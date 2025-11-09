local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local math = math
    local pairs = pairs
    local vector3 = Vector3
    local tostring = tostring
    local managers = Managers
    local math_max = math.max
    local unit_alive = unit.alive
    local vector3_distance_squared = vector3.distance_squared
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.time = function(self)
    return self:game_time() or self:main_time()
end

mod.delta_time = function(self)
    return self:game_delta_time() or self:main_delta_time()
end

mod.main_time = function(self)
    local time_manager = managers.time
	return time_manager and time_manager:has_timer("main") and time_manager:time("main")
end

mod.main_delta_time = function(self)
    local time_manager = managers.time
    return time_manager and time_manager:has_timer("main") and time_manager:delta_time("main")
end

mod.game_time = function(self)
    local time_manager = managers.time
	return time_manager and time_manager:has_timer("gameplay") and time_manager:time("gameplay")
end

mod.game_delta_time = function(self)
    local time_manager = managers.time
    return time_manager and time_manager:has_timer("gameplay") and time_manager:delta_time("gameplay")
end

mod.is_in_hub = function()
	local state_manager = managers.state
	local game_mode = state_manager and state_manager.game_mode
	local game_mode_name = game_mode and game_mode:game_mode_name()
	return game_mode_name == "hub" or mod:is_in_prologue_hub()
end

mod.is_in_prologue_hub = function()
	local state_manager = managers.state
	local game_mode = state_manager and state_manager.game_mode
	local game_mode_name = game_mode and game_mode:game_mode_name()
	return game_mode_name == "prologue_hub"
end

mod.world = function(self)
    return managers.world:world("level_world")
end

mod.me = function(self)
    -- Get player
    local player = self:player()
    -- Return player unit
    return player and player.player_unit
end

mod.player = function(self)
    return managers.player:local_player_safe(1)
end

mod.profile = function(self, player)
    local player = player or self:player()
    return player and player:profile()
end

mod.get_view = function(self, view_name)
    local ui_manager = managers.ui
    return ui_manager:view_active(view_name) and ui_manager:view_instance(view_name) or nil
end

mod.localize_or_nil = function(self, str, optional_mod)
    local used_mod = optional_mod or self
    local used_str = str or ""
    local localized = used_mod:localize(used_str)
    if localized == "<"..used_str..">" then
        return nil
    end
    return localized
end

mod.update_cutscene = function(self)
    -- Old value
    local old_value = self.cutscene_playing
    -- New value
    local is_playing = self:is_cutscene_active()
    -- Value change?
    if old_value ~= is_playing then
        -- Cutscene is now playing
        managers.event:trigger("ewc_cutscene", is_playing)
    end
    -- Save value
    self.cutscene_playing = is_playing
end

mod.is_cutscene_active = function (self)
	local extension_manager = managers.state.extension
	local cinematic_scene_system = extension_manager and extension_manager:system("cinematic_scene_system")
	local cinematic_scene_system_active = cinematic_scene_system and cinematic_scene_system:is_active()
	local cinematic_manager = managers.state.cinematic
	local cinematic_manager_active = cinematic_manager and cinematic_manager:cinematic_active()
	return cinematic_scene_system_active or cinematic_manager_active
end

mod.calculate_light_value = function(self, darkness_system, position)
	local light_value = 0
	for unit, data in pairs(darkness_system._light_source_data) do
        if unit and unit_alive(unit) then
            local pos = POSITION_LOOKUP[unit] or position
            local dist_sq = math_max(vector3_distance_squared(position, pos), 1)
            local intensity = data.intensity
            light_value = light_value + intensity * (1 / dist_sq)
        end
	end
	return light_value
end

mod.is_in_darkness = function(self, position)
    local darkness_system = managers.state.extension:system("darkness_system")
    if darkness_system and position then
        local is_in_darkness = darkness_system:is_in_darkness(position)
        local light_value = self:calculate_light_value(darkness_system, position)
        return is_in_darkness or light_value < 0.0025
    end
end
