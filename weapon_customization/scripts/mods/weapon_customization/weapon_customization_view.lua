local mod = get_mod("weapon_customization")
local modding_tools = get_mod("modding_tools")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
	local ItemUtils = mod:original_require("scripts/utilities/items")
	local UIFonts = mod:original_require("scripts/managers/ui/ui_fonts")
	local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
	local MasterItems = mod:original_require("scripts/backend/master_items")
	local UIRenderer = mod:original_require("scripts/managers/ui/ui_renderer")
	local UIScenegraph = mod:original_require("scripts/managers/ui/ui_scenegraph")
	local WorldRenderUtils = mod:original_require("scripts/utilities/world_render")
	local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")
	local ScriptGui = mod:original_require("scripts/foundation/utilities/script_gui")
	local UIFontSettings = mod:original_require("scripts/managers/ui/ui_font_settings")
	local ScriptWorld = mod:original_require("scripts/foundation/utilities/script_world")
	local ButtonPassTemplates = mod:original_require("scripts/ui/pass_templates/button_pass_templates")
	local ItemPackage = mod:original_require("scripts/foundation/managers/package/utilities/item_package")
	local DropdownPassTemplates = mod:original_require("scripts/ui/pass_templates/dropdown_pass_templates")
	local SoundEventAliases = mod:original_require("scripts/settings/sound/player_character_sound_event_aliases")
	local WwiseGameSyncSettings = mod:original_require("scripts/settings/wwise_game_sync/wwise_game_sync_settings")
	local VisualLoadoutCustomization = mod:original_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization")
	local ViewElementWeaponInfoDefinitions = mod:original_require("scripts/ui/view_elements/view_element_weapon_info/view_element_weapon_info_definitions")
	local inventory_weapon_cosmetics_view_definitions = mod:original_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view_definitions")
	local Breeds = mod:original_require("scripts/settings/breed/breeds")

	local WeaponCustomizationLocalization = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_localization")
	local WeaponBuildAnimation = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/classes/weapon_build_animation")
	local CustomizationCamera = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/classes/customization_camera")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
	local Unit = Unit
	local math = math
	local World = World
	local table = table
	local Color = Color
	local pairs = pairs
	local Camera = Camera
	local string = string
	local vector2 = Vector2
	local vector3 = Vector3
	local math_min = math.min
	local math_max = math.max
	local tostring = tostring
	local managers = Managers
	local callback = callback
	local Localize = Localize
	local Matrix4x4 = Matrix4x4
	local math_lerp = math.lerp
	local math_ceil = math.ceil
	local Quaternion = Quaternion
	local unit_alive = Unit.alive
	local table_size = table.size
	local table_find = table.find
	local utf8_upper = Utf8.upper
	local vector3_box = Vector3Box
	local script_unit = ScriptUnit
	local table_clone = table.clone
	local string_gsub = string.gsub
	local string_find = string.find
	local vector3_zero = vector3.zero
	local vector3_lerp = vector3.lerp
	local unit_get_data = Unit.get_data
	local table_reverse = table.reverse
	local table_contains = table.contains
	local vector3_unbox = vector3_box.unbox
	local unit_num_meshes = Unit.num_meshes
	local world_unlink_unit = World.unlink_unit
	local RESOLUTION_LOOKUP = RESOLUTION_LOOKUP
	local quaternion_forward = Quaternion.forward
	local world_destroy_unit = World.destroy_unit
	local ShadingEnvironment = ShadingEnvironment
	local unit_world_position = Unit.world_position
	local unit_world_rotation = Unit.world_rotation
	local unit_set_local_scale = Unit.set_local_scale
	local matrix4x4_translation = Matrix4x4.translation
	local camera_world_rotation = Camera.world_rotation
	local camera_world_to_screen = Camera.world_to_screen
	local camera_world_position = Camera.world_position
	local unit_set_local_position = Unit.set_local_position
	local unit_set_local_rotation = Unit.set_local_rotation
	local unit_set_mesh_visibility = Unit.set_mesh_visibility
	local unit_set_unit_visibility = Unit.set_unit_visibility
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local grid_size = inventory_weapon_cosmetics_view_definitions.grid_settings.grid_size
	local edge_padding = inventory_weapon_cosmetics_view_definitions.grid_settings.edge_padding
	local grid_width = grid_size[1] + edge_padding
	local edge = edge_padding * 0.5
	local label_height = 30
	local dropdown_height = 32
	local REFERENCE = "weapon_customization"
	local SOUND_DURATION = .5
	local LINE_THICKNESS = 2
	local LINE_Z = 0

	-- mod.bar_breakdown_widgets = {}
	-- mod.bar_breakdown_widgets_by_name = {}
	mod.original_weapon_settings = {}
	mod.changed_weapon_settings = {}
	mod.weapon_changed = nil
	mod.cosmetics_view = nil
	-- mod.mesh_positions = {}
	mod.dropdown_positions = {}
	mod.spawned_attachments = {}
	mod.attachment_preview_count = 0
	mod.spawned_attachments_last_position = {}
	mod.spawned_attachments_target_position = {}
	mod.spawned_attachments_timer = {}
	mod.attachment_index_updated = {}
	mod.attachment_index = {}
	mod.preview_attachment_name = {}
	mod.preview_attachment_slot = nil
	mod.load_previews = {}
--#endregion

-- ##### ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌  ┌─┐┌┐┌┬┌┬┐┌─┐┌┬┐┬┌─┐┌┐┌ ##################################################################
-- ##### │││├┤ ├─┤├─┘│ ││││  ├─┤│││││││├─┤ │ ││ ││││ ##################################################################
-- ##### └┴┘└─┘┴ ┴┴  └─┘┘└┘  ┴ ┴┘└┘┴┴ ┴┴ ┴ ┴ ┴└─┘┘└┘ ##################################################################

mod.build_animation = WeaponBuildAnimation:new()
-- mod.customization_camera = CustomizationCamera:new()

--#region Old
	-- mod.draw_box = function(self, unit, saved_origin)
	-- 	local tm, half_size = Unit.box(unit)
	-- 	local gui = self.cosmetics_view._ui_forward_renderer.gui
	-- 	local ui_weapon_spawner = self.cosmetics_view._weapon_preview._ui_weapon_spawner
	-- 	local camera = ui_weapon_spawner and ui_weapon_spawner._camera
	-- 	-- Get boundary points
	-- 	local points = {
	-- 		bottom_01 = {}, bottom_02 = {}, bottom_03 = {}, bottom_04 = {},
	-- 		top_01 = {}, top_02 = {}, top_03 = {}, top_04 = {},
	-- 	}
	-- 	points.bottom_01.position = Matrix4x4.transform(tm, vector3(half_size.x, half_size.y, -half_size.z))
	-- 	points.bottom_02.position = Matrix4x4.transform(tm, vector3(half_size.x, -half_size.y, -half_size.z))
	-- 	points.bottom_03.position = Matrix4x4.transform(tm, vector3(-half_size.x, -half_size.y, -half_size.z))
	-- 	points.bottom_04.position = Matrix4x4.transform(tm, vector3(-half_size.x, half_size.y, -half_size.z))
	-- 	points.top_01.position = Matrix4x4.transform(tm, vector3(half_size.x, half_size.y, half_size.z))
	-- 	points.top_02.position = Matrix4x4.transform(tm, vector3(half_size.x, -half_size.y, half_size.z))
	-- 	points.top_03.position = Matrix4x4.transform(tm, vector3(-half_size.x, -half_size.y, half_size.z))
	-- 	points.top_04.position = Matrix4x4.transform(tm, vector3(-half_size.x, half_size.y, half_size.z))
	-- 	-- Get position and distance to camera
	-- 	local results = {
	-- 		bottom_01 = {}, bottom_02 = {}, bottom_03 = {}, bottom_04 = {},
	-- 		top_01 = {}, top_02 = {}, top_03 = {}, top_04 = {},
	-- 	}
	-- 	results.bottom_01.position, results.bottom_01.distance = camera_world_to_screen(camera, points.bottom_01.position)
	-- 	results.bottom_02.position, results.bottom_02.distance = camera_world_to_screen(camera, points.bottom_02.position)
	-- 	results.bottom_03.position, results.bottom_03.distance = camera_world_to_screen(camera, points.bottom_03.position)
	-- 	results.bottom_04.position, results.bottom_04.distance = camera_world_to_screen(camera, points.bottom_04.position)
	-- 	results.top_01.position, results.top_01.distance = camera_world_to_screen(camera, points.top_01.position)
	-- 	results.top_02.position, results.top_02.distance = camera_world_to_screen(camera, points.top_02.position)
	-- 	results.top_03.position, results.top_03.distance = camera_world_to_screen(camera, points.top_03.position)
	-- 	results.top_04.position, results.top_04.distance = camera_world_to_screen(camera, points.top_04.position)
	-- 	-- Farthest point from camera
	-- 	local farthest = nil
	-- 	local last = 0
	-- 	for name, data in pairs(results) do
	-- 		if data.distance > last then
	-- 			last = data.distance
	-- 			farthest = name
	-- 		end
	-- 	end
	-- 	-- Save as target for lines
	-- 	if saved_origin then
	-- 		local closest = nil
	-- 		local last = math.huge
	-- 		local saved_origin_v3 = vector3(saved_origin[1], saved_origin[2], 0)
	-- 		for name, data in pairs(results) do
	-- 			local position = vector3(data.position[1], data.position[2], 0)
	-- 			local distance = vector3.distance(saved_origin_v3, position)
	-- 			if distance < last then
	-- 				last = distance
	-- 				closest = name
	-- 			end
	-- 		end
	-- 		if closest then
	-- 			self.equipment_line_target = {
	-- 				results[closest].position[1],
	-- 				results[closest].position[2],
	-- 			}
	-- 		end
	-- 	end
	
	-- 	-- local weapon_spawn_data = ui_weapon_spawner._weapon_spawn_data
	-- 	-- if weapon_spawn_data then
	-- 	-- 	local weapon_size = mod:weapon_size(weapon_spawn_data.attachment_units_3p)
	-- 	-- 	mod:echot("weapon_size: "..tostring(weapon_size))
	-- 	-- end

	-- 	-- Draw box bottom
	-- 	if farthest ~= "bottom_01" and farthest ~= "bottom_02" then ScriptGui.hud_line(gui, results.bottom_01.position, results.bottom_02.position, LINE_Z, LINE_THICKNESS, Color(255, 106, 121, 100)) end
	-- 	if farthest ~= "bottom_01" and farthest ~= "bottom_04" then ScriptGui.hud_line(gui, results.bottom_01.position, results.bottom_04.position, LINE_Z, LINE_THICKNESS, Color(255, 106, 121, 100)) end
	-- 	if farthest ~= "bottom_02" and farthest ~= "bottom_03" then ScriptGui.hud_line(gui, results.bottom_02.position, results.bottom_03.position, LINE_Z, LINE_THICKNESS, Color(255, 106, 121, 100)) end
	-- 	if farthest ~= "bottom_03" and farthest ~= "bottom_04" then ScriptGui.hud_line(gui, results.bottom_03.position, results.bottom_04.position, LINE_Z, LINE_THICKNESS, Color(255, 106, 121, 100)) end
	-- 	-- Draw box top
	-- 	if farthest ~= "top_01" and farthest ~= "bottom_01" then ScriptGui.hud_line(gui, results.top_01.position, results.bottom_01.position, LINE_Z, LINE_THICKNESS, Color(255, 106, 121, 100)) end
	-- 	if farthest ~= "top_02" and farthest ~= "bottom_02" then ScriptGui.hud_line(gui, results.top_02.position, results.bottom_02.position, LINE_Z, LINE_THICKNESS, Color(255, 106, 121, 100)) end
	-- 	if farthest ~= "top_03" and farthest ~= "bottom_03" then ScriptGui.hud_line(gui, results.top_03.position, results.bottom_03.position, LINE_Z, LINE_THICKNESS, Color(255, 106, 121, 100)) end
	-- 	if farthest ~= "top_04" and farthest ~= "bottom_04" then ScriptGui.hud_line(gui, results.top_04.position, results.bottom_04.position, LINE_Z, LINE_THICKNESS, Color(255, 106, 121, 100)) end
	-- 	-- Draw box sides
	-- 	if farthest ~= "top_01" and farthest ~= "top_02" then ScriptGui.hud_line(gui, results.top_01.position, results.top_02.position, LINE_Z, LINE_THICKNESS, Color(255, 106, 121, 100)) end
	-- 	if farthest ~= "top_01" and farthest ~= "top_04" then ScriptGui.hud_line(gui, results.top_01.position, results.top_04.position, LINE_Z, LINE_THICKNESS, Color(255, 106, 121, 100)) end
	-- 	if farthest ~= "top_02" and farthest ~= "top_03" then ScriptGui.hud_line(gui, results.top_02.position, results.top_03.position, LINE_Z, LINE_THICKNESS, Color(255, 106, 121, 100)) end
	-- 	if farthest ~= "top_03" and farthest ~= "top_04" then ScriptGui.hud_line(gui, results.top_03.position, results.top_04.position, LINE_Z, LINE_THICKNESS, Color(255, 106, 121, 100)) end
	-- end

	-- mod.draw_equipment_box = function(self, dt, t)
	-- 	if self.cosmetics_view and self.cosmetics_view.weapon_unit and unit_alive(self.cosmetics_view.weapon_unit) and not self.dropdown_open then
	-- 		local attachment_slots = self:get_attachment_slots(self.cosmetics_view.weapon_unit)
	-- 		if attachment_slots and #attachment_slots > 0 then
	-- 			for _, attachment_slot in pairs(attachment_slots) do
	-- 				local unit = self:get_attachment_unit(self.cosmetics_view.weapon_unit, attachment_slot)
	-- 				if unit and unit_alive(unit) then
	-- 					local saved_origin = self.dropdown_positions[attachment_slot]
	-- 					if saved_origin and saved_origin[3] and saved_origin[3] == true then
	-- 						self:draw_box(unit, saved_origin)
	-- 						break
	-- 					end
	-- 				end
	-- 			end
	-- 		end
	-- 	end
	-- end

	-- mod.draw_equipment_lines = function(self, dt, t)
	-- 	if self.cosmetics_view and self.cosmetics_view.weapon_unit and unit_alive(self.cosmetics_view.weapon_unit) and not self.dropdown_open then
	-- 		local attachment_slots = self:get_attachment_slots(self.cosmetics_view.weapon_unit)
	-- 		if attachment_slots and #attachment_slots > 0 then
	-- 			local gui = self.cosmetics_view._ui_forward_renderer.gui
	-- 			local camera = self.cosmetics_view._weapon_preview._ui_weapon_spawner._camera
	-- 			for _, attachment_slot in pairs(attachment_slots) do
	-- 				local unit = self:get_attachment_unit(self.cosmetics_view.weapon_unit, attachment_slot)
	-- 				if unit and unit_alive(unit) then
	-- 					local box = Unit.box(unit, false)
	-- 					local center_position = matrix4x4_translation(box)
	-- 					local world_to_screen, distance = camera_world_to_screen(camera, center_position)
	-- 					if self.equipment_line_target then
	-- 						world_to_screen = vector2(self.equipment_line_target[1], self.equipment_line_target[2])
	-- 					end
	-- 					local saved_origin = self.dropdown_positions[attachment_slot]
	-- 					if saved_origin and saved_origin[3] and saved_origin[3] == true then
	-- 						local origin = vector2(saved_origin[1], saved_origin[2])
	-- 						local color = Color(255, 49, 62, 45)
	-- 						ScriptGui.hud_line(gui, origin, world_to_screen, LINE_Z, LINE_THICKNESS, Color(255, 106, 121, 100))
	-- 						break
	-- 					end
	-- 				end
	-- 			end
	-- 		end
	-- 	end
	-- end
--#endregion

-- ##### ┬ ┬┬  ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌  ┌─┐┌─┐┌─┐┬ ┬┌┐┌┌─┐┬─┐  ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ###################################
-- ##### │ ││  │││├┤ ├─┤├─┘│ ││││  └─┐├─┘├─┤││││││├┤ ├┬┘  ├┤ │ │││││   │ ││ ││││└─┐ ###################################
-- ##### └─┘┴  └┴┘└─┘┴ ┴┴  └─┘┘└┘  └─┘┴  ┴ ┴└┴┘┘└┘└─┘┴└─  └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ###################################

mod.start_weapon_move = function(self, position, no_reset)
	-- local view = self.cosmetics_view
	-- local ui_weapon_spawner = view and view._weapon_preview._ui_weapon_spawner
	-- local weapon_spawn_data = ui_weapon_spawner and ui_weapon_spawner._weapon_spawn_data
	-- if weapon_spawn_data then
	-- 	mod:execute_extension(weapon_spawn_data.item_unit_3p, "weapon_animation_system", "move", position)
	-- end

	-- mod.customization_camera:move(position)

	if self.demo then return end

	if position then
		self.move_position = position
		self.do_move = true
		self.no_reset = no_reset
	elseif self.link_unit_position then
		self.move_position = vector3_box(vector3_zero())
		self.do_move = true
	end
end

mod.play_zoom_sound = function(self, t, sound)
	if not self.sound_end or t >= self.sound_end then
		self.sound_end = t + SOUND_DURATION
		self.cosmetics_view:_play_sound(sound)
	end
end

mod.load_new_attachment = function(self, item, attachment_slot, attachment, no_update)
	if self.cosmetics_view._gear_id then
		if attachment_slot and attachment then
			if not self.original_weapon_settings[attachment_slot] and not table_contains(self.automatic_slots, attachment_slot) then
				if not self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot) then
					self.original_weapon_settings[attachment_slot] = "default"
				else
					self.original_weapon_settings[attachment_slot] = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot)
				end
			end

			self:set_gear_setting(self.cosmetics_view._gear_id, attachment_slot, attachment)

			-- self:get_attachment_weapon_name(item, attachment_slot, attachment)

			self:resolve_special_changes(self.cosmetics_view._presentation_item, attachment)
			self:resolve_auto_equips(self.cosmetics_view._presentation_item)
			self:resolve_no_support(self.cosmetics_view._presentation_item)
			-- local attachment_data = self.attachment_models[self.cosmetics_view._item_name][attachment]
			-- if attachment_data and attachment_data.special_resolve then
			-- 	local special_changes = attachment_data.special_resolve(self.cosmetics_view._gear_id, self.cosmetics_view._presentation_item, attachment)
			-- 	if special_changes then
			-- 		for special_slot, special_attachment in pairs(special_changes) do

			-- 			if not self.original_weapon_settings[special_slot] and not table_contains(self.automatic_slots, special_slot) then
			-- 				if not self:get_gear_setting(self.cosmetics_view._gear_id, special_slot) then
			-- 					self.original_weapon_settings[special_slot] = "default"
			-- 				else
			-- 					self.original_weapon_settings[special_slot] = self:get_gear_setting(self.cosmetics_view._gear_id, special_slot)
			-- 				end
			-- 			end

			-- 			self:set_gear_setting(self.cosmetics_view._gear_id, special_slot, special_attachment)
			-- 		end
			-- 	end
			-- end
		end

		if not no_update then
			-- self:resolve_special_changes(self.cosmetics_view._presentation_item, attachment)
			-- self:resolve_auto_equips(self.cosmetics_view._presentation_item)

			-- mod:add_to_packages(self.cosmetics_view._selected_item)
			-- mod:remove_from_packages(self.cosmetics_view._selected_item)

			self.cosmetics_view._presentation_item = MasterItems.create_preview_item_instance(self.cosmetics_view._selected_item)

			-- if self.cosmetics_view._previewed_element then
			-- 	self.cosmetics_view:_preview_element(self.cosmetics_view._previewed_element)
			-- else
			self.cosmetics_view:_preview_item(self.cosmetics_view._presentation_item)
			-- end

			-- self:resolve_no_support(self.cosmetics_view._presentation_item)

			self.cosmetics_view._slot_info_id = self:get_slot_info_id(self.cosmetics_view._presentation_item)

			self:get_changed_weapon_settings()
		end
	end
end

-- Change light positions
mod.set_light_positions = function(self)
	if self.preview_lights and self.cosmetics_view then
		for _, unit_data in pairs(self.preview_lights) do
			-- Get default position
			local default_position = vector3_unbox(unit_data.position)
			-- Get difference to link unit position
			local weapon_spawner = self.cosmetics_view._weapon_preview._ui_weapon_spawner
			if weapon_spawner then
				local link_difference = vector3_unbox(weapon_spawner._link_unit_base_position) - vector3_unbox(weapon_spawner._link_unit_position)
				-- Position with offset
				local light_position = vector3(default_position[1], default_position[2] - link_difference[2], default_position[3])
				-- mod:info("mod.set_light_positions: "..tostring(unit_data.unit))
				unit_set_local_position(unit_data.unit, 1, light_position)
			end
		end
	end
end

mod.unit_hide_meshes = function(self, unit, hide)
	if unit and unit_alive(unit) then
		local num_meshes = unit_num_meshes(unit)
		if num_meshes and num_meshes > 0 then
			for i = 1, num_meshes do
				unit_set_mesh_visibility(unit, i, not hide)
			end
		end
	end
end

mod.update_attachment_previews = function(self, dt, t)
	local selected_index = self.attachment_preview_index or 1
	local attachment_slot = self.preview_attachment_slot
	if self.cosmetics_view._weapon_preview._ui_weapon_spawner._weapon_spawn_data then
		for _, unit in pairs(self.spawned_attachments) do
			
			local link_unit = self.cosmetics_view._weapon_preview._ui_weapon_spawner._weapon_spawn_data.link_unit
			if unit and unit_alive(unit) then
				-- if index + 1 == self.attachment_preview_index then
				-- 	unit_set_local_scale(unit, 1, vector3(1.3, 1.3, 1.3))
				-- else
				-- 	unit_set_local_scale(unit, 1, vector3(1, 1, 1))
				-- end
				local index = self.attachment_index[unit]
				unit_set_local_rotation(unit, 1, unit_world_rotation(link_unit, 1))

				if index == selected_index then
					-- self:draw_box(unit)
				end

				-- local last_slot = mod.attachment_slot_positions[7] or self.spawned_attachments_last_position[unit]
				-- self.dropdown_positions[attachment_slot][3] = index == self.attachment_preview_index
				if self.attachment_index_updated[unit] ~= self.attachment_preview_index then
					-- local max = self.attachment_preview_count / 2
					-- local selected = selected_index / max
					-- local fraction = index / max
					-- local x = (max * fraction - max * (selected - .4)) * .4
					-- local z = math.abs(index - selected_index) * .1
					
					-- local camera = self.cosmetics_view._weapon_preview._ui_weapon_spawner._camera
					-- local rotation = camera_world_rotation(camera)
					-- local camera_forward = quaternion_forward(rotation)
					-- local distance = vector3_zero()
					-- local down = vector3.down() * .2
					-- if index + 1 == self.attachment_preview_index then
					-- 	distance = camera_forward * 3
					-- 	down = vector3.down() * .15
					-- else
					-- 	distance = camera_forward * 6
					-- end
					-- local camera_position = camera_world_position(camera)
					-- local target_position = camera_position + distance + down + vector3(x, 0, 0)
					local world = self.cosmetics_view._weapon_preview._ui_weapon_spawner._world
					local target_position = self.attachment_slot_positions[6]
					-- local index = self.attachment_index[unit]
					local attachment_name = self.preview_attachment_name[unit]
					if index == self.attachment_preview_index then
						local item = mod.cosmetics_view._selected_item
						-- local attachment_slot = self.preview_attachment_slot
						self:play_attachment_sound(item, attachment_slot, attachment_name, "select")
						self:preview_flashlight(true, world, unit, attachment_name)
						local ui_weapon_spawner = self.cosmetics_view._weapon_preview._ui_weapon_spawner
						local attachment_units_3p = ui_weapon_spawner._weapon_spawn_data.attachment_units_3p
						local attachment_unit = attachment_units_3p and mod:get_attachment_slot_in_attachments(attachment_units_3p, attachment_slot)
						-- self.attachment_slot_positions[3] = attachment_unit and unit_world_position(attachment_unit, 1) or self.attachment_slot_positions[3]
						target_position = self.attachment_slot_positions[3]
						self.spawned_attachments_last_position[unit] = attachment_unit and unit_world_position(attachment_unit, 1)
						unit_set_unit_visibility(unit, true, true)

						-- local attachment_name = attachment_unit and unit_get_data(attachment_unit, "attachment_name")
						local attachment_data = attachment_name and mod.attachment_models[self.cosmetics_view._item_name][attachment_name]
						attachment_data = self:_apply_anchor_fixes(item, attachment_slot) or attachment_data
						local scale = attachment_data and attachment_data.scale and vector3_unbox(attachment_data.scale) or vector3_zero()
						unit_set_local_scale(unit, 1, scale)
						
						-- local ui_weapon_spawner = self.cosmetics_view._weapon_preview._ui_weapon_spawner
						-- local attachment_units_3p = ui_weapon_spawner._weapon_spawn_data.attachment_units_3p
						-- local attachment_unit = mod:get_attachment_slot_in_attachments(attachment_units_3p, attachment_slot)
						-- -- local attachment_name = unit_get_data(flashlight, "attachment_name")
						-- -- mod:preview_flashlight(true, self._world, flashlight, attachment_name)
						-- if attachment_unit then
						-- 	self.spawned_attachments_overwrite_position[unit] = mod.attachment_slot_positions[7]
						-- end
						-- mod:play_attachment_sound(mod.cosmetics_view._selected_item, self.preview_attachment_slot, entry.new, "attach")
						
						-- target_position = self.attachment_slot_positions[3]
						-- unit_set_unit_visibility(unit, true, true)
					elseif index ~= self.attachment_preview_index then
						self.spawned_attachments_last_position[unit] = self.spawned_attachments_last_position[unit] 
							or self.attachment_slot_positions[3]
						local diff = index - self.attachment_preview_index
						if math.abs(diff) <= 2 then
							target_position = self.attachment_slot_positions[3 + diff]
							unit_set_unit_visibility(unit, true, true)
						else
							unit_set_unit_visibility(unit, false, true)
						end
						self:preview_flashlight(false, world, unit, attachment_name, true)

					end

					local tm, half_size = Unit.box(unit)
					local radius = math.max(half_size.x, half_size.y)
					local scale = .08 / math_max(radius, half_size.z * 2)
					unit_set_local_scale(unit, 1, vector3(scale, scale, scale))					

					self.spawned_attachments_last_position[unit] = self.spawned_attachments_target_position[unit] or self.attachment_slot_positions[6]
					self.spawned_attachments_target_position[unit] = target_position

					self.attachment_index_updated[unit] = self.attachment_preview_index
					self.spawned_attachments_timer[unit] = t + 1

				elseif self.spawned_attachments_timer[unit] and self.spawned_attachments_timer[unit] > t then
					local target_position = self.spawned_attachments_target_position[unit]
					local last_position = self.spawned_attachments_last_position[unit]
					local progress = (self.spawned_attachments_timer[unit] - t) / 1
					local anim_progress = math.easeOutCubic(1 - progress)
					local lerp_position = vector3_lerp(vector3_unbox(last_position), vector3_unbox(target_position), anim_progress)
					-- mod:info("mod.update_attachment_previews: "..tostring(unit))
					unit_set_local_position(unit, 1, lerp_position)

				elseif self.spawned_attachments_timer[unit] and self.spawned_attachments_timer[unit] <= t then
					self.spawned_attachments_timer[unit] = nil
					local target_position = self.spawned_attachments_target_position[unit]
					-- mod:info("mod.update_attachment_previews: "..tostring(unit))
					unit_set_local_position(unit, 1, vector3_unbox(target_position))
					-- self.spawned_attachments_overwrite_position[unit] = nil
					-- mod.attachment_slot_positions[7] = nil

				end
			end
		end
	end
end

mod.spawn_attachment_preview = function(self, index, attachment_slot, attachment_name, base_unit)
	local link_unit = self.cosmetics_view._weapon_preview._ui_weapon_spawner._weapon_spawn_data.link_unit
	local world = self.cosmetics_view._weapon_preview._ui_weapon_spawner._world
	local pose = Unit.world_pose(link_unit, 1)
	local unit = base_unit and World.spawn_unit_ex(world, base_unit, nil, pose)
	local callback = function()
	end
	Unit.force_stream_meshes(unit, callback, true)
	-- local attachment_data = mod.attachment_models[self.cosmetics_view._item_name][attachment_name]
	local attachment_data = attachment_name and mod.attachment_models[self.cosmetics_view._item_name][attachment_name]
	local scale = attachment_data and attachment_data.scale or vector3(1, 1, 1)
	attachment_data = self:_apply_anchor_fixes(self.cosmetics_view._selected_item, attachment_slot) or attachment_data
	scale = attachment_data and attachment_data.scale or scale
	unit_set_local_scale(unit, 1, scale)
	-- mod:preview_flashlight(true, false, world, unit, attachment_name)
	self.preview_attachment_name[unit] = attachment_name
	self.attachment_index[unit] = index
	self.spawned_attachments[#self.spawned_attachments+1] = unit
	return unit
end

mod.try_spawning_previews = function(self)
	if self.cosmetics_view and self.cosmetics_view._weapon_preview._ui_weapon_spawner._weapon_spawn_data then
		for i = #self.load_previews, 1, -1 do
			local preview = self.load_previews[i]
			self:spawn_attachment_preview(preview.index, preview.attachment_slot, preview.attachment_name, preview.base_unit)
			self.load_previews[i] = nil
		end
	end
end

mod.attachment_package_loaded = function(self, index, attachment_slot, attachment_name, base_unit)
	-- local attachment_unit = self:spawn_attachment_preview(index, attachment_slot, attachment_name, base_unit)
	self.load_previews[#self.load_previews+1] = {
		index = index,
		attachment_slot = attachment_slot,
		attachment_name = attachment_name,
		base_unit = base_unit,
	}
end

mod.release_attachment_packages = function(self)
	self:destroy_attachment_previews()
	self:persistent_table(REFERENCE).used_packages.customization = {}
	for package_key, package_id in pairs(self:persistent_table(REFERENCE).loaded_packages.customization) do
		managers.package:release(package_id)
	end
	self:persistent_table(REFERENCE).loaded_packages.customization = {}
end

mod.destroy_attachment_previews = function(self)
	local world = self.cosmetics_view._weapon_preview._ui_weapon_spawner._world
	for _, unit in pairs(self.spawned_attachments) do
		if unit and unit_alive(unit) then
			world_unlink_unit(world, unit)
			-- world_destroy_unit(world, unit)
		end
	end
	for _, unit in pairs(self.spawned_attachments) do
		if unit and unit_alive(unit) then
			-- world_unlink_unit(world, unit)
			world_destroy_unit(world, unit)
		end
	end
	self.spawned_attachments = {}
end

mod.setup_attachment_slot_positions = function(self)
	local camera = self.cosmetics_view._weapon_preview._ui_weapon_spawner._camera
	local rotation = camera_world_rotation(camera)
	local camera_forward = quaternion_forward(rotation)
	local camera_position = camera_world_position(camera)
	local x = .05
	local link_unit = self.cosmetics_view._weapon_preview._ui_weapon_spawner._weapon_spawn_data.link_unit
	self.attachment_slot_positions = {
		vector3_box(camera_position + camera_forward * 5 + vector3(x - .6, 0, 0)),
		vector3_box(camera_position + camera_forward * 4 + vector3(x - .3, -.1, -.1)),
		vector3_box(camera_position + camera_forward * 2 + vector3(x, 0, -.05)),
		vector3_box(camera_position + camera_forward * 3 + vector3(x + .175, -.15, .025)),
		vector3_box(camera_position + camera_forward * 3.5 + vector3(x + .3, 0, .2)),
		-- vector3_box(unit_world_position(link_unit, 1) + vector3(0, 0, 3)),
		vector3_box(camera_position + camera_forward * 2 + vector3(x, 0, -.05)),
	}
end

mod.create_attachment_array = function(self, item, attachment_slot)
	self.preview_attachment_slot = attachment_slot
	if self.cosmetics_view and self.cosmetics_view._weapon_preview._ui_weapon_spawner._camera then
		local ui_weapon_spawner = self.cosmetics_view._weapon_preview._ui_weapon_spawner
		if ui_weapon_spawner._weapon_spawn_data then
			local attachment_units_3p = ui_weapon_spawner._weapon_spawn_data.attachment_units_3p
			local attachment_unit = attachment_units_3p and mod:get_attachment_slot_in_attachments(attachment_units_3p, attachment_slot)
			if attachment_unit then
				local attachment_name = attachment_unit and unit_get_data(attachment_unit, "attachment_name")
				local attachment_data = attachment_name and mod.attachment_models[self.cosmetics_view._item_name][attachment_name]
				local movement = attachment_data and attachment_data.remove and vector3_unbox(attachment_data.remove) or vector3_zero()
				self:setup_attachment_slot_positions()
				self:load_attachment_packages(item, attachment_slot)
				self:unit_hide_meshes(attachment_unit, true)
			else
				self:setup_attachment_slot_positions()
				self:load_attachment_packages(item, attachment_slot)
			end
		end
	end
end

-- ##### ┌─┐┌─┐┌┬┐┌┬┐┬┌┐┌┌─┐┌─┐ #######################################################################################
-- ##### └─┐├┤  │  │ │││││ ┬└─┐ #######################################################################################
-- ##### └─┘└─┘ ┴  ┴ ┴┘└┘└─┘└─┘ #######################################################################################

mod.get_changed_weapon_settings = function(self)
	if self.cosmetics_view._gear_id then
		self.changed_weapon_settings = {}
		local attachment_slots = self:get_item_attachment_slots(self.cosmetics_view._selected_item)
		for _, attachment_slot in pairs(attachment_slots) do
			if not table_contains(self.automatic_slots, attachment_slot) then
				self.changed_weapon_settings[attachment_slot] = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot)
			end
		end
	end
end

mod.check_unsaved_changes = function(self, no_animation)
	if table_size(self.original_weapon_settings) > 0 then
		if self.cosmetics_view._gear_id then
			if no_animation then
				for attachment_slot, value in pairs(self.original_weapon_settings) do
					self:set_gear_setting(self.cosmetics_view._gear_id, attachment_slot, value)
				end
			else
				local attachment_slots = self:get_item_attachment_slots(self.cosmetics_view._selected_item)
				local original_weapon_settings = table_clone(self.original_weapon_settings)
				local attachment_names = {}
				table_reverse(original_weapon_settings)
				for attachment_slot, value in pairs(original_weapon_settings) do
					attachment_names[attachment_slot] = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot, self.cosmetics_view._selected_item)
				end

				-- mod.build_animation.animations = {}
				self.weapon_part_animation_update = true
				for attachment_slot, value in pairs(original_weapon_settings) do
					-- self:detach_attachment(self.cosmetics_view._selected_item, attachment_slot, attachment_names[attachment_slot], value)
					mod.build_animation:animate(self.cosmetics_view._selected_item, attachment_slot, attachment_names[attachment_slot], value)
				end

				-- for attachment_slot, value in pairs(original_weapon_settings) do
				-- 	if mod.add_custom_attachments[attachment_slot] then
				-- 		mod:resolve_special_changes(self.cosmetics_view._presentation_item, value)
				-- 	end
				-- end
				-- for attachment_slot, value in pairs(original_weapon_settings) do
				-- 	if not mod.add_custom_attachments[attachment_slot] then
				-- 		mod:resolve_special_changes(self.cosmetics_view._presentation_item, value)
				-- 	end
				-- end
			end
			-- Auto equip
			for attachment_slot, value in pairs(self.original_weapon_settings) do
				if not self.add_custom_attachments[attachment_slot] then
					self:resolve_auto_equips(self.cosmetics_view._presentation_item, "default")
				end
			end
			for attachment_slot, value in pairs(self.original_weapon_settings) do
				if self.add_custom_attachments[attachment_slot] then
					self:resolve_auto_equips(self.cosmetics_view._presentation_item, "default")
				end
			end
			-- Special
			for attachment_slot, value in pairs(self.original_weapon_settings) do
				if self.add_custom_attachments[attachment_slot] then
					self:resolve_special_changes(self.cosmetics_view._presentation_item, "default")
				end
			end
			for attachment_slot, value in pairs(self.original_weapon_settings) do
				if not self.add_custom_attachments[attachment_slot] then
					self:resolve_special_changes(self.cosmetics_view._presentation_item, "default")
				end
			end
			self.original_weapon_settings = {}
		end
		-- self:update_equip_button()
	end
end

-- ##### ┬ ┬┬  ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ##############################################################################
-- ##### │ ││  ├┤ │ │││││   │ ││ ││││└─┐ ##############################################################################
-- ##### └─┘┴  └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ##############################################################################

mod.cb_on_demo_pressed = function(self)
	self.demo = true
	self.demo_time = .5
	self.demo_timer = 0
	self:persistent_table(REFERENCE).keep_all_packages = true
	self.cosmetics_view:_cb_on_ui_visibility_toggled("entry_"..tostring(3))
	-- self:start_weapon_move(vector3_box(vector3(-.15, -1, 0)))
	local ui_weapon_spawner = self.cosmetics_view._weapon_preview._ui_weapon_spawner
	ui_weapon_spawner._link_unit_position = vector3_box(vector3_unbox(ui_weapon_spawner._link_unit_base_position) + vector3(-.2, -2, 0))
	mod.link_unit_position = ui_weapon_spawner._link_unit_position
	local weapon_spawn_data = ui_weapon_spawner._weapon_spawn_data
	if weapon_spawn_data then
		local link_unit = weapon_spawn_data.link_unit
		-- mod:info("mod.set_light_positions: "..tostring(link_unit))
		unit_set_local_position(link_unit, 1, vector3_unbox(ui_weapon_spawner._link_unit_position))
	end
end

--#region Old
	-- mod.cb_on_randomize_pressed = function(self, skip_animation)
		
	-- 	-- Get random attachments
	-- 	local random_attachments = self:randomize_weapon(self.cosmetics_view._selected_item)

	-- 	-- Skip animation?
	-- 	local skip_animation = skip_animation or not self:get("mod_option_weapon_build_animation")

	-- 	if self.cosmetics_view._gear_id and random_attachments then
	-- 		-- mod:dtf(random_attachments, "random_attachments", 2)
	-- 		local attachment_names = {}
	-- 		-- table_reverse(random_attachments)
	-- 		for attachment_slot, value in pairs(random_attachments) do
	-- 			attachment_names[attachment_slot] = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot, self.cosmetics_view._selected_item)
	-- 		end
	-- 		local index = 1
	-- 		-- mod.build_animation.animations = {}
	-- 		self.weapon_part_animation_update = true
	-- 		for attachment_slot, value in pairs(random_attachments) do
	-- 			-- local attachment_data = self.attachment_models[self.cosmetics_view._item_name][attachment_names[attachment_slot]]
	-- 			-- local no_animation = attachment_data and attachment_data.no_animation
	-- 			if not skip_animation then
	-- 				-- self:detach_attachment(self.cosmetics_view._selected_item, attachment_slot, attachment_names[attachment_slot], value, nil, nil, true)
	-- 				self.build_animation:animate(self.cosmetics_view._selected_item, attachment_slot, attachment_names[attachment_slot], value, nil, nil, true)
	-- 				-- self.weapon_part_animation_update = true
	-- 			else
	-- 				self:load_new_attachment(self.cosmetics_view._selected_item, attachment_slot, value, index < table_size(random_attachments))
	-- 			end
	-- 			index = index + 1
	-- 		end
	-- 		-- Auto equip
	-- 		for attachment_slot, value in pairs(random_attachments) do
	-- 			if not self.add_custom_attachments[attachment_slot] then
	-- 				self:resolve_auto_equips(self.cosmetics_view._presentation_item, "default")
	-- 			end
	-- 		end
	-- 		for attachment_slot, value in pairs(random_attachments) do
	-- 			if self.add_custom_attachments[attachment_slot] then
	-- 				self:resolve_auto_equips(self.cosmetics_view._presentation_item, "default")
	-- 			end
	-- 		end
	-- 		-- Special
	-- 		for attachment_slot, value in pairs(random_attachments) do
	-- 			if self.add_custom_attachments[attachment_slot] then
	-- 				self:resolve_special_changes(self.cosmetics_view._presentation_item, "default")
	-- 			end
	-- 		end
	-- 		for attachment_slot, value in pairs(random_attachments) do
	-- 			if not self.add_custom_attachments[attachment_slot] then
	-- 				self:resolve_special_changes(self.cosmetics_view._presentation_item, "default")
	-- 			end
	-- 		end
	-- 		-- self.weapon_part_animation_update = true
			
	-- 		-- if not skip_animation then self.weapon_part_animation_update = true end
	-- 	end
	-- end

	-- mod.cb_on_reset_pressed = function(self, skip_animation)
	-- 	-- self:get_changed_weapon_settings()
	-- 	if self.cosmetics_view._gear_id and table_size(self.changed_weapon_settings) > 0 then
	-- 		local skip_animation = skip_animation or not self:get("mod_option_weapon_build_animation")

	-- 		local changed_weapon_settings = table_clone(self.changed_weapon_settings)
	-- 		local attachment_names = {}
	-- 		-- table_reverse(changed_weapon_settings)
	-- 		for attachment_slot, value in pairs(changed_weapon_settings) do
	-- 		-- for _, attachment_slot in pairs(self.attachment_slots) do
	-- 			attachment_names[attachment_slot] = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot, self.cosmetics_view._selected_item)
	-- 		end
	-- 		local index = 1
	-- 		-- mod.build_animation.animations = {}
	-- 		self.weapon_part_animation_update = true
	-- 		for attachment_slot, value in pairs(changed_weapon_settings) do
	-- 			-- local attachment_data = self.attachment_models[self.cosmetics_view._item_name][attachment_names[attachment_slot]]
	-- 			-- local no_animation = attachment_data and attachment_data.no_animation
	-- 			if not skip_animation then
	-- 				-- self:detach_attachment(self.cosmetics_view._selected_item, attachment_slot, attachment_names[attachment_slot], "default")
	-- 				self.build_animation:animate(self.cosmetics_view._selected_item, attachment_slot, attachment_names[attachment_slot], "default")
	-- 			else
	-- 				self:load_new_attachment(self.cosmetics_view._selected_item, attachment_slot, "default", index < #self.attachment_slots)
	-- 			end
	-- 			index = index + 1
	-- 		end
	-- 		-- Auto equip
	-- 		for attachment_slot, value in pairs(changed_weapon_settings) do
	-- 			if not self.add_custom_attachments[attachment_slot] then
	-- 				self:resolve_auto_equips(self.cosmetics_view._presentation_item, "default")
	-- 			end
	-- 		end
	-- 		for attachment_slot, value in pairs(changed_weapon_settings) do
	-- 			if self.add_custom_attachments[attachment_slot] then
	-- 				self:resolve_auto_equips(self.cosmetics_view._presentation_item, "default")
	-- 			end
	-- 		end
	-- 		-- Special
	-- 		for attachment_slot, value in pairs(changed_weapon_settings) do
	-- 			if self.add_custom_attachments[attachment_slot] then
	-- 				self:resolve_special_changes(self.cosmetics_view._presentation_item, "default")
	-- 			end
	-- 		end
	-- 		for attachment_slot, value in pairs(changed_weapon_settings) do
	-- 			if not self.add_custom_attachments[attachment_slot] then
	-- 				self:resolve_special_changes(self.cosmetics_view._presentation_item, "default")
	-- 			end
	-- 		end
	-- 		-- self.weapon_part_animation_update = true
	-- 		-- if not skip_animation then mod.weapon_part_animation_update = true end

	-- 		self.reset_weapon = true
	-- 		self:start_weapon_move()
	-- 		self.new_rotation = 0
	-- 		self.do_rotation = true
	-- 	end
	-- end


	-- mod.update_randomize_button = function(self)
	-- 	local button = self.cosmetics_view._widgets_by_name.randomize_button
	-- 	local button_content = button.content
	-- 	local disabled = self.build_animation:is_busy()
	-- 	button_content.hotspot.disabled = disabled
	-- end

	-- mod.update_equip_button = function(self)
	-- 	if self.cosmetics_view._selected_tab_index == 3 then
	-- 		local button = self.cosmetics_view._widgets_by_name.equip_button
	-- 		local button_content = button.content
	-- 		local disabled = table_size(self.original_weapon_settings) == 0 or self.build_animation:is_busy()
	-- 		button_content.hotspot.disabled = disabled
	-- 		button_content.text = utf8_upper(disabled and self:localize("loc_weapon_inventory_equipped_button") or self:localize("loc_weapon_inventory_equip_button"))
	-- 	end
	-- end

	-- mod.update_reset_button = function(self)
	-- 	local button = self.cosmetics_view._widgets_by_name.reset_button
	-- 	local button_content = button.content
	-- 	local disabled = table_size(self.changed_weapon_settings) == 0 or self.build_animation:is_busy()
	-- 	button_content.hotspot.disabled = disabled
	-- 	button_content.text = utf8_upper(disabled and self:localize("loc_weapon_inventory_no_reset_button") or self:localize("loc_weapon_inventory_reset_button"))
	-- end
--#endregion

mod.update_dropdown = function(self, widget, input_service, dt, t)
	local content = widget.content
	local entry = content.entry
	local value = entry.get_function and entry:get_function() or content.internal_value or "<not selected>"
	local selected_option = content.options[content.selected_index]

	if content.close_setting then
		content.close_setting = nil

		self:release_attachment_packages()
		
		local ui_weapon_spawner = self.cosmetics_view._weapon_preview._ui_weapon_spawner
		if content.reset and ui_weapon_spawner._weapon_spawn_data then
			content.reset = nil
			mod.dropdown_positions[entry.attachment_slot][3] = false
			local attachment_units_3p = ui_weapon_spawner._weapon_spawn_data.attachment_units_3p
			local unit = self:get_attachment_slot_in_attachments(attachment_units_3p, entry.attachment_slot)
			if unit then self:unit_hide_meshes(unit, false) end
			if attachment_units_3p then self:execute_hide_meshes(self.cosmetics_view._presentation_item, attachment_units_3p) end
			-- mod.build_animation.animations = {}
			self.weapon_part_animation_update = true
			-- self:detach_attachment(self.cosmetics_view._presentation_item, entry.attachment_slot, nil, selected_option.value, nil, nil, nil, "attach")
			mod.build_animation:animate(self.cosmetics_view._presentation_item, entry.attachment_slot, nil, selected_option.value, nil, nil, nil, "attach")
			self:start_weapon_move()
		end

		content.exclusive_focus = false
		local hotspot = content.hotspot or content.button_hotspot

		if hotspot then
			hotspot.is_selected = false
		end
		self.dropdown_open = false
		self.cosmetics_view._widgets_by_name.attachment_display_name.content.text = ""

		return
	end

	self.dropdown_positions[entry.attachment_slot] = self.dropdown_positions[entry.attachment_slot] or {}
	self.dropdown_positions[entry.attachment_slot][3] = (not self.dropdown_open and content.hotspot.is_hover) or content.hotspot.is_selected

	if (content.hotspot.is_hover or content.hotspot.is_selected) and not self.dropdown_open and not self.build_animation:is_busy() then
		mod.dropdown_positions[entry.attachment_slot][3] = true
		local weapon_attachments = self.attachment_models[self.cosmetics_view._item_name]
		local attachment_data = weapon_attachments[value]
		local new_angle = attachment_data and attachment_data.angle or 0
		self.do_rotation = true
		self.new_rotation = new_angle
		self.attachment_preview_index = content.selected_index

		-- local ui_weapon_spawner = self.cosmetics_view._weapon_preview._ui_weapon_spawner
		-- local attachment_units_3p = ui_weapon_spawner._weapon_spawn_data.attachment_units_3p
		-- local attachment_unit = self:get_attachment_slot_in_attachments(attachment_units_3p, entry.attachment_slot)
		-- if attachment_unit and unit_alive(attachment_unit) then
			-- if ui_weapon_spawner.selected_unit ~= attachment_unit and unit_alive(ui_weapon_spawner.selected_unit) and script_unit_has_extension(ui_weapon_spawner.selected_unit, "unit_manipulation_system") then
			-- 	script_unit_remove_extension(ui_weapon_spawner.selected_unit, "unit_manipulation_system")
			-- 	ui_weapon_spawner.selected_unit = nil
			-- end
			-- if not script_unit_has_extension(attachment_unit, "unit_manipulation_system") then
			-- 	local camera = ui_weapon_spawner._camera
			-- 	local world = ui_weapon_spawner._world
			-- 	script_unit_add_extension({
			-- 		world = world,
			-- 	}, attachment_unit, "UnitManipulationExtension", "unit_manipulation_system", {
			-- 		unit = attachment_unit,
			-- 		gui = self.cosmetics_view._ui_forward_renderer.gui,
			-- 		camera = camera,
			-- 	})
			-- 	ui_weapon_spawner.selected_unit = attachment_unit
			-- end
		-- end

	-- else
	-- 	mod.dropdown_positions[entry.attachment_slot][3] = false
	end

	local is_disabled = entry.disabled or false
	content.disabled = is_disabled or self.build_animation:is_busy()
	local size = {
		400,
		dropdown_height
	}
	local using_gamepad = not managers.ui:using_cursor_navigation()
	local offset = widget.offset
	local style = widget.style
	local options = content.options
	local options_by_id = content.options_by_id
	local num_visible_options = content.num_visible_options
	local num_options = #options
	local focused = content.exclusive_focus and not is_disabled

	if focused then
		offset[3] = 90
	else
		offset[3] = 0
	end

	local selected_index = content.selected_index
	local new_value, real_value = nil, nil
	local hotspot = content.hotspot
	local hotspot_style = style.hotspot

	if selected_index and focused then
		if using_gamepad and hotspot.on_pressed then
			new_value = options[selected_index].id
			real_value = options[selected_index].value
		end

		hotspot_style.on_pressed_sound = hotspot_style.on_pressed_fold_in_sound
	else
		hotspot_style.on_pressed_sound = hotspot_style.on_pressed_fold_out_sound
	end

	

	local localization_manager = managers.localization
	local preview_option = options_by_id[value]
	local preview_option_id = preview_option and preview_option.id
	local preview_value = preview_option and preview_option.display_name or "loc_settings_option_unavailable"
	local ignore_localization = preview_option and preview_option.ignore_localization
	content.value_text = ignore_localization and preview_value or localization_manager:localize(preview_value)
	local always_keep_order = true
	local grow_downwards = content.grow_downwards
	local new_selection_index = nil

	if not selected_index or not focused then
		for i = 1, #options do
			local option = options[i]

			if option.id == preview_option_id then
				selected_index = i

				break
			end
		end

		selected_index = selected_index or 1
	end

	if selected_index and focused then
		if input_service:get("navigate_up_continuous") then
			if grow_downwards or not grow_downwards and always_keep_order then
				new_selection_index = math_max(selected_index - 1, 1)
			else
				new_selection_index = math_min(selected_index + 1, num_options)
			end
		elseif input_service:get("navigate_down_continuous") then
			if grow_downwards or not grow_downwards and always_keep_order then
				new_selection_index = math_min(selected_index + 1, num_options)
			else
				new_selection_index = math_max(selected_index - 1, 1)
			end
		end
	end

	if new_selection_index or not content.selected_index then
		if new_selection_index then
			selected_index = new_selection_index
		end

		if num_visible_options < num_options then
			local step_size = 1 / num_options
			local new_scroll_percentage = math_min(selected_index - 1, num_options) * step_size
			content.scroll_percentage = new_scroll_percentage
			content.scroll_add = nil
		end

		content.selected_index = selected_index
	end

	local scroll_percentage = content.scroll_percentage

	if scroll_percentage then
		local step_size = 1 / (num_options - (num_visible_options - 1))
		content.start_index = math_max(1, math_ceil(scroll_percentage / step_size))
	end

	local option_hovered = false
	local option_index = 1
	local start_index = content.start_index or 1
	local end_index = math_min(start_index + num_visible_options - 1, num_options)
	local using_scrollbar = num_visible_options < num_options

	for i = start_index, end_index do
		local actual_i = i

		if not grow_downwards and always_keep_order then
			actual_i = end_index - i + start_index
		end

		local option_text_id = "option_text_" .. option_index
		local option_hotspot_id = "option_hotspot_" .. option_index
		local outline_style_id = "outline_" .. option_index
		local option_hotspot = content[option_hotspot_id]
		option_hovered = option_hovered or option_hotspot.is_hover
		option_hotspot.is_selected = actual_i == selected_index
		local option = options[actual_i]

		if option_hotspot.is_hover then
			
			-- entry.original_value = entry.original_value or value
			entry.preview_attachment = entry.preview_attachment or option.value
			if entry.preview_attachment ~= option.value then
				local weapon_attachments = self.attachment_models[self.cosmetics_view._item_name]
				-- local attachment_name = self:attachment_
				local attachment_data = weapon_attachments[option.value]
				local new_angle = attachment_data and attachment_data.angle or 0
				self.do_rotation = true
				self.new_rotation = new_angle + 1 * (actual_i / #options) - .5

				-- mod.build_animation.animations = {}
				mod.dropdown_positions[entry.attachment_slot][3] = true
				mod.attachment_preview_index = actual_i
				if attachment_data and attachment_data.move then self:start_weapon_move(attachment_data.move) end
				entry.preview_attachment = option.value

				self:set_attachment_info(option.display_name, attachment_data.data)
			end
		end

		if option_hotspot.on_pressed and not option.disabled then
			if not self.build_animation:is_busy() then
				option_hotspot.on_pressed = nil
				new_value = option.id
				real_value = option.value
				content.selected_index = actual_i
				self.dropdown_closing = true
				content.option_disabled = false
				mod.dropdown_positions[entry.attachment_slot][3] = false
			end
		elseif option_hotspot.on_pressed and option.disabled then
			content.option_disabled = true
		end

		local option_display_name = option.display_name
		local option_ignore_localization = option.ignore_localization
		content[option_text_id] = option_ignore_localization and option_display_name or localization_manager:localize(option_display_name)
		local options_y = size[2] * option_index
		style[option_hotspot_id].offset[2] = grow_downwards and options_y or -options_y
		style[option_hotspot_id].on_pressed_sound = not option.disabled and "wwise/events/ui/play_ui_click"
		style[option_hotspot_id].on_pressed_fold_in_sound = not option.disabled and "wwise/events/ui/play_ui_click"
		style[option_text_id].offset[2] = grow_downwards and options_y or -options_y
		local entry_length = using_scrollbar and size[1] - style.scrollbar_hotspot.size[1] or size[1]
		style[outline_style_id].size[1] = not option.disabled and entry_length or 0
		style[outline_style_id].visible = not option.disabled
		style[option_text_id].size[1] = not option.disabled and size[1] or 0
		style["text"].size[1] = size[1]
		-- style["text"].horizontal_alignment = "left"
		-- style["text"].text_horizontal_alignment = "right"
		-- style["text"].size[1] = size[1] * 1.2
		style["text"].offset[1] = size[1] * .025
		style["text"].offset[3] = 20
		option_index = option_index + 1
	end

	local value_changed = new_value ~= nil

	if value_changed and new_value ~= value then
		local on_activated = entry.on_activated

		self.reset_start = nil
		self.do_reset = nil

		on_activated(new_value, entry)
	-- elseif self.dropdown_positions[entry.attachment_slot][3] and not value_changed and #mod.build_animation.animations == 0 then
	-- 	local attachment_data = self.attachment_models[self.cosmetics_view._item_name][value]
	-- 	if attachment_data then
	-- 		local rotation = attachment_data.angle or 0
	-- 		if self._last_rotation_angle ~= rotation then
	-- 			-- mod.do_rotation = true
	-- 			-- mod.new_rotation = rotation
	-- 			self.cosmetics_view._weapon_preview._ui_weapon_spawner._default_rotation_angle = rotation
	-- 		end
	-- 		self.reset_start = t + .1
	-- 	end
	end

	local scrollbar_hotspot = content.scrollbar_hotspot
	local scrollbar_hovered = scrollbar_hotspot.is_hover

	if (input_service:get("left_pressed") or input_service:get("confirm_pressed") or input_service:get("back")) and content.exclusive_focus and not content.wait_next_frame then
		if not self.build_animation:is_busy() then
			content.wait_next_frame = true
			content.reset = true

			return
		end
	end

	if content.wait_next_frame and not content.option_disabled then
		content.wait_next_frame = nil
		content.close_setting = true
		self.dropdown_open = false
		self.dropdown_closing = false

		return
	elseif content.wait_next_frame and content.option_disabled then
		content.option_disabled = nil
		content.wait_next_frame = nil

		return
	end
end

mod.update_custom_widgets = function(self, input_service, dt, t)
    if self.cosmetics_view and self.cosmetics_view._custom_widgets then
        for _, widget in pairs(self.cosmetics_view._custom_widgets) do
            if widget.content and widget.content.entry and widget.content.entry.widget_type == "dropdown" then
				local pivot_name = widget.name.."_pivot"
				pivot_name = string_gsub(pivot_name, "_custom", "")
				local scenegraph_entry = self.cosmetics_view._ui_scenegraph[pivot_name]
				local any_active = false
				for _, data in pairs(mod.dropdown_positions) do
					if data[3] == true then
						any_active = true
						break
					end
				end
				local entry = self.dropdown_positions[widget.content.entry.attachment_slot]
				local text = self.cosmetics_view._widgets_by_name[widget.content.entry.attachment_slot.."_custom_text"]
				local active = entry and entry[3]
				if active or not any_active or not entry then
					widget.alpha_multiplier = math_lerp(widget.alpha_multiplier, 1, dt * 2)
					text.alpha_multiplier = widget.alpha_multiplier
				else
					widget.alpha_multiplier = math_lerp(widget.alpha_multiplier, .25, dt * 2)
					text.alpha_multiplier = widget.alpha_multiplier
				end
				if scenegraph_entry and scenegraph_entry.position then
					if scenegraph_entry.position[2] > grid_size[2] / 2 then
						widget.content.grow_downwards = false
					else
						widget.content.grow_downwards = true
					end
				end
                self:update_dropdown(widget, input_service, dt, t)
            end
        end
    end
end

mod.hide_custom_widgets = function(self, hide)
    if self.cosmetics_view and self.cosmetics_view._custom_widgets then
        for _, widget in pairs(self.cosmetics_view._custom_widgets) do
			if not widget.not_applicable then
            	widget.visible = not hide
			else
				widget.visible = false
			end
        end
		if self.cosmetics_view._custom_widgets_overlapping > 0 then
			self.cosmetics_view._widgets_by_name.panel_extension.visible = not hide
		else
			self.cosmetics_view._widgets_by_name.panel_extension.visible = false
		end
		self.cosmetics_view._widgets_by_name.reset_button.visible = not hide
		self.cosmetics_view._widgets_by_name.randomize_button.visible = not hide
		local demo_mode = mod:get("demo_mode")
		self.cosmetics_view._widgets_by_name.demo_button.visible = demo_mode and not hide
		self.cosmetics_view._widgets_by_name.weapon_customization_scrollbar.visible = not hide and self.cosmetics_view.total_dropdown_height > 950
    end
end

-- ##### ┬  ┬┬┌─┐┬ ┬  ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ #######################################################################
-- ##### └┐┌┘│├┤ │││  ├┤ │ │││││   │ ││ ││││└─┐ #######################################################################
-- #####  └┘ ┴└─┘└┴┘  └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ #######################################################################

mod.validate_item_model = function(self, model)
	self:setup_item_definitions()
	if model ~= "" then
		local definition = mod:persistent_table(REFERENCE).item_definitions[model]
		if definition then
			if definition.workflow_state ~= "RELEASABLE" then
				return false
			end
			if table_find(definition.feature_flags, "FEATURE_unreleased_premium_cosmetics") then
				return false
			end
			-- if table_find(definition.feature_flags, "FEATURE_premium_store") and 
			-- 		not table_find(definition.feature_flags, "FEATURE_item_retained") then
			-- 	return false
			-- end
			-- if not table_find(definition.feature_flags, "FEATURE_item_retained") then
			-- 	return false
			-- end
		end
	end
	return true
end

mod.generate_dropdown_option = function(self, id, display_name, sounds)
    return {
        id = id,
        display_name = display_name,
        ignore_localization = true,
        value = id,
		sounds = sounds,
		disabled = false,
    }
end

mod.add_custom_widget = function(self, widget)
	widget.custom = true
	self.cosmetics_view._custom_widgets[#self.cosmetics_view._custom_widgets+1] = widget
end

mod.find_custom_widget = function(self, name)
	for _, widget in pairs(self.cosmetics_view._custom_widgets) do
		if widget.name == name then
			return widget
		end
	end
end

mod.generate_custom_widgets = function(self)
	local item = self.cosmetics_view._selected_item
	if item then
		-- Iterate scenegraphs additions
		local cosmetics_scenegraphs = mod:get_cosmetics_scenegraphs()
		for _, added_scenegraph in pairs(cosmetics_scenegraphs) do
			-- Differentiate text and dropdown
			if string_find(added_scenegraph, "text_pivot") then
				-- Generate label
				local attachment_slot = string_gsub(added_scenegraph, "_text_pivot", "")
				self:add_custom_widget(self:generate_label(added_scenegraph, attachment_slot, item))
			else
				-- Generate dropdown
				local attachment_slot = string_gsub(added_scenegraph, "_pivot", "")
				self:add_custom_widget(self:generate_dropdown(added_scenegraph, attachment_slot, item))
			end
		end
	end
end

mod.shift_attachments = function(self, progress)
	-- Iterate scenegraph entries
	local cosmetics_scenegraphs = mod:get_cosmetics_scenegraphs()
	for _, scenegraph_name in pairs(cosmetics_scenegraphs) do
		-- Make sure attachment slot is applicable
		if not table_contains(self.cosmetics_view._not_applicable, scenegraph_name) then
			local widget_name = ""
			local is_text = nil
			if string_find(scenegraph_name, "text_pivot") then
				widget_name = string_gsub(scenegraph_name, "_text_pivot", "_custom_text")
				is_text = true
			else
				widget_name = string_gsub(scenegraph_name, "_pivot", "_custom")
			end
			local widget = self:find_custom_widget(widget_name)
			if widget then
				local scenegraph_entry = self.cosmetics_view._ui_scenegraph[scenegraph_name]
				widget.original_y = widget.original_y or widget.offset[2]
				widget.offset[2] = widget.original_y - (self.cosmetics_view.total_dropdown_height - 950) * progress
				local offset = widget.offset[2] + scenegraph_entry.local_position[2]
				widget.visible = offset > 10 and offset < 950 and self.cosmetics_view._selected_tab_index == 3
			end
		end
	end
end

mod.resolve_not_applicable_attachments = function(self)
	local item = self.cosmetics_view._selected_item
	if item then
		-- Get item name
		-- local item_name = self:item_name_from_content_string(item.name)
		local item_name = self.cosmetics_view._item_name
		local move = -10
		-- Iterate attachment slots
		for index, slot in pairs(self.attachment_slots) do
			-- Check that weapon has attachment slot and more than 2 options
			-- 1st option is default
			if self.attachment[item_name] and (not self.attachment[item_name][slot] or #self.attachment[item_name][slot] <= 2)
					and not table_contains(mod.attachment_slots_show_always, slot) then
				-- Set not applicable in widgets to hide them
				self.cosmetics_view._widgets_by_name[slot.."_custom"].not_applicable = true
				self.cosmetics_view._widgets_by_name[slot.."_custom_text"].not_applicable = true
				-- Add to list of not applicable widgets
				self.cosmetics_view._not_applicable[#self.cosmetics_view._not_applicable+1] = slot.."_pivot"
				self.cosmetics_view._not_applicable[#self.cosmetics_view._not_applicable+1] = slot.."_text_pivot"
			end
		end
		-- Move widgets according to their applicable status
		local cosmetics_scenegraphs = mod:get_cosmetics_scenegraphs()
		for _, scenegraph_name in pairs(cosmetics_scenegraphs) do
			if table_contains(self.cosmetics_view._not_applicable, scenegraph_name) then
				-- Differentiate text and dropdown
				if string_find(scenegraph_name, "text_pivot") then
					move = move + label_height
				else
					move = move + dropdown_height
				end
			end
			-- Change scenegraph position
			local scenegraph_entry = self.cosmetics_view._ui_scenegraph[scenegraph_name]
			if scenegraph_entry then
				scenegraph_entry.local_position[2] = scenegraph_entry.local_position[2] - move
				scenegraph_entry.original_y = scenegraph_entry.local_position[2]
				self.cosmetics_view.total_dropdown_height = scenegraph_entry.local_position[2] + dropdown_height
			end
		end
	end
end

mod.resolve_overlapping_widgets = function(self)
	local move = 0
	local overlapping = {}
	-- Iterate scenegraph entries
	local cosmetics_scenegraphs = mod:get_cosmetics_scenegraphs()
	for _, scenegraph_entry in pairs(cosmetics_scenegraphs) do
		-- Make sure attachment slot is applicable
		if not table_contains(self.cosmetics_view._not_applicable, scenegraph_entry) then
			-- Differentiate text and dropdown
			if string_find(scenegraph_entry, "text_pivot") then
				move = move + label_height
			else
				move = move + dropdown_height
			end
			-- Check if widget is overlapping
			if self.cosmetics_view._ui_scenegraph[scenegraph_entry].local_position[2] > grid_size[2] then
				-- Count overlapping attachment slots
				if not string_find(scenegraph_entry, "text_pivot") then
					self.cosmetics_view._custom_widgets_overlapping = self.cosmetics_view._custom_widgets_overlapping + 1
				end
				-- Add overlapping widget to list
				overlapping[#overlapping+1] = scenegraph_entry
			end
		end
	end
	-- Change extension panels size
	local extension_panel_pivot = self.cosmetics_view._ui_scenegraph.panel_extension_pivot
	extension_panel_pivot.size[2] = (85 * self.cosmetics_view._custom_widgets_overlapping) + (edge * 2)
	-- extension_panel_pivot.local_position[1] = grid_size[2] - 85 * (self.cosmetics_view._custom_widgets_overlapping + 1)
	-- extension_panel_pivot.local_position[2] = grid_size[2] - 85 * (self.cosmetics_view._custom_widgets_overlapping + 1)
	-- Change overlapping widgets positions
	local y = -85
	for _, scenegraph_name in pairs(overlapping) do
		local scenegraph_entry = self.cosmetics_view._ui_scenegraph[scenegraph_name]
		-- position = {-90 -(grid_width / 2), 0, z}
		-- local screen_width = RESOLUTION_LOOKUP.width
		-- local screen_height = RESOLUTION_LOOKUP.height
		local corner_top_right = self.cosmetics_view._ui_scenegraph.corner_top_right.world_position
		local grid_pos = self.cosmetics_view._ui_scenegraph.item_grid_pivot.world_position
		local extension_pos = self.cosmetics_view._ui_scenegraph.panel_extension_pivot.world_position
		if string_find(scenegraph_name, "text_pivot") then
			y = y + label_height
		else
			y = y + dropdown_height
		end
		scenegraph_entry.position[1] = extension_pos[1] - grid_pos[1] + 35 -- grid_width / 2 - edge --extension_pos[1] - 
		scenegraph_entry.local_position[2] = extension_pos[2] + y
		scenegraph_entry.local_position[3] = 100
		
	end
end

mod.get_dropdown_positions = function(self)
	if self.cosmetics_view then
		local cosmetics_scenegraphs = mod:get_cosmetics_scenegraphs()
		for _, scenegraph_name in pairs(cosmetics_scenegraphs) do
			if not string_find(scenegraph_name, "text_pivot") then
				local screen_width = RESOLUTION_LOOKUP.width
				local attachment_slot = string_gsub(scenegraph_name, "_pivot", "")
				local scenegraph_entry = self.cosmetics_view._ui_scenegraph[scenegraph_name]
				local entry = self.dropdown_positions[attachment_slot] or {}

				local ui_scenegraph = self.cosmetics_view._ui_scenegraph
				local scale = RESOLUTION_LOOKUP.scale
				local world_position = UIScenegraph.world_position(ui_scenegraph, scenegraph_name)
				local size_width, size_height = UIScenegraph.get_size(ui_scenegraph, scenegraph_name, scale)

				local widget_name = attachment_slot.."_custom"
				local widget = self.cosmetics_view._widgets_by_name[widget_name]
				local y = widget and widget.offset[2] or 0

				if scenegraph_entry.position[1] > screen_width / 2 then
					entry[1] = world_position[1] * scale
				else
					entry[1] = world_position[1] * scale + size_width * scale
				end
				-- entry[1] = world_position[1] * scale + size_width * scale
				entry[2] = world_position[2] * scale + (dropdown_height * scale) / 2 + y
				entry[3] = entry[3] or false
				self.dropdown_positions[attachment_slot] = entry
			end
		end
	end
end

mod.init_custom_weapon_zoom = function(self)
	local item = self.cosmetics_view._selected_item
	if item then
		-- Get item name
		-- local item_name = self:item_name_from_content_string(item.name)
		local item_name = self.cosmetics_view._item_name
		-- Check for weapon in data
		if self.attachment_models[item_name] then
			-- Check for custom weapon zoom
			if self.attachment_models[item_name].customization_min_zoom then
				local min_zoom = self.attachment_models[item_name].customization_min_zoom
				self.cosmetics_view._min_zoom = min_zoom
			else
				self.cosmetics_view._min_zoom = -2
			end
			-- Set zoom
			self.cosmetics_view._weapon_zoom_target = self.cosmetics_view._min_zoom
			self.cosmetics_view._weapon_zoom_fraction = self.cosmetics_view._min_zoom
			self.cosmetics_view:_set_weapon_zoom(self.cosmetics_view._min_zoom)
		end
	end
end

mod.reset_stuff = function(self)
	self:persistent_table(REFERENCE).keep_all_packages = false
	self.demo = nil
	self.move_position = nil
	self.new_position = nil
	self.last_move_position = nil
	self.link_unit_position = nil
	self.do_move = nil
	self.move_end = nil
	self.do_reset = nil
	self.reset_start = nil
	self._last_rotation_angle = 0
	self.mesh_positions = {}
	self.weapon_part_animation_update = nil
	self.build_animation:clear()
	self.preview_flashlight_state = false
end

mod.generate_label = function(self, scenegraph, attachment_slot, item)

	-- local weapon_name = self:item_name_from_content_string(item.name)
	local item_name = self.cosmetics_view._item_name
	local style = table_clone(UIFontSettings.grid_title)
	style.offset = {0, 0, 1}
	local text = "loc_weapon_cosmetics_customization_"..attachment_slot

	if self.text_overwrite[item_name] then
		text = self.text_overwrite[item_name][text] or text
	end

    local definition = UIWidget.create_definition({
        {
            value_id = "text",
            style_id = "text",
            pass_type = "text",
            value = self:localize_or_global(text),
            style = style,
        }
    }, scenegraph, nil)

	local widget_name = attachment_slot.."_custom_text"
	local widget = self.cosmetics_view:_create_widget(widget_name, definition)

	self.cosmetics_view._widgets_by_name[widget_name] = widget
    self.cosmetics_view._widgets[#self.cosmetics_view._widgets+1] = widget

	return widget
end

mod.set_attachment_text = function(self, text, subtext)
	if text then
		-- self._widgets_by_name
	end
end

mod.generate_dropdown = function(self, scenegraph, attachment_slot, item)

	local item_name = self.cosmetics_view._item_name
    local options = {}
    if self.attachment[item_name] and self.attachment[item_name][attachment_slot] then
		self.found_names = nil
        for _, data in pairs(self.attachment[item_name][attachment_slot]) do
			local model = self.attachment_models[item_name][data.id] and self.attachment_models[item_name][data.id].model
			if model and self:validate_item_model(model) then
				local attachment_name = self:get_attachment_weapon_name(item, attachment_slot, data.id) or data.name
            	options[#options+1] = self:generate_dropdown_option(data.id, attachment_name, data.sounds)
			end
        end
    end

    local max_visible_options = 10
    local num_options = #options
    local num_visible_options = math_min(num_options, max_visible_options)

    local size = {grid_size[1], dropdown_height}
    local template = DropdownPassTemplates.settings_dropdown(size[1], size[2], size[1], num_visible_options, true)
	for _, pass in pairs(template) do
		if pass.content_id and string_find(pass.content_id, "option_hotspot") then
			-- local s = string_gsub(pass.content_id, "option_hotspot_", "")
			-- local id = tonumber(s)
			-- pass.content.on_hover_sound = UISoundEvents.default_mouse_hover
			-- pass.change_function = function(content, style)
			-- 	if content.was_hover ~= content.is_hover then
			-- 		mod:unhover_attachment(id)
			-- 	end
			-- 	content.was_hover = content.is_hover
			-- end
			pass.visibility_function = function(content)
				return content.parent.anim_exclusive_focus_progress > 0 and not content.disabled
			end
		end
	end
	template[7].pass_type = "texture"
	template[7].value = "content/ui/materials/backgrounds/terminal_basic"
	template[7].style.horizontal_alignment = "center"

    local definition = UIWidget.create_definition(template, scenegraph, nil, size)
    local widget_name = attachment_slot.."_custom"
    local widget = self.cosmetics_view:_create_widget(widget_name, definition)
	widget.alpha_multiplier = 1
    self.cosmetics_view._widgets_by_name[widget_name] = widget
    self.cosmetics_view._widgets[#self.cosmetics_view._widgets+1] = widget

    local content = widget.content
    content.entry = {
		attachment_slot = attachment_slot,
		attachment_name = "-",
        options = options,
        widget_type = "dropdown",
        on_activated = function(new_value, entry)
			if not mod.build_animation:is_busy() then
				local attachment = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot, self.cosmetics_view._selected_item)
				local attachment_data = self.attachment_models[item_name][attachment]
				local no_animation = attachment_data and attachment_data.no_animation

				if self:get("mod_option_weapon_build_animation") and not no_animation then
					self.weapon_part_animation_update = true
					-- self:detach_attachment(self.cosmetics_view._presentation_item, attachment_slot, attachment, new_value, nil, nil, nil, "attach")
					mod.build_animation:animate(self.cosmetics_view._presentation_item, attachment_slot, attachment, new_value, nil, nil, nil, "attach")
				else
					self:load_new_attachment(self.cosmetics_view._selected_item, attachment_slot, new_value)
					self:play_attachment_sound(self.cosmetics_view._selected_item, attachment_slot, new_value, "attach")
				end

				self.reset_weapon = nil

				local weapon_attachments = self.attachment_models[item_name]
				local attachment_data = weapon_attachments[new_value]
				local new_angle = attachment_data.angle or 0

				-- if string_find(new_value, "default") then
				-- 	self.new_rotation = 0
				-- 	self.do_rotation = true
				-- else
				-- 	self.do_rotation = true
				-- 	self.new_rotation = new_angle
				-- end

				-- if attachment_data.move then
				-- 	self:start_weapon_move(attachment_data.move)
				-- else
				-- 	self:start_weapon_move()
				-- end
				self:start_weapon_move()
			end
        end,
        get_function = function()
            return self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot)
        end,
    }
    local options_by_id = {}
    for index, option in pairs(options) do
        options_by_id[option.id] = option
    end
    content.options_by_id = options_by_id
	content.options = options
    content.num_visible_options = num_visible_options

    content.hotspot.pressed_callback = function ()
		if not self.dropdown_open and not content.disabled then
			if not mod.build_animation:is_busy() then
				if mod:get("mod_option_carousel") then
					local ui_weapon_spawner = self.cosmetics_view._weapon_preview._ui_weapon_spawner
					local attachment_units_3p = ui_weapon_spawner._weapon_spawn_data.attachment_units_3p
					local attachment_unit = attachment_units_3p and mod:get_attachment_slot_in_attachments(attachment_units_3p, attachment_slot)
					local attachment_name = attachment_unit and unit_get_data(attachment_unit, "attachment_name")
					local callback = callback(mod, "create_attachment_array", self.cosmetics_view._selected_item, attachment_slot)
					-- mod.build_animation.animations = {}
					mod.build_animation:clear()
					self.weapon_part_animation_update = true
					-- self:detach_attachment(self.cosmetics_view._presentation_item, attachment_slot, nil, attachment_name, nil, nil, nil, "detach_only", callback)
					mod.build_animation:animate(self.cosmetics_view._presentation_item, attachment_slot, nil, attachment_name, nil, nil, nil, "detach_only", callback)
				end
				local selected_widget = nil
				local selected = true
				content.exclusive_focus = selected
				local hotspot = content.hotspot or content.button_hotspot
				if hotspot then
					hotspot.is_selected = selected
				end
				self.dropdown_open = true
			end
		end
    end

    content.area_length = size[2] * num_visible_options
    local scroll_length = math_max(size[2] * num_options - content.area_length, 0)
    content.scroll_length = scroll_length
    local spacing = 0
    local scroll_amount = scroll_length > 0 and (size[2] + spacing) / scroll_length or 0
    content.scroll_amount = scroll_amount

    return widget
end

mod.update_attachment_info = function(self)
	local visible = self.cosmetics_view._widgets_by_name.attachment_display_name.content.text ~= ""
	self.cosmetics_view._widgets_by_name.attachment_info_box.visible = false
	self.cosmetics_view._widgets_by_name.attachment_display_name.visible = visible
	if self.cosmetics_view.bar_breakdown_widgets_by_name.attachment_bar_1 then
		self.cosmetics_view.bar_breakdown_widgets_by_name.attachment_bar_1.visible = visible
		self.cosmetics_view.bar_breakdown_widgets_by_name.attachment_bar_2.visible = visible
		self.cosmetics_view.bar_breakdown_widgets_by_name.attachment_bar_3.visible = visible
	end
end

mod.set_attachment_info = function(self, display_name, attribute_data)
	if display_name ~= "Default" and attribute_data then
		local tiers = {
			"content/ui/materials/icons/perks/perk_level_01",
			"content/ui/materials/icons/perks/perk_level_02",
			"content/ui/materials/icons/perks/perk_level_03",
			"content/ui/materials/icons/perks/perk_level_04",
			"content/ui/materials/icons/perks/perk_level_05",
		}
		self.cosmetics_view._widgets_by_name.attachment_display_name.content.text = display_name
		-- for i, data in pairs(attribute_data) do
		local index = 1
		for _, column in pairs(attribute_data) do
			for name, tier in pairs(column) do
				local widgets_by_name = self.cosmetics_view.bar_breakdown_widgets_by_name
				local widget = widgets_by_name["attachment_bar_"..tostring(index)]
				if widget then
					widget.content.text = mod:localize_or_global(name)
					widget.content.value_id_1 = tiers[tier]
				end
				index = index + 1
			end
		end
	else
		self.cosmetics_view._widgets_by_name.attachment_display_name.content.text = ""
	end
end

mod.create_bar_breakdown_widgets = function(self)
	self:destroy_bar_breakdown_widgets()

	table.clear(self.cosmetics_view.bar_breakdown_widgets)
	table.clear(self.cosmetics_view.bar_breakdown_widgets_by_name)

	local bar_breakdown_widgets = self.cosmetics_view.bar_breakdown_widgets
	local bar_breakdown_widgets_by_name = self.cosmetics_view.bar_breakdown_widgets_by_name
	local bar_breakdown_widgets_definitions = ViewElementWeaponInfoDefinitions.bar_breakdown_widgets_definitions
	-- local definition = table_clone(bar_breakdown_widgets_definitions.bar_breakdown_slate)
	-- definition.scenegraph_id = "attachment_bar_breakdown_slate"
	-- local widget = UIWidget.init("attachment_bar_breakdown_slate", bar_breakdown_widgets_definitions.bar_breakdown_slate)
	-- widget.scenegraph_id = "attachment_bar_breakdown_slate"
	-- local content = widget.content
	-- local style = widget.style
	-- content.header = "test header" --Localize(bar_data.display_name)
	-- bar_breakdown_widgets[#bar_breakdown_widgets + 1] = widget
	-- bar_breakdown_widgets_by_name.attachment_bar_breakdown_slate = widget
	-- local description_offset = 0
	-- local entry_size = 40
	-- local stripped_bar_data = self:_strip_redundant_stats(bar_data)
	local num_entries = 3 --#stripped_bar_data
	-- local old_desc = content.description
	-- local new_desc = "test" --Localize(bar_data.description or bar_data.display_name .. "_desc")
	-- local ui_renderer = self._ui_grid_renderer
	-- local text_style = style.description
	-- local text_font_data = UIFonts.data_by_type(text_style.font_type)
	-- local text_font = text_font_data.path
	-- local text_size = text_style.size
	-- local text_options = UIFonts.get_font_options_by_style(text_style)
	-- local _, old_text_height = UIRenderer.text_size(ui_renderer, old_desc, text_style.font_type, text_style.font_size, text_size, text_options)
	-- local _, new_text_height = UIRenderer.text_size(ui_renderer, new_desc, text_style.font_type, text_style.font_size, text_size, text_options)
	-- description_offset = math.max(new_text_height - old_text_height, 0) + 20
	-- content.description = new_desc

	-- if bar_data.name ~= "base_rating" then
		for i = 1, num_entries do
			-- local bar_entry = stripped_bar_data[i]
			local definition = table_clone(bar_breakdown_widgets_definitions.entry)
			-- definition.scenegraph_id = "attachment_sub_display_name_"..tostring(i)
			local widget = UIWidget.init("attachment_bar_"..tostring(i), bar_breakdown_widgets_definitions.entry)
			widget.scenegraph_id = "attachment_sub_display_name_"..tostring(i)
			local content = widget.content
			-- local stat_text = self:_get_stats_text(bar_entry)
			content.text = "test stat" --stat_text
			bar_breakdown_widgets[#bar_breakdown_widgets + 1] = widget
			bar_breakdown_widgets_by_name["attachment_bar_"..tostring(i)] = widget
			-- widget.offset[2] = (num_entries - i) * -entry_size
			-- mod:dtf(widget, "widget_"..tostring(i), 5)
		end
	-- end

	-- local grid_length = grid_width --self:grid_length()
	-- local offset = 65
	-- local base_size = 50
	-- local size = base_size + num_entries * entry_size + description_offset
	-- self.cosmetics_view._ui_scenegraph.attachment_bar_breakdown_slate.size[2] = size
	-- self.cosmetics_view._ui_scenegraph.attachment_bar_breakdown_slate.world_position[2] = grid_length - size + offset
	-- self.cosmetics_view._ui_scenegraph.entry.world_position[2] = grid_length - base_size + offset - description_offset
	self.cosmetics_view.bar_breakdown_name = "test name" --stripped_bar_data.name
end

mod.destroy_bar_breakdown_widgets = function(self)
	table.clear(self.cosmetics_view.bar_breakdown_widgets)
	table.clear(self.cosmetics_view.bar_breakdown_widgets_by_name)

	self.cosmetics_view.bar_breakdown_name = nil
end

mod.get_cosmetics_scenegraphs = function(self)
	local cosmetics_scenegraphs = {}
	for _, attachment_slot in pairs(self.attachment_slots) do
		cosmetics_scenegraphs[#cosmetics_scenegraphs+1] = attachment_slot.."_text_pivot"
		cosmetics_scenegraphs[#cosmetics_scenegraphs+1] = attachment_slot.."_pivot"
	end
	return cosmetics_scenegraphs
end