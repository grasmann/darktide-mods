local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
	local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
	local _common_melee = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_melee")
	local _chainaxe_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/chainaxe_p1_m1")
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

return table_combine(
	_chainaxe_p1_m1,
	{
		attachments = {
			grip = _chainaxe_p1_m1.grip_attachments(),
			shaft = _chainaxe_p1_m1.shaft_attachments(),
			blade = _chainaxe_p1_m1.blade_attachments(),
			teeth = _chainaxe_p1_m1.teeth_attachments(),
			emblem_left = _common.emblem_left_attachments(),
			trinket_hook = _common.trinket_hook_attachments(),
			emblem_right = _common.emblem_right_attachments(),
		},
		models = table_combine(
			_common.trinket_hook_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
			_chainaxe_p1_m1.shaft_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
			_chainaxe_p1_m1.teeth_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
			_chainaxe_p1_m1.blade_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2)),
			_chainaxe_p1_m1.grip_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.2)),
			_common.emblem_right_models("head", 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
			_common.emblem_left_models("head", -3, vector3_box(0, 0, 0), vector3_box(0, 0, 0))
		),
		anchors = {
			fixes = {
				
			}
		}
	}
)