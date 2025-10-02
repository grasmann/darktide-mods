local mod = get_mod("extended_weapon_customization_base_additions")

mod:add_global_localize_strings({
	loc_extended_weapon_customization_base_additions = {
		en = "EWC Base Additions",
	},
	loc_laser_pointers = {
		en = "EWC Base Additions - Red Laser Pointers",
	},
	loc_laser_pointers_green = {
		en = "EWC Base Additions - Green Laser Pointers",
	},
	loc_laser_blades_red = {
		en = "EWC Base Additions - Red Laser Blades",
	},
	loc_laser_blades_green = {
		en = "EWC Base Additions - Green Laser Blades",
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
