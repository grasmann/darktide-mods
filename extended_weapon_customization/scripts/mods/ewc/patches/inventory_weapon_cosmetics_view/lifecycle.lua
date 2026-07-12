-- File: extended_weapon_customization/scripts/mods/ewc/patches/inventory_weapon_cosmetics_view/lifecycle.lua
local mod = get_mod("extended_weapon_customization"); if not mod then return end

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local inventory_weapon_cosmetics_view_definitions = mod:original_require(
	"scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view_definitions")
local master_items = mod:original_require("scripts/backend/master_items")
local items = mod:original_require("scripts/utilities/items")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
local CLASS = CLASS
local table = table
local get_mod = get_mod
local localize = Localize
local math_uuid = math.uuid
local table_clear = table.clear
local table_size = table.size
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local pt = mod:pt()

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

-- Performance impact: negligible during normal play. These helpers only run when the cosmetics view enters/leaves
-- attachment customization mode, with per-view setup work equivalent to the previous monolithic implementation.
mod.inventory_weapon_cosmetics_view_init = function(self, context)
	-- Modding tools
	self.modding_tools = get_mod("modding_tools")

	-- Custom init
	self.customize_attachments = context and context.customize_attachments

	-- Check customization menu
	if self.customize_attachments then
		-- Modify view definitions
		mod:inventory_weapon_cosmetics_view_adjust_definitions(self._definitions)

		-- Get selected item template
		local weapon_template = self._selected_item.weapon_template
		-- Get supported attachment slots
		local attachments = weapon_template and mod.settings.attachments[weapon_template]
		-- Check attachments
		if attachments then
			-- Iterate through attachments
			for attachment_slot, attachment_entries in pairs(attachments) do
				-- Attachment ino
				local attachment_item_path = mod:fetch_attachment(self._selected_item.attachments, attachment_slot)
				-- Set selected element name
				self["_equipped_" .. attachment_slot .. "_name"] = attachment_item_path or
					"content/items/weapons/player/trinkets/unused_trinket"
				self["_selected_" .. attachment_slot .. "_name"] = attachment_item_path or
					"content/items/weapons/player/trinkets/unused_trinket"
				-- Check attachment path
				if attachment_item_path then
					-- First equipped slot_name
					if attachment_item_path and not self.first_equipped_slot_name then
						self.first_equipped_slot_name = attachment_slot
					end
					-- Get attachment item
					local attachment_item = master_items.get_item(attachment_item_path)
					-- Set selected element
					self["_equipped_" .. attachment_slot] = attachment_item
					self["_selected_" .. attachment_slot] = attachment_item
				end
			end
		end
	end
end

mod.inventory_weapon_cosmetics_view_destroy_forward_gui = function(self)
	-- Check customization menu
	if self.customize_attachments then
		-- Set flags
		mod.is_in_customization_menu = nil
		mod.customization_menu_slot_name = nil
		-- Clear item origin table
		table_clear(pt.items_originating_from_customization_menu)

		-- Check selected material overrides
		if self.selected_color_override or self.selected_pattern_override or self.selected_wear_override then
			-- Reload gear settings
			self:reload_gear_settings()

			-- Reset selected material overrides
			self.selected_color_override = nil
			self.selected_pattern_override = nil
			self.selected_wear_override = nil
		end
	end
end

mod.inventory_weapon_cosmetics_view_on_enter = function(self)
	if not self.customize_attachments then
		return false
	end

	CLASS.InventoryWeaponCosmeticsView.super.on_enter(self)

	mod.is_in_customization_menu = true

	self.finished_tutorial = mod:get("customization_menu_finished_tutorial")

	self._render_settings.alpha_multiplier = 0

	self:_setup_forward_gui()

	self._background_widget = self:_create_widget("background",
		inventory_weapon_cosmetics_view_definitions.background_widget)

	if not self._selected_item then
		return true
	end

	local grid_size = inventory_weapon_cosmetics_view_definitions.grid_settings.grid_size

	self._content_blueprints = mod:original_require("scripts/ui/view_content_blueprints/item_blueprints")(grid_size)

	self:_setup_input_legend()

	local tabs_content = {}

	if self._presentation_item then
		local gear_id = math_uuid()

		self._presentation_item.gear_id = gear_id
		self._presentation_item.__gear_id = gear_id
		self._presentation_item.__original_gear_id = gear_id
		self._presentation_item.__attachment_customization = true

		self:update_presentation_item()

		pt.items_originating_from_customization_menu[gear_id] = true

		local weapon_template = self._presentation_item.weapon_template
		local attachments = weapon_template and mod.settings.attachments[weapon_template]
		if attachments then
			for attachment_slot, attachment_entries in pairs(attachments) do
				if mod:selectable_attachment_count(attachment_entries) > 1 and not mod:cached_table_contains(mod.settings.hide_attachment_slots_in_menu, attachment_slot) then
					tabs_content[#tabs_content + 1] = {
						display_name = attachment_slot,
						slot_name = attachment_slot,
						get_item_filters = function(slot_name, item_type)
							local slot_filter = slot_name and {
								slot_name,
							}
							return slot_filter, nil
						end,
						setup_selected_item_function = function(real_item, selected_item)
							if real_item.name == self["_selected_" .. attachment_slot .. "_name"] then
								self["_selected_" .. attachment_slot] = real_item
							end
						end,
						get_empty_item = function(selected_item, presentation_item)
							local empty_master_item = master_items.get_item(
								"content/items/weapons/player/trinkets/unused_trinket")
							local item = items.weapon_trinket_preview_item(empty_master_item)
							item.empty_item = true
							return item
						end,
						generate_visual_item_function = function(slot_name, real_item, attachment_data)
							local real_item = real_item or self["_selected_" .. slot_name]
							local attachment_item = master_items.get_item(real_item.name)
							local visual_item = items.weapon_trinket_preview_item(real_item)

							local gear_id = math_uuid()

							visual_item.gear_id = gear_id
							visual_item.__attachment_customization = true
							attachment_item.icon_render_unit_rotation_offset = attachment_data and
								attachment_data.icon_render_unit_rotation_offset or { 90, 0, 0 }
							attachment_item.icon_render_camera_position_offset = attachment_data and
								attachment_data.icon_render_camera_position_offset or { 0, -1, 0 }

							mod:gear_settings(gear_id, {
								[slot_name] = real_item and real_item.name or "",
							})

							mod:modify_item(visual_item.__data or visual_item.__master_item or visual_item)

							return visual_item
						end,
						apply_on_preview = function(real_item, presentation_item)
							if real_item then
								self["_selected_" .. attachment_slot .. "_name"] = real_item.name
								self["_selected_" .. attachment_slot] = real_item
							end
						end,
					}
				end
			end
		end

		-- Get attachment slots from item
		local attachment_slots = mod:fetch_attachment_slots(self._selected_item.attachments)
		-- Iterate through attachment slots
		for attachment_slot, data in pairs(attachment_slots) do
			-- Get material overrides from item
			local material_overrides = mod:gear_material_overrides(self._selected_item, nil, attachment_slot)
			-- Check material overrides
			if material_overrides then
				-- Apply material overrides to presentation item
				mod:gear_material_overrides(self._presentation_item, nil, attachment_slot, material_overrides)
			end
		end
	end

	if not self._on_enter_anim_id then
		self._on_enter_anim_id = self:_start_animation("on_enter", self._widgets_by_name, self)
	end

	self.attachment_selection_rotation_offset = 0
	self.current_default_rotation_angle = 0

	if self._presentation_item then
		self:_setup_weapon_preview()

		local gear_id = mod:gear_id(self._presentation_item, true)
		pt.items_originating_from_customization_menu[gear_id] = true

		self:_preview_item(self._presentation_item)
		self._weapon_preview:center_align(0, { -.3, 0, -.2 })
	end

	self:present_grid_layout({})
	self:_register_button_callbacks()
	self:_fetch_inventory_items(tabs_content)
	self:_setup_menu_tabs(tabs_content)
	self:cb_switch_tab(1)

	local weapon_preview = self._weapon_preview

	if weapon_preview then
		weapon_preview:center_align(1, { -.3, 0, -.2 })
	end

	if self._widgets_by_name.tip_1 then
		self._widgets_by_name.tip_1.content.title = "title test title"
		self._widgets_by_name.tip_1.content.text = "test test text"
	end

	if self._widgets_by_name.plugin_warning then
		local num_plugins = table_size(pt.loaded_plugins)
		self._widgets_by_name.plugin_warning.content.title = localize("loc_weapon_inventory_plugin_warning")
		self._widgets_by_name.plugin_warning.visible = num_plugins == 0
	end

	self:create_color_dropdown()
	self:create_pattern_dropdown()
	self:create_wear_dropdown()

	-- Preview presentation item
	-- Fix weapon not showing modified after opening menu
	self:_preview_item(self._selected_item)

	return true
end
