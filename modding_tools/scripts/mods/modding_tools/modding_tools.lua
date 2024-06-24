local mod = get_mod("modding_tools")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    -- local ScriptWorld = mod:original_require("scripts/foundation/utilities/script_world")
    mod:io_dofile("modding_tools/scripts/mods/modding_tools/interface/unit_manipulation")
    mod:io_dofile("modding_tools/scripts/mods/modding_tools/interface/watcher")
    mod:io_dofile("modding_tools/scripts/mods/modding_tools/interface/console")
    mod:io_dofile("modding_tools/scripts/mods/modding_tools/interface/inspector")
    mod:io_dofile("modding_tools/scripts/mods/modding_tools/patches/inject_gui")
    mod:io_dofile("modding_tools/scripts/mods/modding_tools/patches/ui_hud")
    mod:io_dofile("modding_tools/scripts/mods/modding_tools/patches/dmfmod")
    mod:io_dofile("modding_tools/scripts/mods/modding_tools/patches/ui_manager")
--#endregion

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
        }
    })
--#endregion

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

local hello_inspector = {
    ["this is the table inspector"] = {
        ["you can redirect mod:dtf"] = {
            ["to automatically open the inspector"] = {
                ["instead of dumping a file"] = true
            }
        }
    }
}
mod.on_all_mods_loaded = function()
    if not mod:get("inspector_hello") then
        mod:set("inspector_hello", true)
        mod:inspect("hello", hello_inspector)
    end
    if not mod:get("console_hello") then
        mod:set("console_hello", true)
        mod:console_print("hello - this is the console")
        mod:console_print("you can redirect mod:echo")
        mod:console_print("to print to the console")
        mod:console_print("")
        mod:console_print("you can also print a table")
        mod:console_print("and click on it")
        mod:console_print(hello_inspector)
        mod:console_print("")
        mod:console_show(true)
    end
end

mod.on_unload = function()
    mod.inspector:delete()
    mod.console:delete()
    mod.watcher:delete()
    mod:destroy_forward_guis()
end

mod.toggle_ui = function()
    mod.ui_toggle = not mod.ui_toggle
    mod.inspector:show(mod.ui_toggle)
    mod.console:show(mod.ui_toggle)
    mod.watcher:show(mod.ui_toggle)
end