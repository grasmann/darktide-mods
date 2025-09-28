local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local trinket_hooks = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/trinket_hook")
local emblem_right = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/emblem_right")
local emblem_left = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/emblem_left")
local flashlights = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/flashlight")

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
        flashlight = flashlights,
        barrel = {
            autogun_rifle_barrel_01 = {
                replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.175, -2, 0},
            },
            autogun_rifle_barrel_02 = {
                replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_02",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.175, -2, 0},
            },
            autogun_rifle_barrel_03 = {
                replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_03",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.175, -2, 0},
            },
            autogun_rifle_barrel_04 = {
                replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_04",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.175, -2, 0},
            },
            autogun_rifle_barrel_05 = {
                replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_05",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.175, -2, 0},
            },
            autogun_rifle_barrel_06 = {
                replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_06",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.175, -2, 0},
            },
            autogun_rifle_barrel_ml01 = {
                replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ml01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.175, -2, 0},
            },
        },
        muzzle = {
            autogun_rifle_muzzle_01 = {
                replacement_path = _item_ranged.."/muzzles/autogun_rifle_muzzle_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
            autogun_rifle_muzzle_02 = {
                replacement_path = _item_ranged.."/muzzles/autogun_rifle_muzzle_02",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
            autogun_rifle_muzzle_03 = {
                replacement_path = _item_ranged.."/muzzles/autogun_rifle_muzzle_03",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
            autogun_rifle_muzzle_04 = {
                replacement_path = _item_ranged.."/muzzles/autogun_rifle_muzzle_04",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
            autogun_rifle_muzzle_05 = {
                replacement_path = _item_ranged.."/muzzles/autogun_rifle_muzzle_05",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
            autogun_rifle_muzzle_ml01 = {
                replacement_path = _item_ranged.."/muzzles/autogun_rifle_muzzle_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
        },
        magazine = {
            autogun_rifle_magazine_01 = {
                replacement_path = _item_ranged.."/magazines/autogun_rifle_magazine_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.125, -1.25, -.05},
            },
            autogun_rifle_magazine_02 = {
                replacement_path = _item_ranged.."/magazines/autogun_rifle_magazine_02",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.125, -1.25, -.05},
            },
            autogun_rifle_magazine_03 = {
                replacement_path = _item_ranged.."/magazines/autogun_rifle_magazine_03",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.125, -1.25, -.05},
            },
        },
        receiver = {
            autogun_rifle_receiver_01 = {
                replacement_path = _item_ranged.."/recievers/autogun_rifle_receiver_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.175, -2, .25},
            },
            autogun_rifle_receiver_ml01 = {
                replacement_path = _item_ranged.."/recievers/autogun_rifle_receiver_ml01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.175, -2, .25},
            },
        },
        sight = {
            autogun_rifle_sight_01 = {
                replacement_path = _item_ranged.."/sights/autogun_rifle_sight_01",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .175},
            },
        },
        stock = {
            autogun_rifle_stock_01 = {
                replacement_path = _item_ranged.."/stocks/autogun_rifle_stock_01",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.1, -1.5, .2},
            },
            autogun_rifle_stock_02 = {
                replacement_path = _item_ranged.."/stocks/autogun_rifle_stock_02",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.1, -1.5, .2},
            },
            autogun_rifle_stock_03 = {
                replacement_path = _item_ranged.."/stocks/autogun_rifle_stock_03",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.1, -1.5, .2},
            },
            autogun_rifle_stock_04 = {
                replacement_path = _item_ranged.."/stocks/autogun_rifle_stock_04",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.1, -1.5, .2},
            },
            autogun_rifle_stock_ml01 = {
                replacement_path = _item_ranged.."/stocks/autogun_rifle_stock_ml01",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.1, -1.5, .2},
            },
        },
        grip = {
            autogun_rifle_grip_01 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            autogun_rifle_grip_02 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_02",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            autogun_rifle_grip_03 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_03",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            autogun_rifle_grip_ml01 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
        },
    },
}
