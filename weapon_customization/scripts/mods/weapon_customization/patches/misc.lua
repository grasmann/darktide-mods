local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
	local PlayerCharacterLoopingParticleAliases = mod:original_require("scripts/settings/particles/player_character_looping_particle_aliases")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
	local Unit = Unit
	local table = table
	local World = World
	local pairs = pairs
	local CLASS = CLASS
	local Level = Level
	local string = string
	local vector3 = Vector3
	local tostring = tostring
	local unit_alive = Unit.alive
	local vector3_box = Vector3Box
	local string_find = string.find
	local level_units = Level.units
	local vector3_zero = vector3.zero
	local unit_has_data = Unit.has_data
	local NetworkLookup = NetworkLookup
	local table_contains = table.contains
	local unit_debug_name = Unit.debug_name
	local unit_local_position = Unit.local_position
	local unit_set_local_position = Unit.set_local_position
	local world_update_out_of_bounds_checker = World.update_out_of_bounds_checker
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local REFERENCE = "weapon_customization"
--#endregion

-- ##### ┬─┐┌─┐┌┬┐┌─┐┌┬┐┌─┐  ┌─┐┬ ┬┌─┐┬─┐┌─┐┌─┐┌┬┐┌─┐┬─┐ ##############################################################
-- ##### ├┬┘│ │ │ ├─┤ │ ├┤   │  ├─┤├─┤├┬┘├─┤│   │ ├┤ ├┬┘ ##############################################################
-- ##### ┴└─└─┘ ┴ ┴ ┴ ┴ └─┘  └─┘┴ ┴┴ ┴┴└─┴ ┴└─┘ ┴ └─┘┴└─ ##############################################################

mod:hook(CLASS.MissionIntroView, "init", function(func, self, settings, context, ...)
	-- Pass input
	self._pass_input = true
	-- Original function
	func(self, settings, context, ...)
end)

mod:hook(CLASS.OutOfBoundsManager, "pre_update", function(func, self, shared_state, ...)
	local hard_cap_out_of_bounds_units = shared_state.hard_cap_out_of_bounds_units
	local soft_cap_out_of_bounds_units = shared_state.soft_cap_out_of_bounds_units
	local world = shared_state.world

	table.clear(soft_cap_out_of_bounds_units)
	table.clear(hard_cap_out_of_bounds_units)

	-- local num_hard_cap_units, _ = 
	world_update_out_of_bounds_checker(world, hard_cap_out_of_bounds_units, soft_cap_out_of_bounds_units)
	for _, unit in pairs(hard_cap_out_of_bounds_units) do
		local u = tostring(unit)
		if u == "#ID[e90c4e5ba603c2af]" or u == "#ID[465f4895f3dc98d1]" then
			unit_set_local_position(unit, 1, vector3_zero())
		end
	end
	-- local local_hard_cap_out_of_bounds_units = self._local_hard_cap_out_of_bounds_units
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
	elseif mod:find_node_in_unit(parent_unit, node_name) then
		return func(self, sources, source_name, parent_unit, nil, node_name, ...)
	end
	return func(self, sources, source_name, parent_unit, nil, 1, ...)
end)

mod:hook(CLASS.PlayerUnitFxExtension, "_register_vfx_spawner", function(func, self, spawners, spawner_name, parent_unit, attachments, node_name, should_add_3p_node, ...)
	if attachments and mod:find_node_in_attachments(parent_unit, node_name, attachments) then
		return func(self, spawners, spawner_name, parent_unit, attachments, node_name, should_add_3p_node, ...)
	elseif mod:find_node_in_unit(parent_unit, node_name) then
		return func(self, spawners, spawner_name, parent_unit, nil, node_name, should_add_3p_node, ...)
	end

	local special_nodes = {
		muzzle = {
			targets = {"muzzle", "barrel"},
			nodes = {"fx_01", "fx_02", "fx_muzzle", "fx_muzzle_01"}
		}
	}
	for name, special_node in pairs(special_nodes) do
		if table_contains(special_node.nodes, node_name) then
			for _, target in pairs(special_node.targets) do
				local attachment_unit = mod:get_attachment_slot_in_attachments(attachments, target)
				if attachment_unit then
					return func(self, spawners, spawner_name, attachment_unit, nil, 1, should_add_3p_node, ...)
				end
			end
		end
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
					-- mod:info("CLASS.UIWorldSpawner: "..tostring(unit))
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