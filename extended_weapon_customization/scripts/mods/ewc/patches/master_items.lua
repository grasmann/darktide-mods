local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local log = Log
    local math = math
    local type = type
    local cjson = cjson
    local table = table
    local pairs = pairs
    local string = string
    local rawget = rawget
    local rawset = rawset
    local tostring = tostring
    local math_uuid = math.uuid
    local log_error = log.error
    local string_find = string.find
    local table_clear = table.clear
    local string_gsub = string.gsub
    local json_encode = json_encode
    local table_clone = table.clone
    local log_warning = log.warning
    local string_split = string.split
    local cjson_encode = cjson.encode
    local setmetatable = setmetatable
    local string_format = string.format
    local table_clone_instance = table.clone_instance
--#endregion

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local master_items = mod:original_require("scripts/backend/master_items")

local pt = mod:pt()

local debug_master_items = false

if pt.game_initialized then
    if debug_master_items then mod:dtf(master_items.get_cached(), "master_items", 20) end
end

if not pt.master_item_listener then
    pt.master_item_listener = master_items.add_listener(function()
        mod:print("master items loaded")
        if debug_master_items then mod:dtf(master_items.get_cached(), "master_items", 20) end
        mod:try_kitbash_load()
        -- mod:find_missing_items()
        -- mod:find_missing_attachments()
    end)
end

-- ##### ┌─┐┬┌┐┌┌┬┐  ┌┬┐┌─┐┌─┐┌┬┐┌─┐┬─┐  ┬┌┬┐┌─┐┌┬┐  ┌─┐┌┐┌┌┬┐┬─┐┬┌─┐┌─┐ ##############################################
-- ##### ├┤ ││││ ││  │││├─┤└─┐ │ ├┤ ├┬┘  │ │ ├┤ │││  ├┤ │││ │ ├┬┘│├┤ └─┐ ##############################################
-- ##### └  ┴┘└┘─┴┘  ┴ ┴┴ ┴└─┘ ┴ └─┘┴└─  ┴ ┴ └─┘┴ ┴  └─┘┘└┘ ┴ ┴└─┴└─┘└─┘ ##############################################

local _temp_names = {}

mod.find_missing_items = function(self)

    local items = self:find_master_item_entries({
        item_type = "WEAPON_MELEE|WEAPON_RANGED",
        item_list_faction = "Player",
        weapon_template = "!_nil|",
    })

    table_clear(_temp_names)

    for name, item in pairs(items) do

        local template_ok = item.weapon_template and item.weapon_template ~= ""

        local filter = {
            "bot",
            "npc",
        }

        local filter_ok = true

        for _, filter_name in pairs(filter) do
            if string_find(item.weapon_template, filter_name) then
                filter_ok = false
                break
            end
        end

        if template_ok and not self.settings.attachments[item.weapon_template] and filter_ok then

            _temp_names[#_temp_names+1] = item.weapon_template

        end

    end

    if #_temp_names > 0 then
        self:print("################## unsupported items ##################")
        for _, name in pairs(_temp_names) do
            self:print(name)
        end
        self:print("####################################################")
    end

end

mod.find_missing_attachments = function(self)

    local items = self:find_master_item_entries({
        attach_node = "!_nil|j_rightweaponattach|j_head|j_hips|j_spine1|j_spine2|root_point|1|j_leftleg|j_rightleg|j_backpackattach|j_backpackoffset|ap_anim_01|ap_anim_02|ap_anim_03|ap_anim_04|ap_anim_05|ap_anim_06",
        attachments = "!_nil",
        item_type = "!WEAPON_TRINKET",
        item_list_faction = "Player",
    })

    table_clear(_temp_names)

    for name, item in pairs(items) do

        local parts = string_split(name, "/")
        local item_name = parts[#parts]

        local attachment_found = false

        for weapon_template, weapon_attachments in pairs(self.settings.attachments) do
            for attachment_slot, attachments in pairs(weapon_attachments) do
                for attachment_name, attachment_data in pairs(attachments) do
                    if name == attachment_data.replacement_path then
                        attachment_found = true
                        break
                    end
                end
                if attachment_found then break end
            end
            if attachment_found then break end
        end

        local filter = {
            "bot",
            "npc",
            "shell",
            "bullet",
            "trail",
            "casing",
        }

        local filter_ok = true

        for _, filter_name in pairs(filter) do
            if string_find(item_name, filter_name) then
                filter_ok = false
                break
            end
        end

        local search = nil --"rippergun_rifle"
        local search_ok = search and false or true

        if search then
            search_ok = string_find(item_name, search)
        end

        if search_ok and filter_ok and not attachment_found then

            _temp_names[#_temp_names+1] = item_name

        end

    end

    if #_temp_names > 0 then
        self:print("################## unsupported attachments ##################")
        for _, name in pairs(_temp_names) do
            self:print(name)
        end
        self:print("##########################################################")
    end

end

local _temp_items = {}

mod.find_master_item_entries = function(self, identifications)
    local master_items = master_items.get_cached()
    if master_items then

        table_clear(_temp_items)

        for item_name, item in pairs(master_items) do

            local identifications_valid = true

            for name, value in pairs(identifications) do

                local identification_valid = true

                local negative = string_find(name, "!")
                local name_str = string_gsub(name, "!", "")
                local table_value = item[name_str]

                if type(value) == "table" and table_value and type(table_value) == "table" then

                    identification_valid = cjson_encode(table_value) == cjson_encode(value)

                elseif type(value) == "string" then

                    local negative = string_find(value, "!")
                    if not negative then
                        identification_valid = false
                    end
                    local parts_str = string_gsub(value, "!", "")
                    local parts = string_split(parts_str, "|")

                    for _, part in pairs(parts) do

                        if not negative then
                            if part ~= "_nil" and table_value == part then
                                identification_valid = true
                                break
                            elseif part == "_nil" and table_value == nil then
                                identification_valid = true
                                break
                            end
                        else
                            if part ~= "_nil" and table_value == part then
                                identification_valid = false
                                break
                            elseif part == "_nil" and table_value == nil then
                                identification_valid = false
                                break
                            end
                        end

                    end

                end

                identifications_valid = identification_valid
                if not identifications_valid then
                    break
                end

            end

            if identifications_valid then
                _temp_items[item_name] = item
            end

        end

        return _temp_items

    end
end

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
        return mod:gear_settings(gear_id) and mod:mod_item(gear_id, item_instance) or item_instance
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
