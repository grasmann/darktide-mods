local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local HudElementBatterySettings = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/hud/hud_element_battery_settings")
local UIWorkspaceSettings = mod:original_require("scripts/settings/ui/ui_workspace_settings")
local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
local UIHudSettings = mod:original_require("scripts/settings/ui/ui_hud_settings")
local UIFontSettings = mod:original_require("scripts/managers/ui/ui_font_settings")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local bar_size = HudElementBatterySettings.bar_size
local area_size = HudElementBatterySettings.area_size
local glow_size = HudElementBatterySettings.glow_size
local center_offset = HudElementBatterySettings.center_offset
local position = HudElementBatterySettings.position
local scenegraph_definition = {
	screen = UIWorkspaceSettings.screen,
	area = {
		vertical_alignment = "center",
		parent = "screen",
		horizontal_alignment = "right",
		size = area_size,
		position = {-55, 0, 0}
	},
	gauge = {
		vertical_alignment = "top",
		parent = "area",
		horizontal_alignment = "center",
		size = {212, 10},
		position = {0, 6, 1}
	},
	charge = {
		vertical_alignment = "top",
		parent = "area",
		horizontal_alignment = "center",
		size = bar_size,
		position = {0, 0, 1}
	}
}
local value_text_style = table.clone(UIFontSettings.body_small)
value_text_style.offset = {0, 10, 3}
value_text_style.size = {500, 30}
value_text_style.vertical_alignment = "top"
value_text_style.horizontal_alignment = "left"
value_text_style.text_horizontal_alignment = "left"
value_text_style.text_vertical_alignment = "top"
value_text_style.text_color = UIHudSettings.color_tint_main_1
local name_text_style = table.clone(value_text_style)
name_text_style.offset = {0, 10, 3}
name_text_style.horizontal_alignment = "right"
name_text_style.text_horizontal_alignment = "right"
name_text_style.text_color = UIHudSettings.color_tint_main_2
name_text_style.drop_shadow = false
local widget_definitions = {
	gauge = UIWidget.create_definition({
		{
			value_id = "value_text",
			style_id = "value_text",
			pass_type = "text",
			value = "100%",
			style = value_text_style
		},
		{
			value_id = "name_text",
			style_id = "name_text",
			pass_type = "text",
			value = Utf8.upper(mod:localize("mod_hud_display_name_battery")),
			style = name_text_style
		},
		{
			value = "content/ui/materials/hud/stamina_gauge",
			style_id = "warning",
			pass_type = "texture",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "center",
				offset = {0, 0, 1},
				color = UIHudSettings.color_tint_main_2
			}
		}
	}, "gauge")
}
local charge = UIWidget.create_definition({
	{
		value = "content/ui/materials/hud/stamina_full",
		style_id = "full",
		pass_type = "rect",
		style = {
			offset = {0, 0, 3},
			color = UIHudSettings.color_tint_main_1
		}
	}
}, "charge")

-- ##### ┬─┐┌─┐┌┬┐┬ ┬┬─┐┌┐┌ ###########################################################################################
-- ##### ├┬┘├┤  │ │ │├┬┘│││ ###########################################################################################
-- ##### ┴└─└─┘ ┴ └─┘┴└─┘└┘ ###########################################################################################

return {
	charge_definition = charge,
	widget_definitions = widget_definitions,
	scenegraph_definition = scenegraph_definition
}
