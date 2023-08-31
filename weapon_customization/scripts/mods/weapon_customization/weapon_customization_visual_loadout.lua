local mod = get_mod("weapon_customization")

local ScriptWorld = mod:original_require("scripts/foundation/utilities/script_world")

mod:hook_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization", function(instance)

    instance._sort_order_enum = {
        FACE_SCAR = 1,
        FACE_HAIR = 2,
        HAIR = 3
    }

    instance.spawn_item_attachments = function(item_data, override_lookup, attach_settings, item_unit, optional_extract_attachment_units_bind_poses, optional_mission_template)

        local item_name = mod:item_name_from_content_string(item_data.name)
        local attachments = item_data.attachments
        if item_unit and attachments then
            local gear_id = mod:get_gear_id(item_data)
            if gear_id then
                mod:setup_item_definitions()
                -- Bulwark
                if mod:get_gear_setting(gear_id, "left") == "bulwark_shield_01" then
                    attach_settings.item_definitions = mod:persistent_table("weapon_customization").bulwark_item_definitions
                end

                -- Add flashlight slot
                mod:_add_custom_attachments(gear_id, attachments)
                
                -- Overwrite attachments
                mod:_overwrite_attachments(item_data, attachments)
            end
        end

        local attachment_slot_info = {}

        -- mod:echo(item_name)
        -- mod:debug_attachments(item_data, attachments, {"combatsword_p3_m1", "combatsword_p3_m2", "combatsword_p3_m3"})

        -- ############################################################################################################

        local attachment_units, attachment_units_bind_poses = nil, nil
        local attachments = item_data.attachments
    
        if item_unit and attachments then
            attachment_units_bind_poses = optional_extract_attachment_units_bind_poses and {} or nil
            attachment_units = {}
            local attachment_names = table.keys(attachments)
    
            table.sort(attachment_names)
    
            local skin_color_slot_name = "slot_body_skin_color"
            local skin_color_slot_index = table.find(attachment_names, skin_color_slot_name)
    
            if skin_color_slot_index then
                table.remove(attachment_names, skin_color_slot_index)
    
                attachment_names[#attachment_names + 1] = skin_color_slot_name
            end
    
            for i = 1, #attachment_names do
                local name = attachment_names[i]
                local attachment_slot_data = attachments[name]
                attachment_units, attachment_units_bind_poses = instance._attach_hierarchy(attachment_slot_data, override_lookup, attach_settings, item_unit, attachment_units, attachment_units_bind_poses, optional_mission_template, attachment_slot_info)
            end
        end

        -- ############################################################################################################

        if attachment_slot_info.attachment_slot_to_unit then
            for attachment_slot, unit in pairs(attachment_slot_info.attachment_slot_to_unit) do
                if not table.contains(mod.attachment_slots, attachment_slot) then
                    -- mod:echo("attachment slot '"..attachment_slot.."' not found")
                end
            end
        end

        -- if not mod.test then
        --     mod:dtf(attachment_slot_info, "attachment_slot_info", 15)
        --     mod.test = true
        -- end

        if attachment_units and item_data then
            for _, unit in pairs(attachment_units) do
                local unit_name = Unit.debug_name(unit)
                local anchor = nil

                if mod.attachment_units[unit_name] then
                    local attachment = mod.attachment_units[unit_name]
                    if attachment then
                        if mod.anchors[item_name] and mod.anchors[item_name][attachment] then
                            anchor = mod.anchors[item_name][attachment]
                            if anchor.preview_only and optional_mission_template or ScriptWorld.name(attach_settings.world) == "ui_inventory" then anchor = nil end
                        end
                    end
                end

                if unit_name == "#ID[bc25db1df0670d2a]" then
                    Unit.set_local_position(unit, 1, Unit.local_position(unit, 1) + Vector3(0, 0, -.065))
                    local x, y, z = Quaternion.to_euler_angles_xyz(Unit.local_rotation(unit, 1))
                    local rotation = Vector3(x, y, z) + Vector3(-10, 5, 5)
                    local rotate_quaternion = Quaternion.from_euler_angles_xyz(rotation[1], rotation[2], rotation[3])
                    Unit.set_local_rotation(unit, 1, rotate_quaternion)
                    Unit.set_local_scale(unit, 1, Vector3(1, 1, 0.9))
                end

                -- -- Fixes
                -- if not anchor and mod.anchors[item_name] and mod.anchors[item_name]["fixes"] then
                --     for fix_attachment, fix_data in pairs(mod.anchors[item_name]["fixes"]) do
                --         if mod.attachment_models[item_name] and mod.attachment_models[item_name][fix_attachment] then
                --             local model_string = mod.attachment_models[item_name][fix_attachment].model
                --             local has_fix_attachment = mod:_recursive_find_attachment_item_string(attachments, model_string)
                --             if has_fix_attachment then
                --                 local fix_attachment_slot = mod.attachment_models[item_name][fix_attachment].type
                --                 for dependency_attachment, fix in pairs(fix_data) do
                --                     if mod.attachment_models[item_name] and mod.attachment_models[item_name][dependency_attachment] then
                --                         local model_string = mod.attachment_models[item_name][dependency_attachment].model
                --                         local has_dependency = mod:_recursive_find_attachment_item_string(attachments, model_string)
                --                         if has_dependency and fix_attachment_slot and unit == attachment_slots_to_units[fix_attachment_slot] then
                --                             anchor = fix
                --                             break
                --                         end
                --                     end
                --                 end
                --             end
                --         end
                --     end
                -- end

                if anchor then
                    World.unlink_unit(attach_settings.world, unit)
                    World.link_unit(attach_settings.world, unit, 1, item_unit, 1)

                    local position = Vector3Box.unbox(anchor.position)
                    local rotation_euler = Vector3Box.unbox(anchor.rotation)
                    local rotation = Quaternion.from_euler_angles_xyz(rotation_euler[1], rotation_euler[2], rotation_euler[3])
                    local scale = Vector3Box.unbox(anchor.scale)

                    Unit.set_local_position(unit, 1, position)
                    Unit.set_local_rotation(unit, 1, rotation)
                    Unit.set_local_scale(unit, 1, scale)
                end
            end
        end

        if mod._debug then
            local new_unit_names = {}
            local gear_id = mod:get_gear_id(item_data)
            if gear_id and attachment_units then
                if mod.last_attachment_units[gear_id] then
                    local last_units = mod.last_attachment_units[gear_id]
                    local new_units = mod.new_units[gear_id]
                    local debug_units = mod.debug_selected_unit

                    for _, unit in pairs(attachment_units) do
                        local unit_name = Unit.debug_name(unit)
                        if not table.contains(last_units, unit_name) then
                            new_unit_names[#new_unit_names+1] = unit_name
                            new_units[#new_units+1] = unit
                            last_units[#last_units+1] = unit_name
                        end
                    end

                    if #new_unit_names > 0 then
                        for _, unit_name in pairs(new_unit_names) do
                            -- mod:echo(unit_name)
                        end
                    end

                    if #new_unit_names == 1 then
                        debug_units[#debug_units+1] = new_units[#new_units]
                        if not mod.attachment_units[new_unit_names[1]] then
                            -- mod:dtf(new_unit_names, "new_unit", 3)
                        end
                    end

                else

                    local last_units = {}
                    for _, unit in pairs(attachment_units) do
                        local unit_name = Unit.debug_name(unit)
                        last_units[#last_units+1] = unit_name
                    end
                    mod.debug_item_name = mod:item_name_from_content_string(item_data.name)
                    mod.last_attachment_units[gear_id] = last_units
                    mod.new_units[gear_id] = {}
                    mod.debug_selected_unit = {}

                end
            end
        end

        -- ############################################################################################################
    
        return attachment_units, attachment_units_bind_poses
    end

    instance.attach_hierarchy = function(attachment_slot_data, override_lookup, settings, parent_unit, attached_units, attached_units_bind_poses_or_nil, attachment_slot_info)
        return instance._attach_hierarchy(attachment_slot_data, override_lookup, settings, parent_unit, attached_units, attached_units_bind_poses_or_nil, attachment_slot_info)
    end

    instance._attach_hierarchy = function(attachment_slot_data, override_lookup, settings, parent_unit, attached_units, attached_units_bind_poses_or_nil, optional_mission_template, attachment_slot_info)
        local item_name = attachment_slot_data.item
        local item = instance._validate_item_name(item_name)
        local override_item = override_lookup[attachment_slot_data]
        item = override_item or item
    
        if type(item) == "string" then
            item = settings.item_definitions[item]
        end
    
        if not item then
            return attached_units, attached_units_bind_poses_or_nil
        end
    
        local attachment_unit, bind_pose = instance._spawn_attachment(item, settings, parent_unit, optional_mission_template, attachment_slot_info)
    
        if attachment_unit then
            attached_units[#attached_units + 1] = attachment_unit
    
            if attached_units_bind_poses_or_nil then
                attached_units_bind_poses_or_nil[attachment_unit] = Matrix4x4Box(bind_pose)
            end
    
            local attachments = item and item.attachments
            attached_units = instance._attach_hierarchy_children(attachments, override_lookup, settings, attachment_unit, attached_units, attached_units_bind_poses_or_nil, optional_mission_template, attachment_slot_info)
            local children = attachment_slot_data.children
            attached_units = instance._attach_hierarchy_children(children, override_lookup, settings, attachment_unit, attached_units, attached_units_bind_poses_or_nil, optional_mission_template, attachment_slot_info)
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
                for _, material_override in pairs(material_overrides) do
                    instance.apply_material_override(attachment_unit, parent_unit, apply_to_parent, material_override)
                end
            end
        end
    
        return attached_units, attached_units_bind_poses_or_nil
    end

    instance._attach_hierarchy_children = function(children, override_lookup, settings, parent_unit, attached_units, attached_units_bind_poses_or_nil, optional_mission_template, attachment_slot_info)
        if children then
            for _, child_attachment_slot_data in pairs(children) do
                attached_units, attached_units_bind_poses_or_nil = instance._attach_hierarchy(child_attachment_slot_data, override_lookup, settings, parent_unit, attached_units, attached_units_bind_poses_or_nil, optional_mission_template, attachment_slot_info)
            end
        end
    
        return attached_units, attached_units_bind_poses_or_nil
    end

    instance._validate_item_name = function(item)
        if item == "" then
            return nil
        end
    
        return item
    end

    instance._node_name_to_attachment_slot = function(node_name)
        local name = node_name
        name = string.gsub(name, "ap_", "")
        name = string.gsub(name, "_01", "")
        name = string.gsub(name, "rp_", "")
        name = string.gsub(name, "magazine_02", "magazine2")
        if string.find(name, "chained_rig") then name = "receiver" end
        return name
    end

    instance._spawn_attachment = function(item_data, settings, parent_unit, optional_mission_template, attachment_slot_info)
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
                attach_node_index = Unit.has_node(parent_unit, item_data.wielded_attach_node or attach_node) and Unit.node(parent_unit, item_data.wielded_attach_node or attach_node) or 1
            else
                attach_node_index = Unit.has_node(parent_unit, item_data.unwielded_attach_node or attach_node) and Unit.node(parent_unit, item_data.unwielded_attach_node or attach_node) or 1
            end
        elseif attach_node then
            attach_node_index = Unit.has_node(parent_unit, attach_node) and Unit.node(parent_unit, attach_node) or 1
        end
    
        local spawned_unit = nil
        local pose = Unit.world_pose(parent_unit, attach_node_index)
    
        if settings.from_script_component then
            spawned_unit = World.spawn_unit_ex(settings.world, base_unit, nil, pose)
        elseif settings.is_minion then
            spawned_unit = settings.unit_spawner:spawn_unit(base_unit, settings.attach_pose)
        else
            spawned_unit = settings.unit_spawner:spawn_unit(base_unit, pose)
        end

        if type(attach_node) == "string" and item_data.base_unit ~= "content/characters/empty_item/empty_item" then
            local attachment_slot = instance._node_name_to_attachment_slot(attach_node)
            attachment_slot_info = attachment_slot_info or {}
            attachment_slot_info.attachment_slot_to_unit = attachment_slot_info.attachment_slot_to_unit or {}
            attachment_slot_info.unit_to_attachment_slot = attachment_slot_info.unit_to_attachment_slot or {}
            -- attachment_slot_info.attachment_slot_to_base_unit = attachment_slot_info.attachment_slot_to_base_unit or {}
            attachment_slot_info.attachment_slot_to_unit[attachment_slot] = spawned_unit
            attachment_slot_info.unit_to_attachment_slot[spawned_unit] = attachment_slot
            -- attachment_slot_info.attachment_slot_to_base_unit[item_data.base_unit] = attachment_slot
        end
    
        local item_type = item_data.item_type
    
        if item_type then
            local sort_order = instance._sort_order_enum[item_type]
    
            if sort_order then
                Unit.set_sort_order(spawned_unit, sort_order)
            end
        end
    
        if settings.is_first_person or settings.force_highest_lod_step then
            Unit.set_unit_culling(spawned_unit, false)
    
            if Unit.has_lod_object(spawned_unit, "lod") then
                local item_lod_object = Unit.lod_object(spawned_unit, "lod")
    
                LODObject.set_static_select(item_lod_object, 0)
            end
        end
    
        if not spawned_unit then
            return nil
        end
    
        local backpack_offset = item_data.backpack_offset
    
        if backpack_offset then
            local backpack_offset_node_index = Unit.has_node(parent_unit, "j_backpackoffset") and Unit.node(parent_unit, "j_backpackoffset")
    
            if backpack_offset_node_index then
                local backpack_offset_v3 = Vector3(0, backpack_offset, 0)
    
                Unit.set_local_position(parent_unit, backpack_offset_node_index, backpack_offset_v3)
            end
        end
    
        local bind_pose = Unit.local_pose(spawned_unit, 1)
    
        if is_first_person and (show_in_1p or only_show_in_1p) then
            Unit.set_unit_objects_visibility(spawned_unit, false, true, VisibilityContexts.RAYTRACING_CONTEXT)
        end
    
        local keep_local_transform = not settings.skip_link_children and true
    
        World.link_unit(settings.world, spawned_unit, 1, parent_unit, attach_node_index, keep_local_transform)
    
        if settings.lod_group and Unit.has_lod_object(spawned_unit, "lod") and not settings.is_first_person then
            local attached_lod_object = Unit.lod_object(spawned_unit, "lod")
    
            LODGroup.add_lod_object(settings.lod_group, attached_lod_object)
        end
    
        if settings.lod_shadow_group and Unit.has_lod_object(spawned_unit, "lod_shadow") and not settings.is_first_person then
            local attached_lod_object = Unit.lod_object(spawned_unit, "lod_shadow")
    
            LODGroup.add_lod_object(settings.lod_shadow_group, attached_lod_object)
        end
    
        if optional_mission_template then
            local face_state_machine_key = optional_mission_template.face_state_machine_key
            local state_machine = item_data[face_state_machine_key]
    
            if state_machine and state_machine ~= "" then
                Unit.set_animation_state_machine(spawned_unit, state_machine)
            end
        end
    
        return spawned_unit, bind_pose
    end

    instance._empty_overrides_table = table.set_readonly({})

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

    instance.generate_attachment_overrides_lookup = function (item_data, override_item_data)
        if override_item_data then
            local attachments = override_item_data.attachments
            local gear_id = mod:get_gear_id(item_data)
            if gear_id then
                mod:setup_item_definitions()

                -- Add flashlight slot
                mod:_add_custom_attachments(gear_id, attachments)
                
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

end)