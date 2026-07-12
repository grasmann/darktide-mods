-- File: extended_weapon_customization/scripts/mods/ewc/patches/inventory_weapon_cosmetics_view/tabs.lua
local mod = get_mod("extended_weapon_customization")
if not mod then return end

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local ViewElementTabMenu = mod:original_require("scripts/ui/view_elements/view_element_tab_menu/view_element_tab_menu")
local ButtonPassTemplates = mod:original_require("scripts/ui/pass_templates/button_pass_templates")
local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")
local ColorUtilities = mod:original_require("scripts/utilities/ui/colors")
local master_items = mod:original_require("scripts/backend/master_items")
local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
local items = mod:original_require("scripts/utilities/items")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
local math = math
local table = table
local pairs = pairs
local color = Color
local callback = callback
local localize = Localize
local tostring = tostring
local math_max = math.max
local math_min = math.min
local table_clear = table.clear
local table_clone = table.clone
local string_format = string.format
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local pt = mod:pt()
local temp_mod_count = {}
local temp_group_index = {}

local TAB_BUTTON_SIZE = { 230, 40 }
local TAB_BUTTON_SPACING = 10
local TAB_MAX_VISIBLE_ROWS = 16
local TAB_SCROLLBAR_WIDTH = 12
local TAB_SCROLLBAR_HOVER_WIDTH = 20
local TAB_SCROLLBAR_MIN_THUMB_HEIGHT = 36
local TAB_SCROLLBAR_X_OFFSET = 240
local TAB_SCROLLBAR_HOVER_X_OFFSET = -8
local TAB_PANEL_HOVER_WIDTH = 370
local TAB_PANEL_HOVER_X_OFFSET = -100
local TAB_PANEL_HOVER_Y_OFFSET = -15
local TAB_PANEL_HOVER_EXTRA_HEIGHT = 40

local function tab_list_height(row_count, button_size, button_spacing)
	if row_count <= 0 then
		return 0
	end

	return button_size[2] * row_count + button_spacing * (row_count - 1)
end

local function tab_panel_hover_height(row_count, button_size, button_spacing)
	return tab_list_height(row_count, button_size, button_spacing) + TAB_PANEL_HOVER_EXTRA_HEIGHT
end

local function clamp_tab_scroll_index(index, max_first_index)
	return math_min(math_max(index, 1), max_first_index)
end

local function widget_hotspot_hovered(widget)
	local content = widget and widget.content
	local hotspot = content and content.hotspot

	return hotspot and hotspot.is_hover
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.selectable_attachment_count = function(self, attachment_entries)
	local count = 0

	if not attachment_entries then
		return count
	end

	for attachment_name, attachment_data in pairs(attachment_entries) do
		if attachment_data and not attachment_data.hide_from_selection then
			count = count + 1
		end
	end

	return count
end

mod.inventory_weapon_cosmetics_view_tab_menu_hovered = function(tab_menu_element)
	local scroll_data = tab_menu_element._ewc_tab_scroll_data

	if scroll_data then
		if widget_hotspot_hovered(scroll_data.panel_hover_widget) or widget_hotspot_hovered(scroll_data.scrollbar_widget) then
			return true
		end

		local original_hovered = scroll_data.original_hovered

		if original_hovered then
			return original_hovered(tab_menu_element)
		end
	end

	return false
end

mod.inventory_weapon_cosmetics_view_create_tab_panel_hover_widget = function(tab_menu_element, visible_rows, button_size, button_spacing)
	local hover_height = tab_panel_hover_height(visible_rows, button_size, button_spacing)
	local panel_hover_definition = UIWidget.create_definition({
		{
			pass_type = "hotspot",
			content_id = "hotspot",
			style_id = "hotspot",
			style = {
				horizontal_alignment = "left",
				vertical_alignment = "top",
				size = {
					TAB_PANEL_HOVER_WIDTH,
					hover_height,
				},
				offset = {
					0,
					0,
					80,
				},
			},
		},
	}, "entry_pivot", nil, {
		TAB_PANEL_HOVER_WIDTH,
		hover_height,
	})

	local panel_hover_widget = tab_menu_element:_create_widget("ewc_attachment_tab_panel_hover", panel_hover_definition)

	panel_hover_widget.offset[1] = TAB_PANEL_HOVER_X_OFFSET
	panel_hover_widget.offset[2] = TAB_PANEL_HOVER_Y_OFFSET

	return panel_hover_widget
end

mod.inventory_weapon_cosmetics_view_draw_scrollable_tab_menu = function(tab_menu_element, dt, t, input_service, ui_renderer, render_settings)
	local scroll_data = tab_menu_element._ewc_tab_scroll_data
	local entries = tab_menu_element._entries

	if not scroll_data or not entries then
		return
	end

	local panel_hover_widget = scroll_data.panel_hover_widget

	if panel_hover_widget then
		panel_hover_widget.visible = true
		UIWidget.draw(panel_hover_widget, ui_renderer)
	end

	local num_entries = #entries
	local visible_rows = scroll_data.visible_rows

	if num_entries <= visible_rows then
		if scroll_data.scrollbar_widget then
			scroll_data.scrollbar_widget.visible = false
		end

		return scroll_data.original_draw_widgets(tab_menu_element, dt, t, input_service, ui_renderer, render_settings)
	end

	local scrollbar_widget = scroll_data.scrollbar_widget
	local scrollbar_content = scrollbar_widget.content

	local max_first_index = math_max(num_entries - visible_rows + 1, 1)
	local first_index = scroll_data.first_index or 1
	local selected_index = tab_menu_element._selected_index or 1
	local selected_index_changed = selected_index ~= scroll_data.last_selected_index

	if selected_index_changed then
	if selected_index < first_index then
		first_index = selected_index
	elseif selected_index > first_index + visible_rows - 1 then
		first_index = selected_index - visible_rows + 1
	end

		scroll_data.last_selected_index = selected_index
	end

	local tab_panel_hovered = mod.inventory_weapon_cosmetics_view_tab_menu_hovered(tab_menu_element)
	local scroll_axis = input_service and input_service:get("scroll_axis")
	local scroll_delta = scroll_axis and scroll_axis[2] or 0

	if tab_panel_hovered and scroll_delta ~= 0 then
		if scroll_delta > 0 then
			first_index = first_index - 1
		else
			first_index = first_index + 1
		end
	end


	local new_first_index = nil
	local scrollbar_hotspot = scrollbar_content.hotspot
	local scrollbar_hovered = scrollbar_hotspot.is_hover
	local scrollbar_thumb = scrollbar_widget.style.thumb
	local on_pressed = scrollbar_hotspot.ewc_on_pressed

	local current_color = scrollbar_thumb.color

	if scrollbar_hovered then
		ColorUtilities.color_lerp(current_color, scrollbar_thumb.highlight_color, dt * 10, current_color)
	else
		ColorUtilities.color_lerp(current_color, scrollbar_thumb.idle_color, dt * 10, current_color)
	end

	scrollbar_thumb.color = current_color

	if not scrollbar_content.drag_active then
		if on_pressed then
			scrollbar_content.drag_active = true
		end
	end

	if scrollbar_content.drag_active then

		if not input_service:get("left_hold") then
			-- Drag just ended: stop dragging and keep the last known-good
			-- first_index. Do NOT reinterpret scroll_percentage here, since
			-- doing so re-derives first_index using a different scale than
			-- the one used while writing it, which is what caused the
			-- position to jump/reset on mouse release.
			scrollbar_content.drag_active = nil
			scrollbar_content.drag_was_active = true
			first_index = scroll_data.first_index or first_index
		else
			local scroll_percentage = scrollbar_content.scroll_percentage

			if scroll_percentage and max_first_index > 1 then
				local step_size = 1 / (max_first_index - 1)
				new_first_index = math_min(math_max(1, math.floor((scroll_percentage / step_size) + 0.5) + 1), max_first_index)
			end

			if new_first_index then
				first_index = new_first_index
			end

			scroll_data.first_index = first_index
		end

	elseif scrollbar_content.drag_was_active then
		-- Only correct first_index on the single frame right after a drag
		-- ends. Previously this ran on every non-dragging frame, which also
		-- overwrote first_index changes coming from the mouse wheel below.
		first_index = scroll_data.first_index or first_index

		scrollbar_content.drag_was_active = nil
	end

	first_index = clamp_tab_scroll_index(first_index, max_first_index)
	scroll_data.first_index = first_index
	
	local last_index = math_min(first_index + visible_rows - 1, num_entries)
	local menu_settings = tab_menu_element._menu_settings
	local button_spacing = menu_settings.button_spacing or 0
	local input_label_offset = menu_settings.input_label_offset
	local input_label_offset_x = input_label_offset and input_label_offset[1] or 0
	local input_label_offset_y = input_label_offset and input_label_offset[2] or 0
	local button_size = scroll_data.button_size
	local widgets_by_name = tab_menu_element._widgets_by_name
	local top_size_offset = 0

	if widgets_by_name.input_text_left then
		widgets_by_name.input_text_left.offset[1] = input_label_offset_x
		widgets_by_name.input_text_left.offset[2] = -(button_size[2] + input_label_offset_y)
	end

	for i = 1, num_entries do
		local entry = entries[i]
		local widget = entry and entry.widget
		local content = widget and widget.content
		local hotspot = content and content.hotspot
		local is_visible = i >= first_index and i <= last_index

		if hotspot then
			hotspot.disabled = not is_visible
			hotspot.is_focused = is_visible and i == selected_index
		end

		if widget then
			widget.visible = is_visible
		end
	end

	for i = first_index, last_index do
		local entry = entries[i]
		local widget = entry and entry.widget

		if widget then
			local offset = widget.offset
			local size = widget.content.size

			offset[1] = 0
			offset[2] = top_size_offset

			top_size_offset = top_size_offset + size[2]

			if i < last_index then
				top_size_offset = top_size_offset + button_spacing
			end

			UIWidget.draw(widget, ui_renderer)
		end
	end

	if widgets_by_name.input_text_right then
		widgets_by_name.input_text_right.offset[1] = input_label_offset_x
		widgets_by_name.input_text_right.offset[2] = top_size_offset + input_label_offset_y
	end

	local scrollbar_widget = scroll_data.scrollbar_widget

	if scrollbar_widget then
		local visible_height = scroll_data.visible_height
		local thumb_height = math_max(TAB_SCROLLBAR_MIN_THUMB_HEIGHT, visible_height * visible_rows / num_entries)
		local scroll_range = math_max(visible_height - thumb_height, 0)
		local scroll_percent = max_first_index > 1 and (first_index - 1) / (max_first_index - 1) or 0

		scrollbar_widget.visible = true
		scrollbar_widget.offset[1] = TAB_SCROLLBAR_X_OFFSET
		scrollbar_widget.offset[2] = 0
		scrollbar_widget.style.track.size[2] = visible_height
		scrollbar_widget.style.thumb.size[2] = thumb_height - 4
		scrollbar_widget.style.thumb.offset[2] = (scroll_range * scroll_percent) + 2
		scrollbar_widget.style.hotspot.size[2] = visible_height

		UIWidget.draw(scrollbar_widget, ui_renderer)
	end

	if widgets_by_name.input_text_left then
		UIWidget.draw(widgets_by_name.input_text_left, ui_renderer)
	end

	if widgets_by_name.input_text_right then
		UIWidget.draw(widgets_by_name.input_text_right, ui_renderer)
	end

	tab_menu_element._total_width = button_size[1]
end

mod.inventory_weapon_cosmetics_view_update_tab_scrollbar = function(self, tab_menu_element, input_service)

	if tab_menu_element then

		local scroll_data = tab_menu_element and tab_menu_element._ewc_tab_scroll_data
		local scrollbar_widget = scroll_data and scroll_data.scrollbar_widget
		local scrollbar_content = scrollbar_widget and scrollbar_widget.content
		local scrollbar_hotspot = scrollbar_content and scrollbar_content.hotspot

		local raw_mouse_pos = input_service and not input_service:is_null_service() and input_service:get("cursor") or nil
		local raw_cursor_y = raw_mouse_pos and raw_mouse_pos[2] or -1

		if scrollbar_hotspot and scrollbar_hotspot.ewc_on_pressed and not input_service:get("left_hold") then

			scrollbar_hotspot.ewc_on_pressed = false

		elseif scrollbar_hotspot and not scrollbar_hotspot.ewc_on_pressed then

			scrollbar_hotspot.cursor_y = raw_cursor_y

			-- Keep a baseline matching the CURRENT scroll position while not
			-- dragging, so that a new drag continues from where the list
			-- already is instead of starting from scroll_percentage 0 (top).
			local entries = tab_menu_element._entries
			local num_entries = entries and #entries or 0
			local visible_rows = scroll_data.visible_rows or 0
			local max_first_index = math_max(num_entries - visible_rows + 1, 1)
			local first_index = scroll_data.first_index or 1

			scrollbar_content.drag_start_percentage = max_first_index > 1 and (first_index - 1) / (max_first_index - 1) or 0

		elseif scrollbar_hotspot and scrollbar_hotspot.ewc_on_pressed then

			local drag_start_percentage = scrollbar_content.drag_start_percentage or 0
			scrollbar_content.scroll_percentage = drag_start_percentage + ((raw_cursor_y - scrollbar_hotspot.cursor_y) * 4 / scroll_data.visible_height)

		end

	end
end

mod.inventory_weapon_cosmetics_view_setup_tab_scrollbar = function(tab_menu_element, num_entries, button_size, button_spacing)
	local visible_rows = math_min(num_entries, TAB_MAX_VISIBLE_ROWS)
	local visible_height = tab_list_height(visible_rows, button_size, button_spacing)
	local panel_hover_widget = mod.inventory_weapon_cosmetics_view_create_tab_panel_hover_widget(tab_menu_element, visible_rows, button_size, button_spacing)
	local scrollbar_widget

	if num_entries > visible_rows then
		local scrollbar_definition = UIWidget.create_definition({
			{
				pass_type = "hotspot",
				content_id = "hotspot",
				style_id = "hotspot",
				style = {
					horizontal_alignment = "left",
					vertical_alignment = "top",
					size = {
						TAB_SCROLLBAR_HOVER_WIDTH,
						visible_height,
					},
					offset = {
						TAB_SCROLLBAR_HOVER_X_OFFSET,
						0,
						89,
					},
				},
			},
			{
				pass_type = "rect",
				style_id = "bg",
				style = {
					horizontal_alignment = "left",
					vertical_alignment = "top",
					color = color.black(255, true),
					size = {
						TAB_SCROLLBAR_WIDTH - 4,
						visible_height - 4,
					},
					offset = {
						2,
						2,
						89,
					},
				},
			},
			{
				pass_type = "texture",
				style_id = "track",
				value = "content/ui/materials/scrollbars/scrollbar_frame_default",
				style = {
					horizontal_alignment = "left",
					vertical_alignment = "top",
					color = color.terminal_frame(255, true),
					size = {
						TAB_SCROLLBAR_WIDTH,
						visible_height,
					},
					offset = {
						0,
						0,
						90,
					},
				},
			},
			{
				pass_type = "texture",
				style_id = "thumb",
				value = "content/ui/materials/scrollbars/scrollbar_thumb_default",
				style = {
					horizontal_alignment = "left",
					vertical_alignment = "top",
					color = color.terminal_text_body(255, true),
					idle_color = color.terminal_text_body(255, true),
					highlight_color = color.ui_brown_super_light(255, true),
					size = {
						TAB_SCROLLBAR_WIDTH - 4,
						TAB_SCROLLBAR_MIN_THUMB_HEIGHT,
					},
					offset = {
						2,
						2,
						91,
					},
				},
			},
		}, "entry_pivot", nil, {
			TAB_SCROLLBAR_HOVER_WIDTH,
			visible_height,
		})

		scrollbar_widget = tab_menu_element:_create_widget("ewc_attachment_tab_scrollbar", scrollbar_definition)

	end

	tab_menu_element._ewc_tab_scroll_data = {
		button_size = button_size,
		button_spacing = button_spacing,
		first_index = 1,
		original_draw_widgets = tab_menu_element._draw_widgets,
		original_hovered = tab_menu_element.hovered,
		panel_hover_widget = panel_hover_widget,
		scrollbar_widget = scrollbar_widget,
		visible_height = visible_height,
		visible_rows = visible_rows,
	}

	tab_menu_element._draw_widgets = mod.inventory_weapon_cosmetics_view_draw_scrollable_tab_menu
	tab_menu_element.hovered = mod.inventory_weapon_cosmetics_view_tab_menu_hovered

	return visible_rows
end

mod.inventory_weapon_cosmetics_view_setup_menu_tabs = function(self, content)
	if not content then
		return false
	end

	self._tabs_content = content

	local id = "tab_menu"
	local layer = 10
	local button_size = TAB_BUTTON_SIZE
	local button_spacing = TAB_BUTTON_SPACING
	local tab_menu_settings = {
		grow_vertically = true,
		vertical_alignment = "top",
		button_size = button_size,
		button_spacing = button_spacing,
		input_label_offset = { 25, 30 },
		fixed_button_size = true,
	}
	local tab_menu_element = self:_add_element(ViewElementTabMenu, id, layer, tab_menu_settings)

	self._tab_menu_element = tab_menu_element

	local input_action_left = "navigate_secondary_left_pressed"
	local input_action_right = "navigate_secondary_right_pressed"

	tab_menu_element:set_input_actions(input_action_left, input_action_right)
	tab_menu_element:set_is_handling_navigation_input(true)

	local tab_button_template = table_clone(ButtonPassTemplates.tab_menu_button)

	tab_button_template[1].style = {
		on_pressed_sound = UISoundEvents.tab_secondary_button_pressed,
	}

	local tab_ids = {}

	for i = 1, #content do
		local tab_content = content[i]
		local localize_name = tab_content and tab_content.display_name

		if localize_name == "left" and mod:is_shield(self._selected_item) then
			localize_name = "shield"
		end

		local display_name = "attachment_slot_" .. tostring(localize_name)
		local display_icon = tab_content and tab_content.icon
		local pressed_callback = callback(self, "cb_switch_tab", i)
		local tab_id = tab_menu_element:add_entry(display_name, pressed_callback, tab_button_template, display_icon)

		if self.first_equipped_slot_name and self.first_equipped_slot_name == localize_name and not self.initial_tab_index then
			self.initial_tab_index = i
		end

		tab_ids[i] = tab_id
	end

	local visible_rows = mod.inventory_weapon_cosmetics_view_setup_tab_scrollbar(tab_menu_element, #content, button_size, button_spacing)
	local total_height = button_size[2] * visible_rows + button_spacing * visible_rows

	local scroll_data = tab_menu_element and tab_menu_element._ewc_tab_scroll_data
	local scrollbar_widget = scroll_data and scroll_data.scrollbar_widget
	local scrollbar_content = scrollbar_widget and scrollbar_widget.content
	local scrollbar_hotspot = scrollbar_content and scrollbar_content.hotspot

	scrollbar_hotspot.pressed_callback = function ()

		-- mod:echo("scrollbar pressed")

		scrollbar_hotspot.ewc_on_pressed = true

	end

	self:_set_scenegraph_size("button_pivot_background", nil, total_height + 30)

	self._tab_ids = tab_ids

	self:_update_tab_bar_position()

	return true
end

mod.inventory_weapon_cosmetics_view_switch_tab = function(self, index)
	if not self._tabs_content then
		return false
	end

	local content = self._tabs_content[index]

	if not content then
		return false
	end

	self:reload_gear_settings()

	self.selected_color_override = nil
	self.selected_pattern_override = nil
	self.selected_wear_override = nil

	local weapon_template = self._selected_item and self._selected_item.weapon_template
	local attachments = weapon_template and mod.settings.attachments[weapon_template]
	local slot_name = content.slot_name

	mod.customization_menu_slot_name = slot_name

	if not slot_name then
		return true
	end

	local mod_name = mod:get_name()
	local original_item = self._selected_item and master_items.get_item(self._selected_item.name)
	local original_attachment = original_item and original_item.attachments and
		mod:fetch_attachment(original_item.attachments, slot_name)
	local original_attachment_is_empty = original_attachment == "content/items/weapons/player/trinkets/unused_trinket" or
		original_attachment == ""

	if index ~= self._selected_tab_index then
		if self._selected_tab_index then
			self["_selected_" .. slot_name .. "_name"] = mod:fetch_attachment(self._selected_item.attachments, slot_name)

			local real_item = master_items.get_item(self["_selected_" .. slot_name .. "_name"])
			local previous_content = self._tabs_content[self._selected_tab_index]

			if previous_content and previous_content.apply_on_preview then
				previous_content.apply_on_preview(real_item, self._presentation_item)
			end

			local gear_id = mod:gear_id(self._presentation_item, true)
			pt.items_originating_from_customization_menu[gear_id] = true
		end

		self:_preview_item(self._presentation_item)

		self._selected_tab_index = index

		if self._tab_menu_element then
			self._tab_menu_element:set_selected_index(index)
		end

		local generate_visual_item_function = content.generate_visual_item_function
		local get_empty_item_function = content.get_empty_item

		self._grid_display_name = content.display_name

		if not self._using_cursor_navigation then
			self:_play_sound(UISoundEvents.tab_secondary_button_pressed)
		end

		local layout = {}
		local current_group_index = 1

		table_clear(temp_mod_count)
		table_clear(temp_group_index)

		if original_attachment_is_empty and get_empty_item_function then
			local empty_item = get_empty_item_function(self._selected_item, self._presentation_item)

			temp_mod_count[mod_name] = temp_mod_count[mod_name] or 0
			temp_mod_count[mod_name] = temp_mod_count[mod_name] + 1

			if not temp_group_index[mod_name] then
				temp_group_index[mod_name] = current_group_index
				current_group_index = current_group_index + 1
			end

			local group_index = string_format("%04d", temp_group_index[mod_name])
			local attachment_index = string_format("%04d", temp_mod_count[mod_name])
			local sort_string = mod_name .. "_" .. group_index .. "_" .. attachment_index

			layout[#layout + 1] = {
				is_empty = true,
				item = empty_item,
				slot_name = slot_name,
				sort_data = {
					display_name = sort_string,
				},
			}
		end

		local attachment_entries = attachments and attachments[slot_name]

		if attachment_entries and generate_visual_item_function and mod:selectable_attachment_count(attachment_entries) > 1 then
			for attachment_name, attachment_data in pairs(attachment_entries) do
				if attachment_data and not attachment_data.hide_from_selection then
					local attachment_item = master_items.get_item(attachment_data.replacement_path)
					local item = generate_visual_item_function(slot_name, attachment_item, attachment_data)
					local origin_mod = pt.attachment_data_origin[attachment_data] or mod
					local group_name = attachment_data.custom_selection_group or origin_mod:get_name()

					temp_mod_count[group_name] = temp_mod_count[group_name] or 0
					temp_mod_count[group_name] = temp_mod_count[group_name] + 1

					if not temp_group_index[group_name] then
						temp_group_index[group_name] = current_group_index
						current_group_index = current_group_index + 1
					end

					local group_index = string_format("%04d", temp_group_index[group_name])
					local attachment_index = string_format("%04d",
						attachment_data.selection_index or temp_mod_count[group_name])
					local sort_string = group_name .. "_" .. group_index .. "_" .. attachment_index

					layout[#layout + 1] = {
						widget_type = "gear_set",
						item = item,
						real_item = attachment_item,
						attachment_data = attachment_data,
						slot_name = slot_name,
						sort_data = {
							display_name = sort_string,
						},
					}
				end
			end
		end

		for group_name, count in pairs(temp_mod_count) do
			local localization_name = "loc_ewc_" .. tostring(group_name)
			local group_index = string_format("%04d", temp_group_index[group_name])
			local attachment_index = string_format("%04d", 0)
			local sort_string = group_name .. "_" .. group_index .. "_" .. attachment_index

			layout[#layout + 1] = {
				widget_type = "sub_header",
				slot_name = slot_name,
				display_name = localization_name,
				sort_data = {
					display_name = sort_string,
				},
			}
		end

		self._offer_items_layout = layout

		if self._sort_options and self._sort_options[1] then
			self:_sort_grid_layout(self._sort_options[1].sort_function)
		end

		self:_present_layout_by_slot_filter()
	end

	if self.tutorial_step == 2 then
		self.tutorial_step = 3
	end

	return true
end

mod.inventory_weapon_cosmetics_view_setup_sort_options = function(self)
	if not self._item_grid then
		return true
	end

	if not self._sort_options then
		self._sort_options = {
			{
				display_name = localize("loc_inventory_item_grid_sort_title_format_increasing_letters", true, {
					sort_name = localize("loc_inventory_item_grid_sort_title_name"),
				}),
				sort_function = items.sort_element_key_comparator({ "<", "sort_data", items.compare_item_name }),
			},
			{
				display_name = localize("loc_inventory_item_grid_sort_title_format_decreasing_letters", true, {
					sort_name = localize("loc_inventory_item_grid_sort_title_name"),
				}),
				sort_function = items.sort_element_key_comparator({ ">", "sort_data", items.compare_item_name }),
			},
		}
	end

	local sort_callback = callback(self, "cb_on_sort_button_pressed")

	self._item_grid:setup_sort_button(self._sort_options, sort_callback)

	return true
end
