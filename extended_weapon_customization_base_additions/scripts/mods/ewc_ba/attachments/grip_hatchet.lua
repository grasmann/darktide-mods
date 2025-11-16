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
    hatchet_grip_01 = {
        replacement_path = _item_melee.."/grips/hatchet_grip_01",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {-.05, -1.5, .2},
    },
    hatchet_grip_02 = {
        replacement_path = _item_melee.."/grips/hatchet_grip_02",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {-.05, -1.5, .2},
    },
    hatchet_grip_03 = {
        replacement_path = _item_melee.."/grips/hatchet_grip_03",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {-.05, -1.5, .2},
    },
    hatchet_grip_04 = {
        replacement_path = _item_melee.."/grips/hatchet_grip_04",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {-.05, -1.5, .2},
    },
    hatchet_grip_05 = {
        replacement_path = _item_melee.."/grips/hatchet_grip_05",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {-.05, -1.5, .2},
    },
    hatchet_grip_06 = {
        replacement_path = _item_melee.."/grips/hatchet_grip_06",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {-.05, -1.5, .2},
    },
}
