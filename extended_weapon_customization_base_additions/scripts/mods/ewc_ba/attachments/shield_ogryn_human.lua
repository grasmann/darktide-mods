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
    ogryn_shield_01 = {
        replacement_path = _item.."/shields/ogryn_shield_01",
        icon_render_unit_rotation_offset = {90, 15, 90 + 60},
        icon_render_camera_position_offset = {.3, -14, .05},
    },
    ogryn_shield_02 = {
        replacement_path = _item.."/shields/ogryn_shield_02",
        icon_render_unit_rotation_offset = {90, 15, 90 + 60},
        icon_render_camera_position_offset = {.3, -14, .05},
    },
    ogryn_shield_03 = {
        replacement_path = _item.."/shields/ogryn_shield_03",
        icon_render_unit_rotation_offset = {90, 15, 90 + 60},
        icon_render_camera_position_offset = {.3, -14, .05},
    },
    ogryn_shield_04 = {
        replacement_path = _item.."/shields/ogryn_shield_04",
        icon_render_unit_rotation_offset = {90, 15, 90 + 60},
        icon_render_camera_position_offset = {.3, -14, .05},
    },
    ogryn_shield_05 = {
        replacement_path = _item.."/shields/ogryn_shield_05",
        icon_render_unit_rotation_offset = {90, 15, 90 + 60},
        icon_render_camera_position_offset = {.3, -14, .05},
    },
    ogryn_shield_06 = {
        replacement_path = _item.."/shields/ogryn_shield_06",
        icon_render_unit_rotation_offset = {90, 15, 90 + 60},
        icon_render_camera_position_offset = {.3, -14, .05},
    },
    ogryn_shield_07 = {
        replacement_path = _item.."/shields/ogryn_shield_07",
        icon_render_unit_rotation_offset = {90, 15, 90 + 60},
        icon_render_camera_position_offset = {.3, -14, .05},
    },
    bulwark_shield_01 = {
        replacement_path = _item.."/shields/bulwark_shield_01",
        icon_render_unit_rotation_offset = {90, 15, 90 + 60},
        icon_render_camera_position_offset = {.5, -14, .3},
    },
}
