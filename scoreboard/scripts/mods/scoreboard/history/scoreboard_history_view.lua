local mod = get_mod("scoreboard")
local DMF = get_mod("DMF")

local UISettings = mod:original_require("scripts/settings/ui/ui_settings")
local Missions = mod:original_require("scripts/settings/mission/mission_templates")
local ScriptWorld = mod:original_require("scripts/foundation/utilities/script_world")
local InputUtils = mod:original_require("scripts/managers/input/input_utils")
local UIRenderer = mod:original_require("scripts/managers/ui/ui_renderer")
local UIFonts = mod:original_require("scripts/managers/ui/ui_fonts")
local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
local UIWidgetGrid = mod:original_require("scripts/ui/widget_logic/ui_widget_grid")
local ViewElementInputLegend = mod:original_require("scripts/ui/view_elements/view_element_input_legend/view_element_input_legend")
local CATEGORIES_GRID = 1
local TextUtilities = mod:original_require("scripts/utilities/ui/text")
local Circumstance = mod:original_require("scripts/settings/circumstance/circumstance_templates")
local Danger = mod:original_require("scripts/settings/difficulty/danger_settings")
local ScoreboardHistoryView = class("ScoreboardHistoryView", "BaseView")

-- ##### ██╗███╗   ██╗██╗████████╗ ####################################################################################
-- ##### ██║████╗  ██║██║╚══██╔══╝ ####################################################################################
-- ##### ██║██╔██╗ ██║██║   ██║    ####################################################################################
-- ##### ██║██║╚██╗██║██║   ██║    ####################################################################################
-- ##### ██║██║ ╚████║██║   ██║    ####################################################################################
-- ##### ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝    ####################################################################################

ScoreboardHistoryView.init = function(self, settings)
    self._definitions = mod:io_dofile("scoreboard/scripts/mods/scoreboard/history/scoreboard_history_view_definitions")
    self._blueprints = mod:io_dofile("scoreboard/scripts/mods/scoreboard/history/scoreboard_history_view_blueprints")
    self._settings = mod:io_dofile("scoreboard/scripts/mods/scoreboard/history/scoreboard_history_view_settings")
    ScoreboardHistoryView.super.init(self, self._definitions, settings)
    self._pass_draw = false
    self.ui_manager = Managers.ui
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

-- ##### ███████╗███╗   ██╗████████╗███████╗██████╗  ##################################################################
-- ##### ██╔════╝████╗  ██║╚══██╔══╝██╔════╝██╔══██╗ ##################################################################
-- ##### █████╗  ██╔██╗ ██║   ██║   █████╗  ██████╔╝ ##################################################################
-- ##### ██╔══╝  ██║╚██╗██║   ██║   ██╔══╝  ██╔══██╗ ##################################################################
-- ##### ███████╗██║ ╚████║   ██║   ███████╗██║  ██║ ##################################################################
-- ##### ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚═╝  ╚═╝ ##################################################################

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

ScoreboardHistoryView._setup_input_legend = function(self)
    self._input_legend_element = self:_add_element(ViewElementInputLegend, "input_legend", 10)
    local legend_inputs = self._definitions.legend_inputs
    for i = 1, #legend_inputs do
        local legend_input = legend_inputs[i]
        local on_pressed_callback = legend_input.on_pressed_callback and callback(self, legend_input.on_pressed_callback)
        local visibility_function = legend_input.visibility_function
        if legend_input.display_name == "loc_scoreboard_delete" then
            visibility_function = function()
                return self.entry
            end
        end
        self._input_legend_element:add_entry(legend_input.display_name, legend_input.input_action, visibility_function, on_pressed_callback, legend_input.alignment)
    end
end

ScoreboardHistoryView._enable_settings_overlay = function(self, enable)
    local widgets_by_name = self._widgets_by_name
    local settings_overlay_widget = widgets_by_name.settings_overlay
    settings_overlay_widget.content.visible = enable
end

ScoreboardHistoryView.present_category_widgets = function(self, category)
    if self.entry then
        if self.ui_manager:view_active("scoreboard_view") and not self.ui_manager:is_view_closing("scoreboard_view") then
            self.ui_manager:close_view("scoreboard_view", true)
        end
        local players = {}
        for _, player_data in pairs(self.entry.players) do
            players[#players+1] = {
                account_id = function()
                    return player_data.account_id
                end,
                name = function()
                    return player_data.name
                end,
                string_symbol = player_data.string_symbol,
            }
        end
        self.ui_manager:open_view("scoreboard_view", nil, false, false, nil, {
            scoreboard_history = true,
            rows = self.entry.rows,
            players = players,
            groups = self.groups or {},
        }, {use_transition_ui = false})
    end
end

-- #####  ██████╗ ██████╗ ██╗██████╗  #################################################################################
-- ##### ██╔════╝ ██╔══██╗██║██╔══██╗ #################################################################################
-- ##### ██║  ███╗██████╔╝██║██║  ██║ #################################################################################
-- ##### ██║   ██║██╔══██╗██║██║  ██║ #################################################################################
-- ##### ╚██████╔╝██║  ██║██║██████╔╝ #################################################################################
-- #####  ╚═════╝ ╚═╝  ╚═╝╚═╝╚═════╝  #################################################################################

ScoreboardHistoryView._setup_content_grid_scrollbar = function(self, grid, widget_id, grid_scenegraph_id, grid_pivot_scenegraph_id)
    local widgets_by_name = self._widgets_by_name
    local scrollbar_widget = widgets_by_name[widget_id]
  
    if DMF:get("dmf_options_scrolling_speed") and widgets_by_name and widgets_by_name["scrollbar"] then
        widgets_by_name["scrollbar"].content.scroll_speed = DMF:get("dmf_options_scrolling_speed")
    end
  
    grid:assign_scrollbar(scrollbar_widget, grid_pivot_scenegraph_id, grid_scenegraph_id)
    grid:set_scrollbar_progress(0)
end

-- ScoreboardHistoryView._setup_filter = function(self)
--     local DMFContentBlueprints = mod:io_dofile("dmf/scripts/mods/dmf/modules/ui/options/dmf_options_view_content_blueprints")
--     local template = DMFContentBlueprints.dropdown
--     local pass_template = template.pass_template
--     local widget_definition = UIWidget.create_definition(pass_template, "filter")

--     if widget_definition then
--         -- local name = scenegraph_id .. "_widget_" .. i
--         local widget = self:_create_widget("filter", widget_definition)
--         local init = template.init

--         if init then
--           init(self, widget, entry, callback_name)
--         end
--     end
-- end

ScoreboardHistoryView._setup_category_config = function(self, scan_dir)
    if self._category_content_widgets then
        for i = 1, #self._category_content_widgets do
            local widget = self._category_content_widgets[i]
            self:_unregister_widget_name(widget.name)
        end
        self._category_content_widgets = {}
    end
  
    -- local config_categories = config.categories
    local config_categories = mod:get_scoreboard_history_entries(scan_dir)
    local entries = {}
    local reset_functions_by_category = {}
    local categories_by_display_name = {}
  
    for i = 1, #config_categories do
        local category_config = config_categories[i]
        -- local category_display_name = category_config.display_name or category_config.name
        local mission_name = ""
        local mission_subname = ""
        if category_config.mission_name then
            local mission_settings = Missions[category_config.mission_name]
            if mission_settings then
                mission_name = " | "..Localize(mission_settings.mission_name)
            end
            if category_config.victory_defeat == "won" then
                local mytext = TextUtilities.apply_color_to_text("WON", Color.ui_green_light(255, true))
                mission_name = " | "..mytext..mission_name
            elseif category_config.victory_defeat == "lost" then
                local mytext = TextUtilities.apply_color_to_text("LOST", Color.ui_red_light(255, true))
                mission_name = " | "..mytext..mission_name
            end
            if category_config.timer ~= "" then
                mission_subname = "\n"..category_config.timer
            end
            if category_config.mission_challenge ~= "" then
                local mission_challenge = Danger[tonumber(category_config.mission_challenge)]
                if mission_challenge then
                    if mission_subname == "" then
                        mission_subname = "\n"..Localize(mission_challenge.display_name)
                    else
                        mission_subname = mission_subname.." | "..Localize(mission_challenge.display_name)
                    end
                end
            end
            if category_config.mission_circumstance ~= "" then
                local mission_circumstance = Circumstance[category_config.mission_circumstance]
                if ( mission_circumstance and mission_circumstance.ui ) then
                    if mission_subname == "" then
                        mission_subname = "\n"..Localize(mission_circumstance.ui.display_name)
                    else
                        mission_subname = mission_subname.." | "..Localize(mission_circumstance.ui.display_name)
                    end
                end
            end
        end

        mod:add_global_localize_strings({
            ["loc_scoreboard_history_view_entry_"..tostring(category_config.date)] = {
                en = tostring(category_config.date)..mission_name..mission_subname,
            },
        })
        local category_display_name = "loc_scoreboard_history_view_entry_"..tostring(category_config.date)

        local players = {}
        if category_config.players then
            for _, player in pairs(category_config.players) do
                local player_name = player.name
                local symbol = player.string_symbol --or player._profile and player._profile.archetype.string_symbol
                -- local profile = player:profile()
			    -- local archetype_name = profile and profile.archetype and profile.archetype.name
                -- local archetype_name = player._profile.archetype and player._profile.archetype.name
			    -- local symbol = archetype_name and UISettings.archetype_font_icon[archetype_name]
                if symbol then
                    player_name = symbol.." "..player_name
                end
                players[#players+1] = player_name
            end
        end
        mod:add_global_localize_strings({
            ["loc_scoreboard_history_view_entry_"..tostring(category_config.date).."_players"] = {
                en = table.concat(players, ", "),
            },
        })
        local category_display_name2 = "loc_scoreboard_history_view_entry_"..tostring(category_config.date).."_players"
    --   local category_reset_function = category_config.reset_function
    --   local valid = self._validation_mapping[category_display_name].validation_result
  
        -- if valid then
        local entry = {
            widget_type = "settings_button",
            display_name = category_display_name,
            display_name2 = category_display_name2,
            -- can_be_reset = category_config.can_be_reset,
            file = category_config.file,
            file_path = category_config.file_path,
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
  
    self._default_category = config_categories[1] and (config_categories[1].display_name or config_categories[1].name) or nil
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

ScoreboardHistoryView._setup_grid = function (self, widgets, alignment_list, grid_scenegraph_id, spacing, use_is_focused)
    local ui_scenegraph = self._ui_scenegraph
    local direction = "down"
    local grid = UIWidgetGrid:new(widgets, alignment_list, ui_scenegraph, grid_scenegraph_id, direction, spacing, nil, use_is_focused)
    local render_scale = self._render_scale
  
    grid:set_render_scale(render_scale)
  
    return grid
end

ScoreboardHistoryView._setup_content_widgets = function(self, content, scenegraph_id, callback_name)
    local definitions = self._definitions
    local widget_definitions = {}
    local widgets = {}
    local alignment_list = {}
    local amount = #content

    for i = amount, 1, -1 do
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
                widget.file = entry.file
                widget.file_path = entry.file_path
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

-- ##### ███████╗██╗  ██╗██╗████████╗ #################################################################################
-- ##### ██╔════╝╚██╗██╔╝██║╚══██╔══╝ #################################################################################
-- ##### █████╗   ╚███╔╝ ██║   ██║    #################################################################################
-- ##### ██╔══╝   ██╔██╗ ██║   ██║    #################################################################################
-- ##### ███████╗██╔╝ ██╗██║   ██║    #################################################################################
-- ##### ╚══════╝╚═╝  ╚═╝╚═╝   ╚═╝    #################################################################################

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

    if self.ui_manager:view_active("scoreboard_view") and not self.ui_manager:is_view_closing("scoreboard_view") then
        self.ui_manager:close_view("scoreboard_view", true)
    end

    ScoreboardHistoryView.super.on_exit(self)
end

-- #####  ██████╗ █████╗ ██╗     ██╗     ██████╗  █████╗  ██████╗██╗  ██╗███████╗ #####################################
-- ##### ██╔════╝██╔══██╗██║     ██║     ██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔════╝ #####################################
-- ##### ██║     ███████║██║     ██║     ██████╔╝███████║██║     █████╔╝ ███████╗ #####################################
-- ##### ██║     ██╔══██║██║     ██║     ██╔══██╗██╔══██║██║     ██╔═██╗ ╚════██║ #####################################
-- ##### ╚██████╗██║  ██║███████╗███████╗██████╔╝██║  ██║╚██████╗██║  ██╗███████║ #####################################
-- #####  ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝ #####################################

ScoreboardHistoryView.cb_on_category_pressed = function(self, widget, entry)
    local pressed_function = entry.pressed_function
  
    -- local text = widget.file_path or ""
    self.entry, self.groups = mod:load_scoreboard_history_entry(widget.file_path, widget.file, false)
    -- mod:dtf(self.entry, "self.entry", 5)

    if pressed_function then
        pressed_function(self, widget, entry)
    end
end

ScoreboardHistoryView.cb_on_back_pressed = function(self)
    self.ui_manager:close_view("scoreboard_history_view")
end

ScoreboardHistoryView.cb_delete_pressed = function(self)
    if self.entry then
        if mod:delete_scoreboard_history_entry(self.entry.name) then
            mod:close_scoreboard_view()
            self.entry = nil
            self:_setup_category_config()
        end
    end
end

ScoreboardHistoryView.cb_reload_cache_pressed = function(self)
    if self.ui_manager:view_active("scoreboard_view") and not self.ui_manager:is_view_closing("scoreboard_view") then
        self.ui_manager:close_view("scoreboard_view", true)
    end
    self.entry = nil
    self:_setup_category_config(true)
end
  
ScoreboardHistoryView.cb_reset_category_to_default = function(self)	
end

-- ##### ██╗   ██╗██████╗ ██████╗  █████╗ ████████╗███████╗ ###########################################################
-- ##### ██║   ██║██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔════╝ ###########################################################
-- ##### ██║   ██║██████╔╝██║  ██║███████║   ██║   █████╗   ###########################################################
-- ##### ██║   ██║██╔═══╝ ██║  ██║██╔══██║   ██║   ██╔══╝   ###########################################################
-- ##### ╚██████╔╝██║     ██████╔╝██║  ██║   ██║   ███████╗ ###########################################################
-- #####  ╚═════╝ ╚═╝     ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝ ###########################################################

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

-- ##### ██████╗ ██████╗  █████╗ ██╗    ██╗ ###########################################################################
-- ##### ██╔══██╗██╔══██╗██╔══██╗██║    ██║ ###########################################################################
-- ##### ██║  ██║██████╔╝███████║██║ █╗ ██║ ###########################################################################
-- ##### ██║  ██║██╔══██╗██╔══██║██║███╗██║ ###########################################################################
-- ##### ██████╔╝██║  ██║██║  ██║╚███╔███╔╝ ###########################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚══╝╚══╝  ###########################################################################

ScoreboardHistoryView.draw = function(self, dt, t, input_service, layer)
    self:_draw_elements(dt, t, self._ui_renderer, self._render_settings, input_service)
    -- self:_draw_widgets(dt, t, input_service)
    local ui_renderer = self._ui_offscreen_renderer
    local widgets_by_name = self._widgets_by_name
    local grid_interaction_widget = widgets_by_name.grid_interaction
    self:_draw_grid(self._category_content_grid, self._category_content_widgets, grid_interaction_widget, dt, t, input_service)
    ScoreboardHistoryView.super.draw(self, dt, t, input_service, layer)
end

ScoreboardHistoryView._draw_elements = function(self, dt, t, ui_renderer, render_settings, input_service)
    ScoreboardHistoryView.super._draw_elements(self, dt, t, ui_renderer, render_settings, input_service)
end

ScoreboardHistoryView._draw_grid = function (self, grid, widgets, interaction_widget, dt, t, input_service)
    local is_grid_hovered = not self._using_cursor_navigation or interaction_widget.content.hotspot.is_hover or false
    local null_input_service = input_service:null_service()
    local render_settings = self._render_settings
    local ui_renderer = self._ui_offscreen_renderer
    local ui_scenegraph = self._ui_scenegraph

    UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, render_settings)



    for j = 1, #widgets do
        local widget = widgets[j]
        local draw = widget ~= self._selected_settings_widget

        if draw then
            if self._selected_settings_widget then
                ui_renderer.input_service = null_input_service
            end

            if grid:is_widget_visible(widget) then
                local hotspot = widget.content.hotspot

                if hotspot then
                    hotspot.force_disabled = not is_grid_hovered
                    local is_active = hotspot.is_focused or hotspot.is_hover

                    if is_active and widget.content.entry and (widget.content.entry.tooltip_text or widget.content.entry.disabled_by and not table.is_empty(widget.content.entry.disabled_by)) then
                        self:_set_tooltip_data(widget)
                    end
                end

                UIWidget.draw(widget, ui_renderer)
            end
        end
    end

    UIRenderer.end_pass(ui_renderer)
end

return ScoreboardHistoryView