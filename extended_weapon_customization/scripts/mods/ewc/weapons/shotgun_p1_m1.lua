local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local trinket_hooks = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/trinket_hook")
local flashlights = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/flashlight")
local sights = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/sight")
local rails = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/rail")
local emblem_left = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/emblem_left")
local emblem_right = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/emblem_right")

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
        sight = table_merge_recursive({
            shotgun_rifle_sight_01 = {
                replacement_path = _item_ranged.."/sights/shotgun_rifle_sight_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.05, -1.5, .15},
            },
            shotgun_rifle_sight_04 = {
                replacement_path = _item_ranged.."/sights/shotgun_rifle_sight_04",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.05, -1.5, .15},
            },
        }, sights),
        underbarrel = {
            shotgun_rifle_underbarrel_01 = {
                replacement_path = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.05, -1.5, .15},
            },
            shotgun_rifle_underbarrel_04 = {
                replacement_path = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_04",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.1, -2.25, .15},
            },
            shotgun_rifle_underbarrel_05 = {
                replacement_path = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_05",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.05, -1.5, .15},
            },
            shotgun_rifle_underbarrel_06 = {
                replacement_path = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_06",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.05, -1.5, .15},
            },
            shotgun_rifle_underbarrel_07 = {
                replacement_path = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_07",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.05, -1.5, .15},
            },
            shotgun_rifle_underbarrel_08 = {
                replacement_path = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_08",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.05, -1.5, .15},
            },
            shotgun_pump_action_underbarrel_01 = {
                replacement_path = _item_ranged.."/underbarrels/shotgun_pump_action_underbarrel_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.1, -2.25, .15},
            },
            shotgun_pump_action_underbarrel_02 = {
                replacement_path = _item_ranged.."/underbarrels/shotgun_pump_action_underbarrel_02",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.1, -2.25, .15},
            },
            shotgun_pump_action_underbarrel_03 = {
                replacement_path = _item_ranged.."/underbarrels/shotgun_pump_action_underbarrel_03",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.1, -2.25, .15},
            },
        },
        receiver = {
            shotgun_rifle_receiver_01 = {
                replacement_path = _item_ranged.."/recievers/shotgun_rifle_receiver_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -1.75, .25},
            },
            shotgun_rifle_receiver_ml01 = {
                replacement_path = _item_ranged.."/recievers/shotgun_rifle_receiver_ml01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -1.75, .25},
            },
        },
        stock = {
            shotgun_rifle_stock_01 = {
                replacement_path = _item_ranged.."/stocks/shotgun_rifle_stock_01",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.15, -2, .2},
            },
            shotgun_rifle_stock_03 = {
                replacement_path = _item_ranged.."/stocks/shotgun_rifle_stock_03",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.15, -2, .2},
            },
            shotgun_rifle_stock_05 = {
                replacement_path = _item_ranged.."/stocks/shotgun_rifle_stock_05",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.15, -2, .2},
            },
            shotgun_rifle_stock_06 = {
                replacement_path = _item_ranged.."/stocks/shotgun_rifle_stock_06",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.15, -2, .2},
            },
            shotgun_rifle_stock_07 = {
                replacement_path = _item_ranged.."/stocks/shotgun_rifle_stock_07",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.15, -2, .2},
            },
            shotgun_rifle_stock_08 = {
                replacement_path = _item_ranged.."/stocks/shotgun_rifle_stock_08",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.15, -2, .2},
            },
            shotgun_rifle_stock_09 = {
                replacement_path = _item_ranged.."/stocks/shotgun_rifle_stock_09",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.15, -2, .2},
            },
            shotgun_rifle_stock_ml01 = {
                replacement_path = _item_ranged.."/stocks/shotgun_rifle_stock_ml01",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.15, -2, .2},
            },
        },
        barrel = {
            shotgun_rifle_barrel_01 = {
                replacement_path = _item_ranged.."/barrels/shotgun_rifle_barrel_01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.25, -2.5, 0},
            },
            shotgun_rifle_barrel_04 = {
                replacement_path = _item_ranged.."/barrels/shotgun_rifle_barrel_04",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.325, -3.25, -.1},
            },
            shotgun_rifle_barrel_05 = {
                replacement_path = _item_ranged.."/barrels/shotgun_rifle_barrel_05",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.25, -2.5, 0},
            },
            shotgun_rifle_barrel_06 = {
                replacement_path = _item_ranged.."/barrels/shotgun_rifle_barrel_06",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.25, -2.5, 0},
            },
            shotgun_rifle_barrel_07 = {
                replacement_path = _item_ranged.."/barrels/shotgun_rifle_barrel_07",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.25, -2.5, 0},
            },
            shotgun_rifle_barrel_08 = {
                replacement_path = _item_ranged.."/barrels/shotgun_rifle_barrel_08",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.25, -2.5, 0},
            },
            shotgun_rifle_barrel_09 = {
                replacement_path = _item_ranged.."/barrels/shotgun_rifle_barrel_09",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.25, -2.5, 0},
            },
            shotgun_rifle_barrel_ml01 = {
                replacement_path = _item_ranged.."/barrels/shotgun_rifle_barrel_ml01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.25, -2.5, 0},
            },
        },
    },
}
