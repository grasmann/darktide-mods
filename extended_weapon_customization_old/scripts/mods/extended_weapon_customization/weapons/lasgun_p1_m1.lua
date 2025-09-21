local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local trinket_hooks = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/trinket_hook")
local flashlights = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/flashlight")
local sights = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/sight")
local rails = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/rail")
local emblem_left = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/emblem_left")
local emblem_right = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/emblem_right")

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

local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local scopes = "scope_01"

return {
    attachments = {
        emblem_left = emblem_left,
        emblem_right = emblem_right,
        trinket_hook = trinket_hooks,
        flashlight = flashlights,
        rail = rails,
        sight = sights,
        grip = {
            lasgun_rifle_grip_01 = {
                replacement_path = _item_ranged.."/grips/lasgun_rifle_grip_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            lasgun_rifle_grip_02 = {
                replacement_path = _item_ranged.."/grips/lasgun_rifle_grip_02",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            lasgun_rifle_grip_03 = {
                replacement_path = _item_ranged.."/grips/lasgun_rifle_grip_03",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            lasgun_rifle_grip_04 = {
                replacement_path = _item_ranged.."/grips/lasgun_rifle_grip_04",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
        },
        stock = {
            lasgun_rifle_stock_01 = {
                replacement_path = _item_ranged.."/stocks/lasgun_rifle_stock_01",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.1, -1.5, .2},
            },
            lasgun_rifle_stock_02 = {
                replacement_path = _item_ranged.."/stocks/lasgun_rifle_stock_02",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.1, -1.5, .2},
            },
            lasgun_rifle_stock_03 = {
                replacement_path = _item_ranged.."/stocks/lasgun_rifle_stock_03",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.1, -1.5, .2},
            },
            lasgun_rifle_stock_04 = {
                replacement_path = _item_ranged.."/stocks/lasgun_rifle_stock_04",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.1, -1.5, .2},
            },
            lasgun_rifle_stock_05 = {
                replacement_path = _item_ranged.."/stocks/lasgun_rifle_stock_05",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.1, -1.5, .2},
            },
        },
        muzzle = {
            lasgun_rifle_muzzle_01 = {
                replacement_path = _item_ranged.."/muzzles/lasgun_rifle_muzzle_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
            lasgun_rifle_muzzle_02 = {
                replacement_path = _item_ranged.."/muzzles/lasgun_rifle_muzzle_02",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
            lasgun_rifle_muzzle_03 = {
                replacement_path = _item_ranged.."/muzzles/lasgun_rifle_muzzle_03",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
            lasgun_rifle_muzzle_04 = {
                replacement_path = _item_ranged.."/muzzles/lasgun_rifle_muzzle_04",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
            lasgun_rifle_muzzle_ml01 = {
                replacement_path = _item_ranged.."/muzzles/lasgun_rifle_muzzle_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
        },
        receiver = {
            lasgun_rifle_receiver_01 = {
                replacement_path = _item_ranged.."/recievers/lasgun_rifle_receiver_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -2.75, .25},
            },
            lasgun_rifle_receiver_02 = {
                replacement_path = _item_ranged.."/recievers/lasgun_rifle_receiver_02",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.3, -3.75, .25},
            },
            lasgun_rifle_receiver_03 = {
                replacement_path = _item_ranged.."/recievers/lasgun_rifle_receiver_03",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -2.75, .25},
            },
            lasgun_rifle_receiver_ml01 = {
                replacement_path = _item_ranged.."/recievers/lasgun_rifle_receiver_ml01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -2.75, .25},
            },
        },
        magazine = {
            lasgun_rifle_magazine_01 = {
                replacement_path = _item_ranged.."/magazines/lasgun_rifle_magazine_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.1, -1.5, -.05},
            },
            lasgun_rifle_magazine_ml01 = {
                replacement_path = _item_ranged.."/magazines/lasgun_rifle_magazine_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.1, -1.5, -.05},
            },
        },
        barrel = {
            lasgun_rifle_barrel_01 = {
                replacement_path = _item_ranged.."/barrels/lasgun_rifle_barrel_01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.175, -2, 0},
            },
            lasgun_rifle_barrel_02 = {
                replacement_path = _item_ranged.."/barrels/lasgun_rifle_barrel_02",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.175, -2, 0},
            },
            lasgun_rifle_barrel_03 = {
                replacement_path = _item_ranged.."/barrels/lasgun_rifle_barrel_03",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.175, -2, 0},
            },
            lasgun_rifle_barrel_04 = {
                replacement_path = _item_ranged.."/barrels/lasgun_rifle_barrel_04",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.175, -2, 0},
            },
            lasgun_rifle_barrel_05 = {
                replacement_path = _item_ranged.."/barrels/lasgun_rifle_barrel_05",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.175, -2, 0},
            },
            lasgun_rifle_barrel_06 = {
                replacement_path = _item_ranged.."/barrels/lasgun_rifle_barrel_06",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.175, -2, 0},
            },
            lasgun_rifle_barrel_07 = {
                replacement_path = _item_ranged.."/barrels/lasgun_rifle_barrel_07",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.175, -2, 0},
            },
            lasgun_rifle_barrel_08 = {
                replacement_path = _item_ranged.."/barrels/lasgun_rifle_barrel_08",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.175, -2, 0},
            },
            lasgun_rifle_barrel_09 = {
                replacement_path = _item_ranged.."/barrels/lasgun_rifle_barrel_09",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.175, -2, 0},
            },
            lasgun_rifle_barrel_ml01 = {
                replacement_path = _item_ranged.."/barrels/lasgun_rifle_barrel_ml01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.175, -2, 0},
            },
        },
    },
}
