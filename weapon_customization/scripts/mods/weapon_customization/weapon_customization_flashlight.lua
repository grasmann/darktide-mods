local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local FlashlightTemplates = mod:original_require("scripts/settings/equipment/flashlight_templates")
local PerlinNoise = mod:original_require("scripts/utilities/perlin_noise")
local HudElementBattery = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/hud/hud_element_battery")
local UIHud = mod:original_require("scripts/managers/ui/ui_hud")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
	local vector3_box = Vector3Box
	local vector3_unbox = vector3_box.unbox
	local unit_alive = Unit.alive
	local unit_get_child_units = Unit.get_child_units
	local unit_debug_name = Unit.debug_name
	local unit_light = Unit.light
	local unit_set_vector3_for_materials = Unit.set_vector3_for_materials
	local table_contains = table.contains
	local table_size = table.size
	local table_clone = table.clone
	local math_random = math.random
	local math_random_seed = math.random_seed
	local math_max = math.max
	local math_clamp = math.clamp
	local light_set_intensity = Light.set_intensity
	local light_color_with_intensity = Light.color_with_intensity
	local light_set_ies_profile = Light.set_ies_profile
	local light_set_correlated_color_temperature = Light.set_correlated_color_temperature
	local light_set_volumetric_intensity = Light.set_volumetric_intensity
	local light_set_casts_shadows = Light.set_casts_shadows
	local light_set_spot_angle_start = Light.set_spot_angle_start
	local light_set_spot_angle_end = Light.set_spot_angle_end
	local light_set_spot_reflector = Light.set_spot_reflector
	local light_set_falloff_start = Light.set_falloff_start
	local light_set_falloff_end = Light.set_falloff_end
	local light_set_enabled = Light.set_enabled
	local light_set_color_filter = Light.set_color_filter
	local tostring = tostring
	local pairs = pairs
	local ipairs = ipairs
	local managers = Managers
	local CLASS = CLASS
	local RESOLUTION_LOOKUP = RESOLUTION_LOOKUP
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _flashlight_template = {
	light = {
		first_person = {
			intensity = 12,
			cast_shadows = true,
			spot_reflector = false,
			color_temperature = 8000,
			volumetric_intensity = 0.1,
			ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_02",
			spot_angle = {
				max = 1.1,
				min = 0
			},
			falloff = {
				far = 70,
				near = 0
			}
		},
		third_person = {
			intensity = 12,
			cast_shadows = true,
			spot_reflector = false,
			color_temperature = 8000,
			volumetric_intensity = 0.6,
			ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_02",
			spot_angle = {
				max = 0.8,
				min = 0
			},
			falloff = {
				far = 30,
				near = 0
			}
		}
	},
	flicker = FlashlightTemplates.assault.flicker,
}

mod.flashlight_templates = {
	flashlight_01 = table_clone(FlashlightTemplates.assault),
	flashlight_02 = table_clone(FlashlightTemplates.default),
	flashlight_03 = table_clone(FlashlightTemplates.assault),
	flashlight_04 = table_clone(FlashlightTemplates.default),
	-- laser_pointer = table_clone(FlashlightTemplates.assault),
	laser_pointer = {
		light = {
			first_person = {
				intensity = 12,
				cast_shadows = true,
				spot_reflector = false,
				color_temperature = 8000,
				color_filter = vector3_box(1, 0, 0),
				volumetric_intensity = 0.1,
				ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_02",
				spot_angle = {
					max = 1.1,
					min = 0
				},
				falloff = {
					far = 70,
					near = 0
				}
			},
			third_person = {
				intensity = 12,
				cast_shadows = true,
				spot_reflector = false,
				color_temperature = 8000,
				color_filter = vector3_box(1, 0, 0),
				volumetric_intensity = 0.6,
				ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_02",
				spot_angle = {
					max = 0.8,
					min = 0
				},
				falloff = {
					far = 30,
					near = 0
				}
			}
		},
		battery = {
			max = 10,
			interval = 1,
			drain = .01,
			charge = .02,
		},
		flicker = FlashlightTemplates.assault.flicker,
	},
}

mod.battery_timer = 0
mod.battery = nil
mod.attached_flashlights = {}
mod._active_flashlight_template = nil

-- ##### ┌┐ ┌─┐┌┬┐┌┬┐┌─┐┬─┐┬ ┬ ########################################################################################
-- ##### ├┴┐├─┤ │  │ ├┤ ├┬┘└┬┘ ########################################################################################
-- ##### └─┘┴ ┴ ┴  ┴ └─┘┴└─ ┴  ########################################################################################

mod.recharge_battery = function(self)
	local flashlight_template = self:get_flashlight_template()
	self.battery = flashlight_template and flashlight_template.battery.max
end

-- Get current battery charge
mod.get_battery_charge = function(self)
	return self.battery or self._active_flashlight_template and self._active_flashlight_template.battery and self._active_flashlight_template.battery.max or 0
end

-- Get maximum battery charge
mod.get_battery_charge_max = function(self)
	return self._active_flashlight_template and self._active_flashlight_template.battery and self._active_flashlight_template.battery.max or 0
end

-- Get active battery template
mod.get_battery_template = function(self)
	return self._active_flashlight_template and self._active_flashlight_template.battery
end

-- Get battery charge fraction
mod.get_battery_fraction = function(self)
	-- Check battery template
	if self._active_flashlight_template and self._active_flashlight_template.battery then
		-- Current battery charge or max
		local current = self.battery or self._active_flashlight_template.battery.max
		-- Max battery charge
		local max = self._active_flashlight_template.battery.max
		-- Fraction
		return current / max
	end
end

-- Update battery
mod.update_battery = function(self)
	-- Check initialized and slot
	if self.initialized then
		-- Check battery template
		if self._active_flashlight_template and self._active_flashlight_template.battery then
			-- Get gameplay time
			local t = self.time_manager:time("gameplay")
			-- Set initial value if not set
			if not self.battery then self.battery = self._active_flashlight_template.battery.max end
			-- Battery interval
			if t > self.battery_timer then
				-- Check if flashlight is switched on
				local flashlight_on = self:persistent_table("weapon_customization").flashlight_on
				local laser_pointer_on = self:persistent_table("weapon_customization").laser_pointer_on == 2
				local only_pointer = self:persistent_table("weapon_customization").laser_pointer_on == 1
				if (flashlight_on or laser_pointer_on or only_pointer) and self:get_wielded_slot() == "slot_secondary" then
					-- Drain battery
					local drain = only_pointer and self._active_flashlight_template.battery.drain * .3 or self._active_flashlight_template.battery.drain
					self.battery = self.battery - drain * (self.battery_drain_multiplier or 1)
				else
					-- Charge battery
					self.battery = self.battery + self._active_flashlight_template.battery.charge
				end
				-- Clamp value
				self.battery = math_clamp(self.battery, 0, self._active_flashlight_template.battery.max)
				-- Set battery time
				self.battery_timer = t + self._active_flashlight_template.battery.interval
			end
			-- Battery empty
			if self.battery <= 0 then
				-- Check battery or laser pointer
				if self:persistent_table("weapon_customization").flashlight_on then
					-- Switch off flashlight
					self:toggle_flashlight(false, false)
				elseif self:persistent_table("weapon_customization").laser_pointer_on == 2 then
					-- Switch off laser pointer light
					self:toggle_laser(false, 0)
				end
			end
		end
	end
end

-- ##### ┌─┐┬  ┌─┐┌─┐┬ ┬┬  ┬┌─┐┬ ┬┌┬┐  ┬ ┬┌┐┌┬┌┬┐ #####################################################################
-- ##### ├┤ │  ├─┤└─┐├─┤│  ││ ┬├─┤ │   │ │││││ │  #####################################################################
-- ##### └  ┴─┘┴ ┴└─┘┴ ┴┴─┘┴└─┘┴ ┴ ┴   └─┘┘└┘┴ ┴  #####################################################################

-- Get flashlight unit of wielded weapon
mod.get_flashlight_unit = function(self)
    -- Get wielded weapon
	local weapon = self:get_wielded_weapon()
    -- Check weapon and flashlight
	if weapon and self:has_flashlight_attachment() then
		-- Get weapon gear id
		local gear_id = self:get_gear_id(weapon.item)
		-- Check flashlight unit cache
        self.attached_flashlights[gear_id] = self.attached_flashlights[gear_id] or {}
		-- Check if unit set but not alive
		if table_size(self.attached_flashlights[gear_id]) > 0 then
			if not unit_alive(self.attached_flashlights[gear_id].unit_1p) or not unit_alive(self.attached_flashlights[gear_id].unit_3p) then
				self.attached_flashlights[gear_id] = {}
				self:print("get_flashlight_unit - flashlight unit destroyed", self._debug_skip_some)
			end
		end
		-- Search for flashlight unit
		if table_size(self.attached_flashlights[gear_id]) == 0 then
			-- Set flashlight units
            self.attached_flashlights[gear_id] = {
                unit_1p = self:_get_flashlight_unit(weapon.weapon_unit),
                unit_3p = self:_get_flashlight_unit(self:get_wielded_weapon_3p()),
            }
			-- Set flashlight template
			self:set_flashlight_template(self.attached_flashlights[gear_id])
		end
		-- Return cached unit
		return self.attached_flashlights[gear_id].unit_1p, self.attached_flashlights[gear_id].unit_3p
	else self:print("get_flashlight_unit - weapon is nil", self._debug_skip_some) end
end

-- Get flashlight unit of specified weapon unit
mod._get_flashlight_unit = function(self, weapon_unit)
	self:print("get_flashlight_unit - searching flashlight unit", self._debug_skip_some)
	local flashlight = nil
    -- Get unit children
	local children = unit_get_child_units(weapon_unit)
	if children then
        -- Iterate children
		for _, child in pairs(children) do
            -- Check for known flashlight names
			local unit_name = unit_debug_name(child)
			if self.attachment_units[unit_name] and table_contains(self.flashlights, self.attachment_units[unit_name]) then
				flashlight = child
			else
				flashlight = self:_get_flashlight_unit(child)
			end
			if flashlight then break end
		end
	else self:print("get_flashlight_unit - main_childs is nil", self._debug_skip_some) end
	return flashlight
end

-- ##### ┌─┐┬  ┌─┐┌─┐┬ ┬┬  ┬┌─┐┬ ┬┌┬┐  ┌┬┐┌─┐┌┬┐┌─┐┬  ┌─┐┌┬┐┌─┐ #######################################################
-- ##### ├┤ │  ├─┤└─┐├─┤│  ││ ┬├─┤ │    │ ├┤ │││├─┘│  ├─┤ │ ├┤  #######################################################
-- ##### └  ┴─┘┴ ┴└─┘┴ ┴┴─┘┴└─┘┴ ┴ ┴    ┴ └─┘┴ ┴┴  ┴─┘┴ ┴ ┴ └─┘ #######################################################

-- Get flashlight template from current equipment
mod.get_flashlight_template = function(self)
	local flashlight = self:has_flashlight_attachment() or self:has_laser_pointer_attachment()
	if flashlight then return self.flashlight_templates[flashlight] end
end

-- Set flashlight template
mod.set_flashlight_template = function(self, flashlight_units)
	local flashlight_template = self:get_flashlight_template()
	if flashlight_template then
		self:_set_light_values(flashlight_units.unit_1p, flashlight_template.light.first_person)
		self:_set_light_values(flashlight_units.unit_3p, flashlight_template.light.third_person)
		self._active_flashlight_template = flashlight_template
	end
end

-- ##### ┬  ┬┌─┐┬ ┬┌┬┐  ┬  ┬┌─┐┬  ┬ ┬┌─┐┌─┐ ###########################################################################
-- ##### │  ││ ┬├─┤ │   └┐┌┘├─┤│  │ │├┤ └─┐ ###########################################################################
-- ##### ┴─┘┴└─┘┴ ┴ ┴    └┘ ┴ ┴┴─┘└─┘└─┘└─┘ ###########################################################################

-- Set flashlight template
mod._set_light_values = function(self, flashlight_unit, template)
	-- Get and check light
	local light = flashlight_unit and unit_light(flashlight_unit, 1)
	if light and template then
		-- Set values
		light_set_ies_profile(light, template.ies_profile)
		light_set_correlated_color_temperature(light, template.color_temperature)
		light_set_intensity(light, template.intensity)
		light_set_volumetric_intensity(light, template.volumetric_intensity)
		light_set_casts_shadows(light, self:get("mod_option_flashlight_shadows"))
		light_set_spot_angle_start(light, template.spot_angle.min)
		light_set_spot_angle_end(light, template.spot_angle.max)
		light_set_spot_reflector(light, template.spot_reflector)
		light_set_falloff_start(light, template.falloff.near)
		light_set_falloff_end(light, template.falloff.far)
		if template.color_filter then
			local color_filter = vector3_unbox(template.color_filter)
			light_set_color_filter(light, color_filter)
		end
	end
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

-- Check if wielded slot has flashlight attachment
mod.has_flashlight_attachment = function(self)
	if self.initialized then
        -- Get wielded item
		local item = self.visual_loadout_extension:item_from_slot(self.inventory_component.wielded_slot)
        -- Gear id
        local gear_id = self:get_gear_id(item)
        if gear_id and self:get_gear_setting(gear_id, "flashlight") then
            -- Check
            return not self:_has_laser_pointer_attachment(item) and self:_has_flashlight_attachment(item)
        end
	end
end

-- Check if item has flashlight attachment
mod._has_flashlight_attachment = function(self, item)
    -- Check item
    local attachments = item and item.attachments
    attachments = attachments or item and item.__master_item and item.__master_item.attachments
	if attachments then
        -- Check flashlight
        local flashlight = nil
        for _, flashlight_attachment in pairs(self.flashlights) do
		    flashlight = self:_recursive_find_attachment_name(attachments, flashlight_attachment)
            if flashlight then
				flashlight = flashlight_attachment
				break
			end
        end
		return flashlight
	end
end

mod.has_flashlight = function(self, item)
	local gear_id = self:get_gear_id(item)
	local flashlight = gear_id and self:get_gear_setting(gear_id, "flashlight")
	return flashlight and flashlight ~= "laser_pointer"
end

mod.update_flashlight_view = function(self)
    local _, changed = self:is_in_third_person()
    if changed or self:character_state_changed() then
        self:toggle_flashlight(true)
    end
end

-- Update flashlight flicker
mod.update_flicker = function(self)
    -- Check flashlight and flicker setting
	if (self:has_flashlight_attachment() or self:has_laser_pointer_attachment()) and self:get("mod_option_flashlight_flicker") then
		local is_in_third_person = self:is_in_third_person()
        -- Get flashlight unit
		local light_unit_1p, light_unit_3p = self:get_flashlight_unit() or self:get_laser_pointer_unit()
        local light_unit = light_unit_1p
        if is_in_third_person then light_unit = light_unit_3p end
		-- Light template
		local light_template = self._active_flashlight_template.light.first_person
		if is_in_third_person then light_template = self._active_flashlight_template.light.third_person end
        -- Check flashlight unit and state
        local state = self:persistent_table("weapon_customization").flashlight_on or self:persistent_table("weapon_customization").laser_pointer_on
		if light_unit and state then
			local t = self.time_manager:time("gameplay")
			local settings = self._active_flashlight_template.flicker
			if (self:get("mod_option_laser_pointer_wild") and self:persistent_table("weapon_customization").laser_pointer_on == 2) or self.flicker_wild then
				settings = self.laser_pointer_flicker_wild
			end

			if not self._flickering and (self._next_check_at_t <= t or self.start_flicker_now) then
				local chance = settings.chance
				local roll = math_random()

				if roll <= chance or self.start_flicker_now then
					self.start_flicker_now = false
					self._flickering = true
					self._flicker_start_t = t
					self.fx_extension:trigger_wwise_event("wwise/events/player/play_foley_gear_flashlight_flicker", false, light_unit, 1)
					local duration = settings.duration
					local min = duration.min
					local max = duration.max
					self._flicker_duration = math_random() * (max - min) + min
					self._seed = math_random_seed()
				else
					local interval = settings.interval
					local min = interval.min
					local max = interval.max
					self._next_check_at_t = t + math_random(min, max)
					return
				end
			end

			if self._flickering then
				local flicker_duration = self._flicker_duration
				local current_flicker_time = t - self._flicker_start_t
				local flicker_end_time = self._flicker_start_t + self._flicker_duration
				local progress = current_flicker_time / flicker_duration
				local intensity_scale = nil

				if progress >= 1 then
					self._flickering = false
					local interval = settings.interval
					local min = interval.min
					local max = interval.max
					self._next_check_at_t = t + math_random(min, max)
					intensity_scale = 1
				else
					local fade_out = settings.fade_out
					local min_octave_percentage = settings.min_octave_percentage
					local fade_progress = fade_out and math_max(1 - progress, min_octave_percentage) or 1
					local frequence_multiplier = settings.frequence_multiplier
					local persistance = settings.persistance
					local octaves = settings.octaves
					intensity_scale = 1 - PerlinNoise.calculate_perlin_value((flicker_end_time - t) * frequence_multiplier, persistance, octaves * fade_progress, self._seed)
				end

				local light = unit_light(light_unit, 1)
				if light then
					local intensity = light_template.intensity * intensity_scale
					light_set_intensity(light, intensity)
					local color = light_color_with_intensity(light)
					unit_set_vector3_for_materials(light_unit, "light_color", color * intensity_scale * intensity_scale * intensity_scale)
				end
			end
		end
	end
end

-- Toggle equipped flashlight
mod.toggle_flashlight = function(self, retain, optional_value)
    -- Initialized?
	if self.initialized then
        -- Get and check flashlight unit
		local flashlight_unit_1p, flashlight_unit_3p = self:get_flashlight_unit()
        if not flashlight_unit_1p or not flashlight_unit_3p then
            flashlight_unit_1p, flashlight_unit_3p = self:get_laser_pointer_unit()
        end
        local flashlight_unit = flashlight_unit_1p
        if self:is_in_third_person() then flashlight_unit = flashlight_unit_3p end
        if flashlight_unit and unit_alive(flashlight_unit) then
            local flashlight_state = not self:persistent_table("weapon_customization").flashlight_on
            -- Check retain ( flashlight update )
            if retain then flashlight_state = not flashlight_state end
            -- Optional overwrite value
            if optional_value ~= nil then flashlight_state = optional_value end

            local light = unit_light(flashlight_unit, 1)
            if light then
                -- Set values
                light_set_enabled(light, flashlight_state)
                light_set_casts_shadows(light, self:get("mod_option_flashlight_shadows"))
            end

            -- Check flicker
            if not retain and flashlight_state then
                -- Switch on
                if self:get("mod_option_flashlight_flicker_start") then self.start_flicker_now = true end
                self.fx_extension:trigger_wwise_event("wwise/events/player/play_foley_gear_flashlight_on", false, self.player_unit, 1)
            elseif not retain then
                -- Switch off
                self.fx_extension:trigger_wwise_event("wwise/events/player/play_foley_gear_flashlight_off", false, self.player_unit, 1)
            end

            -- Set state
            self:persistent_table("weapon_customization").flashlight_on = flashlight_state
        end
	else self:print("toggle_flashlight - mod not initialized", self._debug_skip_some) end
end

-- ##### ┬ ┬┌─┐┌─┐┬┌─┌─┐ ##############################################################################################
-- ##### ├─┤│ ││ │├┴┐└─┐ ##############################################################################################
-- ##### ┴ ┴└─┘└─┘┴ ┴└─┘ ##############################################################################################

-- Setup battery hud element
mod:hook(CLASS.UIHud, "_setup_elements", function(func, self, element_definitions, ...)
	func(self, element_definitions, ...)

	-- Add element to hud ui
	local class_name = "HudElementBattery"
	self._elements_hud_scale_lookup[class_name] = true
	local hud_scale = UIHud:_hud_scale() or RESOLUTION_LOOKUP.scale
	local element = HudElementBattery:new(self, 0, hud_scale)
	self._elements[class_name] = element
	local id = #self._elements_array + 1
	self._elements_array[id] = element

	-- Get visibility groups
	local visibility_groups_lookup = {}
	for _, settings in ipairs(self._visibility_groups) do
		local name = settings.name
		visibility_groups_lookup[name] = settings
	end

	-- Add to alive visibility group
	local visibility_group = visibility_groups_lookup["alive"]
	visibility_group.visible_elements = visibility_group.visible_elements or {}
	local visible_elements = visibility_group.visible_elements
	visible_elements[class_name] = true

	-- -- Add to communication wheel visibility group
	-- local visibility_group = visibility_groups_lookup["communication_wheel"]
	-- visibility_group.visible_elements = visibility_group.visible_elements or {}
	-- local visible_elements = visibility_group.visible_elements
	-- visible_elements[class_name] = true
end)

