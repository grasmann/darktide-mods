local mod = get_mod("visible_equipment")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local get_mod = get_mod
    local managers = Managers
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "visible_equipment"

mod:persistent_table(REFERENCE, {
    cache = mod:get("visible_equipment_entries") or {},
    unit_attachment_names_by_equipment_component = {},
    unit_attachment_ids_by_equipment_component = {},
    attachment_units_by_equipment_component = {},
    item_units_by_equipment_component = {},
    item_names_by_equipment_component = {},
    equipment_by_equipment_component = {},
    equipment_components = {},
    gear_placements = {},
    gear_id_relays = {},
    spawned_units = {},
    cache_files = {},
})

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
    self:info(message)
end

mod.pt = function(self)
    return self:persistent_table(REFERENCE)
end

mod._on_all_mods_loaded = function(self)
    self.loaded_plugins = self:load_plugins()
    managers.event:trigger("visible_equipment_mods_loaded")
end

mod._on_setting_changed = function(self, setting_id)
    managers.event:trigger("visible_equipment_settings_changed")
end

mod._on_unload = function(self, exit_game)
    -- Release packages
    if exit_game then
        -- self:release_packages()
        self:despawn_all_equipment()
    end
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

mod.on_all_mods_loaded = function() mod:_on_all_mods_loaded() end
mod.on_setting_changed = function(setting_id) mod:_on_setting_changed(setting_id) end

-- ##### ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌┌─┐ ################################################################################
-- ##### ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││└─┐ ################################################################################
-- ##### └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘└─┘ ################################################################################

-- ##### Load extensions ##############################################################################################
local base_path = "visible_equipment/scripts/mods/ve/"
local extensions_path = base_path.."extensions/"
mod:io_dofile(extensions_path.."common")
mod:io_dofile(extensions_path.."visible_equipment_extension")

-- ##### Load utilities ###############################################################################################
local utilities_path = base_path.."utilities/"
mod:io_dofile(utilities_path.."game")
mod:io_dofile(utilities_path.."gear")
mod.settings = mod:io_dofile(utilities_path.."settings")
mod.plugins = mod:io_dofile(utilities_path.."plugins")
mod.save_lua = mod:io_dofile(utilities_path.."save")

-- ##### Load extended weapon customization plugin ####################################################################
mod:io_dofile(base_path.."ewc_plugin")

-- ##### ┌─┐┌─┐┌┬┐┌─┐┬ ┬┌─┐┌─┐ ########################################################################################
-- ##### ├─┘├─┤ │ │  ├─┤├┤ └─┐ ########################################################################################
-- ##### ┴  ┴ ┴ ┴ └─┘┴ ┴└─┘└─┘ ########################################################################################
local patches_path = base_path.."patches/"
mod:io_dofile(patches_path.."inventory_cosmetics_view_definitions")
mod:io_dofile(patches_path.."player_unit_visual_loadout_extension")
mod:io_dofile(patches_path.."player_husk_visual_loadout_extension")
mod:io_dofile(patches_path.."inventory_view_content_blueprints")
mod:io_dofile(patches_path.."inventory_view_definitions")
mod:io_dofile(patches_path.."main_menu_background_view")
mod:io_dofile(patches_path.."inventory_background_view")
mod:io_dofile(patches_path.."inventory_cosmetics_view")
mod:io_dofile(patches_path.."action_shoot_projectile")
mod:io_dofile(patches_path.."action_shoot_hit_scan")
mod:io_dofile(patches_path.."action_shoot_pellets")
mod:io_dofile(patches_path.."equipment_component")
mod:io_dofile(patches_path.."ui_profile_spawner")
mod:io_dofile(patches_path.."view_element_grid")
mod:io_dofile(patches_path.."main_menu_view")
mod:io_dofile(patches_path.."inventory_view")
mod:io_dofile(patches_path.."result_view")
mod:io_dofile(patches_path.."portrait_ui")
mod:io_dofile(patches_path.."material_fx")
mod:io_dofile(patches_path.."lobby_view")
mod:io_dofile(patches_path.."ui_manager")
mod:io_dofile(patches_path.."world")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐┌─┐┬─┐┌─┐┬─┐┬ ┬ ##################################################################################
-- #####  │ ├┤ │││├─┘│ │├┬┘├─┤├┬┘└┬┘ ##################################################################################
-- #####  ┴ └─┘┴ ┴┴  └─┘┴└─┴ ┴┴└─ ┴  ##################################################################################
mod:io_dofile(base_path.."smooth_third_person_rotation")
