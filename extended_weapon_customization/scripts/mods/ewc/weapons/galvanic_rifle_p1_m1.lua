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
            galvanic_rifle_barrel_01 = {
                replacement_path = _item_ranged.."/barrels/galvanic_rifle_barrel_01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.175, -2, 0},
            },
        },
        muzzle = {
            galvanic_rifle_muzzle_01 = {
                replacement_path = _item_ranged.."/muzzles/galvanic_rifle_muzzle_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1.25, .15},
            },
            galvanic_rifle_muzzle_ml01 = {
                replacement_path = _item_ranged.."/muzzles/galvanic_rifle_muzzle_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1.25, .15},
            },
            galvanic_rifle_muzzle_deluxe01 = {
                replacement_path = _item_ranged.."/muzzles/galvanic_rifle_muzzle_deluxe01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1.25, .15},
            },
        },
        receiver = {
            galvanic_rifle_receiver_01 = {
                replacement_path = _item_ranged.."/recievers/galvanic_rifle_receiver_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.225, -1.5, .25},
            },
            galvanic_rifle_receiver_ml01 = {
                replacement_path = _item_ranged.."/recievers/galvanic_rifle_receiver_ml01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.225, -1.5, .25},
            },
            galvanic_rifle_receiver_deluxe01 = {
                replacement_path = _item_ranged.."/recievers/galvanic_rifle_receiver_deluxe01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.225, -1.5, .25},
            },
        },
        stock = {
            galvanic_rifle_stock_01 = {
                replacement_path = _item_ranged.."/stocks/galvanic_rifle_stock_01",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {-.2, -3, .2},
            },
            galvanic_rifle_stock_ml01 = {
                replacement_path = _item_ranged.."/stocks/galvanic_rifle_stock_ml01",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {-.2, -3, .2},
            },
            galvanic_rifle_stock_deluxe01 = {
                replacement_path = _item_ranged.."/stocks/galvanic_rifle_stock_deluxe01",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {-.2, -3, .2},
            },
        },
        underbarrel = {
            galvanic_rifle_underbarrel_01 = {
                replacement_path = _item_ranged.."/underbarrels/galvanic_rifle_underbarrel_01",
                icon_render_unit_rotation_offset = {90, 0, 40},
                icon_render_camera_position_offset = {.025, -3, .15},
            },
            galvanic_rifle_underbarrel_ml01 = {
                replacement_path = _item_ranged.."/underbarrels/galvanic_rifle_underbarrel_ml01",
                icon_render_unit_rotation_offset = {90, 0, 40},
                icon_render_camera_position_offset = {.025, -3, .15},
            },
            galvanic_rifle_underbarrel_deluxe01 = {
                replacement_path = _item_ranged.."/underbarrels/galvanic_rifle_underbarrel_deluxe01",
                icon_render_unit_rotation_offset = {90, 0, 40},
                icon_render_camera_position_offset = {.025, -3, .15},
            },
        },
    },
}
