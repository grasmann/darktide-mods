local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local VisualLoadoutCustomization = mod:original_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization")
local master_items = mod:original_require("scripts/backend/master_items")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local pairs = pairs
    local table = table
    local table_clear = table.clear
    local unit_set_data = unit.set_data
    local table_set_readonly = table.set_readonly
    local table_merge_recursive = table.merge_recursive
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local empty_overrides_table = table_set_readonly({})
local temp_children = {}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.recursive_children = function(self, unit, attachment_units_by_unit, children)
    -- local children = children or {}
    if not children then
        table_clear(temp_children)
        children = temp_children
    end
    -- local unit_children = unit_get_child_units(unit)
    local unit_children = attachment_units_by_unit[unit]
    for _, unit in pairs(unit_children) do
        children[#children+1] = unit
        self:recursive_children(unit, attachment_units_by_unit, children)
    end
    return children
end

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization", function(instance)

    mod:hook(instance, "spawn_item_attachments", function(func, item_data, override_lookup, attach_settings, item_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment, ...)
        -- Modify item
        mod:modify_item(item_data)
        -- Fixes
        local fixes = mod:collect_fixes(item_data)
        mod:apply_attachment_fixes(item_data, fixes)
        -- Original function
        local attachment_units_by_unit, attachment_id_lookup, attachment_name_lookup, bind_poses_by_unit, item_name_by_unit = func(item_data, override_lookup, attach_settings, item_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment, ...)

        local is_ui_item_preview = false
        if attachment_id_lookup and item_data.attachments then

            -- Collect current attachment names
            local kitbash_fixes = mod:fetch_attachment_fixes(item_data.attachments)
            if kitbash_fixes then
                fixes = table_merge_recursive(fixes, kitbash_fixes)
            end

            for _, attachment_unit in pairs(attachment_units_by_unit[item_unit]) do

                local attachment_slot = attachment_id_lookup[attachment_unit]
                unit_set_data(attachment_unit, "attachment_slot", attachment_slot)

                if item_data.attachments.slot_trinket_1 and item_data.attachments.slot_trinket_1.item then

                    is_ui_item_preview = true

                    local item = item_data.attachments.slot_trinket_1.item

                    if item and item.attachments then
                        -- Collect current attachment names
                        local kitbash_fixes = mod:fetch_attachment_fixes(item.attachments)
                        if kitbash_fixes then
                            fixes = table_merge_recursive(fixes, kitbash_fixes)
                        end
                    end

                else
                    
                    local item_path = mod:fetch_attachment(item_data.attachments, attachment_slot)
                    local item = master_items.get_item(item_path)

                    if item and item.attachments then
                        -- Collect current attachment names
                        local kitbash_fixes = mod:fetch_attachment_fixes(item.attachments)
                        if kitbash_fixes then
                            fixes = table_merge_recursive(fixes, kitbash_fixes)
                        end

                        if item.is_kitbash and not item.disable_vfx_spawner_exclusion then
                            
                            local pt = mod:pt()

                            pt.exclude_from_vfx_spawner[attachment_unit] = true

                            local all_children = mod:recursive_children(attachment_unit, attachment_units_by_unit)
                            for _, child in pairs(all_children) do
                                pt.exclude_from_vfx_spawner[child] = true
                            end

                        elseif item.disable_vfx_spawner_exclusion then

                            -- mod:echo("disable_vfx_spawner_exclusion: "..tostring(item.name))

                        end

                    end

                end
                
            end
        end

        -- Apply fixes
        mod:apply_unit_fixes(item_data, item_unit, attachment_units_by_unit, attachment_name_lookup, fixes, is_ui_item_preview)
        -- Return
        return attachment_units_by_unit, attachment_id_lookup, attachment_name_lookup, bind_poses_by_unit, item_name_by_unit
    end)

    mod:hook(instance, "spawn_item", function(func, item_data, attach_settings, parent_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment, ...)
        -- Modify item
        mod:modify_item(item_data)
        -- Fixes
        local fixes = mod:collect_fixes(item_data)
        mod:apply_attachment_fixes(item_data, fixes)
        -- Original function
        local item_unit, attachment_units_by_unit, bind_pose, attachment_id_lookup, attachment_name_lookup, attachment_units_bind_poses, item_name_by_unit = func(item_data, attach_settings, parent_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment, ...)

        if attachment_id_lookup and item_data.attachments then

            -- Collect current attachment names
            local kitbash_fixes = mod:fetch_attachment_fixes(item_data.attachments)
            if kitbash_fixes then
                fixes = table_merge_recursive(fixes, kitbash_fixes)
            end

            for _, attachment_unit in pairs(attachment_units_by_unit[item_unit]) do

                local attachment_slot = attachment_id_lookup[attachment_unit]
                unit_set_data(attachment_unit, "attachment_slot", attachment_slot)
                
                local item_path = mod:fetch_attachment(item_data.attachments, attachment_slot)
                local item = master_items.get_item(item_path)

                if item and item.attachments then
                    -- Collect current attachment names
                    local kitbash_fixes = mod:fetch_attachment_fixes(item.attachments)
                    if kitbash_fixes then
                        fixes = table_merge_recursive(fixes, kitbash_fixes)
                    end
                end

            end

        end

        -- Apply fixes
        mod:apply_unit_fixes(item_data, item_unit, attachment_units_by_unit, attachment_name_lookup, fixes, true)
        -- Return
        return item_unit, attachment_units_by_unit, bind_pose, attachment_id_lookup, attachment_name_lookup, attachment_units_bind_poses, item_name_by_unit
    end)
    
    local string = string
    local table_size = table.size
    local string_find = string.find

    mod:hook(instance, "generate_attachment_overrides_lookup", function(func, item_data, override_item_data, ...)

        -- Original function
        local override_lookup = func(item_data, override_item_data, ...)
        
        if override_lookup and table_size(override_lookup) > 0 then
            for attachment_slot, replacement_path in pairs(override_lookup) do
                if not string_find(replacement_path, "skins") then
                    override_lookup[attachment_slot] = nil
                end
            end
        end

        -- Return
        return override_lookup
    end)

end)
