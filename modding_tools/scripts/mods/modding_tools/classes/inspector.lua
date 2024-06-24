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
    local string_sub = string.sub
    local vector3_box = Vector3Box
    local table_clear = table.clear
    local Application = Application
    local DevParameters = DevParameters
    local quaternion_box = QuaternionBox
    local vector3_unbox = vector3_box.unbox
    local RESOLUTION_LOOKUP = RESOLUTION_LOOKUP
    local quaternion_unbox = quaternion_box.unbox
--#endregion

-- ##### ┬┌┐┌┌─┐┌─┐┌─┐┌─┐┌┬┐┌─┐┬─┐  ┌─┐┬  ┌─┐┌─┐┌─┐ ###################################################################
-- ##### ││││└─┐├─┘├┤ │   │ │ │├┬┘  │  │  ├─┤└─┐└─┐ ###################################################################
-- ##### ┴┘└┘└─┘┴  └─┘└─┘ ┴ └─┘┴└─  └─┘┴─┘┴ ┴└─┘└─┘ ###################################################################

local Inspector = class("Inspector")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

Inspector.init = function(self, init_data)
    -- Colors
    self.background = init_data and init_data.background or quaternion_box(Color(128, 0, 0, 0))
    self.context_menu_background = init_data and init_data.context_menu_background or quaternion_box(Color(255, 0, 0, 0))
    self.context_menu = {
        options = {
            "Watch"
        },
        visible = false,
    }
    self.hover_background = init_data and init_data.hover_background or quaternion_box(Color(200, 0, 0, 0))
    self.highlight = init_data and init_data.highlight or quaternion_box(Color(128, 128, 128, 255))
    self.color = init_data and init_data.color or quaternion_box(Color.white())
    self.lowlight = init_data and init_data.lowlight or quaternion_box(Color(128, 255, 255, 255))
    self.disabled_color = init_data and init_data.disabled_color or quaternion_box(Color(64, 255, 255, 255))
    self.shadow = init_data and init_data.shadow or quaternion_box(Color.gray())
    -- Values
    self.z = init_data and init_data.z or 990
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
    self.current = nil
    self.scroll = 1
    self.history = {}
    self.line_sizes = {}
    self.longest_key = 0
    self.longest_type = 0
    self.longest_value = 0
    self.available_value = 0
    self.lines = {}
    self.visible = init_data and init_data.visible or false
    self.initialized = true
end

Inspector.delete = function(self)
	self.initialized = false
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

Inspector.update = function(self, dt, t, input_service)
	if self.initialized and self.visible then
		return self:draw(dt, t, input_service)
	end
end

Inspector.draw_title_bar = function(self, input_service)
    -- Get gui
    local gui, gui_retained = mod:forward_gui()
    -- Check if gui is available
    if gui then
        -- Values
        local position = vector3_unbox(self.position)
        local size = vector3_unbox(self.size)
        local cursor = self:cursor(input_service)
        local title_size = vector3_unbox(self.title_size)
        local color = quaternion_unbox(self.color)
        local shadow = quaternion_unbox(self.shadow)
        -- Title text
        local t_min, t_max, t_caret = Gui.text_extents(gui, "Inspector", self.font, self.font_size * 1.5)
        ScriptGui.text(gui, "Inspector", self.font, self.font_size * 1.5, vector3(position[1] + 60, position[2] + 7, position[3] + 1), color, shadow)
        local title_hover = math.point_is_inside_2d_box(cursor, position, title_size)
        -- Back button
        local button_position = vector3(position[1] + 10, position[2] + 10, position[3] + 1)
        local button_size = vector3(title_size[2] - 20, title_size[2] - 20, 0)
        local button_hover = #self.history > 0 and math.point_is_inside_2d_box(cursor, button_position, button_size)
        -- Back Button hover
        if button_hover then
            -- Highlight
            ScriptGui.icrect(gui, self.RES_X, self.RES_Y, button_position[1], button_position[2], button_position[1] + button_size[1], button_position[2] + button_size[2], self.z, quaternion_unbox(self.highlight))
        end
        local button_color = #self.history > 0 and color or quaternion_unbox(self.disabled_color)
        local min, max, caret = Gui.text_extents(gui, "<", self.font, self.font_size)
        ScriptGui.text(gui, "<", self.font, self.font_size * 2, button_position + vector3(5 - max.x / 2, -max.y / 2, 0), button_color, shadow)
        -- Close button
        local close_button_position = vector3(position[1] + size[1] - 10 - button_size[1], position[2] + 10, position[3] + 1)
        local close_button_hover = math.point_is_inside_2d_box(cursor, close_button_position, button_size)
        -- Close button hover
        if close_button_hover then
            ScriptGui.icrect(gui, self.RES_X, self.RES_Y, close_button_position[1], close_button_position[2], close_button_position[1] + button_size[1], close_button_position[2] + button_size[2], self.z, quaternion_unbox(self.highlight))
        end
        local min, max, caret = Gui.text_extents(gui, "x", self.font, self.font_size)
        ScriptGui.text(gui, "x", self.font, self.font_size * 2, close_button_position + vector3(7 - max.x / 2, -2 - max.y / 2, 0), color, shadow)
        -- Clear button
        local clear_button_position = vector3(position[1] + 70 + t_max.x, position[2] + 10, position[3] + 1)
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
        if button_hover then
            -- Check pressed
            if self:pressed(input_service) then
                -- Return busy
                self:back()
            end
            -- Return busy
            return true
        elseif close_button_hover then
            -- Check pressed
            if self:pressed(input_service) then
                -- self.visible = false
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

Inspector.draw_frame = function(self, input_service)
    -- Get gui
    local gui, gui_retained = mod:forward_gui()
    -- Check if gui is available
    if gui then
        -- Values
        local position = vector3_unbox(self.position)
        local size = vector3_unbox(self.size)
        local cursor = self:cursor(input_service)
        local frame_size = vector3_unbox(self.frame_size_inner)
        local total_height = #self.lines *  self.row_height
        -- Frame hover
        self.hover = math.point_is_inside_2d_box(cursor, position, size)
        -- Background
        local background = self.hover and quaternion_unbox(self.hover_background) or quaternion_unbox(self.background)
        -- Draw frame
        ScriptGui.icrect(gui, self.RES_X, self.RES_Y, position[1], position[2], position[1] + size[1], position[2] + size[2], self.z - 1, background)
        -- Functionality
        if self.hover and total_height > frame_size[2] then
            -- Scroll
            local scroll_axis = input_service:get("scroll_axis")
            local max_scroll = math.ceil(#self.lines - frame_size[2] / self.row_height) + 1
            if scroll_axis then
                self.scroll = math.ceil(math.clamp(self.scroll - scroll_axis[2], 1, max_scroll))
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

Inspector.draw_bread_crumbs = function(self, input_service)
    -- Get gui
    local gui, gui_retained = mod:forward_gui()
    -- Check if gui is available
    if gui then
        local is_busy = false
        -- Values
        local color = quaternion_unbox(self.color)
        local shadow = quaternion_unbox(self.shadow)
        local position = vector3_unbox(self.position)
        local adress_position = position + vector3_unbox(self.adress_position)
        local adress_size = vector3_unbox(self.adress_size)
        local offset = vector3(10, 5, 0)
        local size = vector3_unbox(self.size)
        local cursor = self:cursor(input_service)
        local x = 0
        -- Iterate history entries
        for _, history in pairs(self.history) do
            -- Get dimensions
            local value = history.key
            local min, max, caret = Gui.text_extents(gui, value, self.font, self.font_size)
            if max.x > size[1] / 2 then
                value = "..."..string_sub(value, string.len(value) - 20, string.len(value))
                min, max, caret = Gui.text_extents(gui, value, self.font, self.font_size)
            end
            -- Position
            local crumb_position = adress_position + vector3(x, 0, 1) + offset
            -- Hover
            history.hover = math.point_is_inside_2d_box(cursor, crumb_position, vector3(max.x, 20, 0))
            -- Check hover
            if history.hover and not self.context_menu.hover then
                -- Check highlight background
                ScriptGui.icrect(gui, self.RES_X, self.RES_Y, crumb_position[1], crumb_position[2], crumb_position[1] + max.x, crumb_position[2] + 20, self.z, quaternion_unbox(self.highlight))
                -- Check pressed
                if self:pressed(input_service) then
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
            ScriptGui.text(gui, value, self.font, self.font_size, crumb_position, color, shadow)
            -- Draw arrow
            ScriptGui.text(gui, ">", self.font, self.font_size, crumb_position + vector3(max.x + 8, 0, 0), color, shadow)
            -- Update x
            x = x + max.x + 20
        end
        -- Get current dimensions
        if self.current then
            local value = self.current.key
            local crumb_position = adress_position + vector3(x, 0, 1) + offset
            local min, max, caret = Gui.text_extents(gui, value, self.font, self.font_size)
            if max.x > size[1] / 2 then
                value = "..."..string_sub(value, string.len(value) - 20, string.len(value))
                min, max, caret = Gui.text_extents(gui, value, self.font, self.font_size)
            end
            -- Draw current text
            ScriptGui.text(gui, value, self.font, self.font_size, crumb_position, color, shadow)
        end
        -- Return busy
        return is_busy == true and true
    end
end

Inspector.draw_scroll = function(self, input_service)
    -- Get gui
    local gui, gui_retained = mod:forward_gui()
    -- Check if gui is available
    if gui then
        -- Values
        local position = vector3_unbox(self.position)
        local size = vector3_unbox(self.size)
        local frame_position = position + vector3_unbox(self.frame_position_inner)
        local frame_size = vector3_unbox(self.frame_size_inner)
        local total_lines_height = self:total_lines_height()
        local scroll_bar_height = self:scrollbar_height()
        local scroll_bar_color = total_lines_height > frame_size[2] and quaternion_unbox(self.color) or quaternion_unbox(self.disabled_color)
        local scroll_offset = total_lines_height > frame_size[2] and self.scroll * frame_size[2] / #self.lines or 0
        local y = position[2] + vector3_unbox(self.title_size)[2] + vector3_unbox(self.adress_size)[2] + scroll_offset
        local y2 = y + scroll_bar_height
        -- Draw
        ScriptGui.icrect(gui, self.RES_X, self.RES_Y, position[1] + size[1] - 10, y, position[1] + size[1] - 5, y2, self.z, scroll_bar_color)
    end
end

Inspector.draw_context_menu = function(self, input_service)
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
                    mod:watcher_set_mod(mod)
                    mod:watch(self.context_menu.line.key, self.current.table, self.context_menu.line.key)
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

Inspector.draw_lines = function(self, input_service)
    -- Get gui
    local gui, gui_retained = mod:forward_gui()
    -- Check if gui is available
    if gui then
        local is_busy = false
        -- Values
        local position = vector3_unbox(self.position)
        local frame_position = position + vector3_unbox(self.frame_position_inner)
        local frame_size = vector3_unbox(self.frame_size_inner)
        local cursor = self:cursor(input_service)
        local y = 0
        -- Iterate lines
        for index = self.scroll, #self.lines, 1 do
            local line = self.lines[index]
            if line then

                if y + self.row_height > frame_size[2] then break end
                
                local row_position = vector3(frame_position[1], frame_position[2] + y, frame_position[3])
                local row_size = vector3(frame_size[1] - 10, self.row_height, 0)
                local hover = math.point_is_inside_2d_box(cursor, row_position, row_size)

                if hover and not self.context_menu.hover then
                    ScriptGui.icrect(gui, self.RES_X, self.RES_Y, row_position[1], row_position[2], row_position[1] + row_size[1], row_position[2] + row_size[2], self.z, quaternion_unbox(self.highlight))
                    if self:pressed(input_service) then
                        if line.is_table and self.current.table[line.key] and type(self.current.table[line.key]) == "table" then
                            self:navigate(line.key, self.current.table[line.key])
                            -- mod:echot("navigate to: "..tostring(line.key))
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
                ScriptGui.text(gui, type(line.value), self.font, self.font_size, vector3(frame_position[1] + 10 + self.longest_key + 10, frame_position[2] + y, frame_position[3] + 1), color, shadow)

                -- Row 3 - Value
                local value = tostring(line.value)
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

Inspector.draw = function(self, dt, t, input_service)
    local is_busy = false
    is_busy = self:draw_frame(input_service)
    is_busy = self:draw_scroll(input_service) or is_busy
    is_busy = self:draw_title_bar(input_service) or is_busy
    is_busy = self:draw_bread_crumbs(input_service) or is_busy
    self:get_line_sizes()
    is_busy = self:draw_lines(input_service) or is_busy
    is_busy = self:draw_context_menu(input_service) or is_busy
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

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

Inspector.screen_size = function(self)
    return vector3(RESOLUTION_LOOKUP.width, RESOLUTION_LOOKUP.height, 0)
end

Inspector.scrollbar_height = function(self)
    local frame_size = vector3_unbox(self.frame_size_inner)
    return frame_size[2] * math.clamp(frame_size[2] / self:total_lines_height(), 0, 1)
end

Inspector.total_lines_height = function(self)
    return self.row_height * #self.lines
end

Inspector.cursor = function(self, input_service)
	return input_service and input_service:get("cursor") or vector3(0, 0, 0)
end

Inspector.pressed = function(self, input_service)
	return input_service and input_service:get("left_pressed") or false
end

Inspector.context_pressed = function(self, input_service)
    return input_service and input_service:get("right_pressed") or false
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

Inspector.get_line_sizes = function(self)
    local gui, gui_retained = mod:forward_gui()
    if gui then
        self.longest_key = 0
        self.longest_type = 0
        self.longest_value = 0
        table_clear(self.line_sizes)
        for index, line in pairs(self.lines) do
            local k_min, k_max, k_caret = Gui.text_extents(gui, tostring(line.key), self.font, self.font_size)
            local t_min, t_max, t_caret = Gui.text_extents(gui, type(line.value), self.font, self.font_size)
            local v_min, v_max, v_caret = Gui.text_extents(gui, tostring(line.value), self.font, self.font_size)
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

Inspector.show = function(self, show)
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
        self.scroll = 1
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
        self.scroll = 1
        self:update_content()
    end
end

return Inspector