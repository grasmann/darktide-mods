local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local damage_profile_templates = mod:original_require("scripts/settings/damage/damage_profile_templates")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local CLASS = CLASS
    local managers = Managers
    local script_unit = ScriptUnit
    local network_lookup = NetworkLookup
    local script_unit_extension = script_unit.extension
    local script_unit_has_extension = script_unit.has_extension
--#endregion

-- local attack_results = AttackSettings.attack_results

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.AttackReportManager, "rpc_add_attack_result", function(func, self, channel_id, damage_profile_id, attacked_unit_id, attacked_unit_is_level_unit,
        attacking_unit_id, attack_direction, hit_world_position, hit_weakspot, damage, attack_result_id, attack_type_id, damage_efficiency_id, is_critical_strike, ...)

    -- Original function
    func(self, channel_id, damage_profile_id, attacked_unit_id, attacked_unit_is_level_unit,
        attacking_unit_id, attack_direction, hit_world_position, hit_weakspot, damage, attack_result_id, attack_type_id, damage_efficiency_id, is_critical_strike, ...)

    -- -- local attacked_unit = buffer_data.attacked_unit
    local unit_spawner_manager = managers.state.unit_spawner
    local attacked_unit = attacked_unit_id and unit_spawner_manager:unit(attacked_unit_id, attacked_unit_is_level_unit)
    local attacking_unit = attacking_unit_id and unit_spawner_manager:unit(attacking_unit_id)
    local attack_type = attack_type_id and network_lookup.attack_types[attack_type_id]
    local damage_profile_name = network_lookup.damage_profile_templates[damage_profile_id]
	local damage_profile = damage_profile_templates[damage_profile_name]

    local attachment_callback_extension = script_unit_extension(attacking_unit, "attachment_callback_system")
    if attachment_callback_extension then
        attachment_callback_extension:on_impact(hit_world_position, attacked_unit, attack_type, damage_profile)
    end

    -- local unit_data_extension = script_unit_has_extension(attacked_unit, "unit_data_system")
	-- local breed_or_nil = unit_data_extension and unit_data_extension:breed()

    -- if not breed_or_nil then
	-- 	return
	-- end

    -- local attack_result = network_lookup.attack_results[attack_result_id]
    -- local tags = breed_or_nil and breed_or_nil.tags
    -- local allowed_breed = tags and (tags.monster or tags.special or tags.elite)
    -- if allowed_breed and attack_result == attack_results.died then

    --     local point_cost = breed_or_nil.point_cost or 0
    --     managers.event:trigger("servo_friend_victory_speech_accumulation", point_cost, breed_or_nil.is_boss, nil, attacking_unit)

    -- end

end)

mod:hook(CLASS.AttackReportManager, "_process_attack_result", function(func, self, buffer_data, ...)

    -- Original function
    func(self, buffer_data, ...)

    local attacked_unit = buffer_data.attacked_unit
	local attacking_unit = buffer_data.attacking_unit
    local attack_direction = buffer_data.attack_direction:unbox()
	local hit_world_position = buffer_data.hit_world_position and buffer_data.hit_world_position:unbox()
    local attack_type = buffer_data.attack_type
    local damage_profile = buffer_data.damage_profile

    local attachment_callback_extension = script_unit_extension(attacking_unit, "attachment_callback_system")
    if attachment_callback_extension then
        attachment_callback_extension:on_impact(hit_world_position, attacked_unit, attack_type, damage_profile)
    end

    -- local attacked_unit = buffer_data.attacked_unit
    -- local attacking_unit = buffer_data.attacking_unit
    -- local unit_data_extension = script_unit_has_extension(attacked_unit, "unit_data_system")
	-- local breed_or_nil = unit_data_extension and unit_data_extension:breed()

    -- if not breed_or_nil then
	-- 	return
	-- end

    -- local attack_result = buffer_data.attack_result
    -- local tags = breed_or_nil and breed_or_nil.tags
    -- local allowed_breed = tags and (tags.monster or tags.special or tags.elite)
    -- if allowed_breed and attack_result == attack_results.died then

    --     local point_cost = breed_or_nil.point_cost or 0
    --     managers.event:trigger("servo_friend_victory_speech_accumulation", point_cost, breed_or_nil.is_boss, nil, attacking_unit)

    -- end

end)

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
    -- Original function
    func(self, unit_3p, unit_1p, slot, item, optional_existing_unit_3p, deform_overrides, optional_breed_name, optional_mission_template, optional_equipment, optional_companion_unit_3p, ...)
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
