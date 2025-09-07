local mod = get_mod("extended_weapon_customization")

local MasterItems = mod:original_require("scripts/backend/master_items")

local type = type
local CLASS = CLASS
local table = table
local pairs = pairs
-- local BUILD = BUILD
local string = string
local rawget = rawget
local rawset = rawset
-- local ferror = ferror
local tostring = tostring
local managers = Managers
local math_uuid = math.uuid
local log_error = Log.error
-- local table_clone = table.clone
-- local table_find = table.find
local table_clone = table.clone
local log_warning = Log.warning
-- local table_remove = table.remove
local setmetatable = setmetatable
local string_format = string.format
local table_clone_instance = table.clone_instance

-- mod:hook(CLASS.UIProfileSpawner, "_equip_item_for_spawned_character", function(func, self, slot_id, item, visual_item, ...)
--     visual_item = item
--     -- Original function
--     func(self, slot_id, item, visual_item, ...)
-- end)

mod.overwrite_attachment = function(self, attachments, target_slot, replacement_path)
    for slot, data in pairs(attachments) do
        if slot == target_slot then
            data.item = replacement_path
        end
        if data.children then
            self:overwrite_attachment(data.children, target_slot, replacement_path)
        end
    end
end

mod.modify_item = function(self, item_data)
    local item = item_data and (item_data.__is_ui_item_preview and item_data.__data) or item_data
    local item_type = item_data and item_data.item_type
    -- local attachments = item_data and item_data.attachments
    if item_type == "WEAPON_MELEE" or item_type == "WEAPON_RANGED" and item.attachments then
        local pt = mod:pt()
        local gear_id = mod:gear_id(item)
        local gear_settings = gear_id and mod:gear_settings(gear_id)
        if gear_settings then
            for slot, replacement_path in pairs(gear_settings) do
                mod:overwrite_attachment(item.attachments, slot, replacement_path)
                -- local master_item = MasterItems.get_item(replacement_path)
                -- local resource_dependencies = master_item.resource_dependencies
                -- if resource_dependencies then
                --     for resource_name, _ in pairs(resource_dependencies) do
                --         item.resource_dependencies[resource_name] = true
                --     end
                -- end
            end
        end
    end
end

mod:hook_require("scripts/backend/master_items", function(instance)

    instance.overwrite_attachment = function(attachments, target_slot, replacement_path)
        mod:overwrite_attachment(attachments, target_slot, replacement_path)
    end

    instance.item_plus_overrides = function(gear, gear_id, is_preview_item, ...)
        local new_gear_id = math_uuid()
        local item_instance = {
            __gear = gear,
            __gear_id = is_preview_item and new_gear_id or gear_id,
            __original_gear_id = is_preview_item and gear_id,
            __is_preview_item = is_preview_item and true or false
        }
        -- if is_preview_item then
        --     mod:gear_id_relay(new_gear_id, gear_id)
        -- end
        setmetatable(item_instance, {
            __index = function (t, field_name)
                local master_ver = rawget(item_instance, "__master_ver")
                if master_ver ~= instance.get_cached_version() then
                    local success = instance.update_master_data(item_instance) --, gear_id)
                    if not success then
                        log_error("MasterItems", "[_item_plus_overrides][1] could not update master data with %s", gear.masterDataInstance.id)
                        return nil
                    end
                end
                if field_name == "gear_id" then
                    return rawget(item_instance, "__gear_id")
                end
                if field_name == "gear" then
                    return rawget(item_instance, "__gear")
                end
                local master_item = rawget(item_instance, "__master_item")
                if not master_item then
                    log_warning("MasterItemCache", string_format("No master data for item with id %s", gear.masterDataInstance.id))
                    return nil
                end
                local field_value = master_item[field_name]
                if field_name == "rarity" and field_value == -1 then
                    return nil
                end
                return field_value
            end,
            __newindex = function (t, field_name, value)
                rawset(t, field_name, value)
            end,
            __tostring = function (t)
                local master_item = rawget(item_instance, "__master_item")
                return string_format("master_item: [%s] gear_id: [%s]", tostring(master_item and master_item.name), tostring(rawget(item_instance, "__gear_id")))
            end
        })
        local success = instance.update_master_data(item_instance) --, gear_id)
        if not success then
            log_error("MasterItems", "[_item_plus_overrides][2] could not update master data with %s", gear.masterDataInstance.id)
            return nil
        -- else
        --     -- local master_item = rawget(item_instance, "__master_item")
        --     mod:modify_item(item_instance.__master_item)
        end
        return item_instance
    end

    instance.get_ui_item_instance = function(item)
        local gear_override = item.gear and item.gear.masterDataInstance and item.gear.masterDataInstance.overrides
        local overrides = item.overrides or gear_override
        if overrides then
            overrides = table_clone_instance(overrides)
        else
            overrides = {}
        end
        if item.slot_weapon_skin then
            overrides.slot_weapon_skin = type(item.slot_weapon_skin) == "table" and item.slot_weapon_skin.name or item.slot_weapon_skin
        end
        local item_instance = {
            __is_ui_item_preview = true,
            __data = item,
            __gear = {
                masterDataInstance = {
                    id = item.name,
                    overrides = overrides,
                },
            },
            __gear_id = item.gear_id or math_uuid(),
        }
        setmetatable(item_instance, {
            __index = function (t, field_name)
                local master_ver = rawget(item_instance, "__master_ver")
                if master_ver ~= instance.get_cached_version() then
                    local success = instance.update_master_data(item_instance) --, item.gear_id)
                    if not success then
                        log_error("MasterItems", "[_store_item_plus_overrides][1] could not update master data with %s; %s", item.name, item.gear_id)
                        return nil
                    end
                end
                if field_name == "gear_id" then
                    return rawget(item_instance, "__gear_id")
                end
                if field_name == "gear" then
                    return rawget(item_instance, "__gear")
                end
                local master_item = rawget(item_instance, "__master_item")
                if not master_item then
                    log_warning("MasterItemCache", string_format("UI - No master data for item with id %s", item.name))
                    return nil
                end
                local field_value = master_item[field_name]
                if field_name == "rarity" and field_value == -1 then
                    return nil
                end
                return field_value
            end,
            __newindex = function (t, field_name, value)
                rawset(t, field_name, value)
            end,
            __tostring = function (t)
                local master_item = rawget(item_instance, "__master_item")
                return string_format("master_item: [%s] gear_id: [%s]", tostring(master_item and master_item.name), tostring(rawget(item_instance, "__gear_id")))
            end,
        })
        local success = instance.update_master_data(item_instance) --, item.gear_id)
        if not success then
            log_error("MasterItems", "UI - [_store_item_plus_overrides][2] could not update master data with %s; %s", item.name, item.gear_id)
            return nil
        -- else
        --     -- local data = rawget(item_instance, "__data")
        --     mod:modify_item(item_instance.__data)
        end
        return item_instance
    end

    mod:hook(instance, "create_preview_item_instance", function(func, item, ...)

        -- -- local gear_id = item.__gear_id

        mod:modify_item(item)

        -- Original function
        local item_instance = func(item, ...)

        -- mod:modify_item(item_instance)

        -- -- if item_instance then
        -- --     -- local master_item = item_instance.__master_item or item_instance
        -- --     -- item_instance.__original_gear_id = gear_id
        -- --     -- master_item.__original_gear_id = gear_id
        -- --     mod:modify_item(item_instance)
        -- -- end

        -- managers.event:trigger("grasmann_register_gear_id_relay", item_instance.gear_id, item.gear_id)
        mod:gear_id_relay(item_instance.gear_id, item.gear_id)

        return item_instance

        -- local gear = table.clone_instance(item.__gear)
        -- local gear_id = item.__gear_id

        -- if not gear then
        --     Log.warning("MasterItemCache", string.format("Gear list missing gear with id %s", gear_id))
        --     return nil
        -- else
        --     -- local allow_modifications = true
        --     return instance.item_plus_overrides(gear, gear_id, true)
        -- end

    end)

end)

mod:hook(CLASS.WeaponIconUI, "load_weapon_icon", function(func, self, item, on_load_callback, optional_render_context, prioritized, on_unload_callback, ...)

    -- local item_type = item and item.item_type

    -- if item_type == "WEAPON_MELEE" or item_type == "WEAPON_RANGED" then
    --     local pt = mod:pt()
    --     local gear_id = item and mod:gear_id(item)
    --     local gear_settings = mod:gear_settings(gear_id)
    --     if gear_settings then
    --         for slot, replacement_path in pairs(gear_settings) do
    --             mod:overwrite_attachment(item.attachments, slot, replacement_path)
    --         end
    --     end
    -- end
    mod:modify_item(item)

    -- Original function
    return func(self, item, on_load_callback, optional_render_context, prioritized, on_unload_callback, ...)

end)

mod:hook(CLASS.UICharacterProfilePackageLoader, "load_slot_item", function(func, self, slot_id, item, complete_callback, ...)

    -- local item_type = item and item.item_type

    -- if item_type == "WEAPON_MELEE" or item_type == "WEAPON_RANGED" then
    --     local pt = mod:pt()
    --     local gear_id = item and mod:gear_id(item)
    --     local gear_settings = mod:gear_settings(gear_id)
    --     if gear_settings then
    --         for slot, replacement_path in pairs(gear_settings) do
    --             mod:overwrite_attachment(item.attachments, slot, replacement_path)
    --         end
    --     end
    -- end
    mod:modify_item(item)

    -- Original function
    return func(self, slot_id, item, complete_callback, ...)

end)

mod:hook(CLASS.ItemIconLoaderUI, "load_icon", function(func, self, item, on_load_callback, on_unload_callback, ...)

    -- local item_type = item and item.item_type

    -- if item_type == "WEAPON_MELEE" or item_type == "WEAPON_RANGED" then
    --     local pt = mod:pt()
    --     local gear_id = item and mod:gear_id(item)
    --     local gear_settings = mod:gear_settings(gear_id)
    --     if gear_settings then
    --         for slot, replacement_path in pairs(gear_settings) do
    --             mod:overwrite_attachment(item.attachments, slot, replacement_path)
    --         end
    --     end
    -- end
    mod:modify_item(item)

    -- Original function
    return func(self, item, on_load_callback, on_unload_callback, ...)

end)

mod:hook(CLASS.EquipmentComponent, "_spawn_player_item_units", function(func, self, slot, unit_3p, unit_1p, attach_settings, optional_mission_template, optional_equipment, ...)

    local item = slot and slot.item
    -- local item_type = item and item.item_type

    -- if item_type == "WEAPON_MELEE" or item_type == "WEAPON_RANGED" then
    --     local pt = mod:pt()
    --     local gear_id = item and mod:gear_id(item)
    --     local gear_settings = mod:gear_settings(gear_id)
    --     if gear_settings then
    --         for slot, replacement_path in pairs(gear_settings) do
    --             mod:overwrite_attachment(item.attachments, slot, replacement_path)
    --         end
    --     end
    -- end
    mod:modify_item(item)

    -- Original function
    return func(self, slot, unit_3p, unit_1p, attach_settings, optional_mission_template, optional_equipment, ...)

end)

mod:hook_require("scripts/foundation/managers/package/utilities/item_package", function(instance)
    
    mod:hook(instance, "compile_item_instance_dependencies", function(func, item, items_dictionary, out_result, optional_mission_template, ...)
    
        -- local item_type = item and item.item_type

        -- if item_type == "WEAPON_MELEE" or item_type == "WEAPON_RANGED" then
        --     local pt = mod:pt()
        --     local gear_id = item and mod:gear_id(item)
        --     local gear_settings = mod:gear_settings(gear_id)
        --     if gear_settings then
        --         for slot, replacement_path in pairs(gear_settings) do
        --             mod:overwrite_attachment(item.attachments, slot, replacement_path)
        --         end
        --     end
        -- end
        mod:modify_item(item)

        -- Original function
        return func(item, items_dictionary, out_result, optional_mission_template, ...)

    end)

    mod:hook(instance, "compile_resource_dependencies", function(func, item_entry_data, resource_dependencies, ...)
    
        mod:modify_item(item_entry_data)

        -- Original function
        return func(item_entry_data, resource_dependencies, ...)

    end)

end)

mod:hook_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization", function(instance)

    mod:hook(instance, "spawn_item_attachments", function(func, item_data, override_lookup, attach_settings, item_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment, ...)

        -- local item_type = item_data and item_data.item_type

        -- if item_type == "WEAPON_MELEE" or item_type == "WEAPON_RANGED" then
        --     local pt = mod:pt()
        --     local gear_id = mod:gear_id(item_data)
        --     local gear_settings = mod:gear_settings(gear_id)
        --     if gear_settings then
        --         for slot, replacement_path in pairs(gear_settings) do
        --             mod:overwrite_attachment(item_data.attachments, slot, replacement_path)
        --         end
        --     end
        -- end
        mod:modify_item(item_data)

        -- Original function
        return func(item_data, override_lookup, attach_settings, item_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment, ...)

    end)

    mod:hook(instance, "spawn_item", function(func, item_data, attach_settings, parent_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment, ...)

        -- local item_type = item_data and item_data.item_type

        -- if item_type == "WEAPON_MELEE" or item_type == "WEAPON_RANGED" then
        --     local pt = mod:pt()
        --     local gear_id = mod:gear_id(item_data)
        --     local gear_settings = mod:gear_settings(gear_id)
        --     if gear_settings then
        --         for slot, replacement_path in pairs(gear_settings) do
        --             -- instance.overwrite_attachment(pt.cached_items[gear_id].attachments, slot, replacement_path)
        --             mod:overwrite_attachment(item_data.attachments, slot, replacement_path)
        --         end
        --     end
        -- end
        -- mod:modify_item(item_data)

        -- Original function
        local item_unit, attachment_units_by_unit, bind_pose, attachment_id_lookup, attachment_name_lookup, attachment_units_bind_poses, item_name_by_unit = func(item_data, attach_settings, parent_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment, ...)

        mod:modify_item(item_data)

        return item_unit, attachment_units_by_unit, bind_pose, attachment_id_lookup, attachment_name_lookup, attachment_units_bind_poses, item_name_by_unit

    end)

end)
