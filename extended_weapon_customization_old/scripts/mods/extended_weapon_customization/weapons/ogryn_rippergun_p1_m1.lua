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
            rippergun_rifle_barrel_01 = {
                replacement_path = _item_ranged.."/barrels/rippergun_rifle_barrel_01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.3, -4, 0},
            },
            rippergun_rifle_barrel_02 = {
                replacement_path = _item_ranged.."/barrels/rippergun_rifle_barrel_02",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.3, -4, 0},
            },
            rippergun_rifle_barrel_03 = {
                replacement_path = _item_ranged.."/barrels/rippergun_rifle_barrel_03",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.3, -4, 0},
            },
            rippergun_rifle_barrel_04 = {
                replacement_path = _item_ranged.."/barrels/rippergun_rifle_barrel_04",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.3, -4, 0},
            },
            rippergun_rifle_barrel_05 = {
                replacement_path = _item_ranged.."/barrels/rippergun_rifle_barrel_05",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.3, -4, 0},
            },
            rippergun_rifle_barrel_06 = {
                replacement_path = _item_ranged.."/barrels/rippergun_rifle_barrel_06",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.3, -4, 0},
            },
            rippergun_rifle_barrel_ml01 = {
                replacement_path = _item_ranged.."/barrels/rippergun_rifle_barrel_ml01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.3, -4, 0},
            },
        },
        receiver = {
            rippergun_rifle_receiver_01 = {
                replacement_path = _item_ranged.."/recievers/rippergun_rifle_receiver_01",
                icon_render_unit_rotation_offset = {90, 20, 90 - 40},
                icon_render_camera_position_offset = {-.45, -9, 1},
            },
            rippergun_rifle_receiver_02 = {
                replacement_path = _item_ranged.."/recievers/rippergun_rifle_receiver_02",
                icon_render_unit_rotation_offset = {90, 20, 90 - 40},
                icon_render_camera_position_offset = {-.45, -9, 1},
            },
            rippergun_rifle_receiver_03 = {
                replacement_path = _item_ranged.."/recievers/rippergun_rifle_receiver_03",
                icon_render_unit_rotation_offset = {90, 20, 90 - 40},
                icon_render_camera_position_offset = {-.45, -9, 1},
            },
            rippergun_rifle_receiver_04 = {
                replacement_path = _item_ranged.."/recievers/rippergun_rifle_receiver_04",
                icon_render_unit_rotation_offset = {90, 20, 90 - 40},
                icon_render_camera_position_offset = {-.45, -9, 1},
            },
            rippergun_rifle_receiver_05 = {
                replacement_path = _item_ranged.."/recievers/rippergun_rifle_receiver_05",
                icon_render_unit_rotation_offset = {90, 20, 90 - 40},
                icon_render_camera_position_offset = {-.45, -9, 1},
            },
            rippergun_rifle_receiver_06 = {
                replacement_path = _item_ranged.."/recievers/rippergun_rifle_receiver_06",
                icon_render_unit_rotation_offset = {90, 20, 90 - 40},
                icon_render_camera_position_offset = {-.45, -9, 1},
            },
            rippergun_rifle_receiver_07 = {
                replacement_path = _item_ranged.."/recievers/rippergun_rifle_receiver_07",
                icon_render_unit_rotation_offset = {90, 20, 90 - 40},
                icon_render_camera_position_offset = {-.45, -9, 1},
            },
            rippergun_rifle_receiver_08 = {
                replacement_path = _item_ranged.."/recievers/rippergun_rifle_receiver_08",
                icon_render_unit_rotation_offset = {90, 20, 90 - 40},
                icon_render_camera_position_offset = {-.45, -9, 1},
            },
            rippergun_rifle_receiver_09 = {
                replacement_path = _item_ranged.."/recievers/rippergun_rifle_receiver_09",
                icon_render_unit_rotation_offset = {90, 20, 90 - 40},
                icon_render_camera_position_offset = {-.45, -9, 1},
            },
            rippergun_rifle_receiver_ml01 = {
                replacement_path = _item_ranged.."/recievers/rippergun_rifle_receiver_ml01",
                icon_render_unit_rotation_offset = {90, 20, 90 - 40},
                icon_render_camera_position_offset = {-.45, -9, 1},
            },
        },
        magazine = {
            rippergun_rifle_magazine_01 = {
                replacement_path = _item_ranged.."/magazines/rippergun_rifle_magazine_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -5, 0},
            },
            rippergun_rifle_magazine_02 = {
                replacement_path = _item_ranged.."/magazines/rippergun_rifle_magazine_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -5, 0},
            },
            rippergun_rifle_magazine_03 = {
                replacement_path = _item_ranged.."/magazines/rippergun_rifle_magazine_03",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -5, 0},
            },
            rippergun_rifle_magazine_04 = {
                replacement_path = _item_ranged.."/magazines/rippergun_rifle_magazine_04",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -5, 0},
            },
            rippergun_rifle_magazine_05 = {
                replacement_path = _item_ranged.."/magazines/rippergun_rifle_magazine_05",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -5, 0},
            },
            rippergun_rifle_magazine_06 = {
                replacement_path = _item_ranged.."/magazines/rippergun_rifle_magazine_06",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -5, 0},
            },
            rippergun_rifle_magazine_07 = {
                replacement_path = _item_ranged.."/magazines/rippergun_rifle_magazine_07",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -5, 0},
            },
            rippergun_rifle_magazine_09 = {
                replacement_path = _item_ranged.."/magazines/rippergun_rifle_magazine_09",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -5, 0},
            },
            rippergun_rifle_magazine_ml01 = {
                replacement_path = _item_ranged.."/magazines/rippergun_rifle_magazine_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -5, 0},
            },
        },
        handle = {
            rippergun_rifle_handle_01 = {
                replacement_path = _item_ranged.."/handles/rippergun_rifle_handle_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.1, -3, 0},
            },
            rippergun_rifle_handle_02 = {
                replacement_path = _item_ranged.."/handles/rippergun_rifle_handle_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.1, -3, 0},
            },
            rippergun_rifle_handle_03 = {
                replacement_path = _item_ranged.."/handles/rippergun_rifle_handle_03",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.1, -3, 0},
            },
            rippergun_rifle_handle_04 = {
                replacement_path = _item_ranged.."/handles/rippergun_rifle_handle_04",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.1, -3, 0},
            },
            rippergun_rifle_handle_05 = {
                replacement_path = _item_ranged.."/handles/rippergun_rifle_handle_05",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.1, -3, 0},
            },
            rippergun_rifle_handle_07 = {
                replacement_path = _item_ranged.."/handles/rippergun_rifle_handle_07",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.1, -3, 0},
            },
            rippergun_rifle_handle_ml01 = {
                replacement_path = _item_ranged.."/handles/rippergun_rifle_handle_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.1, -3, 0},
            },
        },
    },
}
