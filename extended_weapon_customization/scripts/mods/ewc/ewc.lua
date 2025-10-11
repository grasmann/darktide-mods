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
    local string_format = string.format
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
    loading_packages = {},
    loaded_packages = {},
    debug_sight = {0, 0, 0, 0, 0, 0},
    husk_weapon_templates = {},
    cutscene_playing = false,
})

mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/extensions/common")

mod.save_lua = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/utilities/save")

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.pt = function(self)
    return self:persistent_table(REFERENCE)
end

local pt = mod:pt()

mod.init = function(self)
    -- Clear mod items
    self:clear_mod_items()
    self:clear_all_alternate_fire_overrides()
    -- Load plugins
    self.loaded_plugins = self:load_plugins()
    -- If game already initialized ( mod reload )
    if pt.game_initialized then
        self:try_kitbash_load()
        -- self:find_missing_items()
        -- self:find_missing_attachments()
    end
    -- Load packages
    self:load_packages()
end

mod._on_all_mods_loaded = function(self)
    self:init()
    managers.event:trigger("ewc_reloaded")
end

mod._on_setting_changed = function(self, setting_id)
    managers.event:trigger("ewc_settings_changed")
end

mod._clear_chat = function(self)
	managers.event:trigger("event_clear_notifications")
end

mod._on_game_state_changed = function(self, status, state_name)
    if state_name == "StateTitle" and status == "exit" then
        pt.game_initialized = true
    end
    table_clear(pt.exclude_from_vfx_spawner)
    table_clear(pt.items_originating_from_customization_menu)
end

mod._on_unload = function(self, exit_game)
    if exit_game then
        self:release_packages()
    end
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

mod._update = function(self, dt)
    self:update_cutscene()
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

mod.update = function(dt)
    mod:_update(dt)
end

mod.on_all_mods_loaded = function()
    mod:_on_all_mods_loaded()
end

mod.on_setting_changed = function(setting_id)
    mod:_on_setting_changed(setting_id)
end

mod.on_unload = function(exit_game)
    mod:_on_unload(exit_game)
end

mod.clear_chat = function()
    mod:_clear_chat()
end

mod.on_game_state_changed = function(status, state_name)
    mod:_on_game_state_changed(status, state_name)
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
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/utilities/packages")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/utilities/debug")

mod.settings = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/utilities/settings")
mod:update_flashlight_templates(mod.settings.flashlight_templates)

mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/master_items")

mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/inventory_weapon_cosmetics_view_definitions")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/player_unit_visual_loadout_extension")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/player_husk_visual_loadout_extension")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/ui_character_profile_package_loader")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/player_unit_first_person_extension")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/player_husk_first_person_extension")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/inventory_weapon_cosmetics_view")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/visual_loadout_customization")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/inventory_weapon_marks_view")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/player_unit_fx_extension")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/hud_element_crosshair")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/attack_report_manager")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/equipment_component")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/item_icon_loader_ui")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/ui_profile_spawner")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/view_element_grid")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/ui_weapon_spawner")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/weapon_icon_ui")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/alternate_fire")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/camera_manager")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/crafting_view")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/input_service")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/action_sweep")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/item_package")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/flashlight")

mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/extensions/attachment_callback_extension")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/extensions/flashlight_extension")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/extensions/sight_extension")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/extensions/sway_extension")
