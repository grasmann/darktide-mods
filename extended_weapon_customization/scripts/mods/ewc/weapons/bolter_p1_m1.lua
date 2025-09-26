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
        receiver = {
            boltgun_rifle_receiver_01 = {
                replacement_path = _item_ranged.."/recievers/boltgun_rifle_receiver_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.2, -2.75, .25},
            },
            boltgun_rifle_receiver_02 = {
                replacement_path = _item_ranged.."/recievers/boltgun_rifle_receiver_02",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.2, -2.75, .25},
            },
            boltgun_rifle_receiver_03 = {
                replacement_path = _item_ranged.."/recievers/boltgun_rifle_receiver_03",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.2, -2.75, .25},
            },
            boltgun_rifle_receiver_04 = {
                replacement_path = _item_ranged.."/recievers/boltgun_rifle_receiver_04",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.2, -2.75, .25},
            },
            boltgun_rifle_receiver_05 = {
                replacement_path = _item_ranged.."/recievers/boltgun_rifle_receiver_05",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.2, -2.75, .25},
            },
            boltgun_rifle_receiver_06 = {
                replacement_path = _item_ranged.."/recievers/boltgun_rifle_receiver_06",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.2, -2.75, .25},
            },
            boltgun_rifle_receiver_07 = {
                replacement_path = _item_ranged.."/recievers/boltgun_rifle_receiver_07",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.2, -2.75, .25},
            },
            boltgun_rifle_receiver_08 = {
                replacement_path = _item_ranged.."/recievers/boltgun_rifle_receiver_08",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.2, -2.75, .25},
            },
            boltgun_rifle_receiver_09 = {
                replacement_path = _item_ranged.."/recievers/boltgun_rifle_receiver_09",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.2, -2.75, .25},
            },
            boltgun_rifle_receiver_ml01 = {
                replacement_path = _item_ranged.."/recievers/boltgun_rifle_receiver_ml01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.2, -2.75, .25},
            },
        },
        magazine = {
            boltgun_rifle_magazine_01 = {
                replacement_path = _item_ranged.."/magazines/boltgun_rifle_magazine_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.125, -1.25, -.05},
            },
            boltgun_rifle_magazine_02 = {
                replacement_path = _item_ranged.."/magazines/boltgun_rifle_magazine_02",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.125, -1.25, -.05},
            },
        },
        barrel = {
            boltgun_rifle_barrel_01 = {
                replacement_path = _item_ranged.."/barrels/boltgun_rifle_barrel_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -1.25, .175},
            },
            boltgun_rifle_barrel_02 = {
                replacement_path = _item_ranged.."/barrels/boltgun_rifle_barrel_02",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -1.25, .175},
            },
            boltgun_rifle_barrel_03 = {
                replacement_path = _item_ranged.."/barrels/boltgun_rifle_barrel_03",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -1.25, .175},
            },
            boltgun_rifle_barrel_04 = {
                replacement_path = _item_ranged.."/barrels/boltgun_rifle_barrel_04",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.175, -1.25, .175},
            },
        },
        underbarrel = {
            boltgun_rifle_underbarrel_01 = {
                replacement_path = _item_ranged.."/underbarrels/boltgun_rifle_underbarrel_01",
                icon_render_unit_rotation_offset = {90, 45, 45},
                icon_render_camera_position_offset = {-.15, -1.5, .25},
            },
            boltgun_rifle_underbarrel_02 = {
                replacement_path = _item_ranged.."/underbarrels/boltgun_rifle_underbarrel_02",
                icon_render_unit_rotation_offset = {90, 45, 45},
                icon_render_camera_position_offset = {-.15, -1.5, .25},
            },
            boltgun_rifle_underbarrel_03 = {
                replacement_path = _item_ranged.."/underbarrels/boltgun_rifle_underbarrel_03",
                icon_render_unit_rotation_offset = {90, 45, 45},
                icon_render_camera_position_offset = {-.15, -1.5, .25},
            },
            boltgun_rifle_underbarrel_04 = {
                replacement_path = _item_ranged.."/underbarrels/boltgun_rifle_underbarrel_04",
                icon_render_unit_rotation_offset = {90, 45, 45},
                icon_render_camera_position_offset = {-.15, -1.5, .25},
            },
            boltgun_rifle_underbarrel_05 = {
                replacement_path = _item_ranged.."/underbarrels/boltgun_rifle_underbarrel_05",
                icon_render_unit_rotation_offset = {90, 45, 45},
                icon_render_camera_position_offset = {-.15, -1.5, .25},
            },
            boltgun_rifle_underbarrel_06 = {
                replacement_path = _item_ranged.."/underbarrels/boltgun_rifle_underbarrel_06",
                icon_render_unit_rotation_offset = {90, 45, 45},
                icon_render_camera_position_offset = {-.15, -1.5, .25},
            },
            boltgun_rifle_underbarrel_ml01 = {
                replacement_path = _item_ranged.."/underbarrels/boltgun_rifle_underbarrel_ml01",
                icon_render_unit_rotation_offset = {90, 45, 45},
                icon_render_camera_position_offset = {-.15, -1.5, .25},
            },
        },
        sight = {
            boltgun_rifle_sight_01 = {
                replacement_path = _item_ranged.."/sights/boltgun_rifle_sight_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.2, -2.75, .25},
            },
            boltgun_rifle_sight_02 = {
                replacement_path = _item_ranged.."/sights/boltgun_rifle_sight_02",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.2, -2.75, .25},
            },
        },
        grip = {
            boltgun_rifle_grip_01 = {
                replacement_path = _item_ranged.."/grips/boltgun_rifle_grip_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            boltgun_rifle_grip_02 = {
                replacement_path = _item_ranged.."/grips/boltgun_rifle_grip_02",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            boltgun_rifle_grip_03 = {
                replacement_path = _item_ranged.."/grips/boltgun_rifle_grip_03",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            boltgun_rifle_grip_04 = {
                replacement_path = _item_ranged.."/grips/boltgun_rifle_grip_04",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            boltgun_rifle_grip_05 = {
                replacement_path = _item_ranged.."/grips/boltgun_rifle_grip_05",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            boltgun_rifle_grip_ml01 = {
                replacement_path = _item_ranged.."/grips/boltgun_rifle_grip_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
        },
    },
}
