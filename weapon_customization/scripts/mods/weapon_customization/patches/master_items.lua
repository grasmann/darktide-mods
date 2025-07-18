local mod = get_mod("weapon_customization")

--#region Require
	-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #####################################################################################
	-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #####################################################################################
	-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #####################################################################################

    local ItemPackage = mod:original_require("scripts/foundation/managers/package/utilities/item_package")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local type = type
    local table = table
    local pairs = pairs
    local BUILD = BUILD
    local string = string
    local rawget = rawget
    local rawset = rawset
    local ferror = ferror
    local tostring = tostring
    local managers = Managers
    local math_uuid = math.uuid
    local log_error = Log.error
    local table_find = table.find
    local table_clone = table.clone
    local log_warning = Log.warning
    local table_remove = table.remove
    local setmetatable = setmetatable
    local string_format = string.format
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local add_resources = {}
    local REFERENCE = "weapon_customization"
    local WEAPON_MELEE = "WEAPON_MELEE"
    local WEAPON_RANGED = "WEAPON_RANGED"
    local OPTION_VISIBLE_EQUIPMENT = "mod_option_visible_equipment"
    local OPTION_VISIBLE_EQUIPMENT_NO_HUB = "mod_option_visible_equipment_disable_in_hub"
--#endregion

mod.player_items = {}

-- ##### ┌┬┐┌─┐┌─┐┌┬┐┌─┐┬─┐  ┬┌┬┐┌─┐┌┬┐  ┌┬┐┌─┐┌┬┐┬┌─┐┬┌─┐┌─┐┌┬┐┬┌─┐┌┐┌  ┌─┐┬─┐┌─┐┌─┐┬ ┬ ##############################
-- ##### │││├─┤└─┐ │ ├┤ ├┬┘  │ │ ├┤ │││  ││││ │ │││├┤ ││  ├─┤ │ ││ ││││  │  ├┬┘├─┤└─┐├─┤ ##############################
-- ##### ┴ ┴┴ ┴└─┘ ┴ └─┘┴└─  ┴ ┴ └─┘┴ ┴  ┴ ┴└─┘─┴┘┴└  ┴└─┘┴ ┴ ┴ ┴└─┘┘└┘  └─┘┴└─┴ ┴└─┘┴ ┴ ##############################

mod:hook_require("scripts/backend/master_items", function(instance)

    --#region Original Code
        local function _item_plus_overrides(gear, gear_id, is_preview_item)
            local item_instance = {
                __gear = gear,
                __gear_id = is_preview_item and math_uuid() or gear_id,
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

        local function _store_item_plus_overrides(data)
            local item_instance = {
                __data = data,
                __gear = {
                    masterDataInstance = {
                        id = data.id,
                        overrides = data.overrides,
                    }
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
                end
            })
            local success = instance.update_master_data(item_instance)
            if not success then
                log_error("MasterItems", "[_store_item_plus_overrides][2] could not update master data with %s; %s", data.id, data.gear_id)
                return nil
            end
            return item_instance
        end
    --#endregion Original Code

    mod:hook(instance, "create_preview_item_instance", function(func, item, ...)
        local gear = table.clone_instance(item.__gear)
        local gear_id = item.__gear_id
        if not gear then
            log_warning("MasterItemCache", string_format("Gear list missing gear with id %s", gear_id))
            return nil
        else
            -- Process
            local item_instance = _item_plus_overrides(gear, gear_id, true)
            if item_instance then
                local master_item = item_instance.__master_item or item_instance
                if gear_id and master_item.item_list_faction == "Player" then
                    if master_item.item_type == WEAPON_MELEE or master_item.item_type == WEAPON_RANGED then
                        local gear_settings = mod.gear_settings
                        local cached_gear_list = gear_settings:player_gear_list()
                        if cached_gear_list and cached_gear_list[gear_id] ~= nil then
                            mod.player_items[gear_id] = master_item
                        elseif master_item.attachments and cached_gear_list and not cached_gear_list[gear_id] then
                            mod.player_items[gear_id] = nil
                            -- Get attributes
                            local in_possesion_of_other_player = mod:is_owned_by_other_player(item_instance)
                            -- local in_store = mod:is_store_item(item_instance) and not mod:is_premium_store_item(item_instance)
                            -- local in_premium_store = mod:is_premium_store_item(item_instance)
                            -- Get options
                            -- local store = in_store and mod:get("mod_option_randomization_store")
                            local other_player = in_possesion_of_other_player and mod:get("mod_option_randomization_players")
                            -- local randomize = store or other_player
                            -- Randomize
                            if other_player and not mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] then
                                gear_settings:create_temp_settings(gear_id, gear_settings:randomize_weapon(master_item))
                            end
                        end
                        if master_item.attachments and not mod:is_premium_store_item() then
                            -- Add custom attachments
                            mod.gear_settings:_add_custom_attachments(master_item, master_item.attachments)
                            -- Overwrite attachments
                            mod.gear_settings:_overwrite_attachments(master_item, master_item.attachments)
                        end
                        -- Add Resources
                        table.clear(add_resources)
                        add_resources = ItemPackage:add_custom_resources(master_item)
                        for resource, _ in pairs(add_resources) do
                            master_item.resource_dependencies[resource] = true
                        end
                    end
                end
            end
            -- Return instance
            return item_instance
        end
    end)

    mod:hook(instance, "get_item_instance", function(func, gear, gear_id, ...)
        -- Check instance
        if not gear then
            log_warning("MasterItemCache", string_format("Gear list missing gear with id %s", gear_id))
            return nil
        else
            -- Process
            local item_instance = _item_plus_overrides(gear, gear_id)
            if item_instance then
                local master_item = item_instance.__master_item or item_instance
                if gear_id and master_item.item_list_faction == "Player" then
                    if master_item.item_type == WEAPON_MELEE or master_item.item_type == WEAPON_RANGED then
                        local gear_settings = mod.gear_settings
                        local cached_gear_list = gear_settings:player_gear_list()
                        if cached_gear_list and cached_gear_list[gear_id] ~= nil then
                            mod.player_items[gear_id] = master_item
                        elseif master_item.attachments and cached_gear_list and not cached_gear_list[gear_id] then
                            mod.player_items[gear_id] = nil
                            -- Get attributes
                            local in_possesion_of_other_player = mod:is_owned_by_other_player(item_instance)
                            -- local in_store = mod:is_store_item(item_instance) and not mod:is_premium_store_item(item_instance)
                            -- local in_premium_store = mod:is_premium_store_item(item_instance)
                            -- Get options
                            -- local store = in_store and mod:get("mod_option_randomization_store")
                            local other_player = in_possesion_of_other_player and mod:get("mod_option_randomization_players")
                            -- local randomize = store or other_player
                            -- Randomize
                            if other_player and not mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] then
                                gear_settings:create_temp_settings(gear_id, gear_settings:randomize_weapon(master_item))
                            end
                        end
                        if master_item.attachments and not mod:is_premium_store_item() then
                            -- Add custom attachments
                            mod.gear_settings:_add_custom_attachments(master_item, master_item.attachments)
                            -- Overwrite attachments
                            mod.gear_settings:_overwrite_attachments(master_item, master_item.attachments)
                        end
                        -- Add resources
                        table.clear(add_resources)
                        add_resources = ItemPackage:add_custom_resources(master_item)
                        for resource, _ in pairs(add_resources) do
                            master_item.resource_dependencies[resource] = true
                        end
                    end
                end
            end
            -- Return instance
            return item_instance
        end
    end)

    mod:hook(instance, "get_store_item_instance", function(func, description, ...)
        local item_instance = _store_item_plus_overrides(description)
        -- local item_instance = instance.store_item_plus_overrides(description)
        if description and item_instance then
            local gear_settings = mod.gear_settings
            local gear_id = gear_settings:item_to_gear_id(item_instance)
            local master_item = item_instance.__master_item or item_instance
            if gear_id and master_item.item_list_faction == "Player" then
                if item_instance.item_type == WEAPON_MELEE or item_instance.item_type == WEAPON_RANGED then
                    local offer_id = description.offer_id
                    -- Check gear id and offer id and weapon item and not randomized already
                    if offer_id and not gear_settings:has_temp_settings(offer_id) then
                        if not mod:is_premium_store_item() then
                            -- Get attributes
                            local in_possesion_of_other_player = mod:is_owned_by_other_player(item_instance)
                            -- local in_store = mod:is_store_item(item_instance) and not mod:is_premium_store_item(item_instance)
                            local in_premium_store = mod:is_premium_store_item(item_instance)
                            -- Get options
                            local store = not in_premium_store and mod:get("mod_option_randomization_store")
                            local other_player = in_possesion_of_other_player and mod:get("mod_option_randomization_players")
                            local randomize = store or other_player
                            -- Randomize
                            if randomize and offer_id then
                                gear_settings:create_temp_settings(offer_id, gear_settings:randomize_weapon(master_item))
                            end
                        end
                    end
                    if gear_settings:has_temp_settings(offer_id) then
                        gear_settings:copy_temp_settings(gear_id, offer_id)
                    end
                    -- local add_resources = {}
                    table.clear(add_resources)
                    add_resources = ItemPackage:add_custom_resources(master_item)
                    for resource, _ in pairs(add_resources) do
                        master_item.resource_dependencies[resource] = true
                    end
                end
            end
        end
        -- Return instance
        return item_instance
    end)

    -- local lol = false
    mod:hook(instance, "get_cached", function(func, original, ...)
        local master_items = func(original, ...)
        local persistent_table = mod:persistent_table(REFERENCE)
        -- Setup definitions
        if not persistent_table.item_definitions and master_items then mod:setup_item_definitions(master_items) end
        -- if not lol then
        --     mod:dtf(master_items, "master_items", 10)
        --     lol = true
        -- end
        -- Return custom definitions
        if not original and persistent_table.item_definitions then return persistent_table.item_definitions end
        -- Return original definitions
        return master_items
    end)

end)