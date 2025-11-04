local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local damage_settings = mod:original_require("scripts/settings/damage/damage_settings")
local HitScan = mod:original_require("scripts/utilities/attack/hit_scan")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local type = type
    local unit = Unit
    local pairs = pairs
    local CLASS = CLASS
    local table = table
    local tostring = tostring
    local quaternion = Quaternion
    local table_sort = table.sort
    local script_unit = ScriptUnit
    local table_clear = table.clear
    local table_append = table.append
    local quaternion_forward = quaternion.forward
    local script_unit_extension = script_unit.extension
    local unit_attachment_callback = unit.attachment_callback
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local EMPTY_TABLE = {}
local ALL_HITS = {}
local _hit_sort_function, _find_line_effect
local INDEX_DISTANCE = 2
local INDEX_ACTOR = 4
local IMPACT_FX_DATA = {
	will_be_predicted = true,
}
local damage_type_setting = "damage_type"
local damage_type_active_setting = "damage_type_active"

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

local function _hit_sort_function(entry_1, entry_2)
	local distance_1 = entry_1.distance or entry_1[INDEX_DISTANCE]
	local distance_2 = entry_2.distance or entry_2[INDEX_DISTANCE]

	return distance_1 < distance_2
end

local shoot_hook = function(func, self, position, rotation, power_level, charge_level, t, fire_config, ...)

    local hit_minion = nil
    local hit_scan_template = fire_config.hit_scan_template
    if hit_scan_template then
        local debug_drawer = self._debug_drawer
        local is_local_unit = self._is_local_unit
        local is_server = self._is_server
        local physics_world = self._physics_world
        local player = self._player
        local player_unit = self._player_unit
        local world = self._world
        local weapon_item = self._weapon.item
        local wielded_slot = self._inventory_component.wielded_slot
        local action_settings = self._action_settings
        local max_distance = hit_scan_template.range
        local is_critical_strike = self._critical_strike_component.is_active
        local direction = quaternion_forward(rotation)
        local instakill = false
        local end_position, hit_weakspot, killing_blow, num_hit_units
        local rewind_ms = self:_rewind_ms(is_local_unit, player, position, direction, max_distance)
        local collision_tests = hit_scan_template.collision_tests

        if collision_tests then
            table_clear(ALL_HITS)

            for i = 1, #collision_tests do
                local config = collision_tests[i]
                local test = config.test
                local against = config.against
                local collision_filter = config.collision_filter
                local radius = config.radius

                if test == "ray" then
                    local hits = HitScan.raycast(physics_world, position, direction, max_distance, against, collision_filter, rewind_ms, is_local_unit, player, is_server)

                    if hits then
                        table_append(ALL_HITS, hits)
                    end
                elseif test == "sphere" then
                    local hits = HitScan.sphere_sweep(physics_world, position, direction, max_distance, against, collision_filter, rewind_ms, radius)

                    if hits then
                        table_append(ALL_HITS, hits)
                    end
                end
            end

            table_sort(ALL_HITS, _hit_sort_function)

            end_position, hit_weakspot, killing_blow, hit_minion, num_hit_units = HitScan.process_hits(is_server, world, physics_world, player_unit, fire_config, ALL_HITS, position, direction, power_level, charge_level, IMPACT_FX_DATA, max_distance, debug_drawer, is_local_unit, player, instakill, is_critical_strike, weapon_item, wielded_slot)
        else
            local hits = HitScan.raycast(physics_world, position, direction, max_distance, nil, nil, rewind_ms, is_local_unit, player, is_server)

            end_position, hit_weakspot, killing_blow, hit_minion, num_hit_units = HitScan.process_hits(is_server, world, physics_world, player_unit, fire_config, hits, position, direction, power_level, charge_level, IMPACT_FX_DATA, max_distance, debug_drawer, is_local_unit, player, instakill, is_critical_strike, weapon_item, wielded_slot)
        end
    end

    -- Get weapon item
    local item = self._weapon.item
    local gear_id = item and mod:gear_id(item)
    -- Get damage type
    local damage_type_list = mod:get(damage_type_setting)
    local damage_type = damage_type_list and gear_id and damage_type_list[gear_id]
    local damage_type_active_list = mod:get(damage_type_active_setting)
    local use_damage_type = damage_type_active_list and gear_id and damage_type_active_list[gear_id]

    -- Check item and damage type
    if hit_minion and use_damage_type and damage_type then
        -- Override damage type
        mod.enemy_unit_damage_type_override[hit_minion] = damage_type
    end

    -- Original function
    func(self, position, rotation, power_level, charge_level, t, fire_config, ...)

end

mod:hook(CLASS.ActionShoot, "_shoot", shoot_hook)
mod:hook(CLASS.ActionShootHitScan, "_shoot", shoot_hook)
mod:hook(CLASS.ActionShootPellets, "_shoot", shoot_hook)
mod:hook(CLASS.ActionShootProjectile, "_shoot", shoot_hook)

local line_fx_hook = function(func, self, line_effect, position, end_position, optional_attachment_id, ...)

    local player_unit = self._player_unit
    local unit_data_extension = script_unit_extension(player_unit, "unit_data_system")
    local alternate_fire_component = unit_data_extension and unit_data_extension:read_component("alternate_fire")
    local aiming = alternate_fire_component and alternate_fire_component.is_active

    -- Get weapon item
    local item = self._weapon.item
    -- Check item and attachments
    if item and item.attachments then
        -- Get damage type
        local gear_id = mod:gear_id(item)
        local damage_type_list = mod:get(damage_type_setting)
        local damage_type = damage_type_list and gear_id and damage_type_list[gear_id]
        local damage_type_active_list = mod:get(damage_type_active_setting)
        local use_damage_type = damage_type_active_list and gear_id and damage_type_active_list[gear_id]
        -- Check damage type
        if damage_type and use_damage_type then
            -- Override damage type
            local new_effect
            if aiming and mod.damage_types[damage_type].line_effect_aiming then
                new_effect = mod.damage_types[damage_type].line_effect_aiming
            elseif mod.damage_types[damage_type].line_effect then
                new_effect = mod.damage_types[damage_type].line_effect
            end
            line_effect = new_effect or line_effect
        end
    end

    -- Original function
    func(self, line_effect, position, end_position, optional_attachment_id, ...)
end

mod:hook(CLASS.ActionShootHitScan, "_play_line_fx", line_fx_hook)
mod:hook(CLASS.ActionShootPellets, "_play_line_fx", line_fx_hook)

local shoot_sound_hook = function(func, self, fire_config, ...)

    local player_unit = self._player_unit
    local unit_data_extension = script_unit_extension(player_unit, "unit_data_system")
    local alternate_fire_component = unit_data_extension and unit_data_extension:read_component("alternate_fire")
    local aiming = alternate_fire_component and alternate_fire_component.is_active

    -- Get weapon item
    local item = self._weapon.item
    local gear_id = item and mod:gear_id(item)

    -- Check item and attachments
    if gear_id then
        -- Get damage type
        local damage_type_list = mod:get(damage_type_setting)
        local damage_type = damage_type_list and gear_id and damage_type_list[gear_id]
        local damage_type_active_list = mod:get(damage_type_active_setting)
        local use_damage_type = damage_type_active_list and gear_id and damage_type_active_list[gear_id]
        -- Check damage type
        if use_damage_type and damage_type and mod.damage_types[damage_type] then
            -- Override damage type
            local damage_type = mod.damage_types[damage_type]

            mod:clear_fx_override(gear_id, "ranged_single_shot")
            mod:clear_fx_override(gear_id, "play_ranged_shooting")
            mod:clear_fx_override(gear_id, "stop_ranged_shooting")
            mod:clear_fx_override(gear_id, "ranged_pre_loop_shot")

            if aiming and damage_type.play_ranged_shooting_aiming then
                mod:set_fx_override(gear_id, "play_ranged_shooting", damage_type.play_ranged_shooting_aiming)
            elseif damage_type.play_ranged_shooting then
                mod:set_fx_override(gear_id, "play_ranged_shooting", damage_type.play_ranged_shooting)
            end

            if aiming and damage_type.ranged_single_shot_aiming then
                mod:set_fx_override(gear_id, "ranged_single_shot", damage_type.ranged_single_shot_aiming)
            elseif damage_type.ranged_single_shot then
                mod:set_fx_override(gear_id, "ranged_single_shot", damage_type.ranged_single_shot)
            end

            if aiming and damage_type.stop_ranged_shooting_aiming then
                mod:set_fx_override(gear_id, "stop_ranged_shooting", damage_type.stop_ranged_shooting_aiming)
            elseif damage_type.stop_ranged_shooting then
                mod:set_fx_override(gear_id, "stop_ranged_shooting", damage_type.stop_ranged_shooting)
            end

            if aiming and damage_type.ranged_pre_loop_shot_aiming then
                mod:set_fx_override(gear_id, "ranged_pre_loop_shot", damage_type.ranged_pre_loop_shot_aiming)
            elseif damage_type.ranged_pre_loop_shot then
                mod:set_fx_override(gear_id, "ranged_pre_loop_shot", damage_type.ranged_pre_loop_shot)
            end
        else
            mod:clear_fx_overrides(gear_id)
        end
    end

    -- Original function
    func(self, fire_config, ...)

end

mod:hook(CLASS.ActionShoot, "_play_shoot_sound", shoot_sound_hook)
mod:hook(CLASS.ActionShootHitScan, "_play_shoot_sound", shoot_sound_hook)
mod:hook(CLASS.ActionShootPellets, "_play_shoot_sound", shoot_sound_hook)
mod:hook(CLASS.ActionShootProjectile, "_play_shoot_sound", shoot_sound_hook)

mod:hook(CLASS.ActionShoot, "_update_looping_shoot_sound", shoot_sound_hook)
mod:hook(CLASS.ActionShootHitScan, "_update_looping_shoot_sound", shoot_sound_hook)
mod:hook(CLASS.ActionShootPellets, "_update_looping_shoot_sound", shoot_sound_hook)
mod:hook(CLASS.ActionShootProjectile, "_update_looping_shoot_sound", shoot_sound_hook)

local muzzle_flash_hook = function(func, self, fire_config, shoot_rotation, charge_level, ...)
    -- Get weapon item
    local effect_to_play = nil
    local item = self._weapon.item
    local gear_id = item and mod:gear_id(item)
    -- Check item and attachments
    if gear_id then
        -- Get damage type
        local damage_type_list = mod:get(damage_type_setting)
        local damage_type = damage_type_list and gear_id and damage_type_list[gear_id]
        local damage_type_active_list = mod:get(damage_type_active_setting)
        local use_damage_type = damage_type_active_list and gear_id and damage_type_active_list[gear_id]
        -- Check damage type
        if use_damage_type and damage_type and mod.damage_types[damage_type] then
            -- Override damage type
            local damage_type = mod.damage_types[damage_type]

            local fx = self._action_settings.fx
            if fx then
                local effect_name = fx.muzzle_flash_effect
                local effect_name_secondary = fx.muzzle_flash_effect_secondary
                local crit_effect_name = fx.muzzle_flash_crit_effect
                local weapon_special_effect_name = fx.weapon_special_muzzle_flash_effect
                local weapon_special_crit_effect_name = fx.weapon_special_muzzle_flash_crit_effect

                local player_unit = self._player_unit
                local unit_data_extension = script_unit_extension(player_unit, "unit_data_system")
                local alternate_fire_component = unit_data_extension and unit_data_extension:read_component("alternate_fire")
                local aiming = alternate_fire_component and alternate_fire_component.is_active

                mod:clear_fx_override(gear_id, crit_effect_name)
                mod:clear_fx_override(gear_id, effect_name)
                mod:clear_fx_override(gear_id, effect_name_secondary)
                mod:clear_fx_override(gear_id, weapon_special_effect_name)
                mod:clear_fx_override(gear_id, weapon_special_crit_effect_name)

                if aiming and damage_type.muzzle_flash_crit_aiming then
                    mod:set_fx_override(gear_id, crit_effect_name, damage_type.muzzle_flash_crit_aiming)
                elseif damage_type.muzzle_flash_crit then
                    mod:set_fx_override(gear_id, crit_effect_name, damage_type.muzzle_flash_crit)
                end

                if aiming and damage_type.muzzle_flash_secondary_aiming then
                    mod:set_fx_override(gear_id, effect_name_secondary, damage_type.muzzle_flash_secondary_aiming)
                elseif damage_type.muzzle_flash_secondary then
                    mod:set_fx_override(gear_id, effect_name_secondary, damage_type.muzzle_flash_secondary)
                end

                if aiming and damage_type.muzzle_flash_aiming then
                    mod:set_fx_override(gear_id, effect_name, damage_type.muzzle_flash_aiming)
                elseif damage_type.muzzle_flash then
                    mod:set_fx_override(gear_id, effect_name, damage_type.muzzle_flash)
                end

                if aiming and damage_type.muzzle_flash_special_aiming then
                    mod:set_fx_override(gear_id, weapon_special_effect_name, damage_type.muzzle_flash_special_aiming)
                elseif damage_type.muzzle_flash_special then
                    mod:set_fx_override(gear_id, weapon_special_effect_name, damage_type.muzzle_flash_special)
                end

                if aiming and damage_type.muzzle_flash_special_crit_aiming then
                    mod:set_fx_override(gear_id, weapon_special_crit_effect_name, damage_type.muzzle_flash_special_crit_aiming)
                elseif damage_type.muzzle_flash_special_crit then
                    mod:set_fx_override(gear_id, weapon_special_crit_effect_name, damage_type.muzzle_flash_special_crit)
                end

            end
        else
            mod:clear_fx_overrides(gear_id)
        end
    end
    -- Original function
    func(self, fire_config, shoot_rotation, charge_level, ...)

end

mod:hook(CLASS.ActionShoot, "_play_muzzle_flash_vfx", muzzle_flash_hook)
mod:hook(CLASS.ActionShootHitScan, "_play_muzzle_flash_vfx", muzzle_flash_hook)
mod:hook(CLASS.ActionShootPellets, "_play_muzzle_flash_vfx", muzzle_flash_hook)
mod:hook(CLASS.ActionShootProjectile, "_play_muzzle_flash_vfx", muzzle_flash_hook)
