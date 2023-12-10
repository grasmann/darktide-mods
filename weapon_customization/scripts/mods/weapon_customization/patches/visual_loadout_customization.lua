local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local ItemMaterialOverrides = mod:original_require("scripts/settings/equipment/item_material_overrides/item_material_overrides")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
	local table = table
	local table_contains = table.contains
	local table_keys = table.keys
	local table_sort = table.sort
	local table_find = table.find
	local table_remove = table.remove
	local table_append = table.append
	local table_set_readonly = table.set_readonly
	local table_clone = table.clone
	local Unit = Unit
	local unit_set_data = Unit.set_data
	local unit_debug_name = Unit.debug_name
	local unit_alive = Unit.alive
	local unit_set_local_position = Unit.set_local_position
	local unit_set_local_rotation = Unit.set_local_rotation
	local unit_set_local_scale = Unit.set_local_scale
	local unit_local_position = Unit.local_position
	local unit_local_rotation = Unit.local_rotation
	local unit_world_position = Unit.world_position
	local unit_world_rotation = Unit.world_rotation
	local unit_local_pose = Unit.local_pose
	local unit_has_node = Unit.has_node
	local unit_node = Unit.node
	local unit_world_pose = Unit.world_pose
	local unit_set_animation_state_machine = Unit.set_animation_state_machine
	local unit_has_lod_object = Unit.has_lod_object
	local unit_lod_object = Unit.lod_object
	local unit_set_unit_objects_visibility = Unit.set_unit_objects_visibility
	local unit_set_unit_culling = Unit.set_unit_culling
	local unit_set_sort_order = Unit.set_sort_order
	local unit_num_meshes = Unit.num_meshes
	local unit_mesh = Unit.mesh
	local unit_set_mesh_visibility = Unit.set_mesh_visibility
	local unit_set_unit_visibility = Unit.set_unit_visibility
	local Unit_set_scalar_for_materials = Unit.set_scalar_for_materials
	local Unit_set_vector2_for_materials = Unit.set_vector2_for_materials
	local Unit_set_vector3_for_materials = Unit.set_vector3_for_materials
	local Unit_set_vector4_for_materials = Unit.set_vector4_for_materials
	local Unit_set_texture_for_materials = Unit.set_texture_for_materials
	local Mesh = Mesh
	local mesh_local_position = Mesh.local_position
	local Quaternion = Quaternion
	local quaternion_to_euler_angles_xyz = Quaternion.to_euler_angles_xyz
	local quaternion_from_euler_angles_xyz = Quaternion.from_euler_angles_xyz
	local quaternion_matrix4x4 = Quaternion.matrix4x4
	local string = string
	local string_gsub = string.gsub
	local string_find = string.find
	local string_split = string.split
	local vector2 = Vector2
	local vector3 = Vector3
	local vector3_box = Vector3Box
	local vector3_unbox = vector3_box.unbox
	local vector3_zero = vector3.zero
	local vector3_one = vector3.one
	local matrix4x4_box = Matrix4x4Box
	local World = World
	local world_unlink_unit = World.unlink_unit
	local world_link_unit = World.link_unit
	local world_spawn_unit_ex = World.spawn_unit_ex
	local lod_group_add_lod_object = LODGroup.add_lod_object
	local lod_object_set_static_select = LODObject.set_static_select
	local log_info = Log.info
	local pairs = pairs
	local type = type
	local tonumber = tonumber
	local visibility_contexts = VisibilityContexts
	local CLASS = CLASS
	local color = Color
	local rawget = rawget
    local Level = Level
    local level_units = Level.units
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"
local attachment_setting_overwrite = {
	slot_trinket_1 = "slot_trinket_1",
	slot_trinket_2 = "slot_trinket_2",
	help_sight = "bolter_sight_01",
}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

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

mod:hook(CLASS.ExtensionManager, "unregister_unit", function(func, self, unit, ...)
    if unit and unit_alive(unit) then
        func(self, unit, ...)
    end
end)

mod._add_custom_attachments = function(self, item, attachments)
	local gear_id = self:get_gear_id(item)
	if gear_id and attachments then
		-- Get item name
		local item_name = self:item_name_from_content_string(item.name)
		-- Save original attachments
		if item.__master_item and not item.__master_item.original_attachments then
			item.__master_item.original_attachments = table_clone(attachments)
		elseif not item.original_attachments then
			item.original_attachments = table_clone(attachments)
		end
		-- Iterate custom attachment slots
		for attachment_slot, attachment_table in pairs(self.add_custom_attachments) do
			-- Get weapon setting for attachment slot
			local attachment_setting = self:get_gear_setting(gear_id, attachment_slot, item)
			local attachment = self:_recursive_find_attachment(attachments, attachment_slot)
			-- Overwrite specific attachment settings
			if table_contains(attachment_setting_overwrite, attachment_slot) then
				attachment_setting = attachment_setting_overwrite[attachment_slot]
			end
			-- if attachment_slot == "slot_trinket_1" then attachment_setting = "slot_trinket_1" end
			-- if attachment_slot == "slot_trinket_2" then attachment_setting = "slot_trinket_2" end
			-- if attachment_slot == "help_sight" then attachment_setting = "bolter_sight_01" end
			if table_contains(self[attachment_table], attachment_setting) then
				-- Get attachment data
				local attachment_data = self.attachment_models[item_name] and self.attachment_models[item_name][attachment_setting]
				if attachment_data and attachment_data.parent then
					-- Set attachment parent
					local parent = attachments
					local has_original_parent, original_parent = self:_recursive_find_attachment_parent(attachments, attachment_slot)
					if has_original_parent and attachment_data.parent ~= original_parent then
						self:_recursive_remove_attachment(attachments, attachment_slot)
					end
					local parent_slot = self:_recursive_find_attachment(attachments, attachment_data.parent)
					parent = parent_slot and parent_slot.children or parent
					-- Children
					local original_children = {}
					if attachment and attachment.children then
						original_children = table_clone(attachment.children)
					end
					-- Value
					local original_value = nil
					if attachment and attachment.item and attachment.item ~= "" then
						original_value = attachment and attachment.item
					end
					-- Attach custom slot
					parent[attachment_slot] = {
						children = original_children,
						item = original_value or attachment_data.model,
						attachment_type = attachment_slot,
            			attachment_name = attachment_setting,
					}
				end
			end
		end
	end
end

mod._apply_anchor_fixes = function(self, item, unit_or_name)
	-- if item and self:is_composite_item(item.name) then
	-- 	if item.anchors[unit_or_name] then
	-- 		mod:echo(tostring(item.anchors[unit_or_name]))
	-- 		return item.anchors[unit_or_name]
	-- 	end
	-- end
	if item and item.attachments then
		local gear_id = self:get_gear_id(item)
		local slot_infos = self:persistent_table(REFERENCE).attachment_slot_infos
		local slot_info_id = self:get_slot_info_id(item)
		local item_name = self:item_name_from_content_string(item.name)

		-- -- Default
		-- if type(unit_or_name) == "string" and string_find(unit_or_name, "default") then
		-- 	mod:echo("default: "..tostring(unit_or_name))
		-- 	local attachment_data = self.attachment_models[item_name][unit_or_name]
		-- 	local attachment_slot = attachment_data and attachment_data.type
		-- 	unit_or_name = attachment_slot and self:get_gear_setting(gear_id, attachment_slot, item) or unit_or_name
		-- 	mod:echo("attachment: "..tostring(unit_or_name))
		-- end

		local attachments = item.attachments
		if gear_id then
			-- Fixes
			if self.anchors[item_name] and self.anchors[item_name].fixes then
				local fixes = self.anchors[item_name].fixes
				for _, fix_data in pairs(fixes) do
					-- Dependencies
					local has_dependencies = false
					local no_dependencies = false
					if fix_data.dependencies then
						for _, dependency_entry in pairs(fix_data.dependencies) do
							-- local sets = string_split(dependency_entry, ",")
							-- for _, set in pairs(sets) do
							-- if not string_find(dependency_entry, ",") then
								local dependency_possibilities = string_split(dependency_entry, "|")
								local has_dependency_possibility = false

								for _, dependency_possibility in pairs(dependency_possibilities) do
									local negative = string_find(dependency_possibility, "!")
									dependency_possibility = string_gsub(dependency_possibility, "!", "")
									if self.attachment_models[item_name] and self.attachment_models[item_name][dependency_possibility] then
										-- local model_string = self.attachment_models[item_name][dependency].model
										if negative then
											has_dependency_possibility = not self:_recursive_find_attachment_name(attachments, dependency_possibility)
										else
											has_dependency_possibility = self:_recursive_find_attachment_name(attachments, dependency_possibility)
										end
										if has_dependency_possibility then break end
									elseif table_contains(self.attachment_slots, dependency_possibility) then
										if negative then
											has_dependency_possibility = not self:_recursive_find_attachment(attachments, dependency_possibility)
										else
											has_dependency_possibility = self:_recursive_find_attachment(attachments, dependency_possibility)
										end
										if has_dependency_possibility then break end
									end
								end

								has_dependencies = has_dependency_possibility
								if not has_dependencies then break end
							-- end
						end
					else
						no_dependencies = true
					end
					if has_dependencies or no_dependencies then
						for fix_attachment, fix in pairs(fix_data) do
							-- Attachment
							if slot_infos and slot_infos[slot_info_id] then
								local attachment_slot_info = slot_infos[slot_info_id]
								if self.attachment_models[item_name] and self.attachment_models[item_name][fix_attachment] then
									-- local model_string = self.attachment_models[item_name][fix_attachment].model
									local has_fix_attachment = self:_recursive_find_attachment_name(attachments, fix_attachment)
									local fix_attachment_slot = self.attachment_models[item_name][fix_attachment].type
									if has_fix_attachment and fix_attachment_slot and unit_or_name == attachment_slot_info.attachment_slot_to_unit[fix_attachment_slot] then
										return fix
									end
								end
								-- Slot
								if unit_or_name == attachment_slot_info.attachment_slot_to_unit[fix_attachment] then
									return fix
								end
							end
							-- Scope offset etc
							if unit_or_name == fix_attachment then
								return fix
							end
						end
					end
				end
			end
		else self:print("slot_info is nil") end
	end
end

-- ##### ┬ ┬┌─┐┌─┐┬┌─┌─┐ ##############################################################################################
-- ##### ├─┤│ ││ │├┴┐└─┐ ##############################################################################################
-- ##### ┴ ┴└─┘└─┘┴ ┴└─┘ ##############################################################################################

mod.execute_hide_meshes = function(self, item, attachment_units)
	local gear_id = self:get_gear_id(item)
	local slot_info_id = self:get_slot_info_id(item)
	local slot_infos = mod:persistent_table(REFERENCE).attachment_slot_infos
	local item_name = self:item_name_from_content_string(item.name)
	for _, unit in pairs(attachment_units) do
		if slot_infos[slot_info_id] then
			local attachment_name = slot_infos[slot_info_id].unit_to_attachment_name[unit]
			local attachment_data = attachment_name and mod.attachment_models[item_name] and mod.attachment_models[item_name][attachment_name]
			-- Hide meshes
			local hide_mesh = attachment_data and attachment_data.hide_mesh
			-- Get fixes
			local fixes = mod:_apply_anchor_fixes(item, unit)
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

local output_index = 1
-- Visual loadout extension hooks
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
		local in_possesion_of_player = mod:item_in_possesion_of_player(item_data)
		local in_store = mod:item_in_store(item_data)
		-- if in_possesion_of_player and gear_id then
		-- 	-- mod:echo("In possesion of player: "..tostring(gear_id))
		-- end
		-- if in_store == "store" and gear_id then
		-- 	if not mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] then
		-- 		local master_item = item_data.__master_item or item_data
		-- 		local random_attachments = mod:randomize_weapon(master_item)
		-- 		mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] = random_attachments
		-- 	end
		-- 	-- mod:echo("In store: "..tostring(gear_id).." - "..tostring(in_store))
		-- end
		-- if output_index < 20 then
		-- 	mod:echo("In possesion of player: "..tostring(in_possesion_of_player))
		-- 	-- mod:echo("In store: "..tostring(in_store))
		-- 	output_index = output_index + 1
		-- end
		local attachment_slot_info = {}

		if item_unit and attachments and gear_id and (not item_data.premium_store_item or in_possesion_of_player) then
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

		if attachment_units and item_unit and attachments and gear_id and not item_data.premium_store_item then

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

				-- -- Bulwark shield
				-- if unit_name == "#ID[bc25db1df0670d2a]" then
				-- 	mod:echo("bulwark!")
				-- 	unit_set_local_position(unit, 1, unit_local_position(unit, 1) + vector3(0, 0, -.065))
				-- 	local x, y, z = quaternion_to_euler_angles_xyz(unit_local_rotation(unit, 1))
				-- 	local rotation = vector3(x, y, z) + vector3(-10, 5, 5)
				-- 	local rotate_quaternion = quaternion_from_euler_angles_xyz(rotation[1], rotation[2], rotation[3])
				-- 	unit_set_local_rotation(unit, 1, rotate_quaternion)
				-- 	unit_set_local_scale(unit, 1, vector3(1, 1, 0.9))
				-- end

				-- Handle positioning and setup infos
				if slot_infos[slot_info_id] then
					local attachment_name = slot_infos[slot_info_id].unit_to_attachment_name[unit]
					local attachment_slot = slot_infos[slot_info_id].unit_to_attachment_slot[unit]
					-- -- Default
					-- if attachment_name and string_find(attachment_name, "default") then
					-- 	mod:echo("default: "..tostring(attachment_name))
					-- 	-- local attachment_data = self.attachment_models[item_name][unit_or_name]
					-- 	-- local attachment_slot = attachment_data and attachment_data.type
					-- 	-- attachment_name = mod:get_actual_default_attachment(item_data, attachment_slot) or attachment_name
					-- 	local item = item_data.__master_item or item_data
					-- 	attachment_name = attachment_slot and mod:get_gear_setting(gear_id, attachment_slot, item_data) or attachment_name
					-- 	mod:echo("attachment: "..tostring(attachment_name))
					-- end
					local attachment_data = attachment_name and mod.attachment_models[item_name] and mod.attachment_models[item_name][attachment_name]
					
					-- if item_data.anchors and self:is_composite_item(item_data.name) then
					-- 	attachment_data = item_data.anchors[attachment_slot]
					-- end

					local parent_name = attachment_data and attachment_data.parent and attachment_data.parent
					local parent_node = attachment_data and attachment_data.parent_node and attachment_data.parent_node or 1

					

					-- if attachment_name == "scope" then
					-- 	local num_meshes = unit_num_meshes(unit)
					-- 	-- mod:echo("scope - "..tostring(num_meshes))
					-- 	if unit and unit_alive(unit) then
					-- 		unit_set_mesh_visibility(unit, 1, false)
					-- 		unit_set_mesh_visibility(unit, 2, false)
					-- 		unit_set_mesh_visibility(unit, 3, false)
					-- 		unit_set_mesh_visibility(unit, 5, false)
					-- 		unit_set_mesh_visibility(unit, 6, false)
					-- 		unit_set_mesh_visibility(unit, 7, false)
					-- 		local check_groups = {"receiver", "main", "barrel", "scope", "a", "front_walls"}
					-- 		for _, group in pairs(check_groups) do
					-- 			if Unit.has_visibility_group(unit, group) then
					-- 				mod:echo(group)
					-- 			end
					-- 		end
					-- 		-- local childs = Unit.get_child_units(unit)
					-- 		-- if childs then
					-- 		-- 	mod:echo("childs "..tostring(#childs))
					-- 		-- end
					-- 	end
					-- 	-- unit_set_local_position(unit, mod.test_index, vector3(0, 0, .1))
					-- 	-- unit_set_local_scale(unit, 38, vector3(3, 3, 3))
					-- end

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
							unit_set_local_scale(unit, scale_node, scale)

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

			-- if mod.cosmetics_view and mod.cosmetics_view._fade_system then
			-- 	local unit_item_offsets = {}
			-- 	-- for _, unit in pairs(attachment_units) do
			-- 	for i = #attachment_units, 1, -1 do
			-- 		local unit = attachment_units[i]
			-- 		world_unlink_unit(attach_settings.world, unit, true)
			-- 		local offset = unit_world_position(item_unit, 1) - unit_world_position(unit, 1)
			-- 		local unit_rotation = unit_world_rotation(item_unit, 1)
			-- 		local mat = quaternion_matrix4x4(unit_rotation)
			-- 		local rotated_offset = Matrix4x4.transform(mat, offset)
			-- 		unit_item_offsets[unit] = rotated_offset
			-- 	end
			-- 	for _, unit in pairs(attachment_units) do
			-- 		-- local offset = unit_world_position(item_unit, 1) - unit_world_position(unit, 1)
			-- 		local offset = unit_item_offsets[unit]
			-- 		-- local unit_rotation = unit_world_rotation(item_unit, 1)
			-- 		-- local mat = quaternion_matrix4x4(unit_rotation)
			-- 		-- local rotated_offset = Matrix4x4.transform(mat, offset)
			-- 		-- world_unlink_unit(attach_settings.world, unit)
			-- 		world_link_unit(attach_settings.world, unit, 1, item_unit, 1)
			-- 		unit_set_local_position(unit, 1, offset)
			-- 		-- mod:unit_set_local_position_mesh(slot_info_id, unit, offset)
					
			-- 		slot_infos[slot_info_id].unit_default_position[unit] = vector3_box(unit_local_position(unit, 1))
			-- 		-- Set unit mesh default positions
			-- 		mod.mesh_positions[unit] = mod.mesh_positions[unit] or {}
			-- 		local num_meshes = unit_num_meshes(unit)
			-- 		for i = 1, num_meshes do
			-- 			mod.mesh_positions[unit][i] = vector3_box(mesh_local_position(unit_mesh(unit, i)))
			-- 		end
			-- 	end
			-- end

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
		local in_possesion_of_player = mod:item_in_possesion_of_player(item_data)
		local in_store = mod:item_in_store(item_data)
		-- if in_possesion_of_player and gear_id then
		-- 	-- mod:echo("In possesion of player: "..tostring(gear_id))
		-- end
		-- if in_store == "store" and gear_id then
		-- 	if not mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] then
		-- 		local master_item = item_data.__master_item or item_data
		-- 		local random_attachments = mod:randomize_weapon(master_item)
		-- 		mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] = random_attachments
		-- 	end
		-- 	-- mod:echo("In store: "..tostring(gear_id).." - "..tostring(in_store))
		-- end

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
		local name = node_name
		name = string_gsub(name, "ap_", "")
		name = string_gsub(name, "_01", "")
		name = string_gsub(name, "rp_", "")
		name = string_gsub(name, "magazine_02", "magazine2")
		if string_find(name, "chained_rig") then name = "receiver" end
		if name == "trinket" then name = mod.anchors[item_name] and mod.anchors[item_name].trinket_slot or "slot_trinket_1" end
		return name
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

		if type(attach_node) == "string" then
			local attachment_slot = attachment_type or instance._node_name_to_attachment_slot(item_name, attach_node)
			-- if item_data.base_unit ~= "content/characters/empty_item/empty_item" then
				attachment_slot_info = attachment_slot_info or {}
				attachment_slot_info.attachment_slot_to_unit = attachment_slot_info.attachment_slot_to_unit or {}
				attachment_slot_info.unit_to_attachment_slot = attachment_slot_info.unit_to_attachment_slot or {}
				attachment_slot_info.unit_to_attachment_name = attachment_slot_info.unit_to_attachment_name or {}
				attachment_slot_info.attachment_slot_to_unit[attachment_slot] = spawned_unit
				attachment_slot_info.unit_to_attachment_slot[spawned_unit] = attachment_slot
				attachment_slot_info.unit_to_attachment_name[spawned_unit] = attachment_name
				Unit.set_data(spawned_unit, "attachment_name", attachment_name)
				Unit.set_data(spawned_unit, "attachment_slot", attachment_slot)
				-- mod:echo("spawn "..tostring(attachment_name))
				-- if item_data.anchors and mod:is_composite_item(item_data.name) then
				-- 	Unit.set_data(spawned_unit, "anchor", item_data.anchors[attachment_slot])
				-- 	-- mod:dtf(item_data.anchors[attachment_slot], "item_data.anchors["..tostring(attachment_slot).."]", 5)
				-- 	-- attachment_data = item_data.anchors[attachment_slot]
				-- 	-- Unit.set_data(spawned_unit, "composite_anchor", item_data.anchors[attachment_slot])
				-- end
			-- end
		end
	
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

			local in_possesion_of_player = mod:item_in_possesion_of_player(item_data)
			local in_store = mod:item_in_store(item_data)
			-- if in_possesion_of_player and gear_id then
			-- 	-- mod:echo("In possesion of player: "..tostring(gear_id))
			-- end
			-- if in_store == "store" and gear_id then
			-- 	if not mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] then
			-- 		local master_item = item_data.__master_item or item_data
			-- 		local random_attachments = mod:randomize_weapon(master_item)
			-- 		mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] = random_attachments
			-- 	end
			-- 	-- mod:echo("In store: "..tostring(gear_id).." - "..tostring(in_store))
			-- end

			if gear_id and not item_data.premium_store_item then
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
