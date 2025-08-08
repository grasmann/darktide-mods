local mod = get_mod("visual_loadout_customization_community_patch")

-- # Game Version 1.8.4

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local ItemMaterialOverrides = mod:original_require("scripts/settings/equipment/item_material_overrides/item_material_overrides")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local log = Log
    local type = type
    local unit = Unit
    local table = table
    local pairs = pairs
    local world = World
    local color = Color
    local rawget = rawget
    local ipairs = ipairs
    local string = string
    local vector3 = Vector3
    local vector2 = Vector2
    local Log_info = log.info
    local tonumber = tonumber
    local lod_group = LODGroup
    local table_set = table.set
    local unit_node = unit.node
    local lod_object = LODObject
    local table_keys = table.keys
    local table_sort = table.sort
    local table_find = table.find
    local table_remove = table.remove
    local matrix4x4_box = Matrix4x4Box
    local string_format = string.format
    local unit_set_data = unit.set_data
    local unit_get_data = unit.get_data
    local unit_has_node = unit.has_node
    local unit_local_pose = unit.local_pose
    local unit_world_pose = unit.world_pose
    local unit_lod_object = unit.lod_object
    local ToolsMasterItems = ToolsMasterItems
    local table_set_readonly = table.set_readonly
    local visibility_contexts = VisibilityContexts
    local world_spawn_unit_ex = world.spawn_unit_ex
    local unit_set_sort_order = unit.set_sort_order
    local unit_has_lod_object = unit.has_lod_object
    local unit_data_table_size = unit.data_table_size
    local unit_animation_event = unit.animation_event
    local unit_set_unit_culling = unit.set_unit_culling
    local unit_set_local_position = unit.set_local_position
    local unit_has_animation_event = unit.has_animation_event
    local lod_group_add_lod_object = lod_group.add_lod_object
    local lod_object_set_static_select = lod_object.set_static_select
    local Unit_set_scalar_for_materials = unit.set_scalar_for_materials
    local Unit_set_texture_for_material = unit.set_texture_for_material
    local Unit_set_vector2_for_materials = unit.set_vector2_for_materials
    local Unit_set_vector3_for_materials = unit.set_vector3_for_materials
    local Unit_set_vector4_for_materials = unit.set_vector4_for_materials
    local Unit_set_texture_for_materials = unit.set_texture_for_materials
    local unit_has_animation_state_machine = unit.has_animation_state_machine
    local unit_set_unit_objects_visibility = unit.set_unit_objects_visibility
    local unit_set_animation_state_machine = unit.set_animation_state_machine
-- #endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _sort_order_enum = {
	FACE_HAIR = 2,
	FACE_SCAR = 1,
	HAIR = 3,
}
local ignore_slot_item_assigning = table_set({
	"slot_primary",
	"slot_secondary",
})
local temp_units = {}
local _empty_overrides_table = table_set_readonly({})

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #############################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################################################

mod:hook_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization", function(instance)

    -- ##### ┌─┐┌─┐┌┬┐┬┌┬┐┬┌─┐┌─┐┌┬┐  ┌┬┐┌─┐┌─┐┌─┐┬ ┬┬ ┌┬┐ ############################################################
    -- ##### │ │├─┘ │ │││││┌─┘├┤  ││   ││├┤ ├┤ ├─┤│ ││  │  ############################################################
    -- ##### └─┘┴   ┴ ┴┴ ┴┴└─┘└─┘─┴┘  ─┴┘└─┘└  ┴ ┴└─┘┴─┘┴  ############################################################

    instance.spawn_item = function (item_data, attach_settings, parent_unit, optional_map_attachment_name_to_unit,
            optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template,
            optional_equipment)
        local weapon_skin = instance.validate_item_name(item_data.slot_weapon_skin)

        if type(weapon_skin) == "string" then
            if attach_settings.in_editor then
                if attach_settings.item_manager and ToolsMasterItems then
                    weapon_skin = ToolsMasterItems:get(weapon_skin)
                else
                    weapon_skin = rawget(attach_settings.item_definitions, weapon_skin)
                end
            else
                weapon_skin = attach_settings.item_definitions[weapon_skin]
            end
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

    instance._create_extract_data = function (map_attachment_units, map_bind_poses, map_item_names)
        local extract_data = {
            parents = {},
            attachment_units_by_unit = {},
            item_name_by_unit = map_item_names and {} or nil,
            bind_poses_by_unit = map_bind_poses and {} or nil,
            attachment_id_lookup = map_attachment_units and {} or nil,
            attachment_name_lookup = map_attachment_units and {} or nil,
        }

        return extract_data
    end

    instance._push_extract_data = function (extract_data, item_unit, item_name, attachment_key_or_nil)
        if extract_data.attachment_id_lookup then
            local parent_id = extract_data.attachment_id_lookup[extract_data.parents[#extract_data.parents]]
            local unique_id

            if not parent_id then
                unique_id = instance.ROOT_ATTACH_NAME
            elseif parent_id == instance.ROOT_ATTACH_NAME then
                unique_id = attachment_key_or_nil
            else
                unique_id = string_format("%s.%s", parent_id, attachment_key_or_nil)
            end

            extract_data.attachment_id_lookup[item_unit] = unique_id
            extract_data.attachment_id_lookup[unique_id] = item_unit
        end

        extract_data.parents[#extract_data.parents + 1] = item_unit
        extract_data.attachment_units_by_unit[item_unit] = {}

        if extract_data.item_name_by_unit then
            extract_data.item_name_by_unit[item_unit] = item_name
        end

        if extract_data.attachment_name_lookup then
            extract_data.attachment_name_lookup[item_unit] = {}
        end

        if extract_data.bind_poses_by_unit then
            extract_data.bind_poses_by_unit[item_unit] = {}
        end
    end

    instance._pop_extract_data = function (extract_data, expected_parent)
        extract_data.parents[#extract_data.parents] = nil
    end

    instance._fill_extract_data = function (extract_data, attachment_name, attachment_unit, bind_pose)
        local parents = extract_data.parents
        local attachment_units_by_unit = extract_data.attachment_units_by_unit
        local attachment_name_lookup = extract_data.attachment_name_lookup
        local bind_poses_by_unit = extract_data.bind_poses_by_unit
        local bind_pose_boxed = matrix4x4_box(bind_pose)

        for i = 1, #parents do
            local parent_unit = parents[i]

            attachment_units_by_unit[parent_unit][#attachment_units_by_unit[parent_unit] + 1] = attachment_unit

            if attachment_name_lookup then
                local attachments = attachment_name_lookup[parent_unit]

                if not attachments[attachment_name] then
                    attachments[attachment_name] = attachment_unit
                    attachments[attachment_unit] = attachment_name
                end
            end

            if bind_poses_by_unit then
                local bind_poses = bind_poses_by_unit[parent_unit]

                bind_poses[attachment_unit] = bind_pose_boxed
            end
        end
    end

    instance.apply_material_overrides = function (item_data, item_unit, parent_unit, attach_settings)
        local material_overrides = item_data.material_overrides
        local apply_to_parent = item_data.material_override_apply_to_parent

        if item_unit and material_overrides then
            for _, material_override in pairs(material_overrides) do
                instance.apply_material_override(item_unit, parent_unit, apply_to_parent, material_override, attach_settings.in_editor)
            end
        end
    end

    instance.add_extensions = function (item_unit_or_nil, attachment_units_or_nil, attach_settings)
        if attach_settings.spawn_with_extensions then
            local world = attach_settings.world
            local extension_manager = attach_settings.extension_manager

            if item_unit_or_nil then
                temp_units[1] = item_unit_or_nil

                extension_manager:add_and_register_units(world, temp_units, 1)
            end

            if attachment_units_or_nil then
                extension_manager:add_and_register_units(world, attachment_units_or_nil)
            end
        end
    end

    instance.play_item_on_spawn_anim_event = function (item_data, parent_unit)
        local event_in_parent_state_machine = item_data.event_in_parent_state_machine

        if event_in_parent_state_machine and event_in_parent_state_machine ~= "" and unit_has_animation_state_machine(parent_unit) and unit_has_animation_event(parent_unit, event_in_parent_state_machine) then
            unit_animation_event(parent_unit, event_in_parent_state_machine)
        end
    end

    instance.validate_item_name = function(item)
        if item == "" then return nil end
        return item
    end

    -- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐┌┬┐  ┌─┐┌─┐┬─┐  ┌─┐┌┐  ┬┌─┐┌─┐┌┬┐  ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ###########################
    -- ##### │ │├─┘ ││├─┤ │ ├┤  ││  ├┤ │ │├┬┘  │ │├┴┐ │├┤ │   │   ├┤ │ │││││   │ ││ ││││└─┐ ###########################
    -- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘─┴┘  └  └─┘┴└─  └─┘└─┘└┘└─┘└─┘ ┴   └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ###########################

    instance.spawn_base_unit = function (item_data, attach_settings, parent_unit, optional_mission_template, optional_equipment)
        return instance.spawn_attachment(item_data, attach_settings, parent_unit, optional_mission_template, optional_equipment)
    end

    instance.spawn_item_attachments = function (item_data, override_lookup, attach_settings, item_unit,
            optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names,
            optional_mission_template, optional_equipment)
        if not item_unit then return nil, nil, nil, nil end

        local extract_data = instance._create_extract_data(optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names)

        instance._push_extract_data(extract_data, item_unit, item_data.name, nil)

        local attachments = item_data.attachments

        if attachments then
            local attachment_names = table_keys(attachments)

            table_sort(attachment_names)

            local skin_color_slot_name = "slot_body_skin_color"
            local skin_color_slot_index = table_find(attachment_names, skin_color_slot_name)

            if skin_color_slot_index then
                table_remove(attachment_names, skin_color_slot_index)

                attachment_names[#attachment_names + 1] = skin_color_slot_name
            end

            local companion_body_skin_color_slot_name = "slot_companion_body_skin_color"
            local companion_body_skin_color_slot_index = table_find(attachment_names, companion_body_skin_color_slot_name)

            if companion_body_skin_color_slot_index then
                table_remove(attachment_names, companion_body_skin_color_slot_index)

                attachment_names[#attachment_names + 1] = companion_body_skin_color_slot_name
            end

            for ii = 1, #attachment_names do
                local attachment_name = attachment_names[ii]
                local attachment_slot_data = attachments[attachment_name]

                instance.attach_hierarchy_ex(attachment_slot_data, override_lookup, attach_settings, item_unit, attachment_name, extract_data, optional_mission_template, optional_equipment)
            end
        end

        instance._pop_extract_data(extract_data, item_unit)

        return extract_data.attachment_units_by_unit, extract_data.attachment_id_lookup, extract_data.attachment_name_lookup, extract_data.bind_poses_by_unit, extract_data.item_name_by_unit
    end

    instance.attach_hierarchy = function (attachment_slot_data, override_lookup, settings, parent_unit, parent_item_name,
            attachment_name, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses,
            optional_extract_item_names, optional_mission_template)
        local extract_data = instance._create_extract_data(optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names)

        instance._push_extract_data(extract_data, parent_unit, parent_item_name, attachment_name)
        instance.attach_hierarchy_ex(attachment_slot_data, override_lookup, settings, parent_unit, attachment_name, extract_data, optional_mission_template)
        instance._pop_extract_data(extract_data, parent_unit)

        return extract_data.attachment_units_by_unit, extract_data.attachment_id_lookup, extract_data.attachment_name_lookup, extract_data.bind_poses_by_unit, extract_data.item_name_by_unit
    end

    instance.apply_material_override = function (unit, parent_unit, apply_to_parent, material_override, in_editor)
        if material_override and material_override ~= "" then
            local material_override_data

            if in_editor then
                material_override_data = rawget(ItemMaterialOverrides, material_override)

                if material_override_data == nil then
                    Log_info("VisualLoadoutCustomization", "Material override %s does not exist.", material_override)
                end
            else
                material_override_data = ItemMaterialOverrides[material_override]
            end

            if material_override_data then
                if apply_to_parent then
                    instance.apply_material_override_ex(parent_unit, material_override_data, in_editor)
                else
                    instance.apply_material_override_ex(unit, material_override_data, in_editor)
                end
            end
        end
    end

    instance.generate_attachment_overrides_lookup = function (item_data, override_item_data)
        if not override_item_data then
            return _empty_overrides_table
        end

        local override_lookup = {}
        local attachments = item_data.attachments
        local override_attachments = override_item_data.attachments

        if not attachments or not override_attachments then
            return _empty_overrides_table
        end

        for attachment_name, attachment_slot_data in pairs(attachments) do
            local override_slot_data = override_attachments[attachment_name]

            instance.generate_attachment_overrides_recursive(attachment_slot_data, override_slot_data, override_lookup)
        end

        return override_lookup
    end

    -- ##### ┌─┐┬ ┬┌─┐┌┐┌┌─┐┌─┐┌┬┐  ┌─┐┬─┐┌─┐┌┬┐  ┬  ┌─┐┌─┐┌─┐┬    ┌┬┐┌─┐  ┌─┐┌┐  ┬┌─┐┌─┐┌┬┐ ##########################
    -- ##### │  ├─┤├─┤││││ ┬├┤  ││  ├┤ ├┬┘│ ││││  │  │ ││  ├─┤│     │ │ │  │ │├┴┐ │├┤ │   │  ##########################
    -- ##### └─┘┴ ┴┴ ┴┘└┘└─┘└─┘─┴┘  └  ┴└─└─┘┴ ┴  ┴─┘└─┘└─┘┴ ┴┴─┘   ┴ └─┘  └─┘└─┘└┘└─┘└─┘ ┴  ##########################

    instance.generate_attachment_overrides_recursive = function(attachment_slot_data, override_slot_data, override_lookup)
        if not override_slot_data then return end

        local override_item_name = instance.validate_item_name(override_slot_data.item)

        if override_item_name then
            override_lookup[attachment_slot_data] = override_item_name
        end

        local children = attachment_slot_data.children
        local override_children = override_slot_data.children

        for name, data in pairs(children) do
            local override_data = override_children[name]

            instance.generate_attachment_overrides_recursive(data, override_data, override_lookup)
        end
    end

    instance.spawn_attachment = function(item_data, settings, parent_unit, optional_mission_template,
            optional_as_leaf_override_attach_node, optional_as_leaf_map_mode)
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
        local attach_node = optional_as_leaf_override_attach_node or breed_attach_node or item_data.attach_node
        local attach_node_index

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
        else
            attach_node_index = 1
        end

        local spawned_unit
        local pose = unit_world_pose(parent_unit, attach_node_index)

        if settings.from_script_component then
            spawned_unit = world_spawn_unit_ex(settings.world, base_unit, nil, pose)
        elseif settings.is_minion then
            spawned_unit = settings.unit_spawner:spawn_unit(base_unit, settings.attach_pose)
        else
            spawned_unit = settings.unit_spawner:spawn_unit(base_unit, pose)
        end

        local item_type = item_data.item_type

        if item_type then
            local sort_order = _sort_order_enum[item_type]

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
                local offset_translation = vector3(0, backpack_offset, 0)

                unit_set_local_position(parent_unit, backpack_offset_node_index, offset_translation)
            end
        end

        local bind_pose = unit_local_pose(spawned_unit, 1)

        if is_first_person and (show_in_1p or only_show_in_1p) then
            unit_set_unit_objects_visibility(spawned_unit, false, true, visibility_contexts.RAYTRACING_CONTEXT)
        end

        local map_mode

        if optional_as_leaf_map_mode then
            map_mode = optional_as_leaf_map_mode
        elseif world[item_data.link_map_mode] then
            map_mode = world[item_data.link_map_mode]
        elseif item_type == "COMPANION_GEAR_FULL" then
            map_mode = world.LINK_MODE_NONE
        elseif settings.skip_link_children and not item_data.force_link_children then
            map_mode = world.LINK_MODE_NONE
        else
            map_mode = world.LINK_MODE_NODE_NAME
        end

        world.link_unit(settings.world, spawned_unit, 1, parent_unit, attach_node_index, map_mode)

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
    end

    instance.attach_hierarchy_ex = function(attachment_slot_data, override_lookup, settings, parent_unit, attachment_name,
            extract_data, optional_mission_template, optional_equipment)
        local item_name = attachment_slot_data.item
        local item = instance.validate_item_name(item_name)
        local override_item = override_lookup[attachment_slot_data]

        item = override_item or item

        if type(item) == "string" then
            if settings.in_editor then
                if settings.item_manager and ToolsMasterItems then
                    item = ToolsMasterItems:get(item)
                else
                    item = rawget(settings.item_definitions, item)
                end
            else
                item = settings.item_definitions[item]
            end
        elseif item then
            item_name = item.name
        end

        if not item then
            return
        end

        local override_attach_node = attachment_slot_data.leaf_attach_node_override ~= "" and attachment_slot_data.leaf_attach_node_override or nil
        local override_map_mode = world[attachment_slot_data.link_map_mode_override]
        local attachment_unit, bind_pose = instance.spawn_attachment(item, settings, parent_unit, optional_mission_template, override_attach_node, override_map_mode)

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

            instance.attach_hierarchy_children(attachments, override_lookup, settings, attachment_unit, extract_data, optional_mission_template)
            instance._pop_extract_data(extract_data, attachment_unit)

            local children = attachment_slot_data.children

            instance.attach_hierarchy_children(children, override_lookup, settings, attachment_unit, extract_data, optional_mission_template)

            local material_overrides = {}
            local item_material_overrides = item.material_overrides

            if item_material_overrides then
                table.append(material_overrides, item_material_overrides)
            end

            local parent_material_overrides = attachment_slot_data.material_overrides

            if parent_material_overrides then
                table.append(material_overrides, parent_material_overrides)
            end

            local apply_to_parent = item.material_override_apply_to_parent

            if material_overrides then
                if not settings.in_editor and item.item_type == "COMPANION_BODY_COAT_PATTERN" then
                    local parent_item_name = parent_unit and extract_data.item_name_by_unit[parent_unit]
                    local parent_item = parent_item_name and settings.item_definitions[parent_item_name]
                    local parent_attachments = parent_item and parent_item.attachments

                    if parent_attachments then
                        for attachment_child_name, _ in pairs(parent_attachments) do
                            local attachment_child_unit = extract_data.attachment_id_lookup[attachment_child_name]

                            if attachment_child_unit then
                                local attachment_item_name = extract_data.item_name_by_unit[attachment_child_unit]

                                if attachment_item_name then
                                    unit_set_data(attachment_child_unit, "attachment_item_name", attachment_item_name)

                                    for _, material_override in pairs(material_overrides) do
                                        instance.apply_material_override(attachment_child_unit, parent_unit, false, material_override, settings.in_editor)
                                    end
                                end
                            end
                        end
                    end
                else
                    for _, material_override in pairs(material_overrides) do
                        instance.apply_material_override(attachment_unit, parent_unit, apply_to_parent, material_override, settings.in_editor)
                    end
                end
            end
        end
    end

    instance.attach_hierarchy_children = function(children, override_lookup, settings, parent_unit, extract_data,
            optional_mission_template)
        if children then
            for attachment_name, child_attachment_slot_data in pairs(children) do
                instance.attach_hierarchy_ex(child_attachment_slot_data, override_lookup, settings, parent_unit, attachment_name, extract_data, optional_mission_template)
            end
        end
    end

    instance.apply_material_override_ex = function(unit, material_override_data, in_editor)
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
                local resource_by_item = texture_override_data.resource_by_item

                if resource_by_item == nil then
                    if texture_override_data.material_slot == nil then
                        Unit_set_texture_for_materials(unit, texture_slot, texture_override_data.resource, true)
                    else
                        Unit_set_texture_for_material(unit, texture_override_data.material_slot, texture_slot, texture_override_data.resource)
                    end
                elseif in_editor then
                    local items_array_size = unit_data_table_size(unit, "attached_item_names") or 0

                    for ii = 1, items_array_size do
                        local attached_item_name = unit_get_data(unit, "attached_item_names", ii)
                        local texture_resource = resource_by_item[attached_item_name]

                        if texture_resource then
                            local unit_array_size = unit_data_table_size(unit, "attached_units_lookup", ii) or 0

                            for jj = 1, unit_array_size do
                                local attachment_unit = unit_get_data(unit, "attached_units_lookup", ii, jj)

                                Unit_set_texture_for_materials(attachment_unit, texture_slot, texture_resource, true)
                            end
                        end
                    end
                else
                    local attachment_item_name = unit_get_data(unit, "attachment_item_name")
                    local texture_resource = resource_by_item[attachment_item_name]

                    if texture_resource then
                        Unit_set_texture_for_materials(unit, texture_slot, texture_resource, true)
                    end
                end
            end
        end
    end

end)