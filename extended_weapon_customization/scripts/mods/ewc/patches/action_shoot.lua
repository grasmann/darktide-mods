local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local VisualLoadoutCustomization = mod:original_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization")
local MultiFireModes = mod:original_require("scripts/settings/equipment/weapon_templates/multi_fire_modes")
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
    local unit_damage_type_callback = unit.damage_type_callback
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
local EXTERNAL_PROPERTIES = {}
local damage_type_active_setting = "damage_type_active"

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

local function _hit_sort_function(entry_1, entry_2)
	local distance_1 = entry_1.distance or entry_1[INDEX_DISTANCE]
	local distance_2 = entry_2.distance or entry_2[INDEX_DISTANCE]
	return distance_1 < distance_2
end

local function _get_aiming(action)
    local player_unit = action._player_unit
    local unit_data_extension = script_unit_extension(player_unit, "unit_data_system")
    local alternate_fire_component = unit_data_extension and unit_data_extension:read_component("alternate_fire")
    return alternate_fire_component and alternate_fire_component.is_active
end

local function _damage_type(action)
    local wielded_slot = action._inventory_component.wielded_slot
    return unit_damage_type_callback(action._player_unit, "damage_type", wielded_slot)
end

local function _damage_type_active(action)
    local item = action._weapon.item
    local gear_id = item and mod:gear_id(item)
    local damage_type_active_list = mod:get(damage_type_active_setting)
    local use_damage_type = damage_type_active_list and gear_id and damage_type_active_list[gear_id]
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

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

    -- Get damage type
    local damage_type = _damage_type(self)
    local use_damage_type = _damage_type_active(self)

    -- Check item and damage type
    if hit_minion and use_damage_type and damage_type then
        -- Override damage type
        mod.enemy_unit_damage_type_override[hit_minion] = damage_type.game_damage_type
    end

    -- Original function
    func(self, position, rotation, power_level, charge_level, t, fire_config, ...)

end

mod:hook(CLASS.ActionShoot, "_shoot", shoot_hook)
mod:hook(CLASS.ActionShootHitScan, "_shoot", shoot_hook)
mod:hook(CLASS.ActionShootPellets, "_shoot", shoot_hook)
mod:hook(CLASS.ActionShootProjectile, "_shoot", shoot_hook)

local line_fx_hook = function(func, self, line_effect, position, end_position, optional_attachment_id, ...)

    -- Get aiming
    local aiming = _get_aiming(self)
    -- Get damage type
    local damage_type = _damage_type(self)
    local use_damage_type = _damage_type_active(self)
    -- Check damage type
    if damage_type and use_damage_type then
        
        local new_effect
        if aiming and damage_type.line_effect_aiming then
            new_effect = damage_type.line_effect_aiming
        elseif damage_type.line_effect then
            new_effect = damage_type.line_effect
        end

        line_effect = new_effect or line_effect

    end

    -- Original function
    func(self, line_effect, position, end_position, optional_attachment_id, ...)
end

mod:hook(CLASS.ActionShootHitScan, "_play_line_fx", line_fx_hook)
mod:hook(CLASS.ActionShootPellets, "_play_line_fx", line_fx_hook)

local shoot_sound_hook = function(func, self, fire_config, ...)

    -- Get aiming
    local aiming = _get_aiming(self)
    -- Get weapon item
    local item = self._weapon.item
    local gear_id = item and mod:gear_id(item)

    -- Check item and attachments
    if gear_id then
        -- Get damage type
        local damage_type = _damage_type(self)
        local use_damage_type = _damage_type_active(self)
        -- Check damage type
        if use_damage_type and damage_type then

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

            local action_settings = self._action_settings
            local fx_settings = action_settings.fx
            local default_looping_sound = fx_settings and fx_settings.looping_shoot_sfx_alias
            local no_play_loop_or_silence = (not damage_type.play_ranged_shooting_aiming and not damage_type.play_ranged_shooting) or
                (damage_type.play_ranged_shooting_aiming == "wwise/events/weapon/play_weapon_silence" or damage_type.play_ranged_shooting == "wwise/events/weapon/play_weapon_silence")

            self.fake_looping_shoot_sfx_alias = default_looping_sound and no_play_loop_or_silence and (damage_type.ranged_single_shot_aiming or damage_type.ranged_single_shot)

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

local update_sound_hook = function(func, self, fire_config, ...)

    -- Get time
    local t = mod:time()
    -- Get damage type
    local damage_type = _damage_type(self)
    local use_damage_type = _damage_type_active(self)
    -- Get aiming
    local aiming = _get_aiming(self)

    if self.fake_looping_shoot_sfx_alias and use_damage_type and damage_type then

        local action_component = self._action_component
        local fx_extension = self._fx_extension
        local action_settings = self._action_settings
        local muzzle_fx_source_name = self:_muzzle_fx_source()
        local fx_settings = action_settings.fx or EMPTY_TABLE
        local post_loop_tail_alias = fx_settings.post_loop_shoot_tail_sfx_alias
        local num_pre_loop_events = fx_settings.num_pre_loop_events or 0
        local reference_attachment_id, has_ammo

        if self._multi_fire_mode == MultiFireModes.simultaneous then
            reference_attachment_id = VisualLoadoutCustomization.ROOT_ATTACH_NAME

            for i = 1, #self._fire_configurations do
                if self:_has_ammo(self._fire_configurations[i]) then
                    has_ammo = true

                    break
                end
            end
        else
            reference_attachment_id = self:_reference_attachment_id(fire_config)
            has_ammo = self:_has_ammo(fire_config)
        end

        local fire_state = action_component.fire_state
        local is_looping_shoot_sfx_playing = self._run_looping_sound
        local automatic_fire = is_looping_shoot_sfx_playing and (fire_state == "waiting_to_shoot" or fire_state == "shooting" or fire_state == "prepare_shooting" or fire_state == "prepare_simultaneous_shot")
        local shooting = fire_state == "start_shooting" or fire_state == "shooting" or automatic_fire
        local num_shots_fired = action_component.num_shots_fired
        local started_shooting = shooting and has_ammo

        if started_shooting then

            self.fake_timer = self.fake_timer or t

            local fire_rate_settings = self:_fire_rate_settings()
            local auto_fire_time = fire_rate_settings.auto_fire_time
            local parameter_name = fx_settings.auto_fire_time_parameter_name

            if auto_fire_time then

                local shoot_sfx = aiming and (damage_type.ranged_single_shot_aiming or damage_type.ranged_pre_loop_shot_aiming) or damage_type.ranged_single_shot or damage_type.ranged_pre_loop_shot

                table.clear(EXTERNAL_PROPERTIES)
                local action_module_charge_component = self._action_module_charge_component
                if action_module_charge_component then
                    local charge_level = action_module_charge_component.charge_level
                    EXTERNAL_PROPERTIES.charge_level = charge_level >= 1 and "fully_charged"
                end

                if shoot_sfx and t - self.fake_timer >= auto_fire_time then

                    self.fake_timer = t

                    fx_extension:trigger_wwise_event_with_source(shoot_sfx, muzzle_fx_source_name, true, false, reference_attachment_id)
                end

            end

        else
            self.fake_timer = nil
        end

    end

    -- Original function
    func(self, fire_config, ...)

end

mod:hook(CLASS.ActionShoot, "_update_looping_shoot_sound", update_sound_hook)
mod:hook(CLASS.ActionShootHitScan, "_update_looping_shoot_sound", update_sound_hook)
mod:hook(CLASS.ActionShootPellets, "_update_looping_shoot_sound", update_sound_hook)
mod:hook(CLASS.ActionShootProjectile, "_update_looping_shoot_sound", update_sound_hook)

local muzzle_flash_hook = function(func, self, fire_config, shoot_rotation, charge_level, ...)
    -- Get weapon item
    local effect_to_play = nil
    local item = self._weapon.item
    local gear_id = item and mod:gear_id(item)
    -- Check item and attachments
    if gear_id then
        -- Get damage type
        local damage_type = _damage_type(self)
        local use_damage_type = _damage_type_active(self)
        -- Get aiming
        local aiming = _get_aiming(self)
        -- Check damage type
        if use_damage_type and damage_type then

            local fx = self._action_settings.fx
            if fx then
                local effect_name = fx.muzzle_flash_effect
                local effect_name_secondary = fx.muzzle_flash_effect_secondary
                local crit_effect_name = fx.muzzle_flash_crit_effect
                local weapon_special_effect_name = fx.weapon_special_muzzle_flash_effect
                local weapon_special_crit_effect_name = fx.weapon_special_muzzle_flash_crit_effect

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
