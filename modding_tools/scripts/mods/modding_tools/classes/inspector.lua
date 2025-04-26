local mod = get_mod("modding_tools")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
	local ScriptGui = mod:original_require("scripts/foundation/utilities/script_gui")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
    local Gui = Gui
    local math = math
    local type = type
    local class = class
    local pairs = pairs
    local Color = Color
    local table = table
    local string = string
    local vector3 = Vector3
    local tostring = tostring
    local managers = Managers
    local math_min = math.min
    local math_max = math.max
    local math_ceil = math.ceil
    local math_clamp = math.clamp
    local math_floor = math.floor
    local string_len = string.len
    local string_sub = string.sub
    local vector3_box = Vector3Box
    local table_clear = table.clear
    local Application = Application
    local DevParameters = DevParameters
    local quaternion_box = QuaternionBox
    local script_gui_text = ScriptGui.text
    local vector3_unbox = vector3_box.unbox
    local gui_text_extents = Gui.text_extents
    local script_gui_icrect = ScriptGui.icrect
    local RESOLUTION_LOOKUP = RESOLUTION_LOOKUP
    local quaternion_unbox = quaternion_box.unbox
    local math_point_is_inside_2d_box = math.point_is_inside_2d_box
--#endregion

-- ##### ┬┌┐┌┌─┐┌─┐┌─┐┌─┐┌┬┐┌─┐┬─┐  ┌─┐┬  ┌─┐┌─┐┌─┐ ###################################################################
-- ##### ││││└─┐├─┘├┤ │   │ │ │├┬┘  │  │  ├─┤└─┐└─┐ ###################################################################
-- ##### ┴┘└┘└─┘┴  └─┘└─┘ ┴ └─┘┴└─  └─┘┴─┘┴ ┴└─┘└─┘ ###################################################################

local tabs = {}
local context = {
    Watch = "Watch",
    InspectInNewTab = "Inspect in new tab",
}
local column_names = {
    "Key", "Type", "Value"
}
local Inspector = class("Inspector")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

Inspector.init = function(self, init_data)
    -- Colors
    self.background = init_data and init_data.background or quaternion_box(Color(128, 0, 0, 0))
    self.context_menu_background = init_data and init_data.context_menu_background or quaternion_box(Color(255, 0, 0, 0))
    self.context_menu = {options = {context.Watch, context.InspectInNewTab}, visible = false, position = vector3_box(vector3(0, 0, 0))}
    self.scrollbar = {cursor = vector3_box(vector3(0, 0, 0)), hover = false, active = false, scroll = 1}
    self.hover_background = init_data and init_data.hover_background or quaternion_box(Color(200, 0, 0, 0))
    self.hover_scrollbar = init_data and init_data.hover_scrollbar or quaternion_box(Color(128, 128, 128, 255))
    self.highlight = init_data and init_data.highlight or quaternion_box(Color(128, 128, 128, 255))
    self.highlight_faded = init_data and init_data.highlight or quaternion_box(Color(64, 128, 128, 255))
    self.color = init_data and init_data.color or quaternion_box(Color.white())
    self.lowlight = init_data and init_data.lowlight or quaternion_box(Color(128, 255, 255, 255))
    self.disabled_color = init_data and init_data.disabled_color or quaternion_box(Color(64, 255, 255, 255))
    self.shadow = init_data and init_data.shadow or quaternion_box(Color.gray())
    -- Values
    self.z = init_data and init_data.z or 997
    self.font_size = init_data and init_data.font_size or 16
    self.font = init_data and init_data.font or DevParameters.debug_text_font
    self.RES_X, self.RES_Y = Application.back_buffer_size()
    -- Sizes
    local screen_size = self:screen_size()
    self.row_height = init_data and init_data.row_height or 20
    self.size = init_data and init_data.size and vector3_box(init_data.size) or vector3_box(vector3(screen_size[1] / 2, screen_size[2] / 2, 0))
    local size = vector3_unbox(self.size)
    self.title_size = init_data and init_data.title_size and vector3_box(init_data.title_size) or vector3_box(vector3(size[1], 40, 0))
    local title_size = vector3_unbox(self.title_size)
    self.adress_position = vector3_box(vector3(0, title_size[2], 1))
    self.adress_size = init_data and init_data.adress_size and vector3_box(init_data.adress_size) or vector3_box(vector3(size[1], 20, 0))
    local adress_size = vector3_unbox(self.adress_size)
    self.min_size = init_data and init_data.min_size and vector3_box(init_data.min_size) or vector3_box(vector3(screen_size[1], 600, 0))
    self.frame_position = vector3_box(vector3(0, title_size[2] + adress_size[2], 1))
    self.frame_position_inner = vector3_box(vector3_unbox(self.frame_position) + vector3(10, 10, 0))
    self.frame_size = vector3_box(vector3(size[1], size[2] - title_size[2] - adress_size[2], 0))
    self.frame_size_inner = vector3_box(vector3_unbox(self.frame_size) - vector3(20, 20, 0))
    -- Positions
    self.position = init_data and init_data.position and vector3_box(init_data.position) or vector3_box(vector3(screen_size[1] - size[1], screen_size[2] / 2, self.z))
    -- Other
    self.dirty = true
    self.current = nil
    self.scroll = 0
    self.max_scroll = 0
    self.history = {}
    self.line_sizes = {}
    self.longest_key = 0
    self.longest_type = 0
    self.longest_value = 0
    self.available_value = 0
    self.lines = {}
    self.visible = init_data and init_data.visible or false
    self.was_pressed = false
    self.drawing_time = 0
    self.initialized = true
end

Inspector.destroy = function(self)
    -- Hide
    self:show(false)
    -- Clear
    self:clear()
    -- Unset
	self.initialized = false
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

Inspector.update = function(self, dt, t, input_service)
    -- Reset mouse button was pressed this loop
    self.was_pressed = false
    -- Cache
    self.max_scroll = #self.lines - self:visible_rows()
    self._gui, self._gui_retained = mod:forward_gui()
    self._cursor = self:cursor(input_service)
    self._size = vector3_unbox(self.size)
    self._frame_size_inner = vector3_unbox(self.frame_size_inner)
    self._title_size = vector3_unbox(self.title_size)
    self._button_size = vector3(self._title_size[2] - 20, self._title_size[2] - 20, 0)
    self._position = vector3_unbox(self.position)
    self._breadcrumb_offset = vector3(20, -8, 0)
    self._frame_position = self._position + vector3_unbox(self.frame_position_inner)
    self._adress_position = self._position + vector3_unbox(self.adress_position)
    self._adress_size = vector3_unbox(self.adress_size)
    self._context_menu_position = vector3_unbox(self.context_menu.position)
    self._color = quaternion_unbox(self.color)
    self._background = quaternion_unbox(self.background)
    self._context_menu_background = quaternion_unbox(self.context_menu_background)
    self._shadow = quaternion_unbox(self.shadow)
    self._disabled_color = quaternion_unbox(self.disabled_color)
    self._hover_background = quaternion_unbox(self.hover_background)
    self._highlight = quaternion_unbox(self.highlight)
    self._lowlight = quaternion_unbox(self.lowlight)
    self._highlight_faded = quaternion_unbox(self.highlight_faded)
    self._is_tab = self ~= mod.inspector
    self._pressed = self:pressed(input_service)
    self._scroll_axis = input_service:get("scroll_axis")
    self._held = self:held(input_service)
    self._context_pressed = self:context_pressed(input_service)
    -- Disable control
    self.disable_control = mod.console_busy or mod.watcher_busy
	if self.initialized and self.visible then
		return self:draw(dt, t, input_service)
	end
end

Inspector.draw = function(self, dt, t, input_service)
    local handle = Application.query_performance_counter()
    local is_busy = false
    is_busy = self:draw_frame(input_service)
    is_busy = self:draw_scroll(input_service) or is_busy
    is_busy = self:draw_title_bar(input_service) or is_busy
    is_busy = self:draw_bread_crumbs(input_service) or is_busy
    is_busy = self:draw_context_menu(input_service) or is_busy
    self:get_line_sizes()
    is_busy = self:draw_lines(input_service) or is_busy
    self.drawing_time = Application.time_since_query(handle)
    -- Return busy
    return is_busy == true and true
end

Inspector.update_content = function(self)
    if self.current then
        table_clear(self.lines)
        for key, value in pairs(self.current.table) do
            self.lines[#self.lines+1] = {
                key = key,
                value = value,
                is_table = type(value) == "table",
            }
        end
    end
end

Inspector.draw_title_bar = function(self, input_service)
    -- Check if gui is available
    if self._gui then
        -- Title text
        local t_min, t_max, t_caret = gui_text_extents(self._gui, "Inspector", self.font, self.font_size * 1.5)
        script_gui_text(self._gui, "Inspector", self.font, self.font_size * 1.5, vector3(self._position[1] + 60, self._position[2] + 7, self._position[3] + 1), self._color, self._shadow)
        local title_hover = not self.scrollbar.active and not self.disable_control and math_point_is_inside_2d_box(self._cursor, self._position, self._title_size)
        -- Back button
        local button_position = vector3(self._position[1] + 10, self._position[2] + 10, self._position[3] + 1)
        -- local button_size = vector3(self._title_size[2] - 20, self._title_size[2] - 20, 0)
        local button_hover = #self.history > 0 and not self.scrollbar.active and not self.disable_control and math_point_is_inside_2d_box(self._cursor, button_position, self._button_size)
        -- Back Button hover
        if button_hover then
            -- Highlight
            script_gui_icrect(self._gui, self.RES_X, self.RES_Y, button_position[1], button_position[2], button_position[1] + self._button_size[1], button_position[2] + self._button_size[2], self.z, self._highlight)
        end
        local button_color = #self.history > 0 and self._color or self._disabled_color
        local min, max, caret = gui_text_extents(self._gui, "<", self.font, self.font_size)
        script_gui_text(self._gui, "<", self.font, self.font_size * 2, button_position + vector3(5 - max.x / 2, -max.y / 2, 0), button_color, self._shadow)
        -- Close button
        local close_button_position = vector3(self._position[1] + self._size[1] - 10 - self._button_size[1], self._position[2] + 10, self._position[3] + 1)
        local close_button_hover = not self.scrollbar.active and not self.disable_control and math_point_is_inside_2d_box(self._cursor, close_button_position, self._button_size)
        -- Close button hover
        if close_button_hover then
            script_gui_icrect(self._gui, self.RES_X, self.RES_Y, close_button_position[1], close_button_position[2], close_button_position[1] + self._button_size[1], close_button_position[2] + self._button_size[2], self.z, self._highlight)
        end
        local min, max, caret = gui_text_extents(self._gui, "x", self.font, self.font_size)
        script_gui_text(self._gui, "x", self.font, self.font_size * 2, close_button_position + vector3(7 - max.x / 2, -2 - max.y / 2, 0), self._color, self._shadow)
        -- Clear button
        local clear_button_position = vector3(self._position[1] + 70 + t_max.x, self._position[2] + 10, self._position[3] + 1)
        -- Clear button hover
        local clear_button_hover = not self.scrollbar.active and not self.disable_control and math_point_is_inside_2d_box(self._cursor, clear_button_position, self._button_size)
        if clear_button_hover then
            script_gui_icrect(self._gui, self.RES_X, self.RES_Y, clear_button_position[1], clear_button_position[2], clear_button_position[1] + self._button_size[1],
                clear_button_position[2] + self._button_size[2], self.z, self._highlight)
        end
        -- Clear button draw
        local min, max, caret = gui_text_extents(self._gui, "cl", self.font, self.font_size)
        script_gui_text(self._gui, "cl", self.font, self.font_size * 1.5, clear_button_position + vector3(7 - max.x / 2, 5 - max.y / 2, 0), self._color, self._shadow)

        -- Tabs
        local start_x, busy = 0, false
        start_x, busy = self:draw_tab_button(start_x, self._gui, clear_button_position, input_service, mod.inspector)
        if mod.inspector_tabs and #mod.inspector_tabs > 0 then
            -- Tab button
            for i, inspector_tab in pairs(mod.inspector_tabs) do
                start_x, busy = self:draw_tab_button(start_x, self._gui, clear_button_position, input_service, inspector_tab)
            end
        end
        if busy == true then return true end
        -- Functionality
        if button_hover then
            -- Check pressed
            if not self.was_pressed and self._pressed then
                self.was_pressed = true
                -- Return busy
                self:back()
            end
            -- Return busy
            return true
        elseif close_button_hover then
            -- Check pressed
            if not self.was_pressed and self._pressed then
                self.was_pressed = true
                if self._is_tab then
                    -- self:destroy()
                    mod:inspector_close_tab(self)
                    mod:inspector_switch_tab(mod.inspector)
                else
                    -- Return busy
                    self:show(false)
                end
            end
            -- Return busy
            return true
        elseif clear_button_hover then
            -- Check pressed
            if not self.was_pressed and self._pressed then
                self.was_pressed = true
                if self._is_tab then
                    -- self:destroy()
                    mod:inspector_close_tab(self)
                    mod:inspector_switch_tab(mod.inspector)
                else
                    -- Clear
                    self:clear()
                end
            end
            -- Return busy
            return true
        end
    end
end

Inspector.draw_tab_button = function(self, start_x, gui, clear_button_position, input_service, inspector_tab)
    local text = inspector_tab.current and inspector_tab.current.key or "..."
    local t_min, t_max, t_caret = gui_text_extents(gui, text, self.font, self.font_size)
    local tab_x, tab_y = clear_button_position[1] + 30 + start_x--+ t_max.x

    local limit = 80
    if t_max.x > limit then
        text = string_sub(text, 1, math_min(20, string_len(text))).."..."
        t_min, t_max, t_caret = gui_text_extents(gui, text, self.font, self.font_size)
    end
    local tab_width = t_max.x + 20
    local tab_button_position = vector3(tab_x, clear_button_position[2], clear_button_position[3])
    script_gui_text(gui, text, self.font, self.font_size, vector3(tab_button_position[1] + 10, tab_button_position[2], tab_button_position[3]), self._color, self._shadow)

    local tab_button_hover = not self.scrollbar.active and not self.disable_control and math_point_is_inside_2d_box(self._cursor, tab_button_position, vector3(tab_width, self._button_size[2], 1))
    if tab_button_hover then
        script_gui_icrect(gui, self.RES_X, self.RES_Y, tab_button_position[1], tab_button_position[2], tab_button_position[1] + tab_width, tab_button_position[2] + self._button_size[2], self.z, self._highlight)
        -- Check pressed
        if not self.was_pressed and self._pressed then
            self.was_pressed = true
            -- Switch tab
            mod:inspector_switch_tab(inspector_tab)
            -- Return busy
            return start_x + tab_width, true
        end
    elseif inspector_tab.visible then
        script_gui_icrect(gui, self.RES_X, self.RES_Y, tab_button_position[1], tab_button_position[2], tab_button_position[1] + tab_width, tab_button_position[2] + self._button_size[2], self.z, self._highlight_faded)
    end
    return start_x + tab_width, false
end

Inspector.draw_frame = function(self, input_service)
    -- Check if gui is available
    if self._gui then
        -- Values
        local total_height = #self.lines *  self.row_height
        -- Frame hover
        self.hover = not self.disable_control and math_point_is_inside_2d_box(self._cursor, self._position, self._size)
        -- Background
        local background = self.hover and self._hover_background or self._background
        -- Draw frame
        script_gui_icrect(self._gui, self.RES_X, self.RES_Y, self._position[1], self._position[2], self._position[1] + self._size[1], self._position[2] + self._size[2], self.z, background)
        -- Functionality
        if total_height > self._frame_size_inner[2] then
            -- Scroll
            if self.hover then
                self.scroll = math_ceil(math_clamp(self.scroll - self._scroll_axis[2], 0, self.max_scroll))
            end
            -- self.max_scroll = math_ceil(#self.lines - self._frame_size_inner[2] / self.row_height) + 1
        else
            self.scroll = 0
        end
        if self.hover and self.context_menu.visible and not self.context_menu.hover then
            if not self.was_pressed and self._pressed then
                self.was_pressed = true
                self:close_context_menu()
            end
        elseif not self.hover and not self.context_menu.hover then
            self:close_context_menu()
        end
        -- Return busy
        return self.hover == true and true
    end
end

Inspector.draw_bread_crumbs = function(self, input_service)
    -- Check if gui is available
    if self._gui then
        local is_busy = false
        -- Values
        local x = 0
        -- Iterate history entries
        for _, history in pairs(self.history) do
            -- Get dimensions
            local value = tostring(history.key)
            local min, max, caret = gui_text_extents(self._gui, value, self.font, self.font_size)
            if max.x > self._size[1] / 2 then
                value = "..."..string_sub(value, string_len(value) - 20, string_len(value))
                min, max, caret = gui_text_extents(self._gui, value, self.font, self.font_size)
            end
            -- Position
            local crumb_position = self._adress_position + vector3(x, 0, 1) + self._breadcrumb_offset
            -- Hover
            history.hover = not self.scrollbar.active and not self.disable_control and math_point_is_inside_2d_box(self._cursor, crumb_position, vector3(max.x, 20, 0))
            -- Check hover
            if history.hover and not self.context_menu.hover then
                -- Check highlight background
                script_gui_icrect(self._gui, self.RES_X, self.RES_Y, crumb_position[1], crumb_position[2], crumb_position[1] + max.x, crumb_position[2] + 20, self.z, self._highlight)
                -- Check pressed
                if not self.was_pressed and self._pressed then
                    self.was_pressed = true
                    -- Update current
                    self.current = history
                    -- Splice history
                    for i = #self.history, _, -1 do
                        self.history[i] = nil
                    end
                    -- Update content
                    self:update_content()
                    -- Return busy
                    return true
                end
                -- Return busy
                is_busy = true
            end
            -- Draw text
            script_gui_text(self._gui, value, self.font, self.font_size, crumb_position, self._color, self._shadow)
            -- Draw arrow
            script_gui_text(self._gui, ">", self.font, self.font_size, crumb_position + vector3(max.x + 8, 0, 0), self._color, self._shadow)
            -- Update x
            x = x + max.x + 20
        end
        -- Get current dimensions
        if self.current then
            local value = tostring(self.current.key)
            local crumb_position = self._adress_position + vector3(x, 0, 1) + self._breadcrumb_offset
            local min, max, caret = gui_text_extents(self._gui, value, self.font, self.font_size)
            if max.x > self._size[1] / 2 then
                value = "..."..string_sub(value, string_len(value) - 20, string_len(value))
                min, max, caret = gui_text_extents(self._gui, value, self.font, self.font_size)
            end
            -- Draw current text
            script_gui_text(self._gui, value, self.font, self.font_size, crumb_position, self._color, self._shadow)
        end
        -- Return busy
        return is_busy == true and true
    end
end

Inspector.draw_scroll = function(self, input_service)
    -- Check if gui is available
    if self._gui then
        -- Values
        local held = false
        local total_lines_height = self:total_lines_height()
        local scroll_bar_height = self:scrollbar_height()
        local scroll_bar_color = total_lines_height > self._frame_size_inner[2] and self._color or self._disabled_color
        local scroll_offset = total_lines_height > self._frame_size_inner[2] and self.scroll * self._frame_size_inner[2] / #self.lines or 0
        local y = self._position[2] + self._title_size[2] + self._adress_size[2] + scroll_offset
        local y2 = y + scroll_bar_height

        self.scrollbar.hover = not self.disable_control and math_point_is_inside_2d_box(self._cursor, vector3(self._position[1] + self._size[1] - 10, y, 1), vector3(5, scroll_bar_height, 1))

        if self.scrollbar.hover then
            held = self._held
            if held ~= self.scrollbar.active then
                self:close_context_menu()
                self.scrollbar.active = held
            end
        end

        if self.scrollbar.hover or self.scrollbar.active then
            script_gui_icrect(self._gui, self.RES_X, self.RES_Y, self._position[1] + self._size[1] - 10, y, self._position[1] + self._size[1] - 5, y2, 1000, self._highlight)
        else
            script_gui_icrect(self._gui, self.RES_X, self.RES_Y, self._position[1] + self._size[1] - 10, y, self._position[1] + self._size[1] - 5, y2, 1000, scroll_bar_color)
        end

        if self.scrollbar.active then
            local diff = vector3_unbox(self.scrollbar.cursor) - self._cursor
            self.scroll = math_ceil(math_clamp(self.scrollbar.scroll - (diff[2] / scroll_bar_height) * self.row_height, 0, self.max_scroll))
            self:scrolled()
            if not self._held then
                self.scrollbar.active = false
            end
        else
            self.scrollbar.cursor = vector3_box(self._cursor)
            self.scrollbar.scroll = self.scroll
        end

        return self.scrollbar.active == true and true

    end
end

Inspector.draw_context_menu = function(self, input_service)
    -- Check if gui is available
    if self._gui and self.context_menu.visible then
        -- Values
        local size = vector3(160, self.row_height * #self.context_menu.options + 20, 0)
        
        script_gui_icrect(self._gui, self.RES_X, self.RES_Y, self._context_menu_position[1], self._context_menu_position[2], self._context_menu_position[1] + size[1], self._context_menu_position[2] + size[2], 1000, self._context_menu_background)

        local y = 10

        self.context_menu.hover = false
        for _, option in pairs(self.context_menu.options) do

            local row_position = vector3(self._context_menu_position[1] + 10, self._context_menu_position[2] + y, self._context_menu_position[3])
            local row_size = vector3(size[1] - 20, self.row_height, 0)

            local hover = not self.disable_control and math_point_is_inside_2d_box(self._cursor, row_position, row_size)

            if hover then
                self.context_menu.hover = true
                script_gui_icrect(self._gui, self.RES_X, self.RES_Y, row_position[1], row_position[2], row_position[1] + row_size[1], row_position[2] + row_size[2], 1000, self._highlight)
                if not self.was_pressed and self._pressed then
                    self.was_pressed = true
                    if option == context.Watch then
                        mod:watcher_set_mod(mod)
                        mod:watch(self.context_menu.line.key, self.current.table, self.context_menu.line.key)
                        self:close_context_menu()
                        return true
                    elseif option == context.InspectInNewTab then
                        mod:inspect_new(self.context_menu.line.key, self.current.table[self.context_menu.line.key])
                        self:close_context_menu()
                        return true
                    end
                end
            end

            script_gui_text(self._gui, option, self.font, self.font_size, vector3(row_position[1] + 10, row_position[2], 1000), self._color, self._shadow)

            y = y + self.row_height
        end

        return self.context_menu.hover
    end
end

Inspector.draw_lines = function(self, input_service)
    -- Check if gui is available
    if self._gui then
        local is_busy = false
        -- Values
        local y = 0
        local line_nr = 1
        -- local visible_lines = math_ceil(self._frame_size_inner[2] / self.row_height)
        local max_line = math_min(self.scroll + self:visible_rows(), #self.lines)
        -- Iterate lines
        for index = self.scroll, max_line, 1 do
            local line = self.lines[index]
            if line then

                if y + self.row_height < self._frame_size_inner[2] then
                
                    local row_position = vector3(self._frame_position[1], self._frame_position[2] + y, self._frame_position[3])
                    local row_size = vector3(self._frame_size_inner[1] - 10, self.row_height, 0)
                    if (line_nr % 2 == 0) then
                        script_gui_icrect(self._gui, self.RES_X, self.RES_Y, row_position[1], row_position[2], row_position[1] + row_size[1], row_position[2] + row_size[2], self.z, Color(20, 255, 255, 255))
                    end
                    local hover = not self.scrollbar.active and not self.disable_control and math_point_is_inside_2d_box(self._cursor, row_position, row_size)

                    if (hover and not self.context_menu.visible) or (self.context_menu.visible and self.context_menu.line == line) then
                        script_gui_icrect(self._gui, self.RES_X, self.RES_Y, row_position[1], row_position[2], row_position[1] + row_size[1], row_position[2] + row_size[2], self.z, self._highlight)
                    end
                    if hover and not self.context_menu.visible then
                        if not self.was_pressed and self._pressed then
                            self.was_pressed = true
                            if line.is_table and self.current.table[line.key] and type(self.current.table[line.key]) == "table" then
                                self:navigate(line.key, self.current.table[line.key])
                            end
                        end
                        if self._context_pressed then
                            self:open_context_menu(line, self._cursor)
                        end
                        is_busy = true
                    end

                    local color = line.is_table and self._color or quaternion_unbox(self.lowlight)

                    -- Row 1 - Key
                    script_gui_text(self._gui, line.shortend_key or tostring(line.key), self.font, self.font_size, vector3(self._frame_position[1] + 10, self._frame_position[2] + y, self._frame_position[3] + 1), color, self._shadow)

                    -- Row 2 - Type
                    script_gui_text(self._gui, type(line.value), self.font, self.font_size, vector3(self._frame_position[1] + 10 + self.longest_key + 10, self._frame_position[2] + y, self._frame_position[3] + 1), color, self._shadow)

                    -- Row 3 - Value
                    local value = tostring(line.value)
                    local min, max, caret = gui_text_extents(self._gui, value, self.font, self.font_size)
                    if max.x > self.available_value then
                        value = "..."..string_sub(value, math_max(1, string_len(value) - 20), string_len(value))
                        -- min, max, caret = gui_text_extents(gui, value, self.font, self.font_size)
                    end
                    script_gui_text(self._gui, value, self.font, self.font_size, vector3(self._frame_position[1] + row_size[1] - 10 - max.x, self._frame_position[2] + y, self._frame_position[3] + 1), color, self._shadow)

                    y = y + self.row_height
                    line_nr = line_nr + 1
                end
            end
        end

        if max_line - self.scroll > 0 then
            -- Draw column texts
            local key_x, key_y, key_z = self._frame_position[1] + 10, self._frame_position[2] - 20, self._frame_position[3] + 1
            local type_x, type_y, type_z = key_x + self.longest_key + 10, key_y, key_z
            local value_x, value_y, value_z = type_x + self.longest_type + 10, key_y, key_z
            -- local graph_x, graph_y, graph_z = value_x + self.longest_value + 10, key_y, key_z
            local col_x, col_y, col_z = key_x, key_y, key_z
            local min, max, caret = gui_text_extents(self._gui, "Graph", self.font, self.font_size)
            local width = ((self.available_value - max.x - 10) / 2) - 5
            -- Iterate columns
            for index = 1, 3, 1 do
                if index == 2 then col_x = key_x + self.longest_key + 10 end
                if index == 3 then col_x = type_x + self.longest_type + 10 end
                -- if index == 4 then col_x = value_x + self.longest_value + 10 end
                script_gui_text(self._gui, column_names[index], self.font, self.font_size, vector3(col_x, col_y, col_z), self._lowlight, self._shadow)
            end
        end

        -- Return busy
        return is_busy == true and true
    end
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

Inspector.changed = function(self) end
Inspector.cleared = function(self) end
Inspector.shown = function(self) end
Inspector.hidden = function(self) end
Inspector.context_shown = function(self) end
Inspector.context_hidden = function(self) end
Inspector.scrolled = function(self) end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

Inspector.screen_size = function(self)
    return vector3(RESOLUTION_LOOKUP.width, RESOLUTION_LOOKUP.height, 0)
end

Inspector.scrollbar_height = function(self)
    local frame_size = vector3_unbox(self.frame_size_inner)
    return frame_size[2] * math_clamp(frame_size[2] / self:total_lines_height(), 0, 1)
end

Inspector.total_lines_height = function(self)
    return self.row_height * #self.lines
end

Inspector.cursor = function(self, input_service)
	return input_service and input_service:get("cursor") or vector3(0, 0, 0)
end

Inspector.held = function(self, input_service)
    return input_service and input_service:get("left_hold") or false
end

Inspector.pressed = function(self, input_service)
	return input_service and input_service:get("left_pressed") or false
end

Inspector.context_pressed = function(self, input_service)
    return input_service and input_service:get("right_pressed") or false
end

Inspector.visible_rows = function(self)
    local frame_size = vector3_unbox(self.frame_size) - vector3(20, 20, 0)
    return math_floor(frame_size[2] / self.row_height)
end

-- ##### ┬┌┐┌┌┬┐┌─┐┬─┐┌┐┌┌─┐┬    ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ################################################################
-- ##### ││││ │ ├┤ ├┬┘│││├─┤│    │││├┤  │ ├─┤│ │ ││└─┐ ################################################################
-- ##### ┴┘└┘ ┴ └─┘┴└─┘└┘┴ ┴┴─┘  ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ################################################################

Inspector.open_context_menu = function(self, line, position)
    self.context_menu.line = line
    self.context_menu.position:store(position[1], position[2], position[3])
    self._context_menu_position = position
    self.context_menu.visible = true
    self:context_shown()
end

Inspector.close_context_menu = function(self)
    self.context_menu.visible = false
    self.context_menu.hover = false
    self:context_hidden()
end

Inspector.get_line_sizes = function(self)
    local gui, gui_retained = mod:forward_gui()
    if gui then
        self.longest_key = 0
        self.longest_type = 0
        self.longest_value = 0
        table_clear(self.line_sizes)
        -- local frame_size = vector3_unbox(self.frame_size_inner)
        -- local visible_lines = math_ceil(self._frame_size_inner[2] / self.row_height)
        local max_line = math_min(self.scroll + self:visible_rows(), #self.lines)
        -- for index, line in pairs(self.lines) do
        for index = self.scroll, max_line, 1 do
            local line = self.lines[index]
            if line then
                if not line.shortend_key then
                    line.shortend_key = tostring(line.key)
                    local min, max, caret = gui_text_extents(gui, line.shortend_key, self.font, self.font_size)
                    if max.x > self._frame_size_inner[1] * .6 then
                        line.shortend_key = "..."..string_sub(line.shortend_key, math_max(1, string_len(line.shortend_key) - 60), string_len(line.shortend_key))
                        -- .. "..."..string_sub(line.shortend_key, string_len(line.shortend_key) - 20, string_len(line.shortend_key))
                        -- min, max, caret = gui_text_extents(gui, line.shortend_key, self.font, self.font_size)
                    end
                end
                local k_min, k_max, k_caret = gui_text_extents(gui, line.shortend_key, self.font, self.font_size)
                local t_min, t_max, t_caret = gui_text_extents(gui, type(line.value), self.font, self.font_size)
                local v_min, v_max, v_caret = gui_text_extents(gui, tostring(line.value), self.font, self.font_size)
                if k_max.x > self.longest_key then self.longest_key = k_max.x end
                if t_max.x > self.longest_type then self.longest_type = t_max.x end
                if v_max.x > self.longest_value then self.longest_value = v_max.x end
                self.line_sizes[index] = {
                    key = {min = k_min, max = k_max, caret = k_caret},
                    type = {min = t_min, max = t_max, caret = t_caret},
                    value = {min = v_min, max = v_max, caret = v_caret},
                }
            end
        end
        -- local frame_size = vector3_unbox(self.frame_size_inner)
        self.available_value = self._frame_size_inner[1] - self.longest_key - self.longest_type
    end
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

Inspector.show = function(self, show)
    if show then mod:inspectors_hide() end
    self.visible = show
    mod:push_or_pop_cursor(self, "modding_tools_inspector")
end

Inspector.clear = function(self)
    table_clear(self.lines)
    table_clear(self.line_sizes)
    table_clear(self.history)
    self.current = nil
end

Inspector.back = function(self)
    if #self.history > 0 then
        self.current = self.history[#self.history]
        self.history[#self.history] = nil
        self.scroll = 0
        self:update_content()
    end
end

Inspector.navigate = function(self, key, table)
    if table and type(table) == "table" then
        if self.current then
            self.history[#self.history+1] = self.current
        end
        self.current = {
            key = key,
            table = table,
        }
        self.scroll = 0
        self:update_content()
    end
end

return Inspector