local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local MasterItems = mod:original_require("scripts/backend/master_items")
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
    local REFERENCE = "weapon_customization"
--#endregion

mod.player_items = {}

-- ##### ┌┬┐┌─┐┌─┐┌┬┐┌─┐┬─┐  ┬┌┬┐┌─┐┌┬┐  ┌┬┐┌─┐┌┬┐┬┌─┐┬┌─┐┌─┐┌┬┐┬┌─┐┌┐┌  ┌─┐┬─┐┌─┐┌─┐┬ ┬ ##############################
-- ##### │││├─┤└─┐ │ ├┤ ├┬┘  │ │ ├┤ │││  ││││ │ │││├┤ ││  ├─┤ │ ││ ││││  │  ├┬┘├─┤└─┐├─┤ ##############################
-- ##### ┴ ┴┴ ┴└─┘ ┴ └─┘┴└─  ┴ ┴ └─┘┴ ┴  ┴ ┴└─┘─┴┘┴└  ┴└─┘┴ ┴ ┴ ┴└─┘┘└┘  └─┘┴└─┴ ┴└─┘┴ ┴ ##############################

mod:hook_require("scripts/backend/master_items", function(MasterItems)

    --#region Original Code
        local FALLBACK_ITEMS_BY_SLOT = {
            slot_body_hair = "content/items/characters/player/human/attachments_default/slot_body_hair",
            slot_animation_emote_5 = "content/items/animations/emotes/emote_human_greeting_001_wave_01",
            slot_body_tattoo = "content/items/characters/player/human/attachments_default/slot_body_torso",
            slot_gear_extra_cosmetic = "content/items/characters/player/human/attachments_default/slot_attachment",
            slot_animation_emote_3 = "content/items/animations/emotes/emote_human_greeting_001_wave_01",
            slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_pale_01",
            slot_pocketable = "content/items/pocketable/empty_pocketable",
            slot_body_face_scar = "content/items/characters/player/human/attachments_default/slot_body_face",
            slot_trinket_1 = "content/items/weapons/player/trinkets/empty_trinket",
            slot_body_face_implant = "content/items/characters/player/human/attachments_default/slot_body_face",
            slot_gear_upperbody = "content/items/characters/player/human/attachments_default/slot_gear_torso",
            slot_body_face_hair = "content/items/characters/player/human/attachments_default/slot_body_face",
            slot_body_legs = "content/items/characters/player/human/attachments_default/slot_body_legs",
            slot_secondary = "content/items/weapons/player/melee/unarmed",
            slot_body_face = "content/items/characters/player/human/attachments_default/slot_body_face",
            slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_blue_01",
            slot_weapon_skin = "content/items/weapons/player/skins/lasgun/lasgun_p1_m001",
            slot_gear_lowerbody = "content/items/characters/player/human/attachments_default/slot_gear_legs",
            slot_portrait_frame = "content/items/2d/portrait_frames/portrait_frame_default",
            slot_body_face_tattoo = "content/items/characters/player/human/attachments_default/slot_body_face",
            slot_insignia = "content/items/2d/insignias/insignia_default",
            slot_body_torso = "content/items/characters/player/human/attachments_default/slot_body_torso",
            slot_primary = "content/items/weapons/player/melee/unarmed",
            slot_unarmed = "content/items/weapons/player/melee/unarmed",
            slot_device = "content/items/devices/empty_device",
            slot_animation_end_of_round = "content/items/animations/emotes/emote_human_greeting_001_wave_01",
            slot_animation_emote_4 = "content/items/animations/emotes/emote_human_greeting_001_wave_01",
            slot_animation_emote_1 = "content/items/animations/emotes/emote_human_greeting_001_wave_01",
            slot_gear_head = "content/items/characters/player/human/attachments_default/slot_gear_head",
            slot_body_arms = "content/items/characters/player/human/attachments_default/slot_body_arms",
            slot_skin_set = "content/items/characters/player/sets/empty_set",
            slot_animation_emote_2 = "content/items/animations/emotes/emote_human_greeting_001_wave_01",
            slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_brown_01"
        }
        
        if BUILD == "release" then
            FALLBACK_ITEMS_BY_SLOT.slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/empty_face_tattoo"
            FALLBACK_ITEMS_BY_SLOT.slot_body_face_scar = "content/items/characters/player/human/face_scars/empty_face_scar"
            FALLBACK_ITEMS_BY_SLOT.slot_body_face_hair = "content/items/characters/player/human/face_hair/empty_face_hair"
            FALLBACK_ITEMS_BY_SLOT.slot_body_hair = "content/items/characters/player/human/hair/empty_hair"
            FALLBACK_ITEMS_BY_SLOT.slot_body_tattoo = "content/items/characters/player/human/body_tattoo/empty_body_tattoo"
            FALLBACK_ITEMS_BY_SLOT.slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_blue_01"
            FALLBACK_ITEMS_BY_SLOT.slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_brown_01"
            FALLBACK_ITEMS_BY_SLOT.slot_gear_extra_cosmetic = "items/characters/player/human/backpacks/empty_backpack"
            FALLBACK_ITEMS_BY_SLOT.slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear"
            FALLBACK_ITEMS_BY_SLOT.slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/empty_lowerbody"
            FALLBACK_ITEMS_BY_SLOT.slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/empty_upperbody"
        end

        local function _fallback_item(gear)
            local instance_id = gear.masterDataInstance.id
        
            log_error("MasterItemCache", string_format("No master data for item with id %s", instance_id))
        
            local slot = gear.slots and gear.slots[1]
            local fallback_name = slot and FALLBACK_ITEMS_BY_SLOT[slot]
        
            log_warning("MasterItemCache", string_format("Using fallback with name %s", fallback_name))
        
            local fallback = rawget(MasterItems.get_cached(), fallback_name)
        
            return fallback
        end

        local function _merge_item_data_recursive(dest, source)
            for key, value in pairs(source) do
                local is_table = type(value) == "table"
        
                if value == source then
                    dest[key] = dest
                elseif is_table and type(dest[key]) == "table" then
                    _merge_item_data_recursive(dest[key], value)
                else
                    dest[key] = value
                end
            end
        
            return dest
        end

        local function _validate_overrides(overrides)
            local traits = overrides.traits
        
            if traits then
                for i = #traits, 1, -1 do
                    local data = traits[i]
                    local trait_id = data.id
                    local trait_exists = rawget(MasterItems.get_cached(), trait_id)
        
                    if not trait_exists then
                        table_remove(traits, i)
                    end
                end
            end
        
            local perks = overrides.perks
        
            if perks then
                for i = #perks, 1, -1 do
                    local data = perks[i]
                    local perk_id = data.id
                    local perk_exists = rawget(MasterItems.get_cached(), perk_id)
        
                    if not perk_exists then
                        table_remove(perks, i)
                    end
                end
            end
        end

        local function _update_master_data(item_instance)
            rawset(item_instance, "__master_ver", MasterItems.get_cached_version())
        
            local gear = rawget(item_instance, "__gear")
            local item = rawget(MasterItems.get_cached(), gear.masterDataInstance.id)
            item = item or _fallback_item(gear)
        
            if item then
                local clone = table_clone(item)
                local overrides = gear.masterDataInstance.overrides
        
                if overrides then
                    _validate_overrides(overrides)
                    _merge_item_data_recursive(clone, overrides)
                end
        
                local count = gear.count
        
                if count then
                    clone.count = count
                end
        
                local temp_overrides = rawget(item_instance, "__temp_overrides")
        
                if temp_overrides then
                    _merge_item_data_recursive(clone, temp_overrides)
                end
        
                rawset(item_instance, "__master_item", clone)
                rawset(item_instance, "set_temporary_overrides", function (self, new_temp_overrides)
                    rawset(item_instance, "__temp_overrides", new_temp_overrides)
                    _update_master_data(item_instance)
                end)
        
                return true
            end
        
            return false
        end

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
        
                    if master_ver ~= MasterItems.get_cached_version() then
                        local success = _update_master_data(item_instance)
        
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
        
                    return master_item[field_name]
                end,
                __newindex = function (t, field_name, value)
                    rawset(t, field_name, value)
                end,
                __tostring = function (t)
                    local master_item = rawget(item_instance, "__master_item")
                    return string_format("master_item: [%s] gear_id: [%s]", tostring(master_item and master_item.name), tostring(rawget(item_instance, "__gear_id")))
                end
            })
        
            local success = _update_master_data(item_instance)
        
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
        
                    if master_ver ~= MasterItems.get_cached_version() then
                        local success = _update_master_data(item_instance)
        
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
        
            local success = _update_master_data(item_instance)
        
            if not success then
                log_error("MasterItems", "[_store_item_plus_overrides][2] could not update master data with %s; %s", data.id, data.gear_id)
                return nil
            end
        
            return item_instance
        end
    --#endregion Original Code

    -- local function cached_gear_list()
    --     local data_service = managers and managers.data_service
    --     local gear_data = data_service and data_service.gear
    --     return gear_data and gear_data._cached_gear_list
    -- end

    mod:hook(MasterItems, "get_item_instance", function(func, gear, gear_id, ...)
        -- Check instance
        if not gear then
            log_warning("MasterItemCache", string_format("Gear list missing gear with id %s", gear_id))
            return nil
        else
            -- Process
            local item_instance = _item_plus_overrides(gear, gear_id)
            local master_item = item_instance.__master_item or item_instance
            -- local cached_gear_list = cached_gear_list()
            local cached_gear_list = mod.gear_settings:player_gear_list()
            if gear_id and cached_gear_list and cached_gear_list[gear_id] ~= nil then
                mod.player_items[gear_id] = master_item
            elseif gear_id then
                mod.player_items[gear_id] = nil
                -- Get attributes
                local in_possesion_of_other_player = mod:is_owned_by_other_player(item_instance)
                local in_store = mod:is_store_item(item_instance) and not mod:is_premium_store_item(item_instance)
                local in_premium_store = mod:is_premium_store_item(item_instance)
                -- Get options
                local store = in_store and mod:get("mod_option_randomization_store")
                local other_player = in_possesion_of_other_player and mod:get("mod_option_randomization_players")
                local randomize = store or other_player
                -- Randomize
                if randomize and gear_id then
                    if not mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] then
                        mod:randomize_item(item_instance, mod:persistent_table(REFERENCE).temp_gear_settings, gear_id)
                    end
                end
                -- Add / overwrite attachments
                if gear_id then
                    -- Setup definitions
                    mod:setup_item_definitions()
                    -- Add custom attachment slot
                    mod:_add_custom_attachments(master_item, master_item.attachments)
                    -- Overwrite attachment slots
                    mod:_overwrite_attachments(master_item, master_item.attachments)
                end
            end
            -- Add special templates
            -- mod:apply_special_templates(master_item)
            -- Return instance
            return item_instance
        end
    end)

    mod:hook(MasterItems, "get_store_item_instance", function(func, description, ...)
        local item_instance = _store_item_plus_overrides(description)
        local gear_id = mod.gear_settings:item_to_gear_id(item_instance)
        local offer_id = description.offer_id
        if gear_id and offer_id then
            local master_item = item_instance.__master_item or item_instance
            if not mod:is_premium_store_item() then
                -- Get attributes
                local in_possesion_of_other_player = mod:is_owned_by_other_player(item_instance)
                local in_store = mod:is_store_item(item_instance) and not mod:is_premium_store_item(item_instance)
                local in_premium_store = mod:is_premium_store_item(item_instance)
                -- Get options
                local store = in_store and mod:get("mod_option_randomization_store")
                local other_player = in_possesion_of_other_player and mod:get("mod_option_randomization_players")
                local randomize = store or other_player
                -- Randomize
                if randomize and offer_id then
                    if not mod:persistent_table(REFERENCE).temp_gear_settings[offer_id] then
                        mod:randomize_item(item_instance, mod:persistent_table(REFERENCE).temp_gear_settings, offer_id)
                    end
                end

                mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] = mod:persistent_table(REFERENCE).temp_gear_settings[offer_id]
                -- Add / overwrite attachments
                if gear_id then
                    -- Setup definitions
                    mod:setup_item_definitions()
                    -- Add custom attachment slot
                    mod:_add_custom_attachments(master_item, master_item.attachments)
                    -- Overwrite attachment slots
                    mod:_overwrite_attachments(master_item, master_item.attachments)
                end
            end
        end
        -- Add special templates
        -- mod:apply_special_templates(master_item)
        -- Return instance
        return item_instance
    end)

    mod:hook(MasterItems, "get_cached", function(func, original, ...)
        local master_items = func(original, ...)
        -- Setup definitions
        if not mod:persistent_table(REFERENCE).item_definitions and master_items then mod:setup_item_definitions(master_items) end
        -- Return custom definitions
        if not original and mod:persistent_table(REFERENCE).item_definitions then return mod:persistent_table(REFERENCE).item_definitions end
        -- Return original definitions
        return master_items
    end)

end)