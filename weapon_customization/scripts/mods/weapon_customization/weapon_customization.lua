local mod = get_mod("weapon_customization")

-- local FlashlightTemplates = mod:original_require("scripts/settings/equipment/flashlight_templates")
-- mod._flicker_settings = FlashlightTemplates.default.flicker

function mod.on_game_state_changed(status, state_name)
	mod:load_packages()
	mod.initialized = false
end

mod.get_gear_id = function(self, item, original)
    return not original and item.__gear_id or item.__original_gear_id or item.gear_id, item.__original_gear_id or item.gear_id
end

mod.item_name_from_content_string = function(self, content_string)
	return content_string:gsub('.*[%/%\\]', '')
end

mod.has_flashlight_attachment = function(self, item)
	local gear_id = self:get_gear_id(item)
	if gear_id and not self.flashlight_attached[gear_id] then
		self.flashlight_attached[gear_id] = table.contains(self.flashlights, mod:get(tostring(gear_id).."_special"))
	end
	return self.flashlight_attached[gear_id]
end

mod.get_flashlight_unit = function(self, item)
	local gear_id = self:get_gear_id(item)
	if not self.attached_flashlights[gear_id] then
		local player_unit = Managers.player:local_player(1).player_unit
		local weapon_extension = ScriptUnit.extension(player_unit, "weapon_system")
		if weapon_extension._weapons then
			for _, weapon in pairs(weapon_extension._weapons) do
				if weapon.item.__gear_id == gear_id then
					if weapon.weapon_unit then
						local main_childs = Unit.get_child_units(weapon.weapon_unit)
						for _, main_child in pairs(main_childs) do
							local unit_name = Unit.debug_name(main_child)
							if self.attachment_units[unit_name] then
								if table.contains(self.flashlights, self.attachment_units[unit_name]) then
									self.attached_flashlights[gear_id] = main_child
								end
							end
							local weapon_parts = Unit.get_child_units(main_child)
							if weapon_parts then
								for _, weapon_part in pairs(weapon_parts) do
									local unit_name = Unit.debug_name(weapon_part)
									if self.attachment_units[unit_name] then
										if table.contains(self.flashlights, self.attachment_units[unit_name]) then
											self.attached_flashlights[gear_id] = weapon_part
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	if Unit.alive(self.attached_flashlights[gear_id]) then
		return self.attached_flashlights[gear_id]
	else
		self.attached_flashlights[gear_id] = nil
	end
end

mod.redo_weapon_attachments = function(self, gear_id)
	local player_unit = Managers.player:local_player(1).player_unit
	local weapon_extension = ScriptUnit.extension(player_unit, "weapon_system")
	if weapon_extension and weapon_extension._weapons then
		for slot_name, weapon in pairs(weapon_extension._weapons) do
			if weapon.item.__gear_id == gear_id then
				if weapon.weapon_unit then
					local visual_loadout_extension = ScriptUnit.extension(player_unit, "visual_loadout_system")
					local slot_name = weapon.item.__gear.slots[1]
					local fixed_time_step = GameParameters.fixed_time_step
					local gameplay_time = Managers.time:time("gameplay")
					local latest_frame = math.floor(gameplay_time / fixed_time_step)
					visual_loadout_extension:unequip_item_from_slot(slot_name, latest_frame)
					local time_manager = Managers.time
					local t = time_manager:time("gameplay")
					visual_loadout_extension:equip_item_to_slot(weapon.item, slot_name, weapon.weapon_unit, gameplay_time)
				end
			end
		end
	end
end

mod.init_context = function(self)
	if not self.visual_loadout_extension then
		self.initialized = false
	end
	if not self.initialized then
		self.player_manager = Managers.player
		local player = self.player_manager:local_player(1)
		if player then
			self.player_unit = player.player_unit
			if self.player_unit then
				self.fx_extension = ScriptUnit.extension(self.player_unit, "fx_system")
				local unit_data = ScriptUnit.extension(self.player_unit, "unit_data_system")
				if unit_data then
					self.inventory_component = unit_data:read_component("inventory")
					self.visual_loadout_extension = ScriptUnit.extension(self.player_unit, "visual_loadout_system")
					if self.visual_loadout_extension then
						self.first_person_extension = ScriptUnit.extension(self.player_unit, "first_person_system")
						if self.first_person_extension then
							self.first_person_unit = self.first_person_extension:first_person_unit()
							if self.first_person_unit then
								self.initialized = true
							end
						end
					end
				end
			end
		end
	end
end

mod.toggle_flashlight = function(self)
	self:init_context()
	if self.initialized then
		local item = self.visual_loadout_extension:item_from_slot(self.inventory_component.wielded_slot)
		if item then
			local flashlight_unit = self:get_flashlight_unit(item)
			if flashlight_unit then
				self.flashlight_on = not self.flashlight_on
				local light = Unit.light(flashlight_unit, 1)
				if self.flashlight_on then
					Light.set_correlated_color_temperature(light, 7000)
					Light.set_intensity(light, 40)
					Light.set_volumetric_intensity(light, 0.3)
					Light.set_casts_shadows(light, true)
					Light.set_falloff_end(light, 45)
					Light.set_enabled(light, true)
					self.fx_extension:trigger_wwise_event("wwise/events/player/play_foley_gear_flashlight_on", false, self.player_unit, 1)
				else
					Light.set_correlated_color_temperature(light, 8000)
					Light.set_intensity(light, 1)
					Light.set_volumetric_intensity(light, 0.1)
					Light.set_casts_shadows(light, false)
					Light.set_falloff_end(light, 10)
					Light.set_enabled(light, false)
					self.fx_extension:trigger_wwise_event("wwise/events/player/play_foley_gear_flashlight_off", false, self.player_unit, 1)
				end
			end
		end
	end
end

mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_fix")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_packages")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_anchors")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_debug")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_patch")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_view")

-- mod:echo("Init ####################")
