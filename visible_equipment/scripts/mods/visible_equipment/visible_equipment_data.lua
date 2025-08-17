local mod = get_mod("visible_equipment")

return {
	name = "visible_equipment",
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = {
			{["setting_id"] = "mod_option_sounds_self",
				["type"] = "dropdown",
				["default_value"] = "on",
				["tooltip"] = "mod_option_sounds_self_tooltip",
				["options"] = {
					{text = "mod_option_sounds_self_on", value = "on"},
					{text = "mod_option_sounds_self_third_person", value = "third_person"},
					{text = "mod_option_sounds_self_first_person", value = "first_person"},
					{text = "mod_option_sounds_self_off", value = "off"},
				},
			},
			{["setting_id"] = "mod_option_sounds_others",
				["type"] = "dropdown",
				["default_value"] = "on",
				["tooltip"] = "mod_option_sounds_others_tooltip",
				["options"] = {
					{text = "mod_option_sounds_others_on", value = "on"},
					{text = "mod_option_sounds_others_off", value = "off"},
				},
			},
			{["setting_id"] = "mod_option_animations",
				["type"] = "checkbox",
				["default_value"] = true,
				["tooltip"] = "mod_option_animations_tooltip",
			},
			{["setting_id"] = "mod_option_random_placements",
				["type"] = "checkbox",
				["default_value"] = true,
				["tooltip"] = "mod_option_random_placements_tooltip",
			},
		},
	}
}
