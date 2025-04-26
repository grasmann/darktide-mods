local mod = get_mod("weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
	local CLASS = CLASS
	local table = table
	local pairs = pairs
	local managers = Managers
	local ScriptUnit = ScriptUnit
	local table_clear = table.clear
	local script_unit_extension = ScriptUnit.extension
	local unit_set_scalar_for_materials = Unit.set_scalar_for_materials
	local unit_set_shader_pass_flag_for_meshes = Unit.set_shader_pass_flag_for_meshes
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local SLOT_SECONDARY = "slot_secondary"
	local SLOT_PRIMARY = "slot_primary"
--#endregion

-- ##### ┌─┐┬  ┌─┐┌┐ ┌─┐┬    ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ################################################################
-- ##### │ ┬│  │ │├┴┐├─┤│    ├┤ │ │││││   │ ││ ││││└─┐ ################################################################
-- ##### └─┘┴─┘└─┘└─┘┴ ┴┴─┘  └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ################################################################

mod.get_equipment_component = function(self, unit)
	local visual_loadout_extension = script_unit_extension(unit, "visual_loadout_system")
	return visual_loadout_extension and visual_loadout_extension._equipment_component
end

mod.execute_equipment_component = function(self, unit, function_name, ...)
	local equipment_component = self:get_equipment_component(unit)
	if equipment_component then equipment_component[function_name](equipment_component, ...) end
end

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

-- local temp_unspawned_attachment_slots = {}
mod:hook_require("scripts/extension_systems/visual_loadout/equipment_component", function(instance)

	instance.wield_custom = function(self, slot)
		-- Visible equipment
		if self.use_visible_equipment_system then mod:execute_extension(slot.parent_unit_3p, "visible_equipment_system", "on_wield_slot", slot) end
		-- Flashlights
		if self.use_flashlight_system then mod:execute_extension(slot.parent_unit_3p, "flashlight_system", "on_wield_slot", slot) end
		-- Crouch
		if self.use_crouch_animation_system then mod:execute_extension(slot.parent_unit_3p, "crouch_system", "on_wield_slot", slot) end
		-- Sway
		if self.use_sway_system then mod:execute_extension(slot.parent_unit_3p, "sway_system", "on_wield_slot", slot) end
		-- Sight
		if self.use_sight_system then mod:execute_extension(slot.parent_unit_3p, "sight_system", "on_wield_slot", slot) end
		-- Weapon DOF
		if self.use_dof_system then mod:execute_extension(slot.parent_unit_3p, "weapon_dof_system", "on_wield_slot", slot) end
		-- Sling
		-- if self.use_sling_system then mod:execute_extension(slot.parent_unit_3p, "weapon_sling_system", "on_wield_slot", slot) end
	end

	instance.unwield_custom = function(self, slot)
		-- Visible equipment
		if self.use_visible_equipment_system then mod:execute_extension(slot.parent_unit_3p, "visible_equipment_system", "on_unwield_slot", slot) end
		-- Flashlights
		if self.use_flashlight_system then mod:execute_extension(slot.parent_unit_3p, "flashlight_system", "on_unwield_slot", slot) end
		-- Sling
		-- if self.use_sling_system then mod:execute_extension(slot.parent_unit_3p, "weapon_sling_system", "on_unwield_slot", slot) end
	end

	instance.equip_custom = function(self, slot)
		-- Flashlights
		if self.use_flashlight_system then mod:execute_extension(slot.parent_unit_3p, "flashlight_system", "on_equip_slot", slot) end
		-- Sight
		if self.use_sight_system then mod:execute_extension(slot.parent_unit_3p, "sight_system", "on_equip_slot", slot) end
		-- Weapon DOF
		if self.use_dof_system then mod:execute_extension(slot.parent_unit_3p, "weapon_dof_system", "on_equip_slot", slot) end
		-- Visible equipment
		-- if slot.name == "slot_gear_extra_cosmetic" then
		if self.use_visible_equipment_system then mod:execute_extension(slot.parent_unit_3p, "visible_equipment_system", "position_equipment") end
		-- end
		-- Sling
		-- if self.use_sling_system then mod:execute_extension(slot.parent_unit_3p, "weapon_sling_system", "on_equip_slot", slot) end
	end

	instance.unequip_custom = function(self, slot)
		-- Visible equipment
		if self.use_visible_equipment_system then mod:execute_extension(slot.parent_unit_3p, "visible_equipment_system", "on_unequip_slot", slot) end
		-- Sling
		-- if self.use_sling_system then mod:execute_extension(slot.parent_unit_3p, "weapon_sling_system", "on_unequip_slot", slot) end
	end

	instance.update_visibility_custom = function(self, wielded_slot, unit_3p)
		-- Visible equipment
		if self.use_visible_equipment_system then mod:execute_extension(unit_3p, "visible_equipment_system", "on_update_item_visibility", wielded_slot) end
	end

	instance.on_settings_changed = function(self)
        self.use_crouch_animation_system = mod:get("mod_option_crouch_animation")
        self.use_dof_system = mod:get("mod_option_misc_weapon_dof")
        self.use_sway_system = mod:get("mod_option_sway")
        self.use_flashlight_system = mod:get("mod_option_flashlight")
        self.use_sight_system = mod:get("mod_option_scopes")
        self.use_visible_equipment_system = mod:get("mod_option_visible_equipment")
        self.disable_visible_equipment_system_in_hub = mod:get("mod_option_visible_equipment_disable_in_hub")
		-- self.use_sling_system = mod:get("mod_option_sling")
    end

	instance.destroy = function(self)
		managers.event:unregister(self, "weapon_customization_settings_changed")
	end

end)

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #############################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################################################

mod:hook(CLASS.EquipmentComponent, "init", function(func, self, world, item_definitions, unit_spawner, unit_3p, optional_extension_manager, optional_item_streaming_settings, optional_force_highest_lod_step, ...)
	-- Original function
	func(self, world, item_definitions, unit_spawner, unit_3p, optional_extension_manager, optional_item_streaming_settings, optional_force_highest_lod_step, ...)
	-- Register event
	managers.event:register(self, "weapon_customization_settings_changed", "on_settings_changed")
	-- Set settings
	self:on_settings_changed()
end)

mod:hook(CLASS.EquipmentComponent, "wield_slot", function(func, slot, first_person_mode, ...)
	-- Original function
	func(slot, first_person_mode, ...)
	-- Extensions
	mod:execute_equipment_component(slot.parent_unit_3p, "wield_custom", slot)
end)

mod:hook(CLASS.EquipmentComponent, "unwield_slot", function(func, slot, first_person_mode, ...)
	-- Extensions
	mod:execute_equipment_component(slot.parent_unit_3p, "unwield_custom", slot)
	-- Original function
	func(slot, first_person_mode, ...)
end)

mod:hook(CLASS.EquipmentComponent, "equip_item", function(func, self, unit_3p, unit_1p, slot, item, optional_existing_unit_3p, deform_overrides, optional_breed_name, optional_mission_template, optional_equipment, ...)
	-- Original function
	func(self, unit_3p, unit_1p, slot, item, optional_existing_unit_3p, deform_overrides, optional_breed_name, optional_mission_template, optional_equipment, ...)
	-- Extensions
	self:equip_custom(slot)
end)

mod:hook(CLASS.EquipmentComponent, "unequip_item", function(func, self, slot, ...)
	-- Extensions
	self:unequip_custom(slot)
	-- Original function
	func(self, slot, ...)
end)

mod:hook(CLASS.EquipmentComponent, "update_item_visibility", function(func, equipment, wielded_slot, unit_3p, unit_1p, first_person_mode, ...)
	-- Original function
	func(equipment, wielded_slot, unit_3p, unit_1p, first_person_mode, ...)
	-- Extensions
	mod:execute_equipment_component(unit_3p, "update_visibility_custom", wielded_slot, unit_3p)
end)