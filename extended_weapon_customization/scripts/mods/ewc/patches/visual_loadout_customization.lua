local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local master_items = mod:original_require("scripts/backend/master_items")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local CLASS = CLASS
    local pairs = pairs
    local table = table
    local string = string
    local tostring = tostring
    local table_size = table.size
    local unit_alive = unit.alive
    local table_clear = table.clear
    local string_find = string.find
    local unit_set_data = unit.set_data
    local table_contains = table.contains
    local table_set_readonly = table.set_readonly
    local table_merge_recursive = table.merge_recursive
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local empty_overrides_table = table_set_readonly({})
local temp_children = {}
local PROCESS_SLOTS = {"WEAPON_SKIN", "WEAPON_MELEE", "WEAPON_RANGED"}

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

--item_data.hide_in_ui_preview 

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

local script_unit = ScriptUnit
local script_unit_extension = script_unit.extension

-- mod:hook(CLASS.InventoryBackgroundView, "_update_presentation_wield_item", function(func, self, ...)
mod:hook(CLASS.UIProfileSpawner, "wield_slot", function(func, self, slot_id, ...)
	-- if not self._profile_spawner then
	-- 	return
	-- end

	local character_spawn_data = self._character_spawn_data
    if character_spawn_data then

        local wielded_slot = character_spawn_data.wielded_slot
	    local slot_id = wielded_slot and wielded_slot.name
        local slots = character_spawn_data.slots
	    local slot = slot_id and slots[slot_id]
        local equipped_items = character_spawn_data.equipped_items
        local slot_item = equipped_items and equipped_items[slot_id]
        -- mod:echo("slot_item: "..tostring(slot_item))
        -- if not attach_settings.from_ui_profile_spawner then
        local item_path = slot_item and mod:fetch_attachment(slot_item.attachments, "flashlight")
        -- mod:echo("item_path: "..tostring(item_path))
        local attachment_data = item_path and mod.settings.attachment_data_by_item_string[item_path]
        if slot and attachment_data and attachment_data.ui_item_deinit then
            local world = self._world

            local player_unit = character_spawn_data.unit_3p
            -- mod:echo("player_unit: "..tostring(player_unit))

            -- local slot = character_spawn_data.slots[slot_id]

            -- if slot then
            --     local unit = slot.unit_3p

            -- local visual_loadout_extension = player_unit and script_unit_extension(player_unit, "visual_loadout_system")
            -- mod:echo("visual_loadout_extension: "..tostring(visual_loadout_extension))
            -- local _, item_unit, _, attachment_units = visual_loadout_extension and visual_loadout_extension:unit_and_attachments_from_slot(slot_id)
            local item_unit = slot.unit_3p
            local attachment_units = item_unit and slot.attachments_by_unit_3p[item_unit]
            -- mod:echo("attachment_units: "..tostring(attachment_units))

            if attachment_units then
                local attachment_unit = mod:find_in_units(attachment_units, "flashlight")
                if attachment_unit and unit_alive(attachment_unit) then
                    -- mod:echo("ui_item_deinit: "..tostring(attachment_unit))
                    attachment_data.ui_item_deinit(world, attachment_unit, attachment_data)
                end
            end
        end

    end

	-- self._profile_spawner:wield_slot(slot_id)

	-- local item_inventory_animation_event = slot_item and slot_item.inventory_animation_event or "inventory_idle_default"

	-- if item_inventory_animation_event then
	-- 	self._profile_spawner:assign_animation_event(item_inventory_animation_event)
	-- end

    -- Original function
    func(self, slot_id, ...)

    -- local slot_id = self._preview_wield_slot_id
	-- local preview_profile_equipped_items = self._preview_profile_equipped_items
	-- local presentation_inventory = preview_profile_equipped_items
	-- local slot_item = presentation_inventory[slot_id]

    local character_spawn_data = self._character_spawn_data
    if character_spawn_data then

        local slots = character_spawn_data.slots
	    local slot = slots[slot_id]
        local equipped_items = character_spawn_data.equipped_items
        local slot_item = equipped_items[slot_id]
        -- mod:echo("slot_item: "..tostring(slot_item))
        -- if not attach_settings.from_ui_profile_spawner then
        local item_path = slot_item and mod:fetch_attachment(slot_item.attachments, "flashlight")
        -- mod:echo("item_path: "..tostring(item_path))
        local attachment_data = item_path and mod.settings.attachment_data_by_item_string[item_path]
        if attachment_data and attachment_data.ui_item_init then
            local world = self._world

            local player_unit = character_spawn_data.unit_3p
            -- mod:echo("player_unit: "..tostring(player_unit))

            -- local slot = character_spawn_data.slots[slot_id]

            -- if slot then
            --     local unit = slot.unit_3p

            -- local visual_loadout_extension = player_unit and script_unit_extension(player_unit, "visual_loadout_system")
            -- mod:echo("visual_loadout_extension: "..tostring(visual_loadout_extension))
            -- local _, item_unit, _, attachment_units = visual_loadout_extension and visual_loadout_extension:unit_and_attachments_from_slot(slot_id)
            local item_unit = slot.unit_3p
            local attachment_units = item_unit and slot.attachments_by_unit_3p[item_unit]
            -- mod:echo("attachment_units: "..tostring(attachment_units))

            if attachment_units then
                local attachment_unit = mod:find_in_units(attachment_units, "flashlight")
                if attachment_unit and unit_alive(attachment_unit) then
                    -- mod:echo("ui_item_init: "..tostring(attachment_unit))
                    attachment_data.ui_item_init(world, attachment_unit, attachment_data)
                end
            end
        end

    end

end)

mod:hook_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization", function(instance)

    mod:hook(instance, "spawn_item_attachments", function(func, item_data, override_lookup, attach_settings, item_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment, ...)
        -- Modify item
        mod:modify_item(item_data)
        -- Fixes
        local fixes = mod:collect_fixes(item_data)
        mod:apply_attachment_fixes(item_data, fixes)
        -- Original function
        local attachment_units_by_unit, attachment_id_lookup, attachment_name_lookup, bind_poses_by_unit, item_name_by_unit = func(item_data, override_lookup, attach_settings, item_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment, ...)

        -- local is_ui_item_preview = false
        local is_ui_item_preview = (item_data and (item_data.__is_ui_item_preview or item_data.__is_preview_item or item_data.__attachment_customization))
        if attachment_id_lookup and item_data.attachments then

            -- Collect current attachment names
            local kitbash_fixes = mod:fetch_attachment_fixes(item_data.structure or item_data.attachments)
            if kitbash_fixes then
                fixes = table_merge_recursive(fixes, kitbash_fixes)
            end

            for _, attachment_unit in pairs(attachment_units_by_unit[item_unit]) do

                local attachment_slot = attachment_id_lookup[attachment_unit]
                unit_set_data(attachment_unit, "attachment_slot", attachment_slot)

                local item_path = mod:fetch_attachment(item_data.attachments, attachment_slot)

                local attachment_name = mod.settings.attachment_name_by_item_string[item_path]
                unit_set_data(attachment_unit, "attachment_name", attachment_name)

                -- local attachment_data = mod.settings.attachment_data_by_item_string[item_path]
                -- if attachment_data and attachment_data.ui_item_init then
                --     local world = attach_settings.world
                --     attachment_data.ui_item_init(world, attachment_unit, attachment_data)
                -- end

                if item_data.attachments.slot_trinket_1 and item_data.attachments.slot_trinket_1.item then

                    is_ui_item_preview = true

                    local item = item_data.attachments.slot_trinket_1.item
                    local item_path = item.name

                    local attachment_data = mod.settings.attachment_data_by_item_string[item_path]
                    if attachment_data and attachment_data.ui_item_init then
                        local world = attach_settings.world
                        attachment_data.ui_item_init(world, attachment_unit, attachment_data)
                    end

                    if item and item.attachments then
                        -- Collect current attachment names
                        local kitbash_fixes = mod:fetch_attachment_fixes(item.structure or item.attachments)
                        if kitbash_fixes then
                            fixes = table_merge_recursive(fixes, kitbash_fixes)
                        end
                    end

                else

                    local item = master_items.get_item(item_path)

                    if is_ui_item_preview and not attach_settings.from_ui_profile_spawner then
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

                        if item.is_kitbash and not item.disable_vfx_spawner_exclusion then
                            
                            local pt = mod:pt()

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
            local kitbash_fixes = mod:fetch_attachment_fixes(item_data.structure or item_data.attachments)
            if kitbash_fixes then
                fixes = table_merge_recursive(fixes, kitbash_fixes)
            end

            for _, attachment_unit in pairs(attachment_units_by_unit[item_unit]) do

                local attachment_slot = attachment_id_lookup[attachment_unit]
                unit_set_data(attachment_unit, "attachment_slot", attachment_slot)
                
                local item_path = mod:fetch_attachment(item_data.attachments, attachment_slot)
                local item = master_items.get_item(item_path)

                -- local attachment_data = mod.settings.attachment_data_by_item_string[item_path]
                -- if attachment_data and attachment_data.ui_item_init then
                --     local world = attach_settings.world
                --     attachment_data.ui_item_init(world, attachment_unit, attachment_data)
                -- end

                local attachment_name = mod.settings.attachment_name_by_item_string[item_path]
                unit_set_data(attachment_unit, "attachment_name", attachment_name)

                if item and item.attachments then

                    -- Collect current attachment names
                    local kitbash_fixes = mod:fetch_attachment_fixes(item.structure or item.attachments)
                    if kitbash_fixes then
                        fixes = table_merge_recursive(fixes, kitbash_fixes)
                    end

                    if item.is_kitbash and not item.disable_vfx_spawner_exclusion then
                            
                        local pt = mod:pt()

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
