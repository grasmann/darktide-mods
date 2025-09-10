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
    -- local unit = Unit
    local pairs = pairs
    local table = table
    -- local CLASS = CLASS
    -- local string = string
    -- local tostring = tostring
    -- local unit_alive = unit.alive
    -- local quaternion = Quaternion
    -- local vector3_box = Vector3Box
    -- local table_clone = table.clone
    local table_clear = table.clear
    -- local string_gsub = string.gsub
    -- local string_split = string.split
    -- local table_combine = table.combine
    -- local table_contains = table.contains
    -- local vector3_unbox = vector3_box.unbox
    local table_set_readonly = table.set_readonly
    -- local unit_get_child_units = unit.get_child_units
    -- local unit_set_local_scale = unit.set_local_scale
    local table_merge_recursive = table.merge_recursive
    -- local quaternion_from_vector = quaternion.from_vector
    -- local unit_set_local_position = unit.set_local_position
    -- local unit_set_local_rotation = unit.set_local_rotation
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

-- local PROCESS_SLOTS = {"WEAPON_MELEE", "WEAPON_RANGED", "KITBASH"}
-- local temp_fixes = {}
-- local temp_attachments = {}
-- local temp_requirement_parts = {}
local empty_overrides_table = table_set_readonly({})
local temp_children = {}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

-- mod.collect_fixes = function(self, item_data)
    
--     local item = item_data and (item_data.__is_ui_item_preview and item_data.__data) or item_data.__master_item or item_data
--     local item_type = item.item_type

--     -- Clear temp
--     table_clear(temp_fixes)

--     if table_contains(PROCESS_SLOTS, item_type) and item.attachments then

--         local weapon_template = item.weapon_template
--         local weapon_fixes = mod.settings.fixes[weapon_template]
--         if weapon_fixes then

--             local attachments = mod.settings.attachments[weapon_template]
--             if attachments then

--                 -- Clear temp
--                 table_clear(temp_attachments)

--                 -- Collect current attachment names
--                 for attachment_slot, attachment_entries in pairs(attachments) do
--                     -- Get current attachment path
--                     local attachment_item_path = self:fetch_attachment(item.attachments, attachment_slot)
--                     -- Iterate attachment entries
--                     for attachment_name, attachment_data in pairs(attachment_entries) do
--                         -- Check attachment path
--                         if attachment_item_path == attachment_data.replacement_path then
--                             -- Collect attachment name
--                             temp_attachments[attachment_slot] = attachment_name
--                             break
--                         end
--                     end
--                 end

--                 -- Collect fixes to apply
--                 for _, fix_entry in pairs(weapon_fixes) do
--                     local requirements_met = true
--                     -- Iterate through fix requirements
--                     for requirement_slot, requirement_data in pairs(fix_entry.requirements) do
--                         local requirement_met = true
--                         -- Fix data
--                         local positive = requirement_data.has and true or false
--                         local requirement_string = positive and requirement_data.has or requirement_data.missing
--                         local temp_requirement_parts = string_split(requirement_string, "|")
--                         -- Check validity
--                         if positive and not table_contains(temp_requirement_parts, temp_attachments[requirement_slot]) then
--                             requirement_met = false
--                         elseif not positive and table_contains(temp_requirement_parts, temp_attachments[requirement_slot]) then
--                             requirement_met = false
--                         end
--                         -- Break if not met
--                         if not requirement_met then
--                             requirements_met = false
--                             break
--                         end
--                     end
--                     -- Check if requirements are met
--                     if requirements_met then
--                         -- Collect fix
--                         temp_fixes[fix_entry.fix] = fix_entry.attachment_slot
--                     end
--                 end

--             end
--         end

--     end

--     return temp_fixes

-- end

-- mod.apply_unit_fixes = function(self, item_data, item_unit, attachment_units_by_unit, attachment_name_lookup, optional_fixes, is_ui_item_preview)
--     -- Item data
--     local item = item_data and (item_data.__is_ui_item_preview and item_data.__data) or item_data.__master_item or item_data
--     -- Check data
--     if item.attachments then
--         -- Get fixes
--         local fixes = optional_fixes or self:collect_fixes(item)
--         if fixes then
--             -- Iterate through fixes
--             for fix, attachment_slot in pairs(fixes) do
--                 -- Check fix valid
--                 if not fix.disable_in_ui or not is_ui_item_preview then
--                     -- Current attachment unit
--                     local attachment_unit = attachment_name_lookup[item_unit][attachment_slot]
--                     -- Check fix offset
--                     if fix.offset and attachment_unit and unit_alive(attachment_unit) then
--                         local offset = fix.offset
--                         local node = offset.node or 1
--                         -- Check offset data
--                         if offset.position then unit_set_local_position(attachment_unit, 1, vector3_unbox(offset.position)) end
--                         if offset.rotation then unit_set_local_rotation(attachment_unit, 1, quaternion_from_vector(vector3_unbox(offset.rotation))) end
--                         if offset.scale then unit_set_local_scale(attachment_unit, 1, vector3_unbox(offset.scale)) end
--                     end
--                 end
--             end
--         end
--     end
-- end

-- mod.apply_attachment_fixes = function(self, item_data, optional_fixes)
--     -- Item data
--     local item = item_data and (item_data.__is_ui_item_preview and item_data.__data) or item_data.__master_item or item_data
--     local item_type = item.item_type
--     -- Check data
--     if table_contains(PROCESS_SLOTS, item_type) and item.attachments then
--         -- Get fixes
--         local fixes = optional_fixes or self:collect_fixes(item)
--         if fixes then
--             -- Weapon data
--             local weapon_template = item.weapon_template
--             local attachments = mod.settings.attachments[weapon_template]
--             -- Iterate through fixes
--             for fix, attachment_slot in pairs(fixes) do
--                 -- Check fix attach
--                 if fix.attach then
--                     local attach = fix.attach
--                     -- Iterate through attach entries
--                     for attachment_slot, attachment_name in pairs(attach) do
--                         -- Get attachment path
--                         local attachment_item_path = attachments[attachment_slot][attachment_name].replacement_path
--                         -- Apply fix
--                         mod:modify_item(item, nil, {
--                             [attachment_slot] = attachment_item_path
--                         })
--                     end
--                 end
--             end
--         end
--     end
-- end

-- mod.kitbash_preload = function(self, structure, name, display_name, description, attach_node, optional_dev_name)
--     self:pt().kitbash_entries[name] = {
--         name = name,
--         display_name = display_name,
--         description = description,
--         attach_node = attach_node,
--         attachments = structure,
--         dev_name = optional_dev_name
--     }
-- end

-- mod.kitbash_item = function(self, structure, name, display_name, description, attach_node, optional_dev_name)
--     local template = table_clone(master_items.get_item("content/items/weapons/player/trinkets/unused_trinket"))
--     if template then
--         template.attachments = structure
--         template.feature_flags = {}
--         template.attach_node = attach_node
--         template.description = description
--         template.slots = {}
--         template.item_type = "KITBASH"
--         template.dev_name = optional_dev_name or ""
--         template.name = name
--         template.display_name = display_name
--         template.is_fallback_item = nil
--         template.is_kitbash = true

--         master_items.get_cached()[template.name] = template
--     end
-- end

-- mod.try_kitbash_load = function(self)
--     if not self.kitbash_loaded then
--         local kitbash_entries = self:pt().kitbash_entries
--         for name, kitbash_entry in pairs(kitbash_entries) do

--             self:kitbash_item(kitbash_entry.attachments, name, kitbash_entry.display_name, kitbash_entry.description, kitbash_entry.attach_node, kitbash_entry.dev_name)

--         end
--         self.kitbash_loaded = true
--     end
-- end

-- mod:kitbash_preload(
--     {
--         base = {
--             item = "content/items/weapons/player/ranged/sights/reflex_sight_03",
--             fix = {
--                 disable_in_ui = true,
--                 offset = {
--                     node = 1,
--                     position = vector3_box(0, 0, .115),
--                     rotation = vector3_box(0, 0, 0),
--                     scale = vector3_box(1, 1, 1),
--                 },
--             },
--             children = {
--                 body = {
--                     item = "content/items/weapons/player/ranged/muzzles/lasgun_rifle_krieg_muzzle_02",
--                     fix = {
--                         offset = {
--                             node = 1,
--                             position = vector3_box(0, -.04, .05),
--                             rotation = vector3_box(0, 0, 0),
--                             scale = vector3_box(1.5, 1.5, 1.5),
--                         },
--                     },
--                     children = {
--                         lense_1 = {
--                             item = "content/items/weapons/player/ranged/bullets/rippergun_rifle_bullet_01",
--                             fix = {
--                                 offset = {
--                                     node = 1,
--                                     position = vector3_box(0, .085, 0),
--                                     rotation = vector3_box(0, 0, 0),
--                                     scale = vector3_box(1, .35, 1),
--                                 },
--                             },
--                         },
--                         lense_2 = {
--                             item = "content/items/weapons/player/ranged/bullets/rippergun_rifle_bullet_01",
--                             fix = {
--                                 offset = {
--                                     node = 1,
--                                     position = vector3_box(0, .075, 0),
--                                     rotation = vector3_box(180, 0, 0),
--                                     scale = vector3_box(1, .35, 1),
--                                 },
--                             },
--                         },
--                     },
--                 },
--             },
--         },
--     },
--     "content/items/weapons/player/ranged/sights/scope_01",
--     "loc_scope_01",
--     "loc_description_scope_01",
--     "ap_sight",
--     "loc_scope_01"
-- )

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

-- local function _register_vfx_spawner_from_attachments(parent_unit, attachments_by_unit, attachment_name_lookup, node_name, spawner_name)
-- 	local spawners = {}

-- 	for unit, attachments in pairs(attachments_by_unit) do
-- 		for i = 1, #attachments do
-- 			local attachment_unit = attachments[i]

--             if not mod:pt().exclude_from_vfx_spawner[attachment_unit] then

--                 if Unit.has_node(attachment_unit, node_name) then
--                     local attachment_name = attachment_name_lookup[unit]
--                     local node = Unit.node(attachment_unit, node_name)

--                     spawners[attachment_name] = {
--                         unit = attachment_unit,
--                         node = node,
--                     }

--                     break
--                 end
--             end
-- 		end
-- 	end

-- 	if Unit.has_node(parent_unit, node_name) then
-- 		local parent_id_name = attachment_name_lookup[parent_unit]
-- 		local node = Unit.node(parent_unit, node_name)

-- 		spawners[parent_id_name] = {
-- 			unit = parent_unit,
-- 			node = node,
-- 		}
-- 	end

-- 	if not table.is_empty(spawners) then
-- 		return spawners
-- 	end

-- 	local attachment_string = ""
-- 	local attachments = attachments_by_unit[parent_unit]

-- 	for ii = 1, #attachments do
-- 		local unit = attachments[ii]

-- 		attachment_string = string.format("%s%s, ", attachment_string, tostring(unit))
-- 	end

-- 	Log.exception("PlayerUnitFxExtension", "Could not register vfx spawner %q. Node %q could not be found in any of the given attachment (%q) units nor parent unit (%q)", spawner_name, node_name, attachment_string, tostring(parent_unit))

-- 	spawners[VisualLoadoutCustomization.ROOT_ATTACH_NAME] = {
-- 		node = 1,
-- 		unit = parent_unit,
-- 	}

-- 	return spawners
-- end

-- mod:hook(CLASS.PlayerUnitFxExtension, "_register_vfx_spawner", function(func, self, spawners, spawner_name, parent_unit, attachments_by_unit, attachment_name_lookup, node_name, should_add_3p_node, ...)
-- 	if attachments_by_unit and not table.is_empty(attachments_by_unit[parent_unit]) then
-- 		local spawner = _register_vfx_spawner_from_attachments(parent_unit, attachments_by_unit, attachment_name_lookup, node_name, spawner_name)

-- 		spawners[spawner_name] = spawner
-- 	else
-- 		spawners[spawner_name] = {}

-- 		local node = Unit.has_node(parent_unit, node_name) and Unit.node(parent_unit, node_name) or 1
-- 		local node_3p

-- 		if should_add_3p_node then
-- 			node_3p = Unit.has_node(self._unit, node_name) and Unit.node(self._unit, node_name) or 1
-- 		end

-- 		spawners[spawner_name][VisualLoadoutCustomization.ROOT_ATTACH_NAME] = {
-- 			unit = parent_unit,
-- 			node = node,
-- 			node_3p = node_3p,
-- 		}
-- 	end
-- end)

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

            for _, attachment_unit in pairs(attachment_units_by_unit[item_unit]) do

                local attachment_slot = attachment_id_lookup[attachment_unit]

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

                        if item.is_kitbash then
                            
                            local pt = mod:pt()

                            pt.exclude_from_vfx_spawner[attachment_unit] = true

                            local all_children = mod:recursive_children(attachment_unit, attachment_units_by_unit)
                            for _, child in pairs(all_children) do
                                pt.exclude_from_vfx_spawner[child] = true
                            end

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

            for _, attachment_unit in pairs(attachment_units_by_unit[item_unit]) do

                local attachment_slot = attachment_id_lookup[attachment_unit]
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
        mod:apply_unit_fixes(item_data, item_unit, attachment_units_by_unit, attachment_name_lookup, fixes)
        -- Return
        return item_unit, attachment_units_by_unit, bind_pose, attachment_id_lookup, attachment_name_lookup, attachment_units_bind_poses, item_name_by_unit
    end)
    
    mod:hook(instance, "generate_attachment_overrides_lookup", function(func, item_data, override_item_data, ...)

        -- Original function
        local override_lookup = func(item_data, override_item_data, ...)
        
        local gear_id = mod:gear_id(item_data)
        local gear_settings = mod:gear_settings(gear_id)

        if item_data.__attachment_customization then
            return empty_overrides_table
        end

        local item = item_data and (item_data.__is_ui_item_preview and item_data.__data) or item_data.__master_item or item_data
        if item.attachments then
            if override_lookup and override_item_data and gear_settings then

                -- Overwrite gear_settings
                for attachment_slot, replacement_path in pairs(gear_settings) do

                    local attachment_data = mod:fetch_attachment_data(item.attachments, attachment_slot)
                    if attachment_data and override_lookup[attachment_data] then
                        override_lookup[attachment_data] = replacement_path
                    end

                end

                -- Weapon data
                local weapon_template = item.weapon_template
                local attachments = mod.settings.attachments[weapon_template]

                local fixes = mod:collect_fixes(item)

                -- Overwrite fixes
                for fix, attachment_slot in pairs(fixes) do

                    if fix.attach then
                        local attach = fix.attach

                        for attachment_slot, attachment_name in pairs(attach) do
                            -- Get attachment path
                            local attachment_item_path = attachments[attachment_slot][attachment_name].replacement_path
                            local attachment_data = mod:fetch_attachment_data(item.attachments, attachment_slot)

                            if attachment_data and override_lookup[attachment_data] then
                                override_lookup[attachment_data] = attachment_item_path
                            end
                        end

                    end

                end

            end
        end

        -- Return
        return override_lookup
    end)

end)
