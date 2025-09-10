local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local pairs = pairs
    local table = table
    local CLASS = CLASS
    local string = string
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

local PROCESS_SLOTS = {"WEAPON_MELEE", "WEAPON_RANGED"}
local temp_fixes = {}
local temp_attachments = {}
local temp_requirement_parts = {}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.apply_fixes = function(self, item_data, item_unit, attachment_units_by_unit, attachment_id_lookup, attachment_name_lookup)

    local item = item_data and (item_data.__is_ui_item_preview and item_data.__data) or item_data
    local item_type = item_data and item_data.item_type

    if table_contains(PROCESS_SLOTS, item_type) and item.attachments then

        local weapon_template = item_data.weapon_template
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

                -- Clear temp
                table_clear(temp_fixes)

                -- Collect fixes to apply
                for _, fix_entry in pairs(weapon_fixes) do
                    local requirements_met = true
                    -- Iterate through fix requirements
                    for requirement_slot, requirement_data in pairs(fix_entry.requirements) do
                        local requirement_met = true
                        -- Fix data
                        local positive = requirement_data.has and true or false
                        local requirement_string = positive and requirement_data.has or requirement_data.missing
                        local temp_requirement_parts = string_split(requirement_string, "|")
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
                        temp_fixes[fix_entry.attachment_slot] = fix_entry.fix
                    end
                end

                -- Iterate through fixes
                for attachment_slot, fix in pairs(temp_fixes) do
                    -- Current attachment unit
                    local attachment_unit = attachment_id_lookup[item_unit][attachment_slot]
                    -- Check fix offset
                    if fix.offset then
                        local offset = fix.offset
                        local node = offset.node or 1
                        -- Check offset position
                        if offset.position then unit_set_local_position(attachment_unit, 1, vector3_unbox(offset.position)) end
                        if offset.rotation then unit_set_local_rotation(attachment_unit, 1, quaternion_from_vector(vector3_unbox(offset.rotation))) end
                        if offset.scale then unit_set_local_scale(attachment_unit, 1, vector3_unbox(offset.scale)) end

                    end

                end


            end
        end
    end
end

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization", function(instance)

    mod:hook(instance, "spawn_item_attachments", function(func, item_data, override_lookup, attach_settings, item_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment, ...)
        -- Modify item
        mod:modify_item(item_data)
        -- Original function
        local attachment_units_by_unit, attachment_id_lookup, attachment_name_lookup, bind_poses_by_unit, item_name_by_unit = func(item_data, override_lookup, attach_settings, item_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment, ...)
        -- Apply fixes
        mod:apply_fixes(item_data, item_unit, attachment_units_by_unit, attachment_name_lookup)
        -- Return
        return attachment_units_by_unit, attachment_id_lookup, attachment_name_lookup, bind_poses_by_unit, item_name_by_unit
    end)

    mod:hook(instance, "spawn_item", function(func, item_data, attach_settings, parent_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment, ...)
        -- Modify item
        mod:modify_item(item_data)
        -- Original function
        local item_unit, attachment_units_by_unit, bind_pose, attachment_id_lookup, attachment_name_lookup, attachment_units_bind_poses, item_name_by_unit = func(item_data, attach_settings, parent_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment, ...)
        -- Apply fixes
        mod:apply_fixes(item_data, item_unit, attachment_units_by_unit, attachment_name_lookup)
        -- Return
        return item_unit, attachment_units_by_unit, bind_pose, attachment_id_lookup, attachment_name_lookup, attachment_units_bind_poses, item_name_by_unit
    end)

    local table = table
    local pairs = pairs
    local tostring = tostring
    local table_set_readonly = table.set_readonly

    local _empty_overrides_table = table_set_readonly({})
    
    mod:hook(instance, "generate_attachment_overrides_lookup", function(func, item_data, override_item_data, ...)

        -- Original function
        local override_lookup = func(item_data, override_item_data, ...)
        
        local gear_id = mod:gear_id(item_data)
        local gear_settings = mod:gear_settings(gear_id)

        if item_data.__attachment_customization then
            return _empty_overrides_table
        end

        local attachments = item_data.__master_item and item_data.__master_item.attachments or item_data.attachments
        if attachments then
            if override_lookup and override_item_data and gear_settings then

                for attachment_slot, replacement_path in pairs(gear_settings) do

                    local attachment_data = mod:fetch_attachment_data(attachments, attachment_slot)
                    if attachment_data and override_lookup[attachment_data] then
                        override_lookup[attachment_data] = replacement_path
                    end

                end
            end
        end

        -- Return
        return override_lookup
    end)

end)
