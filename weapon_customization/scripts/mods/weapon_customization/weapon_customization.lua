local mod = get_mod("weapon_customization")

mod.version = "2.10"

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
	local Unit = Unit
	local type = type
	local table = table
	local CLASS = CLASS
	local string = string
	local get_mod = get_mod
	local tostring = tostring
	local managers = Managers
	local script_unit = ScriptUnit
	local table_clear = table.clear
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
		temp_cached_fixes = {},
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
		reload_definitions = {},
		icon_cache = {},
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
			original_items = {},
			original_patterns = {},
			pattern_to_item = {},
			string_split = {},
			string_gsub = {},
			string_find = {},
			string_trim = {},
			string_cap = {},
			cached_data = {},
			combinations = {},
			diff = 0,
		},
		debug_split = {split = 0, cache = 0},
		debug_gsub = {gsub = 0, cache = 0},
		debug_find = {find = 0, cache = 0},
		debug_trim = {trim = 0, cache = 0},
		debug_cap = {cap = 0, cache = 0},
	})
--#endregion

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

mod.current_player_models = {}

-- ##### ┌┬┐┌─┐┌┬┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ###############################################################################
-- ##### ││││ │ ││  ├┤ └┐┌┘├┤ │││ │ └─┐ ###############################################################################
-- ##### ┴ ┴└─┘─┴┘  └─┘ └┘ └─┘┘└┘ ┴ └─┘ ###############################################################################

-- Gamestate changed
mod.on_game_state_changed = function(status, state_name)
	local loaded_packages = mod:persistent_table(REFERENCE).loaded_packages
	table_clear(loaded_packages.visible_equipment)
	-- if state_name == "StateVictoryDefeat" then
	-- 	if status == "enter" then
	-- 		-- Cutscene
	-- 		managers.event:trigger("weapon_customization_cutscene", true)
	-- 	elseif status == "exit" then
	-- 		-- Cutscene
	-- 		managers.event:trigger("weapon_customization_cutscene", false)
	-- 	end
	-- end
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
end

-- When all mods are loaded
mod.on_all_mods_loaded = function()
	mod.modding_tools = get_mod("modding_tools")
	mod:watch_string_cache()
	mod.all_mods_loaded = true
end

-- Mod is unloaded
mod.on_unload = function(exit_game)
	if not exit_game then mod:reload_cache() end
	if managers.event then managers.event:trigger("weapon_customization_unload") end
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

-- Player visual extension initialized
mod.on_player_unit_loaded = function(self, player_unit)
	self.current_player_models[player_unit] = player_unit
	self:init()
end

-- Teammate visual extension initialized
mod.on_husk_unit_loaded = function(self, husk_unit)
	self.current_player_models[husk_unit] = husk_unit
end

-- Player visual extension destroyed
mod.on_player_unit_destroyed = function(self, player_unit)
	self.current_player_models[player_unit] = nil
	if player_unit == mod.player_unit then self:deinit() end
end

-- Teammate visual extension destroyed
mod.on_husk_unit_destroyed = function(self, husk_unit)
	self.current_player_models[husk_unit] = nil
end

mod.register_definition_callback = function(reload_function)
	local reload_definitions = mod:persistent_table(REFERENCE).reload_definitions
	if reload_function and type(reload_function) == "function" then
		reload_definitions[#reload_definitions + 1] = reload_function
	end
end

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
	-- mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/profile_utils")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/input_service")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/randomization")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/weapon_templates")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/visual_loadout_customization")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/player_unit_spawn_manager")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/ui_weapon_spawner")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/ui_profile_spawner")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/player_husk_first_person_extension")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/player_husk_visual_loadout_extension")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/player_unit_first_person_extension")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/player_unit_visual_loadout_extension")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/equipment_component")

	-- Definitions
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/visible_equipment/offsets")
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
	-- mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/composite")
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

-- local weapon_customization = get_mod("weapon_customization")
-- weapon_customization.register_definition_callback(function()
-- 	mod:echo("weapon attachment reload")
-- end)

-- Reinitialize on mod reload
if managers and managers.player._game_state ~= nil then
	mod:on_reload()
end