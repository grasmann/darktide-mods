local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local trinket_hooks = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/trinket_hook")
local emblem_right = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/emblem_right")
local emblem_left = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/emblem_left")

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
        barrel = {
            autogun_rifle_barrel_ak_01 = {
                replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.245, -2.5, 0},
            },
            autogun_rifle_barrel_ak_02 = {
                replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_02",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.245, -2.5, 0},
            },
            autogun_rifle_barrel_ak_03 = {
                replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_03",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.245, -2.5, 0},
            },
            autogun_rifle_barrel_ak_04 = {
                replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_04",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.245, -2.5, 0},
            },
            autogun_rifle_barrel_ak_05 = {
                replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_05",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.245, -2.5, 0},
            },
            autogun_rifle_barrel_ak_06 = {
                replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_06",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.245, -2.5, 0},
            },
            autogun_rifle_barrel_ak_07 = {
                replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_07",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.245, -2.5, 0},
            },
            autogun_rifle_barrel_ak_08 = {
                replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_08",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.245, -2.5, 0},
            },
            autogun_rifle_barrel_ak_ml01 = {
                replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_ml01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.245, -2.5, 0},
            },
        },
        muzzle = {
            autogun_rifle_ak_muzzle_01 = {
                replacement_path = _item_ranged.."/muzzles/autogun_rifle_ak_muzzle_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
            autogun_rifle_ak_muzzle_02 = {
                replacement_path = _item_ranged.."/muzzles/autogun_rifle_ak_muzzle_02",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
            autogun_rifle_ak_muzzle_03 = {
                replacement_path = _item_ranged.."/muzzles/autogun_rifle_ak_muzzle_03",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
            autogun_rifle_ak_muzzle_04 = {
                replacement_path = _item_ranged.."/muzzles/autogun_rifle_ak_muzzle_04",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
            autogun_rifle_ak_muzzle_05 = {
                replacement_path = _item_ranged.."/muzzles/autogun_rifle_ak_muzzle_05",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
            autogun_rifle_ak_muzzle_ml01 = {
                replacement_path = _item_ranged.."/muzzles/autogun_rifle_ak_muzzle_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
        },
        magazine = {
            autogun_rifle_ak_magazine_01 = {
                replacement_path = _item_ranged.."/magazines/autogun_rifle_ak_magazine_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1.45, -.1},
            },
        },
        receiver = {
            autogun_rifle_ak_receiver_01 = {
                replacement_path = _item_ranged.."/recievers/autogun_rifle_ak_receiver_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.125, -1.75, .25},
            },
            autogun_rifle_ak_receiver_02 = {
                replacement_path = _item_ranged.."/recievers/autogun_rifle_ak_receiver_02",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.125, -1.75, .25},
            },
            autogun_rifle_ak_receiver_03 = {
                replacement_path = _item_ranged.."/recievers/autogun_rifle_ak_receiver_03",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.125, -1.75, .25},
            },
            autogun_rifle_ak_receiver_ml01 = {
                replacement_path = _item_ranged.."/recievers/autogun_rifle_ak_receiver_ml01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.125, -1.75, .25},
            },
        },
        sight = {
            autogun_rifle_ak_sight_01 = {
                replacement_path = _item_ranged.."/sights/autogun_rifle_ak_sight_01",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .175},
            },
        },
        stock = {
            autogun_rifle_ak_stock_01 = {
                replacement_path = _item_ranged.."/stocks/autogun_rifle_ak_stock_01",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.1, -1.5, .2},
            },
            autogun_rifle_ak_stock_02 = {
                replacement_path = _item_ranged.."/stocks/autogun_rifle_ak_stock_02",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.1, -1.5, .2},
            },
            autogun_rifle_ak_stock_03 = {
                replacement_path = _item_ranged.."/stocks/autogun_rifle_ak_stock_03",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.1, -1.5, .2},
            },
            autogun_rifle_ak_stock_04 = {
                replacement_path = _item_ranged.."/stocks/autogun_rifle_ak_stock_04",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.1, -1.5, .2},
            },
            autogun_rifle_ak_stock_05 = {
                replacement_path = _item_ranged.."/stocks/autogun_rifle_ak_stock_05",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.1, -1.5, .2},
            },
            autogun_rifle_ak_stock_06 = {
                replacement_path = _item_ranged.."/stocks/autogun_rifle_ak_stock_06",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.1, -1.5, .2},
            },
            autogun_rifle_ak_stock_07 = {
                replacement_path = _item_ranged.."/stocks/autogun_rifle_ak_stock_07",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.1, -1.5, .2},
            },
            autogun_rifle_ak_stock_ml01 = {
                replacement_path = _item_ranged.."/stocks/autogun_rifle_ak_stock_ml01",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.1, -1.5, .2},
            },
        },
        grip = {
            autogun_rifle_grip_ak_01 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_ak_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            autogun_rifle_grip_ak_02 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_ak_02",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            autogun_rifle_grip_ak_03 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_ak_03",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            autogun_rifle_grip_ak_04 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_ak_04",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            autogun_rifle_grip_ak_05 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_ak_05",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            autogun_rifle_grip_ak_ml01 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_ak_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
        },
    },
}
