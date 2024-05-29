local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
	local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
	local _common_melee = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_melee")
	local _chainsword_2h_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/chainsword_2h_p1_m1")
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local _item = "content/items/weapons/player"
	local _item_melee = _item.."/melee"
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
	local table = table
	local vector3_box = Vector3Box
	local table_combine = table.combine
	local table_icombine = table.icombine
--#endregion

-- ##### ┌┬┐┌─┐┌─┐┬┌┐┌┬┌┬┐┬┌─┐┌┐┌┌─┐ ##################################################################################
-- #####  ││├┤ ├┤ │││││ │ ││ ││││└─┐ ##################################################################################
-- ##### ─┴┘└─┘└  ┴┘└┘┴ ┴ ┴└─┘┘└┘└─┘ ##################################################################################

return table_combine(
	_chainsword_2h_p1_m1,
	{
		attachments = {
			grip = _chainsword_2h_p1_m1.grip_attachments(),
			body = _chainsword_2h_p1_m1.body_attachments(),
			chain = _chainsword_2h_p1_m1.chain_attachments(),
			trinket_hook = _common.trinket_hook_attachments(),
			emblem_right = _common.emblem_right_attachments(),
			emblem_left = _common.emblem_left_attachments(),
		},
		models = table_combine(
			-- {customization_default_position = vector3_box(0, 3, .35)},
			_common.emblem_right_models("body", 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
			_common.emblem_left_models("body", -3, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
			_common.trinket_hook_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
			_chainsword_2h_p1_m1.chain_models(nil, 0, vector3_box(-.3, -3, .2), vector3_box(0, 0, 0)),
			_chainsword_2h_p1_m1.body_models(nil, 0, vector3_box(0, -5.5, -.4), vector3_box(0, 0, .2)),
			_chainsword_2h_p1_m1.grip_models(nil, 0, vector3_box(-.5, -4, .5), vector3_box(0, 0, -.2))
		),
		anchors = {
			fixes = {
				
			}
		},
	}
)