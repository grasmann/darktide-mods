local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
    local MasterItems = mod:original_require("scripts/backend/master_items")
    local UIRenderer = mod:original_require("scripts/managers/ui/ui_renderer")
	local UIAnimation = mod:original_require("scripts/managers/ui/ui_animation")
    local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")
	local ScriptGui = mod:original_require("scripts/foundation/utilities/script_gui")
	local UIFontSettings = mod:original_require("scripts/managers/ui/ui_font_settings")
	local ScriptWorld = mod:original_require("scripts/foundation/utilities/script_world")
    local ButtonPassTemplates = mod:original_require("scripts/ui/pass_templates/button_pass_templates")
    local ItemPackage = mod:original_require("scripts/foundation/managers/package/utilities/item_package")
	local ScrollbarPassTemplates = mod:original_require("scripts/ui/pass_templates/scrollbar_pass_templates")
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
	local Camera = Camera
	local get_mod = get_mod
	local vector3 = Vector3
	local vector2 = Vector2
	local Localize = Localize
    local managers = Managers
    local tostring = tostring
    local callback = callback
    local math_min = math.min
    local math_max = math.max
	local unit_box = Unit.box
	local Matrix4x4 = Matrix4x4
	local unit_alive = Unit.alive
    local utf8_upper = Utf8.upper
	local table_size = table.size
    local vector3_box = Vector3Box
    local table_clone = table.clone
    local string_find = string.find
    local vector3_unbox = vector3_box.unbox
	local vector3_distance = vector3.distance
	local matrix4x4_transform = Matrix4x4.transform
	local matrix4x4_translation = Matrix4x4.translation
	local camera_world_to_screen = Camera.world_to_screen
    local unit_set_local_position = Unit.set_local_position
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local MOD_OPTION_BUILD_ANIMATION = "mod_option_weapon_build_animation"
    local edge_padding = inventory_weapon_cosmetics_view_definitions.grid_settings.edge_padding
    local grid_size = inventory_weapon_cosmetics_view_definitions.grid_settings.grid_size
    local grid_width = grid_size[1] + edge_padding
    local tab_panel_width = grid_size[1] * .75    
    local button_width = tab_panel_width * 0.3
    local edge = edge_padding * 0.5
	local LINE_THICKNESS = 2
    local dropdown_height = 32
    local label_height = 30
	local LINE_Z = 100
	local ignore_slots = {"slot_trinket_1", "slot_trinket_2", "magazine2", "1"}
	local REFERENCE = "weapon_customization"
--#endregion

-- ##### ┌─┐┬  ┌─┐┌┐ ┌─┐┬    ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ################################################################
-- ##### │ ┬│  │ │├┴┐├─┤│    ├┤ │ │││││   │ ││ ││││└─┐ ################################################################
-- ##### └─┘┴─┘└─┘└─┘┴ ┴┴─┘  └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ################################################################

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

-- ##### ┬  ┬┬┌─┐┬ ┬  ┌┬┐┌─┐┌─┐┬┌┐┌┬┌┬┐┬┌─┐┌┐┌┌─┐ #####################################################################
-- ##### └┐┌┘│├┤ │││   ││├┤ ├┤ │││││ │ ││ ││││└─┐ #####################################################################
-- #####  └┘ ┴└─┘└┴┘  ─┴┘└─┘└  ┴┘└┘┴ ┴ ┴└─┘┘└┘└─┘ #####################################################################

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
		instance.legend_inputs[#instance.legend_inputs+1] = {
			on_pressed_callback = "_cb_on_modding_tool_toggled",
			input_action = "hotkey_item_sort",
			display_name = "loc_use_modding_tool",
			alignment = "right_alignment"
		}
	end

	instance.scenegraph_definition.weapon_presets_pivot = {
		vertical_alignment = "top",
		parent = "screen",
		horizontal_alignment = "right",
		size = {0, 0},
		position = {-60, 94, 62}
	}

	instance.scenegraph_definition.weapon_customization_scrollbar = {
        vertical_alignment = "top",
        parent = "item_grid_pivot",
        horizontal_alignment = "right",
        size = {10, 970 - 40},
        position = {grid_width, 20, 0}
    }

	instance.widget_definitions.weapon_customization_scrollbar = UIWidget.create_definition(ScrollbarPassTemplates.default_scrollbar, "weapon_customization_scrollbar")

	-- instance.always_visible_widget_names.background = true

	-- instance.grid_settings.use_terminal_background = true
	-- instance.grid_settings.layer = 300

	-- mod:dtf(instance.widget_definitions, "instance.widget_definitions", 10)


end)

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view", function(instance)

	-- instance._setup_forward_gui = function(self)
	-- 	self:set_unique_id()
	-- 	self._forward_world = managers.ui:create_world(self._unique_id.."_ui_forward_world", 101, "ui", self.view_name)
	-- 	local viewport_name = self._unique_id.."_ui_forward_world_viewport"
	-- 	self._forward_viewport = managers.ui:create_viewport(self._forward_world, viewport_name, "default_with_alpha", 1)
	-- 	self._forward_viewport_name = viewport_name
	-- 	self._ui_forward_renderer = managers.ui:create_renderer(self._unique_id.."_forward_renderer", self._forward_world)
	-- 	self._ui_resource_renderer = managers.ui:create_renderer(self._unique_id, self._forward_world, true, self._ui_forward_renderer.gui,
	-- 		self._ui_forward_renderer.gui_retained, "content/ui/materials/render_target_masks/ui_render_target_straight_blur")
	-- end

	-- instance._destroy_forward_gui = function(self)
	-- 	if self._ui_resource_renderer then
	-- 		self._ui_resource_renderer = nil
	-- 		managers.ui:destroy_renderer(self._unique_id)
	-- 	end
	-- 	if self._ui_forward_renderer then
	-- 		self._ui_forward_renderer = nil
	-- 		managers.ui:destroy_renderer(self._unique_id.."_forward_renderer")
	-- 		ScriptWorld.destroy_viewport(self._forward_world, self._forward_viewport_name)
	-- 		managers.ui:destroy_world(self._forward_world)
	-- 		self._forward_viewport_name = nil
	-- 		self._forward_world = nil
	-- 	end
	-- end

	-- Overwrite draw function
    -- Draw legend elements
	instance.draw = function(self, dt, t, input_service, layer)
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
	instance._draw_elements = function(self, dt, t, ui_renderer, render_settings, input_service)
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
	instance._cb_on_ui_visibility_toggled = function (self, id)
		self._visibility_toggled_on = not self._visibility_toggled_on
		local display_name = self._visibility_toggled_on and "loc_menu_toggle_ui_visibility_off" or "loc_menu_toggle_ui_visibility_on"
		self._input_legend_element:set_display_name(id, display_name)
	end

    -- Callback when modding tool is toggled
	instance._cb_on_modding_tool_toggled = function (self, id)
		self._modding_tool_toggled_on = not self._modding_tool_toggled_on
		local ui_weapon_spawner = self._weapon_preview._ui_weapon_spawner
		local weapon_spawn_data = ui_weapon_spawner._weapon_spawn_data
		if weapon_spawn_data then
			local camera = ui_weapon_spawner._camera
			local world = ui_weapon_spawner._world
			local gui = self._ui_forward_renderer.gui
			self:get_modding_tools()
			-- if self.modding_tools and self._modding_tool_toggled_on then
			-- 	self.modding_tools:unit_manipulation_add(weapon_spawn_data.item_unit_3p, camera, world, gui, self._item_name)
			-- elseif self.modding_tools then
			-- 	self.modding_tools:unit_manipulation_remove(weapon_spawn_data.item_unit_3p)
			-- end
			for _, unit in pairs(weapon_spawn_data.attachment_units_3p) do
				local name = Unit.get_data(unit, "attachment_slot")
				if not table.contains(ignore_slots, name) then
					if self.modding_tools and name and self._modding_tool_toggled_on then
						self.modding_tools:unit_manipulation_add(unit, camera, world, gui, name)
					elseif self.modding_tools then
						self.modding_tools:unit_manipulation_remove(unit)
					end
				end
			end
			-- if self._modding_tool_toggled_on then
			-- 	modding_tools:unit_manipulation_add(weapon_spawn_data.item_unit_3p, camera, world, gui)
			-- 	local attachment_units_3p = weapon_spawn_data.attachment_units_3p or {}
			-- 	for _, unit in pairs(attachment_units_3p) do
			-- 		modding_tools:unit_manipulation_add(unit, camera, world, gui)
			-- 	end
			-- else
			-- 	modding_tools:unit_manipulation_remove(weapon_spawn_data.item_unit_3p)
			-- 	local attachment_units_3p = weapon_spawn_data.attachment_units_3p or {}
			-- 	for _, unit in pairs(attachment_units_3p) do
			-- 		modding_tools:unit_manipulation_remove(unit)
			-- 	end
			-- end
		end
	end

	-- Events
	instance.hide_ui = function(self, hide)
		self._visibility_toggled_on =  hide
		self:_cb_on_ui_visibility_toggled("entry_"..tostring(3))
	end
	
	instance.can_exit = function (self)
		return self._can_close and not mod.build_animation:is_busy()
	end

	instance.scrollbar_widget = function(self)
		return self._widgets_by_name.weapon_customization_scrollbar
	end

	instance.set_scrollbar_progress = function(self, progress)
		local scrollbar_widget = self:scrollbar_widget()
		local scrollbar_content = scrollbar_widget.content
		local scrollbar_style = scrollbar_widget.style
		scrollbar_content.scroll_length = 950
		scrollbar_content.value = progress
	end

	instance.scrollbar_active = function(self)
		return self._scrollbar_is_active
	end

	instance.update_scrollbar = function(self, input_service)
		local scrollbar_widget = self:scrollbar_widget()
		local scrollbar_content = scrollbar_widget.content
		local scrollbar_hotspot = scrollbar_content.hotspot

		if not self._scrollbar_is_active and scrollbar_hotspot._input_pressed then
			self._scrollbar_is_active = true
		elseif self._scrollbar_is_active then
			if not input_service:get("left_hold") then
				self._scrollbar_is_active = false
			end
		end

		mod:shift_attachments(scrollbar_content.value)
	end

	instance.get_modding_tools = function(self)
		self.modding_tools = self.modding_tools or get_mod("modding_tools")
	end

	instance.draw_box = function(self, unit, saved_origin)
		if unit and unit_alive(unit) then
			local tm, half_size = unit_box(unit)
			local gui = self._ui_forward_renderer.gui
			local ui_weapon_spawner = self._weapon_preview._ui_weapon_spawner
			local camera = ui_weapon_spawner and ui_weapon_spawner._camera
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
				points[name].position = matrix4x4_transform(tm, position)
			end
			-- Get position and distance to camera
			local results = {
				bottom_01 = {}, bottom_02 = {}, bottom_03 = {}, bottom_04 = {},
				top_01 = {}, top_02 = {}, top_03 = {}, top_04 = {},
			}
			for name, data in pairs(results) do
				results[name].position, results[name].distance = camera_world_to_screen(camera, points[name].position)
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
			-- Save as target for lines
			if saved_origin then
				local closest = nil
				local last = math.huge
				local saved_origin_v3 = vector3(saved_origin[1], saved_origin[2], 0)
				for name, data in pairs(results) do
					local position = vector3(data.position[1], data.position[2], 0)
					local distance = vector3_distance(saved_origin_v3, position)
					if distance < last then
						last = distance
						closest = name
					end
				end
				if closest then
					mod.equipment_line_target = {
						results[closest].position[1],
						results[closest].position[2],
					}
				end
			end
			-- Draw box
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
					ScriptGui.hud_line(gui, results[data.a].position, results[data.b].position, LINE_Z, LINE_THICKNESS, Color(255, 106, 121, 100))
				end
			end
		end
	end

	instance.weapon_unit = function(self)
		local ui_weapon_spawner = self._weapon_preview._ui_weapon_spawner
		local weapon_spawn_data = ui_weapon_spawner and ui_weapon_spawner._weapon_spawn_data
		return weapon_spawn_data and weapon_spawn_data.item_unit_3p
	end
	
	instance.draw_equipment_box = function(self, dt, t)
		local weapon_unit = self:weapon_unit()
		if weapon_unit and unit_alive(weapon_unit) and not mod.dropdown_open then
			local attachment_slots = mod:get_attachment_slots(weapon_unit)
			if attachment_slots and #attachment_slots > 0 then
				for _, attachment_slot in pairs(attachment_slots) do
					local unit = mod:get_attachment_unit(weapon_unit, attachment_slot)
					if unit and unit_alive(unit) then
						local saved_origin = mod.dropdown_positions[attachment_slot]
						if saved_origin and saved_origin[3] and saved_origin[3] == true then
							self:draw_box(unit, saved_origin)
							break
						end
					end
				end
			end
		end
	end
	
	instance.draw_equipment_lines = function(self, dt, t)
		local weapon_unit = self:weapon_unit()
		if weapon_unit and unit_alive(weapon_unit) and not mod.dropdown_open then
			local attachment_slots = mod:get_attachment_slots(weapon_unit)
			if attachment_slots and #attachment_slots > 0 then
				local gui = self._ui_forward_renderer.gui
				local camera = self._weapon_preview._ui_weapon_spawner._camera
				for _, attachment_slot in pairs(attachment_slots) do
					local unit = mod:get_attachment_unit(weapon_unit, attachment_slot)
					if unit and unit_alive(unit) then
						local box = unit_box(unit, false)
						local center_position = matrix4x4_translation(box)
						local world_to_screen, distance = camera_world_to_screen(camera, center_position)
						if mod.equipment_line_target then
							world_to_screen = vector2(mod.equipment_line_target[1], mod.equipment_line_target[2])
						end
						local saved_origin = mod.dropdown_positions[attachment_slot]
						if saved_origin and saved_origin[3] and saved_origin[3] == true then
							local origin = vector2(saved_origin[1], saved_origin[2])
							local color = Color(255, 49, 62, 45)
							ScriptGui.hud_line(gui, origin, world_to_screen, LINE_Z, LINE_THICKNESS, Color(255, 106, 121, 100))
							break
						end
					end
				end
			end
		end
	end

	instance.is_tab = function(self)
		return self._selected_tab_index == 3
	end

	instance.reevaluate_packages = function(self)
		local package_synchronizer_client = managers.package_synchronization:synchronizer_client()
		if package_synchronizer_client then
			package_synchronizer_client:reevaluate_all_profiles_packages()
		end
	end

	instance.equip_attachments = function(self)

		-- Reset original settings
		mod.original_weapon_settings = {}

		-- Reset animation
		mod.reset_start = mod:main_time() --managers.time:time("main")

		-- Update equip button
		self:update_equip_button()

		-- Get changed settings
		mod:get_changed_weapon_settings()

		-- Load new attachments
		mod:load_new_attachment()

		-- Save gear settings
		if mod.gear_settings then
			mod.gear_settings:save(self._presentation_item)
		end

		-- Reevaluate packages
		self:reevaluate_packages()

		-- Reload current weapon
		mod:redo_weapon_attachments(self._presentation_item)

		-- Update UI icons
		managers.ui:item_icon_updated(self._selected_item)
		managers.event:trigger("event_item_icon_updated", self._selected_item)
		managers.event:trigger("event_replace_list_item", self._selected_item)

	end

	instance.reset_attachments = function(self, no_animation)

		-- Get changed settings
		mod:get_changed_weapon_settings()

		-- Auto equip
		self:resolve_auto_equips(mod.changed_weapon_settings)

		-- Special
		self:resolve_special_changes(mod.changed_weapon_settings)

		-- Check unsaved
		mod:check_unsaved_changes(no_animation)

		-- Redo attachments
		mod:redo_weapon_attachments(self._presentation_item)

	end

	instance.add_custom_tab = function(self, content)
		local item_name = self._item_name
		if item_name and mod.attachment[item_name] then
			content[3] = {
				display_name = "loc_weapon_cosmetics_customization",
				slot_name = "slot_weapon_skin",
				item_type = "WEAPON_SKIN",
				icon = "content/ui/materials/icons/system/settings/category_gameplay",
				filter_on_weapon_template = true,
				apply_on_preview = function(real_item, presentation_item)
					self:_preview_item(presentation_item)
				end
			}
		end
	end

	instance.resize_tabs = function(self)
		local item_name = self._item_name
		if item_name and mod.attachment[item_name] then
			self._tab_menu_element._widgets_by_name.entry_0.content.size[1] = button_width
			self._tab_menu_element._widgets_by_name.entry_1.content.size[1] = button_width
			self._tab_menu_element._widgets_by_name.entry_2.content.size[1] = button_width
		end
	end

	instance.register_custom_button_callbacks = function(self)
		self._widgets_by_name.reset_button.content.hotspot.pressed_callback = callback(self, "cb_on_reset_pressed")
		self._widgets_by_name.randomize_button.content.hotspot.pressed_callback = callback(self, "cb_on_randomize_pressed")
		self._widgets_by_name.demo_button.content.hotspot.pressed_callback = callback(mod, "cb_on_demo_pressed")
	end

	instance.get_attachment_names = function(self, attachment_settings)
		local attachment_names = {}
		for attachment_slot, value in pairs(attachment_settings) do
			attachment_names[attachment_slot] = mod:get_gear_setting(self._gear_id, attachment_slot, self._selected_item)
		end
		return attachment_names
	end

	instance.resolve_auto_equips = function(self, attachment_settings)
		for attachment_slot, value in pairs(attachment_settings) do
			if not mod.add_custom_attachments[attachment_slot] then
				mod:resolve_auto_equips(self._presentation_item, "default")
			end
		end
		for attachment_slot, value in pairs(attachment_settings) do
			if mod.add_custom_attachments[attachment_slot] then
				mod:resolve_auto_equips(self._presentation_item, "default")
			end
		end
	end

	instance.resolve_special_changes = function(self, attachment_settings)
		for attachment_slot, value in pairs(attachment_settings) do
			if mod.add_custom_attachments[attachment_slot] then
				mod:resolve_special_changes(self._presentation_item, "default")
			end
		end
		for attachment_slot, value in pairs(attachment_settings) do
			if not mod.add_custom_attachments[attachment_slot] then
				mod:resolve_special_changes(self._presentation_item, "default")
			end
		end
	end

	instance.attach_attachments = function(self, attachment_settings, attachment_names, skip_animation)
		local index = 1
		mod.weapon_part_animation_update = not skip_animation
		for attachment_slot, value in pairs(attachment_settings) do
			if not skip_animation then
				mod.build_animation:animate(self._selected_item, attachment_slot, attachment_names[attachment_slot], value, nil, nil, true)
			else
				mod:load_new_attachment(self._selected_item, attachment_slot, value, index < table_size(attachment_settings))
			end
			index = index + 1
		end
	end

	instance.attachments_changed_since_start = function(self)
		if table_size(mod.start_weapon_settings) ~= table_size(mod.changed_weapon_settings) then return true end
		for attachment_slot, value in pairs(mod.start_weapon_settings) do
			local changed_setting = mod.changed_weapon_settings[attachment_slot]
			if value ~= changed_setting then return true end
		end
	end

	instance.attachments_changed_at_all = function(self)
		for attachment_slot, value in pairs(mod.changed_weapon_settings) do
			local default = mod:get_actual_default_attachment(self._selected_item, attachment_slot)
			if default and value ~= default then return true end
		end
	end

	instance.update_equip_button = function(self)
		if self._selected_tab_index == 3 then
			local button = self._widgets_by_name.equip_button
			local button_content = button.content
			-- local disabled = table_size(mod.original_weapon_settings) == 0 or mod.build_animation:is_busy()
			local disabled = not self:attachments_changed_since_start() or mod.build_animation:is_busy()
			button_content.hotspot.disabled = disabled
			button_content.text = utf8_upper(disabled and mod:localize("loc_weapon_inventory_equipped_button") or mod:localize("loc_weapon_inventory_equip_button"))
		end
	end
	
	instance.update_reset_button = function(self)
		local button = self._widgets_by_name.reset_button
		local button_content = button.content
		-- local disabled = table_size(mod.changed_weapon_settings) == 0 or mod.build_animation:is_busy()
		local disabled = not self:attachments_changed_at_all() or mod.build_animation:is_busy()
		-- for k, v in pairs(mod.changed_weapon_settings) do
		-- 	mod:echot("setting: "..tostring(k))
		-- end
		button_content.hotspot.disabled = disabled
		button_content.text = utf8_upper(disabled and mod:localize("loc_weapon_inventory_no_reset_button") or mod:localize("loc_weapon_inventory_reset_button"))
	end

	instance.cb_on_reset_pressed = function(self, skip_animation)

		-- self:get_changed_weapon_settings()
		if self._visibility_toggled_on and self._gear_id and mod.changed_weapon_settings and table_size(mod.changed_weapon_settings) > 0 then
			
			-- Skip animation?
			local skip_animation = skip_animation or not mod:get(MOD_OPTION_BUILD_ANIMATION)
	
			-- Clone changed settings
			local changed_weapon_settings = table_clone(mod.changed_weapon_settings)
			for attachment_slot, value in pairs(changed_weapon_settings) do
				changed_weapon_settings[attachment_slot] = "default"
			end
			
			-- Get attachment names
			local attachment_names = self:get_attachment_names(changed_weapon_settings)

			-- Attach default attachments
			self:attach_attachments(changed_weapon_settings, attachment_names, skip_animation)

			-- Auto equip
			self:resolve_auto_equips(changed_weapon_settings)

			-- Special
			self:resolve_special_changes(changed_weapon_settings)
	
			mod:start_weapon_move()
			mod.new_rotation = 0
			mod.do_rotation = true
		end
	end

	instance.update_randomize_button = function(self)
		local button = self._widgets_by_name.randomize_button
		local button_content = button.content
		local disabled = mod.build_animation:is_busy()
		button_content.hotspot.disabled = disabled
	end

	instance.cb_on_randomize_pressed = function(self, skip_animation)
	
		-- Get random attachments
		local random_attachments = mod:randomize_weapon(self._selected_item)
	
		if self._visibility_toggled_on and self._gear_id and random_attachments and table_size(random_attachments) > 0 then

			-- Skip animation?
			local skip_animation = skip_animation or not mod:get(MOD_OPTION_BUILD_ANIMATION)

			-- Get attachment names
			local attachment_names = self:get_attachment_names(random_attachments)

			-- Attach random attachments
			self:attach_attachments(random_attachments, attachment_names, skip_animation)

			-- Auto equip
			self:resolve_auto_equips(random_attachments)

			-- Special
			self:resolve_special_changes(random_attachments)

			-- Get changed settings
			mod:get_changed_weapon_settings()

		end
	end

end)

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #############################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################################################

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

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "on_enter", function(func, self, ...)
	-- Fetch instance
	mod.cosmetics_view = self

	mod:persistent_table(REFERENCE).temp_gear_settings[self._gear_id] = {}

    func(self, ...)

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
	-- mod:resolve_overlapping_widgets()
	-- mod:get_dropdown_positions()
	mod:init_custom_weapon_zoom()

	mod.original_weapon_settings = {}
	mod:get_changed_weapon_settings()
	-- mod.start_weapon_settings = table_clone(mod.changed_weapon_settings)
	self:update_reset_button()

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

	self:set_scrollbar_progress(0)

	managers.event:register(self, "weapon_customization_hide_ui", "hide_ui")

	mod:get_changed_weapon_settings()
	-- mod:dtf(mod.changed_weapon_settings, "mod.changed_weapon_settings", 5)
	mod.start_weapon_settings = table_clone(mod.changed_weapon_settings)

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "update", function(func, self, dt, t, input_service, ...)

	if self._selected_tab_index == 3 then
		self._previewed_element = nil
	end

	self._weapon_preview._ui_weapon_spawner._rotation_input_disabled = mod.dropdown_open or self:scrollbar_active() or self._grid_hovered

    local pass_input, pass_draw = func(self, dt, t, input_service, ...)

	if mod.cosmetics_view then
		mod:update_custom_widgets(input_service, dt, t)
		mod:update_attachment_info()
		
		
	end



	-- if mod.cosmetics_view and mod.demo then
	-- 	local rotation_angle = (mod._last_rotation_angle or 0) + dt
	-- 	self._weapon_preview._ui_weapon_spawner._rotation_angle = rotation_angle
	-- 	self._weapon_preview._ui_weapon_spawner._default_rotation_angle = rotation_angle
	-- 	mod._last_rotation_angle = self._weapon_preview._ui_weapon_spawner._default_rotation_angle
	-- 	if mod.demo_timer < t then
	-- 		mod:cb_on_randomize_pressed(true)
	-- 		mod.demo_timer = t + mod.demo_time
	-- 	end
	-- end

	self:update_equip_button()
	self:update_reset_button()
	self:update_randomize_button()

	return pass_input, pass_draw
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_handle_input", function(func, self, input_service, dt, t, ...)
	local zoom_target = self._weapon_zoom_target
	local zoom_fraction = self._weapon_zoom_fraction

	if self._grid_hovered and not mod.dropdown_open and self.total_dropdown_height > 950 then
		local scroll_axis = input_service:get("scroll_axis")
		if scroll_axis then
			-- local scroll = scroll_axis[2]
			-- local scroll_speed = 0.05
			local scrollbar_widget = self:scrollbar_widget()
			local scrollbar_content = scrollbar_widget.content
			local val = math.clamp(scrollbar_content.value - scroll_axis[2] * 0.05, 0, 1)
			self:set_scrollbar_progress(val)
		end
	end

	func(self, input_service, dt, t, ...)

	self:update_scrollbar(input_service)

	local cursor = input_service:get("cursor")
	self._grid_hovered = cursor[1] > 160 and cursor[1] < grid_width + 160

	if mod.dropdown_open or self:scrollbar_active() or self._grid_hovered then
		self._weapon_zoom_target = zoom_target
		self._weapon_zoom_fraction = zoom_fraction
	end
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_register_button_callbacks", function(func, self, ...)

	-- Original function
	func(self, ...)
	
	-- Register custom button callbacks
	self:register_custom_button_callbacks()

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_set_weapon_zoom", function(func, self, fraction, ...)
	if not mod.dropdown_open and not self._scrollbar_is_active and not self._grid_hovered then
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
	self:draw_equipment_lines(dt, t)
	self:draw_equipment_box(dt, t)

	local bar_breakdown_widgets = self.bar_breakdown_widgets

	if bar_breakdown_widgets then
		for _, widget in ipairs(bar_breakdown_widgets) do
			UIWidget.draw(widget, ui_renderer)
		end
	end

	-- UIWidget.draw(self._widgets_by_name.weapon_customization_scrollbar, ui_renderer)

	UIRenderer.end_pass(ui_renderer)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "on_exit", function(func, self, ...)

	-- Reset attachments
	self:reset_attachments(true)


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

	-- mod:check_unsaved_changes(true)
	mod:release_attachment_sounds()

	managers.event:unregister(self, "weapon_customization_hide_ui")
	
	-- mod:redo_weapon_attachments(self._presentation_item)

	mod:persistent_table(REFERENCE).temp_gear_settings[self._gear_id] = nil

	func(self, ...)

	mod.cosmetics_view = nil
	mod.reset_weapon = nil
	-- Fade.destroy(self._fade_system)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "cb_on_equip_pressed", function(func, self, ...)

	if self:is_tab() then

		-- Equip attachments
		self:equip_attachments()

		-- Get changed settings
		mod:get_changed_weapon_settings()
		mod.start_weapon_settings = table_clone(mod.changed_weapon_settings)

	else
		
		-- Original function
		func(self, ...)

	end
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_setup_menu_tabs", function(func, self, content, ...)

	-- Add custom tab
	self:add_custom_tab(content)

	-- Original function
	func(self, content, ...)

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "cb_switch_tab", function(func, self, index, ...)
	if not mod.dropdown_open then
		if index == 3 then
			self:present_grid_layout({})
			self._item_grid._widgets_by_name.grid_empty.visible = false
			mod:hide_custom_widgets(false)
			mod.original_weapon_settings = {}
			mod:get_changed_weapon_settings()
			-- self:update_equip_button()
			-- self:update_reset_button()

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

	-- Return on nil
	if not element then return end

	-- Original function
	func(self, element, ...)

end)