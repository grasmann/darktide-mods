local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local MasterItems = mod:original_require("scripts/backend/master_items")
local ScriptGui = mod:original_require("scripts/foundation/utilities/script_gui")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local script_gui_hud_line = ScriptGui.hud_line
    local Camera = Camera
    local camera_world_position = Camera.world_position
	local camera_world_to_screen = Camera.world_to_screen
	local camera_world_rotation = Camera.world_rotation
    local vector3 = Vector3
	local vector3_box = Vector3Box
	local vector3_unbox = vector3_box.unbox
	local vector3_zero = vector3.zero
	local vector3_lerp = vector3.lerp
    local vector2 = Vector2
    local matrix4x4_translation = Matrix4x4.translation
    local table = table
	local table_insert = table.insert
	local table_size = table.size
	local table_find = table.find
	local table_contains = table.contains
	local table_clone = table.clone
	local table_reverse = table.reverse
	local table_remove = table.remove
	local table_sort = table.sort
    local Color = Color
    local Unit = Unit
	local unit_get_data = Unit.get_data
	local unit_alive = Unit.alive
	local unit_set_local_position = Unit.set_local_position
	local unit_set_local_rotation = Unit.set_local_rotation
	local unit_set_local_scale = Unit.set_local_scale
	local unit_local_position = Unit.local_position
	local unit_local_rotation = Unit.local_rotation
	local unit_get_child_units = Unit.get_child_units
	local unit_num_meshes = Unit.num_meshes
	local unit_set_mesh_visibility = Unit.set_mesh_visibility
	local unit_set_unit_visibility = Unit.set_unit_visibility
	local unit_debug_name = Unit.debug_name
    local unit_box = Unit.box
    local managers = Managers
    local class = class
    local pairs = pairs
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"

-- ##### ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌  ┌─┐┌┐┌┬┌┬┐┌─┐┌┬┐┬┌─┐┌┐┌  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ######################################
-- ##### │││├┤ ├─┤├─┘│ ││││  ├─┤│││││││├─┤ │ ││ ││││  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ######################################
-- ##### └┴┘└─┘┴ ┴┴  └─┘┘└┘  ┴ ┴┘└┘┴┴ ┴┴ ┴ ┴ ┴└─┘┘└┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ######################################

local AttachmentCarouselExtension = class("AttachmentCarouselExtension", "WeaponCustomizationExtension")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

AttachmentCarouselExtension.init = function(self, extension_init_context, unit, extension_init_data)
    AttachmentCarouselExtension.super.init(self, extension_init_context, unit, extension_init_data)

    mod:echo("init")

    self.ui_weapon_spawner = extension_init_data.ui_weapon_spawner
    self:set_units()

    self.animations = {}

    managers.event:register(self, "weapon_customization_settings_changed", "on_settings_changed")

    self:on_settings_changed()
    
    self.initialized = true
end

AttachmentCarouselExtension.delete = function(self)
    managers.event:unregister(self, "weapon_customization_settings_changed")
    self.initialized = false

    mod:echo("delete")

    AttachmentCarouselExtension.super.delete(self)
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

AttachmentCarouselExtension.on_settings_changed = function(self)
    self.carousel = mod:get("mod_option_carousel")
end

AttachmentCarouselExtension.on_spawn_item = function(self)

end

AttachmentCarouselExtension.on_despawn_item = function(self)

end

AttachmentCarouselExtension.on_streaming_complete = function(self)

end


-- mod.unit_hide_meshes = function(self, unit, hide)
-- 	if unit and unit_alive(unit) then
-- 		local num_meshes = unit_num_meshes(unit)
-- 		-- if hide then mod:echo("hide unit: "..tostring(unit)) end
-- 		-- if not hide then mod:echo("show unit: "..tostring(unit)) end
-- 		if num_meshes and num_meshes > 0 then
-- 			for i = 1, num_meshes do
-- 				unit_set_mesh_visibility(unit, i, not hide)
-- 			end
-- 		end
-- 	end
-- end

-- mod.update_attachment_previews = function(self, dt, t)
-- 	local selected_index = self.attachment_preview_index or 1
-- 	if self.cosmetics_view._weapon_preview._ui_weapon_spawner._weapon_spawn_data then
-- 		for _, unit in pairs(self.spawned_attachments) do
			
-- 			local link_unit = self.cosmetics_view._weapon_preview._ui_weapon_spawner._weapon_spawn_data.link_unit
-- 			if unit and unit_alive(unit) then
-- 				-- if index + 1 == self.attachment_preview_index then
-- 				-- 	unit_set_local_scale(unit, 1, vector3(1.3, 1.3, 1.3))
-- 				-- else
-- 				-- 	unit_set_local_scale(unit, 1, vector3(1, 1, 1))
-- 				-- end
-- 				unit_set_local_rotation(unit, 1, unit_world_rotation(link_unit, 1))

-- 				-- local last_slot = mod.attachment_slot_positions[7] or self.spawned_attachments_last_position[unit]

-- 				if self.attachment_index_updated[unit] ~= self.attachment_preview_index then
-- 					-- local max = self.attachment_preview_count / 2
-- 					-- local selected = selected_index / max
-- 					-- local fraction = index / max
-- 					-- local x = (max * fraction - max * (selected - .4)) * .4
-- 					-- local z = math.abs(index - selected_index) * .1
					
-- 					-- local camera = self.cosmetics_view._weapon_preview._ui_weapon_spawner._camera
-- 					-- local rotation = camera_world_rotation(camera)
-- 					-- local camera_forward = quaternion_forward(rotation)
-- 					-- local distance = vector3_zero()
-- 					-- local down = vector3.down() * .2
-- 					-- if index + 1 == self.attachment_preview_index then
-- 					-- 	distance = camera_forward * 3
-- 					-- 	down = vector3.down() * .15
-- 					-- else
-- 					-- 	distance = camera_forward * 6
-- 					-- end
-- 					-- local camera_position = camera_world_position(camera)
-- 					-- local target_position = camera_position + distance + down + vector3(x, 0, 0)
-- 					local world = self.cosmetics_view._weapon_preview._ui_weapon_spawner._world
-- 					local target_position = self.attachment_slot_positions[6]
-- 					local index = self.attachment_index[unit]
-- 					local attachment_name = self.preview_attachment_name[unit]
-- 					if index == self.attachment_preview_index then
-- 						local item = mod.cosmetics_view._selected_item
-- 						local attachment_slot = self.preview_attachment_slot
-- 						self:play_attachment_sound(item, attachment_slot, attachment_name, "select")
-- 						self:preview_flashlight(true, world, unit, attachment_name)
-- 						local ui_weapon_spawner = self.cosmetics_view._weapon_preview._ui_weapon_spawner
-- 						local attachment_units_3p = ui_weapon_spawner._weapon_spawn_data.attachment_units_3p
-- 						local attachment_unit = attachment_units_3p and mod:get_attachment_slot_in_attachments(attachment_units_3p, attachment_slot)
-- 						-- self.attachment_slot_positions[3] = attachment_unit and unit_world_position(attachment_unit, 1) or self.attachment_slot_positions[3]
-- 						target_position = self.attachment_slot_positions[3]
-- 						self.spawned_attachments_last_position[unit] = attachment_unit and unit_world_position(attachment_unit, 1)
-- 						unit_set_unit_visibility(unit, true, true)

-- 						-- local attachment_name = attachment_unit and unit_get_data(attachment_unit, "attachment_name")
-- 						local attachment_data = attachment_name and mod.attachment_models[self.cosmetics_view._item_name][attachment_name]
-- 						attachment_data = self:_apply_anchor_fixes(item, attachment_slot) or attachment_data
-- 						local scale = attachment_data and attachment_data.scale and vector3_unbox(attachment_data.scale) or vector3_zero()
-- 						unit_set_local_scale(unit, 1, scale)
						
-- 						-- local ui_weapon_spawner = self.cosmetics_view._weapon_preview._ui_weapon_spawner
-- 						-- local attachment_units_3p = ui_weapon_spawner._weapon_spawn_data.attachment_units_3p
-- 						-- local attachment_unit = mod:get_attachment_slot_in_attachments(attachment_units_3p, attachment_slot)
-- 						-- -- local attachment_name = unit_get_data(flashlight, "attachment_name")
-- 						-- -- mod:preview_flashlight(true, self._world, flashlight, attachment_name)
-- 						-- if attachment_unit then
-- 						-- 	self.spawned_attachments_overwrite_position[unit] = mod.attachment_slot_positions[7]
-- 						-- end
-- 						-- mod:play_attachment_sound(mod.cosmetics_view._selected_item, self.preview_attachment_slot, entry.new, "attach")
						
-- 						-- target_position = self.attachment_slot_positions[3]
-- 						-- unit_set_unit_visibility(unit, true, true)
-- 					elseif index ~= self.attachment_preview_index then
-- 						self.spawned_attachments_last_position[unit] = self.spawned_attachments_last_position[unit] 
-- 							or self.attachment_slot_positions[3]
-- 						local diff = index - self.attachment_preview_index
-- 						if math.abs(diff) <= 2 then
-- 							target_position = self.attachment_slot_positions[3 + diff]
-- 							unit_set_unit_visibility(unit, true, true)
-- 						else
-- 							unit_set_unit_visibility(unit, false, true)
-- 						end
-- 						self:preview_flashlight(false, world, unit, attachment_name, true)

-- 					end

-- 					local tm, half_size = Unit.box(unit)
-- 					local radius = math.max(half_size.x, half_size.y)
-- 					local scale = .08 / math_max(radius, half_size.z * 2)
-- 					unit_set_local_scale(unit, 1, vector3(scale, scale, scale))					

-- 					self.spawned_attachments_last_position[unit] = self.spawned_attachments_target_position[unit] or self.attachment_slot_positions[6]
-- 					self.spawned_attachments_target_position[unit] = target_position
-- 					-- mod:echo("target: "..tostring(vector3_unbox(target_position)))

-- 					self.attachment_index_updated[unit] = self.attachment_preview_index
-- 					self.spawned_attachments_timer[unit] = t + 1

-- 				elseif self.spawned_attachments_timer[unit] and self.spawned_attachments_timer[unit] > t then
-- 					local target_position = self.spawned_attachments_target_position[unit]
-- 					local last_position = self.spawned_attachments_last_position[unit]
-- 					local progress = (self.spawned_attachments_timer[unit] - t) / 1
-- 					local anim_progress = math.easeOutCubic(1 - progress)
-- 					local lerp_position = vector3_lerp(vector3_unbox(last_position), vector3_unbox(target_position), anim_progress)
-- 					unit_set_local_position(unit, 1, lerp_position)

-- 				elseif self.spawned_attachments_timer[unit] and self.spawned_attachments_timer[unit] <= t then
-- 					self.spawned_attachments_timer[unit] = nil
-- 					local target_position = self.spawned_attachments_target_position[unit]
-- 					unit_set_local_position(unit, 1, vector3_unbox(target_position))
-- 					-- self.spawned_attachments_overwrite_position[unit] = nil
-- 					-- mod.attachment_slot_positions[7] = nil

-- 				end
-- 			end
-- 		end
-- 	end
-- end

-- mod.spawn_attachment_preview = function(self, index, attachment_slot, attachment_name, base_unit)
-- 	local link_unit = self.cosmetics_view._weapon_preview._ui_weapon_spawner._weapon_spawn_data.link_unit
-- 	local world = self.cosmetics_view._weapon_preview._ui_weapon_spawner._world
-- 	local pose = Unit.world_pose(link_unit, 1)
-- 	local unit = base_unit and World.spawn_unit_ex(world, base_unit, nil, pose)
-- 	-- local attachment_data = mod.attachment_models[self.cosmetics_view._item_name][attachment_name]
-- 	local attachment_data = attachment_name and mod.attachment_models[self.cosmetics_view._item_name][attachment_name]
-- 	local scale = attachment_data and attachment_data.scale or vector3(1, 1, 1)
-- 	attachment_data = self:_apply_anchor_fixes(self.cosmetics_view._selected_item, attachment_slot) or attachment_data
-- 	scale = attachment_data and attachment_data.scale or scale
-- 	unit_set_local_scale(unit, 1, scale)
-- 	-- mod:preview_flashlight(true, false, world, unit, attachment_name)
-- 	self.preview_attachment_name[unit] = attachment_name
-- 	self.attachment_index[unit] = index
-- 	self.spawned_attachments[#self.spawned_attachments+1] = unit
-- 	return unit
-- end

-- mod.try_spawning_previews = function(self)
-- 	if self.cosmetics_view and self.cosmetics_view._weapon_preview._ui_weapon_spawner._weapon_spawn_data then
-- 		for i = #self.load_previews, 1, -1 do
-- 			local preview = self.load_previews[i]
-- 			self:spawn_attachment_preview(preview.index, preview.attachment_slot, preview.attachment_name, preview.base_unit)
-- 			self.load_previews[i] = nil
-- 		end
-- 	end
-- end

-- mod.attachment_package_loaded = function(self, index, attachment_slot, attachment_name, base_unit)
-- 	-- local attachment_unit = self:spawn_attachment_preview(index, attachment_slot, attachment_name, base_unit)
-- 	self.load_previews[#self.load_previews+1] = {
-- 		index = index,
-- 		attachment_slot = attachment_slot,
-- 		attachment_name = attachment_name,
-- 		base_unit = base_unit,
-- 	}
-- end

-- mod.release_attachment_packages = function(self)
-- 	self:destroy_attachment_previews()
-- 	self:persistent_table(REFERENCE).used_packages.customization = {}
-- 	for package_key, package_id in pairs(self:persistent_table(REFERENCE).loaded_packages.customization) do
-- 		managers.package:release(package_id)
-- 	end
-- 	self:persistent_table(REFERENCE).loaded_packages.customization = {}
-- end

-- mod.destroy_attachment_previews = function(self)
-- 	local world = self.cosmetics_view._weapon_preview._ui_weapon_spawner._world
-- 	for _, unit in pairs(self.spawned_attachments) do
-- 		if unit and unit_alive(unit) then
-- 			world_unlink_unit(world, unit)
-- 			-- world_destroy_unit(world, unit)
-- 		end
-- 	end
-- 	for _, unit in pairs(self.spawned_attachments) do
-- 		if unit and unit_alive(unit) then
-- 			-- world_unlink_unit(world, unit)
-- 			world_destroy_unit(world, unit)
-- 		end
-- 	end
-- 	self.spawned_attachments = {}
-- end

-- mod.setup_attachment_slot_positions = function(self)
-- 	local camera = self.cosmetics_view._weapon_preview._ui_weapon_spawner._camera
-- 	local rotation = camera_world_rotation(camera)
-- 	local camera_forward = quaternion_forward(rotation)
-- 	local camera_position = camera_world_position(camera)
-- 	local x = .05
-- 	local link_unit = self.cosmetics_view._weapon_preview._ui_weapon_spawner._weapon_spawn_data.link_unit
-- 	self.attachment_slot_positions = {
-- 		vector3_box(camera_position + camera_forward * 5 + vector3(x - .6, 0, 0)),
-- 		vector3_box(camera_position + camera_forward * 4 + vector3(x - .3, -.1, -.1)),
-- 		vector3_box(camera_position + camera_forward * 2 + vector3(x, 0, -.05)),
-- 		vector3_box(camera_position + camera_forward * 3 + vector3(x + .175, -.15, .025)),
-- 		vector3_box(camera_position + camera_forward * 3.5 + vector3(x + .3, 0, .2)),
-- 		-- vector3_box(unit_world_position(link_unit, 1) + vector3(0, 0, 3)),
-- 		vector3_box(camera_position + camera_forward * 2 + vector3(x, 0, -.05)),
-- 	}
-- end

-- mod.create_attachment_array = function(self, item, attachment_slot)
-- 	self.preview_attachment_slot = attachment_slot
-- 	if self.cosmetics_view and self.cosmetics_view._weapon_preview._ui_weapon_spawner._camera then
-- 		local ui_weapon_spawner = self.cosmetics_view._weapon_preview._ui_weapon_spawner
-- 		if ui_weapon_spawner._weapon_spawn_data then
-- 			local attachment_units_3p = ui_weapon_spawner._weapon_spawn_data.attachment_units_3p
-- 			local attachment_unit = attachment_units_3p and mod:get_attachment_slot_in_attachments(attachment_units_3p, attachment_slot)
-- 			if attachment_unit then
-- 				local attachment_name = attachment_unit and unit_get_data(attachment_unit, "attachment_name")
-- 				local attachment_data = attachment_name and mod.attachment_models[self.cosmetics_view._item_name][attachment_name]
-- 				local movement = attachment_data and attachment_data.remove and vector3_unbox(attachment_data.remove) or vector3_zero()
-- 				-- mod:echo("set position")
-- 				self:setup_attachment_slot_positions()
-- 				self:load_attachment_packages(item, attachment_slot)
-- 				self:unit_hide_meshes(attachment_unit, true)
-- 			else
-- 				self:setup_attachment_slot_positions()
-- 				self:load_attachment_packages(item, attachment_slot)
-- 			end
-- 		end
-- 	end
-- end

return AttachmentCarouselExtension