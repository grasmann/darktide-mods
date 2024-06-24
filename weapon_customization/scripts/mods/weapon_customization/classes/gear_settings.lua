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
	local World = World
	local string = string
	local vector3 = Vector3
	local tostring = tostring
	local managers = Managers
	local math_abs = math.abs
	local callback = callback
	local unit_node = Unit.node
	local unit_alive = Unit.alive
	local table_size = table.size
	local vector3_box = Vector3Box
	local table_clear = table.clear
	local table_clone = table.clone
	local math_random = math.random
	local string_gsub = string.gsub
	local string_find = string.find
	local string_split = string.split
	local table_insert = table.insert
	local unit_get_data = Unit.get_data
	local unit_has_node = Unit.has_node
	local table_contains = table.contains
	local unit_world_pose = Unit.world_pose
	local vector3_unbox = vector3_box.unbox
	local world_link_unit = World.link_unit
	local world_spawn_unit_ex = World.spawn_unit_ex
	local unit_data_table_size = Unit.data_table_size
	local unit_set_local_scale = Unit.set_local_scale
	local unit_set_local_position = Unit.set_local_position
	local math_random_array_entry = math.random_array_entry
	local unit_set_unit_visibility = Unit.set_unit_visibility
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local REFERENCE = "weapon_customization"
	local EMPTY_UNIT = "core/units/empty_root"
	local DEBUG = false
	local WEAPON_MELEE = "WEAPON_MELEE"
	local WEAPON_RANGED = "WEAPON_RANGED"
	local DEFAULT = "default"
	local attachment_setting_overwrite = {
		slot_trinket_1 = "slot_trinket_1",
		slot_trinket_2 = "slot_trinket_2",
		help_sight = "bolter_sight_01",
	}
	local hide_bullet_units = {
		"bullet_01", "bullet_02", "bullet_03", "bullet_04", "bullet_05",
		"casing_01", "casing_02", "casing_03", "casing_04", "casing_05",
		"speedloader"
	}
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
	self.generated_gear_ids = {}
end

-- Debug
GearSettings.debug = function(self, gear_id_or_item, message)
	-- Get gear id from potential item
	local gear_id = self:item_to_gear_id(gear_id_or_item)
	-- Print message to console
	if DEBUG then mod:echo(tostring(message)..tostring(gear_id)) end
end

-- ##### ┬┌┬┐┌─┐┌┬┐  ┬┌┐┌┌─┐┌─┐ #######################################################################################
-- ##### │ │ ├┤ │││  ││││├┤ │ │ #######################################################################################
-- ##### ┴ ┴ └─┘┴ ┴  ┴┘└┘└  └─┘ #######################################################################################

-- Check if item is table
GearSettings.is_table = function(self, item)
	return type(item) == "table"
end

-- Check if unit and unit is alive
GearSettings.is_unit = function(self, unit)
	return unit and type(unit) == "userdata" and unit_alive(unit)
end

GearSettings.is_weapon_item = function(self, gear_id_or_item)
	-- Get item from potential gear id
	local item = self:item_from_gear_id(gear_id_or_item)
	-- Return item type is weapon
	return item.item_type == WEAPON_MELEE or item.item_type == WEAPON_RANGED or item.item_type == nil
end

-- Get real item from item
GearSettings._real_item = function(self, gear_id_or_item)
	return gear_id_or_item and self:is_table(gear_id_or_item)
		and gear_id_or_item.__maser_item or gear_id_or_item
end

-- Get gear id from item
GearSettings.gear_id = function(self, gear_id_or_item)
	-- -- Get real item
	-- local item = self:_real_item(gear_id_or_item)
	-- Return gear id
	return gear_id_or_item and self:is_table(gear_id_or_item) and (gear_id_or_item.__gear and gear_id_or_item.__gear.uuid
		or gear_id_or_item.__original_gear_id or gear_id_or_item.__gear_id or gear_id_or_item.gear_id) or gear_id_or_item
end

-- Get slot info from item or gear id
GearSettings.slot_info_id = function(self, gear_id_or_item)
	-- Get item from potential gear id
	local item = self:item_from_gear_id(gear_id_or_item)
	-- Return slot info
	return item and self:is_table(item) and (item.gear_id or item.__gear_id
		or item.__original_gear_id or item.__gear and item.__gear.uuid) or gear_id_or_item
end

-- Get original item
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
	if mod.data_cache and mod.data_cache:item_string_to_item_name(content_string) then
		return mod.data_cache:item_string_to_item_name(content_string)
	else
		return string_gsub(content_string, '.*[%/%\\]', '')
	end
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
GearSettings.player_item = function(self, gear_id_or_item)
	-- Get player gear list
	local gear_list = self:player_gear_list()
	-- Get item from potential gear id
	local gear_id = self:item_to_gear_id(gear_id_or_item)
	-- Return player item
	return mod.player_items[gear_id] or gear_list and gear_list[gear_id]
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

-- ##### ┌─┐┌┬┐┌┬┐┌─┐┌─┐┬ ┬┌┬┐┌─┐┌┐┌┌┬┐  ┬─┐┌─┐┌─┐┬ ┬┬─┐┌─┐┬┬  ┬┌─┐ ###################################################
-- ##### ├─┤ │  │ ├─┤│  ├─┤│││├┤ │││ │   ├┬┘├┤ │  │ │├┬┘└─┐│└┐┌┘├┤  ###################################################
-- ##### ┴ ┴ ┴  ┴ ┴ ┴└─┘┴ ┴┴ ┴└─┘┘└┘ ┴   ┴└─└─┘└─┘└─┘┴└─└─┘┴ └┘ └─┘ ###################################################

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

-- Recursively get all attachments from item instance
GearSettings._recursive_get_attachment_slots = function(self, attachments, output)
	if attachments then
		-- Iterate attachments
		for attachment_slot, attachment_data in pairs(attachments) do
			output[#output+1] = attachment_slot
			-- mod:echo("rec found: "..tostring(attachment_slot))
			-- Check children
			if attachment_data.children then
				-- Get children
				self:_recursive_get_attachments(attachment_data.children, output)
			end
		end
	end
end

-- Recursively find attachment name in item instance
GearSettings._recursive_find_attachment_name = function(self, attachments, attachment_name)
	local val = nil
	if attachments then
		-- Iterate attachments
		for attachment_slot, attachment_data in pairs(attachments) do
			-- Check name
			if attachment_data.attachment_name == attachment_name then
				-- Set value
				val = attachment_data
			else
				-- Check children
				if attachment_data.children then
					-- Get value from children
					val = self:_recursive_find_attachment_name(attachment_data.children, attachment_name)
				end
			end
			if val then break end
		end
	end
	return val
end

-- Recursively find attachment parent
GearSettings._recursive_find_attachment_parent = function(self, attachments, attachment_type)
	local val = nil
	local parent = nil
	if attachments then
		-- Iterate attachments
		for attachment_name, attachment_data in pairs(attachments) do
			-- Check name
			if attachment_name == attachment_type then
				-- Set value
				val = true
			else
				-- Check children
				if attachment_data.children then
					-- Get value from children
					val, parent = self:_recursive_find_attachment_parent(attachment_data.children, attachment_type)
					-- Set parent
					if val and not parent then parent = attachment_name end
				end
			end
			if val then break end
		end
	end
	return val, parent
end

-- Recursively find attachment item
GearSettings._recursive_find_attachment_item_string = function(self, attachments, item_string)
	local val = nil
	if attachments then
		-- Iterate attachments
		for attachment_name, attachment_data in pairs(attachments) do
			-- Check model string
			if attachment_data.item == item_string then
				-- Set value
				val = attachment_data
			else
				-- Check children
				if attachment_data.children then
					-- Get value from children
					val = self:_recursive_find_attachment_item_string(attachment_data.children, item_string)
				end
			end
			if val then break end
		end
	end
	return val
end

-- Get attachment list from item or gear id
-- local attachments = {}
GearSettings.attachments = function(self, gear_id_or_item)
	-- Get item from potential gear id
	local item = self:item_from_gear_id(gear_id_or_item)
	-- Check item and name
	if item and item.name and self:is_weapon_item(gear_id_or_item) then
		-- Get item name
		local item_name = self:short_name(item.name)
		-- Check if not in cache
		if not mod.data_cache or not mod.data_cache:item_name_to_attachment_list(item_name) then
			-- Get attachments
			local attachments = {}
			-- table_clear(attachments)
			-- Get attachments from item
			self:_recursive_get_attachments(item.attachments, true, attachments)
			-- Cache
			return attachments
		end
		-- Return cached attachments
		return mod.data_cache:item_name_to_attachment_list(item_name)
	end
end

-- Get vanilla default attachment of specified item and slot
GearSettings.default_attachment = function(self, gear_id_or_item, attachment_slot)
	-- Get original item
	local original_item = self:original_item(gear_id_or_item)
	-- Check item
	-- if original_item and original_item.attachments then
	-- local item = self:item_from_gear_id(gear_id_or_item)
	if original_item and original_item.attachments and original_item.name and self:is_weapon_item(original_item) then
		-- Get item name
		local item_name = self:short_name(original_item.name)
		-- Check if not in cache
		if not mod.data_cache or not mod.data_cache:item_name_to_default_attachment(item_name, attachment_slot) then
			local default = nil

			local item_models = mod.attachment_models[item_name]
			local item_attachments = mod.attachment[item_name]
			local slot_attachments = item_attachments and item_attachments[attachment_slot]
			local custom_slot = mod.add_custom_attachments[attachment_slot] ~= nil

			-- Original default
			local item_attachment = self:_recursive_find_attachment(original_item.attachments, attachment_slot)
			-- Check attachment
			if item_attachment and item_models then
				-- Iterate attachments
				for attachment_name, attachment_data in pairs(item_models) do
					-- Get attachment data
					local function is_default(attachment_name)
						return string_find(attachment_name, DEFAULT)
					end
					-- Check attachment
					if attachment_data.original_mod and attachment_data.type == attachment_slot and attachment_data.model == item_attachment.item then
						default = attachment_name
						break
					-- elseif attachment_data.original_mod and attachment_data.type == attachment_slot and attachment_data.model == item_attachment.item then
					-- 	default = attachment_name
					end
				end
			end

			-- Custom slot default
			if not default and custom_slot and item_attachments and item_attachments[attachment_slot]
					and #item_attachments[attachment_slot] > 0 then
				default = item_attachments[attachment_slot][1].id
			end

			-- Default slot
			if not default and custom_slot and item_models and item_models[attachment_slot.."_default"] then
				default = attachment_slot.."_default"
			end

			-- Return default
			return default
		end
		-- Return cached default
		return mod.data_cache:item_name_to_default_attachment(item_name, attachment_slot)
	end
end

-- ##### ┌┬┐┌─┐┌┬┐┬┌─┐┬ ┬  ┬┌┬┐┌─┐┌┬┐  ┌─┐┌┬┐┌┬┐┌─┐┌─┐┬ ┬┌┬┐┌─┐┌┐┌┌┬┐┌─┐ ##############################################
-- ##### ││││ │ │││├┤ └┬┘  │ │ ├┤ │││  ├─┤ │  │ ├─┤│  ├─┤│││├┤ │││ │ └─┐ ##############################################
-- ##### ┴ ┴└─┘─┴┘┴└   ┴   ┴ ┴ └─┘┴ ┴  ┴ ┴ ┴  ┴ ┴ ┴└─┘┴ ┴┴ ┴└─┘┘└┘ ┴ └─┘ ##############################################

-- Recursively set attachment
GearSettings._recursive_set_attachment = function(self, attachments, attachment_name, attachment_type, model)
	-- Iterate attachments
	for attachment_slot, attachment_data in pairs(attachments) do
		-- Set attachment slot
		if attachment_slot == attachment_type then
			-- Set attachment
			attachment_data.item = model
			attachment_data.attachment_type = attachment_type
			attachment_data.attachment_name = attachment_name
		else
			-- Check children
			if attachment_data.children then
				-- Set attachment in children
				self:_recursive_set_attachment(attachment_data.children, attachment_name, attachment_type, model)
			end
		end
	end
end

-- Recursively remove attachment
GearSettings._recursive_remove_attachment = function(self, attachments, attachment_type)
	local val = nil
	if attachments then
		-- Iterate attachments
		for attachment_name, attachment_data in pairs(attachments) do
			-- Check attachment slot
			if attachment_name == attachment_type then
				-- Remove attachment
				attachments[attachment_name] = nil
				val = true
			else
				-- Check children
				if attachment_data.children then
					-- Remove attachment in children
					val = self:_recursive_remove_attachment(attachment_data.children, attachment_type)
				end
			end
			if val then break end
		end
	end
	return val
end

GearSettings.is_automatic_slot = function(self, attachment_slot)
	return mod.automatic_attachments[attachment_slot] ~= nil
end

GearSettings.is_trinket_or_skin = function(self, attachment_slot)
	return attachment_slot == "slot_trinket_1" or attachment_slot == "slot_trinket_2" or attachment_slot == "zzz_shared_material_overrides"
end

-- Recursively overwrite attachments
GearSettings._overwrite_attachments = function(self, gear_id_or_item, attachments, gear_id_or_nil)
	-- Get item from potential gear id
	local item = self:item_from_gear_id(gear_id_or_item)
	-- Check item and attachments
	-- if item and attachments then
	if item and attachments and item.name and self:is_weapon_item(gear_id_or_item) then
		-- Get item name
		local item_name = self:short_name(item.name)
		-- Get attachment slots
		local possible_attachment_slots = self:possible_attachment_slots(gear_id_or_item, true)
		-- Iterate attachment slots
		for _, attachment_slot in pairs(possible_attachment_slots) do
			-- Don't handle trinkets
			if mod.attachment_models[item_name] then
				-- Get item data
				local item_data = mod.attachment_models[item_name]
				-- Get attachment
				local attachment = self:get(gear_id_or_nil or gear_id_or_item, attachment_slot)
				-- Customize
				if attachment and item_data[attachment] then
					-- Get attachment data
					local attachment_data = item_data[attachment]
					-- Set attachment
					self:_recursive_set_attachment(attachments, attachment, attachment_slot, attachment_data.model)
				end
			end
		end
	end

end

-- Add custom attachments
-- local original_children = {}
GearSettings._add_custom_attachments = function(self, gear_id_or_item, attachments, gear_id_or_nil)
	-- Get item from potential gear id
	local item = self:item_from_gear_id(gear_id_or_item)
	-- Check item and attachments
	-- if item and attachments then
	if item and attachments and item.name and self:is_weapon_item(gear_id_or_item) then
		-- Get item name
		local item_name = self:short_name(item.name)
		-- Iterate custom attachment slots
		for attachment_slot, attachment_table in pairs(mod.add_custom_attachments) do
			-- Get weapon setting for attachment slot
			local attachment_setting = self:get(gear_id_or_nil or item, attachment_slot)
			local attachment = self:_recursive_find_attachment(attachments, attachment_slot)
			-- Overwrite specific attachment settings
			if table_contains(attachment_setting_overwrite, attachment_slot) then
				attachment_setting = attachment_setting_overwrite[attachment_slot]
			end
			-- Get attachment data
			local attachment_data = mod.attachment_models[item_name] and mod.attachment_models[item_name][attachment_setting]
			-- Check attachment data
			if attachment_data and attachment_data.parent then
				-- Set attachment parent
				local parent = attachments
				local has_original_parent, original_parent = self:_recursive_find_attachment_parent(attachments, attachment_slot)
				if has_original_parent and attachment_data.parent ~= original_parent then
					self:_recursive_remove_attachment(attachments, attachment_slot)
				end
				local parent_slot = self:_recursive_find_attachment(attachments, attachment_data.parent)
				parent = parent_slot and parent_slot.children or parent
				-- Children
				local original_children = {}
				-- table_clear(original_children)
				if attachment and attachment.children then
					original_children = table_clone(attachment.children)
				end
				-- Value
				local original_value = nil
				if attachment and attachment.item and attachment.item ~= "" then
					original_value = attachment and attachment.item
				end
				-- Attach custom slot
				parent[attachment_slot] = {
					children = original_children,
					item = original_value or attachment_data.model,
					attachment_type = attachment_slot,
					attachment_name = attachment_setting,
				}
			end
		end
	end
end

GearSettings.add_custom_resources = function(self, gear_id_or_item, out_result, gear_id_or_nil)
	-- Setup master items backup
	mod:setup_item_definitions()
	local item = self:item_from_gear_id(gear_id_or_item)
	-- Check item
	if item and item.name and self:is_weapon_item(gear_id_or_item) then
		-- Get item name
		local item_name = self:short_name(item.name)
		-- Iter attachment slots
		for _, attachment_slot in pairs(mod.attachment_slots) do
			-- Get attachment
			local attachment = self:get(gear_id_or_nil or item, attachment_slot)
			-- Get item data
			local item_data = attachment and mod.attachment_models[item_name]
			-- Get attachment data
			local attachment_data = item_data and item_data[attachment]
			-- Get model
			local model = attachment_data and attachment_data.model
			-- Get original item
			local original_item = model and mod:persistent_table(REFERENCE).item_definitions[model]
			-- Check original item and dependencies
			if original_item and original_item.resource_dependencies then
				-- Iterate dependencies
				for resource, _ in pairs(original_item.resource_dependencies) do
					-- Add resource
					out_result[resource] = true
				end
			end
		end
	end
end

-- ##### ┌─┐┌┬┐┌┬┐┌─┐┌─┐┬ ┬┌┬┐┌─┐┌┐┌┌┬┐┌─┐ ############################################################################
-- ##### ├─┤ │  │ ├─┤│  ├─┤│││├┤ │││ │ └─┐ ############################################################################
-- ##### ┴ ┴ ┴  ┴ ┴ ┴└─┘┴ ┴┴ ┴└─┘┘└┘ ┴ └─┘ ############################################################################

-- Get gear attach points
GearSettings.gear_attach_points = function(self, archetype)
	local archetype = archetype == "ogryn" and "ogryn" or "human"
	return mod.gear_attach_points[archetype]
end

-- Spawn gear attach points on a player unit
GearSettings.spawn_gear_attach_points = function(self, archetype, world, unit_or_nil)
	-- Set unit
	local unit = unit_or_nil and unit_alive(unit_or_nil) and unit_or_nil or mod.player_unit
	-- Check unit
	if unit and unit_alive(unit) and archetype then
		-- Get attach points
		local gear_attach_points = self:gear_attach_points(archetype)
		-- Check attach points
		if gear_attach_points then
			local attach_point_units = {}
			-- Iterate gear nodes
			for _, point in pairs(gear_attach_points) do
				-- Get attach node
				local node = unit_node(unit, point.node)
				-- Spawn attach point unit
				local point_unit = world_spawn_unit_ex(world, EMPTY_UNIT, nil, unit_world_pose(unit, node))
				-- Check attach point unit
				if point_unit then
					-- Link attach point unit
					world_link_unit(world, point_unit, 1, unit, node)
					-- Set attach point unit position
					unit_set_local_position(point_unit, 1, vector3_unbox(point.offset))
					-- Add attach point unit
					attach_point_units[point.name] = point_unit
				end
			end
			-- Return attach point units
			return attach_point_units
		end
	end
end

-- Get possible attachment slots from item
GearSettings.possible_attachment_slots = function(self, gear_id_or_item)
	-- Get item from potential gear id
	local item = self:item_from_gear_id(gear_id_or_item)
	-- Check item
	if item and item.name and self:is_weapon_item(gear_id_or_item) then
		-- Get item name
		local item_name = self:short_name(item.name)
		-- Check if not in cache
		if not mod.data_cache or not mod.data_cache:item_name_to_attachment_slots(item_name) then
			local possible_attachment_slots = {}
			-- Get item attachments
			local list = mod.attachment_models[item_name]
			-- Check list
			if list then
				-- Iterate list
				for attachment_name, attachment_data in pairs(list) do
					-- Check if not in list
					if type(attachment_data.type) == "string" and not table_contains(possible_attachment_slots, attachment_data.type) then
						-- Add to list
						possible_attachment_slots[#possible_attachment_slots+1] = attachment_data.type
					elseif type(attachment_data.type) ~= "string" then
						mod:print("WARNING: Unknown attachment type: "..tostring(type(attachment_data.type)).." for "..tostring(attachment_name))
					end
				end
			end
			-- Cache slots
			return possible_attachment_slots
		end
		-- Return cached slots
		return mod.data_cache:item_name_to_attachment_slots(item_name)
	end
end

-- Get possible attachments from item optionally for attachment_slot
GearSettings.possible_attachments = function(self, gear_id_or_item, attachment_slot_or_nil)
	-- Get item from potential gear id
	local item = self:item_from_gear_id(gear_id_or_item)
	-- Check item
	if item and item.name and self:is_weapon_item(gear_id_or_item) then
		-- Get item name
		local item_name = self:short_name(item.name)
		-- Check if not in cache
		if not mod.data_cache or not mod.data_cache:item_name_to_attachment_list(item_name, attachment_slot_or_nil) then
			local possible_attachments = {}
			-- table_clear(possible_attachments)
			-- Get attachments
			local attachments = self:attachments(gear_id_or_item)
			-- Check item and attachments
			if item and attachments then
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
			-- Cache attachment list
			return possible_attachments
		end
		-- Return cached attachment list
		return mod.data_cache:item_name_to_attachment_list(item_name, attachment_slot_or_nil)
	end
end

-- Get attachment unit
GearSettings.attachment_unit = function(self, attachments, attachment_slot)
	-- Check attachments
	if attachments and #attachments > 0 then
		-- Iterate attachments
		for _, unit in pairs(attachments) do
			-- Check unit and slot
			if unit and unit_alive(unit) and unit_get_data(unit, "attachment_slot") == attachment_slot then
				-- Return unit
				return unit
			end
		end
	end
end

GearSettings.attachment_slot = function(self, attachment_unit)
	return unit_get_data(attachment_unit, "attachment_slot")
end

GearSettings.attachment_name = function(self, attachment_unit)
	return unit_get_data(attachment_unit, "attachment_name")
end

-- Hide bullet units
GearSettings.hide_bullets = function(self, attachment_units)
	-- Check attachment units
	if attachment_units and #attachment_units > 0 then
		-- Iterate attachments
		for _, unit in pairs(attachment_units) do
			-- Check hide unit
			if table_contains(hide_bullet_units, unit_get_data(unit, "attachment_slot")) then
				-- Hide
				unit_set_unit_visibility(unit, false, false)
				unit_set_local_scale(unit, 1, vector3(0, 0, 0))
			end
		end
	end
end

local possible_attachments = {}
local no_support_entries = {}
local trigger_move_entries = {}
GearSettings.randomize_weapon = function(self, gear_id_or_item)
    local random_attachments = {}
    -- local possible_attachments = {}
	table.clear(possible_attachments)
    -- local no_support_entries = {}
	table.clear(no_support_entries)
    -- local trigger_move_entries = {}
	table.clear(trigger_move_entries)
	local item = self:item_from_gear_id(gear_id_or_item)
    -- local item_name = self:item_name_from_content_string(item.name)
	local item_name = self:short_name(item.name)
    -- local attachment_slots = self:get_item_attachment_slots(item)
	local attachment_slots = self:possible_attachment_slots(gear_id_or_item)
	-- local gear_id = gear_id_or_nil or mod.gear_settings:item_to_gear_id(item)
	local base_mod_only = mod:get("mod_option_randomization_only_base_mod")
	-- local base_mod_only = mod.randomization_only_base_mod
	if attachment_slots then
		for _, attachment_slot in pairs(attachment_slots) do
			if mod.attachment[item_name] and mod.attachment[item_name][attachment_slot] and not table_contains(mod.automatic_slots, attachment_slot) then
				local chance_success = true
				if mod.random_chance[attachment_slot] then
				    local chance_option = mod.random_chance[attachment_slot]
				    local chance = mod:get(chance_option)
				    -- local already_has_attachment = self:get_actual_default_attachment(item, attachment_slot)
					local already_has_attachment = self:default_attachment(item, attachment_slot)
				    if already_has_attachment then chance = 100 end
				    local random_chance = math_random(100)
				    chance_success = random_chance <= chance
				end
				if chance_success then
				    for _, data in pairs(mod.attachment[item_name][attachment_slot]) do
				        if not string_find(data.id, "default") and not data.no_randomize and mod.attachment_models[item_name][data.id] and (data.original_mod or not base_mod_only) then
				            possible_attachments[attachment_slot] = possible_attachments[attachment_slot] or {}
				            possible_attachments[attachment_slot][#possible_attachments[attachment_slot]+1] = data.id
				        end
				    end
				    if possible_attachments[attachment_slot] then
				        local random_attachment = math_random_array_entry(possible_attachments[attachment_slot])
				        -- if attachment_slot == "flashlight" then random_attachment = "laser_pointer" end
				        random_attachments[attachment_slot] = random_attachment
				        local attachment_data = mod.attachment_models[item_name][random_attachment]
				        local no_support = attachment_data and attachment_data.no_support
				        -- local trigger_move = attachment_data and attachment_data.trigger_move
				        attachment_data = self:apply_fixes(item, attachment_slot) or attachment_data
				        no_support = attachment_data.no_support or no_support
				        -- trigger_move = attachment_data.trigger_move or trigger_move
				        -- if trigger_move then
				        --     for _, trigger_move_entry in pairs(trigger_move) do
				        --         if not table_contains(trigger_move_entries, trigger_move_entry) and not possible_attachments[trigger_move_entry] then
				        --             trigger_move_entries[#trigger_move_entries+1] = trigger_move_entry
				        --         end
				        --     end
				        -- end
				        if no_support then
				            for _, no_support_entry in pairs(no_support) do
				                no_support_entries[#no_support_entries+1] = no_support_entry
				            end
				        end
				    end
				end
			end
		end
	end
    -- No support
    for _, no_support_entry in pairs(no_support_entries) do
        for attachment_slot, random_attachment in pairs(random_attachments) do
            while random_attachment == no_support_entry do
                random_attachment = math_random_array_entry(possible_attachments[attachment_slot])
                random_attachments[attachment_slot] = random_attachment
            end
            if attachment_slot == no_support_entry then
                random_attachments[no_support_entry] = "default"
            end
        end
    end
    -- Trigger move
    for _, trigger_move_entry in pairs(trigger_move_entries) do
		random_attachments[trigger_move_entry] = self:get(item, trigger_move_entry)
    end
    return random_attachments
end

-- ##### ┌─┐┌┬┐┌┬┐┌─┐┌─┐┬ ┬┌┬┐┌─┐┌┐┌┌┬┐  ┌─┐┬─┐ ┬┌─┐┌─┐ ###############################################################
-- ##### ├─┤ │  │ ├─┤│  ├─┤│││├┤ │││ │   ├┤ │┌┴┬┘├┤ └─┐ ###############################################################
-- ##### ┴ ┴ ┴  ┴ ┴ ┴└─┘┴ ┴┴ ┴└─┘┘└┘ ┴   └  ┴┴ └─└─┘└─┘ ###############################################################

-- Apply attachment fixes
local current_attachments_by_slot = {}
local current_attachments = {}
GearSettings.apply_fixes = function(self, gear_id_or_item, unit_or_name)
	-- Get item from potential gear id
	local item = self:item_from_gear_id(gear_id_or_item)
	-- Check item and attachments
	if item and item.attachments and (item.item_type == WEAPON_MELEE or item.item_type == WEAPON_RANGED) then
		-- local gear_id = self:item_to_gear_id(item)
		local slot_infos = mod:persistent_table(REFERENCE).attachment_slot_infos
		local slot_info_id = self:slot_info_id(item)
		local item_name = self:short_name(item.name)
		-- Check gear id
		if item_name and mod.attachment_models[item_name] then
			-- Check if item has fixes
			if mod.anchors[item_name] and mod.anchors[item_name].fixes then --and #mod.anchors[item_name].fixes > 0 then
				-- Get attachment slots
				table_clear(current_attachments_by_slot)
				table_clear(current_attachments)
				-- Get possible attachment slots
				local possible_attachment_slots = self:possible_attachment_slots(gear_id_or_item)
				-- Iterate attachment slots
				for _, attachment_slot in pairs(possible_attachment_slots) do
					current_attachments_by_slot[attachment_slot] = self:get(gear_id_or_item, attachment_slot)
					current_attachments[#current_attachments+1] = current_attachments_by_slot[attachment_slot]
				end
				-- Get fixes
				local fix_list = mod.anchors[item_name].fixes
				-- Iterate fixes
				for fix_index, fix_data in pairs(fix_list) do
					-- Dependencies
					local has_dependencies = false
					local no_dependencies = false
					-- Check dependencies
					if fix_data.dependencies then
						-- Iterate dependencies
						for _, dependency_entry in pairs(fix_data.dependencies) do
							-- Split dependency possibilities
							local dependency_possibilities = string_split(dependency_entry, "|")
							local has_dependency_possibility = false
							-- Iterate dependency possibilities
							for i, dependency_possibility in pairs(dependency_possibilities) do
								local negative = string_find(dependency_possibility, "!")
								dependency_possibility = negative and string_gsub(dependency_possibility, "!", "") or dependency_possibility

								if mod.attachment_models[item_name] and mod.attachment_models[item_name][dependency_possibility] then
									if negative then
										has_dependency_possibility = not table_contains(current_attachments, dependency_possibility)
									else
										has_dependency_possibility = table_contains(current_attachments, dependency_possibility)
									end
								elseif table_contains(possible_attachment_slots, dependency_possibility) then
									if negative then
										has_dependency_possibility = current_attachments_by_slot[dependency_possibility] == nil
									else
										has_dependency_possibility = current_attachments_by_slot[dependency_possibility] ~= nil
									end
								elseif mod.attachment_models[item_name] then
									if negative then
										has_dependency_possibility = dependency_possibility ~= item_name
									else
										has_dependency_possibility = dependency_possibility == item_name
									end
								end
								if has_dependency_possibility then break end
							end

							has_dependencies = has_dependency_possibility
							if not has_dependencies then break end
						end
					else
						no_dependencies = true
					end
					-- Check if has dependencies or no dependencies
					if has_dependencies or no_dependencies then

						for fix_attachment, fix in pairs(fix_data) do
							-- Attachment
							if slot_infos and slot_infos[slot_info_id] then
								if mod.attachment_models[item_name][fix_attachment] then
									-- if mod.gear_settings:has_attachment(item, fix_attachment)
									if self:_recursive_find_attachment_name(item.attachments, fix_attachment)
											and unit_or_name == slot_infos[slot_info_id].attachment_slot_to_unit[mod.attachment_models[item_name][fix_attachment].type] then
										return fix
									end
								end
								-- Slot
								if unit_or_name == slot_infos[slot_info_id].attachment_slot_to_unit[fix_attachment] then
									return fix
								end
							end
							-- Scope offset etc
							if unit_or_name == fix_attachment then
								return fix
							end
						end
					end
				end
			end
		end
	end
end

-- Release attachment packages
local unloaded_packages = {}
GearSettings.release_attachment_sounds = function(self)
	-- local unloaded_packages = {}
	table_clear(unloaded_packages)
	for sound, package_id in pairs(mod:persistent_table(REFERENCE).loaded_packages.view_weapon_sounds) do
		unloaded_packages[#unloaded_packages+1] = sound
		mod:persistent_table(REFERENCE).used_packages.view_weapon_sounds[sound] = nil
		managers.package:release(package_id)
	end
	for _, package in pairs(unloaded_packages) do
		mod:persistent_table(REFERENCE).loaded_packages.view_weapon_sounds[package] = nil
	end
end

-- Load attachment sounds
GearSettings.load_attachment_sounds = function(self, item)
	-- local attachments = self:get_item_attachment_slots(item)
	local attachments = self:possible_attachment_slots(item)
	for _, attachment_slot in pairs(attachments) do
		local attachment_name = self:get(item, attachment_slot)
		local detach_sounds = mod:get_equipment_sound_effect(item, attachment_slot, attachment_name, "detach", true)
		if detach_sounds then
			for _, detach_sound in pairs(detach_sounds) do
				if not mod:persistent_table(REFERENCE).loaded_packages.view_weapon_sounds[detach_sound] then
					mod:persistent_table(REFERENCE).used_packages.view_weapon_sounds[detach_sound] = true
					mod:persistent_table(REFERENCE).loaded_packages.view_weapon_sounds[detach_sound] = managers.package:load(detach_sound, REFERENCE)
				end
			end
		end
		local attach_sounds = mod:get_equipment_sound_effect(item, attachment_slot, attachment_name, "attach", true)
		if attach_sounds then
			for _, attach_sound in pairs(attach_sounds) do
				if not mod:persistent_table(REFERENCE).loaded_packages.view_weapon_sounds[attach_sound] then
					mod:persistent_table(REFERENCE).used_packages.view_weapon_sounds[attach_sound] = true
					mod:persistent_table(REFERENCE).loaded_packages.view_weapon_sounds[attach_sound] = managers.package:load(attach_sound, REFERENCE)
				end
			end
		end
		local select_sounds = mod:get_equipment_sound_effect(item, attachment_slot, attachment_name, "select", true)
		if select_sounds then
			for _, select_sound in pairs(select_sounds) do
				if not mod:persistent_table(REFERENCE).loaded_packages.view_weapon_sounds[select_sound] then
					mod:persistent_table(REFERENCE).used_packages.view_weapon_sounds[select_sound] = true
					mod:persistent_table(REFERENCE).loaded_packages.view_weapon_sounds[select_sound] = managers.package:load(select_sound, REFERENCE)
				end
			end
		end
	end
end

GearSettings.find_node_in_unit = function(self, unit, node_name)
	if unit_has_node(unit, node_name) then
		return true
	end
end

GearSettings.find_node_in_attachments = function(self, parent_unit, node_name, attachments)
	if attachments then
		local num_attachments = #attachments
		for i = 1, num_attachments do
			local unit = attachments[i]
			if unit_has_node(unit, node_name) then
				return true
			end
		end
	end
end

-- ##### ┬─┐┌─┐┌─┐┌─┐┬ ┬  ┬┌─┐ ########################################################################################
-- ##### ├┬┘├┤ └─┐│ ││ └┐┌┘├┤  ########################################################################################
-- ##### ┴└─└─┘└─┘└─┘┴─┘└┘ └─┘ ########################################################################################

-- Resolve issues
GearSettings.resolve_issues = function(self, gear_id_or_item, attachment_slot)
	-- Resolve special changes
	self:resolve_special_changes(gear_id_or_item, attachment_slot)
	-- Resolve auto equips
	self:resolve_auto_equips(gear_id_or_item, attachment_slot)
end

-- Resolve auto equips
GearSettings.resolve_auto_equips = function(self, gear_id_or_item, attachment_slot)
	if attachment_slot then
		self:_resolve_auto_equips(gear_id_or_item, attachment_slot)
	else
		local possible_attachment_slots = self:possible_attachment_slots(gear_id_or_item)
		if possible_attachment_slots then
			-- Iterate through attachment settings
			for _, attachment_slot in pairs(possible_attachment_slots) do
				-- Custom attachments
				if not mod.add_custom_attachments[attachment_slot] then
					self:_resolve_auto_equips(gear_id_or_item, attachment_slot)
				end
			end
			-- Iterate through attachment settings
			for _, attachment_slot in pairs(possible_attachment_slots) do
				-- Non-Custom attachments
				if mod.add_custom_attachments[attachment_slot] then
					self:_resolve_auto_equips(gear_id_or_item, attachment_slot)
				end
			end
		end
	end
end

-- Resolve auto equips
GearSettings._resolve_auto_equips = function(self, gear_id_or_item, attachment_slot)
	-- Get item
	local item = self:item_from_gear_id(gear_id_or_item)
	-- Check item
	if item and item.name and self:is_weapon_item(gear_id_or_item) then
		-- Get item name
		local item_name = self:short_name(item.name)
		-- Get attachment
		local attachment = self:get(gear_id_or_item, attachment_slot)
		if mod.attachment_models[item_name] and mod.attachment_models[item_name][attachment] then
			local attachment_data = mod.attachment_models[item_name][attachment]
			if attachment_data then
				local automatic_equip = attachment_data.automatic_equip
				local fixes = self:apply_fixes(gear_id_or_item, attachment_slot)
				automatic_equip = fixes and fixes.automatic_equip or automatic_equip
				if automatic_equip then
					for auto_type, auto_attachment in pairs(automatic_equip) do
						local parameters = string_split(auto_attachment, "|")
						if #parameters == 2 then
							local negative = string_find(parameters[1], "!")
							parameters[1] = negative and string_gsub(parameters[1], "!", "") or parameters[1]
							local attachment_name = self:get(gear_id_or_item, auto_type)
							if attachment_name then
								if negative and attachment_name ~= parameters[1] then
									-- mod:echo("set "..tostring(auto_type).." to "..tostring(parameters[2]))
									self:_set(gear_id_or_item, auto_type, parameters[2])
								elseif attachment_name == parameters[1] then
									-- mod:echo("set "..tostring(auto_type).." to "..tostring(parameters[2]))
									self:_set(gear_id_or_item, auto_type, parameters[2])
								end
							else mod:print("Attachment data for slot "..tostring(auto_type).." is nil") end
						else
							-- mod:echo("set "..tostring(auto_type).." to "..tostring(parameters[1]))
							self:_set(gear_id_or_item, auto_type, parameters[1])
						end
					end
				end
			end
		end
	end
end

-- Resolve special changes
local resolved_attachments = {}
GearSettings.resolve_special_changes = function(self, gear_id_or_item, attachment_slot)
	table_clear(resolved_attachments)
	if attachment_slot then
		self:_resolve_special_changes(gear_id_or_item, resolved_attachments[attachment_slot] or self:get(gear_id_or_item, attachment_slot))
	else
		-- Get attachment slots
		local possible_attachment_slots = self:possible_attachment_slots(gear_id_or_item, true)
		-- Check attachments
		if possible_attachment_slots then
			-- Iterate through attachment settings
			for _, attachment_slot in pairs(possible_attachment_slots) do
				-- Custom attachments
				if mod.add_custom_attachments[attachment_slot] then
					self:_resolve_special_changes(gear_id_or_item, resolved_attachments[attachment_slot] or self:get(gear_id_or_item, attachment_slot))
				end
			end
			-- Iterate through attachment settings
			for _, attachment_slot in pairs(possible_attachment_slots) do
				-- Non-Custom attachments
				if not mod.add_custom_attachments[attachment_slot] then
					self:_resolve_special_changes(gear_id_or_item, resolved_attachments[attachment_slot] or self:get(gear_id_or_item, attachment_slot))
				end
			end
		end
	end
end

-- Resolve special changes
GearSettings._resolve_special_changes = function(self, gear_id_or_item, attachment)
	-- Get item from potential gear id
	local item = self:item_from_gear_id(gear_id_or_item)
	-- Check item
	if item and item.name and self:is_weapon_item(gear_id_or_item) then
		-- Get item name
		local item_name = self:short_name(item.name)
		-- Get gear id from potential item
		local gear_id = self:item_to_gear_id(item)
		-- Get attachment data
		local attachment_data = mod.attachment_models[item_name] and mod.attachment_models[item_name][attachment]
		-- Check special resolve
		if attachment_data and attachment_data.special_resolve and not resolved_attachments[attachment_data.type] then
			-- Execute special resolve function
			local special_changes = attachment_data.special_resolve(gear_id, item, attachment)
			-- Check special changes
			if special_changes then
				-- Iterate special changes
				for special_slot, special_attachment in pairs(special_changes) do
					-- mod:echo(special_slot, resolved_attachments)
					-- Resolve multiple attachments
					local special_attachment = special_attachment
					if string_find(special_attachment, "|") then
						local possibilities = string_split(special_attachment, "|")
						local rnd = math.random(#possibilities)
						special_attachment = possibilities[rnd]
					end
					-- Set special attachment
					-- mod:echo("Resolved "..tostring(special_slot).." to "..tostring(special_attachment))
					self:_set(gear_id_or_item, special_slot, special_attachment)
					resolved_attachments[special_slot] = special_attachment
				end
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
	-- Get gear id from potential item
	local gear_id = self:item_to_gear_id(gear_id_or_item)
	-- Load entry
	local gear_settings = self.save_lua:load_entry(gear_id)
	-- Check entry
	if gear_settings then
		-- Cache entry
		self:add_cache(gear_id_or_item, gear_settings)
		-- Debug
		self:debug(gear_id_or_item, "File loaded: ")
		-- Resolve issues
		self:resolve_issues(gear_id_or_item)
		-- Return entry
		return gear_settings
	end
end

GearSettings.copy_temp_settings = function(self, gear_id_or_item, other_gear_id_or_item)
	if self:has_temp_settings(other_gear_id_or_item) then
		self:create_temp_settings(gear_id_or_item, self:pull(other_gear_id_or_item))
	end
end

GearSettings.create_temp_settings = function(self, gear_id_or_item, attachments_or_nil, skip_resolving_issues)
	-- Get gear id from potential item
	local gear_id = self:item_to_gear_id(gear_id_or_item)
	-- Get attachments
	local saved_settings = self:pull(gear_id_or_item)
	local attachments = attachments_or_nil or saved_settings and table_clone(saved_settings) or {}
	-- Create temp settings
	if gear_id then
		-- Set temp settings
		mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] = attachments
		if not skip_resolving_issues then
			-- Resolve issues
			self:resolve_issues(gear_id_or_item)
		end
	end
end

GearSettings.has_temp_settings = function(self, gear_id_or_item)
	-- Get gear id from potential item
	local gear_id = self:item_to_gear_id(gear_id_or_item)
	-- Check if temp settings exist
	return gear_id and mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] ~= nil
end

GearSettings.destroy_temp_settings = function(self, gear_id_or_item)
	-- Get gear id from potential item
	local gear_id = self:item_to_gear_id(gear_id_or_item)
	-- Remove temp settings
	if gear_id then
		mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] = nil
	end
end

GearSettings.destroy_all_temp_settings = function(self)
	table_clear(mod:persistent_table(REFERENCE).temp_gear_settings)
end

-- ##### ┌─┐┌─┐┌┬┐┌┬┐┬┌┐┌┌─┐┌─┐ #######################################################################################
-- ##### └─┐├┤  │  │ │││││ ┬└─┐ #######################################################################################
-- ##### └─┘└─┘ ┴  ┴ ┴┘└┘└─┘└─┘ #######################################################################################

-- Correct attachment
GearSettings.correct = function(self, gear_id_or_item, attachment_slot, attachment_name)
	-- Check if attachment name is nil contains default
	if not attachment_name or (attachment_name and string_find(attachment_name, DEFAULT)) or attachment_name == DEFAULT then
		-- Return nil
		return nil
	end
	-- Return attachment
	return attachment_name
end

-- Get single attachment from settings
GearSettings.get = function(self, gear_id_or_item, attachment_slot, no_default)

	local attachment_name = nil

	-- Get gear id from potential item
	local gear_id = self:item_to_gear_id(gear_id_or_item)
	-- Check if temp settings exist
	if mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] then
		-- Set temp attachment
		attachment_name = mod:persistent_table(REFERENCE).temp_gear_settings[gear_id][attachment_slot] or "default"
	end

	-- Check saved entry
	local gear_settings = self:load(gear_id_or_item)
	-- Check settings
	if not attachment_name and gear_settings then
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

	-- Correct setting
	attachment_name = self:correct(gear_id_or_item, attachment_slot, attachment_name)

	-- Check if no default
	if no_default then return attachment_name end

	-- Check vanilla default
	if not attachment_name then
		-- Set real vanilla attachment
		attachment_name = self:default_attachment(gear_id_or_item, attachment_slot)
	end

	-- Return attachment
	return attachment_name
end

-- Set single attachment in settings
GearSettings.set = function(self, gear_id_or_item, attachment_slot, attachment_name, skip_resolving_issues)
	-- Set attachment
	self:_set(gear_id_or_item, attachment_slot, attachment_name)
	if not skip_resolving_issues then
		-- Resolve issues
		self:resolve_issues(gear_id_or_item, attachment_slot)
	end
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
		-- Check settings
		if gear_settings then
			-- if attachment_slot == "gear_node" then
			-- 	mod:echo("set real gear_node to "..tostring(attachment_name))
			-- end
			-- Set attachment in entry
			gear_settings.attachments[attachment_slot] = attachment_name
			-- Update cache
			self:update_cache(gear_id_or_item, gear_settings)
		end
	end
end

-- Set all attachments in settings
GearSettings.push = function(self, gear_id_or_item, attachments, skip_resolving_issues)
	-- Get gear id from potential item
	local gear_id = self:item_to_gear_id(gear_id_or_item)
	-- Check if temp settings exist
	if mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] then
		-- Set attachment in temp settings
		mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] = attachments
	else
		-- Get entry
		local gear_settings = self:load(gear_id_or_item)
		-- Check settings
		if gear_settings then
			-- Set attachments in entry
			gear_settings.attachments = attachments
			-- Update cache
			self:update_cache(gear_id_or_item, gear_settings)
		end
	end
	if not skip_resolving_issues then
		-- Resolve issues
		self:resolve_issues(gear_id_or_item)
	end
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
		local gear_settings = self:load(gear_id_or_item)
		-- Set attachments in entry
		return gear_settings and gear_settings.attachments
	end
end

-- Load gear settings
GearSettings.load = function(self, gear_id_or_item)
	return self:get_cache(gear_id_or_item) or self:load_file(gear_id_or_item)
end

-- Save gear settings
GearSettings.save = function(self, gear_id_or_item, unit_or_nil, attachments_or_nil)
	-- Get item from potential gear id
	local item = self:item_from_gear_id(gear_id_or_item)
	-- Check item
	if item then
		-- Save entry
		local gear_settings = self.save_lua:save_entry({
			item = item,
			unit = unit_or_nil,
			attachments = attachments_or_nil,
		})
		-- Update cache
		self:update_cache(gear_id_or_item, gear_settings)
	end
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