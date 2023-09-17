local mod = get_mod("weapon_customization")

return {
	name = mod:localize("mod_title"),
	description = mod:localize("mod_description"),
	is_togglable = false,
	options = {
		widgets = {
			{["setting_id"] = "mod_option_weapon_build_animation",
				["type"] = "checkbox",
				["default_value"] = true,
				["sub_widgets"] = {
					{["setting_id"] = "mod_option_weapon_build_animation_speed",
						["type"] = "numeric",
						["default_value"] = 1,
						["range"] = {1, 2},
						["unit_text"] = "mod_option_weapon_build_animation_speed_unit",
						["decimals_number"] = 2
					},
					{["setting_id"] = "mod_option_weapon_build_animation_wobble",
						["type"] = "checkbox",
						["default_value"] = true,
					},
				},
			},
			{["setting_id"] = "mod_option_camera_zoom",
				["type"] = "checkbox",
				["default_value"] = true,
			},
			{["setting_id"] = "mod_option_flashlight_shadows",
				["type"] = "checkbox",
				["default_value"] = true,
			},
			{["setting_id"] = "mod_option_flashlight_flicker",
				["type"] = "checkbox",
				["default_value"] = true,
				["sub_widgets"] = {
					{["setting_id"] = "mod_option_flashlight_flicker_start",
						["type"] = "checkbox",
						["default_value"] = true,
					},
					{["setting_id"] = "mod_option_laser_pointer_wild",
						["type"] = "checkbox",
						["default_value"] = false,
					},
				},
			},
			{["setting_id"] = "mod_option_debug",
				["type"] = "checkbox",
				["default_value"] = false,
				["sub_widgets"] = {
					{["setting_id"] = "reposition_x_neg",
						["type"] = "keybind",
						["default_value"] = {},
						["keybind_trigger"] = "pressed",
						["keybind_type"] = "function_call",
						["function_name"] = "reposition_x_neg",
					},
					{["setting_id"] = "reposition_x_pos",
						["type"] = "keybind",
						["default_value"] = {},
						["keybind_trigger"] = "pressed",
						["keybind_type"] = "function_call",
						["function_name"] = "reposition_x_pos",
					},
					{["setting_id"] = "reposition_y_neg",
						["type"] = "keybind",
						["default_value"] = {},
						["keybind_trigger"] = "pressed",
						["keybind_type"] = "function_call",
						["function_name"] = "reposition_y_neg",
					},
					{["setting_id"] = "reposition_y_pos",
						["type"] = "keybind",
						["default_value"] = {},
						["keybind_trigger"] = "pressed",
						["keybind_type"] = "function_call",
						["function_name"] = "reposition_y_pos",
					},
					{["setting_id"] = "reposition_z_neg",
						["type"] = "keybind",
						["default_value"] = {},
						["keybind_trigger"] = "pressed",
						["keybind_type"] = "function_call",
						["function_name"] = "reposition_z_neg",
					},
					{["setting_id"] = "reposition_z_pos",
						["type"] = "keybind",
						["default_value"] = {},
						["keybind_trigger"] = "pressed",
						["keybind_type"] = "function_call",
						["function_name"] = "reposition_z_pos",
					},
					{["setting_id"] = "rerotate_x_neg",
						["type"] = "keybind",
						["default_value"] = {},
						["keybind_trigger"] = "pressed",
						["keybind_type"] = "function_call",
						["function_name"] = "rerotate_x_neg",
					},
					{["setting_id"] = "rerotate_x_pos",
						["type"] = "keybind",
						["default_value"] = {},
						["keybind_trigger"] = "pressed",
						["keybind_type"] = "function_call",
						["function_name"] = "rerotate_x_pos",
					},
					{["setting_id"] = "rerotate_y_neg",
						["type"] = "keybind",
						["default_value"] = {},
						["keybind_trigger"] = "pressed",
						["keybind_type"] = "function_call",
						["function_name"] = "rerotate_y_neg",
					},
					{["setting_id"] = "rerotate_y_pos",
						["type"] = "keybind",
						["default_value"] = {},
						["keybind_trigger"] = "pressed",
						["keybind_type"] = "function_call",
						["function_name"] = "rerotate_y_pos",
					},
					{["setting_id"] = "rerotate_z_neg",
						["type"] = "keybind",
						["default_value"] = {},
						["keybind_trigger"] = "pressed",
						["keybind_type"] = "function_call",
						["function_name"] = "rerotate_z_neg",
					},
					{["setting_id"] = "rerotate_z_pos",
						["type"] = "keybind",
						["default_value"] = {},
						["keybind_trigger"] = "pressed",
						["keybind_type"] = "function_call",
						["function_name"] = "rerotate_z_pos",
					},
					{["setting_id"] = "test_index",
						["type"] = "keybind",
						["default_value"] = {},
						["keybind_trigger"] = "pressed",
						["keybind_type"] = "function_call",
						["function_name"] = "inc_test_index",
					},
				}
			},
		},
	},
}
