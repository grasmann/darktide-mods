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
    local table = table
    local class = class
    local pairs = pairs
    local Color = Color
    local CLASS = CLASS
    local vector3 = Vector3
    local managers = Managers
    local tostring = tostring
    local math_abs = math.abs
    local math_min = math.min
    local math_max = math.max
    local math_ceil = math.ceil
    local math_clamp = math.clamp
    local math_floor = math.floor
    local table_size = table.size
    local vector3_box = Vector3Box
    local Application = Application
    local table_clear = table.clear
    local table_remove = table.remove
    local DevParameters = DevParameters
    local quaternion_box = QuaternionBox
    local script_gui_text = ScriptGui.text
    local vector3_unbox = vector3_box.unbox
    local gui_text_extents = Gui.text_extents
    local script_gui_icrect = ScriptGui.icrect
    local RESOLUTION_LOOKUP = RESOLUTION_LOOKUP
    local quaternion_unbox = quaternion_box.unbox
    local math_point_is_inside_2d_box = math.point_is_inside_2d_box
    local application_time_since_query = Application.time_since_query
    local application_query_performance_counter = Application.query_performance_counter
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local context = {
        Inspect = "Inspect",
        Remove = "Remove",
    }
    local new_line_time = 1
--#endregion

-- ##### ┌─┐┌─┐┌┐┌┌─┐┌─┐┬  ┌─┐  ┌─┐┬  ┌─┐┌─┐┌─┐ #######################################################################
-- ##### │  │ ││││└─┐│ ││  ├┤   │  │  ├─┤└─┐└─┐ #######################################################################
-- ##### └─┘└─┘┘└┘└─┘└─┘┴─┘└─┘  └─┘┴─┘┴ ┴└─┘└─┘ #######################################################################

local Console = class("Console")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

Console.init = function(self, init_data)
    -- Values
    self.lines = {}
    self.scroll = init_data and init_data.scroll or 0
    self.max_scroll = 0
    self.row_height = init_data and init_data.row_height or 20
    self.z = init_data and init_data.z or 997
    self.visible = init_data and init_data.visible or false
    -- Lines
    if init_data and init_data.lines then for _, line in pairs(init_data.lines) do self:print(line) end end
    self.last_line = #self.lines > 0 and self.lines[#self.lines] or nil
    self.context_menu_background = init_data and init_data.context_menu_background or quaternion_box(Color(255, 0, 0, 0))
    self.context_menu = {options = {context.Inspect, context.Remove}, visible = false, position = vector3_box(vector3(0, 0, 0))}
    self.scrollbar = {cursor = vector3_box(vector3(0, 0, 0)), hover = false, active = false, scroll = 1}
    self.selection = {cursor = vector3_box(vector3(0, 0, 0)), active = false, lines = {}}
    -- Colors
    self.background = init_data and init_data.background or quaternion_box(Color(128, 0, 0, 0))
    self.hover_background = init_data and init_data.hover_background or quaternion_box(Color(200, 0, 0, 0))
    self.disabled_color = init_data and init_data.disabled_color or quaternion_box(Color(64, 255, 255, 255))
    self.color = init_data and init_data.color or quaternion_box(Color.white())
    self.highlight = init_data and init_data.highlight or quaternion_box(Color(128, 128, 128, 255))
    self.highlight_more = init_data and init_data.highlight_more or quaternion_box(Color(192, 128, 128, 255))
    self.shadow = init_data and init_data.shadow or quaternion_box(Color.gray())
    self.alternate_row = init_data and init_data.alternate_row or quaternion_box(Color(20, 255, 255, 255))
    -- Font
    self.font_size = init_data and init_data.font_size or 16
    self.font = init_data and init_data.font or DevParameters.debug_text_font
    -- Sizes
    local screen_size = self:screen_size()
    self.size = init_data and init_data.size and vector3_box(init_data.size) or vector3_box(vector3(screen_size[1], screen_size[2] / 2, 0))
    local size = vector3_unbox(self.size)
    self.title_size = init_data and init_data.title_size and vector3_box(init_data.title_size) or vector3_box(vector3(size[1], 40, 0))
    local title_size = vector3_unbox(self.title_size)
    self.RES_X, self.RES_Y = Application.back_buffer_size()
    -- Positions
    self.position = init_data and init_data.position and vector3_box(init_data.position) or vector3_box(vector3(0, 0, self.z))
    local position = vector3_unbox(self.position)
    self.frame_position = vector3_box(vector3(position[1] + 10, position[2] + title_size[2] + 10, self.z + 1))
    self.frame_size = vector3_box(size - vector3_unbox(self.title_size) - vector3(20, 20, 0))
    -- Calc
    self.title = init_data and init_data.title or "Console"
    -- self.carret = init_data and init_data.carret or {0, 0}
    self.was_pressed = false
    self.time_manager = managers.time
    self.drawing_time = 0
    self.initialized = true
    -- Print delayed messages
    self:print_delay_buffer()
end

Console.destroy = function(self)
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

Console.update = function(self, dt, t, input_service)
    -- Check visible
    if self.initialized and self.visible then
        -- Reset mouse button was already pressed this loop
        self.was_pressed = false
        -- Cache
        self.max_scroll = #self.lines - self:visible_rows()
        self._screen_size = self:screen_size()
        self._position = vector3_unbox(self.position)
        self._size = vector3_unbox(self.size)
        self._frame_size = vector3_unbox(self.frame_size)
        self._frame_position = vector3_unbox(self.frame_position)
        self._cursor = self:cursor(input_service)
        self._hover_background = quaternion_unbox(self.hover_background)
        self._background = quaternion_unbox(self.background)
        self._highlight = quaternion_unbox(self.highlight)
        self._highlight_more = quaternion_unbox(self.highlight_more)
        self._disabled_color = quaternion_unbox(self.disabled_color)
        self._color = quaternion_unbox(self.color)
        self._shadow = quaternion_unbox(self.shadow)
        self._alternate_row = quaternion_unbox(self.alternate_row)
        self._context_menu_position = vector3_unbox(self.context_menu.position)
        self._context_menu_background = quaternion_unbox(self.context_menu_background)
        self._title_size = vector3_unbox(self.title_size)
        self._gui, self._gui_retained = mod:forward_gui()
        self._scroll_axis = self:scroll_axis(input_service)
        self._pressed = self:pressed(input_service)
        self._held = self:held(input_service)
        self._shift_held = self:shift_held()
        self._ctrl_held = self:ctrl_held()
        self._context_pressed = self:context_pressed(input_service)
        -- Disable control
        self.disable_control = mod.inspector_busy or mod.watcher_busy
        -- Draw
        return self:draw(input_service)
    end
end

-- ##### ┌┬┐┬─┐┌─┐┬ ┬ #################################################################################################
-- #####  ││├┬┘├─┤│││ #################################################################################################
-- ##### ─┴┘┴└─┴ ┴└┴┘ #################################################################################################

Console.draw = function(self, input_service)
    -- Performance counter
    local handle = application_query_performance_counter()
    -- Busy
    local is_busy = false
    -- Draw
    is_busy = self:draw_frame(input_service)
    is_busy = self:draw_title_bar(input_service) or is_busy
    is_busy = self:draw_lines(input_service) or is_busy
    is_busy = self:draw_scroll(input_service) or is_busy
    is_busy = self:draw_context_menu(input_service) or is_busy
    is_busy = self:draw_selection(input_service) or is_busy
    -- Drawing time from performance counter
    self.drawing_time = application_time_since_query(handle)
    -- Return busy
    return is_busy == true and true
end

Console.draw_frame = function(self, input_service)
    -- Check if gui is available
    if self._gui then
        -- Hover
        self.hover = not self.disable_control and math_point_is_inside_2d_box(self._cursor, self._position, self._size)
        -- Color
        local color = self.hover and self._hover_background or self._background
        -- Draw frame background
        script_gui_icrect(self._gui, self.RES_X, self.RES_Y, 0, 0, self._screen_size[1], self._size[2], self.z, color)
        -- Scroll functionality
        if self:total_lines_height() > self._frame_size[2] then
            -- Scroll
            if self.hover then
                self.scroll = math_ceil(math_clamp(self.scroll - self._scroll_axis[2], 1, self.max_scroll))
                self:scrolled()
            end
        else
            -- Reset scroll
            self.scroll = 1
        end
        -- Functionality
        if self.hover and self.context_menu.visible and not self.context_menu.hover then
            -- Check if mouse button pressed and not already pressed this loop
            if not self.was_pressed and self._pressed then
                -- Close context menu
                self:close_context_menu()
            end
        elseif self.hover and not self.context_menu.visible and not self._ctrl_held and not self.selection.active then
            if not self.was_pressed and self._pressed then
                self:unselect()
            end
        elseif not self.hover and not self.context_menu.hover then
            -- Close context menu
            self:close_context_menu()
        end
        -- Return busy
        return self.hover == true and true
    end
end

Console.draw_context_menu = function(self, input_service)
    -- Check if gui is available
    if self._gui and self.context_menu.visible then
        -- Values
        local size = vector3(160, self.row_height * #self.context_menu.options + 20, 0)
        local y = 10
        -- Draw background
        script_gui_icrect(self._gui, self.RES_X, self.RES_Y, self._context_menu_position[1], self._context_menu_position[2], self._context_menu_position[1] + size[1], self._context_menu_position[2] + size[2], 1000, self._context_menu_background)
        -- Functionality
        self.context_menu.hover = false
        for _, option in pairs(self.context_menu.options) do
            -- Position
            local row_position = vector3(self._context_menu_position[1] + 10, self._context_menu_position[2] + y, self._context_menu_position[3])
            -- Size
            local row_size = vector3(size[1] - 20, self.row_height, 0)
            -- Hover
            local hover = not self.scrollbar.active and not self.disable_control and math_point_is_inside_2d_box(self._cursor, row_position, row_size)
            -- Check hover
            if hover then
                self.context_menu.hover = true
                -- Draw option background
                script_gui_icrect(self._gui, self.RES_X, self.RES_Y, row_position[1], row_position[2], row_position[1] + row_size[1], row_position[2] + row_size[2], 1000, self._highlight)
                -- Check if mouse button pressed and not already pressed this loop
                if not self.was_pressed and self._pressed then
                    -- Set was pressed in loop
                    self.was_pressed = true
                    -- Close context menu
                    self:close_context_menu()
                    -- Check option
                    if option == context.Inspect then
                        -- Inspect
                        self:inspect_selection()
                        return true
                    elseif option == context.Remove then
                        -- Remove
                        self:remove_selection()
                        return true
                    end
                end
            end
            -- Draw option text
            script_gui_text(self._gui, option, self.font, self.font_size, vector3(row_position[1] + 10, row_position[2], 1000), self._color, self._shadow)
            -- Increase y
            y = y + self.row_height
        end
        -- Return busy
        return self.context_menu.hover
    end
end

Console.draw_title_bar = function(self, input_service)
    -- Check if gui is available
    if self._gui then
        -- Draw title text
        local t_min, t_max, t_caret = gui_text_extents(self._gui, self.title, self.font, self.font_size * 1.5)
        script_gui_text(self._gui, self.title, self.font, self.font_size * 1.5,vector3(self._position[1] + 20, self._position[2] + 7, self._position[3] + 1), self._color, self._shadow)
        -- Close button
        local button_size = vector3(self._title_size[2] - 20, self._title_size[2] - 20, 0)
        local close_button_position = vector3(self._position[1] + self._title_size[1] - 10 - button_size[1], self._position[2] + 10, self._position[3] + 1)
        -- local button_size = vector3(self._title_size[2] - 20, self._title_size[2] - 20, 0)
        local close_button_hover = not self.scrollbar.active and not self.disable_control and math_point_is_inside_2d_box(self._cursor, close_button_position, button_size)
        -- Close button hover
        if close_button_hover then
            script_gui_icrect(self._gui, self.RES_X, self.RES_Y, close_button_position[1], close_button_position[2], close_button_position[1] + button_size[1], close_button_position[2] + button_size[2], self.z, self._highlight)
        end
        -- Close button draw
        local min, max, caret = gui_text_extents(self._gui, "x", self.font, self.font_size)
        script_gui_text(self._gui, "x", self.font, self.font_size * 2, close_button_position + vector3(7 - max.x / 2, -2 - max.y / 2, 0), self._color, self._shadow)
        -- Clear button
        local clear_button_position = vector3(self._position[1] + 30 + t_max.x, self._position[2] + 10, self._position[3] + 1)
        -- Clear button hover
        local clear_button_hover = not self.scrollbar.active and not self.disable_control and math_point_is_inside_2d_box(self._cursor, clear_button_position, button_size)
        if clear_button_hover then
            script_gui_icrect(self._gui, self.RES_X, self.RES_Y, clear_button_position[1], clear_button_position[2], clear_button_position[1] + button_size[1], clear_button_position[2] + button_size[2], self.z, self._highlight)
        end
        -- Clear button draw
        local min, max, caret = gui_text_extents(self._gui, "cl", self.font, self.font_size)
        script_gui_text(self._gui, "cl", self.font, self.font_size * 1.5, clear_button_position + vector3(7 - max.x / 2, 5 - max.y / 2, 0), self._color, self._shadow)
        -- Functionality
        local is_tab = self == mod.inspector
        if close_button_hover then
            -- Check pressed
            if not self.was_pressed and self._pressed then
                self.was_pressed = true
                -- Return busy
                self:show(false)
            end
            -- Return busy
            return true
        elseif clear_button_hover then
            -- Check pressed
            if not self.was_pressed and self._pressed then
                self.was_pressed = true
                -- Clear
                self:clear()
            end
            -- Return busy
            return true
        end
    end
end

Console.draw_scroll = function(self, input_service)
    -- Check if gui is available
    if self._gui then
        -- Get values
        local held = false
        local total_lines_height = self:total_lines_height()
        local scroll_bar_height = self:scrollbar_height()
        -- Color
        local scroll_bar_color = total_lines_height > self._frame_size[2] and self._color or self._disabled_color
        -- Offset
        local scroll_offset = total_lines_height > self._frame_size[2] and self.scroll * self._frame_size[2] / #self.lines or 0
        local y = self._position[2] + vector3_unbox(self.title_size)[2] + scroll_offset + 10
        local y2 = y + scroll_bar_height
        -- Hover
        self.scrollbar.hover = not self.disable_control and math_point_is_inside_2d_box(self._cursor, vector3(self._position[1] + self._size[1] - 10, y, 1), vector3(5, scroll_bar_height, 1))
        -- Check hover
        if self.scrollbar.hover then
            held = self._held
            -- Check held
            if held ~= self.scrollbar.active then
                -- Close context menu
                self:close_context_menu()
                -- Set active
                self.scrollbar.active = held
            end
        end
        -- Draw scrollbar
        if self.scrollbar.hover or self.scrollbar.active then
            script_gui_icrect(self._gui, self.RES_X, self.RES_Y, self._position[1] + self._size[1] - 10, y, self._position[1] + self._size[1] - 5, y2, 1000, self._highlight)
        else
            script_gui_icrect(self._gui, self.RES_X, self.RES_Y, self._position[1] + self._size[1] - 10, y, self._position[1] + self._size[1] - 5, y2, 1000, scroll_bar_color)
        end
        -- Check active
        if self.scrollbar.active then
            -- Get diff
            local diff = vector3_unbox(self.scrollbar.cursor) - self._cursor
            -- Set scroll
            self.scroll = math_ceil(math_clamp(self.scrollbar.scroll - (diff[2] / scroll_bar_height) * self.row_height, 1, self.max_scroll))
            self:scrolled()
            -- Check held
            if not self._held then
                -- Set inactive
                self.scrollbar.active = false
            end
        else
            -- Set cursor
            self.scrollbar.cursor = vector3_box(self._cursor)
            self.scrollbar.scroll = self.scroll
        end
        -- Return busy
        return self.scrollbar.active == true and true
    end
end

Console.draw_lines = function(self, input_service)
    -- Values
    local is_busy = false
    local line_nr = 1
    local max_line = math_min(self.scroll + self:visible_rows(), #self.lines)
    -- Iterate lines from scroll to end
    for index = self.scroll, max_line, 1 do
        -- Get line
        local line = self.lines[index]
        if line then
            -- Draw line
            is_busy = self:draw_line(line, line_nr, input_service) or is_busy
            -- Index
            line_nr = line_nr + 1
        end
    end
    -- Return busy
    return is_busy == true and true
end

Console.draw_line = function(self, line, line_nr, input_service)
    -- Check if gui is available
    if self._gui then
        -- Position
        local position = self._frame_position + vector3(0, self.row_height * (line_nr - 1), 1)
        if position[2] + self.row_height > self._size[2] then return false end
        -- Count
        local count = line.count and "("..tostring(line.count)..") " or ""
        -- Hover
        line.hover = not self.scrollbar.active and not self.disable_control and math_point_is_inside_2d_box(self._cursor, position, vector3(self._screen_size[1] - 20, self.row_height, 0))
        -- Check hover
        local color = nil
        if (line.hover and not self.context_menu.visible) or self.selection.lines[line] then
            -- Highlight
            color = line.hover and (self._pressed or self._held) and self._highlight_more or self._highlight
            -- script_gui_icrect(self._gui, self.RES_X, self.RES_Y, position[1], position[2], self._screen_size[1] - 20, position[2] + self.row_height, self.z, color)
        elseif (line_nr % 2 == 0) then
            color = self._alternate_row
            -- script_gui_icrect(self._gui, self.RES_X, self.RES_Y, position[1], position[2], self._screen_size[1] - 20, position[2] + self.row_height, self.z, self._alternate_row)
        end
        local end_time = line.t + new_line_time
        if end_time > mod:main_time() then
            color = color or self._background
            -- local ende = line.t + new_line_time
            local p = (end_time - mod:main_time()) / new_line_time
            -- -- mod:echot("p: "..tostring(p))
            -- color = Quaternion.lerp(self._highlight, color, p)
            color[1] = math.lerp(color[1], self._highlight[1], p)
            color[2] = math.lerp(color[2], self._highlight[2], p)
            color[3] = math.lerp(color[3], self._highlight[3], p)
            -- color[0] = math.lerp(color[0], self._highlight[0], p)
            -- color[4] = math_clamp(color[4] * (1 - (line.t + new_line_time - mod:main_time()) / new_line_time)
        end
        if color then
            script_gui_icrect(self._gui, self.RES_X, self.RES_Y, position[1], position[2], self._screen_size[1] - 20, position[2] + self.row_height, self.z, color)
        end
        -- Draw
        script_gui_text(self._gui, line.mod..tostring(count)..line.text, DevParameters.debug_text_font, 16, position + vector3(10, 0, 0), self._color, self._shadow)
        -- Functionality
        if line.hover and not self.context_menu.visible then
            -- Inspect table on left click
            if not self.was_pressed and self._pressed then
                self.was_pressed = true
                if not self._ctrl_held then
                    self:unselect()
                    if line.is_table then
                        mod:inspect(line.text, line.obj)
                    end
                end
                self:select(line)
            end
            -- Open context menu on right click
            if self._context_pressed then
                if table_size(self.selection.lines) == 1 then self:unselect() end
                self:select(line)
                self:open_context_menu(line, self._cursor)
            end
            -- Return busy
            return true
        end
    end
end

Console.draw_selection = function(self, input_service)
    if self.selection.active then
        local position = vector3_unbox(self.selection.cursor)
        local size = vector3(self._cursor[1] - position[1], self._cursor[2] - position[2], 0)
        -- mod:echo("pos: "..tostring(position).." cursor: "..tostring(self._cursor).." size: "..tostring(size))
        script_gui_icrect(self._gui, self.RES_X, self.RES_Y, position[1], position[2], self._cursor[1], self._cursor[2], 1000, self._highlight)

        local max_line = math_min(self.scroll + self:visible_rows(), #self.lines)
        -- Iterate lines from scroll to end
        local line_nr = 1
        for index = self.scroll, max_line, 1 do
            -- Get line
            local line = self.lines[index]
            local line_position = self._frame_position + vector3(0, self.row_height * (line_nr - 1), 1)
            local line_bottom = self._frame_position + vector3(0, self.row_height * line_nr, 1)
            local position_satisfied = (position[2] > line_position[2] and self._cursor[2] < line_position[2])
                or (position[2] < line_position[2] and self._cursor[2] > line_position[2])
                or (position[2] > line_bottom[2] and self._cursor[2] < line_bottom[2])
                or (position[2] < line_bottom[2] and self._cursor[2] > line_bottom[2])
            -- Select
            if math_abs(size[1]) > 2 and math_abs(size[2]) > 2 then
                if self._ctrl_held then
                    self.selection.lines[line] = (position_satisfied or line.hover) and true or self.selection.lines[line]
                else
                    self.selection.lines[line] = (position_satisfied or line.hover) and true or nil
                end
            end
            -- Index
            line_nr = line_nr + 1
        end

        -- Cancel
        if not self.hover or not self._held then
            self.selection.active = false
            return false
        end
        return true
    elseif self.hover and self._held and not self.was_pressed and not self.scrollbar.active then
        self.selection.cursor = vector3_box(self._cursor)
        self.selection.active = true
        return true
    end
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

Console.changed = function(self) end
Console.cleared = function(self) end
Console.shown = function(self) end
Console.hidden = function(self) end
Console.context_shown = function(self) end
Console.context_hidden = function(self) end
Console.scrolled = function(self) end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

Console.line_nr = function(self, line)
    for i = 1, #self.lines, 1 do
        if self.lines[i] == line then
            return i
        end
    end
end

Console.screen_size = function(self)
    return vector3(RESOLUTION_LOOKUP.width, RESOLUTION_LOOKUP.height, 0)
end

Console.visible_rows = function(self)
    local frame_size = vector3_unbox(self.frame_size) - vector3(20, 20, 0)
    return math_floor(frame_size[2] / self.row_height)
end

Console.scrollbar_height = function(self)
    local frame_size = vector3_unbox(self.frame_size) - vector3(20, 20, 0)
    return frame_size[2] * math_clamp(frame_size[2] / self:total_lines_height(), 0, 1)
end

Console.total_lines_height = function(self)
    return self.row_height * #self.lines
end

Console.cursor = function(self, input_service)
	return input_service and input_service:get("cursor") or vector3(0, 0, 0)
end

Console.held = function(self, input_service)
    return input_service and input_service:get("left_hold") or false
end

Console.pressed = function(self, input_service)
	return input_service and input_service:get("left_pressed") or false
end

Console.context_pressed = function(self, input_service)
    return input_service and input_service:get("right_pressed") or false
end

Console.scroll_axis = function(self, input_service)
    return input_service and input_service:get("scroll_axis") or vector3(0, 0, 0)
end

Console.shift_held = function(self)
    return mod:is_shift_held()
end

Console.ctrl_held = function(self)
    return mod:is_ctrl_held()
end

-- ##### ┬┌┐┌┌┬┐┌─┐┬─┐┌┐┌┌─┐┬    ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ################################################################
-- ##### ││││ │ ├┤ ├┬┘│││├─┤│    │││├┤  │ ├─┤│ │ ││└─┐ ################################################################
-- ##### ┴┘└┘ ┴ └─┘┴└─┘└┘┴ ┴┴─┘  ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ################################################################

Console.select = function(self, lines)
    if lines.text and lines.obj then
        if self._ctrl_held and self.selection.lines[lines] then
            self.selection.lines[lines] = nil
        else
            self.selection.lines[lines] = true
        end
    else
        for _, line in pairs(lines) do
            if self._ctrl_held and self.selection.lines[lines] then
                self.selection.lines[lines] = nil
            else
                self.selection.lines[lines] = true
            end
        end
    end
end

Console.unselect = function(self)
    self.selection.active = false
    table_clear(self.selection.lines)
end

Console.inspect_selection = function(self)
    for line, _ in pairs(self.selection.lines) do
        if line.is_table then
            self:inspect_table(line.text, line.obj)
        end
    end
end

Console.inspect_table = function(self, key, table)
    mod:inspect(key, table)
end

Console.open_context_menu = function(self, line, position)
    self.context_menu.line = line
    self.context_menu.position:store(position[1], position[2], position[3])
    self._context_menu_position = position
    self.context_menu.visible = true
    self:context_shown()
end

Console.close_context_menu = function(self)
    self.context_menu.visible = false
    self.context_menu.hover = false
    self:context_hidden()
end

Console.delay_buffer = function(self)
    return mod:persistent_table("modding_tools").console.delay_buffer
end

Console.clear_delay_buffer = function(self)
    table_clear(mod:persistent_table("modding_tools").console.delay_buffer)
end

Console.print_delay_buffer = function(self)
    local delay_buffer = self:delay_buffer()
    if delay_buffer then
        for _, delayed_print in pairs(delay_buffer) do
            self:print(delayed_print)
        end
    end
end

Console.print_line = function(self, line) 
    local line_text = mod.executing_mod and mod.executing_mod.get_name and mod.executing_mod:get_name().."> "..tostring(line) or tostring(line)
    if self.last_line and line_text == self.last_line.text and #self.lines > 0 and self.lines[#self.lines] and self.lines[#self.lines].count then
        local count = self.lines[#self.lines].count or 1
        self.lines[#self.lines].count = count + 1
        self:changed()
    else
        self.lines[#self.lines + 1] = {
            text = line_text,
            is_table = type(line) == "table",
            obj = line,
            t = mod:main_time(),
            mod = self.executing_mod and self.executing_mod.get_name and self.executing_mod:get_name() or mod:get_name(),
        }
        if not self.visible or self.scroll == self.max_scroll then
            self.scroll = math_clamp(#self.lines - self:visible_rows(), 0, #self.lines)
            self:scrolled()
        end
        self.last_line = self.lines[#self.lines]
        self:changed()
    end
end

Console.remove_selection = function(self)
    for line, _ in pairs(self.selection.lines) do
        self.selection.lines[line] = nil
        self:remove(line)
    end
end

Console.remove = function(self, line)
    for i, other_line in pairs(self.lines) do
        if other_line == line then
            table_remove(self.lines, i)
            self:changed()
            break
        end
    end
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

Console.toggle = function(self)
    self:show(not self.visible)
end

Console.show = function(self, show)
    self.visible = show
    if show then self:shown() end
    if not show then self:hidden() end
    mod:push_or_pop_cursor(self, "modding_tools_console")
end

-- Console.set_mod = function(self, mod)
--     self.mod = mod
-- end

Console.clear = function(self)
    table_clear(self.lines)
    self.last_line = nil
    self.scroll = 0
    self:scrolled()
    self:cleared()
end

Console.print = function(self, ...)
    local arg = {...}
    if #arg > 0 then
        for _, a in pairs(arg) do
            self:print_line(a)
        end
    end
end

return Console