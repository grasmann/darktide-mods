-- File: extended_weapon_customization/scripts/mods/ewc/patches/inventory_weapon_cosmetics_view/equip.lua
local mod = get_mod("extended_weapon_customization"); if not mod then return end

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local master_items = mod:original_require("scripts/backend/master_items")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
local math = math
local table = table
local pairs = pairs
local managers = Managers
local math_uuid = math.uuid
local table_clear = table.clear
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local pt = mod:pt()
local OVERRIDE_TYPE = table.enum("color", "pattern", "wear")

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.inventory_weapon_cosmetics_view_install_equip = function(instance)
	-- Performance impact: negligible. This installs view instance helpers once when the vanilla class module loads.

	instance.update_presentation_item = function(self, optional_item)
		-- Get item
		local item = optional_item or self._selected_item
		-- Create presentation item from item
		self._presentation_item = master_items.create_preview_item_instance(item, true)
		-- Generate gear id
		local gear_id = math_uuid()
		-- Set presentation item gear id
		self._presentation_item.gear_id = gear_id
		self._presentation_item.__gear_id = gear_id
		self._presentation_item.__original_gear_id = gear_id
		self._presentation_item.__attachment_customization = true

		-- Mark gear id origin
		pt.items_originating_from_customization_menu[gear_id] = true
		-- Preview presentation item
		self:_preview_item(self._presentation_item)

		-- Switch tab
		self:cb_switch_tab(1)
	end

	instance.update_real_world_item = function(self, optional_item)
		-- Get item
		local item = optional_item or self._selected_item

		-- -- Gear id
		-- local gear_id = mod:gear_id(item)
		-- -- Clear cached item
		-- mod:clear_mod_item(gear_id)

		-- Trigger item icon update
		managers.ui:item_icon_updated(item)
		managers.event:trigger("event_item_icon_updated", item)
		managers.event:trigger("event_replace_list_item", item)

		-- Reevaluate packages
		mod:reevaluate_packages()
		-- Redo weapon attachments
		mod:redo_weapon_attachments(self._selected_item)
	end

	instance.reload_gear_settings = function(self)
		-- Clear material overrides for item
		mod:clear_gear_material_overrides(self._selected_item)
		-- Get gear id
		local gear_id = mod:gear_id(self._selected_item)
		-- Reload gear settings from file
		if not mod:gear_settings(gear_id, nil, true) then
			mod:clear_gear_material_overrides(self._presentation_item)
		end
	end

	instance.cb_on_reset_pressed = function(self)
		-- Toggle flags
		mod.is_in_customization_menu = nil
		mod.customization_menu_slot_name = nil

		-- Clear item origin table
		table_clear(pt.items_originating_from_customization_menu)

		-- Reset item
		local gear_id = mod:gear_id(self._selected_item)
		mod:delete_gear_settings(gear_id, true)
		mod:reset_item(self._selected_item, true)

		-- Reset presentation item
		local fake_gear_id = mod:gear_id(self._presentation_item, true)
		mod:delete_gear_settings(fake_gear_id, true)
		mod:reset_item(self._presentation_item, true)

		-- Get attachment slots from item
		local attachment_slots = mod:fetch_attachment_slots(self._selected_item.attachments)
		-- Iterate through attachment slots
		for attachment_slot, data in pairs(attachment_slots) do
			-- Attachment info
			local attachment_item_path = mod:fetch_attachment(self._selected_item.attachments, attachment_slot)
			local attachment_item = master_items.get_item(attachment_item_path)
			-- Set selected element name
			self["_equipped_" .. attachment_slot .. "_name"] = attachment_item_path or
				"content/items/weapons/player/trinkets/unused_trinket"
			self["_selected_" .. attachment_slot .. "_name"] = attachment_item_path or
				"content/items/weapons/player/trinkets/unused_trinket"
			-- Set selected element
			self["_equipped_" .. attachment_slot] = attachment_item
			self["_selected_" .. attachment_slot] = attachment_item
		end

		-- Update real world item
		self:update_real_world_item()
		-- Update presentation item
		self:update_presentation_item()

		-- Mark gear id origin
		pt.items_originating_from_customization_menu[fake_gear_id] = true

		-- Preview presentation item
		self:_preview_item(self._presentation_item)

		-- Switch tab
		local index = self._selected_tab_index
		self._selected_tab_index = nil
		self:cb_switch_tab(index)

		-- Toggle flags
		mod.is_in_customization_menu = true
	end

	instance.cb_on_random_pressed = function(self)
		-- Advance tutorial
		if self.tutorial_step == 5 then
			self.tutorial_step = 6
		end

		-- Toggle flags
		mod.is_in_customization_menu = nil
		mod.customization_menu_slot_name = nil

		-- Clear item origin table
		table_clear(pt.items_originating_from_customization_menu)

		-- Randomize item
		local new_gear_settings = mod:randomize_item(self._selected_item)
		-- Apply new gear settings to item
		local gear_id = mod:gear_id(self._selected_item)
		mod:gear_settings(gear_id, new_gear_settings, true)
		-- Modify item
		mod:modify_item(self._selected_item, false, new_gear_settings)
		-- Apply fixes
		mod:apply_attachment_fixes(self._selected_item)

		-- Iterate through gear settings
		for attachment_slot, replacement_path in pairs(new_gear_settings) do
			-- Attachment info
			local attachment_item = master_items.get_item(replacement_path)
			-- Set selected element name
			self["_equipped_" .. attachment_slot .. "_name"] = replacement_path or
				"content/items/weapons/player/trinkets/unused_trinket"
			self["_selected_" .. attachment_slot .. "_name"] = replacement_path or
				"content/items/weapons/player/trinkets/unused_trinket"
			-- Set selected element
			self["_equipped_" .. attachment_slot] = attachment_item
			self["_selected_" .. attachment_slot] = attachment_item
		end

		-- Update real world item
		self:update_real_world_item()
		-- Update presentation item
		self:update_presentation_item()

		-- Mark gear id origin
		local fake_gear_id = mod:gear_id(self._presentation_item, true)
		pt.items_originating_from_customization_menu[fake_gear_id] = true

		-- Preview presentation item
		self:_preview_item(self._presentation_item)

		-- Switch tab
		local index = self._selected_tab_index
		self._selected_tab_index = nil
		self:cb_switch_tab(index)

		-- Toggle flags
		mod.is_in_customization_menu = true
	end

	instance.cb_on_alternate_fire_toggle_pressed = function(self, init)
		-- Get gear id
		local gear_id = mod:gear_id(self._selected_item)
		-- Get alternate fire setting
		local alternate_fire_list = mod:get(mod.inventory_weapon_cosmetics_view_alternate_fire_setting) or {}
		if not init then
			-- Toggle alternate fire
			alternate_fire_list[gear_id] = not alternate_fire_list[gear_id]
		elseif not alternate_fire_list[gear_id] then
			alternate_fire_list[gear_id] = true
		end
		-- Set alternate fire setting
		mod:set(mod.inventory_weapon_cosmetics_view_alternate_fire_setting, alternate_fire_list)

		-- Advance tutorial
		if self.tutorial_step == 4 then
			self.tutorial_step = 5
		end
	end

	instance.cb_on_crosshair_toggle_pressed = function(self, init)
		-- Get gear id
		local gear_id = mod:gear_id(self._selected_item)
		-- Get crosshair setting
		local crosshair_list = mod:get(mod.inventory_weapon_cosmetics_view_crosshair_list_setting) or {}
		if not init then
			-- Toggle crosshair
			crosshair_list[gear_id] = not crosshair_list[gear_id]
		elseif not crosshair_list[gear_id] then
			crosshair_list[gear_id] = true
		end
		-- Set crosshair setting
		mod:set(mod.inventory_weapon_cosmetics_view_crosshair_list_setting, crosshair_list)

		-- Advance tutorial
		if self.tutorial_step == 4 then
			self.tutorial_step = 5
		end
	end

	instance.cb_on_damage_type_toggle_pressed = function(self, init)
		-- Get gear id
		local gear_id = mod:gear_id(self._selected_item)
		-- Get damage type active setting
		local damage_type_active_list = mod:get(mod.inventory_weapon_cosmetics_view_damage_type_active_setting) or {}
		if not init then
			-- Toggle damage type
			damage_type_active_list[gear_id] = not damage_type_active_list[gear_id]
		elseif not damage_type_active_list[gear_id] then
			damage_type_active_list[gear_id] = true
		end
		-- Set damage type setting
		mod:set(mod.inventory_weapon_cosmetics_view_damage_type_active_setting, damage_type_active_list)

		-- Advance tutorial
		if self.tutorial_step == 4 then
			self.tutorial_step = 5
		end
	end

	instance.cb_on_grid_entry_right_pressed = function(self, widget, element)
		instance.super.cb_on_grid_entry_left_pressed(self, widget, element)

		-- Advance tutorial
		if self.tutorial_step == 3 then
			self.tutorial_step = 4
		end

		-- Preview element
		self:_preview_element(element)

		-- Equip
		self:cb_on_equip_pressed()
	end

	instance.cb_on_grid_entry_left_pressed = function(self, widget, element)
		instance.super.cb_on_grid_entry_left_pressed(self, widget, element)

		-- Advance tutorial
		if self.tutorial_step == 3 then
			self.tutorial_step = 4
		end
	end
end

mod.inventory_weapon_cosmetics_view_equip_selected = function(self)
	-- Performance impact: low and user-triggered only. This runs only when the equip button is pressed in the customization view.

	-- Get slot name
	local slot_name = self:selected_slot_name()

	-- Set flags
	mod.is_in_customization_menu = nil
	mod.customization_menu_slot_name = nil

	-- Clear item origin table
	table_clear(pt.items_originating_from_customization_menu)

	-- Get gear id
	local gear_id = mod:gear_id(self._selected_item)

	-- Create new gear settings
	local gear_settings = {}

	-- Get possible attachment slots
	local attachments = mod.settings.attachments[self._selected_item.weapon_template]

	-- Iterate through attachment slots
	for attachment_slot, attachment_name in pairs(attachments) do
		-- Set gear setting for attachment slot
		gear_settings[attachment_slot] = self["_selected_" .. attachment_slot .. "_name"] or
			"content/items/weapons/player/trinkets/unused_trinket"
		-- Set equipped name
		self["_equipped_" .. attachment_slot .. "_name"] = gear_settings[attachment_slot]
	end

	-- Get attachment slots from item
	local attachment_slots = mod:fetch_attachment_slots(self._presentation_item.attachments)
	-- Iterate through attachment slots
	for attachment_slot, data in pairs(attachment_slots) do
		-- Get material overrides from item
		local material_overrides = mod:gear_material_overrides(self._presentation_item, nil, attachment_slot)
		-- Check material overrides
		if material_overrides then
			-- Apply material overrides to presentation item
			mod:gear_material_overrides(self._selected_item, nil, attachment_slot, material_overrides)
			-- gear_settings.material_overrides = gear_settings.material_overrides or {}
			-- gear_settings.material_overrides[attachment_slot] = material_overrides
		end
	end

	-- Reset color overrides
	if slot_name and self.selected_color_override == "" then
		mod:clear_gear_material_overrides(self._selected_item, nil, slot_name, { OVERRIDE_TYPE.color })
	end

	-- Reset pattern overrides
	if slot_name and self.selected_pattern_override == "" then
		mod:clear_gear_material_overrides(self._selected_item, nil, slot_name, { OVERRIDE_TYPE.pattern })
	end

	-- Reset wear overrides
	if slot_name and self.selected_wear_override == "" then
		mod:clear_gear_material_overrides(self._selected_item, nil, slot_name, { OVERRIDE_TYPE.wear })
	end

	-- Clear selected material overrides
	self.selected_color_override = nil
	self.selected_pattern_override = nil
	self.selected_wear_override = nil

	self:cb_on_alternate_fire_toggle_pressed(true)
	self:cb_on_crosshair_toggle_pressed(true)
	self:cb_on_damage_type_toggle_pressed(true)

	-- Set new gear settings
	mod:gear_settings(gear_id, gear_settings, true)

	-- Update real world item
	self:update_real_world_item()

	-- Update inventory background view
	local inventory_background_view = mod:get_view("inventory_background_view")
	if inventory_background_view then
		inventory_background_view:event_force_refresh_inventory()
	end

	-- Set flag
	mod.is_in_customization_menu = true

	-- Switch tab
	self:cb_switch_tab(self._selected_tab_index)

	return true
end
