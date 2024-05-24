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
	local Unit = Unit
	local math = math
	local Color = Color
	local class = class
	local pairs = pairs
	local table = table
	local Camera = Camera
	local vector2 = Vector2
	local vector3 = Vector3
	local tostring = tostring
	local Managers = Managers
	local Matrix4x4 = Matrix4x4
	local table_enum = table.enum
	local Quaternion = Quaternion
	local unit_alive = Unit.alive
	local vector3_box = Vector3Box
	local Application = Application
	local unit_set_data = Unit.set_data
	local unit_get_data = Unit.get_data
	local quaternion_up = Quaternion.up
	local DevParameters = DevParameters
	local quaternion_box = QuaternionBox
	local vector3_unbox = vector3_box.unbox
	local quaternion_right = Quaternion.right
	local unit_local_scale = Unit.local_scale
	local unit_world_scale = Unit.world_scale
	local quaternion_unbox = QuaternionBox.unbox
	local quaternion_forward = Quaternion.forward
	local unit_local_position = Unit.local_position
	local unit_local_rotation = Unit.local_rotation
	local unit_world_rotation = Unit.world_rotation
	local unit_world_position = Unit.world_position
	local matrix4x4_transform = Matrix4x4.transform
	local quaternion_multiply = Quaternion.multiply
	local quaternion_identity = Quaternion.identity
	local unit_set_local_scale = Unit.set_local_scale
	local quaternion_matrix4x4 = Quaternion.matrix4x4
	local camera_world_rotation = Camera.world_rotation
    local camera_world_position = Camera.world_position
	local camera_world_to_screen = Camera.world_to_screen
	local unit_set_local_position = Unit.set_local_position
    local unit_set_local_rotation = Unit.set_local_rotation
	local quaternion_from_euler_angles_xyz = Quaternion.from_euler_angles_xyz
	local quaternion_to_euler_angles_xyz = Quaternion.to_euler_angles_xyz
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local LINE_THICKNESS = 2
	local LINE_Z = 100
	local MANIPULATION_MODES = table_enum("POSITION", "ROTATION", "SCALE")
	local SHOW_BUTTONS = true
	local BUTTON_SIZE = {50, 50}
	local BUTTON_MARGIN = {5, 5}
	local SHOW_INFO = true
	local buttons = {
		{x = 0, x2 = 0, text = "<", value = "button_revert"},
		{x = 0, x2 = 0, text = "P", value = "button_move", 	 mode = MANIPULATION_MODES.POSITION, symbol_func = "draw_position_symbol", active = true},
		{x = 0, x2 = 0, text = "R", value = "button_rotate", mode = MANIPULATION_MODES.ROTATION, symbol_func = "draw_rotation_symbol"},
		{x = 0, x2 = 0, text = "S", value = "button_scale",  mode = MANIPULATION_MODES.SCALE,	 symbol_func = "draw_scale_symbol"},
		{x = 0, x2 = 0, text = ">", value = "button_redo"},
		{x = 0, x2 = 0, text = "X", value = "button_deselect"},
	}
	local inputs = {
		{value = "position_x", add = {true, false, false}, type = "position", diff_multiplier = .002},
		{value = "position_y", add = {false, true, false}, type = "position", diff_multiplier = .002},
		{value = "position_z", add = {false, false, true}, type = "position", diff_multiplier = .002},
		{value = "rotation_x", add = {false, false, true}, type = "rotation"},
		{value = "rotation_y", add = {true, false, false}, type = "rotation"},
		{value = "rotation_z", add = {false, true, false}, type = "rotation"},
	}
--#endregion

-- ##### ┬ ┬┌┐┌┬┌┬┐  ┌┬┐┌─┐┌┐┌┬┌─┐┬ ┬┬  ┌─┐┌┬┐┬┌─┐┌┐┌  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ #####################################
-- ##### │ │││││ │   │││├─┤││││├─┘│ ││  ├─┤ │ ││ ││││  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ #####################################
-- ##### └─┘┘└┘┴ ┴   ┴ ┴┴ ┴┘└┘┴┴  └─┘┴─┘┴ ┴ ┴ ┴└─┘┘└┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ #####################################

local UnitManipulationExtension = class("UnitManipulationExtension")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

UnitManipulationExtension.init = function(self, extension_init_context, unit, extension_init_data)
	self.unit = unit
	self.node = extension_init_data.node or 1
	self.font_size = extension_init_data.font_size or 14
	self.gui = extension_init_data.gui
	self.camera = extension_init_data.camera
	self.faded_alpha = extension_init_data.faded_alpha or 128
	self.faded_color = extension_init_data.faded_color or 255
	self.position_tolerance = extension_init_data.position_tolerance or .02
	self.rotation_tolerance = extension_init_data.rotation_tolerance or 10
	self.show = true
	self.name = extension_init_data.name or "<NO NAME PROVIDED>"
	self.angle_names = extension_init_data.angle_names or true
	self.mode = extension_init_data.mode or MANIPULATION_MODES.POSITION
	self.tm, self.half_size = Unit.box(unit)
	self.original_position = vector3_box(unit_local_position(unit, self.node))
	self.original_rotation = quaternion_box(unit_local_rotation(unit, self.node))
	self.original_scale = vector3_box(unit_local_scale(unit, self.node))
	self.root_unit = extension_init_data.root_unit
	self.button = extension_init_data.button
	self.pressed_callback = extension_init_data.pressed_callback
	self.changed_callback = extension_init_data.changed_callback
	self.selected = false
	self.history = {}
	self.history_index = 1
	self.position_points = nil
	self.rotation_points = nil
	self.held_cursor = nil
	self.position_x = nil
	self.position_y = nil
	self.position_z = nil
	self.rotation_x = nil
	self.rotation_y = nil
	self.rotation_z = nil
	self.button_move = nil
	self.button_rotate = nil
	self.button_scale = nil
	self.initialized = true
	self:add_history()
end

UnitManipulationExtension.delete = function(self)
	self.initialized = false
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

UnitManipulationExtension.update = function(self, dt, t, input_service)
	if self.initialized and self.unit and unit_alive(self.unit) then
		if self.selected and self.show then
			self:draw_box(dt, t, input_service)
			if SHOW_BUTTONS then self:draw_buttons(dt, t, input_service) end
			if SHOW_INFO then self:draw_info(dt, t, input_service) end
			if self.mode == MANIPULATION_MODES.POSITION then self:draw_position_gizmo(dt, t, input_service)
			elseif self.mode == MANIPULATION_MODES.ROTATION then self:draw_rotation_gizmo(dt, t, input_service)
			elseif self.mode == MANIPULATION_MODES.SCALE then self:draw_position_gizmo(dt, t, input_service) end
		elseif self.show then
			self:draw_selector(dt, t, input_service)
		end
		self:update_controls(dt, t, input_service)
	end
end

UnitManipulationExtension.update_controls = function(self, dt, t, input_service, all)
	if self.held_cursor and self.unit and unit_alive(self.unit) then
		local rotation = unit_local_rotation(self.unit, self.node)

		local position_offset = unit_get_data(self.unit, "unit_manipulation_position_offset")
		position_offset = position_offset and vector3_unbox(position_offset) or vector3(0, 0, 0)

		local rotation_offset = unit_get_data(self.unit, "unit_manipulation_rotation_offset")
		rotation_offset = rotation_offset and quaternion_unbox(rotation_offset) or quaternion_identity()

		local scale_offset = unit_get_data(self.unit, "unit_manipulation_scale_offset")
		scale_offset = scale_offset and vector3_unbox(scale_offset) or vector3(0, 0, 0)

		local cursor = self:cursor(input_service)
		local diff_vector = (cursor - vector3_unbox(self.held_cursor))
		local diff = (diff_vector[1] + diff_vector[2])
		for _, input in pairs(inputs) do
			if self[input.value] or all then
				self.something_was_active = true
				local x = input.add[1] and diff * (input.diff_multiplier or 1)
				local y = input.add[2] and diff * (input.diff_multiplier or 1)
				local z = input.add[3] and diff * (input.diff_multiplier or 1)
				if input.type == "position" or all then
					if self.mode == MANIPULATION_MODES.POSITION or all then
						-- Position
						local add_offset = self:orient_to(vector3(x, y, z), rotation)
						local offset = position_offset + add_offset
						self:position_unit(offset)
					end
					if self.mode == MANIPULATION_MODES.SCALE or all then
						-- Scale
						local offset = scale_offset + vector3(x, y, z)
						self:scale_unit(offset)
					end
				end
				if input.type == "rotation" or all then
					-- Rotation
					local offset = Quaternion.multiply(rotation_offset, quaternion_from_euler_angles_xyz(x, y, z))
					self:rotate_unit(offset)
				end
				if self.changed_callback and type(self.changed_callback) == "function" then
					self.changed_callback(self)
				end
			end
		end
		if not self:hold(input_service) then
			self.held_cursor = nil
			if self.something_was_active then self:add_history() end
			self.something_was_active = false
		else
			self.held_cursor = vector3_box(cursor)
		end
	end
end

UnitManipulationExtension.position_unit = function(self, offset)
	unit_set_local_position(self.unit, self.mode, vector3_unbox(self.original_position) + offset)
	unit_set_data(self.unit, "unit_manipulation_position_offset", vector3_box(offset))
end

UnitManipulationExtension.rotate_unit = function(self, offset)
	local new_rotation = Quaternion.multiply(quaternion_unbox(self.original_rotation), offset)
	unit_set_local_rotation(self.unit, self.mode, new_rotation)
	unit_set_data(self.unit, "unit_manipulation_rotation_offset", quaternion_box(offset))
end

UnitManipulationExtension.scale_unit = function(self, offset)
	unit_set_local_scale(self.unit, self.mode, vector3_unbox(self.original_scale) + offset)
	unit_set_data(self.unit, "unit_manipulation_scale_offset", vector3_box(offset))
end

-- ##### ┬ ┬┬┌─┐┌┬┐┌─┐┬─┐┬ ┬ ##########################################################################################
-- ##### ├─┤│└─┐ │ │ │├┬┘└┬┘ ##########################################################################################
-- ##### ┴ ┴┴└─┘ ┴ └─┘┴└─ ┴  ##########################################################################################

UnitManipulationExtension.restore_history = function(self)
	if self.history and #self.history >= self.history_index then
		local history_entry = self.history[self.history_index]
		if self.unit and unit_alive(self.unit) then
			self:position_unit(vector3_unbox(history_entry.position_offset))
			self:rotate_unit(quaternion_unbox(history_entry.rotation_offset))
			self:scale_unit(vector3_unbox(history_entry.scale_offset))
		end
	end
end

UnitManipulationExtension.back_history = function(self)
	if self.history_index > 1 then
		self.history_index = self.history_index - 1
		self:restore_history()
	end
end

UnitManipulationExtension.forward_history = function(self)
	if self.history_index < #self.history then
		self.history_index = self.history_index + 1
		self:restore_history()
	end
end

UnitManipulationExtension.add_history = function(self)
	if #self.history > 0 and self.history_index < #self.history then
		for i = #self.history, self.history_index + 1, -1 do
			self.history[i] = nil
		end
	end
	if self.unit and unit_alive(self.unit) then
		self.history[#self.history + 1] = {
			position_offset = unit_get_data(self.unit, "unit_manipulation_position_offset") or vector3_box(vector3(0, 0, 0)),
			rotation_offset = unit_get_data(self.unit, "unit_manipulation_rotation_offset") or quaternion_box(quaternion_identity()),
			scale_offset = unit_get_data(self.unit, "unit_manipulation_scale_offset") or vector3_box(vector3(0, 0, 0)),
		}
	end
	self.history_index = #self.history
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

UnitManipulationExtension.is_busy = function(self)
	return self:already_collided()
end

UnitManipulationExtension.cursor = function(self, input_service)
	return input_service and input_service:get("cursor") or vector3(0, 0, 0)
end

UnitManipulationExtension.hold = function(self, input_service)
	return input_service and input_service:get("left_hold") or false
end

UnitManipulationExtension.pressed = function(self, input_service)
	return input_service and input_service:get("left_pressed") or false
end

UnitManipulationExtension.already_collided = function(self, input_service)
	return self.position_x or self.position_y or self.position_z or self.rotation_x or self.rotation_y or self.rotation_z
end

UnitManipulationExtension.orient_to = function(self, position, rotation)
	local mat = quaternion_matrix4x4(rotation)
    return matrix4x4_transform(mat, position)
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

UnitManipulationExtension.set_selected = function(self, selected)
	self.selected = selected
end

UnitManipulationExtension.set_cursor = function(self, cursor)
	if not self.held_cursor and cursor then
		self.held_cursor = cursor
	end
end

UnitManipulationExtension.change_mode = function(self, mode)
	self.mode = mode
end

UnitManipulationExtension.activate_button_by_index = function(self, button)
	buttons[button].active = true
end

UnitManipulationExtension.deactivate_buttons = function(self)
	for _, button in pairs(buttons) do button.active = false end
end

-- ##### ┌┬┐┬─┐┌─┐┬ ┬  ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ######################################################################
-- #####  ││├┬┘├─┤│││  ├┤ │ │││││   │ ││ ││││└─┐ ######################################################################
-- ##### ─┴┘┴└─┴ ┴└┴┘  └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ######################################################################

-- Draw rotation symbol
UnitManipulationExtension.draw_rotation_symbol = function(self, dt, t, input_service, position)
	local size = vector3(BUTTON_SIZE[1] - 25, BUTTON_SIZE[2] - 25, 0)
	for i = 0, 360 do
        local angle = math.rad(i)
        local cx = position[1] + BUTTON_SIZE[1] / 2 + math.cos(angle) * (size[1] / 2)
        local cy = position[2] + BUTTON_SIZE[2] / 2 + math.sin(angle) * (size[2] / 2)
		ScriptGui.hud_line(self.gui, vector3(cx, cy, LINE_Z), vector3(cx+1, cy+1, LINE_Z), LINE_Z+1, LINE_THICKNESS, Color.black())
    end
	local cx = position[1] + BUTTON_SIZE[1] / 2 + math.cos(270) * (size[1] / 2)
	local cy = position[2] + BUTTON_SIZE[2] / 2 + math.sin(270) * (size[2] / 2)
	ScriptGui.hud_line(self.gui, vector3(cx-1, cy+8, LINE_Z), vector3(cx+8, cy, LINE_Z), LINE_Z+1, LINE_THICKNESS, Color.black())
	ScriptGui.hud_line(self.gui, vector3(cx-1, cy+8, LINE_Z), vector3(cx-8, cy, LINE_Z), LINE_Z+1, LINE_THICKNESS, Color.black())
	local cx = position[1] + BUTTON_SIZE[1] / 2 + math.cos(90) * (size[1] / 2)
	local cy = position[2] + BUTTON_SIZE[2] / 2 + math.sin(90) * (size[2] / 2)
	ScriptGui.hud_line(self.gui, vector3(cx-6, cy-14, LINE_Z), vector3(cx+2, cy-4, LINE_Z), LINE_Z+1, LINE_THICKNESS, Color.black())
	ScriptGui.hud_line(self.gui, vector3(cx-6, cy-14, LINE_Z), vector3(cx-14, cy-4, LINE_Z), LINE_Z+1, LINE_THICKNESS, Color.black())
end

-- Draw position symbol
UnitManipulationExtension.draw_position_symbol = function(self, dt, t, input_service, position)
	local size = vector3(BUTTON_SIZE[1] - 20, BUTTON_SIZE[2] - 20, 0)
	local cx = position[1] + BUTTON_SIZE[1] / 2 - 5
	local cy = position[2] + BUTTON_SIZE[2] / 2
	-- Center line
	ScriptGui.hud_line(self.gui, vector3(cx, cy, LINE_Z), vector3(cx, cy-size[2]/2, LINE_Z), LINE_Z+1, LINE_THICKNESS, Color.black())
	-- Arrow up
	ScriptGui.hud_line(self.gui, vector3(cx+2, cy-size[2]/2, LINE_Z), vector3(cx+2-8, cy-size[2]/2+8, LINE_Z), LINE_Z+1, LINE_THICKNESS, Color.black())
	ScriptGui.hud_line(self.gui, vector3(cx+2, cy-size[2]/2, LINE_Z), vector3(cx+2+8, cy-size[2]/2+8, LINE_Z), LINE_Z+1, LINE_THICKNESS, Color.black())
	-- Right line
	ScriptGui.hud_line(self.gui, vector3(cx+1, cy, LINE_Z), vector3(cx+22, cy+15, LINE_Z), LINE_Z+1, LINE_THICKNESS, Color.black())
	-- Arrow right
	ScriptGui.hud_line(self.gui, vector3(cx+20, cy+16, LINE_Z), vector3(cx+20-12, cy+16, LINE_Z), LINE_Z+1, LINE_THICKNESS, Color.black())
	ScriptGui.hud_line(self.gui, vector3(cx+20, cy+16, LINE_Z), vector3(cx+20-4, cy+16-12, LINE_Z), LINE_Z+1, LINE_THICKNESS, Color.black())
	-- Left line
	ScriptGui.hud_line(self.gui, vector3(cx+1, cy, LINE_Z), vector3(cx-10, cy+16, LINE_Z), LINE_Z+1, LINE_THICKNESS, Color.black())
	-- Arrow left
	ScriptGui.hud_line(self.gui, vector3(cx-12, cy+14, LINE_Z), vector3(cx-12, cy+14-12, LINE_Z), LINE_Z+1, LINE_THICKNESS, Color.black())
	ScriptGui.hud_line(self.gui, vector3(cx-12, cy+14, LINE_Z), vector3(cx-12+12, cy+14, LINE_Z), LINE_Z+1, LINE_THICKNESS, Color.black())
end

-- Draw scale symbol
UnitManipulationExtension.draw_scale_symbol = function(self, dt, t, input_service, position)
	local size = vector3(BUTTON_SIZE[1] - 20, BUTTON_SIZE[2] - 20, 0)
	local cx = position[1] + BUTTON_SIZE[1] / 2 - size[1] / 2
	local cy = position[2] + BUTTON_SIZE[2] / 2 - size[2] / 2
	-- Center line
	ScriptGui.hud_line(self.gui, vector3(cx+size[1]/2, cy+4, LINE_Z), vector3(cx+size[1]/2, cy+size[2]-3, LINE_Z), LINE_Z+1, LINE_THICKNESS, Color.black())
	-- Top line
	ScriptGui.hud_line(self.gui, vector3(cx+5, cy, LINE_Z), vector3(cx+size[1]-5, cy, LINE_Z), LINE_Z+1, LINE_THICKNESS, Color.black())
	-- Bottom line
	ScriptGui.hud_line(self.gui, vector3(cx+5, cy+size[2], LINE_Z), vector3(cx+size[1]-5, cy+size[2], LINE_Z), LINE_Z+1, LINE_THICKNESS, Color.black())
	-- Arrow up
	ScriptGui.hud_line(self.gui, vector3(cx+size[1]/2, cy+4, LINE_Z), vector3(cx+size[1]/2-8, cy+4+8, LINE_Z), LINE_Z+1, LINE_THICKNESS, Color.black())
	ScriptGui.hud_line(self.gui, vector3(cx+size[1]/2, cy+4, LINE_Z), vector3(cx+size[1]/2+8, cy+4+8, LINE_Z), LINE_Z+1, LINE_THICKNESS, Color.black())
	-- Arrow down
	ScriptGui.hud_line(self.gui, vector3(cx+size[1]/2-2, cy+size[2]-3, LINE_Z), vector3(cx+size[1]/2-8-2, cy+size[2]-3-8, LINE_Z), LINE_Z+1, LINE_THICKNESS, Color.black())
	ScriptGui.hud_line(self.gui, vector3(cx+size[1]/2-2, cy+size[2]-3, LINE_Z), vector3(cx+size[1]/2+8-2, cy+size[2]-3-8, LINE_Z), LINE_Z+1, LINE_THICKNESS, Color.black())
end

-- Draw selector for extension unit
UnitManipulationExtension.draw_selector = function(self, dt, t, input_service, position)
	if self.name and self.unit and unit_alive(self.unit) then
		local position = unit_world_position(self.unit, self.node)
		local direction = self.root_unit and vector3.normalize(position - unit_world_position(self.root_unit, 1)) or vector3(0, 0, 0)
		local position_2d = camera_world_to_screen(self.camera, position + direction * .05)
		-- local attachment_slot = unit_get_data(self.unit, "attachment_slot")
		local RES_X, RES_Y = Application.back_buffer_size()
		local min, max, caret = Gui.text_extents(self.gui, self.name, DevParameters.debug_text_font, self.font_size)
		local size = vector3(max[1], max[2]+2, 1)
		ScriptGui.icrect(self.gui, RES_X, RES_Y, position_2d[1], position_2d[2] + max[2]+2, position_2d[1] + max[1], position_2d[2], 99, Color(128, 255, 255, 255))
		ScriptGui.text(self.gui, self.name, DevParameters.debug_text_font, self.font_size, position_2d, Color.black(), Color.gray())
		local cursor = self:cursor(input_service)
		local hover = math.point_is_inside_2d_box(cursor, position_2d, size)
		if self:pressed(input_service) and hover then
			if not self.button then
				mod:unit_manipulation_select(self.unit)
			elseif self.pressed_callback and type(self.pressed_callback) == "function" then
				self.pressed_callback(self)
			end
		end
	end
end

-- Draw info panel with global and local position, rotation, scale
UnitManipulationExtension.draw_info = function(self, dt, t, input_service)
	if self.unit and unit_alive(self.unit) then
		local position = unit_world_position(self.unit, self.node)
		local rotation = unit_world_rotation(self.unit, self.node)
		local x, y, z = quaternion_to_euler_angles_xyz(rotation)
		rotation = vector3(x, y, z)
		local local_position = unit_local_position(self.unit, self.node)
		local local_rotation = unit_local_rotation(self.unit, self.node)
		local x, y, z = quaternion_to_euler_angles_xyz(local_rotation)
		local_rotation = vector3(x, y, z)
		local position_2d = camera_world_to_screen(self.camera, position)
		local offset = position_2d + vector3(200, 180, 0)
		local scale = unit_world_scale(self.unit, self.node)
		local local_scale = unit_local_scale(self.unit, self.node)
		local lines = {
			{text = "Scale "..tostring(scale)},
			{text = "Rotation "..tostring(rotation)},
			{text = "Position "..tostring(position)},
			{text = "World"},
			{text = "Scale "..tostring(local_scale)},
			{text = "Rotation "..tostring(local_rotation)},
			{text = "Position "..tostring(local_position)},
			{text = "Local"},
		}
		local RES_X, RES_Y = Application.back_buffer_size()
		ScriptGui.icrect(self.gui, RES_X, RES_Y, offset[1], offset[2] + 10, offset[1] + 350, offset[2] - 140, 99, Color(128, 255, 255, 255))
		for i, line in pairs(lines) do
			ScriptGui.text(self.gui, line.text, DevParameters.debug_text_font, 14, vector3(offset[1] + 15, offset[2] - 16 * i, LINE_Z), Color.black(), Color.gray())
		end
	end
end

-- Draw button panel with history and mode buttons
UnitManipulationExtension.draw_buttons = function(self, dt, t, input_service)
	if self.unit and unit_alive(self.unit) then
		local position = unit_world_position(self.unit, self.node)
		local position_2d = camera_world_to_screen(self.camera, position)
		local offset = position_2d + vector3(200, 200, 0)
		local cursor = self:cursor(input_service)
		local RES_X, RES_Y = Application.back_buffer_size()
		for i, button in pairs(buttons) do
			button.x = offset[1] + ((BUTTON_SIZE[1] + BUTTON_MARGIN[1]) * (i - 1))
			button.x2 = offset[1] + ((BUTTON_SIZE[2] + BUTTON_MARGIN[2]) * (i - 1)) + BUTTON_SIZE[2]
		end
		for i, button in pairs(buttons) do
			if not self:already_collided(input_service) then
				self[button.value] = math.point_is_inside_2d_box(cursor, vector2(button.x, offset[2]), vector2(BUTTON_SIZE[1], BUTTON_SIZE[2]))
			end
			if self:pressed(input_service) and self[button.value] then
				if button.mode then
					self:change_mode(button.mode)
					self:deactivate_buttons()
					self:activate_button_by_index(i)
				elseif button.value == "button_revert" then
					self:back_history()
				elseif button.value == "button_redo" then
					self:forward_history()
				elseif button.value == "button_deselect" then
					self:set_selected(false)
				end
			end
			local color = self[button.value] and Color.white() or Color(255, 200, 200, 200)
			color = button.active and Color(255, 128, 255, 128) or color
			ScriptGui.icrect(self.gui, RES_X, RES_Y, button.x, offset[2], button.x2, offset[2] + BUTTON_SIZE[2], LINE_Z, color)
			if button.symbol_func and self[button.symbol_func] then
				self[button.symbol_func](self, dt, t, input_service, vector3(button.x, offset[2], LINE_Z))
			else
				ScriptGui.text(self.gui, button.text, DevParameters.debug_text_font, 30, vector3(button.x + 15, offset[2] + 10, LINE_Z), Color.black(), Color.gray())
			end
		end
	end
end

-- Draw 3d box around unit
UnitManipulationExtension.draw_box = function(self, dt, t, input_service)
	if self.unit and unit_alive(self.unit) then
		local tm, half_size = Unit.box(self.unit)
		-- Get boundary points
		local points = {
			bottom_01 = {vec = {true, true, false}}, bottom_02 = {vec = {true, false, false}},
			bottom_03 = {vec = {false, false, false}}, bottom_04 = {vec = {false, true, false}},
			top_01 = {vec = {true, true, true}}, top_02 = {vec = {true, false, true}},
			top_03 = {vec = {false, false, true}}, top_04 = {vec = {false, true, true}},
		}
		for name, data in pairs(points) do
			local position = vector3(
				data.vec[1] == true and half_size.x or -half_size.x,
				data.vec[2] == true and half_size.y or -half_size.y,
				data.vec[3] == true and half_size.z or -half_size.z
			)
			points[name].position = Matrix4x4.transform(tm, position)
		end
		-- Get position and distance to camera
		local results = {
			bottom_01 = {}, bottom_02 = {}, bottom_03 = {}, bottom_04 = {},
			top_01 = {}, top_02 = {}, top_03 = {}, top_04 = {},
		}
		for name, data in pairs(results) do
			results[name].position, results[name].distance = camera_world_to_screen(self.camera, points[name].position)
		end
		-- Farthest point from camera
		local farthest = nil
		local last = 0
		for name, data in pairs(results) do
			if data.distance > last then
				last = data.distance
				farthest = name
			end
		end
		local draw = {
			{a = "bottom_01", b = "bottom_02"}, {a = "bottom_01", b = "bottom_04"},
			{a = "bottom_02", b = "bottom_03"}, {a = "bottom_03", b = "bottom_04"},
			{a = "top_01", b = "bottom_01"}, {a = "top_02", b = "bottom_02"},
			{a = "top_03", b = "bottom_03"}, {a = "top_04", b = "bottom_04"},
			{a = "top_01", b = "top_02"}, {a = "top_01", b = "top_04"},
			{a = "top_02", b = "top_03"}, {a = "top_03", b = "top_04"},
		}
		for name, data in pairs(draw) do
			if farthest ~= data.a and farthest ~= data.b then
				ScriptGui.hud_line(self.gui, results[data.a].position, results[data.b].position, LINE_Z, LINE_THICKNESS, Color(255, 106, 121, 100))
			end
		end
	end
end

-- Draw position / scale gizmo at unit position
UnitManipulationExtension.draw_position_gizmo = function(self, dt, t, input_service)
	if self.unit and unit_alive(self.unit) then
		-- Unit data
		local position = unit_world_position(self.unit, self.node)
		local rotation = unit_world_rotation(self.unit, self.node)
		local cursor = self:cursor(input_service)
		local hold = self:hold(input_service)
		-- Get boundary points
		local points = {center = {}, X = {}, Y = {}, Z = {}}
		points.center.position = position
		points.X.position = position + quaternion_right(rotation) * .2
		points.Y.position = position + quaternion_forward(rotation) * .2
		points.Z.position = position + quaternion_up(rotation) * .2
		-- Get position and distance to camera
		local results = {center = {}, X = {}, Y = {}, Z = {}}
		results.center.position, results.center.distance = camera_world_to_screen(self.camera, points.center.position)
		results.X.position, results.X.distance = camera_world_to_screen(self.camera, points.X.position)
		results.Y.position, results.Y.distance = camera_world_to_screen(self.camera, points.Y.position)
		results.Z.position, results.Z.distance = camera_world_to_screen(self.camera, points.Z.position)
		local position_points = {
			{text = "X", position = results.X.position, value = "position_x", color = Color(255, 255, 0, 0), faded_color = Color(self.faded_alpha, self.faded_color, 0, 0)},
			{text = "Y", position = results.Y.position, value = "position_y", color = Color(255, 0, 255, 0), faded_color = Color(self.faded_alpha, 0, self.faded_color, 0)},
			{text = "Z", position = results.Z.position, value = "position_z", color = Color(255, 0, 0, 255), faded_color = Color(self.faded_alpha, 0, 0, self.faded_color)},
		}
		-- Iterate angles
		for _, angle in pairs(position_points) do
			-- Check cursor collision
			local distance_1 = math.distance_2d(results.center.position[1], results.center.position[2], angle.position[1], angle.position[2])
			local distance_2 = math.distance_2d(results.center.position[1], results.center.position[2], cursor.x, cursor.y)
			local distance_3 = math.distance_2d(angle.position[1], 			angle.position[2], 			cursor.x, cursor.y)
			-- Check controls
			if not hold then self[angle.value] = nil end
			if not hold and not self:already_collided(input_service) and not self[angle.value] then
				self[angle.value] = distance_2 + distance_3 <= distance_1 + distance_1 * self.position_tolerance or nil
			end
			if self[angle.value] and hold then self:set_cursor(vector3_box(cursor)) end
			-- Draw
			local color = self[angle.value] and angle.color or angle.faded_color
			ScriptGui.hud_line(self.gui, results.center.position, angle.position, LINE_Z, self[angle.value] and LINE_THICKNESS * 2 or LINE_THICKNESS, color)
			if self.angle_names then ScriptGui.text(self.gui, angle.text, DevParameters.debug_text_font, 16, angle.position, angle.color, Color.gray()) end
		end
	end
end

-- Draw rotation gizmo at unit position
UnitManipulationExtension.draw_rotation_gizmo = function(self, dt, t, input_service)
	if self.unit and unit_alive(self.unit) then
		-- Unit data
		local position = unit_world_position(self.unit, self.node)
		local rotation = unit_world_rotation(self.unit, self.node)
		local cursor = self:cursor(input_service)
		local hold = self:hold(input_service)
		-- Define angles
		local angles = {
			{direction = {false, false, true}, value = "rotation_x", dir_func = quaternion_right, text = "X",
				color = Color(255, 255, 0, 0), faded_color = Color(self.faded_alpha, self.faded_color, 0, 0)},
			{direction = {true, false, false}, value = "rotation_y", dir_func = quaternion_forward, text = "Y",
				color = Color(255, 0, 255, 0), faded_color = Color(self.faded_alpha, 0, self.faded_color, 0)},
			{direction = {false, true, false}, value = "rotation_z", dir_func = quaternion_up, text = "Z",
				color = Color(255, 0, 0, 255), faded_color = Color(self.faded_alpha, 0, 0, self.faded_color)},
		}
		-- Iterate angles
		for _, angle in pairs(angles) do
			-- Check controls
			if not hold then self[angle.value] = nil end
			-- Define points
			local point_list = {}
			for i = 1, 360, 1 do
				-- Define point
				local offset = quaternion_from_euler_angles_xyz(
					angle.direction[1] == true and i or 0,
					angle.direction[2] == true and i or 0,
					angle.direction[3] == true and i or 0
				)
				local new_rotation = quaternion_multiply(rotation, offset)
				local new_position = camera_world_to_screen(self.camera, position + angle.dir_func(new_rotation) * .2)
				point_list[#point_list + 1] = new_position
				-- Check cursor collision
				if not hold and not self:already_collided(input_service) and not self[angle.value] then
					local distance = math.distance_2d(new_position[1], new_position[2], cursor.x, cursor.y)
					self[angle.value] = distance <= self.rotation_tolerance or nil
				end
				if self[angle.value] and hold then self:set_cursor(vector3_box(cursor)) end
			end
			-- First previous is last point
			local previous = point_list[#point_list]
			-- Draw points
			for _, pos in pairs(point_list) do
				local color = self[angle.value] and angle.color or angle.faded_color
				ScriptGui.hud_line(self.gui, previous, pos, LINE_Z, self[angle.value] and LINE_THICKNESS * 2 or LINE_THICKNESS, color)
				previous = pos
			end
			if self.angle_names then
				local position = camera_world_to_screen(self.camera, position + angle.dir_func(rotation) * .2)
				ScriptGui.text(self.gui, angle.text, DevParameters.debug_text_font, 16, position, angle.color, Color.gray())
			end
		end
	end
end