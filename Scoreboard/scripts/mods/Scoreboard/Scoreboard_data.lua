local mod = get_mod("scoreboard")

local mod_data = {
	name = "scoreboard",
	description = mod:localize("mod_description"),
	is_togglable = false,
}

-- #####  ██████╗ ██████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗ #####################################################
-- ##### ██╔═══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ #####################################################
-- ##### ██║   ██║██████╔╝   ██║   ██║██║   ██║██╔██╗ ██║███████╗ #####################################################
-- ##### ██║   ██║██╔═══╝    ██║   ██║██║   ██║██║╚██╗██║╚════██║ #####################################################
-- ##### ╚██████╔╝██║        ██║   ██║╚██████╔╝██║ ╚████║███████║ #####################################################
-- #####  ╚═════╝ ╚═╝        ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ #####################################################

mod_data.options = {
	widgets = {
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
			["default_value"] = true
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
	}
}

return mod_data