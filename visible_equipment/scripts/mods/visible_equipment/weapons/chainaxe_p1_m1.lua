local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
	local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
	local _common_melee = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_melee")
	local _chainaxe_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/chainaxe_p1_m1")
	local SoundEventAliases = mod:original_require("scripts/settings/sound/player_character_sound_event_aliases")
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local _item = "content/items/weapons/player"
	local _item_ranged = _item.."/ranged"
	local _item_melee = _item.."/melee"
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
	local table = table
	local vector3_box = Vector3Box
	local table_combine = table.combine
	local table_icombine = table.icombine
--#endregion

-- ##### ┌┬┐┌─┐┌─┐┬┌┐┌┬┌┬┐┬┌─┐┌┐┌┌─┐ ##################################################################################
-- #####  ││├┤ ├┤ │││││ │ ││ ││││└─┐ ##################################################################################
-- ##### ─┴┘└─┘└  ┴┘└┘┴ ┴ ┴└─┘┘└┘└─┘ ##################################################################################

local _ogryn_powermaul_shafts = "ogryn_powermaul_shaft_01|ogryn_powermaul_shaft_02|ogryn_powermaul_shaft_03|ogryn_powermaul_shaft_04|ogryn_powermaul_shaft_05"
local _ogryn_club_pommels = "ogryn_club_pommel_01|ogryn_club_pommel_02|ogryn_club_pommel_03|ogryn_club_pommel_04|ogryn_club_pommel_05"
local _hatchet_grips = "hatchet_grip_01|hatchet_grip_02|hatchet_grip_03|hatchet_grip_04|hatchet_grip_05|hatchet_grip_06"
local _2h_powermaul_shafts = "2h_power_maul_shaft_01|2h_power_maul_shaft_02|2h_power_maul_shaft_03|2h_power_maul_shaft_04|2h_power_maul_shaft_05|2h_power_maul_shaft_06"
local _combat_axe_grips = "axe_grip_01|axe_grip_02|axe_grip_03|axe_grip_04|axe_grip_05|axe_grip_06"

return table_combine(
	_chainaxe_p1_m1,
	{
		attachments = {
			-- grip = _chainaxe_p1_m1.grip_attachments(),
			grip = _common_melee.medium_grip_attachments(),
			-- shaft = _chainaxe_p1_m1.shaft_attachments(),
			shaft = _common_melee.small_shaft_attachments(),
			blade = _chainaxe_p1_m1.blade_attachments(),
			teeth = _chainaxe_p1_m1.teeth_attachments(),
			pommel = _common_melee.pommel_attachments(true, false, false, false),
			emblem_left = _common.emblem_left_attachments(),
			trinket_hook = _common.trinket_hook_attachments(),
			emblem_right = _common.emblem_right_attachments(),
		},
		models = table_combine(
			_common.trinket_hook_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
			-- _chainaxe_p1_m1.shaft_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
			_common_melee.small_shaft_models({
				{parent = nil, angle = 0, move = vector3_box(0, 0, 0), remove = vector3_box(0, 0, 0)}
			}),
			_chainaxe_p1_m1.teeth_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
			_chainaxe_p1_m1.blade_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2)),
			-- _chainaxe_p1_m1.grip_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.2)),
			_common_melee.medium_grip_models({
				{parent = nil, angle = 0, move = vector3_box(0, 0, 0), remove = vector3_box(0, 0, -.2)}
			}),
			_common_melee.pommel_models({
				{parent = "shaft", angle = 0, move = vector3_box(0, 0, 0), remove = vector3_box(0, 0, -.2)}
			}),
			_common.emblem_right_models("head", 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
			_common.emblem_left_models("head", -3, vector3_box(0, 0, 0), vector3_box(0, 0, 0))
		),
		anchors = {
			fixes = {
				{dependencies = {"ogryn_powermaul_shaft_01", _ogryn_club_pommels},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
				},
				{dependencies = {"ogryn_powermaul_shaft_01"},
					shaft = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(.3, .3, .6)},
					blade = {offset = true, position = vector3_box(0, 0, .385), rotation = vector3_box(0, 0, 0), scale = vector3_box(3, 3, 1.66)},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(3, 3, 1.66)},
				},
				{dependencies = {"ogryn_powermaul_shaft_02", _ogryn_club_pommels},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
				},
				{dependencies = {"ogryn_powermaul_shaft_02"},
					shaft = {offset = true, position = vector3_box(0, 0, -.1), rotation = vector3_box(0, 0, 0), scale = vector3_box(.3, .3, .5)},
					blade = {offset = true, position = vector3_box(0, 0, .65), rotation = vector3_box(0, 0, 0), scale = vector3_box(3, 3, 2)},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(3, 3, 2)},
				},
				{dependencies = {"ogryn_powermaul_shaft_03", _ogryn_club_pommels},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.1, 1.1, 1)},
				},
				{dependencies = {"ogryn_powermaul_shaft_03"},
					shaft = {offset = true, position = vector3_box(0, 0, -.05), rotation = vector3_box(0, 0, 0), scale = vector3_box(.3, .3, .6)},
					blade = {offset = true, position = vector3_box(0, 0, .55), rotation = vector3_box(0, 0, 0), scale = vector3_box(3, 3, 1.66)},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(3, 3, 1.66)},
				},
				{dependencies = {"ogryn_powermaul_shaft_04", _ogryn_club_pommels},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.1, 1.1, 1)},
				},
				{dependencies = {"ogryn_powermaul_shaft_04"},
					shaft = {offset = true, position = vector3_box(0, 0, .025), rotation = vector3_box(0, 0, 0), scale = vector3_box(.3, .3, .4)},
					blade = {offset = true, position = vector3_box(0, 0, .52), rotation = vector3_box(0, 0, 0), scale = vector3_box(3, 3, 2.5)},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(3, 3, 2.5)},
				},
				{dependencies = {"ogryn_powermaul_shaft_05", _ogryn_club_pommels},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.1, 1.1, 1)},
				},
				{dependencies = {"ogryn_powermaul_shaft_05"},
					shaft = {offset = true, position = vector3_box(0, 0, .025), rotation = vector3_box(0, 0, 0), scale = vector3_box(.3, .3, .4)},
					blade = {offset = true, position = vector3_box(0, 0, .6), rotation = vector3_box(0, 0, 0), scale = vector3_box(3, 3, 2.5)},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(3, 3, 2.5)},
				},
				
				
				{dependencies = {"2h_power_maul_shaft_01", _hatchet_grips},
					grip = {offset = true, position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.2, 1.2, 1.2)},
				},
				{dependencies = {"2h_power_maul_shaft_01", _ogryn_club_pommels},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(.3, .3, .4)},
				},
				{dependencies = {"2h_power_maul_shaft_01"},
					shaft = {offset = true, position = vector3_box(0, 0, -.2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					blade = {offset = true, position = vector3_box(0, 0, .415), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					grip = {offset = true, position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
				},
				{dependencies = {"2h_power_maul_shaft_02", _hatchet_grips},
					grip = {offset = true, position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.2, 1.2, 1.2)},
				},
				{dependencies = {"2h_power_maul_shaft_02", _ogryn_club_pommels},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(.3, .3, .4)},
				},
				{dependencies = {"2h_power_maul_shaft_02"},
					shaft = {offset = true, position = vector3_box(0, 0, -.2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					blade = {offset = true, position = vector3_box(0, 0, .415), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					grip = {offset = true, position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
				},
				{dependencies = {"2h_power_maul_shaft_03", _hatchet_grips},
					grip = {offset = true, position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.2, 1.2, 1.2)},
				},
				{dependencies = {"2h_power_maul_shaft_03", _ogryn_club_pommels},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(.3, .3, .4)},
				},
				{dependencies = {"2h_power_maul_shaft_03"},
					shaft = {offset = true, position = vector3_box(0, 0, -.18), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					blade = {offset = true, position = vector3_box(0, 0, .4), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					grip = {offset = true, position = vector3_box(0, 0, .18), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
				},
				{dependencies = {"2h_power_maul_shaft_04", _hatchet_grips},
					grip = {offset = true, position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.2, 1.2, 1.2)},
				},
				{dependencies = {"2h_power_maul_shaft_04", _ogryn_club_pommels},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(.3, .3, .4)},
				},
				{dependencies = {"2h_power_maul_shaft_04"},
					shaft = {offset = true, position = vector3_box(0, 0, -.175), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					blade = {offset = true, position = vector3_box(0, 0, .35), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					grip = {offset = true, position = vector3_box(0, 0, .175), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
				},
				{dependencies = {"2h_power_maul_shaft_05", _hatchet_grips},
					grip = {offset = true, position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.2, 1.2, 1.2)},
				},
				{dependencies = {"2h_power_maul_shaft_05", _ogryn_club_pommels},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.25), rotation = vector3_box(0, 0, 0), scale = vector3_box(.3, .3, .4)},
				},
				{dependencies = {"2h_power_maul_shaft_05"},
					shaft = {offset = true, position = vector3_box(0, 0, -.175), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					blade = {offset = true, position = vector3_box(0, 0, .35), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.25), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					grip = {offset = true, position = vector3_box(0, 0, .175), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
				},
				{dependencies = {"2h_power_maul_shaft_06", _hatchet_grips},
					grip = {offset = true, position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.2, 1.2, 1.2)},
				},
				{dependencies = {"2h_power_maul_shaft_06", _ogryn_club_pommels},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(.3, .3, .4)},
				},
				{dependencies = {"2h_power_maul_shaft_06"},
					shaft = {offset = true, position = vector3_box(0, 0, -.175), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					blade = {offset = true, position = vector3_box(0, 0, .35), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					grip = {offset = true, position = vector3_box(0, 0, .175), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
				},

				{dependencies = {"thunder_hammer_shaft_01", _hatchet_grips},
					grip = {offset = true, position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.3, 1.3, 1.3)},
				},
				{dependencies = {"thunder_hammer_shaft_01", _combat_axe_grips},
					grip = {offset = true, position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.3, 1.3, 1.3)},
				},
				{dependencies = {"thunder_hammer_shaft_01", _ogryn_club_pommels},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.1), rotation = vector3_box(0, 0, 0), scale = vector3_box(.3, .3, .4)},
				},
				{dependencies = {"thunder_hammer_shaft_01"},
					shaft = {offset = true, position = vector3_box(0, 0, -.2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					blade = {offset = true, position = vector3_box(0, 0, .415), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.1), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					grip = {offset = true, position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
				},
				{dependencies = {"thunder_hammer_shaft_02", _hatchet_grips},
					grip = {offset = true, position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.3, 1.3, 1.3)},
				},
				{dependencies = {"thunder_hammer_shaft_02", _combat_axe_grips},
					grip = {offset = true, position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.3, 1.3, 1.3)},
				},
				{dependencies = {"thunder_hammer_shaft_02", _ogryn_club_pommels},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(.3, .3, .4)},
				},
				{dependencies = {"thunder_hammer_shaft_02"},
					shaft = {offset = true, position = vector3_box(0, 0, -.2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					blade = {offset = true, position = vector3_box(0, 0, .415), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					grip = {offset = true, position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
				},
				{dependencies = {"thunder_hammer_shaft_03", _hatchet_grips},
					grip = {offset = true, position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.3, 1.3, 1.3)},
				},
				{dependencies = {"thunder_hammer_shaft_03", _combat_axe_grips},
					grip = {offset = true, position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.3, 1.3, 1.3)},
				},
				{dependencies = {"thunder_hammer_shaft_03", _ogryn_club_pommels},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(.3, .3, .4)},
				},
				{dependencies = {"thunder_hammer_shaft_03"},
					shaft = {offset = true, position = vector3_box(0, 0, -.2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					blade = {offset = true, position = vector3_box(0, 0, .415), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					grip = {offset = true, position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
				},
				{dependencies = {"thunder_hammer_shaft_04", _hatchet_grips},
					grip = {offset = true, position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.3, 1.3, 1.3)},
				},
				{dependencies = {"thunder_hammer_shaft_04", _combat_axe_grips},
					grip = {offset = true, position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.3, 1.3, 1.3)},
				},
				{dependencies = {"thunder_hammer_shaft_04", _ogryn_club_pommels},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(.3, .3, .4)},
				},
				{dependencies = {"thunder_hammer_shaft_04"},
					shaft = {offset = true, position = vector3_box(0, 0, -.2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					blade = {offset = true, position = vector3_box(0, 0, .415), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					grip = {offset = true, position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
				},
				{dependencies = {"thunder_hammer_shaft_05", _hatchet_grips},
					grip = {offset = true, position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.3, 1.3, 1.3)},
				},
				{dependencies = {"thunder_hammer_shaft_05", _combat_axe_grips},
					grip = {offset = true, position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.3, 1.3, 1.3)},
				},
				{dependencies = {"thunder_hammer_shaft_05", _ogryn_club_pommels},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.1), rotation = vector3_box(0, 0, 0), scale = vector3_box(.3, .3, .4)},
				},
				{dependencies = {"thunder_hammer_shaft_05"},
					shaft = {offset = true, position = vector3_box(0, 0, -.2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					blade = {offset = true, position = vector3_box(0, 0, .415), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					pommel = {parent = "shaft", position = vector3_box(0, 0, -.1), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
					grip = {offset = true, position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
				},

				-- {dependencies = {_hatchet_grips},
				-- 	grip = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.2, 1.2, 1.2)},
				-- },
				{pommel = {parent = "shaft", position = vector3_box(0, 0, -.145), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
			}
		},
		sounds = {
			-- blade = {
			-- 	select = {SoundEventAliases.sfx_reload_lever_pull.events.ogryn_heavystubber_p1_m1},
			-- 	detach = {SoundEventAliases.sfx_reload_lever_pull.events.ogryn_heavystubber_p1_m1},
			-- 	attach = {SoundEventAliases.sfx_reload_lever_release.events.ogryn_heavystubber_p1_m1},
			-- },
			shaft = {
				select = {SoundEventAliases.sfx_reload_lever_pull.events.ogryn_heavystubber_p1_m1},
				-- detach = {SoundEventAliases.sfx_reload_lever_pull.events.ogryn_heavystubber_p1_m1},
				-- attach = {SoundEventAliases.sfx_reload_lever_release.events.ogryn_heavystubber_p1_m1},
			},
			-- teeth = {
			-- 	select = {SoundEventAliases.sfx_reload_lever_pull.events.ogryn_heavystubber_p1_m1},
			-- 	detach = {SoundEventAliases.sfx_reload_lever_pull.events.ogryn_heavystubber_p1_m1},
			-- 	attach = {SoundEventAliases.sfx_reload_lever_release.events.ogryn_heavystubber_p1_m1},
			-- },
			-- grip = {
			-- 	select = {SoundEventAliases.sfx_reload_lever_pull.events.ogryn_heavystubber_p1_m1},
			-- 	detach = {SoundEventAliases.sfx_reload_lever_pull.events.ogryn_heavystubber_p1_m1},
			-- 	attach = {SoundEventAliases.sfx_reload_lever_release.events.ogryn_heavystubber_p1_m1},
			-- },
		},
	}
)