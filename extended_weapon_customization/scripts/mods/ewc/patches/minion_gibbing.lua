local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local CLASS = CLASS
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.MinionGibbing, "gib", function(func, self, hit_zone_name_or_nil, attack_direction, damage_profile, override_gib_type, optional_override_gib_forces, optional_is_critical_strike, ...)
    local minion_unit = self._unit
    local reset_gibbing_type, reset_gibbing_power = nil, nil
    -- Check if unit has an override
    if minion_unit and mod.enemy_unit_damage_type_override[minion_unit] then
        -- Get gibbing values
        local damage_type = mod.enemy_unit_damage_type_override[minion_unit]
        local gibbing = mod.damage_types[damage_type] or mod.damage_types.default
        -- Override gibbing values
        reset_gibbing_power = damage_profile.gibbing_power
        damage_profile.gibbing_type = gibbing and gibbing.gibbing_type or override_gib_type
        damage_profile.gibbing_power = gibbing and gibbing.gibbing_power or damage_profile.gibbing_power
        override_gib_type = gibbing and gibbing.gibbing_type or override_gib_type
        -- Unset unit
        mod.enemy_unit_damage_type_override[minion_unit] = nil
    end
    -- Original function
    local ret = func(self, hit_zone_name_or_nil, attack_direction, damage_profile, override_gib_type, optional_override_gib_forces, optional_is_critical_strike, ...)
    -- Reset gibbing values
    if reset_gibbing_power then damage_profile.gibbing_power = reset_gibbing_power end
    if reset_gibbing_type then damage_profile.gibbing_type = reset_gibbing_type end
    -- Return
    return ret
end)
