local mod = get_mod("ewc_example_plugin")

return {
	name = mod:localize("mod_title"),
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = {
			{["setting_id"] = "group_misc",
  				["type"] = "group",
				["sub_widgets"] = {
					{["setting_id"] = "mod_option_blue_flashlight_randomization",
						["type"] = "checkbox",
						["default_value"] = true,
						["tooltip"] = "mod_option_blue_flashlight_randomization_tooltip",
					},
				},
			},
		},
	},
}
