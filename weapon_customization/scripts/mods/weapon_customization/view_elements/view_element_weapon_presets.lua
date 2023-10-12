local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local ButtonPassTemplates = mod:original_require("scripts/ui/pass_templates/button_pass_templates")
local InputDevice = mod:original_require("scripts/managers/input/input_device")
local InputUtils = mod:original_require("scripts/managers/input/input_utils")
local ItemSlotSettings = mod:original_require("scripts/settings/item/item_slot_settings")
local UIFonts = mod:original_require("scripts/managers/ui/ui_fonts")
local UIRenderer = mod:original_require("scripts/managers/ui/ui_renderer")
local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")
local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
local ViewElementGrid = mod:original_require("scripts/ui/view_elements/view_element_grid/view_element_grid")

local Definitions = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/view_elements/view_element_weapon_presets_definitions")
local ViewElementWeaponPresetsSettings = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/view_elements/view_element_weapon_presets_settings")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
	local table = table
	local table_merge_recursive = table.merge_recursive
	local table_clone = table.clone
	local managers = Managers
	local class = class
	local callback = callback
	local RESOLUTION_LOOKUP = RESOLUTION_LOOKUP
	local Color = Color
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.get_weapon_presets = function(self, gear_id)
	return {
		["1f94107d-a07a-4885-9a69-19917ba03a29"] = {
			{
				barrel = "barrel_03",
				emblem_left = "emblem_left_02",
				emblem_right = "emblem_right_10",
				flashlight = "laser_pointer",
				grip = "grip_03",
				magazine = "magazine_03",
				receiver = "receiver_03",
				trinket_hook = "trinket_hook_01",
			},
			{
				barrel = "barrel_01",
				emblem_left = "emblem_left_01",
				emblem_right = "emblem_right_4",
				flashlight = "flashlight_02",
				grip = "grip_01",
				magazine = "magazine_02",
				receiver = "receiver_01",
				trinket_hook = "trinket_hook_02",
			}
		}
	}
end

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local ViewElementWeaponPresets = class("ViewElementWeaponPresets", "ViewElementBase")

ViewElementWeaponPresets.init = function (self, parent, draw_layer, start_scale, optional_menu_settings)
	ViewElementWeaponPresets.super.init(self, parent, draw_layer, start_scale, Definitions)

	if optional_menu_settings then
		self._menu_settings = table_merge_recursive(table_clone(ViewElementWeaponPresetsSettings), optional_menu_settings)
	else
		self._menu_settings = ViewElementWeaponPresetsSettings
	end

	self._is_inventory_ready = false
	self._release_input_frame_delay = 0
	self._is_handling_navigation_input = false
	self._pivot_offset = {
		0,
		0
	}
	self._costumization_open = false

	self:_setup_tooltip_grid()
	self:_setup_preset_buttons()

	-- local local_player_id = 1
	-- local player_manager = managers.player
	-- local player = player_manager and player_manager:local_player(local_player_id)
	-- local character_id = player and player:character_id()
	-- local save_manager = managers.save
	-- local character_data = character_id and save_manager and save_manager:character_data(character_id)
	-- local weapon_presets = character_data and character_data.weapon_presets
	local weapon_presets = mod:get_weapon_presets(self._menu_settings.gear_id)
	local intro_presented = false

	if not intro_presented then
		self:_setup_intro_grid()

		local pulse_tooltip = true

		self:_set_tooltip_visibility(true, pulse_tooltip)

		-- if not weapon_presets and character_data then
		-- 	local default_character_data = SaveData.default_character_data
		-- 	local default_weapon_presets = default_character_data.weapon_presets
		-- 	weapon_presets = table.clone(default_weapon_presets)
		-- 	character_data.weapon_presets = weapon_presets

		-- 	Managers.save:queue_save()
		-- end

		-- if weapon_presets then
		-- 	weapon_presets.intro_presented = true
		-- end
	else
		self:_setup_custom_icons_grid()
		self:_set_tooltip_visibility(false)
	end

	local widgets_by_name = self._widgets_by_name
	local add_button_widget = widgets_by_name.weapon_preset_add_button
	add_button_widget.content.hotspot.pressed_callback = callback(self, "cb_add_new_weapon_preset")
end

ViewElementWeaponPresets.sync_weapons_states = function (self)
	self:_sync_weapon_buttons_items_status()
end

ViewElementWeaponPresets._setup_tooltip_grid = function (self)
	local grid_scenegraph_id = "weapon_preset_tooltip_grid"
	local definitions = self._definitions
	local scenegraph_definition = definitions.scenegraph_definition
	local grid_scenegraph = scenegraph_definition[grid_scenegraph_id]
	local grid_size = grid_scenegraph.size
	local mask_padding_size = 40
	local grid_settings = {
		scrollbar_width = 7,
		widget_icon_load_margin = 0,
		use_select_on_focused = false,
		edge_padding = 0,
		hide_dividers = true,
		use_is_focused_for_navigation = false,
		use_terminal_background = false,
		title_height = 0,
		hide_background = true,
		grid_spacing = {
			0,
			0
		},
		grid_size = grid_size,
		mask_size = {
			grid_size[1] + mask_padding_size,
			grid_size[2] + mask_padding_size
		}
	}
	local reference_name = "weapon_preset_tooltip_grid"
	local layer = self._draw_layer + 10
	local scale = self._render_scale or RESOLUTION_LOOKUP.scale
	local grid = ViewElementGrid:new(self, layer, scale, grid_settings)
	self._weapon_preset_tooltip_grid = grid
end

ViewElementWeaponPresets._setup_intro_grid = function (self) -- Done
	local layout = {
		{
			widget_type = "dynamic_spacing",
			size = {
				225,
				25
			}
		},
		{
			widget_type = "header",
			text = mod:localize("loc_inventory_menu_weapon_preset_intro_text_1")
		},
		{
			widget_type = "dynamic_spacing",
			size = {
				225,
				20
			}
		},
		{
			widget_type = "header",
			text = mod:localize("loc_inventory_menu_weapon_preset_intro_text_2")
		},
		{
			widget_type = "dynamic_spacing",
			size = {
				225,
				25
			}
		},
		{
			widget_type = "dynamic_spacing",
			size = {
				86,
				40
			}
		},
		{
			texture = "content/ui/materials/icons/generic/aquila",
			widget_type = "texture",
			size = {
				52,
				20
			},
			color = Color.terminal_icon(255, true)
		},
		{
			widget_type = "dynamic_spacing",
			size = {
				86,
				40
			}
		}
	}

	self:_present_tooltip_grid_layout(layout)

	self._intro_active = true
end

ViewElementWeaponPresets._setup_custom_icons_grid = function (self)
	self._custom_icons_initialized = true
	local definitions = self._definitions
	local layout = {
		{
			widget_type = "dynamic_spacing",
			size = {
				225,
				10
			}
		},
		{
			widget_type = "header",
			text = Localize("loc_inventory_menu_weapon_preset_customize_text")
		},
		{
			widget_type = "dynamic_spacing",
			size = {
				225,
				10
			}
		}
	}
	local optional_preset_icon_reference_keys = ViewElementWeaponPresetsSettings.optional_preset_icon_reference_keys
	local optional_preset_icons_lookup = ViewElementWeaponPresetsSettings.optional_preset_icons_lookup

	for i = 1, #optional_preset_icon_reference_keys do
		local icon_key = optional_preset_icon_reference_keys[i]
		local icon_texture = optional_preset_icons_lookup[icon_key]
		layout[#layout + 1] = {
			widget_type = "icon",
			icon = icon_texture,
			icon_key = icon_key
		}
	end

	layout[#layout + 1] = {
		widget_type = "dynamic_spacing",
		size = {
			225,
			10
		}
	}
	layout[#layout + 1] = {
		delete_button = true,
		widget_type = "dynamic_button",
		text = Localize("loc_inventory_menu_weapon_preset_delete")
	}
	layout[#layout + 1] = {
		widget_type = "dynamic_spacing",
		size = {
			225,
			10
		}
	}

	self:_present_tooltip_grid_layout(layout)
end

ViewElementWeaponPresets._present_tooltip_grid_layout = function (self, layout)
	local definitions = self._definitions
	local weapon_preset_grid_blueprints = definitions.weapon_preset_grid_blueprints
	local grid = self._weapon_preset_tooltip_grid

	grid:present_grid_layout(layout, weapon_preset_grid_blueprints, callback(self, "cb_on_weapon_preset_icon_grid_left_pressed"), nil, nil, nil, callback(self, "cb_on_weapon_preset_icon_grid_layout_changed"), nil)
end

ViewElementWeaponPresets._setup_preset_buttons = function (self)
	local weapon_buttons_widgets = self._weapon_buttons_widgets

	if weapon_buttons_widgets then
		for i = 1, #weapon_buttons_widgets do
			local widget = weapon_buttons_widgets[i]
			local name = widget.name

			self:_unregister_widget_name(name)
		end

		table.clear(weapon_buttons_widgets)
	else
		weapon_buttons_widgets = {}
	end

	local button_width = 44
	local button_spacing = 6
	local total_width = 0
	local optional_preset_icon_reference_keys = ViewElementWeaponPresetsSettings.optional_preset_icon_reference_keys
	local optional_preset_icons_lookup = ViewElementWeaponPresetsSettings.optional_preset_icons_lookup
	local definitions = self._definitions
	local weapon_preset_button = definitions.weapon_preset_button
	-- local active_weapon_preset_id = weaponUtils.get_active_weapon_preset_id()
	-- local weapon_presets = weaponUtils.get_weapon_presets()
	local weapon_presets = mod:get_weapon_presets(self._menu_settings.gear_id)
	local active_weapon_preset_id = 0
	local num_weapon_presets = weapon_presets and #weapon_presets or 0

	for i = num_weapon_presets, 1, -1 do
		local weapon_preset = weapon_presets[i]
		local custom_icon_key = weapon_preset and weapon_preset.custom_icon_key
		local widget_name = "weapon_button_" .. i
		local widget = self:_create_widget(widget_name, weapon_preset_button)
		weapon_buttons_widgets[i] = widget
		local offset = widget.offset
		offset[1] = -total_width
		local content = widget.content
		local hotspot = content.hotspot
		hotspot.pressed_callback = callback(self, "on_weapon_preset_index_change", i)
		hotspot.right_pressed_callback = callback(self, "on_weapon_preset_index_customize", i)
		local is_selected = i == active_weapon_preset_id

		if is_selected then
			self._active_weapon_preset_id = i
		end

		hotspot.is_selected = is_selected
		local default_icon_index = math.index_wrapper(i, #optional_preset_icon_reference_keys)
		local default_icon_key = optional_preset_icon_reference_keys[default_icon_index]
		local default_icon = optional_preset_icons_lookup[custom_icon_key or default_icon_key]
		content.icon = default_icon
		total_width = total_width + button_width

		if i > 1 then
			total_width = total_width + button_spacing
		end
	end

	self._weapon_buttons_widgets = weapon_buttons_widgets
	local panel_width = total_width + button_width + 45

	self:_set_scenegraph_size("weapon_preset_button_panel", panel_width)
	self:_force_update_scenegraph()

	local widgets_by_name = self._widgets_by_name
	local add_button_widget = widgets_by_name.weapon_preset_add_button
	add_button_widget.content.hotspot.disabled = ViewElementWeaponPresetsSettings.max_weapon_presets <= num_weapon_presets

	-- self:_sync_weapon_buttons_items_status()
end

-- ViewElementWeaponPresets._sync_weapon_buttons_items_status = function (self)
-- 	-- local weapon_presets = weaponUtils.get_weapon_presets()
-- 	local weapon_presets = {}
-- 	local num_weapon_presets = weapon_presets and #weapon_presets or 0
-- 	local weapon_buttons_widgets = self._weapon_buttons_widgets

-- 	if num_weapon_presets > 0 and weapon_buttons_widgets then
-- 		for i = 1, #weapon_buttons_widgets do
-- 			local weapon_preset = weapon_presets[i]
-- 			local widget = weapon_buttons_widgets[i]
-- 			local content = widget.content
-- 			content.missing_content = self:is_weapon_preset_missing_items(weapon_preset)
-- 		end
-- 	end
-- end

-- ViewElementWeaponPresets.is_weapon_preset_missing_items = function (self, weapon_preset)
-- 	local parent = self._parent
-- 	local loadout = weapon_preset.loadout
-- 	local missing_slots = {}

-- 	if loadout then
-- 		for slot_id, gear_id in pairs(loadout) do
-- 			local item = parent:_get_inventory_item_by_id(gear_id)

-- 			if not item then
-- 				missing_slots[slot_id] = true
-- 			end
-- 		end
-- 	end

-- 	return not table.is_empty(missing_slots), missing_slots
-- end

ViewElementWeaponPresets.can_add_weapon_preset = function (self)
	-- local weapon_presets = weaponUtils.get_weapon_presets()
	local weapon_presets = mod:get_weapon_presets(self._menu_settings.gear_id)
	if #weapon_presets < ViewElementWeaponPresetsSettings.max_weapon_presets then
		return true
	end

	return false
end

ViewElementWeaponPresets.cb_add_new_weapon_preset = function (self)
	if self._intro_active then
		self:_set_tooltip_visibility(false)

		self._intro_active = nil
	end

	-- local weapon_presets = weaponUtils.get_weapon_presets()
	local weapon_presets = mod:get_weapon_presets(self._menu_settings.gear_id)
	local num_weapon_presets = #weapon_presets

	if ViewElementWeaponPresetsSettings.max_weapon_presets <= num_weapon_presets then
		return
	end

	self:_play_sound(UISoundEvents.add_weapon_preset)

	-- local active_weapon_preset_id = weaponUtils.get_active_weapon_preset_id()
	local active_weapon_preset_id = 0
	-- local active_weapon_preset = active_weapon_preset_id and weaponUtils.get_weapon_preset(active_weapon_preset_id)
	local active_weapon_preset = active_weapon_preset_id and nil
	local new_loadout = {}
	local new_talents = nil
	local parent = self._parent

	if active_weapon_preset then
		local loadout = active_weapon_preset.loadout
		local talents = active_weapon_preset.talents
		new_loadout = table.create_copy(nil, loadout)
		new_talents = table.create_copy(nil, talents)
	else
		local player = parent:_player()
		local weapon = player:weapon()
		local loadout = weapon.loadout
		local talents = weapon.talents
		new_talents = table.create_copy(nil, talents)

		for slot_id, item in pairs(loadout) do
			local slot = ItemSlotSettings[slot_id]

			if slot.equipped_in_inventory and item.gear_id then
				new_loadout[slot_id] = item.gear_id
			end
		end

		local presentation_loadout = parent._preview_weapon_equipped_items

		for slot_id, item in pairs(presentation_loadout) do
			local slot = ItemSlotSettings[slot_id]

			if slot.equipped_in_inventory and item.gear_id then
				new_loadout[slot_id] = item.gear_id
			end
		end
	end

	local optional_preset_icon_reference_keys = ViewElementWeaponPresetsSettings.optional_preset_icon_reference_keys
	local icon_index = math.index_wrapper(num_weapon_presets + 1, #optional_preset_icon_reference_keys)
	local icon_key = optional_preset_icon_reference_keys[icon_index]
	-- local weapon_preset_id = weaponUtils.add_weapon_preset(new_loadout, new_talents, icon_key)
	local weapon_preset_id = 0

	if weapon_preset_id == 1 then
		-- weaponUtils.save_active_weapon_preset_id(weapon_preset_id)

	end

	self:_setup_preset_buttons()
	self:on_weapon_preset_index_change(weapon_preset_id)
end

ViewElementWeaponPresets._remove_weapon_preset = function (self, widget, element)
	local active_customize_preset_index = self._active_customize_preset_index

	if not active_customize_preset_index then
		return
	end

	local widget_content = widget.content
	local widget_hotspot = widget_content.hotspot
	widget_hotspot.anim_hover_progress = 0
	widget_hotspot.anim_input_progress = 0
	widget_hotspot.anim_focus_progress = 0
	widget_hotspot.anim_select_progress = 0
	local previously_active_weapon_preset_id = 0
	-- local previously_active_weapon_preset_id = weaponUtils.get_active_weapon_preset_id()
	self._active_weapon_preset_id = nil

	-- weaponUtils.remove_weapon_preset(active_customize_preset_index)

	local new_active_weapon_preset_id = previously_active_weapon_preset_id and math.max(previously_active_weapon_preset_id - 1, 1)

	-- if new_active_weapon_preset_id and not weaponUtils.get_weapon_preset(new_active_weapon_preset_id) then
	if new_active_weapon_preset_id then
		new_active_weapon_preset_id = nil
	end

	self:on_weapon_preset_index_customize()
	self:_setup_preset_buttons()

	if new_active_weapon_preset_id then
		self:on_weapon_preset_index_change(new_active_weapon_preset_id)
	else
		-- weaponUtils.save_active_weapon_preset_id(nil)
	end

	self:_play_sound(UISoundEvents.remove_weapon_preset)

	self._costumization_open = false
end

ViewElementWeaponPresets.cb_on_weapon_preset_icon_grid_layout_changed = function (self, layout, content_blueprints, left_click_callback, right_click_callback, display_name, optional_grow_direction)
	local grid = self._weapon_preset_tooltip_grid
	local grid_length = grid:grid_length()
	local menu_settings = grid:menu_settings()
	local grid_size = menu_settings.grid_size
	local mask_size = menu_settings.mask_size
	local new_grid_height = math.clamp(grid_length, 0, 700)
	grid_size[2] = new_grid_height
	mask_size[2] = new_grid_height

	self:_set_scenegraph_size("weapon_preset_tooltip_grid", nil, new_grid_height + 30)
	self:_set_scenegraph_size("weapon_preset_tooltip", nil, new_grid_height + 30)
	self:_update_weapon_preset_tooltip_grid_position()
	grid:force_update_list_size()
end

ViewElementWeaponPresets.cb_on_weapon_preset_icon_grid_left_pressed = function (self, widget, element)
	if element.delete_button then
		self:_remove_weapon_preset(widget, element)

		return
	end

	local active_customize_preset_index = self._active_customize_preset_index

	if not active_customize_preset_index then
		return
	end

	-- local weapon_preset = weaponUtils.get_weapon_preset(active_customize_preset_index)
	local weapon_preset = nil

	if not weapon_preset then
		return
	end

	local grid = self._weapon_preset_tooltip_grid
	local grid_widgets = grid:widgets()

	for i = 1, #grid_widgets do
		local grid_widget = grid_widgets[i]
		local equipped = grid_widget == widget
		local content = grid_widget.content
		content.equipped = equipped
	end

	local icon_key = element.icon_key

	if icon_key then
		local optional_preset_icons_lookup = ViewElementWeaponPresetsSettings.optional_preset_icons_lookup
		local default_icon = optional_preset_icons_lookup[icon_key]

		if default_icon then
			local weapon_buttons_widgets = self._weapon_buttons_widgets
			local button_widget = weapon_buttons_widgets[active_customize_preset_index]

			if button_widget then
				local content = button_widget.content
				content.icon = default_icon
				weapon_preset.custom_icon_key = icon_key

				-- Managers.save:queue_save()
			end
		end
	end
end

ViewElementWeaponPresets._update_weapon_preset_tooltip_grid_position = function (self)
	if not self._weapon_preset_tooltip_grid then
		return
	end

	self:_force_update_scenegraph()

	local position = self:scenegraph_world_position("weapon_preset_tooltip_grid")

	self._weapon_preset_tooltip_grid:set_pivot_offset(position[1], position[2])
end

ViewElementWeaponPresets.has_active_weapon_preset = function (self)
	return self._active_weapon_preset_id ~= nil
end

ViewElementWeaponPresets.customize_active_weapon_presets = function (self)
	local index = self._active_weapon_preset_id

	if index then
		self:on_weapon_preset_index_customize(index)
	end
end

ViewElementWeaponPresets.on_weapon_preset_index_customize = function (self, index)
	if index and index == self._active_customize_preset_index then
		return
	end

	if index then
		-- local weapon_preset = weaponUtils.get_weapon_preset(index)
		local weapon_preset = nil

		if not weapon_preset then
			return
		end

		if not self._custom_icons_initialized then
			self:_setup_custom_icons_grid()
		end

		self:_play_sound(UISoundEvents.default_click)
	end

	local weapon_buttons_widgets = self._weapon_buttons_widgets

	if weapon_buttons_widgets then
		for i = 1, #weapon_buttons_widgets do
			local widget = weapon_buttons_widgets[i]
			local content = widget.content
			local hotspot = content.hotspot
			hotspot.is_focused = i == index
		end
	end

	if not index and self._active_customize_preset_index then
		self._release_input_frame_delay = 1
	end

	self._active_customize_preset_index = index
	local tooltip_visible = index ~= nil

	self:_set_tooltip_visibility(tooltip_visible)

	local weapon_preset_button_widget = weapon_buttons_widgets and weapon_buttons_widgets[index]
	local equipped_icon_texture = weapon_preset_button_widget and weapon_preset_button_widget.content.icon
	local grid = self._weapon_preset_tooltip_grid
	local grid_widgets = grid:widgets()
	local equipped_widget = nil

	for i = 1, #grid_widgets do
		local grid_widget = grid_widgets[i]
		local content = grid_widget.content
		local equipped = content.icon == equipped_icon_texture
		content.equipped = equipped

		if equipped then
			equipped_widget = grid_widget
		end
	end

	if equipped_widget then
		grid:select_grid_widget(equipped_widget)
	end

	self._costumization_open = true
end

ViewElementWeaponPresets.handling_input = function (self)
	if self._active_customize_preset_index ~= nil then
		return true
	elseif self._release_input_frame_delay and self._release_input_frame_delay > 0 then
		return true
	end

	return false
end

ViewElementWeaponPresets._set_tooltip_visibility = function (self, visible, pulse_tooltip)
	local widgets_by_name = self._widgets_by_name
	widgets_by_name.weapon_preset_tooltip.content.visible = visible
	widgets_by_name.weapon_preset_tooltip.content.pulse = visible and pulse_tooltip
	local add_button_widget = widgets_by_name.weapon_preset_add_button
	add_button_widget.content.pulse = pulse_tooltip
	local grid = self._weapon_preset_tooltip_grid

	grid:set_visibility(visible)
end

ViewElementWeaponPresets.cycle_next_weapon_preset = function (self)
	local weapon_buttons_widgets = self._weapon_buttons_widgets
	local active_weapon_preset_id = self._active_weapon_preset_id

	if not active_weapon_preset_id or not weapon_buttons_widgets then
		return
	end

	local next_weapon_preset_index = math.index_wrapper(active_weapon_preset_id + 1, #weapon_buttons_widgets)

	self:on_weapon_preset_index_change(next_weapon_preset_index)
end

ViewElementWeaponPresets.on_weapon_preset_index_change = function (self, index, ignore_activation, ignore_sound)
	local weapon_buttons_widgets = self._weapon_buttons_widgets

	if weapon_buttons_widgets then
		for i = 1, #weapon_buttons_widgets do
			local widget = weapon_buttons_widgets[i]
			local content = widget.content
			local hotspot = content.hotspot
			hotspot.is_selected = i == index
		end
	end

	if index then
		if self._intro_active then
			self:_set_tooltip_visibility(false)

			self._intro_active = nil
		end

		if not ignore_sound then
			self:_play_sound(UISoundEvents.default_click)
		end
	end

	if not ignore_activation and index ~= self._active_weapon_preset_id then
		self._active_weapon_preset_id = index

		-- weaponUtils.save_active_weapon_preset_id(index)

		local parent = self._parent
		-- local weapon_preset = weaponUtils.get_weapon_preset(index)
		local weapon_preset = nil

		if weapon_preset then
			local weapon_preset_loadout = weapon_preset.loadout

			for slot_id, gear_id in pairs(weapon_preset_loadout) do
				local item = parent:_get_inventory_item_by_id(gear_id)

				if item then
					parent:_equip_slot_item(slot_id, item)
				end
			end

			local weapon_preset_talents = weapon_preset.talents
			local player = parent:_player()
			local weapon = player:weapon()
			local talents = weapon.talents
			local combined_talents = table.create_copy(table.clone(talents), weapon_preset_talents)

			Managers.event:trigger("event_on_weapon_preset_changed", weapon_preset_talents)

			local talent_service = Managers.data_service.talents

			talent_service:set_talents(player, combined_talents)
		end
	end
end

ViewElementWeaponPresets._update_weapon_presets = function (self, input_service, dt, t)
	if self._active_customize_preset_index then
		local hovering_weapon_buttons = false
		local weapon_buttons_widgets = self._weapon_buttons_widgets

		if weapon_buttons_widgets then
			for i = 1, #weapon_buttons_widgets do
				local widget = weapon_buttons_widgets[i]
				local content = widget.content
				local hotspot = content.hotspot

				if hotspot.is_hover then
					hovering_weapon_buttons = false

					break
				end
			end
		end

		local confirm_pressed = input_service:get("confirm_released")
		local left_pressed = input_service:get("left_pressed")
		local right_pressed = input_service:get("right_pressed")
		local close_customization = false

		if (left_pressed or right_pressed) and not hovering_weapon_buttons and not self._widgets_by_name.weapon_preset_tooltip.content.hotspot.is_hover then
			close_customization = true
		elseif confirm_pressed or input_service:get("back_released") then
			close_customization = true
		end

		if close_customization then
			self:on_weapon_preset_index_customize(nil)

			self._costumization_open = false
		end
	end

	if not self._weapon_buttons_widgets then
		return false
	end

	local using_gamepad = not self._using_cursor_navigation
	local focused = false

	if focused and self:can_exit() then
		self:set_can_exit(false)
	end
end

ViewElementWeaponPresets._on_navigation_input_changed = function (self)
	ViewElementWeaponPresets.super._on_navigation_input_changed(self)
end

ViewElementWeaponPresets.set_pivot_offset = function (self, x, y)
	self._pivot_offset[1] = x or self._pivot_offset[1]
	self._pivot_offset[2] = y or self._pivot_offset[2]

	self:_set_scenegraph_position("entry_pivot", x, y)
end

ViewElementWeaponPresets.on_resolution_modified = function (self, scale)
	ViewElementWeaponPresets.super.on_resolution_modified(self, scale)
	self:_update_weapon_preset_tooltip_grid_position()
	self._weapon_preset_tooltip_grid:set_render_scale(scale)
end

ViewElementWeaponPresets.update = function (self, dt, t, input_service)
	-- if not self._is_inventory_ready then
	-- 	local parent = self._parent

	-- 	if parent:is_inventory_synced() then
	-- 		self._is_inventory_ready = true
	-- 	end

	-- 	input_service = input_service:null_service()
	-- end

	if self._release_input_frame_delay then
		self._release_input_frame_delay = self._release_input_frame_delay - 1

		if self._release_input_frame_delay == 0 then
			self._release_input_frame_delay = nil
		end
	end

	self:_update_weapon_presets(input_service, dt, t)

	local grid = self._weapon_preset_tooltip_grid

	if grid then
		grid:update(dt, t, input_service)

		if self._active_customize_preset_index then
			local equipped_grid_index = nil
			local grid_widgets = grid:widgets()

			for i = 1, #grid_widgets do
				local grid_widget = grid_widgets[i]
				local content = grid_widget.content

				if content.equipped then
					equipped_grid_index = i

					break
				end
			end

			local gamepad_active = InputDevice.gamepad_active

			if not grid:selected_grid_index() then
				if gamepad_active and equipped_grid_index then
					grid:select_grid_index(equipped_grid_index)
				end
			elseif not gamepad_active then
				grid:select_grid_widget(nil)
			end

			local selected_grid_index = grid:selected_grid_index()

			if selected_grid_index and equipped_grid_index and selected_grid_index ~= equipped_grid_index then
				local grid_widget = grid_widgets[selected_grid_index]
				local grid_widget_element = grid_widget and grid_widget.content.element

				if grid_widget_element and not grid_widget_element.delete_button then
					self:cb_on_weapon_preset_icon_grid_left_pressed(grid_widget, grid_widget_element)
				end
			end

			input_service = input_service:null_service()
		end
	end

	return ViewElementWeaponPresets.super.update(self, dt, t, input_service)
end

ViewElementWeaponPresets.draw = function (self, dt, t, ui_renderer, render_settings, input_service)
	if not self._is_inventory_ready then
		input_service = input_service:null_service()
	end

	local grid = self._weapon_preset_tooltip_grid

	if grid then
		grid:draw(dt, t, ui_renderer, render_settings, input_service)
	end

	return ViewElementWeaponPresets.super.draw(self, dt, t, ui_renderer, render_settings, input_service)
end

ViewElementWeaponPresets._draw_widgets = function (self, dt, t, input_service, ui_renderer, render_settings)
	local weapon_buttons_widgets = self._weapon_buttons_widgets

	if weapon_buttons_widgets then
		for i = 1, #weapon_buttons_widgets do
			local widget = weapon_buttons_widgets[i]

			UIWidget.draw(widget, ui_renderer)
		end
	end

	ViewElementWeaponPresets.super._draw_widgets(self, dt, t, input_service, ui_renderer, render_settings)
end

ViewElementWeaponPresets._get_input_text = function (self, input_action)
	local service_type = "View"
	local alias_key = Managers.ui:get_input_alias_key(input_action)
	local input_text = InputUtils.input_text_for_current_input_device(service_type, alias_key)

	return tostring(input_text)
end

ViewElementWeaponPresets.set_input_actions = function (self, input_action_left, input_action_right)
	self._input_action_left = input_action_left
	self._input_action_right = input_action_right

	self:_update_input_action_texts()
end

ViewElementWeaponPresets.set_is_handling_navigation_input = function (self, is_enabled)
	self._is_handling_navigation_input = is_enabled
end

ViewElementWeaponPresets._update_input_action_texts = function (self)
	local using_cursor_navigation = self._using_cursor_navigation
	local input_action_left = self._input_action_left
	local input_action_right = self._input_action_right
	local widgets_by_name = self._widgets_by_name
	widgets_by_name.input_text_left.content.text = not using_cursor_navigation and input_action_left and self:_get_input_text(input_action_left) or ""
	widgets_by_name.input_text_right.content.text = not using_cursor_navigation and input_action_right and self:_get_input_text(input_action_right) or ""
end

ViewElementWeaponPresets.destroy = function (self, ui_renderer)
	self._weapon_preset_tooltip_grid:destroy(ui_renderer)

	self._weapon_preset_tooltip_grid = nil

	ViewElementWeaponPresets.super.destroy(self, ui_renderer)
end

ViewElementWeaponPresets.is_costumization_open = function (self)
	return self._costumization_open
end

return ViewElementWeaponPresets
