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
	local ScriptGui = mod:original_require("scripts/foundation/utilities/script_gui")
	local UIScenegraph = mod:original_require("scripts/managers/ui/ui_scenegraph")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
	local Unit = Unit
	local math = math
	local pairs = pairs
	local table = table
	local CLASS = CLASS
	local Color = Color
	local string = string
	local Camera = Camera
	local get_mod = get_mod
	local vector3 = Vector3
	local vector2 = Vector2
	local tostring = tostring
	local managers = Managers
	local Localize = Localize
	local callback = callback
	local unit_box = Unit.box
	local math_huge = math.huge
	local Matrix4x4 = Matrix4x4
	local unit_alive = Unit.alive
	local string_gsub = string.gsub
	local table_clear = table.clear
	local table_contains = table.contains
	local vector3_distance = vector3.distance
	local RESOLUTION_LOOKUP = RESOLUTION_LOOKUP
	local unit_world_position = Unit.world_position
	local matrix4x4_translation = Matrix4x4.translation
	local camera_world_position = Camera.world_position
	local camera_world_to_screen = Camera.world_to_screen
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local SLOT_PRIMARY = "slot_primary"
	local SLOT_SECONDARY = "slot_secondary"
	local WEAPON_CUSTOMIZATION_TAB = "tab_weapon_customization"
	local BACKPACK_EMPTY = "content/items/characters/player/human/backpacks/empty_backpack"
	local weapon_items = {}
	local entry_distance = {}
	local closest_6 = {}
	local entry_show = {}
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/ui/views/inventory_view/inventory_view", function(instance)

	-- instance._setup_forward_gui = function(self)
	-- 	if not self._ui_forward_renderer_id then
	-- 		self._unique_id = self._unique_id or self.__class_name.."_"..mod:cached_gsub(tostring(self), "table: ", "")
	-- 		self._ui_forward_renderer_id = self._unique_id.."_forward_renderer"
	-- 		self._ui_forward_renderer = managers.ui:create_renderer(self._ui_forward_renderer_id, self._world)
	-- 	end
	-- end

	-- instance._destroy_forward_gui = function(self)
	-- 	if self._ui_forward_renderer then
	-- 		self._ui_forward_renderer = nil
	-- 		managers.ui:destroy_renderer(self._ui_forward_renderer_id)
	-- 	end
	-- end

	instance.forward_gui = function(self)
		return (self._ui_forward_renderer and self._ui_forward_renderer.gui)
			or (self._ui_default_renderer and self._ui_default_renderer.gui)
			or (self._ui_renderer and self._ui_renderer.gui)
			or (self._ui_offscreen_renderer and self._ui_offscreen_renderer.gui)
	end

	instance.player_profile = function(self)
		local player = self._preview_player
		-- Check if player is not destroyed
		if player and table_contains(managers.player:players(), player) then
			return player and player:profile()
		end
	end

	instance.player_archetype = function(self)
		local profile = self:player_profile()
		return profile and profile.archetype or "human"
	end

	instance.character_name = function(self)
		local profile = self:player_profile()
		return profile and profile.name
	end

	instance.get_inventory_background_view = function(self)
		self.inventory_background_view = self.inventory_background_view or mod:get_view("inventory_background_view")
	end

	instance.unequipped_slot_id = function(self)
		self:get_inventory_background_view()
		if self.inventory_background_view then
			return self.inventory_background_view._preview_wield_slot_id == SLOT_PRIMARY and SLOT_SECONDARY or SLOT_PRIMARY
		end
	end

	instance.unequipped_weapon_unit = function(self)
		self:get_inventory_background_view()
		if self.inventory_background_view and self.inventory_background_view._profile_spawner then
			local character_spawn_data = self.inventory_background_view._profile_spawner._character_spawn_data
			if character_spawn_data and character_spawn_data.unit_3p and unit_alive(character_spawn_data.unit_3p) then
				return mod:execute_extension(character_spawn_data.unit_3p, "visible_equipment_system", "weapon_unit", self:unequipped_slot_id())
			end
		end
	end

	instance.weapon_items = function(self)
		table_clear(weapon_items)
		self:get_inventory_background_view()
		if self.inventory_background_view then
			local profile = self:player_profile()
			if profile then
				weapon_items[1] = profile.loadout[SLOT_PRIMARY]
				weapon_items[2] = profile.loadout[SLOT_SECONDARY]
			end
		end
		return weapon_items
	end

	instance.unequipped_weapon_item = function(self)
		self:get_inventory_background_view()
		if self.inventory_background_view then
			local profile = self:player_profile()
			return profile and profile.loadout[self:unequipped_slot_id()]
		end
	end

	instance.weapon_name = function(self)
		self:get_inventory_background_view()
		if self.inventory_background_view and self.inventory_background_view._profile_spawner then
			local preview_profile_equipped_items = self.inventory_background_view._preview_profile_equipped_items
			local slot_item = preview_profile_equipped_items and preview_profile_equipped_items[self:unequipped_slot_id()]
			return slot_item and Localize(slot_item.display_name)
		end
	end

	instance.is_tab = function(self, tab_context)
		local tab_context = tab_context or self._active_category_tab_context
		return tab_context and tab_context.display_name == WEAPON_CUSTOMIZATION_TAB
	end

	instance.customization_angle = function(self)
		if self:is_tab() then
			return self:unequipped_slot_id() == SLOT_PRIMARY and 2 or 4.5
		end
	end

	instance.has_backpack = function(self)
		local item = self._preview_profile_equipped_items["slot_gear_extra_cosmetic"]
		return item and item.name and not mod:cached_find(item.name, "empty_backpack")
	end

	instance.backpack_name = function(self)
		local profile = self:player_profile()
		local item = profile and profile.loadout.slot_gear_extra_cosmetic
		return item and Localize(item.display_name)
	end

	instance.armour_name = function(self)
		local profile = self:player_profile()
		local item = profile and profile.loadout.slot_gear_upperbody
		return item and Localize(item.display_name)
	end

	instance.button_pressed = function(self, button)
		if button.name == "visible_equipment_save_button" then
			self:save_offset()
		elseif button.name == "visible_equipment_reset_button" then
			self:reset_offset()
		elseif button.content.gear_node then
			if mod.gear_settings:has_temp_settings(self:unequipped_weapon_item()) then
				mod.gear_settings:set(self:unequipped_weapon_item(), "gear_node", button.content.gear_node)
				managers.event:trigger("weapon_customization_attach_point_changed")
			end
		end
	end

	instance.update_checktbox = function(self, checkbox)
		checkbox.style.option_1.visible = checkbox.content.value
		checkbox.style.option_2.visible = not checkbox.content.value
	end

	instance.toggle_checkbox = function(self, checkbox)
		checkbox.content.value = not checkbox.content.value
		mod:set(checkbox.content.saved_option, checkbox.content.value)
		self:update_checktbox(checkbox)
		self:checkbox_changed(checkbox, checkbox.content.value)
	end

	instance.checkbox_changed = function(self, checkbox, value)
	end

	instance.add_widget = function(self, widget)
		if widget then
			self._widgets[#self._widgets+1] = widget
			self._widgets_by_name[widget.name] = widget
			return widget
		end
	end

	instance.armour_option = function(self)
		return self._widgets_by_name["visible_equipment_option_3"].content.value
	end

	instance.backpack_option = function(self)
		return self._widgets_by_name["visible_equipment_option_4"].content.value
	end

	instance.weapon_option = function(self)
		return self._widgets_by_name["visible_equipment_option_2"].content.value
	end

	instance.character_option = function(self)
		return self._widgets_by_name["visible_equipment_option_1"].content.value
	end

	instance.draw_gear_node_lines = function(self)

		local gui = self:forward_gui()
		if gui then
			local ui_profile_spawner = self:profile_spawner()
			local camera = ui_profile_spawner and ui_profile_spawner._camera
			local gear_nodes = mod.gear_settings:gear_attach_points(self:player_archetype())
			local character_spawn_data = ui_profile_spawner and ui_profile_spawner._character_spawn_data
			local unit = character_spawn_data and character_spawn_data.unit_3p
			if unit and self:is_tab() then
				local gear_node_units = mod:execute_extension(unit, "visible_equipment_system", "gear_node_units")

				if gear_node_units then

					table_clear(entry_distance)
					
					for _, gear_node in pairs(gear_nodes) do
						local unit = gear_node_units[gear_node.name]
						if unit and unit_alive(unit) then
							local camera_position = camera_world_position(camera)
							local distance = vector3_distance(camera_position, unit_world_position(unit, 1))
							entry_distance[gear_node.name] = distance
						end
					end

					table_clear(closest_6)
					for i = 1, 6, 1 do
						local last = math.huge
						local closest = nil
						for attach_name, distance in pairs(entry_distance) do
							if distance < last then
								last = distance
								closest = attach_name
							end
						end
						closest_6[#closest_6+1] = closest
						entry_distance[closest] = nil
					end

					for _, gear_node in pairs(gear_nodes) do
						entry_show[gear_node.name] = false
					end
					for _, gear_node_name in pairs(closest_6) do
						entry_show[gear_node_name] = true
					end

					for _, gear_node in pairs(gear_nodes) do
						
						local back = (gear_node.name ~= "back_left" and gear_node.name ~= "back_right") or not self:has_backpack()
						local backpack = (gear_node.name ~= "backpack_left" and gear_node.name ~= "backpack_right") or self:has_backpack()
						local one_hip = gear_node.name ~= "hips_back" or not self._widgets_by_name["hips_front_button"].visible
						self._widgets_by_name[tostring(gear_node.name).."_button"].visible = self:is_tab() and back and backpack and one_hip and entry_show[gear_node.name]

						local unit = gear_node_units[gear_node.name]
						if unit and unit_alive(unit) and self._widgets_by_name[tostring(gear_node.name).."_button"].visible then
							-- local box = unit_box(unit, false)
							-- local center_position = matrix4x4_translation(box)
							-- local world_to_screen, distance = camera_world_to_screen(camera, center_position)
							
							-- local ui_scenegraph = self._ui_scenegraph
							-- local scale = RESOLUTION_LOOKUP.scale
							-- local screen_width = RESOLUTION_LOOKUP.width
							-- local screen_height = RESOLUTION_LOOKUP.height
							-- local scenegraph_entry_name = tostring(gear_node.name).."_button_pivot"
							-- local world_position = UIScenegraph.world_position(ui_scenegraph, scenegraph_entry_name)
							
							-- local size_width, size_height = UIScenegraph.get_size(ui_scenegraph, scenegraph_entry_name, scale)
							-- local scenegraph_entry = ui_scenegraph[scenegraph_entry_name]

							-- local origin = vector2(
							-- 	world_position[1] * scale + (screen_width * scale) / 4,
							-- 	world_position[2] * scale
							-- )

							-- if gear_node.name == "chest" then
							-- 	origin[1] = origin[1] + (size_width * scale) / 2 - 10 * scale
							-- 	origin[2] = origin[2] + size_height * scale + 15 * scale
							-- end
							-- if gear_node.name == "hips_front" or gear_node.name == "hips_back" then
							-- 	origin[1] = origin[1] + (size_width * scale) / 2 - 10 * scale
							-- end
							-- if gear_node.name == "back_left" or gear_node.name == "backpack_left" or gear_node.name == "hips_left" or gear_node.name == "leg_left" then
							-- 	origin[1] = origin[1] + size_width * scale + 20 * scale
							-- 	origin[2] = origin[2] + (size_height * scale) / 2 + 5 * scale
							-- end
							-- if gear_node.name == "back_right" or gear_node.name == "backpack_right" or gear_node.name == "hips_right" or gear_node.name == "leg_right" then
							-- 	origin[1] = origin[1] - 55 * scale
							-- 	origin[2] = origin[2] + (size_height * scale) / 2 + 5 * scale
							-- end

							-- local color = Color(255, 49, 62, 45)
							-- ScriptGui.hud_line(gui, origin, world_to_screen, 100, 2, Color(255, 106, 121, 100))

						else
							
							self._widgets_by_name[tostring(gear_node.name).."_button"].visible = false

						end

					end
				end

			end
		end

	end

	instance.profile_spawner = function(self)
		self:get_inventory_background_view()
		if self.inventory_background_view then
			return self.inventory_background_view._profile_spawner
		end
	end

	instance.profile_spawner_unit = function(self)
		local profile_spawner = self:profile_spawner()
		local character_spawn_data = profile_spawner and profile_spawner._character_spawn_data
		return character_spawn_data and character_spawn_data.unit_3p
	end

	--#region Animation
		-- instance.freeze_animation = function(self)
		-- 	local unit = self:profile_spawner_unit()
		-- 	if unit and unit_alive(unit) then
		-- 		-- Unit.disable_animation_state_machine(unit)
		-- 		self.frozen = true
		-- 	end
		-- end

		-- instance.unfreeze_animation = function(self)
		-- 	local unit = self:profile_spawner_unit()
		-- 	if unit and unit_alive(unit) then
		-- 		-- Unit.enable_animation_state_machine(unit)
		-- 		self.frozen = nil
		-- 	end
		-- end
	--#endregion

	instance.respawn_profile = function(self)
		local profile_spawner = self:profile_spawner()
		if profile_spawner then
			local profile = self.inventory_background_view._presentation_profile
			self.inventory_background_view:_spawn_profile(profile)
		end
	end

	instance.set_rotation = function(self)
		self:get_inventory_background_view()
		if self.inventory_background_view and self.inventory_background_view._profile_spawner then
			self.inventory_background_view._profile_spawner._rotation_angle = self:customization_angle() or 0
		end
	end

	instance.reset_rotation = function(self)
		local profile_spawner = self:profile_spawner()
		if profile_spawner then
			local rotation_angle = profile_spawner._rotation_angle
			profile_spawner._previous_rotation_angle = rotation_angle
			profile_spawner._rotation_angle = 0
		end
	end

	instance.reset_offset = function(self)
		local weapon_item = self:unequipped_weapon_item()
		local weapon_unit = self:unequipped_weapon_unit()
		if weapon_item and weapon_unit and unit_alive(weapon_unit) then
			-- mod.gear_settings:set(weapon_item, "gear_node", nil)
			-- mod.gear_settings:save(weapon_item, weapon_unit)
			mod.gear_settings:destroy_temp_settings(weapon_item)
			mod.gear_settings:create_temp_settings(weapon_item)
			managers.event:trigger("weapon_customization_attach_point_changed")
		end
	end

	instance.save_offset = function(self)
		local weapon_item = self:unequipped_weapon_item()
		local weapon_unit = self:unequipped_weapon_unit()
		if weapon_item and weapon_unit and unit_alive(weapon_unit) then
			mod.gear_settings:save(weapon_item, weapon_unit)
			managers.event:trigger("weapon_customization_attach_point_changed")
		end
	end

	instance.button = function(self, name, size, scenegraph_id)
		local config = {
			display_name = "loc_"..name,
			value_width = 275,
		}
		local gear_node = string.gsub(name, "_button", "")
		local widget = nil
		local template = ContentBlueprints["button"]
		local size = template.size_function and template.size_function(self, config) or template.size
		config.size = size
		local indentation_level = config.indentation_level or 0
		local indentation_spacing = OptionsViewSettings.indentation_spacing * indentation_level
		local new_size = {size[1] - 300 - indentation_spacing, size[2]}
		local pass_template_function = template.pass_template_function
		local pass_template = pass_template_function and pass_template_function(self, config, new_size) or template.pass_template
		local widget_definition = pass_template and UIWidget.create_definition(pass_template, scenegraph_id, nil, new_size)
		if widget_definition then
			widget = self:_create_widget(name, widget_definition)
			if widget then
				widget.type = "button"
				local init = template.init
				if init then init(self, widget, config) end
				widget.content.button_text = Localize("loc_"..name.."_prompt")
				widget.content.gear_node = gear_node
				-- widget.content.hotspot.disabled = true
				widget.content.hotspot.pressed_callback = callback(self, "button_pressed", widget)
				widget.style.hotspot.size = {275, 50}
				widget.style.hotspot.offset = {425, 0, 0}
				widget.style.background_selected.visible = false
				widget.style.frame_highlight.visible = false
				widget.style.list_header.visible = false
				-- mod:dtf(widget, "button", 5)
				return widget
			end
		end
	end
	
	instance.checkbox = function(self, name, size, scenegraph_id, option)
		local config = {
			display_name = "loc_"..name,
			value_width = 425,
		}
		local widget = nil
		local template = ContentBlueprints["checkbox"]
		local size = template.size_function and template.size_function(self, config) or template.size
		config.size = size
		local indentation_level = config.indentation_level or 0
		local indentation_spacing = OptionsViewSettings.indentation_spacing * indentation_level
		local new_size = {size[1] - 350 - indentation_spacing, size[2] - 10}
		local pass_template_function = template.pass_template_function
		local pass_template = pass_template_function and pass_template_function(self, config, new_size) or template.pass_template
		local widget_definition = pass_template and UIWidget.create_definition(pass_template, scenegraph_id, nil, new_size)
		if widget_definition then
			widget = self:_create_widget(name, widget_definition)
			if widget then
				widget.type = "checkbox"
				local init = template.init
				if init then init(self, widget, config) end
				widget.content.value = mod:get(option) or false
				widget.content.saved_option = option
				widget.content.hotspot.pressed_callback = callback(self, "toggle_checkbox", widget)
				widget.style.option_1.offset[1] = -20
				widget.style.option_1.size[1] = 500
				widget.style.option_1.text_horizontal_alignment = "right"
				widget.style.option_2.offset[1] = -20
				widget.style.option_2.size[1] = 500
				widget.style.option_2.text_horizontal_alignment = "right"
				widget.style.style_id_6.offset[2] = 100
				widget.style.style_id_6.size[2] = size[2] - 10
				self:update_checktbox(widget)
	
				widget.style.background_selected.visible = false
				widget.style.frame_highlight.visible = false
				widget.content.option_1 = "n/a"
				widget.content.option_2 = "n/a"
				if not self:backpack_name() then
	
				end
				-- mod:dtf(widget, "checkbox", 5)
				return widget
			end
		end
	end
	
	instance.value_slider = function(self, name, size, scenegraph_id, value_text)
		local config = {
			min_value = -100,
			step_size_value = 1,
			max_value = 100,
			apply_on_drag = true,
			display_name = "loc_"..name,
			default_value = 0,
			slider_value = .5,
			get_function = function()
				return .5
			end,
			value_width = size[1],
		}
		local widget_type = "value_slider"
		local widget = nil
		local template = ContentBlueprints[widget_type]
		config.size = size
		local indentation_level = config.indentation_level or 0
		local indentation_spacing = OptionsViewSettings.indentation_spacing * indentation_level
		local new_size = {size[1] - indentation_spacing, size[2]}
		local pass_template_function = template.pass_template_function
		local pass_template = pass_template_function and pass_template_function(self, config, new_size) or template.pass_template
		local widget_definition = pass_template and UIWidget.create_definition(pass_template, scenegraph_id, nil, new_size)
		if widget_definition then
			widget = self:_create_widget(name, widget_definition)
			if widget then
				widget.type = widget_type
				widget.content.value_text = value_text
				if template.init then template.init(self, widget, config) end
				-- mod:dtf(widget, "slider", 5)
				return widget
			end
		end
	end

	instance.get_modding_tools = function(self)
		self.modding_tools = self.modding_tools or get_mod("modding_tools")
	end

	instance.add_unit_manipulation = function(self)
		self:get_inventory_background_view()
		if self.inventory_background_view then
			self.inventory_background_view:add_unit_manipulation()
		end
	end

	instance.remove_unit_manipulation_all = function(self)
		self:get_modding_tools()
		if self.modding_tools then
			self.inventory_background_view:remove_unit_manipulation()
		end
	end

	instance.create_custom_widgets = function(self)
		local size = {600, 50}
		local y = 100
		-- Create custom checkboxes
		local gear_nodes = mod.gear_settings:gear_attach_points(self:player_archetype())
		for _, gear_node in pairs(gear_nodes) do
			local new_widget = self:add_widget(self:button(tostring(gear_node.name).."_button", size, tostring(gear_node.name).."_button_pivot"))
			new_widget.content.button_text = mod:localize("loc_visible_equipment_"..gear_node.name)
		end
		-- Create custom buttons
		self:add_widget(self:button("visible_equipment_save_button", size, "save_button_pivot"))
		self:add_widget(self:button("visible_equipment_reset_button", size, "reset_button_pivot"))
	end

	instance.update_custom_widget_visibility = function(self)
		local is_tab = self:is_tab()
		-- Update gear node widgets
		local gear_nodes = mod.gear_settings:gear_attach_points(self:player_archetype())
		for _, gear_node in pairs(gear_nodes) do
			local gear_node_widget = self._widgets_by_name[tostring(gear_node.name).."_button"]
			if gear_node_widget then
				gear_node_widget.visible = is_tab and gear_node_widget.visible or false
			end
		end
		-- Update name widget
		if self._widgets_by_name.name_text then
			self._widgets_by_name.name_text.content.text = tostring(self:weapon_name()).."\n"..tostring(mod.gear_settings:gear_id(self:unequipped_weapon_item()))
			self._widgets_by_name.name_text.visible = is_tab
		end
		-- Update save and reset buttons
		if self._widgets_by_name.visible_equipment_save_button then
			self._widgets_by_name.visible_equipment_save_button.visible = is_tab
		end
		if self._widgets_by_name.visible_equipment_reset_button then
			self._widgets_by_name.visible_equipment_reset_button.visible = is_tab
		end
	end

	instance.create_temp_settings = function(self)
		local weapon_items = self:weapon_items()
		if weapon_items then
			for _, weapon_item in pairs(weapon_items) do
				mod.gear_settings:create_temp_settings(weapon_item)
			end
			managers.event:trigger("weapon_customization_attach_point_changed")
		end
	end

	instance.destroy_temp_settings = function(self)
		local weapon_items = self:weapon_items()
		if weapon_items then
			for _, weapon_item in pairs(weapon_items) do
				if mod.gear_settings:has_temp_settings(weapon_item) then
					mod.gear_settings:destroy_temp_settings(weapon_item)
				end
			end
			managers.event:trigger("weapon_customization_attach_point_changed")
		end
	end

end)

-- ##### ┬  ┬┬┌─┐┬ ┬  ┌┬┐┌─┐┌─┐┬┌┐┌┬┌┬┐┬┌─┐┌┐┌┌─┐ #####################################################################
-- ##### └┐┌┘│├┤ │││   ││├┤ ├┤ │││││ │ ││ ││││└─┐ #####################################################################
-- #####  └┘ ┴└─┘└┴┘  ─┴┘└─┘└  ┴┘└┘┴ ┴ ┴└─┘┘└┘└─┘ #####################################################################

mod:hook_require("scripts/ui/views/inventory_view/inventory_view_definitions", function(instance)
	local x_base, y_base = 450, 300
	local size = {600, 50}

	-- Create name text pivot
	instance.scenegraph_definition.name_text_pivot = {
		vertical_alignment = "top",
		parent = "screen",
		horizontal_alignment = "center",
		size = {600, 50},
		position = {x_base, y_base - 150, 0},
	}

	-- Creat option checkbox pivots
	local gear_nodes = mod.gear_settings:gear_attach_points("human")
	for _, gear_node in pairs(gear_nodes) do
		instance.scenegraph_definition[tostring(gear_node.name).."_button_pivot"] = {
			vertical_alignment = "top",
			parent = "screen",
			horizontal_alignment = "center",
			size = {200, 50},
			position = {0, 0, 0},
		}
	end

	instance.scenegraph_definition.hips_front_button_pivot.horizontal_alignment = "left"
	instance.scenegraph_definition.hips_front_button_pivot.vertical_alignment = "bottom"
	instance.scenegraph_definition.hips_front_button_pivot.position = {100, -100, 0}
	instance.scenegraph_definition.hips_back_button_pivot.horizontal_alignment = "left"
	instance.scenegraph_definition.hips_back_button_pivot.vertical_alignment = "bottom"
	instance.scenegraph_definition.hips_back_button_pivot.position = {100, -100, 0}

	instance.scenegraph_definition.hips_left_button_pivot.horizontal_alignment = "left"
	instance.scenegraph_definition.hips_left_button_pivot.vertical_alignment = "bottom"
	instance.scenegraph_definition.hips_left_button_pivot.position = {-300, -400, 0}
	instance.scenegraph_definition.hips_right_button_pivot.horizontal_alignment = "left"
	instance.scenegraph_definition.hips_right_button_pivot.vertical_alignment = "bottom"
	instance.scenegraph_definition.hips_right_button_pivot.position = {500, -400, 0}

	instance.scenegraph_definition.leg_left_button_pivot.horizontal_alignment = "left"
	instance.scenegraph_definition.leg_left_button_pivot.vertical_alignment = "bottom"
	instance.scenegraph_definition.leg_left_button_pivot.position = {-250, -200, 0}
	instance.scenegraph_definition.leg_right_button_pivot.horizontal_alignment = "left"
	instance.scenegraph_definition.leg_right_button_pivot.vertical_alignment = "bottom"
	instance.scenegraph_definition.leg_right_button_pivot.position = {450, -200, 0}

	instance.scenegraph_definition.backpack_left_button_pivot.horizontal_alignment = "left"
	instance.scenegraph_definition.backpack_left_button_pivot.vertical_alignment = "bottom"
	instance.scenegraph_definition.backpack_left_button_pivot.position = {-300, -700, 0}
	instance.scenegraph_definition.backpack_right_button_pivot.horizontal_alignment = "left"
	instance.scenegraph_definition.backpack_right_button_pivot.vertical_alignment = "bottom"
	instance.scenegraph_definition.backpack_right_button_pivot.position = {500, -700, 0}

	instance.scenegraph_definition.back_left_button_pivot.horizontal_alignment = "left"
	instance.scenegraph_definition.back_left_button_pivot.vertical_alignment = "bottom"
	instance.scenegraph_definition.back_left_button_pivot.position = {-300, -700, 0}
	instance.scenegraph_definition.back_right_button_pivot.horizontal_alignment = "left"
	instance.scenegraph_definition.back_right_button_pivot.vertical_alignment = "bottom"
	instance.scenegraph_definition.back_right_button_pivot.position = {500, -700, 0}

	instance.scenegraph_definition.chest_button_pivot.horizontal_alignment = "left"
	instance.scenegraph_definition.chest_button_pivot.vertical_alignment = "top"
	instance.scenegraph_definition.chest_button_pivot.position = {100, 150, 0}

	-- Create save button pivot
	instance.scenegraph_definition.save_button_pivot = {
		vertical_alignment = "top",
		parent = "screen",
		horizontal_alignment = "center",
		size = size,
		position = {x_base, y_base + 625, 0},
	}
	-- Create save button pivot
	instance.scenegraph_definition.reset_button_pivot = {
		vertical_alignment = "top",
		parent = "screen",
		horizontal_alignment = "center",
		size = size,
		position = {x_base, y_base + 525, 0},
	}

	local title_text_font_settings = UIFontSettings.header_2
	-- Create name text
	instance.widget_definitions.name_text = UIWidget.create_definition({
		{
			value = "n/a",
			value_id = "text",
			pass_type = "text",
			style = {
				text_vertical_alignment = "top",
				text_horizontal_alignment = "center",
				text_color = title_text_font_settings.text_color,
				font_type = title_text_font_settings.font_type,
				font_size = title_text_font_settings.font_size
			}
		}
	}, "name_text_pivot", nil, size)
end)

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #############################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################################################

mod:hook(CLASS.InventoryView, "init", function(func, self, settings, context, ...)
	-- Original function
	func(self, settings, context, ...)
end)

mod:hook(CLASS.InventoryView, "on_enter", function(func, self, ...)
	-- Original function
	func(self, ...)
	-- Setup forward gui for rendering
	-- self:_setup_forward_gui()
	-- Create custom widgets
	self:create_custom_widgets()
	-- Modding tools
	self:add_unit_manipulation()
end)

mod:hook(CLASS.InventoryView, "update", function(func, self, dt, t, input_service, ...)
	-- Update custom widgets
	self:draw_gear_node_lines()
	-- Update custom widget visibility
	self:update_custom_widget_visibility()
	-- Original function
	return func(self, dt, t, input_service, ...)
end)

mod:hook(CLASS.InventoryView, "on_exit", function(func, self, ...)
	-- Modding tools
	self:remove_unit_manipulation_all()
	-- Destroy forward gui
	-- self:_destroy_forward_gui()
	-- Destroy temp settings
	self:destroy_temp_settings()
	-- Destroy background view
	self.inventory_background_view = nil
	-- Original function
	func(self, ...)
end)

mod:hook(CLASS.InventoryView, "_switch_active_layout", function(func, self, tab_context, ...)
	-- Original function
	func(self, tab_context, ...)
	-- Check tab
	if self:is_tab() then -- Custom tab
		-- Create temp settings
		self:create_temp_settings()
		-- Rotation
		self:set_rotation()
	else -- Default tab
		-- Destroy temp settings
		self:destroy_temp_settings()
		-- Modding Tools
		self:remove_unit_manipulation_all()
		-- Rotation
		self:reset_rotation()
	end
	-- -- Update custom widget visibility
	-- self:update_custom_widget_visibility()
end)

mod:hook(CLASS.InventoryView, "cb_on_grid_entry_pressed", function(func, self, widget, element, ...)
	-- Original function
	func(self, widget, element, ...)
	-- if not self._is_own_player or self._is_readonly then
	-- end
end)