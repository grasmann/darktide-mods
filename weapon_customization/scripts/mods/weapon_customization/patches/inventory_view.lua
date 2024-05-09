local mod = get_mod("weapon_customization")
local modding_tools = get_mod("modding_tools")

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

--#endregion

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

mod:hook(CLASS.InventoryView, "on_exit", function(func, self, ...)
	self:_destroy_forward_gui()
	func(self, ...)
end)

mod:hook(CLASS.InventoryView, "on_enter", function(func, self, ...)
	local size = {600, 50}

	func(self, ...)

	modding_tools = get_mod("modding_tools")
	local class_name = self.__class_name
	self._unique_id = class_name .. "_" .. string_gsub(tostring(self), "table: ", "")

	self._setup_forward_gui = function(self)
		local ui_manager = managers.ui
		local timer_name = "ui"
		local world_layer = 101
		local world_name = self._unique_id .. "_ui_forward_world"
		local view_name = self.view_name
		self._forward_world = ui_manager:create_world(world_name, world_layer, timer_name, view_name)
		local viewport_name = self._unique_id .. "_ui_forward_world_viewport"
		local viewport_type = "default_with_alpha"
		local viewport_layer = 1
		self._forward_viewport = ui_manager:create_viewport(self._forward_world, viewport_name, viewport_type, viewport_layer)
		self._forward_viewport_name = viewport_name
		local renderer_name = self._unique_id .. "_forward_renderer"
		self._ui_forward_renderer = ui_manager:create_renderer(renderer_name, self._forward_world)
		local gui = self._ui_forward_renderer.gui
		local gui_retained = self._ui_forward_renderer.gui_retained
		local resource_renderer_name = self._unique_id
		local material_name = "content/ui/materials/render_target_masks/ui_render_target_straight_blur"
		self._ui_resource_renderer = ui_manager:create_renderer(resource_renderer_name, self._forward_world, true, gui, gui_retained, material_name)
	end

	self._destroy_forward_gui = function(self)
		if self._ui_resource_renderer then
			local renderer_name = self._unique_id
			self._ui_resource_renderer = nil
	
			managers.ui:destroy_renderer(renderer_name)
		end
	
		if self._ui_forward_renderer then
			self._ui_forward_renderer = nil
	
			managers.ui:destroy_renderer(self._unique_id .. "_forward_renderer")
	
			local world = self._forward_world
			local viewport_name = self._forward_viewport_name
	
			ScriptWorld.destroy_viewport(world, viewport_name)
			managers.ui:destroy_world(world)
	
			self._forward_viewport_name = nil
			self._forward_world = nil
		end
	end

	self:_setup_forward_gui()

	self.character_name = function(self)
		local preview_player = self._preview_player
		local profile = preview_player and preview_player:profile()
		return profile and profile.name
	end

	self.weapon_unit = function(self)
		local inventory_background_view = mod:get_view("inventory_background_view")
		if inventory_background_view and inventory_background_view._profile_spawner then
			local spawn_data = inventory_background_view._profile_spawner._character_spawn_data
			local slot_id = inventory_background_view._preview_wield_slot_id == "slot_primary" and "slot_secondary" or "slot_primary"
			if spawn_data and spawn_data.unit_3p and unit_alive(spawn_data.unit_3p) then
				return mod:execute_extension(spawn_data.unit_3p, "visible_equipment_system", "weapon_unit", slot_id)
			end
		end
	end

	self.weapon_item = function(self)
		local inventory_background_view = mod:get_view("inventory_background_view")
		if inventory_background_view then
			local slot_id = inventory_background_view._preview_wield_slot_id
			local preview_player = self._preview_player
			local profile = preview_player and preview_player:profile()
			return profile.loadout[slot_id]
		end
	end

	self.weapon_name = function(self)
		local inventory_background_view = mod:get_view("inventory_background_view")
		if inventory_background_view and inventory_background_view._profile_spawner then
			local slot_id = inventory_background_view._preview_wield_slot_id == "slot_primary" and "slot_secondary" or "slot_primary"
			local preview_profile_equipped_items = inventory_background_view._preview_profile_equipped_items
			local presentation_inventory = preview_profile_equipped_items
			local slot_item = presentation_inventory[slot_id]
			return Localize(slot_item.display_name)
		end
	end

	self.customization_angle = function(self)
		local inventory_background_view = mod:get_view("inventory_background_view")
		local is_tab = self._active_category_tab_context and self._active_category_tab_context.display_name == "tab_weapon_customization"
		if is_tab and inventory_background_view and inventory_background_view._profile_spawner then
			local slot_id = inventory_background_view._preview_wield_slot_id == "slot_primary" and "slot_secondary" or "slot_primary"
			return slot_id == "slot_primary" and 2 or 4.5
		end
	end

	self.backpack_name = function(self)
		local preview_player = self._preview_player
		local profile = preview_player and preview_player:profile()
		local item = profile and profile.loadout.slot_gear_extra_cosmetic
		return item and Localize(item.display_name)
	end

	self.armour_name = function(self)
		local preview_player = self._preview_player
		local profile = preview_player and preview_player:profile()
		local item = profile and profile.loadout.slot_gear_upperbody
		return item and Localize(item.display_name)
	end

	self.button_pressed = function(self, button)
	end

	--#region Freeze animation
		-- self.freeze_animation = function(self)
		-- 	local ibv = mod:get_view("inventory_background_view")
		-- 	local spawn_data = ibv and ibv._profile_spawner and ibv._profile_spawner._character_spawn_data
		-- 	local unit = spawn_data and spawn_data.unit_3p
		-- 	if unit and unit_alive(unit) and not self.frozen then
		-- 		Unit.disable_animation_state_machine(unit)
		-- 		self.frozen = true
		-- 	end
		-- end

		-- self.unfreeze_animation = function(self)
		-- 	local ibv = mod:get_view("inventory_background_view")
		-- 	local spawn_data = ibv and ibv._profile_spawner and ibv._profile_spawner._character_spawn_data
		-- 	local unit = spawn_data and spawn_data.unit_3p
		-- 	if unit and unit_alive(unit) and self.frozen then
		-- 		Unit.enable_animation_state_machine(unit)
		-- 		Unit.animation_event(unit, "inventory_idle_default")
		-- 		self.frozen = nil
		-- 	end
		-- end
	--#endregion

	self.update_checktbox = function(self, checkbox)
		checkbox.style.option_1.visible = checkbox.content.value
		checkbox.style.option_2.visible = not checkbox.content.value
	end

	self.toggle_checkbox = function(self, checkbox)
		checkbox.content.value = not checkbox.content.value
		mod:set(checkbox.content.saved_option, checkbox.content.value)
		self:update_checktbox(checkbox)
		self:checkbox_changed(checkbox, checkbox.content.value)
	end

	self.checkbox_changed = function(self, checkbox, value)
	end

	self.add_widget = function(self, widget)
		if widget then
			self._widgets[#self._widgets+1] = widget
			self._widgets_by_name[widget.name] = widget
		end
	end

	local function button(name, size, scenegraph_id)
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

	local function checkbox(name, size, scenegraph_id, option)
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
				-- widget.content.entry.get_function = config.get_function
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

	local function value_slider(name, size, scenegraph_id, value_text)
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

	self.update_options_text = function(self)
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

	for i = 1, 4, 1 do
		self:add_widget(checkbox("visible_equipment_option_"..i, size, "option_check_"..i.."_pivot", "visible_equipment_option_"..i))
	end

	self:add_widget(button("visible_equipment_save_button", size, "save_button_pivot"))
	self:add_widget(button("visible_equipment_reset_button", size, "reset_button_pivot"))

end)

mod:hook(CLASS.InventoryView, "_switch_active_layout", function(func, self, tab_context, ...)
	func(self, tab_context, ...)
	if tab_context and self.weapon_unit then
		local is_tab = tab_context.display_name == "tab_weapon_customization"
		local ibv = mod:get_view("inventory_background_view")
		local spawn_data = ibv._profile_spawner and ibv._profile_spawner._character_spawn_data
		local unit = spawn_data and spawn_data.unit_3p
		local weapon_unit = self:weapon_unit()

		if is_tab then
			self:update_options_text()
			if ibv and ibv._profile_spawner then ibv._profile_spawner._rotation_angle = self:customization_angle() or 0 end
		else
			if modding_tools then
				modding_tools:unit_manipulation_remove(weapon_unit)
			end
			if ibv and ibv._profile_spawner then ibv._profile_spawner._rotation_angle = 0 end
		end

		for i = 1, 4, 1 do
			self._widgets_by_name["visible_equipment_option_"..i].visible = is_tab
		end
		
		self._widgets_by_name.name_text.visible = is_tab
		self._widgets_by_name.visible_equipment_save_button.visible = is_tab
		self._widgets_by_name.visible_equipment_reset_button.visible = is_tab
	end
end)
