local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local TextUtilities = mod:original_require("scripts/utilities/ui/text")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local table = table
    local Color = Color
    local get_mod = get_mod
    local managers = Managers
    local table_clear = table.clear
    local table_clone = table.clone
    local table_clone_instance = table.clone_instance
    local table_create_copy_instance = table.create_copy_instance
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "extended_weapon_customization"
local base_path = "extended_weapon_customization/scripts/mods/ewc/"
local extensions_path = base_path.."extensions/"
local utilities_path = base_path.."utilities/"
local patches_path = base_path.."patches/"

mod:persistent_table(REFERENCE, {
    items_originating_from_customization_menu = {},
    gear_files = mod:get("gear_files") or {},
    debug_sight = {0, 0, 0, 0, 0, 0},
    exclude_from_vfx_spawner = {},
    gear_material_overrides = {},
    attachment_data_origin = {},
    attachment_slot_origin = {},
    gear_id_to_offer_id = {},
    game_initialized = false,
    resource_packages = {},
    loading_packages = {},
    kitbash_entries = {},
    weapon_packages = {},
    loaded_packages = {},
    loaded_plugins = {},
    gear_id_relays = {},
    gear_settings = {},
    spawned_units = {},
    cached_items = {},
    husk_items = {},
    items = {},
})

mod:io_dofile(extensions_path.."common")

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.pt = function(self)
    return self:persistent_table(REFERENCE)
end

local pt = mod:pt()

mod.check_visual_loadout_customization_community_patch = function(self)
    local vlcp = get_mod("visual_loadout_customization_community_patch")
    self.vlcp_missing = not vlcp
    if self.vlcp_missing then
        self:echo(TextUtilities.apply_color_to_text("Extended Weapon Customization:\nDependency Visual Loadout Customization Community Patch is missing!", Color.ui_red_light(255, true)))
    end
end

mod.master_item_community_patch = function(self)
    local micp = get_mod("master_item_community_patch")
    self.micp_missing = not micp
    if self.micp_missing then
        self:echo(TextUtilities.apply_color_to_text("Extended Weapon Customization:\nDependency Master Item Community Patch is missing!", Color.ui_red_light(255, true)))
    end
end

mod.init = function(self)
    -- Clear mod items
    self:clear_mod_items()
    self:clear_all_alternate_fire_overrides()
    -- Load plugins
    self.loaded_plugins = self:load_plugins()
    -- If game already initialized ( mod reload )
    if pt.game_initialized then
        self:try_kitbash_load()
        self:find_missing_entries()
    end
    -- Load packages
    self:load_packages()
end

mod._on_all_mods_loaded = function(self)
    -- Init
    self:init()
    -- Trigger reload
    managers.event:trigger("ewc_reloaded")
end

mod._on_setting_changed = function(self, setting_id)
    -- Trigger settings changed event
    managers.event:trigger("ewc_settings_changed")
end

mod._clear_chat = function(self)
    -- Trigger clear notifications
	managers.event:trigger("event_clear_notifications")
end

mod._on_game_state_changed = function(self, status, state_name)
    -- Set game initialized
    if state_name == "StateTitle" and status == "exit" then
        pt.game_initialized = true
    end
    -- Clear data
    table_clear(pt.exclude_from_vfx_spawner)
    table_clear(pt.items_originating_from_customization_menu)
end

mod._on_unload = function(self, exit_game)
    -- Release packages
    if exit_game then
        self:release_packages()
    end
end

mod._update = function(self, dt)
    -- Update cutscene
    self:update_cutscene()
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

mod.update =                function(dt) mod:_update(dt) end
mod.on_all_mods_loaded =    function() mod:_on_all_mods_loaded() end
mod.on_setting_changed =    function(setting_id) mod:_on_setting_changed(setting_id) end
mod.on_unload =             function(exit_game) mod:_on_unload(exit_game) end
mod.clear_chat =            function() mod:_clear_chat() end
mod.on_game_state_changed = function(status, state_name) mod:_on_game_state_changed(status, state_name) end

-- ##### ┬ ┬┌┬┐┬┬  ┬┌┬┐┬┌─┐┌─┐ ########################################################################################
-- ##### │ │ │ ││  │ │ │├┤ └─┐ ########################################################################################
-- ##### └─┘ ┴ ┴┴─┘┴ ┴ ┴└─┘└─┘ ########################################################################################

-- Load utilities
mod:io_dofile(utilities_path.."gear_settings")
mod:io_dofile(utilities_path.."damage_types")
mod:io_dofile(utilities_path.."packages")
mod:io_dofile(utilities_path.."plugins")
mod:io_dofile(utilities_path.."kitbash")
mod:io_dofile(utilities_path.."cache")
mod:io_dofile(utilities_path.."items")
mod:io_dofile(utilities_path.."fixes")
mod:io_dofile(utilities_path.."debug")
mod:io_dofile(utilities_path.."game")
-- Load save lua
mod.save_lua = mod:io_dofile(utilities_path.."save")
-- Load settings
mod.settings = mod:io_dofile(utilities_path.."settings")
-- Clone settings of main mod as a plugin
pt.extended_weapon_customization_plugin = table_clone_instance(mod.settings)
-- Update flashlight templates
mod:update_flashlight_templates(mod.settings.flashlight_templates)

-- ##### ┌─┐┌─┐┌┬┐┌─┐┬ ┬┌─┐┌─┐ ########################################################################################
-- ##### ├─┘├─┤ │ │  ├─┤├┤ └─┐ ########################################################################################
-- ##### ┴  ┴ ┴ ┴ └─┘┴ ┴└─┘└─┘ ########################################################################################

-- Load patches
mod:io_dofile(patches_path.."inventory_weapon_cosmetics_view_definitions")
mod:io_dofile(patches_path.."player_unit_visual_loadout_extension")
mod:io_dofile(patches_path.."player_husk_visual_loadout_extension")
mod:io_dofile(patches_path.."ui_character_profile_package_loader")
mod:io_dofile(patches_path.."player_unit_first_person_extension")
mod:io_dofile(patches_path.."player_husk_first_person_extension")
mod:io_dofile(patches_path.."view_element_tab_menu_definitions")
mod:io_dofile(patches_path.."inventory_weapon_cosmetics_view")
mod:io_dofile(patches_path.."visual_loadout_customization")
mod:io_dofile(patches_path.."inventory_weapon_marks_view")
mod:io_dofile(patches_path.."mispredict_package_handler")
mod:io_dofile(patches_path.."player_unit_fx_extension")
mod:io_dofile(patches_path.."view_element_tab_menu")
mod:io_dofile(patches_path.."hud_element_crosshair")
mod:io_dofile(patches_path.."attack_report_manager")
mod:io_dofile(patches_path.."interactee_extension")
mod:io_dofile(patches_path.."equipment_component")
mod:io_dofile(patches_path.."item_icon_loader_ui")
mod:io_dofile(patches_path.."item_pass_templates")
mod:io_dofile(patches_path.."ui_profile_spawner")
mod:io_dofile(patches_path.."mission_intro_view")
mod:io_dofile(patches_path.."view_element_grid")
mod:io_dofile(patches_path.."ui_weapon_spawner")
mod:io_dofile(patches_path.."end_player_view")
mod:io_dofile(patches_path.."package_manager")
mod:io_dofile(patches_path.."weapon_icon_ui")
mod:io_dofile(patches_path.."alternate_fire")
mod:io_dofile(patches_path.."camera_manager")
mod:io_dofile(patches_path.."minion_gibbing")
mod:io_dofile(patches_path.."crafting_view")
mod:io_dofile(patches_path.."input_service")
mod:io_dofile(patches_path.."store_service")
mod:io_dofile(patches_path.."gear_service")
mod:io_dofile(patches_path.."action_sweep")
mod:io_dofile(patches_path.."action_shoot")
mod:io_dofile(patches_path.."item_package")
mod:io_dofile(patches_path.."master_items")
mod:io_dofile(patches_path.."flashlight")
mod:io_dofile(patches_path.."lobby_view")

-- ##### ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌┌─┐ ################################################################################
-- ##### ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││└─┐ ################################################################################
-- ##### └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘└─┘ ################################################################################

-- Load extensions
mod:io_dofile(extensions_path.."attachment_callback_extension")
mod:io_dofile(extensions_path.."damage_type_extension")
mod:io_dofile(extensions_path.."flashlight_extension")
mod:io_dofile(extensions_path.."shield_extension")
mod:io_dofile(extensions_path.."sight_extension")
mod:io_dofile(extensions_path.."sway_extension")
