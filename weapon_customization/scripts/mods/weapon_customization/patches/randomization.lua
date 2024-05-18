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
    local Unit = Unit
    local math = math
    local type = type
    local table = table
    local pairs = pairs
    local CLASS = CLASS
    local Camera = Camera
    local string = string
    local wc_perf = wc_perf
    local Localize = Localize
    local managers = Managers
    local tostring = tostring
    local table_size = table.size
    local table_enum = table.enum
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

--#region Data
    local REFERENCE = "weapon_customization"
    local REWARD_ITEM = "reward_item"
    local CARD_TYPES = table_enum("xp", "levelUp", "salary", "weaponDrop", "weapon_unlock", "talents_unlock")
--#endregion

mod.gear_id_to_offer_id = {}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.randomize_item = function(self, item_instance, table, id)
    local master_item = item_instance.__master_item or item_instance
    local random_attachments = self:randomize_weapon(master_item)
    if table and id then table[id] = random_attachments end
    -- Auto equip
    for attachment_slot, value in pairs(random_attachments) do
        if not self.add_custom_attachments[attachment_slot] then
            self:resolve_auto_equips(item_instance, value)
        end
    end
    for attachment_slot, value in pairs(random_attachments) do
        if self.add_custom_attachments[attachment_slot] then
            self:resolve_auto_equips(item_instance, value)
        end
    end
    -- Special resolve
    for attachment_slot, value in pairs(random_attachments) do
        if self.add_custom_attachments[attachment_slot] then
            self:resolve_special_changes(item_instance, value)
        end
    end
    for attachment_slot, value in pairs(random_attachments) do
        if not self.add_custom_attachments[attachment_slot] then
            self:resolve_special_changes(item_instance, value)
        end
    end
    return random_attachments
end

-- ##### ┬ ┬┌─┐┌─┐┬┌─┌─┐ ##############################################################################################
-- ##### ├─┤│ ││ │├┴┐└─┐ ##############################################################################################
-- ##### ┴ ┴└─┘└─┘┴ ┴└─┘ ##############################################################################################

mod:hook(CLASS.MarksVendorView, "_get_store", function(func, self, ...)
    local promise = func(self, ...)
    promise:next(function(store_catalogue)
        for _, item_offer in pairs(store_catalogue.offers) do
            local offer_id = item_offer.offerId
            item_offer.description.offer_id = item_offer.offerId
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
            item_offer.description.offer_id = item_offer.offerId
            local gear_id = item_offer.description.gear_id
            mod.gear_id_to_offer_id[gear_id] = offer_id
        end
    end)
    return promise
end)

mod:hook(CLASS.StoreService, "purchase_item", function(func, self, offer, ...)
    mod.offer_id = offer.offerId
    return func(self, offer, ...)
end)

mod:hook(CLASS.GearService, "on_gear_created", function(func, self, gear_id, gear, ...)
    local create_id = mod.offer_id or gear_id
    local attachments = nil
    if create_id and mod:persistent_table(REFERENCE).temp_gear_settings[create_id] then
        attachments = table_clone(mod:persistent_table(REFERENCE).temp_gear_settings[create_id])
        mod:persistent_table(REFERENCE).temp_gear_settings[create_id] = nil
    end
    if attachments then
        mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] = nil
        -- for attachment_slot, attachment in pairs(attachments) do
        --     -- mod:set_gear_setting(gear_id, attachment_slot, attachment)
        --     mod.gear_settings:set(gear_id, attachment_slot, attachment)
        -- end
        mod.gear_settings:push_attachments(gear_id, attachments)
    end
    mod.offer_id = nil
    func(self, gear_id, gear, ...)
end)

mod:hook(CLASS.EndPlayerView, "_get_item", function(func, self, card_reward, ...)
    local item, item_group, rarity, item_level = func(self, card_reward, ...)
    if item and card_reward.gear_id and mod:get("mod_option_randomization_reward") then
        -- local attachments = {}
        item.gear_id = card_reward.gear_id
        local attachments = mod:randomize_item(item, nil, card_reward.gear_id)
        mod:persistent_table(REFERENCE).temp_gear_settings[card_reward.gear_id] = nil
        -- for attachment_slot, attachment in pairs(attachments[card_reward.gear_id]) do
        --     -- mod:set_gear_setting(card_reward.gear_id, attachment_slot, attachment)
        --     if mod.gear_settings then
        --         mod.gear_settings:set(card_reward.gear_id, attachment_slot, attachment)
        --     end
        -- end
        mod.gear_settings:push_attachments(card_reward.gear_id, attachments)
        -- mod:persistent_table(REFERENCE).temp_gear_settings[card_reward.gear_id] = attachments
    end
    return item, item_group, rarity, item_level
end)
