local mod = get_mod("scoreboard_example_plugin")

return {
	name = mod:localize("mod_title"),
	description = mod:localize("mod_description"),
	is_togglable = false,
	options = {
		widgets = {
			{["setting_id"] = "show_row",
				["type"] = "checkbox",
				["default_value"] = true,
			},
		},
	},
}
