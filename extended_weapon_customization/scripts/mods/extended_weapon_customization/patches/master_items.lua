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

mod:hook(CLASS.UIProfileSpawner, "_equip_item_for_spawned_character", function(func, self, slot_id, item, visual_item, ...)
    visual_item = item
    -- Original function
    func(self, slot_id, item, visual_item, ...)
end)

mod:hook_require("scripts/backend/master_items", function(instance)

    instance.overwrite_attachment = function(attachments, target_slot, replacement_path)
        for slot, data in pairs(attachments) do
            if slot == target_slot then
                data.item = replacement_path
            end
            if data.children then
                instance.overwrite_attachment(data.children, target_slot, replacement_path)
            end
        end
    end

    instance.update_master_data = function(item_instance, gear_id)
        rawset(item_instance, "__master_ver", instance.get_cached_version())
        
        local pt = mod:pt()
        local gear = rawget(item_instance, "__gear")
        local item = rawget(instance.get_cached(), gear.masterDataInstance.id)
        item = item or instance.fallback_item(gear)
        gear_id = gear_id or mod:gear_id(item)

        -- Cache item based on gear_id
        if not pt.cached_items[gear_id] then
            pt.cached_items[gear_id] = table_clone(item)
        end

        -- Replace attachments
        if pt.cached_items[gear_id] then
            local gear_settings = mod:gear_settings(gear_id)
            if gear_settings then
                for slot, replacement_path in pairs(gear_settings) do
                    instance.overwrite_attachment(pt.cached_items[gear_id].attachments, slot, replacement_path)
                end
            end
        end

        -- Use cached item
        item = pt.cached_items[gear_id] or item
    
        if item then
            local clone = table_clone(item)
            local overrides = gear.masterDataInstance.overrides
    
            if overrides then
                instance.validate_overrides(overrides)
                instance.merge_item_data_recursive(clone, overrides)
            end
    
            local count = gear.count
    
            if count then
                clone.count = count
            end
    
            local temp_overrides = rawget(item_instance, "__temp_overrides")
    
            if temp_overrides then
                instance.merge_item_data_recursive(clone, temp_overrides)
            end
    
            rawset(item_instance, "__master_item", clone)
            rawset(item_instance, "set_temporary_overrides", function (self, new_temp_overrides)
                rawset(item_instance, "__temp_overrides", new_temp_overrides)
                instance.update_master_data(item_instance)
            end)
    
            return true
        end
    
        return false
    end

    instance.item_plus_overrides = function(gear, gear_id, is_preview_item, ...)

        local item_instance = {
            __gear = gear,
            __gear_id = is_preview_item and math_uuid() or gear_id,
            __original_gear_id = is_preview_item and gear_id,
            __is_preview_item = is_preview_item and true or false
        }

        setmetatable(item_instance, {
            __index = function (t, field_name)
                local master_ver = rawget(item_instance, "__master_ver")

                if master_ver ~= MasterItems.get_cached_version() then
                    local success = MasterItems.update_master_data(item_instance, gear_id)
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

        local success = MasterItems.update_master_data(item_instance, gear_id)

        if not success then
            log_error("MasterItems", "[_item_plus_overrides][2] could not update master data with %s", gear.masterDataInstance.id)
            return nil
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

                if master_ver ~= MasterItems.get_cached_version() then
                    local success = instance.update_master_data(item_instance, item.gear_id)
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

        local success = instance.update_master_data(item_instance, item.gear_id)

        if not success then
            log_error("MasterItems", "UI - [_store_item_plus_overrides][2] could not update master data with %s; %s", item.name, item.gear_id)
            return nil
        end

        return item_instance
    end

end)