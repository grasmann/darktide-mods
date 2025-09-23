local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local type = type
    local CLASS = CLASS
    local pairs = pairs
    local table = table
    local managers = Managers
    local table_find = table.find
    local script_unit = ScriptUnit
    local table_clear = table.clear
    local table_contains = table.contains
    local script_unit_extension = script_unit.extension
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "extended_weapon_customization"

mod:persistent_table(REFERENCE, {
    items = {},
    gear_files = mod:get("gear_files") or {},
    gear_settings = {},
    cached_items = {},
    gear_id_relays = {},
    kitbash_entries = {},
    exclude_from_vfx_spawner = {},
    items_originating_from_customization_menu = {},
    game_initialized = false,
    attachment_data_origin = {},
})

mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/extensions/common")

mod.save_lua = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/utilities/save")

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.print = function(self, message)
    if self:get("debug_mode") then self:echo(message) end
end

mod.pt = function(self)
    return self:persistent_table(REFERENCE)
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

mod.on_all_mods_loaded = function()
    mod.loaded_plugins = mod:load_plugins()
    local pt = mod:pt()
    table_clear(pt.items)
    if pt.game_initialized then
        mod:try_kitbash_load()
    end
    managers.event:trigger("ewc_reloaded")
end

mod.on_setting_changed = function(setting_id)
    managers.event:trigger("ewc_settings_changed")
end

mod.on_unload = function(exit_game)
end

mod.clear_chat = function()
	managers.event:trigger("event_clear_notifications")
end

mod.on_game_state_changed = function(status, state_name)
    local pt = mod:pt()
    if state_name == "StateTitle" and status == "exit" then
        pt.game_initialized = true
    end
    table_clear(pt.exclude_from_vfx_spawner)
    table_clear(pt.items_originating_from_customization_menu)
end

-- ##### ┌─┐┌─┐┌┬┐┌─┐┬ ┬┌─┐┌─┐ ########################################################################################
-- ##### ├─┘├─┤ │ │  ├─┤├┤ └─┐ ########################################################################################
-- ##### ┴  ┴ ┴ ┴ └─┘┴ ┴└─┘└─┘ ########################################################################################

mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/utilities/game")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/utilities/items")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/utilities/gear_settings")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/utilities/kitbash")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/utilities/fixes")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/utilities/plugins")

mod.settings = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/utilities/settings")

mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/master_items")

mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/inventory_weapon_cosmetics_view_definitions")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/player_unit_visual_loadout_extension")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/ui_character_profile_package_loader")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/player_unit_first_person_extension")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/inventory_weapon_cosmetics_view")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/visual_loadout_customization")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/player_unit_fx_extension")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/equipment_component")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/item_icon_loader_ui")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/view_element_grid")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/weapon_icon_ui")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/item_package")

mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/extensions/sight_extension")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/extensions/sway_extension")
