local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
	local MasterItems = mod:original_require("scripts/backend/master_items")
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	-- string.find_hooked = true
	-- string.gsub_hooked = true
	-- string.split_hooked = true
	-- string.trim_hooked = true
	-- string.cap_hooked = true
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
	local string_cap = string.cap
	local vector3_box = Vector3Box
	local string_trim = string._trim
	local table_clone = table.clone
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
	local persistent_table = mod:persistent_table(REFERENCE)
	local string_split_cache = persistent_table.cache.string_split
	local debug_split_cache = persistent_table.debug_split
	local string_gsub_cache = persistent_table.cache.string_gsub
	local debug_gsub_cache = persistent_table.debug_gsub
	local string_find_cache = persistent_table.cache.string_find
	local debug_find_cache = persistent_table.debug_find
	local string_trim_cache = persistent_table.cache.string_trim
	local debug_trim_cache = persistent_table.debug_trim
	local string_cap_cache = persistent_table.cache.string_cap
	local debug_cap_cache = persistent_table.debug_cap
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

mod.check_master_items = function(self)
	if self.master_items_available then return true end
	self.temp_master_items = MasterItems.get_cached()
	if self.temp_master_items then self.master_items_available = true end
end

mod.try_init_cache = function(self)
	if self.all_mods_loaded and not self.data_cache then
		if self:check_master_items() then
			self.data_cache = DataCache:new()
		end
	end
end

mod.reload_cache = function(self)
	if (DEBUG) then
		mod:echo("Reloading Weapon Customization Cache")
		self:persistent_table(REFERENCE).cache.initialized = false
		self.data_cache:destroy()
	end
end

mod.get_cosmetics_scenegraphs = function(self)
	local cache = mod:persistent_table(REFERENCE).cache
	if not cache or not cache.cosmetics_scenegraphs then
		local cosmetics_scenegraphs = {}
		local mod_attachment_slots = mod.attachment_slots
		for i = 1, #mod_attachment_slots, 1 do
			local attachment_slot = mod_attachment_slots[i]
			cosmetics_scenegraphs[#cosmetics_scenegraphs+1] = attachment_slot.."_text_pivot"
			cosmetics_scenegraphs[#cosmetics_scenegraphs+1] = attachment_slot.."_pivot"
		end
		return cosmetics_scenegraphs
	end
	return cache.cosmetics_scenegraphs
end

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

DataCache.init = function(self)
	self.item_definitions = self:setup_item_definitions()
	self.cache = mod:persistent_table(REFERENCE).cache
	self:cache_attachment_data()
	self.initialized = true
end

DataCache.destroy = function(self)
	self.initialized = false
end

DataCache.setup_item_definitions = function(self)
	local persistent_table = mod:persistent_table(REFERENCE)
	if persistent_table.item_definitions == nil then
		local master_items = mod.temp_master_items or MasterItems.get_cached()
		if master_items then
			persistent_table.item_definitions = table_clone_instance(master_items)
			-- Bulwark shield
			local definitions = persistent_table.item_definitions
			if not definitions[bulwark_shield_string] then
				definitions[bulwark_shield_string] = table_clone(definitions[ogryn_slabshield_item])
				local bulwark_shield_item_entry = definitions[bulwark_shield_string]
				bulwark_shield_item_entry.name = bulwark_shield_string
				bulwark_shield_item_entry.base_unit = bulwark_shield_unit
				bulwark_shield_item_entry.resource_dependencies = {
					[bulwark_shield_unit] = true,
				}
			end
			master_items = nil
		end
	end
	return persistent_table.item_definitions
end

DataCache.cache_attachment_data = function(self)
	if not self.cache.initialized then
		local mod_attachments = mod.attachment
		local mod_attachment_slots = mod.attachment_slots
		local mod_anchors = mod.anchors
		local gear_settings = mod.gear_settings
		for item_name, _ in pairs(mod_attachments) do
			-- Strings
			local melee = "content/items/weapons/player/melee/"..item_name
			local ranged = "content/items/weapons/player/ranged/"..item_name
			-- local npc = "content/items/weapons/npc/"..item_name
			-- local minion_melee = "content/items/weapons/minions/melee/"..item_name
			-- local minion_ranged = "content/items/weapons/minions/ranged/"..item_name
			-- Get master item string
			-- local item_definitions = self.item_definitions
			local item_string = self.item_definitions[melee] and melee
				or self.item_definitions[ranged] and ranged
				-- or item_definitions[npc] and npc
				-- or item_definitions[minion_melee] and minion_melee
				-- or item_definitions[minion_ranged] and minion_ranged
			-- Get master item
			local item = self.item_definitions[item_string]
			-- Check item
			if item then
				-- Cache full item string -> item name
				self.cache.item_names[item_string] = item_name
				-- Cache item name -> full item string
				self.cache.item_strings[item_name] = item_string
				-- Cache item name -> num fixes
				local item_anchors = mod.anchors[item_name]
				self.cache.num_fixes[item_name] = item_anchors and item_anchors.fixes and #item_anchors.fixes
				-- Cache item name -> attachment slots
				self.cache.attachment_slots[item_name] = gear_settings:possible_attachment_slots(item)
				local item_slots = self.cache.attachment_slots[item_name]
				self.cache.num_attachment_slots[item_name] = item_slots and #item_slots
				self.cache.attachment_list[item_name] = {}
				-- local attachment_list = self.cache.attachment_list
				if item_slots then
					for j = 1, #item_slots, 1 do
						local attachment_slot = item_slots[j]
						-- Cache item name -> possible attachments by slot
						local list = gear_settings:possible_attachments(item, attachment_slot)
						if list and #list > 0 then self.cache.attachment_list[item_name][attachment_slot] = list end
					end
				end
				-- Cache item name -> default attachment
				self.cache.default_attachments[item_name] = {}
				if item_slots then
					for j = 1, #item_slots, 1 do
						local attachment_slot = item_slots[j]
						-- Cache item name -> default attachment by slot
						self.cache.default_attachments[item_name][attachment_slot] = gear_settings:default_attachment(item, attachment_slot)
					end
				end

				-- for attachment_slot, attachment_list in pairs(self.cache.attachment_list[item_name]) do
					
				-- 	-- Cache attachment name -> original item
				-- 	-- local weapon_name = string.gsub(item_name, '%S+', {_p1='', _p2='', _p3='', _m1='', _m2='', _m3='', _ml01=''})
				-- 	local weapon_name = item_name
				-- 	for j, rep_pattern in pairs(replace_pattern) do
				-- 		weapon_name = string.gsub(weapon_name, rep_pattern, '')
				-- 	end

				-- 	-- self.cache.pattern_to_item = self.cache.pattern_to_item or {}
				-- 	self.cache.pattern_to_item[item_name] = weapon_name

				-- 	for j, attachment_name in pairs(attachment_list) do
				-- 		self.cache.original_items[#self.cache.original_items+1] = {
				-- 			attachment_name,
				-- 			weapon_name,
				-- 		}
				-- 	end
				-- 	-- Cache attachment name -> original pattern
				-- 	for j, attachment_name in pairs(attachment_list) do
				-- 		self.cache.original_patterns[#self.cache.original_patterns+1] = {
				-- 			attachment_name,
				-- 			item_name,
				-- 		}
				-- 	end

				-- end
			end
		end
		-- Cache cosmetics scenegraphs
		for i = 1, #mod_attachment_slots, 1 do
			local attachment_slot = mod_attachment_slots[i]
			if not table_contains(self.cache.cosmetics_scenegraphs, attachment_slot.."_text_pivot") then
				self.cache.cosmetics_scenegraphs[#self.cache.cosmetics_scenegraphs+1] = attachment_slot.."_text_pivot"
			end
			if not table_contains(self.cache.cosmetics_scenegraphs, attachment_slot.."_pivot") then
				self.cache.cosmetics_scenegraphs[#self.cache.cosmetics_scenegraphs+1] = attachment_slot.."_pivot"
			end
		end
		-- Cache initialized
		self.cache.initialized = true
		-- Debug
		self:debug_dump()
	end
end

-- ##### ┬┌┐┌┌┬┐┌─┐┬─┐┌─┐┌─┐┌─┐┌─┐ ####################################################################################
-- ##### ││││ │ ├┤ ├┬┘├┤ ├─┤│  ├┤  ####################################################################################
-- ##### ┴┘└┘ ┴ └─┘┴└─└  ┴ ┴└─┘└─┘ ####################################################################################

DataCache.cosmetics_scenegraphs = function(self)
	return self.cache.cosmetics_scenegraphs
end

DataCache.item_name_to_num_fixes = function(self, item_name)
	return self.cache.num_fixes[item_name]
end

DataCache.item_name_to_default_attachment = function(self, item_name, attachment_slot)
	local item_cache = self.cache.default_attachments[item_name]
	return item_cache and item_cache[attachment_slot]
end

DataCache.item_name_to_attachment_list = function(self, item_name, attachment_slot_or_nil)
	local item_cache = self.cache.attachment_list[item_name]
	if attachment_slot_or_nil then
		return item_cache and item_cache[attachment_slot_or_nil]
	else
		return item_cache and item_cache["all"]
	end
end

DataCache.item_name_to_attachment_slots = function(self, item_name)
	return self.cache.attachment_slots[item_name]
end

DataCache.item_name_to_num_attachment_slots = function(self, item_name)
	return self.cache.num_attachment_slots[item_name]
end

DataCache.item_name_to_item_string = function(self, item_name)
	return self.cache.item_strings[item_name]
end

DataCache.item_string_to_item_name = function(self, item_string)
	return self.cache.item_names[item_string]
end

-- DataCache.attachment_name_to_original_item = function(self, attachment_name)
-- 	return self.cache.original_items[attachment_name]
-- end

-- DataCache.attachment_name_to_original_pattern = function(self, attachment_name)
-- 	return self.cache.original_patterns[attachment_name]
-- end

-- DataCache.item_name_to_weapon_name = function(self, item_name)
-- 	return self.cache.pattern_to_item[item_name]
-- end

-- DataCache.attachment_name_to_generated_attachment_name = function(self, attachment_name)
-- 	return self.cache.attachment_names[attachment_name]
-- end

-- ##### ┌─┐┌┬┐┬─┐┬┌┐┌┌─┐  ┌┬┐┌─┐┌┬┐┌─┐┬┌─┐┌─┐┌┬┐┬┌─┐┌┐┌ ##############################################################
-- ##### └─┐ │ ├┬┘│││││ ┬  │││├┤ ││││ ││┌─┘├─┤ │ ││ ││││ ##############################################################
-- ##### └─┘ ┴ ┴└─┴┘└┘└─┘  ┴ ┴└─┘┴ ┴└─┘┴└─┘┴ ┴ ┴ ┴└─┘┘└┘ ##############################################################

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
		self.modding_tools:inspect("Cache", persistent_table.cache)
	end
end

mod.cached_split = function(self, str, sep, ...)
	local key = str..(sep or "")
	if not string_split_cache[key] then
		-- string.split_hooked = false
		string_split_cache[key] = {string_split(str, sep, ...)}
		-- string.split_hooked = true
		debug_split_cache.split = debug_split_cache.split + 1
	else
		debug_split_cache.cache = debug_split_cache.cache + 1
	end
	return unpack(string_split_cache[key])
end

mod.cached_gsub = function(self, str, pattern, repl, ...)
	local key = str..(tostring(pattern) or "")..(tostring(repl) or "")
	if not string_gsub_cache[key] then
		-- string.gsub_hooked = false
		string_gsub_cache[key] = {string_gsub(str, pattern, repl, ...)}
		-- string.gsub_hooked = true
		debug_gsub_cache.gsub = debug_gsub_cache.gsub + 1
	else
		debug_gsub_cache.cache = debug_gsub_cache.cache + 1
	end
	return unpack(string_gsub_cache[key])
end

mod.cached_find = function(self, str, pattern, start, ...)
	local key = str..(pattern or "")..(start or "")
	if not string_find_cache[key] then
		-- string.find_hooked = false
		string_find_cache[key] = {string_find(str, pattern, start, ...)} --~= nil
		-- string.find_hooked = true
		debug_find_cache.find = debug_find_cache.find + 1
	else
		debug_find_cache.cache = debug_find_cache.cache + 1
	end
	return unpack(string_find_cache[key])
end

mod.cached_trim = function(self, str, ...)
	if not string_trim_cache[str] then
		-- string.trim_hooked = false
		-- string_trim_cache[str] = string_gsub(str, "^%s*(.-)%s*$", "%1")
		string_trim_cache[str] = {string_trim(str, ...)}
		-- string.trim_hooked = true
		debug_trim_cache.trim = debug_trim_cache.trim + 1
	else
		debug_trim_cache.cache = debug_trim_cache.cache + 1
	end
	return unpack(string_trim_cache[str])
end

mod.cached_cap = function(self, str, ...)
	if not string_cap_cache[str] then
		-- string.cap_hooked = false
		-- string_cap_cache[str] = string_gsub(str, "^%l", string_upper)
		string_cap_cache[str] = {string_cap(str, ...)}
		-- string.cap_hooked = true
		debug_cap_cache.cap = debug_cap_cache.cap + 1
	else
		debug_cap_cache.cache = debug_cap_cache.cache + 1
	end
	return unpack(string_cap_cache[str])
end

-- ##### ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌┬┐  ┌─┐┬  ┌─┐┌─┐┌─┐┌─┐┌─┐ ###################################################################
-- ##### ├┤ ┌┴┬┘ │ ├┤ │││ ││  │  │  ├─┤└─┐└─┐├┤ └─┐ ###################################################################
-- ##### └─┘┴ └─ ┴ └─┘┘└┘─┴┘  └─┘┴─┘┴ ┴└─┘└─┘└─┘└─┘ ###################################################################

-- mod:hook(string, "find", function(func, str, pattern, start, ...)
-- 	if string.find_hooked then
-- 		return mod:cached_find(str, pattern, start, ...)
-- 	end
-- 	return func(str, pattern, start, ...)
-- end)

-- mod:hook(string, "gsub", function(func, str, pattern, repl, ...)
-- 	if string.gsub_hooked then --and type(pattern) == "string" and type(repl) == "string" then
-- 		return mod:cached_gsub(str, pattern, repl, ...)
-- 	end
-- 	return func(str, pattern, repl, ...)
-- end)

-- mod:hook(string, "split", function(func, str, sep, ...)
-- 	if string.split_hooked then
-- 		return mod:cached_split(str, sep, ...)
-- 	end
-- 	return func(str, sep, ...)
-- end)

-- mod:hook(string, "trim", function(func, str, ...)
-- 	if string.trim_hooked then
-- 		return mod:cached_trim(str, ...)
-- 	end
-- 	return func(str, ...)
-- end)

-- mod:hook(string, "cap", function(func, str, ...)
-- 	if string.cap_hooked then
-- 		return mod:cached_cap(str, ...)
-- 	end
-- 	return func(str, ...)
-- end)

-- ##### ┌┬┐┌─┐┌┐ ┬ ┬┌─┐ ##############################################################################################
-- #####  ││├┤ ├┴┐│ ││ ┬ ##############################################################################################
-- ##### ─┴┘└─┘└─┘└─┘└─┘ ##############################################################################################

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