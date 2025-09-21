local mod = get_mod("extended_weapon_customization")

return {
	name = mod:localize("mod_title"),
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = {

			{["setting_id"] = "mod_option_sway",
				["type"] = "checkbox",
				["default_value"] = false,
				["tooltip"] = "mod_option_sway_tooltip",
			},

			{["setting_id"] = "clear_chat",
				["type"] = "keybind",
				["default_value"] = {},
				["keybind_trigger"] = "pressed",
				["keybind_type"] = "function_call",
				["function_name"] = "clear_chat",
			},
			{["setting_id"] = "debug_mode",
				["type"] = "checkbox",
				["default_value"] = false,
				["tooltip"] = "debug_mode_tooltip",
			},
		},
	},
}
