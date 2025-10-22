local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local Missions = mod:original_require("scripts/settings/mission/mission_templates")
local MissionIntroViewSettings = mod:original_require("scripts/ui/views/mission_intro_view/mission_intro_view_settings")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local CLASS = CLASS
    local string = string
    local get_mod = get_mod
    local managers = Managers
    local string_format = string.format
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local pt = mod:pt()

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.print = function(self, message, echo)
    if self:get("debug_mode") then
        local modding_tools = get_mod("modding_tools")
        if not echo and modding_tools then
            modding_tools:console_print(message)
        else
            self:echo(message)
        end
    end
    mod:info(message)
end

mod.debug_sight_clear = function(self)
    pt.debug_sight = {0, 0, 0, 0, 0, 0}
end

mod.debug_sight_set = function(self, px, py, pz, rx, ry, rz)
    if not pt.debug_sight then
        self:debug_sight_clear()
    end
    pt.debug_sight = {pt.debug_sight[1] + px, pt.debug_sight[2] + py, pt.debug_sight[3] + pz, pt.debug_sight[4] + rx, pt.debug_sight[5] + ry, pt.debug_sight[6] + rz}
    mod:print(string_format("px: %f, py: %f, pz: %f, rx: %f, ry: %f, rz: %f", pt.debug_sight[1], pt.debug_sight[2], pt.debug_sight[3], pt.debug_sight[4], pt.debug_sight[5], pt.debug_sight[6]))
end

local rotation_step = .1
local position_step = .01

mod.rotate_x = function() mod:debug_sight_set(0, 0, 0, rotation_step, 0, 0) end
mod.rotate_x_2 = function() mod:debug_sight_set(0, 0, 0, -rotation_step, 0, 0) end

mod.rotate_y = function() mod:debug_sight_set(0, 0, 0, 0, rotation_step, 0) end
mod.rotate_y_2 = function() mod:debug_sight_set(0, 0, 0, 0, -rotation_step, 0) end

mod.rotate_z = function() mod:debug_sight_set(0, 0, 0, 0, 0, rotation_step) end
mod.rotate_z_2 = function() mod:debug_sight_set(0, 0, 0, 0, 0, -rotation_step) end

mod.move_x = function() mod:debug_sight_set(position_step, 0, 0, 0, 0, 0) end
mod.move_x_2 = function() mod:debug_sight_set(-position_step, 0, 0, 0, 0, 0) end

mod.move_y = function() mod:debug_sight_set(0, position_step, 0, 0, 0, 0) end
mod.move_y_2 = function() mod:debug_sight_set(0, -position_step, 0, 0, 0, 0) end

mod.move_z = function() mod:debug_sight_set(0, 0, position_step, 0, 0, 0) end
mod.move_z_2 = function() mod:debug_sight_set(0, 0, -position_step, 0, 0, 0) end

-- ##### ┌┬┐┌─┐┌┐ ┬ ┬┌─┐  ┬  ┬┬┌─┐┬ ┬┌─┐ ##############################################################################
-- #####  ││├┤ ├┴┐│ ││ ┬  └┐┌┘│├┤ │││└─┐ ##############################################################################
-- ##### ─┴┘└─┘└─┘└─┘└─┘   └┘ ┴└─┘└┴┘└─┘ ##############################################################################

mod.load_mission_intro_view = function()
	mod:_load_mission_intro_view()
end

mod.load_end_view = function()
	mod:_load_end_view()
end

mod.load_lobby_view = function()
	mod:_load_lobby_view()
end

mod._load_mission_intro_view = function()
	if not mod.loading_open then
		mod.loading_intro_view = true
		managers.ui:open_view("mission_intro_view", nil, nil, nil, nil, {})
	elseif mod.loading_open then
		mod.loading_intro_view = false
		managers.ui:close_view("mission_intro_view")
	end
	mod.loading_open = not mod.loading_open
end

mod._load_end_view = function()
	if not mod.end_view_open then
		managers.ui:open_view("end_view", nil, nil, nil, nil, {})
	elseif mod.end_view_open then
		managers.ui:close_view("end_view")
	end
	mod.end_view_open = not mod.end_view_open
end

mod._load_lobby_view = function()
	if not mod.lobby_view_open then
		mod.loading_lobby_view = true
		if not managers.mechanism._mechanism then
			managers.mechanism._mechanism = {
				_mechanism_data = {
					mission_name = "psykhanium",
					circumstance_name = "default",
					backend_mission_id = 1,
				}
			}
		end
		managers.ui:open_view("lobby_view", nil, nil, nil, nil, {
			mission_data = ""
		})
		managers.mechanism._mechanism = nil
	elseif mod.lobby_view_open then
		mod.loading_lobby_view = false
		managers.ui:close_view("lobby_view")
	end
	mod.lobby_view_open = not mod.lobby_view_open
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.LobbyView, "_sync_votes", function(func, self, ...)
	if mod.loading_lobby_view then
		return
	end
	return func(self, ...)
end)

mod:hook(CLASS.EndView, "_set_mission_key", function(func, self, mission_key, session_report, render_scale, ...)
	if mission_key then
		-- Original function
		func(self, mission_key, session_report, render_scale, ...)
	end
end)

mod:hook(CLASS.MissionIntroView, "select_target_intro_level", function(func, mission_name, ...)
	if mod.loading_intro_view then
		local mission_zone_id = mission_name and Missions[mission_name].zone_id or "default"
		local intro_level = MissionIntroViewSettings.intro_levels_by_zone_id[mission_zone_id] or MissionIntroViewSettings.intro_levels_by_zone_id.default
		local intro_level_packages = {
			is_level_package = true,
			name = intro_level.level_name,
		}
		return intro_level, intro_level_packages
	else
		return func(mission_name, ...)
	end
end)
