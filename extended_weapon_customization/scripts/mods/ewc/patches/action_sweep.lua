local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local CLASS = CLASS
    local unit_attachment_callback = unit.attachment_callback
    local unit_damage_type_callback = unit.damage_type_callback
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local damage_type_active_setting = "damage_type_active"

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

local function _damage_type(action)
    local wielded_slot = action._inventory_component.wielded_slot
    return unit_damage_type_callback(action._player_unit, "damage_type", wielded_slot)
end

local function _damage_type_active(action)
    local item = action._weapon.item
    local gear_id = item and mod:gear_id(item)
    local damage_type_active_list = mod:get(damage_type_active_setting)
    return damage_type_active_list and gear_id and damage_type_active_list[gear_id]
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.ActionSweep, "_do_damage_to_unit", function(func, self, damage_profile, hit_unit, hit_actor, hit_position, hit_normal, attack_direction, target_index, num_hit_enemies, hit_zone_name_or_nil, abort_attack, amount_of_mass_hit, damage_type, is_special_active, ...)
    -- Get damage type
    local damage_type_t = _damage_type(self)
    local use_damage_type = _damage_type_active(self)
    -- Check damage type
    if damage_type_t and use_damage_type then
        -- Override damage type
        -- damage_type = damage_type_t.game_damage_type or damage_type
        -- Set unit override
        mod.enemy_unit_damage_type_override[hit_unit] = damage_type_t.game_damage_type or damage_type
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
