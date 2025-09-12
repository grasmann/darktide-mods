local mod = get_mod("extended_weapon_customization")

local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
	local color = Color
	local color_white = color.white
	local color_terminal_grid_background = color.terminal_grid_background
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local WEAPON_OPTIONS_VIEW = "inventory_weapons_view_weapon_options"

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view_definitions", function(instance)

    instance.scenegraph_definition.item_grid_pivot.position[1] = 320
    instance.scenegraph_definition.button_pivot.position[1] = -290
    instance.scenegraph_definition.button_pivot_background.position[1] = 75
    instance.scenegraph_definition.info_box.position[1] = 0
    instance.scenegraph_definition.equip_button.position[1] = -100

    instance.widget_definitions.button_pivot_background = UIWidget.create_definition({
		{
			pass_type = "texture",
			style_id = "background",
			value = "content/ui/materials/backgrounds/terminal_basic",
			value_id = "background",
			style = {
				horizontal_alignment = "center",
				scale_to_material = true,
				vertical_alignment = "center",
				color = color_terminal_grid_background(255, true),
				size_addition = {170, 20},
				offset = {0, 0, 0},
			},
		},
		{
			pass_type = "texture",
			value = "content/ui/materials/frames/tab_frame_upper",
			style = {
				horizontal_alignment = "center",
				vertical_alignment = "top",
				color = color_white(255, true),
				size = {300, 14},
				offset = {0, -5, 1},
			},
		},
		{
			pass_type = "texture",
			value = "content/ui/materials/frames/tab_frame_lower",
			style = {
				horizontal_alignment = "center",
				vertical_alignment = "bottom",
				color = color_white(255, true),
				size = {299, 14},
				offset = {0, 5, 1},
			},
		},
	}, "button_pivot_background")

end)
