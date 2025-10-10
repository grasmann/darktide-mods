local mod = get_mod("visible_equipment")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local managers = Managers
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "visible_equipment"

mod:persistent_table(REFERENCE, {
    equipment_components = {},
    equipment_by_equipment_component = {},
    item_units_by_equipment_component = {},
    attachment_units_by_equipment_component = {},
    unit_attachment_ids_by_equipment_component = {},
    unit_attachment_names_by_equipment_component = {},
    item_names_by_equipment_component = {},
    spawned_units = {},
    gear_placements = {},
    cache = mod:get("visible_equipment_entries") or {},
    cache_files = {},
    cutscene_playing = false,
})

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

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

-- Load extensions
mod:io_dofile("visible_equipment/scripts/mods/ve/extensions/common")
mod:io_dofile("visible_equipment/scripts/mods/ve/extensions/visible_equipment_extension")

-- Load utilities
mod:io_dofile("visible_equipment/scripts/mods/ve/utilities/game")
mod:io_dofile("visible_equipment/scripts/mods/ve/utilities/gear")
mod.settings = mod:io_dofile("visible_equipment/scripts/mods/ve/utilities/settings")
mod.plugins = mod:io_dofile("visible_equipment/scripts/mods/ve/utilities/plugins")
mod.save_lua = mod:io_dofile("visible_equipment/scripts/mods/ve/utilities/save")

-- Load extended weapon customization plugin
mod:io_dofile("visible_equipment/scripts/mods/ve/ewc_plugin")

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

mod.on_all_mods_loaded = function()
    mod:_on_all_mods_loaded()
end

mod.on_setting_changed = function(setting_id)
    mod:_on_setting_changed(setting_id)
end

-- ##### ┌─┐┌─┐┌┬┐┌─┐┬ ┬┌─┐┌─┐ ########################################################################################
-- ##### ├─┘├─┤ │ │  ├─┤├┤ └─┐ ########################################################################################
-- ##### ┴  ┴ ┴ ┴ └─┘┴ ┴└─┘└─┘ ########################################################################################

mod:io_dofile("visible_equipment/scripts/mods/ve/patches/inventory_cosmetics_view_definitions")
mod:io_dofile("visible_equipment/scripts/mods/ve/patches/player_unit_visual_loadout_extension")
mod:io_dofile("visible_equipment/scripts/mods/ve/patches/player_husk_visual_loadout_extension")
mod:io_dofile("visible_equipment/scripts/mods/ve/patches/inventory_view_content_blueprints")
mod:io_dofile("visible_equipment/scripts/mods/ve/patches/inventory_view_definitions")
mod:io_dofile("visible_equipment/scripts/mods/ve/patches/main_menu_background_view")
mod:io_dofile("visible_equipment/scripts/mods/ve/patches/inventory_background_view")
mod:io_dofile("visible_equipment/scripts/mods/ve/patches/inventory_cosmetics_view")
mod:io_dofile("visible_equipment/scripts/mods/ve/patches/action_shoot_projectile")
mod:io_dofile("visible_equipment/scripts/mods/ve/patches/action_shoot_hit_scan")
mod:io_dofile("visible_equipment/scripts/mods/ve/patches/action_shoot_pellets")
mod:io_dofile("visible_equipment/scripts/mods/ve/patches/equipment_component")
mod:io_dofile("visible_equipment/scripts/mods/ve/patches/ui_profile_spawner")
mod:io_dofile("visible_equipment/scripts/mods/ve/patches/view_element_grid")
mod:io_dofile("visible_equipment/scripts/mods/ve/patches/main_menu_view")
mod:io_dofile("visible_equipment/scripts/mods/ve/patches/inventory_view")
mod:io_dofile("visible_equipment/scripts/mods/ve/patches/cutscene_view")
mod:io_dofile("visible_equipment/scripts/mods/ve/patches/result_view")
mod:io_dofile("visible_equipment/scripts/mods/ve/patches/portrait_ui")
mod:io_dofile("visible_equipment/scripts/mods/ve/patches/material_fx")
mod:io_dofile("visible_equipment/scripts/mods/ve/patches/lobby_view")
mod:io_dofile("visible_equipment/scripts/mods/ve/patches/ui_manager")
mod:io_dofile("visible_equipment/scripts/mods/ve/patches/world")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐┌─┐┬─┐┌─┐┬─┐┬ ┬ ##################################################################################
-- #####  │ ├┤ │││├─┘│ │├┬┘├─┤├┬┘└┬┘ ##################################################################################
-- #####  ┴ └─┘┴ ┴┴  └─┘┴└─┴ ┴┴└─ ┴  ##################################################################################

mod:io_dofile("visible_equipment/scripts/mods/ve/smooth_third_person_rotation")
