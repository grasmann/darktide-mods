local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local FlashlightTemplates = mod:original_require("scripts/settings/equipment/flashlight_templates")
local PerlinNoise = mod:original_require("scripts/utilities/perlin_noise")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

mod._flicker_settings = FlashlightTemplates.assault.flicker
mod._active_flicker_settings = mod._flicker_settings
mod._flashlight_template = FlashlightTemplates.assault.light.first_person
mod._active_flashlight_template = mod._flashlight_template
mod.attached_flashlights = {}

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local vector3_unbox = Vector3Box.unbox
    local unit_alive = Unit.alive
    local unit_get_child_units = Unit.get_child_units
    local unit_debug_name = Unit.debug_name
    local unit_light = Unit.light
    local unit_set_vector3_for_materials = Unit.set_vector3_for_materials
    local table_contains = table.contains
    local table_size = table.size
    local math_random = math.random
    local math_random_seed = math.random_seed
    local math_max = math.max
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
    local managers = Managers
--#endregion

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
            return self:_has_flashlight_attachment(item) and not self:has_laser_pointer_attachment()
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
            if flashlight then break end
        end
		return flashlight
	end
end

-- Get flashlight unit of wielded weapon
mod.get_flashlight_unit = function(self)
    -- Get wielded weapon
	local weapon = self:get_wielded_weapon()
    -- Check weapon and flashlight
	if weapon and self:has_flashlight_attachment() then
		local gear_id = self:get_gear_id(weapon.item)
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
			-- self.attached_flashlights[gear_id] = self:_get_flashlight_unit(weapon.weapon_unit)
            local weapon_3p = self.visual_loadout_extension:unit_3p_from_slot("slot_secondary")
            self.attached_flashlights[gear_id] = {
                unit_1p = self:_get_flashlight_unit(weapon.weapon_unit),
                unit_3p = self:_get_flashlight_unit(weapon_3p),
            }
			self:set_flashlight_template(self.attached_flashlights[gear_id].unit_1p, self._flashlight_template)
            self:set_flashlight_template(self.attached_flashlights[gear_id].unit_3p, self._flashlight_template)
            self:set_flicker_template(self._flicker_settings)
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

mod.update_flashlight = function(self)
    local _, changed = self:is_in_third_person()
    if changed or self:character_state_changed() then
        self:toggle_flashlight(true)
    end
end

-- Update flashlight flicker
mod.update_flicker = function(self)
    -- Check flashlight and flicker setting
	if (self:has_flashlight_attachment() or self:has_laser_pointer_attachment()) and self:get("mod_option_flashlight_flicker") then
        -- Get flashlight unit
		local light_unit_1p, light_unit_3p = self:get_flashlight_unit() or self:get_laser_pointer_unit()
        local light_unit = light_unit_1p
        if self:is_in_third_person() then light_unit = light_unit_3p end
        -- Check flashlight unit and state
        local state = self:persistent_table("weapon_customization").flashlight_on or self:persistent_table("weapon_customization").laser_pointer_on
		if light_unit and state then
			local t = self.time_manager:time("gameplay")
			local settings = self._active_flicker_settings

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
					local intensity = self._active_flashlight_template.intensity * intensity_scale
					light_set_intensity(light, intensity)
					local color = light_color_with_intensity(light)
					unit_set_vector3_for_materials(light_unit, "light_color", color * intensity_scale * intensity_scale * intensity_scale)
				end
			end
		end
	end
end

mod.set_flicker_template = function(self, template)
    self._active_flicker_settings = template
end

-- Set flashlight template
mod.set_flashlight_template = function(self, light_unit, template)
    local template = template or self._flashlight_template
    -- Check flashlight unit
	if light_unit then
        -- Get and check light
		local light = unit_light(light_unit, 1)
		if light then
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
            self._active_flashlight_template = template
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
