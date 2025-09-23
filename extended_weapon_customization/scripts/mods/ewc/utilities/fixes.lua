local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local type = type
    local pairs = pairs
    local table = table
    local string = string
    local vector3 = Vector3
    local unit_node = unit.node
    local unit_alive = unit.alive
    local quaternion = Quaternion
    local vector3_box = Vector3Box
    local table_clear = table.clear
    local string_split = string.split
    local unit_has_node = unit.has_node
    local table_contains = table.contains
    local vector3_unbox = vector3_box.unbox
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

local PROCESS_SLOTS = {"WEAPON_MELEE", "WEAPON_RANGED", "KITBASH"}
local temp_fixes = {}
local temp_attachments = {}
local temp_requirement_parts = {}
local split_cache = {}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.collect_fixes = function(self, item_data, target_slot)
    -- Get item data
    -- local item = item_data and (item_data.__is_ui_item_preview and item_data.__data) or item_data.__master_item or item_data
    local item = self:item_data(item_data)
    --item = item and item.__master_item or item_data.__master_item or item
    
    local item_type = item.item_type
    -- Clear temp
    table_clear(temp_fixes)
    -- Check item type
    if table_contains(PROCESS_SLOTS, item_type) and item.attachments then
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
                                -- Fix data
                                local positive = requirement_data.has and true or false
                                local requirement_string = positive and requirement_data.has or requirement_data.missing
                                local cache = split_cache[requirement_string]
                                temp_requirement_parts = cache or string_split(requirement_string, "|")
                                split_cache[requirement_string] = temp_requirement_parts
                                -- Check validity
                                if positive and not table_contains(temp_requirement_parts, temp_attachments[requirement_slot]) then
                                    requirement_met = false
                                elseif not positive and table_contains(temp_requirement_parts, temp_attachments[requirement_slot]) then
                                    requirement_met = false
                                end
                                -- Break if not met
                                if not requirement_met then
                                    requirements_met = false
                                    break
                                end
                            end
                        elseif fix_entry.active_function then
                            local gear_id = mod:gear_id(item, true)
                            local is_customization_menu = mod:pt().items_originating_from_customization_menu[gear_id]
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

mod.apply_unit_fixes = function(self, item_data, item_unit, attachment_units_by_unit, attachment_name_lookup, optional_fixes, is_ui_item_preview)
    -- Item data
    -- local item = item_data and (item_data.__is_ui_item_preview and item_data.__data) or item_data
    local item = self:item_data(item_data)
    --item = item and item.__master_item or item_data.__master_item or item
    -- local is_ui_item_preview = (item_data and (item_data.__is_ui_item_preview or item_data.__is_preview_item or item_data.__attachment_customization)) or is_ui_item_preview
    local is_ui_item_preview = is_ui_item_preview or (item_data and (item_data.__is_ui_item_preview or item_data.__is_preview_item or item_data.__attachment_customization))
    -- Check data
    if item.attachments then
        -- Get fixes
        local fixes = optional_fixes or self:collect_fixes(item)
        if fixes then
            -- Iterate through fixes
            for fix, attachment_slot in pairs(fixes) do
                -- Check fix valid
                local active = true
                if fix.active_function then
                    local gear_id = mod:gear_id(item, true)
                    local is_customization_menu = mod:pt().items_originating_from_customization_menu[gear_id]
                    active = fix.active_function(item, item_data.__is_ui_item_preview, item_data.__is_preview_item, is_customization_menu, self.customization_menu_slot_name)
                end
                if active and (not fix.disable_in_ui or not is_ui_item_preview) and (not fix.only_in_ui or is_ui_item_preview) then
                    -- Current attachment unit
                    local attachment_unit = attachment_name_lookup[item_unit][attachment_slot]
                    -- Check fix offset
                    if fix.offset and attachment_unit and unit_alive(attachment_unit) then
                        local offset = fix.offset
                        local node = offset.node or 1
                        if type(node) == "string" then
                            node = unit_has_node(attachment_unit, node) and unit_node(attachment_unit, node) or 1
                        end
                        -- Check offset data
                        if offset.position then unit_set_local_position(attachment_unit, node, vector3_unbox(offset.position)) end
                        if offset.rotation then unit_set_local_rotation(attachment_unit, node, quaternion_from_vector(vector3_unbox(offset.rotation))) end
                        if offset.scale then unit_set_local_scale(attachment_unit, node, vector3_unbox(offset.scale)) end
                    end
                    -- Check alpha
                    if fix.alpha and attachment_unit and unit_alive(attachment_unit) then
                        unit_set_shader_pass_flag_for_meshes(attachment_unit, "one_bit_alpha", true, true)
                        unit_set_scalar_for_materials(attachment_unit, "inv_jitter_alpha", fix.alpha, true)
                    end
                    -- Check fix hide
                    if fix.hide and attachment_unit and unit_alive(attachment_unit) then
                        local hide = fix.hide
                        if hide.node then
                            -- mod:print("fix hide "..tostring(attachment_slot))
                            local node = hide.node
                            if type(node) == "string" then
                                node = unit_has_node(attachment_unit, node) and unit_node(attachment_unit, node) or 1
                            end
                            if type(node) == "table" then
                                for i = 1, #node do
                                    unit_set_local_scale(attachment_unit, node[i], vector3(0, 0, 0))
                                end
                            else
                                unit_set_local_scale(attachment_unit, node, vector3(0, 0, 0))
                            end
                        end
                        if hide.mesh then
                            local mesh = hide.mesh
                            if type(mesh) == "table" then
                                for i = 1, #mesh do
                                    unit_set_mesh_visibility(attachment_unit, mesh[i], false)
                                end
                            else
                                unit_set_mesh_visibility(attachment_unit, mesh, false)
                            end
                        end
                    end
                end
            end
        end
    end
end

mod.apply_attachment_fixes = function(self, item_data, optional_fixes)
    -- Item data
    -- local item = item_data and (item_data.__is_ui_item_preview and item_data.__data) or item_data
    local item = self:item_data(item_data)
    --item = item and item.__master_item or item_data.__master_item or item
    local is_ui_item_preview = (item_data and (item_data.__is_ui_item_preview or item_data.__is_preview_item or item_data.__attachment_customization))
    local item_type = item.item_type
    -- Check data
    if table_contains(PROCESS_SLOTS, item_type) and item.attachments then
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
                    local is_customization_menu = mod:pt().items_originating_from_customization_menu[gear_id]
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
                            local attachment_item_path = attachments[attachment_slot][attachment_name].replacement_path
                            -- Apply fix
                            mod:modify_item(item, nil, {
                                [attachment_slot] = attachment_item_path
                            })
                        end
                    end
                end
            end
        end
    end
end
