local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local WeaponTemplate = mod:original_require("scripts/utilities/weapon/weapon_template")
local FixedFrame = mod:original_require("scripts/utilities/fixed_frame")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--  Debug
mod._debug = mod:get("mod_option_debug")
mod._debug_skip_some = true

-- Persistent values
mod:persistent_table("weapon_customization", {
	flashlight_on = false,
	laser_pointer_on = 0,
	spawned_lasers = {},
	item_definitions = nil,
	player_equipment = {},
	attachment_slot_infos = {},
	loaded_packages = {},
	input_hooked = false,
})
mod.was_third_person = nil

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
	local string_gsub = string.gsub
	local string_find = string.find
	local math_floor = math.floor
	local tostring = tostring
	local pairs = pairs
	local game_parameters = GameParameters
	local script_unit = ScriptUnit
	local managers = Managers
	local CLASS = CLASS
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ###############################################################################
-- ##### ││││ │ ││  ├┤ └┐┌┘├┤ │││ │ └─┐ ###############################################################################
-- ##### ┴ ┴└─┘─┴┘  └─┘ └┘ └─┘┘└┘ ┴ └─┘ ###############################################################################

-- Gamestate changed
function mod.on_game_state_changed(status, state_name)
	-- Reset flashlight state
	mod:persistent_table("weapon_customization").flashlight_on = false
	mod:reset_laser_pointer()
end

-- Mod settings changed
function mod.on_setting_changed(setting_id)
	-- Update mod settings
	mod.update_option(setting_id)
	-- Update flashlight
	if setting_id == "mod_option_flashlight_shadows" or setting_id == "mod_option_flashlight_flicker" then
		if mod:has_flashlight_attachment() then mod:toggle_flashlight(true) end
		if mod:has_laser_pointer_attachment() then mod:toggle_laser(true) end
	end
	if setting_id == "mod_option_laser_pointer_wild" or setting_id == "mod_option_laser_pointer_weapon_dot" or setting_id == "mod_option_laser_pointer_weapon_flash" then
		if mod:has_laser_pointer_attachment() then mod:toggle_laser(true) end
	end
	if setting_id == "mod_option_visible_equipment" then
		mod:update_equipment_visibility()
	end
	-- Debug
	mod._debug = mod:get("mod_option_debug")
end

-- Update loop
function mod.update(main_dt)
	mod:update_flicker()
	mod:update_battery()
	mod:update_equipment(main_dt)
end

-- ##### ┬ ┬┌─┐┌─┐┬┌─┌─┐ ##############################################################################################
-- ##### ├─┤│ ││ │├┴┐└─┐ ##############################################################################################
-- ##### ┴ ┴└─┘└─┘┴ ┴└─┘ ##############################################################################################

-- Player visual extension initialized
mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "extensions_ready", function(func, self, world, unit, ...)
	func(self, world, unit, ...)
	-- Initialize
	mod:init()
end)

-- Player visual extension destroyed
mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "destroy", function(func, self, ...)
	if self._unit == mod.player_unit then
		-- Set reinitialization
		mod.initialized = false
	end
	return func(self, ...)
end)

-- Update flashlight state
mod:hook(CLASS.Flashlight, "update_first_person_mode", function(func, self, first_person_mode, ...)
	func(self, first_person_mode, ...)
	if mod.initialized then
		-- Update flashlight / laser pointer
		if mod:has_flashlight_attachment() then mod:update_flashlight_view() end
		if mod:has_laser_pointer_attachment() then mod:update_laser_pointer() end
		-- Cache values
		mod.was_third_person = mod:_is_in_third_person()
		mod.last_character_state = mod:_character_state()
	end
end)

-- Update flashlight state
mod:hook(CLASS.InventoryView, "on_exit", function(func, self, ...)
	func(self, ...)
	-- Update flashlight
	if mod._update_flashlight then
		if mod:has_flashlight_attachment() then mod:toggle_flashlight(true) end
		if mod:has_laser_pointer_attachment() then mod:toggle_laser(true) end
	end
end)

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

-- Debug print
mod.print = function(self, message, skip)
	if self._debug and not skip then self:echo(message) end
end

-- Get gear id from item
mod.get_gear_id = function(self, item, original)
	return item and (item.__gear and item.__gear.uuid or item.__original_gear_id or item.__gear_id or item.gear_id)
end

mod.get_slot_info_id = function(self, item)
	return item.gear_id or item.__gear_id or item.__original_gear_id or item.__gear and item.__gear.uuid
end

-- Set attachment for specified gear id and slot
mod.set_gear_setting = function(self, gear_id, attachment_slot, attachment)
	if not attachment or (attachment and (string_find(attachment, "default") or attachment == "default")) then
		self:set(tostring(gear_id).."_"..attachment_slot, nil)
	else
		self:set(tostring(gear_id).."_"..attachment_slot, attachment)
	end
end

-- Get attachment from specified gear id and slot
-- Optional: Item to get real default attachment
mod.get_gear_setting = function(self, gear_id, attachment_slot, optional_item)
	local attachment = self:get(tostring(gear_id).."_"..attachment_slot)
	-- Check attachment
	if not attachment and optional_item then
		-- Get real vanilla attachment
		attachment = self:get_actual_default_attachment(optional_item, attachment_slot)
	end
	-- Check attachment
	if not attachment and optional_item then
		local item_name = self:item_name_from_content_string(optional_item.name)
		-- Get custom slot default
		if self.attachment[item_name] and self.attachment[item_name][attachment_slot] then
			attachment = self.attachment[item_name][attachment_slot][1].id
		end
	end
	return attachment
end

-- Get vanilla default attachment of specified item and slot
mod.get_actual_default_attachment = function(self, item, attachment_slot)
	-- Check item
	if item then
		-- Setup master items backup
		self:setup_item_definitions()
		-- Get original item
		local original_item = self:persistent_table("weapon_customization").item_definitions[item.name]
		local item_name = self:item_name_from_content_string(item.name)
		-- Check item
		if original_item and original_item.attachments then
			-- Find attachment
			local attachment = self:_recursive_find_attachment(original_item.attachments, attachment_slot)
			if attachment then
				-- Check attachment data
				if item_name and self.attachment_models[item_name] then
					-- Iterate attachments
					for attachment_name, attachment_data in pairs(self.attachment_models[item_name]) do
						-- Compare model
						if attachment_data.model == attachment.item and attachment_data.model ~= "" then
							return attachment_name
						end
					end
				end
			end
		end
	end
end

-- Redo weapon attachments by unequipping and reequipping weapon
mod.redo_weapon_attachments = function(self, item)
	local gear_id = mod:get_gear_id(item)
	local slot_name, weapon = self:get_weapon_from_gear_id(gear_id)
	if weapon then
		-- Get latest frame
		-- local fixed_time_step = game_parameters.fixed_time_step
		local gameplay_time = self.time_manager:time("gameplay")
		-- local latest_frame = math_floor(gameplay_time / fixed_time_step)
		local latest_frame = FixedFrame.get_latest_fixed_time()
		-- Reset flashlight cache
		self.attached_flashlights[gear_id] = {}
		self:persistent_table("weapon_customization").flashlight_on = false
		-- Reset laser pointer cache
		-- self:despawn_all_lasers()
		self:reset_laser_pointer()
		self.attached_laser_pointers[gear_id] = {}
		-- self:persistent_table("weapon_customization").laser_pointer_on = 0
		-- Unequip
		self.visual_loadout_extension:unequip_item_from_slot(slot_name, latest_frame)
		-- Get time
		local t = self.time_manager:time("gameplay")
		-- Equip
		self.visual_loadout_extension:equip_item_to_slot(item, slot_name, nil, gameplay_time)
		self:print("redo_weapon_attachments - done")
		-- Trigger flashlight update
		self._update_flashlight = true
	else self:print("redo_weapon_attachments - weapon is nil") end
end

-- ##### ┬┌┐┌┬┌┬┐┬┌─┐┬  ┬┌─┐┌─┐ #######################################################################################
-- ##### │││││ │ │├─┤│  │┌─┘├┤  #######################################################################################
-- ##### ┴┘└┘┴ ┴ ┴┴ ┴┴─┘┴└─┘└─┘ #######################################################################################

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

-- Import mod files
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_utilities")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_visible_equipment")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_flashlight")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_laser_pointer")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_visual_loadout")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_fix")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_anchors")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_debug")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_patch")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_sights")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_view")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_mod_options")

-- Reinitialize on mod reload
if managers and managers.player._game_state ~= nil then
	mod:init()
end
