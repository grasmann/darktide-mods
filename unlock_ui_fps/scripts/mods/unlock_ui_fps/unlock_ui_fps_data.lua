local mod = get_mod("unlock_ui_fps")

return {
	name = mod:localize("mod_title"),
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = {
			{["setting_id"] = "mod_option_ui_fps_target",
				["type"] = "dropdown",
				["default_value"] = "0",
				["tooltip"] = "mod_option_ui_fps_target_tooltip",
				["options"] = {
					{text = "mod_option_sounds_self_0", value = "0"},
					{text = "mod_option_sounds_self_60", value = "60"},
					{text = "mod_option_sounds_self_75", value = "75"},
					{text = "mod_option_sounds_self_90", value = "90"},
					{text = "mod_option_sounds_self_120", value = "120"},
					{text = "mod_option_sounds_self_144", value = "144"},
					{text = "mod_option_sounds_self_144", value = "180"},
					{text = "mod_option_sounds_self_165", value = "165"},
					{text = "mod_option_sounds_self_240", value = "240"},
				},
			},
		},
	},
}
