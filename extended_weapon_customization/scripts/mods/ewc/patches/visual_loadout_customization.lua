--#region Old
    -- local mod = get_mod("extended_weapon_customization")

    -- -- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
    -- -- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
    -- -- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

    -- local VisualLoadoutExtractData = mod:original_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_extract_data")
    -- local ItemSlotUtils = mod:original_require("scripts/utilities/item_slot_utils")
    -- local master_items = mod:original_require("scripts/backend/master_items")

    -- -- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
    -- -- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
    -- -- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
    -- -- #region Performance
    --     local unit = Unit
    --     local pairs = pairs
    --     local table = table
    --     local world = World
    --     local string = string
    --     local tostring = tostring
    --     local tonumber = tonumber
    --     local Managers = Managers
    --     local unit_node = unit.node
    --     local table_size = table.size
    --     local unit_alive = unit.alive
    --     local table_clear = table.clear
    --     local string_find = string.find
    --     local table_append = table.append
    --     local string_split = string.split
    --     local table_reverse = table.reverse
    --     local unit_set_data = unit.set_data
    --     local unit_get_data = unit.get_data
    --     local table_combine = table.combine
    --     local unit_has_node = unit.has_node
    --     local table_icombine = table.icombine
    --     local world_destroy_unit = world.destroy_unit
    --     local table_set_readonly = table.set_readonly
    --     local unit_get_child_units = unit.get_child_units
    --     local table_merge_recursive = table.merge_recursive
    -- --#endregion

    -- -- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
    -- -- #####  ││├─┤ │ ├─┤ #################################################################################################
    -- -- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

    -- local pt = mod:pt()
    -- local PROCESS_SLOTS = {"WEAPON_SKIN", "WEAPON_MELEE", "WEAPON_RANGED"}
    -- local PROCESS_ITEM_TYPES = {"WEAPON_MELEE", "WEAPON_RANGED"}
    -- local TEMP_CHILDREN = {}

    -- -- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
    -- -- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
    -- -- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

    -- mod.recursive_children = function(self, unit, attachment_units_by_unit, children)
    --     -- Table
    --     if not children then
    --         table_clear(TEMP_CHILDREN)
    --         children = TEMP_CHILDREN
    --     end
    --     -- Get children
    --     local unit_children = attachment_units_by_unit[unit]
    --     -- Iterate through children
    --     for _, unit in pairs(unit_children) do
    --         -- Add child
    --         children[#children+1] = unit
    --         -- Recursive
    --         self:recursive_children(unit, attachment_units_by_unit, children)
    --     end
    --     -- Return
    --     return children
    -- end

    -- mod.implement_units = function(self, item_unit, attachments, attachment_units_by_unit, attachment_id_lookup, attachment_name_lookup, units)
    --     if item_unit then
    --         -- Save unit

    --         -- Get sub-attachment units
    --         local units = units or attachment_units_by_unit[item_unit]
    --         -- Check units
    --         if units then
    --             -- Iterate through units
    --             for _, unit in pairs(units) do
    --                 -- Set attachment slot
    --                 local slot = attachment_id_lookup[unit]
    --                 local attachment_slot_parts = string_split(slot, ".")
    --                 local attachment_slot = attachment_slot_parts and attachment_slot_parts[#attachment_slot_parts]
    --                 unit_set_data(unit, "attachment_slot", attachment_slot)
    --                 unit_set_data(unit, "attachment_slot_long", attachment_id_lookup[unit])
    --                 -- Get item path
    --                 local item_path = mod:fetch_attachment(attachments, attachment_slot)
    --                 -- Set attachment name
    --                 local attachment_name = self.settings.attachment_name_by_item_string[item_path]
    --                 unit_set_data(unit, "attachment_name", attachment_name)
    --                 -- Get attachment master item
    --                 local item = master_items.get_item(item_path)
    --                 -- Check item
    --                 if item and item.attachments then
    --                     -- Implement units
    --                     self:implement_units(item_unit, item.attachments, attachment_units_by_unit, attachment_id_lookup, attachment_name_lookup, attachment_units_by_unit[unit])
    --                 end
    --             end
    --         end
    --     end
    -- end

    -- -- mod.register_unit = function(self, unit)
    -- --     pt.spawned_units[unit] = true
    -- --     self:print("registered unit: "..tostring(unit))
    -- -- end

    -- -- mod.delete_all_units = function(self)
    -- --     local world = self:world()
    -- --     if world then
    -- --         for unit, _ in pairs(pt.spawned_units) do
    -- --             if unit and unit_alive(unit) then
    -- --                 world_destroy_unit(world, unit)
    -- --                 mod:print("deleted unit: "..tostring(unit))
    -- --             end
    -- --         end
    -- --         table_clear(pt.spawned_units)
    -- --     else
    -- --         mod:print("error - world: "..tostring(world))
    -- --     end
    -- -- end

    -- -- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
    -- -- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
    -- -- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

    -- mod:hook_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization", function(instance)

    --     instance.handle_sub_attachments_recursive = function(self, item_data, attachment_name, attachment_unit, attach_settings, attachment_units_by_unit, attachment_id_lookup)

    --         if item_data.attachments and attachment_units_by_unit[attachment_unit] then

    --             for _, sub_attachment_unit in pairs(attachment_units_by_unit[attachment_unit]) do

    --                 -- Register unit
    --                 -- mod:register_unit(sub_attachment_unit)

    --                 -- Set attachment slot
    --                 local attachment_slot_parts = string_split(attachment_id_lookup[sub_attachment_unit], ".")
    --                 local attachment_slot = attachment_slot_parts and attachment_slot_parts[#attachment_slot_parts]
    --                 unit_set_data(sub_attachment_unit, "attachment_slot", attachment_slot)
    --                 unit_set_data(attachment_unit, "attachment_slot_long", attachment_id_lookup[sub_attachment_unit])

    --                 -- Get master item
    --                 local item_path = mod:fetch_attachment(item_data.attachments, attachment_slot)

    --                 local attachment_slot_data = mod:fetch_attachment_data(item_data.attachments, attachment_slot)
    --                 local sub_item = master_items.get_item(item_path)
    --                 local parent_attachment_slot_data = mod:fetch_attachment_parent(item_data.attachments, attachment_slot)
    --                 local material_overrides_data = mod:gear_material_overrides(item_data, nil, attachment_slot) or (attachment_slot_data and attachment_slot_data.material_overrides and attachment_slot_data) or (parent_attachment_slot_data and parent_attachment_slot_data.material_overrides and parent_attachment_slot_data) --or sub_item
    --                 if material_overrides_data then
    --                     instance.apply_material_overrides(material_overrides_data, sub_attachment_unit, attachment_unit, attach_settings)
    --                 end

    --                 -- Set attachment name
    --                 local sub_attachment_name = mod.settings.attachment_name_by_item_string[item_path] or attachment_name
    --                 unit_set_data(sub_attachment_unit, "attachment_name", sub_attachment_name)

    --                 mod:print("sub attachment: "..tostring(sub_attachment_unit).." name: "..tostring(sub_attachment_name).." slot: "..tostring(attachment_slot))

    --                 instance:handle_sub_attachments_recursive(item_data, attachment_name, sub_attachment_unit, attach_settings, attachment_units_by_unit, attachment_id_lookup)

    --             end
    --         end

    --     end

    --     mod:hook(instance, "spawn_item_attachments", function(func, item_data, override_lookup, attach_settings, item_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment, ...)

    --         -- Check item
    --         if item_data and mod:cached_table_contains(PROCESS_ITEM_TYPES, item_data.item_type) then
    --             -- Modify item
    --             mod:modify_item(item_data)
    --         end

    --         -- Fixes
    --         local fixes = mod:collect_fixes(item_data)
    --         mod:apply_attachment_fixes(item_data, fixes)
            
    --         -- Original function
    --         local attachment_units_by_unit, attachment_id_lookup, attachment_name_lookup, bind_poses_by_unit, item_name_by_unit = func(item_data, override_lookup, attach_settings, item_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment, ...)

    --         -- local is_ui_item_preview = false
    --         local is_ui_item_preview = (item_data and (item_data.__is_ui_item_preview or item_data.__is_preview_item or item_data.__attachment_customization))
    --         if attachment_id_lookup and item_data.attachments then

    --             mod:implement_units(item_unit, item_data.attachments, attachment_units_by_unit, attachment_id_lookup, attachment_name_lookup)

    --             -- Collect attachment fixes
    --             local kitbash_fixes = mod:fetch_attachment_fixes(item_data.structure or item_data.attachments)
    --             if kitbash_fixes then
    --                 fixes = table_merge_recursive(fixes, kitbash_fixes)
    --             end

    --             for _, attachment_unit in pairs(attachment_units_by_unit[item_unit]) do

    --                 -- Set attachment slot
    --                 local attachment_slot_parts = string_split(attachment_id_lookup[attachment_unit], ".")
    --                 local attachment_slot = attachment_slot_parts and attachment_slot_parts[#attachment_slot_parts]
    --                 unit_set_data(attachment_unit, "attachment_slot", attachment_slot)
    --                 unit_set_data(attachment_unit, "attachment_slot_long", attachment_id_lookup[attachment_unit])

    --                 -- Get item path
    --                 local item_path = mod:fetch_attachment(item_data.attachments, attachment_slot)
    --                 local item = master_items.get_item(item_path)
    --                 local parent_attachment_slot_data = mod:fetch_attachment_data(item_data.attachments, attachment_slot)
    --                 local material_overrides_data = mod:gear_material_overrides(item_data, nil, attachment_slot) or (parent_attachment_slot_data and parent_attachment_slot_data.material_overrides and parent_attachment_slot_data) --or item
    --                 mod:generate_material_override_items(material_overrides_data)
    --                 if material_overrides_data and material_overrides_data.material_override_items then
    --                     instance.apply_material_overrides(material_overrides_data, attachment_unit, item_unit, attach_settings)
    --                 end

    --                 -- Set attachment name
    --                 local attachment_name = mod.settings.attachment_name_by_item_string[item_path]
    --                 unit_set_data(attachment_unit, "attachment_name", attachment_name)

    --                 if item_data.attachments.slot_trinket_1 and item_data.attachments.slot_trinket_1.item then
    --                     -- This is a preview item in attachment customization menu

    --                     is_ui_item_preview = true

    --                     -- Get item path
    --                     local item = item_data.attachments.slot_trinket_1.item
    --                     local item_path = item.name

    --                     -- Execute ui item init function for attachment
    --                     local attachment_data = mod.settings.attachment_data_by_item_string[item_path]
    --                     if attachment_data and attachment_data.ui_item_init then
    --                         local world = attach_settings.world
    --                         attachment_data.ui_item_init(world, attachment_unit, attachment_data, true)
    --                     end

    --                     -- Collect attachment fixes
    --                     if item and item.attachments then
    --                         local kitbash_fixes = mod:fetch_attachment_fixes(item.structure or item.attachments)
    --                         if kitbash_fixes then
    --                             fixes = table_merge_recursive(fixes, kitbash_fixes)
    --                         end

    --                         instance:handle_sub_attachments_recursive(item_data, attachment_name, attachment_unit, attach_settings, attachment_units_by_unit, attachment_id_lookup)

    --                     end

    --                 else -- This is a normal item

    --                     -- Get master item
    --                     local item = master_items.get_item(item_path)

    --                     -- Execute ui item init function for attachment
    --                     -- Only execute if not from ui profile spawner or ui item preview
    --                     if is_ui_item_preview and not attach_settings.from_ui_profile_spawner then
    --                         -- Get attachment data
    --                         local attachment_data = mod.settings.attachment_data_by_item_string[item_path]
    --                         if attachment_data and attachment_data.ui_item_init then
    --                             local world = attach_settings.world
    --                             attachment_data.ui_item_init(world, attachment_unit, attachment_data)
    --                         end
    --                     end

    --                     if item and item.attachments then

    --                         -- Collect current attachment names
    --                         local kitbash_fixes = mod:fetch_attachment_fixes(item.structure or item.attachments)
    --                         if kitbash_fixes then
    --                             fixes = table_merge_recursive(fixes, kitbash_fixes)
    --                         end

    --                         -- Exlcude from vfx spawner
    --                         if item.is_kitbash and not item.disable_vfx_spawner_exclusion then

    --                             for unit, _ in pairs(pt.exclude_from_vfx_spawner) do
    --                                 if not unit or not unit_alive(unit) then
    --                                     pt.exclude_from_vfx_spawner[unit] = nil
    --                                 end
    --                             end

    --                             pt.exclude_from_vfx_spawner[attachment_unit] = true

    --                             local all_children = mod:recursive_children(attachment_unit, attachment_units_by_unit)
    --                             for _, child in pairs(all_children) do
    --                                 pt.exclude_from_vfx_spawner[child] = true
    --                             end

    --                         elseif item.disable_vfx_spawner_exclusion then

    --                             mod:print("disable_vfx_spawner_exclusion: "..tostring(item.name))

    --                         end

    --                         instance:handle_sub_attachments_recursive(item_data, attachment_name, attachment_unit, attach_settings, attachment_units_by_unit, attachment_id_lookup)

    --                     end

    --                 end
                    
    --             end

    --         end

    --         -- Apply fixes
    --         mod:apply_unit_fixes(item_data, item_unit, attachment_units_by_unit, attachment_name_lookup, fixes, is_ui_item_preview)

    --         -- Return
    --         return attachment_units_by_unit, attachment_id_lookup, attachment_name_lookup, bind_poses_by_unit, item_name_by_unit

    --     end)

    --     mod:hook(instance, "spawn_item", function(func, item_data, attach_settings, parent_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment, ...)

    --         -- Check item
    --         if item_data and mod:cached_table_contains(PROCESS_ITEM_TYPES, item_data.item_type) then
    --             -- Modify item
    --             mod:modify_item(item_data)
    --         end

    --         -- Fixes
    --         local fixes = mod:collect_fixes(item_data)
    --         mod:apply_attachment_fixes(item_data, fixes)

    --         -- Original function
    --         local item_unit, attachment_units_by_unit, bind_pose, attachment_id_lookup, attachment_name_lookup, attachment_units_bind_poses, item_name_by_unit = func(item_data, attach_settings, parent_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment, ...)

    --         if attachment_id_lookup and item_data.attachments then

    --             mod:implement_units(item_unit, item_data.attachments, attachment_units_by_unit, attachment_id_lookup, attachment_name_lookup)

    --             -- Collect current attachment names
    --             local kitbash_fixes = mod:fetch_attachment_fixes(item_data.structure or item_data.attachments)
    --             if kitbash_fixes then
    --                 fixes = table_merge_recursive(fixes, kitbash_fixes)
    --             end

    --             for _, attachment_unit in pairs(attachment_units_by_unit[item_unit]) do

    --                 -- Set attachment slot
    --                 local attachment_slot_parts = string_split(attachment_id_lookup[attachment_unit], ".")
    --                 local attachment_slot = attachment_slot_parts and attachment_slot_parts[#attachment_slot_parts]
    --                 unit_set_data(attachment_unit, "attachment_slot", attachment_slot)
    --                 unit_set_data(attachment_unit, "attachment_slot_long", attachment_id_lookup[attachment_unit])

                    
    --                 -- Get master item
    --                 local item_path = mod:fetch_attachment(item_data.attachments, attachment_slot)
    --                 local item = master_items.get_item(item_path)
    --                 local parent_attachment_slot_data = mod:fetch_attachment_data(item_data.attachments, attachment_slot)
    --                 local material_overrides_data = mod:gear_material_overrides(item_data, nil, attachment_slot) or (parent_attachment_slot_data and parent_attachment_slot_data.material_overrides and parent_attachment_slot_data) --or item
    --                 mod:generate_material_override_items(material_overrides_data)
    --                 if material_overrides_data and material_overrides_data.material_override_items then
    --                     instance.apply_material_overrides(material_overrides_data, attachment_unit, item_unit, attach_settings)
    --                 end

    --                 -- Set attachment name
    --                 local attachment_name = mod.settings.attachment_name_by_item_string[item_path]
    --                 unit_set_data(attachment_unit, "attachment_name", attachment_name)

    --                 if item and item.attachments then

    --                     -- Collect current attachment names
    --                     local kitbash_fixes = mod:fetch_attachment_fixes(item.structure or item.attachments)
    --                     if kitbash_fixes then
    --                         fixes = table_merge_recursive(fixes, kitbash_fixes)
    --                     end

    --                     if item.is_kitbash and not item.disable_vfx_spawner_exclusion then

    --                         local deleted = 0
    --                         for unit, _ in pairs(pt.exclude_from_vfx_spawner) do
    --                             if not unit or not unit_alive(unit) then
    --                                 pt.exclude_from_vfx_spawner[unit] = nil
    --                                 deleted = deleted + 1
    --                             end
    --                         end
    --                         if deleted > 0 then
    --                             mod:print("exclude_from_vfx_spawner deleted: "..tostring(deleted))
    --                         end

    --                         pt.exclude_from_vfx_spawner[attachment_unit] = true

    --                         local all_children = mod:recursive_children(attachment_unit, attachment_units_by_unit)
    --                         for _, child in pairs(all_children) do
    --                             pt.exclude_from_vfx_spawner[child] = true
    --                         end

    --                     elseif item.disable_vfx_spawner_exclusion then

    --                         mod:print("disable_vfx_spawner_exclusion: "..tostring(item.name))

    --                     end

    --                     instance:handle_sub_attachments_recursive(item_data, attachment_name, attachment_unit, attach_settings, attachment_units_by_unit, attachment_id_lookup)

    --                 end

    --             end

    --         end

    --         -- Apply fixes
    --         mod:apply_unit_fixes(item_data, item_unit, attachment_units_by_unit, attachment_name_lookup, fixes, true)

    --         -- Return
    --         return item_unit, attachment_units_by_unit, bind_pose, attachment_id_lookup, attachment_name_lookup, attachment_units_bind_poses, item_name_by_unit

    --     end)

    --     mod:hook(instance, "generate_attachment_overrides_lookup", function(func, item_data, override_item_data, ...)

    --         -- Original function
    --         local override_lookup = func(item_data, override_item_data, ...)
            
    --         if mod:cached_table_contains(PROCESS_ITEM_TYPES, item_data.item_type) then
    --             if override_lookup and table_size(override_lookup) > 0 then
    --                 for attachment_slot, replacement_path in pairs(override_lookup) do
    --                     if not string_find(replacement_path, "skins") then
    --                         override_lookup[attachment_slot] = nil
    --                     end
    --                 end
    --             end
    --         end

    --         -- Return
    --         return override_lookup
    --     end)

    --     mod:check_visual_loadout_customization_community_patch()

    --     if not mod.vlcp_missing then

    --         -- Reset parent and node method to earlier game version
    --         mod:hook(instance, "_find_unit_node_recursive", function(func, unit, attach_node, item_data, attach_settings, extract_data, ...)

    --             -- local parent_unit = nil
    --             -- local attach_node_index = nil

    --             -- local child_units = unit_get_child_units(unit)

    --             -- for _, child_unit in pairs(child_units) do
    --             --     parent_unit, attach_node_index = instance._find_unit_node_recursive(child_unit, attach_node)
    --             -- end

    --             -- if unit_has_node(unit, attach_node) then
    --             --     parent_unit = unit
    --             --     attach_node_index = unit_node(unit, attach_node)
    --             -- end

    --             -- return parent_unit, attach_node_index

    --             local attach_node_index

    --             if tonumber(attach_node) ~= nil then
    --                 attach_node_index = tonumber(attach_node)
    --             elseif attach_node then
    --                 attach_node_index = unit_has_node(unit, attach_node) and unit_node(unit, attach_node) or 1
    --             else
    --                 attach_node_index = 1
    --             end

    --             return unit, attach_node_index

    --             -- return func(unit, attach_node, item_data, attach_settings, extract_data, ...)

    --         end)

    --     end

    -- end)
--#endregion

local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local VisualLoadoutExtractData = mod:original_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_extract_data")
local ItemSlotUtils = mod:original_require("scripts/utilities/item_slot_utils")
local master_items = mod:original_require("scripts/backend/master_items")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local pairs = pairs
    local table = table
    local world = World
    local string = string
    local tostring = tostring
    local tonumber = tonumber
    local Managers = Managers
    local unit_node = unit.node
    local table_size = table.size
    local unit_alive = unit.alive
    local table_clear = table.clear
    local string_find = string.find
    local string_match = string.match
    local table_append = table.append
    local table_reverse = table.reverse
    local unit_set_data = unit.set_data
    local unit_get_data = unit.get_data
    local table_combine = table.combine
    local unit_has_node = unit.has_node
    local table_icombine = table.icombine
    local world_destroy_unit = world.destroy_unit
    local table_set_readonly = table.set_readonly
    local unit_get_child_units = unit.get_child_units
    local table_merge_recursive = table.merge_recursive
    local master_items_get_item = master_items.get_item
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local pt = mod:pt()
local PROCESS_SLOTS = {"WEAPON_SKIN", "WEAPON_MELEE", "WEAPON_RANGED"}
local PROCESS_ITEM_TYPES = {"WEAPON_MELEE", "WEAPON_RANGED"}
local TEMP_CHILDREN = {}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.recursive_children = function(self, unit, attachment_units_by_unit, children)
    -- Table
    if not children then
        table_clear(TEMP_CHILDREN)
        children = TEMP_CHILDREN
    end
    -- Get children
    local unit_children = attachment_units_by_unit[unit]
    -- Iterate through children
    for _, unit in pairs(unit_children) do
        -- Add child
        children[#children+1] = unit
        -- Recursive
        self:recursive_children(unit, attachment_units_by_unit, children)
    end
    -- Return
    return children
end

mod.implement_units = function(self, item_unit, attachments, attachment_units_by_unit, attachment_id_lookup, attachment_name_lookup, units)
    if item_unit then
        -- Save unit

        -- Get sub-attachment units
        local units = units or attachment_units_by_unit[item_unit]
        -- Check units
        if units then
            -- Iterate through units
            for _, unit in pairs(units) do
                -- Set attachment slot
                local slot = attachment_id_lookup[unit]
                local attachment_slot = slot and string_match(slot, "[^.]+$")
                unit_set_data(unit, "attachment_slot", attachment_slot)
                unit_set_data(unit, "attachment_slot_long", attachment_id_lookup[unit])
                -- Get item path
                local item_path = mod:fetch_attachment(attachments, attachment_slot)
                -- Set attachment name
                local attachment_name = self.settings.attachment_name_by_item_string[item_path]
                unit_set_data(unit, "attachment_name", attachment_name)
                -- Get attachment master item
                local item = master_items_get_item(item_path)
                -- Check item
                if item and item.attachments then
                    -- Implement units
                    self:implement_units(item_unit, item.attachments, attachment_units_by_unit, attachment_id_lookup, attachment_name_lookup, attachment_units_by_unit[unit])
                end
            end
        end
    end
end

-- mod.register_unit = function(self, unit)
--     pt.spawned_units[unit] = true
--     self:print("registered unit: "..tostring(unit))
-- end

-- mod.delete_all_units = function(self)
--     local world = self:world()
--     if world then
--         for unit, _ in pairs(pt.spawned_units) do
--             if unit and unit_alive(unit) then
--                 world_destroy_unit(world, unit)
--                 mod:print("deleted unit: "..tostring(unit))
--             end
--         end
--         table_clear(pt.spawned_units)
--     else
--         mod:print("error - world: "..tostring(world))
--     end
-- end

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization", function(instance)

    instance.handle_sub_attachments_recursive = function(self, item_data, attachment_name, attachment_unit, attach_settings, attachment_units_by_unit, attachment_id_lookup)

        if item_data.attachments and attachment_units_by_unit[attachment_unit] then

            for _, sub_attachment_unit in pairs(attachment_units_by_unit[attachment_unit]) do

                -- Register unit
                -- mod:register_unit(sub_attachment_unit)

                -- Set attachment slot
                local attachment_slot = attachment_id_lookup[sub_attachment_unit] and string_match(attachment_id_lookup[sub_attachment_unit], "[^.]+$")
                unit_set_data(sub_attachment_unit, "attachment_slot", attachment_slot)
                unit_set_data(attachment_unit, "attachment_slot_long", attachment_id_lookup[sub_attachment_unit])

                -- Get master item
                local item_path = mod:fetch_attachment(item_data.attachments, attachment_slot)

                local attachment_slot_data = mod:fetch_attachment_data(item_data.attachments, attachment_slot)
                local sub_item = master_items_get_item(item_path)
                local parent_attachment_slot_data = mod:fetch_attachment_parent(item_data.attachments, attachment_slot)
                local material_overrides_data = mod:gear_material_overrides(item_data, nil, attachment_slot) or (attachment_slot_data and attachment_slot_data.material_overrides and attachment_slot_data) or (parent_attachment_slot_data and parent_attachment_slot_data.material_overrides and parent_attachment_slot_data) --or sub_item
                if material_overrides_data then
                    instance.apply_material_overrides(material_overrides_data, sub_attachment_unit, attachment_unit, attach_settings)
                end

                -- Set attachment name
                local sub_attachment_name = mod.settings.attachment_name_by_item_string[item_path] or attachment_name
                unit_set_data(sub_attachment_unit, "attachment_name", sub_attachment_name)

                mod:print("sub attachment: "..tostring(sub_attachment_unit).." name: "..tostring(sub_attachment_name).." slot: "..tostring(attachment_slot))

                instance:handle_sub_attachments_recursive(item_data, attachment_name, sub_attachment_unit, attach_settings, attachment_units_by_unit, attachment_id_lookup)

            end
        end

    end

    mod:hook(instance, "spawn_item_attachments", function(func, item_data, override_lookup, attach_settings, item_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment, ...)

        -- Check item
        if item_data and mod:cached_table_contains(PROCESS_ITEM_TYPES, item_data.item_type) then
            -- Modify item
            mod:modify_item(item_data)
        end

        -- Fixes
        local fixes = mod:collect_fixes(item_data)
        mod:apply_attachment_fixes(item_data, fixes)
        
        -- Original function
        local attachment_units_by_unit, attachment_id_lookup, attachment_name_lookup, bind_poses_by_unit, item_name_by_unit = func(item_data, override_lookup, attach_settings, item_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment, ...)

        -- local is_ui_item_preview = false
        local is_ui_item_preview = (item_data and (item_data.__is_ui_item_preview or item_data.__is_preview_item or item_data.__attachment_customization))
        if attachment_id_lookup and item_data.attachments then

            mod:implement_units(item_unit, item_data.attachments, attachment_units_by_unit, attachment_id_lookup, attachment_name_lookup)

            -- Collect attachment fixes
            local kitbash_fixes = mod:fetch_attachment_fixes(item_data.structure or item_data.attachments)
            if kitbash_fixes then
                fixes = table_merge_recursive(fixes, kitbash_fixes)
            end

            for _, attachment_unit in pairs(attachment_units_by_unit[item_unit]) do

                -- Set attachment slot
                local attachment_slot = attachment_id_lookup[attachment_unit] and string_match(attachment_id_lookup[attachment_unit], "[^.]+$")
                unit_set_data(attachment_unit, "attachment_slot", attachment_slot)
                unit_set_data(attachment_unit, "attachment_slot_long", attachment_id_lookup[attachment_unit])

                -- Get item path
                local item_path = mod:fetch_attachment(item_data.attachments, attachment_slot)
                local item = master_items_get_item(item_path)
                local parent_attachment_slot_data = mod:fetch_attachment_data(item_data.attachments, attachment_slot)
                local material_overrides_data = mod:gear_material_overrides(item_data, nil, attachment_slot) or (parent_attachment_slot_data and parent_attachment_slot_data.material_overrides and parent_attachment_slot_data) --or item
                mod:generate_material_override_items(material_overrides_data)
                if material_overrides_data and material_overrides_data.material_override_items then
                    instance.apply_material_overrides(material_overrides_data, attachment_unit, item_unit, attach_settings)
                end

                -- Set attachment name
                local attachment_name = mod.settings.attachment_name_by_item_string[item_path]
                unit_set_data(attachment_unit, "attachment_name", attachment_name)

                if item_data.attachments.slot_trinket_1 and item_data.attachments.slot_trinket_1.item then
                    -- This is a preview item in attachment customization menu

                    is_ui_item_preview = true

                    -- Get item path
                    local item = item_data.attachments.slot_trinket_1.item
                    local item_path = item.name

                    -- Execute ui item init function for attachment
                    local attachment_data = mod.settings.attachment_data_by_item_string[item_path]
                    if attachment_data and attachment_data.ui_item_init then
                        local world = attach_settings.world
                        attachment_data.ui_item_init(world, attachment_unit, attachment_data, true)
                    end

                    -- Collect attachment fixes
                    if item and item.attachments then
                        local kitbash_fixes = mod:fetch_attachment_fixes(item.structure or item.attachments)
                        if kitbash_fixes then
                            fixes = table_merge_recursive(fixes, kitbash_fixes)
                        end

                        instance:handle_sub_attachments_recursive(item_data, attachment_name, attachment_unit, attach_settings, attachment_units_by_unit, attachment_id_lookup)

                    end

                else -- This is a normal item

                    -- Get master item (already resolved above for this attachment_slot/item_path; avoid a redundant lookup)

                    -- Execute ui item init function for attachment
                    -- Only execute if not from ui profile spawner or ui item preview
                    if is_ui_item_preview and not attach_settings.from_ui_profile_spawner then
                        -- Get attachment data
                        local attachment_data = mod.settings.attachment_data_by_item_string[item_path]
                        if attachment_data and attachment_data.ui_item_init then
                            local world = attach_settings.world
                            attachment_data.ui_item_init(world, attachment_unit, attachment_data)
                        end
                    end

                    if item and item.attachments then

                        -- Collect current attachment names
                        local kitbash_fixes = mod:fetch_attachment_fixes(item.structure or item.attachments)
                        if kitbash_fixes then
                            fixes = table_merge_recursive(fixes, kitbash_fixes)
                        end

                        -- Exlcude from vfx spawner
                        if item.is_kitbash and not item.disable_vfx_spawner_exclusion then

                            for unit, _ in pairs(pt.exclude_from_vfx_spawner) do
                                if not unit or not unit_alive(unit) then
                                    pt.exclude_from_vfx_spawner[unit] = nil
                                end
                            end

                            pt.exclude_from_vfx_spawner[attachment_unit] = true

                            local all_children = mod:recursive_children(attachment_unit, attachment_units_by_unit)
                            for _, child in pairs(all_children) do
                                pt.exclude_from_vfx_spawner[child] = true
                            end

                        elseif item.disable_vfx_spawner_exclusion then

                            mod:print("disable_vfx_spawner_exclusion: "..tostring(item.name))

                        end

                        instance:handle_sub_attachments_recursive(item_data, attachment_name, attachment_unit, attach_settings, attachment_units_by_unit, attachment_id_lookup)

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

        -- Check item
        if item_data and mod:cached_table_contains(PROCESS_ITEM_TYPES, item_data.item_type) then
            -- Modify item
            mod:modify_item(item_data)
        end

        -- Fixes
        local fixes = mod:collect_fixes(item_data)
        mod:apply_attachment_fixes(item_data, fixes)

        -- Original function
        local item_unit, attachment_units_by_unit, bind_pose, attachment_id_lookup, attachment_name_lookup, attachment_units_bind_poses, item_name_by_unit = func(item_data, attach_settings, parent_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment, ...)

        if attachment_id_lookup and item_data.attachments then

            mod:implement_units(item_unit, item_data.attachments, attachment_units_by_unit, attachment_id_lookup, attachment_name_lookup)

            -- Collect current attachment names
            local kitbash_fixes = mod:fetch_attachment_fixes(item_data.structure or item_data.attachments)
            if kitbash_fixes then
                fixes = table_merge_recursive(fixes, kitbash_fixes)
            end

            for _, attachment_unit in pairs(attachment_units_by_unit[item_unit]) do

                -- Set attachment slot
                local attachment_slot = attachment_id_lookup[attachment_unit] and string_match(attachment_id_lookup[attachment_unit], "[^.]+$")
                unit_set_data(attachment_unit, "attachment_slot", attachment_slot)
                unit_set_data(attachment_unit, "attachment_slot_long", attachment_id_lookup[attachment_unit])

                
                -- Get master item
                local item_path = mod:fetch_attachment(item_data.attachments, attachment_slot)
                local item = master_items_get_item(item_path)
                local parent_attachment_slot_data = mod:fetch_attachment_data(item_data.attachments, attachment_slot)
                local material_overrides_data = mod:gear_material_overrides(item_data, nil, attachment_slot) or (parent_attachment_slot_data and parent_attachment_slot_data.material_overrides and parent_attachment_slot_data) --or item
                mod:generate_material_override_items(material_overrides_data)
                if material_overrides_data and material_overrides_data.material_override_items then
                    instance.apply_material_overrides(material_overrides_data, attachment_unit, item_unit, attach_settings)
                end

                -- Set attachment name
                local attachment_name = mod.settings.attachment_name_by_item_string[item_path]
                unit_set_data(attachment_unit, "attachment_name", attachment_name)

                if item and item.attachments then

                    -- Collect current attachment names
                    local kitbash_fixes = mod:fetch_attachment_fixes(item.structure or item.attachments)
                    if kitbash_fixes then
                        fixes = table_merge_recursive(fixes, kitbash_fixes)
                    end

                    if item.is_kitbash and not item.disable_vfx_spawner_exclusion then

                        local deleted = 0
                        for unit, _ in pairs(pt.exclude_from_vfx_spawner) do
                            if not unit or not unit_alive(unit) then
                                pt.exclude_from_vfx_spawner[unit] = nil
                                deleted = deleted + 1
                            end
                        end
                        if deleted > 0 then
                            mod:print("exclude_from_vfx_spawner deleted: "..tostring(deleted))
                        end

                        pt.exclude_from_vfx_spawner[attachment_unit] = true

                        local all_children = mod:recursive_children(attachment_unit, attachment_units_by_unit)
                        for _, child in pairs(all_children) do
                            pt.exclude_from_vfx_spawner[child] = true
                        end

                    elseif item.disable_vfx_spawner_exclusion then

                        mod:print("disable_vfx_spawner_exclusion: "..tostring(item.name))

                    end

                    instance:handle_sub_attachments_recursive(item_data, attachment_name, attachment_unit, attach_settings, attachment_units_by_unit, attachment_id_lookup)

                end

            end

        end

        -- Apply fixes
        mod:apply_unit_fixes(item_data, item_unit, attachment_units_by_unit, attachment_name_lookup, fixes, true)

        -- Return
        return item_unit, attachment_units_by_unit, bind_pose, attachment_id_lookup, attachment_name_lookup, attachment_units_bind_poses, item_name_by_unit

    end)

    mod:hook(instance, "generate_attachment_overrides_lookup", function(func, item_data, override_item_data, ...)

        -- Original function
        local override_lookup = func(item_data, override_item_data, ...)
        
        if mod:cached_table_contains(PROCESS_ITEM_TYPES, item_data.item_type) then
            if override_lookup and table_size(override_lookup) > 0 then
                for attachment_slot, replacement_path in pairs(override_lookup) do
                    if not string_find(replacement_path, "skins") then
                        override_lookup[attachment_slot] = nil
                    end
                end
            end
        end

        -- Return
        return override_lookup
    end)

    mod:check_visual_loadout_customization_community_patch()

    if not mod.vlcp_missing then

        -- Reset parent and node method to earlier game version
        mod:hook(instance, "_find_unit_node_recursive", function(func, unit, attach_node, item_data, attach_settings, extract_data, ...)

            -- local parent_unit = nil
            -- local attach_node_index = nil

            -- local child_units = unit_get_child_units(unit)

            -- for _, child_unit in pairs(child_units) do
            --     parent_unit, attach_node_index = instance._find_unit_node_recursive(child_unit, attach_node)
            -- end

            -- if unit_has_node(unit, attach_node) then
            --     parent_unit = unit
            --     attach_node_index = unit_node(unit, attach_node)
            -- end

            -- return parent_unit, attach_node_index

            local attach_node_index

            if tonumber(attach_node) ~= nil then
                attach_node_index = tonumber(attach_node)
            elseif attach_node then
                attach_node_index = unit_has_node(unit, attach_node) and unit_node(unit, attach_node) or 1
            else
                attach_node_index = 1
            end

            return unit, attach_node_index

            -- return func(unit, attach_node, item_data, attach_settings, extract_data, ...)

        end)

    end

end)
