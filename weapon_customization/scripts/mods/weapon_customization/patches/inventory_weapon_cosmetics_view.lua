local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
	local ItemUtils = mod:original_require("scripts/utilities/items")
	local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
	local TextUtilities = mod:original_require("scripts/utilities/ui/text")
	local MasterItems = mod:original_require("scripts/backend/master_items")
	local UIRenderer = mod:original_require("scripts/managers/ui/ui_renderer")
	local UIAnimation = mod:original_require("scripts/managers/ui/ui_animation")
	local UIScenegraph = mod:original_require("scripts/managers/ui/ui_scenegraph")
	local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")
	local ScriptGui = mod:original_require("scripts/foundation/utilities/script_gui")
	local UIFontSettings = mod:original_require("scripts/managers/ui/ui_font_settings")
	local ScriptWorld = mod:original_require("scripts/foundation/utilities/script_world")
	local ButtonPassTemplates = mod:original_require("scripts/ui/pass_templates/button_pass_templates")
	local ItemPackage = mod:original_require("scripts/foundation/managers/package/utilities/item_package")
	local DropdownPassTemplates = mod:original_require("scripts/ui/pass_templates/dropdown_pass_templates")
	local CheckboxPassTemplates = mod:original_require("scripts/ui/pass_templates/checkbox_pass_templates")
	local ScrollbarPassTemplates = mod:original_require("scripts/ui/pass_templates/scrollbar_pass_templates")
	local WwiseGameSyncSettings = mod:original_require("scripts/settings/wwise_game_sync/wwise_game_sync_settings")
	local ViewElementWeaponInfoDefinitions = mod:original_require("scripts/ui/view_elements/view_element_weapon_info/view_element_weapon_info_definitions")
	local inventory_weapon_cosmetics_view_definitions = mod:original_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view_definitions")
	
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
	local Utf8 = Utf8
	local type = type
	local Unit = Unit
	local math = math
	local table = table
	local pairs = pairs
	local CLASS = CLASS
	local Color = Color
	local World = World
	local unpack = unpack
	local ipairs = ipairs
	local string = string
	local Camera = Camera
	local get_mod = get_mod
	local vector3 = Vector3
	local vector2 = Vector2
	local math_abs = math.abs
	local Localize = Localize
	local managers = Managers
	local tostring = tostring
	local callback = callback
	local math_min = math.min
	local math_max = math.max
	local unit_box = Unit.box
	local Matrix4x4 = Matrix4x4
	local math_ceil = math.ceil
	local math_lerp = math.lerp
	local unit_alive = Unit.alive
	local table_find = table.find
	local utf8_upper = Utf8.upper
	local table_size = table.size
	local Quaternion = Quaternion
	local string_gsub = string.gsub
	local vector3_box = Vector3Box
	local table_clear = table.clear
	local table_clone = table.clone
	local string_find = string.find
	local vector3_lerp = vector3.lerp
	local vector3_zero = vector3.zero
	local table_insert = table.insert
	local table_reverse = table.reverse
	local table_contains = table.contains
	local vector3_unbox = vector3_box.unbox
	local RESOLUTION_LOOKUP = RESOLUTION_LOOKUP
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
	local TOGGLE_VISIBILITY_ENTRY = "entry_"..tostring(3)
	local SOUND_DURATION = .5

	mod.weapon_changed = nil
	mod.cosmetics_view = nil
--#endregion

-- ##### ┬  ┬┬┌─┐┬ ┬  ┌┬┐┌─┐┌─┐┬┌┐┌┬┌┬┐┬┌─┐┌┐┌┌─┐ #####################################################################
-- ##### └┐┌┘│├┤ │││   ││├┤ ├┤ │││││ │ ││ ││││└─┐ #####################################################################
-- #####  └┘ ┴└─┘└┴┘  ─┴┘└─┘└  ┴┘└┘┴ ┴ ┴└─┘┘└┘└─┘ #####################################################################

mod:hook_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view_definitions", function(instance)

	local top, z, y = 115, 100, -20
	local info_box_size = {1250, 200}
	local equip_button_size = {374, 76}

	-- Create attachment info box widgets
	local sub_display_name_style = table_clone(UIFontSettings.header_3)
	sub_display_name_style.text_horizontal_alignment = "left"
	sub_display_name_style.text_vertical_alignment = "top"

	-- Get attachment slot scenegraph names
	local cosmetics_scenegraphs = mod:get_cosmetics_scenegraphs()
	-- local cosmetics_scenegraphs = mod.data_cache:cosmetics_scenegraphs()

	-- Iterate through attachment slot scenegraphs
	for _, scenegraph_id in pairs(cosmetics_scenegraphs) do
		-- Check if scenegraph is a label
		-- if string_find(scenegraph_id, "text_pivot") then
		if mod:cached_find(scenegraph_id, "text_pivot") then
			y = y + label_height
		else
			y = y + dropdown_height
		end
		-- Create scenegraph entry
		instance.scenegraph_definition[scenegraph_id] = {
			vertical_alignment = "top",
			parent = "item_grid_pivot",
			horizontal_alignment = "left",
			size = {grid_size[1], label_height},
			position = {edge, y, z}
		}
	end

	-- Create item grid scenegraph
	instance.scenegraph_definition.item_grid_pivot = {
		vertical_alignment = "top",
		parent = "screen",
		horizontal_alignment = "left",
		size = {0, 0},
		position = {160, 15, 0},
	}

	-- Modify grid tab panel scenegraph
	instance.scenegraph_definition.grid_tab_panel.position[1] = grid_width - (grid_width - tab_panel_width) - 20
	instance.scenegraph_definition.grid_tab_panel.position[2] = -48
	instance.scenegraph_definition.grid_tab_panel.size[1] = tab_panel_width

	-- Modify grid settings
	instance.grid_settings.grid_size[2] = 970
	instance.grid_settings.mask_size[2] = 970

	-- Modify info box scenegraph
	instance.scenegraph_definition.info_box.vertical_alignment = "top"
	instance.scenegraph_definition.info_box.horizontal_alignment = "left"
	instance.scenegraph_definition.info_box.position = {grid_width + 160, -100, 3}
	instance.scenegraph_definition.info_box.size[1] = 1920 - (grid_width + 160)

	-- Modify display name scenegraph
	instance.scenegraph_definition.display_name.horizontal_alignment = "left"
	instance.scenegraph_definition.display_name.size[1] = 1920 - (grid_width + 160)
	-- instance.scenegraph_definition.display_name.position[2] = 0

	-- Modify sub display name scenegraph
	instance.scenegraph_definition.sub_display_name.horizontal_alignment = "left"
	instance.scenegraph_definition.sub_display_name.size[1] = 1920 - (grid_width + 160)
	-- instance.scenegraph_definition.sub_display_name.position[2] = -50

	-- Modify button pivot background
	instance.widget_definitions.button_pivot_background.style.background.visible = false
	
	-- Modify equip button scenegraph
	instance.scenegraph_definition.equip_button = {
		vertical_alignment = "bottom",
		parent = "corner_bottom_right",
		horizontal_alignment = "right",
		size = equip_button_size,
		position = {0, 0, 1},
		offset = {-100, -70, 1}
	}

	-- Create reset button scenegraph
	instance.scenegraph_definition.reset_button = {
		vertical_alignment = "bottom",
		parent = "equip_button",
		horizontal_alignment = "right",
		size = equip_button_size,
		position = {-equip_button_size[1] - 35, 0, 1}
	}
	-- Create reset button widget
	instance.widget_definitions.reset_button = UIWidget.create_definition(table_clone(ButtonPassTemplates.default_button), "reset_button", {
		gamepad_action = "confirm_pressed",
		text = utf8_upper(mod:localize("loc_weapon_inventory_reset_button")),
		hotspot = {
			on_pressed_sound = UISoundEvents.weapons_skin_confirm
		}
	})
	instance.widget_definitions.reset_button.content.original_text = utf8_upper(mod:localize("loc_weapon_inventory_reset_button"))

	-- Create randomize button scenegraph
	instance.scenegraph_definition.randomize_button = {
		vertical_alignment = "bottom",
		parent = "reset_button",
		horizontal_alignment = "right",
		size = equip_button_size,
		position = {-equip_button_size[1] - 35, 0, 1}
	}
	-- Create randomize button widget
	instance.widget_definitions.randomize_button = UIWidget.create_definition(table_clone(ButtonPassTemplates.default_button), "randomize_button", {
		gamepad_action = "confirm_pressed",
		text = utf8_upper(mod:localize("loc_weapon_inventory_randomize_button")),
		hotspot = {
			on_pressed_sound = UISoundEvents.weapons_skin_confirm
		}
	})
	instance.widget_definitions.randomize_button.content.original_text = utf8_upper(mod:localize("loc_weapon_inventory_randomize_button"))

	-- Create randomize button scenegraph
	instance.scenegraph_definition.reload_definitions_button = {
		vertical_alignment = "bottom",
		parent = "equip_button",
		horizontal_alignment = "right",
		size = equip_button_size,
		position = {0, -equip_button_size[2] - 10, 1}
	}
	-- Create randomize button widget
	instance.widget_definitions.reload_definitions_button = UIWidget.create_definition(table_clone(ButtonPassTemplates.default_button), "reload_definitions_button", {
		gamepad_action = "confirm_pressed",
		text = utf8_upper(mod:localize("loc_weapon_inventory_reload_definitions_button")),
		hotspot = {
			on_pressed_sound = UISoundEvents.weapons_skin_confirm
		}
	}, equip_button_size)
	instance.widget_definitions.reload_definitions_button.content.original_text = utf8_upper(mod:localize("loc_weapon_inventory_reload_definitions_button"))

	-- Create attachment info box scenegraphs
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

	-- Create scrollbar scenegraph
	instance.scenegraph_definition.weapon_customization_scrollbar = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "right",
		size = {10, 970 - 40},
		position = {grid_width, 20, 0}
	}
	-- Create scrollbar widget
	instance.widget_definitions.weapon_customization_scrollbar = UIWidget.create_definition(ScrollbarPassTemplates.default_scrollbar, "weapon_customization_scrollbar")

	local legends_contain = function(display_name)
		for _, legend_input in pairs(instance.legend_inputs) do
			if legend_input.display_name == display_name then
				return true
			end
		end
	end

	-- Modify legend inputs
	-- if #instance.legend_inputs == 1 then
	if not legends_contain("loc_menu_toggle_ui_visibility_off") then
		instance.legend_inputs[#instance.legend_inputs+1] = {
			on_pressed_callback = "_cb_on_ui_visibility_toggled",
			input_action = "hotkey_menu_special_2",
			display_name = "loc_menu_toggle_ui_visibility_off",
			alignment = "right_alignment"
		}
	end
	if not legends_contain("loc_use_modding_tool") then
		instance.legend_inputs[#instance.legend_inputs+1] = {
			on_pressed_callback = "_cb_on_modding_tool_toggled",
			input_action = "hotkey_item_sort",
			display_name = "loc_use_modding_tool",
			alignment = "right_alignment"
		}
	end

end)

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view", function(instance)

	-- ##### ┌─┐┌─┐┌┬┐┌─┐┬─┐┌─┐  ┌┬┐┌─┐┬  ┬┌─┐┌┬┐┌─┐┌┐┌┌┬┐ ############################################################
	-- ##### │  ├─┤│││├┤ ├┬┘├─┤  ││││ │└┐┌┘├┤ │││├┤ │││ │  ############################################################
	-- ##### └─┘┴ ┴┴ ┴└─┘┴└─┴ ┴  ┴ ┴└─┘ └┘ └─┘┴ ┴└─┘┘└┘ ┴  ############################################################
	
	instance.start_weapon_move = function(self, position)
		local ui_weapon_spawner = self:ui_weapon_spawner()
		if ui_weapon_spawner then
			ui_weapon_spawner:initiate_camera_movement(position)
		end
	end

	-- ┌─┐┬  ┬┌─┐┬─┐┬ ┬┬─┐┬┌┬┐┌─┐  ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐
	-- │ │└┐┌┘├┤ ├┬┘│││├┬┘│ │ ├┤   ├┤ │ │││││   │ ││ ││││└─┐
	-- └─┘ └┘ └─┘┴└─└┴┘┴└─┴ ┴ └─┘  └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘

	-- Overwrite draw function
	-- Draw legend elements
	instance.draw = function(self, dt, t, input_service, layer)
		local render_scale = self._render_scale
		local render_settings = self._render_settings
		local ui_renderer = self._ui_renderer
		local ui_default_renderer = self._ui_default_renderer
		local ui_forward_renderer = self._ui_forward_renderer or ui_default_renderer
		render_settings.start_layer = layer
		render_settings.scale = render_scale
		render_settings.inverse_scale = render_scale and 1 / render_scale
		local alpha_multiplier = render_settings.alpha_multiplier
		render_settings.alpha_multiplier = 1
		local ui_scenegraph = self._ui_scenegraph
	
		UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, render_settings)
		UIWidget.draw(self._background_widget, ui_renderer)
		UIRenderer.end_pass(ui_renderer)
		render_settings.alpha_multiplier = alpha_multiplier
		UIRenderer.begin_pass(ui_forward_renderer, ui_scenegraph, input_service, dt, render_settings)
		self:_draw_widgets(dt, t, input_service, ui_forward_renderer, render_settings)
		UIRenderer.end_pass(ui_forward_renderer)
		self:_draw_elements(dt, t, ui_forward_renderer, render_settings, input_service)
		self:_draw_render_target()
	end

	-- Overwrite draw elements function
	-- Make view legend inputs visible when UI gets hidden
	instance._draw_elements = function(self, dt, t, ui_renderer, render_settings, input_service)
		-- Overwrite draw function
		-- render_settings.alpha_multiplier = 1
		-- self._alpha_multiplier = 1

		local old_alpha_multiplier = render_settings.alpha_multiplier
		local alpha_multiplier = self._alpha_multiplier or 1
		local elements_array = self._elements_array
		-- if not mod.test83294234 then
		-- 	mod:dtf(elements_array, "elements_array", 10)
		-- 	mod.test83294234 = true
		-- end
		for i = 1, #elements_array do
			local element = elements_array[i]
			if element then
				local element_name = element.__class_name
				if element_name ~= "ViewElementInventoryWeaponPreview" or element_name ~= "ViewElementInputLegend" then
					ui_renderer = self._ui_default_renderer or ui_renderer
				end
				render_settings.alpha_multiplier = (element_name ~= "ViewElementInventoryWeaponPreview" and element_name ~= "ViewElementInputLegend") and alpha_multiplier or 1
				element:draw(dt, t, ui_renderer, render_settings, input_service)
			end
		end
		render_settings.alpha_multiplier = old_alpha_multiplier
	end

	-- Overwrite draw widgets function
	-- Make view legend inputs visible when UI gets hidden
	instance._draw_widgets = function(self, dt, t, input_service, ui_renderer, render_settings)
		local always_visible_widget_names = self._always_visible_widget_names
		local alpha_multiplier = self._render_settings and self._render_settings.alpha_multiplier or 1
		local anim_alpha_speed = 3
	
		if self._visibility_toggled_on and not self._modding_tool_toggled_on then
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
	
		self:get_dropdown_positions()
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
	end

	-- Overwrite can exit function
	instance.can_exit = function (self)
		-- Check build animation
		return self._can_close and not mod.build_animation:is_busy()
	end

	-- ┬─┐┌─┐┌┬┐┬─┐┬┌─┐┬  ┬┌─┐  ┬┌┐┌┌─┐┌─┐┬─┐┌┬┐┌─┐┌┬┐┬┌─┐┌┐┌
	-- ├┬┘├┤  │ ├┬┘│├┤ └┐┌┘├┤   ││││├┤ │ │├┬┘│││├─┤ │ ││ ││││
	-- ┴└─└─┘ ┴ ┴└─┴└─┘ └┘ └─┘  ┴┘└┘└  └─┘┴└─┴ ┴┴ ┴ ┴ ┴└─┘┘└┘

	-- Check if custom tab is selected
	instance.is_tab = function(self, index)
		return index == 3 or self.__selected_tab_index == 3
	end

	-- Get forward gui
	instance.forward_gui = function(self)
		return self._ui_forward_renderer.gui
	end

	-- Get UI weapon spawner
	instance.ui_weapon_spawner = function(self)
		return self._weapon_preview._ui_weapon_spawner
	end

	-- Get weapon spawn data
	instance.weapon_spawn_data = function(self)
		-- Get UI weapon spawner
		local ui_weapon_spawner = self:ui_weapon_spawner()
		-- Return weapon spawn data
		return ui_weapon_spawner and ui_weapon_spawner._weapon_spawn_data
	end

	-- Check if weapon spawn data exists
	instance.weapon_spawned = function(self)
		return self:weapon_spawn_data() ~= nil
	end

	-- Get weapon unit
	instance.weapon_unit = function(self)
		-- Get weapon spawn data
		local weapon_spawn_data = self:weapon_spawn_data()
		-- Return weapon unit
		return weapon_spawn_data and weapon_spawn_data.item_unit_3p
	end

	-- Get attachment units
	instance.attachment_units = function(self)
		-- Get weapon spawn data
		local weapon_spawn_data = self:weapon_spawn_data()
		-- Return attachment units
		-- return weapon_spawn_data and weapon_spawn_data.attachment_units_3p
		return weapon_spawn_data and weapon_spawn_data.attachment_units_3p and weapon_spawn_data.attachment_units_3p[weapon_spawn_data.item_unit_3p]
	end

	-- Check if is busy
	instance.is_busy = function(self)
		return mod.dropdown_open or self:scrollbar_active() or self._grid_hovered or mod.build_animation:is_busy()
	end

	-- Find custom widget
	instance.find_custom_widget = function(self, name)
		for _, widget in pairs(self._custom_widgets) do
			if widget.name == name then
				return widget
			end
		end
	end

	-- ┌┬┐┌─┐┌┬┐┌┬┐┬┌┐┌┌─┐  ┌┬┐┌─┐┌─┐┬  ┌─┐
	-- ││││ │ ││ │││││││ ┬   │ │ ││ ││  └─┐
	-- ┴ ┴└─┘─┴┘─┴┘┴┘└┘└─┘   ┴ └─┘└─┘┴─┘└─┘

	-- Get modding tools
	instance.get_modding_tools = function(self)
		self.modding_tools = self.modding_tools or get_mod("modding_tools")
	end

	-- Callback when modding tool is toggled
	instance._cb_on_modding_tool_toggled = function (self, id)
		-- Toggle modding tool variable
		self._modding_tool_toggled_on = not self._modding_tool_toggled_on
		-- Check if weapon spawned
		if self:weapon_spawned() then
			-- Get objects
			local ui_weapon_spawner = self:ui_weapon_spawner()
			local camera = ui_weapon_spawner._camera
			local world = ui_weapon_spawner._world
			local gui = self._ui_forward_renderer.gui
			-- Get modding tools
			self:get_modding_tools()
			-- Iterate through attachment units
			for _, unit in pairs(self:attachment_units()) do
				-- Get attachment slot
				local name = Unit.get_data(unit, "attachment_slot")
				-- Ignore slots
				if not table.contains(ignore_slots, name) then
					-- Toggle modding tools
					if self.modding_tools and name and self._modding_tool_toggled_on then
						-- Add unit
						self.modding_tools:unit_manipulation_add({unit = unit, camera = camera, world = world, gui = gui, name = name})
					elseif self.modding_tools then
						-- Remove unit
						self.modding_tools:unit_manipulation_remove(unit)
					end
				end
			end
		end
	end

	-- ┬ ┬┬  ┬  ┬┬┌─┐┬┌┐ ┬┬  ┬┌┬┐┬ ┬  ┌┬┐┌─┐┌─┐┌─┐┬  ┌─┐
	-- │ ││  └┐┌┘│└─┐│├┴┐││  │ │ └┬┘   │ │ ││ ┬│ ┬│  ├┤ 
	-- └─┘┴   └┘ ┴└─┘┴└─┘┴┴─┘┴ ┴  ┴    ┴ └─┘└─┘└─┘┴─┘└─┘

	-- Programmtically toggle Hide UI
	instance.hide_ui = function(self, hide)
		-- Toggle visibility variable
		self._visibility_toggled_on =  hide
		-- Execute callback 
		self:_cb_on_ui_visibility_toggled(TOGGLE_VISIBILITY_ENTRY)
	end
	
	-- Callback when UI visibility is toggled
	instance._cb_on_ui_visibility_toggled = function (self, id)
		-- Toggle visibility variable
		self._visibility_toggled_on = self._modding_tool_toggled_on == true and false or not self._visibility_toggled_on
		-- Update button display name
		self._input_legend_element:set_display_name(id, self._visibility_toggled_on and "loc_menu_toggle_ui_visibility_off" or "loc_menu_toggle_ui_visibility_on")
	end

	-- ┌─┐┌─┐┬─┐┌─┐┬  ┬  ┌┐ ┌─┐┬─┐
	-- └─┐│  ├┬┘│ ││  │  ├┴┐├─┤├┬┘
	-- └─┘└─┘┴└─└─┘┴─┘┴─┘└─┘┴ ┴┴└─

	-- Get scrollbar widget
	instance.scrollbar_widget = function(self)
		return self._widgets_by_name.weapon_customization_scrollbar
	end

	-- Set scrollbar progress
	instance.set_scrollbar_progress = function(self, progress)
		-- Get scrollbar widget
		local widget = self:scrollbar_widget()
		-- Get scrollbar content
		local content = widget and widget.content
		-- Set scrollbar progress
		if content then
			content.scroll_length = 950
			content.value = progress
		end
	end

	-- Check if scrollbar is active
	instance.scrollbar_active = function(self)
		return self._scrollbar_is_active
	end

	-- Update scrollbar input
	instance.update_scrollbar = function(self, input_service)
		-- Get scrollbar widget
		local widget = self:scrollbar_widget()
		-- Get scrollbar content
		local content = widget and widget.content
		-- Get scrollbar hotspot
		local hotspot = content and content.hotspot
		-- Scrollbar pressed
		if not self._scrollbar_is_active and hotspot._input_pressed then
			-- Set active
			self._scrollbar_is_active = true
		elseif self._scrollbar_is_active and not input_service:get("left_hold") then
			-- Set inactive
			self._scrollbar_is_active = false
		end
		-- Shift attachments
		self:shift_attachments(content.value)
	end

	-- Check if scrollbar is needed
	instance.scrollbar_needed = function(self)
		return self.total_dropdown_height > 950
	end

	-- Scrollbar input
	instance.handle_scrollbar_input = function(self, input_service)
		-- Update grid hover
		local cursor = input_service:get("cursor")
		self._grid_hovered = cursor[1] > 160 and cursor[1] < grid_width + 160
		-- Check if scrollbar is needed and grid hovered
		if self._grid_hovered and not mod.dropdown_open and self:scrollbar_needed() then
			local scroll_axis = input_service:get("scroll_axis")
			if scroll_axis then
				-- Set scrollbar progress
				local scrollbar_widget = self:scrollbar_widget()
				local scrollbar_content = scrollbar_widget.content
				local val = math.clamp(scrollbar_content.value - scroll_axis[2] * 0.05, 0, 1)
				self:set_scrollbar_progress(val)
			end
		end
		-- Update scrollbar
		self:update_scrollbar(input_service)
	end

	-- Shift attachments by scrollbar progress
	instance.shift_attachments = function(self, progress)
		-- Iterate scenegraph entries
		local cosmetics_scenegraphs = mod:get_cosmetics_scenegraphs()
		-- local cosmetics_scenegraphs = mod.data_cache:cosmetics_scenegraphs()
		for _, scenegraph_name in pairs(cosmetics_scenegraphs) do
			-- Make sure attachment slot is applicable
			if not table_contains(self._not_applicable, scenegraph_name) then
				-- local widget_name = ""
				-- local is_text = nil
				-- if string_find(scenegraph_name, "text_pivot") then
				-- if mod:cached_find(scenegraph_name, "text_pivot") then
				-- if self.scenegraph_to_widgets[scenegraph_name] then
				-- 	-- widget_name = string_gsub(scenegraph_name, "_text_pivot", "_custom_text")
				-- 	widget_name = mod:cached_gsub(scenegraph_name, "_text_pivot", "_custom_text")
				-- 	is_text = true
				-- else
				-- 	-- widget_name = string_gsub(scenegraph_name, "_pivot", "_custom")
				-- 	widget_name = mod:cached_gsub(scenegraph_name, "_pivot", "_custom")
				-- end
				-- local widget = self:find_custom_widget(widget_name)
				if self.scenegraph_to_widgets[scenegraph_name] then
					local widget = self.scenegraph_to_widgets[scenegraph_name].widget
					local scenegraph_entry = self._ui_scenegraph[scenegraph_name]
					widget.original_y = widget.original_y or widget.offset[2]
					widget.offset[2] = widget.original_y - (self.total_dropdown_height - 950) * progress
					local offset = widget.offset[2] + scenegraph_entry.local_position[2]
					widget.visible = offset > 10 and offset < 950 and self.__selected_tab_index == 3
				end
			end
		end
	end

	-- ┌┬┐┬─┐┌─┐┬ ┬  ┌─┐┬ ┬┬  ┌─┐┬ ┬┌─┐┌─┐┌─┐┌─┐
	--  ││├┬┘├─┤│││  │ ┬│ ││  └─┐├─┤├─┤├─┘├┤ └─┐
	-- ─┴┘┴└─┴ ┴└┴┘  └─┘└─┘┴  └─┘┴ ┴┴ ┴┴  └─┘└─┘	

	-- Draw box
	local draw_box_points = {
		bottom_01 = {vec = {true, true, false}}, bottom_02 = {vec = {true, false, false}},
		bottom_03 = {vec = {false, false, false}}, bottom_04 = {vec = {false, true, false}},
		top_01 = {vec = {true, true, true}}, top_02 = {vec = {true, false, true}},
		top_03 = {vec = {false, false, true}}, top_04 = {vec = {false, true, true}},
	}
	local draw_box_results = {
		bottom_01 = {}, bottom_02 = {}, bottom_03 = {}, bottom_04 = {},
		top_01 = {}, top_02 = {}, top_03 = {}, top_04 = {},
	}
	local draw_box_draw = {
		{a = "bottom_01", b = "bottom_02"}, {a = "bottom_01", b = "bottom_04"},
		{a = "bottom_02", b = "bottom_03"}, {a = "bottom_03", b = "bottom_04"},
		{a = "top_01", b = "bottom_01"}, {a = "top_02", b = "bottom_02"},
		{a = "top_03", b = "bottom_03"}, {a = "top_04", b = "bottom_04"},
		{a = "top_01", b = "top_02"}, {a = "top_01", b = "top_04"},
		{a = "top_02", b = "top_03"}, {a = "top_03", b = "top_04"},
	}
	instance.draw_box = function(self, unit, saved_origin)
		if unit and unit_alive(unit) then
			local tm, half_size = unit_box(unit)
			local gui = self:forward_gui()
			local ui_weapon_spawner = self:ui_weapon_spawner()
			local camera = ui_weapon_spawner and ui_weapon_spawner._camera
			-- Get boundary points
			for name, data in pairs(draw_box_points) do
				local position = vector3(
					data.vec[1] == true and half_size.x or -half_size.x,
					data.vec[2] == true and half_size.y or -half_size.y,
					data.vec[3] == true and half_size.z or -half_size.z
				)
				draw_box_points[name].position = Matrix4x4.transform(tm, position)
			end
			-- Get position and distance to camera
			for name, data in pairs(draw_box_results) do
				draw_box_results[name].position, draw_box_results[name].distance = Camera.world_to_screen(camera, draw_box_points[name].position)
			end
			-- Farthest point from camera
			local farthest = nil
			local last = 0
			for name, data in pairs(draw_box_results) do
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
				for name, data in pairs(draw_box_results) do
					local position = vector3(data.position[1], data.position[2], 0)
					local distance = vector3.distance(saved_origin_v3, position)
					if distance < last then
						last = distance
						closest = name
					end
				end
				if closest then
					self.equipment_line_target[1] = draw_box_results[closest].position[1]
					self.equipment_line_target[2] = draw_box_results[closest].position[2]
				end
			end
			-- Draw box
			for name, data in pairs(draw_box_draw) do
				if farthest ~= data.a and farthest ~= data.b then
					ScriptGui.hud_line(gui, draw_box_results[data.a].position, draw_box_results[data.b].position, LINE_Z, LINE_THICKNESS, Color(255, 106, 121, 100))
				end
			end
		end
	end

	-- Draw box
	instance.draw_equipment_box = function(self, dt, t)
		local attachment_units = self:attachment_units()
		if attachment_units and not mod.dropdown_open then
			-- local attachments = mod.gear_settings:attachments(self._presentation_item)
			local attachment_slots = mod.gear_settings:possible_attachment_slots(self._presentation_item, true)
			if attachment_slots then
				for _, attachment_slot in pairs(attachment_slots) do
					local unit = mod.gear_settings:attachment_unit(attachment_units, attachment_slot)
					if unit and unit_alive(unit) then
						local saved_origin = self.dropdown_positions[attachment_slot]
						if saved_origin and saved_origin[3] and saved_origin[3] == true then
							self:draw_box(unit, saved_origin)
							break
						end
					end
				end
			end
		end
	end
	
	-- Draw lines
	instance.draw_equipment_lines = function(self, dt, t)
		-- Get weapon unit
		local attachment_units = self:attachment_units()
		-- Check if weapon unit is valid and dropdown is not open
		if attachment_units and not mod.dropdown_open then
			-- Get attachments
			-- local attachments = mod.gear_settings:attachments(self._presentation_item)
			local attachment_slots = mod.gear_settings:possible_attachment_slots(self._presentation_item, true)
			-- Check if attachments are valid
			if attachment_slots then
				-- Get objects
				local gui = self:forward_gui()
				local ui_weapon_spawner = self:ui_weapon_spawner()
				local camera = ui_weapon_spawner and ui_weapon_spawner._camera
				-- Iterate through attachment slots
				for _, attachment_slot in pairs(attachment_slots) do
					-- Get attachment unit
					local unit = mod.gear_settings:attachment_unit(attachment_units, attachment_slot)
					-- Check if attachment unit is valid
					if unit and unit_alive(unit) then
						local box = unit_box(unit, false)
						local center_position = Matrix4x4.translation(box)
						local world_to_screen, distance = Camera.world_to_screen(camera, center_position)
						if self.equipment_line_target then
							world_to_screen = vector2(self.equipment_line_target[1], self.equipment_line_target[2])
						end
						local saved_origin = self.dropdown_positions[attachment_slot]
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

	-- ┌─┐┌┬┐┌┬┐┌─┐┌─┐┬ ┬┌┬┐┌─┐┌┐┌┌┬┐┌─┐
	-- ├─┤ │  │ ├─┤│  ├─┤│││├┤ │││ │ └─┐
	-- ┴ ┴ ┴  ┴ ┴ ┴└─┘┴ ┴┴ ┴└─┘┘└┘ ┴ └─┘

	-- Reevaluate packages (when new attachments are added)
	instance.reevaluate_packages = function(self)
		-- Get package synchronizer client
		local package_synchronizer_client = managers.package_synchronization:synchronizer_client()
		-- Reevaluate all profile packages
		if package_synchronizer_client then
			local player = managers.player:local_player(1)
			local peer_id = player:peer_id()
			if package_synchronizer_client:peer_enabled(peer_id) then
				package_synchronizer_client:player_profile_packages_changed(peer_id, 1)
			end
		end
	end

	-- Save original attachment
	instance.save_original_attachment = function(self, attachment_slot)
		if not self.original_weapon_settings[attachment_slot] and not table_contains(mod.automatic_slots, attachment_slot) then
			if not mod.gear_settings:get(self._presentation_item, attachment_slot) then
				self.original_weapon_settings[attachment_slot] = "default"
			else
				self.original_weapon_settings[attachment_slot] = mod.gear_settings:get(self._presentation_item, attachment_slot)
			end
		end
	end

	-- Load new attachment
	instance.load_new_attachment = function(self, item, attachment_slot, attachment, no_update)
		if self._gear_id then
			-- Check if attachment and attachment slot are valid
			if attachment_slot then
				-- Save original attachment
				self:save_original_attachment(attachment_slot)
				-- Set attachment
				mod.gear_settings:set(self._selected_item, attachment_slot, attachment)
				-- Resolve no support
				self:resolve_no_support()
			end
			-- Update
			if not no_update then
				-- Create new preview item instance
				self._presentation_item = MasterItems.create_preview_item_instance(self._selected_item)
				-- Preview item
				self:_preview_item(self._presentation_item)
				-- Get slot info
				self._slot_info_id = mod.gear_settings:slot_info_id(self._presentation_item)
				-- Get changed settings
				self:get_changed_weapon_settings()
			end
		end
	end

	instance.resolve_not_applicable_attachments = function(self)
		local item = self._selected_item
		if item then
			-- Get item name
			-- local item_name = mod.gear_settings:short_name(item.name)
			local item_name = self._item_name
			local item_attachments = mod.attachment[item_name]
			if item_attachments then
				local move = -10
				-- Iterate attachment slots
				for index, slot in pairs(mod.attachment_slots) do
					local slot_attachments = item_attachments[slot]
					-- Check that weapon has attachment slot and more than 2 options
					-- 1st option is default
					if item_attachments and (not slot_attachments or #slot_attachments <= 2) then
						local slot_dropdown = self._widgets_by_name[slot.."_custom"]
						local slot_label = self._widgets_by_name[slot.."_custom_text"]
						-- Set not applicable in widgets to hide them
						if slot_dropdown then slot_dropdown.not_applicable = true end
						if slot_label then slot_label.not_applicable = true end
						-- Add to list of not applicable widgets
						self._not_applicable[#self._not_applicable+1] = slot.."_pivot"
						self._not_applicable[#self._not_applicable+1] = slot.."_text_pivot"
					end
				end
				-- Move widgets according to their applicable status
				local cosmetics_scenegraphs = mod:get_cosmetics_scenegraphs()
				-- local cosmetics_scenegraphs = mod.data_cache:cosmetics_scenegraphs()
				for _, scenegraph_name in pairs(cosmetics_scenegraphs) do
					if table_contains(self._not_applicable, scenegraph_name) then
						-- Differentiate text and dropdown
						if mod:cached_find(scenegraph_name, "text_pivot") then
							move = move + label_height
						else
							move = move + dropdown_height
						end
					end
					-- Change scenegraph position
					local scenegraph_entry = self._ui_scenegraph[scenegraph_name]
					if scenegraph_entry then
						scenegraph_entry.local_position[2] = scenegraph_entry.local_position[2] - move
						scenegraph_entry.original_y = scenegraph_entry.local_position[2]
						self.total_dropdown_height = scenegraph_entry.local_position[2] + dropdown_height
					end
				end
			end
		end
	end

	instance.resolve_no_support = function(self)
		local item_attachment_models = mod.attachment_models[self._item_name]
		-- Enable all dropdowns
		for _, attachment_slot in pairs(mod.attachment_slots) do
			local widget = self._widgets_by_name[attachment_slot.."_custom"]
			if widget then
				widget.content.entry.disabled = false
				if widget.content.entry and widget.content.entry.widget_type == "dropdown" then
					local options_by_id = widget.content.options_by_id
					for option_index, option in pairs(widget.content.options) do
						option.disabled = false
					end
				end
			end
		end
		-- Disable no supported
		for _, attachment_slot in pairs(mod.attachment_slots) do
			local attachment = mod.gear_settings:get(self._presentation_item, attachment_slot)
			local attachment_data = item_attachment_models and item_attachment_models[attachment]
			if attachment and attachment_data then
				local no_support = attachment_data.no_support
				attachment_data = mod.gear_settings:apply_fixes(self._presentation_item, attachment_slot) or attachment_data
				no_support = attachment_data.no_support or no_support
				if no_support then
					for _, no_support_entry in pairs(no_support) do
						local widget = self._widgets_by_name[no_support_entry.."_custom"]
						if widget then
							widget.content.entry.disabled = true
						else
							for _, widget in pairs(self._custom_widgets) do
								if widget.content.entry and widget.content.entry.widget_type == "dropdown" then
									local options = widget.content.options
									for option_index, option in pairs(widget.content.options) do
										if option.id == no_support_entry then
											option.disabled = true
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	-- Get changed settings
	instance.get_changed_weapon_settings = function(self)
		if self._gear_id then
			-- self.changed_weapon_settings = {}
			table_clear(self.changed_attachment_settings)
			-- local attachment_slots = mod:get_item_attachment_slots(self._selected_item)
			local attachment_slots = mod.gear_settings:possible_attachment_slots(self._selected_item)
			for _, attachment_slot in pairs(attachment_slots) do
				if not table_contains(mod.automatic_slots, attachment_slot) then
					self.changed_weapon_settings[attachment_slot] = mod.gear_settings:get(self._selected_item, attachment_slot)
				end
			end
		end
	end

	-- Equip attachments to weapon
	instance.equip_attachments = function(self)
		-- Reset original settings
		-- self.original_weapon_settings = {}
		table_clear(self.original_weapon_settings)
		-- -- Reset animation
		-- mod.reset_start = mod:main_time() --managers.time:time("main")
		-- Update equip button
		self:update_equip_button()
		-- Get changed settings
		self:get_changed_weapon_settings()
		-- Load new attachments
		self:load_new_attachment()
		-- Save gear settings
		mod.gear_settings:save(self._presentation_item)
		if self._gear_id then
			mod:persistent_table(REFERENCE).weapon_templates[self._gear_id] = nil
		end
		-- Reevaluate packages
		self:reevaluate_packages()
		-- Reload current weapon
		mod:redo_weapon_attachments(self._presentation_item)
		-- Delete fix cache
		local temp_cached_fixes = mod:persistent_table(REFERENCE).temp_cached_fixes
		temp_cached_fixes[self._gear_id] = nil
		-- Trigger Events
		managers.event:trigger("weapon_customization_weapon_changed")
		-- Update UI icons
		managers.ui:item_icon_updated(self._selected_item)
		managers.event:trigger("event_item_icon_updated", self._selected_item)
		managers.event:trigger("event_replace_list_item", self._selected_item)
	end

	-- Reset attachments to default
	instance.reset_attachments = function(self, no_animation)
		-- Get changed settings
		self:get_changed_weapon_settings()
		-- Check unsaved
		self:check_unsaved_changes(no_animation)
		-- Reevaluate packages
		self:reevaluate_packages()
		-- Redo attachments
		mod:redo_weapon_attachments(self._selected_item)
	end

	-- Get attachment names
	local attachment_names = {}
	instance.get_attachment_names = function(self, attachment_settings)
		-- local attachment_names = {}
		table_clear(attachment_names)
		-- Iterate through attachment settings
		for attachment_slot, value in pairs(attachment_settings) do
			-- Get attachment name
			attachment_names[attachment_slot] = mod.gear_settings:get(self._selected_item, attachment_slot)
		end
		-- Return attachment names
		return attachment_names
	end

	-- Attach attachments
	instance.attach_attachments = function(self, attachment_settings, skip_animation)
		local index = 1
		-- Check if we need to skip animation
		mod.weapon_part_animation_update = not skip_animation
		-- Get attachment names
		local attachment_names = self:get_attachment_names(attachment_settings)
		-- Iterate through attachment settings
		for attachment_slot, value in pairs(attachment_settings) do
			if not skip_animation then
				-- Animate attachment change
				mod.build_animation:animate(self._selected_item, attachment_slot, attachment_names[attachment_slot], value) --, nil, nil, true)
			else
				-- Load new attachment
				self:load_new_attachment(self._selected_item, attachment_slot, value, index < table_size(attachment_settings))
			end
			-- Update index
			index = index + 1
		end
	end

	-- Check if any attachments have been changed since start
	instance.attachments_changed_since_start = function(self)
		-- Check if table sizes are different
		if table_size(self.start_weapon_settings) ~= table_size(self.changed_weapon_settings) then return true end
		-- Iterate through changed settings
		for attachment_slot, value in pairs(self.start_weapon_settings) do
			-- Get actual changed setting
			local changed_setting = self.changed_weapon_settings[attachment_slot]
			-- Check if value is different
			if value ~= changed_setting then return true end
		end
	end

	-- Check if any attachments have been changed
	instance.attachments_changed_at_all = function(self)
		-- Iterate through changed settings
		for attachment_slot, value in pairs(self.changed_weapon_settings) do
			-- Get actual default attachment
			-- local default = mod:get_actual_default_attachment(self._selected_item, attachment_slot)
			local default = mod.gear_settings:default_attachment(self._selected_item, attachment_slot)
			-- Check if default is different
			if default and value ~= default then return true end
		end
	end

	-- Remove player visible equipment
	instance.remove_player_visible_equipment = function(self)
		mod:execute_extension(mod.player_unit, "visible_equipment_system", "delete_slots")
		mod:execute_extension(mod.player_unit, "visible_equipment_system", "delete")
		mod:remove_extension(mod.player_unit, "visible_equipment_system")
	end

	-- Update start settings
	instance.update_start_settings = function(self)
		self.start_weapon_settings = table_clone(self.changed_weapon_settings)
	end

	instance.check_unsaved_changes = function(self, no_animation)
		if table_size(self.original_weapon_settings) > 0 then
			if self._gear_id then
				if no_animation then
					for attachment_slot, value in pairs(self.original_weapon_settings) do
						mod.gear_settings:set(self._presentation_item, attachment_slot, value)
					end
				else
					-- local attachment_slots = mod:get_item_attachment_slots(self._selected_item)
					local attachment_slots = mod.gear_settings:possible_attachment_slots(self._selected_item)
					local original_weapon_settings = table_clone(self.original_weapon_settings)
					local attachment_names = {}
					table_reverse(original_weapon_settings)
					for attachment_slot, value in pairs(original_weapon_settings) do
						attachment_names[attachment_slot] = mod.gear_settings:get(self._presentation_item, attachment_slot)
					end
	
					-- mod.build_animation.animations = {}
					mod.weapon_part_animation_update = true
					for attachment_slot, value in pairs(original_weapon_settings) do
						-- self:detach_attachment(self.cosmetics_view._selected_item, attachment_slot, attachment_names[attachment_slot], value)
						mod.build_animation:animate(self._selected_item, attachment_slot, attachment_names[attachment_slot], value)
					end
				end
				-- self.original_weapon_settings = {}
				table_clear(self.original_weapon_settings)
			end
			-- self:update_equip_button()
		end
	end

	-- ┌─┐┌┬┐┌┬┐┌─┐┌─┐┬ ┬┌┬┐┌─┐┌┐┌┌┬┐  ┌┬┐┬─┐┌─┐┌─┐┌┬┐┌─┐┬ ┬┌┐┌  ┬ ┬┬┌┬┐┌─┐┌─┐┌┬┐┌─┐
	-- ├─┤ │  │ ├─┤│  ├─┤│││├┤ │││ │    ││├┬┘│ │├─┘ │││ │││││││  ││││ │││ ┬├┤  │ └─┐
	-- ┴ ┴ ┴  ┴ ┴ ┴└─┘┴ ┴┴ ┴└─┘┘└┘ ┴   ─┴┘┴└─└─┘┴  ─┴┘└─┘└┴┘┘└┘  └┴┘┴─┴┘└─┘└─┘ ┴ └─┘

	instance.add_custom_widget = function(self, widget)
		widget.custom = true
		self._custom_widgets[#self._custom_widgets+1] = widget
	end

	instance.generate_custom_widgets = function(self)
		-- local item = self.cosmetics_view._selected_item
		if self._selected_item then
			-- Iterate scenegraphs additions
			local cosmetics_scenegraphs = mod:get_cosmetics_scenegraphs()
			-- local cosmetics_scenegraphs = mod.data_cache:cosmetics_scenegraphs()
			for _, added_scenegraph in pairs(cosmetics_scenegraphs) do
				-- Differentiate text and dropdown
				-- if string_find(added_scenegraph, "text_pivot") then
				if mod:cached_find(added_scenegraph, "text_pivot") then
					-- Generate label
					-- local attachment_slot = string_gsub(added_scenegraph, "_text_pivot", "")
					local attachment_slot = mod:cached_gsub(added_scenegraph, "_text_pivot", "")
					self:add_custom_widget(self:generate_label(added_scenegraph, attachment_slot, self._selected_item))
					self.scenegraph_to_widgets[added_scenegraph] = {
						attachment_slot = mod:cached_gsub(added_scenegraph, "_pivot", ""),
						widget = self._custom_widgets[#self._custom_widgets],
						is_text = true,
						is_dropdown = false,
					}
				else
					-- Generate dropdown
					-- local attachment_slot = string_gsub(added_scenegraph, "_pivot", "")
					local attachment_slot = mod:cached_gsub(added_scenegraph, "_pivot", "")
					self:add_custom_widget(self:generate_dropdown(added_scenegraph, attachment_slot, self._selected_item))
					self.scenegraph_to_widgets[added_scenegraph] = {
						attachment_slot = mod:cached_gsub(added_scenegraph, "_pivot", ""),
						widget = self._custom_widgets[#self._custom_widgets],
						is_text = false,
						is_dropdown = true,
					}
				end
			end

			-- self:add_custom_widget(self:generate_combination_dropdown("combination_dropdown", self._selected_item))
			-- self.scenegraph_to_widgets["combination_dropdown"] = {
			-- 	widget = self._custom_widgets[#self._custom_widgets],
			-- 	is_text = false,
			-- 	is_dropdown = true,
			-- }
		end
	end

	instance.generate_dropdown_option = function(self, id, display_name, sounds)
		return {
			id = id,
			display_name = display_name,
			ignore_localization = true,
			value = id,
			sounds = sounds,
			disabled = false,
		}
	end

	instance.generate_label = function(self, scenegraph, attachment_slot, item)
		local item_name = self._item_name
		local style = table_clone(UIFontSettings.grid_title)
		style.offset = {0, 0, 1}
		local text = "loc_weapon_cosmetics_customization_"..attachment_slot
	
		if mod.text_overwrite[item_name] then
			text = mod.text_overwrite[item_name][text] or text
		end
	
		local definition = UIWidget.create_definition({
			{
				value_id = "text",
				style_id = "text",
				pass_type = "text",
				value = mod:localize_or_global(text),
				style = style,
			}
		}, scenegraph, nil)
	
		local widget_name = attachment_slot.."_custom_text"
		local widget = self:_create_widget(widget_name, definition)
	
		self._widgets_by_name[widget_name] = widget
		self._widgets[#self._widgets+1] = widget
	
		return widget
	end

	instance.validate_item_model = function(self, model)
		mod:setup_item_definitions()
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

	instance.generate_dropdown = function(self, scenegraph, attachment_slot, item)

		local item_name = self._item_name
		local item_attachments = mod.attachment[item_name]
		local item_attachment_models = mod.attachment_models[item_name]
		local slot_attachments = item_attachments and item_attachments[attachment_slot]
		local options = {}
		if slot_attachments and item_attachment_models then
			mod.found_names = nil
			for _, data in pairs(slot_attachments) do
				local model = item_attachment_models[data.id] and item_attachment_models[data.id].model
				if model and self:validate_item_model(model) then
					local attachment_name = mod:get("mod_option_misc_attachment_names") and mod:get_attachment_weapon_name(item, attachment_slot, data.id) or data.name
					-- local attachment_name = mod:get("mod_option_misc_attachment_names") and mod.data_cache:attachment_name_to_generated_attachment_name(data.id) or data.name
					options[#options+1] = self:generate_dropdown_option(data.id, attachment_name, data.sounds)
				end
			end
		end
	
		local max_visible_options = 10
		local num_options = #options
		local num_visible_options = math_min(num_options, max_visible_options)
	


		local size = {100, dropdown_height}
		local template = CheckboxPassTemplates.settings_checkbox(size[1], dropdown_height, size[1], 1, true, true)
		local definition = UIWidget.create_definition(template, scenegraph, nil, size)

		local widget_name = attachment_slot.."_prev"
		local prev_widget = self:_create_widget(widget_name, definition)
		prev_widget.alpha_multiplier = 1
		prev_widget.offset[2] = prev_widget.offset[2] - dropdown_height
		prev_widget.content.option_1 = "<"
		prev_widget.content.checked = false
		prev_widget.content.checkbox = true
		-- prev_widget.content.option_hotspot_1.pressed_callback = function()
		-- 	-- if not widget.content.checked then
		-- 	-- 	widget.content.option_1 = TextUtilities.apply_color_to_text("Locked", Color.red(255, true))
		-- 	-- 	widget.content.checked = true
		-- 	-- 	if widget.content.filter.content.checked then
		-- 	-- 		widget.content.filter.content.option_hotspot_1.pressed_callback()
		-- 	-- 	end
		-- 	-- 	self:update_filtered_combinations()
		-- 	-- else
		-- 	-- 	widget.content.option_1 = "Lock"
		-- 	-- 	widget.content.checked = false
		-- 	-- 	self:update_filtered_combinations()
		-- 	-- end
		-- end
		self._widgets_by_name[widget_name] = prev_widget
		self._widgets[#self._widgets+1] = prev_widget
		self:add_custom_widget(prev_widget)

		local widget_name = attachment_slot.."_next"
		local next_widget = self:_create_widget(widget_name, definition)
		next_widget.alpha_multiplier = 1
		next_widget.offset[1] = next_widget.offset[1] + grid_size[1] - size[1]
		next_widget.offset[2] = next_widget.offset[2] - dropdown_height
		next_widget.content.option_1 = ">"
		next_widget.content.checked = false
		next_widget.content.checkbox = true
		-- widget.content.prev = self._widgets_by_name[attachment_slot.."_prev"]
		-- next_widget.content.option_hotspot_1.pressed_callback = function()
		-- 	-- if not widget.content.checked then
		-- 	-- 	widget.content.option_1 = TextUtilities.apply_color_to_text("Filtered", Color.light_blue(255, true))
		-- 	-- 	widget.content.checked = true
		-- 	-- 	if widget.content.prev.content.checked then
		-- 	-- 		widget.content.prev.content.option_hotspot_1.pressed_callback()
		-- 	-- 	end
		-- 	-- 	self:update_filtered_combinations()
		-- 	-- else
		-- 	-- 	widget.content.option_1 = "Filter"
		-- 	-- 	widget.content.checked = false
		-- 	-- 	self:update_filtered_combinations()
		-- 	-- end
		-- end
		self._widgets_by_name[widget_name] = next_widget
		self._widgets[#self._widgets+1] = next_widget
		self:add_custom_widget(next_widget)

		-- self._widgets_by_name[attachment_slot.."_prev"].content.next = widget

		local size = {grid_size[1], dropdown_height}
		local template = DropdownPassTemplates.settings_dropdown(size[1], size[2], size[1], num_visible_options, true)
		for _, pass in pairs(template) do
			-- if pass.content_id and string_find(pass.content_id, "option_hotspot") then
			if pass.content_id and mod:cached_find(pass.content_id, "option_hotspot") then
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
		local widget = self:_create_widget(widget_name, definition)
		widget.alpha_multiplier = 1
		self._widgets_by_name[widget_name] = widget
		self._widgets[#self._widgets+1] = widget

		-- widget.content.lock = self._widgets_by_name[attachment_slot.."_lock"]
		-- self._widgets_by_name[attachment_slot.."_lock"].content.dropdown = widget
		-- widget.content.filter = self._widgets_by_name[attachment_slot.."_filter"]
		-- self._widgets_by_name[attachment_slot.."_filter"].content.dropdown = widget
	
		local content = widget.content
		content.entry = {
			attachment_slot = attachment_slot,
			attachment_name = "-",
			options = options,
			widget_type = "dropdown",
			on_activated = function(new_value, entry)
				if not mod.build_animation:is_busy() then
					local attachment = mod.gear_settings:get(self._selected_item, attachment_slot)
					local attachment_data = item_attachment_models[attachment]
					local no_animation = attachment_data and attachment_data.no_animation
	
					if mod:get("mod_option_weapon_build_animation") and not no_animation then
						mod.weapon_part_animation_update = true
						-- self:detach_attachment(self.cosmetics_view._presentation_item, attachment_slot, attachment, new_value, nil, nil, nil, "attach")
						mod.build_animation:animate(self._presentation_item, attachment_slot, attachment, new_value, nil, nil, nil, "attach")
					else
						self:load_new_attachment(self._selected_item, attachment_slot, new_value)
						mod:play_attachment_sound(self._selected_item, attachment_slot, new_value, "attach")
					end
	
					mod.reset_weapon = nil
	
					-- local weapon_attachments = mod.attachment_models[item_name]
					local attachment_data = item_attachment_models[new_value]
					local new_angle = attachment_data.angle or 0
					local ui_weapon_spawner = self:ui_weapon_spawner()
					if ui_weapon_spawner then
						ui_weapon_spawner:initiate_weapon_rotation(new_angle, 1)
						ui_weapon_spawner:initiate_camera_movement()
					end
	
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
					-- self:start_weapon_move()
					
				end
			end,
			get_function = function()
				return mod.gear_settings:get(self._gear_id, attachment_slot)
			end,
		}
		local options_by_id = {}
		for index, option in pairs(options) do
			options_by_id[option.id] = option
		end
		content.options_by_id = options_by_id
		content.options = options
		content.num_visible_options = num_visible_options
		content.next_widget = next_widget
		content.prev_widget = prev_widget

		next_widget.content.option_hotspot_1.pressed_callback = function()
			local item_name = self._item_name
			local item_attachments = mod.attachment[item_name]
			if not content.disabled and item_attachments[attachment_slot] then
				content.selected_index = math_min(content.selected_index + 1, #content.entry.options)
				self:load_new_attachment(self._selected_item, attachment_slot, content.entry.options[content.selected_index].value)
			end
		end

		prev_widget.content.option_hotspot_1.pressed_callback = function()
			local item_name = self._item_name
			local item_attachments = mod.attachment[item_name]
			if not content.disabled and item_attachments[attachment_slot] then
				content.selected_index = math_max(content.selected_index - 1, 1)
				self:load_new_attachment(self._selected_item, attachment_slot, content.entry.options[content.selected_index].value)
			end
		end
	
		content.hotspot.pressed_callback = function ()
			if not mod.dropdown_open and not content.disabled then
				if not mod.build_animation:is_busy() then
					if mod:get("mod_option_carousel") then
						local ui_weapon_spawner = self._weapon_preview._ui_weapon_spawner
						-- local attachment_units_3p = ui_weapon_spawner._weapon_spawn_data.attachment_units_3p
						local unit_3p = ui_weapon_spawner._weapon_spawn_data.item_unit_3p
						local attachment_units_3p = ui_weapon_spawner._weapon_spawn_data.attachment_units_3p and ui_weapon_spawner._weapon_spawn_data.attachment_units_3p[unit_3p]
						-- local attachment_unit = attachment_units_3p and mod:get_attachment_slot_in_attachments(attachment_units_3p, attachment_slot)
						local attachment_unit = unit_3p and mod.gear_settings:attachment_unit(attachment_units_3p, attachment_slot)
						local attachment_name = attachment_unit and Unit.get_data(attachment_unit, "attachment_name")
						local callback = callback(self, "create_attachment_array", self._selected_item, attachment_slot)
						-- mod.build_animation.animations = {}
						mod.build_animation:clear()
						mod.weapon_part_animation_update = true
						-- self:detach_attachment(self.cosmetics_view._presentation_item, attachment_slot, nil, attachment_name, nil, nil, nil, "detach_only", callback)
						mod.build_animation:animate(self._presentation_item, attachment_slot, nil, attachment_name, nil, nil, nil, "detach_only", callback)
					end
					local selected_widget = nil
					local selected = true
					content.exclusive_focus = selected
					local hotspot = content.hotspot or content.button_hotspot
					if hotspot then
						hotspot.is_selected = selected
					end
					mod.dropdown_open = true

					local weapon_attachments = mod.attachment_models[self._item_name]
					local selected_option = content.options[content.selected_index]
					local attachment_data = weapon_attachments[selected_option.value]
					local ui_weapon_spawner = self:ui_weapon_spawner()
					if attachment_data and attachment_data.move and ui_weapon_spawner then
						-- self:start_weapon_move(attachment_data.move)
						ui_weapon_spawner:initiate_camera_movement(attachment_data.move)
					end
					-- local weapon_attachments = mod.attachment_models[self._item_name]
					-- local selected_option = content.options[content.selected_index]
					-- local attachment_data = weapon_attachments[selected_option.value]
					-- local new_angle = attachment_data and attachment_data.angle or 0
					-- local ui_weapon_spawner = self:ui_weapon_spawner()
					-- if ui_weapon_spawner then
					-- 	ui_weapon_spawner:initiate_weapon_rotation(new_angle)
					-- end
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

	instance.hide_custom_widgets = function(self, hide)
		if self._custom_widgets then
			for _, widget in pairs(self._custom_widgets) do
				if not widget.not_applicable then
					widget.visible = not hide
				else
					widget.visible = false
				end
			end
			self._widgets_by_name.reset_button.visible = not hide
			self._widgets_by_name.randomize_button.visible = not hide
			self._widgets_by_name.weapon_customization_scrollbar.visible = not hide and self.total_dropdown_height > 950
			self._widgets_by_name.reload_definitions_button.visible = not hide
		end
	end

	-- Get dropdown positions
	instance.get_dropdown_positions = function(self)
		local cosmetics_scenegraphs = mod:get_cosmetics_scenegraphs()
		-- local cosmetics_scenegraphs = mod.data_cache:cosmetics_scenegraphs()
		for _, scenegraph_name in pairs(cosmetics_scenegraphs) do
			-- if not string_find(scenegraph_name, "text_pivot") then
			local scenegraph_to_widgets = self.scenegraph_to_widgets[scenegraph_name]
			if scenegraph_to_widgets and not scenegraph_to_widgets.is_text then
				local ui_scenegraph = self._ui_scenegraph
				local screen_width = RESOLUTION_LOOKUP.width
				-- local attachment_slot = string_gsub(scenegraph_name, "_pivot", "")
				-- local attachment_slot = mod:cached_gsub(scenegraph_name, "_pivot", "")
				local attachment_slot = scenegraph_to_widgets.attachment_slot
				local scenegraph_entry = ui_scenegraph[scenegraph_name]
				local entry = self.dropdown_positions[attachment_slot] or {}

				local scale = RESOLUTION_LOOKUP.scale
				local world_position = UIScenegraph.world_position(ui_scenegraph, scenegraph_name)
				local size_width, size_height = UIScenegraph.get_size(ui_scenegraph, scenegraph_name, scale)

				local widget_name = attachment_slot.."_custom"
				local widget = self._widgets_by_name[widget_name]
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

	instance.update_custom_widgets = function(self, input_service, dt, t)
		if self._custom_widgets then
			for _, widget in pairs(self._custom_widgets) do
				if widget.content and widget.content.entry and widget.content.entry.widget_type == "dropdown" then
					-- local pivot_name = widget.name.."_pivot"
					-- pivot_name = string_gsub(pivot_name, "_custom", "")
					-- pivot_name = mod:cached_gsub(pivot_name, "_custom", "")
					-- local scenegraph_entry = self._ui_scenegraph[pivot_name]
					local scenegraph_entry = self._ui_scenegraph[widget.scenegraph_id]
					local any_active = false
					for _, data in pairs(self.dropdown_positions) do
						if data[3] == true then
							any_active = true
							break
						end
					end
					if widget.content.entry.attachment_slot then
						local entry = self.dropdown_positions[widget.content.entry.attachment_slot]
						local text = self._widgets_by_name[widget.content.entry.attachment_slot.."_custom_text"]
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
					else
						widget.content.grow_downwards = false
					end
					self:update_dropdown(widget, input_service, dt, t)

					-- self._widgets_by_name[widget.name.."_lock"].visible = self:is_tab() and not self:is_busy()
				elseif widget.content.checkbox then

					widget.visible = self:is_tab()

				end
			end
		end
	end

	local attachment_info_tiers = {
		"content/ui/materials/icons/perks/perk_level_01",
		"content/ui/materials/icons/perks/perk_level_02",
		"content/ui/materials/icons/perks/perk_level_03",
		"content/ui/materials/icons/perks/perk_level_04",
		"content/ui/materials/icons/perks/perk_level_05",
	}
	instance.set_attachment_info = function(self, display_name, attribute_data)
		if display_name ~= "Default" and attribute_data then
			self._widgets_by_name.attachment_display_name.content.text = display_name
			-- for i, data in pairs(attribute_data) do
			local index = 1
			for _, column in pairs(attribute_data) do
				for name, tier in pairs(column) do
					local widgets_by_name = self.bar_breakdown_widgets_by_name
					local widget = widgets_by_name["attachment_bar_"..tostring(index)]
					if widget then
						widget.content.text = mod:localize_or_global(name)
						widget.content.value_id_1 = attachment_info_tiers[tier]
					end
					index = index + 1
				end
			end
		else
			self._widgets_by_name.attachment_display_name.content.text = ""
		end
	end

	instance.execute_hide_meshes = function(self, item, weapon_unit, attachment_units)
		-- local slot_infos = mod:persistent_table(REFERENCE).attachment_slot_infos
		local item_name = mod.gear_settings:short_name(item.name)
		for _, unit in pairs(attachment_units) do
			-- if slot_infos[slot_info_id] then
				-- local attachment_name = slot_infos[slot_info_id].unit_to_attachment_name[unit]
				local attachment_name = Unit.get_data(unit, "attachment_name")
				local attachment_data = attachment_name and mod.attachment_models[item_name] and mod.attachment_models[item_name][attachment_name]
				-- Hide meshes
				local hide_mesh = attachment_data and attachment_data.hide_mesh
				-- Get fixes
				local fixes = mod.gear_settings:apply_fixes(item, unit)
				hide_mesh = fixes and fixes.hide_mesh or hide_mesh
				-- Check hide mesh
				if hide_mesh then
					-- Iterate hide mesh entries
					for _, hide_entry in pairs(hide_mesh) do
						-- Check more than one paramet                 er
						if #hide_entry > 1 then
							-- Get attachment name - parameter 1
							local attachment_slot = hide_entry[1]
							-- Get attachment unit
							-- local hide_unit = slot_infos[slot_info_id].attachment_slot_to_unit[attachment_slot]
							-- local hide_unit = self:get_attachment_unit(item, attachment_slot)
							-- local hide_unit = self:get_attachment_slot_in_attachments(attachment_units, attachment_slot)
							local hide_unit = mod.gear_settings:attachment_unit(attachment_units, attachment_slot)
							-- Check unit
							if hide_unit and unit_alive(hide_unit) then
								-- Hide nodes
								for i = 2, #hide_entry do
									local mesh_index = hide_entry[i]
									if Unit.num_meshes(hide_unit) >= mesh_index then
										Unit.set_mesh_visibility(hide_unit, mesh_index, false)
									end
								end
							end
						end
					end
				end
			-- end
		end
	end

	instance.update_dropdown = function(self, widget, input_service, dt, t)
		local content = widget.content
		local entry = content.entry
		local value = entry.get_function and entry:get_function() or content.internal_value or "<not selected>"
		local selected_option = content.options[content.selected_index]
	
		if content.close_setting then
			content.close_setting = nil

			if entry.attachment_slot then
				-- self:release_attachment_packages()
				self:destroy_attachment_previews()
				
				local ui_weapon_spawner = self._weapon_preview._ui_weapon_spawner
				if content.reset and ui_weapon_spawner._weapon_spawn_data then
					content.reset = nil
					self.dropdown_positions[entry.attachment_slot][3] = false
					local unit_3p = ui_weapon_spawner._weapon_spawn_data.item_unit_3p
					-- local attachment_units_3p = ui_weapon_spawner._weapon_spawn_data.attachment_units_3p
					local attachment_units_3p = ui_weapon_spawner._weapon_spawn_data.attachment_units_3p and ui_weapon_spawner._weapon_spawn_data.attachment_units_3p[unit_3p]
					-- local unit = mod:get_attachment_slot_in_attachments(attachment_units_3p, entry.attachment_slot)
					local unit = mod.gear_settings:attachment_unit(attachment_units_3p, entry.attachment_slot)
					
					if unit then self:unit_hide_meshes(unit, false) end
					if attachment_units_3p then self:execute_hide_meshes(self._presentation_item, unit_3p, attachment_units_3p) end
					-- mod.build_animation.animations = {}
					mod.weapon_part_animation_update = true
					-- self:detach_attachment(self.cosmetics_view._presentation_item, entry.attachment_slot, nil, selected_option.value, nil, nil, nil, "attach")
					mod.build_animation:animate(self._presentation_item, entry.attachment_slot, nil, selected_option.value, nil, nil, nil, "attach")
					
				end
			end
	
			content.exclusive_focus = false
			local hotspot = content.hotspot or content.button_hotspot
	
			if hotspot then
				hotspot.is_selected = false
			end
			mod.dropdown_open = false
			self._widgets_by_name.attachment_display_name.content.text = ""

			return
		end
	
		if entry.attachment_slot then
			self.dropdown_positions[entry.attachment_slot] = self.dropdown_positions[entry.attachment_slot] or {}
			self.dropdown_positions[entry.attachment_slot][3] = not mod.dropdown_open and (content.hotspot.is_hover or content.hotspot.is_selected or content.next_widget.content.option_hotspot_1.is_hover or content.prev_widget.content.option_hotspot_1.is_hover)
		end
	
		if entry.attachment_slot and (content.hotspot.is_hover or content.hotspot.is_selected or content.next_widget.content.option_hotspot_1.is_hover or content.prev_widget.content.option_hotspot_1.is_hover) and not mod.dropdown_open and not mod.build_animation:is_busy() then
			
			self.dropdown_positions[entry.attachment_slot][3] = true

			if (content.next_widget.content.option_hotspot_1.is_hover and not content.next_widget.content.option_hotspot_1.hovered)
				or (content.prev_widget.content.option_hotspot_1.is_hover and not content.prev_widget.content.option_hotspot_1.hovered)
				or (content.hotspot.is_hover and not content.hotspot.hovered) then
				
				local weapon_attachments = mod.attachment_models[self._item_name]
				local attachment_data = weapon_attachments[value] --or weapon_attachments[selected_option.value]
				local attachment_name = attachment_data and attachment_data.name
				local new_angle = attachment_data and attachment_data.angle or 0
				local new_move = attachment_data and attachment_data.move
				-- mod.do_rotation = true
				-- mod.new_rotation = new_angle
				
				if mod.attachment_preview_index ~= content.selected_index then
					mod:play_attachment_sound(self._selected_item, entry.attachment_slot, entry.preview_attachment, "select")
				end
				-- mod.attachment_preview_index = content.selected_index
				-- self.dropdown_positions[entry.attachment_slot][3] = true

				local ui_weapon_spawner = self:ui_weapon_spawner()
				if ui_weapon_spawner then
					ui_weapon_spawner:initiate_camera_movement(new_move)
					ui_weapon_spawner:initiate_weapon_rotation(new_angle, 1)
				end
				
				mod.attachment_preview_index = content.selected_index
		
				if content.next_widget.content.option_hotspot_1.is_hover then
					content.next_widget.content.option_hotspot_1.hovered = true
				end

				if content.prev_widget.content.option_hotspot_1.is_hover then
					content.prev_widget.content.option_hotspot_1.hovered = true
				end

				if content.hotspot.is_hover then
					content.hotspot.hovered = true
				end

			end

			-- mod.attachment_preview_index = content.selected_index
			-- self.dropdown_positions[entry.attachment_slot][3] = true

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
		else
			content.next_widget.content.option_hotspot_1.hovered = false
			content.prev_widget.content.option_hotspot_1.hovered = false
			content.hotspot.hovered = false
		end
	
		local is_disabled = entry.disabled or false
		content.disabled = is_disabled or mod.build_animation:is_busy() or (content.lock and content.lock.content and content.lock.content.checked)
		-- local size = {
		-- 	400,
		-- 	dropdown_height
		-- }
		local size = vector2(400, dropdown_height)
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
	
			if option_hotspot.is_hover and entry.attachment_slot then
				
				-- entry.original_value = entry.original_value or value
				entry.preview_attachment = entry.preview_attachment or option.value
				if entry.preview_attachment ~= option.value then
					local weapon_attachments = mod.attachment_models[self._item_name]
					-- local attachment_name = self:attachment_
					local attachment_data = weapon_attachments[option.value]
					local new_angle = attachment_data and attachment_data.angle or 0
					local new_move = attachment_data and attachment_data.move
					-- mod.do_rotation = true
					-- mod.new_rotation = new_angle + 1 * (actual_i / #options) - .5
					local ui_weapon_spawner = self:ui_weapon_spawner()
					if ui_weapon_spawner then
						ui_weapon_spawner:initiate_camera_movement(new_move)
						ui_weapon_spawner:initiate_weapon_rotation(new_angle + .1 * (actual_i / #options), 1)
					end
	
					-- mod.build_animation.animations = {}
					self.dropdown_positions[entry.attachment_slot][3] = true
					mod.attachment_preview_index = actual_i
					-- if attachment_data and attachment_data.move then self:start_weapon_move(attachment_data.move) end
					entry.preview_attachment = option.value
	
					self:set_attachment_info(option.display_name, attachment_data.data)
				end
			end
	
			if option_hotspot.on_pressed and not option.disabled then
				if not mod.build_animation:is_busy() then
					option_hotspot.on_pressed = nil
					new_value = option.id
					real_value = option.value
					content.selected_index = actual_i
					mod.dropdown_closing = true
					content.option_disabled = false
					if entry.attachment_slot then
						self.dropdown_positions[entry.attachment_slot][3] = false
					end
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
	
			-- mod.reset_start = nil
			-- mod.do_reset = nil
	
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
			if not mod.build_animation:is_busy() then
				content.wait_next_frame = true
				content.reset = true
	
				return
			end
		end
	
		if content.wait_next_frame and not content.option_disabled then
			content.wait_next_frame = nil
			content.close_setting = true
			mod.dropdown_open = false
			mod.dropdown_closing = false

			-- self:start_weapon_move()
			if entry.attachment_slot then
				local ui_weapon_spawner = self:ui_weapon_spawner()
				if ui_weapon_spawner then
					ui_weapon_spawner:initiate_weapon_rotation(0, 1)
					ui_weapon_spawner:initiate_camera_movement()
				end
			end
	
			return
		elseif content.wait_next_frame and content.option_disabled then
			content.option_disabled = nil
			content.wait_next_frame = nil
	
			return
		end
	end






	instance.unit_hide_meshes = function(self, unit, hide)
		if unit and unit_alive(unit) then
			local num_meshes = Unit.num_meshes(unit)
			if num_meshes and num_meshes > 0 then
				for i = 1, num_meshes do
					Unit.set_mesh_visibility(unit, i, not hide)
				end
			end
		end
	end


	instance.create_bar_breakdown_widgets = function(self)
		self:destroy_bar_breakdown_widgets()
	
		table_clear(self.bar_breakdown_widgets)
		table_clear(self.bar_breakdown_widgets_by_name)
	
		local bar_breakdown_widgets = self.bar_breakdown_widgets
		local bar_breakdown_widgets_by_name = self.bar_breakdown_widgets_by_name
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
		self.bar_breakdown_name = "test name" --stripped_bar_data.name
	end
	
	instance.destroy_bar_breakdown_widgets = function(self)
		table_clear(self.bar_breakdown_widgets)
		table_clear(self.bar_breakdown_widgets_by_name)
	
		self.bar_breakdown_name = nil
	end

	-- ┌─┐┌┬┐┌┬┐┌─┐┌─┐┬ ┬┌┬┐┌─┐┌┐┌┌┬┐  ┌─┐┬─┐┌─┐┬  ┬┬┌─┐┬ ┬┌─┐
	-- ├─┤ │  │ ├─┤│  ├─┤│││├┤ │││ │   ├─┘├┬┘├┤ └┐┌┘│├┤ │││└─┐
	-- ┴ ┴ ┴  ┴ ┴ ┴└─┘┴ ┴┴ ┴└─┘┘└┘ ┴   ┴  ┴└─└─┘ └┘ ┴└─┘└┴┘└─┘

	-- Load attachment packages
	local possible_attachments = {}
	instance.load_attachment_packages = function(self, item, attachment_slot)
		mod:setup_item_definitions()

		local attachments = mod.attachment[self._item_name]
		local slot_attachments = attachments and attachments[attachment_slot]
		table_clear(possible_attachments)

		for index, attachment_data in pairs(slot_attachments) do
			local model_data = mod.attachment_models[self._item_name][attachment_data.id]
			local attachment_item = model_data and mod:persistent_table(REFERENCE).item_definitions[model_data.model]

			if attachment_item then
				local priority = false
				if index == mod.attachment_preview_index then
					priority = true
				else
					local diff = index - mod.attachment_preview_index
					if math_abs(diff) <= 2 then priority = true end
				end
				local target_index = #possible_attachments + 1
				if priority then target_index = 1 end
				table_insert(possible_attachments, target_index, {
					item = attachment_item,
					name = attachment_data.id,
					base_unit = attachment_item.base_unit,
					index = index,
				})
			end
		end
		
		self.attachment_preview_count = #possible_attachments

		for _, attachment_data in pairs(possible_attachments) do
			if attachment_data.item.resource_dependencies then
				for package_name, _ in pairs(attachment_data.item.resource_dependencies) do
					local package_key = attachment_slot.."_"..attachment_data.name
					local callback = callback(mod.cosmetics_view, "attachment_package_loaded", attachment_data.index, attachment_slot, attachment_data.name, attachment_data.base_unit)
					if not mod:persistent_table(REFERENCE).loaded_packages.customization[package_key] then
						mod:persistent_table(REFERENCE).used_packages.customization[package_key] = true
						mod:persistent_table(REFERENCE).loaded_packages.customization[package_key] = managers.package:load(package_name, REFERENCE, callback)
					elseif managers.package:has_loaded(package_name) then
						callback()
					end
				end
			end

		end
	end

	instance.update_attachment_previews = function(self, dt, t)
		local selected_index = mod.attachment_preview_index or 1
		local attachment_slot = self.preview_attachment_slot
		if self._weapon_preview._ui_weapon_spawner._weapon_spawn_data then
			for _, unit in pairs(self.spawned_attachments) do
				
				local link_unit = self._weapon_preview._ui_weapon_spawner._weapon_spawn_data.link_unit
				if unit and unit_alive(unit) then
					-- if index + 1 == self.attachment_preview_index then
					-- 	Unit.set_local_scale(unit, 1, vector3(1.3, 1.3, 1.3))
					-- else
					-- 	Unit.set_local_scale(unit, 1, vector3(1, 1, 1))
					-- end
					local index = self.attachment_index[unit]
					Unit.set_local_rotation(unit, 1, Unit.world_rotation(link_unit, 1))
	
					if index == selected_index then
						-- self:draw_box(unit)
					end
	
					-- local last_slot = self.attachment_slot_positions[7] or self.spawned_attachments_last_position[unit]
					-- self.dropdown_positions[attachment_slot][3] = index == self.attachment_preview_index
					if self.attachment_index_updated[unit] ~= mod.attachment_preview_index then
						-- local max = self.attachment_preview_count / 2
						-- local selected = selected_index / max
						-- local fraction = index / max
						-- local x = (max * fraction - max * (selected - .4)) * .4
						-- local z = math.abs(index - selected_index) * .1
						
						-- local camera = self.cosmetics_view._weapon_preview._ui_weapon_spawner._camera
						-- local rotation = Camera.world_rotation(camera)
						-- local camera_forward = Quaternion.forward(rotation)
						-- local distance = vector3_zero()
						-- local down = vector3.down() * .2
						-- if index + 1 == self.attachment_preview_index then
						-- 	distance = camera_forward * 3
						-- 	down = vector3.down() * .15
						-- else
						-- 	distance = camera_forward * 6
						-- end
						-- local camera_position = Camera.world_position(camera)
						-- local target_position = camera_position + distance + down + vector3(x, 0, 0)
						local world = self._weapon_preview._ui_weapon_spawner._world
						local target_position = self.attachment_slot_positions[6]
						-- local index = self.attachment_index[unit]
						local attachment_name = self.preview_attachment_name[unit]
						if index == mod.attachment_preview_index then
							local item = self._selected_item
							-- local attachment_slot = self.preview_attachment_slot
							if mod.attachment_preview_index ~= mod.last_attachment_preview_index then
								mod:play_attachment_sound(item, attachment_slot, attachment_name, "select")
								mod.last_attachment_preview_index = mod.attachment_preview_index
							end
							mod:preview_flashlight(true, world, unit, attachment_name)
							local ui_weapon_spawner = self._weapon_preview._ui_weapon_spawner
							-- local attachment_units_3p = ui_weapon_spawner._weapon_spawn_data.attachment_units_3p
							local unit_3p = ui_weapon_spawner._weapon_spawn_data.item_unit_3p
							local attachment_units_3p = ui_weapon_spawner._weapon_spawn_data.attachment_units_3p and ui_weapon_spawner._weapon_spawn_data.attachment_units_3p[unit_3p]
							-- local attachment_unit = attachment_units_3p and mod:get_attachment_slot_in_attachments(attachment_units_3p, attachment_slot)
							local attachment_unit = unit_3p and mod.gear_settings:attachment_unit(attachment_units_3p, attachment_slot)
							
							-- self.attachment_slot_positions[3] = attachment_unit and Unit.world_position(attachment_unit, 1) or self.attachment_slot_positions[3]
							target_position = self.attachment_slot_positions[3]
							self.spawned_attachments_last_position[unit] = attachment_unit and Unit.world_position(attachment_unit, 1)
							Unit.set_unit_visibility(unit, true, true)
	
							-- local attachment_name = attachment_unit and Unit.get_data(attachment_unit, "attachment_name")
							local attachment_data = attachment_name and mod.attachment_models[self._item_name][attachment_name]
							attachment_data = mod.gear_settings:apply_fixes(item, attachment_slot) or attachment_data
							local scale = attachment_data and attachment_data.scale and vector3_unbox(attachment_data.scale) or vector3_zero()
							Unit.set_local_scale(unit, 1, scale)
							
							-- local ui_weapon_spawner = self.cosmetics_view._weapon_preview._ui_weapon_spawner
							-- local attachment_units_3p = ui_weapon_spawner._weapon_spawn_data.attachment_units_3p
							-- local attachment_unit = mod:get_attachment_slot_in_attachments(attachment_units_3p, attachment_slot)
							-- -- local attachment_name = Unit.get_data(flashlight, "attachment_name")
							-- -- mod:preview_flashlight(true, self._world, flashlight, attachment_name)
							-- if attachment_unit then
							-- 	self.spawned_attachments_overwrite_position[unit] = self.attachment_slot_positions[7]
							-- end
							-- mod:play_attachment_sound(mod.cosmetics_view._selected_item, self.preview_attachment_slot, entry.new, "attach")
							
							-- target_position = self.attachment_slot_positions[3]
							-- Unit.set_unit_visibility(unit, true, true)
						elseif index ~= mod.attachment_preview_index then
							self.spawned_attachments_last_position[unit] = self.spawned_attachments_last_position[unit] 
								or self.attachment_slot_positions[3]
							local diff = index - mod.attachment_preview_index
							if math.abs(diff) <= 2 then
								target_position = self.attachment_slot_positions[3 + diff]
								Unit.set_unit_visibility(unit, true, true)
							else
								Unit.set_unit_visibility(unit, false, true)
							end
							mod:preview_flashlight(false, world, unit, attachment_name, true)
	
						end
	
						local tm, half_size = unit_box(unit)
						local radius = math_max(half_size.x, half_size.y)
						local scale = .08 / math_max(radius, half_size.z * 2)
						Unit.set_local_scale(unit, 1, vector3(scale, scale, scale))					
	
						self.spawned_attachments_last_position[unit] = self.spawned_attachments_target_position[unit] or self.attachment_slot_positions[6]
						self.spawned_attachments_target_position[unit] = target_position
	
						self.attachment_index_updated[unit] = mod.attachment_preview_index
						self.spawned_attachments_timer[unit] = t + 1
	
					elseif self.spawned_attachments_timer[unit] and self.spawned_attachments_timer[unit] > t then
						local target_position = self.spawned_attachments_target_position[unit]
						local last_position = self.spawned_attachments_last_position[unit]
						local progress = (self.spawned_attachments_timer[unit] - t) / 1
						local anim_progress = math.easeOutCubic(1 - progress)
						local lerp_position = vector3_lerp(vector3_unbox(last_position), vector3_unbox(target_position), anim_progress)
						-- mod:info("mod.update_attachment_previews: "..tostring(unit))
						Unit.set_local_position(unit, 1, lerp_position)
	
					elseif self.spawned_attachments_timer[unit] and self.spawned_attachments_timer[unit] <= t then
						self.spawned_attachments_timer[unit] = nil
						local target_position = self.spawned_attachments_target_position[unit]
						-- mod:info("mod.update_attachment_previews: "..tostring(unit))
						Unit.set_local_position(unit, 1, vector3_unbox(target_position))
						-- self.spawned_attachments_overwrite_position[unit] = nil
						-- self.attachment_slot_positions[7] = nil
	
					end
				end
			end
		end
	end
	
	instance.spawn_attachment_preview = function(self, index, attachment_slot, attachment_name, base_unit)
		local link_unit = self._weapon_preview._ui_weapon_spawner._weapon_spawn_data.link_unit
		local world = self._weapon_preview._ui_weapon_spawner._world
		local pose = Unit.world_pose(link_unit, 1)
		local unit = base_unit and World.spawn_unit_ex(world, base_unit, nil, pose)
		local callback = function()
		end
		Unit.force_stream_meshes(unit, callback, true)
		-- local attachment_data = mod.attachment_models[self.cosmetics_view._item_name][attachment_name]
		local attachment_data = attachment_name and mod.attachment_models[self._item_name][attachment_name]
		local scale = attachment_data and attachment_data.scale or vector3(1, 1, 1)
		attachment_data = mod.gear_settings:apply_fixes(self._selected_item, attachment_slot) or attachment_data
		scale = attachment_data and attachment_data.scale or scale
		Unit.set_local_scale(unit, 1, scale)
		-- mod:preview_flashlight(true, false, world, unit, attachment_name)
		self.preview_attachment_name[unit] = attachment_name
		self.attachment_index[unit] = index
		self.spawned_attachments[#self.spawned_attachments+1] = unit
		return unit
	end
	
	instance.try_spawning_previews = function(self)
		local weapon_spawn_data = self:weapon_spawn_data()
		if weapon_spawn_data then
			for i = #self.load_previews, 1, -1 do
				local preview = self.load_previews[i]
				self:spawn_attachment_preview(preview.index, preview.attachment_slot, preview.attachment_name, preview.base_unit)
				self.load_previews[i] = nil
			end
		end
	end
	
	instance.attachment_package_loaded = function(self, index, attachment_slot, attachment_name, base_unit)
		-- local attachment_unit = self:spawn_attachment_preview(index, attachment_slot, attachment_name, base_unit)
		self.load_previews[#self.load_previews+1] = {
			index = index,
			attachment_slot = attachment_slot,
			attachment_name = attachment_name,
			base_unit = base_unit,
		}
	end
	
	instance.release_attachment_packages = function(self)
		self:destroy_attachment_previews()
		mod:persistent_table(REFERENCE).used_packages.customization = {}
		for package_key, package_id in pairs(mod:persistent_table(REFERENCE).loaded_packages.customization) do
			managers.package:release(package_id)
		end
		mod:persistent_table(REFERENCE).loaded_packages.customization = {}
	end
	
	instance.destroy_attachment_previews = function(self)
		local world = self._weapon_preview._ui_weapon_spawner._world
		for _, unit in pairs(self.spawned_attachments) do
			if unit and unit_alive(unit) then
				World.unlink_unit(world, unit)
			end
		end
		for _, unit in pairs(self.spawned_attachments) do
			if unit and unit_alive(unit) then
				World.destroy_unit(world, unit)
			end
		end
		-- mod.spawned_attachments = {}
		table_clear(self.spawned_attachments)
	end
	
	instance.setup_attachment_slot_positions = function(self)
		local camera = self._weapon_preview._ui_weapon_spawner._camera
		local rotation = Camera.world_rotation(camera)
		local camera_forward = Quaternion.forward(rotation)
		local camera_position = Camera.world_position(camera)
		local x = .05
		local link_unit = self._weapon_preview._ui_weapon_spawner._weapon_spawn_data.link_unit
		self.attachment_slot_positions[1]:store(camera_position + camera_forward * 5 + vector3(x - .6, 0, 0))
		self.attachment_slot_positions[2]:store(camera_position + camera_forward * 4 + vector3(x - .3, -.1, -.1))
		self.attachment_slot_positions[3]:store(camera_position + camera_forward * 2 + vector3(x, 0, -.05))
		self.attachment_slot_positions[4]:store(camera_position + camera_forward * 3 + vector3(x + .175, -.15, .025))
		self.attachment_slot_positions[5]:store(camera_position + camera_forward * 3.5 + vector3(x + .3, 0, .2))
		self.attachment_slot_positions[6]:store(camera_position + camera_forward * 2 + vector3(x, 0, -.05))
		-- self.attachment_slot_positions = {
		-- 	vector3_box(camera_position + camera_forward * 5 + vector3(x - .6, 0, 0)),
		-- 	vector3_box(camera_position + camera_forward * 4 + vector3(x - .3, -.1, -.1)),
		-- 	vector3_box(camera_position + camera_forward * 2 + vector3(x, 0, -.05)),
		-- 	vector3_box(camera_position + camera_forward * 3 + vector3(x + .175, -.15, .025)),
		-- 	vector3_box(camera_position + camera_forward * 3.5 + vector3(x + .3, 0, .2)),
		-- 	-- vector3_box(Unit.world_position(link_unit, 1) + vector3(0, 0, 3)),
		-- 	vector3_box(camera_position + camera_forward * 2 + vector3(x, 0, -.05)),
		-- }
	end
	
	instance.create_attachment_array = function(self, item, attachment_slot)
		self:destroy_attachment_previews()
		self.preview_attachment_slot = attachment_slot
		if self._weapon_preview._ui_weapon_spawner._camera then
			local ui_weapon_spawner = self._weapon_preview._ui_weapon_spawner
			if ui_weapon_spawner._weapon_spawn_data then
				-- local attachment_units_3p = ui_weapon_spawner._weapon_spawn_data.attachment_units_3p
				local unit_3p = ui_weapon_spawner._weapon_spawn_data.item_unit_3p
				local attachment_units_3p = ui_weapon_spawner._weapon_spawn_data.attachment_units_3p and ui_weapon_spawner._weapon_spawn_data.attachment_units_3p[unit_3p]
				-- local attachment_unit = attachment_units_3p and mod:get_attachment_slot_in_attachments(attachment_units_3p, attachment_slot)
				local attachment_unit = unit_3p and mod.gear_settings:attachment_unit(attachment_units_3p, attachment_slot)
				
				if attachment_unit then
					local attachment_name = attachment_unit and Unit.get_data(attachment_unit, "attachment_name")
					local attachment_data = attachment_name and mod.attachment_models[self._item_name][attachment_name]
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

	-- ┬  ┬┬┌─┐┬ ┬  ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐
	-- └┐┌┘│├┤ │││  ├┤ │ │││││   │ ││ ││││└─┐
	--  └┘ ┴└─┘└┴┘  └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘

	-- Init custom
	instance.init_custom = function(self)
		self.total_dropdown_height = 950
		self.preview_attachment_slot = nil
		self.preview_attachment_name = {}
		self.attachment_index = {}
		self.attachment_index_updated = {}
		self.spawned_attachments_timer = {}
		self.spawned_attachments_target_position = {}
		self.attachment_preview_count = 0
		self.spawned_attachments_last_position = {}
		self.load_previews = {}
		self.spawned_attachments = {}
		self.dropdown_positions = {}
		self._custom_widgets = {}
		self._not_applicable = {}
		self._custom_widgets_overlapping = 0
		self._item_name = mod.gear_settings:short_name(self._presentation_item.name)
		self._gear_id = mod.gear_settings:item_to_gear_id(self._presentation_item)
		self._slot_info_id = mod.gear_settings:slot_info_id(self._presentation_item)
		self.bar_breakdown_widgets = {}
		self.bar_breakdown_widgets_by_name = {}
		self.changed_weapon_settings = {}
		self.original_weapon_settings = {}
		self.changed_attachment_settings = {}
		self.start_weapon_settings = {}
		self.equipment_line_target = {0, 0}
		self.attachment_slot_positions = {
			vector3_box(vector3_zero()),
			vector3_box(vector3_zero()),
			vector3_box(vector3_zero()),
			vector3_box(vector3_zero()),
			vector3_box(vector3_zero()),
			vector3_box(vector3_zero()),
		}
		self.scenegraph_to_widgets = {}
		self.combination = nil
	end

	-- Custom enter
	instance.custom_enter = function(self)
		-- self.current_combination = 1
		-- self.combinations = self:create_all_combinations()
		self.combination_count = self:combination_count()
		-- self.filtered_combinations = self.combinations
		-- self.filtered_combinations = {}
		-- self:update_filtered_combinations()
		-- Switch off modding tool
		self._modding_tool_toggled_on = false
		self._visibility_toggled_on = true
		-- -- Remove player visible equipment
		-- self:remove_player_visible_equipment()
		-- Generate custom widgets
		self:generate_custom_widgets()
		-- Resolve attachments not applicable
		self:resolve_not_applicable_attachments()
		-- -- Init custom weapon zoom
		-- self:init_custom_weapon_zoom()
		-- Get changed settings
		self:get_changed_weapon_settings()
		-- Update start settings
		self:update_start_settings()
		-- Update reset button
		self:update_reset_button()
		-- Hide custom widgets
		self:hide_custom_widgets(true)
		-- Resolve no support
		self:resolve_no_support()
		-- Load attachment sounds
		mod.gear_settings:load_attachment_sounds(self._selected_item)
		-- Create bar breakdown widgets
		self:create_bar_breakdown_widgets()
		-- Hide UI widgets
		-- self._item_grid._widgets_by_name.grid_divider_top.visible = false
		-- self._item_grid._widgets_by_name.grid_divider_bottom.visible = false
		-- self._item_grid._widgets_by_name.grid_divider_title.visible = false
		self._item_grid._widgets_by_name.grid_background.visible = false
		-- Set scrollbar progress
		self:set_scrollbar_progress(0)
		-- Register events
		managers.event:register(self, "weapon_customization_hide_ui", "hide_ui")
		-- -- Get changed settings
		-- self:get_changed_weapon_settings()
		-- -- Update start settings
		-- self:update_start_settings()
		-- Register custom button callbacks
		self:register_custom_button_callbacks()
		-- self:update_combination_inputs()
	end

	instance.reset_stuff = function(self)
		-- mod.move_position = vector3_box(vector3_zero())
		-- mod.move_position:store(vector3_zero())
		-- mod.new_position = nil
		-- mod.new_position:store(vector3_zero())
		-- mod.last_move_position = nil
		-- mod.link_unit_position = nil
		-- mod.link_unit_position:store(vector3_zero())
		-- mod.do_move = nil
		-- mod.move_end = nil
		-- mod.do_reset = nil
		-- mod.reset_start = nil
		-- mod._last_rotation_angle = 0
		mod.mesh_positions = {}
		mod.weapon_part_animation_update = nil
		mod.build_animation:clear()
		mod.preview_flashlight_state = false


		mod.start_rotation = nil
		mod._rotation_angle = nil
		mod._target_rotation_angle = nil
		mod._last_rotation_angle = nil
		mod.is_doing_rotation = nil
		mod.rotation_time = nil
		mod.do_rotation = nil

		mod.do_move = nil
		mod.last_move_position = nil
		mod.move_position = nil
		mod.new_position = nil
		mod._link_unit_position = nil
		mod.move_end = nil
		mod.current_move_duration = nil
	end

	-- Custom exit
	instance.custom_exit = function(self)
		-- Reset attachments
		self:reset_attachments(true)

		self:release_attachment_packages()

		self:reset_stuff()
		
		local weapon_spawner = self._weapon_preview._ui_weapon_spawner
		local default_position = weapon_spawner._link_unit_base_position
		weapon_spawner._link_unit_position = default_position
		weapon_spawner._rotation_angle = 0
		weapon_spawner._default_rotation_angle = 0

		if weapon_spawner._weapon_spawn_data then
			local link_unit = weapon_spawner._weapon_spawn_data.link_unit
			-- mod:info("CLASS.InventoryWeaponCosmeticsView: "..tostring(link_unit))
			Unit.set_local_position(link_unit, 1, vector3_unbox(default_position))
		end

		-- mod:check_unsaved_changes(true)
		-- mod.gear_settings:release_attachment_sounds()

		managers.event:unregister(self, "weapon_customization_hide_ui")
		
		-- mod:redo_weapon_attachments(self._presentation_item)
		-- self:destroy_temp_settings()
		mod.gear_settings:destroy_temp_settings(self._gear_id)
		-- mod:persistent_table(REFERENCE).temp_gear_settings[self._gear_id] = nil
	end

	-- Modify wwise states
	instance.modify_wwise_state = function(self, settings)
		settings.wwise_states = {options = WwiseGameSyncSettings.state_groups.options.none}
	end

	-- Add custom tab
	instance.add_custom_tab = function(self, content)
		-- Check item name and attachment
		if self._item_name and mod.attachment[self._item_name] then
			-- Add tab
			content[3] = {
				display_name = "loc_weapon_cosmetics_customization",
				slot_name = "slot_weapon_skin_ewc",
				item_type = "WEAPON_SKIN",
				icon = "content/ui/materials/icons/system/settings/category_gameplay",
				filter_on_weapon_template = true,
				apply_on_preview = function(real_item, presentation_item)
					self:_preview_item(presentation_item)
				end
			}
		end
	end

	-- Register custom button callbacks
	instance.register_custom_button_callbacks = function(self)
		-- Reset button
		self._widgets_by_name.reset_button.content.hotspot.pressed_callback = callback(self, "cb_on_reset_pressed")
		-- Randomize button
		self._widgets_by_name.randomize_button.content.hotspot.pressed_callback = callback(self, "cb_on_randomize_pressed")
		-- Prev button
		-- self._widgets_by_name.prev_button.content.hotspot.pressed_callback = callback(self, "cb_on_prev_pressed")
		-- Next button
		-- self._widgets_by_name.next_button.content.hotspot.pressed_callback = callback(self, "cb_on_next_pressed")
		-- Combination button
		self._widgets_by_name.reload_definitions_button.content.hotspot.pressed_callback = callback(self, "cb_on_reload_definitions_pressed")
	end

	-- instance.cb_on_prev_pressed = function(self)
	-- 	self.current_combination = math_max(self.current_combination - 1, 1)
	-- 	-- self:attach_attachments(self.filtered_combinations[self.current_combination])
	-- 	self:update_combination_inputs()
	-- end

	-- instance.cb_on_next_pressed = function(self)
	-- 	self.current_combination = math_min(self.current_combination + 1, #self.filtered_combinations)
	-- 	-- self:attach_attachments(self.filtered_combinations[self.current_combination])
	-- 	self:update_combination_inputs()
	-- end

	

	-- Update equip button
	instance.update_equip_button = function(self)
		-- Get button widget
		local button = self._widgets_by_name.equip_button
		-- Get button content
		local button_content = button and button.content
		-- Check if tab
		if self:is_tab() then
			-- Get disabled state
			local disabled = not self:attachments_changed_since_start() or self:is_busy() or self._modding_tool_toggled_on or not button.visible or not self._visibility_toggled_on or not self._gear_id
			-- Set disabled
			button_content.hotspot.disabled = disabled
			-- Update text
			button_content.text = utf8_upper(disabled and mod:localize("loc_weapon_inventory_equipped_button") or mod:localize("loc_weapon_inventory_equip_button"))
		else
			-- Set disabled
			button_content.hotspot.disabled = false
		end
	end
	
	-- Update reset button
	instance.update_reset_button = function(self)
		-- Get button widget
		local button = self._widgets_by_name.reset_button
		-- Get button content
		local button_content = button and button.content
		-- Get disabled state
		-- local disabled = not self:attachments_changed_at_all() or mod.build_animation:is_busy()
		local disabled = not self:attachments_changed_at_all() or self:is_busy() or self._modding_tool_toggled_on or not button.visible or not self._visibility_toggled_on or not self._gear_id or not self.changed_weapon_settings or table_size(self.changed_weapon_settings) <= 0
		-- Set disabled
		button_content.hotspot.disabled = disabled
		-- Update text
		button_content.text = utf8_upper(disabled and mod:localize("loc_weapon_inventory_no_reset_button") or mod:localize("loc_weapon_inventory_reset_button"))
	end

	-- Reset button pressed callback
	instance.cb_on_reset_pressed = function(self, skip_animation)
		-- Skip animation?
		local skip_animation = skip_animation or not mod:get(MOD_OPTION_BUILD_ANIMATION)
		-- Clone changed settings
		local changed_weapon_settings = table_clone(self.changed_weapon_settings)
		for attachment_slot, value in pairs(changed_weapon_settings) do
			changed_weapon_settings[attachment_slot] = "default"
		end
		-- Attach default attachments
		self:attach_attachments(changed_weapon_settings, skip_animation)
		-- Reset animation
		-- self:start_weapon_move()
		local ui_weapon_spawner = self:ui_weapon_spawner()
		if ui_weapon_spawner then
			ui_weapon_spawner:initiate_camera_movement()
			ui_weapon_spawner:initiate_weapon_rotation(0, 1)
		end
		-- mod.new_rotation = 0
		-- mod.do_rotation = true
	end

	-- Update randomize button
	instance.update_randomize_button = function(self)
		-- Get button widget
		local button = self._widgets_by_name.randomize_button
		-- Get button content
		local button_content = button and button.content
		-- Get disabled state
		local disabled = self:is_busy() or self._modding_tool_toggled_on or not button.visible or not self._visibility_toggled_on or not self._gear_id
		-- Set disabled
		button_content.hotspot.disabled = disabled
	end

	-- Randomize button pressed callback
	instance.cb_on_randomize_pressed = function(self, skip_animation)
		-- Get random attachments
		local random_attachments = mod.gear_settings:randomize_weapon(self._selected_item)
		-- mod:dtf(random_attachments, "random_attachments", 10)
		-- Check attachments
		if random_attachments then
			-- Skip animation?
			local skip_animation = skip_animation or not mod:get(MOD_OPTION_BUILD_ANIMATION)
			-- Attach random attachments
			self:attach_attachments(random_attachments, skip_animation)
			-- Get changed settings
			self:get_changed_weapon_settings()
		end
	end

	-- Custom switch tab
	instance.custom_switch_tab = function(self, index)
		self.__selected_tab_index = index
		-- self._grid_display_name = ""
		if self:is_tab(index) then
			mod.weapon_skin_override = nil
			-- local content = self._tabs_content[self.__selected_tab_index]
			-- self._grid_display_name = "loc_weapon_cosmetics_customization"
			self:present_grid_layout({})
			self._item_grid._widgets_by_name.grid_empty.visible = false
			self:hide_custom_widgets(false)
			-- self.original_weapon_settings = {}
			table_clear(self.original_weapon_settings)
			self:get_changed_weapon_settings()
		else
			mod.weapon_skin_override = true
			-- local t = managers.time:time("main")
			-- mod.reset_start = t
			self:check_unsaved_changes(true)
			self:hide_custom_widgets(true)
			-- local content = self._tabs_content[self.__selected_tab_index]
			-- mod:echo("Switching to " .. content.display_name)
			-- self._grid_display_name = content.display_name
			-- self:present_grid_layout({})
		end
		
	end

	instance.update_reload_definitions_button = function(self)
		-- Get button widget
		local button = self._widgets_by_name.reload_definitions_button
		-- visibility
		-- button.visible = self:is_tab()
		-- Get button content
		local button_content = button and button.content
		-- Get disabled state
		local disabled = self:is_busy() or self._modding_tool_toggled_on or not button.visible or not self._visibility_toggled_on or not self._gear_id
		-- Set disabled
		button_content.hotspot.disabled = disabled
	end

	instance.cb_on_reload_definitions_pressed = function(self)
		-- Reload weapon definitions
		mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_anchors")
		-- Reload plugins via registered definition callback
		local reload_definitions = mod:persistent_table(REFERENCE).reload_definitions
		for _, callback in pairs(reload_definitions) do
			if callback and type(callback) == "function" then callback() end
		end
		-- Create new preview item instance
		self._presentation_item = MasterItems.create_preview_item_instance(self._selected_item)
		-- Preview item
		self:_preview_item(self._presentation_item)
		-- Get slot info
		self._slot_info_id = mod.gear_settings:slot_info_id(self._presentation_item)
	end

	instance.update_attachment_info = function(self)
		local visible = self._widgets_by_name.attachment_display_name.content.text ~= ""
		self._widgets_by_name.attachment_info_box.visible = false
		self._widgets_by_name.attachment_display_name.visible = visible
		if self.bar_breakdown_widgets_by_name.attachment_bar_1 then
			self.bar_breakdown_widgets_by_name.attachment_bar_1.visible = visible
			self.bar_breakdown_widgets_by_name.attachment_bar_2.visible = visible
			self.bar_breakdown_widgets_by_name.attachment_bar_3.visible = visible
		end
	end

	-- Custom update
	instance.custom_update = function(self, input_service, dt, t)
		-- Set ui weapon spawner rotation input
		local ui_weapon_spawner = self:ui_weapon_spawner()
		ui_weapon_spawner._rotation_input_disabled = self:is_busy()
		-- Update custom widgets
		self:update_custom_widgets(input_service, dt, t)
		-- Update attachment info
		self:update_attachment_info()
		-- Update buttons
		self:update_equip_button()
		self:update_reset_button()
		self:update_randomize_button()
		-- self:update_combination_inputs()
		self:update_reload_definitions_button()

		if not self:is_busy() then
			ui_weapon_spawner:initiate_camera_movement()
			ui_weapon_spawner:initiate_weapon_rotation()
		end
	end

	instance.set_combinations_text = function(self)
		-- Set text
		self._widgets_by_name.sub_display_name.content.text = ItemUtils.display_name(self._selected_item).." - "..tostring(self.combination_count).." combinations"
	end

	-- instance.calculate_combinations = function(self)
	-- 	-- Calculate combinations
	-- 	local combinations = 0
	-- 	local attachment_slots = mod.gear_settings:possible_attachment_slots(self._selected_item)
	-- 	for _, attachment_slot in pairs(attachment_slots) do
	-- 		-- local possible_attachments = mod.gear_settings:possible_attachments(self._selected_item, attachment_slot)
	-- 		combinations = combinations + table_size(mod.gear_settings:possible_attachments(self._selected_item, attachment_slot))
	-- 	end
	-- 	return combinations
	-- end

	instance.attachment_by_index = function(self, attachment_slot, index)
		return mod.gear_settings:possible_attachments(self._selected_item, attachment_slot)[index]
	end

	instance.attachment_combination = function(self, attachment_slots, attachment_indices)
		local combination = {}
		for _, attachment_slot in pairs(attachment_slots) do
			combination[attachment_slot] = self:attachment_by_index(attachment_slot, attachment_indices[_])
		end
		return combination
	end

	-- local lol = false
	-- instance.update_filtered_combinations = function(self)

	-- 	-- mod:echo("update_filtered_combinations")
	-- 	-- table_clear(self.filtered_combinations)

	-- 	-- for _, combination in pairs(self.combinations) do

	-- 	-- 	local add_combination = true

	-- 	-- 	for attachment_slot, value in pairs(combination) do

	-- 	-- 		local lock_widget = self._widgets_by_name[attachment_slot.."_lock"]

	-- 	-- 		if lock_widget and lock_widget.content.checked then

	-- 	-- 			local selected_value = mod.gear_settings:get(self._gear_id, attachment_slot) --self._widgets_by_name[attachment_slot.."_custom"].content.entry.get_function()

	-- 	-- 			-- if not lol then
	-- 	-- 			-- 	mod:dtf(self._widgets_by_name[attachment_slot.."_custom"], "test", 10)
	-- 	-- 			-- 	lol = true
	-- 	-- 			-- end

	-- 	-- 			if value ~= selected_value then

	-- 	-- 				mod:echo(value.." ~= "..selected_value)

	-- 	-- 				add_combination = false

	-- 	-- 			end

	-- 	-- 		end

	-- 	-- 	end

	-- 	-- 	if add_combination then

	-- 	-- 		self.filtered_combinations[#self.filtered_combinations+1] = combination

	-- 	-- 	end

	-- 	-- end

	-- 	self.filtered_combinations = {}
	-- 	self:update_combination_inputs()
	-- 	self:set_combinations_text()

	-- end

	-- local function icombn_many(n, params, t)
	-- 	t = t or {}
	-- 	if n < 1 then return nil end
	-- 	local o = params[n]
	-- 	local l = table.getn(o)
	-- 	if n == 1 then
	-- 		local i = 1
	-- 		return function()
	-- 			if i > l then return nil end
	-- 			t[n] = o[i]
	-- 			i = i + 1
	-- 			return t[n]
	-- 		end
	-- 	end
	-- 	local i = 1
	-- 	local v = icombn_many(n-1, params, t)
	-- 	return function()
	-- 		if i > l then return nil end
	-- 		local x = v()
	-- 		if x == nil then
	-- 			i = i + 1
	-- 			if i > l or n < 0 then return nil end
	-- 			v = icombn_many(n-1, params, t)
	-- 			x = v()
	-- 		end
	-- 		if x == nil then return nil end
	-- 		t[n] = o[i]
	-- 		return unpack(t)
	-- 	end
	-- end
	-- local function combn_many(...)
	-- 	local params = {...}
	-- 	local l = table.getn(params)
	-- 	if l == 0 then error("Need at least one array.") end
	-- 	return icombn_many(l, params, nil)
	-- end
	local possible_attachments = {}
	-- local possible_combinations = {}
	instance.combination_count = function(self)
		local count = 1
		local attachment_slots = mod.gear_settings:possible_attachment_slots(self._selected_item)
		table_clear(possible_attachments)
		for _, attachment_slot in pairs(attachment_slots) do
			local attachments = mod.gear_settings:possible_attachments(self._selected_item, attachment_slot)
			if attachments and #attachments > 0 then
				possible_attachments[#possible_attachments+1] = attachments
			end
		end
		for _, attachments in pairs(possible_attachments) do
			count = count * #attachments
		end
		return count
	end
	-- instance.create_all_combinations = function(self, get_count, get_n)
	-- 	if not mod:persistent_table(REFERENCE).cache.combinations[self._selected_item.name] then

	-- 		local attachment_slots = mod.gear_settings:possible_attachment_slots(self._selected_item)

	-- 		table_clear(possible_attachments)

	-- 		for _, attachment_slot in pairs(attachment_slots) do
	-- 			local attachments = mod.gear_settings:possible_attachments(self._selected_item, attachment_slot)
	-- 			if attachments and #attachments > 0 then
	-- 				possible_attachments[#possible_attachments+1] = attachments
	-- 			end
	-- 		end

	-- 		table_clear(possible_combinations)

	-- 		local f = combn_many(unpack(possible_attachments))
	-- 		while true do
	-- 			local x = {f()}
	-- 			if #x == 0 then break end
	-- 			possible_combinations[#possible_combinations+1] = x
	-- 		end

	-- 		mod:dtf(possible_combinations, "combinations", 10)

	-- 		mod:persistent_table(REFERENCE).cache.combinations[self._selected_item.name] = possible_combinations
	-- 	end

	-- 	return mod:persistent_table(REFERENCE).cache.combinations[self._selected_item.name]
	-- end

end)

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #############################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################################################

mod:hook(CLASS.InventoryWeaponCosmeticsView, "init", function(func, self, settings, context, ...)

	-- Fetch instance
	mod.cosmetics_view = self

	-- Modify wwise states
	self:modify_wwise_state(settings)

	-- Original function
	func(self, settings, context, ...)

	-- Custom init
	self:init_custom()

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "on_enter", function(func, self, ...)

	-- Fetch instance
	mod.cosmetics_view = self

	-- Create temp gear settings
	-- self:create_temp_setting()
	mod.gear_settings:create_temp_settings(self._gear_id)

	-- mod:echo("on_enter")

	-- Original function
	func(self, ...)

	-- Custom enter
	self:custom_enter()

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "update", function(func, self, dt, t, input_service, ...)

	-- Unset previewed element
	if self:is_tab() then
		self._previewed_element = nil
	end

	-- Original function
	local pass_input, pass_draw = func(self, dt, t, input_service, ...)

	-- Custom update
	self:custom_update(input_service, dt, t)

	-- Return original values
	return pass_input, pass_draw

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_handle_input", function(func, self, input_service, dt, t, ...)

	-- Save rotation
	local zoom_target = self._weapon_zoom_target
	local zoom_fraction = self._weapon_zoom_fraction

	func(self, input_service, dt, t, ...)

	-- Scrollbar
	self:handle_scrollbar_input(input_service)

	-- Check is rotation is disabled
	if self:is_busy() then
		-- Reset rotation
		self._weapon_zoom_target = zoom_target
		self._weapon_zoom_fraction = zoom_fraction
	end

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_set_weapon_zoom", function(func, self, fraction, ...)

	if not self:is_busy() then

		-- Original function
		func(self, fraction, ...)
		
	end

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "on_exit", function(func, self, ...)

	-- Custom exit
	self:custom_exit()

	-- Original function
	func(self, ...)

	-- Destroy instance
	mod.cosmetics_view = nil

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "cb_on_equip_pressed", function(func, self, ...)

	if self:is_tab() then

		-- Equip attachments
		self:equip_attachments()

		-- Get changed settings
		self:get_changed_weapon_settings()

		-- Update start settings
		self:update_start_settings()
		-- mod.start_weapon_settings = table_clone(mod.changed_weapon_settings)

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

		-- Custom switch tab
		self:custom_switch_tab(index)
		
		-- Original function
		func(self, index, ...)

	end

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_preview_element", function(func, self, element, ...)

	-- Return on nil
	if not element then return end

	-- Original function
	func(self, element, ...)

	-- self._widgets_by_name.sub_display_name.content.text = ItemUtils.display_name(self._selected_item).." - "..tostring(self:calculate_combinations().." combinations")
	self:set_combinations_text()

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "present_grid_layout", function(func, self, layout, optional_on_present_callback, ...)
	self._grid_display_name = nil
	-- Original function
	func(self, layout, optional_on_present_callback, ...)
end)