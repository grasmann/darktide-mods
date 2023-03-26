local mod = get_mod("scoreboard")

local OptionsViewSettings = mod:original_require("scripts/ui/views/options_view/options_view_settings")
local ButtonPassTemplates = mod:original_require("scripts/ui/pass_templates/button_pass_templates")

local grid_size = OptionsViewSettings.grid_size
local grid_width = grid_size[1]
local settings_grid_width = 1000
local settings_value_width = 500
local settings_value_height = 64

local blueprints = {
	settings_button = {
		size = {
			grid_width,
			settings_value_height
		},
		pass_template = ButtonPassTemplates.list_button_with_icon,
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
			content.text = Managers.localization:localize(display_name)
			content.icon = entry.icon
			content.entry = entry
		end
	},
}

return settings("OptionsViewContentBlueprints", blueprints)