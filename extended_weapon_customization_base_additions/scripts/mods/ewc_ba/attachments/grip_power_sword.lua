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
local _item_melee = _item.."/melee"

return {
    power_sword_grip_01 = {
        replacement_path = _item_melee.."/grips/power_sword_grip_01",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {-.025, -.5, .1},
    },
    power_sword_grip_02 = {
        replacement_path = _item_melee.."/grips/power_sword_grip_02",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {-.025, -.5, .1},
    },
    power_sword_grip_03 = {
        replacement_path = _item_melee.."/grips/power_sword_grip_03",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {-.025, -.5, .1},
    },
    power_sword_grip_04 = {
        replacement_path = _item_melee.."/grips/power_sword_grip_04",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {-.15, -1.75, .1},
    },
    power_sword_grip_05 = {
        replacement_path = _item_melee.."/grips/power_sword_grip_05",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {-.025, -.5, .1},
    },
    power_sword_grip_06 = {
        replacement_path = _item_melee.."/grips/power_sword_grip_06",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {-.025, -.5, .1},
    },
    power_sword_grip_ml01 = {
        replacement_path = _item_melee.."/grips/power_sword_grip_ml01",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {-.025, -.5, .1},
    },
}
