local mod = get_mod("weapon_customization")

mod._debug = false
mod._debug_skip_some = true

mod:persistent_table("weapon_customization", {
	flashlight_on = false,
})

mod.print = function(self, message, skip)
	if self._debug and not skip then self:echo(message) end
end

local FlashlightTemplates = mod:original_require("scripts/settings/equipment/flashlight_templates")
local PerlinNoise = mod:original_require("scripts/utilities/perlin_noise")

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

mod.get_gear_setting = function(self, gear_id, setting)
	return self:get(tostring(gear_id).."_"..setting)
end

mod.item_name_from_content_string = function(self, content_string)
	return content_string:gsub('.*[%/%\\]', '')
end

mod.has_flashlight_attachment = function(self)
	if self.initialized then
		local item = self.visual_loadout_extension:item_from_slot(self.inventory_component.wielded_slot)
		if item then return mod:_has_flashlight_attachment(item) end
	end
end

mod._has_flashlight_attachment = function(self, item)
	local gear_id = self:get_gear_id(item)
	if gear_id and not self.flashlight_attached[gear_id] then
		self.flashlight_attached[gear_id] = table.contains(self.flashlights, self:get_gear_setting(gear_id, "flashlight"))
	end
	return self.flashlight_attached[gear_id]
end

mod.get_flashlight_unit = function(self, optional_weapon_unit)
	local weapon = self:get_wielded_weapon()
	if weapon and mod:has_flashlight_attachment() then
		local gear_id = mod:get_gear_id(weapon.item)
		-- Check if unit set but not alive
		if self.attached_flashlights[gear_id] then
			if not Unit.alive(self.attached_flashlights[gear_id]) then
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
		if Unit.alive(self.attached_flashlights[gear_id]) then
			return self.attached_flashlights[gear_id]
		end
	else self:print("get_flashlight_unit - weapon is nil", mod._debug_skip_some) end
end

mod._get_flashlight_unit = function(self, weapon_unit)
	self:print("get_flashlight_unit - searching flashlight unit", mod._debug_skip_some)
	local main_childs = Unit.get_child_units(weapon_unit)
	if main_childs then
		for _, main_child in pairs(main_childs) do
			local unit_name = Unit.debug_name(main_child)
			if self.attachment_units[unit_name] then
				if table.contains(self.flashlights, self.attachment_units[unit_name]) then
					-- self.attached_flashlights[gear_id] = main_child
					-- self:set_flashlight_template(main_child)
					return main_child
				end
			end
			-- local weapon_parts = Unit.get_child_units(main_child)
			-- if weapon_parts then
			-- 	for _, weapon_part in pairs(weapon_parts) do
			-- 		local unit_name = Unit.debug_name(weapon_part)
			-- 		if self.attachment_units[unit_name] then
			-- 			if table.contains(self.flashlights, self.attachment_units[unit_name]) then
			-- 				self.attached_flashlights[gear_id] = weapon_part
			-- 				self:set_flashlight_template(weapon_part)
			-- 			end
			-- 		end
			-- 	end
			-- else self:print("get_flashlight_unit - weapon_parts is nil") end
		end
	else self:print("get_flashlight_unit - main_childs is nil", mod._debug_skip_some) end
end

mod.redo_weapon_attachments = function(self, gear_id)
	local slot_name, weapon = self:get_weapon_from_gear_id(gear_id)
	if weapon then
		local gear_id = mod:get_gear_id(weapon.item)
		local fixed_time_step = GameParameters.fixed_time_step
		local gameplay_time = self.time_manager:time("gameplay")
		local latest_frame = math.floor(gameplay_time / fixed_time_step)
		self.attached_flashlights[gear_id] = nil
		self.visual_loadout_extension:unequip_item_from_slot(slot_name, latest_frame)
		local t = self.time_manager:time("gameplay")
		self.visual_loadout_extension:equip_item_to_slot(weapon.item, slot_name, nil, gameplay_time)
		self:print("redo_weapon_attachments - done")
		self.update_flashlight = true
		return weapon.item
	else self:print("redo_weapon_attachments - weapon is nil") end
end

mod:hook(CLASS.InventoryView, "on_exit", function(func, self, ...)
	func(self, ...)
	if mod.update_flashlight then
		mod:toggle_flashlight(true)
	end
end)

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
				local roll = math.random()

				if roll <= chance or self.start_flicker_now then
					self.start_flicker_now = false
					self._flickering = true
					self._flicker_start_t = t

					self.fx_extension:trigger_wwise_event("wwise/events/player/play_foley_gear_flashlight_flicker", false, flashlight_unit, 1)

					local duration = settings.duration
					local min = duration.min
					local max = duration.max
					self._flicker_duration = math.random() * (max - min) + min
					self._seed = math.random_seed()
				else
					local interval = settings.interval
					local min = interval.min
					local max = interval.max
					self._next_check_at_t = t + math.random(min, max)

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
					self._next_check_at_t = t + math.random(min, max)
					intensity_scale = 1
				else
					local fade_out = settings.fade_out
					local min_octave_percentage = settings.min_octave_percentage
					local fade_progress = fade_out and math.max(1 - progress, min_octave_percentage) or 1
					local frequence_multiplier = settings.frequence_multiplier
					local persistance = settings.persistance
					local octaves = settings.octaves
					intensity_scale = 1 - PerlinNoise.calculate_perlin_value((flicker_end_time - t) * frequence_multiplier, persistance, octaves * fade_progress, self._seed)
				end

				local light = Unit.light(flashlight_unit, 1)
				if light then
					local intensity = self._flashlight_template.intensity * intensity_scale
					Light.set_intensity(light, intensity)
					local color = Light.color_with_intensity(light)
					Unit.set_vector3_for_materials(flashlight_unit, "light_color", color * intensity_scale * intensity_scale * intensity_scale)
				end
			end
		end
	end
end

mod.set_flashlight_template = function(self, flashlight_unit)
	if flashlight_unit then
		local light = Unit.light(flashlight_unit, 1)
		if light then
			Light.set_ies_profile(light, self._flashlight_template.ies_profile)
			Light.set_correlated_color_temperature(light, self._flashlight_template.color_temperature)
			Light.set_intensity(light, self._flashlight_template.intensity)
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
			-- if retain then mod:persistent_table("weapon_customization").flashlight_on = not mod:persistent_table("weapon_customization").flashlight_on end
			local light = Unit.light(flashlight_unit, 1)
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

mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_fix")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_anchors")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_debug")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_patch")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_view")

if Managers and Managers.player._game_state ~= nil then
	mod:init()
end

-- mod:dtf(CLASSES, "CLASSES", 5)
