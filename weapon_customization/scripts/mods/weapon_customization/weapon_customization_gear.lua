local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local FixedFrame = mod:original_require("scripts/utilities/fixed_frame")


local REFERENCE = "weapon_customization"

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local string_find = string.find
    local math_floor = math.floor
    local tostring = tostring
    local pairs = pairs
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

-- Get gear id from item
mod.get_gear_id = function(self, item)
	return item and (item.__gear and item.__gear.uuid or item.__original_gear_id or item.__gear_id or item.gear_id)
end

-- Get slot info id
mod.get_slot_info_id = function(self, item)
	return item.gear_id or item.__gear_id or item.__original_gear_id or item.__gear and item.__gear.uuid
end

-- Set attachment for specified gear id and slot
mod.set_gear_setting = function(self, gear_id, attachment_slot, optional_attachment_or_nil)
	if not optional_attachment_or_nil or (optional_attachment_or_nil and (string_find(optional_attachment_or_nil, "default") or optional_attachment_or_nil == "default")) then
		self:set(tostring(gear_id).."_"..attachment_slot, nil)
	else
		self:set(tostring(gear_id).."_"..attachment_slot, optional_attachment_or_nil)
	end
end

-- Get attachment from specified gear id and slot
-- Optional: Item to get real default attachment
mod.get_gear_setting = function(self, gear_id, attachment_slot, optional_item_or_nil)
	local attachment = self:get(tostring(gear_id).."_"..attachment_slot)
	-- Check attachment
	if not attachment and optional_item_or_nil then
		-- Get real vanilla attachment
		attachment = self:get_actual_default_attachment(optional_item_or_nil, attachment_slot)
	end
	-- Check attachment
	if not attachment and optional_item_or_nil then
		local item_name = self:item_name_from_content_string(optional_item_or_nil.name)
		-- Get custom slot default
		if self.attachment[item_name] and self.attachment[item_name][attachment_slot] then
			attachment = self.attachment[item_name][attachment_slot][1].id
		end
	end
	return attachment
end

-- Get vanilla default attachment of specified item and slot
mod.get_actual_default_attachment = function(self, item, attachment_slot)
	-- Check item
	if item then
		-- Setup master items backup
		self:setup_item_definitions()
		-- Get original item
		local original_item = self:persistent_table(REFERENCE).item_definitions[item.name]
		local item_name = self:item_name_from_content_string(item.name)
		-- Check item
		if original_item and original_item.attachments then
			-- Find attachment
			local attachment = self:_recursive_find_attachment(original_item.attachments, attachment_slot)
			if attachment then
				-- Check attachment data
				if item_name and self.attachment_models[item_name] then
					-- Iterate attachments
					for attachment_name, attachment_data in pairs(self.attachment_models[item_name]) do
						-- Compare model
						if attachment_data.model == attachment.item and attachment_data.model ~= "" then
							return attachment_name
						end
					end
				end
			end
		end
	end
end

-- Redo weapon attachments by unequipping and reequipping weapon
mod.redo_weapon_attachments = function(self, item)
	local gear_id = mod:get_gear_id(item)
	local slot_name, weapon = self:get_weapon_from_gear_id(gear_id)
	if weapon then
		-- Get gameplay time
		local gameplay_time = self.time_manager:time("gameplay")
		-- Get latest frame
		local latest_frame = FixedFrame.get_latest_fixed_time()
		-- Reset flashlight cache
		self.attached_flashlights[gear_id] = {}
		self:persistent_table(REFERENCE).flashlight_on = false
		-- Reset laser pointer cache
		self:reset_laser_pointer()
		self.attached_laser_pointers[gear_id] = {}
		-- Unequip
		self.visual_loadout_extension:unequip_item_from_slot(slot_name, latest_frame)
		-- Equip
		self.visual_loadout_extension:equip_item_to_slot(item, slot_name, nil, gameplay_time)
		self:print("redo_weapon_attachments - done")
		-- Trigger flashlight update
		self._update_flashlight = true
	else self:print("redo_weapon_attachments - weapon is nil") end
end