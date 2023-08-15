local mod = get_mod("weapon_customization")

mod:add_global_localize_strings({
	loc_weapon_inventory_switch_torch_button = {
		en = "Switch torch / stab",
		de = "Wechsel Lampe / Stich",
	},
})

return {
	mod_title = {
		en = "Extended Weapon Customization",
		de = "Erweiterte Waffenanpassung",
	},
	mod_description = {
		en = "Extends weapon customizations",
		de = "Erweitert Waffenanpassungen",
	},
}
