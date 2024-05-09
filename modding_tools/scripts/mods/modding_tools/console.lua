local mod = get_mod("weapon_customization")

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
    local math = math
    local class = class
    local pairs = pairs
    local Color = Color
    local CLASS = CLASS
    local vector3 = Vector3
    local tostring = tostring
    local vector3_box = Vector3Box
    local Application = Application
    local DevParameters = DevParameters
    local quaternion_box = QuaternionBox
    local vector3_unbox = vector3_box.unbox
    local RESOLUTION_LOOKUP = RESOLUTION_LOOKUP
    local quaternion_unbox = quaternion_box.unbox
--#endregion

local Console = class("Console")

Console.init = function(self, extension_init_data)
    self.gui = extension_init_data.gui
    self.lines = {} --extension_init_data.lines or {}
    self.scroll = extension_init_data.scroll or 0
    self.background = extension_init_data.background or quaternion_box(Color(128, 0, 0, 0))
    self.hover_background = extension_init_data.hover_background or quaternion_box(Color(200, 0, 0, 0))
    self.color = extension_init_data.color or quaternion_box(Color.white())
    self.shadow = extension_init_data.shadow or quaternion_box(Color.gray())
    self.z = extension_init_data.z or 100
    self.height = extension_init_data.height or 300
    self.carret = extension_init_data.carret or {0, 0}
    self.visible = extension_init_data.visible or true
    local lines = extension_init_data.lines or {}
    for _, line in pairs(lines) do
        self:print(line)
    end
    self.last_line = #self.lines > 0 and self.lines[#self.lines] or nil
end

Console.destroy = function(self)
    
end

Console.cursor = function(self, input_service)
	return input_service and input_service:get("cursor") or vector3(0, 0, 0)
end

Console.clear = function(self)
    self.lines = {}
    self.last_line = nil
end

Console.update = function(self, dt, t, input_service)
    if self.visible then self:draw() end
end

Console.print = function(self, line)
    if self.last_line and line == self.last_line.text then
        local count = self.lines[#self.lines].count or 1
        self.lines[#self.lines].count = count + 1
    else
        self.lines[#self.lines + 1] = {
            text = line,
        }
        self.last_line = self.lines[#self.lines]
    end
end

Console.draw = function(self)
    self:draw_frame()
    self:draw_lines()
end

Console.draw_frame = function(self)
    local RES_X, RES_Y = Application.back_buffer_size()
    local screen_width = RESOLUTION_LOOKUP.width
	local screen_height = RESOLUTION_LOOKUP.height
    self.hover = math.point_is_inside_2d_box(self:cursor(), vector3(0, self.height, 0), vector3(screen_width, 0))
    local color = self.hover and quaternion_unbox(self.hover_background) or quaternion_unbox(self.background)
    ScriptGui.icrect(self.gui, RES_X, RES_Y, 0, 0, screen_width, self.height, self.z, color)
end

Console.draw_lines = function(self)
    for line_nr, line in pairs(self.lines) do
        self:draw_line(line, line_nr)
    end
end

Console.draw_line = function(self, line, line_nr)
    local count = line.count and "("..tostring(line.count)..") " or ""
    ScriptGui.text(self.gui, count..line.text, DevParameters.debug_text_font, 14, vector3(10, 10 + 16 * (line_nr - 1), self.z), quaternion_unbox(self.color), quaternion_unbox(self.shadow))
end

return Console