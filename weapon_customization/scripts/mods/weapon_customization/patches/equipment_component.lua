local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require

--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
    local CLASS = CLASS
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data

--#endregion

mod:hook(CLASS.EquipmentComponent, "wield_slot", function(func, slot, first_person_mode, ...)
    -- Original function
    func(slot, first_person_mode, ...)
    -- Extensions
    if slot.name then
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
end)

mod:hook(CLASS.EquipmentComponent, "unwield_slot", function(func, slot, first_person_mode, ...)
    -- Extensions
    if slot.name then
        -- Visible equipment
        mod:execute_extension(slot.parent_unit_3p, "visible_equipment_system", "on_unwield_slot", slot)
        -- Flashlights
        mod:execute_extension(slot.parent_unit_3p, "flashlight_system", "on_unwield_slot", slot)
    end
    -- Original function
    func(slot, first_person_mode, ...)
end)

mod:hook(CLASS.EquipmentComponent, "equip_item", function(func, self, unit_3p, unit_1p, slot, item, optional_existing_unit_3p, deform_overrides, optional_breed_name, optional_mission_template, ...)
    -- Original function
    func(self, unit_3p, unit_1p, slot, item, optional_existing_unit_3p, deform_overrides, optional_breed_name, optional_mission_template, ...)
    -- Flashlights
    mod:execute_extension(unit_3p, "flashlight_system", "on_equip_slot", slot)
    -- Sight
    mod:execute_extension(unit_3p, "sight_system", "on_equip_slot", slot)
    -- Weapon DOF
    mod:execute_extension(unit_3p, "weapon_dof_system", "on_equip_slot", slot)
    -- Visible equipment
    if slot.name == "slot_gear_extra_cosmetic" then
        mod:execute_extension(unit_3p, "visible_equipment_system", "position_equipment")
    end
end)

mod:hook(CLASS.EquipmentComponent, "unequip_item", function(func, self, slot, ...)
    -- Visible equipment
    mod:execute_extension(slot.parent_unit_3p, "visible_equipment_system", "on_unequip_slot", slot)
    -- Original function
    func(self, slot, ...)
end)

mod:hook(CLASS.EquipmentComponent, "update_item_visibility", function(func, equipment, wielded_slot, unit_3p, unit_1p, first_person_mode, ...)
    -- Original function
    func(equipment, wielded_slot, unit_3p, unit_1p, first_person_mode, ...)
    -- Visible equipment
    mod:execute_extension(unit_3p, "visible_equipment_system", "on_update_item_visibility", wielded_slot)
end)