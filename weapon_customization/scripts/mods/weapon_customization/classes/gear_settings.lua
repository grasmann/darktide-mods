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
    local Unit = Unit
    local type = type
    local math = math
    local pairs = pairs
    local class = class
    local table = table
    local string = string
    local tostring = tostring
    local managers = Managers
    local unit_alive = Unit.alive
    local math_random = math.random
    local string_gsub = string.gsub
    local string_find = string.find
    local string_split = string.split
    local unit_get_data = Unit.get_data
    local table_contains = table.contains
    local unit_data_table_size = Unit.data_table_size
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local REFERENCE = "weapon_customization"
    local DEBUG = false
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local GearSettings = class("GearSettings")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

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

GearSettings.is_unit = function(self, unit)
    return type(unit) == "userdata" and unit_alive(unit)
end

-- Get real item from item
GearSettings._real_item = function(self, item)
    return item and self:is_table(item) and item.__maser_item or item
end

-- Get gear id from item
GearSettings.gear_id = function(self, item)
    -- Get real item
    local item = self:_real_item(item)
    -- Return gear id
    return item and self:is_table(item) and (item.__gear and item.__gear.uuid or item.__original_gear_id or item.__gear_id or item.gear_id)
end

-- Get slot info from item or gear id
GearSettings.slot_info_id = function(self, gear_id_or_item)
    -- Get item from potential gear id
    local item = self:item_from_gear_id(gear_id_or_item)
    -- Return slot info
    return item and self:is_table(item) and (item.gear_id or item.__gear_id or item.__original_gear_id or item.__gear and item.__gear.uuid)
end

GearSettings.original_item = function(self, gear_id_or_item)
    -- Setup master items backup
	mod:setup_item_definitions()
    -- Get item from potential gear id
    local item = self:item_from_gear_id(gear_id_or_item)
    -- Return original item
	return item and item.name and mod:persistent_table(REFERENCE).item_definitions[item.name]
end

-- ##### ┬ ┬┌─┐┬  ┌─┐ #################################################################################################
-- ##### ├─┤├┤ │  ├─┘ #################################################################################################
-- ##### ┴ ┴└─┘┴─┘┴   #################################################################################################

-- Get short name from content string
GearSettings.short_name = function(self, content_string)
	return string_gsub(content_string, '.*[%/%\\]', '')
end

-- Get cached player gear list from data service
GearSettings.player_gear_list = function(self)
    -- Get data service
    local data_service = managers and managers.data_service
    -- Get gear service
    local gear_data = data_service and data_service.gear
    -- Return gear list
    return gear_data and gear_data._cached_gear_list
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
        if player_item then return self:_real_item(player_item) end
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

-- Recursively get attachment from item instance
GearSettings._recursive_find_attachment = function(self, attachments, attachment_slot)
    local val = nil
    -- Check attachments
    if attachments then
        -- Iterate attachments
        for attachment_name, attachment_data in pairs(attachments) do
            -- Check slot
            if attachment_name == attachment_slot then
                -- Set value
                val = attachment_data
            else
                -- Check children
                if attachment_data.children then
                    -- Get value from children
                    val = self:_recursive_find_attachment(attachment_data.children, attachment_slot)
                end
            end
            -- Check value
            if val then break end
        end
    end
    -- Return value
    return val
end

-- Recursively get all attachments from item instance
GearSettings._recursive_get_attachments = function(self, attachments, all, output)
    output = output or {}
    if attachments then
        -- Iterate attachments
        for attachment_slot, attachment_data in pairs(attachments) do
            -- Check item
            if type(attachment_data.item) == "string" and (attachment_data.item ~= "" or all) then
                -- Add to list
                output[attachment_slot] = attachment_data.attachment_name
            end
            -- Check children
            if attachment_data.children then
                -- Get children
                self:_recursive_get_attachments(attachment_data.children, all, output)
            end
        end
    end
    -- Return output
    return output
end

-- Get possible attachment slots from item
GearSettings.possible_attachment_slots = function(self, gear_id_or_item)
    local possible_attachment_slots = {}
    -- Get item from potential gear id
    local item = self:item_from_gear_id(gear_id_or_item)
    -- Check item and attachments
    if item then
        -- Get item attachments
        local list = mod.attachment[self:short_name(item.name)]
        -- Check list
        if list then
            -- Iterate list
            for attachment_slot, _ in pairs(list) do
                -- Check if not in list
                if not table_contains(possible_attachment_slots, attachment_slot) then
                    -- Add to list
                    possible_attachment_slots[#possible_attachment_slots+1] = attachment_slot
                end
            end
        end
    end
    -- Return possible attachments
    return possible_attachment_slots
end

-- Get possible attachments from item optionally for attachment_slot
GearSettings.possible_attachments = function(self, gear_id_or_item, attachment_slot_or_nil)
    local possible_attachments = {}
    -- Get item from potential gear id
    local item = self:item_from_gear_id(gear_id_or_item)
    -- Get attachments
    local attachments = self:attachments(gear_id_or_item)
    -- Check item and attachments
    if item and attachments then
        -- Get item name
        local item_name = self:short_name(item.name)
        -- Get item attachments
        local list = mod.attachment[item_name]
        -- Optional get slot attachments
        list = attachment_slot_or_nil and list and list[attachment_slot_or_nil]
        -- Check list
        if list then
            -- Iterate list
            for _, attachment_data in pairs(list) do
                -- Check if not in list
                if not table_contains(possible_attachments, attachment_data.id) then
                    -- Add to list
                    possible_attachments[#possible_attachments+1] = attachment_data.id
                end
            end
        end
    end
    -- Return possible attachments
    return possible_attachments
end

-- Get attachment from item or gear id
GearSettings.attachment = function(self, gear_id_or_item_or_weapon_unit, attachment_slot)
    if self:is_unit(gear_id_or_item_or_weapon_unit) then
        -- Get attachment from live unit

        return unit_get_data(gear_id_or_item_or_weapon_unit, attachment_slot)
    else
        -- Get attachment from item or gear id

        -- Get item from potential gear id
        local item = self:item_from_gear_id(gear_id_or_item_or_weapon_unit)
        -- Find attachment slot in item
        local slot = item and item.attachments and self:_recursive_find_attachment(item.attachments, attachment_slot)
        -- Return attachment name
        return slot and slot.attachment_name
    end
end

GearSettings.attachment_unit = function(self, weapon_unit, attachment_slot_or_name)
    return unit_get_data(weapon_unit, attachment_slot_or_name)
end

-- Get attachment list from item or gear id
GearSettings.attachments = function(self, gear_id_or_item_or_weapon_unit)
    local attachments = {}
    if self:is_unit(gear_id_or_item_or_weapon_unit) then
        -- Get attachment list from live unit

        local num_attachments = unit_data_table_size(gear_id_or_item_or_weapon_unit, "attachment_slots")
        for i = 1, num_attachments, 1 do
            local attachment_slot = unit_get_data(gear_id_or_item_or_weapon_unit, "attachment_slots", i)
            attachments[attachment_slot] = self:attachment(gear_id_or_item_or_weapon_unit, attachment_slot)
        end
    else
        -- Get attachment list from item or gear id

        -- Get item from potential gear id
        local item = self:item_from_gear_id(gear_id_or_item_or_weapon_unit)
        -- Get attachments from item
        self:_recursive_get_attachments(item.attachments, true, attachments)
    end
    -- Return attachments
    return attachments
end

-- Get vanilla default attachment of specified item and slot
GearSettings.default_attachment = function(self, gear_id_or_item, attachment_slot)
    local default = nil
    -- Get original item
    local original_item = self:original_item(gear_id_or_item)
    -- Check item
    if original_item and original_item.attachments then
        -- Get item name
        local item_name = self:short_name(original_item.name)
        -- Find attachment
        local attachment = self:_recursive_find_attachment(original_item.attachments, attachment_slot)
        -- Check attachment
        if attachment then
            -- Get item data
            local item_data = item_name and mod.default_attachment_models[item_name]
            -- Check attachment data
            if item_data then
                -- Iterate attachments
                for _, attachment_name in pairs(item_data) do
                    -- Get attachment data
                    local attachment_data = item_data and item_data[attachment_name]

                    if not string_find(attachment_name, "default") and attachment_data
                            and attachment_data.model == attachment.item and attachment_data.model ~= "" then
                        default = attachment_name
                        break
                    elseif string_find(attachment_name, "default") and attachment_data 
                            and attachment_data.model == attachment.item and attachment_data.model ~= "" then
                        default = attachment_name
                    end

                end
            end
        end
    end
    -- Return default
    return default
end

GearSettings.resolve_special_changes = function(self, gear_id_or_item)
    -- Get attachments
    local attachments = self:attachments(gear_id_or_item)
    -- Check attachments
    if attachments then
        -- Iterate through attachment settings
        for attachment_slot, attachment_name in pairs(attachments) do
            -- Custom attachments
            if mod.add_custom_attachments[attachment_slot] then
                self:_resolve_special_changes(gear_id_or_item, "default")
            end
        end
        -- Iterate through attachment settings
        for attachment_slot, attachment_name in pairs(attachments) do
            -- Non-Custom attachments
            if not mod.add_custom_attachments[attachment_slot] then
                self:_resolve_special_changes(gear_id_or_item, "default")
            end
        end
    end
end

GearSettings._resolve_special_changes = function(self, gear_id_or_item, attachment)
    -- Get item from potential gear id
    local item = self:item_from_gear_id(gear_id_or_item)
    -- Get item name
	local item_name = self:short_name(item.name)
    -- Get gear id from potential item
	local gear_id = self:item_to_gear_id(item)
    -- Get attachment data
	local attachment_data = mod.attachment_models[item_name] and mod.attachment_models[item_name][attachment]
    -- Check special resolve
	if attachment_data and attachment_data.special_resolve then
        -- Execute special resolve function
		local special_changes = attachment_data.special_resolve(gear_id, item, attachment)
        -- Check special changes
		if special_changes then
            -- Iterate special changes
			for special_slot, special_attachment in pairs(special_changes) do

				-- if self.cosmetics_view then
				-- 	if not self.cosmetics_view.original_weapon_settings[special_slot] and not table_contains(self.automatic_slots, special_slot) then
				-- 		if not self.gear_settings:get(item, special_slot) then
				-- 			self.cosmetics_view.original_weapon_settings[special_slot] = "default"
				-- 		else
				-- 			self.cosmetics_view.original_weapon_settings[special_slot] = self.gear_settings:get(item, special_slot)
				-- 		end
				-- 	end
				-- end

                -- Resolve multiple attachments
				if string_find(special_attachment, "|") then
					local possibilities = string_split(special_attachment, "|")
					local rnd = math.random(#possibilities)
					special_attachment = possibilities[rnd]
				end
                -- Set special attachment
				self:_set(gear_id_or_item, special_slot, special_attachment)
			end
		end
	end
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
        -- Update cache
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
        -- Resolve special changes
        self:resolve_special_changes(gear_id_or_item)
        -- Cache entry
        self:add_cache(gear_id_or_item, gear_settings)
        -- Debug
        self:debug(gear_id_or_item, "File loaded: ")
        -- Return entry
        return gear_settings
    end
end

GearSettings.create_temp_settings = function(self, gear_id_or_item)
    -- Get gear id from potential item
    local gear_id = self:item_to_gear_id(gear_id_or_item)
    -- Get attachments
    local attachments = self:pull(gear_id_or_item)
    -- Create temp settings
    mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] = attachments or {}
end

GearSettings.destroy_temp_settings = function(self, gear_id_or_item)
    -- Get gear id from potential item
    local gear_id = self:item_to_gear_id(gear_id_or_item)
    -- Remove temp settings
    mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] = nil
end

-- ##### ┌─┐┌─┐┌┬┐┌┬┐┬┌┐┌┌─┐┌─┐ #######################################################################################
-- ##### └─┐├┤  │  │ │││││ ┬└─┐ #######################################################################################
-- ##### └─┘└─┘ ┴  ┴ ┴┘└┘└─┘└─┘ #######################################################################################

-- Correct attachment
GearSettings.correct = function(self, gear_id_or_item, attachment_slot, attachment_name)
    -- Check if attachment name is nil contains default
    if not attachment_name or (attachment_name and string_find(attachment_name, "default")) or attachment_name == "default" then
        -- Return nil
        return nil
    end
    -- Return attachment
    return attachment_name
end

-- Get single attachment from settings
GearSettings.get = function(self, gear_id_or_item, attachment_slot)
    
    local attachment_name = nil

    -- Get gear id from potential item
    local gear_id = self:item_to_gear_id(gear_id_or_item)
    -- Check if temp settings exist
    if mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] then
        -- Set temp attachment
		attachment_name = mod:persistent_table(REFERENCE).temp_gear_settings[gear_id][attachment_slot]
    end

    -- Check saved entry
    local gear_settings = self:load(gear_id_or_item)
    if gear_settings then
        -- Cache entry
        self:add_cache(gear_id_or_item, gear_settings)
        -- Set attachment
        attachment_name = gear_settings.attachments[attachment_slot]
    end

    -- Check mod default
    if not attachment_name then
        -- Get item from potential gear id
        local item = self:item_from_gear_id(gear_id_or_item)
        -- Check mod default
        if item and item.name then
            local item_name = self:short_name(item.name)
            -- Set custom slot default
            if mod.attachment[item_name] and mod.attachment[item_name][attachment_slot] and #mod.attachment[item_name][attachment_slot] > 0 then
                attachment_name = mod.attachment[item_name][attachment_slot][1].id
            end
        end
	end

    attachment_name = self:correct(gear_id_or_item, attachment_slot, attachment_name)

    -- Check vanilla default
    if not attachment_name then
        -- Set real vanilla attachment
        attachment_name = self:default_attachment(gear_id_or_item, attachment_slot)
    end

    -- Return attachment
    return attachment_name
end

-- Set single attachment in settings
GearSettings.set = function(self, gear_id_or_item, attachment_slot, attachment_name)
    -- Set attachment
    self:_set(gear_id_or_item, attachment_slot, attachment_name)
    -- Resolve special changes
    self:resolve_special_changes(gear_id_or_item)
end

GearSettings._set = function(self, gear_id_or_item, attachment_slot, attachment_name)
    -- Get gear id from potential item
    local gear_id = self:item_to_gear_id(gear_id_or_item)
    -- Correct setting
    attachment_name = self:correct(gear_id_or_item, attachment_slot, attachment_name)
    -- Check if temp settings exist
    if mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] then
        -- Set attachment in temp settings
        mod:persistent_table(REFERENCE).temp_gear_settings[gear_id][attachment_slot] = attachment_name
    else
        -- Get entry
        local gear_settings = self:load(gear_id_or_item)
        if gear_settings then
            -- Set attachment in entry
            gear_settings.attachments[attachment_slot] = attachment_name
            -- Update cache
            self:update_cache(gear_id_or_item, gear_settings)
        end
    end
end

-- Set all attachments in settings
GearSettings.push = function(self, gear_id_or_item, attachments)
    -- Get gear id from potential item
    local gear_id = self:item_to_gear_id(gear_id_or_item)
    -- Check if temp settings exist
    if mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] then
        -- Set attachment in temp settings
        mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] = attachments
    else
        -- Get entry
        local gear_settings = self:load(gear_id_or_item) or {}
        -- Set attachments in entry
        gear_settings.attachments = attachments
        -- Update cache
        self:update_cache(gear_id_or_item, gear_settings)
    end
    -- Resolve special changes
    self:resolve_special_changes(gear_id_or_item)
end

GearSettings.pull = function(self, gear_id_or_item)
    -- Get gear id from potential item
    local gear_id = self:item_to_gear_id(gear_id_or_item)
    -- Check if temp settings exist
    if mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] then
        -- Set attachment in temp settings
        return mod:persistent_table(REFERENCE).temp_gear_settings[gear_id]
    else
        -- Get entry
        local gear_settings = self:load(gear_id_or_item) or {}
        -- Set attachments in entry
        return gear_settings.attachments
    end
end

-- Load gear settings
GearSettings.load = function(self, gear_id_or_item)
    return self:get_cache(gear_id_or_item) or self:load_file(gear_id_or_item)
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