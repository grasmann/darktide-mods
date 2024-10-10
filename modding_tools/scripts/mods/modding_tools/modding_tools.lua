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

--#region Require
	-- Interfaces
	mod:io_dofile("modding_tools/scripts/mods/modding_tools/interface/unit_manipulation")
	mod:io_dofile("modding_tools/scripts/mods/modding_tools/interface/watcher")
	mod:io_dofile("modding_tools/scripts/mods/modding_tools/interface/console")
	mod:io_dofile("modding_tools/scripts/mods/modding_tools/interface/inspector")
	-- Patches
	mod:io_dofile("modding_tools/scripts/mods/modding_tools/patches/inject_gui")
	mod:io_dofile("modding_tools/scripts/mods/modding_tools/patches/ui_hud")
	mod:io_dofile("modding_tools/scripts/mods/modding_tools/patches/dmfmod")
	mod:io_dofile("modding_tools/scripts/mods/modding_tools/patches/ui_manager")
--#endregion

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

mod.on_all_mods_loaded = function()
end

mod.on_unload = function()
	if mod.inspector then
		mod.inspector:delete()
		mod.inspector = nil
	end
	if mod.console then
		mod.console:delete()
		mod.console = nil
	end
	if mod.watcher then
		mod.watcher:delete()
		mod.watcher = nil
	end
end

mod.toggle_ui = function()
	mod.ui_toggle = not mod.ui_toggle
	if mod.inspector then mod.inspector:show(mod.ui_toggle) end
	if mod.console then mod.console:show(mod.ui_toggle) end
	if mod.watcher then mod.watcher:show(mod.ui_toggle) end
end