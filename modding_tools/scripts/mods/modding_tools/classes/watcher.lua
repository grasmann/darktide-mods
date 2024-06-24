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
    local string = string
    local vector3 = Vector3
    local managers = Managers
    local tostring = tostring
    local string_sub = string.sub
    local vector3_box = Vector3Box
    local Application = Application
    local table_clear = table.clear
    local DevParameters = DevParameters
    local quaternion_box = QuaternionBox
    local vector3_unbox = vector3_box.unbox
    local RESOLUTION_LOOKUP = RESOLUTION_LOOKUP
    local quaternion_unbox = quaternion_box.unbox
--#endregion

-- ##### ┌─┐┌─┐┌┐┌┌─┐┌─┐┬  ┌─┐  ┌─┐┬  ┌─┐┌─┐┌─┐ #######################################################################
-- ##### │  │ ││││└─┐│ ││  ├┤   │  │  ├─┤└─┐└─┐ #######################################################################
-- ##### └─┘└─┘┘└┘└─┘└─┘┴─┘└─┘  └─┘┴─┘┴ ┴└─┘└─┘ #######################################################################

local Watcher = class("Watcher")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

Watcher.init = function(self, init_data)
    -- Values
    self.line_sizes = {}
    self.longest_key = 0
    self.longest_type = 0
    self.longest_value = 0
    self.available_value = 0
    self.lines = {}
    self.scroll = init_data and init_data.scroll or 1
    self.row_height = init_data and init_data.row_height or 20
    self.z = init_data and init_data.z or 990
    self.visible = init_data and init_data.visible or false
    self.context_menu_background = init_data and init_data.context_menu_background or quaternion_box(Color(255, 0, 0, 0))
    self.context_menu = {
        options = {
            "Remove"
        },
        visible = false,
    }
    -- Lines
    if init_data and init_data.lines then
        for _, line in pairs(init_data.lines) do
            self:print(line)
        end
    end
    self.last_line = #self.lines > 0 and self.lines[#self.lines] or nil
    -- Colors
    self.background = init_data and init_data.background or quaternion_box(Color(128, 0, 0, 0))
    self.hover_background = init_data and init_data.hover_background or quaternion_box(Color(200, 0, 0, 0))
    self.disabled_color = init_data and init_data.disabled_color or quaternion_box(Color(64, 255, 255, 255))
    self.color = init_data and init_data.color or quaternion_box(Color.white())
    self.lowlight = init_data and init_data.lowlight or quaternion_box(Color(128, 255, 255, 255))
    self.highlight = init_data and init_data.highlight or quaternion_box(Color(128, 128, 128, 255))
    self.shadow = init_data and init_data.shadow or quaternion_box(Color.gray())
    -- Font
    self.font_size = init_data and init_data.font_size or 16
    self.font = init_data and init_data.font or DevParameters.debug_text_font
    -- Sizes
    local screen_size = self:screen_size()
    self.size = init_data and init_data.size and vector3_box(init_data.size) or vector3_box(vector3(screen_size[1] / 2, screen_size[2] / 2, 0))
    local size = vector3_unbox(self.size)
    self.title_size = init_data and init_data.title_size and vector3_box(init_data.title_size) or vector3_box(vector3(size[1], 40, 0))
    local title_size = vector3_unbox(self.title_size)
    self.RES_X, self.RES_Y = Application.back_buffer_size()
    -- Positions
    self.position = init_data and init_data.position and vector3_box(init_data.position) or vector3_box(vector3(0, screen_size[2] / 2, self.z))
    local position = vector3_unbox(self.position)
    self.frame_position = vector3_box(vector3(position[1], position[2] + title_size[2], self.z + 1))
    self.frame_position_inner = vector3_box(vector3_unbox(self.frame_position) + vector3(10, 10, 0))
    self.frame_size = vector3_box(vector3(size[1], size[2] - title_size[2], self.z + 1))
    self.frame_size_inner = vector3_box(vector3_unbox(self.frame_size) - vector3(30, 20, 0))
    -- Calc
    self.title = init_data and init_data.title or "Watcher"
    -- self.carret = init_data and init_data.carret or {0, 0}
    self.initialized = true
end

Watcher.destroy = function(self)
    self.initialized = false
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

Watcher.update = function(self, dt, t, input_service)
    if self.initialized and self.visible then
        return self:draw(input_service)
    end
end

Watcher.draw = function(self, input_service)
    local is_busy = false
    is_busy = self:draw_frame(input_service)
    is_busy = self:draw_title_bar(input_service) or is_busy
    is_busy = self:draw_scroll(input_service) or is_busy
    self:get_line_sizes()
    is_busy = self:draw_lines(input_service) or is_busy
    is_busy = self:draw_context_menu(input_service) or is_busy
    return is_busy == true and true
end

Watcher.draw_title_bar = function(self, input_service)
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

Watcher.draw_context_menu = function(self, input_service)
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
                    self:remove(self.context_menu.line.key)
                    self.context_menu.visible = false
                    self.context_menu.hover = false
                    return true
                end
            end

            ScriptGui.text(gui, option, self.font, self.font_size, vector3(row_position[1], row_position[2], self.z + 3), color, shadow)

            y = y + self.row_height
        end

        return self.context_menu.hover
    end
end

Watcher.draw_scroll = function(self, input_service)
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

Watcher.draw_frame = function(self, input_service)
    -- Get gui
    local gui, gui_retained = mod:forward_gui()
    -- Check if gui is available
    if gui then
        -- Get values
        local screen_size = self:screen_size()
        local cursor = self:cursor(input_service)
        local size = vector3_unbox(self.size)
        local frame_size = vector3_unbox(self.frame_size)
        local position = vector3_unbox(self.position)
        -- Hover
        self.hover = math.point_is_inside_2d_box(cursor, position, size)
        -- Color
        local color = self.hover and quaternion_unbox(self.hover_background) or quaternion_unbox(self.background)
        -- Draw
        ScriptGui.icrect(gui, self.RES_X, self.RES_Y, position[1], position[2], position[1] + size[1], position[2] + size[2], self.z, color)
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

Watcher.draw_lines = function(self, input_service)
    -- Get gui
    local gui, gui_retained = mod:forward_gui()
    -- Check if gui is available
    if gui then
        local is_busy = false
        -- Values
        local position = vector3_unbox(self.position)
        local frame_position = vector3_unbox(self.frame_position_inner)
        local frame_size = vector3_unbox(self.frame_size_inner)
        local cursor = self:cursor(input_service)
        local y = 0
        -- Iterate lines
        for index = self.scroll, #self.lines, 1 do
            local line = self.lines[index]
            if line then

                if y + self.row_height > frame_size[2] then break end
                
                local row_position = vector3(frame_position[1], frame_position[2] + y, frame_position[3])
                local row_size = vector3(frame_size[1], self.row_height, 0)
                local hover = math.point_is_inside_2d_box(cursor, row_position, row_size)

                if hover and not self.context_menu.hover then
                    ScriptGui.icrect(gui, self.RES_X, self.RES_Y, row_position[1], row_position[2], row_position[1] + row_size[1], row_position[2] + row_size[2], self.z, quaternion_unbox(self.highlight))
                    if self:pressed(input_service) then
                        if line.is_table and line.obj and type(line.obj) == "table" then
                            self:navigate(line.key, line.obj)
                        end
                    end
                    if self:context_pressed(input_service) then
                        self.context_menu.visible = true
                        self.context_menu.line = line
                        self.context_menu.position = vector3_box(row_position[1], row_position[2] + 20, row_position[3] + 1)
                    end
                    is_busy = true
                end

                local color = line.is_table and quaternion_unbox(self.color) or quaternion_unbox(self.lowlight)
                local shadow = quaternion_unbox(self.shadow)

                -- Row 1 - Key
                ScriptGui.text(gui, line.key, self.font, self.font_size, vector3(frame_position[1] + 10, frame_position[2] + y, frame_position[3] + 1), color, shadow)

                -- Row 2 - Type
                ScriptGui.text(gui, type(line.table[line.obj_key]), self.font, self.font_size, vector3(frame_position[1] + 10 + self.longest_key + 10, frame_position[2] + y, frame_position[3] + 1), color, shadow)

                -- Row 3 - Value
                local value = tostring(line.table[line.obj_key])
                local min, max, caret = Gui.text_extents(gui, value, self.font, self.font_size)
                if max.x > self.available_value then
                    value = "..."..string_sub(value, string.len(value) - 20, string.len(value))
                    min, max, caret = Gui.text_extents(gui, value, self.font, self.font_size)
                end
                ScriptGui.text(gui, value, self.font, self.font_size, vector3(frame_position[1] + row_size[1] - 10 - max.x, frame_position[2] + y, frame_position[3] + 1), color, shadow)

                y = y + self.row_height
            end
        end
        -- Return busy
        return is_busy == true and true
    end
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

Watcher.get_line_sizes = function(self)
    local gui, gui_retained = mod:forward_gui()
    if gui then
        self.longest_key = 0
        self.longest_type = 0
        self.longest_value = 0
        table_clear(self.line_sizes)
        for index, line in pairs(self.lines) do
            local k_min, k_max, k_caret = Gui.text_extents(gui, tostring(line.key), self.font, self.font_size)
            local t_min, t_max, t_caret = Gui.text_extents(gui, type(line.table[line.obj_key]), self.font, self.font_size)
            local v_min, v_max, v_caret = Gui.text_extents(gui, tostring(line.table[line.obj_key]), self.font, self.font_size)
            if k_max.x > self.longest_key then self.longest_key = k_max.x end
            if t_max.x > self.longest_type then self.longest_type = t_max.x end
            if v_max.x > self.longest_value then self.longest_value = v_max.x end
            self.line_sizes[index] = {
                key = {min = k_min, max = k_max, caret = k_caret},
                type = {min = t_min, max = t_max, caret = t_caret},
                value = {min = v_min, max = v_max, caret = v_caret},
            }
        end
        local frame_size = vector3_unbox(self.frame_size_inner)
        self.available_value = frame_size[1] - self.longest_key - self.longest_type
    end
end

Watcher.screen_size = function(self)
    return vector3(RESOLUTION_LOOKUP.width, RESOLUTION_LOOKUP.height, 0)
end

Watcher.scrollbar_height = function(self)
    local frame_size = vector3_unbox(self.frame_size) - vector3(20, 20, 0)
    return frame_size[2] * math.clamp(frame_size[2] / self:total_lines_height(), 0, 1)
end

Watcher.total_lines_height = function(self)
    return self.row_height * #self.lines
end

Watcher.cursor = function(self, input_service)
	return input_service and input_service:get("cursor") or vector3(0, 0, 0)
end

Watcher.pressed = function(self, input_service)
	return input_service and input_service:get("left_pressed") or false
end

Watcher.context_pressed = function(self, input_service)
    return input_service and input_service:get("right_pressed") or false
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

Watcher.remove = function(self, key)
    for index, line in pairs(self.lines) do
        if line.key == key then
            self.lines[index] = nil
        end
    end
    self.last_line = #self.lines > 0 and self.lines[#self.lines]
end

Watcher.watch = function(self, key, table, obj_key)
    -- mod:echo("watch", key, table, obj_key)
    local line_key = self.mod and self.mod.get_name and self.mod:get_name().."> "..tostring(key) or tostring(key)
    if self.last_line and line_key == self.last_line.key then
        local count = self.lines[#self.lines].count or 1
        self.lines[#self.lines].count = count + 1
    else
        self.lines[#self.lines + 1] = {
            table = table,
            key = line_key,
            obj_key = obj_key,
            is_table = type(table[obj_key]) == "table",
        }
        self.last_line = self.lines[#self.lines]
    end
end

Watcher.toggle = function(self)
    self.visible = not self.visible
    mod:push_or_pop_cursor(self, "modding_tools_watcher")
end

Watcher.show = function(self, show)
    self.visible = show
    mod:push_or_pop_cursor(self, "modding_tools_watcher")
end

Watcher.set_mod = function(self, mod)
    self.mod = mod
end

Watcher.clear = function(self)
    self.lines = {}
    self.last_line = nil
end

return Watcher