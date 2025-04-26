local mod = get_mod("servo_friend_example_addon")

return {
	name = mod:localize("mod_title"),
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = {
			{["setting_id"] = "mod_option_show_hat",
				["type"] = "checkbox",
				["default_value"] = true,
				["tooltip"] = "mod_option_show_hat_tooltip",
			},
		}
	}
}
