local mod = get_mod("scoreboard")
local DMF = get_mod("DMF")

local ScriptWorld = mod:original_require("scripts/foundation/utilities/script_world")
local InputUtils = mod:original_require("scripts/managers/input/input_utils")
local UIFonts = mod:original_require("scripts/managers/ui/ui_fonts")
local UIRenderer = mod:original_require("scripts/managers/ui/ui_renderer")
local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
local UIWidgetGrid = mod:original_require("scripts/ui/widget_logic/ui_widget_grid")
local ViewElementInputLegend = mod:original_require("scripts/ui/view_elements/view_element_input_legend/view_element_input_legend")
local CATEGORIES_GRID = 1
local USE_EXAMPLE_DATA = true
local DEBUG = false

local ScoreboardView = class("ScoreboardView", "BaseView")

-- ####################################################################################################################
-- ##### INIT #########################################################################################################
-- ####################################################################################################################

ScoreboardView.init = function(self, settings, context)
    self._definitions = mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard/scoreboard_view_definitions")
    self._blueprints = mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard/scoreboard_view_blueprints")
    self._settings = mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard/scoreboard_view_settings")
    -- self._context = context
    self.is_history = context and context.scoreboard_history or false
    ScoreboardView.super.init(self, self._definitions, settings)
    self._pass_draw = true
    self._pass_input = true
    self.widget_timers = {}
    self.widget_times = {}
    self.wait_timer = 0
    -- self:_setup_offscreen_gui()
end

-- ####################################################################################################################
-- ##### ENTER ########################################################################################################
-- ####################################################################################################################

ScoreboardView.on_enter = function(self)
    self._definitions = mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard/scoreboard_view_definitions")
    self._blueprints = mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard/scoreboard_view_blueprints")
    self._settings = mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard/scoreboard_view_settings")
    self.wait_timer = 0
    -- if not self._scorebaord_history_entries then
    -- 	self._scorebaord_history_entries = {
    -- 	  data = {},
    -- 	  entries = {},
    -- 	}
    -- 	-- dmf:create_mod_options_settings(self._options_templates)
    -- end
    ScoreboardView.super.on_enter(self)

    -- self._default_category = nil
    -- self._using_cursor_navigation = Managers.ui:using_cursor_navigation()
    local scoreboard_widget = self._widgets_by_name["scoreboard"]
    scoreboard_widget.alpha_multiplier = 0
    if self.is_history then scoreboard_widget.offset = {300, 0, 0} end
    self.widget_times["scoreboard"] = 0

    -- self:_setup_category_config()
    self:setup_row_widgets()
    -- self:_setup_input_legend()
    -- self:_enable_settings_overlay(false)
    -- self:_update_grid_navigation_selection()
end

ScoreboardView._setup_input_legend = function(self)
    self._input_legend_element = self:_add_element(ViewElementInputLegend, "input_legend", 10)
    local legend_inputs = self._definitions.legend_inputs
    for i = 1, #legend_inputs do
        local legend_input = legend_inputs[i]
        local on_pressed_callback = legend_input.on_pressed_callback and callback(self, legend_input.on_pressed_callback)
    
        self._input_legend_element:add_entry(legend_input.display_name, legend_input.input_action, 
            legend_input.visibility_function, on_pressed_callback, legend_input.alignment)
    end
end

ScoreboardView.row_example_data = function(self, row)
    if row.example and type(row.example) == "table" then
        return math.random(row.example[1], row.example[2])
    elseif row.example and type(row.example) == "number" then
        return row.example
    else
        return math.random(0, 10)
    end
end

ScoreboardView.delete_row_widgets = function(self)
    if self.row_widgets then
        for i = 1, #self.row_widgets do
            local widget = self.row_widgets[i]
            self._widgets_by_name[widget.name] = nil
            self:_unregister_widget_name(widget.name)
        end
        self.row_widgets = {}
    end
end

ScoreboardView.create_row_widget = function(self, index, current_offset, visible_rows)
    local this_row = mod.registered_scoreboard_rows[index]

    local widget = nil
    local template = table.clone(self._blueprints["scoreboard_row"])
    local size = template.size
    local pass_template = template.pass_template
    -- local scenegraph_id = "scoreboard_rows"
    local name = "scoreboard_row_"..this_row.name
    local header_height = self._settings.scoreboard_row_header_height
    local row_height = index == 1 and header_height or size[2] or 30

    -- Vertical offset
    if this_row.parent then
        local parent = self._widgets_by_name["scoreboard_row_"..this_row.parent]
        if parent then
            current_offset = parent.offset[2]
            row_height = parent.style.style_id_1.size[2]
        end
    end

    -- Set vertical row offset
    -- pass_template[1].style.offset[2] = current_offset
    -- pass_template[3].style.offset[2] = current_offset
    -- pass_template[5].style.offset[2] = current_offset
    -- pass_template[7].style.offset[2] = current_offset
    -- pass_template[9].style.offset[2] = current_offset
    -- pass_template[10].style.offset[2] = current_offset

    -- for j = 1, #pass_template do
    --     local pass = pass_template[j]
    --     if pass.value_id then
    --         pass.style.offset[2] = current_offset
    --         -- if this_row.parent then
    --         --     local parent = self._widgets_by_name["scoreboard_row_"..this_row.parent]
    --         --     pass.style.offset[2] = parent.offset[2]
    --         -- end
    --         if USE_EXAMPLE_DATA then
    --             pass.value = self:row_example_data(this_row)
    --         end
    --     end
    -- end

    if this_row.parent then
        local parent = self._widgets_by_name["scoreboard_row_"..this_row.parent]
        if parent then
            -- Find text chunk in parent
            local this_text = parent.content.text
            local s, e = string.find(this_text, this_row.text)
            if s then
                local before = string.sub(this_text, 1, s-1)
                if DEBUG then mod:echo("start:'"..tostring(s).."' end:'"..tostring(e).."' before:'"..before.."'") end

                -- Calculate parent text width
                local font_style = parent.style.style_id_1
                local font_type = font_style.font_type
                local font_size = font_style.font_size
                local scale = self._ui_renderer.scale or 1
                local scaled_font_size = UIFonts.scaled_size(font_size, scale)
                local sender_font_options = UIFonts.get_font_options_by_style(font_style)
                local text_width, text_height = UIRenderer.text_size(self._ui_renderer, before, font_type, scaled_font_size) --, {300}, sender_font_options)

                pass_template[1].style.offset[1] = pass_template[1].style.offset[1] + text_width + 5
            else
                if DEBUG then mod:echo("'"..this_row.text.."' not found in '"..this_text.."'") end
            end
        end
    end

    pass_template[1].value = this_row.text

    -- Alternate row
    local alternate_row = visible_rows % 2 == 0
    if alternate_row and not this_row.parent then
        pass_template[#pass_template].style.size[2] = row_height
    else
        pass_template[#pass_template] = nil
    end

    -- local offset_y = 0
    -- if self.is_history then pass_template[#pass_template].style.offset[1] = 300 end
    -- if this_row.parent then
    --     local parent = self._widgets_by_name["scoreboard_row_"..this_row.parent]
    --     offset_y = parent.offset[2]
    -- else
    --     offset_y = current_offset
    -- end
    -- pass_template[#pass_template].style.offset[2] = offset_y

    local widget_definition = UIWidget.create_definition(pass_template, "scoreboard_rows", nil, size)

    if widget_definition then
        widget = self:_create_widget(name, widget_definition)

        widget.alpha_multiplier = 0
        
        widget.offset = {self.is_history and 300 or 0, current_offset, 0}

        self.widget_times[widget.name] = index / 50

        return widget, row_height
    end
end

ScoreboardView.setup_row_widgets = function(self)
    self:delete_row_widgets()

    self.widget_times = self.widget_times or {}
    self.row_offsets = {}

    local widget_definitions = {}
    local current_offset = 0
    local visible_rows = 0

    for i = 1, #mod.registered_scoreboard_rows, 1 do
        local this_row = mod.registered_scoreboard_rows[i]
        if this_row.visible ~= false then
            local name = "scoreboard_row_"..this_row.name
            if not this_row.parent then
                visible_rows = visible_rows + 1
            end
            local widget, row_height = self:create_row_widget(i, current_offset, visible_rows)

            if widget then
                self.row_widgets = self.row_widgets or {}
                self.row_widgets[#self.row_widgets+1] = widget
                self._widgets_by_name = self._widgets_by_name or {}
                self._widgets_by_name[name] = widget
                if not this_row.parent then
                    current_offset = current_offset + row_height
                end
            end
        end
    end
end

-- ####################################################################################################################
-- ##### EXIT #########################################################################################################
-- ####################################################################################################################

ScoreboardView.remove_input_legend = function(self)
    if self._input_legend_element then
        self._input_legend_element = nil
        self:_remove_element("input_legend")
    end
end

ScoreboardView.on_exit = function(self)
    -- Remove legend
    self:remove_input_legend()
    ScoreboardView.super.on_exit(self)
end

-- ####################################################################################################################
-- ##### CALLBACKS ####################################################################################################
-- ####################################################################################################################

ScoreboardView.cb_on_save_pressed = function(self)
    -- Remove legend
    self:remove_input_legend()
    if DEBUG then mod:echo("Scoreboard saved") end
end

-- ####################################################################################################################
-- ##### UPDATE #######################################################################################################
-- ####################################################################################################################

ScoreboardView.update = function(self, dt, t, input_service, view_data)
    local drawing_view = view_data and view_data.drawing_view
    local using_cursor_navigation = Managers.ui:using_cursor_navigation()

    -- if self:_handling_keybinding() then
    --     if not drawing_view or not using_cursor_navigation then
    --         self:close_keybind_popup(true)
    --     end

    --     input_service = input_service:null_service()
    -- end

    -- self:_handle_keybind_rebind(dt, t, input_service)

    -- local close_keybind_popup_duration = self._close_keybind_popup_duration

    -- if close_keybind_popup_duration then
    --     if close_keybind_popup_duration < 0 then
    --         self._close_keybind_popup_duration = nil

    --         self:close_keybind_popup(true)
    --     else
    --         self._close_keybind_popup_duration = close_keybind_popup_duration - dt
    --     end
    -- end

    -- local grid_length = self._category_content_grid:length()

    -- if grid_length ~= self._grid_length then
    --     self._grid_length = grid_length
    -- end

    -- local category_grid_is_focused = self._selected_navigation_column_index == CATEGORIES_GRID
    -- local category_grid_input_service = category_grid_is_focused and input_service or input_service:null_service()

    -- self._category_content_grid:update(dt, t, category_grid_input_service)
    -- self:_update_category_content_widgets(dt, t)

    -- skdjlfsdf

    if self._tooltip_data and self._tooltip_data.widget and not self._tooltip_data.widget.content.hotspot.is_hover then
        self._tooltip_data = {}
        self._widgets_by_name.tooltip.content.visible = false
    end

    return ScoreboardView.super.update(self, dt, t, input_service)
end

ScoreboardView.animate_rows = function(self, dt)
    self.widget_timers = self.widget_timers or {}
    self.wait_timer = self.wait_timer or 0
    -- Iterate through all rows
    for name, widget in pairs(self._widgets_by_name) do
        -- Check state
        if widget.alpha_multiplier == 0 and not self.widget_timers[widget.name] then
            -- Alpha = 0 and timer not yet started
            if self.wait_timer and self.wait_timer >= self.widget_times[widget.name] then
                -- Start timer
                self.widget_timers[widget.name] = self._settings.scoreboard_fade_length
            end

        elseif self.widget_timers[widget.name] and self.widget_timers[widget.name] > 0 then
            -- Timer was started; Calculate alpha
            local percentage = self.widget_timers[widget.name] / self._settings.scoreboard_fade_length
            widget.alpha_multiplier = 1 - percentage
            self.widget_timers[widget.name] = self.widget_timers[widget.name] - dt

        elseif self.widget_timers[widget.name] and self.widget_timers[widget.name] <= 0 then
            -- Timer finished; Set alpha = 1
            widget.alpha_multiplier = 1
            self.widget_timers[widget.name] = nil

        end
    end
    self.wait_timer = self.wait_timer + dt
end

-- ####################################################################################################################
-- ##### DRAW #########################################################################################################
-- ####################################################################################################################

ScoreboardView.draw = function(self, dt, t, input_service, layer)
    self:_draw_elements(dt, t, self._ui_renderer, self._render_settings, input_service)
    self:_draw_widgets(dt, input_service)
end

ScoreboardView._draw_elements = function(self, dt, t, ui_renderer, render_settings, input_service)
    ScoreboardView.super._draw_elements(self, dt, t, ui_renderer, render_settings, input_service)
end

ScoreboardView._draw_widgets = function(self, dt, input_service)
    UIRenderer.begin_pass(self._ui_renderer, self._ui_scenegraph, input_service, dt, self._render_settings)
    self:animate_rows(dt)
    for name, widget in pairs(self._widgets_by_name) do
        UIWidget.draw(widget, self._ui_renderer)
    end
    UIRenderer.end_pass(self._ui_renderer)
end

return ScoreboardView