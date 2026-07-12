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
            arc_rifle_barrel_01 = {
                replacement_path = _item_ranged.."/barrels/arc_rifle_barrel_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.175, -2, .15},
            },
            arc_rifle_barrel_ml01 = {
                replacement_path = _item_ranged.."/barrels/arc_rifle_barrel_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.175, -2, .15},
            },
            arc_rifle_barrel_deluxe01 = {
                replacement_path = _item_ranged.."/barrels/arc_rifle_barrel_deluxe01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.175, -2, .15},
            },
        },
        muzzle = {
            arc_rifle_muzzle_01 = {
                replacement_path = _item_ranged.."/muzzles/arc_rifle_muzzle_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
            arc_rifle_muzzle_ml01 = {
                replacement_path = _item_ranged.."/muzzles/arc_rifle_muzzle_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
            arc_rifle_muzzle_deluxe01 = {
                replacement_path = _item_ranged.."/muzzles/arc_rifle_muzzle_deluxe01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
        },
        magazine = {
            arc_rifle_magazine_01 = {
                replacement_path = _item_ranged.."/magazines/arc_rifle_magazine_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.05, -1, .15},
            },
            arc_rifle_magazine_ml01 = {
                replacement_path = _item_ranged.."/magazines/arc_rifle_magazine_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.05, -1, .15},
            },
            arc_rifle_magazine_deluxe01 = {
                replacement_path = _item_ranged.."/magazines/arc_rifle_magazine_deluxe01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.05, -1, .15},
            },
        },
        receiver = {
            arc_rifle_receiver_01 = {
                replacement_path = _item_ranged.."/recievers/arc_rifle_receiver_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.175, -2, .25},
            },
            arc_rifle_receiver_ml01 = {
                replacement_path = _item_ranged.."/recievers/arc_rifle_receiver_ml01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.175, -2, .25},
            },
            arc_rifle_receiver_deluxe01 = {
                replacement_path = _item_ranged.."/recievers/arc_rifle_receiver_deluxe01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.175, -2, .25},
            },
        },
        stock = {
            arc_rifle_stock_01 = {
                replacement_path = _item_ranged.."/stocks/arc_rifle_stock_01",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.15, -1, .075},
            },
            arc_rifle_stock_ml01 = {
                replacement_path = _item_ranged.."/stocks/arc_rifle_stock_ml01",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.15, -1, .075},
            },
            arc_rifle_stock_deluxe01 = {
                replacement_path = _item_ranged.."/stocks/arc_rifle_stock_deluxe01",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.15, -1, .075},
            },
        },
        grip = {
            arc_rifle_grip_01 = {
                replacement_path = _item_ranged.."/grips/arc_rifle_grip_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            arc_rifle_grip_ml01 = {
                replacement_path = _item_ranged.."/grips/arc_rifle_grip_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            arc_rifle_grip_deluxe01 = {
                replacement_path = _item_ranged.."/grips/arc_rifle_grip_deluxe01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
        },
        underbarrel = {
            arc_rifle_underbarrel_01 = {
                replacement_path = _item_ranged.."/underbarrels/arc_rifle_underbarrel_01",
                icon_render_unit_rotation_offset = {90, 0, 40},
                icon_render_camera_position_offset = {-.25, -3, .25},
            },
            arc_rifle_underbarrel_ml01 = {
                replacement_path = _item_ranged.."/underbarrels/arc_rifle_underbarrel_ml01",
                icon_render_unit_rotation_offset = {90, 0, 40},
                icon_render_camera_position_offset = {-.25, -3, .25},
            },
            arc_rifle_underbarrel_deluxe01 = {
                replacement_path = _item_ranged.."/underbarrels/arc_rifle_underbarrel_deluxe01",
                icon_render_unit_rotation_offset = {90, 0, 40},
                icon_render_camera_position_offset = {-.25, -3, .25},
            },
        },
    },
}
