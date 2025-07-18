local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
	local SoundEventAliases = mod:original_require("scripts/settings/sound/player_character_sound_event_aliases")
	
	local SaveLua = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/classes/save_lua")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
	local Unit = Unit
	local type = type
	local math = math
	local pairs = pairs
	local class = class
	local table = table
	local World = World
	local ipairs = ipairs
	local Script = Script
	local string = string
	local vector3 = Vector3
	local tostring = tostring
	local managers = Managers
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
	local unit_set_data = Unit.set_data
	local unit_get_data = Unit.get_data
	local unit_has_node = Unit.has_node
	local script_new_map = Script.new_map
	local table_contains = table.contains
	local unit_world_pose = Unit.world_pose
	local vector3_unbox = vector3_box.unbox
	local world_link_unit = World.link_unit
	local script_new_array = Script.new_array
	local world_spawn_unit_ex = World.spawn_unit_ex
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
	-- local EMPTY_UNIT = "content/weapons/player/attachments/trinket_hooks/trinket_hook_03_v"
	local DEBUG = false
	local WEAPON_MELEE = "WEAPON_MELEE"
	local WEAPON_RANGED = "WEAPON_RANGED"
	local DEFAULT = "default"
	local current_attachments_by_slot = {}
	local current_attachments = {}
	local possible_attachments = {}
	local auto_equip_entries = {}
	local special_resolve_entries = {}
	local no_support_entries = {}
	local trigger_move_entries = {}
	local attachment_setting_overwrite = {
		slot_trinket_1 = "slot_trinket_1",
		slot_trinket_2 = "slot_trinket_2",
		help_sight = "bolter_sight_01",
	}
	local hide_bullet_units = {
		"bullet_01", "bullet_02", "bullet_03", "bullet_04", "bullet_05",
		"casing_01", "casing_02", "casing_03", "casing_04", "casing_05",
		"speedloader", "shotpistol_bullet_01", "shotpistol_bullet_02",
		"shotpistol_bullet_03", "shotpistol_bullet_04", "shotpistol_bullet_05",
		"assault_shotgun_special_shell_01", "assault_shotgun_special_shell_02",
		"assault_shotgun_special_shell_03", "assault_shotgun_special_shell_04",
		"assault_shotgun_special_shell_05", "assault_shotgun_special_shell_06",
	}
	local rnd_attach = {
        "hips_front",
        "hips_back",
        "hips_left",
        "hips_right",
        "chest",
        "back_right",
        "back_left",
    }
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local GearSettings = class("GearSettings")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

--#region Setup
	-- Initialize
	GearSettings.init = function(self)
		self.save_lua = SaveLua:new(self)
		self.dependency_possibility_info = {}
		-- self.generated_gear_ids = {}
	end

	-- Debug
	GearSettings.debug = function(self, gear_id_or_item, message)
		-- Get gear id from potential item
		local gear_id = self:item_to_gear_id(gear_id_or_item)
		-- Print message to console
		if DEBUG then mod:echo(tostring(message)..tostring(gear_id)) end
	end
--#endregion

-- ##### ┬┌┬┐┌─┐┌┬┐  ┬┌┐┌┌─┐┌─┐ #######################################################################################
-- ##### │ │ ├┤ │││  ││││├┤ │ │ #######################################################################################
-- ##### ┴ ┴ └─┘┴ ┴  ┴┘└┘└  └─┘ #######################################################################################

--#region Info
	-- Check if item is table
	GearSettings.is_table = function(self, item)
		return type(item) == "table"
	end

	-- Check if unit and unit is alive
	GearSettings.is_unit = function(self, unit)
		return unit and type(unit) == "userdata" and unit_alive(unit)
	end

	-- Check if item is weapon
	GearSettings.is_weapon_item = function(self, gear_id_or_item)
		-- Get item from potential gear id
		local item = self:item_from_gear_id(gear_id_or_item)
		local item_type = item.item_type
		-- Return item type is weapon
		return item_type == WEAPON_MELEE or item_type == WEAPON_RANGED
	end

	-- Check if attachment slot is automatic slot
	GearSettings.is_automatic_slot = function(self, attachment_slot)
		return mod.automatic_attachments[attachment_slot] ~= nil
	end

	-- Check if attachment is trinket or skin
	GearSettings.is_trinket_or_skin = function(self, attachment_slot)
		return attachment_slot == "zzz_shared_material_overrides" or (attachment_slot == "slot_trinket_1" or attachment_slot == "slot_trinket_2")
	end

	-- Get real item from item
	GearSettings._real_item = function(self, gear_id_or_item)
		return gear_id_or_item and self:is_table(gear_id_or_item) and gear_id_or_item.__maser_item or gear_id_or_item
	end

	-- Get gear id from item
	GearSettings.gear_id = function(self, gear_id_or_item)
		-- Return gear id
		return gear_id_or_item and self:is_table(gear_id_or_item) and (gear_id_or_item.__gear and gear_id_or_item.__gear.uuid or gear_id_or_item.__original_gear_id or gear_id_or_item.__gear_id or gear_id_or_item.gear_id) or gear_id_or_item
	end

	-- Get slot info from item or gear id
	GearSettings.slot_info_id = function(self, gear_id_or_item)
		-- Get item from potential gear id
		local item = self:item_from_gear_id(gear_id_or_item)
		-- Return slot info
		return item and self:is_table(item) and (item.gear_id or item.__gear_id or item.__original_gear_id or item.__gear and item.__gear.uuid) or gear_id_or_item
	end

	-- Get original item
	GearSettings.original_item = function(self, gear_id_or_item)
		-- Setup master items backup
		mod:setup_item_definitions()
		-- Get item from potential gear id
		local item = self:item_from_gear_id(gear_id_or_item)
		local item_name = item and item.name
		-- Return original item
		return item_name and mod:persistent_table(REFERENCE).item_definitions[item_name]
	end
--#endregion

-- ##### ┬ ┬┌─┐┬  ┌─┐ #################################################################################################
-- ##### ├─┤├┤ │  ├─┘ #################################################################################################
-- ##### ┴ ┴└─┘┴─┘┴   #################################################################################################

--#region Helpers
	GearSettings.cached_gsub = function(self, string, pattern, replacement)
		return mod:cached_gsub(string, pattern, replacement)
	end

	GearSettings.cached_find = function(self, string, pattern)
		return mod:cached_find(string, pattern)
	end

	GearSettings.cached_split = function(self, str, sep)
		return mod:cached_split(str, sep)
	end

	GearSettings.slot_infos = function(self)
		return mod:persistent_table(REFERENCE).attachment_slot_infos
	end

	-- Get short name from content string
	GearSettings.short_name = function(self, content_string)
		local data_cache = mod.data_cache
		if data_cache and data_cache:item_string_to_item_name(content_string) then
			return data_cache:item_string_to_item_name(content_string)
		else
			return self:cached_gsub(content_string, '.*[%/%\\]', '')
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
		local item_name = item and item.name
		-- Return name
		return item_name and self:short_name(item_name)
	end

	GearSettings.get_weapon_from_gear_id = function(self, from_gear_id)
		local mod_weapon_extension = mod.weapon_extension
		local weapons = mod_weapon_extension and mod_weapon_extension._weapons
		if weapons then
			-- Iterate equipped itemslots
			for slot_name, weapon in pairs(weapons) do
				-- Check gear id
				local gear_id = self:item_to_gear_id(weapon.item)
				if from_gear_id == gear_id then
					-- Check weapon unit
					if weapon.weapon_unit then
						return slot_name, weapon
					end
				end
			end
		end
	end

--#endregion

-- ##### ┌─┐┌┬┐┌┬┐┌─┐┌─┐┬ ┬┌┬┐┌─┐┌┐┌┌┬┐  ┬─┐┌─┐┌─┐┬ ┬┬─┐┌─┐┬┬  ┬┌─┐ ###################################################
-- ##### ├─┤ │  │ ├─┤│  ├─┤│││├┤ │││ │   ├┬┘├┤ │  │ │├┬┘└─┐│└┐┌┘├┤  ###################################################
-- ##### ┴ ┴ ┴  ┴ ┴ ┴└─┘┴ ┴┴ ┴└─┘┘└┘ ┴   ┴└─└─┘└─┘└─┘┴└─└─┘┴ └┘ └─┘ ###################################################

--#region Attachment Recursive
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
					local children = attachment_data.children
					-- Check children
					if children then
						-- Get value from children
						val = self:_recursive_find_attachment(children, attachment_slot)
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
				local item = attachment_data.item
				-- Check item
				if type(item) == "string" and (item ~= "" or all) then
					-- Add to list
					output[attachment_slot] = attachment_data.attachment_name
				end
				local children = attachment_data.children
				-- Check children
				if children then
					-- Get children
					self:_recursive_get_attachments(children, all, output)
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
				local children = attachment_data.children
				-- Check children
				if children then
					-- Get children
					self:_recursive_get_attachments(children, output)
				end
			end
		end
	end

	-- Recursively get all attachments from item instance
	GearSettings._recursive_get_attachment_models = function(self, attachments, output)
		output = output or {}
		if attachments then
			-- Iterate attachments
			for attachment_slot, attachment_data in pairs(attachments) do
				-- Add to list
				output[#output+1] = attachment_data.item
				-- Check children
				local children = attachment_data.children
				if children then
					-- Get children
					self:_recursive_get_attachment_models(children, output)
				end
			end
		end
		-- Return output
		return output
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
					local children = attachment_data.children
					-- Check children
					if children then
						-- Get value from children
						val = self:_recursive_find_attachment_name(children, attachment_name)
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
					local children = attachment_data.children
					-- Check children
					if children then
						-- Get value from children
						val, parent = self:_recursive_find_attachment_parent(children, attachment_type)
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
					local children = attachment_data.children
					-- Check children
					if children then
						-- Get value from children
						val = self:_recursive_find_attachment_item_string(children, item_string)
					end
				end
				if val then break end
			end
		end
		return val
	end

	-- Get attachment list from item or gear id
	GearSettings.attachments = function(self, gear_id_or_item)
		-- Get item from potential gear id
		local item = self:item_from_gear_id(gear_id_or_item)
		local item_name = item and item.name
		-- Check item and name
		if item_name and self:is_weapon_item(gear_id_or_item) then
			-- Get item name
			item_name = self:short_name(item_name)
			-- Check if not in cache
			local data_cache = mod.data_cache
			if not data_cache or not data_cache:item_name_to_attachment_list(item_name) then
				-- Get attachments
				local attachments = {}
				-- Get attachments from item
				self:_recursive_get_attachments(item.attachments, true, attachments)
				-- Cache
				return attachments
			end
			-- Return cached attachments
			return data_cache:item_name_to_attachment_list(item_name)
		end
	end

	-- Get vanilla default attachment of specified item and slot
	GearSettings.default_attachment = function(self, gear_id_or_item, attachment_slot)
		-- Get original item
		local original_item = self:original_item(gear_id_or_item)
		local original_attachments = original_item and original_item.attachments
		local original_name = original_item and original_item.name
		-- Check item
		-- if original_item and original_item.attachments then
		-- local item = self:item_from_gear_id(gear_id_or_item)
		if original_item and original_attachments and original_name and self:is_weapon_item(original_item) then
			-- Get item name
			local item_name = self:short_name(original_name)
			-- Check if not in cache
			local data_cache = mod.data_cache
			local data_cache_value = data_cache and data_cache:item_name_to_default_attachment(item_name, attachment_slot)
			if not data_cache or not data_cache_value then
				local default = nil

				local item_models = mod.attachment_models[item_name]
				local item_attachments = mod.attachment[item_name]
				local slot_attachments = item_attachments and item_attachments[attachment_slot]
				local custom_slot = mod.add_custom_attachments[attachment_slot] ~= nil

				-- Original default
				local item_attachment = self:_recursive_find_attachment(original_attachments, attachment_slot)
				-- Check attachment
				if item_attachment and item_models then
					-- Iterate attachments
					for attachment_name, attachment_data in pairs(item_models) do
						-- Get attachment data
						-- local function is_default(attachment_name)
						-- 	-- return string_find(attachment_name, DEFAULT)
						-- 	return self:cached_find(attachment_name, DEFAULT)
						-- end
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
			return data_cache_value
		end
	end

	-- GearSettings.skin_attachment = function(self, gear_id_or_item, attachment_slot)
	-- 	mod:setup_item_definitions()
	-- 	mod:echo("loooooooooool")
	-- 	-- Get item from potential gear id
	-- 	local item = self:item_from_gear_id(gear_id_or_item)
	-- 	-- Get skin
	-- 	local weapon_skin = item and item.slot_weapon_skin
	-- 	if weapon_skin and type(weapon_skin) == "string" and weapon_skin ~= "" then
	-- 		weapon_skin = mod:persistent_table(REFERENCE).item_definitions[weapon_skin]
	-- 	end
	-- 	if weapon_skin then
	-- 		local attachment_data = self:_recursive_find_attachment(weapon_skin.attachments, attachment_slot)
	-- 		-- mod:dtf(weapon_skin, "weapon_skin", 10)
	-- 		-- mod:dtf(attachment_data, "attachment_data", 10)
	-- 		-- mod:echo(weapon_skin)
	-- 		-- mod:echo(attachment_data)
	-- 	else
	-- 		-- mod:dtf(item, "item", 10)
	-- 		-- mod:echo(item)
	-- 	end
	-- end
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┬┌─┐┬ ┬  ┬┌┬┐┌─┐┌┬┐  ┌─┐┌┬┐┌┬┐┌─┐┌─┐┬ ┬┌┬┐┌─┐┌┐┌┌┬┐┌─┐ ##############################################
-- ##### ││││ │ │││├┤ └┬┘  │ │ ├┤ │││  ├─┤ │  │ ├─┤│  ├─┤│││├┤ │││ │ └─┐ ##############################################
-- ##### ┴ ┴└─┘─┴┘┴└   ┴   ┴ ┴ └─┘┴ ┴  ┴ ┴ ┴  ┴ ┴ ┴└─┘┴ ┴┴ ┴└─┘┘└┘ ┴ └─┘ ##############################################

--#region Modify attachment items
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
				local children = attachment_data.children
				-- Check children
				if children then
					-- Set attachment in children
					self:_recursive_set_attachment(children, attachment_name, attachment_type, model)
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
					local children = attachment_data.children
					-- Check children
					if children then
						-- Remove attachment in children
						val = self:_recursive_remove_attachment(children, attachment_type)
					end
				end
				if val then break end
			end
		end
		return val
	end

	-- Recursively overwrite attachments
	-- GearSettings._overwrite_attachments = function(self, gear_id_or_item, attachments, gear_id_or_nil, attachment_list_or_nil)
	-- 	-- Get item from potential gear id
	-- 	local item = self:item_from_gear_id(gear_id_or_item)
	-- 	local item_name = item and item.name
	-- 	local mod_attachment_models = mod.attachment_models
	-- 	-- Check item and attachments
	-- 	-- if item and attachments then
	-- 	if item_name and attachments and self:is_weapon_item(gear_id_or_item) then
	-- 		-- Get item name
	-- 		item_name = self:short_name(item_name)
	-- 		-- Get attachment slots
	-- 		local possible_attachment_slots = self:possible_attachment_slots(gear_id_or_item, true)
	-- 		-- Iterate attachment slots
	-- 		for i = 1, #possible_attachment_slots, 1 do
	-- 			local attachment_slot = possible_attachment_slots[i]
	-- 			-- Don't handle trinkets
	-- 			local item_data = mod_attachment_models[item_name]
	-- 			if item_data then
	-- 				-- Get item data
	-- 				-- local item_data = mod_attachment_models[item_name]
	-- 				-- Get attachment
	-- 				local attachment = attachment_list_or_nil and attachment_list_or_nil[attachment_slot] or self:get(gear_id_or_nil or gear_id_or_item, attachment_slot)
	-- 				-- Customize
	-- 				local attachment_data = item_data[attachment]
	-- 				if attachment and attachment_data then
	-- 					-- Get attachment data
	-- 					-- local attachment_data = item_data[attachment]
	-- 					-- Set attachment
	-- 					self:_recursive_set_attachment(attachments, attachment, attachment_slot, attachment_data.model)
	-- 				end
	-- 			end
	-- 		end
	-- 	-- else
	-- 	-- 	mod:error("Invalid item or attachments - "..tostring(gear_id_or_item))
	-- 	end
	-- end
	GearSettings._overwrite_attachments = function(self, gear_id_or_item, attachments, gear_id_or_nil, attachment_list_or_nil)
		local item = self:item_from_gear_id(gear_id_or_item)
		local item_name = item and item.name
		local mod_attachment_models = mod.attachment_models

		if not (item_name and attachments and self:is_weapon_item(gear_id_or_item)) then
			return
		end

		item_name = self:short_name(item_name)
		local item_data = mod_attachment_models[item_name]
		if not item_data then
			return
		end

		local possible_attachment_slots = self:possible_attachment_slots(gear_id_or_item, true)
		local get_attachment = function(slot)
			return attachment_list_or_nil and attachment_list_or_nil[slot] or self:get(gear_id_or_nil or gear_id_or_item, slot)
		end

		for i = 1, #possible_attachment_slots do
			local attachment_slot = possible_attachment_slots[i]
			local attachment = get_attachment(attachment_slot)
			if attachment then
				local attachment_data = item_data[attachment]
				if attachment_data then
					self:_recursive_set_attachment(attachments, attachment, attachment_slot, attachment_data.model)
				end
			end
		end
	end

	-- Add custom attachments
	-- GearSettings._add_custom_attachments = function(self, gear_id_or_item, attachments, gear_id_or_nil, attachment_list_or_nil)
	-- 	-- Get item from potential gear id
	-- 	local item = self:item_from_gear_id(gear_id_or_item)
	-- 	local item_name = item and item.name
	-- 	local mod_attachment_models = mod.attachment_models
	-- 	-- Check item and attachments
	-- 	-- if item and attachments then
	-- 	if item_name and attachments and self:is_weapon_item(gear_id_or_item) then
	-- 		-- Get item name
	-- 		item_name = self:short_name(item_name)
	-- 		-- Iterate custom attachment slots
	-- 		for attachment_slot, attachment_table in pairs(mod.add_custom_attachments) do
	-- 			-- Get weapon setting for attachment slot
	-- 			local attachment_setting = attachment_list_or_nil and attachment_list_or_nil[attachment_slot] or self:get(gear_id_or_nil or item, attachment_slot)
	-- 			local attachment = self:_recursive_find_attachment(attachments, attachment_slot)
	-- 			local attachment_children = attachment and attachment.children
	-- 			local attachment_item = attachment and attachment.item
	-- 			-- Overwrite specific attachment settings
	-- 			if table_contains(attachment_setting_overwrite, attachment_slot) then
	-- 				attachment_setting = attachment_setting_overwrite[attachment_slot]
	-- 			end
	-- 			-- Get attachment data
	-- 			local model_data = mod_attachment_models[item_name]
	-- 			local attachment_data = model_data and model_data[attachment_setting]
	-- 			local attachment_parent = attachment_data and attachment_data.parent
	-- 			-- Check attachment data
	-- 			if attachment_data and attachment_parent then
	-- 				-- Set attachment parent
	-- 				local parent = attachments
	-- 				local has_original_parent, original_parent = self:_recursive_find_attachment_parent(attachments, attachment_slot)
	-- 				if has_original_parent and attachment_parent ~= original_parent then
	-- 					self:_recursive_remove_attachment(attachments, attachment_slot)
	-- 				end
	-- 				local parent_slot = self:_recursive_find_attachment(attachments, attachment_parent)
	-- 				parent = parent_slot and parent_slot.children or parent
	-- 				-- Children
	-- 				local original_children = nil
	-- 				-- table_clear(original_children)
	-- 				if attachment and attachment_children then
	-- 					original_children = table_clone(attachment_children)
	-- 				end
	-- 				-- Value
	-- 				local original_value = nil
	-- 				if attachment and attachment_item and attachment_item ~= "" then
	-- 					original_value = attachment and attachment_item
	-- 				end
	-- 				-- Attach custom slot
	-- 				parent[attachment_slot] = {
	-- 					children = original_children or {},
	-- 					item = original_value or attachment_data.model,
	-- 					attachment_type = attachment_slot,
	-- 					attachment_name = attachment_setting,
	-- 				}
	-- 			end
	-- 		end
	-- 	-- else
	-- 	-- 	mod:error("Invalid item or attachments - "..tostring(gear_id_or_item))
	-- 	end
	-- end
	GearSettings._add_custom_attachments = function(self, gear_id_or_item, attachments, gear_id_or_nil, attachment_list_or_nil)
		local item = self:item_from_gear_id(gear_id_or_item)
		local item_name = item and item.name
		local mod_attachment_models = mod.attachment_models
		local attachment_setting_overwrite = attachment_setting_overwrite -- assuming this is global or upvalue
		
		if not (item_name and attachments and self:is_weapon_item(gear_id_or_item)) then
			return
		end

		item_name = self:short_name(item_name)
		local model_data = mod_attachment_models[item_name]
		if not model_data then
			return
		end

		for attachment_slot, attachment_table in pairs(mod.add_custom_attachments) do
			-- Determine attachment_setting from argument or fallback
			local attachment_setting = nil
			if attachment_list_or_nil then
				attachment_setting = attachment_list_or_nil[attachment_slot]
			elseif gear_id_or_nil then
				attachment_setting = self:get(gear_id_or_nil, attachment_slot)
			else
				attachment_setting = self:get(item, attachment_slot)
			end

			if table_contains(attachment_setting_overwrite, attachment_slot) then
				attachment_setting = attachment_setting_overwrite[attachment_slot]
			end

			local attachment_data = model_data[attachment_setting]
			if not attachment_data or not attachment_data.parent then
				goto continue
			end

			local attachment = self:_recursive_find_attachment(attachments, attachment_slot)
			local has_original_parent, original_parent = self:_recursive_find_attachment_parent(attachments, attachment_slot)

			if has_original_parent and attachment_data.parent ~= original_parent then
				self:_recursive_remove_attachment(attachments, attachment_slot)
			end

			local parent_slot = self:_recursive_find_attachment(attachments, attachment_data.parent)
			local parent = parent_slot and parent_slot.children or attachments

			local original_children = attachment and attachment.children and table_clone(attachment.children) or {}
			local original_value = (attachment and attachment.item and attachment.item ~= "") and attachment.item or attachment_data.model

			parent[attachment_slot] = {
				children = original_children,
				item = original_value,
				attachment_type = attachment_slot,
				attachment_name = attachment_setting,
			}

			::continue::
		end
	end

	GearSettings.sound_packages = function(self, gear_id_or_item)
		local sounds_out = {}
		local item = self:item_from_gear_id(gear_id_or_item)
		local item_name = item and item.name
		-- Check item
		if item_name and self:is_weapon_item(gear_id_or_item) then
			-- Get item name
			item_name = self:short_name(item_name)
			-- mod:console_print("Getting sound packages for "..item_name)
			-- local data_type = self:has_backpack() and BACKPACK or DEFAULT
			-- local offsets = mod.visible_equipment_offsets
			local item_data = mod.visible_equipment_offsets[item_name]
			local item_equipment_data1 = item_data and item_data["default"]
			local item_equipment_data2 = item_data and item_data["backpack"]
			
			item_equipment_data1 = item_equipment_data1 or mod.visible_equipment_offsets.human[item_name]
        		and mod.visible_equipment_offsets.human[item_name]["default"]
			item_equipment_data2 = item_equipment_data2 or mod.visible_equipment_offsets.human[item_name]
        		and mod.visible_equipment_offsets.human[item_name]["backpack"]

			local sounds1 = item_equipment_data1 and item_equipment_data1.step_sounds or item_data and item_data.step_sounds or {}
			local sounds2 = item_equipment_data1 and item_equipment_data1.step_sounds2 or item_data and item_data.step_sounds2 or {}
			local sounds3 = item_equipment_data2 and item_equipment_data2.step_sounds or item_data and item_data.step_sounds or {}
			local sounds4 = item_equipment_data2 and item_equipment_data2.step_sounds2 or item_data and item_data.step_sounds2 or {}
			local sounds5 = SoundEventAliases.sfx_ads_up.events[item_name]
				or SoundEventAliases.sfx_ads_down.events[item_name]
				-- or SoundEventAliases.sfx_grab_weapon.events[self.item_names[slot]]
				-- or SoundEventAliases.sfx_equip.events[self.item_names[slot]]
				or SoundEventAliases.sfx_equip.events.default
			local sounds6 = SoundEventAliases.sfx_weapon_foley_left_hand_01.events[item_name]
				or SoundEventAliases.sfx_ads_down.events[item_name]
				-- or SoundEventAliases.sfx_grab_weapon.events[self.item_names[slot]]
				-- or SoundEventAliases.sfx_equip.events[self.item_names[slot]]
				or SoundEventAliases.sfx_ads_down.events.default
			local sounds = table.icombine(sounds1, sounds2, sounds3, sounds4, {sounds5}, {sounds6})
			
			-- for _, sound in pairs(sounds) do
			for i = 1, #sounds, 1 do
				sounds_out[sounds[i]] = true
			end

		end

		return sounds_out
	end

	-- Add custom resources - unused
	GearSettings.add_custom_resources = function(self, gear_id_or_item, out_result, gear_id_or_nil)
		-- Setup master items backup
		mod:setup_item_definitions()
		local item = self:item_from_gear_id(gear_id_or_item)
		local item_name = item and item.name
		-- Check item
		if item_name and item.attachments and self:is_weapon_item(gear_id_or_item) then
			-- Get item name
			item_name = self:short_name(item_name)
			-- Iter attachment slots
			local mod_attachment_slots = mod.attachment_slots
			for i = 1, #mod_attachment_slots, 1 do
				local attachment_slot = mod_attachment_slots[i]
				-- Get attachment
				-- local attachment = self:get(gear_id_or_nil or item, attachment_slot)
				local attachment = self:_recursive_find_attachment(item.attachments, attachment_slot)
				-- Get item data
				-- local item_data = attachment and mod.attachment_models[item_name]
				-- Get attachment data
				-- local attachment_data = item_data and item_data[attachment]
				-- Get model
				-- local model = attachment_data and attachment_data.model
				local model = attachment and attachment.item
				-- Get original item
				local original_item = model and mod:persistent_table(REFERENCE).item_definitions[model]
				local original_item_resource_dependencies = original_item.resource_dependencies
				-- Check original item and dependencies
				if original_item and original_item_resource_dependencies then
					-- Iterate dependencies
					for resource, _ in pairs(original_item_resource_dependencies) do
						-- Add resource
						out_result[resource] = true
					end
				end
			end
			-- Sounds
			local sounds = self:sound_packages(gear_id_or_item)
			if sounds then
				for sound, _ in pairs(sounds) do
					out_result[sound] = true
				end
			end

		end
	end
--#endregion

-- ##### ┌─┐┌┬┐┌┬┐┌─┐┌─┐┬ ┬┌┬┐┌─┐┌┐┌┌┬┐┌─┐ ############################################################################
-- ##### ├─┤ │  │ ├─┤│  ├─┤│││├┤ │││ │ └─┐ ############################################################################
-- ##### ┴ ┴ ┴  ┴ ┴ ┴└─┘┴ ┴┴ ┴└─┘┘└┘ ┴ └─┘ ############################################################################

--#region Attachments
	-- Get gear attach points
	GearSettings.gear_attach_points = function(self, archetype)
		local archetype = archetype == "ogryn" and "ogryn" or "human"
		return mod.gear_attach_points[archetype]
	end

	local quaternion_from_vector = Quaternion.from_vector
	local unit_set_local_rotation = Unit.set_local_rotation
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
						-- Set attach point unit data
						unit_set_data(point_unit, "gear_attach_name", point.name)
						-- Link attach point unit
						world_link_unit(world, point_unit, 1, unit, node)
						-- Set attach point unit position
						unit_set_local_position(point_unit, 1, vector3_unbox(point.offset))
						-- unit_set_local_rotation(point_unit, 1, quaternion_from_vector(vector3(90, 0, 0)))
						-- unit_set_local_rotation(point_unit, 3, quaternion_from_vector(vector3(90, 0, 0)))
						-- Add attach point unit
						attach_point_units[point.name] = point_unit
					end
				end
				-- Return attach point units
				return attach_point_units
			end
		end
	end

	GearSettings.get_skin_attachments = function(self, gear_id_or_item)
		local item = self:item_from_gear_id(gear_id_or_item)
		local weapon_skin = item and item.slot_weapon_skin
		if weapon_skin and type(weapon_skin) == "string" and weapon_skin ~= "" then
			mod:setup_item_definitions()
			weapon_skin = mod:persistent_table(REFERENCE).item_definitions[weapon_skin]
		end
		if weapon_skin and type(weapon_skin) == "table" and weapon_skin.attachments then
			return weapon_skin.attachments, weapon_skin.feature_flags and table_contains(weapon_skin.feature_flags, "FEATURE_premium_store")
		end
	end

	-- Get possible attachment slots from item
	GearSettings.possible_attachment_slots = function(self, gear_id_or_item)
		-- Get item from potential gear id
		local item = self:item_from_gear_id(gear_id_or_item)
		local item_name = item and item.name
		-- Check item
		if item_name and self:is_weapon_item(gear_id_or_item) then
			-- Get item name
			item_name = self:short_name(item_name)
			-- Check if not in cache
			local data_cache = mod.data_cache
			if not data_cache or not data_cache:item_name_to_attachment_slots(item_name) then
				local possible_attachment_slots = {}
				local num_possible_attachment_slots = 0
				-- Get item attachments
				local list = mod.attachment_models[item_name]
				-- Check list
				if list then
					-- Iterate list
					for attachment_name, attachment_data in pairs(list) do
						local attachment_data_type = attachment_data.type
						-- Check if not in list
						if type(attachment_data_type) == "string" and not table_contains(possible_attachment_slots, attachment_data_type) then
							-- Add to list
							possible_attachment_slots[#possible_attachment_slots+1] = attachment_data_type
							num_possible_attachment_slots = num_possible_attachment_slots + 1
						elseif type(attachment_data_type) ~= "string" then
							mod:print("WARNING: Unknown attachment type: "..tostring(type(attachment_data_type)).." for "..tostring(attachment_name))
						end
					end
				end
				-- Cache slots
				return possible_attachment_slots, num_possible_attachment_slots
			end
			-- Return cached slots
			return data_cache:item_name_to_attachment_slots(item_name), data_cache:item_name_to_num_attachment_slots(item_name)
		end
	end

	-- Get possible attachments from item optionally for attachment_slot
	-- GearSettings.possible_attachments = function(self, gear_id_or_item, attachment_slot_or_nil)
	-- 	-- Get item from potential gear id
	-- 	local item = self:item_from_gear_id(gear_id_or_item)
	-- 	local item_name = item and item.name
	-- 	-- Check item
	-- 	if item_name and self:is_weapon_item(gear_id_or_item) then
	-- 		-- Get item name
	-- 		item_name = self:short_name(item_name)
	-- 		-- Check if not in cache
	-- 		local data_cache = mod.data_cache
	-- 		if not data_cache or not data_cache:item_name_to_attachment_list(item_name, attachment_slot_or_nil) then
	-- 			local possible_attachments = {}
	-- 			-- Get attachments
	-- 			local attachments = self:attachments(gear_id_or_item)
	-- 			-- Check item and attachments
	-- 			if item and attachments then
	-- 				-- Get item attachments
	-- 				local list = mod.attachment[item_name]
	-- 				-- Optional get slot attachments
	-- 				list = attachment_slot_or_nil and list and list[attachment_slot_or_nil]
	-- 				-- Check list
	-- 				if list then
	-- 					-- Iterate list
	-- 					for _, attachment_data in pairs(list) do
	-- 						local attachment_data_id = attachment_data.id
	-- 						-- Check if not in list
	-- 						if not table_contains(possible_attachments, attachment_data_id) then
	-- 							-- Add to list
	-- 							possible_attachments[#possible_attachments+1] = attachment_data_id
	-- 						end
	-- 					end
	-- 				end
	-- 			end
	-- 			-- Cache attachment list
	-- 			return possible_attachments
	-- 		end
	-- 		-- Return cached attachment list
	-- 		return data_cache:item_name_to_attachment_list(item_name, attachment_slot_or_nil)
	-- 	end
	-- end
	GearSettings.possible_attachments = function(self, gear_id_or_item, attachment_slot_or_nil)
		local item = self:item_from_gear_id(gear_id_or_item)
		if not item then return end

		local item_name = item.name
		if not item_name or not self:is_weapon_item(gear_id_or_item) then
			return
		end

		item_name = self:short_name(item_name)
		local data_cache = mod.data_cache
		if data_cache then
			local cached_list = data_cache:item_name_to_attachment_list(item_name, attachment_slot_or_nil)
			if cached_list then
				return cached_list
			end
		end

		local possible_attachments = {}
		local possible_attachments_set = {}

		local attachments = self:attachments(gear_id_or_item)
		if not attachments then return possible_attachments end

		local list = mod.attachment[item_name]
		if attachment_slot_or_nil and list then
			list = list[attachment_slot_or_nil]
		end

		if not list then
			return possible_attachments
		end

		for _, attachment_data in ipairs(list) do
			local id = attachment_data.id
			if not possible_attachments_set[id] then
				possible_attachments_set[id] = true
				possible_attachments[#possible_attachments + 1] = id
			end
		end

		return possible_attachments
	end

	-- Get attachment unit for attachment slot from attachment units
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

	-- Get attachment slot from attachment unit
	GearSettings.attachment_slot = function(self, attachment_unit)
		return unit_get_data(attachment_unit, "attachment_slot")
	end

	-- Get attachment name from attachment unit
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

	-- Randomize weapon attachments
	GearSettings.randomize_weapon = function(self, gear_id_or_item)
		-- Get item from potential gear id
		local item = self:item_from_gear_id(gear_id_or_item)
		local item_name = item and item.name
		if item_name then
			-- Check item name
			item_name = self:short_name(item_name)
			-- Get gear id from item or gear id
			local gear_id = mod.gear_settings:item_to_gear_id(gear_id_or_item)
			-- Get attachment slots
			local attachment_slots = self:possible_attachment_slots(gear_id_or_item)
			-- Base mod only
			local base_mod_only = mod:get("mod_option_randomization_only_base_mod")
			-- Check attachment slots
			if attachment_slots then
				local random_attachments = {}
				-- Clear temp tables
				table_clear(possible_attachments)
				table_clear(no_support_entries)
				table_clear(special_resolve_entries)
				table_clear(auto_equip_entries)
				table_clear(trigger_move_entries)
				local mod_attachment = mod.attachment
				local mod_attachment_models = mod.attachment_models
				local mod_automatic_slots = mod.automatic_slots
				-- Iterate attachment slots
				for _, attachment_slot in pairs(attachment_slots) do
					-- Check attachments for slots
					local item_attachments = mod_attachment[item_name]
					local item_models = mod_attachment_models[item_name]
					if item_attachments and item_attachments[attachment_slot] and not table_contains(mod_automatic_slots, attachment_slot) then
						local chance_success = true
						-- Randomization chance
						local random_attachment_list = mod.random_chance[attachment_slot]
						if random_attachment_list then
							-- Get chance option value
							local chance = mod:get(random_attachment_list)
							-- Set chance 100 if default attachment in slot
							if self:default_attachment(item, attachment_slot) then chance = 100 end
							-- Generate random chance
							chance_success = math_random(100) <= chance
						end
						-- Check success
						if chance_success then
							-- Get possible attachments
							for _, data in pairs(item_attachments[attachment_slot]) do
								-- Check attachment
								if not mod:cached_find(data.id, "default") and not data.no_randomize and item_models[data.id] and (data.original_mod or not base_mod_only) then
									-- Create attachment slot table
									possible_attachments[attachment_slot] = possible_attachments[attachment_slot] or {}
									-- Add attachment to list
									possible_attachments[attachment_slot][#possible_attachments[attachment_slot]+1] = data.id
								end
							end
							-- Check possible attachments
							if possible_attachments[attachment_slot] then
								-- Get random attachment
								local random_attachment = math_random_array_entry(possible_attachments[attachment_slot])
								-- if attachment_slot == "flashlight" then random_attachment = "laser_pointer" end
								-- Set random attachment
								random_attachments[attachment_slot] = random_attachment
								-- Get attachment data
								local attachment_data = item_models[random_attachment]
								-- Get attachment settings
								local no_support = attachment_data and attachment_data.no_support
								local auto_equip = attachment_data and attachment_data.automatic_equip
								local special_resolve = attachment_data and attachment_data.special_resolve
								local trigger_move = attachment_data and attachment_data.trigger_move
								-- Apply fixes
								attachment_data = self:apply_fixes(item, attachment_slot) or attachment_data
								-- Get attachment fix settings
								no_support = attachment_data.no_support or no_support
								auto_equip = attachment_data.automatic_equip or auto_equip
								special_resolve = attachment_data.special_resolve or special_resolve
								trigger_move = attachment_data and attachment_data.trigger_move
								-- Trigger move
								if trigger_move then
									for _, trigger_slot in pairs(trigger_move) do
										trigger_move_entries[#trigger_move_entries+1] = trigger_slot
									end
								end
								-- Get no support entries
								if no_support then
									for _, no_support_entry in pairs(no_support) do
										no_support_entries[#no_support_entries+1] = no_support_entry
									end
								end
								-- Get auto equip entries
								if auto_equip then
									for auto_type, auto_attachment in pairs(auto_equip) do
										auto_equip_entries[auto_type] = auto_attachment
									end
								end
								-- Resolve special resolve entries
								if special_resolve and type(special_resolve) == "function" then
									special_resolve_entries[random_attachment] = special_resolve
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
				-- Auto equip
				for auto_type, auto_attachment in pairs(auto_equip_entries) do
					local parameters = self:cached_split(auto_attachment, "|")
					if #parameters == 2 then
						-- local negative = string_find(parameters[1], "!")
						local negative = self:cached_find(parameters[1], "!")
						-- parameters[1] = negative and string_gsub(parameters[1], "!", "") or parameters[1]
						parameters[1] = negative and self:cached_gsub(parameters[2], "!", "") or parameters[1]
						local attachment_name = self:get(gear_id_or_item, auto_type)
						if attachment_name then
							if negative and attachment_name ~= parameters[1] then
								random_attachments[auto_type] = parameters[2]
							elseif attachment_name == parameters[1] then
								random_attachments[auto_type] = parameters[2]
							end
						end
					else
						random_attachments[auto_type] = parameters[1]
					end
				end
				-- Special resolve
				for special_attachment, special_resolve_function in pairs(special_resolve_entries) do
					-- Execute special resolve function
					local special_changes = special_resolve_function(gear_id, item, special_attachment, random_attachments)
					-- Check special changes
					if special_changes then
						-- Iterate special changes
						for special_slot, special_attachment in pairs(special_changes) do
							-- Get special resolve attachment possibilities
							-- if string_find(special_attachment, "|") then
							if self:cached_find(special_attachment, "|") then
								-- Split special resolve attachment possibilities
								local possibilities = self:cached_split(special_attachment, "|")
								-- Select random possibility
								special_attachment = possibilities[math.random(#possibilities)]
							end
							-- Set special attachment
							random_attachments[special_slot] = special_attachment
						end
					end
				end
				-- Trigger move
				for _, trigger_slot in pairs(trigger_move_entries) do
					random_attachments[trigger_slot] = random_attachments[trigger_slot] or self:get(item, trigger_slot)
				end
				-- Gear node
				random_attachments["gear_node"] = rnd_attach[math_random(1, #rnd_attach)]
				-- Return random attachments
				return random_attachments
			end
		end
	end
--#endregion

-- ##### ┌─┐┌┬┐┌┬┐┌─┐┌─┐┬ ┬┌┬┐┌─┐┌┐┌┌┬┐  ┌─┐┬─┐ ┬┌─┐┌─┐ ###############################################################
-- ##### ├─┤ │  │ ├─┤│  ├─┤│││├┤ │││ │   ├┤ │┌┴┬┘├┤ └─┐ ###############################################################
-- ##### ┴ ┴ ┴  ┴ ┴ ┴└─┘┴ ┴┴ ┴└─┘┘└┘ ┴   └  ┴┴ └─└─┘└─┘ ###############################################################

-- GearSettings.pattern_to_weapon = function(self, pattern)
-- 	return mod:persistent_table(REFERENCE).cache.pattern_to_item[pattern]
-- end

GearSettings.is_standard_attachment = function(self, item_name, attachment_slot, attachment_name)
	if attachment_name and mod:persistent_table(REFERENCE).cache.attachment_list[item_name] and mod:persistent_table(REFERENCE).cache.attachment_list[item_name][attachment_slot] then
		if table_contains(mod:persistent_table(REFERENCE).cache.attachment_list[item_name][attachment_slot], attachment_name) then
			for i, data in pairs(mod.attachment[item_name][attachment_slot]) do
				if data.id == attachment_name then
					return data.original_mod
				end
			end
		end
	end
end

--#region Attachment Fixes
	-- Apply attachment fixes
	GearSettings.apply_fixes = function(self, gear_id_or_item, unit_or_name)
		-- Get item from potential gear id
		local item = self:item_from_gear_id(gear_id_or_item)
		local item_name = item and item.name

		if not unit_or_name then return end

		local gear_id = self:item_to_gear_id(gear_id_or_item)
		local temp_gear_settings = mod:persistent_table(REFERENCE).temp_gear_settings
		local temp_cached_fixes = mod:persistent_table(REFERENCE).temp_cached_fixes
		-- Check if temp settings exist
		if gear_id and unit_or_name and temp_cached_fixes[gear_id] and temp_cached_fixes[gear_id][unit_or_name] then
			return temp_cached_fixes[gear_id][unit_or_name]
		end

		local function cache_fix(fix)
			if gear_id and unit_or_name then --and temp_gear_settings[gear_id] then
				temp_cached_fixes[gear_id] = temp_cached_fixes[gear_id] or {}
				temp_cached_fixes[gear_id][unit_or_name] = fix
			end
		end

		-- Check item and attachments
		if item_name and self:is_weapon_item(gear_id_or_item) then--(item.item_type == WEAPON_MELEE or item.item_type == WEAPON_RANGED) then
			-- local gear_id = self:item_to_gear_      id(item)
			item_name = self:short_name(item_name)
			-- local weapon_name = self:pattern_to_weapon(item_name)
			-- Check gear id
			local item_attachments = mod.attachment_models[item_name]
			if item_name and item_attachments then
				local item_anchors = mod.anchors[item_name]
				-- Check if item has fixes
				if item_anchors and item_anchors.fixes then
					-- Get possible attachment slots
					local possible_attachment_slots, num_possible_attachment_slots = self:possible_attachment_slots(gear_id_or_item)
					-- Get attachment slots
					table_clear(current_attachments_by_slot)
					table_clear(current_attachments)
					-- current_attachments_by_slot = script_new_map(num_possible_attachment_slots)
					-- current_attachments = script_new_array(num_possible_attachment_slots)
					-- Iterate attachment slots
					for i, attachment_slot in pairs(possible_attachment_slots) do
						current_attachments[i] = self:get(gear_id_or_item, attachment_slot)
						current_attachments_by_slot[attachment_slot] = current_attachments[i]
						-- current_attachments_by_slot[attachment_slot] = self:get(gear_id_or_item, attachment_slot)
						-- current_attachments[i] = current_attachments_by_slot[attachment_slot]
					end

					-- local find_attachment = function(dependency_possibility)
					-- 	local possible_attachment_slots = self:possible_attachment_slots(gear_id_or_item)
					-- 	for _, attachment_slot in pairs(possible_attachment_slots) do
					-- 		if self:get(gear_id_or_item, attachment_slot) == dependency_possibility then
					-- 			return true
					-- 		end
					-- 	end
					-- 	return false
					-- end

					-- local _current_attachments = self:pull(gear_id_or_item)
					-- Get fixes
					local fix_list = item_anchors.fixes
					local mod_attachment_slots = mod.attachment_slots
					-- Iterate fixes
					for fix_index, fix_data in pairs(fix_list) do
						-- Dependencies
						local has_dependencies = false
						-- local no_dependencies = false
						-- Check dependencies
						if fix_data.dependencies then
							-- Iterate dependencies
							for _, dependency_entry in pairs(fix_data.dependencies) do
								-- Split dependency possibilities
								local dependency_possibilities = self:cached_split(dependency_entry, "|")
								local has_dependency_possibility = false
								-- Iterate dependency possibilities
								for i, dependency_possibility in pairs(dependency_possibilities) do

									-- local negative = string_find(dependency_possibility, "!")
									if not self.dependency_possibility_info[dependency_possibility] then
										self.dependency_possibility_info[dependency_possibility] = {
											negative = self:cached_find(dependency_possibility, "!"),
											possibility = self:cached_gsub(dependency_possibility, "!", ""),
										}
										local possibility = self.dependency_possibility_info[dependency_possibility]
										if self:cached_find(possibility.possibility, "&") then
											possibility.original_item = true
											possibility.possibility = self:cached_gsub(possibility.possibility, "&", "")
										end
									end
									local possibility = self.dependency_possibility_info[dependency_possibility]
									-- local negative = self:cached_find(dependency_possibility, "!")
									local negative = possibility.negative
									-- dependency_possibility = negative and string_gsub(dependency_possibility, "!", "") or dependency_possibility
									-- dependency_possibility = negative and self:cached_gsub(dependency_possibility, "!", "") or dependency_possibility
									dependency_possibility = negative and possibility.possibility or dependency_possibility


									local is_slot = table_contains(mod_attachment_slots, dependency_possibility)

									if possibility.original_item and is_slot then
										if negative then
											-- has_dependency_possibility = weapon_name ~= self:attachment_to_item(current_attachments_by_slot[dependency_possibility])
											has_dependency_possibility = not self:is_standard_attachment(item_name, dependency_possibility, current_attachments_by_slot[dependency_possibility])
										else
											-- has_dependency_possibility = weapon_name == self:attachment_to_item(current_attachments_by_slot[dependency_possibility])
											has_dependency_possibility = self:is_standard_attachment(item_name, dependency_possibility, current_attachments_by_slot[dependency_possibility])
										end
									elseif item_attachments and item_attachments[dependency_possibility] then
										if negative then
											has_dependency_possibility = not table_contains(current_attachments, dependency_possibility)
											-- has_dependency_possibility = not find_attachment(dependency_possibility)
											-- has_dependency_possibility = self:_recursive_find_attachment_name(item.attachments, dependency_possibility) == nil
										else
											has_dependency_possibility = table_contains(current_attachments, dependency_possibility)
											-- has_dependency_possibility = find_attachment(dependency_possibility)
											-- has_dependency_possibility = self:_recursive_find_attachment_name(item.attachments, dependency_possibility) ~= nil
										end
									elseif is_slot then
										-- local slot_attachment = self:get(gear_id_or_item, dependency_possibility)
										if negative then
											has_dependency_possibility = current_attachments_by_slot[dependency_possibility] == nil
											-- has_dependency_possibility = self:get(gear_id_or_item, dependency_possibility) == nil
											-- has_dependency_possibility = self:_recursive_find_attachment(item.attachments, dependency_possibility) == nil
										else
											has_dependency_possibility = current_attachments_by_slot[dependency_possibility] ~= nil
											-- has_dependency_possibility = self:get(gear_id_or_item, dependency_possibility) ~= nil
											-- has_dependency_possibility = self:_recursive_find_attachment(item.attachments, dependency_possibility) ~= nil
										end
									elseif item_attachments then
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
							has_dependencies = true
						end
						-- Check if has dependencies or no dependencies
						if has_dependencies then

							local slot_infos = self:slot_infos()
							local slot_info_id = self:slot_info_id(item)

							for fix_attachment, fix in pairs(fix_data) do
								-- Attachment
								if slot_infos and slot_infos[slot_info_id] then
									if item_attachments[fix_attachment] then
										-- if mod.gear_settings:has_attachment(item, fix_attachment)
										-- if self:_recursive_find_attachment_name(item.attachments, fix_attachment)
										-- if find_attachment(fix_attachment)
										if table_contains(current_attachments, fix_attachment) and unit_or_name == slot_infos[slot_info_id].attachment_slot_to_unit[item_attachments[fix_attachment].type] then
											cache_fix(fix)
											return fix
										end
									end
									-- Slot
									if unit_or_name == slot_infos[slot_info_id].attachment_slot_to_unit[fix_attachment] then
										cache_fix(fix)
										return fix
									end
								end
								-- Scope offset etc
								if unit_or_name == fix_attachment then
									cache_fix(fix)
									return fix
								end
							end
						end
					end
				end
			end
		end
	end
	-- GearSettings.apply_fixes = function(self, gear_id_or_item, unit_or_name)
	-- 	local item = self:item_from_gear_id(gear_id_or_item)
	-- 	if not item then return end

	-- 	local gear_id = self:item_to_gear_id(gear_id_or_item)
	-- 	local temp_gear_settings = mod:persistent_table(REFERENCE).temp_gear_settings
	-- 	local temp_cached_fixes = mod:persistent_table(REFERENCE).temp_cached_fixes
	-- 	-- Check if temp settings exist
	-- 	if temp_gear_settings[gear_id] and temp_cached_fixes[gear_id][unit_or_name] then
	-- 		mod:echo("used cached fixes")
	-- 		return temp_cached_fixes[gear_id][unit_or_name]
	-- 	else
	-- 		temp_cached_fixes[gear_id] = temp_cached_fixes[gear_id] or {}
	-- 	end

	-- 	local item_name = item.name
	-- 	if not item_name or not self:is_weapon_item(gear_id_or_item) then
	-- 		return
	-- 	end

	-- 	item_name = self:short_name(item_name)
	-- 	local item_attachments = mod.attachment_models[item_name]
	-- 	if not item_attachments then return end

	-- 	local item_anchors = mod.anchors[item_name]
	-- 	if not item_anchors or not item_anchors.fixes then return end

	-- 	local mod_attachment_slots = mod.attachment_slots
	-- 	local fix_list = item_anchors.fixes

	-- 	-- Get possible attachment slots once
	-- 	local possible_attachment_slots = self:possible_attachment_slots(gear_id_or_item)
	-- 	if not possible_attachment_slots then return end

	-- 	-- Clear or reuse tables to avoid garbage
	-- 	table_clear(current_attachments_by_slot)
	-- 	table_clear(current_attachments)

	-- 	-- Cache current attachments by slot
	-- 	for i, attachment_slot in ipairs(possible_attachment_slots) do
	-- 		local attachment = self:get(gear_id_or_item, attachment_slot)
	-- 		current_attachments[i] = attachment
	-- 		current_attachments_by_slot[attachment_slot] = attachment
	-- 	end

	-- 	local slot_infos = self:slot_infos()
	-- 	local slot_info_id = self:slot_info_id(item)

	-- 	-- Dependency info cache
	-- 	local dep_info_cache = self.dependency_possibility_info

	-- 	local function cache_fix(fix)
	-- 		if temp_gear_settings[gear_id] then
	-- 			temp_cached_fixes[gear_id][unit_or_name] = fix
	-- 		end
	-- 	end

	-- 	for _, fix_data in ipairs(fix_list) do
	-- 		local has_dependencies = true

	-- 		if fix_data.dependencies then
	-- 			for _, dep_entry in ipairs(fix_data.dependencies) do
	-- 				local dependency_possibilities = self:cached_split(dep_entry, "|")
	-- 				local dep_satisfied = false

	-- 				for _, dep_possibility_raw in ipairs(dependency_possibilities) do
	-- 					local dep_info = dep_info_cache[dep_possibility_raw]
	-- 					if not dep_info then
	-- 						local negative = self:cached_find(dep_possibility_raw, "!")
	-- 						local possibility = self:cached_gsub(dep_possibility_raw, "!", "")
	-- 						local original_item = false
	-- 						if self:cached_find(possibility, "&") then
	-- 							original_item = true
	-- 							possibility = self:cached_gsub(possibility, "&", "")
	-- 						end
	-- 						dep_info = {
	-- 							negative = negative,
	-- 							possibility = possibility,
	-- 							original_item = original_item
	-- 						}
	-- 						dep_info_cache[dep_possibility_raw] = dep_info
	-- 					end

	-- 					local neg = dep_info.negative
	-- 					local dep_possibility = neg and dep_info.possibility or dep_possibility_raw
	-- 					local is_slot = table_contains(mod_attachment_slots, dep_possibility)
	-- 					local satisfied = false

	-- 					if dep_info.original_item and is_slot then
	-- 						if neg then
	-- 							satisfied = not self:is_standard_attachment(item_name, dep_possibility, current_attachments_by_slot[dep_possibility])
	-- 						else
	-- 							satisfied = self:is_standard_attachment(item_name, dep_possibility, current_attachments_by_slot[dep_possibility])
	-- 						end

	-- 					elseif item_attachments[dep_possibility] then
	-- 						if neg then
	-- 							satisfied = not table_contains(current_attachments, dep_possibility)
	-- 						else
	-- 							satisfied = table_contains(current_attachments, dep_possibility)
	-- 						end

	-- 					elseif is_slot then
	-- 						if neg then
	-- 							satisfied = current_attachments_by_slot[dep_possibility] == nil
	-- 						else
	-- 							satisfied = current_attachments_by_slot[dep_possibility] ~= nil
	-- 						end

	-- 					else
	-- 						if neg then
	-- 							satisfied = dep_possibility ~= item_name
	-- 						else
	-- 							satisfied = dep_possibility == item_name
	-- 						end
	-- 					end

	-- 					if satisfied then
	-- 						dep_satisfied = true
	-- 						break
	-- 					end
	-- 				end

	-- 				has_dependencies = dep_satisfied
	-- 				if not has_dependencies then
	-- 					break
	-- 				end
	-- 			end
	-- 		end

	-- 		if has_dependencies then
	-- 			if slot_infos and slot_infos[slot_info_id] then
	-- 				local slot_info = slot_infos[slot_info_id]
	-- 				for fix_attachment, fix in pairs(fix_data) do
	-- 					if item_attachments[fix_attachment] then
	-- 						if table_contains(current_attachments, fix_attachment) and unit_or_name == slot_info.attachment_slot_to_unit[item_attachments[fix_attachment].type] then
	-- 							cache_fix(fix)
	-- 							return fix
	-- 						end
	-- 					end
	-- 					if unit_or_name == slot_info.attachment_slot_to_unit[fix_attachment] then
	-- 						cache_fix(fix)
	-- 						return fix
	-- 					end
	-- 					if unit_or_name == fix_attachment then
	-- 						cache_fix(fix)
	-- 						return fix
	-- 					end
	-- 				end
	-- 			end
	-- 		end
	-- 	end
	-- end

	GearSettings.loaded_packages = function(self)
		return mod:persistent_table(REFERENCE).loaded_packages.view_weapon_sounds
	end

	GearSettings.used_packages = function(self)
		return mod:persistent_table(REFERENCE).used_packages.view_weapon_sounds
	end

	-- Release attachment packages
	-- local unloaded_packages = {}
	-- GearSettings.release_attachment_sounds = function(self)
	-- 	-- local unloaded_packages = {}
	-- 	-- table_clear(unloaded_packages)
	-- 	for sound, package_id in pairs(self:loaded_packages()) do
	-- 		-- unloaded_packages[#unloaded_packages+1] = sound
	-- 		self:used_packages()[sound] = nil
	-- 		managers.package:release(package_id)
	-- 	end
	-- 	table_clear(self:loaded_packages())
	-- 	-- self:loaded_packages() = {}
	-- 	-- for _, package in pairs(unloaded_packages) do
	-- 	-- 	self:loaded_packages()[package] = nil
	-- 	-- end
	-- end

	-- Load attachment sounds
	GearSettings.load_attachment_sounds = function(self, item)
		-- local attachments = self:get_item_attachment_slots(item)
		local attachments = self:possible_attachment_slots(item)
		local managers_package = managers.package
		for _, attachment_slot in pairs(attachments) do
			local attachment_name = self:get(item, attachment_slot)
			local detach_sounds = mod:get_equipment_sound_effect(item, attachment_slot, attachment_name, "detach", true)
			if detach_sounds then
				for _, detach_sound in pairs(detach_sounds) do
					if not self:loaded_packages()[detach_sound] then
						self:used_packages()[detach_sound] = true
						self:loaded_packages()[detach_sound] = managers_package:load(detach_sound, REFERENCE)
					end
				end
			end
			local attach_sounds = mod:get_equipment_sound_effect(item, attachment_slot, attachment_name, "attach", true)
			if attach_sounds then
				for _, attach_sound in pairs(attach_sounds) do
					if not self:loaded_packages()[attach_sound] then
						self:used_packages()[attach_sound] = true
						self:loaded_packages()[attach_sound] = managers_package:load(attach_sound, REFERENCE)
					end
				end
			end
			local select_sounds = mod:get_equipment_sound_effect(item, attachment_slot, attachment_name, "select", true)
			if select_sounds then
				for _, select_sound in pairs(select_sounds) do
					if not self:loaded_packages()[select_sound] then
						self:used_packages()[select_sound] = true
						self:loaded_packages()[select_sound] = managers_package:load(select_sound, REFERENCE)
					end
				end
			end
		end
	end

	-- Find node in unit
	GearSettings.find_node_in_unit = function(self, unit, node_name)
		if unit_has_node(unit, node_name) then
			return true
		end
	end

	-- Find node in attachments
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
--#endregion

-- ##### ┬─┐┌─┐┌─┐┌─┐┬ ┬  ┬┌─┐ ########################################################################################
-- ##### ├┬┘├┤ └─┐│ ││ └┐┌┘├┤  ########################################################################################
-- ##### ┴└─└─┘└─┘└─┘┴─┘└┘ └─┘ ########################################################################################

--#region Resolve issues
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
				local mod_add_custom_attachments = mod.add_custom_attachments
				-- Iterate through attachment settings
				for _, attachment_slot in pairs(possible_attachment_slots) do
					-- Custom attachments
					if not mod_add_custom_attachments[attachment_slot] then
						self:_resolve_auto_equips(gear_id_or_item, attachment_slot)
					end
				end
				-- Iterate through attachment settings
				for _, attachment_slot in pairs(possible_attachment_slots) do
					-- Non-Custom attachments
					if mod_add_custom_attachments[attachment_slot] then
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
		local item_name = item and item.name
		-- Check item
		if item_name and self:is_weapon_item(gear_id_or_item) then
			-- Get item name
			item_name = self:short_name(item_name)
			-- Get attachment
			local attachment = self:get(gear_id_or_item, attachment_slot)
			local item_attachments = mod.attachment_models[item_name]
			if item_attachments and item_attachments[attachment] then
				local attachment_data = item_attachments[attachment]
				if attachment_data then
					local automatic_equip = attachment_data.automatic_equip
					local fixes = self:apply_fixes(gear_id_or_item, attachment_slot)
					automatic_equip = fixes and fixes.automatic_equip or automatic_equip
					if automatic_equip then
						for auto_type, auto_attachment in pairs(automatic_equip) do
							local parameters = self:cached_split(auto_attachment, "|")
							if #parameters == 2 then
								local negative = self:cached_find(parameters[1], "!")
								parameters[1] = negative and self:cached_gsub(parameters[1], "!", "") or parameters[1]
								local attachment_name = self:get(gear_id_or_item, auto_type)
								if attachment_name then
									if negative and attachment_name ~= parameters[1] then
										self:_set(gear_id_or_item, auto_type, parameters[2])
									elseif attachment_name == parameters[1] then
										self:_set(gear_id_or_item, auto_type, parameters[2])
									end
								end
							else
								self:_set(gear_id_or_item, auto_type, parameters[1])
							end
						end
					end
				end
			end
		end
	end

	-- Resolve special changes
	-- local resolved_attachments = {}
	GearSettings.resolve_special_changes = function(self, gear_id_or_item, attachment_slot)
		-- table_clear(resolved_attachments)
		if attachment_slot then
			self:_resolve_special_changes(gear_id_or_item, self:get(gear_id_or_item, attachment_slot))
		else
			-- Get attachment slots
			local possible_attachment_slots = self:possible_attachment_slots(gear_id_or_item, true)
			-- Check attachments
			if possible_attachment_slots then
				local mod_add_custom_attachments = mod.add_custom_attachments
				-- Iterate through attachment settings
				for _, attachment_slot in pairs(possible_attachment_slots) do
					-- Custom attachments
					if mod_add_custom_attachments[attachment_slot] then
						self:_resolve_special_changes(gear_id_or_item, self:get(gear_id_or_item, attachment_slot))
					end
				end
				-- Iterate through attachment settings
				for _, attachment_slot in pairs(possible_attachment_slots) do
					-- Non-Custom attachments
					if not mod_add_custom_attachments[attachment_slot] then
						self:_resolve_special_changes(gear_id_or_item, self:get(gear_id_or_item, attachment_slot))
					end
				end
			end
		end
	end

	-- Resolve special changes
	GearSettings._resolve_special_changes = function(self, gear_id_or_item, attachment)
		-- Get item from potential gear id
		local item = self:item_from_gear_id(gear_id_or_item)
		local item_name = item and item.name
		-- Check item
		if item_name and self:is_weapon_item(gear_id_or_item) then
			-- Get item name
			item_name = self:short_name(item_name)
			-- Get gear id from potential item
			local gear_id = self:item_to_gear_id(item)
			-- Get attachment data
			local item_models = mod.attachment_models[item_name]
			local attachment_data = item_models and item_models[attachment]
			-- Check special resolve
			if attachment_data and attachment_data.special_resolve then
				-- Execute special resolve function
				local special_changes = attachment_data.special_resolve(gear_id, item, attachment)
				-- Check special changes
				if special_changes then
					-- Iterate special changes
					for special_slot, special_attachment in pairs(special_changes) do
						-- Resolve multiple attachments
						local special_attachment = special_attachment
						-- if string_find(special_attachment, "|") then
						if self:cached_find(special_attachment, "|") then
							local possibilities = self:cached_split(special_attachment, "|")
							local rnd = math.random(#possibilities)
							special_attachment = possibilities[rnd]
						end
						-- Set special attachment
						self:_set(gear_id_or_item, special_slot, special_attachment)
					end
				end
			end
		end
	end
--#endregion

-- ##### ┌─┐┌─┐┌┬┐┌┬┐┬┌┐┌┌─┐┌─┐  ┌─┐┌─┐┌─┐┬ ┬┌─┐ ######################################################################
-- ##### └─┐├┤  │  │ │││││ ┬└─┐  │  ├─┤│  ├─┤├┤  ######################################################################
-- ##### └─┘└─┘ ┴  ┴ ┴┘└┘└─┘└─┘  └─┘┴ ┴└─┘┴ ┴└─┘ ######################################################################

--#region Settings Cache
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
--#endregion

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

-- ##### ┌┬┐┌─┐┌┬┐┌─┐  ┌─┐┌─┐┌┬┐┌┬┐┬┌┐┌┌─┐┌─┐ #########################################################################
-- #####  │ ├┤ │││├─┘  └─┐├┤  │  │ │││││ ┬└─┐ #########################################################################
-- #####  ┴ └─┘┴ ┴┴    └─┘└─┘ ┴  ┴ ┴┘└┘└─┘└─┘ #########################################################################

--#region Temp Settings
	-- Copy temp settings
	GearSettings.copy_temp_settings = function(self, gear_id_or_item, other_gear_id_or_item)
		if self:has_temp_settings(other_gear_id_or_item) then
			self:create_temp_settings(gear_id_or_item, self:pull(other_gear_id_or_item))
		end
	end

	-- Create temp settings
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

	-- Check if temp settings exist
	GearSettings.has_temp_settings = function(self, gear_id_or_item)
		-- Get gear id from potential item
		local gear_id = self:item_to_gear_id(gear_id_or_item)
		-- Check if temp settings exist
		return gear_id and mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] ~= nil
	end

	-- Destroy temp settings
	GearSettings.destroy_temp_settings = function(self, gear_id_or_item)
		-- Get gear id from potential item
		local gear_id = self:item_to_gear_id(gear_id_or_item)
		-- Remove temp settings
		if gear_id then
			mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] = nil
		end
	end

	-- Destroy all temp settings
	GearSettings.destroy_all_temp_settings = function(self)
		table_clear(mod:persistent_table(REFERENCE).temp_gear_settings)
	end
--#endregion

-- ##### ┌─┐┌─┐┌┬┐┌┬┐┬┌┐┌┌─┐┌─┐ #######################################################################################
-- ##### └─┐├┤  │  │ │││││ ┬└─┐ #######################################################################################
-- ##### └─┘└─┘ ┴  ┴ ┴┘└┘└─┘└─┘ #######################################################################################

--#region Settings
	-- Correct attachment
	GearSettings.correct = function(self, gear_id_or_item, attachment_slot, attachment_name)
		-- Check if attachment name is nil contains default
		-- if not attachment_name or (attachment_name and string_find(attachment_name, DEFAULT)) or attachment_name == DEFAULT then
		-- local cache = mod:persistent_table(REFERENCE).cache
		-- cache.contains_default = cache.contains_default or {}
		-- local contains_default = cache and cache.contains_default
		-- if attachment_name and not contains_default[attachment_name] then
		-- 	contains_default[attachment_name] = attachment_name == DEFAULT or self:cached_find(attachment_name, DEFAULT) or false
		-- 	-- if contains_default[attachment_name] == nil then contains_default[attachment_name] = false end
		-- 	-- if not contains_default[attachment_name] then contains_default[attachment_name] = false end
		-- end
		if attachment_name and not mod:persistent_table(REFERENCE).cache.contains_default[attachment_name] then
			mod:persistent_table(REFERENCE).cache.contains_default[attachment_name] = self:cached_find(attachment_name, DEFAULT) or false
		end
		if not attachment_name or (attachment_name == DEFAULT or mod:persistent_table(REFERENCE).cache.contains_default[attachment_name]) then
		-- if not attachment_name or (attachment_name and contains_default[attachment_name]) then --or attachment_name == DEFAULT then
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
		local temp_gear_settings = mod:persistent_table(REFERENCE).temp_gear_settings
		-- Check if temp settings exist
		if temp_gear_settings[gear_id] then
			-- Set temp attachment
			attachment_name = temp_gear_settings[gear_id][attachment_slot] or "default"
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

		-- -- Check skin
		-- if not attachment_name then

		-- end

		-- Check mod default
		if not attachment_name then
			-- Get item from potential gear id
			local item = self:item_from_gear_id(gear_id_or_item)
			local item_name = item and item.name
			-- Check mod default
			if item_name then
				item_name = self:short_name(item_name)
				-- Set custom slot default
				local item_attachments = mod.attachment[item_name]
				local slot_attachments = item_attachments and item_attachments[attachment_slot]
				if slot_attachments and #slot_attachments > 0 then
					attachment_name = slot_attachments[1].id
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
	-- Set single attachment in settings
	GearSettings._set = function(self, gear_id_or_item, attachment_slot, attachment_name)
		-- Get gear id from potential item
		local gear_id = self:item_to_gear_id(gear_id_or_item)
		-- Correct setting
		attachment_name = self:correct(gear_id_or_item, attachment_slot, attachment_name)

		-- if mod.weapon_skin_override then
		-- 	self:skin_attachment(gear_id_or_item, attachment_slot)
		-- end

		-- Check if temp settings exist
		local temp_gear_settings = mod:persistent_table(REFERENCE).temp_gear_settings
		if temp_gear_settings[gear_id] then
			-- Set attachment in temp settings
			temp_gear_settings[gear_id][attachment_slot] = attachment_name
		else
			-- Get entry
			local gear_settings = self:load(gear_id_or_item)
			-- Check settings
			if gear_settings then
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
		local temp_gear_settings = mod:persistent_table(REFERENCE).temp_gear_settings
		if gear_id and temp_gear_settings[gear_id] then
			-- Set attachment in temp settings
			temp_gear_settings[gear_id] = attachments
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

	-- Pull all attachments from settings
	GearSettings.pull = function(self, gear_id_or_item)
		-- Get gear id from potential item
		local gear_id = self:item_to_gear_id(gear_id_or_item)
		-- Check if temp settings exist
		local temp_gear_settings = mod:persistent_table(REFERENCE).temp_gear_settings
		if gear_id and temp_gear_settings[gear_id] then
			-- Set attachment in temp settings
			return temp_gear_settings[gear_id]
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
--#endregion

return GearSettings