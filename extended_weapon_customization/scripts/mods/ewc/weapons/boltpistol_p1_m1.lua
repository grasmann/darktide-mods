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
            boltgun_pistol_grip_01 = {
                replacement_path = _item_ranged.."/grips/boltgun_pistol_grip_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            boltgun_pistol_grip_02 = {
                replacement_path = _item_ranged.."/grips/boltgun_pistol_grip_02",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            boltgun_pistol_grip_03 = {
                replacement_path = _item_ranged.."/grips/boltgun_pistol_grip_03",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            boltgun_pistol_grip_ml01 = {
                replacement_path = _item_ranged.."/grips/boltgun_pistol_grip_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
        },
        receiver = {
            boltgun_pistol_receiver_01 = {
                replacement_path = _item_ranged.."/recievers/boltgun_pistol_receiver_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.11, -1.75, .25},
            },
            boltgun_pistol_receiver_02 = {
                replacement_path = _item_ranged.."/recievers/boltgun_pistol_receiver_02",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.11, -1.75, .25},
            },
            boltgun_pistol_receiver_03 = {
                replacement_path = _item_ranged.."/recievers/boltgun_pistol_receiver_03",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.11, -1.75, .25},
            },
            boltgun_pistol_receiver_04 = {
                replacement_path = _item_ranged.."/recievers/boltgun_pistol_receiver_04",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.11, -1.75, .25},
            },
            boltgun_pistol_receiver_05 = {
                replacement_path = _item_ranged.."/recievers/boltgun_pistol_receiver_05",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.11, -1.75, .25},
            },
            boltgun_pistol_receiver_06 = {
                replacement_path = _item_ranged.."/recievers/boltgun_pistol_receiver_06",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.11, -1.75, .25},
            },
            boltgun_pistol_receiver_07 = {
                replacement_path = _item_ranged.."/recievers/boltgun_pistol_receiver_07",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.11, -1.75, .25},
            },
            boltgun_pistol_receiver_ml01 = {
                replacement_path = _item_ranged.."/recievers/boltgun_pistol_receiver_ml01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.11, -1.75, .25},
            },
        },
        magazine = {
            boltgun_pistol_magazine_01 = {
                replacement_path = _item_ranged.."/magazines/boltgun_pistol_magazine_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.125, -.75, 0},
            },
            boltgun_pistol_magazine_02 = {
                replacement_path = _item_ranged.."/magazines/boltgun_pistol_magazine_02",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.125, -.75, 0},
            },
        },
        barrel = {
            boltgun_pistol_barrel_01 = {
                replacement_path = _item_ranged.."/barrels/boltgun_pistol_barrel_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.08, -.5, .15},
            },
            boltgun_pistol_barrel_02 = {
                replacement_path = _item_ranged.."/barrels/boltgun_pistol_barrel_02",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.08, -.5, .15},
            },
            boltgun_pistol_barrel_03 = {
                replacement_path = _item_ranged.."/barrels/boltgun_pistol_barrel_03",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.08, -.5, .15},
            },
        },
        sight = {
            boltgun_pistol_sight_01 = {
                replacement_path = _item_ranged.."/sights/boltgun_pistol_sight_01",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .175},
            },
            boltgun_pistol_sight_02 = {
                replacement_path = _item_ranged.."/sights/boltgun_pistol_sight_02",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .175},
            },
            boltgun_pistol_sight_03 = {
                replacement_path = _item_ranged.."/sights/boltgun_pistol_sight_03",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .175},
            },
        },
    },
}
