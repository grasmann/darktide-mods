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
local COSMETIC_VIEW = "inventory_cosmetics_view"

mod:persistent_table(REFERENCE, {
    equipment_components = {},
    equipment_by_equipment_component = {},
    item_units_by_equipment_component = {},
    attachment_units_by_equipment_component = {},
    unit_attachment_ids_by_equipment_component = {},
    unit_attachment_names_by_equipment_component = {},
    item_names_by_equipment_component = {},
    spawned_units = {},
})

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.pt = function(self)
    return self:persistent_table(REFERENCE)
end

mod.main_time = function(self)
	return managers.time:time("main")
end

mod.game_time = function(self)
	return managers.time:time("gameplay")
end

mod.get_view = function(self, view_name)
    return managers.ui:view_active(view_name) and managers.ui:view_instance(view_name) or nil
end

mod.get_cosmetic_view = function(self)
	return self:get_view(COSMETIC_VIEW)
end

mod.vector3_equal = function(self, v1, v2)
	return v1[1] == v2[1] and v1[2] == v2[2] and v1[3] == v2[3]
end

mod.is_in_hub = function(self)
    local manager = managers.state.game_mode
	local game_mode_name = manager and manager:game_mode_name()
	return game_mode_name == "hub"
end

-- ##### ┌─┐┌─┐┌┬┐┌─┐┬ ┬┌─┐┌─┐ ########################################################################################
-- ##### ├─┘├─┤ │ │  ├─┤├┤ └─┐ ########################################################################################
-- ##### ┴  ┴ ┴ ┴ └─┘┴ ┴└─┘└─┘ ########################################################################################

mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/inventory_cosmetics_view")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/player_unit_visual_loadout_extension")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/player_husk_visual_loadout_extension")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/world")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/ui_profile_spawner")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/equipment_component")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/patches/material_fx")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/extensions/common")
mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/extensions/visible_equipment_extension")
