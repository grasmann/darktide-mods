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
    emblemright_01 = {
        replacement_path = _item_ranged.."/emblems/emblemright_01",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemright_02 = {
        replacement_path = _item_ranged.."/emblems/emblemright_02",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemright_03 = {
        replacement_path = _item_ranged.."/emblems/emblemright_03",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemright_04a = {
        replacement_path = _item_ranged.."/emblems/emblemright_04a",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemright_04b = {
        replacement_path = _item_ranged.."/emblems/emblemright_04b",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemright_04c = {
        replacement_path = _item_ranged.."/emblems/emblemright_04c",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemright_04d = {
        replacement_path = _item_ranged.."/emblems/emblemright_04d",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemright_04e = {
        replacement_path = _item_ranged.."/emblems/emblemright_04e",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemright_04f = {
        replacement_path = _item_ranged.."/emblems/emblemright_04f",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemright_05 = {
        replacement_path = _item_ranged.."/emblems/emblemright_05",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemright_06 = {
        replacement_path = _item_ranged.."/emblems/emblemright_06",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemright_07 = {
        replacement_path = _item_ranged.."/emblems/emblemright_07",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemright_08a = {
        replacement_path = _item_ranged.."/emblems/emblemright_08a",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .1},
    },
    emblemright_08b = {
        replacement_path = _item_ranged.."/emblems/emblemright_08b",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .1},
    },
    emblemright_08c = {
        replacement_path = _item_ranged.."/emblems/emblemright_08c",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .1},
    },
    emblemright_09a = {
        replacement_path = _item_ranged.."/emblems/emblemright_09a",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .1},
    },
    emblemright_09b = {
        replacement_path = _item_ranged.."/emblems/emblemright_09b",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .05},
    },
    emblemright_09c = {
        replacement_path = _item_ranged.."/emblems/emblemright_09c",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .05},
    },
    emblemright_09d = {
        replacement_path = _item_ranged.."/emblems/emblemright_09d",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemright_09e = {
        replacement_path = _item_ranged.."/emblems/emblemright_09e",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .125},
    },
    emblemright_10 = {
        replacement_path = _item_ranged.."/emblems/emblemright_10",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemright_11 = {
        replacement_path = _item_ranged.."/emblems/emblemright_11",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, -.15, .15},
    },
    emblemright_12 = {
        replacement_path = _item_ranged.."/emblems/emblemright_12",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemright_13 = {
        replacement_path = _item_ranged.."/emblems/emblemright_13",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemright_14 = {
        replacement_path = _item_ranged.."/emblems/emblemright_14",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemright_15 = {
        replacement_path = _item_ranged.."/emblems/emblemright_15",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
}
