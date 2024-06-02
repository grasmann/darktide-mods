local mod = get_mod("weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
    local CLASS = CLASS
    local ScriptUnit = ScriptUnit
    local script_unit_extension = ScriptUnit.extension
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

mod:hook_require("scripts/extension_systems/visual_loadout/equipment_component", function(instance)

    instance.wield_custom = function(self, slot)
        -- Visible equipment
        mod:execute_extension(slot.parent_unit_3p, "visible_equipment_system", "on_wield_slot", slot)
        -- Flashlights
        mod:execute_extension(slot.parent_unit_3p, "flashlight_system", "on_wield_slot", slot)
        -- Crouch
        mod:execute_extension(slot.parent_unit_3p, "crouch_system", "on_wield_slot", slot)
        -- Sway
        mod:execute_extension(slot.parent_unit_3p, "sway_system", "on_wield_slot", slot)
        -- Sight
        mod:execute_extension(slot.parent_unit_3p, "sight_system", "on_wield_slot", slot)
        -- Weapon DOF
        mod:execute_extension(slot.parent_unit_3p, "weapon_dof_system", "on_wield_slot", slot)
    end

    instance.unwield_custom = function(self, slot)
        if slot and slot.name then
            -- Visible equipment
            mod:execute_extension(slot.parent_unit_3p, "visible_equipment_system", "on_unwield_slot", slot)
            -- Flashlights
            mod:execute_extension(slot.parent_unit_3p, "flashlight_system", "on_unwield_slot", slot)
        end
    end

    instance.equip_custom = function(self, slot)
        -- Flashlights
        mod:execute_extension(slot.parent_unit_3p, "flashlight_system", "on_equip_slot", slot)
        -- Sight
        mod:execute_extension(slot.parent_unit_3p, "sight_system", "on_equip_slot", slot)
        -- Weapon DOF
        mod:execute_extension(slot.parent_unit_3p, "weapon_dof_system", "on_equip_slot", slot)
        -- Visible equipment
        if slot.name == "slot_gear_extra_cosmetic" then
            mod:execute_extension(slot.parent_unit_3p, "visible_equipment_system", "position_equipment")
        end
    end

    instance.unequip_custom = function(self, slot)
        -- Visible equipment
        mod:execute_extension(slot.parent_unit_3p, "visible_equipment_system", "on_unequip_slot", slot)
    end

    instance.update_visibility_custom = function(self, wielded_slot, unit_3p)
        -- Visible equipment
        mod:execute_extension(unit_3p, "visible_equipment_system", "on_update_item_visibility", wielded_slot)
    end

end)

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #############################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################################################

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

mod:hook(CLASS.EquipmentComponent, "equip_item", function(func, self, unit_3p, unit_1p, slot, item, optional_existing_unit_3p, deform_overrides, optional_breed_name, optional_mission_template, ...)
    
    -- Original function
    func(self, unit_3p, unit_1p, slot, item, optional_existing_unit_3p, deform_overrides, optional_breed_name, optional_mission_template, ...)

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