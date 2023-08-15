local mod = get_mod("weapon_customization")

local UISettings = mod:original_require("scripts/settings/ui/ui_settings")
local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")
local PlayerUnitVisualLoadout = mod:original_require("scripts/extension_systems/visual_loadout/utilities/player_unit_visual_loadout")
local WeaponTemplate = mod:original_require("scripts/utilities/weapon/weapon_template")

function mod.on_game_state_changed(status, state_name)
	mod.initialized = false
end

mod.init_context = function(self)
	if not self.initialized then
		self.player_manager = Managers.player
		local player = self.player_manager:local_player(1)
		if player then
			self.player_unit = player.player_unit
			self.fx_extension = ScriptUnit.extension(self.player_unit, "fx_system")
			local unit_data = ScriptUnit.extension(self.player_unit, "unit_data_system")
			if unit_data then
				self.inventory_component = unit_data:read_component("inventory")
				self.visual_loadout_extension = ScriptUnit.extension(self.player_unit, "visual_loadout_system")
				self.first_person_extension = ScriptUnit.extension(self.player_unit, "first_person_system")
				self.first_person_unit = self.first_person_extension:first_person_unit()
				self.flashlight = Unit.light(self.first_person_unit, 1)
				self.initialized = true
			end
		end
	end
end

mod.set_flashlight = function(self, state)
	self:init_context()
	local item = self.visual_loadout_extension:item_from_slot(self.inventory_component.wielded_slot)
	local flashlight_on = mod:get(item.__gear_id)
	if flashlight_on then
		if state then
			Light.set_correlated_color_temperature(self.flashlight, 7000)
			Light.set_intensity(self.flashlight, 40)
			Light.set_volumetric_intensity(self.flashlight, 0.3)
			Light.set_casts_shadows(self.flashlight, true)
			Light.set_falloff_end(self.flashlight, 45)
			self.fx_extension:trigger_wwise_event("wwise/events/player/play_foley_gear_flashlight_on", false, self.player_unit, 1)
		else
			Light.set_correlated_color_temperature(self.flashlight, 8000)
			Light.set_intensity(self.flashlight, 1)
			Light.set_volumetric_intensity(self.flashlight, 0.1)
			Light.set_casts_shadows(self.flashlight, false)
			Light.set_falloff_end(self.flashlight, 10)
			self.fx_extension:trigger_wwise_event("wwise/events/player/play_foley_gear_flashlight_off", false, self.player_unit, 1)
		end
	end
end

mod:hook(CLASS.InputService, "get", function(func, self, action_name, ...)
	if Managers and Managers.player._game_state ~= nil then
		mod:init_context()
		if mod.initialized then
			local item = mod.visual_loadout_extension:item_from_slot(mod.inventory_component.wielded_slot)
			local flashlight_on = mod:get(item.__gear_id)
			if action_name == "weapon_extra_pressed" and flashlight_on then
				return self:get_default(action_name)
			end
		end
	end
	return func(self, action_name, ...)
end)

mod.weapon_templates = {}
mod.special_types = {
	"special_bullet",
	"melee",
}

mod.template_add_torch = function(self, orig_weapon_template)
	if orig_weapon_template then
		local weapon_template = orig_weapon_template
		if not self.weapon_templates[orig_weapon_template.name] then
			self.weapon_templates[orig_weapon_template.name] = table.clone(orig_weapon_template)
			weapon_template = self.weapon_templates[orig_weapon_template.name]
			if weapon_template.displayed_weapon_stats_table and weapon_template.displayed_weapon_stats_table.damage[3] then
				weapon_template.displayed_weapon_stats_table.damage[3] = nil
			end
			if weapon_template.displayed_attacks and weapon_template.displayed_attacks.special then
				if table.contains(self.special_types, weapon_template.displayed_attacks.special.type) then
					weapon_template.displayed_attacks.special = {
						desc = "loc_stats_special_action_flashlight_desc",
						display_name = "loc_weapon_special_flashlight",
						type = "flashlight"
					}
				end
			end
		else
			weapon_template = self.weapon_templates[orig_weapon_template.name]
		end
		if weapon_template and self.previewed_weapon_flashlight then
			return weapon_template
		end
	end
	return orig_weapon_template
end

mod:hook(CLASS.ViewElementWeaponStats, "present_item", function(func, self, item, is_equipped, on_present_callback, ...)
	mod.previewed_weapon_flashlight = mod:get(item.__gear_id)
	func(self, item, is_equipped, on_present_callback, ...)
	mod.previewed_weapon_flashlight = nil
end)

InventoryWeaponsView.cb_on_switch_torch_pressed = function(self, widget)
	local id = self._previewed_item.__gear_id
	local item = self._previewed_item
	local state = mod:get(id)
	mod:set(id, not state)
	self:_play_sound(UISoundEvents.apparel_equip_frame)
	self:_stop_previewing()
	self:_preview_item(item)
end

mod:hook_require("scripts/ui/views/inventory_weapons_view/inventory_weapons_view_definitions", function(instance)
	local found = false
	for index, input in pairs(instance.legend_inputs) do
		if input.display_name == "loc_weapon_inventory_switch_torch_button" then
			found = true
		end
	end
	if not found then
		instance.legend_inputs[#instance.legend_inputs+1] = {
			input_action = "hotkey_item_discard_pressed",
			display_name = "loc_weapon_inventory_switch_torch_button",
			alignment = "right_alignment",
			on_pressed_callback = "cb_on_switch_torch_pressed",
			visibility_function = function (parent)
				local is_previewing_item = parent:is_previewing_item()
				if is_previewing_item then
					local is_previewing_item = parent:is_previewing_item()
					local previewed_item = parent:previewed_item()
					local item_type = previewed_item.item_type
					local ITEM_TYPES = UISettings.ITEM_TYPES
					if item_type == ITEM_TYPES.WEAPON_RANGED then
						local weapon_template = mod:weapon_template_from_item(previewed_item)
						if weapon_template.displayed_attacks and weapon_template.displayed_attacks.special then
							if table.contains(mod.special_types, weapon_template.displayed_attacks.special.type) then
								return true
							end
						end
					end
				end
				return false
			end
		}
	end
end)

mod.weapon_template_from_item = function (self, weapon_item)
	if not weapon_item then return nil end
	local weapon_template_name = weapon_item.weapon_template
	local weapon_progression_template_name = weapon_item.weapon_progression_template
	if weapon_progression_template_name then
		return WeaponTemplate._weapon_template(weapon_progression_template_name)
	end
	return WeaponTemplate._weapon_template(weapon_template_name)
end

mod:hook_require("scripts/utilities/weapon/weapon_template", function(instance)
	if not instance._weapon_template then instance._weapon_template = instance.weapon_template end
	instance.weapon_template = function(template_name)
		local weapon_template = instance._weapon_template(template_name)
		return mod:template_add_torch(weapon_template)
	end
end)

mod.animation_events_add_callbacks = {
	to_braced = function(event_name, event_index, unit, first_person, context)
		mod:init_context()
		if unit == mod.player_unit then mod:set_flashlight(true) end
	end,
	to_ironsight = function(event_name, event_index, unit, first_person, context)
		mod:init_context()
		if unit == mod.player_unit then mod:set_flashlight(true) end
	end,
	to_unaim_braced = function(event_name, event_index, unit, first_person, context)
		mod:init_context()
		if unit == mod.player_unit then mod:set_flashlight(false) end
	end,
	to_unaim_ironsight = function(event_name, event_index, unit, first_person, context)
		mod:init_context()
		if unit == mod.player_unit then mod:set_flashlight(false) end
	end,
}
