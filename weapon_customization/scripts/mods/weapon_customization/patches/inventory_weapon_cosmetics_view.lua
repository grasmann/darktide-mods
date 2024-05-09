local mod = get_mod("weapon_customization")
local modding_tools = get_mod("modding_tools")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
    local MasterItems = mod:original_require("scripts/backend/master_items")
    local UIRenderer = mod:original_require("scripts/managers/ui/ui_renderer")
    local UIFontSettings = mod:original_require("scripts/managers/ui/ui_font_settings")
    local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")
    local ButtonPassTemplates = mod:original_require("scripts/ui/pass_templates/button_pass_templates")
    local ItemPackage = mod:original_require("scripts/foundation/managers/package/utilities/item_package")
    local WwiseGameSyncSettings = mod:original_require("scripts/settings/wwise_game_sync/wwise_game_sync_settings")
    local inventory_weapon_cosmetics_view_definitions = mod:original_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view_definitions")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
    local Utf8 = Utf8
	local Unit = Unit
	local math = math
    local table = table
    local pairs = pairs
	local CLASS = CLASS
    local Color = Color
    local ipairs = ipairs
    local string = string
	local get_mod = get_mod
	local Localize = Localize
    local managers = Managers
    local tostring = tostring
    local callback = callback
    local math_min = math.min
    local math_max = math.max
	local unit_alive = Unit.alive
    local utf8_upper = Utf8.upper
    local vector3_box = Vector3Box
    local table_clone = table.clone
    local string_find = string.find
    local vector3_unbox = vector3_box.unbox
    local unit_set_local_position = Unit.set_local_position
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local edge_padding = inventory_weapon_cosmetics_view_definitions.grid_settings.edge_padding
    local grid_size = inventory_weapon_cosmetics_view_definitions.grid_settings.grid_size
    local grid_width = grid_size[1] + edge_padding
    local tab_panel_width = grid_size[1] * .75    
    local button_width = tab_panel_width * 0.3
    local edge = edge_padding * 0.5
    local dropdown_height = 32
    local label_height = 30
--#endregion

mod.attachment_package_snapshot = function(self, item, test_data)
    local packages = test_data or {}
    if not test_data then
        local attachments = item.__master_item.attachments
        ItemPackage._resolve_item_packages_recursive(attachments, MasterItems.get_cached(), packages)
    end
    if self.old_package_snapshot then
        self.new_package_snapshot = packages
        return self:attachment_package_resolve()
    else
        self.old_package_snapshot = packages
    end
end

mod.attachment_package_resolve = function(self)
    if self.old_package_snapshot and self.new_package_snapshot then
        local old_packages = {}
        for name, _ in pairs(self.old_package_snapshot) do
            if not self.new_package_snapshot[name] then
                old_packages[#old_packages+1] = name
            end
        end
        local new_packages = {}
        for name, _ in pairs(self.new_package_snapshot) do
            if not self.old_package_snapshot[name] then
                new_packages[#new_packages+1] = name
            end
        end
        self.old_package_snapshot = nil
        self.new_package_snapshot = nil
        return old_packages, new_packages
    end
end

mod:hook_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view_definitions", function(instance)

	local top = 115
	local z = 100
	local y = -20
	local cosmetics_scenegraphs = mod:get_cosmetics_scenegraphs()
	for _, scenegraph_id in pairs(cosmetics_scenegraphs) do
		if string_find(scenegraph_id, "text_pivot") then
			y = y + label_height
		else
			y = y + dropdown_height
		end
		instance.scenegraph_definition[scenegraph_id] = {
			vertical_alignment = "top",
			parent = "item_grid_pivot",
			horizontal_alignment = "left",
			size = {grid_size[1], label_height},
			position = {edge, y, z}
		}
	end

	instance.scenegraph_definition.item_grid_pivot = {
		vertical_alignment = "top",
		parent = "screen",
		horizontal_alignment = "left",
		size = {0, 0},
		position = {160, 15, 0},
	}

	instance.scenegraph_definition.grid_tab_panel.position[1] = grid_width - (grid_width - tab_panel_width) - 20
	instance.scenegraph_definition.grid_tab_panel.position[2] = -48
	instance.scenegraph_definition.grid_tab_panel.size[1] = tab_panel_width
	instance.grid_settings.grid_size[2] = 970
	instance.grid_settings.mask_size[2] = 970

	instance.scenegraph_definition.panel_extension_pivot = {
		vertical_alignment = "top",
		parent = "corner_top_right",
		horizontal_alignment = "left",
		size = {grid_width + edge, 340 + edge * 2},
		position = {-90 -(grid_width / 2), 0, z}
	}
	local info_box_size = {1250, 200}
	local equip_button_size = {374, 76}
	-- instance.scenegraph_definition.info_box.position[1] = -220
	instance.scenegraph_definition.info_box.vertical_alignment = "top"
	instance.scenegraph_definition.info_box.horizontal_alignment = "left"
	instance.scenegraph_definition.info_box.position = {grid_width + 160, -100, 3}
	instance.scenegraph_definition.info_box.size[1] = 1920 - (grid_width + 160)
	-- instance.scenegraph_definition.display_name.text_horizontal_alignment = "right"
	instance.scenegraph_definition.display_name.horizontal_alignment = "left"
	instance.scenegraph_definition.display_name.size[1] = 1920 - (grid_width + 160)
	-- instance.scenegraph_definition.sub_display_name.text_horizontal_alignment = "right"
	instance.scenegraph_definition.sub_display_name.horizontal_alignment = "left"
	instance.scenegraph_definition.sub_display_name.size[1] = 1920 - (grid_width + 160)
	
	instance.scenegraph_definition.attachment_info_box = {
		vertical_alignment = "bottom",
		parent = "canvas",
		horizontal_alignment = "right",
		size = {500, 100},
		position = {-50, -300, 3}
	}
	instance.scenegraph_definition.attachment_display_name = {
		vertical_alignment = "top",
		parent = "attachment_info_box",
		horizontal_alignment = "left",
		size = {500, 50},
		position = {30, 20, 3}
	}
	instance.scenegraph_definition.attachment_sub_display_name_1 = {
		vertical_alignment = "bottom",
		parent = "attachment_info_box",
		horizontal_alignment = "left",
		size = {150, 50},
		position = {10, 0, 3}
	}
	instance.scenegraph_definition.attachment_sub_display_name_2 = {
		vertical_alignment = "bottom",
		parent = "attachment_info_box",
		horizontal_alignment = "left",
		size = {150, 50},
		position = {160, 0, 3}
	}
	instance.scenegraph_definition.attachment_sub_display_name_3 = {
		vertical_alignment = "bottom",
		parent = "attachment_info_box",
		horizontal_alignment = "left",
		size = {150, 50},
		position = {310, 0, 3}
	}
	-- instance.scenegraph_definition.attachment_sub_display_name_4 = {
	-- 	vertical_alignment = "bottom",
	-- 	parent = "attachment_info_box",
	-- 	horizontal_alignment = "left",
	-- 	size = {150, 50},
	-- 	position = {150, 0, 3}
	-- }


	-- local display_name_style = table.clone(UIFontSettings.header_2)
	-- display_name_style.text_horizontal_alignment = "left"
	-- display_name_style.text_vertical_alignment = "bottom"
	-- local title_text_style = table.clone(UIFontSettings.header_2)
	-- title_text_style.text_horizontal_alignment = "center"
	-- title_text_style.text_vertical_alignment = "bottom"
	local sub_display_name_style = table_clone(UIFontSettings.header_3)
	sub_display_name_style.text_horizontal_alignment = "left"
	sub_display_name_style.text_vertical_alignment = "top"
	-- sub_display_name_style.text_color = Color.ui_grey_light(255, true)
	-- local description_text_style = table.clone(UIFontSettings.body_small)
	-- description_text_style.text_horizontal_alignment = "left"
	-- description_text_style.text_vertical_alignment = "top"

	instance.widget_definitions.button_pivot_background.style.background.visible = false

	instance.widget_definitions.attachment_info_box = UIWidget.create_definition({
		{
			value = "content/ui/materials/backgrounds/terminal_basic",
			style_id = "background",
			pass_type = "texture",
			style = {
				vertical_alignment = "bottom",
				scale_to_material = true,
				horizontal_alignment = "left",
				offset = {0, 0, 0},
				size_addition = {0, -1},
				color = Color.terminal_grid_background(255, true),
			}
		},
		{
			value = "content/ui/materials/frames/dropshadow_medium",
			style_id = "input_progress_frame",
			pass_type = "texture",
			style = {
				vertical_alignment = "bottom",
				scale_to_material = true,
				horizontal_alignment = "right",
				offset = {10, 10, 4},
				default_offset = {10, 0, 4},
				size = {0, 10},
				color = {255, 226, 199, 126},
				-- size_addition = {20, 20}
			}
		}
	}, "attachment_info_box")

	instance.widget_definitions.attachment_display_name = UIWidget.create_definition({
		{
			value = "",
			value_id = "text",
			pass_type = "text",
			style = sub_display_name_style
		}
	}, "attachment_display_name")

	instance.scenegraph_definition.equip_button = {
		vertical_alignment = "bottom",
		parent = "corner_bottom_right",
		horizontal_alignment = "right",
		size = equip_button_size,
		position = {0, 0, 1},
		offset = {-100, -70, 1}
	}

	local equip_button_size = {374, 76}
	instance.scenegraph_definition.reset_button = {
		vertical_alignment = "bottom",
		parent = "equip_button",
		horizontal_alignment = "right",
		size = equip_button_size,
		position = {-equip_button_size[1] - 35, 0, 1}
	}
	instance.widget_definitions.reset_button = UIWidget.create_definition(table_clone(ButtonPassTemplates.default_button), "reset_button", {
		gamepad_action = "confirm_pressed",
		text = utf8_upper(mod:localize("loc_weapon_inventory_reset_button")),
		hotspot = {
			on_pressed_sound = UISoundEvents.weapons_skin_confirm
		}
	})
	instance.widget_definitions.reset_button.content.original_text = utf8_upper(mod:localize("loc_weapon_inventory_reset_button"))
	
	instance.scenegraph_definition.randomize_button = {
		vertical_alignment = "bottom",
		parent = "reset_button",
		horizontal_alignment = "right",
		size = equip_button_size,
		position = {-equip_button_size[1] - 35, 0, 1}
	}
	instance.widget_definitions.randomize_button = UIWidget.create_definition(table_clone(ButtonPassTemplates.default_button), "randomize_button", {
		gamepad_action = "confirm_pressed",
		text = utf8_upper(mod:localize("loc_weapon_inventory_randomize_button")),
		hotspot = {
			on_pressed_sound = UISoundEvents.weapons_skin_confirm
		}
	})
	instance.widget_definitions.randomize_button.content.original_text = utf8_upper(mod:localize("loc_weapon_inventory_randomize_button"))

	instance.scenegraph_definition.demo_button = {
		vertical_alignment = "bottom",
		parent = "equip_button",
		horizontal_alignment = "right",
		size = equip_button_size,
		position = {0, -equip_button_size[2], 1}
	}
	instance.widget_definitions.demo_button = UIWidget.create_definition(table_clone(ButtonPassTemplates.default_button), "demo_button", {
		gamepad_action = "confirm_pressed",
		text = utf8_upper(mod:localize("loc_weapon_inventory_demo_button")),
		hotspot = {
			on_pressed_sound = UISoundEvents.weapons_skin_confirm
		}
	})

	instance.widget_definitions.panel_extension = UIWidget.create_definition({
		{
			value = "content/ui/materials/backgrounds/terminal_basic",
			style_id = "background",
			pass_type = "texture",
			style = {
				vertical_alignment = "bottom",
				scale_to_material = true,
				horizontal_alignment = "left",
				offset = {0, 0, 0},
				size_addition = {0, -1},
				color = Color.terminal_grid_background(255, true),
			}
		},
		{
			value = "content/ui/materials/frames/dropshadow_medium",
			style_id = "input_progress_frame",
			pass_type = "texture",
			style = {
				vertical_alignment = "bottom",
				scale_to_material = true,
				horizontal_alignment = "right",
				offset = {10, 10, 4},
				default_offset = {10, 0, 4},
				size = {0, 10},
				color = {255, 226, 199, 126},
				-- size_addition = {20, 20}
			}
		}
	}, "panel_extension_pivot")

	if #instance.legend_inputs == 1 then
		instance.legend_inputs[#instance.legend_inputs+1] = {
			on_pressed_callback = "_cb_on_ui_visibility_toggled",
			input_action = "hotkey_menu_special_2",
			display_name = "loc_menu_toggle_ui_visibility_off",
			alignment = "right_alignment"
		}
		if modding_tools then
			instance.legend_inputs[#instance.legend_inputs+1] = {
				on_pressed_callback = "_cb_on_modding_tool_toggled",
				input_action = "hotkey_item_sort",
				display_name = "loc_use_modding_tool",
				alignment = "right_alignment"
			}
		end
	end

	instance.scenegraph_definition.weapon_presets_pivot = {
		vertical_alignment = "top",
		parent = "screen",
		horizontal_alignment = "right",
		size = {0, 0},
		position = {-60, 94, 62}
	}

	-- instance.always_visible_widget_names.background = true

	-- instance.grid_settings.use_terminal_background = true
	-- instance.grid_settings.layer = 300

	-- mod:dtf(instance.widget_definitions, "instance.widget_definitions", 10)

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "init", function(func, self, settings, context, ...)
	-- Fetch instance
	mod.cosmetics_view = self

	-- Settings
	settings.wwise_states = {options = WwiseGameSyncSettings.state_groups.options.none}

	-- Original function
	func(self, settings, context, ...)

	-- Custom attributes
	self._custom_widgets = {}
	self._not_applicable = {}
	self._custom_widgets_overlapping = 0
	self._item_name = mod:item_name_from_content_string(self._selected_item.name)
	self._gear_id = mod:get_gear_id(self._presentation_item)
	self._slot_info_id = mod:get_slot_info_id(self._presentation_item)
    
    -- Overwrite draw function
    -- Draw legend elements
	self.draw = function(self, dt, t, input_service, layer)
		local render_scale = self._render_scale
		local render_settings = self._render_settings
		local ui_renderer = self._ui_renderer
		local ui_default_renderer = self._ui_default_renderer
		local ui_forward_renderer = self._ui_forward_renderer
		render_settings.start_layer = layer
		render_settings.scale = render_scale
		render_settings.inverse_scale = render_scale and 1 / render_scale
		local ui_scenegraph = self._ui_scenegraph
	
		UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, render_settings)
		UIWidget.draw(self._background_widget, ui_renderer)
		UIRenderer.end_pass(ui_renderer)
		UIRenderer.begin_pass(ui_forward_renderer, ui_scenegraph, input_service, dt, render_settings)
		self:_draw_widgets(dt, t, input_service, ui_forward_renderer, render_settings)
		UIRenderer.end_pass(ui_forward_renderer)
		self:_draw_elements(dt, t, ui_forward_renderer, render_settings, input_service)
		self:_draw_render_target()
	end

	-- Overwrite draw elements function
	-- Make view legend inputs visible when UI gets hidden
	self._draw_elements = function(self, dt, t, ui_renderer, render_settings, input_service)
		local old_alpha_multiplier = render_settings.alpha_multiplier
		local alpha_multiplier = self._alpha_multiplier or 1
		local elements_array = self._elements_array
		for i = 1, #elements_array do
			local element = elements_array[i]
			if element then
				local element_name = element.__class_name
				if element_name ~= "ViewElementInventoryWeaponPreview" or element_name ~= "ViewElementInputLegend" then
					ui_renderer = self._ui_default_renderer or ui_renderer
				end
				render_settings.alpha_multiplier = element_name ~= "ViewElementInputLegend" and alpha_multiplier or 1
				element:draw(dt, t, ui_renderer, render_settings, input_service)
			end
		end
		render_settings.alpha_multiplier = old_alpha_multiplier
	end

    -- Callback when UI visibility is toggled
	self._cb_on_ui_visibility_toggled = function (self, id)
		self._visibility_toggled_on = not self._visibility_toggled_on
		local display_name = self._visibility_toggled_on and "loc_menu_toggle_ui_visibility_off" or "loc_menu_toggle_ui_visibility_on"
		self._input_legend_element:set_display_name(id, display_name)
	end

    -- Callback when modding tool is toggled
	self._cb_on_modding_tool_toggled = function (self, id)
		self._modding_tool_toggled_on = not self._modding_tool_toggled_on
		local ui_weapon_spawner = self._weapon_preview._ui_weapon_spawner
		local weapon_spawn_data = ui_weapon_spawner._weapon_spawn_data
		if weapon_spawn_data and modding_tools then
			local camera = ui_weapon_spawner._camera
			local world = ui_weapon_spawner._world
			local gui = self._ui_forward_renderer.gui
			if self._modding_tool_toggled_on then
				modding_tools:unit_manipulation_add(weapon_spawn_data.item_unit_3p, camera, world, gui)
				local attachment_units_3p = weapon_spawn_data.attachment_units_3p or {}
				for _, unit in pairs(attachment_units_3p) do
					modding_tools:unit_manipulation_add(unit, camera, world, gui)
				end
			else
				modding_tools:unit_manipulation_remove(weapon_spawn_data.item_unit_3p)
				local attachment_units_3p = weapon_spawn_data.attachment_units_3p or {}
				for _, unit in pairs(attachment_units_3p) do
					modding_tools:unit_manipulation_remove(unit)
				end
			end
		end
	end

	-- Events
	self.hide_ui = function(self, hide)
		mod.cosmetics_view._visibility_toggled_on =  hide
		mod.cosmetics_view:_cb_on_ui_visibility_toggled("entry_"..tostring(3))
	end
	
	self.can_exit = function (self)
		return self._can_close and not mod.build_animation:is_busy()
	end

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "on_enter", function(func, self, ...)
	-- Fetch instance
	mod.cosmetics_view = self

    func(self, ...)

	modding_tools = get_mod("modding_tools")
	local world_spawner = self._weapon_preview._world_spawner
	local world = world_spawner:world()

	self._modding_tool_toggled_on = false

	-- mod:persistent_table(REFERENCE).temp_gear_settings[self._gear_id] = {}
	mod:remove_extension(mod.player_unit, "visible_equipment_system")

	-- mod.changed_weapon = nil
	self.bar_breakdown_widgets = {}
	self.bar_breakdown_widgets_by_name = {}

    mod:generate_custom_widgets()
	mod:resolve_not_applicable_attachments()
	mod:resolve_overlapping_widgets()
	-- mod:get_dropdown_positions()
	mod:init_custom_weapon_zoom()

	mod.original_weapon_settings = {}
	mod:get_changed_weapon_settings()
	mod:update_reset_button()

    mod:hide_custom_widgets(true)
	mod:resolve_no_support(self._selected_item)
	mod:load_attachment_sounds(self._selected_item)
	mod:create_bar_breakdown_widgets()

	-- Auto equip
	for attachment_slot, value in pairs(mod.changed_weapon_settings) do
		if not mod.add_custom_attachments[attachment_slot] then
			mod:resolve_auto_equips(self._selected_item, "default")
		end
	end
	for attachment_slot, value in pairs(mod.changed_weapon_settings) do
		if mod.add_custom_attachments[attachment_slot] then
			mod:resolve_auto_equips(self._selected_item, "default")
		end
	end

	-- Special
	for attachment_slot, value in pairs(mod.changed_weapon_settings) do
		if mod.add_custom_attachments[attachment_slot] then
			mod:resolve_special_changes(self._selected_item, "default")
		end
	end
	for attachment_slot, value in pairs(mod.changed_weapon_settings) do
		if not mod.add_custom_attachments[attachment_slot] then
			mod:resolve_special_changes(self._selected_item, "default")
		end
	end

	self._item_grid._widgets_by_name.grid_divider_top.visible = false
	self._item_grid._widgets_by_name.grid_divider_bottom.visible = false
	self._item_grid._widgets_by_name.grid_background.visible = false

	managers.event:register(self, "weapon_customization_hide_ui", "hide_ui")

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "update", function(func, self, dt, t, input_service, ...)

	if self._selected_tab_index == 3 then
		self._previewed_element = nil
	end

    local pass_input, pass_draw = func(self, dt, t, input_service, ...)

	if mod.cosmetics_view then
		mod:update_custom_widgets(input_service, dt, t)
		mod:update_attachment_info()
		mod:update_equip_button()
		mod:update_reset_button()
	end

	if mod.cosmetics_view and mod.demo then
		local rotation_angle = (mod._last_rotation_angle or 0) + dt
		self._weapon_preview._ui_weapon_spawner._rotation_angle = rotation_angle
		self._weapon_preview._ui_weapon_spawner._default_rotation_angle = rotation_angle
		mod._last_rotation_angle = self._weapon_preview._ui_weapon_spawner._default_rotation_angle
		if mod.demo_timer < t then
			mod:cb_on_randomize_pressed(true)
			mod.demo_timer = t + mod.demo_time
		end
	end

	return pass_input, pass_draw
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_handle_input", function(func, self, input_service, dt, t, ...)
	local zoom_target = self._weapon_zoom_target

	func(self, input_service, dt, t, ...)

	if mod.dropdown_open then
		self._weapon_zoom_target = zoom_target
	end
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_register_button_callbacks", function(func, self, ...)
	func(self, ...)
	local widgets_by_name = self._widgets_by_name
	local reset_button = widgets_by_name.reset_button
	reset_button.content.hotspot.pressed_callback = callback(mod, "cb_on_reset_pressed")
	local randomize_button = widgets_by_name.randomize_button
	randomize_button.content.hotspot.pressed_callback = callback(mod, "cb_on_randomize_pressed")
	local demo_button = widgets_by_name.demo_button
	demo_button.content.hotspot.pressed_callback = callback(mod, "cb_on_demo_pressed")
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_set_weapon_zoom", function(func, self, fraction, ...)
	if not mod.dropdown_open then
		func(self, fraction, ...)
	end
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_draw_widgets", function(func, self, dt, t, input_service, ui_renderer, render_settings, ...)
	local always_visible_widget_names = self._always_visible_widget_names
	local alpha_multiplier = self._render_settings and self._render_settings.alpha_multiplier or 1
	local anim_alpha_speed = 3

	if self._visibility_toggled_on then
		alpha_multiplier = math_min(alpha_multiplier + dt * anim_alpha_speed, 1)
	else
		alpha_multiplier = math_max(alpha_multiplier - dt * anim_alpha_speed, 0)
	end

	local always_visible_widget_names = self._always_visible_widget_names
	self._alpha_multiplier = alpha_multiplier
	local widgets = self._widgets
	local num_widgets = #widgets

	UIRenderer.begin_pass(ui_renderer, self._ui_scenegraph, input_service, dt, self._render_settings)

	for i = 1, num_widgets do
		local widget = widgets[i]
		local widget_name = widget.name
		self._render_settings.alpha_multiplier = always_visible_widget_names[widget_name] and 1 or alpha_multiplier

		UIWidget.draw(widget, ui_renderer)
	end

	mod:get_dropdown_positions()
	mod:draw_equipment_lines(dt, t)
	mod:draw_equipment_box(dt, t)

	local bar_breakdown_widgets = self.bar_breakdown_widgets

	if bar_breakdown_widgets then
		for _, widget in ipairs(bar_breakdown_widgets) do
			UIWidget.draw(widget, ui_renderer)
		end
	end

	UIRenderer.end_pass(ui_renderer)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "on_exit", function(func, self, ...)

	-- mod:persistent_table(REFERENCE).temp_gear_settings[self._gear_id] = nil

	mod:get_changed_weapon_settings()
	-- Auto equip
	for attachment_slot, value in pairs(mod.changed_weapon_settings) do
		if not mod.add_custom_attachments[attachment_slot] then
			mod:resolve_auto_equips(self._selected_item, "default")
		end
	end
	for attachment_slot, value in pairs(mod.changed_weapon_settings) do
		if mod.add_custom_attachments[attachment_slot] then
			mod:resolve_auto_equips(self._selected_item, "default")
		end
	end
	-- Special
	for attachment_slot, value in pairs(mod.changed_weapon_settings) do
		if mod.add_custom_attachments[attachment_slot] then
			mod:resolve_special_changes(self._selected_item, "default")
		end
	end
	for attachment_slot, value in pairs(mod.changed_weapon_settings) do
		if not mod.add_custom_attachments[attachment_slot] then
			mod:resolve_special_changes(self._selected_item, "default")
		end
	end

	mod:reset_stuff()
	
	local weapon_spawner = self._weapon_preview._ui_weapon_spawner
	local default_position = weapon_spawner._link_unit_base_position
	weapon_spawner._link_unit_position = default_position
	weapon_spawner._rotation_angle = 0
	weapon_spawner._default_rotation_angle = 0

	if weapon_spawner._weapon_spawn_data then
		local link_unit = weapon_spawner._weapon_spawn_data.link_unit
		-- mod:info("CLASS.InventoryWeaponCosmeticsView: "..tostring(link_unit))
		unit_set_local_position(link_unit, 1, vector3_unbox(default_position))
	end

	mod:check_unsaved_changes(true)
	mod:release_attachment_sounds()

	managers.event:unregister(self, "weapon_customization_hide_ui")
	
	mod:redo_weapon_attachments(self._presentation_item)

	func(self, ...)

	mod.cosmetics_view = nil
	mod.reset_weapon = nil
	-- Fade.destroy(self._fade_system)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "cb_on_equip_pressed", function(func, self, ...)
	if self._selected_tab_index == 3 then
		mod.original_weapon_settings = {}
		mod.just_changed = {}
		mod:update_equip_button()

		mod:attachment_package_snapshot(self._selected_item)

		local old_packages, new_packages = mod:attachment_package_snapshot(self._presentation_item)
		if new_packages and #new_packages > 0 then
			local weapon_spawner = self._weapon_preview._ui_weapon_spawner
			local reference_name = weapon_spawner._reference_name .. "_weapon_item_loader_" .. tostring(weapon_spawner._weapon_loader_index)
			for _, new_package in pairs(new_packages) do
				managers.package:load(new_package, reference_name, nil, true)
			end
		end

		local package_synchronizer_client = managers.package_synchronization:synchronizer_client()
		if package_synchronizer_client then
			package_synchronizer_client:reevaluate_all_profiles_packages()
		end

		mod:redo_weapon_attachments(self._presentation_item)
		local new_item = self._presentation_item
		new_item.item_type = self._selected_item.item_type
		new_item.gear_id = self._selected_item.gear_id
		new_item.name = self._selected_item.name

		-- mod:get_dropdown_positions()
		-- mod:get_changed_weapon_settings()
		-- mod:load_new_attachment()
		-- if mod.reset_weapon then
		-- 	for _, attachment_slot in pairs(mod.attachment_slots) do
		-- 		mod:set_gear_setting(self._gear_id, attachment_slot, nil)
		-- 	end
		-- 	mod.reset_weapon = nil
		-- end

		mod.reset_start = managers.time:time("main")

		-- mod.changed_weapon = self._selected_item
		-- mod.weapon_changed = true


		managers.ui:item_icon_updated(self._selected_item)
		managers.event:trigger("event_item_icon_updated", self._selected_item)
		managers.event:trigger("event_replace_list_item", self._selected_item)

	else
		-- if self._presentation_item.__master_item.original_attachments then
		-- 	self._presentation_item.__master_item.attachments = table_clone(self._selected_item.__master_item.attachments)
		-- 	self._selected_item.__master_item.attachments = table_clone(self._presentation_item.__master_item.original_attachments)
		-- end
		func(self, ...)
	end
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_setup_forward_gui", function(func, self, ...)
	local ui_manager = managers.ui
	local timer_name = "ui"
	local world_layer = 200
	local world_name = self._unique_id .. "_ui_forward_world"
	local view_name = self.view_name
	self._world = ui_manager:create_world(world_name, world_layer, timer_name, view_name)
	local viewport_name = self._unique_id .. "_ui_forward_world_viewport"
	local viewport_type = "default_with_alpha"
	local viewport_layer = 10
	self._viewport = ui_manager:create_viewport(self._world, viewport_name, viewport_type, viewport_layer)
	self._viewport_name = viewport_name
	local renderer_name = self._unique_id .. "_forward_renderer"
	self._ui_forward_renderer = ui_manager:create_renderer(renderer_name, self._world)
	local gui = self._ui_forward_renderer.gui
	local gui_retained = self._ui_forward_renderer.gui_retained
	local resource_renderer_name = self._unique_id
	local material_name = "content/ui/materials/render_target_masks/ui_render_target_straight_blur"
	self._ui_resource_renderer = ui_manager:create_renderer(resource_renderer_name, self._world, true, gui, gui_retained, material_name)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_setup_menu_tabs", function(func, self, content, ...)
	local item_name = self._item_name
	if item_name and mod.attachment[item_name] then
		content[3] = {
			display_name = "loc_weapon_cosmetics_customization",
			slot_name = "slot_weapon_skin",
			item_type = "WEAPON_SKIN",
			icon = "content/ui/materials/icons/system/settings/category_gameplay",
			filter_on_weapon_template = true,
			apply_on_preview = function(real_item, presentation_item)
				-- local weapon_skin = self._equipped_weapon_skin
				-- if self._presentation_item.__master_item then
				-- 	self._presentation_item.__master_item.slot_weapon_skin = nil
				-- end
				-- self._presentation_item.slot_weapon_skin = weapon_skin
				-- self._selected_weapon_skin = weapon_skin
				-- self._selected_weapon_skin_name = weapon_skin and weapon_skin.gear.masterDataInstance.id

				-- local trinket = self._equipped_weapon_trinket
				-- self._selected_weapon_trinket_name = trinket and trinket.gear.masterDataInstance.id
				-- self._selected_weapon_trinket = trinket

				-- content[1].apply_on_preview(self._equipped_weapon_skin, presentation_item)
				-- content[2].apply_on_preview(self._equipped_weapon_trinket, presentation_item)
				self:_preview_item(presentation_item)
			end
		}
	end
	func(self, content, ...)
	if item_name and mod.attachment[item_name] then
		self._tab_menu_element._widgets_by_name.entry_0.content.size[1] = button_width
		self._tab_menu_element._widgets_by_name.entry_1.content.size[1] = button_width
		self._tab_menu_element._widgets_by_name.entry_2.content.size[1] = button_width
	end
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "cb_switch_tab", function(func, self, index, ...)
	if not mod.dropdown_open then
		if index == 3 then
			self:present_grid_layout({})
			self._item_grid._widgets_by_name.grid_empty.visible = false
			mod:hide_custom_widgets(false)
			mod.original_weapon_settings = {}
			mod:get_changed_weapon_settings()
			mod:update_equip_button()
			mod:update_reset_button()

			-- Auto equip
			for attachment_slot, value in pairs(mod.changed_weapon_settings) do
				if not mod.add_custom_attachments[attachment_slot] then
					mod:resolve_auto_equips(self._selected_item, "default")
				end
			end
			for attachment_slot, value in pairs(mod.changed_weapon_settings) do
				if mod.add_custom_attachments[attachment_slot] then
					mod:resolve_auto_equips(self._selected_item, "default")
				end
			end
			-- Special
			for attachment_slot, value in pairs(mod.changed_weapon_settings) do
				if mod.add_custom_attachments[attachment_slot] then
					mod:resolve_special_changes(self._selected_item, "default")
				end
			end
			for attachment_slot, value in pairs(mod.changed_weapon_settings) do
				if not mod.add_custom_attachments[attachment_slot] then
					mod:resolve_special_changes(self._selected_item, "default")
				end
			end
		else
			local t = managers.time:time("main")
			mod.reset_start = t
			mod:check_unsaved_changes(true)
			mod:hide_custom_widgets(true)
		end
		func(self, index, ...)
	end
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_preview_element", function(func, self, element, ...)
	if not element then return end
	func(self, element, ...)
end)