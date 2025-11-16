local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local CheckboxPassTemplates = mod:original_require("scripts/ui/pass_templates/checkbox_pass_templates")
local DefaultPassTemplates = mod:original_require("scripts/ui/pass_templates/default_pass_templates")
local ButtonPassTemplates = mod:original_require("scripts/ui/pass_templates/button_pass_templates")
local DropdownTemplates = mod:original_require("scripts/ui/pass_templates/dropdown_pass_templates")
local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")
local UIFontSettings = mod:original_require("scripts/managers/ui/ui_font_settings")
local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
	local utf8 = Utf8
	local table = table
	local color = Color
	local localize = Localize
	local utf8_upper = utf8.upper
	local color_white = color.white
	local table_clone = table.clone
	local color_terminal_grid_background = color.terminal_grid_background
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local WEAPON_OPTIONS_VIEW = "inventory_weapons_view_weapon_options"
local equip_button_size = {374, 76}
local default_button_size = {200, 38}
local color_size = {350, 38}
local pattern_size = {350, 38}
local wear_size = {300, 38}
local tip_size = {600, 400}
local button_size = {30, 30}

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view_definitions", function(instance)

	instance.scenegraph_definition.reset_button = {
		horizontal_alignment = "right",
		parent = "info_box",
		vertical_alignment = "bottom",
		size = equip_button_size,
		position = {-100, -equip_button_size[2] - 10, 1},
	}
	instance.scenegraph_definition.random_button = {
		horizontal_alignment = "right",
		parent = "info_box",
		vertical_alignment = "bottom",
		size = equip_button_size,
		position = {-100, -equip_button_size[2] * 2 - 10, 1},
	}

	instance.scenegraph_definition.alternate_fire_toggle = {
		horizontal_alignment = "right",
		parent = "weapon_preview",
		vertical_alignment = "top",
		size = default_button_size,
		position = {-100, -default_button_size[2], 1},
	}
	instance.scenegraph_definition.crosshair_toggle = {
		horizontal_alignment = "right",
		parent = "weapon_preview",
		vertical_alignment = "top",
		size = default_button_size,
		position = {-120 - default_button_size[1], -default_button_size[2], 1},
	}
	instance.scenegraph_definition.damage_type_toggle = {
		horizontal_alignment = "right",
		parent = "weapon_preview",
		vertical_alignment = "top",
		size = default_button_size,
		position = {-140 - default_button_size[1] * 2, -default_button_size[2], 1},
	}

	instance.scenegraph_definition.color_text = {
		horizontal_alignment = "right",
		parent = "weapon_preview",
		vertical_alignment = "top",
		size = color_size,
		position = {-90, 12, 1},
	}
	instance.scenegraph_definition.pattern_text = {
		horizontal_alignment = "right",
		parent = "weapon_preview",
		vertical_alignment = "top",
		size = pattern_size,
		position = {-110 - color_size[1], 12, 1},
	}
	instance.scenegraph_definition.wear_text = {
		horizontal_alignment = "right",
		parent = "weapon_preview",
		vertical_alignment = "top",
		size = wear_size,
		position = {-130 - color_size[1] - pattern_size[1], 12, 1},
	}

	instance.scenegraph_definition.color_button = {
		horizontal_alignment = "right",
		parent = "weapon_preview",
		vertical_alignment = "top",
		size = button_size,
		position = {-100, 6, 1},
	}
	instance.scenegraph_definition.pattern_button = {
		horizontal_alignment = "right",
		parent = "weapon_preview",
		vertical_alignment = "top",
		size = button_size,
		position = {-120 - color_size[1], 6, 1},
	}
	instance.scenegraph_definition.wear_button = {
		horizontal_alignment = "right",
		parent = "weapon_preview",
		vertical_alignment = "top",
		size = button_size,
		position = {-140 - color_size[1] - pattern_size[1], 6, 1},
	}

	instance.scenegraph_definition.color_dropdown = {
		horizontal_alignment = "right",
		parent = "weapon_preview",
		vertical_alignment = "top",
		size = color_size,
		position = {-100, 40, 1},
	}
	instance.scenegraph_definition.pattern_dropdown = {
		horizontal_alignment = "right",
		parent = "weapon_preview",
		vertical_alignment = "top",
		size = pattern_size,
		position = {-120 - color_size[1], 40, 1},
	}
	instance.scenegraph_definition.wear_dropdown = {
		horizontal_alignment = "right",
		parent = "weapon_preview",
		vertical_alignment = "top",
		size = wear_size,
		position = {-140 - color_size[1] - pattern_size[1], 40, 1},
	}

	instance.scenegraph_definition.tip_1 = {
		horizontal_alignment = "center",
		parent = "canvas",
		vertical_alignment = "center",
		size = tip_size,
		position = {200, 0, 1},
	}

	instance.scenegraph_definition.tip_1_button = {
		horizontal_alignment = "center",
		parent = "tip_1",
		vertical_alignment = "bottom",
		size = default_button_size,
		position = {0, -30, 1},
	}



	instance.widget_definitions.reset_button = UIWidget.create_definition(table_clone(ButtonPassTemplates.default_button), "reset_button", {
		gamepad_action = "secondary_action_pressed",
		original_text = utf8_upper(localize("loc_weapon_inventory_reset_button")),
		hotspot = {
			on_pressed_sound = UISoundEvents.weapons_skin_confirm,
		},
	})

	instance.widget_definitions.random_button = UIWidget.create_definition(table_clone(ButtonPassTemplates.default_button), "random_button", {
		gamepad_action = "secondary_action_pressed",
		original_text = utf8_upper(localize("loc_weapon_inventory_random_button")),
		hotspot = {
			on_pressed_sound = UISoundEvents.weapons_skin_confirm,
		},
	})

	instance.widget_definitions.alternate_fire_toggle = UIWidget.create_definition(table_clone(ButtonPassTemplates.terminal_button_small), "alternate_fire_toggle", {
		gamepad_action = "secondary_action_pressed",
		text = utf8_upper(localize("loc_weapon_inventory_alternate_fire_toggle")),
		hotspot = {
			on_pressed_sound = UISoundEvents.system_popup_enter,
		},
	})

	instance.widget_definitions.crosshair_toggle = UIWidget.create_definition(table_clone(ButtonPassTemplates.terminal_button_small), "crosshair_toggle", {
		gamepad_action = "secondary_action_pressed",
		text = utf8_upper(localize("loc_weapon_inventory_crosshair_toggle")),
		hotspot = {
			on_pressed_sound = UISoundEvents.system_popup_enter,
		},
	})

	instance.widget_definitions.damage_type_toggle = UIWidget.create_definition(table_clone(ButtonPassTemplates.terminal_button_small), "damage_type_toggle", {
		gamepad_action = "secondary_action_pressed",
		text = utf8_upper(localize("loc_weapon_inventory_damage_type_toggle")),
		hotspot = {
			on_pressed_sound = UISoundEvents.system_popup_enter,
		},
	})


	local terminal_button_small = table_clone(ButtonPassTemplates.terminal_button_small)
	terminal_button_small.size = button_size

	instance.widget_definitions.color_button = UIWidget.create_definition(terminal_button_small, "color_button", {
		gamepad_action = "secondary_action_pressed",
		text = utf8_upper(localize("loc_weapon_inventory_color_button")),
		hotspot = {
			on_pressed_sound = UISoundEvents.system_popup_enter,
		},
	})

	instance.widget_definitions.pattern_button = UIWidget.create_definition(terminal_button_small, "pattern_button", {
		gamepad_action = "secondary_action_pressed",
		text = utf8_upper(localize("loc_weapon_inventory_pattern_button")),
		hotspot = {
			on_pressed_sound = UISoundEvents.system_popup_enter,
		},
	})

	instance.widget_definitions.wear_button = UIWidget.create_definition(terminal_button_small, "wear_button", {
		gamepad_action = "secondary_action_pressed",
		text = utf8_upper(localize("loc_weapon_inventory_wear_button")),
		hotspot = {
			on_pressed_sound = UISoundEvents.system_popup_enter,
		},
	})


	instance.widget_definitions.color_text = UIWidget.create_definition(table_clone(DefaultPassTemplates.body_text), "color_text", {
		gamepad_action = "secondary_action_pressed",
		text = utf8_upper(localize("loc_weapon_inventory_color_text")),
		hotspot = {
			on_pressed_sound = UISoundEvents.system_popup_enter,
		},
	})

	instance.widget_definitions.pattern_text = UIWidget.create_definition(table_clone(DefaultPassTemplates.body_text), "pattern_text", {
		gamepad_action = "secondary_action_pressed",
		text = utf8_upper(localize("loc_weapon_inventory_pattern_text")),
		hotspot = {
			on_pressed_sound = UISoundEvents.system_popup_enter,
		},
	})

	instance.widget_definitions.wear_text = UIWidget.create_definition(table_clone(DefaultPassTemplates.body_text), "wear_text", {
		gamepad_action = "secondary_action_pressed",
		text = utf8_upper(localize("loc_weapon_inventory_wear_text")),
		hotspot = {
			on_pressed_sound = UISoundEvents.system_popup_enter,
		},
	})

	local simple_button_font_setting_name = "button_medium"
	local simple_button_font_settings = UIFontSettings[simple_button_font_setting_name]
	local simple_button_font_color = simple_button_font_settings.text_color

	local tip_template = {
		{
			pass_type = "texture",
			style_id = "background",
			value = "content/ui/materials/backgrounds/terminal_basic",
			style = {
				horizontal_alignment = "center",
				scale_to_material = true,
				vertical_alignment = "center",
				color = Color.terminal_grid_background(255, true),
				offset = {0, -8, 0},
			},
		},
		{
			pass_type = "text",
			style_id = "title",
			value_id = "title",
			style = {
				drop_shadow = true,
				font_size = 34,
				font_type = "proxima_nova_bold",
				horizontal_alignment = "left",
				scale_to_material = true,
				vertical_alignment = "top",
				default_color = Color.terminal_text_header(255, true),
				text_color = Color.terminal_text_header(255, true),
				hover_color = Color.white(255, true),
				disabled_color = Color.ui_grey_light(255, true),
				offset = {25, 10, 2},
				size_addition = {-40, 0},
			},
		},
		{
			pass_type = "text",
			style_id = "text",
			value_id = "text",
			style = {
				drop_shadow = true,
				font_size = 24,
				font_type = "proxima_nova_bold",
				horizontal_alignment = "left",
				scale_to_material = true,
				vertical_alignment = "top",
				text_color = Color.text_default(255, true),
				offset = {25, 60, 2},
				size_addition = {-40, 0},
			},
		},
	}

	instance.widget_definitions.tip_1 = UIWidget.create_definition(tip_template, "tip_1", {
		-- gamepad_action = "secondary_action_pressed",
		text = utf8_upper(localize("loc_weapon_inventory_tip_1")),
		hotspot = {
			on_pressed_sound = UISoundEvents.system_popup_enter,
		},
	})

	instance.widget_definitions.tip_1_button = UIWidget.create_definition(table_clone(ButtonPassTemplates.terminal_button_small), "tip_1_button", {
		-- gamepad_action = "secondary_action_pressed",
		text = utf8_upper(localize("loc_weapon_inventory_tip_1_button")),
		hotspot = {
			on_pressed_sound = UISoundEvents.system_popup_enter,
		},
	})

end)
