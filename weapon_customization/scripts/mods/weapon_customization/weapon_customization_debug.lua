local mod = get_mod("weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
	local Unit = Unit
	local type = type
	local CLASS = CLASS
	local pairs = pairs
	local table = table
	local string = string
	local get_mod = get_mod
	local tostring = tostring
	local managers = Managers
	local table_sort = table.sort
	local string_find = string.find
	local unit_get_child_units = Unit.get_child_units
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"
local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_melee = _item.."/melee"

-- ##### ┌┬┐┌─┐┌┐ ┬ ┬┌─┐  ┌─┐┌┬┐┌┬┐┌─┐┌─┐┬ ┬┌┬┐┌─┐┌┐┌┌┬┐┌─┐ ###########################################################
-- #####  ││├┤ ├┴┐│ ││ ┬  ├─┤ │  │ ├─┤│  ├─┤│││├┤ │││ │ └─┐ ###########################################################
-- ##### ─┴┘└─┘└─┘└─┘└─┘  ┴ ┴ ┴  ┴ ┴ ┴└─┘┴ ┴┴ ┴└─┘┘└┘ ┴ └─┘ ###########################################################

mod.find_attachment_entry_in_mod = function(self, name)
	for weapon_name, weapon_data in pairs(self.attachment_models) do
		for attachment_name, attachment_data in pairs(weapon_data) do
			if attachment_data.model == name then
				return true
			end
		end
	end
end

mod.attachment_entry_is_weapon = function(self, name)
	for weapon_name, weapon_data in pairs(self.attachment_models) do
		-- if string_find(name, weapon_name) then
		if mod:cached_find(name, weapon_name) then
			return true
		end
	end
end

local filter = {
	"stubgun_pistol_bullet",
	"stubgun_pistol_casing",
	"shotgun_rifle_bullet",
	"bot_",
	"rippergun_rifle_bullet",
	"psyker_throwing_knife",
	"shotgun_grenade_bullet",
	"autogun_pistol_bullet",
	"autogun_rifle_bullet",
	"force_staff_projectile",
	"grenade_thumper",
	"_cinematic",

	"_cine",
	"_trail",
	"unarmed_",
}
mod.find_attachment_entries = function(self)
	self:setup_item_definitions()
	local ranged_definitions = {}
	local melee_definitions = {}
	local item_definitions = self:persistent_table(REFERENCE).item_definitions
	for name, data in pairs(item_definitions) do
		local filter_ok = true
		for _, phrase in pairs(filter) do
			-- if string_find(name, phrase) then
			if mod:cached_find(name, phrase) then
				filter_ok = false
				break
			end
		end
		if not self:find_attachment_entry_in_mod(name) and not self:attachment_entry_is_weapon(name) and filter_ok then
			-- if string_find(name, _item_ranged) then
			if mod:cached_find(name, _item_ranged) then
				ranged_definitions[name] = data
			-- elseif string_find(name, _item_melee) then
			elseif mod:cached_find(name, _item_melee) then
				melee_definitions[name] = data
			end
		end
	end
	self:dtf(ranged_definitions, "ranged_definitions", 15)
	self:dtf(melee_definitions, "melee_definitions", 15)
end


-- ##### ┌┬┐┌─┐┌─┐┌┬┐  ┬┌┐┌┌┬┐┌─┐─┐ ┬ #################################################################################
-- #####  │ ├┤ └─┐ │   ││││ ││├┤ ┌┴┬┘ #################################################################################
-- #####  ┴ └─┘└─┘ ┴   ┴┘└┘─┴┘└─┘┴ └─ #################################################################################

mod.test_index = 1
mod.test_float = 0
mod.inc_test_index = function()
	mod.test_index = mod.test_index + 1
	mod.test_float = mod.test_float + .01
	mod:echo("index: "..tostring(mod.test_index).." float: "..tostring(mod.test_float))
end
mod.dec_test_index = function()
	mod.test_index = mod.test_index - 1
	mod.test_float = mod.test_float - .01
	mod:echo("index: "..tostring(mod.test_index).." float: "..tostring(mod.test_float))
end

mod.clear_chat = function()
	managers.event:trigger("event_clear_notifications")
end

-- mod.loading_open = false
mod.load_mission = function()
	if not mod.loading_open then
		mod.loading_intro_view = true
		managers.ui:open_view("mission_intro_view", nil, nil, nil, nil, {})
	elseif mod.loading_open then
		mod.loading_intro_view = false
		managers.ui:close_view("mission_intro_view")
	end
	mod.loading_open = not mod.loading_open
end

mod.end_view = function()
	if not mod.end_view_open then
		managers.ui:open_view("end_view", nil, nil, nil, nil, {})
	elseif mod.end_view_open then
		managers.ui:close_view("end_view")
	end
	mod.end_view_open = not mod.end_view_open
end

mod.lobby_view = function()
	if not mod.lobby_view_open then
		mod.loading_lobby_view = true
		if not managers.mechanism._mechanism then
			managers.mechanism._mechanism = {
				_mechanism_data = {
					mission_name = "psykhanium",
					circumstance_name = "default",
					backend_mission_id = 1,
				}
			}
		end
		managers.ui:open_view("lobby_view", nil, nil, nil, nil, {
			mission_data = ""
		})
		managers.mechanism._mechanism = nil
	elseif mod.lobby_view_open then
		mod.loading_lobby_view = false
		managers.ui:close_view("lobby_view")
	end
	mod.lobby_view_open = not mod.lobby_view_open
end

-- mod.mission_board_view = function()
-- 	if not mod.mission_board_view_open then
-- 		mod.loading_mission_board_view = true
-- 		if not managers.mechanism._mechanism then
-- 			managers.mechanism._mechanism = {
-- 				_mechanism_data = {
-- 					mission_name = "psykhanium",
-- 					circumstance_name = "default",
-- 					backend_mission_id = 1,
-- 				}
-- 			}
-- 		end
-- 		managers.ui:open_view("mission_board_view", nil, nil, nil, nil, {
-- 			mission_data = ""
-- 		})
-- 		managers.mechanism._mechanism = nil
-- 	elseif mod.mission_board_view_open then
-- 		mod.loading_mission_board_view = false
-- 		managers.ui:close_view("mission_board_view")
-- 	end
-- 	mod.mission_board_view_open = not mod.mission_board_view_open
-- end

-- mod:hook(CLASS.UIViewHandler, "_open", function(func, self, view_name, opening_duration, context, settings_override, ...)
-- 	mod:echo("Opening "..view_name)
-- 	return func(self, view_name, opening_duration, context, settings_override, ...)
-- end)

mod:hook(CLASS.LobbyView, "_sync_votes", function(func, self, ...)
	if mod.loading_lobby_view then
		return
	end
	return func(self, ...)
end)

mod:hook(CLASS.EndView, "_set_mission_key", function(func, self, mission_key, session_report, render_scale, ...)
	if mission_key then
		-- Original function
		func(self, mission_key, session_report, render_scale, ...)
	end
end)

local Missions = mod:original_require("scripts/settings/mission/mission_templates")
local MissionIntroViewSettings = mod:original_require("scripts/ui/views/mission_intro_view/mission_intro_view_settings")

mod:hook(CLASS.MissionIntroView, "select_target_intro_level", function(func, mission_name, ...)
	if mod.loading_intro_view then
		local mission_zone_id = mission_name and Missions[mission_name].zone_id or "default"
		local intro_level = MissionIntroViewSettings.intro_levels_by_zone_id[mission_zone_id] or MissionIntroViewSettings.intro_levels_by_zone_id.default
		local intro_level_packages = {
			is_level_package = true,
			name = intro_level.level_name,
		}
		return intro_level, intro_level_packages
	else
		return func(mission_name, ...)
	end
end)

-- mod:hook(CLASS.MissionIntroView, "_register_mission_intro_spawn_point", function(func, self, spawn_point_unit, index, ...)
-- 	-- self._spawn_point_units[index] = spawn_point_unit
-- 	func(self, spawn_point_unit, 1, ...)
-- end)

--  Debug
mod._debug = mod:get("mod_option_debug")
mod._debug_skip_some = true

-- Debug print
mod.print = function(self, message, skip)
	self:info(message)
	-- if self._debug and not skip then self:info(message) end
end

mod.get_modding_tools = function(self)
	self.modding_tools = self.modding_tools or get_mod("modding_tools")
end

mod.console_print = function(self, ...)
	self:get_modding_tools()
	if self.modding_tools then
		local args = {...}
		for _, arg in pairs(args) do
			self:print(tostring(arg))
		end
		self.modding_tools:console_print(...)
	end
end

mod.debug_stingray_objects = function(self)
	self:dtf(Unit, "Unit", 10)
end

mod._recursive_get_child_units = function(self, unit, slot_info_id, out_units)
	local slot_info_id = slot_info_id or self.cosmetics_view._slot_info_id
	local slot_infos = mod:persistent_table(REFERENCE).attachment_slot_infos
	local attachment_slot_info = slot_infos[slot_info_id]
	if attachment_slot_info then
		local attachment_slot = attachment_slot_info.unit_to_attachment_slot[unit]
		local text = attachment_slot and attachment_slot or unit
		out_units[text] = {}
		local children = unit_get_child_units(unit)
		if children then
			for _, child in pairs(children) do
				self:_recursive_get_child_units(child, out_units[text])
			end
		end
	end
end

mod.map_out_unit = function(self, unit)
	local map = {}
	self:_recursive_get_child_units(unit, map)
	self:dtf(map, "map", 20)
end

-- ##### ┌┬┐┌─┐┌┐ ┬ ┬┌─┐  ┬┌┬┐┌─┐┌┬┐  ┌─┐┌┬┐┌┬┐┌─┐┌─┐┬ ┬┌┬┐┌─┐┌┐┌┌┬┐┌─┐ ###############################################
-- #####  ││├┤ ├┴┐│ ││ ┬  │ │ ├┤ │││  ├─┤ │  │ ├─┤│  ├─┤│││├┤ │││ │ └─┐ ###############################################
-- ##### ─┴┘└─┘└─┘└─┘└─┘  ┴ ┴ └─┘┴ ┴  ┴ ┴ ┴  ┴ ┴ ┴└─┘┴ ┴┴ ┴└─┘┘└┘ ┴ └─┘ ###############################################

mod.generate_console_title = function(self, text)
	local title = text or " Weapon Customization "..tostring(mod.version).." "
	local title_length = string.len(title)
	local fill = 100 - title_length
	for i = 1, fill / 2, 1 do
		title = "#"..title
	end
	local title_length = string.len(title)
	for i = title_length, 99, 1 do
		title = title.."#"
	end
	return title
end

mod.console_init = function(self)
	if not mod:persistent_table(REFERENCE).console_init then
		local title = self:generate_console_title(" Weapon Customization "..tostring(mod.version).." initialized! ")

		self:info("####################################################################################################")
		self:info(title)
		self:info("####################################################################################################")
		
		mod:persistent_table(REFERENCE).console_init = true
	end
end

mod.debug_attachments = function(self, item_data, attachments, weapon_name_or_table, overwrite, full, depth)
    if item_data then
		local time = overwrite and "" or managers.time:time("main")
        local item_name = self.gear_settings:short_name(item_data.name)
		local debug = full and item_data or attachments
		local file_name = full and "item_data" or "attachments"
		local depth = depth or 10
		if type(weapon_name_or_table) == "string" then
			if item_name == weapon_name_or_table then
				self:dtf(debug, file_name.."_"..item_name.."_"..tostring(time), 10)
			end
		elseif type(weapon_name_or_table) == "table" then
			for _, weapon_name in pairs(weapon_name_or_table) do
				if item_name == weapon_name then
					self:dtf(debug, file_name.."_"..item_name.."_"..tostring(time), 10)
				end
			end
		end
    end
end
