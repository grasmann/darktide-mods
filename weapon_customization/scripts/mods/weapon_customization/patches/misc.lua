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
    local NetworkLookup = NetworkLookup
    local table_contains = table.contains
    local unit_debug_name = Unit.debug_name
    local unit_local_position = Unit.local_position
    local unit_set_local_position = Unit.set_local_position
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"

-- ##### ┬─┐┌─┐┌┬┐┌─┐┌┬┐┌─┐  ┌─┐┬ ┬┌─┐┬─┐┌─┐┌─┐┌┬┐┌─┐┬─┐ ##############################################################
-- ##### ├┬┘│ │ │ ├─┤ │ ├┤   │  ├─┤├─┤├┬┘├─┤│   │ ├┤ ├┬┘ ##############################################################
-- ##### ┴└─└─┘ ┴ ┴ ┴ ┴ └─┘  └─┘┴ ┴┴ ┴┴└─┴ ┴└─┘ ┴ └─┘┴└─ ##############################################################

mod:hook(CLASS.MissionIntroView, "init", function(func, self, settings, context, ...)
    -- Pass input
    self._pass_input = true
    -- Original function
    func(self, settings, context, ...)
end)

-- ##### ┌─┐┬─┐┌─┐┌─┐┬ ┬  ┌─┐┬─┐ ┬ ####################################################################################
-- ##### │  ├┬┘├─┤└─┐├─┤  ├┤ │┌┴┬┘ ####################################################################################
-- ##### └─┘┴└─┴ ┴└─┘┴ ┴  └  ┴┴ └─ ####################################################################################

mod:hook(CLASS.PlayerHuskVisualLoadoutExtension, "rpc_player_equip_item_from_profile_to_slot", function(func, self, channel_id, go_id, slot_id, item_id, ...)
	local slot_name = NetworkLookup.player_inventory_slot_names[slot_id]
	local player = self._player
	local peer_id = player:peer_id()
	local local_player_id = player:local_player_id()
	local package_synchronizer_client = self._package_synchronizer_client
	local profile = package_synchronizer_client:cached_profile(peer_id, local_player_id)
	local visual_loadout = profile.visual_loadout
	local item = visual_loadout[slot_name]
	local optional_existing_unit_3p = nil
	self:_equip_item_to_slot(slot_name, item, optional_existing_unit_3p)
end)

-- ##### ┌─┐┬─┐┌─┐┌─┐┬ ┬  ┌─┐┬─┐ ┬ ####################################################################################
-- ##### │  ├┬┘├─┤└─┐├─┤  ├┤ │┌┴┬┘ ####################################################################################
-- ##### └─┘┴└─┴ ┴└─┘┴ ┴  └  ┴┴ └─ ####################################################################################

mod:hook(CLASS.ExtensionManager, "unregister_unit", function(func, self, unit, ...)
    if unit and unit_alive(unit) then
        func(self, unit, ...)
    end
end)

-- ##### ┌─┐─┐ ┬  ┌─┐┌─┐┬ ┬┬─┐┌─┐┌─┐┌─┐ ###############################################################################
-- ##### ├┤ ┌┴┬┘  └─┐│ ││ │├┬┘│  ├┤ └─┐ ###############################################################################
-- ##### └  ┴ └─  └─┘└─┘└─┘┴└─└─┘└─┘└─┘ ###############################################################################

mod:hook(CLASS.PlayerUnitFxExtension, "_register_sound_source", function(func, self, sources, source_name, parent_unit, attachments, node_name, ...)
    if attachments and mod:find_node_in_attachments(parent_unit, node_name, attachments) then
        return func(self, sources, source_name, parent_unit, attachments, node_name, ...)
    end
    return func(self, sources, source_name, parent_unit, nil, 1, ...)
end)

mod:hook(CLASS.PlayerUnitFxExtension, "_register_vfx_spawner", function(func, self, spawners, spawner_name, parent_unit, attachments, node_name, should_add_3p_node, ...)
    if attachments and mod:find_node_in_attachments(parent_unit, node_name, attachments) then
        return func(self, spawners, spawner_name, parent_unit, attachments, node_name, should_add_3p_node, ...)
    end
    return func(self, spawners, spawner_name, parent_unit, nil, 1, should_add_3p_node, ...)
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