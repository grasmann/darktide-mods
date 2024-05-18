local mod = get_mod("weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
	local Mesh = Mesh
	local Unit = Unit
	local type = type
	local pairs = pairs
	local vector3 = Vector3
	local string = string
	local vector2 = Vector2
	local unit_mesh = Unit.mesh
	local managers = Managers
	local unit_alive = Unit.alive
	local Quaternion = Quaternion
	local vector3_box = Vector3Box
	local vector3_zero = vector3.zero
	local vector3_lerp = vector3.lerp
	local string_gsub = string.gsub
	local unit_get_data = Unit.get_data
	local quaternion_box = QuaternionBox
	local unit_num_meshes = Unit.num_meshes
	local unit_debug_name = Unit.debug_name
	local unit_world_pose = Unit.world_pose
	local unit_local_pose = Unit.local_pose
	local vector3_unbox = vector3_box.unbox
	local quaternion_forward = Quaternion.forward
	local quaternion_unbox = quaternion_box.unbox
	local wwise_wwise_world = Wwise.wwise_world
	local unit_local_position = Unit.local_position
	local unit_local_rotation = Unit.local_rotation
	local mesh_local_rotation = Mesh.local_rotation
	local unit_set_local_pose = Unit.set_local_pose
	local unit_world_position = Unit.world_position
	local unit_world_rotation = Unit.world_rotation
	local quaternion_multiply = Quaternion.multiply
	local unit_set_local_scale = Unit.set_local_scale
	local unit_get_child_units = Unit.get_child_units
	local quaternion_matrix_4x4 = Quaternion.matrix4x4
	local world_physics_world = World.physics_world
	local quaternion_axis_angle = Quaternion.axis_angle
	local unit_set_local_position = Unit.set_local_position
	local unit_set_local_rotation = Unit.set_local_rotation
	local mesh_set_local_position = Mesh.set_local_position
	local mesh_set_local_rotation = Mesh.set_local_rotation
	local unit_set_mesh_visibility = Unit.set_mesh_visibility
	local unit_set_unit_visibility = Unit.set_unit_visibility
	local quaternion_from_euler_angles_xyz = Quaternion.from_euler_angles_xyz
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local REFERENCE = "weapon_customization"
	local COSMETIC_VIEW = "inventory_cosmetics_view"
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.world = function(self)
    return managers.world:world("level_world")
end

mod.vector3_equal = function(self, v1, v2)
	return v1[1] == v2[1] and v1[2] == v2[2] and v1[3] == v2[3]
end

mod.physics_world = function(self, world)
	local world = world or self:world()
    return world_physics_world(world)
end

mod.wwise_world = function(self, world)
	local world = world or self:world()
	return wwise_wwise_world(world)
end

mod.get_view = function(self, view_name)
    return managers.ui:view_active(view_name) and managers.ui:view_instance(view_name) or nil
end

mod.get_cosmetic_view = function(self)
	return self:get_view(COSMETIC_VIEW)
    -- return managers.ui:view_active(COSMETIC_VIEW) and managers.ui:view_instance(COSMETIC_VIEW) or nil
end

mod.is_light_mutator = function(self)
	local FLASHLIGHT_AGGRO_MUTATORS = {
		"mutator_darkness_los",
		"mutator_ventilation_purge_los"
	}
	local mutator_manager = managers.state.mutator
	for i = 1, #FLASHLIGHT_AGGRO_MUTATORS do
		if mutator_manager:mutator(FLASHLIGHT_AGGRO_MUTATORS[i]) then
			return true
		end
	end
end

mod.is_in_hub = function()
	local state_manager = managers.state
	local game_mode = state_manager and state_manager.game_mode
	local game_mode_name = game_mode and game_mode:game_mode_name()
	return game_mode_name == "hub" or mod:is_in_prologue_hub()
end

mod.is_in_prologue_hub = function()
	local state_manager = managers.state
	local game_mode = state_manager and state_manager.game_mode
	local game_mode_name = game_mode and game_mode:game_mode_name()
	return game_mode_name == "prologue_hub"
end

mod.main_time = function()
	return managers.time:time("main")
end

mod.game_time = function()
	return managers.time:time("gameplay")
end

mod.recreate_hud = function(self)
	local ui_manager = managers.ui
	if ui_manager then
		local hud = ui_manager._hud
		if hud then
			local player = managers.player:local_player(1)
			local peer_id = player:peer_id()
			local local_player_id = player:local_player_id()
			local elements = hud._element_definitions
			local visibility_groups = hud._visibility_groups
			hud:destroy()
			ui_manager:create_player_hud(peer_id, local_player_id, elements, visibility_groups)
		end
	end
end

mod.player_from_viewport = function(self, viewport_name)
    local players = managers.player:players()
    for _, player in pairs(players) do
        if player.viewport_name == viewport_name then
            return player
        end
    end
end

-- Get player from player_unit
mod.player_from_unit = function(self, unit)
    if unit then
        local player_manager = managers.player
        for _, player in pairs(player_manager:players()) do
            if player.player_unit == unit then
                return player
            end
        end
    end
    return managers.player:local_player_safe(1)
end

-- Extract item name from model string
mod.item_name_from_content_string = function(self, content_string)
	return string_gsub(content_string, '.*[%/%\\]', '')
end

mod.release_non_essential_packages = function(self)
	-- Release all non-essential packages
	local unloaded_packages = {}
	local lists = {"visible_equipment", "view_weapon_sounds"}
	for _, list in pairs(lists) do
		for package_name, package_id in pairs(self:persistent_table(REFERENCE).loaded_packages[list]) do
			unloaded_packages[package_name] = package_id
			self:persistent_table(REFERENCE).used_packages[list][package_name] = nil
		end
		self:persistent_table(REFERENCE).loaded_packages[list] = {}
	end
	for package_name, package_id in pairs(unloaded_packages) do
		managers.package:release(package_id)
	end
end

mod.load_needed_packages = function(self)
    local _needed_packages = {
        "content/weapons/player/ranged/bolt_gun/attachments/sight_01/sight_01",
		"content/fx/particles/enemies/sniper_laser_sight",
		"content/fx/particles/enemies/red_glowing_eyes",
		"packages/ui/views/splash_view/splash_view",
		-- "content/fx/particles/interacts/servoskull_visibility_hover",
		-- "content/fx/particles/abilities/psyker_warp_charge_shout",
		-- "content/fx/particles/enemies/buff_stummed",
		-- "content/fx/particles/enemies/corruptor/corruptor_arm_tip",
		-- "content/fx/particles/weapons/force_staff/force_staff_channel_charge",
		"content/fx/particles/abilities/chainlightning/protectorate_chainlightning_hands_charge",
		-- "content/characters/player/human/third_person/animations/lasgun_pistol",
		-- "content/characters/player/human/first_person/animations/lasgun_pistol",
		-- "content/characters/player/human/third_person/animations/stubgun_pistol",
		-- "content/characters/player/human/first_person/animations/stubgun_pistol",
		-- "content/characters/player/human/third_person/animations/autogun_pistol",
		-- "content/characters/player/human/first_person/animations/autogun_pistol",
		"content/fx/particles/screenspace/screen_ogryn_dash",
		"wwise/events/weapon/play_lasgun_p3_mag_button",
    }
    for _, package_name in pairs(_needed_packages) do
		if not self:persistent_table(REFERENCE).loaded_packages.needed[package_name] then
			self:persistent_table(REFERENCE).used_packages.needed[package_name] = true
            self:persistent_table(REFERENCE).loaded_packages.needed[package_name] = managers.package:load(package_name, REFERENCE)
        end
    end
end

mod.unit_set_local_position_mesh = function(self, slot_info_id, unit, movement)
	if unit and unit_alive(unit) then
		local slot_infos = self:persistent_table(REFERENCE).attachment_slot_infos
		local gear_info = slot_infos[slot_info_id]
		local mesh_move = gear_info and gear_info.unit_mesh_move[unit]
		local unit_and_meshes = mesh_move == "both" or false
		local root_unit = gear_info and gear_info.attachment_slot_to_unit["root"] or unit
		local attachment_slot = gear_info and gear_info.unit_to_attachment_slot[unit]
		local mesh_position = gear_info and gear_info.unit_mesh_position[unit]
		local mesh_rotation = gear_info and gear_info.unit_mesh_rotation[unit]
		local mesh_index = gear_info and gear_info.unit_mesh_index[unit]

		local num_meshes = unit_num_meshes(unit)
		if (mesh_move or unit_and_meshes or mesh_position) and num_meshes > 0 then
			local mesh_positions = {}
			local mesh_rotations = {}
			if mesh_position and mesh_index then
				if type(mesh_position) == "table" and type(mesh_index) == "table" then
					for i = 1, #mesh_position do
						local index = mesh_index[i]
						mesh_positions[index] = vector3_unbox(mesh_position[i])
						if mesh_rotation then
							mesh_rotations[index] = vector3_unbox(mesh_rotation[i])
						end
					end
				else
					mesh_positions[mesh_index] = vector3_unbox(mesh_position)
					if mesh_rotation then
						mesh_rotations[mesh_index] = vector3_unbox(mesh_rotation)
					end
				end
			end
			local mesh_start, mesh_end = 1, num_meshes
			for i = mesh_start, mesh_end do
				local mesh = unit_mesh(unit, i)
				local unit_data = self.mesh_positions[unit]
				local mesh_default = unit_data and unit_data[i] and vector3_unbox(unit_data[i]) or vector3_zero()
				local mesh_pos = mesh_positions[i] or vector3_zero()
				local position = mesh_default + mesh_pos
				if mesh_move or unit_and_meshes then
					position = position + movement
				end
				if mesh_rotations[i] then
					local rotation = quaternion_from_euler_angles_xyz(mesh_rotations[i][1], mesh_rotations[i][2], mesh_rotations[i][3])
					mesh_set_local_rotation(mesh, unit, rotation)
				end
				mesh_set_local_position(mesh, unit, position)
			end
			-- for i = mesh_start, mesh_end do
			-- for i, mesh_index in pairs(mesh_index) do
			-- 	local mesh = unit_mesh(unit, i)
			-- 	local unit_data = self.mesh_positions[unit]
			-- 	local mesh_default = unit_data and unit_data[i] and vector3_unbox(unit_data[i]) or vector3_zero()
			-- 	local mesh_position = mesh_position[i] or vector3_zero()
			-- 	local position = mesh_default + mesh_position
			-- 	if mesh_move or unit_and_meshes then
			-- 		position = position + movement
			-- 	end
			-- 	mesh_set_local_position(mesh, unit, position)
			-- end
		end

		if not mesh_move or unit_and_meshes then
			-- mod:info("mod.unit_set_local_position_mesh: "..tostring(unit))
			unit_set_local_position(unit, 1, movement)
		end

		local root_movement = gear_info and gear_info.unit_root_movement[unit]
		local root_default_position = gear_info and gear_info.unit_default_position["root"]
		local root_position = gear_info and gear_info.unit_root_position[unit]
		if (root_movement or root_position) and root_unit and unit_alive(root_unit) then
			local default_position = root_default_position and vector3_unbox(root_default_position) or vector3_zero()
			local position = root_position and vector3_unbox(root_position) or vector3_zero()
			local offset = default_position + position + movement
			-- mod:info("mod.unit_set_local_position_mesh: "..tostring(root_unit))
			unit_set_local_position(root_unit, 1, default_position + position + movement)
		end
	end
end

mod.with = function(self, object, callback)
	if object and callback and type(callback) == "function" then
		if type(object) == "unit" and not unit_alive(object) then return false end
		return callback(object)
	end
end
