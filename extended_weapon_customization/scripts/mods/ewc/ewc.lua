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
    loading_packages = {},
    loaded_packages = {},
    debug_sight = {0, 0, 0, 0, 0, 0},
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

mod.init = function(self)
    local pt = self:pt()
    -- Clear mod items
    self:clear_mod_items()
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
    local pt = self:pt()
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

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

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












mod.debug_sight_clear = function(self)
    local pt = self:pt()
    pt.debug_sight = {0, 0, 0, 0, 0, 0}
end

mod.debug_sight_set = function(self, px, py, pz, rx, ry, rz)
    local pt = self:pt()
    if not pt.debug_sight then
        self:debug_sight_clear()
    end
    pt.debug_sight = {pt.debug_sight[1] + px, pt.debug_sight[2] + py, pt.debug_sight[3] + pz, pt.debug_sight[4] + rx, pt.debug_sight[5] + ry, pt.debug_sight[6] + rz}
    mod:echo(string.format("px: %f, py: %f, pz: %f, rx: %f, ry: %f, rz: %f", pt.debug_sight[1], pt.debug_sight[2], pt.debug_sight[3], pt.debug_sight[4], pt.debug_sight[5], pt.debug_sight[6]))
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

mod.settings = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/utilities/settings")
mod:update_flashlight_templates(mod.settings.flashlight_templates)

mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/master_items")

mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/inventory_weapon_cosmetics_view_definitions")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/player_unit_visual_loadout_extension")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/ui_character_profile_package_loader")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/player_unit_first_person_extension")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/inventory_weapon_cosmetics_view")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/visual_loadout_customization")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/inventory_weapon_marks_view")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/player_unit_fx_extension")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/hud_element_crosshair")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/equipment_component")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/item_icon_loader_ui")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/view_element_grid")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/weapon_icon_ui")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/crafting_view")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/input_service")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/item_package")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/flashlight")

mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/extensions/flashlight_extension")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/extensions/sight_extension")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/extensions/sway_extension")
