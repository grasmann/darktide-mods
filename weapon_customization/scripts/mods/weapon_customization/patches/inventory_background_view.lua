local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
	local ContentBlueprints = mod:original_require("scripts/ui/views/options_view/options_view_content_blueprints")
	local OptionsViewSettings = mod:original_require("scripts/ui/views/options_view/options_view_settings")
	local UIFontSettings = mod:original_require("scripts/managers/ui/ui_font_settings")
	local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
	local ScriptWorld = mod:original_require("scripts/foundation/utilities/script_world")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
	local Unit = Unit
	local math = math
	local table = table
	local pairs = pairs
	local World = World
	local CLASS = CLASS
	local string = string
	local Camera = Camera
	local vector3 = Vector3
	local get_mod = get_mod
	local Localize = Localize
	local tostring = tostring
	local managers = Managers
	local unit_node = Unit.node
	local Quaternion = Quaternion
	local unit_alive = Unit.alive
	local vector3_box = Vector3Box
	local string_gsub = string.gsub
	local vector3_zero = vector3.zero
	local unit_has_node = Unit.has_node
	local world_link_unit = World.link_unit
	local vector3_unbox = vector3_box.unbox
	local unit_world_pose = Unit.world_pose
	local vector3_distance = vector3.distance
	local world_spawn_unit_ex = World.spawn_unit_ex
	local unit_world_position = Unit.world_position
	local camera_world_position = Camera.world_position
	local quaternion_from_vector = Quaternion.from_vector
	local unit_set_local_position = Unit.set_local_position
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local WEAPON_CUSTOMIZATION_TAB = "tab_weapon_customization"
	local EMPTY_UNIT = "core/units/empty_root"
	local WEAPON_MELEE = "WEAPON_MELEE"
    local WEAPON_RANGED = "WEAPON_RANGED"
--#endregion

mod:hook_require("scripts/ui/views/inventory_background_view/inventory_background_view_definitions", function(instance)



end)

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/ui/views/inventory_background_view/inventory_background_view", function(instance)

	instance.get_inventory_view = function(self)
		self.inventory_view = self.inventory_view or mod:get_view("inventory_view")
	end

	instance.get_modding_tools = function(self)
		self.modding_tools = self.modding_tools or get_mod("modding_tools")
	end

	instance.remove_unit_manipulation = function(self)
		self:get_modding_tools()
		if self.modding_tools and self.modding_tools.unit_manipulation_remove_all then

			self.modding_tools:unit_manipulation_remove_all()

			self._unit_manipulation_added =         nil
		end
	end

	instance.unit_manipulation_busy = function(self)
		self:get_modding_tools()
		if self.modding_tools and self.modding_tools.unit_manipulation_busy then
			return self.modding_tools and self.modding_tools:unit_manipulation_busy()
		end
	end

	instance.unit_manipulation_add = function(self, unit, camera, world, gui, name, node, font_size, button, pressed_callback, changed_callback)
		self:get_modding_tools()
		if self.modding_tools and self.modding_tools.unit_manipulation_add then
			return self.modding_tools:unit_manipulation_add({
				unit = unit, camera = camera, world = world, gui = gui,
				name = name, node = node, font_size = font_size,
				button = button, pressed_callback = pressed_callback, changed_callback = changed_callback,
			})
		end
	end

	instance.unit_manipulation_select = function(self, unit)
		self:get_modding_tools()
		if self.modding_tools and self.modding_tools.unit_manipulation_select then
			self.modding_tools:unit_manipulation_select(unit)
		end
	end

	instance.is_ogryn = function(self)
		-- local player = self.player
		-- local profile = self.profile or player and player:profile()
		return self._spawned_profile and self._spawned_profile.archetype.name == "ogryn"
	end
	
	instance.get_breed = function(self)
		-- return self.back_node == BACKPACK_OFFSET and "ogryn" or "human"
		return self:is_ogryn() and "ogryn" or "human"
	end

	instance.add_custom_panel = function(self)
		if not self._custom_panel_added and self._views_settings then
			local player = self._preview_player
			local profile = player:profile()
			local profile_archetype = profile.archetype
			local archetype_name = profile_archetype.name
			local is_ogryn = archetype_name == "ogryn"
			self._views_settings[#self._views_settings + 1] = {
				view_name = "inventory_view",
				display_name = "loc_visible_equipment_customization",
				update = function (content, style, dt) end,
				view_context = {
					tabs = {
						{
							ui_animation = "cosmetics_on_enter",
							display_name = WEAPON_CUSTOMIZATION_TAB,
							draw_wallet = false,
							allow_item_hover_information = true,
							icon = "content/ui/materials/icons/system/settings/category_gameplay",
							is_grid_layout = false,
							camera_settings = {
								{"event_inventory_set_camera_position_axis_offset", "x", is_ogryn and 1.8 or 1.45, 0.5, math.easeCubic},
								{"event_inventory_set_camera_position_axis_offset", "y", 0, 0.5, math.easeCubic},
								{"event_inventory_set_camera_position_axis_offset", "z", 0, 0.5, math.easeCubic},
								{"event_inventory_set_camera_rotation_axis_offset", "x", 0, 0.5, math.easeCubic},
								{"event_inventory_set_camera_rotation_axis_offset", "y", 0, 0.5, math.easeCubic},
								{"event_inventory_set_camera_rotation_axis_offset", "z", 0, 0.5, math.easeCubic},
							},
							item_hover_information_offset = {0},
							layout = {}
						}
					}
				}
			}
			self._custom_panel_added = true
		end
	end

	-- local unit_list = {}
	local entry_distance = {}
	local closest_4 = {}
	instance.add_unit_manipulation = function(self)
		self:get_inventory_view()
		-- Check modding tools
		self:get_modding_tools()
		-- Check if unit manipulation is already added
		if self.modding_tools then
			-- Check profile spawner
			local ui_profile_spawner = self._profile_spawner
			if self.inventory_view and ui_profile_spawner and ui_profile_spawner._character_spawn_data then
				local character_spawn_data = ui_profile_spawner._character_spawn_data
				local unit = character_spawn_data and character_spawn_data.unit_3p
				local weapon_unit = self.inventory_view:unequipped_weapon_unit()
				local weapon_item = self.inventory_view:unequipped_weapon_item()

				if unit and unit_alive(unit) and not self._unit_manipulation_added then
					
					if self.inventory_view._ui_forward_renderer then
						
						local tab_context = self.inventory_view._active_category_tab_context
						local is_tab = tab_context and tab_context.display_name == WEAPON_CUSTOMIZATION_TAB

						-- Check custom tab
						if is_tab then

							local world = ui_profile_spawner._world
							local camera = ui_profile_spawner and ui_profile_spawner._camera
							local gui = self.inventory_view._ui_forward_renderer.gui

							-- local has_backpack = mod:execute_extension(unit, "visible_equipment_system", "has_backpack")

							-- local points = unit_has_node(unit, "j_frontchestplate") and unit_has_node(unit, "j_backchestplate") and {
							-- 	{node = "j_hips", offset = vector3(0, .2, .1), text = "Hips Front", name = "hips_front"},
							-- 	{node = "j_hips", offset = vector3(0, -.15, .1), text = "Hips Back", name = "hips_back"},
							-- 	{node = "j_hips", offset = vector3(-.15, 0, .1), text = "Hips Left", name = "hips_left"},
							-- 	{node = "j_hips", offset = vector3(.15, 0, .1), text = "Hips Right", name = "hips_right"},
							-- 	{node = "j_leftupleg", offset = vector3(0, 0, 0), text = "Left Leg", name = "leg_left"},
							-- 	{node = "j_rightupleg", offset = vector3(0, 0, 0), text = "Right Leg", name = "leg_right"},
							-- 	{node = "j_frontchestplate", offset = vector3(0, 0, 0), text = "Chest", name = "chest"},
							-- } or {
							-- 	{node = "j_hips", offset = vector3(0, .55, .1), text = "Hips Front", name = "hips_front"},
							-- 	{node = "j_hips", offset = vector3(0, -.4, .1), text = "Hips Back", name = "hips_back"},
							-- 	{node = "j_hips", offset = vector3(-.5, 0, .1), text = "Hips Left", name = "hips_left"},
							-- 	{node = "j_hips", offset = vector3(.5, 0, .1), text = "Hips Right", name = "hips_right"},
							-- 	{node = "j_leftupleg", offset = vector3(0, -.2, 0), text = "Left Leg", name = "leg_left"},
							-- 	{node = "j_rightupleg", offset = vector3(0, .2, 0), text = "Right Leg", name = "leg_right"},
							-- 	{node = "j_spine2", offset = vector3(0, -.5, 0), text = "Chest", name = "chest"},
							-- }
							-- -- Back / backpack
							-- if unit_has_node(unit, "j_frontchestplate") and unit_has_node(unit, "j_backchestplate") then
							-- 	if has_backpack then
							-- 		points[#points+1] = {node = "j_backchestplate", offset = vector3(0, 0, -.15), text = "Backpack Left", name = "backpack_left"}
							-- 		points[#points+1] = {node = "j_backchestplate", offset = vector3(0, 0, .15), text = "Backpack Right", name = "backpack_right"}
							-- 	else
							-- 		points[#points+1] = {node = "j_backchestplate", offset = vector3(0, 0, -.15), text = "Back Left", name = "back_left"}
							-- 		points[#points+1] = {node = "j_backchestplate", offset = vector3(0, 0, .15), text = "Back Right", name = "back_right"}
							-- 	end
							-- else
							-- 	if has_backpack then
							-- 		points[#points+1] = {node = "j_spine2", offset = vector3(-.25, .5, 0), text = "Backpack Left", name = "backpack_left"}
							-- 		points[#points+1] = {node = "j_spine2", offset = vector3(.25, .5, 0), text = "Backpack Right", name = "backpack_right"}
							-- 	else
							-- 		points[#points+1] = {node = "j_spine2", offset = vector3(-.25, .5, 0), text = "Back Left", name = "back_left"}
							-- 		points[#points+1] = {node = "j_spine2", offset = vector3(.25, .5, 0), text = "Back Right", name = "back_right"}
							-- 	end
							-- end

							-- local attach_points = mod.gear_settings:gear_attach_points(self:get_breed())

							-- local unit_list = {}
							-- -- table.clear(unit_list)
							-- for _, point in pairs(attach_points) do
							-- 	local node = unit_node(unit, point.node)
							-- 	local point_unit = world_spawn_unit_ex(world, "core/units/empty_root", nil, unit_world_pose(unit, node))
							-- 	world_link_unit(world, point_unit, 1, unit, node)
							-- 	unit_set_local_position(point_unit, 1, vector3_unbox(point.offset))
							-- 	unit_list[point.text] = {
							-- 		unit = point_unit,
							-- 		data = point,
							-- 		unit_manipulation = self:unit_manipulation_add(point_unit, camera, world, gui, point.text, nil, 20, true, function(extension)
							-- 			local name = ui_profile_spawner.help_units[point.text]
							-- 			name = name and name.data and name.data.name
							-- 			if name and weapon_item.item_type == WEAPON_RANGED then
							-- 				if mod.gear_settings:has_temp_settings(weapon_item) then
							-- 					mod.gear_settings:set(weapon_item, "gear_node", name)
							-- 					managers.event:trigger("weapon_customization_attach_point_changed")
							-- 				end
							-- 			end
							-- 		end),
							-- 	}
							-- end

							-- local unit_list = mod.gear_settings:spawn_gear_attach_points(self:get_breed(), world, weapon_unit)
							-- if unit_list then
							-- 	for _, entry in pairs(t) do
									
							-- 	end
							-- end
							
							-- ui_profile_spawner.help_units = unit_list

							self:unit_manipulation_add(weapon_unit, camera, world, gui, "weapon")
							-- self:unit_manipulation_select(weapon_unit)

							-- self.modding_tools:inspect("weapon_item", weapon_item, gui)
							-- self.modding_tools:show_console(true)
							-- self.modding_tools:console_print(weapon_item)
							
							-- mod:echo(weapon_item)
							-- mod:echo(character_spawn_data.profile)
							-- mod:dtf(weapon_item, "weapon_item", 5)
							
							self._unit_manipulation_added = true
						end
					end
				elseif self._unit_manipulation_added then

					-- if ui_profile_spawner.help_units then

					-- 	-- local entry_distance = {}
					-- 	table.clear(entry_distance)
						
					-- 	for attach_name, entry in pairs(ui_profile_spawner.help_units) do
					-- 		local camera_position = camera_world_position(ui_profile_spawner._camera)
					-- 		local distance = vector3_distance(camera_position, unit_world_position(entry.unit, 1))
					-- 		entry_distance[attach_name] = distance
					-- 	end
					-- 	-- local closest_4 = {}
					-- 	table.clear(closest_4)
					-- 	for i = 1, 4, 1 do
					-- 		local last = math.huge
					-- 		local closest = nil
					-- 		for attach_name, distance in pairs(entry_distance) do
					-- 			if distance < last then
					-- 				last = distance
					-- 				closest = attach_name
					-- 			end
					-- 		end
					-- 		closest_4[#closest_4+1] = ui_profile_spawner.help_units[closest]
					-- 		entry_distance[closest] = nil
					-- 	end
					-- 	for attach_name, entry in pairs(ui_profile_spawner.help_units) do
					-- 		if entry.unit_manipulation then
					-- 			entry.unit_manipulation.show = false
					-- 		end
					-- 	end
					-- 	for _, entry in pairs(closest_4) do
					-- 		if entry.unit_manipulation then
					-- 			entry.unit_manipulation.show = true
					-- 		end
					-- 	end
					-- end

				end

				-- Disable rotation when interacting with modding tools
				ui_profile_spawner._rotation_input_disabled = self:unit_manipulation_busy()
			end
		end
		if self.inventory_view then
			local wbn = self.inventory_view._widgets_by_name
				if wbn then wbn.name_text.content.text = self._item_name or "n/a" end
		end
	end

	instance.update_item_name = function(self)
		self:get_inventory_view()
		if self._profile_spawner and self.inventory_view then
			local slot_id = self._preview_wield_slot_id == "slot_primary" and "slot_secondary" or "slot_primary"
			local preview_profile_equipped_items = self._preview_profile_equipped_items
			local presentation_inventory = preview_profile_equipped_items
			local slot_item = presentation_inventory[slot_id]
			local item_name = Localize(slot_item.display_name)
			self._item_name = item_name
			-- Rotation
			self._profile_spawner._rotation_angle = self.inventory_view.customization_angle and self.inventory_view:customization_angle() or 0
		end
	end

	instance.reset_rotation = function(self)
		self:get_inventory_view()
		if self.inventory_view then
			self.inventory_view:reset_rotation()
		end
	end

	instance.custom_enter = function(self)

		managers.event:register(self, "weapon_customization_weapon_changed", "on_weapon_changed")

		-- Modding tools
		self:remove_unit_manipulation()

	end

	instance.custom_exit = function(self)

		managers.event:unregister(self, "weapon_customization_weapon_changed")

		-- Modding tools
		self:remove_unit_manipulation()

	end

	instance.respawn_profile = function(self)
		self:_spawn_profile(self._spawned_profile)
	end

	instance.on_weapon_changed = function(self)
		self:respawn_profile()
	end

end)

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #############################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################################################

mod:hook(CLASS.InventoryBackgroundView, "on_enter", function(func, self, ...)

	-- Custom enter
	self:custom_enter()

	-- Original function
	func(self, ...)

end)

mod:hook(CLASS.InventoryBackgroundView, "on_exit", function(func, self, ...)

	-- Custom exit
	self:custom_exit()

	-- Destroy background view
	self.inventory_view = nil

	-- Original function
	func(self, ...)

end)

mod:hook(CLASS.InventoryBackgroundView, "_update_has_empty_talent_nodes", function(func, self, optional_selected_nodes, ...)

	-- Custom panel
	self:add_custom_panel()

	-- Original function
	func(self, optional_selected_nodes, ...)

end)

mod:hook(CLASS.InventoryBackgroundView, "update", function(func, self, dt, t, input_service, ...)

	-- Original function
	local ret = func(self, dt, t, input_service, ...)

	-- if mod.test_table and mod.test_table.t < t then
	-- 	mod.test_table.t = t + 1
	-- 	mod.test_table.text = "test_value_"..tostring(mod.test_table.index)
	-- 	mod.test_table.index = mod.test_table.index + 1
	-- elseif not mod.test_table then
	-- 	mod.test_table = {
	-- 		text = "test_value_1",
	-- 		index = 1,
	-- 		t = t + 1,
	-- 	}
	-- 	self.modding_tools:inspect("test_table", mod.test_table)
	-- end

	-- -- Add unit manipulation
	self:add_unit_manipulation()

	-- Return
	return ret
end)

mod:hook(CLASS.InventoryBackgroundView, "cb_on_weapon_swap_pressed", function(func, self, ...)

	-- Rotation
	self:reset_rotation()

	-- Original function
	func(self, ...)

end)

mod:hook(CLASS.InventoryBackgroundView, "_update_presentation_wield_item", function(func, self, ...)

	-- Modding tools
	self:remove_unit_manipulation()

	-- Original function
	func(self, ...)

	-- Update weapon name
	self:update_item_name()

end)