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
local _item_melee = _item.."/melee"

return {
    sabre_grip_01 = {
        replacement_path = _item_melee.."/grips/sabre_grip_01",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {-.025, -2.5, .2},
    },
    sabre_grip_02 = {
        replacement_path = _item_melee.."/grips/sabre_grip_02",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {-.025, -2.5, .2},
    },
    sabre_grip_03 = {
        replacement_path = _item_melee.."/grips/sabre_grip_03",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {-.025, -2.5, .2},
    },
    sabre_grip_04 = {
        replacement_path = _item_melee.."/grips/sabre_grip_04",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {-.025, -2.5, .2},
    },
    sabre_grip_05 = {
        replacement_path = _item_melee.."/grips/sabre_grip_05",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {-.025, -2.5, .2},
    },
    sabre_grip_06 = {
        replacement_path = _item_melee.."/grips/sabre_grip_06",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {-.025, -2.5, .2},
    },
    sabre_grip_07 = {
        replacement_path = _item_melee.."/grips/sabre_grip_07",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {-.025, -2.5, .2},
    },
    sabre_grip_08 = {
        replacement_path = _item_melee.."/grips/sabre_grip_08",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {-.025, -2.5, .2},
    },
    sabre_grip_ml01 = {
        replacement_path = _item_melee.."/grips/sabre_grip_ml01",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {-.025, -2.5, .2},
    },
}
