local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local vector3 = Vector3
    local vector3_box = Vector3Box
    local vector3_zero = vector3.zero
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"

return {
    autogun_rifle_barrel_ak_01 = {
        replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_01",
        icon_render_unit_rotation_offset = {90, -20, 90 - 30},
        icon_render_camera_position_offset = {-.245, -2.5, 0},
    },
    autogun_rifle_barrel_ak_02 = {
        replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_02",
        icon_render_unit_rotation_offset = {90, -20, 90 - 30},
        icon_render_camera_position_offset = {-.245, -2.5, 0},
    },
    autogun_rifle_barrel_ak_03 = {
        replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_03",
        icon_render_unit_rotation_offset = {90, -20, 90 - 30},
        icon_render_camera_position_offset = {-.245, -2.5, 0},
    },
    autogun_rifle_barrel_ak_04 = {
        replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_04",
        icon_render_unit_rotation_offset = {90, -20, 90 - 30},
        icon_render_camera_position_offset = {-.245, -2.5, 0},
    },
    autogun_rifle_barrel_ak_05 = {
        replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_05",
        icon_render_unit_rotation_offset = {90, -20, 90 - 30},
        icon_render_camera_position_offset = {-.245, -2.5, 0},
    },
    autogun_rifle_barrel_ak_06 = {
        replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_06",
        icon_render_unit_rotation_offset = {90, -20, 90 - 30},
        icon_render_camera_position_offset = {-.245, -2.5, 0},
    },
    autogun_rifle_barrel_ak_07 = {
        replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_07",
        icon_render_unit_rotation_offset = {90, -20, 90 - 30},
        icon_render_camera_position_offset = {-.245, -2.5, 0},
    },
    autogun_rifle_barrel_ak_08 = {
        replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_08",
        icon_render_unit_rotation_offset = {90, -20, 90 - 30},
        icon_render_camera_position_offset = {-.245, -2.5, 0},
    },
    autogun_rifle_barrel_ak_ml01 = {
        replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_ml01",
        icon_render_unit_rotation_offset = {90, -20, 90 - 30},
        icon_render_camera_position_offset = {-.245, -2.5, 0},
    },
}
