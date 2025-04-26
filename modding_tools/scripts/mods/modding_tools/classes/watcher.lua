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
    local string = string
    local vector3 = Vector3
    local managers = Managers
    local tostring = tostring
    local profiler = Profiler
    local tonumber = tonumber
    local math_max = math.max
    local math_abs = math.abs
    local math_min = math.min
    local math_huge = math.huge
    local math_ceil = math.ceil
    local math_floor = math.floor
    local table_size = table.size
    local string_len = string.len
    local math_clamp = math.clamp
    local string_sub = string.sub
    local vector3_box = Vector3Box
    local string_trim = string.trim
    local Application = Application
    local table_clear = table.clear
    local string_format = string.format
    local DevParameters = DevParameters
    local lua_stats = profiler.lua_stats
    local quaternion_box = QuaternionBox
    local scriptGui_text = ScriptGui.text
    local vector3_unbox = vector3_box.unbox
    local gui_text_extents = Gui.text_extents
    local scriptGui_icrect = ScriptGui.icrect
    local script_gui_icrect = ScriptGui.icrect
    local RESOLUTION_LOOKUP = RESOLUTION_LOOKUP
    local quaternion_unbox = quaternion_box.unbox
    local script_gui_hud_line = ScriptGui.hud_line
    local math_round_with_precision = math.round_with_precision
    local math_point_is_inside_2d_box = math.point_is_inside_2d_box
    local application_time_since_query = Application.time_since_query
    local application_query_performance_counter = Application.query_performance_counter
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local DEBUG = false
    local WATCH_LUA_STATS = true
    local lua_stat_values = {
        total_memory_allocated_by_lua = 0,
        estimated_garbage_memory = 0,
        percentage_of_garbage_memory = 0,
        estimated_time_in_garbage_collection = 0,
        actual_time_in_garbage_collection = 0,
        total_time_in_garbage_collection = 0,
    }
    local column_names = {
        "Key", "Type", "Value", "Graph"
    }
    local context = {
        Inspect = "Inspect",
        Remove = "Remove",
    }
    -- local dot_chain = {}
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
    self.z = init_data and init_data.z or 997
    self.visible = init_data and init_data.visible or false
    -- Graph
    self.graph_values = {}
    self.graph_extents = {}
    self.graph_timer = 0
    self.graph_time = .1
    self.history_slider = {cursor = vector3_box(vector3(0, 0, 0)), hover = false, active = false, scroll = 1, percentage = 1}
    self.history_slider_scroll = init_data and init_data.scale_slider_scroll or 1
    -- Columns
    self.longest_key = 0
    self.longest_type = 0
    self.longest_value = 0
    self.available_value = 0
    -- Lines
    self.line_sizes = {}
    self.lines = {}
    if init_data and init_data.lines then for _, line in pairs(init_data.lines) do self:print(line) end end
    self.last_line = #self.lines > 0 and self.lines[#self.lines] or nil
    -- Selection
    self.selection = {cursor = vector3_box(vector3(0, 0, 0)), active = false, lines = {}}
    -- Row height
    self.scale_slider = {cursor = vector3_box(vector3(0, 0, 0)), hover = false, active = false, scroll = 1}
    self.scale_slider_scroll = init_data and init_data.scale_slider_scroll or 1
    self.default_row_height = init_data and init_data.default_row_height or 20
    self.row_height = init_data and init_data.row_height or self.default_row_height
    -- Scroll
    self.scrollbar = {cursor = vector3_box(vector3(0, 0, 0)), hover = false, active = false, scroll = 0}
    self.scroll = init_data and init_data.scroll or 0
    self.max_scroll = 1
    -- Context menu
    self.context_menu_background = init_data and init_data.context_menu_background or quaternion_box(Color(255, 0, 0, 0))
    self.context_menu = {options = {context.Inspect, context.Remove}, visible = false, position = vector3_box(vector3(0, 0, 0))}
    -- Colors
    self.background = init_data and init_data.background or quaternion_box(Color(128, 0, 0, 0))
    self.hover_background = init_data and init_data.hover_background or quaternion_box(Color(200, 0, 0, 0))
    self.disabled_color = init_data and init_data.disabled_color or quaternion_box(Color(64, 255, 255, 255))
    self.color = init_data and init_data.color or quaternion_box(Color.white())
    self.lowlight = init_data and init_data.lowlight or quaternion_box(Color(128, 255, 255, 255))
    self.highlight = init_data and init_data.highlight or quaternion_box(Color(128, 128, 128, 255))
    self.highlight_more = init_data and init_data.highlight_more or quaternion_box(Color(192, 128, 128, 255))
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
    self.frame_position_inner = vector3_box(vector3_unbox(self.frame_position) + vector3(10, 10 + self.row_height, 0))
    self.frame_size = vector3_box(vector3(size[1], size[2] - title_size[2], self.z + 1))
    self.frame_size_inner = vector3_box(vector3_unbox(self.frame_size) - vector3(30, 20 + self.row_height, 0))
    -- Calc
    self.title = init_data and init_data.title or "Watcher"
    -- self.carret = init_data and init_data.carret or {0, 0}
    self.was_pressed = false
    self.drawing_time = 0
    self.initialized = true
    -- Watch lua stats
    if WATCH_LUA_STATS then
        self:update_lua_stats()
        self:watch("Total memory allocated by lua", lua_stat_values, "total_memory_allocated_by_lua")
        self:watch("Estimated garbage memory", lua_stat_values, "estimated_garbage_memory")
        self:watch("Percentage of garbage memory", lua_stat_values, "percentage_of_garbage_memory")
        self:watch("Estimated time in garbage collection", lua_stat_values, "estimated_time_in_garbage_collection")
        self:watch("Actual time in garbage collection", lua_stat_values, "actual_time_in_garbage_collection")
        self:watch("Total time in garbage collection", lua_stat_values, "total_time_in_garbage_collection")
    end
end

Watcher.destroy = function(self)
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

Watcher.update_lua_stats = function(self)
    if WATCH_LUA_STATS then
        -- Get lua stats
        lua_stat_values.total_memory_allocated_by_lua,
        lua_stat_values.estimated_garbage_memory,
        lua_stat_values.percentage_of_garbage_memory,
        lua_stat_values.estimated_time_in_garbage_collection,
        lua_stat_values.actual_time_in_garbage_collection,
        lua_stat_values.total_time_in_garbage_collection = lua_stats()
        -- Format lua stats
        lua_stat_values.total_memory_allocated_by_lua = string_format("%2d Mb", (lua_stat_values.total_memory_allocated_by_lua or 0) / 1024)
        lua_stat_values.estimated_garbage_memory = string_format("%2d Mb", (lua_stat_values.estimated_garbage_memory or 0) / 1024)
        lua_stat_values.percentage_of_garbage_memory = string_format("%.2f %%", (lua_stat_values.percentage_of_garbage_memory or 0) * 100)
        lua_stat_values.estimated_time_in_garbage_collection = string_format("%.2f ms", lua_stat_values.estimated_time_in_garbage_collection or 0)
        lua_stat_values.actual_time_in_garbage_collection = string_format("%.2f ms", lua_stat_values.actual_time_in_garbage_collection or 0)
        lua_stat_values.total_time_in_garbage_collection = string_format("%.2f ms", lua_stat_values.total_time_in_garbage_collection or 0)
    end
end

Watcher.update = function(self, dt, t, input_service)
    -- Performance counter
    local handle = application_query_performance_counter()
    -- Update lua stats
    self:update_lua_stats()
    -- Update graphs
    self:update_graphs(t)
    -- Check if visible
    if self.initialized and self.visible then
        -- Reset mouse button was already pressed this loop
        self.was_pressed = false
        -- Cache
        self._gui, self._gui_retained = mod:forward_gui()
        self._screen_size = self:screen_size()
        self._position = vector3_unbox(self.position)
        self._frame_size = vector3_unbox(self.frame_size)
        self._frame_size_inner = vector3_unbox(self.frame_size_inner)
        self._frame_position = vector3_unbox(self.frame_position_inner)
        self._size = vector3_unbox(self.size)
        self._title_size = vector3_unbox(self.title_size)
        self._context_menu_position = vector3_unbox(self.context_menu.position)
        -- Colors
        self._color = quaternion_unbox(self.color)
        self._shadow = quaternion_unbox(self.shadow)
        self._background = quaternion_unbox(self.background)
        self._lowlight = quaternion_unbox(self.lowlight)
        self._highlight = quaternion_unbox(self.highlight)
        self._highlight_more = quaternion_unbox(self.highlight_more)
        self._context_menu_background = quaternion_unbox(self.context_menu_background)
        self._hover_background = quaternion_unbox(self.hover_background)
        self._disabled_color = quaternion_unbox(self.disabled_color)
        -- Inputs
        self._cursor = self:cursor(input_service)
        self._scroll_axis = self:scroll_axis(input_service)
        self._pressed = self:pressed(input_service)
        self._held = self:held(input_service)
        self._context_pressed = self:context_pressed(input_service)
        self._shift_held = self:shift_held()
        self._ctrl_held = self:ctrl_held()
        -- Disable control
        self.disable_control = mod.inspector_busy or mod.console_busy
        -- Draw
        local busy = self:draw(input_service)
        -- Drawing time from performance counter
        self.drawing_time = application_time_since_query(handle)
        -- Return busy
        return busy
    end
end

local function numbers_only(str)
    local number_only = ""
    local chr = ""
    if type(str) == "string" then
        for i = 1, #str do
            chr = string_sub(str, i, i)
            if tonumber(chr) ~= nil and chr ~= "." then
                number_only = number_only..chr
            end
        end
        return number_only
    elseif type(str) == "number" then
        return str
    end
end

Watcher.update_graphs = function(self, t)
    -- Check timer
    if t > self.graph_timer + self.graph_time then
        -- Iterate through lines
        for index = 1, #self.lines, 1 do
            -- Get line
            local line = self.lines[index]
            -- Get value
            local value = numbers_only(line.table[line.obj_key])
            -- Check value
            if value and value ~= "" then
                -- Check graph value table
                self.graph_values[index] = self.graph_values[index] or {}
                -- Add graph value
                self.graph_values[index][#self.graph_values[index] + 1] = tonumber(value)
                -- Round value
                self.graph_values[index][#self.graph_values[index]] = math_round_with_precision(self.graph_values[index][#self.graph_values[index]], 3)
            end
        end
        -- Set timer
        self.graph_timer = t + self.graph_time
    end
end

Watcher.update_line_graph_extents = function(self, index)
    -- Get line
    local line = self.lines[index]
    -- Highest and lowest
    local highest, lowest = 0, math_huge
    -- Get width
    local width = math_max(100, self.available_value)
    -- Iterate through graph values
    local graph_values = self.graph_values[index]
    if graph_values then
        local from = math_ceil(line.start or #self.graph_values[index])
        local to = math_ceil(math.max(from - width, 1))
        for i = from, to, -1 do
            -- Check value
            if i > 0 and graph_values[i] then
                local value = graph_values[i]
                -- Update highest and lowest
                if value > highest then highest = value end
                if value < lowest then lowest = value end
            end
        end
        -- Check graph extent table
        self.graph_extents[index] = self.graph_extents[index] or {}
        -- Add graph extents
        self.graph_extents[index].highest = tonumber(highest)
        self.graph_extents[index].lowest = tonumber(lowest)
    end
end

Watcher.update_graph_extents = function(self)
    -- Iterate through lines
    for index = 1, #self.lines, 1 do
        self:update_line_graph_extents(index)
    end
end

Watcher.draw = function(self, input_service)
    -- Busy
    local is_busy = false
    -- Get line sizes
    self:get_line_sizes()
    -- Draw
    is_busy = self:draw_frame(input_service)
    is_busy = self:draw_title_bar(input_service) or is_busy
    is_busy = self:draw_scroll(input_service) or is_busy
    is_busy = self:draw_lines(input_service) or is_busy
    is_busy = self:draw_context_menu(input_service) or is_busy
    is_busy = self:draw_selection(input_service) or is_busy
    -- Return busy
    return is_busy == true and true
end

Watcher.draw_title_bar = function(self, input_service)
    -- Check if gui is available
    if self._gui then

        -- Draw title text
        local t_min, t_max, t_caret = gui_text_extents(self._gui, self.title, self.font, self.font_size * 1.5)
        scriptGui_text(self._gui, self.title, self.font, self.font_size * 1.5, vector3(self._position[1] + 20, self._position[2] + 7, self._position[3] + 1), self._color, self._shadow)


        -- Close button
        local button_size = vector3(self._title_size[2] - 20, self._title_size[2] - 20, 0)
        local close_button_position = vector3(self._position[1] + self._title_size[1] - 10 - button_size[1], self._position[2] + 10, self._position[3] + 1)
        -- local button_size = vector3(self._title_size[2] - 20, self._title_size[2] - 20, 0)
        local close_button_hover = not self.scrollbar.active and not self.scale_slider.active and not self.history_slider.active and not self.disable_control and math_point_is_inside_2d_box(self._cursor, close_button_position, button_size)
        -- Close button hover
        if close_button_hover then
            scriptGui_icrect(self._gui, self.RES_X, self.RES_Y, close_button_position[1], close_button_position[2], close_button_position[1] + button_size[1], close_button_position[2] + button_size[2], self.z, self._highlight)
        end
        -- Close button draw
        local min, max, caret = gui_text_extents(self._gui, "x", self.font, self.font_size)
        scriptGui_text(self._gui, "x", self.font, self.font_size * 2, close_button_position + vector3(7 - max.x / 2, -2 - max.y / 2, 0), self._color, self._shadow)


        -- Clear button
        local clear_button_position = vector3(self._position[1] + 30 + t_max.x, self._position[2] + 10, self._position[3] + 1)
        -- Clear button hover
        local clear_button_hover = not self.scrollbar.active and not self.scale_slider.active and not self.history_slider.active and not self.disable_control and math_point_is_inside_2d_box(self._cursor, clear_button_position, button_size)
        if clear_button_hover then
            scriptGui_icrect(self._gui, self.RES_X, self.RES_Y, clear_button_position[1], clear_button_position[2], clear_button_position[1] + button_size[1], clear_button_position[2] + button_size[2], self.z, self._highlight)
        end
        -- Clear button draw
        local min, max, caret = gui_text_extents(self._gui, "cl", self.font, self.font_size)
        scriptGui_text(self._gui, "cl", self.font, self.font_size * 1.5, clear_button_position + vector3(7 - max.x / 2, 5 - max.y / 2, 0), self._color, self._shadow)


        -- Functionality
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

Watcher.draw_context_menu = function(self, input_service)
    -- Check if gui is available
    if self._gui and self.context_menu.visible then
        -- Values
        local y = 10
        local size = vector3(160, self.row_height * #self.context_menu.options + 20, 0)

        -- Draw background
        scriptGui_icrect(self._gui, self.RES_X, self.RES_Y, self._context_menu_position[1], self._context_menu_position[2], self._context_menu_position[1] + size[1], self._context_menu_position[2] + size[2], 1000, self._context_menu_background)

        -- Functionality
        self.context_menu.hover = false
        for _, option in pairs(self.context_menu.options) do
            -- Position and size
            local row_position = vector3(self._context_menu_position[1] + 10, self._context_menu_position[2] + y, self._context_menu_position[3])
            local row_size = vector3(size[1] - 20, self.row_height, 0)
            -- Hover
            local hover = not self.scrollbar.active and not self.scale_slider.active and not self.history_slider.active and not self.disable_control and math_point_is_inside_2d_box(self._cursor, row_position, row_size)
            -- Check hover
            if hover then
                self.context_menu.hover = true
                -- Draw option background
                scriptGui_icrect(self._gui, self.RES_X, self.RES_Y, row_position[1], row_position[2], row_position[1] + row_size[1], row_position[2] + row_size[2], 1000, self._highlight)
                -- Check if mouse button pressed and not already pressed this loop
                if not self.was_pressed and self._pressed then
                    self.was_pressed = true
                    -- Check option
                    if option == context.Remove then
                        -- Remove
                        -- self:remove(self.context_menu.line.key)
                        self:remove_selection()
                        -- Close context menu
                        self:close_context_menu()
                        -- Return busy
                        return true
                    elseif option == context.Inspect then
                        -- Inspect
                        -- mod:inspect(self.context_menu.line.text, self.context_menu.line.obj)
                        self:inspect_selection()
                        -- Close context menu
                        self:close_context_menu()
                        -- Return busy
                        return true
                    end
                end
            end
            -- Draw option text
            scriptGui_text(self._gui, option, self.font, self.font_size, vector3(row_position[1], row_position[2], 1000), self._color, self._shadow)
            -- Increase y
            y = y + self.row_height
        end
        -- Return busy
        return self.context_menu.hover
    end
end

Watcher.draw_scroll = function(self, input_service)
    -- Check if gui is available
    if self._gui then
        -- Get values
        -- local held = false
        local total_lines_height = self:total_lines_height()
        local scroll_bar_height = self:scrollbar_height()
        -- Color
        local scroll_bar_color = total_lines_height > self._frame_size_inner[2] and self._color or self._disabled_color
        -- Offset
        local scroll_offset = total_lines_height > self._frame_size_inner[2] and self.scroll * (self._frame_size_inner[2] / #self.lines) or 0
        local y = self._position[2] + self._title_size[2] + scroll_offset + 10
        local y2 = self._position[2] + self._title_size[2] + scroll_offset + scroll_bar_height
        -- Hover
        self.scrollbar.hover = not self.disable_control and not self.scale_slider.active and not self.history_slider.active and math_point_is_inside_2d_box(self._cursor, vector3(self._position[1] + self._size[1] - 10, y, 1), vector3(5, scroll_bar_height, 1))
        -- Check hover
        if self.scrollbar.hover then
            -- held = self._held
            if self._held ~= self.scrollbar.active then
                self:close_context_menu()
                self.scrollbar.active = self._held
            end
        end
        -- Draw background
        local color = (self.scrollbar.hover or self.scrollbar.active) and self._highlight or scroll_bar_color
        -- mod:echot("x: "..tostring(self._position[1] + self._size[1] - 10).." y: "..tostring(y).." x2: "..tostring(self._position[1] + self._size[1] - 5).." y2: "..tostring(y2).." scroll_offset: "..tostring(scroll_offset).." self.scroll: "..tostring(self.scroll))
        scriptGui_icrect(self._gui, self.RES_X, self.RES_Y, self._position[1] + self._size[1] - 10, y, self._position[1] + self._size[1] - 5, y2, 1000, color)
        -- if self.scrollbar.hover or self.scrollbar.active then
        --     scriptGui_icrect(self._gui, self.RES_X, self.RES_Y, self._position[1] + self._size[1] - 10, y, self._position[1] + self._size[1] - 5, y2, 1000, self._highlight)
        -- else
        --     scriptGui_icrect(self._gui, self.RES_X, self.RES_Y, self._position[1] + self._size[1] - 10, y, self._position[1] + self._size[1] - 5, y2, 1000, scroll_bar_color)
        -- end
        -- Scrollbar active
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
        -- Return busy
        return self.scrollbar.active == true and true
    end
end

Watcher.draw_frame = function(self, input_service)
    -- Check if gui is available
    if self._gui then
        -- Hover
        self.hover = not self.disable_control and math_point_is_inside_2d_box(self._cursor, self._position, self._size)
        -- Color
        local color = self.hover and self._hover_background or self._background
        -- Draw
        scriptGui_icrect(self._gui, self.RES_X, self.RES_Y, self._position[1], self._position[2], self._position[1] + self._size[1], self._position[2] + self._size[2], self.z, color)
        -- Functionality
        if self:total_lines_height() > self._frame_size[2] then
            if self.hover then
                self.scroll = math_clamp(math_ceil(math_clamp(self.scroll - self._scroll_axis[2], 0, #self.lines * self.row_height)), 0, self.max_scroll)
                self:scrolled()
            end
            self.max_scroll = math_ceil(#self.lines - self._frame_size[2] / self.row_height) + 1
        else
            self.max_scroll = 0
        end
        -- Close context menu
        if self.hover and self.context_menu.visible and not self.context_menu.hover then
            -- Check if mouse button pressed and not already pressed this loop
            if not self.was_pressed and self._pressed then
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

Watcher.draw_lines = function(self, input_service)
    -- Check if gui is available
    if self._gui then
        local is_busy = false
        -- Values
        local y = 0
        local key_x, key_y, key_z = nil, nil, nil
        local line_x, line_y, line_z = nil, nil, nil
        local type_x, type_y, type_z = nil, nil, nil
        local value_x, value_y, value_z = nil, nil, nil
        local graph_x, graph_y, graph_z = nil, nil, nil
        -- Iterate lines
        local max_line = math_min(self.scroll + self:visible_rows(), #self.lines)
        local longest_graph_value_chain = 0
        -- Iterate lines from scroll to end
        local line_nr = 1
        for index = self.scroll, max_line, 1 do
        -- for index = self.scroll, #self.lines, 1 do
            local line = self.lines[index]
            if line then

                if y + self.row_height > self._frame_size_inner[2] then break end
                -- Position and size
                local row_position = vector3(self._frame_position[1], self._frame_position[2] + y, self._frame_position[3])
                local row_size = vector3(self._frame_size_inner[1], self.row_height, 0)
                if (line_nr % 2 == 0) then
                    scriptGui_icrect(self._gui, self.RES_X, self.RES_Y, row_position[1], row_position[2], row_position[1] + row_size[1], row_position[2] + row_size[2], self.z, Color(20, 255, 255, 255))
                end
                -- Hover
                line.hover = not self.scrollbar.active and not self.scale_slider.active and not self.history_slider.active and not self.disable_control and math_point_is_inside_2d_box(self._cursor, row_position, row_size)
                -- Check hover
                if (line.hover and not self.context_menu.visible) or self.selection.lines[line] then
                    -- Draw background
                    local color = line.hover and (self._pressed or self._held) and self._highlight_more or self._highlight
                    scriptGui_icrect(self._gui, self.RES_X, self.RES_Y, row_position[1], row_position[2], row_position[1] + row_size[1], row_position[2] + row_size[2], self.z, color)
                end
                if line.hover and not self.context_menu.visible then
                    -- Inspect table on left click
                    if not self.was_pressed and self._pressed then
                        -- Set was pressed in loop
                        self.was_pressed = true
                        -- Check if ctrl held
                        if not self._ctrl_held then
                            -- Unselect
                            self:unselect()
                            -- Check if table
                            if line.is_table then
                                -- Inspect
                                self:inspect_table(line.key, line.table[line.obj_key])
                            end
                        end
                        -- Select
                        self:select(line)
                    end
                    if self._context_pressed then
                        -- Unselect if only one line selected
                        if table_size(self.selection.lines) == 1 then self:unselect() end
                        -- Select
                        self:select(line)
                        -- Open context menu
                        self:open_context_menu(line, self._cursor)
                    end
                    is_busy = true
                end
                -- Color
                local color = line.is_table and self._lowlight or self._color


                -- Row 1 - Key
                local key_min, key_max, key_caret = gui_text_extents(self._gui, line.key, self.font, self.font_size)
                local key_x, key_y, key_z = self._frame_position[1] + 10, self._frame_position[2] + y, self._frame_position[3] + 1
                local text_y = self.row_height / 2 - key_max.y / 2
                scriptGui_text(self._gui, line.key, self.font, self.font_size, vector3(key_x, key_y + text_y, key_z), color, self._shadow)


                -- Row 2 - Type
                local type_x, type_y, type_z = key_x + self.longest_key + 10, key_y, key_z
                scriptGui_text(self._gui, type(line.table[line.obj_key]), self.font, self.font_size, vector3(type_x, type_y + text_y, type_z), color, self._shadow)


                -- Row 3 - Value
                local value_x, value_y, value_z = type_x + self.longest_type + 10, key_y, key_z
                local value = line.table[line.obj_key]
                if type(value) == "number" then
                    value = math_round_with_precision(value, 3)
                    value = string_format("%.3f", value)
                elseif type(value) ~= "string" then
                    value = tostring(value)
                end
                -- value = string_trim(value)
                local min, max, caret = gui_text_extents(self._gui, value, self.font, self.font_size)
                if max.x > self.available_value then
                    value = "..."..string_sub(value, string_len(value) - 20, string_len(value))
                    min, max, caret = gui_text_extents(self._gui, value, self.font, self.font_size)
                end
                if line.text_pattern then
                    value = string_format(line.text_pattern, value)
                end
                scriptGui_text(self._gui, value, self.font, self.font_size, vector3(value_x, value_y + text_y, value_z), color, self._shadow)


                -- Row 4 - graph
                local graph_x, graph_y, graph_z = value_x + self.longest_value + 10, key_y, key_z
                local width = math_max(100, self.available_value)
                -- Graph dots
                self:update_line_graph_extents(index)
                if self.graph_values[index] and #self.graph_values[index] > 0 and self.graph_extents[index] then
                    -- self:update_graph_extents()
                    if #self.graph_values[index] > longest_graph_value_chain then longest_graph_value_chain = #self.graph_values[index] end
                    -- Line
                    local line_x, line_y, line_z = graph_x, graph_y + self.row_height / 2, graph_z
                    scriptGui_icrect(self._gui, self.RES_X, self.RES_Y, line_x, line_y, line_x + width, line_y + 1, self.z, Color(64, 255, 255, 0))
                    -- Iterate through graph values
                    local j = 1
                    local last_dot = nil
                    local from = math_ceil(line.start or #self.graph_values[index])
                    local to = math_ceil(math.max(from - width, 1))
                    for i = from, to, -1 do
                        if i > 0 and self.graph_values[index][i] then
                            local value = self.graph_values[index][i]
                            local percentage = ((value - self.graph_extents[index].lowest) * 100) / (self.graph_extents[index].highest - self.graph_extents[index].lowest)
                            local dot_x, dot_y = graph_x + width - j, graph_y + self.row_height - 4 - (((self.row_height - 8) * percentage) / 100)
                            local dot = vector3(dot_x, dot_y, self.z)
                            if last_dot then
                                script_gui_hud_line(self._gui, last_dot, dot, self.z+1, 1, Color(255, 0, 255, 0))
                            end
                            last_dot = dot
                        end
                        j = j + 1
                    end
                end
                -- Increase y
                y = y + self.row_height
                line_nr = line_nr + 1
            end
        end

        if max_line - self.scroll > 0 then
            -- Draw column texts
            local key_x, key_y, key_z = self._frame_position[1] + 10, self._frame_position[2] - 20, self._frame_position[3] + 1
            local type_x, type_y, type_z = key_x + self.longest_key + 10, key_y, key_z
            local value_x, value_y, value_z = type_x + self.longest_type + 10, key_y, key_z
            local graph_x, graph_y, graph_z = value_x + self.longest_value + 10, key_y, key_z
            local col_x, col_y, col_z = key_x, key_y, key_z
            local min, max, caret = gui_text_extents(self._gui, "Graph", self.font, self.font_size)
            local width = ((self.available_value - max.x - 10) / 2) - 5
            -- Iterate columns
            for index = 1, 4, 1 do
                if index == 2 then col_x = key_x + self.longest_key + 10 end
                if index == 3 then col_x = type_x + self.longest_type + 10 end
                if index == 4 then
                    col_x = value_x + self.longest_value + 10
                    local slider_x, slider_y, slider_z = col_x, key_y - 20 / 2, key_z

                    -- History slider
                    local history_slider_width = self.available_value --((self.available_value - max.x - 10) / 2) - 5
                    local scroll_bar_color = longest_graph_value_chain > self.available_value and self._lowlight or self._disabled_color
                    script_gui_icrect(self._gui, self.RES_X, self.RES_Y, slider_x, slider_y, slider_x + history_slider_width, slider_y + 3, self.z, scroll_bar_color)
                    local handle_width = math_clamp(history_slider_width * (self.available_value / longest_graph_value_chain), 10, history_slider_width)
                    slider_x = slider_x + self.history_slider_scroll
                    -- Hover
                    self.history_slider.hover = not self.disable_control and not self.scale_slider.active and not self.scrollbar.active and math_point_is_inside_2d_box(self._cursor, vector3(slider_x, slider_y - 2, 1), vector3(handle_width, 5, 1))
                    local color = (self.history_slider.hover or self.history_slider.active) and self._highlight_more or Color(192, 255, 255, 255)
                    -- Draw Handle
                    script_gui_icrect(self._gui, self.RES_X, self.RES_Y, slider_x, slider_y - 2, slider_x + handle_width, slider_y + 5, self.z, color)
                    -- Hover
                    if self.history_slider.hover then
                        if self._held ~= self.history_slider.active then
                            self:close_context_menu()
                            self.history_slider.active = self._held
                        end
                    end
                    local history_scroll_width = history_slider_width - handle_width
                    -- Active
                    if self.history_slider.active then
                        local diff = vector3_unbox(self.history_slider.cursor) - self._cursor
                        self.history_slider_scroll = math_ceil(math_clamp(self.history_slider.scroll - diff[1], 1, history_scroll_width))
                        self.history_slider.percentage = history_scroll_width == 0 and 1 or math_clamp(self.history_slider_scroll / history_scroll_width, 0, 1)
                        if not self._held then
                            self.history_slider.active = false
                        end
                    else
                        self.history_slider.cursor = vector3_box(self._cursor)
                        self.history_slider_scroll = math_ceil(math_clamp(history_scroll_width * self.history_slider.percentage, 1, history_scroll_width))
                        self.history_slider.scroll = self.history_slider_scroll
                    end


                    local width_2 = ((width - 10) / 2) - 5
                    -- Row height slider
                    local slider2_x, slider2_y = col_x + self.available_value - width_2, key_y + 20 / 2
                    -- slider2_x = col_x + self.available_value - width_2
                    script_gui_icrect(self._gui, self.RES_X, self.RES_Y, slider2_x, slider2_y, slider2_x + width_2, slider2_y + 3, self.z, scroll_bar_color)
                    local handle2_x = slider2_x + self.scale_slider_scroll
                    -- Hover
                    self.scale_slider.hover = not self.disable_control and not self.history_slider.active and not self.scrollbar.active and math_point_is_inside_2d_box(self._cursor, vector3(handle2_x, slider2_y - 2, 1), vector3(10, 5, 1))
                    local color = (self.scale_slider.hover or self.scale_slider.active) and self._highlight_more or Color(192, 255, 255, 255)
                    -- Draw handle
                    script_gui_icrect(self._gui, self.RES_X, self.RES_Y, handle2_x, slider2_y - 2, handle2_x + 10, slider2_y + 5, self.z, color)
                    -- Hover
                    if self.scale_slider.hover then
                        if self._held ~= self.scale_slider.active then
                            self:close_context_menu()
                            self.scale_slider.active = self._held
                        end
                    end
                    -- Active
                    if self.scale_slider.active then
                        local diff = vector3_unbox(self.scale_slider.cursor) - self._cursor
                        self.scale_slider_scroll = math_ceil(math_clamp(self.scale_slider.scroll - diff[1], 1, width_2 - 10))
                        if not self._held then
                            self.scale_slider.active = false
                        end
                    else
                        self.scale_slider.cursor = vector3_box(self._cursor)
                        self.scale_slider.scroll = self.scale_slider_scroll
                    end
                    -- Set row height
                    local percentage = self.scale_slider_scroll / width_2
                    self.row_height = self.default_row_height + 100 * percentage

                    local min, max, caret = gui_text_extents(self._gui, "Height", self.font, self.font_size)
                    scriptGui_text(self._gui, "Height", self.font, self.font_size, vector3(slider2_x - max.x - 10, key_y, slider_z), self._lowlight, self._shadow)


                    -- Set busy
                    is_busy = (self.scale_slider.active == true or self.history_slider.active == true) and true or is_busy
                end
                scriptGui_text(self._gui, column_names[index], self.font, self.font_size, vector3(col_x, col_y, col_z), self._lowlight, self._shadow)
            end

            -- Update line graphs
            for index, line in pairs(self.lines) do
                if line then
                    local value_count = #self.graph_values[index]
                    line.start = math_ceil(math_clamp(value_count * self.history_slider.percentage, self.available_value, value_count))
                end
            end
        end

        -- Return busy
        return is_busy == true and true
    end
end

Watcher.draw_selection = function(self, input_service)
    if self.selection.active then
        local position = vector3_unbox(self.selection.cursor)
        local size = vector3(self._cursor[1] - position[1], self._cursor[2] - position[2], 0)
        
        script_gui_icrect(self._gui, self.RES_X, self.RES_Y, position[1], position[2], self._cursor[1], self._cursor[2], 1000, self._highlight)

        local max_line = math_min(self.scroll + self:visible_rows(), #self.lines)
        local y = 0
        for index = self.scroll, max_line, 1 do
            -- Get line
            local line = self.lines[index]
            if line then
                local line_position = vector3(self._frame_position[1], self._frame_position[2] + y, self._frame_position[3])
                local line_bottom = vector3(self._frame_position[1], self._frame_position[2] + y + self.row_height, self._frame_position[3])
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
                y = y + self.row_height
            end
        end

        -- Cancel
        if not self.hover or not self._held then
            self.selection.active = false
            return false
        end
        return true
    elseif self.hover and self._held and not self.was_pressed and not self.scrollbar.active and not self.scale_slider.active and not self.history_slider.active then
        self.selection.cursor = vector3_box(self._cursor)
        self.selection.active = true
        return true
    end
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

Watcher.changed = function(self) end
Watcher.cleared = function(self) end
Watcher.shown = function(self) end
Watcher.hidden = function(self) end
Watcher.context_shown = function(self) end
Watcher.context_hidden = function(self) end
Watcher.scrolled = function(self) end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

Watcher.get_line_sizes = function(self)
    -- Check if gui is available
    if self._gui then
        -- Values
        self.longest_key = 0
        self.longest_type = 0
        self.longest_value = 0
        -- Clear table
        table_clear(self.line_sizes)
        -- Iterate through lines
        for index, line in pairs(self.lines) do
            local k_min, k_max, k_caret = gui_text_extents(self._gui, tostring(line.key), self.font, self.font_size)
            local t_min, t_max, t_caret = gui_text_extents(self._gui, type(line.table[line.obj_key]), self.font, self.font_size)
            local value = line.table[line.obj_key]
            -- Check number
            if type(value) == "number" then
                -- Round
                value = math_round_with_precision(value, 3)
                value = string_format("%.3f", value)
            end
            -- Check pattern
            if line.text_pattern then
                value = string_format(line.text_pattern, value)
            elseif type(value) ~= "string" then
                value = tostring(value)
            end
            -- Get size
            local v_min, v_max, v_caret = gui_text_extents(self._gui, value, self.font, self.font_size)
            if k_max.x > self.longest_key then self.longest_key = k_max.x end
            if t_max.x > self.longest_type then self.longest_type = t_max.x end
            if v_max.x > self.longest_value then self.longest_value = v_max.x end
            -- Set size
            self.line_sizes[index] = {
                key = {min = k_min, max = k_max, caret = k_caret},
                type = {min = t_min, max = t_max, caret = t_caret},
                value = {min = v_min, max = v_max, caret = v_caret},
            }
        end
        -- Update available value
        self.available_value = self._frame_size_inner[1] - self.longest_key - self.longest_type - self.longest_value - 50
    end
end

Watcher.visible_rows = function(self)
    local frame_size = vector3_unbox(self._frame_size_inner) -- vector3(20, 20, 0)
    return math_floor(frame_size[2] / self.row_height)
end

Watcher.screen_size = function(self)
    return vector3(RESOLUTION_LOOKUP.width, RESOLUTION_LOOKUP.height, 0)
end

Watcher.scrollbar_height = function(self)
    local frame_size = vector3_unbox(self.frame_size) - vector3(20, 20, 0)
    return frame_size[2] * math_clamp(frame_size[2] / self:total_lines_height(), 0, 1)
end

Watcher.total_lines_height = function(self)
    return self.row_height * #self.lines
end

Watcher.cursor = function(self, input_service)
	return input_service and input_service:get("cursor") or vector3(0, 0, 0)
end

Watcher.held = function(self, input_service)
    return input_service and input_service:get("left_hold") or false
end

Watcher.pressed = function(self, input_service)
	return input_service and input_service:get("left_pressed") or false
end

Watcher.context_pressed = function(self, input_service)
    return input_service and input_service:get("right_pressed") or false
end

Watcher.scroll_axis = function(self, input_service)
    return input_service and input_service:get("scroll_axis") or vector3(0, 0, 0)
end

Watcher.shift_held = function(self)
    return mod:is_shift_held()
end

Watcher.ctrl_held = function(self)
    return mod:is_ctrl_held()
end

-- ##### ┬┌┐┌┌┬┐┌─┐┬─┐┌┐┌┌─┐┬    ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ################################################################
-- ##### ││││ │ ├┤ ├┬┘│││├─┤│    │││├┤  │ ├─┤│ │ ││└─┐ ################################################################
-- ##### ┴┘└┘ ┴ └─┘┴└─┘└┘┴ ┴┴─┘  ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ################################################################

Watcher.open_context_menu = function(self, line, position)
    self.context_menu.line = line
    self.context_menu.position:store(position[1], position[2], position[3])
    self._context_menu_position = position
    self.context_menu.visible = true
    self:context_shown()
end

Watcher.close_context_menu = function(self)
    self.context_menu.visible = false
    self.context_menu.hover = false
    self:context_hidden()
end

Watcher.select = function(self, lines)
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

Watcher.unselect = function(self)
    self.selection.active = false
    table_clear(self.selection.lines)
end

Watcher.inspect_selection = function(self)
    for line, _ in pairs(self.selection.lines) do
        if line.is_table then
            self:inspect_table(line.key, line.table[line.obj_key])
        end
    end
end

Watcher.inspect_table = function(self, key, table)
    mod:inspect(key, table)
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

Watcher.remove_selection = function(self)
    for line, _ in pairs(self.selection.lines) do
        self.selection.lines[line] = nil
        self:remove(line.key)
    end
end

Watcher.remove = function(self, key)
    for index, line in pairs(self.lines) do
        if line.key == key then
            self.lines[index] = nil
            self:changed()
            break
        end
    end
    self.last_line = #self.lines > 0 and self.lines[#self.lines]
end

Watcher.watch = function(self, key, table, obj_key, text_pattern)
    local line_key = self.mod and self.mod.get_name and self.mod:get_name().."> "..tostring(key) or tostring(key)
    if self.last_line and line_key == self.last_line.key then
        local count = self.lines[#self.lines].count or 1
        self.lines[#self.lines].count = count + 1
        self:changed()
    else
        self.lines[#self.lines + 1] = {
            table = table,
            key = line_key,
            obj_key = obj_key,
            is_table = type(table[obj_key]) == "table",
            text_pattern = text_pattern,
            start = 1,
        }
        self.last_line = self.lines[#self.lines]
        self:changed()
    end
end

Watcher.toggle = function(self)
    self:show(not self.visible)
end

Watcher.show = function(self, show)
    self.visible = show
    if show then self:shown() end
    if not show then self:hidden() end
    mod:push_or_pop_cursor(self, "modding_tools_watcher")
end

Watcher.set_mod = function(self, mod)
    self.mod = mod
end

Watcher.clear = function(self)
    table_clear(self.lines)
    self.last_line = nil
end

return Watcher