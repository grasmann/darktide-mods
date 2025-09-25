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
            shotgun_double_barrel_sight_01 = {
                replacement_path = _item_ranged.."/sights/shotgun_double_barrel_sight_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -1.5, .25},
            },
        }, sights),
        receiver = {
            shotgun_double_barrel_receiver_01 = {
                replacement_path = _item_ranged.."/recievers/shotgun_double_barrel_receiver_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -1.5, .25},
            },
            shotgun_double_barrel_receiver_02 = {
                replacement_path = _item_ranged.."/recievers/shotgun_double_barrel_receiver_02",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -1.5, .25},
            },
            shotgun_double_barrel_receiver_03 = {
                replacement_path = _item_ranged.."/recievers/shotgun_double_barrel_receiver_03",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -1.5, .25},
            },
            shotgun_double_barrel_receiver_ml01 = {
                replacement_path = _item_ranged.."/recievers/shotgun_double_barrel_receiver_ml01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -1.5, .25},
            },
        },
        stock = {
            shotgun_double_barrel_stock_01 = {
                replacement_path = _item_ranged.."/stocks/shotgun_double_barrel_stock_01",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.15, -2, .2},
            },
            shotgun_double_barrel_stock_02 = {
                replacement_path = _item_ranged.."/stocks/shotgun_double_barrel_stock_02",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.15, -2, .2},
            },
            shotgun_double_barrel_stock_03 = {
                replacement_path = _item_ranged.."/stocks/shotgun_double_barrel_stock_03",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.15, -2, .2},
            },
            shotgun_double_barrel_stock_ml01 = {
                replacement_path = _item_ranged.."/stocks/shotgun_double_barrel_stock_ml01",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.15, -2, .2},
            },
        },
        barrel = {
            shotgun_double_barrel_01 = {
                replacement_path = _item_ranged.."/barrels/shotgun_double_barrel_01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.175, -2.25, .1},
            },
            shotgun_double_barrel_02 = {
                replacement_path = _item_ranged.."/barrels/shotgun_double_barrel_02",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.2, -2.75, .1},
            },
            shotgun_double_barrel_03 = {
                replacement_path = _item_ranged.."/barrels/shotgun_double_barrel_03",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.25, -3.5, 0},
            },
            shotgun_double_barrel_ml01 = {
                replacement_path = _item_ranged.."/barrels/shotgun_double_barrel_ml01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.25, -3.5, 0},
            },
        },
    },
}
