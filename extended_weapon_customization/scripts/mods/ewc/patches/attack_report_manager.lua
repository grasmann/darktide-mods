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
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.AttackReportManager, "rpc_add_attack_result", function(func, self, channel_id, damage_profile_id, attacked_unit_id, attacked_unit_is_level_unit,
        attacking_unit_id, attack_direction, hit_world_position, hit_weakspot, damage, attack_result_id, attack_type_id, damage_efficiency_id, is_critical_strike, ...)

    -- Original function
    func(self, channel_id, damage_profile_id, attacked_unit_id, attacked_unit_is_level_unit, attacking_unit_id, attack_direction, hit_world_position, hit_weakspot, damage, attack_result_id, attack_type_id, damage_efficiency_id, is_critical_strike, ...)

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

end)
