local mod = get_mod("extended_weapon_customization")

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
    grip_01 = {
        replacement_path = _item_ranged.."/grips/grip_01",
        icon_render_unit_rotation_offset = {90, 0, 30},
        icon_render_camera_position_offset = {.075, -1, .05},
    },
    grip_02 = {
        replacement_path = _item_ranged.."/grips/grip_02",
        icon_render_unit_rotation_offset = {90, 0, 30},
        icon_render_camera_position_offset = {.075, -1, .05},
    },
    grip_03 = {
        replacement_path = _item_ranged.."/grips/grip_03",
        icon_render_unit_rotation_offset = {90, 0, 30},
        icon_render_camera_position_offset = {.075, -1, .05},
    },
    grip_04 = {
        replacement_path = _item_ranged.."/grips/grip_04",
        icon_render_unit_rotation_offset = {90, 0, 30},
        icon_render_camera_position_offset = {.075, -1, .05},
    },
    grip_05 = {
        replacement_path = _item_ranged.."/grips/grip_05",
        icon_render_unit_rotation_offset = {90, 0, 30},
        icon_render_camera_position_offset = {.075, -1, .05},
    },
}
