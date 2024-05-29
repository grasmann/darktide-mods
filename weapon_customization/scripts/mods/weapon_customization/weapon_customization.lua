local mod = get_mod("weapon_customization")

mod.version = "1.21"

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
	local Unit = Unit
	local CLASS = CLASS
	local tostring = tostring
	local managers = Managers
	local script_unit = ScriptUnit
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
		extensions = {
			visible_equipment = {},
			dependencies = {},
		},
		-- Pakcages
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
		prevent_unload = {},
		keep_all_packages = nil,
		-- Performance
		performance = {
			measurements = {},
			result_cache = {},
		},
		split_cache = {},
		negative_cache = {},
		default_cache = {},
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

-- ##### ┌┬┐┌─┐┌┬┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ###############################################################################
-- ##### ││││ │ ││  ├┤ └┐┌┘├┤ │││ │ └─┐ ###############################################################################
-- ##### ┴ ┴└─┘─┴┘  └─┘ └┘ └─┘┘└┘ ┴ └─┘ ###############################################################################

-- Gamestate changed
mod.on_game_state_changed = function(status, state_name)
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
end

-- Mod reload
mod.on_reload = function(self)
	self:init()
	self:setup_item_definitions()
	if self.player_unit and Unit.alive(self.player_unit) then
		if self._debug then
			self:remove_extension(self.player_unit, "crouch_system")
			self:remove_extension(self.player_unit, "sway_system")
			self:remove_extension(self.player_unit, "sight_system")
			self:remove_extension(self.player_unit, "visible_equipment_system")
			self:remove_extension(self.player_unit, "flashlight_system")
			self:remove_extension(self.player_unit, "weapon_dof_system")
		end
	end
end

-- When all mods are loaded
mod.on_all_mods_loaded = function()
	-- Recreate hud
	mod:recreate_hud()

	mod.gear_settings:prepare_fixes()
end

-- Mod is unloaded
mod.on_unload = function(exit_game)
	if exit_game then mod:console_output() end
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

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
	-- Patches
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/extensions")

	-- Utilities
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/utilities/common")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/utilities/weapons")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/utilities/performance")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/utilities/attachments")
	
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
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/dependency_extension")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/flashlight_extension")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/weapon_dof_extension")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/laser_pointer_extension")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/sway_animation_extension")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/crouch_animation_extension")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/visible_equipment_extension")

	-- Other Patches
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/inventory_view")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/inventory_background_view")
	mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/inventory_weapon_cosmetics_view")

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