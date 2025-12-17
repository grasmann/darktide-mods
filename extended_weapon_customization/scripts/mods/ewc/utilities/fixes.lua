local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local type = type
    local world = World
    local pairs = pairs
    local table = table
    local string = string
    local vector3 = Vector3
    local tostring = tostring
    local unit_node = unit.node
    local string_sub = string.sub
    local unit_alive = unit.alive
    local quaternion = Quaternion
    local vector3_box = Vector3Box
    local table_clear = table.clear
    -- local string_find = string.find
    -- local string_split = string.split
    local unit_has_node = unit.has_node
    -- local table_contains = table.contains
    local unit_get_data = unit.get_data
    local world_link_unit = world.link_unit
    local unit_num_meshes = unit.num_meshes
    local vector3_unbox = vector3_box.unbox
    local world_unlink_unit = world.unlink_unit
    local unit_set_local_scale = unit.set_local_scale
    local quaternion_from_vector = quaternion.from_vector
    local unit_set_local_position = unit.set_local_position
    local unit_set_local_rotation = unit.set_local_rotation
    local unit_set_unit_visibility = unit.set_unit_visibility
    local unit_set_mesh_visibility = unit.set_mesh_visibility
    local unit_set_scalar_for_materials = unit.set_scalar_for_materials
    local unit_set_shader_pass_flag_for_meshes = unit.set_shader_pass_flag_for_meshes
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local pt = mod:pt()
local PROCESS_SLOTS = {"WEAPON_MELEE", "WEAPON_RANGED", "KITBASH"}
local temp_fixes = {}
local temp_attachments = {}
local temp_requirement_parts = {}
-- local split_cache = {}
local temp_query_params = {}
local temp_inner_query_params = {}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

-- local function pull_cache(query, seperator)
--     local cache = split_cache[query]
--     local result = cache or string_split(query, seperator)
--     if not split_cache[query] then split_cache[query] = result end
--     return result
-- end

mod.handle_attachment_query = function(self, query)
    if string_sub(query, 1, 6) == "query:" then
        -- local debug = string_find(query, "debug")
        local debug = self:cached_find(query, "debug")
        if debug then
            self:print("")
            self:print("handling attachment query:")
        end
        -- Split string with cache
        -- temp_query_params = pull_cache(query, ":")
        temp_query_params = self:cached_split(query, ":")
        -- Check parameters
        if temp_query_params and temp_query_params[2] then
            -- Split string with cache
            -- temp_inner_query_params = pull_cache(temp_query_params[2], ",")
            temp_inner_query_params = self:cached_split(temp_query_params[2], ",")
            -- Check parameters
            if temp_inner_query_params and temp_inner_query_params[1] and temp_inner_query_params[1] ~= "debug" then
                -- Pull attachment list and return
                return self:pull_attachment_list_string(temp_inner_query_params[1], temp_inner_query_params[2], temp_inner_query_params[3], temp_inner_query_params[4], debug)
            end
        end
    end
    -- Return query
    return query
end

mod.collect_fixes = function(self, item_data, target_slot)
    -- Get item data
    local item = self:item_data(item_data)
    local item_type = item and item.item_type
    -- Clear temp
    table_clear(temp_fixes)
    -- Check item type
    -- if table_contains(PROCESS_SLOTS, item_type) and item.attachments then
    if mod:cached_table_contains(PROCESS_SLOTS, item_type) and item.attachments then
        -- Get weapon data
        local weapon_template = item.weapon_template
        local weapon_fixes = mod.settings.fixes[weapon_template]
        if weapon_fixes then
            -- Get weapon attachments
            local attachments = mod.settings.attachments[weapon_template]
            if attachments then

                -- Clear temp
                table_clear(temp_attachments)

                -- Collect current attachment names
                for attachment_slot, attachment_entries in pairs(attachments) do
                    -- Get current attachment path
                    local attachment_item_path = self:fetch_attachment(item.structure or item.attachments, attachment_slot)
                    -- Iterate attachment entries
                    for attachment_name, attachment_data in pairs(attachment_entries) do
                        -- Check attachment path
                        if attachment_item_path == attachment_data.replacement_path then
                            -- Collect attachment name
                            temp_attachments[attachment_slot] = attachment_name
                            break
                        end
                    end
                end

                -- Collect fixes to apply
                for _, fix_entry in pairs(weapon_fixes) do
                    -- Check target slot
                    if not target_slot or fix_entry.attachment_slot == target_slot then
                        local requirements_met = true
                        -- Check requirements
                        if fix_entry.requirements then
                            -- Iterate through fix requirements
                            for requirement_slot, requirement_data in pairs(fix_entry.requirements) do
                                local requirement_met = true
                                
                                if requirement_data.has then
                                    local requirement_string = requirement_data.has
                                    -- Attachment query
                                    requirement_string = self:handle_attachment_query(requirement_string)
                                    -- Cache
                                    -- local cache = split_cache[requirement_string]
                                    -- temp_requirement_parts = cache or string_split(requirement_string, "|")
                                    -- split_cache[requirement_string] = temp_requirement_parts
                                    -- local temp_requirement_parts = pull_cache(requirement_string, "|")
                                    local temp_requirement_parts = self:cached_split(requirement_string, "|")
                                    -- Check validity
                                    -- if not table_contains(temp_requirement_parts, temp_attachments[requirement_slot]) then
                                    if not mod:cached_table_contains(temp_requirement_parts, temp_attachments[requirement_slot]) then
                                        requirement_met = false
                                    end
                                end

                                if requirement_data.missing then
                                    local requirement_string = requirement_data.missing
                                    -- Attachment query
                                    requirement_string = self:handle_attachment_query(requirement_string)
                                    -- Cache
                                    -- local cache = split_cache[requirement_string]
                                    -- temp_requirement_parts = cache or string_split(requirement_string, "|")
                                    -- split_cache[requirement_string] = temp_requirement_parts
                                    -- local temp_requirement_parts = pull_cache(requirement_string, "|")
                                    local temp_requirement_parts = self:cached_split(requirement_string, "|")
                                    -- Check validity
                                    -- if table_contains(temp_requirement_parts, temp_attachments[requirement_slot]) then
                                    if mod:cached_table_contains(temp_requirement_parts, temp_attachments[requirement_slot]) then
                                        requirement_met = false
                                    end
                                end

                                -- Break if not met
                                if not requirement_met then
                                    requirements_met = false
                                    break
                                end
                            end
                        elseif fix_entry.active_function then
                            local gear_id = mod:gear_id(item, true)
                            local is_customization_menu = pt.items_originating_from_customization_menu[gear_id]
                            requirements_met = fix_entry.active_function(item_data, item_data.__is_ui_item_preview, item_data.__is_preview_item, is_customization_menu, self.customization_menu_slot_name)
                        end
                        -- Check if requirements are met
                        if requirements_met then
                            -- Collect fix
                            temp_fixes[fix_entry.fix] = fix_entry.attachment_slot
                        end
                    end
                end

            end
        end

    end

    return temp_fixes

end

-- local already_used_slot = {}

mod.apply_unit_fix_recursive = function(self, fix, parent_unit, attachment_units_by_unit, attachment_slot, attachment_name_lookup)

    for _, attachment_unit in pairs(attachment_units_by_unit[parent_unit]) do

        -- mod:echo("applying fix "..tostring(fix).." to "..tostring(attachment_unit).." ("..tostring(attachment_slot)..")")

        if attachment_unit and unit_alive(attachment_unit) then
            
            if (unit_get_data(attachment_unit, "attachment_slot") == attachment_slot or attachment_name_lookup[parent_unit][attachment_slot] == attachment_unit) then
                -- attachment_unit = unit
                -- already_used_slot[unit] = true

                -- if attachment_unit and unit_alive(attachment_unit) then

                    -- Check fix offset
                    if fix.offset then --and attachment_unit and unit_alive(attachment_unit) then
                        local offset = fix.offset
                        local node = offset.node or 1
                        if type(node) == "string" then
                            node = unit_has_node(attachment_unit, node) and unit_node(attachment_unit, node) or 1
                            -- mod:print("using node "..tostring(offset.node).." ("..tostring(node)..") for "..tostring(attachment_unit))
                        end
                        -- Check offset data
                        if offset.position then unit_set_local_position(attachment_unit, node, vector3_unbox(offset.position)) end
                        if offset.rotation then unit_set_local_rotation(attachment_unit, node, quaternion_from_vector(vector3_unbox(offset.rotation))) end
                        if offset.scale then unit_set_local_scale(attachment_unit, node, vector3_unbox(offset.scale)) end
                        -- local parent_node = offset.parent_node
                        -- if parent_node then
                        --     world_unlink_unit(attachment_unit)
                        --     world_link_unit(attachment_unit, 1, parent_node)
                        -- end
                    end
                    -- Check alpha
                    if fix.alpha then --and attachment_unit and unit_alive(attachment_unit) then
                        unit_set_shader_pass_flag_for_meshes(attachment_unit, "one_bit_alpha", true, true)
                        unit_set_scalar_for_materials(attachment_unit, "inv_jitter_alpha", fix.alpha, true)
                    end
                    -- Check fix hide
                    if fix.hide then --and attachment_unit and unit_alive(attachment_unit) then
                        local hide = fix.hide
                        if hide.node then
                            local node = hide.node
                            if type(node) == "string" then
                                node = unit_has_node(attachment_unit, node) and unit_node(attachment_unit, node)
                            end
                            if type(node) == "table" then
                                for i = 1, #node do
                                    local table_node = node[i]
                                    if type(table_node) == "string" then
                                        local node_id = unit_has_node(attachment_unit, table_node) and unit_node(attachment_unit, table_node)
                                        if node_id then unit_set_local_scale(attachment_unit, node_id, vector3(0, 0, 0)) end
                                    else
                                        unit_set_local_scale(attachment_unit, table_node, vector3(0, 0, 0))
                                    end
                                end
                            elseif node then
                                unit_set_local_scale(attachment_unit, node, vector3(0, 0, 0))
                            end
                        end
                        if hide.mesh then
                            local mesh = hide.mesh
                            local num_meshes = unit_num_meshes(attachment_unit)
                            if type(mesh) == "table" then
                                for i = 1, #mesh do
                                    if num_meshes >= mesh[i] then
                                        unit_set_mesh_visibility(attachment_unit, mesh[i], false)
                                    end
                                end
                            elseif num_meshes >= mesh then
                                unit_set_mesh_visibility(attachment_unit, mesh, false)
                            end
                        end
                    end

                -- end

                -- break
            end

            if (attachment_units_by_unit[attachment_unit]) then

                self:apply_unit_fix_recursive(fix, attachment_unit, attachment_units_by_unit, attachment_slot, attachment_name_lookup)

            end

        end
    end

end

mod.apply_unit_fixes = function(self, item_data, item_unit, attachment_units_by_unit, attachment_name_lookup, optional_fixes, is_ui_item_preview)
    -- Item data
    -- table_clear(already_used_slot)
    local item = self:item_data(item_data)
    local is_ui_item_preview = is_ui_item_preview or (item_data and (item_data.__is_ui_item_preview or item_data.__is_preview_item or item_data.__attachment_customization))
    -- Check data
    if item and item.attachments and attachment_name_lookup then
        -- Get fixes
        local fixes = optional_fixes or self:collect_fixes(item)
        if fixes then
            -- Iterate through fixes
            for fix, attachment_slot in pairs(fixes) do
                -- Check fix valid
                local active = true
                if fix.active_function then
                    local gear_id = mod:gear_id(item, true)
                    local is_customization_menu = pt.items_originating_from_customization_menu[gear_id]
                    active = fix.active_function(item, item_data.__is_ui_item_preview, item_data.__is_preview_item, is_customization_menu, self.customization_menu_slot_name)
                end
                if active and (not fix.disable_in_ui or not is_ui_item_preview) and (not fix.only_in_ui or is_ui_item_preview) then

                    self:apply_unit_fix_recursive(fix, item_unit, attachment_units_by_unit, attachment_slot, attachment_name_lookup)

                    -- Current attachment unit
                    -- local attachment_unit --= attachment_name_lookup[item_unit][attachment_slot]
                    -- for _, attachment_unit in pairs(attachment_units_by_unit[item_unit]) do

                    --     -- mod:echo("applying fix "..tostring(fix).." to "..tostring(attachment_unit).." ("..tostring(attachment_slot)..")")

                    --     if attachment_unit and unit_alive(attachment_unit) and (unit_get_data(attachment_unit, "attachment_slot") == attachment_slot or attachment_name_lookup[item_unit][attachment_slot] == attachment_unit) then
                    --         -- attachment_unit = unit
                    --         -- already_used_slot[unit] = true

                    --         -- if attachment_unit and unit_alive(attachment_unit) then

                    --             -- Check fix offset
                    --             if fix.offset then --and attachment_unit and unit_alive(attachment_unit) then
                    --                 local offset = fix.offset
                    --                 local node = offset.node or 1
                    --                 if type(node) == "string" then
                    --                     node = unit_has_node(attachment_unit, node) and unit_node(attachment_unit, node) or 1
                    --                     -- mod:print("using node "..tostring(offset.node).." ("..tostring(node)..") for "..tostring(attachment_unit))
                    --                 end
                    --                 -- Check offset data
                    --                 if offset.position then unit_set_local_position(attachment_unit, node, vector3_unbox(offset.position)) end
                    --                 if offset.rotation then unit_set_local_rotation(attachment_unit, node, quaternion_from_vector(vector3_unbox(offset.rotation))) end
                    --                 if offset.scale then unit_set_local_scale(attachment_unit, node, vector3_unbox(offset.scale)) end
                    --                 -- local parent_node = offset.parent_node
                    --                 -- if parent_node then
                    --                 --     world_unlink_unit(attachment_unit)
                    --                 --     world_link_unit(attachment_unit, 1, parent_node)
                    --                 -- end
                    --             end
                    --             -- Check alpha
                    --             if fix.alpha then --and attachment_unit and unit_alive(attachment_unit) then
                    --                 unit_set_shader_pass_flag_for_meshes(attachment_unit, "one_bit_alpha", true, true)
                    --                 unit_set_scalar_for_materials(attachment_unit, "inv_jitter_alpha", fix.alpha, true)
                    --             end
                    --             -- Check fix hide
                    --             if fix.hide then --and attachment_unit and unit_alive(attachment_unit) then
                    --                 local hide = fix.hide
                    --                 if hide.node then
                    --                     local node = hide.node
                    --                     if type(node) == "string" then
                    --                         node = unit_has_node(attachment_unit, node) and unit_node(attachment_unit, node)
                    --                     end
                    --                     if type(node) == "table" then
                    --                         for i = 1, #node do
                    --                             local table_node = node[i]
                    --                             if type(table_node) == "string" then
                    --                                 local node_id = unit_has_node(attachment_unit, table_node) and unit_node(attachment_unit, table_node)
                    --                                 if node_id then unit_set_local_scale(attachment_unit, node_id, vector3(0, 0, 0)) end
                    --                             else
                    --                                 unit_set_local_scale(attachment_unit, table_node, vector3(0, 0, 0))
                    --                             end
                    --                         end
                    --                     elseif node then
                    --                         unit_set_local_scale(attachment_unit, node, vector3(0, 0, 0))
                    --                     end
                    --                 end
                    --                 if hide.mesh then
                    --                     local mesh = hide.mesh
                    --                     local num_meshes = unit_num_meshes(attachment_unit)
                    --                     if type(mesh) == "table" then
                    --                         for i = 1, #mesh do
                    --                             if num_meshes >= mesh[i] then
                    --                                 unit_set_mesh_visibility(attachment_unit, mesh[i], false)
                    --                             end
                    --                         end
                    --                     elseif num_meshes >= mesh then
                    --                         unit_set_mesh_visibility(attachment_unit, mesh, false)
                    --                     end
                    --                 end
                    --             end

                    --         -- end

                    --         -- break
                    --     end
                    -- end

                end
            end
        end
    end
end

mod.apply_attachment_fixes = function(self, item_data, optional_fixes)
    -- Item data
    local item = self:item_data(item_data)
    local is_ui_item_preview = (item_data and (item_data.__is_ui_item_preview or item_data.__is_preview_item or item_data.__attachment_customization))
    local item_type = item and item.item_type
    -- Check data
    -- if table_contains(PROCESS_SLOTS, item_type) and item.attachments then
    if mod:cached_table_contains(PROCESS_SLOTS, item_type) and item.attachments then
        -- Get fixes
        local fixes = optional_fixes or self:collect_fixes(item)
        if fixes then
            -- Weapon data
            local weapon_template = item.weapon_template
            local attachments = mod.settings.attachments[weapon_template]
            -- Iterate through fixes
            for fix, attachment_slot in pairs(fixes) do
                local active = true
                if fix.active_function then
                    local gear_id = mod:gear_id(item, true)
                    local is_customization_menu = pt.items_originating_from_customization_menu[gear_id]
                    active = fix.active_function(item, item_data.__is_ui_item_preview, item_data.__is_preview_item, is_customization_menu, self.customization_menu_slot_name)
                end
                -- Check active
                if active and (not fix.disable_in_ui or not is_ui_item_preview) and (not fix.only_in_ui or is_ui_item_preview) then
                    -- Check fix attach
                    if fix.attach then
                        local attach = fix.attach
                        -- Iterate through attach entries
                        for attachment_slot, attachment_name in pairs(attach) do
                            -- Get attachment path
                            local slot_data = attachments[attachment_slot]
                            local attachment_data = slot_data and slot_data[attachment_name]
                            if attachment_data then
                                local attachment_item_path = attachment_data.replacement_path
                                mod:modify_item(item, nil, {[attachment_slot] = attachment_item_path})
                            end
                        end
                    end
                end
            end
        end
    end
end
