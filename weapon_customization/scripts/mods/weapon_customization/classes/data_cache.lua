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

--#region local functions
	local type = type
	local pairs = pairs
	local class = class
	local table = table
	local string = string
	local unpack = unpack
	local get_mod = get_mod
	local tostring = tostring
	local table_size = table.size
	local string_cap = string.cap
	local vector3_box = Vector3Box
	local string_trim = string._trim
	local table_clone = table.clone
	local table_clear = table.clear
	local string_find = string.find
	local string_gsub = string.gsub
	local string_split = string.split
	local string_upper = string.upper
	local table_contains = table.contains
	local table_clone_instance = table.clone_instance
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local REFERENCE = "weapon_customization"
	local DEBUG = false
	local PERSISTENT_TABLE = mod:persistent_table(REFERENCE)
	local string_split_cache = PERSISTENT_TABLE.cache.string_split
	local debug_split_cache = PERSISTENT_TABLE.debug_split
	local string_gsub_cache = PERSISTENT_TABLE.cache.string_gsub
	local debug_gsub_cache = PERSISTENT_TABLE.debug_gsub
	local string_find_cache = PERSISTENT_TABLE.cache.string_find
	local debug_find_cache = PERSISTENT_TABLE.debug_find
	local string_trim_cache = PERSISTENT_TABLE.cache.string_trim
	local debug_trim_cache = PERSISTENT_TABLE.debug_trim
	local string_cap_cache = PERSISTENT_TABLE.cache.string_cap
	local debug_cap_cache = PERSISTENT_TABLE.debug_cap
	local cached_data = PERSISTENT_TABLE.cache.cached_data
	local melee_string = "content/items/weapons/player/melee/"
	local ranged_string = "content/items/weapons/player/ranged/"
	local ogryn_slabshield_item = "content/items/weapons/player/melee/ogryn_slabshield_p1_m1"
	local bulwark_shield_string = "content/items/weapons/player/melee/ogryn_bulwark_shield_01"
	local bulwark_shield_unit = "content/weapons/enemy/shields/bulwark_shield_01/bulwark_shield_01"
	local replace_pattern = {'_p1', '_p2', '_p3', '_m1', '_m2', '_m3', '_ml01'}
--#endregion
   
-- ##### ┌─┐┌─┐┌─┐┬─┐  ┌─┐┌┬┐┌┬┐┌─┐┌─┐┬ ┬  ┌─┐┌─┐┬┌┐┌┌┬┐┌─┐ ###########################################################
-- ##### │ ┬├┤ ├─┤├┬┘  ├─┤ │  │ ├─┤│  ├─┤  ├─┘│ │││││ │ └─┐ ###########################################################
-- ##### └─┘└─┘┴ ┴┴└─  ┴ ┴ ┴  ┴ ┴ ┴└─┘┴ ┴  ┴  └─┘┴┘└┘ ┴ └─┘ ###########################################################

mod.gear_attach_points = {
	ogryn = {
		{node = "j_hips",		offset = vector3_box(-.5, .55, -.5),	text = "Hips Front",		name = "hips_front"},
		{node = "j_hips",		offset = vector3_box(-.2, -.4, .1),	text = "Hips Back",			name = "hips_back"},
		{node = "j_hips",		offset = vector3_box(-.5, -.1, -.4),	text = "Hips Left",			name = "hips_left"},
		{node = "j_hips",		offset = vector3_box(.5, -.1, -.4),	text = "Hips Right",		name = "hips_right"},
		{node = "j_leftupleg",	offset = vector3_box(.5, -.2, 0),	text = "Left Leg",			name = "leg_left"},
		{node = "j_rightupleg",	offset = vector3_box(-.5, .2, 0),		text = "Right Leg",			name = "leg_right"},
		{node = "j_spine2",		offset = vector3_box(-.5, -.5, .5),	text = "Chest",				name = "chest"},
		{node = "j_spine2",		offset = vector3_box(-.4, .5, -.3),	text = "Backpack Left",		name = "backpack_left"},
		{node = "j_spine2",		offset = vector3_box(-.4, .5, .3),	text = "Backpack Right",	name = "backpack_right"},
		{node = "j_spine2",		offset = vector3_box(-.3, .5, -.4),	text = "Back Left",			name = "back_left"},
		{node = "j_spine2",		offset = vector3_box(-.3, .5, .4),	text = "Back Right",		name = "back_right"},
	},
	human = {
		{node = "j_hips",			 offset = vector3_box(0, .2, .1),	text = "Hips Front",		name = "hips_front"},
		{node = "j_hips",			 offset = vector3_box(0, -.15, .1), text = "Hips Back",			name = "hips_back"},
		{node = "j_hips",			 offset = vector3_box(-.15, 0, .1), text = "Hips Left",			name = "hips_left"},
		{node = "j_hips",			 offset = vector3_box(.15, 0, .1),	text = "Hips Right",		name = "hips_right"},
		{node = "j_leftupleg",		 offset = vector3_box(0, 0, 0),		text = "Left Leg",			name = "leg_left"},
		{node = "j_rightupleg",		 offset = vector3_box(0, 0, 0),		text = "Right Leg",			name = "leg_right"},
		{node = "j_frontchestplate", offset = vector3_box(0, 0, 0),		text = "Chest",				name = "chest"},
		{node = "j_backchestplate",	 offset = vector3_box(0, 0, -.15),	text = "Backpack Left",		name = "backpack_left"},
		{node = "j_backchestplate",	 offset = vector3_box(0, 0, .15),	text = "Backpack Right",	name = "backpack_right"},
		{node = "j_backchestplate",	 offset = vector3_box(0, 0, -.15),	text = "Back Left",			name = "back_left"},
		{node = "j_backchestplate",	 offset = vector3_box(0, 0, .15),	text = "Back Right",		name = "back_right"},
	},
}

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local DataCache = class("DataCache")

-- ##### ┌─┐┬  ┌─┐┌┐ ┌─┐┬   ###########################################################################################
-- ##### │ ┬│  │ │├┴┐├─┤│   ###########################################################################################
-- ##### └─┘┴─┘└─┘└─┘┴ ┴┴─┘ ###########################################################################################

-- Check if master items can be retrieved
-- Returns: boolean
mod.check_master_items = function(self)
	-- Try to get master items
	-- Skip when already checked successfully
	if not self.master_items_available then
		self.temp_master_items = MasterItems.get_cached()
		self.master_items_available = not not self.temp_master_items
	end
	-- Check result
	if self.temp_master_items then
		return true
	end
end

local math = math
local math_max = math.max
mod.table_sub_counts = function(self, t)
	local count = 0
	for k, v in pairs(t) do
		if type(v) == "table" then
			count = count + math_max(table_size(v), #v)
		else
			count = count + 1
		end
	end
	return count
end

mod.check_cache_difference = function(self)
	if self.data_cache and self.anchors then
		local diff = self:table_sub_counts(self.attachment) + self:table_sub_counts(self.attachment_slots) + self:table_sub_counts(self.anchors)
		local current_diff = self.data_cache.cache.diff
		if current_diff and diff and current_diff ~= diff then
			mod:echo("Cache difference current: "..tostring(current_diff).." new: "..tostring(diff).." dif: "..tostring(diff - current_diff))
			return true
		end
	end
end

-- Try to initialize the cache
-- Returns: boolean
mod.try_init_cache = function(self)
	-- Check if all mods are loaded and cache not loaded
	if self.all_mods_loaded and not self.data_cache then
		-- Check master items
		if self:check_master_items() then
			-- Init cache
			self.data_cache = DataCache:new()
			-- Return
			return true
		end
	elseif self.all_mods_loaded and self.data_cache and self:check_cache_difference() then
		self:echo("Reloading Weapon Customization Cache")
		-- Destroy cache
		self.data_cache:destroy()
		-- Set cache not initialized
		PERSISTENT_TABLE.cache.initialized = false
		-- Init cache
		self.data_cache = DataCache:new()
		-- Return
		return true
	end
end

-- Reload the cache
-- Skip if not in debug mode
-- Returns: boolean
mod.reload_cache = function(self)
	-- Skip when not in debug
	if (DEBUG) then
		self:echo("Reloading Weapon Customization Cache")
		-- Destroy cache
		self.data_cache:destroy()
		-- Set cache not initialized
		PERSISTENT_TABLE.cache.initialized = false
		-- Return
		return true
	end
end

-- Get the list of cosmetics scenegraphs
-- Returns: table
mod.get_cosmetics_scenegraphs = function(self)
	-- Try to get cached
	local cache = PERSISTENT_TABLE.cache
	-- Generate if not cached
	if not cache or not cache.cosmetics_scenegraphs then
		-- Create table
		local cosmetics_scenegraphs = {}
		-- Get attachment slots
		local all_attachment_slots = self.attachment_slots
		-- Iterate attachment slots
		for i = 1, #all_attachment_slots, 1 do
			-- Get attachment slot
			local attachment_slot = all_attachment_slots[i]
			-- Add to list
			cosmetics_scenegraphs[#cosmetics_scenegraphs+1] = attachment_slot.."_text_pivot"
			cosmetics_scenegraphs[#cosmetics_scenegraphs+1] = attachment_slot.."_pivot"
		end
		-- Cache generated list
		cache.cosmetics_scenegraphs = cosmetics_scenegraphs
	end
	-- Return cached list
	return cache.cosmetics_scenegraphs
end

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

-- Initialize the cache
DataCache.init = function(self)
	-- Get item definitions
	self.item_definitions = self:setup_item_definitions()
	-- Set cache
	self.cache = PERSISTENT_TABLE.cache
	-- Cache attachment data
	self:cache_attachment_data()
	-- Set initialized
	self.initialized = true
end

-- Destroy the cache
DataCache.destroy = function(self)
	-- Set not initialized
	self.initialized = false
end

-- Setup item definitions
-- Returns: table
DataCache.setup_item_definitions = function(self)
	-- Try to get cached
	-- Generate if not cached
	if PERSISTENT_TABLE.item_definitions == nil then
		-- Try to get master items
		local master_items = mod.temp_master_items or MasterItems.get_cached()
		-- Check if master items are valid
		if master_items then
			-- Clone master items
			PERSISTENT_TABLE.item_definitions = table_clone_instance(master_items)
			-- Get definitions
			local definitions = PERSISTENT_TABLE.item_definitions
			-- Add bulwark shield
			if not definitions[bulwark_shield_string] then
				-- Clone default slab shield entry
				definitions[bulwark_shield_string] = table_clone(definitions[ogryn_slabshield_item])
				-- Get bulwark shield definition
				local bulwark_shield_item_entry = definitions[bulwark_shield_string]
				-- Change values
				bulwark_shield_item_entry.name = bulwark_shield_string
				bulwark_shield_item_entry.base_unit = bulwark_shield_unit
				bulwark_shield_item_entry.resource_dependencies = {
					[bulwark_shield_unit] = true,
				}
			end
			master_items = nil
		end
	end
	-- Return cached
	return PERSISTENT_TABLE.item_definitions
end

-- Cache attachment data
-- Returns: nil
DataCache.cache_attachment_data = function(self, update)
	local cache = self.cache
	if not cache.initialized then
		local mod_attachments = mod.attachment
		local mod_attachment_slots = mod.attachment_slots
		local mod_anchors = mod.anchors
		cache.diff = mod:table_sub_counts(mod_attachments) + mod:table_sub_counts(mod_attachment_slots) + mod:table_sub_counts(mod_anchors)
		local gear_settings = mod.gear_settings
		local cache_item_names = cache.item_names
		local cache_item_strings = cache.item_strings
		local cache_num_fixes = cache.num_fixes
		local cache_attachment_slots = cache.attachment_slots
		local cache_num_attachment_slots = cache.num_attachment_slots
		local cache_attachment_list = cache.attachment_list
		local cache_default_attachments = cache.default_attachments
		local cache_cosmetics_scenegraphs = cache.cosmetics_scenegraphs
		local item_definitions = self.item_definitions
		for item_name, _ in pairs(mod_attachments) do
			-- Strings
			local melee = melee_string..item_name
			local ranged = ranged_string..item_name
			-- Get master item string
			-- Check melee / ranged
			local item_string = item_definitions[melee] and melee
				or item_definitions[ranged] and ranged
			-- Get master item
			local item = item_definitions[item_string]
			-- Check item
			if item then
				-- Cache full item string -> item name
				cache_item_names[item_string] = item_name
				-- Cache item name -> full item string
				cache_item_strings[item_name] = item_string
				-- Cache item name -> num fixes
				local item_anchors = mod_anchors[item_name]
				cache_num_fixes[item_name] = item_anchors and item_anchors.fixes and #item_anchors.fixes
				-- Cache item name -> attachment slots
				cache_attachment_slots[item_name] = gear_settings:possible_attachment_slots(item)
				local item_slots = cache_attachment_slots[item_name]
				cache_num_attachment_slots[item_name] = item_slots and #item_slots
				cache_attachment_list[item_name] = {}
				-- local attachment_list = cache_attachment_list
				if item_slots then
					for j = 1, #item_slots, 1 do
						local attachment_slot = item_slots[j]
						-- Cache item name -> possible attachments by slot
						local list = gear_settings:possible_attachments(item, attachment_slot)
						if list and #list > 0 then cache_attachment_list[item_name][attachment_slot] = list end
					end
				end
				-- Cache item name -> default attachment
				cache_default_attachments[item_name] = {}
				if item_slots then
					for j = 1, #item_slots, 1 do
						local attachment_slot = item_slots[j]
						-- Cache item name -> default attachment by slot
						cache_default_attachments[item_name][attachment_slot] = gear_settings:default_attachment(item, attachment_slot)
					end
				end
			end
		end
		-- Cache cosmetics scenegraphs
		for i = 1, #mod_attachment_slots, 1 do
			local attachment_slot = mod_attachment_slots[i]
			if not table_contains(cache_cosmetics_scenegraphs, attachment_slot.."_text_pivot") then
				cache_cosmetics_scenegraphs[#cache_cosmetics_scenegraphs+1] = attachment_slot.."_text_pivot"
			end
			if not table_contains(cache_cosmetics_scenegraphs, attachment_slot.."_pivot") then
				cache_cosmetics_scenegraphs[#cache_cosmetics_scenegraphs+1] = attachment_slot.."_pivot"
			end
		end
		-- Cache initialized
		cache.initialized = true
		-- Debug
		self:debug_dump()
	end
end

-- ##### ┬┌┐┌┌┬┐┌─┐┬─┐┌─┐┌─┐┌─┐┌─┐ ####################################################################################
-- ##### ││││ │ ├┤ ├┬┘├┤ ├─┤│  ├┤  ####################################################################################
-- ##### ┴┘└┘ ┴ └─┘┴└─└  ┴ ┴└─┘└─┘ ####################################################################################

-- Get cached cosmetics scenegraphs
-- Returns: table
DataCache.cosmetics_scenegraphs = function(self)
	return self.cache.cosmetics_scenegraphs
end

-- Get number of fixes by item name
-- Returns: number
DataCache.item_name_to_num_fixes = function(self, item_name)
	return self.cache.num_fixes[item_name]
end

-- Get default attachment by item name and attachment slot
-- Returns: string
DataCache.item_name_to_default_attachment = function(self, item_name, attachment_slot)
	local item_cache = self.cache.default_attachments[item_name]
	return item_cache and item_cache[attachment_slot]
end

-- Get possible attachments by item name and attachment slot
-- Returns: table
DataCache.item_name_to_attachment_list = function(self, item_name, attachment_slot_or_nil)
	local item_cache = self.cache.attachment_list[item_name]
	if attachment_slot_or_nil then
		return item_cache and item_cache[attachment_slot_or_nil]
	else
		return item_cache and item_cache["all"]
	end
end

-- Get possible attachment slots by item name
-- Returns: table
DataCache.item_name_to_attachment_slots = function(self, item_name)
	return self.cache.attachment_slots[item_name]
end

-- Get number of attachment slots by item name
-- Returns: number
DataCache.item_name_to_num_attachment_slots = function(self, item_name)
	return self.cache.num_attachment_slots[item_name]
end

-- Get item string by item name
-- Returns: string
DataCache.item_name_to_item_string = function(self, item_name)
	return self.cache.item_strings[item_name]
end

-- Get item name by item string
-- Returns: string
DataCache.item_string_to_item_name = function(self, item_string)
	return self.cache.item_names[item_string]
end

-- ##### ┌─┐┌┬┐┬─┐┬┌┐┌┌─┐  ┌┬┐┌─┐┌┬┐┌─┐┬┌─┐┌─┐┌┬┐┬┌─┐┌┐┌ ##############################################################
-- ##### └─┐ │ ├┬┘│││││ ┬  │││├┤ ││││ ││┌─┘├─┤ │ ││ ││││ ##############################################################
-- ##### └─┘ ┴ ┴└─┴┘└┘└─┘  ┴ ┴└─┘┴ ┴└─┘┴└─┘┴ ┴ ┴ ┴└─┘┘└┘ ##############################################################

-- Watch string cache
-- Returns: nil
mod.watch_string_cache = function(self)
	if self.modding_tools then
		local watcher = self.modding_tools.watcher
		watcher:watch("String splits executed", debug_split_cache, "split")
		watcher:watch("String split cache used", debug_split_cache, "cache")
		watcher:watch("String gsubs executed", debug_gsub_cache, "gsub")
		watcher:watch("String gsub cache used", debug_gsub_cache, "cache")
		watcher:watch("String finds executed", debug_find_cache, "find")
		watcher:watch("String find cache used", debug_find_cache, "cache")
		watcher:watch("String trims executed", debug_trim_cache, "trim")
		watcher:watch("String trim cache used", debug_trim_cache, "cache")
		watcher:watch("String caps executed", debug_cap_cache, "cap")
		watcher:watch("String cap cache used", debug_cap_cache, "cache")
		self.modding_tools:inspect("Cache", PERSISTENT_TABLE.cache)
	end
end

-- Cached string split
-- Returns: table
mod.cached_split = function(self, str, sep, ...)
	local key = str..(sep or "")
	if not string_split_cache[key] then
		string_split_cache[key] = {string_split(str, sep, ...)}
		debug_split_cache.split = debug_split_cache.split + 1
	else
		debug_split_cache.cache = debug_split_cache.cache + 1
	end
	return unpack(string_split_cache[key])
end

-- Cached string gsub
-- Returns: string
mod.cached_gsub = function(self, str, pattern, repl, ...)
	local key = str..(tostring(pattern) or "")..(tostring(repl) or "")
	if not string_gsub_cache[key] then
		string_gsub_cache[key] = {string_gsub(str, pattern, repl, ...)}
		debug_gsub_cache.gsub = debug_gsub_cache.gsub + 1
	else
		debug_gsub_cache.cache = debug_gsub_cache.cache + 1
	end
	return unpack(string_gsub_cache[key])
end

-- Cached string find
-- Returns: number
mod.cached_find = function(self, str, pattern, start, ...)
	local key = str..(pattern or "")..(start or "")
	if not string_find_cache[key] then
		string_find_cache[key] = {string_find(str, pattern, start, ...)}
		debug_find_cache.find = debug_find_cache.find + 1
	else
		debug_find_cache.cache = debug_find_cache.cache + 1
	end
	return unpack(string_find_cache[key])
end

-- Cached string trim
-- Returns: string
mod.cached_trim = function(self, str, ...)
	if not string_trim_cache[str] then
		string_trim_cache[str] = {string_trim(str, ...)}
		debug_trim_cache.trim = debug_trim_cache.trim + 1
	else
		debug_trim_cache.cache = debug_trim_cache.cache + 1
	end
	return unpack(string_trim_cache[str])
end

-- Cached string cap
-- Returns: string
mod.cached_cap = function(self, str, ...)
	if not string_cap_cache[str] then
		string_cap_cache[str] = {string_cap(str, ...)}
		debug_cap_cache.cap = debug_cap_cache.cap + 1
	else
		debug_cap_cache.cache = debug_cap_cache.cache + 1
	end
	return unpack(string_cap_cache[str])
end

-- Cached data
-- Returns: various
mod.cached_data = function(self, str, data)
	if not cached_data[str] then
		cached_data[str] = {data}
	end
	return unpack(cached_data[str])
end

-- ##### ┌┬┐┌─┐┌┐ ┬ ┬┌─┐ ##############################################################################################
-- #####  ││├┤ ├┴┐│ ││ ┬ ##############################################################################################
-- ##### ─┴┘└─┘└─┘└─┘└─┘ ##############################################################################################

-- Debug dump cache
DataCache.debug_dump = function(self)
	if DEBUG then
		mod:dtf(self.cache, "self.cache", 10)
	else
		local modding_tools = get_mod("modding_tools")
		if modding_tools then
			modding_tools:console_print("DataCache", self.cache)
		end
	end
end

return DataCache