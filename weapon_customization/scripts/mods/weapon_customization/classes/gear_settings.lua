local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local SaveLua = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/classes/save_lua")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local type = type
    local math = math
    local pairs = pairs
    local class = class
    local table = table
    local string = string
    local tostring = tostring
    local math_random = math.random
    local string_gsub = string.gsub
    local string_find = string.find
    local string_split = string.split
    local table_contains = table.contains
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local REFERENCE = "weapon_customization"
    local DEBUG = true
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local GearSettings = class("GearSettings")

-- Initialize
GearSettings.init = function(self)
    self.save_lua = SaveLua:new(self)
end

GearSettings.debug = function(self, gear_id_or_item, message)
    -- Get gear id from potential item
    local gear_id = self:item_to_gear_id(gear_id_or_item)
    -- Print message to console
    if DEBUG then mod:echot(tostring(message)..tostring(gear_id)) end
end

-- ##### ┬┌┬┐┌─┐┌┬┐  ┬┌┐┌┌─┐┌─┐ #######################################################################################
-- ##### │ │ ├┤ │││  ││││├┤ │ │ #######################################################################################
-- ##### ┴ ┴ └─┘┴ ┴  ┴┘└┘└  └─┘ #######################################################################################

-- Check if item is table
GearSettings.is_table = function(self, item)
    return type(item) == "table"
end

-- Get real item from item
GearSettings._real_item = function(self, item)
    return item and self:is_table(item) and item.__maser_item or item
end

-- Get gear id from item
GearSettings.gear_id = function(self, item)
    local item = self:_real_item(item)
    return item and self:is_table(item) and (item.__gear and item.__gear.uuid or item.__original_gear_id or item.__gear_id or item.gear_id)
end

-- Get slot info from item or gear id
GearSettings.slot_info_id = function(self, gear_id_or_item)
    -- Get item from potential gear id
    local item = self:item_from_gear_id(gear_id_or_item)
    -- Return slot info
    return item and self:is_table(item) and (item.gear_id or item.__gear_id or item.__original_gear_id or item.__gear and item.__gear.uuid)
end

-- ##### ┬ ┬┌─┐┬  ┌─┐ #################################################################################################
-- ##### ├─┤├┤ │  ├─┘ #################################################################################################
-- ##### ┴ ┴└─┘┴─┘┴   #################################################################################################

-- Get short name from content string
GearSettings.short_name = function(self, content_string)
	return string_gsub(content_string, '.*[%/%\\]', '')
end

-- Check if item is player item
GearSettings.player_item = function(self, gear_id)
    return mod.player_items[gear_id]
end

-- Get item from item or gear id
GearSettings.item_from_gear_id = function(self, gear_id_or_item)
    -- Check if gear id
    if not self:is_table(gear_id_or_item) then
        -- Get player item
        local player_item = self:player_item(gear_id_or_item)
        -- Return player item
        if player_item then return player_item end
    end
    -- Return real item
    return self:_real_item(gear_id_or_item)
end

-- Get gear id from item or gear id
GearSettings.item_to_gear_id = function(self, gear_id_or_item)
    -- Check if item
    if self:is_table(gear_id_or_item) then
        -- Get item
        local item = self:_real_item(gear_id_or_item)
        -- Get gear id
        return item and self:gear_id(item)
    end
    -- Return gear id
    return gear_id_or_item
end

-- Get item name from item or gear id
GearSettings.name = function(self, gear_id_or_item)
    -- Get item from potential gear id
    local item = self:item_from_gear_id(gear_id_or_item)
    -- Return name
    return item and item.name and self:short_name(item.name)
end

-- ##### ┌─┐┌┬┐┌┬┐┌─┐┌─┐┬ ┬┌┬┐┌─┐┌┐┌┌┬┐┌─┐ ############################################################################
-- ##### ├─┤ │  │ ├─┤│  ├─┤│││├┤ │││ │ └─┐ ############################################################################
-- ##### ┴ ┴ ┴  ┴ ┴ ┴└─┘┴ ┴┴ ┴└─┘┘└┘ ┴ └─┘ ############################################################################

-- Recursively get attachments from item
GearSettings._find_attachment = function(self, attachments, attachment_slot)
    local val = nil
    if attachments then
        for attachment_name, attachment_data in pairs(attachments) do
            if attachment_name == attachment_slot then
                val = attachment_data
            else
                if attachment_data.children then
                    val = self:_find_attachment(attachment_data.children, attachment_slot)
                end
            end
            if val then break end
        end
    end
    return val
end

-- Get attachment slots from item or gear id
GearSettings.attachment_slots = function(self, gear_id_or_item)
    local attachment_slots = {}
    -- Get item from potential gear id
    local item = self:item_from_gear_id(gear_id_or_item)
    -- Get attachments from item
    local attachments = {}
    mod:_recursive_get_attachments(item.attachments, attachments)
    -- Check attachments
    if attachments then
        -- Iterate attachments
        for _, attachment in pairs(attachments) do
            -- Add attachment slot
            attachment_slots[#attachment_slots+1] = attachment.slot
        end
    end
    -- Return attachment slots
    return attachment_slots
end

-- Get attachment from item or gear id
GearSettings.attachment = function(self, gear_id_or_item, attachment_slot)
    -- Get item from potential gear id
    local item = self:item_from_gear_id(gear_id_or_item)
    -- Find attachment slot in item
    local slot = item and item.attachments and self:_find_attachment(item.attachments, attachment_slot)
    -- Return attachment name
    return slot and slot.attachment_name
end

-- Get attachment list from item or gear id
GearSettings.attachments = function(self, gear_id_or_item)
    local attachments = {}
    -- Get item from potential gear id
    local item = self:item_from_gear_id(gear_id_or_item)
    -- Get attachments from item
    local attachment_slots = item and self:attachment_slots(item)
    -- Check attachments and attachment slots
    if item.attachments and attachment_slots then
        -- Iterate attachment slots
        for _, attachment_slot in pairs(attachment_slots) do
            -- Get attachment data
            local attachment_data = self:_find_attachment(item.attachments, attachment_slot)
            -- Get attachment name
            local attachment_name = attachment_data and attachment_data.attachment_name
            -- Set attachment in list
            if attachment_name then attachments[attachment_slot] = attachment_name end
        end
    end
    -- Return attachment list
    return attachments
end

-- ##### ┌─┐┌─┐┌┬┐┌┬┐┬┌┐┌┌─┐┌─┐  ┌─┐┌─┐┌─┐┬ ┬┌─┐ ######################################################################
-- ##### └─┐├┤  │  │ │││││ ┬└─┐  │  ├─┤│  ├─┤├┤  ######################################################################
-- ##### └─┘└─┘ ┴  ┴ ┴┘└┘└─┘└─┘  └─┘┴ ┴└─┘┴ ┴└─┘ ######################################################################

-- Get cache table
GearSettings.cache = function(self)
    return mod:persistent_table(REFERENCE).loaded_gear_settings
end

-- Get gear settings from cache
GearSettings.get_cache = function(self, gear_id_or_item)
    -- Get cache table
    local cache = self:cache()
    -- Get gear id from potential item
    local gear_id = self:item_to_gear_id(gear_id_or_item)
    -- Return
    return cache[gear_id]
end

-- Update gear settings in cache
GearSettings.update_cache = function(self, gear_id_or_item, gear_settings)
    -- Remove from cache
    self:remove_cache(gear_id_or_item)
    -- Add to cache
    self:add_cache(gear_id_or_item, gear_settings)
    -- Debug
    self:debug(gear_id_or_item, "Cache updated: ")
end

-- Add gear settings to cache
GearSettings.add_cache = function(self, gear_id_or_item, gear_settings)
    -- Get cache table
    local cache = self:cache()
    -- Get gear id from potential item
    local gear_id = self:item_to_gear_id(gear_id_or_item)
    -- Check if cache exists
    if not cache[gear_id] then
        -- Add to cache
        cache[gear_id] = gear_settings
        -- Debug
        self:debug(gear_id_or_item, "Cache added: ")
    else
        self:update_cache(gear_id_or_item, gear_settings)
    end
end

-- Remove gear settings from cache
GearSettings.remove_cache = function(self, gear_id_or_item)
    -- Get cache table
    local cache = self:cache()
    -- Get gear id from potential item
    local gear_id = self:item_to_gear_id(gear_id_or_item)
    -- Check if cache exists
    if cache[gear_id] then
        -- Remove from cache
        cache[gear_id] = nil
        -- Debug
        self:debug(gear_id_or_item, "Cache removed: ")
    end
end

-- ##### ┬  ┌─┐┌─┐┌┬┐  ┌─┐┬┬  ┌─┐ #####################################################################################
-- ##### │  │ │├─┤ ││  ├┤ ││  ├┤  #####################################################################################
-- ##### ┴─┘└─┘┴ ┴─┴┘  └  ┴┴─┘└─┘ #####################################################################################

-- Load gear settings from file
GearSettings.load_file = function(self, gear_id_or_item)
    -- Load entry
    local gear_settings = self.save_lua:load_entry(gear_id_or_item)
    -- Check entry
    if gear_settings then
        -- Cache entry
        self:add_cache(gear_id_or_item, gear_settings)
        -- Debug
        self:debug(gear_id_or_item, "File loaded: ")
        -- Return entry
        return gear_settings
    end
end

-- ##### ┌─┐┌─┐┌┬┐┌┬┐┬┌┐┌┌─┐┌─┐ #######################################################################################
-- ##### └─┐├┤  │  │ │││││ ┬└─┐ #######################################################################################
-- ##### └─┘└─┘ ┴  ┴ ┴┘└┘└─┘└─┘ #######################################################################################

-- Get single attachment from settings
GearSettings.get = function(self, gear_id_or_item, attachment_slot)
    -- Get entry
    local gear_settings = self:get_cache(gear_id_or_item) or self:load_file(gear_id_or_item)
    if gear_settings then
        -- Cache entry
        self:add_cache(gear_id_or_item, gear_settings)
        -- Return attachment
        return gear_settings and gear_settings.attachments[attachment_slot]
    end
    -- -- Gear id
    -- local gear_id = self:item_to_gear_id(gear_id_or_item)
    -- -- Item
    -- local item = self:item_from_gear_id(gear_id_or_item)
    -- -- Return old settings
    -- return mod:get_gear_setting(gear_id_or_item, attachment_slot)
end

-- Set single attachment in settings
GearSettings.set = function(self, gear_id_or_item, attachment_slot, attachment_name)
    -- Get entry
    local gear_settings = self:get_cache(gear_id_or_item) or self:load_file(gear_id_or_item)
    if gear_settings then
        -- Set attachment in entry
        gear_settings.attachments[attachment_slot] = attachment_name
        -- Update cache
        self:update_cache(gear_id_or_item, gear_settings)
        -- Break
        return
    end
    -- -- Gear id
    -- local gear_id = self:item_to_gear_id(gear_id_or_item)
    -- -- Return old settings
    -- return mod:set_gear_setting(gear_id, attachment_slot, attachment_name)
end

GearSettings.push_attachments = function(self, gear_id_or_item, attachments)
    -- Get entry
    local gear_settings = self:get_cache(gear_id_or_item) or self:load_file(gear_id_or_item) or {}
    -- Set attachments in entry
    gear_settings.attachments = attachments
    -- Update cache
    self:update_cache(gear_id_or_item, gear_settings)
end

-- Load gear settings
GearSettings.load = function(self, gear_id_or_item)
    -- Return gear settings
    local gear_settings = self:get_cache(gear_id_or_item)
    return gear_settings or self:load_file(gear_id_or_item)
end

-- Save gear settings
GearSettings.save = function(self, gear_id_or_item, unit)
    -- Get item from potential gear id
    local item = self:item_from_gear_id(gear_id_or_item)
    -- Save entry
    local gear_settings = self.save_lua:save_entry({
        item = item,
        unit = unit,
    })
    -- Update cache
    self:update_cache(gear_id_or_item, gear_settings)
end

-- Delete gear settings
GearSettings.delete = function(self, gear_id_or_item)
    -- Get item from potential gear id
    local item = self:item_from_gear_id(gear_id_or_item)
    -- Save entry
    self.save_lua:delete_entry({
        item = item,
    })
    -- Update cache
    self:remove_cache(gear_id_or_item)
end

return GearSettings