local mod = get_mod("visible_equipment")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local table = table
    local managers = Managers
    local unit_alive = unit.alive
    local unit_get_data = unit.get_data
    local table_contains = table.contains
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

mod.settings = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/utilities/settings")
mod.plugins = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/utilities/plugins")
mod.save_lua = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/utilities/save")
mod.next_ui_profile_spawner_placement_name = {}
mod.next_ui_profile_spawner_placement_slot = {}

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

mod.get_view = function(self, view_name)
    local ui_manager = managers.ui
    return ui_manager:view_active(view_name) and ui_manager:view_instance(view_name) or nil
end

mod.get_cosmetic_view = function(self)
	return self:get_view("inventory_cosmetics_view")
end

mod.vector3_equal = function(self, v1, v2)
	return v1[1] == v2[1] and v1[2] == v2[2] and v1[3] == v2[3]
end

mod.is_in_hub = function(self)
    local game_mode_manager = managers.state.game_mode
	local game_mode_name = game_mode_manager and game_mode_manager:game_mode_name()
	return game_mode_name == "hub"
end

mod.me = function(self)
    -- Get player
    local player = managers.player and managers.player:local_player_safe(1)
    -- Return player unit
    return player and player.player_unit
end

mod.equipment_component_from_unit = function(self, unit)
    if unit and unit_alive(unit) then
        return unit_get_data(unit, "visible_equipment_component")
    end
end

mod.gear_placement = function(self, gear_id, placement, file, no_default)
    local pt = self:pt()
    if placement then
        pt.gear_placements[gear_id] = pt.gear_placements[gear_id] or {}
        local data = pt.gear_placements[gear_id]

        if file then
            mod.save_lua:save_entry(gear_id, data)
        end

        data.placement = placement
    else
        local data = pt.gear_placements[gear_id]

        if (not data or file) and table_contains(pt.cache, gear_id..".lua") then
            pt.gear_placements[gear_id] = mod.save_lua:load_entry(gear_id)
            data = pt.gear_placements[gear_id]
        end

        return (data and data.placement) or (not no_default and "default")
    end
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

mod.on_all_mods_loaded = function()
    mod:load_plugins()
end

mod.on_setting_changed = function(setting_id)
    managers.event:trigger("visible_equipment_settings_changed")
end

-- ##### ┌─┐┌─┐┌┬┐┌─┐┬ ┬┌─┐┌─┐ ########################################################################################
-- ##### ├─┘├─┤ │ │  ├─┤├┤ └─┐ ########################################################################################
-- ##### ┴  ┴ ┴ ┴ └─┘┴ ┴└─┘└─┘ ########################################################################################

mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/utilities/save")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/extensions/common")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/main_menu_view")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/main_menu_background_view")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/result_view")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/lobby_view")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/ui_manager")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/view_element_grid")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/inventory_view_content_blueprints")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/inventory_view_definitions")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/inventory_background_view")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/inventory_view")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/portrait_ui")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/inventory_cosmetics_view")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/player_unit_visual_loadout_extension")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/player_husk_visual_loadout_extension")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/world")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/ui_profile_spawner")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/equipment_component")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/material_fx")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/action_shoot_hit_scan")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/action_shoot_pellets")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/action_shoot_projectile")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/extensions/visible_equipment_extension")
