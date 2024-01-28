local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
	local ItemMaterialOverrides = mod:original_require("scripts/settings/equipment/item_material_overrides/item_material_overrides")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
	local Unit = Unit
	local Mesh = Mesh
	local type = type
	local table = table
	local World = World
	local pairs = pairs
	local CLASS = CLASS
	local color = Color
	local string = string
	local rawget = rawget
	local Level = Level
	local vector2 = Vector2
	local vector3 = Vector3
	local managers= Managers
	local log_info = Log.info
	local tonumber = tonumber
	local unit_node = Unit.node
	local unit_mesh = Unit.mesh
	local table_keys = table.keys
	local table_sort = table.sort
	local table_find = table.find
	local unit_alive = Unit.alive
	local Quaternion = Quaternion
	local vector3_box = Vector3Box
	local table_clone = table.clone
	local string_gsub = string.gsub
	local string_find = string.find
	local vector3_one = vector3.one
	local table_remove = table.remove
	local table_append = table.append
	local string_split = string.split
	local vector3_zero = vector3.zero
	local matrix4x4_box = Matrix4x4Box
	local level_units = Level.units
	local unit_set_data = Unit.set_data
	local unit_has_node = Unit.has_node
	local table_contains = table.contains
	local unit_debug_name = Unit.debug_name
	local unit_local_pose = Unit.local_pose
	local unit_world_pose = Unit.world_pose
	local unit_lod_object = Unit.lod_object
	local unit_num_meshes = Unit.num_meshes
	local vector3_unbox = vector3_box.unbox
	local world_link_unit = World.link_unit
	local world_unlink_unit = World.unlink_unit
	local table_set_readonly = table.set_readonly
	local visibility_contexts = VisibilityContexts
	local unit_local_position = Unit.local_position
	local unit_local_rotation = Unit.local_rotation
	local unit_world_position = Unit.world_position
	local unit_world_rotation = Unit.world_rotation
	local unit_has_lod_object = Unit.has_lod_object
	local unit_set_sort_order = Unit.set_sort_order
	local mesh_local_position = Mesh.local_position
	local world_spawn_unit_ex = World.spawn_unit_ex
	local unit_set_local_scale = Unit.set_local_scale
	local quaternion_matrix4x4 = Quaternion.matrix4x4
	local unit_set_unit_culling = Unit.set_unit_culling
	local unit_set_local_position = Unit.set_local_position
	local unit_set_local_rotation = Unit.set_local_rotation
	local lod_group_add_lod_object = LODGroup.add_lod_object
	local unit_set_mesh_visibility = Unit.set_mesh_visibility
	local unit_set_unit_visibility = Unit.set_unit_visibility
	local lod_object_set_static_select = LODObject.set_static_select
	local Unit_set_scalar_for_materials = Unit.set_scalar_for_materials
	local Unit_set_vector2_for_materials = Unit.set_vector2_for_materials
	local Unit_set_vector3_for_materials = Unit.set_vector3_for_materials
	local Unit_set_vector4_for_materials = Unit.set_vector4_for_materials
	local Unit_set_texture_for_materials = Unit.set_texture_for_materials
	local quaternion_to_euler_angles_xyz = Quaternion.to_euler_angles_xyz
	local unit_set_animation_state_machine = Unit.set_animation_state_machine
	local unit_set_unit_objects_visibility = Unit.set_unit_objects_visibility
	local quaternion_from_euler_angles_xyz = Quaternion.from_euler_angles_xyz
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local REFERENCE = "weapon_customization"
--#endregion

mod.mesh_positions = {}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod:hook_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization", function(instance)

	instance._sort_order_enum = {
		FACE_SCAR = 1,
		FACE_HAIR = 2,
		HAIR = 3
	}

	instance.spawn_item_attachments = function(item_data, override_lookup, attach_settings, item_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_mission_template)
		local item_name = mod:item_name_from_content_string(item_data.name)
		local attachments = item_data.attachments
		local gear_id = mod:get_gear_id(item_data)
		local slot_info_id = mod:get_slot_info_id(item_data)
		local in_possesion_of_player = mod:is_owned_by_player(item_data)
		local attachment_slot_info = {}
		
		if item_unit and attachments and gear_id and in_possesion_of_player and not mod:is_premium_store_item() then
			mod:setup_item_definitions()

			-- Add flashlight slot
			mod:_add_custom_attachments(item_data, attachments)
			
			-- Overwrite attachments
			mod:_overwrite_attachments(item_data, attachments)
		end

		-- mod:echo(item_name)
		-- mod:debug_attachments(item_data, attachments, {"combataxe_p3_m3"}, nil, true)

		--#region Original
			local attachment_units, attachment_units_bind_poses, attachment_name_to_unit  = nil, nil, nil
			local attachments = item_data.attachments
		
			if item_unit and attachments then
				attachment_name_to_unit = optional_map_attachment_name_to_unit and {}
				attachment_units_bind_poses = optional_extract_attachment_units_bind_poses and {}
				attachment_units = {}
				local attachment_names = table_keys(attachments)
		
				table_sort(attachment_names)
		
				local skin_color_slot_name = "slot_body_skin_color"
				local skin_color_slot_index = table_find(attachment_names, skin_color_slot_name)
		
				if skin_color_slot_index then
					table_remove(attachment_names, skin_color_slot_index)
		
					attachment_names[#attachment_names + 1] = skin_color_slot_name
				end
		
				for i = 1, #attachment_names do
					local name = attachment_names[i]
					local attachment_slot_data = attachments[name]
					attachment_units, attachment_name_to_unit, attachment_units_bind_poses = instance._attach_hierarchy(attachment_slot_data, override_lookup, attach_settings, item_unit, attachment_units, name, attachment_name_to_unit, attachment_units_bind_poses, optional_mission_template, attachment_slot_info, item_name, in_possesion_of_player)
				end
			end
		--#endregion Original

		-- ############################################################################################################

		if attachment_units and item_unit and attachments and gear_id and not mod:is_premium_store_item() then

			unit_set_data(item_unit, "attachment_units", attachment_units)

			local slot_infos = mod:persistent_table(REFERENCE).attachment_slot_infos
			slot_infos[slot_info_id] = attachment_slot_info

			slot_infos[slot_info_id].attachment_slot_to_unit = 	slot_infos[slot_info_id].attachment_slot_to_unit or {}
			slot_infos[slot_info_id].unit_to_attachment_slot = 	slot_infos[slot_info_id].unit_to_attachment_slot or {}
			slot_infos[slot_info_id].unit_to_attachment_name = 	slot_infos[slot_info_id].unit_to_attachment_name or {}
			slot_infos[slot_info_id].unit_root_movement =      	slot_infos[slot_info_id].unit_root_movement or {}
			slot_infos[slot_info_id].unit_mesh_move =        	slot_infos[slot_info_id].unit_mesh_move or {}
			slot_infos[slot_info_id].unit_root_position =		slot_infos[slot_info_id].unit_root_position or {}
			slot_infos[slot_info_id].unit_mesh_position =		slot_infos[slot_info_id].unit_mesh_position or {}
			slot_infos[slot_info_id].unit_mesh_rotation =		slot_infos[slot_info_id].unit_mesh_rotation or {}
			slot_infos[slot_info_id].unit_mesh_index = 			slot_infos[slot_info_id].unit_mesh_index or {}
			slot_infos[slot_info_id].unit_default_position = 	slot_infos[slot_info_id].unit_default_position or {}
			slot_infos[slot_info_id].attachment_slot_to_unit["root"] = item_unit
			slot_infos[slot_info_id].unit_to_attachment_slot[item_unit] = "root"
			slot_infos[slot_info_id].unit_to_attachment_name[item_unit] = "root"

			-- Set root default position
			slot_infos[slot_info_id].unit_default_position["root"] = vector3_box(unit_local_position(item_unit, 1))

			-- Set unit default positions
			for _, unit in pairs(attachment_units) do
				slot_infos[slot_info_id].unit_default_position[unit] = vector3_box(unit_local_position(unit, 1))
			end

			-- Iterate attachment units
			for _, unit in pairs(attachment_units) do
				local unit_name = unit_debug_name(unit)
				local anchor = nil

				-- Set unit mesh default positions
				mod.mesh_positions[unit] = mod.mesh_positions[unit] or {}
			    local num_meshes = unit_num_meshes(unit)
			    for i = 1, num_meshes do
			        mod.mesh_positions[unit][i] = vector3_box(mesh_local_position(unit_mesh(unit, i)))
			    end

				-- Handle positioning and setup infos
				if slot_infos[slot_info_id] then
					local attachment_name = slot_infos[slot_info_id].unit_to_attachment_name[unit]
					local attachment_slot = slot_infos[slot_info_id].unit_to_attachment_slot[unit]
					local attachment_data = attachment_name and mod.attachment_models[item_name] and mod.attachment_models[item_name][attachment_name]
					local parent_name = attachment_data and attachment_data.parent and attachment_data.parent
					local parent_node = attachment_data and attachment_data.parent_node and attachment_data.parent_node or 1

					-- Root movement
					local root_movement = attachment_data and attachment_data.move_root or false
					slot_infos[slot_info_id].unit_root_movement[unit] = root_movement

					-- Anchor
					anchor = mod.anchors[item_name] and mod.anchors[item_name][attachment_name]
					anchor = mod:_apply_anchor_fixes(item_data, unit) or anchor

					-- if self:is_composite_item(item_data.name) then
					-- 	-- anchor = item_data.anchors[attachment_slot] or anchor
					-- 	anchor = Unit.get_data("")
					-- end
					-- anchor = Unit.get_data(unit, "anchor") or anchor

					parent_name = anchor and anchor.parent and anchor.parent or parent_name
					parent_node = anchor and anchor.parent_node and anchor.parent_node or parent_node

					-- Parent
					local parent = parent_name and slot_infos[slot_info_id].attachment_slot_to_unit[parent_name] or item_unit

					-- Default position
					local default_position1 = unit and unit_alive(unit) and unit_local_position(unit, 1)
					local default_position = anchor and anchor.position and vector3_unbox(anchor.position) or default_position1 or vector3_zero()

					-- Mesh movement
					local mesh_move = attachment_data and attachment_data.mesh_move
					if mesh_move == nil then mesh_move = true end

					-- Setup data
					slot_infos[slot_info_id].unit_mesh_move[unit] = mesh_move
					slot_infos[slot_info_id].unit_mesh_position[unit] = anchor and anchor.mesh_position
					slot_infos[slot_info_id].unit_mesh_rotation[unit] = anchor and anchor.mesh_rotation
					slot_infos[slot_info_id].unit_mesh_index[unit] = anchor and anchor.mesh_index
					slot_infos[slot_info_id].unit_root_position[unit] = anchor and anchor.root_position

					-- Anchor found?
					if anchor then
						-- Make sure unit is valid
						if unit and unit_alive(unit) then
							-- Link to parent
							if not anchor.offset then
								world_unlink_unit(attach_settings.world, unit)
								world_link_unit(attach_settings.world, unit, 1, parent, parent_node)
							end

							-- Set position ( with meshes )
							mod:unit_set_local_position_mesh(slot_info_id, unit, default_position)

							-- Set rotation
							local rotation_euler = anchor.rotation and vector3_unbox(anchor.rotation) or vector3_zero()
							local rotation = quaternion_from_euler_angles_xyz(rotation_euler[1], rotation_euler[2], rotation_euler[3])
							local rotation_node = anchor.rotation_node or 1
							unit_set_local_rotation(unit, rotation_node, rotation)

							-- Set scale
							-- local scale = {}
							-- local scale_node = {}
							-- if anchor.scale and type(anchor.scale) ~= "table" then
							-- 	scale = {anchor.scale}
							-- 	scale_node = {anchor.scale_node or 1}
							-- end
							-- for s = 1, #scale do
							-- 	local sscale = scale[s] and vector3_unbox(scale[s]) or vector3_one()
							-- 	local sscale_node = scale_node[s]
							-- 	unit_set_local_scale(unit, sscale_node, sscale)
							-- end

							local scale = anchor.scale and vector3_unbox(anchor.scale) or vector3_one()
							local scale_node = anchor.scale_node or 1
							if type(scale_node) ~= "table" then
								scale_node = {scale_node}
							end
							for _, node in pairs(scale_node) do
								unit_set_local_scale(unit, node, scale)
							end

							unit_set_unit_visibility(unit, true, true)

							if anchor.data then
								for name, value in pairs(anchor.data) do
									unit_set_data(unit, name, value)
								end
							end
						end
					end
				end
			end

			for _, unit in pairs(attachment_units) do
				local anchor = nil
				-- Handle positioning and setup infos
				if slot_infos[slot_info_id] then
					local attachment_name = slot_infos[slot_info_id].unit_to_attachment_name[unit]
					local attachment_data = attachment_name and mod.attachment_models[item_name] and mod.attachment_models[item_name][attachment_name]
					-- Hide meshes
					local hide_mesh = attachment_data and attachment_data.hide_mesh
					-- Get fixes
					local fixes = mod:_apply_anchor_fixes(item_data, unit)
					hide_mesh = fixes and fixes.hide_mesh or hide_mesh
					-- Check hide mesh
					if hide_mesh then
						-- Iterate hide mesh entries
						for _, hide_entry in pairs(hide_mesh) do
							-- Check more than one parameter
							if #hide_entry > 1 then
								-- Get attachment name - parameter 1
								local attachment_slot = hide_entry[1]
								-- Get attachment unit
								local hide_unit = slot_infos[slot_info_id].attachment_slot_to_unit[attachment_slot]
								-- Check unit
								if hide_unit and unit_alive(hide_unit) then
									-- Hide nodes
									for i = 2, #hide_entry do
										local mesh_index = hide_entry[i]
										if unit_num_meshes(hide_unit) >= mesh_index then
											unit_set_mesh_visibility(hide_unit, mesh_index, false)
										end
									end
								end
							end
						end
					end
				end
			end
		end
	
		-- Return original values
		return attachment_units, attachment_name_to_unit, attachment_units_bind_poses
	end

	instance.attach_hierarchy = function(attachment_slot_data, override_lookup, settings, parent_unit, attached_units, attachment_name_or_nil, attachment_name_to_unit_or_nil, attached_units_bind_poses_or_nil, optional_mission_template, attachment_slot_info, item_name)
		return instance._attach_hierarchy(attachment_slot_data, override_lookup, settings, parent_unit, attached_units, attachment_name_or_nil, attachment_name_to_unit_or_nil, attached_units_bind_poses_or_nil, optional_mission_template, attachment_slot_info, item_name)
	end

	instance.spawn_item = function(item_data, attach_settings, parent_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_mission_template)
		local weapon_skin = instance._validate_item_name(item_data.slot_weapon_skin)
		local gear_id = mod:get_gear_id(item_data)
		local in_possesion_of_player = mod:is_owned_by_player(item_data)
		local in_store = mod:is_store_item(item_data)

		if type(weapon_skin) == "string" then
			weapon_skin = attach_settings.item_definitions[weapon_skin]
		end
	
		local item_unit, bind_pose = instance.spawn_base_unit(item_data, attach_settings, parent_unit, optional_mission_template, in_possesion_of_player)
		local skin_overrides = instance.generate_attachment_overrides_lookup(item_data, weapon_skin, in_possesion_of_player)
		local attachment_units, attachment_name_to_unit, attachment_units_bind_poses = instance.spawn_item_attachments(item_data, skin_overrides, attach_settings, item_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_mission_template)
	
		instance.apply_material_overrides(item_data, item_unit, parent_unit, attach_settings)
	
		if weapon_skin then
			instance.apply_material_overrides(weapon_skin, item_unit, parent_unit, attach_settings)
		end
	
		instance.add_extensions(item_unit, attachment_units, attach_settings)
		instance.play_item_on_spawn_anim_event(item_data, parent_unit)
	
		return item_unit, attachment_units, bind_pose, attachment_name_to_unit, attachment_units_bind_poses
	end

	instance.spawn_base_unit = function(item_data, attach_settings, parent_unit, optional_mission_template, in_possesion_of_player)
		return instance._spawn_attachment(item_data, attach_settings, parent_unit, optional_mission_template, nil, nil, nil, nil, in_possesion_of_player)
	end

	instance._attach_hierarchy = function(attachment_slot_data, override_lookup, settings, parent_unit, attached_units, attachment_name_or_nil, attachment_name_to_unit_or_nil, attached_units_bind_poses_or_nil, optional_mission_template, attachment_slot_info, item_name, in_possesion_of_player)
		local item_name_ = attachment_slot_data.item
		local item = instance._validate_item_name(item_name_)
		local override_item = override_lookup[attachment_slot_data]
		item = override_item or item
	
		if type(item) == "string" then
			item = settings.item_definitions[item]
		end
	
		if not item then
			return attached_units, attachment_name_to_unit_or_nil, attached_units_bind_poses_or_nil
		end
	
		local attachment_unit, bind_pose = instance._spawn_attachment(item, settings, parent_unit, optional_mission_template, attachment_slot_info, attachment_slot_data.attachment_type, attachment_slot_data.attachment_name, item_name, in_possesion_of_player)
	
		if attachment_unit then
			attached_units[#attached_units + 1] = attachment_unit
	
			if attachment_name_to_unit_or_nil and attachment_name_or_nil then
				attachment_name_to_unit_or_nil[attachment_name_or_nil] = attachment_unit
			end

			if attached_units_bind_poses_or_nil then
				attached_units_bind_poses_or_nil[attachment_unit] = matrix4x4_box(bind_pose)
			end
	
			local attachments = item and item.attachments
			attached_units = instance._attach_hierarchy_children(attachments, override_lookup, settings, attachment_unit, attached_units, attachment_name_or_nil, attachment_name_to_unit_or_nil, attached_units_bind_poses_or_nil, optional_mission_template, attachment_slot_info, item_name, in_possesion_of_player)
			local children = attachment_slot_data.children
			attached_units = instance._attach_hierarchy_children(children, override_lookup, settings, attachment_unit, attached_units, attachment_name_or_nil, attachment_name_to_unit_or_nil, attached_units_bind_poses_or_nil, optional_mission_template, attachment_slot_info, item_name, in_possesion_of_player)
			local material_overrides = {}
			local item_material_overrides = item.material_overrides
	
			if item_material_overrides then
				table_append(material_overrides, item_material_overrides)
			end
	
			local parent_material_overrides = attachment_slot_data.material_overrides
	
			if parent_material_overrides then
				table_append(material_overrides, parent_material_overrides)
			end
	
			local apply_to_parent = item.material_override_apply_to_parent
	
			if material_overrides then
				for _, material_override in pairs(material_overrides) do
					instance.apply_material_override(attachment_unit, parent_unit, apply_to_parent, material_override)
				end
			end
		end
	
		return attached_units, attachment_name_to_unit_or_nil, attached_units_bind_poses_or_nil
	end

	instance._attach_hierarchy_children = function(children, override_lookup, settings, parent_unit, attached_units, attachment_name_or_nil, attachment_name_to_unit_or_nil, attached_units_bind_poses_or_nil, optional_mission_template, attachment_slot_info, item_name, in_possesion_of_player)
		if children then
			for name, child_attachment_slot_data in pairs(children) do
				attached_units, attachment_name_to_unit_or_nil, attached_units_bind_poses_or_nil = instance._attach_hierarchy(child_attachment_slot_data, override_lookup, settings, parent_unit, attached_units, attachment_name_or_nil, attachment_name_to_unit_or_nil, attached_units_bind_poses_or_nil, optional_mission_template, attachment_slot_info, item_name, in_possesion_of_player)
			end
		end
	
		return attached_units, attachment_name_to_unit_or_nil, attached_units_bind_poses_or_nil
	end

	instance._validate_item_name = function(item)
		if item == "" then
			return nil
		end
	
		return item
	end

	instance._node_name_to_attachment_slot = function(item_name, node_name)
		if type(node_name) == "string" then
			local name = node_name
			name = string_gsub(name, "ap_", "")
			name = string_gsub(name, "_01", "")
			name = string_gsub(name, "rp_", "")
			name = string_gsub(name, "magazine_02", "magazine2")
			if string_find(name, "chained_rig") then name = "receiver" end
			if name == "trinket" then name = mod.anchors[item_name] and mod.anchors[item_name].trinket_slot or "slot_trinket_1" end
			return name
		end
		return "unknown"
	end

	instance._spawn_attachment = function(item_data, settings, parent_unit, optional_mission_template, attachment_slot_info, attachment_type, attachment_name, item_name, in_possesion_of_player)
		--#region Original
			if not item_data then
				return nil
			end
		
			local is_first_person = settings.is_first_person
			local show_in_1p = item_data.show_in_1p
			local only_show_in_1p = item_data.only_show_in_1p
		
			if is_first_person and not show_in_1p then
				return nil
			end
		
			if not is_first_person and only_show_in_1p then
				return nil
			end
		
			local base_unit = is_first_person and item_data.base_unit_1p or item_data.base_unit
		
			if not base_unit or base_unit == "" then
				return nil
			end
		
			local breed_attach_node = not settings.is_minion and item_data.breed_attach_node and item_data.breed_attach_node[settings.breed_name]
			local attach_node = breed_attach_node or item_data.attach_node
			local attach_node_index = nil
		
			if tonumber(attach_node) ~= nil then
				attach_node_index = tonumber(attach_node)
			elseif settings.is_minion then
				if settings.from_script_component then
					attach_node_index = unit_has_node(parent_unit, item_data.wielded_attach_node or attach_node) and unit_node(parent_unit, item_data.wielded_attach_node or attach_node) or 1
				else
					attach_node_index = unit_has_node(parent_unit, item_data.unwielded_attach_node or attach_node) and unit_node(parent_unit, item_data.unwielded_attach_node or attach_node) or 1
				end
			elseif attach_node then
				attach_node_index = unit_has_node(parent_unit, attach_node) and unit_node(parent_unit, attach_node) or 1
			end
		
			local spawned_unit = nil
			local pose = unit_world_pose(parent_unit, attach_node_index)
		
			if settings.from_script_component then
				spawned_unit = world_spawn_unit_ex(settings.world, base_unit, nil, pose)
			elseif settings.is_minion then
				spawned_unit = settings.unit_spawner:spawn_unit(base_unit, settings.attach_pose)
			else
				spawned_unit = settings.unit_spawner:spawn_unit(base_unit, pose)
			end
		--#endregion Original

		local attachment_slot = attachment_type or instance._node_name_to_attachment_slot(item_name, attach_node)
		attachment_slot_info = attachment_slot_info or {}
		attachment_slot_info.attachment_slot_to_unit = attachment_slot_info.attachment_slot_to_unit or {}
		attachment_slot_info.unit_to_attachment_slot = attachment_slot_info.unit_to_attachment_slot or {}
		attachment_slot_info.unit_to_attachment_name = attachment_slot_info.unit_to_attachment_name or {}
		attachment_slot_info.attachment_slot_to_unit[attachment_slot] = spawned_unit
		attachment_slot_info.unit_to_attachment_slot[spawned_unit] = attachment_slot
		attachment_slot_info.unit_to_attachment_name[spawned_unit] = attachment_name
		Unit.set_data(spawned_unit, "attachment_name", attachment_name)
		Unit.set_data(spawned_unit, "attachment_slot", attachment_slot)
	
		--#region Original
			local item_type = item_data.item_type
		
			if item_type then
				local sort_order = instance._sort_order_enum[item_type]
		
				if sort_order then
					unit_set_sort_order(spawned_unit, sort_order)
				end
			end
		
			if settings.is_first_person or settings.force_highest_lod_step then
				unit_set_unit_culling(spawned_unit, false)
		
				if unit_has_lod_object(spawned_unit, "lod") then
					local item_lod_object = unit_lod_object(spawned_unit, "lod")
		
					lod_object_set_static_select(item_lod_object, 0)
				end
			end
		
			if not spawned_unit then
				return nil
			end
		
			local backpack_offset = item_data.backpack_offset
		
			if backpack_offset then
				local backpack_offset_node_index = unit_has_node(parent_unit, "j_backpackoffset") and unit_node(parent_unit, "j_backpackoffset")
		
				if backpack_offset_node_index then
					local backpack_offset_v3 = vector3(0, backpack_offset, 0)
		
					unit_set_local_position(parent_unit, backpack_offset_node_index, backpack_offset_v3)
				end
			end
		
			local bind_pose = unit_local_pose(spawned_unit, 1)
		
			if is_first_person and (show_in_1p or only_show_in_1p) then
				unit_set_unit_objects_visibility(spawned_unit, false, true, visibility_contexts.RAYTRACING_CONTEXT)
			end
		
			local keep_local_transform = not settings.skip_link_children and true
		
			world_link_unit(settings.world, spawned_unit, 1, parent_unit, attach_node_index, keep_local_transform)
		
			if settings.lod_group and unit_has_lod_object(spawned_unit, "lod") and not settings.is_first_person then
				local attached_lod_object = unit_lod_object(spawned_unit, "lod")
		
				lod_group_add_lod_object(settings.lod_group, attached_lod_object)
			end
		
			if settings.lod_shadow_group and unit_has_lod_object(spawned_unit, "lod_shadow") and not settings.is_first_person then
				local attached_lod_object = unit_lod_object(spawned_unit, "lod_shadow")
		
				lod_group_add_lod_object(settings.lod_shadow_group, attached_lod_object)
			end
		
			if optional_mission_template then
				local face_state_machine_key = optional_mission_template.face_state_machine_key
				local state_machine = item_data[face_state_machine_key]
		
				if state_machine and state_machine ~= "" then
					unit_set_animation_state_machine(spawned_unit, state_machine)
				end
			end
		
			return spawned_unit, bind_pose
		--#endregion Original
	end

	instance._empty_overrides_table = table_set_readonly({})

	instance._generate_attachment_overrides_recursive = function(attachment_slot_data, override_slot_data, override_lookup)
		if not override_slot_data then
			return
		end
	
		local override_item_name = instance._validate_item_name(override_slot_data.item)
	
		if override_item_name then
			override_lookup[attachment_slot_data] = override_item_name
		end
	
		local children = attachment_slot_data.children
		local override_children = override_slot_data.children
	
		for name, data in pairs(children) do
			local override_data = override_children[name]
	
			instance._generate_attachment_overrides_recursive(data, override_data, override_lookup)
		end
	end

	instance.generate_attachment_overrides_lookup = function (item_data, override_item_data, in_possesion_of_player)
		if override_item_data then
			local attachments = override_item_data.attachments
			local gear_id = mod:get_gear_id(item_data)

			if gear_id and not mod:is_premium_store_item() then
				mod:setup_item_definitions()

				-- Add flashlight slot
				mod:_add_custom_attachments(item_data, attachments)
				
				-- Overwrite attachments
				mod:_overwrite_attachments(item_data, attachments)
			end
		end

		-- ############################################################################################################

		if not override_item_data then
			return instance._empty_overrides_table
		end
	
		local override_lookup = {}
		local attachments = item_data.attachments
		local override_attachments = override_item_data.attachments
	
		if not attachments or not override_attachments then
			return instance._empty_overrides_table
		end
	
		for attachment_name, attachment_slot_data in pairs(attachments) do
			local override_slot_data = override_attachments[attachment_name]
	
			instance._generate_attachment_overrides_recursive(attachment_slot_data, override_slot_data, override_lookup)
		end
	
		return override_lookup
	end

	instance.apply_material_override = function (unit, parent_unit, apply_to_parent, material_override, in_editor)
		if material_override and material_override ~= "" then
			local material_override_data = nil
	
			if in_editor then
				material_override_data = rawget(ItemMaterialOverrides, material_override)
	
				if material_override_data == nil then
					log_info("VisualLoadoutCustomization", "Material override %s does not exist.", material_override)
				end
			else
				material_override_data = ItemMaterialOverrides[material_override]
			end
	
			if material_override_data then
				if apply_to_parent then
					instance._apply_material_override(parent_unit, material_override_data)
				else
					instance._apply_material_override(unit, material_override_data)
				end
			end
		end
	end

	instance._apply_material_override = function(unit, material_override_data)
		if material_override_data.property_overrides ~= nil then
			for property_name, property_override_data in pairs(material_override_data.property_overrides) do
				if type(property_override_data) == "number" then
					Unit_set_scalar_for_materials(unit, property_name, property_override_data, true)
				else
					local property_override_data_num = #property_override_data
	
					if property_override_data_num == 1 then
						Unit_set_scalar_for_materials(unit, property_name, property_override_data[1], true)
					elseif property_override_data_num == 2 then
						Unit_set_vector2_for_materials(unit, property_name, vector2(property_override_data[1], property_override_data[2]), true)
					elseif property_override_data_num == 3 then
						Unit_set_vector3_for_materials(unit, property_name, vector3(property_override_data[1], property_override_data[2], property_override_data[3]), true)
					elseif property_override_data_num == 4 then
						Unit_set_vector4_for_materials(unit, property_name, color(property_override_data[1], property_override_data[2], property_override_data[3], property_override_data[4]), true)
					end
				end
			end
		end
	
		if material_override_data.texture_overrides ~= nil then
			for texture_slot, texture_override_data in pairs(material_override_data.texture_overrides) do
				Unit_set_texture_for_materials(unit, texture_slot, texture_override_data.resource, true)
			end
		end
	end

end)
