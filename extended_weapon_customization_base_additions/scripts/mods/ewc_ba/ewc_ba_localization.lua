local mod = get_mod("extended_weapon_customization_base_additions")

mod:add_global_localize_strings({
	loc_ewc_extended_weapon_customization_base_additions = {
		en = "EWC Base Additions",
	},
	loc_ewc_laser_pointers = {
		en = "EWC:BA - Red Laser Pointers",
	},
	loc_ewc_laser_pointers_green = {
		en = "EWC:BA - Green Laser Pointers",
	},
	loc_ewc_laser_blades_red = {
		en = "EWC:BA - Red Laser Blades",
	},
	loc_ewc_laser_blades_green = {
		en = "EWC:BA - Green Laser Blades",
	},
	loc_ewc_combat_sword = {
		en = "EWC:BA - Combat Sword",
	},
	loc_ewc_falchion = {
		en = "EWC:BA - Falchion",
	},
	loc_ewc_sabre = {
		en = "EWC:BA - Sabre",
	},
	loc_ewc_power_sword = {
		en = "EWC:BA - Power Sword",
	},
	loc_ewc_power_falchion = {
		en = "EWC:BA - Power Falchion",
	},
	loc_ewc_autopistol = {
		en = "EWC:BA - Autopistol",
	},
	loc_ewc_autogun_headhunter = {
		en = "EWC:BA - Headhunter Autogun",
	},
	loc_ewc_autogun_infantry = {
		en = "EWC:BA - Infantry Autogun",
	},
	loc_ewc_autogun_braced = {
		en = "EWC:BA - Braced Autogun",
	},
	loc_ewc_lasgun_infantry = {
		en = "EWC:BA - Infantry Lasgun",
	},
	loc_ewc_lasgun_helbore = {
		en = "EWC:BA - Helbore Lasgun",
	},
	loc_ewc_lasgun_recon = {
		en = "EWC:BA - Recon Lasgun",
	},
	loc_ewc_laspistol = {
		en = "EWC:BA - Laspistol",
	},
	loc_ewc_2h_power_sword = {
		en = "EWC:BA - 2H Power Sword",
	},

	loc_scope_01 = {
		en = "Ranger's Vigil",
	},
})

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_melee = _item.."/melee"

return {
	mod_title = {
		en = "Extended Weapon Customization Base Additions",
	},
	mod_description = {
		en = "Basic custom additions for extended weapon customization.",
	},
}
