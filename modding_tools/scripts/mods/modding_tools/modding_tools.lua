local mod = get_mod("modding_tools")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
	local Unit = Unit
	local CLASS = CLASS
	local pairs = pairs
	local string = string
	local managers = Managers
	local tostring = tostring
	local unit_alive = Unit.alive
	local script_unit = ScriptUnit
	local string_gsub = string.gsub
	local script_unit_extension = script_unit.extension
	local script_unit_has_extension = script_unit.has_extension
	local script_unit_add_extension = script_unit.add_extension
	local script_unit_remove_extension = script_unit.remove_extension
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	mod:persistent_table("modding_tools", {
		-- Flashlight
		unit_manipulation = {
			extensions = {},
		},
		console = {
			delay_buffer = {},
		},
	})
--#endregion

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

-- mod.performance = {}
-- mod.cycle = 0
mod.set_mod = function(self, executing_mod)
	self.executing_mod = executing_mod
end

mod.main_time = function()
	return managers.time and managers.time:time("main") or 0
end

--#region Require
	-- Interfaces
	mod:io_dofile("modding_tools/scripts/mods/modding_tools/interface/unit_manipulation")
	mod:io_dofile("modding_tools/scripts/mods/modding_tools/interface/watcher")
	mod:io_dofile("modding_tools/scripts/mods/modding_tools/interface/console")
	mod:io_dofile("modding_tools/scripts/mods/modding_tools/interface/inspector")
	mod:io_dofile("modding_tools/scripts/mods/modding_tools/interface/gui_injector")
	-- Patches
	mod:io_dofile("modding_tools/scripts/mods/modding_tools/patches/dmfmod")
--#endregion

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

mod.on_all_mods_loaded = function()
	if mod:get("console_drawing_time") then mod:watch("Drawing Console", mod.console, "drawing_time", "%s ms") end
	if mod:get("watcher_drawing_time") then mod:watch("Drawing Watcher", mod.watcher, "drawing_time", "%s ms") end
	if mod:get("inspector_drawing_time") then mod:watch("Drawing Inspector", mod.inspector, "drawing_time", "%s ms") end
end

mod.on_unload = function()
	mod._toggle(false)
	mod:inspector_unload()
	mod:console_unload()
	mod:watcher_unload()
end

mod._toggle = function(visible)
	mod:inspector_toggle(visible)
	mod:console_toggle(visible)
	mod:watcher_toggle(visible)
end

mod.toggle_ui = function(value)
	mod.ui_toggle = not mod.ui_toggle
	mod._toggle(mod.ui_toggle)
end