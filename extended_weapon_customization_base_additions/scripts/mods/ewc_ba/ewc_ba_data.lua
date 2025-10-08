local mod = get_mod("extended_weapon_customization_base_additions")

return {
	name = mod:localize("mod_title"),
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = {
			{["setting_id"] = "group_misc",
  				["type"] = "group",
				["sub_widgets"] = {
					{["setting_id"] = "mod_option_laser_blade_randomization",
						["type"] = "checkbox",
						["default_value"] = true,
						["tooltip"] = "mod_option_laser_blade_randomization_tooltip",
					},
					{["setting_id"] = "mod_option_laser_pointer_randomization",
						["type"] = "checkbox",
						["default_value"] = true,
						["tooltip"] = "mod_option_laser_pointer_randomization_tooltip",
					},
				},
			},
		},
	},
}
