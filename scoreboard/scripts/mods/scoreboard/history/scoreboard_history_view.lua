local mod = get_mod("scoreboard")
local DMF = get_mod("DMF")

local InputUtils = mod:original_require("scripts/managers/input/input_utils")
local UIRenderer = mod:original_require("scripts/managers/ui/ui_renderer")
local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
local ViewElementInputLegend = mod:original_require("scripts/ui/view_elements/view_element_input_legend/view_element_input_legend")
local CATEGORIES_GRID = 1

local ScoreboardHistoryView = class("ScoreboardHistoryView", "BaseView")

-- ####################################################################################################################
-- ##### INIT #########################################################################################################
-- ####################################################################################################################

ScoreboardHistoryView.init = function(self, settings)
	self._definitions = mod:io_dofile("scoreboard/scripts/mods/scoreboard/history/scoreboard_history_view_definitions")
	self._blueprints = mod:io_dofile("scoreboard/scripts/mods/scoreboard/history/scoreboard_history_view_blueprints")
	self._settings = mod:io_dofile("scoreboard/scripts/mods/scoreboard/history/scoreboard_history_view_settings")
	ScoreboardHistoryView.super.init(self, self._definitions, settings)
	self._pass_draw = false
	self:_setup_offscreen_gui()
end

ScoreboardHistoryView._setup_offscreen_gui = function(self)
	local ui_manager = Managers.ui
	local class_name = self.__class_name
	local timer_name = "ui"
	local world_layer = 10
	local world_name = class_name .. "_ui_offscreen_world"
	local view_name = self.view_name
	self._offscreen_world = ui_manager:create_world(world_name, world_layer, timer_name, view_name)
	local shading_environment = self._settings.shading_environment
	local viewport_name = class_name .. "_ui_offscreen_world_viewport"
	local viewport_type = "overlay_offscreen"
	local viewport_layer = 1
	self._offscreen_viewport = ui_manager:create_viewport(self._offscreen_world, viewport_name, viewport_type, viewport_layer, shading_environment)
	self._offscreen_viewport_name = viewport_name
	self._ui_offscreen_renderer = ui_manager:create_renderer(class_name .. "_ui_offscreen_renderer", self._offscreen_world)
end

-- ####################################################################################################################
-- ##### ENTER ########################################################################################################
-- ####################################################################################################################

ScoreboardHistoryView.on_enter = function(self)
	-- if not self._scorebaord_history_entries then
	-- 	self._scorebaord_history_entries = {
	-- 	  data = {},
	-- 	  entries = {},
	-- 	}
	-- 	-- dmf:create_mod_options_settings(self._options_templates)
	-- end
	ScoreboardHistoryView.super.on_enter(self)

	self._default_category = nil
	self._using_cursor_navigation = Managers.ui:using_cursor_navigation()

	self:_setup_category_config()
	self:_setup_input_legend()
	self:_enable_settings_overlay(false)
	self:_update_grid_navigation_selection()
end

ScoreboardHistoryView._setup_category_config = function(self)
	if self._category_content_widgets then
	  	for i = 1, #self._category_content_widgets do
			local widget = self._category_content_widgets[i]
			self:_unregister_widget_name(widget.name)
		end
	  	self._category_content_widgets = {}
	end
  
	-- local config_categories = config.categories
	local config_categories = mod:get_scoreboard_history_entries()
	local entries = {}
	local reset_functions_by_category = {}
	local categories_by_display_name = {}
  
	for i = 1, #config_categories do
		local category_config = config_categories[i]
		local category_display_name = category_config.display_name or category_config.name
	--   local category_reset_function = category_config.reset_function
	--   local valid = self._validation_mapping[category_display_name].validation_result
  
		-- if valid then
		local entry = {
			widget_type = "settings_button",
			display_name = category_display_name,
			can_be_reset = category_config.can_be_reset,
			pressed_function = function (parent, widget, entry)
				self._category_content_grid:select_widget(widget)
	
				local widget_name = widget.name
	
				self:present_category_widgets(category_display_name)
	
				local selected_navigation_column = self._selected_navigation_column_index
	
				if selected_navigation_column then
					self:_change_navigation_column(selected_navigation_column + 1)
				end
			end,
			select_function = function (parent, widget, entry)
				self:present_category_widgets(category_display_name)
			end
		}
		entries[#entries + 1] = entry
		categories_by_display_name[category_display_name] = entry
		-- reset_functions_by_category[category_display_name] = category_reset_function
		-- end
	end
  
	self._default_category = config_categories[1].display_name or config_categories[1].name
	local scenegraph_id = "grid_content_pivot"
	local callback_name = "cb_on_category_pressed"
	self._category_content_widgets, self._category_alignment_list = self:_setup_content_widgets(entries, scenegraph_id, callback_name)
	local scrollbar_widget_id = "scrollbar"
	local grid_scenegraph_id = "background"
	local grid_pivot_scenegraph_id = "grid_content_pivot"
	local grid_spacing = self._settings.grid_spacing
	self._category_content_grid = self:_setup_grid(self._category_content_widgets, self._category_alignment_list, grid_scenegraph_id, grid_spacing, true)
  
	self:_setup_content_grid_scrollbar(self._category_content_grid, scrollbar_widget_id, grid_scenegraph_id, grid_pivot_scenegraph_id)
  
	-- self._reset_functions_by_category = reset_functions_by_category
	self._categories_by_display_name = categories_by_display_name
	self._navigation_widgets = {
	  self._category_content_widgets
	}
	self._navigation_grids = {
	  self._category_content_grid
	}
end

ScoreboardHistoryView._setup_input_legend = function(self)
	self._input_legend_element = self:_add_element(ViewElementInputLegend, "input_legend", 10)
	local legend_inputs = self._definitions.legend_inputs
	for i = 1, #legend_inputs do
		local legend_input = legend_inputs[i]
		local on_pressed_callback = legend_input.on_pressed_callback and callback(self, legend_input.on_pressed_callback)
	
		self._input_legend_element:add_entry(legend_input.display_name, legend_input.input_action, 
			legend_input.visibility_function, on_pressed_callback, legend_input.alignment)
	end
end

ScoreboardHistoryView._enable_settings_overlay = function(self, enable)
	local widgets_by_name = self._widgets_by_name
	local settings_overlay_widget = widgets_by_name.settings_overlay
	settings_overlay_widget.content.visible = enable
end



ScoreboardHistoryView._setup_content_grid_scrollbar = function(self, grid, widget_id, grid_scenegraph_id, grid_pivot_scenegraph_id)
	local widgets_by_name = self._widgets_by_name
	local scrollbar_widget = widgets_by_name[widget_id]
  
	if DMF:get("dmf_options_scrolling_speed") and widgets_by_name and widgets_by_name["scrollbar"] then
		widgets_by_name["scrollbar"].content.scroll_speed = DMF:get("dmf_options_scrolling_speed")
	end
  
	grid:assign_scrollbar(scrollbar_widget, grid_pivot_scenegraph_id, grid_scenegraph_id)
	grid:set_scrollbar_progress(0)
end



ScoreboardHistoryView.present_category_widgets = function(self, category)
end

ScoreboardHistoryView._setup_content_widgets = function(self, content, scenegraph_id, callback_name)
	local definitions = self._definitions
	local widget_definitions = {}
	local widgets = {}
	local alignment_list = {}
	local amount = #content

	for i = 1, amount do
		local entry = content[i]
		local verified = true

		if verified then
			local widget_type = entry.widget_type
			local widget = nil
			local template = self._blueprints[widget_type]
			local size = template.size
			local pass_template = template.pass_template

			if pass_template and not widget_definitions[widget_type] then
				local scenegraph_definition = definitions.scenegraph_definition
				widget_definitions[widget_type] = UIWidget.create_definition(pass_template, scenegraph_id, nil, size)
			end

			local widget_definition = widget_definitions[widget_type]

			if widget_definition then
				local name = scenegraph_id .. "_widget_" .. i
				widget = self:_create_widget(name, widget_definition)
				local init = template.init

				if init then
					init(self, widget, entry, callback_name)
				end

				local focus_group = entry.focus_group

				if focus_group then
					widget.content.focus_group = focus_group
				end

				widgets[#widgets + 1] = widget
			end

			alignment_list[#alignment_list + 1] = widget or {
				size = size
			}
		end
	end

	return widgets, alignment_list
end

ScoreboardHistoryView.on_exit = function(self)
	if self._input_legend_element then
		self._input_legend_element = nil
		self:_remove_element("input_legend")
	end

	if self._popup_id then
		Managers.event:trigger("event_remove_ui_popup", self._popup_id)
	end

	if self._ui_offscreen_renderer then
		self._ui_offscreen_renderer = nil
	
		Managers.ui:destroy_renderer(self.__class_name .. "_ui_offscreen_renderer")
	
		local offscreen_world = self._offscreen_world
		local offscreen_viewport_name = self._offscreen_viewport_name
	
		ScriptWorld.destroy_viewport(offscreen_world, offscreen_viewport_name)
		Managers.ui:destroy_world(offscreen_world)
	
		self._offscreen_viewport = nil
		self._offscreen_viewport_name = nil
		self._offscreen_world = nil
	end

	ScoreboardHistoryView.super.on_exit(self)
end

-- ####################################################################################################################
-- ##### UPDATE #######################################################################################################
-- ####################################################################################################################

ScoreboardHistoryView.update = function(self, dt, t, input_service, view_data)
	local drawing_view = view_data and view_data.drawing_view
	local using_cursor_navigation = Managers.ui:using_cursor_navigation()

	if self:_handling_keybinding() then
		if not drawing_view or not using_cursor_navigation then
			self:close_keybind_popup(true)
		end

		input_service = input_service:null_service()
	end

	self:_handle_keybind_rebind(dt, t, input_service)

	local close_keybind_popup_duration = self._close_keybind_popup_duration

	if close_keybind_popup_duration then
		if close_keybind_popup_duration < 0 then
			self._close_keybind_popup_duration = nil

			self:close_keybind_popup(true)
		else
			self._close_keybind_popup_duration = close_keybind_popup_duration - dt
		end
	end

	local grid_length = self._category_content_grid:length()

	if grid_length ~= self._grid_length then
		self._grid_length = grid_length
	end

	local category_grid_is_focused = self._selected_navigation_column_index == CATEGORIES_GRID
	local category_grid_input_service = category_grid_is_focused and input_service or input_service:null_service()

	self._category_content_grid:update(dt, t, category_grid_input_service)
	self:_update_category_content_widgets(dt, t)

	-- skdjlfsdf

	if self._tooltip_data and self._tooltip_data.widget and not self._tooltip_data.widget.content.hotspot.is_hover then
		self._tooltip_data = {}
		self._widgets_by_name.tooltip.content.visible = false
	end

	return ScoreboardHistoryView.super.update(self, dt, t, input_service)
end

ScoreboardHistoryView._update_category_content_widgets = function(self, dt, t)
	local category_content_widgets = self._category_content_widgets
  
	if category_content_widgets then
		local is_focused_grid = self._selected_navigation_column_index == CATEGORIES_GRID
		local selected_category_widget = self._selected_category_widget
	
		for i = 1, #category_content_widgets do
			local widget = category_content_widgets[i]
			local hotspot = widget.content.hotspot
	
			if hotspot.is_focused then
				hotspot.is_selected = true
		
				if widget ~= selected_category_widget then
					self._selected_category_widget = widget
					local entry = widget.content.entry
		
					if entry and entry.select_function then
						entry.select_function(self, widget, entry)
					end
				end
			elseif is_focused_grid then
				hotspot.is_selected = false
			end
		end
	end
end

ScoreboardHistoryView._handle_keybind_rebind = function(self, dt, t, input_service)
	if self._handling_keybind then
		local input_manager = Managers.input
		local results = input_manager:key_watch_result()
	
		if results then
			local entry = self._active_keybind_entry
			local widget = self._active_keybind_widget
			local presentation_string = InputUtils.localized_string_from_key_info(results)
			local service_type = entry.service_type
			local alias_name = entry.alias_name
			local value = entry.value
			local can_close = entry.on_activated(results, value)
	
			if can_close then
				self:close_keybind_popup()
			else
				Managers.input:stop_key_watch()
		
				local devices = entry.devices
		
				Managers.input:start_key_watch(devices)
			end
		end
	end
end

ScoreboardHistoryView._handling_keybinding = function(self)
	return self._handling_keybind or self._close_keybind_popup_duration ~= nil
end

ScoreboardHistoryView.close_keybind_popup = function(self, force_close)
	if force_close then
		Managers.input:stop_key_watch()
	
		local reference_name = "keybind_popup"
		self._keybind_popup = nil
	
		self:_remove_element(reference_name)
		self:set_can_exit(true, true)
	else
	  	self._close_keybind_popup_duration = 0.2
	end
  
	self._handling_keybind = false
	self._active_keybind_entry = nil
	self._active_keybind_widget = nil
end

ScoreboardHistoryView._update_grid_navigation_selection = function(self)
	local selected_column_index = self._selected_navigation_column_index
	local selected_row_index = self._selected_navigation_row_index
  
	if self._using_cursor_navigation then
		if selected_row_index or selected_column_index then
			self:_set_selected_navigation_widget(nil)
		end
	else
		local navigation_widgets = self._navigation_widgets[selected_column_index]
		local selected_widget = navigation_widgets and navigation_widgets[selected_row_index] or self._selected_settings_widget
	
		if selected_widget then
			local selected_grid = self._navigation_grids[selected_column_index]
	
			if not selected_grid or not selected_grid:selected_grid_index() then
			self:_set_selected_navigation_widget(selected_widget)
			end
		elseif navigation_widgets or self._settings_content_widgets then
			self:_set_default_navigation_widget()
		elseif self._default_category then
			self:present_category_widgets(self._default_category)
		end
	end
end

ScoreboardHistoryView._change_navigation_column = function(self, column_index)
	local navigation_widgets = self._navigation_widgets
	local num_columns = #navigation_widgets
	local success = false
  
	if column_index < 1 or num_columns < column_index or self._navigation_column_changed_this_frame then
	  	return success
	else
		success = true
		self._navigation_column_changed_this_frame = true
	end
  
	local widgets = navigation_widgets[column_index]
  
	for i = 1, #widgets do
		local widget = widgets[i]
		local content = widget.content
		local hotspot = content.hotspot or content.button_hotspot
	
		if hotspot and hotspot.is_selected then
			self:_set_selected_navigation_widget(widget)
			return success
		end
	end
  
	local navigation_grid = self._navigation_grids[column_index]
	local scrollbar_progress = navigation_grid:scrollbar_progress()
  
	for i = 1, #widgets do
		local widget = widgets[i]
		local content = widget.content
		local hotspot = content.hotspot or content.button_hotspot
	
		if hotspot then
			local scroll_position = navigation_grid:get_scrollbar_percentage_by_index(i) or 0
	
			if scrollbar_progress <= scroll_position then
				self:_set_selected_navigation_widget(widget)
				return success
			end
		end
	end
end
  
ScoreboardHistoryView._set_default_navigation_widget = function(self)
	local navigation_widgets = self._navigation_widgets
	for i = 1, #navigation_widgets do
		if self:_change_navigation_column(i) then
			return
		end
	end
end
  
ScoreboardHistoryView._set_selected_navigation_widget = function(self, widget)
	local widget_name = widget and widget.name
	local selected_row, selected_column = nil, nil
	local navigation_widgets = self._navigation_widgets
  
	for column_index = 1, #navigation_widgets do
		local widgets = navigation_widgets[column_index]
		local _, focused_grid_index = self:_set_focused_grid_widget(widgets, widget_name)
	
		if focused_grid_index then
			self:_set_selected_grid_widget(widgets, widget_name)
	
			selected_row = focused_grid_index
			selected_column = column_index
		end
	end
  
	local navigation_grids = self._navigation_grids
  
	for column_index = 1, #navigation_grids do
		local selected_grid = column_index == selected_column
		local navigation_grid = navigation_grids[column_index]
		navigation_grid:select_grid_index(selected_grid and selected_row or nil, nil, nil, column_index == CATEGORIES_GRID)
	end
  
	self._selected_navigation_row_index = selected_row
	self._selected_navigation_column_index = selected_column
end

ScoreboardHistoryView.cb_on_back_pressed = function(self)
	local view_name = "scoreboard_history_view"
	Managers.ui:close_view(view_name)
end
  
ScoreboardHistoryView.cb_reset_category_to_default = function(self)	
end

-- ####################################################################################################################
-- ##### DRAW #########################################################################################################
-- ####################################################################################################################

ScoreboardHistoryView.draw = function(self, dt, t, input_service, layer)
	self:_draw_elements(dt, t, self._ui_renderer, self._render_settings, input_service)
	self:_draw_widgets(dt, input_service)
end

ScoreboardHistoryView._draw_elements = function(self, dt, t, ui_renderer, render_settings, input_service)
	ScoreboardHistoryView.super._draw_elements(self, dt, t, ui_renderer, render_settings, input_service)
end

ScoreboardHistoryView._draw_widgets = function(self, dt, input_service)
	UIRenderer.begin_pass(self._ui_renderer, self._ui_scenegraph, input_service, dt, self._render_settings)
	for name, widget in pairs(self._widgets_by_name) do
		UIWidget.draw(widget, self._ui_renderer)
	end
	UIRenderer.end_pass(self._ui_renderer)
end

-- mod:io_dofile("scoreboard/scripts/mods/scoreboard/history/scoreboard_history_view_setup")

return ScoreboardHistoryView