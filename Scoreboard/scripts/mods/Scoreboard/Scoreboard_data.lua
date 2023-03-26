local mod = get_mod("scoreboard")
return {
	name = mod:localize("mod_title"),
	description = mod:localize("mod_description"),
	is_togglable = false,
	allow_rehooking = true,
	options = {
		widgets = {
			{
				["setting_id"] = "open_scoreboard_history",
				["type"] = "keybind",
				["default_value"] = {"f5"},
				["keybind_trigger"] = "pressed",
				["keybind_type"] = "view_toggle",
				["view_name"] = "scoreboard_history_view"
			},
			{
				["setting_id"] = "open_scoreboard",
				["type"] = "keybind",
				["default_value"] = {"f6"},
				["keybind_trigger"] = "pressed",
				["keybind_type"] = "view_toggle",
				["view_name"] = "scoreboard_view"
			},
			{
				setting_id = "group_plugins",
  				type = "group",
				sub_widgets = {
					{
						["setting_id"] = "plugin_coherency_efficiency",
						["type"] = "checkbox",
						["default_value"] = true,
					},
				},
			},
			{
				setting_id = "group_messages",
  				type = "group",
				sub_widgets = {
					{
						["setting_id"] = "message_ammo",
						["type"] = "checkbox",
						["default_value"] = false
					},
					{
						["setting_id"] = "message_health_station",
						["type"] = "checkbox",
						["default_value"] = true
					},
					{
						["setting_id"] = "message_forge_material",
						["type"] = "checkbox",
						["default_value"] = false
					},
					{
						["setting_id"] = "message_default",
						["type"] = "checkbox",
						["default_value"] = false
					},
					{
						["setting_id"] = "message_health_placed",
						["type"] = "checkbox",
						["default_value"] = true
					},
					{
						["setting_id"] = "message_ammo_placed",
						["type"] = "checkbox",
						["default_value"] = true
					},
					{
						["setting_id"] = "message_decoded",
						["type"] = "checkbox",
						["default_value"] = true
					},
					{
						["setting_id"] = "ammo_health_pickup",
						["type"] = "checkbox",
						["default_value"] = true
					},
					{
						["setting_id"] = "scripture_grimoire_pickup",
						["type"] = "checkbox",
						["default_value"] = true
					},
				},
			},
		}
	}
}