local mod = get_mod("scoreboard")

local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")
local UIFontSettings = mod:original_require("scripts/managers/ui/ui_font_settings")
local OptionsViewSettings = mod:original_require("scripts/ui/views/options_view/options_view_settings")
local ButtonPassTemplates = mod:original_require("scripts/ui/pass_templates/button_pass_templates")

local grid_size = OptionsViewSettings.grid_size
local grid_width = grid_size[1]
local settings_grid_width = 1000
local settings_value_width = 500
local settings_value_height = 75

local list_button_hotspot_default_style = {
	anim_hover_speed = 8,
	anim_input_speed = 8,
	anim_select_speed = 8,
	anim_focus_speed = 8,
	on_hover_sound = UISoundEvents.default_mouse_hover,
	on_pressed_sound = UISoundEvents.default_click
}
local list_button_icon_size = {
	50,
	50
}
local list_button_with_icon_text_style = table.clone(UIFontSettings.list_button)
list_button_with_icon_text_style.offset[1] = 10
list_button_with_icon_text_style.offset[2] = -10
list_button_with_icon_text_style.font_size = 20
local list_button_with_icon_icon_style = {
	vertical_alignment = "center",
	color = list_button_with_icon_text_style.text_color,
	default_color = list_button_with_icon_text_style.default_text_color,
	disabled_color = list_button_with_icon_text_style.disabled_color,
	hover_color = list_button_with_icon_text_style.hover_color,
	size = list_button_icon_size,
	offset = {9, 0, 3},
}
local list_button_with_icon_text_style2 = table.clone(UIFontSettings.list_button_second_row)
list_button_with_icon_text_style2.offset[1] = 10
list_button_with_icon_text_style2.offset[2] = 22
local blueprints = {
	settings_button = {
		size = {
			grid_width,
			settings_value_height
		},
		pass_template = {
			{
				style_id = "hotspot",
				pass_type = "hotspot",
				content_id = "hotspot",
				content = {
					use_is_focused = true,
				},
				style = list_button_hotspot_default_style
			},
			{
				pass_type = "texture",
				style_id = "background_selected",
				value = "content/ui/materials/buttons/background_selected",
				style = {
					color = Color.ui_terminal(0, true),
					offset = {0, 0, 0}
				},
				change_function = function (content, style)
					style.color[1] = 255 * content.hotspot.anim_select_progress
				end,
				visibility_function = ButtonPassTemplates.list_button_focused_visibility_function
			},
			{
				pass_type = "texture",
				style_id = "highlight",
				value = "content/ui/materials/frames/hover",
				style = {
					hdr = true,
					scale_to_material = true,
					color = Color.ui_terminal(255, true),
					offset = {0, 0, 3},
					size_addition = {0, 0}
				},
				change_function = ButtonPassTemplates.list_button_highlight_change_function,
				visibility_function = ButtonPassTemplates.list_button_focused_visibility_function
			},
			{
				pass_type = "texture",
				value_id = "icon",
				style_id = "icon",
				style = table.clone(list_button_with_icon_icon_style),
				change_function = ButtonPassTemplates.list_button_label_change_function,
				visibility_function = function (content, style)
					return not not content.icon
				end
			},
			{
				pass_type = "text",
				style_id = "text",
				value_id = "text",
				style = table.clone(list_button_with_icon_text_style),
				change_function = ButtonPassTemplates.list_button_label_change_function
			},
			{
				pass_type = "text",
				style_id = "text2",
				value_id = "text2",
				style = table.clone(list_button_with_icon_text_style2),
				change_function = ButtonPassTemplates.list_button_label_change_function
			}
		},
		init = function (parent, widget, entry, callback_name)
			local content = widget.content
			local hotspot = content.hotspot

			hotspot.pressed_callback = function ()
				local is_disabled = entry.disabled or false

				if is_disabled then
					return
				end

				callback(parent, callback_name, widget, entry)()
			end

			local display_name = entry.display_name
			local display_name2 = entry.display_name2
			content.text = Managers.localization:localize(display_name)
			content.text2 = Managers.localization:localize(display_name2)
			mod:shrink_text(content.text, widget.style.text, settings_value_width, parent._ui_renderer)
			mod:shrink_text(content.text2, widget.style.text2, settings_value_width, parent._ui_renderer)

			content.icon = entry.icon
			content.entry = entry
		end
	},
}

return settings("OptionsViewContentBlueprints", blueprints)