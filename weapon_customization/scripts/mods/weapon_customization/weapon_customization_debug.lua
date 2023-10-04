local mod = get_mod("weapon_customization")

mod.reposition = {0, 0, 0}
mod.rerotate = {0, 0, 0}

mod.last_attachment_units = {}
mod.debug_item_name = ""
mod.debug_selected_unit = {}
mod.new_units = {}
mod.test_index = 1

mod.reposition_x_neg = function()
	mod.reposition[1] = mod.reposition[1] - 0.01
	mod:reposition_attachments()
end
mod.reposition_x_pos = function()
	mod.reposition[1] = mod.reposition[1] + 0.01
	mod:reposition_attachments()
end
mod.reposition_y_neg = function()
	mod.reposition[2] = mod.reposition[2] - 0.01
	mod:reposition_attachments()
end
mod.reposition_y_pos = function()
	mod.reposition[2] = mod.reposition[2] + 0.01
	mod:reposition_attachments()
end
mod.reposition_z_neg = function()
	mod.reposition[3] = mod.reposition[3] - 0.01
	mod:reposition_attachments()
end
mod.reposition_z_pos = function()
	mod.reposition[3] = mod.reposition[3] + 0.01
	mod:reposition_attachments()
end

mod.rerotate_x_neg = function()
	mod.rerotate[1] = mod.rerotate[1] - 1
	mod:reposition_attachments()
end
mod.rerotate_x_pos = function()
	mod.rerotate[1] = mod.rerotate[1] + 1
	mod:reposition_attachments()
end
mod.rerotate_y_neg = function()
	mod.rerotate[2] = mod.rerotate[2] - 1
	mod:reposition_attachments()
end
mod.rerotate_y_pos = function()
	mod.rerotate[2] = mod.rerotate[2] + 1
	mod:reposition_attachments()
end
mod.rerotate_z_neg = function()
	mod.rerotate[3] = mod.rerotate[3] - 1
	mod:reposition_attachments()
end
mod.rerotate_z_pos = function()
	mod.rerotate[3] = mod.rerotate[3] + 1
	mod:reposition_attachments()
end
mod.inc_test_index = function()
	mod.test_index = mod.test_index + 1
	mod:echo(tostring(mod.test_index))
end

--  Debug
mod._debug = mod:get("mod_option_debug")
mod._debug_skip_some = true

-- Debug print
mod.print = function(self, message, skip)
	if self._debug and not skip then self:echo(message) end
end

mod.reposition_attachments = function(self)
	if #self.debug_selected_unit > 0 then
		for _, unit in pairs(self.debug_selected_unit) do
			if unit and Unit.alive(unit) then
				local unit_name = Unit.debug_name(unit)
				local attachment = self.attachment_units[unit_name]
				if attachment then
					local anchor = self.anchors[self.debug_item_name][attachment]
					local position = Vector3(0, 0, 0)
					local rotation_euler = Vector3(0, 0, 0)
					if anchor then
						position = Vector3Box.unbox(anchor.position)
						rotation_euler = Vector3Box.unbox(anchor.rotation)
					end
					
					position[1] = position[1] + self.reposition[1]
					position[2] = position[2] + self.reposition[2]
					position[3] = position[3] + self.reposition[3]
					Unit.set_local_position(unit, 1, position)
					self:echo("position:"..tostring(position))

					rotation_euler[1] = rotation_euler[1] + self.rerotate[1]
					rotation_euler[2] = rotation_euler[2] + self.rerotate[2]
					rotation_euler[3] = rotation_euler[3] + self.rerotate[3]
					local rotation = Quaternion.from_euler_angles_xyz(rotation_euler[1], rotation_euler[2], rotation_euler[3])
					Unit.set_local_rotation(unit, 1, rotation)
					self:echo("rotation:"..tostring(rotation_euler))

				else
					self:echo("attachment nil")
				end
			else
				self:echo("debug unit nil")
			end
		end
	else
		self:echo("debug units 0")
	end
end

mod.debug_attachments = function(self, item_data, attachments, weapon_name_or_table, overwrite, full, depth)
    if item_data then
		local time = overwrite and "" or Managers.time:time("main")
        local item_name = self:item_name_from_content_string(item_data.name)
		local debug = full and item_data or attachments
		local file_name = full and "item_data" or "attachments"
		local depth = depth or 10
		if type(weapon_name_or_table) == "string" then
			if item_name == weapon_name_or_table then
				self:dtf(debug, file_name.."_"..item_name.."_"..tostring(time), 10)
			end
		elseif type(weapon_name_or_table) == "table" then
			for _, weapon_name in pairs(weapon_name_or_table) do
				if item_name == weapon_name then
					self:dtf(debug, file_name.."_"..item_name.."_"..tostring(time), 10)
				end
			end
		end
    end
end
