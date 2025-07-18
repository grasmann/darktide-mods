local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
	local ItemMaterialOverrides = mod:original_require("scripts/settings/equipment/item_material_overrides/item_material_overrides")
	local VisualLoadoutCustomization = mod:original_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization")
	local MinionAttack = mod:original_require("scripts/utilities/minion_attack")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
	local Unit = Unit
	local Mesh = Mesh
	local type = type
	-- local table = table
	local World = World
	local pairs = pairs
	local CLASS = CLASS
	local color = Color
	local Level = Level
	local ipairs = ipairs
	local string = string
	local rawget = rawget
	local vector2 = Vector2
	local vector3 = Vector3
	local managers= Managers
	local log_info = Log.info
	local callback = callback
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
	local level_units = Level.units
	local table_remove = table.remove
	local table_append = table.append
	local vector3_zero = vector3.zero
	local matrix4x4_box = Matrix4x4Box
	local unit_set_data = Unit.set_data
	local unit_get_data = Unit.get_data
	local unit_has_node = Unit.has_node
	local table_contains = table.contains
	local quaternion_box = QuaternionBox
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
	local table_clone_instance = table.clone_instance
	local quaternion_matrix4x4 = Quaternion.matrix4x4
	local unit_set_unit_culling = Unit.set_unit_culling
	local unit_set_local_position = Unit.set_local_position
	local unit_set_local_rotation = Unit.set_local_rotation
	local lod_group_add_lod_object = LODGroup.add_lod_object
	local unit_set_mesh_visibility = Unit.set_mesh_visibility
	local unit_set_unit_visibility = Unit.set_unit_visibility
	local unit_force_stream_meshes = Unit.force_stream_meshes
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
	local WEAPON_MELEE = "WEAPON_MELEE"
    local WEAPON_RANGED = "WEAPON_RANGED"
--#endregion

mod.mesh_positions = {}
mod.mesh_positions_changed = {}
mod.minion_options = {}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod:hook_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization", function(instance)

	instance._sort_order_enum = {
		FACE_SCAR = 1,
		FACE_HAIR = 2,
		HAIR = 3
	}

	-- ################################################################################################################
	instance.spawn_item_attachments = function(item_data, override_lookup, attach_settings, item_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment)
		if not item_unit then
			return nil, nil, nil, nil
		end

		mod:setup_item_definitions()

		local item_name = mod.gear_settings:short_name(item_data.name)
		local attachments = item_data.attachments
		local slot_info_id = mod.gear_settings:slot_info_id(item_data)
		local in_possesion_of_player = not mod:is_owned_by_other_player(item_data)
		local attachment_slot_info = {}
		local weapon_item = item_data.item_type == "WEAPON_MELEE" or item_data.item_type == "WEAPON_RANGED"
		local player_item = item_data.item_list_faction == "Player"

		local extract_data = instance._create_extract_data(optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names)

		instance._push_extract_data(extract_data, item_unit, item_data.name, nil)

		local attachments = item_data.attachments

		if item_unit and attachments and weapon_item and player_item and not mod:is_premium_store_item() then
			-- Add custom attachments
			mod.gear_settings:_add_custom_attachments(item_data, attachments)
			-- Overwrite attachments
			mod.gear_settings:_overwrite_attachments(item_data, attachments)
		end

		-- mod:console_print("optional_mission_template", optional_mission_template)
		-- mod:debug_attachments(item_data, attachments, {"powersword_p1_m1", "powersword_p1_m2"}, nil, true)

		--#region Original
			local attachment_units, attachment_units_bind_poses, attachment_name_to_unit  = nil, nil, nil
			-- local attachments = item_data.attachments
			-- attachment_units = extract_data.attachment_units_by_unit and extract_data.attachment_units_by_unit[item_unit]
			-- attachment_units = attachment_units or extract_data.attachment_units_by_unit
		
			if item_unit and attachments then
				-- attachment_name_to_unit = optional_map_attachment_name_to_unit and {}
				-- attachment_units_bind_poses = optional_extract_attachment_units_bind_poses and {}
				-- attachment_units = {}
				-- local attachment_names = table_keys(attachments)
		
				-- table_sort(attachment_names)
		
				-- local skin_color_slot_name = "slot_body_skin_color"
				-- local skin_color_slot_index = table_find(attachment_names, skin_color_slot_name)
		
				-- if skin_color_slot_index then
				-- 	table_remove(attachment_names, skin_color_slot_index)
		
				-- 	attachment_names[#attachment_names + 1] = skin_color_slot_name
				-- end
		
				-- for i = 1, #attachment_names do
				-- 	local name = attachment_names[i]
				-- 	local attachment_slot_data = attachments[name]
				-- 	attachment_units, attachment_name_to_unit, attachment_units_bind_poses = instance._attach_hierarchy(attachment_slot_data, override_lookup, attach_settings, item_unit, attachment_units, name, attachment_name_to_unit, attachment_units_bind_poses, optional_mission_template, optional_equipment, attachment_slot_info, item_name, in_possesion_of_player, item_data)
				-- end

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

					instance._attach_hierarchy(attachment_slot_data, override_lookup, attach_settings, item_unit, name, extract_data, optional_mission_template, optional_equipment, attachment_slot_info, item_name, in_possesion_of_player, item_data)
				end
			end
		--#endregion Original

		attachment_units = extract_data.attachment_units_by_unit and extract_data.attachment_units_by_unit[item_unit]
		attachment_units = attachment_units or extract_data.attachment_units_by_unit

		-- ############################################################################################################

		if attachment_units and item_unit and attachments and weapon_item and player_item and not mod:is_premium_store_item() then

			unit_set_data(item_unit, "attachment_units", attachment_units)
			-- unit_set_data(item_unit, "all_attachment_units", attachment_units)

			local slot_infos = mod:persistent_table(REFERENCE).attachment_slot_infos
			slot_infos[slot_info_id] = attachment_slot_info

			-- slot_infos[slot_info_id].attachment_slot_to_unit = 	slot_infos[slot_info_id].attachment_slot_to_unit or {}
			-- slot_infos[slot_info_id].unit_to_attachment_slot = 	slot_infos[slot_info_id].unit_to_attachment_slot or {}
			-- slot_infos[slot_info_id].unit_to_attachment_name = 	slot_infos[slot_info_id].unit_to_attachment_name or {}
			-- slot_infos[slot_info_id].unit_root_movement =      	slot_infos[slot_info_id].unit_root_movement or {}
			-- slot_infos[slot_info_id].unit_mesh_move =        	slot_infos[slot_info_id].unit_mesh_move or {}
			-- slot_infos[slot_info_id].unit_root_position =		slot_infos[slot_info_id].unit_root_position or {}
			-- slot_infos[slot_info_id].unit_mesh_position =		slot_infos[slot_info_id].unit_mesh_position or {}
			-- slot_infos[slot_info_id].unit_mesh_rotation =		slot_infos[slot_info_id].unit_mesh_rotation or {}
			-- slot_infos[slot_info_id].unit_mesh_index = 			slot_infos[slot_info_id].unit_mesh_index or {}
			-- slot_infos[slot_info_id].unit_default_position = 	slot_infos[slot_info_id].unit_default_position or {}
			-- slot_infos[slot_info_id].unit_default_rotation = 	slot_infos[slot_info_id].unit_default_rotation or {}
			-- slot_infos[slot_info_id].unit_changed_position = 	slot_infos[slot_info_id].unit_changed_position or {}
			-- slot_infos[slot_info_id].unit_changed_rotation = 	slot_infos[slot_info_id].unit_changed_rotation or {}
			-- slot_infos[slot_info_id].attachment_slot_to_unit["root"] = item_unit
			-- slot_infos[slot_info_id].unit_to_attachment_slot[item_unit] = "root"
			-- slot_infos[slot_info_id].unit_to_attachment_name[item_unit] = "root"
			local slot_info = slot_infos[slot_info_id]
			if not slot_info then
				slot_info = {}
				slot_infos[slot_info_id] = slot_info
			end

			-- Predefine field names to initialize
			local fields = {
				"attachment_slot_to_unit", "unit_to_attachment_slot", "unit_to_attachment_name",
				"unit_root_movement", "unit_mesh_move", "unit_root_position", "unit_mesh_position",
				"unit_mesh_rotation", "unit_mesh_index", "unit_default_position", "unit_default_rotation",
				"unit_changed_position", "unit_changed_rotation"
			}

			-- Initialize missing fields only once
			for _, key in ipairs(fields) do
				slot_info[key] = slot_info[key] or {}
			end

			-- Assign root data
			slot_info.attachment_slot_to_unit["root"] = item_unit
			slot_info.unit_to_attachment_slot[item_unit] = "root"
			slot_info.unit_to_attachment_name[item_unit] = "root"






			-- Set root default position
			slot_infos[slot_info_id].unit_default_position["root"] = vector3_box(unit_local_position(item_unit, 1))
			unit_set_data(item_unit, "default_position", vector3_box(unit_local_position(item_unit, 1)))

			-- Set unit default positions
			for _, unit in pairs(attachment_units) do
				slot_infos[slot_info_id].unit_default_position[unit] = vector3_box(unit_local_position(unit, 1))
				unit_set_data(unit, "default_position", vector3_box(unit_local_position(unit, 1)))
				slot_infos[slot_info_id].unit_default_rotation[unit] = QuaternionBox(Unit.local_rotation(unit, 1))
				unit_set_data(unit, "default_rotation", QuaternionBox(Unit.local_rotation(unit, 1)))
			end

			-- Iterate attachment units
			for slot_index, unit in pairs(attachment_units) do

				local unit_name = unit_debug_name(unit)
				local anchor = nil

				-- Set unit mesh default positions
				mod.mesh_positions[unit] = mod.mesh_positions[unit] or {}
				local num_meshes = unit_num_meshes(unit)
				for i = 1, num_meshes do
					mod.mesh_positions[unit][i] = vector3_box(mesh_local_position(unit_mesh(unit, i)))
					unit_set_data(unit, "mesh_positions", i, vector3_box(mesh_local_position(unit_mesh(unit, i))))
				end

				-- Handle positioning and setup infos
				if slot_infos[slot_info_id] then
					-- local attachment_name = slot_infos[slot_info_id].unit_to_attachment_name[unit]
					local attachment_name = Unit.get_data(unit, "attachment_name")
					if attachment_name then unit_set_data(item_unit, attachment_name, unit) end
					-- local attachment_slot = slot_infos[slot_info_id].unit_to_attachment_slot[unit]
					local attachment_slot = Unit.get_data(unit, "attachment_slot")
					if attachment_slot then unit_set_data(item_unit, attachment_slot, unit) end
					unit_set_data(item_unit, "attachment_slots", slot_index, attachment_slot)

					local attachment_data = attachment_name and mod.attachment_models[item_name] and mod.attachment_models[item_name][attachment_name]
					local parent_name = attachment_data and attachment_data.parent and attachment_data.parent
					local parent_node = attachment_data and attachment_data.parent_node and attachment_data.parent_node or 1

					-- Root movement
					local root_movement = attachment_data and attachment_data.move_root or false
					slot_infos[slot_info_id].unit_root_movement[unit] = root_movement
					unit_set_data(unit, "root_movement", root_movement)

					-- Anchor
					anchor = mod.anchors[item_name] and mod.anchors[item_name][attachment_name]
					anchor = mod.gear_settings:apply_fixes(item_data, unit) or anchor

					-- if self:is_composite_item(item_data.name) then
					-- 	-- anchor = item_data.anchors[attachment_slot] or anchor
					-- 	anchor = Unit.get_data("")
					-- end
					-- anchor = Unit.get_data(unit, "anchor") or anchor

					parent_name = anchor and anchor.parent and anchor.parent or parent_name
					-- local breed_attach_node = not settings.is_minion and item_data.breed_attach_node and item_data.breed_attach_node[settings.breed_name]
					-- local attach_node = breed_attach_node or item_data.attach_node
					-- local attach_node_index = attach_node and 
					parent_node = anchor and anchor.parent_node and anchor.parent_node or parent_node

					-- Parent
					local parent = parent_name and slot_infos[slot_info_id].attachment_slot_to_unit[parent_name] or item_unit
					-- if type(parent_node) == "string" then
					-- 	mod:echo("parent_node "..parent_node.." is string")
					-- 	if not unit_has_node(parent, parent_node) then
					-- 		mod:echo("parent_node "..parent_node.." does not exist")
					-- 	end
					-- end
					parent_node = (type(parent_node) == "string" and (unit_has_node(parent, parent_node) and unit_node(parent, parent_node) or 1)) or parent_node
					
					-- local slot_node = "ap_"..attachment_slot.."_01"
					-- if unit_has_node(parent, slot_node) then
					-- 	local old_node = parent_node
					-- 	parent_node = unit_has_node(parent, slot_node) and unit_node(parent, slot_node) or parent_node
					-- 	mod:echo(attachment_slot..": used node "..parent_node.."("..slot_node..") instead of "..old_node)
					-- end

					-- Default position
					local default_position1 = unit and unit_alive(unit) and unit_local_position(unit, 1)
					local default_position = anchor and anchor.position and vector3_unbox(anchor.position) or default_position1 or vector3_zero()

					-- Mesh movement
					local mesh_move = attachment_data and attachment_data.mesh_move
					if mesh_move == nil then mesh_move = true end

					-- Setup data
					slot_infos[slot_info_id].unit_mesh_move[unit] = mesh_move
					unit_set_data(unit, "mesh_move", mesh_move)
					slot_infos[slot_info_id].unit_mesh_position[unit] = anchor and anchor.mesh_position
					unit_set_data(unit, "mesh_position", anchor and anchor.mesh_position or {})
					slot_infos[slot_info_id].unit_mesh_rotation[unit] = anchor and anchor.mesh_rotation
					unit_set_data(unit, "mesh_rotation", anchor and anchor.mesh_rotation or {})
					slot_infos[slot_info_id].unit_mesh_index[unit] = anchor and anchor.mesh_index
					unit_set_data(unit, "mesh_index", anchor and anchor.mesh_index or {})
					slot_infos[slot_info_id].unit_root_position[unit] = anchor and anchor.root_position
					unit_set_data(unit, "root_position", anchor and anchor.root_position or {})

					-- Anchor found?
					if anchor then
						-- Make sure unit is valid
						if unit and unit_alive(unit) then
							-- Link to parent
							if not anchor.offset then
								Unit.set_data(unit, "parent_unit", parent)
								Unit.set_data(unit, "parent_node", parent_node)
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

							-- local visible = false
							local visible = table.contains(mod.attachment_slots_always_sheathed, attachment_slot) and false or true
							unit_set_unit_visibility(unit, visible, true)

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
				-- Set unit mesh default positions
				mod.mesh_positions_changed[unit] = mod.mesh_positions_changed[unit] or {}
				local num_meshes = unit_num_meshes(unit)
				for i = 1, num_meshes do
					mod.mesh_positions_changed[unit][i] = vector3_box(mesh_local_position(unit_mesh(unit, i)))
					unit_set_data(unit, "mesh_positions_changed", i, vector3_box(mesh_local_position(unit_mesh(unit, i))))
				end
			end

			-- Set unit changed positions
			for _, unit in pairs(attachment_units) do
				slot_infos[slot_info_id].unit_changed_position[unit] = vector3_box(unit_local_position(unit, 1))
				unit_set_data(unit, "changed_position", vector3_box(unit_local_position(unit, 1)))
				slot_infos[slot_info_id].unit_changed_rotation[unit] = QuaternionBox(Unit.local_rotation(unit, 1))
				unit_set_data(unit, "changed_rotation", QuaternionBox(Unit.local_rotation(unit, 1)))
			end

			-- for _, unit in pairs(attachment_units) do
			-- 	local anchor = nil
			-- 	-- Handle positioning and setup infos
			-- 	if slot_infos[slot_info_id] then
			-- 		local attachment_name = slot_infos[slot_info_id].unit_to_attachment_name[unit]
			-- 		local attachment_data = attachment_name and mod.attachment_models[item_name] and mod.attachment_models[item_name][attachment_name]
			-- 		-- Hide meshes
			-- 		local hide_mesh = attachment_data and attachment_data.hide_mesh
			-- 		-- Get fixes
			-- 		local fixes = mod.gear_settings:apply_fixes(item_data, unit)
			-- 		hide_mesh = fixes and fixes.hide_mesh or hide_mesh
			-- 		-- Check hide mesh
			-- 		if hide_mesh then
			-- 			-- Iterate hide mesh entries
			-- 			for _, hide_entry in pairs(hide_mesh) do
			-- 				-- Check more than one parameter
			-- 				if #hide_entry > 1 then
			-- 					-- Get attachment name - parameter 1
			-- 					local attachment_slot = hide_entry[1]
			-- 					-- Get attachment unit
			-- 					local hide_unit = slot_infos[slot_info_id].attachment_slot_to_unit[attachment_slot]
			-- 					-- Check unit
			-- 					if hide_unit and unit_alive(hide_unit) then
			-- 						-- Hide nodes
			-- 						for i = 2, #hide_entry do
			-- 							local mesh_index = hide_entry[i]
			-- 							if unit_num_meshes(hide_unit) >= mesh_index then
			-- 								unit_set_mesh_visibility(hide_unit, mesh_index, false)
			-- 							end
			-- 						end
			-- 					end
			-- 				end
			-- 			end
			-- 		end
			-- 	end
			-- end
			local slot_info = slot_infos[slot_info_id]
			if slot_info then
				for _, unit in pairs(attachment_units) do
					local attachment_name = slot_info.unit_to_attachment_name[unit]
					local item_attachments = mod.attachment_models[item_name]
					local attachment_data = item_attachments and attachment_name and item_attachments[attachment_name]
					local hide_mesh = attachment_data and attachment_data.hide_mesh

					-- Apply gear fixes (might override hide_mesh)
					local fixes = mod.gear_settings:apply_fixes(item_data, unit)
					if fixes and fixes.hide_mesh then
						hide_mesh = fixes.hide_mesh
					end

					if hide_mesh then
						for _, hide_entry in ipairs(hide_mesh) do
							local entry_len = #hide_entry
							if entry_len > 1 then
								local attachment_slot = hide_entry[1]
								local hide_unit = slot_info.attachment_slot_to_unit[attachment_slot]

								if hide_unit and unit_alive(hide_unit) then
									local mesh_count = unit_num_meshes(hide_unit)
									for i = 2, entry_len do
										local mesh_index = hide_entry[i]
										if mesh_count >= mesh_index then
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

		--#region Old
			-- if attachment_units and mod:has_premium_skin(item_data) and attach_settings then
			-- 	-- local particle_name = "content/fx/particles/interacts/servoskull_visibility_hover"
			-- 	-- local particle_name = "content/fx/particles/enemies/red_glowing_eyes"
			-- 	-- local particle_name = "content/fx/particles/abilities/psyker_warp_charge_shout"
			-- 	-- local particle_name = "content/fx/particles/enemies/buff_stummed";
			-- 	local particle_name = "content/fx/particles/abilities/chainlightning/protectorate_chainlightning_hands_charge";
			-- 	local color = color(255, 255, 0, 0)
			-- 	-- local intensity = 10
			-- 	local world_scale = vector3(.1, .1, .1)
			-- 	local unit = item_unit
			-- 	-- for _, unit in pairs(attachment_units) do
			-- 		if unit and unit_alive(unit) then
			-- 			local world_position = Unit.world_position(unit, 1)
			-- 			local world_rotation = Unit.world_rotation(unit, 1)
			-- 			local particle_id = World.create_particles(attach_settings.world, particle_name, world_position, world_rotation, world_scale)
			-- 			local unit_world_pose = Unit.world_pose(unit, 1)
			-- 			-- Matrix4x4.set_translation(unit_world_pose, vector3(0, distance, 0))
			-- 			Matrix4x4.set_scale(unit_world_pose, vector3(.1, .1, .1))
			-- 			World.link_particles(attach_settings.world, particle_id, unit, 1, Matrix4x4.identity(), "destroy")
			-- 			World.set_particles_use_custom_fov(attach_settings.world, particle_id, true)
			-- 			unit_set_data(unit, "premium_particle", particle_id)
			-- 			-- World.set_particles_material_vector3(attach_settings.world, particle_id, "eye_socket", "material_variable_21872256", vector3(1, 0, 0))
			-- 			-- World.set_particles_material_vector3(attach_settings.world, particle_id, "eye_glow", "trail_color", vector3(0, 0, 0))
			-- 			-- World.set_particles_material_vector3(attach_settings.world, particle_id, "eye_flash_init", "material_variable_21872256", vector3(0, 0, 0))
			-- 			-- Unit.set_vector3_for_materials(unit, "stimmed_color", color, true)
			-- 			-- Unit.set_scalar_for_materials(unit, "emissive_intensity_lumen", intensity)
			-- 			-- Unit.set_scalar_for_materials(unit, "increase_color", 2)
			-- 			-- if attach_settings.character_unit then
			-- 			-- 	-- "content/fx/particles/interacts/servoskull_visibility_hover"
			-- 			-- end
			-- 		end
			-- 	-- end
			-- end
		--#endregion
	
		-- Return original values
		-- return attachment_units, attachment_name_to_unit, attachment_units_bind_poses

		instance._pop_extract_data(extract_data, item_unit)

		return extract_data.attachment_units_by_unit, extract_data.attachment_id_lookup, extract_data.attachment_name_lookup, extract_data.bind_poses_by_unit, extract_data.item_name_by_unit
	end

	-- ################################################################################################################
	instance.spawn_item = function(item_data, attach_settings, parent_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment)
		mod:setup_item_definitions()

		-- local weapon_skin = instance._validate_item_name(item_data.slot_weapon_skin)
		-- local in_possesion_of_player = mod.gear_settings:player_item(item_data)
		-- local in_store = mod:is_store_item(item_data)
		-- local attachments = item_data.attachments
		-- local weapon_item = item_data.item_type == "WEAPON_MELEE" or item_data.item_type == "WEAPON_RANGED"
		-- local player_item = item_data.item_list_faction == "Player"

		-- if type(weapon_skin) == "string" then
		-- 	-- weapon_skin = attach_settings.item_definitions[weapon_skin]
		-- 	weapon_skin = mod:persistent_table(REFERENCE).item_definitions[weapon_skin]
		-- end

		-- if attachments and weapon_item and player_item and not mod:is_premium_store_item() then
		-- 	-- mod:dtf(item_data, "item_data", 10)
		-- 	-- Add custom attachments
		-- 	mod.gear_settings:_add_custom_attachments(item_data, attachments)
		-- 	-- Overwrite attachments
		-- 	mod.gear_settings:_overwrite_attachments(item_data, attachments)
		-- end
	
		-- local item_unit, bind_pose = instance.spawn_base_unit(item_data, attach_settings, parent_unit, optional_mission_template, optional_equipment, in_possesion_of_player)
		-- local skin_overrides = instance.generate_attachment_overrides_lookup(item_data, weapon_skin, in_possesion_of_player)
		-- local attachment_units_by_unit, attachment_name_to_unit, attachment_units_bind_poses = instance.spawn_item_attachments(item_data, skin_overrides, attach_settings, item_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment)
	
		-- instance.apply_material_overrides(item_data, item_unit, parent_unit, attach_settings)
	
		-- if weapon_skin then
		-- 	instance.apply_material_overrides(weapon_skin, item_unit, parent_unit, attach_settings)
		-- end
	
		-- instance.add_extensions(item_unit, attachment_units_by_unit and attachment_units_by_unit[item_unit], attach_settings)
		-- instance.play_item_on_spawn_anim_event(item_data, parent_unit)
	
		-- return item_unit, attachment_units_by_unit, bind_pose, attachment_name_to_unit, attachment_units_bind_poses

		local weapon_skin = instance._validate_item_name(item_data.slot_weapon_skin)

		if type(weapon_skin) == "string" then
			-- if attach_settings.in_editor then
			-- 	if attach_settings.item_manager and ToolsMasterItems then
			-- 		weapon_skin = ToolsMasterItems:get(weapon_skin)
			-- 	else
			-- 		weapon_skin = rawget(attach_settings.item_definitions, weapon_skin)
			-- 	end
			-- else
			-- 	weapon_skin = attach_settings.item_definitions[weapon_skin]
			-- end
			weapon_skin = mod:persistent_table(REFERENCE).item_definitions[weapon_skin]
		end

		local attachments = item_data.attachments
		local weapon_item = item_data.item_type == "WEAPON_MELEE" or item_data.item_type == "WEAPON_RANGED"
		local player_item = item_data.item_list_faction == "Player"

		if attachments and weapon_item and player_item and not mod:is_premium_store_item() then
			-- mod:dtf(item_data, "item_data", 10)
			-- Add custom attachments
			mod.gear_settings:_add_custom_attachments(item_data, attachments)
			-- Overwrite attachments
			mod.gear_settings:_overwrite_attachments(item_data, attachments)
		end

		local item_unit, bind_pose = instance.spawn_base_unit(item_data, attach_settings, parent_unit, optional_mission_template)
		local skin_overrides = instance.generate_attachment_overrides_lookup(item_data, weapon_skin)
		local attachment_units_by_unit, attachment_id_lookup, attachment_name_lookup, attachment_units_bind_poses, item_name_by_unit = instance.spawn_item_attachments(item_data, skin_overrides, attach_settings, item_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment)

		instance.apply_material_overrides(item_data, item_unit, parent_unit, attach_settings)

		if weapon_skin then
			instance.apply_material_overrides(weapon_skin, item_unit, parent_unit, attach_settings)
		end

		instance.add_extensions(item_unit, attachment_units_by_unit and attachment_units_by_unit[item_unit], attach_settings)
		instance.play_item_on_spawn_anim_event(item_data, parent_unit)

		return item_unit, attachment_units_by_unit, bind_pose, attachment_id_lookup, attachment_name_lookup, attachment_units_bind_poses, item_name_by_unit
	end

	instance.spawn_base_unit = function(item_data, attach_settings, parent_unit, optional_mission_template, optional_equipment, in_possesion_of_player)
		return instance._spawn_attachment(item_data, attach_settings, parent_unit, optional_mission_template, optional_equipment, nil, nil, nil, nil, nil, in_possesion_of_player)
	end

	instance.attach_hierarchy = function (attachment_slot_data, override_lookup, settings, parent_unit, parent_item_name, attachment_name, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template)
		local extract_data = instance._create_extract_data(optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names)

		instance._push_extract_data(extract_data, parent_unit, parent_item_name, attachment_name)
		instance._attach_hierarchy(attachment_slot_data, override_lookup, settings, parent_unit, attachment_name, extract_data, optional_mission_template)
		instance._pop_extract_data(extract_data, parent_unit)

		return extract_data.attachment_units_by_unit
	end

	local ignore_slot_item_assigning = table.set({
		"slot_primary",
		"slot_secondary",
	})

	-- instance._attach_hierarchy = function(attachment_slot_data, override_lookup, settings, parent_unit, attached_units, attachment_name_or_nil, attachment_name_to_unit_or_nil, attached_units_bind_poses_or_nil, optional_mission_template, optional_equipment, attachment_slot_info, item_name, in_possesion_of_player, item_data)
	instance._attach_hierarchy = function(attachment_slot_data, override_lookup, settings, parent_unit, attachment_name, extract_data, optional_mission_template, optional_equipment, attachment_slot_info, item_name, in_possesion_of_player, item_data)
		-- local item_name_ = attachment_slot_data.item
		-- local item = instance._validate_item_name(item_name_)
		-- local override_item = override_lookup[attachment_slot_data]
		-- item = override_item or item
	
		-- if type(item) == "string" then
		-- 	-- item = settings.item_definitions[item]
		-- 	item = mod:persistent_table(REFERENCE).item_definitions[item]
		-- end
	
		-- if not item then
		-- 	return attached_units, attachment_name_to_unit_or_nil, attached_units_bind_poses_or_nil
		-- end
	
		-- local attachment_unit, bind_pose = instance._spawn_attachment(item, settings, parent_unit, optional_mission_template, nil, attachment_slot_info, attachment_slot_data.attachment_type, attachment_slot_data.attachment_name, item_name, in_possesion_of_player)

		-- if optional_equipment and item.slots then
		-- 	for _, slot_name in ipairs(item.slots) do
		-- 		if optional_equipment[slot_name] then
		-- 			optional_equipment[slot_name].item = item
		-- 		end
		-- 	end
		-- end
	
		-- if attachment_unit then
		-- 	attached_units[#attached_units + 1] = attachment_unit
	
		-- 	if attachment_name_to_unit_or_nil and attachment_name_or_nil then
		-- 		attachment_name_to_unit_or_nil[attachment_name_or_nil] = attachment_unit
		-- 	end

		-- 	if attached_units_bind_poses_or_nil then
		-- 		attached_units_bind_poses_or_nil[attachment_unit] = matrix4x4_box(bind_pose)
		-- 	end
	
		-- 	local attachments = item and item.attachments
		-- 	attached_units = instance._attach_hierarchy_children(attachments, override_lookup, settings, attachment_unit, attached_units, attachment_name_or_nil, attachment_name_to_unit_or_nil, attached_units_bind_poses_or_nil, optional_mission_template, nil, attachment_slot_info, item_name, in_possesion_of_player, item_data)
		-- 	local children = attachment_slot_data.children
		-- 	attached_units = instance._attach_hierarchy_children(children, override_lookup, settings, attachment_unit, attached_units, attachment_name_or_nil, attachment_name_to_unit_or_nil, attached_units_bind_poses_or_nil, optional_mission_template, nil, attachment_slot_info, item_name, in_possesion_of_player, item_data)
		-- 	local material_overrides = {}
		-- 	local item_material_overrides = item.material_overrides
	
		-- 	if item_material_overrides then
		-- 		table_append(material_overrides, item_material_overrides)
		-- 	end
	
		-- 	local parent_material_overrides = attachment_slot_data.material_overrides
	
		-- 	if parent_material_overrides then
		-- 		table_append(material_overrides, parent_material_overrides)
		-- 	end
	
		-- 	local apply_to_parent = item.material_override_apply_to_parent
	
		-- 	if material_overrides then
		-- 		for _, material_override in pairs(material_overrides) do
		-- 			instance.apply_material_override(attachment_unit, parent_unit, apply_to_parent, material_override)
		-- 		end
		-- 	end
		-- end
	
		-- return attached_units, attachment_name_to_unit_or_nil, attached_units_bind_poses_or_nil

		local item_name = attachment_slot_data.item
		local item = instance._validate_item_name(item_name)
		local override_item = override_lookup[attachment_slot_data]

		item = override_item or item

		if type(item) == "string" then
			-- if settings.in_editor then
			-- 	if settings.item_manager and ToolsMasterItems then
			-- 		item = ToolsMasterItems:get(item)
			-- 	else
			-- 		item = rawget(settings.item_definitions, item)
			-- 	end
			-- else
			-- 	item = settings.item_definitions[item]
			-- end
			item = mod:persistent_table(REFERENCE).item_definitions[item]
		elseif item then
			item_name = item.name
		end

		if not item then
			return
		end

		local override_attach_node = attachment_slot_data.leaf_attach_node_override
		local override_map_mode = World[attachment_slot_data.link_map_mode_override]
		local attachment_unit, bind_pose = instance._spawn_attachment(item, settings, parent_unit, optional_mission_template, override_attach_node, override_map_mode, attachment_slot_info, attachment_slot_data.attachment_type, attachment_slot_data.attachment_name, item_name, in_possesion_of_player)

		if optional_equipment and item.slots then
			for _, slot_name in ipairs(item.slots) do
				if optional_equipment[slot_name] and not ignore_slot_item_assigning[slot_name] then
					optional_equipment[slot_name].item = item
				end
			end
		end

		if attachment_unit then
			instance._fill_extract_data(extract_data, attachment_name, attachment_unit, bind_pose)
			instance._push_extract_data(extract_data, attachment_unit, item_name, attachment_name)

			local attachments = item and item.attachments

			instance._attach_hierarchy_children(attachments, override_lookup, settings, attachment_unit, extract_data, optional_mission_template, attachment_slot_info, item_name, in_possesion_of_player, item_data)
			instance._pop_extract_data(extract_data, attachment_unit)

			local children = attachment_slot_data.children

			instance._attach_hierarchy_children(children, override_lookup, settings, attachment_unit, extract_data, optional_mission_template, attachment_slot_info, item_name, in_possesion_of_player, item_data)

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
					instance.apply_material_override(attachment_unit, parent_unit, apply_to_parent, material_override, settings.in_editor)
				end
			end
		end

		-- return attached_units, attachment_name_to_unit_or_nil, attached_units_bind_poses_or_nil
	end

	-- instance._attach_hierarchy_children = function(children, override_lookup, settings, parent_unit, attached_units, attachment_name_or_nil, attachment_name_to_unit_or_nil, attached_units_bind_poses_or_nil, optional_mission_template, optional_equipment, attachment_slot_info, item_name, in_possesion_of_player, item_data)
	instance._attach_hierarchy_children = function(children, override_lookup, settings, parent_unit, extract_data, optional_mission_template, attachment_slot_info, item_name, in_possesion_of_player, item_data)
		-- if children then
		-- 	for name, child_attachment_slot_data in pairs(children) do
		-- 		attached_units, attachment_name_to_unit_or_nil, attached_units_bind_poses_or_nil = instance._attach_hierarchy(child_attachment_slot_data, override_lookup, settings, parent_unit, attached_units, attachment_name_or_nil, attachment_name_to_unit_or_nil, attached_units_bind_poses_or_nil, optional_mission_template, nil, attachment_slot_info, item_name, in_possesion_of_player, item_data)
		-- 	end
		-- end
		-- return attached_units, attachment_name_to_unit_or_nil, attached_units_bind_poses_or_nil
		if children then
			for attachment_name, child_attachment_slot_data in pairs(children) do
				instance._attach_hierarchy(child_attachment_slot_data, override_lookup, settings, parent_unit, attachment_name, extract_data, optional_mission_template, nil, attachment_slot_info, item_name, in_possesion_of_player, item_data)
			end
		end
	end

	instance._validate_item_name = function(item)
		if item == "" then return nil end
		return item
	end

	-- instance._node_name_to_attachment_slot = function(item_name, node_name)
	-- 	if type(node_name) == "string" then
	-- 		local name = node_name
	-- 		-- name = string_gsub(name, "ap_", "")
	-- 		-- if mod:cached_find(name, "ap_") then
	-- 		-- 	mod:echo("node: "..tostring(name))
	-- 		-- end
	-- 		name = mod:cached_gsub(name, "ap_", "")
	-- 		-- name = string_gsub(name, "_01", "")
	-- 		name = mod:cached_gsub(name, "_01", "")
	-- 		-- name = string_gsub(name, "rp_", "")
	-- 		name = mod:cached_gsub(name, "rp_", "")
	-- 		-- name = string_gsub(name, "magazine_02", "magazine2")
	-- 		name = mod:cached_gsub(name, "magazine_02", "magazine2")
	-- 		-- if string_find(name, "chained_rig") then name = "receiver" end
	-- 		if mod:cached_find(name, "chained_rig") then name = "receiver" end
	-- 		if name == "trinket" then name = mod.anchors[item_name] and mod.anchors[item_name].trinket_slot or "slot_trinket_1" end
	-- 		return name
	-- 	end
	-- 	return "unknown"
	-- end
	instance._node_name_to_attachment_slot = function(item_name, node_name)
		if type(node_name) ~= "string" then
			return "unknown"
		end

		local name = node_name

		-- Perform string replacements using mod's cached gsub
		name = mod:cached_gsub(name, "ap_", "")
		name = mod:cached_gsub(name, "_01", "")
		name = mod:cached_gsub(name, "rp_", "")
		name = mod:cached_gsub(name, "magazine_02", "magazine2")

		-- Special case handling
		if mod:cached_find(name, "chained_rig") then
			return "receiver"
		end

		if name == "trinket" then
			local anchors = mod.anchors[item_name]
			return (anchors and anchors.trinket_slot) or "slot_trinket_1"
		end

		return name
	end

	-- instance._spawn_attachment = function(item_data, settings, parent_unit, optional_mission_template, optional_equipment, attachment_slot_info, attachment_type, attachment_name, item_name, in_possesion_of_player)
	instance._spawn_attachment = function(item_data, settings, parent_unit, optional_mission_template, optional_as_leaf_override_attach_node, optional_as_leaf_map_mode, attachment_slot_info, attachment_type, attachment_name, item_name, in_possesion_of_player)
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

		-- mod:echo(attach_node)
		-- local attach_node_name = instance._node_name_to_attachment_slot(item_name, attach_node)
		-- local attachment_slot = attachment_type or attach_node_name --instance._node_name_to_attachment_slot(item_name, attach_node)
		-- attachment_slot_info = attachment_slot_info or {}
		-- attachment_slot_info.attachment_slot_to_unit = attachment_slot_info.attachment_slot_to_unit or {}
		-- attachment_slot_info.unit_to_attachment_slot = attachment_slot_info.unit_to_attachment_slot or {}
		-- attachment_slot_info.unit_to_attachment_name = attachment_slot_info.unit_to_attachment_name or {}
		-- attachment_slot_info.attachment_slot_to_unit[attachment_slot] = spawned_unit
		-- attachment_slot_info.unit_to_attachment_slot[spawned_unit] = attachment_slot
		-- attachment_slot_info.unit_to_attachment_name[spawned_unit] = attachment_name
		-- Unit.set_data(spawned_unit, "attachment_name", attachment_name)
		-- Unit.set_data(spawned_unit, "attachment_slot", attachment_slot)
		-- Unit.set_data(spawned_unit, "parent_unit", parent_unit)
		-- Unit.set_data(spawned_unit, "parent_node", attach_node_index)
		-- Determine attachment slot only if not explicitly provided
		local attachment_slot = attachment_type or instance._node_name_to_attachment_slot(item_name, attach_node)

		-- Initialize or reuse attachment slot info tables
		attachment_slot_info = attachment_slot_info or {}
		local slot_to_unit = attachment_slot_info.attachment_slot_to_unit or {}
		local unit_to_slot = attachment_slot_info.unit_to_attachment_slot or {}
		local unit_to_name = attachment_slot_info.unit_to_attachment_name or {}

		-- Update mappings
		slot_to_unit[attachment_slot] = spawned_unit
		unit_to_slot[spawned_unit] = attachment_slot
		unit_to_name[spawned_unit] = attachment_name

		-- Reassign back in case they were nil
		attachment_slot_info.attachment_slot_to_unit = slot_to_unit
		attachment_slot_info.unit_to_attachment_slot = unit_to_slot
		attachment_slot_info.unit_to_attachment_name = unit_to_name

		-- Set unit data in one block for readability
		Unit.set_data(spawned_unit, "attachment_name", attachment_name)
		Unit.set_data(spawned_unit, "attachment_slot", attachment_slot)
		Unit.set_data(spawned_unit, "parent_unit", parent_unit)
		Unit.set_data(spawned_unit, "parent_node", attach_node_index)
	
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
					-- mod:info("instance._spawn_attachment: "..tostring(parent_unit))
					unit_set_local_position(parent_unit, backpack_offset_node_index, backpack_offset_v3)
				end
			end
		
			local bind_pose = unit_local_pose(spawned_unit, 1)
		
			if is_first_person and (show_in_1p or only_show_in_1p) then
				unit_set_unit_objects_visibility(spawned_unit, false, true, visibility_contexts.RAYTRACING_CONTEXT)
			end
		
			-- local keep_local_transform = not settings.skip_link_children and true
			local map_mode

			if optional_as_leaf_map_mode then
				map_mode = optional_as_leaf_map_mode
			elseif World[item_data.link_map_mode] then
				map_mode = World[item_data.link_map_mode]
			elseif settings.skip_link_children then
				map_mode = World.LINK_MODE_NONE
			else
				map_mode = World.LINK_MODE_NODE_NAME
			end
		
			-- world_link_unit(settings.world, spawned_unit, 1, parent_unit, attach_node_index, keep_local_transform)
			World.link_unit(settings.world, spawned_unit, 1, parent_unit, attach_node_index, map_mode)
		
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

	instance._generate_attachment_overrides_recursive = function(attachment_slot_data, override_slot_data, override_lookup, item_data)
		if not override_slot_data then
			return
		end
	
		local override_item_name = instance._validate_item_name(override_slot_data.item)
	
		if override_item_name then
			override_lookup[attachment_slot_data] = override_item_name
			-- local gear_id = mod.gear_settings:item_to_gear_id(item_data)
			-- override_lookup[gear_id..attachment_slot_data.attachment_type] = override_item_name
		end
	
		local children = attachment_slot_data.children
		local override_children = override_slot_data.children
	
		for name, data in pairs(children) do
			local override_data = override_children[name]
	
			instance._generate_attachment_overrides_recursive(data, override_data, override_lookup, item_data)
		end
	end

	instance.generate_attachment_overrides_lookup = function (item_data, override_item_data, in_possesion_of_player)
		mod:setup_item_definitions()

		local weapon_item = item_data.item_type == "WEAPON_MELEE" or item_data.item_type == "WEAPON_RANGED"
		local player_item = item_data.item_list_faction == "Player"

		if weapon_item and player_item and not mod:is_premium_store_item() then
			override_item_data = override_item_data or {}
			override_item_data.attachments = override_item_data.attachments or {}
			-- local attachments = item_data.attachments
			local gear_id = mod.gear_settings:item_to_gear_id(item_data)
			-- Add custom attachments
			mod.gear_settings:_add_custom_attachments(item_data, item_data.attachments)
			mod.gear_settings:_add_custom_attachments(item_data, override_item_data.attachments)
			-- Overwrite attachments
			mod.gear_settings:_overwrite_attachments(item_data, item_data.attachments)
			mod.gear_settings:_overwrite_attachments(item_data, override_item_data.attachments)
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
	
			instance._generate_attachment_overrides_recursive(attachment_slot_data, override_slot_data, override_lookup, item_data)
		end
	
		return override_lookup
	end

	-- ################################################################################################################
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

	-- ################################################################################################################
	instance._apply_material_override = function(unit, material_override_data)
		-- if material_override_data.property_overrides ~= nil then
		-- 	for property_name, property_override_data in pairs(material_override_data.property_overrides) do
		-- 		-- mod:echo("_apply_material_override property", property_name, property_override_data)
		-- 		if type(property_override_data) == "number" then
		-- 			Unit_set_scalar_for_materials(unit, property_name, property_override_data, true)
		-- 		else
		-- 			local property_override_data_num = #property_override_data
	
		-- 			if property_override_data_num == 1 then
		-- 				Unit_set_scalar_for_materials(unit, property_name, property_override_data[1], true)
		-- 			elseif property_override_data_num == 2 then
		-- 				Unit_set_vector2_for_materials(unit, property_name, vector2(property_override_data[1], property_override_data[2]), true)
		-- 			elseif property_override_data_num == 3 then
		-- 				Unit_set_vector3_for_materials(unit, property_name, vector3(property_override_data[1], property_override_data[2], property_override_data[3]), true)
		-- 			elseif property_override_data_num == 4 then
		-- 				Unit_set_vector4_for_materials(unit, property_name, color(property_override_data[1], property_override_data[2], property_override_data[3], property_override_data[4]), true)
		-- 			end
		-- 		end
		-- 	end
		-- end
	
		-- if material_override_data.texture_overrides ~= nil then
		-- 	for texture_slot, texture_override_data in pairs(material_override_data.texture_overrides) do
		-- 		-- mod:echo("_apply_material_override texture", texture_slot, texture_override_data.resource)
		-- 		Unit_set_texture_for_materials(unit, texture_slot, texture_override_data.resource, true)
		-- 	end
		-- end

		if material_override_data.property_overrides ~= nil then
			for property_name, property_override_data in pairs(material_override_data.property_overrides) do
				if type(property_override_data) == "number" then
					Unit_set_scalar_for_materials(unit, property_name, property_override_data, true)
				else
					local property_override_data_num = #property_override_data

					if property_override_data_num == 1 then
						Unit_set_scalar_for_materials(unit, property_name, property_override_data[1], true)
					elseif property_override_data_num == 2 then
						Unit_set_vector2_for_materials(unit, property_name, Vector2(property_override_data[1], property_override_data[2]), true)
					elseif property_override_data_num == 3 then
						Unit_set_vector3_for_materials(unit, property_name, Vector3(property_override_data[1], property_override_data[2], property_override_data[3]), true)
					elseif property_override_data_num == 4 then
						Unit_set_vector4_for_materials(unit, property_name, Color(property_override_data[1], property_override_data[2], property_override_data[3], property_override_data[4]), true)
					end
				end
			end
		end

		if material_override_data.texture_overrides ~= nil then
			for texture_slot, texture_override_data in pairs(material_override_data.texture_overrides) do
				if texture_override_data.resource_by_item == nil then
					Unit_set_texture_for_materials(unit, texture_slot, texture_override_data.resource, true)
				else
					local resources = texture_override_data.resource_by_item
					local items_array_size = Unit.data_table_size(unit, "attached_item_names") or 0

					for i = 1, items_array_size do
						local resource = resources[Unit.get_data(unit, "attached_item_names", i)]

						if resource ~= nil then
							Unit_set_texture_for_materials(unit, texture_slot, resource, true)
						end
					end
				end
			end
		end
	end

end)

-- mod:hook(CLASS.MinionSpawnManager, "spawn_minion", function(func, self, breed_name, position, rotation, side_id, optional_param_table, ...)
-- 	-- Original function
-- 	local unit = func(self, breed_name, position, rotation, side_id, optional_param_table, ...)
-- 	-- Add
-- 	mod.minion_options[unit] = {
-- 		no_drop = true
-- 	}
-- 	-- Return
-- 	return unit
-- end)

-- mod:hook(CLASS.MinionDeathManager, "die", function(func, self, unit, attacking_unit_or_nil, attack_direction, hit_zone_name_or_nil, damage_profile, attack_type_or_nil, herding_template_or_nil, damage_type_or_nil, ...)
-- 	-- Original function
-- 	func(self, unit, attacking_unit_or_nil, attack_direction, hit_zone_name_or_nil, damage_profile, attack_type_or_nil, herding_template_or_nil, damage_type_or_nil, ...)
-- 	-- Remove
-- 	mod.minion_options[unit] = nil
-- end)

-- mod:hook(CLASS.MinionVisualLoadoutExtension, "_drop_slot", function(func, self, slot_name, ...)
-- 	if mod.minion_options[self._unit] and mod.minion_options[self._unit].no_drop then
-- 		-- MinionAttack.trigger_shoot_sfx_and_vfx(self._unit, scratchpad, action_data, optional_end_position)

-- 		-- local fx_extension = ScriptUnit.extension(self._unit, "fx_system")
		
-- 		-- fx_extension:trigger_inventory_wwise_event(shoot_event_name, inventory_slot_name, fx_source_name, target_unit, is_ranged_attack)

-- 		return
-- 	end
-- end)