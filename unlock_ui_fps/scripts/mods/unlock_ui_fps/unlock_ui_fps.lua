local mod = get_mod("unlock_ui_fps")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
	local CLASS = CLASS
	local tonumber = tonumber
	local Application = Application
	local GameParameters = GameParameters
-- #endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local NO_THROTTLE = 0
local MOD_FPS_TARGET = NO_THROTTLE

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

mod.on_setting_changed = function(setting_id)
	if setting_id == "mod_option_ui_fps_target" then
		MOD_FPS_TARGET = tonumber(mod:get("mod_option_ui_fps_target")) or NO_THROTTLE
	end
end

mod.on_all_mods_loaded = function()
	MOD_FPS_TARGET = tonumber(mod:get("mod_option_ui_fps_target")) or NO_THROTTLE
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.FrameRateManager, "_set_target_fps", function(self, is_throttled)
	local target_fps

	if not Application.rendering_enabled() then
		target_fps = GameParameters.tick_rate
	elseif is_throttled then
		target_fps = MOD_FPS_TARGET
	else
		target_fps = NO_THROTTLE

		if not Application.render_caps("reflex_supported") then
			target_fps = Application.render_config("settings", "nv_framerate_cap")
		end
	end

	Application.set_time_step_policy("throttle", target_fps)
end)
