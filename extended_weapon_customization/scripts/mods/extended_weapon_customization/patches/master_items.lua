local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local log = Log
    local math = math
    local type = type
    local CLASS = CLASS
    local table = table
    local pairs = pairs
    local string = string
    local rawget = rawget
    local rawset = rawset
    local tostring = tostring
    local managers = Managers
    local math_uuid = math.uuid
    local log_error = log.error
    local table_clone = table.clone
    local log_warning = log.warning
    local setmetatable = setmetatable
    local string_format = string.format
    local table_clone_instance = table.clone_instance
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

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
        setmetatable(item_instance, {
            __index = function (t, field_name)
                local master_ver = rawget(item_instance, "__master_ver")
                if master_ver ~= instance.get_cached_version() then
                    local success = instance.update_master_data(item_instance)
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
        local success = instance.update_master_data(item_instance)
        if not success then
            log_error("MasterItems", "[_item_plus_overrides][2] could not update master data with %s", gear.masterDataInstance.id)
            return nil
        end
        return item_instance
    end

    instance.store_item_plus_overrides = function(data)
        local item_instance = {
            __data = data,
            __gear = {
                masterDataInstance = {
                    id = data.id,
                    overrides = data.overrides,
                },
            },
            __gear_id = data.gear_id or data.gearId,
        }
        setmetatable(item_instance, {
            __index = function (t, field_name)
                local master_ver = rawget(item_instance, "__master_ver")
                if master_ver ~= instance.get_cached_version() then
                    local success = instance.update_master_data(item_instance)
                    if not success then
                        log_error("MasterItems", "[_store_item_plus_overrides][1] could not update master data with %s; %s", data.id, data.gear_id)
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
                    log_warning("MasterItemCache", string_format("No master data for item with id %s", item_instance.__asset_id))

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
        local success = instance.update_master_data(item_instance)
        if not success then
            log_error("MasterItems", "[_store_item_plus_overrides][2] could not update master data with %s; %s", data.id, data.gear_id)
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
                if master_ver ~= instance.get_cached_version() then
                    local success = instance.update_master_data(item_instance)
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
        local success = instance.update_master_data(item_instance)
        if not success then
            log_error("MasterItems", "UI - [_store_item_plus_overrides][2] could not update master data with %s; %s", item.name, item.gear_id)
            return nil
        end
        return item_instance
    end

    mod:hook(instance, "get_item_instance", function(func, gear, gear_id, ...)
        local item_instance = func(gear, gear_id, ...)
        return mod:gear_settings(gear_id) and mod:mod_item(item_instance) or item_instance
    end)

    mod:hook(instance, "create_preview_item_instance", function(func, item, ...)
        -- Modify item
        mod:modify_item(item)
        -- Fixes
        mod:apply_attachment_fixes(item)

        -- Original function
        local item_instance --= func(item, ...)
        local gear = table.clone_instance(item.__gear)
        local gear_id = item.__gear_id
    
        if not gear then
            log_warning("MasterItemCache", string_format("Gear list missing gear with id %s", gear_id))
            return nil
        else
            -- local allow_modifications = true
            item_instance = instance.item_plus_overrides(gear, gear_id, true)
        end
        -- Relay gear id
        mod:gear_id_relay(item_instance.gear_id, item.gear_id)
        -- Return
        return item_instance
    end)

end)
