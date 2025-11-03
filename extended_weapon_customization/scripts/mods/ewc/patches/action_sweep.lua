local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local damage_settings = mod:original_require("scripts/settings/damage/damage_settings")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local CLASS = CLASS
    local unit_attachment_callback = unit.attachment_callback
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.ActionSweep, "_do_damage_to_unit", function(func, self, damage_profile, hit_unit, hit_actor, hit_position, hit_normal, attack_direction, target_index, num_hit_enemies, hit_zone_name_or_nil, abort_attack, amount_of_mass_hit, damage_type, is_special_active, ...)
    -- Get weapon item
    local item = self._weapon.item
    -- Check item and attachments
    if item and item.attachments then
        -- Get damage type
        local gear_id = mod:gear_id(item)
        local damage_type_list = mod:get("damage_type")
        local use_damage_type = damage_type_list and damage_type_list[gear_id]
        -- Check damage type
        if use_damage_type and mod.damage_types[use_damage_type] then
            -- Override damage type
            damage_type = damage_type.game_damage_type or use_damage_type
            -- Set unit override
            mod.enemy_unit_damage_type_override[hit_unit] = use_damage_type
        end
    end
    -- Original function
    func(self, damage_profile, hit_unit, hit_actor, hit_position, hit_normal, attack_direction, target_index, num_hit_enemies, hit_zone_name_or_nil, abort_attack, amount_of_mass_hit, damage_type, is_special_active, ...)
end)

mod:hook(CLASS.ActionSweep, "start", function(func, self, action_settings, t, time_scale, action_start_params, ...)
    -- Original function
    func(self, action_settings, t, time_scale, action_start_params, ...)
    -- Attachment callback
    unit_attachment_callback(self._player_unit, "on_attack", self._hit_units)
end)
