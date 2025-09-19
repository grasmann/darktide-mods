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
    local table_contains = table.contains
    local script_unit_extension = script_unit.extension
--#endregion

mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/extensions/common")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

mod.save_lua = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/utilities/save")
mod.plugins = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/utilities/plugins")
-- mod.settings = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/utilities/settings")

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
})

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.pt = function(self)
    return self:persistent_table(REFERENCE)
end

mod.time = function(self)
    return self:game_time() or self:main_time()
end

mod.main_time = function(self)
    local time_manager = managers.time
	return time_manager and time_manager:has_timer("main") and time_manager:time("main")
end

mod.game_time = function(self)
    local time_manager = managers.time
	return time_manager and time_manager:has_timer("gameplay") and time_manager:time("gameplay")
end

mod.me = function(self)
    -- Get player
    local player = managers.player and managers.player:local_player_safe(1)
    -- Return player unit
    return player and player.player_unit
end

mod.get_view = function(self, view_name)
    local ui_manager = managers.ui
    return ui_manager:view_active(view_name) and ui_manager:view_instance(view_name) or nil
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

mod.on_all_mods_loaded = function()
    mod.loaded_plugins = mod:load_plugins()
    if mod:pt().game_initialized then
        mod:try_kitbash_load()
    end
    managers.event:trigger("extended_weapon_customization_reloaded")
end

mod.on_setting_changed = function(setting_id)
    managers.event:trigger("extended_weapon_customization_settings_changed")
end

mod.on_unload = function(exit_game)
end

mod.clear_chat = function()
	managers.event:trigger("event_clear_notifications")
end

mod.on_game_state_changed = function(status, state_name)
    if state_name == "StateTitle" and status == "exit" then
        mod:pt().game_initialized = true
        mod:try_kitbash_load()
    end
end

-- ##### ┌─┐┌─┐┌┬┐┌─┐┬ ┬┌─┐┌─┐ ########################################################################################
-- ##### ├─┘├─┤ │ │  ├─┤├┤ └─┐ ########################################################################################
-- ##### ┴  ┴ ┴ ┴ └─┘┴ ┴└─┘└─┘ ########################################################################################

mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/patches/master_items")

mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/utilities/gear_settings")
mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/utilities/kitbash")
mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/utilities/fixes")
mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/utilities/items")

mod.settings = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/utilities/settings")

mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/patches/inventory_weapon_cosmetics_view_definitions")
mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/patches/player_unit_visual_loadout_extension")
mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/patches/ui_character_profile_package_loader")
mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/patches/player_unit_first_person_extension")
mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/patches/inventory_weapon_cosmetics_view")
mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/patches/visual_loadout_customization")
mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/patches/player_unit_fx_extension")
mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/patches/equipment_component")
mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/patches/item_icon_loader_ui")
mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/patches/view_element_grid")
mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/patches/weapon_icon_ui")
mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/patches/item_package")

mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/extensions/sight_extension")
