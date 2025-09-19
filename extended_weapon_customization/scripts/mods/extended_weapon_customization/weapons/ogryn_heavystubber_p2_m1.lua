local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local trinket_hooks = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/trinket_hook")
local emblem_left = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/emblem_left")
local emblem_right = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/emblem_right")
local flashlights = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/ogryn_flashlight")

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
local _item_melee = _item.."/melee"
local _item_ranged = _item.."/ranged"

return {
    attachments = {
        emblem_left = emblem_left,
        emblem_right = emblem_right,
        trinket_hook = trinket_hooks,
        flashlight = flashlights,
        barrel = {
            stubgun_ogryn_barrel_01 = {
                replacement_path = _item_ranged.."/barrels/stubgun_ogryn_barrel_01",
                icon_render_unit_rotation_offset = {90, 20, 90 - 30},
                icon_render_camera_position_offset = {-.55, -8, .2},
            },
            stubgun_ogryn_barrel_02 = {
                replacement_path = _item_ranged.."/barrels/stubgun_ogryn_barrel_02",
                icon_render_unit_rotation_offset = {90, 20, 90 - 30},
                icon_render_camera_position_offset = {-.55, -8, .2},
            },
            stubgun_ogryn_barrel_03 = {
                replacement_path = _item_ranged.."/barrels/stubgun_ogryn_barrel_03",
                icon_render_unit_rotation_offset = {90, 20, 90 - 30},
                icon_render_camera_position_offset = {-.55, -8, .2},
            },
            stubgun_ogryn_barrel_04 = {
                replacement_path = _item_ranged.."/barrels/stubgun_ogryn_barrel_04",
                icon_render_unit_rotation_offset = {90, 20, 90 - 30},
                icon_render_camera_position_offset = {-.55, -8, .2},
            },
            stubgun_ogryn_barrel_ml01 = {
                replacement_path = _item_ranged.."/barrels/stubgun_ogryn_barrel_ml01",
                icon_render_unit_rotation_offset = {90, 20, 90 - 30},
                icon_render_camera_position_offset = {-.55, -8, .2},
            },
            stubgun_ogryn_barrel_ml02 = {
                replacement_path = _item_ranged.."/barrels/stubgun_ogryn_barrel_ml02",
                icon_render_unit_rotation_offset = {90, 20, 90 - 30},
                icon_render_camera_position_offset = {-.55, -8, .2},
            },
        },
        receiver = {
            stubgun_ogryn_receiver_01 = {
                replacement_path = _item_ranged.."/recievers/stubgun_ogryn_receiver_01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.125, -11, 0},
            },
            stubgun_ogryn_receiver_02 = {
                replacement_path = _item_ranged.."/recievers/stubgun_ogryn_receiver_02",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.125, -11, 0},
            },
            stubgun_ogryn_receiver_03 = {
                replacement_path = _item_ranged.."/recievers/stubgun_ogryn_receiver_03",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.125, -11, 0},
            },
            stubgun_ogryn_receiver_ml01 = {
                replacement_path = _item_ranged.."/recievers/stubgun_ogryn_receiver_ml01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.125, -11, 0},
            },
            stubgun_ogryn_receiver_ml02 = {
                replacement_path = _item_ranged.."/recievers/stubgun_ogryn_receiver_ml02",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.125, -11, 0},
            },
        },
        magazine = {
            stubgun_ogryn_magazine_01 = {
                replacement_path = _item_ranged.."/magazines/stubgun_ogryn_magazine_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.35, -5.5, -.1},
            },
            stubgun_ogryn_magazine_02 = {
                replacement_path = _item_ranged.."/magazines/stubgun_ogryn_magazine_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.35, -5.5, -.1},
            },
            stubgun_ogryn_magazine_03 = {
                replacement_path = _item_ranged.."/magazines/stubgun_ogryn_magazine_03",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.35, -5.5, -.1},
            },
            stubgun_ogryn_magazine_04 = {
                replacement_path = _item_ranged.."/magazines/stubgun_ogryn_magazine_04",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.35, -5.5, -.1},
            },
            stubgun_ogryn_magazine_ml01 = {
                replacement_path = _item_ranged.."/magazines/stubgun_ogryn_magazine_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.35, -5.5, -.1},
            },
            stubgun_ogryn_magazine_ml02 = {
                replacement_path = _item_ranged.."/magazines/stubgun_ogryn_magazine_ml02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.35, -5.5, -.1},
            },
        },
        grip = {
            stubgun_ogryn_grip_01 = {
                replacement_path = _item_ranged.."/grips/stubgun_ogryn_grip_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.1, -6.5, .15},
            },
            stubgun_ogryn_grip_02 = {
                replacement_path = _item_ranged.."/grips/stubgun_ogryn_grip_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.1, -6.5, .15},
            },
            stubgun_ogryn_grip_03 = {
                replacement_path = _item_ranged.."/grips/stubgun_ogryn_grip_03",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.1, -6.5, .15},
            },
            stubgun_ogryn_grip_04 = {
                replacement_path = _item_ranged.."/grips/stubgun_ogryn_grip_04",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.1, -6.5, .15},
            },
            stubgun_ogryn_grip_ml01 = {
                replacement_path = _item_ranged.."/grips/stubgun_ogryn_grip_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.1, -6.5, .15},
            },
            stubgun_ogryn_grip_ml02 = {
                replacement_path = _item_ranged.."/grips/stubgun_ogryn_grip_ml02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.1, -6.5, .15},
            },
        },
    },
}
