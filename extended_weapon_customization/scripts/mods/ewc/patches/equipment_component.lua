local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local pairs = pairs
    local table = table
    local CLASS = CLASS
    local managers = Managers
    local table_size = table.size
    local script_unit = ScriptUnit
    local table_clear = table.clear
    local unit_sway_callback = unit.sway_callback
    local unit_sight_callback = unit.sight_callback
    local unit_shield_callback = unit.shield_callback
    local script_unit_extension = script_unit.extension
    local unit_attachment_callback = unit.attachment_callback
    local unit_flashlight_callback = unit.flashlight_callback
    local unit_has_animation_event = unit.has_animation_event
    local unit_damage_type_callback = unit.damage_type_callback
    local unit_has_animation_state_machine = unit.has_animation_state_machine
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local SLOT_PRIMARY = "slot_primary"
local SLOT_SECONDARY = "slot_secondary"
local VALID_SLOTS = {SLOT_PRIMARY, SLOT_SECONDARY}

-- local STABILIZE_NECK_SUPPORTED = {}
-- local TEMP_ITEM_STABILIZE_NECK = {}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.EquipmentComponent, "initialize_equipment", function(func, slot_configuration, breed_settings, optional_slot_options, ...)
	-- local equipment = {}
	-- local slot_options = optional_slot_options or NO_SLOT_OPTIONS

	-- for slot_name, config in pairs(slot_configuration) do
	-- 	local slot = _create_slot_from_configuration(config, breed_settings, slot_options[slot_name] or NO_OPTIONS)

	-- 	equipment[slot_name] = slot
	-- end

	-- return equipment

    if mod.skip_link_children then
        -- local slot_options = {
        --     slot_primary = {
        --         skip_link_children = false,
        --     },
        --     slot_secondary = {
        --         skip_link_children = true,
        --     },
        -- }
        optional_slot_options = optional_slot_options or {}
        optional_slot_options.slot_primary = optional_slot_options.slot_primary or {}
        optional_slot_options.slot_secondary = optional_slot_options.slot_secondary or {}
        optional_slot_options.slot_primary.skip_link_children = true
        optional_slot_options.slot_secondary.skip_link_children = true
    end


    return func(slot_configuration, breed_settings, optional_slot_options, ...)

end)

mod:hook(CLASS.EquipmentComponent, "_spawn_player_item_units", function(func, self, slot, unit_3p, unit_1p, attach_settings, optional_mission_template, optional_equipment, ...)
    local item = slot and slot.item
    -- Check item
    if mod:cached_table_contains(VALID_SLOTS, slot.name) and item then
        -- Modify item
        mod:modify_item(item)
        -- Fixes
        mod:apply_attachment_fixes(item)
    end
    -- Original function
    return func(self, slot, unit_3p, unit_1p, attach_settings, optional_mission_template, optional_equipment, ...)
end)

mod:hook(CLASS.EquipmentComponent, "equip_item", function(func, self, unit_3p, unit_1p, slot, item, optional_existing_unit_3p, deform_overrides, optional_breed_name, optional_mission_template, optional_equipment, optional_companion_unit_3p, ...)
    -- Check item
    if mod:cached_table_contains(VALID_SLOTS, slot.name) and item then
        -- Modify item
        mod:modify_item(item)
        -- Fixes
        mod:apply_attachment_fixes(item)
    end
    -- Original function
    func(self, unit_3p, unit_1p, slot, item, optional_existing_unit_3p, deform_overrides, optional_breed_name, optional_mission_template, optional_equipment, optional_companion_unit_3p, ...)
    -- Clear alternate fire override
    mod:clear_alternate_fire_override(unit_3p)
    -- Equip sight callback
    unit_sight_callback(unit_3p, "on_equip_weapon")
    -- Equip attachment callback
    unit_attachment_callback(unit_3p, "on_equip_weapon")
    -- Equip shield callback
    unit_shield_callback(unit_3p, "on_equip_weapon")
    -- Equip damage type callback
    unit_damage_type_callback(unit_3p, "on_equip_weapon")
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
    -- Wield shield callback
    unit_shield_callback(slot.parent_unit_3p, "on_wield", slot.name)
    -- Equip damage type callback
    unit_damage_type_callback(slot.parent_unit_3p, "on_wield", slot.name)
end)

mod:hook(CLASS.EquipmentComponent, "update_item_visibility", function(func, equipment, wielded_slot, unit_3p, unit_1p, first_person_mode, item_definitions, ...)

    -- local stabilize_neck_supported = STABILIZE_NECK_SUPPORTED[unit_3p]

    -- if stabilize_neck_supported == nil then
    --     -- Check support for stabilize neck
    --     if unit_has_animation_state_machine(unit_3p) and unit_has_animation_event(unit_3p, "lock_head") and unit_has_animation_event(unit_3p, "unlock_head") then
    --         STABILIZE_NECK_SUPPORTED[unit_3p] = true
    --     else
    --         STABILIZE_NECK_SUPPORTED[unit_3p] = false
    --     end
    --     stabilize_neck_supported = STABILIZE_NECK_SUPPORTED[unit_3p]
    -- end

    -- -- Check if stabilize neck is not supported
    -- if not stabilize_neck_supported and table_size(equipment) > 0 then
    --     -- Iterate through equipment
    --     for slot_name, slot in pairs(equipment) do
    --         -- Get item
    --         local item = slot.item
    --         -- Check if item has stabilize neck
    --         if item and item.stabilize_neck then
    --             -- Save stabilize neck for unit_3p and slot
    --             TEMP_ITEM_STABILIZE_NECK[slot_name] = item.stabilize_neck
    --             -- Unset stabilize neck in item
    --             item.stabilize_neck = nil
    --         end
    --     end
    -- end

    -- Original function
    func(equipment, wielded_slot, unit_3p, unit_1p, first_person_mode, item_definitions, ...)
    -- Update flashlight visibility
    unit_flashlight_callback(unit_3p, "on_update_item_visibility", wielded_slot)
    -- Update attachment callback visibility
    unit_attachment_callback(unit_3p, "on_update_item_visibility", wielded_slot)

    -- -- Check if stabilize neck is not supported
    -- if not stabilize_neck_supported and table_size(TEMP_ITEM_STABILIZE_NECK) > 0 then
    --     -- Iterate through saved stabilize neck
    --     for slot_name, stabilize_neck in pairs(TEMP_ITEM_STABILIZE_NECK) do
    --         local slot = equipment[slot_name]
    --         local item = slot and slot.item
    --         if item then
    --             item.stabilize_neck = stabilize_neck
    --         end
    --     end
    --     -- Clear saved stabilize neck
    --     table_clear(TEMP_ITEM_STABILIZE_NECK)
    -- end

end)
