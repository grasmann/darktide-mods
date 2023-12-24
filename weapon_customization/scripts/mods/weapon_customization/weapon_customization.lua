local mod = get_mod("weapon_customization")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"

-- Persistent values
mod:persistent_table(REFERENCE, {
	-- Persistend flashlight values
	flashlight_on = false,
	-- laser_pointer_on = 0,
	-- Laser particles
	spawned_lasers = {},
	-- Items
	item_definitions = nil,
	composite_items = {},
	-- Equipment
	player_equipment = {},
	attachment_slot_infos = {},
	weapon_templates = {},
	temp_gear_settings = {},
	fade_system = nil,
	extensions = {
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
	-- Input
	input_hooked = false,
	-- Performance
	performance = {
		measurements = {},
		result_cache = {},
	},
})
mod.was_third_person = nil

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
	local Unit = Unit
	local unit_alive = Unit.alive
	local script_unit = ScriptUnit
	local managers = Managers
	local CLASS = CLASS
	local type = type
	local DMFMod = DMFMod
--#endregion

string.trim = function(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"))
end
string.cap = function(str)
	return (str:gsub("^%l", string.upper))
end

-- ##### ┌┬┐┌─┐┌┬┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ###############################################################################
-- ##### ││││ │ ││  ├┤ └┐┌┘├┤ │││ │ └─┐ ###############################################################################
-- ##### ┴ ┴└─┘─┴┘  └─┘ └┘ └─┘┘└┘ ┴ └─┘ ###############################################################################

function DMFMod:echot(message, optional_t, optional_time)
    local t = type(optional_t) == "number" and optional_t
        or managers and managers.time and managers.time:time("main")
        or 0
    local time = type(optional_time) == "number" and optional_time or 2
    self._echot = self._echot or {}
    local echoTime = self._echot[message]
    if not echoTime or echoTime < t then
        self:echo(message)
        self._echot[message] = t + time
    end
end

-- Gamestate changed
mod.on_game_state_changed = function(status, state_name)
	-- Release hub packages
	mod:release_non_essential_packages()
	mod:persistent_table(REFERENCE).used_packages.hub = {}
	-- mod:echo("state change: "..tostring(state_name))
	-- if state_name == "StateLoading" and status == "enter" then
	-- 	mod:clear_packages()
	-- end
	-- Turn off package safety
	mod.keep_all_packages = nil
	-- mod:composite_test()
end

-- Mod settings changed
mod.on_setting_changed = function(setting_id)
	-- Update mod settings
	mod.update_option(setting_id)
	-- Update randomization
	if setting_id == "mod_option_randomization_players" or setting_id == "mod_option_randomization_store" then
		mod.keep_all_packages = true
		-- mod:update_modded_packages()
	end
	-- Trigger Events
	managers.event:trigger("weapon_customization_settings_changed")
	-- Debug
	mod._debug = mod:get("mod_option_debug")
end

-- Update loop
mod.update = function(main_dt)
	-- mod:update_flicker()
	-- mod:update_battery()
end

-- When all mods are loaded
mod.on_all_mods_loaded = function()
	mod:recreate_hud()
	mod:persistent_table(REFERENCE).keep_all_packages = false
end

mod.on_unload = function(exit_game)
	if not exit_game then mod:persistent_table(REFERENCE).keep_all_packages = true end
	if exit_game then mod:console_output() end
end

-- ##### ┬ ┬┌─┐┌─┐┬┌─┌─┐ ##############################################################################################
-- ##### ├─┤│ ││ │├┴┐└─┐ ##############################################################################################
-- ##### ┴ ┴└─┘└─┘┴ ┴└─┘ ##############################################################################################

-- Player visual extension initialized
mod.player_unit_loaded = function(self)
	-- Initialize
	self:init()
	-- Update used packages
    -- self:update_modded_packages()
end

mod.husk_unit_loaded = function(self)
	-- Update used packages
    -- self:update_modded_packages()
end

-- Player visual extension destroyed
mod.player_unit_destroyed = function(self, player_unit)
	if player_unit == mod.player_unit then
		-- Set reinitialization
		mod.initialized = false
	end
	-- Update used packages
    -- mod:update_modded_packages()
end

-- mod:hook(CLASS.PlayerUnitFirstPersonExtension, "_update_first_person_mode", function(func, self, t, ...)
-- 	local show_1p_equipment, wants_1p_camera = func(self, t, ...)
-- 	if mod.initialized then
-- 		-- Cache values
-- 		mod.was_third_person = mod:_is_in_third_person()
-- 		mod.last_character_state = mod:character_state()
-- 	end
-- 	return show_1p_equipment, wants_1p_camera
-- end)

-- ##### ┬┌┐┌┬┌┬┐┬┌─┐┬  ┬┌─┐┌─┐ #######################################################################################
-- ##### │││││ │ │├─┤│  │┌─┘├┤  #######################################################################################
-- ##### ┴┘└┘┴ ┴ ┴┴ ┴┴─┘┴└─┘└─┘ #######################################################################################

mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/utilities/performance")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/utilities/common")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/utilities/weapons")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/utilities/attachments")

mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/misc")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/item_package")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/master_items")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/weapon_templates")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/input_service")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/visual_loadout_customization")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/randomization")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/patches/hud")

mod.init = function(self)
	self.ui_manager = managers.ui
	self.player_manager = managers.player
	self.package_manager = managers.package
	self.player = self.player_manager:local_player(1)
	self.peer_id = self.player:peer_id()
	self.local_player_id = self.player:local_player_id()
	self.player_unit = self.player.player_unit
	self.fx_extension = script_unit.extension(self.player_unit, "fx_system")
	self.weapon_extension = script_unit.extension(self.player_unit, "weapon_system")
	self.character_state_machine_extension = script_unit.extension(self.player_unit, "character_state_machine_system")
	self.unit_data = script_unit.extension(self.player_unit, "unit_data_system")
	self.visual_loadout_extension = script_unit.extension(self.player_unit, "visual_loadout_system")
	self.inventory_component = self.unit_data:read_component("inventory")
	self.first_person_component = self.unit_data:read_component("first_person")
	self.first_person_extension = script_unit.extension(self.player_unit, "first_person_system")
	self.first_person_unit = self.first_person_extension:first_person_unit()
	self.time_manager = managers.time
	self.initialized = true
	self._next_check_at_t = 0
	self:print("Initialized")
end

-- Extensions
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_anchors")

mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/dependency_extension")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/extension_base")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/laser_pointer_extension")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/flashlight_extension")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/crouch_animation_extension")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/sway_animation_extension")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/sight_extension")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/visible_equipment_extension")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/battery_extension")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/extensions/weapon_animation_extension")
-- Import mod files
-- mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_bolt_pistol")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_hooks")
-- mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_daemon_host")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_debug")

mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/composite")

mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_view")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_mod_options")

-- Reinitialize on mod reload
if managers and managers.player._game_state ~= nil then
	mod:init()
	mod:setup_item_definitions()
	if mod.player_unit and unit_alive(mod.player_unit) then
		if mod._debug then
			mod:remove_extension(mod.player_unit, "crouch_system")
			mod:remove_extension(mod.player_unit, "sway_system")
			mod:remove_extension(mod.player_unit, "sight_system")
			mod:remove_extension(mod.player_unit, "visible_equipment_system")
			mod:remove_extension(mod.player_unit, "flashlight_system")
			-- mod:remove_extension(mod.player_unit, "battery_system")
			-- mod:remove_extension(mod.player_unit, "laser_pointer_system")
		end
	end
end

mod:load_needed_packages()
-- mod:find_attachment_entries()
