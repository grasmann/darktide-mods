local mod = get_mod("ui_extension")
return {
	name = mod:localize("mod_title"),
	description = mod:localize("mod_description"),
	is_togglable = false,
	allow_rehooking = true,
}