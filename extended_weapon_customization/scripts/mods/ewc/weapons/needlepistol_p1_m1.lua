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
            needle_pistol_grip_01 = {
                replacement_path = _item_ranged.."/grips/needle_pistol_grip_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            needle_pistol_grip_deluxe01 = {
                replacement_path = _item_ranged.."/grips/needle_pistol_grip_deluxe01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            needle_pistol_grip_ml01 = {
                replacement_path = _item_ranged.."/grips/needle_pistol_grip_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
        },
        receiver = {
            needle_pistol_receiver_01 = {
                replacement_path = _item_ranged.."/recievers/needle_pistol_receiver_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.11, -1.75, .25},
            },
            needle_pistol_receiver_deluxe01 = {
                replacement_path = _item_ranged.."/recievers/needle_pistol_receiver_deluxe01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.11, -1.75, .25},
            },
            needle_pistol_receiver_ml01 = {
                replacement_path = _item_ranged.."/recievers/needle_pistol_receiver_ml01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.11, -1.75, .25},
            },
        },
        magazine = {
            needle_pistol_magazine_01 = {
                replacement_path = _item_ranged.."/magazines/needle_pistol_magazine_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.125, -.75, 0},
            },
            needle_pistol_magazine_ml01 = {
                replacement_path = _item_ranged.."/magazines/needle_pistol_magazine_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.125, -.75, 0},
            },
        },
        barrel = {
            needle_pistol_barrel_01 = {
                replacement_path = _item_ranged.."/barrels/needle_pistol_barrel_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.08, -.5, .15},
            },
            needle_pistol_barrel_deluxe01 = {
                replacement_path = _item_ranged.."/barrels/needle_pistol_barrel_deluxe01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.08, -.5, .15},
            },
            needle_pistol_barrel_ml01 = {
                replacement_path = _item_ranged.."/barrels/needle_pistol_barrel_ml01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.08, -.5, .15},
            },
        },
    },
}
