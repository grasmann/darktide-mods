local mod = get_mod("extended_weapon_customization")

return {
	name = "extended_weapon_customization",
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = {
			{["setting_id"] = "clear_chat",
				["type"] = "keybind",
				["default_value"] = {},
				["keybind_trigger"] = "pressed",
				["keybind_type"] = "function_call",
				["function_name"] = "clear_chat",
			},
		},
	},
}
