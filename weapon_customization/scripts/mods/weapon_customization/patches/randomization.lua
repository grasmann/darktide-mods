local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local Unit = Unit
    local math = math
    local type = type
    local table = table
    local pairs = pairs
    local CLASS = CLASS
    local Camera = Camera
    local string = string
    local wc_perf = wc_perf
    local managers = Managers
    local tostring = tostring
    local table_size = table.size
    local vector3_box = Vector3Box
    local script_unit = ScriptUnit
    local table_clone = table.clone
    local string_find = string.find
    local string_gsub = string.gsub
    local math_random = math.random
    local string_split = string.split
    local table_contains = table.contains
    local vector3_unbox = vector3_box.unbox
    local unit_debug_name = Unit.debug_name
    local matrix4x4_transform = Matrix4x4.transform
    local table_clone_instance = table.clone_instance
    local quaternion_matrix4x4 = Quaternion.matrix4x4
    local unit_get_child_units = Unit.get_child_units
    local camera_local_position = Camera.local_position
    local camera_local_rotation = Camera.local_rotation
    local math_random_array_entry = math.random_array_entry
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"

mod.gear_id_to_offer_id = {}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

-- ##### ┬ ┬┌─┐┌─┐┬┌─┌─┐ ##############################################################################################
-- ##### ├─┤│ ││ │├┴┐└─┐ ##############################################################################################
-- ##### ┴ ┴└─┘└─┘┴ ┴└─┘ ##############################################################################################

mod:hook(CLASS.MarksVendorView, "_get_store", function(func, self, ...)
    local promise = func(self, ...)
    promise:next(function(store_catalogue)
        for _, item_offer in pairs(store_catalogue.offers) do
            local offer_id = item_offer.offerId
            local gear_id = item_offer.description.gear_id
            mod.gear_id_to_offer_id[gear_id] = offer_id
        end
    end)
    return promise
end)

mod:hook(CLASS.StoreService, "get_credits_store", function(func, self, ignore_event_trigger, ...)
    local promise = func(self, ignore_event_trigger, ...)
    promise:next(function(store_catalogue)
        for _, item_offer in pairs(store_catalogue.offers) do
            local offer_id = item_offer.offerId
            local gear_id = item_offer.description.gear_id
            mod.gear_id_to_offer_id[gear_id] = offer_id
        end
    end)
    return promise
end)

-- mod:hook(CLASS.CreditsVendorView, "_convert_offers_to_layout_entries", function(func, self, item_offers, ...)
--     local layout = func(self, item_offers, ...)
--     -- mod:dtf(item_offers, "item_offers", 10)
--     for _, item_offer in pairs(item_offers) do
--         local offer_id = item_offer.offerId
--         local gear_id = item_offer.description.gear_id
--         mod.gear_id_to_offer_id[gear_id] = offer_id
--         -- mod:echo(tostring(gear_id).." SET TO "..tostring(offer_id))
--     end
--     return layout
-- end)

-- mod:hook(CLASS.VendorViewBase, "update", function(func, self, dt, t, input_service, ...)
--     func(self, dt, t, input_service, ...)
--     if self._offers and #self._offers > 0 then
--         for _, offer in pairs(self._offers) do
-- 			mod:echot()
--         end
--     end
-- end)

mod:hook(CLASS.StoreService, "purchase_item", function(func, self, offer, ...)
    mod.purchase_gear_id = offer.description.gear_id
    return func(self, offer, ...)
end)

mod:hook(CLASS.GearService, "on_gear_created", function(func, self, gear_id, gear, ...)
    -- mod:dtf(gear, "purchased_gear", 20)
    local this_gear_id = mod.purchase_gear_id or mod.reward_gear_id
    -- mod:echo("create gear "..tostring(this_gear_id))
    if this_gear_id and mod:persistent_table(REFERENCE).temp_gear_settings[this_gear_id] then
        local attachments = mod:persistent_table(REFERENCE).temp_gear_settings[this_gear_id]
        mod:persistent_table(REFERENCE).temp_gear_settings[this_gear_id] = nil
        -- mod:echo("purchased_gear "..tostring(this_gear_id))
        -- mod:echo("set settings for "..tostring(gear_id))
        for attachment_slot, attachment in pairs(attachments) do
            mod:set_gear_setting(gear_id, attachment_slot, attachment)
        end
    end
    mod.purchase_gear_id = nil
    mod.reward_gear_id = nil
    func(self, gear_id, gear, ...)
end)

mod:hook(CLASS.EndPlayerView, "_get_item", function(func, self, card_reward, ...)
    local item, item_group, rarity, item_level = func(self, card_reward, ...)
    if mod:get("mod_option_randomization_store") then
        mod.reward_gear_id = mod:get_gear_id(item) or "reward"
        -- mod:echo("randomize reward "..tostring(mod.reward_gear_id))
        if not mod:persistent_table(REFERENCE).temp_gear_settings[mod.reward_gear_id] then
            local master_item = item.__master_item or item
            local random_attachments = mod:randomize_weapon(master_item)
            mod:persistent_table(REFERENCE).temp_gear_settings[mod.reward_gear_id] = random_attachments
            -- -- Auto equip
            -- for attachment_slot, value in pairs(random_attachments) do
            --     if not mod.add_custom_attachments[attachment_slot] then
            --         mod:resolve_auto_equips(item, value)
            --     end
            -- end
            -- for attachment_slot, value in pairs(random_attachments) do
            --     if mod.add_custom_attachments[attachment_slot] then
            --         mod:resolve_auto_equips(item, value)
            --     end
            -- end
            -- -- Special resolve
            -- for attachment_slot, value in pairs(random_attachments) do
            --     if mod.add_custom_attachments[attachment_slot] then
            --         mod:resolve_special_changes(item, value)
            --     end
            -- end
            -- for attachment_slot, value in pairs(random_attachments) do
            --     if not mod.add_custom_attachments[attachment_slot] then
            --         mod:resolve_special_changes(item, value)
            --     end
            -- end
        end
    end
    return item, item_group, rarity, item_level
end)