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
	local CLASS = CLASS
	local managers = Managers
	local vector3_box = Vector3Box
	local table_clear = table.clear
	local table_clone = table.clone
	local table_contains = table.contains
	local table_clone_instance = table.clone_instance
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local REFERENCE = "weapon_customization"
	local DEBUG = false
--#endregion

-- ##### ┌─┐┌─┐┌─┐┬─┐  ┌─┐┌┬┐┌┬┐┌─┐┌─┐┬ ┬  ┌─┐┌─┐┬┌┐┌┌┬┐┌─┐ ###########################################################
-- ##### │ ┬├┤ ├─┤├┬┘  ├─┤ │  │ ├─┤│  ├─┤  ├─┘│ │││││ │ └─┐ ###########################################################
-- ##### └─┘└─┘┴ ┴┴└─  ┴ ┴ ┴  ┴ ┴ ┴└─┘┴ ┴  ┴  └─┘┴┘└┘ ┴ └─┘ ###########################################################

mod.gear_attach_points = {
	ogryn = {
		{node = "j_hips",		offset = vector3_box(0, .55, .1),  text = "Hips Front",	name = "hips_front"},
		{node = "j_hips",		offset = vector3_box(0, -.4, .1),  text = "Hips Back",	name = "hips_back"},
		{node = "j_hips",		offset = vector3_box(-.5, 0, .1),  text = "Hips Left",	name = "hips_left"},
		{node = "j_hips",		offset = vector3_box(.5, 0, .1),   text = "Hips Right",	name = "hips_right"},
		{node = "j_leftupleg",	offset = vector3_box(0, -.2, 0),   text = "Left Leg",	name = "leg_left"},
		{node = "j_rightupleg",	offset = vector3_box(0, .2, 0),    text = "Right Leg",	name = "leg_right"},
		{node = "j_spine2",		offset = vector3_box(0, -.5, 0),   text = "Chest",		name = "chest"},
		{node = "j_spine2",		offset = vector3_box(-.25, .5, 0), text = "Back Left",	name = "backpack_left"},
		{node = "j_spine2",		offset = vector3_box(.25, .5, 0),  text = "Back Right",	name = "backpack_right"},
		{node = "j_spine2",		offset = vector3_box(-.25, .5, 0), text = "Back Left",	name = "back_left"},
		{node = "j_spine2",		offset = vector3_box(.25, .5, 0),  text = "Back Right",	name = "back_right"},
	},
	human = {
		{node = "j_hips",			 offset = vector3_box(0, .2, .1),	text = "Hips Front", name = "hips_front"},
		{node = "j_hips",			 offset = vector3_box(0, -.15, .1), text = "Hips Back",	 name = "hips_back"},
		{node = "j_hips",			 offset = vector3_box(-.15, 0, .1), text = "Hips Left",	 name = "hips_left"},
		{node = "j_hips",			 offset = vector3_box(.15, 0, .1),	text = "Hips Right", name = "hips_right"},
		{node = "j_leftupleg",		 offset = vector3_box(0, 0, 0),		text = "Left Leg",	 name = "leg_left"},
		{node = "j_rightupleg",		 offset = vector3_box(0, 0, 0),		text = "Right Leg",	 name = "leg_right"},
		{node = "j_frontchestplate", offset = vector3_box(0, 0, 0),		text = "Chest",		 name = "chest"},
		{node = "j_backchestplate",	 offset = vector3_box(0, 0, -.15),	text = "Back Left",	 name = "backpack_left"},
		{node = "j_backchestplate",	 offset = vector3_box(0, 0, .15),	text = "Back Right", name = "backpack_right"},
		{node = "j_backchestplate",	 offset = vector3_box(0, 0, -.15),	text = "Back Left",	 name = "back_left"},
		{node = "j_backchestplate",	 offset = vector3_box(0, 0, .15),	text = "Back Right", name = "back_right"},
	},
}

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local DataCache = class("DataCache")

-- ##### ┌─┐┬  ┌─┐┌┐ ┌─┐┬   ###########################################################################################
-- ##### │ ┬│  │ │├┴┐├─┤│   ###########################################################################################
-- ##### └─┘┴─┘└─┘└─┘┴ ┴┴─┘ ###########################################################################################

mod.try_init_cache = function(self)
	if self.all_mods_loaded and not self.data_cache then
		if MasterItems.get_cached() then
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
		for _, attachment_slot in pairs(self.attachment_slots) do
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
	self.attachments = mod.attachment
	self.attachment_models = mod.attachment_models
	self.attachment_fixes = mod.anchors
	self.item_definitions = self:setup_item_definitions()
	self.cache = mod:persistent_table(REFERENCE).cache
	self:cache_attachment_data()
	self.initialized = true
end

DataCache.destroy = function(self)
	self.initialized = false
end

DataCache.setup_item_definitions = function(self)
	if mod:persistent_table(REFERENCE).item_definitions == nil then
		local master_items = MasterItems.get_cached()
		if master_items then
			mod:persistent_table(REFERENCE).item_definitions = table_clone_instance(master_items)
			-- Bulwark shield
			local definitions = mod:persistent_table(REFERENCE).item_definitions
			local bulwark_shield_string = "content/items/weapons/player/melee/ogryn_bulwark_shield_01"
			if not definitions[bulwark_shield_string] then
				local bulwark_shield_unit = "content/weapons/enemy/shields/bulwark_shield_01/bulwark_shield_01"
				definitions[bulwark_shield_string] = table_clone(definitions["content/items/weapons/player/melee/ogryn_slabshield_p1_m1"])
				local bulwark_shield = definitions[bulwark_shield_string]
				bulwark_shield.name = bulwark_shield_string
				bulwark_shield.base_unit = bulwark_shield_unit
				bulwark_shield.resource_dependencies = {
					[bulwark_shield_unit] = true,
				}
			end

		end
	end
	return mod:persistent_table(REFERENCE).item_definitions
end

DataCache.cache_attachment_data = function(self)
	if not self.cache.initialized then
		for item_name, _ in pairs(mod.attachment) do
			-- Strings
			local melee = "content/items/weapons/player/melee/"..item_name
			local ranged = "content/items/weapons/player/ranged/"..item_name
			local npc = "content/items/weapons/npc/"..item_name
			local minion_melee = "content/items/weapons/minions/melee/"..item_name
			local minion_ranged = "content/items/weapons/minions/ranged/"..item_name
			-- Get master item string
			local item_string = self.item_definitions[melee] and melee
				or self.item_definitions[ranged] and ranged
				or self.item_definitions[npc] and npc
				or self.item_definitions[minion_melee] and minion_melee
				or self.item_definitions[minion_ranged] and minion_ranged
			-- Get master item
			local item = self.item_definitions[item_string]
			-- Check item
			if item then
				-- Cache full item string -> item name
				self.cache.item_names[item_string] = item_name
				-- Cache item name -> full item string
				self.cache.item_strings[item_name] = item_string
				-- Cache item name -> attachment slots
				self.cache.attachment_slots[item_name] = mod.gear_settings:possible_attachment_slots(item)
				self.cache.attachment_list[item_name] = {}
				for _, attachment_slot in pairs(self.cache.attachment_slots[item_name]) do
					-- Cache item name -> possible attachments by slot
					local list = mod.gear_settings:possible_attachments(item, attachment_slot)
					if list and #list > 0 then self.cache.attachment_list[item_name][attachment_slot] = mod.gear_settings:possible_attachments(item, attachment_slot) end
				end
				-- Cache item name -> default attachment
				self.cache.default_attachments[item_name] = {}
				for _, attachment_slot in pairs(self.cache.attachment_slots[item_name]) do
					-- Cache item name -> default attachment by slot
					self.cache.default_attachments[item_name][attachment_slot] = mod.gear_settings:default_attachment(item, attachment_slot)
				end
			end
		end
		-- Cache cosmetics scenegraphs
		for _, attachment_slot in pairs(mod.attachment_slots) do
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

DataCache.item_name_to_default_attachment = function(self, item_name, attachment_slot)
	return self.cache.default_attachments[item_name] and self.cache.default_attachments[item_name][attachment_slot]
end

DataCache.item_name_to_attachment_list = function(self, item_name, attachment_slot_or_nil)
	if attachment_slot_or_nil then
		return self.cache.attachment_list[item_name] and self.cache.attachment_list[item_name][attachment_slot_or_nil]
	else
		return self.cache.attachment_list[item_name] and self.cache.attachment_list[item_name]["all"]
	end
end

DataCache.item_name_to_attachment_slots = function(self, item)
	return self.cache.attachment_slots[item]
end

DataCache.item_name_to_item_string = function(self, item_name)
	return self.cache.item_strings[item_name]
end

DataCache.item_string_to_item_name = function(self, item_string)
	return self.cache.item_names[item_string]
end

-- ##### ┌┬┐┌─┐┌┐ ┬ ┬┌─┐ ##############################################################################################
-- #####  ││├┤ ├┴┐│ ││ ┬ ##############################################################################################
-- ##### ─┴┘└─┘└─┘└─┘└─┘ ##############################################################################################

DataCache.debug_dump = function(self)
	if DEBUG then
		mod:dtf(self.cache, "self.cache", 10)
	end
end

return DataCache