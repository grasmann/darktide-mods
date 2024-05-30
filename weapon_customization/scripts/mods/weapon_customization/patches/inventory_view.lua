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
	local CLASS = CLASS
	local string = string
	local get_mod = get_mod
	local tostring = tostring
	local managers = Managers
	local Localize = Localize
	local callback = callback
	local unit_alive = Unit.alive
	local string_gsub = string.gsub
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local WEAPON_CUSTOMIZATION_TAB = "tab_weapon_customization"
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/ui/views/inventory_view/inventory_view", function(instance)

	instance._setup_forward_gui = function(self)
		self:set_unique_id()
		self._forward_world = managers.ui:create_world(self._unique_id.."_ui_forward_world", 101, "ui", self.view_name)
		local viewport_name = self._unique_id.."_ui_forward_world_viewport"
		self._forward_viewport = managers.ui:create_viewport(self._forward_world, viewport_name, "default_with_alpha", 1)
		self._forward_viewport_name = viewport_name
		self._ui_forward_renderer = managers.ui:create_renderer(self._unique_id.."_forward_renderer", self._forward_world)
		self._ui_resource_renderer = managers.ui:create_renderer(self._unique_id, self._forward_world, true, self._ui_forward_renderer.gui,
			self._ui_forward_renderer.gui_retained, "content/ui/materials/render_target_masks/ui_render_target_straight_blur")
	end

	instance._destroy_forward_gui = function(self)
		if self._ui_resource_renderer then
			self._ui_resource_renderer = nil
			managers.ui:destroy_renderer(self._unique_id)
		end
		if self._ui_forward_renderer then
			self._ui_forward_renderer = nil
			managers.ui:destroy_renderer(self._unique_id.."_forward_renderer")
			ScriptWorld.destroy_viewport(self._forward_world, self._forward_viewport_name)
			managers.ui:destroy_world(self._forward_world)
			self._forward_viewport_name = nil
			self._forward_world = nil
		end
	end

	instance.player_profile = function(self)
		return self._preview_player and self._preview_player:profile()
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
			return self.inventory_background_view._preview_wield_slot_id == mod.SLOT_PRIMARY and mod.SLOT_SECONDARY or mod.SLOT_PRIMARY
		end
	end

	instance.weapon_unit = function(self)
		self:get_inventory_background_view()
		if self.inventory_background_view and self.inventory_background_view._profile_spawner then
			local character_spawn_data = self.inventory_background_view._profile_spawner._character_spawn_data
			if character_spawn_data and character_spawn_data.unit_3p and unit_alive(character_spawn_data.unit_3p) then
				return mod:execute_extension(character_spawn_data.unit_3p, mod.SYSTEM_VISIBLE_EQUIPMENT, "weapon_unit", self:unequipped_slot_id())
			end
		end
	end

	instance.weapon_item = function(self)
		self:get_inventory_background_view()
		if self.inventory_background_view then
			local profile = self:player_profile()
			return profile.loadout[self:unequipped_slot_id()]
		end
	end

	instance.weapon_name = function(self)
		self:get_inventory_background_view()
		if self.inventory_background_view and self.inventory_background_view._profile_spawner then
			local preview_profile_equipped_items = self.inventory_background_view._preview_profile_equipped_items
			local slot_item = preview_profile_equipped_items[self:unequipped_slot_id()]
			return Localize(slot_item.display_name)
		end
	end

	instance.is_tab = function(self, tab_context)
		local tab_context = tab_context or self._active_category_tab_context
		return tab_context and tab_context.display_name == WEAPON_CUSTOMIZATION_TAB
	end

	instance.customization_angle = function(self)
		if self:is_tab() then
			return self:unequipped_slot_id() == mod.SLOT_PRIMARY and 2 or 4.5
		end
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

	instance.update_options_text = function(self)
		local options_text = {
			{self:character_name(), Localize("loc_visible_equipment_all")},
			{Localize("loc_visible_equipment_only_this"), self:weapon_name() or ""},
			{self:armour_name() or "", Localize("loc_visible_equipment_all")},
			{self:backpack_name() or "", Localize("loc_visible_equipment_all")},
		}
		for i = 1, 4, 1 do
			self._widgets_by_name["visible_equipment_option_"..i].content.option_1 = options_text[i][1]
			self._widgets_by_name["visible_equipment_option_"..i].content.option_2 = options_text[i][2]
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
		-- Func
	end

	instance.save_offset = function(self)
		local weapon_item = self:weapon_item()
		local weapon_unit = self:weapon_unit()
		if weapon_item and weapon_unit and unit_alive(weapon_unit) then
			if mod.gear_settings then
				mod.gear_settings:save(weapon_item, weapon_unit)
			end
		end
	end

	instance.button = function(self, name, size, scenegraph_id)
		local config = {
			display_name = "loc_"..name,
			value_width = 275,
		}
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

	instance.set_unique_id = function(self)
		self._unique_id = self.__class_name.."_"..string_gsub(tostring(self), "table: ", "")
	end

	instance.create_custom_widgets = function(self)
		local size = {600, 50}
		-- Create custom checkboxes
		for i = 1, 4, 1 do
			self:add_widget(self:checkbox("visible_equipment_option_"..i, size, "option_check_"..i.."_pivot", "visible_equipment_option_"..i))
		end

		-- Create custom buttons
		self:add_widget(self:button("visible_equipment_save_button", size, "save_button_pivot"))
		self:add_widget(self:button("visible_equipment_reset_button", size, "reset_button_pivot"))
	end

	instance.update_custom_widget_visibility = function(self)
		local is_tab = self:is_tab()
		for i = 1, 4, 1 do
			self._widgets_by_name["visible_equipment_option_"..i].visible = is_tab
		end
		self._widgets_by_name.name_text.visible = is_tab
		self._widgets_by_name.visible_equipment_save_button.visible = is_tab
		self._widgets_by_name.visible_equipment_reset_button.visible = is_tab
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
		size = size,
		position = {x_base, y_base - 175, 0},
	}

	-- Creat option checkbox pivots
	for i = 1, 4, 1 do
		instance.scenegraph_definition["option_check_"..i.."_pivot"] = {
			vertical_alignment = "top",
			parent = "screen",
			horizontal_alignment = "center",
			size = size,
			position = {x_base - 20, y_base - 80 + 55 * (i - 1), 0},
		}
	end

	-- Create save button pivot
	instance.scenegraph_definition.save_button_pivot = {
		vertical_alignment = "top",
		parent = "screen",
		horizontal_alignment = "center",
		size = size,
		position = {x_base - 75, y_base + 625, 0},
	}
	-- Create save button pivot
	instance.scenegraph_definition.reset_button_pivot = {
		vertical_alignment = "top",
		parent = "screen",
		horizontal_alignment = "center",
		size = size,
		position = {x_base - 400, y_base + 625, 0},
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
	self:_setup_forward_gui()

	-- Create custom widgets
	self:create_custom_widgets()

	-- Modding tools
	self:add_unit_manipulation()

end)

mod:hook(CLASS.InventoryView, "on_exit", function(func, self, ...)

	-- Modding tools
	self:remove_unit_manipulation_all()

	-- Destroy forward gui
	self:_destroy_forward_gui()

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

		-- Update name text
		self:update_options_text()

		-- Rotation
		self:set_rotation()

	else -- Default tab
		
		-- Modding Tools
		self:remove_unit_manipulation_all()
		
		-- Rotation
		self:reset_rotation()

	end

	-- Update custom widget visibility
	self:update_custom_widget_visibility()

end)

mod:hook(CLASS.InventoryView, "cb_on_grid_entry_pressed", function(func, self, widget, element, ...)

	-- Original function
	func(self, widget, element, ...)

	if not self._is_own_player or self._is_readonly then

	end

end)