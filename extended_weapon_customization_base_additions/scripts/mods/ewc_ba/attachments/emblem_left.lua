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
    emblemleft_01 = {
        replacement_path = _item_ranged.."/emblems/emblemleft_01",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemleft_02 = {
        replacement_path = _item_ranged.."/emblems/emblemleft_02",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemleft_03 = {
        replacement_path = _item_ranged.."/emblems/emblemleft_03",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemleft_04a = {
        replacement_path = _item_ranged.."/emblems/emblemleft_04a",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemleft_04b = {
        replacement_path = _item_ranged.."/emblems/emblemleft_04b",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemleft_04c = {
        replacement_path = _item_ranged.."/emblems/emblemleft_04c",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemleft_04d = {
        replacement_path = _item_ranged.."/emblems/emblemleft_04d",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemleft_04e = {
        replacement_path = _item_ranged.."/emblems/emblemleft_04e",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemleft_04f = {
        replacement_path = _item_ranged.."/emblems/emblemleft_04f",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemleft_05 = {
        replacement_path = _item_ranged.."/emblems/emblemleft_05",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemleft_06 = {
        replacement_path = _item_ranged.."/emblems/emblemleft_06",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemleft_09a = {
        replacement_path = _item_ranged.."/emblems/emblemleft_09a",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .05},
    },
    emblemleft_10 = {
        replacement_path = _item_ranged.."/emblems/emblemleft_10",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, .05, .15},
    },
    emblemleft_11 = {
        replacement_path = _item_ranged.."/emblems/emblemleft_11",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, -.15, .15},
    },
    emblemleft_12 = {
        replacement_path = _item_ranged.."/emblems/emblemleft_12",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemleft_13 = {
        replacement_path = _item_ranged.."/emblems/emblemleft_13",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemleft_14 = {
        replacement_path = _item_ranged.."/emblems/emblemleft_14",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    emblemleft_15 = {
        replacement_path = _item_ranged.."/emblems/emblemleft_15",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
}
