local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local table = table
    local table_contains = table.contains
    local Unit = Unit
    local unit_debug_name = Unit.debug_name
    local unit_alive = Unit.alive
    local unit_set_local_position = Unit.set_local_position
    local unit_local_position = Unit.local_position
    local string = string
    local string_find = string.find
    local vector3 = Vector3
    local vector3_box = Vector3Box
    local pairs = pairs
    local CLASS = CLASS
    local Level = Level
    local level_units = Level.units
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"

-- ##### ┌─┐─┐ ┬  ┌─┐┌─┐┬ ┬┬─┐┌─┐┌─┐┌─┐ ###############################################################################
-- ##### ├┤ ┌┴┬┘  └─┐│ ││ │├┬┘│  ├┤ └─┐ ###############################################################################
-- ##### └  ┴ └─  └─┘└─┘└─┘┴└─└─┘└─┘└─┘ ###############################################################################

mod:hook(CLASS.PlayerUnitFxExtension, "_register_sound_source", function(func, self, sources, source_name, parent_unit, attachments, node_name, ...)
    local _attachments = nil
    if attachments and mod:find_node_in_attachments(parent_unit, node_name, attachments) then
        _attachments = attachments
    end
    return func(self, sources, source_name, parent_unit, _attachments, node_name, ...)
end)

mod:hook(CLASS.PlayerUnitFxExtension, "_register_vfx_spawner", function(func, self, spawners, spawner_name, parent_unit, attachments, node_name, should_add_3p_node, ...)
    local _attachments = nil
    if attachments and mod:find_node_in_attachments(parent_unit, node_name, attachments) then
        _attachments = attachments
    end
    return func(self, spawners, spawner_name, parent_unit, _attachments, node_name, should_add_3p_node, ...)
end)

-- ##### ┬ ┬┬  ┬ ┬┌─┐┬─┐┬  ┌┬┐ ########################################################################################
-- ##### │ ││  ││││ │├┬┘│   ││ ########################################################################################
-- ##### └─┘┴  └┴┘└─┘┴└─┴─┘─┴┘ ########################################################################################

mod:hook(CLASS.UIWorldSpawner, "spawn_level", function(func, self, level_name, included_object_sets, position, rotation, ignore_level_background, ...)
    func(self, level_name, included_object_sets, position, rotation, ignore_level_background, ...)
    if string_find(self._world_name, "ViewElementInventoryWeaponPreview") then
        local level_units = level_units(self._level, true)
        local unknown_units = {}
        if level_units then
            local move_units = {
                "#ID[7fb88579bf209537]", -- background
                "#ID[7c763e4de74815e3]", -- lights
            }
            local light_units = {
                "#ID[be13f33921de73ac]", -- lights
            }

            mod.preview_lights = {}

            for _, unit in pairs(level_units) do
                if table_contains(move_units, unit_debug_name(unit)) then
                    unit_set_local_position(unit, 1, unit_local_position(unit, 1) + vector3(0, 6, 0))
                end
                if table_contains(light_units, unit_debug_name(unit)) then
                    mod.preview_lights[#mod.preview_lights+1] = {
                        unit = unit,
                        position = vector3_box(unit_local_position(unit, 1)),
                    }
                end
            end
        end
    end
end)

-- ##### ┌─┐┬─┐┌─┐┌─┐┬ ┬  ┌─┐┬─┐ ┬ ####################################################################################
-- ##### │  ├┬┘├─┤└─┐├─┤  ├┤ │┌┴┬┘ ####################################################################################
-- ##### └─┘┴└─┴ ┴└─┘┴ ┴  └  ┴┴ └─ ####################################################################################

mod:hook(CLASS.ExtensionManager, "unregister_unit", function(func, self, unit, ...)
    if unit and unit_alive(unit) then
        func(self, unit, ...)
    end
end)