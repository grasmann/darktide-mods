local mod = get_mod("weapon_customization")

mod.version = "2.10"

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
	local Unit = Unit
	local table = table
	local CLASS = CLASS
	local string = string
	local get_mod = get_mod
	local tostring = tostring
	local managers = Managers
	local script_unit = ScriptUnit
	local table_clear = table.clear
	-- local string_find = string.find
	-- local string_gsub = string.gsub
	-- local string_split = string.split
	-- local string_upper = string.upper
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local REFERENCE = "weapon_customization"
	local OPTION_RANDOMIZE_PLAYERS = "mod_option_randomization_players"
	local OPTION_RANDOMIZE_STORE = "mod_option_randomization_store"
	-- Persistent values
	mod:persistent_table(REFERENCE, {
		console_init = false,
		-- Flashlight
		flashlight_on = false,
		-- Gear settings
		loaded_gear_settings = {},
		-- Items
		item_definitions = nil,
		composite_items = {},
		-- Equipment
		attachment_slot_infos = {},
		weapon_templates = {},
		temp_gear_settings = {},
		-- Packages
		package_info = {},
		loaded_packages = {
			visible_equipment = {},
			view_weapon_sounds = {},
			needed = {},
			customization = {},
		},
		used_packages = {
			visible_equipment = {},
			view_weapon_sounds = {},
			needed = {},
			attachments = {},
			hub = {},
			customization = {},
		},
		-- Cache
		cache = {
			initialized = false,
			contains_default = {},
			item_names = {},
			item_strings = {},
			attachment_slots = {},
			num_attachment_slots = {},
			attachment_list = {},
			default_attachments = {},
			cosmetics_scenegraphs = {},
			num_fixes = {},
			attachment_names = {},
			string_split = {},
			string_gsub = {},
			string_find = {},
			string_trim = {},
			string_cap = {},
		},
		debug_split = {split = 0, cache = 0},
		debug_gsub = {gsub = 0, cache = 0},
		debug_find = {find = 0, cache = 0},
		debug_trim = {trim = 0, cache = 0},
		debug_cap = {cap = 0, cache = 0},
	})
	-- local persistent_table = mod:persistent_table(REFERENCE)
	-- local string_split_cache = persistent_table.cache.string_split
	-- local debug_split_cache = persistent_table.debug_split
	-- local string_gsub_cache = persistent_table.cache.string_gsub
	-- local debug_gsub_cache = persistent_table.debug_gsub
	-- local string_find_cache = persistent_table.cache.string_find
	-- local debug_find_cache = persistent_table.debug_find
	-- local string_trim_cache = persistent_table.cache.string_trim
	-- local debug_trim_cache = persistent_table.debug_trim
	-- local string_cap_cache = persistent_table.cache.string_cap
	-- local debug_cap_cache = persistent_table.debug_cap
--#endregion

-- -- ##### ┌─┐┌┬┐┬─┐┬┌┐┌┌─┐  ┌┬┐┌─┐┌┬┐┌─┐┬┌─┐┌─┐┌┬┐┬┌─┐┌┐┌ ##############################################################
-- -- ##### └─┐ │ ├┬┘│││││ ┬  │││├┤ ││││ ││┌─┘├─┤ │ ││ ││││ ##############################################################
-- -- ##### └─┘ ┴ ┴└─┴┘└┘└─┘  ┴ ┴└─┘┴ ┴└─┘┴└─┘┴ ┴ ┴ ┴└─┘┘└┘ ##############################################################

-- mod.cached_split = function(self, str, sep)
-- 	local key = str..sep
-- 	if not string_split_cache[key] then
-- 		string_split_cache[key] = string_split(str, sep)
-- 		debug_split_cache.split = debug_split_cache.split + 1
-- 	else
-- 		debug_split_cache.cache = debug_split_cache.cache + 1
-- 	end
-- 	return string_split_cache[key]
-- end

-- mod.cached_gsub = function(self, str, pattern, repl)
-- 	local key = str..pattern..repl
-- 	if not string_gsub_cache[key] then
-- 		string_gsub_cache[key] = string_gsub(str, pattern, repl)
-- 		debug_gsub_cache.gsub = debug_gsub_cache.gsub + 1
-- 	else
-- 		debug_gsub_cache.cache = debug_gsub_cache.cache + 1
-- 	end
-- 	return string_gsub_cache[key]
-- end

-- mod.cached_find = function(self, str, pattern)
-- 	local key = str..pattern
-- 	if not string_find_cache[key] then
-- 		string_find_cache[key] = string_find(str, pattern) ~= nil
-- 		debug_find_cache.find = debug_find_cache.find + 1
-- 	else
-- 		debug_find_cache.cache = debug_find_cache.cache + 1
-- 	end
-- 	return string_find_cache[key]
-- end

-- mod.cached_trim = function(self, str)
-- 	if not string_trim_cache[str] then
-- 		string_trim_cache[str] = string_gsub(str, "^%s*(.-)%s*$", "%1")
-- 		debug_trim_cache.trim = debug_trim_cache.trim + 1
-- 	else
-- 		debug_trim_cache.cache = debug_trim_cache.cache + 1
-- 	end
-- 	return string_trim_cache[str]
-- end

-- mod.cached_cap = function(self, str)
-- 	if not string_cap_cache[str] then
-- 		string_cap_cache[str] = string_gsub(str, "^%l", string_upper)
-- 		debug_cap_cache.cap = debug_cap_cache.cap + 1
-- 	else
-- 		debug_cap_cache.cache = debug_cap_cache.cache + 1
-- 	end
-- 	return string_cap_cache[str]
-- end

-- ##### ┬┌┐┌┬┌┬┐┬┌─┐┬  ┬┌─┐┌─┐ #######################################################################################
-- ##### │││││ │ │├─┤│  │┌─┘├┤  #######################################################################################
-- ##### ┴┘└┘┴ ┴ ┴┴ ┴┴─┘┴└─┘└─┘ #######################################################################################

-- Initialize mod
mod.init = function(self)
	local player_manager = managers.player
	self.player = player_manager:local_player(1)
	self.player_unit = self.player.player_unit
	self.weapon_extension = script_unit.extension(self.player_unit, "weapon_system")
	self.visual_loadout_extension = script_unit.extension(self.player_unit, "visual_loadout_system")
	self.time_manager = managers.time
	self.initialized = true
end

-- Uninitialize mod
mod.deinit = function(self)
	self.initialized = false
end

-- ##### ┌┬┐┌─┐┌┬┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ###############################################################################
-- ##### ││││ │ ││  ├┤ └┐┌┘├┤ │││ │ └─┐ ###############################################################################
-- ##### ┴ ┴└─┘─┴┘  └─┘ └┘ └─┘┘└┘ ┴ └─┘ ###############################################################################

-- Gamestate changed
mod.on_game_state_changed = function(status, state_name)
	local loaded_packages = mod:persistent_table(REFERENCE).loaded_packages
	table_clear(loaded_packages.visible_equipment)
end

-- Mod settings changed
mod.on_setting_changed = function(setting_id)
	-- Update mod settings
	mod.update_option(setting_id)
	-- Trigger Events
	managers.event:trigger("weapon_customization_settings_changed")
	-- Debug
	mod._debug = mod:get("mod_option_debug")
end

-- Update loop
mod.update = function(main_dt)
	mod:try_init_cache()
end

-- Mod reload
mod.on_reload = function(self)
	self:init()
	self:setup_item_definitions()
	-- if self._debug and self.player_unit and Unit.alive(self.player_unit) then
	-- 	self:remove_extension(self.player_unit, "crouch_system")
	-- 	self:remove_extension(self.player_unit, "sway_system")
	-- 	self:remove_extension(self.player_unit, "sight_system")
	-- 	self:execute_extension(self.player_unit, "visible_equipment_system", "delete_slots")
	-- 	self:remove_extension(self.player_unit, "visible_equipment_system")
	-- 	self:execute_extension(self.player_unit, "weapon_sling_system", "delete_slots")
	-- 	self:remove_extension(self.player_unit, "weapon_sling_system")
	-- 	self:remove_extension(self.player_unit, "flashlight_system")
	-- 	self:remove_extension(self.player_unit, "weapon_dof_system")
	-- end
end

-- When all mods are loaded
mod.on_all_mods_loaded = function()
	-- Recreate hud
	-- mod:recreate_hud_elements()

	-- mod.gear_settings:destroy_all_temp_settings()
	-- mod.gear_settings:prepare_fixes()
	mod.modding_tools = get_mod("modding_tools")

	mod:watch_string_cache()

	-- if mod.modding_tools then
	-- 	mod.modding_tools.watcher:watch("String splits executed", debug_split_cache, "split")
	-- 	mod.modding_tools.watcher:watch("String split cache used", debug_split_cache, "cache")
	-- 	mod.modding_tools.watcher:watch("String gsubs executed", debug_gsub_cache, "gsub")
	-- 	mod.modding_tools.watcher:watch("String gsub cache used", debug_gsub_cache, "cache")
	-- 	mod.modding_tools.watcher:watch("String finds executed", debug_find_cache, "find")
	-- 	mod.modding_tools.watcher:watch("String find cache used", debug_find_cache, "cache")
	-- 	mod.modding_tools.watcher:watch("String trims executed", debug_trim_cache, "trim")
	-- 	mod.modding_tools.watcher:watch("String trim cache used", debug_trim_cache, "cache")
	-- 	mod.modding_tools.watcher:watch("String caps executed", debug_cap_cache, "cap")
	-- 	mod.modding_tools.watcher:watch("String cap cache used", debug_cap_cache, "cache")
	-- 	mod.modding_tools:inspect("Cache", persistent_table.cache)
	-- 	-- mod.modding_tools:watch(mod.debug_split)
	-- 	-- mod.modding_tools:watch(mod.debug_split.split)
	-- 	-- mod.modding_tools:watch(mod.debug_split.cache)
	-- end

	mod.all_mods_loaded = true
end

-- Mod is unloaded
mod.on_unload = function(exit_game)
	if not exit_game then mod:reload_cache() end
	if exit_game then
		-- mod:recreate_hud()
	end
	if managers.event then
		managers.event:trigger("weapon_customization_unload")
	end
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

-- Player visual extension initialized
mod.on_player_unit_loaded = function(self, player_unit)
	self:init()
end

-- Teammate visual extension initialized
mod.on_husk_unit_loaded = function(self, husk_unit)
end

-- Player visual extension destroyed
mod.on_player_unit_destroyed = function(self, player_unit)
	if player_unit == mod.player_unit then self:deinit() end
end

-- Teammate visual extension destroyed
mod.on_husk_unit_destroyed = function(self, husk_unit)
end

-- mod:hook(CLASS.LevelLoader, "start_loading", function(func, self, mission_name, level_editor_level, circumstance_name, ...)
-- 	-- mod:echo("LevelLoader start_loading")
-- 	return func(self, mission_name, level_editor_level, circumstance_name, ...)
-- end)

-- mod.load_mission = function()
-- 	if managers.loading then
-- 		mod:echo("Loading mission")
-- 		managers.loading:load_mission()
-- 	end
-- end

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require

	-- Patches
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/extensions")

	-- Utilities
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/utilities/common")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/utilities/weapons")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/utilities/attachments")

	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/classes/data_cache")

	local WeaponBuildAnimation = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/classes/weapon_build_animation")
	mod.build_animation = WeaponBuildAnimation:new()
	
	local GearSettings = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/classes/gear_settings")
	mod.gear_settings = GearSettings:new()

	-- Patches
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/hud")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/misc")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/icons")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/item_package")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/master_items")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/input_service")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/randomization")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/weapon_templates")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/visual_loadout_customization")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/ui_weapon_spawner")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/ui_profile_spawner")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/player_husk_first_person_extension")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/player_husk_visual_loadout_extension")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/player_unit_first_person_extension")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/player_unit_visual_loadout_extension")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/equipment_component")

	-- Definitions
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_anchors")

	-- Extensions
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/extension_base")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/sight_extension")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/battery_extension")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/flashlight_extension")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/weapon_dof_extension")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/laser_pointer_extension")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/sway_animation_extension")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/crouch_animation_extension")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/visible_equipment_extension")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/sling_extension")

	-- Other Patches
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/inventory_view")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/inventory_background_view")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/inventory_weapon_cosmetics_view")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/main_menu_background_view")

	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_hooks")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_debug")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/composite")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_mod_options")
	-- mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_bolt_pistol")
	-- mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_daemon_host")
--#endregion

-- Console init message
mod:console_init()

-- Packages
mod:load_needed_packages()

-- Find unused attachments
-- mod:find_attachment_entries()
-- mod:debug_stingray_objects()

-- Reinitialize on mod reload
if managers and managers.player._game_state ~= nil then
	mod:on_reload()
end