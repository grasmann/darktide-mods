local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
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
	local string_gsub = string.gsub
    local vector3_box = Vector3Box
    local table_clone = table.clone
    local string_find = string.find
	local unit_get_data = Unit.get_data
	local table_reverse = table.reverse
	local table_contains = table.contains
    local vector3_unbox = vector3_box.unbox
	local vector3_distance = vector3.distance
	local RESOLUTION_LOOKUP = RESOLUTION_LOOKUP
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
	local TOGGLE_VISIBILITY_ENTRY = "entry_"..tostring(3)
--#endregion

-- ##### ┌─┐┬  ┌─┐┌┐ ┌─┐┬    ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ################################################################
-- ##### │ ┬│  │ │├┴┐├─┤│    ├┤ │ │││││   │ ││ ││││└─┐ ################################################################
-- ##### └─┘┴─┘└─┘└─┘┴ ┴┴─┘  └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ################################################################

mod.get_cosmetics_scenegraphs = function(self)
	if mod._cosmetics_scenegraphs then return mod._cosmetics_scenegraphs end
	local cosmetics_scenegraphs = {}
	for _, attachment_slot in pairs(self.attachment_slots) do
		cosmetics_scenegraphs[#cosmetics_scenegraphs+1] = attachment_slot.."_text_pivot"
		cosmetics_scenegraphs[#cosmetics_scenegraphs+1] = attachment_slot.."_pivot"
	end
	mod._cosmetics_scenegraphs = cosmetics_scenegraphs
	return cosmetics_scenegraphs
end

-- ##### ┬  ┬┬┌─┐┬ ┬  ┌┬┐┌─┐┌─┐┬┌┐┌┬┌┬┐┬┌─┐┌┐┌┌─┐ #####################################################################
-- ##### └┐┌┘│├┤ │││   ││├┤ ├┤ │││││ │ ││ ││││└─┐ #####################################################################
-- #####  └┘ ┴└─┘└┴┘  ─┴┘└─┘└  ┴┘└┘┴ ┴ ┴└─┘┘└┘└─┘ #####################################################################

mod:hook_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view_definitions", function(instance)

	local top, z, y = 115, 100, -20
	local info_box_size = {1250, 200}
	local equip_button_size = {374, 76}

	-- Get attachment slot scenegraph names
	local cosmetics_scenegraphs = mod:get_cosmetics_scenegraphs()

	-- Iterate through attachment slot scenegraphs
	for _, scenegraph_id in pairs(cosmetics_scenegraphs) do
		-- Check if scenegraph is a label
		if string_find(scenegraph_id, "text_pivot") then
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

	-- Modify sub display name scenegraph
	instance.scenegraph_definition.sub_display_name.horizontal_alignment = "left"
	instance.scenegraph_definition.sub_display_name.size[1] = 1920 - (grid_width + 160)

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

	-- Create attachment info box widgets
	local sub_display_name_style = table_clone(UIFontSettings.header_3)
	sub_display_name_style.text_horizontal_alignment = "left"
	sub_display_name_style.text_vertical_alignment = "top"

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

	-- Modify legend inputs
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

end)

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view", function(instance)

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
		return index == 3 or self._selected_tab_index == 3
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
		return weapon_spawn_data and weapon_spawn_data.attachment_units_3p
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
		for _, scenegraph_name in pairs(cosmetics_scenegraphs) do
			-- Make sure attachment slot is applicable
			if not table_contains(self._not_applicable, scenegraph_name) then
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
					local scenegraph_entry = self._ui_scenegraph[scenegraph_name]
					widget.original_y = widget.original_y or widget.offset[2]
					widget.offset[2] = widget.original_y - (self.total_dropdown_height - 950) * progress
					local offset = widget.offset[2] + scenegraph_entry.local_position[2]
					widget.visible = offset > 10 and offset < 950 and self._selected_tab_index == 3
				end
			end
		end
	end

	-- ┌┬┐┬─┐┌─┐┬ ┬  ┌─┐┬ ┬┬  ┌─┐┬ ┬┌─┐┌─┐┌─┐┌─┐
	--  ││├┬┘├─┤│││  │ ┬│ ││  └─┐├─┤├─┤├─┘├┤ └─┐
	-- ─┴┘┴└─┴ ┴└┴┘  └─┘└─┘┴  └─┘┴ ┴┴ ┴┴  └─┘└─┘	

	-- Draw box
	instance.draw_box = function(self, unit, saved_origin)
		if unit and unit_alive(unit) then
			local tm, half_size = unit_box(unit)
			local gui = self:forward_gui()
			local ui_weapon_spawner = self:ui_weapon_spawner()
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

	-- Draw box
	instance.draw_equipment_box = function(self, dt, t)
		local weapon_unit = self:weapon_unit()
		if weapon_unit and unit_alive(weapon_unit) and not mod.dropdown_open then
			local attachments = mod.gear_settings:attachments(weapon_unit)
			if attachments and table_size(attachments) > 0 then
				for attachment_slot, _ in pairs(attachments) do
					local unit = mod.gear_settings:attachment_unit(weapon_unit, attachment_slot)
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
	
	-- Draw lines
	instance.draw_equipment_lines = function(self, dt, t)
		-- Get weapon unit
		local weapon_unit = self:weapon_unit()
		-- Check if weapon unit is valid and dropdown is not open
		if weapon_unit and unit_alive(weapon_unit) and not mod.dropdown_open then
			-- Get attachments
			local attachments = mod.gear_settings:attachments(weapon_unit)
			-- Check if attachments are valid
			if attachments and table_size(attachments) > 0 then
				-- Get objects
				local gui = self:forward_gui()
				local ui_weapon_spawner = self:ui_weapon_spawner()
				local camera = ui_weapon_spawner and ui_weapon_spawner._camera
				-- Iterate through attachment slots
				for attachment_slot, _ in pairs(attachments) do
					-- Get attachment unit
					local unit = mod.gear_settings:attachment_unit(weapon_unit, attachment_slot)
					-- Check if attachment unit is valid
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

	instance.simple_unit_box = function(self, unit)
		if unit and unit_alive(unit) then
			local tm, half_size = unit_box(unit)
			local gui = self:forward_gui()
			local ui_weapon_spawner = self:ui_weapon_spawner()
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
			local most_left_top = nil
			local last = math.huge
			for name, data in pairs(results) do
				local val = data.position[1] + data.position[2]
				if val < last then
					last = val
					most_left_top = name
				end
			end
			-- Save as target for lines
			local most_right_bottom = nil
			local last = 0
			for name, data in pairs(results) do
				local val = data.position[1] + data.position[2]
				if val > last then
					last = val
					most_right_bottom = name
				end
			end
			local top_right = vector3(results[most_right_bottom].position[1], results[most_left_top].position[2], 0)
			local bottom_left = vector3(results[most_left_top].position[1], results[most_right_bottom].position[2], 0)
			-- Draw
			ScriptGui.hud_line(gui, results[most_left_top].position, top_right, LINE_Z, LINE_THICKNESS, Color(255, 106, 121, 100))
			-- ScriptGui.hud_line(gui, top_right, results[most_right_bottom].position, LINE_Z, LINE_THICKNESS, Color(255, 106, 121, 100))
			ScriptGui.hud_line(gui, results[most_left_top].position, bottom_left, LINE_Z, LINE_THICKNESS, Color(255, 106, 121, 100))
			-- ScriptGui.hud_line(gui, bottom_left, results[most_right_bottom].position, LINE_Z, LINE_THICKNESS, Color(255, 106, 121, 100))

			local size = vector3(results[most_right_bottom].position[1] - results[most_left_top].position[1],
				results[most_right_bottom].position[2] - results[most_left_top].position[2], 0)

			local center = vector3(results[most_right_bottom].position[1] - size.x / 2,
				results[most_right_bottom].position[2] - size.y / 2, 0)

			ScriptGui.hud_line(gui, results[most_left_top].position, center, LINE_Z, LINE_THICKNESS, Color(255, 106, 121, 100))

			return most_left_top, top_right, most_right_bottom, bottom_left, size, center
		end
	end

	instance.update_click_selection = function(self, input_service, dt, t)
		local cursor = input_service:get("cursor")
		local attachment_units = self:attachment_units()
		local hovered_units = {}
		for _, unit in pairs(attachment_units) do
			local tl, tr, br, bl, size, center = self:simple_unit_box(unit)
			local unit_hover = math.point_is_inside_2d_box(cursor, tl, size)
			if unit_hover then
				hovered_units[#hovered_units+1] = {
					unit = unit,
					tl = tl,
					tr = tr,
					br = br,
					bl = bl,
					size = size,
					center = center,
				}
				local attachment_slot = unit_get_data(unit, "attachment_slot")
				-- mod:echot("hovered: "..tostring(attachment_slot))
			end
		end
		local focused_unit = nil
		local last = math.huge
		for _, hovered_unit in pairs(hovered_units) do
			local distance = vector3_distance(hovered_unit.center, cursor)
			if distance < last then
				last = distance
				focused_unit = hovered_unit
			end
		end
		if focused_unit then
			-- local attachment_slot = unit_get_data(focused_unit.unit, "attachment_slot")
			-- mod:echot("focused: "..tostring(attachment_slot))
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
		if package_synchronizer_client then package_synchronizer_client:reevaluate_all_profiles_packages() end
	end

	-- Save original attachment
	instance.save_original_attachment = function(self, attachment_slot)
		if not self.original_weapon_settings[attachment_slot] and not table_contains(mod.automatic_slots, attachment_slot) then
			if not mod.gear_settings:get(self._selected_item, attachment_slot) then
				self.original_weapon_settings[attachment_slot] = "default"
			else
				self.original_weapon_settings[attachment_slot] = mod.gear_settings:get(self._selected_item, attachment_slot)
			end
		end
	end

	-- Load new attachment
	instance.load_new_attachment = function(self, item, attachment_slot, attachment, no_update)
		if self._gear_id then
			-- Check if attachment and attachment slot are valid
			if attachment_slot and attachment then
				-- Save original attachment
				self:save_original_attachment(attachment_slot)
				-- Set attachment
				mod.gear_settings:set(self._selected_item, attachment_slot, attachment)
				-- -- Resolve special changes
				mod:resolve_special_changes(self._presentation_item, attachment)
				-- Resolve auto equips
				mod:resolve_auto_equips(self._presentation_item)
				-- Resolve no support
				mod:resolve_no_support(self._presentation_item)
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

	-- Get changed settings
	instance.get_changed_weapon_settings = function(self)
		if self._gear_id then
			self.changed_weapon_settings = {}
			local attachment_slots = mod:get_item_attachment_slots(self._selected_item)
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
		self.original_weapon_settings = {}
		-- Reset animation
		mod.reset_start = mod:main_time() --managers.time:time("main")
		-- Update equip button
		self:update_equip_button()
		-- Get changed settings
		self:get_changed_weapon_settings()
		-- Load new attachments
		self:load_new_attachment()
		-- Save gear settings
		mod.gear_settings:save(self._presentation_item)
		-- Reevaluate packages
		self:reevaluate_packages()
		-- Reload current weapon
		mod:redo_weapon_attachments(self._presentation_item)
		-- Update UI icons
		managers.ui:item_icon_updated(self._selected_item)
		managers.event:trigger("event_item_icon_updated", self._selected_item)
		managers.event:trigger("event_replace_list_item", self._selected_item)
	end

	-- Reset attachments to default
	instance.reset_attachments = function(self, no_animation)
		-- Get changed settings
		self:get_changed_weapon_settings()
		-- Auto equip
		self:resolve_auto_equips(self.changed_weapon_settings)
		-- -- Special
		self:resolve_special_changes(self.changed_weapon_settings)
		-- Check unsaved
		self:check_unsaved_changes(no_animation)
		-- Redo attachments
		mod:redo_weapon_attachments(self._presentation_item)
	end

	-- Get attachment names
	instance.get_attachment_names = function(self, attachment_settings)
		local attachment_names = {}
		-- Iterate through attachment settings
		for attachment_slot, value in pairs(attachment_settings) do
			-- Get attachment name
			attachment_names[attachment_slot] = mod.gear_settings:get(self._selected_item, attachment_slot)
		end
		-- Return attachment names
		return attachment_names
	end

	-- Resolve auto equips
	instance.resolve_auto_equips = function(self, attachment_settings, item_or_nil)
		-- Get item
		local item = item_or_nil or self._presentation_item
		-- Iterate through attachment settings
		for attachment_slot, value in pairs(attachment_settings) do
			-- Custom attachments
			if not mod.add_custom_attachments[attachment_slot] then
				mod:resolve_auto_equips(item, "default")
			end
		end
		-- Iterate through attachment settings
		for attachment_slot, value in pairs(attachment_settings) do
			-- Non-Custom attachments
			if mod.add_custom_attachments[attachment_slot] then
				mod:resolve_auto_equips(item, "default")
			end
		end
	end

	-- Resolve special changes
	instance.resolve_special_changes = function(self, attachment_settings, item_or_nil)
		-- Get item
		local item = item_or_nil or self._presentation_item
		-- Iterate through attachment settings
		for attachment_slot, value in pairs(attachment_settings) do
			-- Custom attachments
			if mod.add_custom_attachments[attachment_slot] then
				mod:resolve_special_changes(item, "default")
			end
		end
		-- Iterate through attachment settings
		for attachment_slot, value in pairs(attachment_settings) do
			-- Non-Custom attachments
			if not mod.add_custom_attachments[attachment_slot] then
				mod:resolve_special_changes(item, "default")
			end
		end
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
				mod.build_animation:animate(self._selected_item, attachment_slot, attachment_names[attachment_slot], value, nil, nil, true)
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
		if table_size(mod.start_weapon_settings) ~= table_size(self.changed_weapon_settings) then return true end
		-- Iterate through changed settings
		for attachment_slot, value in pairs(mod.start_weapon_settings) do
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
			local default = mod:get_actual_default_attachment(self._selected_item, attachment_slot)
			-- Check if default is different
			if default and value ~= default then return true end
		end
	end

	-- Remove player visible equipment
	instance.remove_player_visible_equipment = function(self)
		mod:remove_extension(mod.player_unit, "visible_equipment_system")
	end

	-- Update start settings
	instance.update_start_settings = function(self)
		mod.start_weapon_settings = table_clone(self.changed_weapon_settings)
	end

	instance.check_unsaved_changes = function(self, no_animation)
		if table_size(self.original_weapon_settings) > 0 then
			if self._gear_id then
				if no_animation then
					for attachment_slot, value in pairs(self.original_weapon_settings) do
						mod.gear_settings:set(self._selected_item, attachment_slot, value)
					end
				else
					local attachment_slots = mod:get_item_attachment_slots(self._selected_item)
					local original_weapon_settings = table_clone(self.original_weapon_settings)
					local attachment_names = {}
					table_reverse(original_weapon_settings)
					for attachment_slot, value in pairs(original_weapon_settings) do
						attachment_names[attachment_slot] = mod.gear_settings:get(self._selected_item, attachment_slot)
					end
	
					-- mod.build_animation.animations = {}
					mod.weapon_part_animation_update = true
					for attachment_slot, value in pairs(original_weapon_settings) do
						-- self:detach_attachment(self.cosmetics_view._selected_item, attachment_slot, attachment_names[attachment_slot], value)
						mod.build_animation:animate(self._selected_item, attachment_slot, attachment_names[attachment_slot], value)
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
					if not mod.add_custom_attachments[attachment_slot] then
						mod:resolve_auto_equips(self._presentation_item, "default")
					end
				end
				for attachment_slot, value in pairs(self.original_weapon_settings) do
					if mod.add_custom_attachments[attachment_slot] then
						mod:resolve_auto_equips(self._presentation_item, "default")
					end
				end
				-- Special
				for attachment_slot, value in pairs(self.original_weapon_settings) do
					if mod.add_custom_attachments[attachment_slot] then
						mod:resolve_special_changes(self._presentation_item, "default")
					end
				end
				for attachment_slot, value in pairs(self.original_weapon_settings) do
					if not mod.add_custom_attachments[attachment_slot] then
						mod:resolve_special_changes(self._presentation_item, "default")
					end
				end
				self.original_weapon_settings = {}
			end
			-- self:update_equip_button()
		end
	end

	-- ┌┬┐┌─┐┌┬┐┌─┐  ┌─┐┌─┐┌─┐┬─┐  ┌─┐┌─┐┌┬┐┌┬┐┬┌┐┌┌─┐┌─┐
	--  │ ├┤ │││├─┘  │ ┬├┤ ├─┤├┬┘  └─┐├┤  │  │ │││││ ┬└─┐
	--  ┴ └─┘┴ ┴┴    └─┘└─┘┴ ┴┴└─  └─┘└─┘ ┴  ┴ ┴┘└┘└─┘└─┘

	-- Create temp gear settings
	-- instance.create_temp_setting = function(self)
	-- 	mod:persistent_table(REFERENCE).temp_gear_settings[self._gear_id] = mod.gear_settings:pull(self._selected_item)
	-- end

	-- Destroy temp gear settings
	-- instance.destroy_temp_settings = function(self)
	-- 	mod:persistent_table(REFERENCE).temp_gear_settings[self._gear_id] = nil
	-- end

	-- ┌─┐┌┬┐┌┬┐┌─┐┌─┐┬ ┬┌┬┐┌─┐┌┐┌┌┬┐  ┌┬┐┬─┐┌─┐┌─┐┌┬┐┌─┐┬ ┬┌┐┌  ┬ ┬┬┌┬┐┌─┐┌─┐┌┬┐┌─┐
	-- ├─┤ │  │ ├─┤│  ├─┤│││├┤ │││ │    ││├┬┘│ │├─┘ │││ │││││││  ││││ │││ ┬├┤  │ └─┐
	-- ┴ ┴ ┴  ┴ ┴ ┴└─┘┴ ┴┴ ┴└─┘┘└┘ ┴   ─┴┘┴└─└─┘┴  ─┴┘└─┘└┴┘┘└┘  └┴┘┴─┴┘└─┘└─┘ ┴ └─┘

	-- Get dropdown positions
	instance.get_dropdown_positions = function(self)
		local cosmetics_scenegraphs = mod:get_cosmetics_scenegraphs()
		for _, scenegraph_name in pairs(cosmetics_scenegraphs) do
			if not string_find(scenegraph_name, "text_pivot") then
				local ui_scenegraph = self._ui_scenegraph
				local screen_width = RESOLUTION_LOOKUP.width
				local attachment_slot = string_gsub(scenegraph_name, "_pivot", "")
				local scenegraph_entry = ui_scenegraph[scenegraph_name]
				local entry = mod.dropdown_positions[attachment_slot] or {}

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
				mod.dropdown_positions[attachment_slot] = entry
			end
		end
	end

	-- ┬  ┬┬┌─┐┬ ┬  ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐
	-- └┐┌┘│├┤ │││  ├┤ │ │││││   │ ││ ││││└─┐
	--  └┘ ┴└─┘└┴┘  └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘

	-- Init custom
	instance.init_custom = function(self)
		self._custom_widgets = {}
		self._not_applicable = {}
		self._custom_widgets_overlapping = 0
		self._item_name = mod:item_name_from_content_string(self._selected_item.name)
		self._gear_id = mod.gear_settings:item_to_gear_id(self._presentation_item)
		self._slot_info_id = mod.gear_settings:slot_info_id(self._presentation_item)
		self.bar_breakdown_widgets = {}
		self.bar_breakdown_widgets_by_name = {}
		self.changed_weapon_settings = {}
		self.original_weapon_settings = {}
	end

	-- Custom enter
	instance.custom_enter = function(self)
		-- Switch off modding tool
		self._modding_tool_toggled_on = false
		-- Remove player visible equipment
		self:remove_player_visible_equipment()
		-- Generate custom widgets
		mod:generate_custom_widgets()
		-- Resolve attachments not applicable
		mod:resolve_not_applicable_attachments()
		-- Init custom weapon zoom
		mod:init_custom_weapon_zoom()
		-- Get changed settings
		self:get_changed_weapon_settings()
		-- Update start settings
		self:update_start_settings()
		-- Update reset button
		self:update_reset_button()
		-- Hide custom widgets
		mod:hide_custom_widgets(true)
		-- Resolve no support
		mod:resolve_no_support(self._selected_item)
		-- Load attachment sounds
		mod:load_attachment_sounds(self._selected_item)
		-- Create bar breakdown widgets
		mod:create_bar_breakdown_widgets()
		-- Auto equip
		self:resolve_auto_equips(self.changed_weapon_settings, self._selected_item)
		-- Special
		self:resolve_special_changes(self.changed_weapon_settings, self._selected_item)
		-- Hide UI widgets
		self._item_grid._widgets_by_name.grid_divider_top.visible = false
		self._item_grid._widgets_by_name.grid_divider_bottom.visible = false
		self._item_grid._widgets_by_name.grid_background.visible = false
		-- Set scrollbar progress
		self:set_scrollbar_progress(0)
		-- Register events
		managers.event:register(self, "weapon_customization_hide_ui", "hide_ui")
		-- Get changed settings
		self:get_changed_weapon_settings()
		-- Update start settings
		self:update_start_settings()
	end

	-- Custom exit
	instance.custom_exit = function(self)
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

	-- Register custom button callbacks
	instance.register_custom_button_callbacks = function(self)
		-- Reset button
		self._widgets_by_name.reset_button.content.hotspot.pressed_callback = callback(self, "cb_on_reset_pressed")
		-- Randomize button
		self._widgets_by_name.randomize_button.content.hotspot.pressed_callback = callback(self, "cb_on_randomize_pressed")
	end

	-- Update equip button
	instance.update_equip_button = function(self)
		if self:is_tab() then
			-- Get button widget
			local button = self._widgets_by_name.equip_button
			-- Get button content
			local button_content = button and button.content
			-- Get disabled state
			local disabled = not self:attachments_changed_since_start() or mod.build_animation:is_busy()
			-- Set disabled
			button_content.hotspot.disabled = disabled
			-- Update text
			button_content.text = utf8_upper(disabled and mod:localize("loc_weapon_inventory_equipped_button") or mod:localize("loc_weapon_inventory_equip_button"))
		end
	end
	
	-- Update reset button
	instance.update_reset_button = function(self)
		-- Get button widget
		local button = self._widgets_by_name.reset_button
		-- Get button content
		local button_content = button and button.content
		-- Get disabled state
		local disabled = not self:attachments_changed_at_all() or mod.build_animation:is_busy()
		-- Set disabled
		button_content.hotspot.disabled = disabled
		-- Update text
		button_content.text = utf8_upper(disabled and mod:localize("loc_weapon_inventory_no_reset_button") or mod:localize("loc_weapon_inventory_reset_button"))
	end

	-- Reset button pressed callback
	instance.cb_on_reset_pressed = function(self, skip_animation)
		-- Check visibility
		if self._visibility_toggled_on and self._gear_id and self.changed_weapon_settings and table_size(self.changed_weapon_settings) > 0 then
			-- Skip animation?
			local skip_animation = skip_animation or not mod:get(MOD_OPTION_BUILD_ANIMATION)
			-- Clone changed settings
			local changed_weapon_settings = table_clone(self.changed_weapon_settings)
			for attachment_slot, value in pairs(changed_weapon_settings) do
				changed_weapon_settings[attachment_slot] = "default"
			end
			-- Attach default attachments
			self:attach_attachments(changed_weapon_settings, skip_animation)
			-- Auto equip
			self:resolve_auto_equips(changed_weapon_settings)
			-- Special
			self:resolve_special_changes(changed_weapon_settings)
			-- Reset animation
			mod:start_weapon_move()
			mod.new_rotation = 0
			mod.do_rotation = true
		end
	end

	-- Update randomize button
	instance.update_randomize_button = function(self)
		-- Get button widget
		local button = self._widgets_by_name.randomize_button
		-- Get button content
		local button_content = button and button.content
		-- Get disabled state
		local disabled = mod.build_animation:is_busy()
		-- Set disabled
		button_content.hotspot.disabled = disabled
	end

	-- Randomize button pressed callback
	instance.cb_on_randomize_pressed = function(self, skip_animation)
		-- Get random attachments
		local random_attachments = mod:randomize_weapon(self._selected_item)
		-- Check visibility
		if self._visibility_toggled_on and self._gear_id and random_attachments and table_size(random_attachments) > 0 then
			-- Skip animation?
			local skip_animation = skip_animation or not mod:get(MOD_OPTION_BUILD_ANIMATION)
			-- Attach random attachments
			self:attach_attachments(random_attachments, skip_animation)
			-- Auto equip
			self:resolve_auto_equips(random_attachments)
			-- Special
			self:resolve_special_changes(random_attachments)
			-- Get changed settings
			self:get_changed_weapon_settings()
		end
	end

	-- Custom switch tab
	instance.custom_switch_tab = function(self, index)
		if self:is_tab(index) then
			self:present_grid_layout({})
			self._item_grid._widgets_by_name.grid_empty.visible = false
			mod:hide_custom_widgets(false)
			self.original_weapon_settings = {}
			self:get_changed_weapon_settings()
			-- self:update_equip_button()
			-- self:update_reset_button()

			-- Auto equip
			for attachment_slot, value in pairs(self.changed_weapon_settings) do
				if not mod.add_custom_attachments[attachment_slot] then
					mod:resolve_auto_equips(self._selected_item, "default")
				end
			end
			for attachment_slot, value in pairs(self.changed_weapon_settings) do
				if mod.add_custom_attachments[attachment_slot] then
					mod:resolve_auto_equips(self._selected_item, "default")
				end
			end
			-- Special
			for attachment_slot, value in pairs(self.changed_weapon_settings) do
				if mod.add_custom_attachments[attachment_slot] then
					mod:resolve_special_changes(self._selected_item, "default")
				end
			end
			for attachment_slot, value in pairs(self.changed_weapon_settings) do
				if not mod.add_custom_attachments[attachment_slot] then
					mod:resolve_special_changes(self._selected_item, "default")
				end
			end
		else
			local t = managers.time:time("main")
			mod.reset_start = t
			self:check_unsaved_changes(true)
			mod:hide_custom_widgets(true)
		end
	end

	-- Custom update
	instance.custom_update = function(self, input_service, dt, t)
		-- Set ui weapon spawner rotation input
		local ui_weapon_spawner = self:ui_weapon_spawner()
		ui_weapon_spawner._rotation_input_disabled = self:is_busy()
		-- Update custom widgets
		mod:update_custom_widgets(input_service, dt, t)
		-- Update attachment info
		mod:update_attachment_info()
		-- Update buttons
		self:update_equip_button()
		self:update_reset_button()
		self:update_randomize_button()
	end

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

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_register_button_callbacks", function(func, self, ...)

	-- Original function
	func(self, ...)
	
	-- Register custom button callbacks
	self:register_custom_button_callbacks()

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

end)