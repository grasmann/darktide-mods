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
    invisible_flashlight_ogryn = {
        replacement_path = _item_ranged.."/flashlights/invisible_flashlight_ogryn",
        icon_render_unit_rotation_offset = {0, 0, 0},
        icon_render_camera_position_offset = {0, 0, 0},
        flashlight_template = "ogryn_heavy_stubber_p2",
    },
    flashlight_ogryn_01 = {
        replacement_path = _item_ranged.."/flashlights/flashlight_ogryn_01",
        icon_render_unit_rotation_offset = {90, 0, 90 + 30},
        icon_render_camera_position_offset = {-.125, -1.75, .15},
        flashlight_template = "ogryn_heavy_stubber_p2",
    },
    flashlight_ogryn_long_01 = {
        replacement_path = _item_ranged.."/flashlights/flashlight_ogryn_long_01",
        icon_render_unit_rotation_offset = {90, 0, 90 + 30},
        icon_render_camera_position_offset = {-.125, -1.75, .15},
        flashlight_template = "ogryn_heavy_stubber_p2",
    },
}
