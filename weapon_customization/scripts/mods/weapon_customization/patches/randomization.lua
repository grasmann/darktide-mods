local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local table = table
    local table_contains = table.contains
    local table_clone_instance = table.clone_instance
    local table_clone = table.clone
    local table_size = table.size
    local vector3_box = Vector3Box
    local vector3_unbox = vector3_box.unbox
    local quaternion_matrix4x4 = Quaternion.matrix4x4
    local matrix4x4_transform = Matrix4x4.transform
    local Camera = Camera
    local camera_local_position = Camera.local_position
    local camera_local_rotation = Camera.local_rotation
    local Unit = Unit
    local unit_debug_name = Unit.debug_name
    local unit_get_child_units = Unit.get_child_units
    local string = string
    local string_find = string.find
    local string_gsub = string.gsub
    local string_split = string.split
    local math = math
    local math_random = math.random
    local math_random_array_entry = math.random_array_entry
    local pairs = pairs
    local CLASS = CLASS
    local managers = Managers
    local type = type
    local tostring = tostring
    local script_unit = ScriptUnit
    local wc_perf = wc_perf
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

-- ##### ┬ ┬┌─┐┌─┐┬┌─┌─┐ ##############################################################################################
-- ##### ├─┤│ ││ │├┴┐└─┐ ##############################################################################################
-- ##### ┴ ┴└─┘└─┘┴ ┴└─┘ ##############################################################################################

mod:hook(CLASS.StoreService, "purchase_item", function(func, self, offer, ...)
    mod.purchase_gear_id = offer.description.gear_id
    return func(self, offer, ...)
end)

mod:hook(CLASS.GearService, "on_gear_created", function(func, self, gear_id, gear, ...)
    -- mod:dtf(gear, "purchased_gear", 20)
    local this_gear_id = mod.purchase_gear_id or mod.reward_gear_id
    -- mod:echo("create gear "..tostring(this_gear_id))
    if this_gear_id and mod:persistent_table(REFERENCE).temp_gear_settings[this_gear_id] then
        local attachments = table_clone(mod:persistent_table(REFERENCE).temp_gear_settings[this_gear_id])
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
            -- Auto equip
            for attachment_slot, value in pairs(random_attachments) do
                if not mod.add_custom_attachments[attachment_slot] then
                    mod:resolve_auto_equips(item, value)
                end
            end
            for attachment_slot, value in pairs(random_attachments) do
                if mod.add_custom_attachments[attachment_slot] then
                    mod:resolve_auto_equips(item, value)
                end
            end
            -- Special resolve
            for attachment_slot, value in pairs(random_attachments) do
                if mod.add_custom_attachments[attachment_slot] then
                    mod:resolve_special_changes(item, value)
                end
            end
            for attachment_slot, value in pairs(random_attachments) do
                if not mod.add_custom_attachments[attachment_slot] then
                    mod:resolve_special_changes(item, value)
                end
            end
        end
    end
    return item, item_group, rarity, item_level
end)