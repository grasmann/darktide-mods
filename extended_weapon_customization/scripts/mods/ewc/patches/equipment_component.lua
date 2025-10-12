local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local CLASS = CLASS
    local managers = Managers
    local script_unit = ScriptUnit
    local script_unit_extension = script_unit.extension
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
    -- Update sight offset
    local sight_extension = script_unit_extension(unit_3p, "sight_system")
    if sight_extension then
        sight_extension:on_equip_weapon()
    end
    local attachment_callback_extension = script_unit_extension(unit_3p, "attachment_callback_system")
    if attachment_callback_extension then
        attachment_callback_extension:on_equip_weapon()
    end
end)

mod:hook(CLASS.EquipmentComponent, "wield_slot", function(func, slot, first_person_mode, ...)
    -- Original function
    func(slot, first_person_mode, ...)
    -- Update flashlight visibility
    local flashlight_extension = script_unit_extension(slot.parent_unit_3p, "flashlight_system")
    if flashlight_extension then
        flashlight_extension:on_wield(slot.name)
    end
    local sight_extension = script_unit_extension(slot.parent_unit_3p, "sight_system")
    if sight_extension then
        sight_extension:on_wield(slot.name)
    end
    local attachment_callback_extension = script_unit_extension(slot.parent_unit_3p, "attachment_callback_system")
    if attachment_callback_extension then
        attachment_callback_extension:on_wield(slot.name)
    end
end)

mod:hook(CLASS.EquipmentComponent, "update_item_visibility", function(func, equipment, wielded_slot, unit_3p, unit_1p, first_person_mode, ...)
    -- Original function
    func(equipment, wielded_slot, unit_3p, unit_1p, first_person_mode, ...)
    -- Update flashlight visibility
    local flashlight_extension = script_unit_extension(unit_3p, "flashlight_system")
    if flashlight_extension then
        flashlight_extension:on_update_item_visibility(wielded_slot)
    end
    local attachment_callback_extension = script_unit_extension(unit_3p, "attachment_callback_system")
    if attachment_callback_extension then
        attachment_callback_extension:on_update_item_visibility(wielded_slot)
    end
end)
