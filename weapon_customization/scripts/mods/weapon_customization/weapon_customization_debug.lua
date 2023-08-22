local mod = get_mod("weapon_customization")

mod.current_attachment = nil
mod.reposition = {0, 0, 0}
mod.rerotate = {0, 0, 0}

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

mod.reposition_attachments = function(self)
	-- if mod.weapon_attachments[gear_id] then
	-- 	for index, attachment in pairs(mod.weapon_attachments[gear_id]) do
	
	for _, gear_attachment in pairs(self.weapon_attachments) do
		for _, reference_attachment in pairs(gear_attachment) do
			for _, attachment in pairs(reference_attachment) do
				if attachment and Unit.alive(attachment.attachment_unit) then
					if string.find(attachment.attachment_name, "blade_01") then
						-- mod:echo("package:"..package_name)
						mod.current_attachment = attachment
					end
				end
			end
		end
	end

	if mod.current_attachment then
		local attachment = mod.current_attachment
		if attachment.attachment_unit and Unit.alive(attachment.attachment_unit) then
			-- Managers.state.unit_spawner:mark_for_deletion(attachment_unit)
			-- mod:echo("delete unit:"..tostring(attachment_unit))
			local item_name = mod:item_name_from_content_string(attachment.item.name)
			local anchor = mod.anchors[item_name][attachment.attachment_name]
			local position = Vector3Box.unbox(anchor.third_person.position)
			position[1] = position[1] + mod.reposition[1]
			position[2] = position[2] + mod.reposition[2]
			position[3] = position[3] + mod.reposition[3]
			Unit.set_local_position(attachment.attachment_unit, 1, position)
			-- mod:echo("position:"..tostring(position))
			local rotation_euler = Vector3Box.unbox(anchor.third_person.rotation)
			rotation_euler[1] = rotation_euler[1] + mod.rerotate[1]
			rotation_euler[2] = rotation_euler[2] + mod.rerotate[2]
			rotation_euler[3] = rotation_euler[3] + mod.rerotate[3]
			local rotation = Quaternion.from_euler_angles_xyz(rotation_euler[1], rotation_euler[2], rotation_euler[3])
			Unit.set_local_rotation(attachment.attachment_unit, 1, rotation)
			-- mod:echo("rotation:"..tostring(rotation_euler))
		end
	end
	-- 	end
	-- end
end
