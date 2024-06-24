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
    local CLASS = CLASS
    local vector3 = Vector3
    local managers = Managers
    local tostring = tostring
    local vector3_box = Vector3Box
    local Application = Application
    local DevParameters = DevParameters
    local quaternion_box = QuaternionBox
    local vector3_unbox = vector3_box.unbox
    local RESOLUTION_LOOKUP = RESOLUTION_LOOKUP
    local quaternion_unbox = quaternion_box.unbox
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
    self.scroll = init_data and init_data.scroll or 1
    self.row_height = init_data and init_data.row_height or 20
    self.z = init_data and init_data.z or 990
    self.visible = init_data and init_data.visible or false
    -- Lines
    if init_data and init_data.lines then
        for _, line in pairs(init_data.lines) do
            self:print(line)
        end
    end
    self.last_line = #self.lines > 0 and self.lines[#self.lines] or nil
    self.context_menu_background = init_data and init_data.context_menu_background or quaternion_box(Color(255, 0, 0, 0))
    self.context_menu = {
        options = {
            "Open in inspector"
        },
        visible = false,
    }
    -- Colors
    self.background = init_data and init_data.background or quaternion_box(Color(128, 0, 0, 0))
    self.hover_background = init_data and init_data.hover_background or quaternion_box(Color(200, 0, 0, 0))
    self.disabled_color = init_data and init_data.disabled_color or quaternion_box(Color(64, 255, 255, 255))
    self.color = init_data and init_data.color or quaternion_box(Color.white())
    self.highlight = init_data and init_data.highlight or quaternion_box(Color(128, 128, 128, 255))
    self.shadow = init_data and init_data.shadow or quaternion_box(Color.gray())
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
    self.initialized = true
end

Console.destroy = function(self)
    self.initialized = false
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

Console.update = function(self, dt, t, input_service)
    if self.initialized and self.visible then
        return self:draw(input_service)
    end
end

Console.draw = function(self, input_service)
    local is_busy = false
    is_busy = self:draw_frame(input_service)
    is_busy = self:draw_title_bar(input_service) or is_busy
    is_busy = self:draw_lines(input_service) or is_busy
    is_busy = self:draw_scroll(input_service) or is_busy
    is_busy = self:draw_context_menu(input_service) or is_busy
    return is_busy == true and true
end

Console.draw_context_menu = function(self, input_service)
    -- Get gui
    local gui, gui_retained = mod:forward_gui()
    -- Check if gui is available
    if gui and self.context_menu.visible then
        
        -- Values
        local position = vector3_unbox(self.context_menu.position)
        local size = vector3(160, 40, 0)
        local cursor = self:cursor(input_service)
        local color = quaternion_unbox(self.color)
        local shadow = quaternion_unbox(self.shadow)
        local background = quaternion_unbox(self.context_menu_background)
        ScriptGui.icrect(gui, self.RES_X, self.RES_Y, position[1], position[2], position[1] + size[1], position[2] + size[2], self.z + 2, background)

        local y = 10

        for _, option in pairs(self.context_menu.options) do

            local row_position = vector3(position[1] + 10, position[2] + y, position[3])
            local row_size = vector3(size[1] - 20, self.row_height, 0)

            self.context_menu.hover = math.point_is_inside_2d_box(cursor, row_position, row_size)

            if self.context_menu.hover then
                ScriptGui.icrect(gui, self.RES_X, self.RES_Y, row_position[1], row_position[2], row_position[1] + row_size[1], row_position[2] + row_size[2], self.z + 2, quaternion_unbox(self.highlight))
                if self:pressed(input_service) then
                    mod:inspect(self.context_menu.line.text, self.context_menu.line.obj)
                    self.context_menu.visible = false
                    self.context_menu.hover = false
                    return true
                end
            end

            ScriptGui.text(gui, option, self.font, self.font_size, vector3(row_position[1] + 10, row_position[2], self.z + 3), color, shadow)

            y = y + self.row_height
        end

        return self.context_menu.hover
    end
end

Console.draw_title_bar = function(self, input_service)
    -- Get gui
    local gui, gui_retained = mod:forward_gui()
    -- Check if gui is available
    if gui then
        -- Get values
        local title_size = vector3_unbox(self.title_size)
        local position = vector3_unbox(self.position)
        local color = quaternion_unbox(self.color)
        local shadow = quaternion_unbox(self.shadow)
        local cursor = self:cursor(input_service)
        -- Draw title text
        local t_min, t_max, t_caret = Gui.text_extents(gui, self.title, self.font, self.font_size * 1.5)
        ScriptGui.text(gui, self.title, self.font, self.font_size * 1.5, vector3(position[1] + 20, position[2] + 7, position[3] + 1), color, shadow)
        -- Close button
        local button_size = vector3(title_size[2] - 20, title_size[2] - 20, 0)
        local close_button_position = vector3(position[1] + title_size[1] - 10 - button_size[1], position[2] + 10, position[3] + 1)
        -- local button_size = vector3(title_size[2] - 20, title_size[2] - 20, 0)
        local close_button_hover = math.point_is_inside_2d_box(cursor, close_button_position, button_size)
        -- Close button hover
        if close_button_hover then
            ScriptGui.icrect(gui, self.RES_X, self.RES_Y, close_button_position[1], close_button_position[2], close_button_position[1] + button_size[1],
                close_button_position[2] + button_size[2], self.z, quaternion_unbox(self.highlight))
        end
        -- Close button draw
        local min, max, caret = Gui.text_extents(gui, "x", self.font, self.font_size)
        ScriptGui.text(gui, "x", self.font, self.font_size * 2, close_button_position + vector3(7 - max.x / 2, -2 - max.y / 2, 0), quaternion_unbox(self.color), shadow)
        -- Clear button
        local clear_button_position = vector3(position[1] + 30 + t_max.x, position[2] + 10, position[3] + 1)
        -- Clear button hover
        local clear_button_hover = math.point_is_inside_2d_box(cursor, clear_button_position, button_size)
        if clear_button_hover then
            ScriptGui.icrect(gui, self.RES_X, self.RES_Y, clear_button_position[1], clear_button_position[2], clear_button_position[1] + button_size[1],
                clear_button_position[2] + button_size[2], self.z, quaternion_unbox(self.highlight))
        end
        -- Clear button draw
        local min, max, caret = Gui.text_extents(gui, "cl", self.font, self.font_size)
        ScriptGui.text(gui, "cl", self.font, self.font_size * 1.5, clear_button_position + vector3(7 - max.x / 2, 5 - max.y / 2, 0), quaternion_unbox(self.color), shadow)
        -- Functionality
        if close_button_hover then
            -- Check pressed
            if self:pressed(input_service) then
                -- Return busy
                self:show(false)
            end
            -- Return busy
            return true
        elseif clear_button_hover then
            -- Check pressed
            if self:pressed(input_service) then
                -- Clear
                self:clear()
            end
            -- Return busy
            return true
        end
    end
end

Console.draw_scroll = function(self, input_service)
    -- Get gui
    local gui, gui_retained = mod:forward_gui()
    -- Check if gui is available
    if gui then
        -- Get values
        local position = vector3_unbox(self.position)
        local size = vector3_unbox(self.size)
        local frame_size = vector3_unbox(self.frame_size)
        local total_lines_height = self:total_lines_height()
        local scroll_bar_height = self:scrollbar_height()
        -- Color
        local scroll_bar_color = total_lines_height > frame_size[2] and quaternion_unbox(self.color) or quaternion_unbox(self.disabled_color)
        -- Offset
        local scroll_offset = total_lines_height > frame_size[2] and self.scroll * frame_size[2] / #self.lines or 0
        local y = position[2] + vector3_unbox(self.title_size)[2] + scroll_offset + 10
        local y2 = y + scroll_bar_height
        -- Draw
        ScriptGui.icrect(gui, self.RES_X, self.RES_Y, position[1] + size[1] - 10, y, position[1] + size[1] - 5, y2, self.z, scroll_bar_color)
    end
end

Console.draw_frame = function(self, input_service)
    -- Get gui
    local gui, gui_retained = mod:forward_gui()
    -- Check if gui is available
    if gui then
        -- Get values
        local screen_size = self:screen_size()
        local cursor = self:cursor(input_service)
        local size = vector3_unbox(self.size)
        local frame_size = vector3_unbox(self.frame_size)
        -- Hover
        self.hover = math.point_is_inside_2d_box(cursor, vector3(0, 0, 0), vector3(screen_size[1], size[2], 0))
        -- Color
        local color = self.hover and quaternion_unbox(self.hover_background) or quaternion_unbox(self.background)
        -- Draw
        ScriptGui.icrect(gui, self.RES_X, self.RES_Y, 0, 0, screen_size[1], size[2], self.z, color)
        -- Functionality
        if self.hover and self:total_lines_height() > frame_size[2] then
            -- Scroll
            local scroll_axis = input_service:get("scroll_axis")
            local max_scroll = math.ceil(#self.lines - frame_size[2] / 20) + 1
            if scroll_axis then
                self.scroll = math.clamp(math.ceil(math.clamp(self.scroll - scroll_axis[2], 1, #self.lines * 20)), 1, max_scroll)
            end
        end
        if self.hover and not self.context_menu.hover then
            if self:pressed(input_service) or self:context_pressed(input_service) then
                self.context_menu.visible = false
                self.context_menu.hover = false
            end
        elseif not self.hover and not self.context_menu.hover then
            self.context_menu.visible = false
            self.context_menu.hover = false
        end
        -- Return busy
        return self.hover == true and true
    end
end

Console.draw_lines = function(self, input_service)
    local is_busy = false
    local line_nr = 1
    -- Iterate lines from scroll to end
    for index = self.scroll, #self.lines, 1 do
        -- Get line
        local line = self.lines[index]
        -- Draw line
        is_busy = self:draw_line(line, line_nr, input_service) or is_busy
        -- Index
        line_nr = line_nr + 1
    end
    -- Return busy
    return is_busy == true and true
end

Console.draw_line = function(self, line, line_nr, input_service)
    -- Get gui
    local gui = mod:forward_gui()
    -- Check if gui is available
    if gui then
        -- Get values
        local screen_size = self:screen_size()
        local cursor = self:cursor(input_service)
        local size = vector3_unbox(self.size)
        local frame_position = vector3_unbox(self.frame_position)
        -- Position
        local position = frame_position + vector3(0, self.row_height * (line_nr - 1), 1)
        if position[2] + self.row_height > size[2] then return false end
        local count = line.count and "("..tostring(line.count)..") " or ""
        -- Hover
        line.hover = math.point_is_inside_2d_box(cursor, position, vector3(screen_size[1] - 20, self.row_height, 0))
        if line.hover and not self.context_menu.hover then
            -- Highlight
            ScriptGui.icrect(gui, self.RES_X, self.RES_Y, position[1], position[2], screen_size[1] - 20, position[2] + self.row_height, self.z, quaternion_unbox(self.highlight))
        end
        -- Draw
        ScriptGui.text(gui, count..line.text, DevParameters.debug_text_font, 16, position + vector3(10, 0, 0), quaternion_unbox(self.color), quaternion_unbox(self.shadow))
        -- Functionality
        if line.hover and not self.context_menu.hover then
            if self:pressed(input_service) then
                if line.is_table then
                    mod:inspect(line.text, line.obj, gui)
                end
            end
            if self:context_pressed(input_service) then
                self.context_menu.visible = true
                self.context_menu.line = line
                self.context_menu.position = vector3_box(position[1], position[2] + 20, position[3] + 1)
            end
            -- Return busy
            return true
        end
    end
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

Console.screen_size = function(self)
    return vector3(RESOLUTION_LOOKUP.width, RESOLUTION_LOOKUP.height, 0)
end

Console.visible_rows = function(self)
    local frame_size = vector3_unbox(self.frame_size) - vector3(20, 20, 0)
    return math.floor(frame_size[2] / self.row_height)
end

Console.scrollbar_height = function(self)
    local frame_size = vector3_unbox(self.frame_size) - vector3(20, 20, 0)
    return frame_size[2] * math.clamp(frame_size[2] / self:total_lines_height(), 0, 1)
end

Console.total_lines_height = function(self)
    return self.row_height * #self.lines
end

Console.cursor = function(self, input_service)
	return input_service and input_service:get("cursor") or vector3(0, 0, 0)
end

Console.pressed = function(self, input_service)
	return input_service and input_service:get("left_pressed") or false
end

Console.context_pressed = function(self, input_service)
    return input_service and input_service:get("right_pressed") or false
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

Console.toggle = function(self)
    self.visible = not self.visible
    mod:push_or_pop_cursor(self, "modding_tools_console")
end

Console.show = function(self, show)
    self.visible = show
    mod:push_or_pop_cursor(self, "modding_tools_console")
end

Console.set_mod = function(self, mod)
    self.mod = mod
end

Console.clear = function(self)
    self.lines = {}
    self.last_line = nil
    self.scroll = 1
end

Console.print = function(self, ...)
    local arg = {...}
    if #arg > 0 then
        for _, a in pairs(arg) do
            self:print_line(a)
        end
    end
end

Console.print_line = function(self, line)
    local line_text = self.mod and self.mod.get_name and self.mod:get_name().."> "..tostring(line) or tostring(line)
    if self.last_line and line_text == self.last_line.text then
        local count = self.lines[#self.lines].count or 1
        self.lines[#self.lines].count = count + 1
    else
        self.lines[#self.lines + 1] = {
            text = line_text,
            is_table = type(line) == "table",
            obj = line,
        }
        self.scroll = math.clamp(#self.lines - self:visible_rows(), 1, #self.lines)
        self.last_line = self.lines[#self.lines]
    end
end

return Console