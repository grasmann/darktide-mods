local mod = get_mod("servo_friend_tag_cannon")

return {
	name = "servo_friend_tag_cannon",
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = {
			{["setting_id"] = "mod_option_use_cannon",
				["type"] = "checkbox",
				["default_value"] = true,
				["tooltip"] = "mod_option_use_cannon_tooltip",
			},
			{["setting_id"] = "test_index",
				["type"] = "keybind",
				["default_value"] = {},
				["keybind_trigger"] = "pressed",
				["keybind_type"] = "function_call",
				["function_name"] = "inc_test_index",
			},
		},
	},
}
