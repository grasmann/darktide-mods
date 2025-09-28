local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local trinket_hooks = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/trinket_hook")
local emblem_right = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/emblem_right")
local emblem_left = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/emblem_left")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local table = table
    local vector3 = Vector3
    local vector3_box = Vector3Box
    local vector3_zero = vector3.zero
    local table_merge_recursive = table.merge_recursive
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"

return {
    attachments = {
        emblem_left = emblem_left,
        emblem_right = emblem_right,
        trinket_hook = trinket_hooks,
        grip = {
            flamer_rifle_grip_01 = {
                replacement_path = _item_ranged.."/grips/flamer_rifle_grip_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            flamer_rifle_grip_02 = {
                replacement_path = _item_ranged.."/grips/flamer_rifle_grip_02",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            flamer_rifle_grip_03 = {
                replacement_path = _item_ranged.."/grips/flamer_rifle_grip_03",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            flamer_rifle_grip_04 = {
                replacement_path = _item_ranged.."/grips/flamer_rifle_grip_04",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            flamer_rifle_grip_ml01 = {
                replacement_path = _item_ranged.."/grips/flamer_rifle_grip_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
        },
        receiver = {
            flamer_rifle_receiver_01 = {
                replacement_path = _item_ranged.."/recievers/flamer_rifle_receiver_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -2.75, .25},
            },
            flamer_rifle_receiver_02 = {
                replacement_path = _item_ranged.."/recievers/flamer_rifle_receiver_02",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -2.75, .25},
            },
            flamer_rifle_receiver_03 = {
                replacement_path = _item_ranged.."/recievers/flamer_rifle_receiver_03",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -2.75, .25},
            },
            flamer_rifle_receiver_04 = {
                replacement_path = _item_ranged.."/recievers/flamer_rifle_receiver_04",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -2.75, .25},
            },
            flamer_rifle_receiver_05 = {
                replacement_path = _item_ranged.."/recievers/flamer_rifle_receiver_05",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -2.75, .25},
            },
            flamer_rifle_receiver_06 = {
                replacement_path = _item_ranged.."/recievers/flamer_rifle_receiver_06",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -2.75, .25},
            },
            flamer_rifle_receiver_07 = {
                replacement_path = _item_ranged.."/recievers/flamer_rifle_receiver_07",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.275, -3.5, .25},
            },
            flamer_rifle_receiver_ml01 = {
                replacement_path = _item_ranged.."/recievers/flamer_rifle_receiver_ml01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -2.75, .25},
            },
        },
        magazine = {
            flamer_rifle_magazine_01 = {
                replacement_path = _item_ranged.."/magazines/flamer_rifle_magazine_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.1, -1.5, -.05},
            },
            flamer_rifle_magazine_02 = {
                replacement_path = _item_ranged.."/magazines/flamer_rifle_magazine_02",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.1, -1.5, -.05},
            },
            flamer_rifle_magazine_03 = {
                replacement_path = _item_ranged.."/magazines/flamer_rifle_magazine_03",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.075, -1.75, -.05},
            },
            flamer_rifle_magazine_04 = {
                replacement_path = _item_ranged.."/magazines/flamer_rifle_magazine_04",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.1, -1.5, -.05},
            },
            flamer_rifle_magazine_ml01 = {
                replacement_path = _item_ranged.."/magazines/flamer_rifle_magazine_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.1, -1.5, -.05},
            },
        },
        barrel = {
            flamer_rifle_barrel_01 = {
                replacement_path = _item_ranged.."/barrels/flamer_rifle_barrel_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.25, -2.5, .175},
            },
            flamer_rifle_barrel_02 = {
                replacement_path = _item_ranged.."/barrels/flamer_rifle_barrel_02",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.25, -2.5, .175},
            },
            flamer_rifle_barrel_03 = {
                replacement_path = _item_ranged.."/barrels/flamer_rifle_barrel_03",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.25, -2.5, .175},
            },
            flamer_rifle_barrel_04 = {
                replacement_path = _item_ranged.."/barrels/flamer_rifle_barrel_04",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.25, -2.5, .175},
            },
            flamer_rifle_barrel_05 = {
                replacement_path = _item_ranged.."/barrels/flamer_rifle_barrel_05",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.25, -2.5, .175},
            },
            flamer_rifle_barrel_06 = {
                replacement_path = _item_ranged.."/barrels/flamer_rifle_barrel_06",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.25, -2.5, .175},
            },
            flamer_rifle_barrel_07 = {
                replacement_path = _item_ranged.."/barrels/flamer_rifle_barrel_07",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.1, -5, .175},
            },
            flamer_rifle_barrel_ml01 = {
                replacement_path = _item_ranged.."/barrels/flamer_rifle_barrel_ml01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.25, -2.5, .175},
            },
        },
    },
}
