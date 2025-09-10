local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local pairs = pairs
    local table = table
    local string = string
    local unit_alive = unit.alive
    local quaternion = Quaternion
    local vector3_box = Vector3Box
    local table_clear = table.clear
    local string_split = string.split
    local table_contains = table.contains
    local vector3_unbox = vector3_box.unbox
    local unit_set_local_scale = unit.set_local_scale
    local quaternion_from_vector = quaternion.from_vector
    local unit_set_local_position = unit.set_local_position
    local unit_set_local_rotation = unit.set_local_rotation
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local PROCESS_SLOTS = {"WEAPON_MELEE", "WEAPON_RANGED", "KITBASH"}
local temp_fixes = {}
local temp_attachments = {}
local temp_requirement_parts = {}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.collect_fixes = function(self, item_data)
    
    local item = item_data and (item_data.__is_ui_item_preview and item_data.__data) or item_data.__master_item or item_data
    local item_type = item.item_type

    -- Clear temp
    table_clear(temp_fixes)

    if table_contains(PROCESS_SLOTS, item_type) and item.attachments then

        local weapon_template = item.weapon_template
        local weapon_fixes = mod.settings.fixes[weapon_template]
        if weapon_fixes then

            local attachments = mod.settings.attachments[weapon_template]
            if attachments then

                -- Clear temp
                table_clear(temp_attachments)

                -- Collect current attachment names
                for attachment_slot, attachment_entries in pairs(attachments) do
                    -- Get current attachment path
                    local attachment_item_path = self:fetch_attachment(item.attachments, attachment_slot)
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
                    local requirements_met = true
                    -- Iterate through fix requirements
                    for requirement_slot, requirement_data in pairs(fix_entry.requirements) do
                        local requirement_met = true
                        -- Fix data
                        local positive = requirement_data.has and true or false
                        local requirement_string = positive and requirement_data.has or requirement_data.missing
                        temp_requirement_parts = string_split(requirement_string, "|")
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
                    -- Check if requirements are met
                    if requirements_met then
                        -- Collect fix
                        temp_fixes[fix_entry.fix] = fix_entry.attachment_slot
                    end
                end

            end
        end

    end

    return temp_fixes

end

mod.apply_unit_fixes = function(self, item_data, item_unit, attachment_units_by_unit, attachment_name_lookup, optional_fixes, is_ui_item_preview)
    -- Item data
    local item = item_data and (item_data.__is_ui_item_preview and item_data.__data) or item_data.__master_item or item_data
    -- Check data
    if item.attachments then
        -- Get fixes
        local fixes = optional_fixes or self:collect_fixes(item)
        if fixes then
            -- Iterate through fixes
            for fix, attachment_slot in pairs(fixes) do
                -- Check fix valid
                if not fix.disable_in_ui or not is_ui_item_preview then
                    -- Current attachment unit
                    local attachment_unit = attachment_name_lookup[item_unit][attachment_slot]
                    -- Check fix offset
                    if fix.offset and attachment_unit and unit_alive(attachment_unit) then
                        local offset = fix.offset
                        local node = offset.node or 1
                        -- Check offset data
                        if offset.position then unit_set_local_position(attachment_unit, 1, vector3_unbox(offset.position)) end
                        if offset.rotation then unit_set_local_rotation(attachment_unit, 1, quaternion_from_vector(vector3_unbox(offset.rotation))) end
                        if offset.scale then unit_set_local_scale(attachment_unit, 1, vector3_unbox(offset.scale)) end
                    end
                end
            end
        end
    end
end

mod.apply_attachment_fixes = function(self, item_data, optional_fixes)
    -- Item data
    local item = item_data and (item_data.__is_ui_item_preview and item_data.__data) or item_data.__master_item or item_data
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
