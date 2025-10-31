local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local ButtonPassTemplates = mod:original_require("scripts/ui/pass_templates/button_pass_templates")
local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")
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
local default_button_size = {374, 38}

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

end)
