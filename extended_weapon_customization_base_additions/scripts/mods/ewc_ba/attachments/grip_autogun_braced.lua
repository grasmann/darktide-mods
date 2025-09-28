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
    autogun_rifle_grip_ak_01 = {
        replacement_path = _item_ranged.."/grips/autogun_rifle_grip_ak_01",
        icon_render_unit_rotation_offset = {90, 0, 30},
        icon_render_camera_position_offset = {.075, -1, .05},
    },
    autogun_rifle_grip_ak_02 = {
        replacement_path = _item_ranged.."/grips/autogun_rifle_grip_ak_02",
        icon_render_unit_rotation_offset = {90, 0, 30},
        icon_render_camera_position_offset = {.075, -1, .05},
    },
    autogun_rifle_grip_ak_03 = {
        replacement_path = _item_ranged.."/grips/autogun_rifle_grip_ak_03",
        icon_render_unit_rotation_offset = {90, 0, 30},
        icon_render_camera_position_offset = {.075, -1, .05},
    },
    autogun_rifle_grip_ak_04 = {
        replacement_path = _item_ranged.."/grips/autogun_rifle_grip_ak_04",
        icon_render_unit_rotation_offset = {90, 0, 30},
        icon_render_camera_position_offset = {.075, -1, .05},
    },
    autogun_rifle_grip_ak_05 = {
        replacement_path = _item_ranged.."/grips/autogun_rifle_grip_ak_05",
        icon_render_unit_rotation_offset = {90, 0, 30},
        icon_render_camera_position_offset = {.075, -1, .05},
    },
    autogun_rifle_grip_ak_ml01 = {
        replacement_path = _item_ranged.."/grips/autogun_rifle_grip_ak_ml01",
        icon_render_unit_rotation_offset = {90, 0, 30},
        icon_render_camera_position_offset = {.075, -1, .05},
    },
}
