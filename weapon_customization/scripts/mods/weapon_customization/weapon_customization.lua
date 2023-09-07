local mod = get_mod("weapon_customization")

mod._debug = mod:get("mod_option_debug")
mod._debug_skip_some = true

local string_gsub = string.gsub
local string_find = string.find
local unit_alive = Unit.alive
local unit_get_child_units = Unit.get_child_units
local unit_debug_name = Unit.debug_name
local unit_light = Unit.light
local unit_set_vector3_for_materials = Unit.set_vector3_for_materials
local table_contains = table.contains
local math_floor = math.floor
local math_random = math.random
local math_random_seed = math.random_seed
local math_max = math.max
local light_set_intensity = Light.set_intensity
local light_color_with_intensity = Light.color_with_intensity

mod:persistent_table("weapon_customization", {
	flashlight_on = false,
	item_definitions = nil,
})

mod.print = function(self, message, skip)
	if self._debug and not skip then self:echo(message) end
end

local FlashlightTemplates = mod:original_require("scripts/settings/equipment/flashlight_templates")
local PerlinNoise = mod:original_require("scripts/utilities/perlin_noise")
local WeaponTemplate = mod:original_require("scripts/utilities/weapon/weapon_template")

mod._flicker_settings = FlashlightTemplates.assault.flicker
mod._flashlight_template = FlashlightTemplates.assault.light.first_person

function mod.on_game_state_changed(status, state_name)
	mod:persistent_table("weapon_customization").flashlight_on = false
end

function mod.on_setting_changed(setting_id)
	mod.update_option(setting_id)
	if setting_id == "mod_option_flashlight_shadows" then
		mod:toggle_flashlight(true)
	end
end

function mod.update(main_dt)
	mod:update_flicker()
end

mod.get_gear_id = function(self, item, original)
	return item.__gear and item.__gear.uuid or item.__original_gear_id or item.__gear_id or item.gear_id
end

mod.set_gear_setting = function(self, gear_id, setting, value)
	if not value or (value and (string_find(value, "default") or value == "default")) then
		self:set(tostring(gear_id).."_"..setting, nil)
	else
		self:set(tostring(gear_id).."_"..setting, value)
	end
end

mod.get_gear_setting = function(self, gear_id, setting, item)
	local attachment = self:get(tostring(gear_id).."_"..setting)
	if not attachment and item then
		attachment = self:get_actual_default_attachment(item, setting)
	end
	return attachment
end

mod.get_actual_default_attachment = function(self, item, attachment_slot)
	if item then
		self:setup_item_definitions()
		local original_item = self:persistent_table("weapon_customization").item_definitions[item.name]
		local item_name = self:item_name_from_content_string(item.name)
		if original_item and original_item.attachments then
			local attachment = self:_recursive_find_attachment(original_item.attachments, attachment_slot)
			if attachment then
				if item_name and self.attachment_models[item_name] then
					for attachment_name, attachment_data in pairs(self.attachment_models[item_name]) do
						if attachment_data.model == attachment.item and attachment_data.model ~= "" then
							return attachment_name
						end
					end
				end
			end
		end
	end
end

mod.item_name_from_content_string = function(self, content_string)
	return string_gsub(content_string, '.*[%/%\\]', '')
end

mod.has_flashlight_attachment = function(self)
	if self.initialized then
		local item = self.visual_loadout_extension:item_from_slot(self.inventory_component.wielded_slot)
		return self:_has_flashlight_attachment(item)
	end
end

mod._has_flashlight_attachment = function(self, item)
	if item and item.__master_item and item.__master_item.attachments then
		local flashlight = mod:_recursive_find_attachment(item.__master_item.attachments, "flashlight")
		return flashlight and flashlight.item ~= ""
	end
end

mod.get_flashlight_unit = function(self, optional_weapon_unit)
	local weapon = self:get_wielded_weapon()
	if weapon and mod:has_flashlight_attachment() then
		local gear_id = mod:get_gear_id(weapon.item)
		-- Check if unit set but not alive
		if self.attached_flashlights[gear_id] then
			if not unit_alive(self.attached_flashlights[gear_id]) then
				self.attached_flashlights[gear_id] = nil
				self:print("get_flashlight_unit - flashlight unit destroyed", mod._debug_skip_some)
			end
		end
		-- Search for flashlight unit
		if not self.attached_flashlights[gear_id] then
			self.attached_flashlights[gear_id] = self:_get_flashlight_unit(weapon.weapon_unit)
			self:set_flashlight_template(self.attached_flashlights[gear_id])
		end
		-- Return cached unit
		if unit_alive(self.attached_flashlights[gear_id]) then
			return self.attached_flashlights[gear_id]
		end
	else self:print("get_flashlight_unit - weapon is nil", mod._debug_skip_some) end
end

mod._get_flashlight_unit = function(self, weapon_unit)
	self:print("get_flashlight_unit - searching flashlight unit", mod._debug_skip_some)
	local flashlight = nil
	local children = unit_get_child_units(weapon_unit)
	if children then
		for _, child in pairs(children) do
			local unit_name = unit_debug_name(child)
			if self.attachment_units[unit_name] and table_contains(self.flashlights, self.attachment_units[unit_name]) then
				flashlight = child
			else
				flashlight = self:_get_flashlight_unit(child)
			end
			if flashlight then break end
		end
	else self:print("get_flashlight_unit - main_childs is nil", mod._debug_skip_some) end
	return flashlight
end

mod.redo_weapon_attachments = function(self, item)
	local gear_id = mod:get_gear_id(item)
	local slot_name, weapon = self:get_weapon_from_gear_id(gear_id)
	if weapon then
		local fixed_time_step = GameParameters.fixed_time_step
		local gameplay_time = self.time_manager:time("gameplay")
		local latest_frame = math_floor(gameplay_time / fixed_time_step)
		self.attached_flashlights[gear_id] = nil
		self.visual_loadout_extension:unequip_item_from_slot(slot_name, latest_frame)
		local t = self.time_manager:time("gameplay")
		self.visual_loadout_extension:equip_item_to_slot(item, slot_name, nil, gameplay_time)
		self:print("redo_weapon_attachments - done")
		self.update_flashlight = true
	else self:print("redo_weapon_attachments - weapon is nil") end
end

mod:hook(CLASS.InventoryView, "on_exit", function(func, self, ...)
	func(self, ...)
	if mod.update_flashlight then
		mod:toggle_flashlight(true)
	end
end)

mod.get_equipped_weapon_from_slot = function(self, slot_name)
	return self.weapon_extension._weapons[slot_name]
end

mod.get_wielded_weapon = function(self)
	local inventory_component = self.weapon_extension._inventory_component
	local weapons = self.weapon_extension._weapons
	return self.weapon_extension:_wielded_weapon(inventory_component, weapons)
end

mod.get_weapon_from_gear_id = function(self, from_gear_id)
	if self.weapon_extension and self.weapon_extension._weapons then
		for slot_name, weapon in pairs(self.weapon_extension._weapons) do
			local gear_id = mod:get_gear_id(weapon.item)
			if from_gear_id == gear_id then
				if weapon.weapon_unit then
					return slot_name, weapon
				end
			end
		end
	end
end

mod.update_flicker = function(self)
	if self:has_flashlight_attachment() and mod:get("mod_option_flashlight_flicker") then
		local flashlight_unit = self:get_flashlight_unit()
		if flashlight_unit and mod:persistent_table("weapon_customization").flashlight_on then
			local t = self.time_manager:time("gameplay")
			local settings = self._flicker_settings

			if not self._flickering and (self._next_check_at_t <= t or self.start_flicker_now) then
				local chance = settings.chance
				local roll = math_random()

				if roll <= chance or self.start_flicker_now then
					self.start_flicker_now = false
					self._flickering = true
					self._flicker_start_t = t

					self.fx_extension:trigger_wwise_event("wwise/events/player/play_foley_gear_flashlight_flicker", false, flashlight_unit, 1)

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

				local light = unit_light(flashlight_unit, 1)
				if light then
					local intensity = self._flashlight_template.intensity * intensity_scale
					light_set_intensity(light, intensity)
					local color = light_color_with_intensity(light)
					unit_set_vector3_for_materials(flashlight_unit, "light_color", color * intensity_scale * intensity_scale * intensity_scale)
				end
			end
		end
	end
end

mod.set_flashlight_template = function(self, flashlight_unit)
	if flashlight_unit then
		local light = unit_light(flashlight_unit, 1)
		if light then
			Light.set_ies_profile(light, self._flashlight_template.ies_profile)
			Light.set_correlated_color_temperature(light, self._flashlight_template.color_temperature)
			light_set_intensity(light, self._flashlight_template.intensity)
			Light.set_volumetric_intensity(light, self._flashlight_template.volumetric_intensity)
			Light.set_casts_shadows(light, mod:get("mod_option_flashlight_shadows"))
			Light.set_spot_angle_start(light, self._flashlight_template.spot_angle.min)
			Light.set_spot_angle_end(light, self._flashlight_template.spot_angle.max)
			Light.set_spot_reflector(light, self._flashlight_template.spot_reflector)
			Light.set_falloff_start(light, self._flashlight_template.falloff.near)
			Light.set_falloff_end(light, self._flashlight_template.falloff.far)
		end
	end
end

mod.toggle_flashlight = function(self, retain)
	if self.initialized then
		local flashlight_unit = self:get_flashlight_unit()
		if flashlight_unit then
			if not retain then
				mod:persistent_table("weapon_customization").flashlight_on = 
					not mod:persistent_table("weapon_customization").flashlight_on
			end
			local light = unit_light(flashlight_unit, 1)
			if light then
				Light.set_enabled(light, mod:persistent_table("weapon_customization").flashlight_on)
				Light.set_casts_shadows(light, mod:get("mod_option_flashlight_shadows"))
				if mod:persistent_table("weapon_customization").flashlight_on then
					if mod:get("mod_option_flashlight_flicker_start") then self.start_flicker_now = true end
					self.fx_extension:trigger_wwise_event("wwise/events/player/play_foley_gear_flashlight_on", false, self.player_unit, 1)
				else
					self.fx_extension:trigger_wwise_event("wwise/events/player/play_foley_gear_flashlight_off", false, self.player_unit, 1)
				end
			else self:print("toggle_flashlight - light not found", mod._debug_skip_some) end
		else self:print("toggle_flashlight - flashlight_unit not found", mod._debug_skip_some) end
	else self:print("toggle_flashlight - mod not initialized", mod._debug_skip_some) end
end

mod.init = function(self)
	self.ui_manager = Managers.ui
	self.player_manager = Managers.player
	self.package_manager = Managers.package
	self.player = self.player_manager:local_player(1)
	self.peer_id = self.player:peer_id()
	self.local_player_id = self.player:local_player_id()
	self.player_unit = self.player.player_unit
	self.fx_extension = ScriptUnit.extension(self.player_unit, "fx_system")
	self.weapon_extension = ScriptUnit.extension(self.player_unit, "weapon_system")
	self.unit_data = ScriptUnit.extension(self.player_unit, "unit_data_system")
	self.visual_loadout_extension = ScriptUnit.extension(self.player_unit, "visual_loadout_system")
	self.inventory_component = self.unit_data:read_component("inventory")
	self.time_manager = Managers.time
	self.initialized = true
	self._next_check_at_t = 0
	self:print("Initialized")
end

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "extensions_ready", function(func, self, world, unit, ...)
	func(self, world, unit, ...)
	mod:init()
end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "destroy", function(func, self, ...)
	mod.initialized = false
	return func(self, ...)
end)

mod:hook(CLASS.Flashlight, "update_first_person_mode", function(func, self, first_person_mode, ...)
	func(self, first_person_mode, ...)
    mod:toggle_flashlight(true)
end)

mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_visual_loadout")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_fix")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_anchors")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_debug")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_patch")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_view")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_mod_options")

if Managers and Managers.player._game_state ~= nil then
	mod:init()
end
