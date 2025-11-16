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
    force_staff_shaft_upper_01 = {
        replacement_path = _item_ranged.."/shafts/force_staff_shaft_upper_01",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {0, -1.5, .5},
    },
    force_staff_shaft_upper_02 = {
        replacement_path = _item_ranged.."/shafts/force_staff_shaft_upper_02",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {0, -1.5, .5},
    },
    force_staff_shaft_upper_03 = {
        replacement_path = _item_ranged.."/shafts/force_staff_shaft_upper_03",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {0, -1.5, .5},
    },
    force_staff_shaft_upper_04 = {
        replacement_path = _item_ranged.."/shafts/force_staff_shaft_upper_04",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {0, -1.5, .5},
    },
    force_staff_shaft_upper_05 = {
        replacement_path = _item_ranged.."/shafts/force_staff_shaft_upper_05",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {0, -1.5, .5},
    },
    force_staff_shaft_upper_06 = {
        replacement_path = _item_ranged.."/shafts/force_staff_shaft_upper_06",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {0, -1.5, .5},
    },
    force_staff_shaft_upper_ml01 = {
        replacement_path = _item_ranged.."/shafts/force_staff_shaft_upper_ml01",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {0, -1.5, .5},
    },
}
