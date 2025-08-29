local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
	local PlayerCharacterLoopingParticleAliases = mod:original_require("scripts/settings/particles/player_character_looping_particle_aliases")
	local VisualLoadoutCustomization = mod:original_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization")
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
	local special_nodes = {
		muzzle = {
			targets = {"muzzle", "barrel"},
			nodes = {"fx_01", "fx_02", "fx_muzzle", "fx_muzzle_01"}
		}
	}
	local move_units = {
		"#ID[7fb88579bf209537]", -- background
		"#ID[7c763e4de74815e3]", -- lights
	}
	local light_units = {
		"#ID[be13f33921de73ac]", -- lights
	}

	mod.preview_lights = {}
--#endregion

mod:hook(CLASS.InventoryWeaponMarksView, "cb_on_equip_pressed", function(func, self, ...)
	if self._equipped_item then
		local gear_id = mod.gear_settings:gear_id(self._equipped_item)
		mod:persistent_table(REFERENCE).weapon_templates[gear_id] = nil
	end
	-- Original function
	func(self, ...)
end)

mod:hook(CLASS.InventoryWeaponMarksView, "cb_on_grid_entry_left_pressed", function(func, self, widget, element, ...)
	if self._equipped_item then
		local gear_id = mod.gear_settings:gear_id(self._equipped_item)
		mod:persistent_table(REFERENCE).weapon_templates[gear_id] = nil
	end
	-- Original function
	func(self, widget, element, ...)
end)

-- mod:hook(CLASS.InventoryWeaponMarksView, "_preview_item", function(func, self, item, ...)
-- 	if self._equipped_item then
-- 		local gear_id = mod.gear_settings:gear_id(self._equipped_item)
-- 		mod:persistent_table(REFERENCE).weapon_templates[gear_id] = nil
-- 	end
-- 	-- Original function
-- 	func(self, item, ...)
-- end)

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
	local profile = player:profile(peer_id, local_player_id)
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

-- mod:hook(CLASS.PlayerUnitFxExtension, "_register_sound_source", function(func, self, sources, source_name, parent_unit, attachments, node_name, ...)
-- PlayerUnitFxExtension._register_sound_source = function (self, sources, source_name, parent_unit, attachments_by_unit, attachment_name_lookup, optional_node_name)
mod:hook(CLASS.PlayerUnitFxExtension, "_register_sound_source", function(func, self, sources, source_name, parent_unit, attachments_by_unit, attachment_name_lookup, optional_node_name, ...)
	local attachments = attachments_by_unit and attachments_by_unit[parent_unit]
	if attachments and mod.gear_settings:find_node_in_attachments(parent_unit, optional_node_name, attachments) then
		return func(self, sources, source_name, parent_unit, attachments_by_unit, attachment_name_lookup, optional_node_name, ...)
	elseif mod.gear_settings:find_node_in_unit(parent_unit, optional_node_name) then
		return func(self, sources, source_name, parent_unit, nil, attachment_name_lookup, optional_node_name, ...)
	end
	return func(self, sources, source_name, parent_unit, nil, attachment_name_lookup, 1, ...)
end)

-- mod:hook(CLASS.PlayerUnitFxExtension, "sound_source", function(func, self, source_name, optional_attachment_name, ...)
-- 	local sound_source = self._sources[source_name]
-- 	local reference_attachment_name = optional_attachment_name or VisualLoadoutCustomization.ROOT_ATTACH_NAME

-- 	if sound_source then
-- 		sound_source = sound_source[reference_attachment_name]
-- 	elseif source_name then
-- 		self._sources[source_name] = {
-- 			[reference_attachment_name] = self._sources["fx_right_hand"][VisualLoadoutCustomization.ROOT_ATTACH_NAME]
-- 		}
-- 		sound_source = self._sources[source_name][reference_attachment_name]
-- 	end

-- 	return sound_source
-- end)

-- mod:hook(CLASS.PlayerUnitFxExtension, "_register_vfx_spawner", function(func, self, spawners, spawner_name, parent_unit, attachments, node_name, should_add_3p_node, ...)
mod:hook(CLASS.PlayerUnitFxExtension, "_register_vfx_spawner", function(func, self, spawners, spawner_name, parent_unit, attachments_by_unit, attachment_name_lookup, node_name, should_add_3p_node, ...)
	local attachments = attachments_by_unit and attachments_by_unit[parent_unit]
	if attachments and mod.gear_settings:find_node_in_attachments(parent_unit, node_name, attachments) then
		return func(self, spawners, spawner_name, parent_unit, attachments_by_unit, attachment_name_lookup, node_name, should_add_3p_node, ...)
	elseif mod.gear_settings:find_node_in_unit(parent_unit, node_name) then
		return func(self, spawners, spawner_name, parent_unit, nil, attachment_name_lookup, node_name, should_add_3p_node, ...)
	end
	for name, special_node in pairs(special_nodes) do
		if table_contains(special_node.nodes, node_name) then
			for _, target in pairs(special_node.targets) do
				-- local attachment_unit = mod:get_attachment_slot_in_attachments(attachments, target)
				local attachment_unit = mod.gear_settings:attachment_unit(attachments, target)
				
				if attachment_unit then
					return func(self, spawners, spawner_name, parent_unit, nil, attachment_name_lookup, 1, should_add_3p_node, ...)
				end
			end
		end
	end

	return func(self, spawners, spawner_name, parent_unit, nil, attachment_name_lookup, 1, should_add_3p_node, ...)
end)

-- ##### ┬ ┬┬  ┬ ┬┌─┐┬─┐┬  ┌┬┐ ########################################################################################
-- ##### │ ││  ││││ │├┬┘│   ││ ########################################################################################
-- ##### └─┘┴  └┴┘└─┘┴└─┴─┘─┴┘ ########################################################################################

mod:hook(CLASS.UIWorldSpawner, "spawn_level", function(func, self, level_name, included_object_sets, position, rotation, ignore_level_background, ...)
	func(self, level_name, included_object_sets, position, rotation, ignore_level_background, ...)
	-- if string_find(self._world_name, "ViewElementInventoryWeaponPreview") then
	if mod:cached_find(self._world_name, "ViewElementInventoryWeaponPreview") then
		local level_units = level_units(self._level, true)
		-- local unknown_units = {}
		if level_units then
			-- mod.preview_lights = {}
			table.clear(mod.preview_lights)
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