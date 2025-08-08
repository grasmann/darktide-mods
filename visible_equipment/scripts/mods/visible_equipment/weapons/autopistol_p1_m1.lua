local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
	local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
	local _common_ranged = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_ranged")
	local _autopistol_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/autopistol_p1_m1")
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

return table_combine(
	_autopistol_p1_m1,
	{
		attachments = {
			-- Native
			receiver = _autopistol_p1_m1.receiver_attachments(),
			barrel = _autopistol_p1_m1.barrel_attachments(),
			muzzle = _autopistol_p1_m1.muzzle_attachments(),
			sight = table_icombine(
				_autopistol_p1_m1.sight_attachments(),
				_common_ranged.reflex_sights_attachments(false),
				_common_ranged.sights_attachments(false)
			),
			-- Ranged
			flashlight = _common_ranged.flashlights_attachments(),
			magazine = table_icombine(
				_common_ranged.magazine_attachments()
			),
			grip = _common_ranged.grip_attachments(),
			stock = _common_ranged.stock_attachments(),
			bayonet = _common_ranged.bayonet_attachments(),
			-- Common
			trinket_hook = _common.trinket_hook_attachments(),
			emblem_right = _common.emblem_right_attachments(),
			emblem_left = _common.emblem_left_attachments(),
		},
		models = table_combine(
			-- Native
			_autopistol_p1_m1.receiver_models(nil, 0, vector3_box(0, -1, 0), vector3_box(0, 0, -.00001)),
			_autopistol_p1_m1.barrel_models(nil, -.35, vector3_box(.1, -1, 0), vector3_box(0, .2, 0)),
			-- functions.magazine_models(nil, 0, vector3_box(0, -3, .1), vector3_box(0, 0, -.2)),
			_autopistol_p1_m1.muzzle_models(nil, -.5, vector3_box(.2, -1, 0), vector3_box(0, .2, 0)),
			_autopistol_p1_m1.sight_models("receiver", .2, vector3_box(0, -1, -.1), vector3_box(0, -.2, 0)),
			-- Ranged
			_common_ranged.flashlight_models(nil, -2.5, vector3_box(0, -1, 0), vector3_box(.2, 0, 0)),
			_common_ranged.bayonet_models({"barrel", "barrel", "barrel", "muzzle"}, -.5, vector3_box(.3, -1, 0), vector3_box(0, .4, -.034)),
			_common_ranged.grip_models(nil, .3, vector3_box(-.3, -1, 0), vector3_box(0, -.1, -.1)),
			_common_ranged.stock_models("receiver", .4, vector3_box(-.4, -1, 0), vector3_box(0, -.2, 0)),
			_common_ranged.reflex_sights_models("receiver", .2, vector3_box(0, -1, -.1), vector3_box(0, -.2, 0), "sight", {}, {
				{sight_2 = "sight_default"},
				{sight_2 = "sight_default"},
				{sight_2 = "sight_default"},
				{sight_2 = "sight_default"},
				{sight_2 = "sight_default"},
			}),
			_common_ranged.scope_sights_models("sight", .2, vector3_box(0, -1, -.1), vector3_box(0, 0, 0), "sight_2"),
			_common_ranged.scope_lens_models("sight_2", .2, vector3_box(0, -1, -.1), vector3_box(0, 0, 0)),
			_common_ranged.scope_lens_2_models("sight_2", .2, vector3_box(0, -1, -.1), vector3_box(0, 0, 0)),
			_common_ranged.magazine_models(nil, .2, vector3_box(0, -1, .1), vector3_box(0, 0, -.2)),
			_common_ranged.sights_models("receiver", .2, vector3_box(0, -1, -.1), {
				vector3_box(-.2, 0, 0),
				vector3_box(0, -.2, 0),
				vector3_box(0, -.2, 0),
				vector3_box(0, -.2, 0),
				vector3_box(0, -.2, 0),
				vector3_box(0, -.2, 0),
				vector3_box(0, -.2, 0),
				vector3_box(0, -.2, 0),
				vector3_box(0, -.2, 0),
			}, "sight", {}, {
				{sight_2 = "sight_default"},
				{sight_2 = "sight_default"},
				{sight_2 = "sight_default"},
				{sight_2 = "sight_default"},
				{sight_2 = "sight_default"},
				{sight_2 = "scope_sight_03", lens = "scope_lens_02", lens_2 = "scope_lens_2_02"},
				{sight_2 = "scope_sight_02", lens = "scope_lens_02", lens_2 = "scope_lens_2_02"},
				{sight_2 = "scope_sight_03", lens = "scope_lens_02", lens_2 = "scope_lens_2_02"},
				{sight_2 = "sight_default"},
			}, {}, {
				true,
				true,
				false,
				false,
				false,
				false,
				false,
				false,
				false,
			}),
			-- Common
			_common.trinket_hook_models("barrel", -.2, vector3_box(0, 0, .1), vector3_box(0, 0, -.2)),
			_common.emblem_right_models("receiver", -3, vector3_box(0, 0, 0), vector3_box(.2, 0, 0)),
			_common.emblem_left_models("receiver", 0, vector3_box(0, 0, 0), vector3_box(-.2, 0, 0))
		),
		anchors = {
			fixes = {
				--#region Scope
					{dependencies = {"scope_01"}, -- Lasgun sight
						sight = {offset = true, position = vector3_box(0, -.08, .153), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1.5, 1)},
						lens = {offset = true, position = vector3_box(0, .12, .031), rotation = vector3_box(0, 0, 0), scale = vector3_box(.64, .6, .7), data = {lens = 1}},
						lens_2 = {offset = true, position = vector3_box(0, .01, .031), rotation = vector3_box(180, 0, 0), scale = vector3_box(.64, .85, .7), data = {lens = 2}},
						sight_2 = {offset = true, position = vector3_box(0, .07, -.0415), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}}},
						scope_offset = {position = vector3_box(0, .15, .015), lense_transparency = true}},
					{dependencies = {"scope_02"}, -- Lasgun sight
						sight = {offset = true, position = vector3_box(0, -.12, .153), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 3, 1)},
						lens = {offset = true, position = vector3_box(0, -.02, .03), rotation = vector3_box(0, 0, 0), scale = vector3_box(.62, .4, .7), data = {lens = 1}},
						lens_2 = {offset = true, position = vector3_box(0, -.14, .03), rotation = vector3_box(180, 0, 0), scale = vector3_box(.62, .4, .7), data = {lens = 2}},
						sight_2 = {offset = true, position = vector3_box(0, .09, -.04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 3, 4, 5}}},
						scope_offset = {position = vector3_box(0, 0, .015), lense_transparency = true}},
					{dependencies = {"scope_03"}, -- Lasgun sight
						sight = {offset = true, position = vector3_box(0, -.08, .153), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
						lens = {offset = true, position = vector3_box(0, .08, .034), rotation = vector3_box(0, 0, 0), scale = vector3_box(.62, 1, .62), data = {lens = 1}},
						lens_2 = {offset = true, position = vector3_box(0, .22, .034), rotation = vector3_box(180, 0, 0), scale = vector3_box(.62, 1, .62), data = {lens = 2}},
						sight_2 = {offset = true, position = vector3_box(0, 0, -.0425), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}}},
						scope_offset = {position = vector3_box(0, .15, .015), lense_transparency = true}},
					{sight_2 = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
					{lens = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
					{lens_2 = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
				--#endregion
				--#region Grips
					{dependencies = {"grip_27|grip_28|grip_29"}, -- Grip
						grip = {offset = true, position = vector3_box(0, .01, -.02), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
				--#endregion
				--#region Flashlights
					{dependencies = {"laser_pointer"}, -- Laser Pointer
						flashlight = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
				--#endregion
				--#region Sights
					{dependencies = {"lasgun_rifle_sight_01"}, -- Sight
						sight = {offset = true, position = vector3_box(0, -.036, .026), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, .8, 1)}},
					{dependencies = {"reflex_sight_01"}, -- Sight
						sight = {offset = true, position = vector3_box(0, -.05, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
					{dependencies = {"reflex_sight_02"}, -- Sight
						sight = {offset = true, position = vector3_box(0, -.05, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
					{dependencies = {"reflex_sight_03"}, -- Sight
						sight = {offset = true, position = vector3_box(0, -.05, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
				--#endregion
				--#region Magazines
					{dependencies = {"magazine_01"}, -- Magazine
						magazine = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, .6, 1)}},
					{dependencies = {"magazine_02"}, -- Magazine
						magazine = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, .6, 1)}},
					{dependencies = {"magazine_03"}, -- Magazine
						magazine = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, .6, 1)}},
					{dependencies = {"magazine_04"}, -- Magazine
						magazine = {offset = true, position = vector3_box(0, 0, -.06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, .6, .6)}},
					{dependencies = {"bolter_magazine_01|bolter_magazine_02"}, -- Magazine
						magazine = {offset = true, position = vector3_box(0, -.002, -.04), rotation = vector3_box(0, 0, 0), scale = vector3_box(.87, .6, .6)}},
					{dependencies = {"boltpistol_magazine_01|boltpistol_magazine_02"}, -- Magazine
						magazine = {offset = true, position = vector3_box(0, -.002, -.048), rotation = vector3_box(0, 0, 0), scale = vector3_box(.87, .73, .73)}},
				--#endregion
				--#region Emblems
					{dependencies = {"emblem_left_02"}, -- Emblem
						emblem_left = {parent = "receiver", position = vector3_box(-.0257, .08, .09), rotation = vector3_box(0, 10, 180), scale = vector3_box(1, -1, 1)}},
					{emblem_left = {parent = "receiver", position = vector3_box(-.0257, .08, .09), rotation = vector3_box(0, 10, 180), scale = vector3_box(1, 1, 1)}},
				--#endregion
				--#region Stocks
					{stock = {parent = "receiver", position = vector3_box(0, -.095, .065), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
				--#endregion
				--#region Bayonets
					{dependencies = {"barrel_01", "autogun_bayonet_01"}, -- Bayonet
						bayonet = {parent = "barrel", position = vector3_box(0, .105, -.034), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
					{dependencies = {"barrel_01", "autogun_bayonet_02"}, -- Bayonet
						bayonet = {parent = "barrel", position = vector3_box(0, .105, -.034), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
					{dependencies = {"muzzle_01", "autogun_bayonet_03"}, -- Bayonet
						bayonet = {parent = "muzzle", position = vector3_box(0, .009, -.0275), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
					{dependencies = {"barrel_02", "autogun_bayonet_01"}, -- Bayonet
						bayonet = {parent = "barrel", position = vector3_box(0, .105, -.034), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
					{dependencies = {"barrel_02", "autogun_bayonet_02"}, -- Bayonet
						bayonet = {parent = "barrel", position = vector3_box(0, .105, -.034), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
					{dependencies = {"muzzle_02", "autogun_bayonet_03"}, -- Bayonet
						bayonet = {parent = "muzzle", position = vector3_box(0, .02, -.0275), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
					{dependencies = {"barrel_03", "autogun_bayonet_01"}, -- Bayonet
						bayonet = {parent = "barrel", position = vector3_box(0, .13, -.034), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
					{dependencies = {"barrel_03", "autogun_bayonet_02"}, -- Bayonet
						bayonet = {parent = "barrel", position = vector3_box(0, .13, -.034), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
					{dependencies = {"muzzle_03", "autogun_bayonet_03"}, -- Bayonet
						bayonet = {parent = "muzzle", position = vector3_box(0, .009, -.03), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
					{dependencies = {"barrel_04", "autogun_bayonet_01"}, -- Bayonet
						bayonet = {parent = "barrel", position = vector3_box(0, .14, -.034), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
					{dependencies = {"barrel_04", "autogun_bayonet_02"}, -- Bayonet
						bayonet = {parent = "barrel", position = vector3_box(0, .14, -.034), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
					{dependencies = {"muzzle_04", "autogun_bayonet_03"}, -- Bayonet
						bayonet = {parent = "muzzle", position = vector3_box(0, .009, -.03), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
					{dependencies = {"barrel_05", "autogun_bayonet_01"}, -- Bayonet
						bayonet = {parent = "barrel", position = vector3_box(0, .14, -.034), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
					{dependencies = {"barrel_05", "autogun_bayonet_02"}, -- Bayonet
						bayonet = {parent = "barrel", position = vector3_box(0, .14, -.034), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
					{dependencies = {"muzzle_05", "autogun_bayonet_03"}, -- Bayonet
						bayonet = {parent = "muzzle", position = vector3_box(0, .052, -.03), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
				--#endregion
			},
		},
	}
)