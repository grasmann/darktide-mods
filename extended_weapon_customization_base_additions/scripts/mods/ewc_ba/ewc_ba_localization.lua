local mod = get_mod("extended_weapon_customization_base_additions")

mod:add_global_localize_strings({
	loc_ewc_extended_weapon_customization_base_additions = {
		en = "EWC Base Additions",
		["zh-cn"] = "扩展武器自定义：基础增补",
	},
	loc_ewc_laser_pointers = {
		en = "EWC:BA - Red Laser Pointers",
		["zh-cn"] = "扩展武器自定义：基础增补 - 红色激光指针",
	},
	loc_ewc_laser_pointers_green = {
		en = "EWC:BA - Green Laser Pointers",
		["zh-cn"] = "扩展武器自定义：基础增补 - 绿色激光指针",
	},
	loc_ewc_laser_blades_red = {
		en = "EWC:BA - Red Laser Blades",
		["zh-cn"] = "扩展武器自定义：基础增补 - 红色激光剑刃",
	},
	loc_ewc_laser_blades_green = {
		en = "EWC:BA - Green Laser Blades",
		["zh-cn"] = "扩展武器自定义：基础增补 - 绿色激光剑刃",
	},
	loc_ewc_combat_sword = {
		en = "EWC:BA - Combat Sword",
		["zh-cn"] = "扩展武器自定义：基础增补 - 战斗剑",
	},
	loc_ewc_falchion = {
		en = "EWC:BA - Falchion",
		["zh-cn"] = "扩展武器自定义：基础增补 - 弯刀",
	},
	loc_ewc_sabre = {
		en = "EWC:BA - Sabre",
		["zh-cn"] = "扩展武器自定义：基础增补 - 军刀",
	},
	loc_ewc_power_sword = {
		en = "EWC:BA - Power Sword",
		["zh-cn"] = "扩展武器自定义：基础增补 - 动力剑",
	},
	loc_ewc_power_falchion = {
		en = "EWC:BA - Power Falchion",
		["zh-cn"] = "扩展武器自定义：基础增补 - 动力弯刀",
	},
	loc_ewc_autopistol = {
		en = "EWC:BA - Autopistol",
		["zh-cn"] = "扩展武器自定义：基础增补 - 自动手枪",
	},
	loc_ewc_autogun_headhunter = {
		en = "EWC:BA - Headhunter Autogun",
		["zh-cn"] = "扩展武器自定义：基础增补 - 猎头者自动枪",
	},
	loc_ewc_autogun_infantry = {
		en = "EWC:BA - Infantry Autogun",
		["zh-cn"] = "扩展武器自定义：基础增补 - 步兵自动枪",
	},
	loc_ewc_autogun_braced = {
		en = "EWC:BA - Braced Autogun",
		["zh-cn"] = "扩展武器自定义：基础增补 - 支撑自动枪",
	},
	loc_ewc_lasgun_infantry = {
		en = "EWC:BA - Infantry Lasgun",
		["zh-cn"] = "扩展武器自定义：基础增补 - 步兵激光枪",
	},
	loc_ewc_lasgun_helbore = {
		en = "EWC:BA - Helbore Lasgun",
		["zh-cn"] = "扩展武器自定义：基础增补 - 赫尔波激光枪",
	},
	loc_ewc_lasgun_recon = {
		en = "EWC:BA - Recon Lasgun",
		["zh-cn"] = "扩展武器自定义：基础增补 - 侦察激光枪",
	},
	loc_ewc_laspistol = {
		en = "EWC:BA - Laspistol",
		["zh-cn"] = "扩展武器自定义：基础增补 - 激光手枪",
	},
	loc_ewc_2h_power_sword = {
		en = "EWC:BA - 2H Power Sword",
		["zh-cn"] = "扩展武器自定义：基础增补 - 双手动力剑",
	},
	loc_ewc_2h_force_sword = {
		en = "EWC:BA - 2H Force Sword",
	},
	loc_ewc_shotgun_double_barrel = {
		en = "EWC:BA - Double Barrel Shotgun",
	},
	loc_ewc_sight_show = {
		en = "EWC:BA - Sight just for show",
	},

	loc_scope_01 = {
		en = "Ranger's Vigil",
		["zh-cn"] = "游侠警戒",
	},
})

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_melee = _item.."/melee"

return {
	mod_title = {
		en = "Extended Weapon Customization Base Additions",
		["zh-cn"] = "扩展武器自定义：基础增补",
	},
	mod_description = {
		en = "Basic custom additions for extended weapon customization.",
		["zh-cn"] = "为扩展武器自定义功能提供的基础自定义增补内容。",
	},

	group_misc = {
		en = "Misc",
	},
	mod_option_laser_blade_randomization = {
		en = "Randomize Laser Blades",
	},
	mod_option_laser_blade_randomization_tooltip = {
		en = "Allows randomized weapons to have laser blades.",
	},
	mod_option_laser_pointer_randomization = {
		en = "Randomize Laser Pointer",
	},
	mod_option_laser_pointer_randomization_tooltip = {
		en = "Allows randomized weapons to have laser pointers.",
	},
}
