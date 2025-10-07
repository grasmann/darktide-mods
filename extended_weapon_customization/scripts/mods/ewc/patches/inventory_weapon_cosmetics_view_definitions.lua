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

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view_definitions", function(instance)

	-- instance.scenegraph_definition.item_grid_pivot.position[1] = 320
	-- instance.scenegraph_definition.button_pivot.position[1] = -270
	-- instance.scenegraph_definition.button_pivot_background.position[1] = 55
	-- instance.scenegraph_definition.info_box.position[1] = 0
	-- instance.scenegraph_definition.equip_button.position[1] = -100

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

	-- instance.widget_definitions.button_pivot_background = UIWidget.create_definition({
	-- 	{
	-- 		pass_type = "texture",
	-- 		style_id = "background",
	-- 		value = "content/ui/materials/backgrounds/terminal_basic",
	-- 		value_id = "background",
	-- 		style = {
	-- 			horizontal_alignment = "center",
	-- 			scale_to_material = true,
	-- 			vertical_alignment = "center",
	-- 			color = color_terminal_grid_background(255, true),
	-- 			size_addition = {170, 20},
	-- 			offset = {0, 0, 0},
	-- 		},
	-- 	},
	-- 	{
	-- 		pass_type = "texture",
	-- 		value = "content/ui/materials/frames/tab_frame_upper",
	-- 		style = {
	-- 			horizontal_alignment = "center",
	-- 			vertical_alignment = "top",
	-- 			color = color_white(255, true),
	-- 			size = {300, 14},
	-- 			offset = {0, -5, 1},
	-- 		},
	-- 	},
	-- 	{
	-- 		pass_type = "texture",
	-- 		value = "content/ui/materials/frames/tab_frame_lower",
	-- 		style = {
	-- 			horizontal_alignment = "center",
	-- 			vertical_alignment = "bottom",
	-- 			color = color_white(255, true),
	-- 			size = {299, 14},
	-- 			offset = {0, 5, 1},
	-- 		},
	-- 	},
	-- }, "button_pivot_background")

end)
