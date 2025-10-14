local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local CLASS = CLASS
    local managers = Managers
    local script_unit = ScriptUnit
    local unit_sway_callback = unit.sway_callback
    local unit_sight_callback = unit.sight_callback
    local script_unit_extension = script_unit.extension
    local unit_attachment_callback = unit.attachment_callback
    local unit_flashlight_callback = unit.flashlight_callback
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.EquipmentComponent, "_spawn_player_item_units", function(func, self, slot, unit_3p, unit_1p, attach_settings, optional_mission_template, optional_equipment, ...)
    local item = slot and slot.item
    -- Modify item
    mod:modify_item(item)
    -- Fixes
    mod:apply_attachment_fixes(item)
    -- Original function
    return func(self, slot, unit_3p, unit_1p, attach_settings, optional_mission_template, optional_equipment, ...)
end)

-- EquipmentComponent.equip_item = function (self, unit_3p, unit_1p, slot, item, optional_existing_unit_3p, deform_overrides, optional_breed_name, optional_mission_template, optional_equipment, optional_companion_unit_3p)
mod:hook(CLASS.EquipmentComponent, "equip_item", function(func, self, unit_3p, unit_1p, slot, item, optional_existing_unit_3p, deform_overrides, optional_breed_name, optional_mission_template, optional_equipment, optional_companion_unit_3p, ...)
    -- Modify item
    mod:modify_item(item)
    -- Fixes
    mod:apply_attachment_fixes(item)
    -- Original function
    func(self, unit_3p, unit_1p, slot, item, optional_existing_unit_3p, deform_overrides, optional_breed_name, optional_mission_template, optional_equipment, optional_companion_unit_3p, ...)
    -- Clear alternate fire override
    mod:clear_alternate_fire_override(unit_3p)
    -- Equip sight callback
    unit_sight_callback(unit_3p, "on_equip_weapon")
    -- Equip attachment callback
    unit_attachment_callback(unit_3p, "on_equip_weapon")
end)

mod:hook(CLASS.EquipmentComponent, "wield_slot", function(func, slot, first_person_mode, ...)
    -- Original function
    func(slot, first_person_mode, ...)
    -- Wield flashlight callback
    unit_flashlight_callback(slot.parent_unit_3p, "on_wield", slot.name)
    -- Wield sight callback
    unit_sight_callback(slot.parent_unit_3p, "on_wield", slot.name)
    -- Wield attachment callback
    unit_attachment_callback(slot.parent_unit_3p, "on_wield", slot.name)
    -- Wield sway callback
    unit_sway_callback(slot.parent_unit_3p, "on_wield", slot.name)
end)

mod:hook(CLASS.EquipmentComponent, "update_item_visibility", function(func, equipment, wielded_slot, unit_3p, unit_1p, first_person_mode, ...)
    -- Original function
    func(equipment, wielded_slot, unit_3p, unit_1p, first_person_mode, ...)
    -- Update flashlight visibility
    unit_flashlight_callback(unit_3p, "on_update_item_visibility", wielded_slot)
    -- Update attachment callback visibility
    unit_attachment_callback(unit_3p, "on_update_item_visibility", wielded_slot)
end)
