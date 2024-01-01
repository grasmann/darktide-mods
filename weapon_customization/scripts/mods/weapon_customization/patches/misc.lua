local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local PlayerCharacterLoopingParticleAliases = mod:original_require("scripts/settings/particles/player_character_looping_particle_aliases")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local Unit = Unit
    local table = table
    local pairs = pairs
    local CLASS = CLASS
    local Level = Level
    local string = string
    local vector3 = Vector3
    local unit_alive = Unit.alive
    local vector3_box = Vector3Box
    local string_find = string.find
    local level_units = Level.units
    local table_contains = table.contains
    local unit_debug_name = Unit.debug_name
    local unit_local_position = Unit.local_position
    local unit_set_local_position = Unit.set_local_position
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"

-- ##### ┌─┐─┐ ┬  ┌─┐┌─┐┬ ┬┬─┐┌─┐┌─┐┌─┐ ###############################################################################
-- ##### ├┤ ┌┴┬┘  └─┐│ ││ │├┬┘│  ├┤ └─┐ ###############################################################################
-- ##### └  ┴ └─  └─┘└─┘└─┘┴└─└─┘└─┘└─┘ ###############################################################################

-- local tostring = tostring

-- mod:hook(CLASS.World, "find_particles_variable", function(func, world, particle_name, variable_name, ...)
--     local variable_id = func(world, particle_name, variable_name, ...)
--     mod:echot("particle_name: "..tostring(particle_name).." variable_name: "..tostring(variable_name))
--     return variable_id
-- end)

-- mod:hook(CLASS.World, "set_particles_variable", function(func, world, variable_id, value, ...)
--     local res = func(world, variable_id, value, ...)
--     mod:echot("variable_id: "..tostring(variable_id).." value: "..tostring(value))
--     return res
-- end)

-- mod:hook(CLASS.World, "set_particles_material_vector3", function(func, world, effect_id, material_name, variable_name, vector_value, ...)
--     local res = func(world, effect_id, material_name, variable_name, vector_value, ...)
--     mod:echot("material: "..tostring(material_name).." variable: "..tostring(variable_name).." value: "..tostring(vector_value))
--     return res
-- end)

-- mod:hook(CLASS.World, "set_particles_material_color", function(func, world, effect_id, material_name, value, ...)
--     local res = func(world, effect_id, material_name, value, ...)
--     mod:echot("effect_id: "..tostring(effect_id).." material: "..tostring(material_name).." value: "..tostring(value))
--     return res
-- end)

-- mod:hook(CLASS.PlayerUnitFxExtension, "_update_looping_particle_variables", function(func, self, dt, t, ...)
--     func(self, dt, t, ...)
--     local looping_particle_variables_context = self._looping_particles_variables_context
--     for alias, data in pairs(self._looping_particles) do
--         local particle_config = PlayerCharacterLoopingParticleAliases[alias]
--         local variables = particle_config.variables
--         local id = data.id
--         if variables and id then
--             local num_variables = #variables
--             for i = 1, num_variables do
--                 local variable_config = variables[i]
--                 local variable_name = variable_config.variable_name
--                 local variable_type = variable_config.variable_type
--                 mod:echot("name: "..tostring(variable_name).." type: "..tostring(variable_type))
--             end
--         end
--     end
-- end)

mod:hook(CLASS.PlayerUnitFxExtension, "_register_sound_source", function(func, self, sources, source_name, parent_unit, attachments, node_name, ...)
    if attachments and mod:find_node_in_attachments(parent_unit, node_name, attachments) then
        return func(self, sources, source_name, parent_unit, attachments, node_name, ...)
    end
    return func(self, sources, source_name, parent_unit, attachments, "root", ...)
end)

mod:hook(CLASS.PlayerUnitFxExtension, "_register_vfx_spawner", function(func, self, spawners, spawner_name, parent_unit, attachments, node_name, should_add_3p_node, ...)
    if attachments and mod:find_node_in_attachments(parent_unit, node_name, attachments) then
        return func(self, spawners, spawner_name, parent_unit, attachments, node_name, should_add_3p_node, ...)
    end
    return func(self, spawners, spawner_name, parent_unit, attachments, "root", should_add_3p_node, ...)
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