local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local muzzle_lasgun_infantry = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/muzzle_lasgun_infantry")
local muzzle_lasgun_helbore = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/muzzle_lasgun_helbore")
-- local magazine_lasgun = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/magazine_lasgun")
local magazine_lasgun_infantry = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/magazine_lasgun_infantry")
local magazine_lasgun_helbore = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/magazine_lasgun_helbore")
-- local barrel_lasgun = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/barrel_lasgun")
local barrel_lasgun_helbore = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/barrel_lasgun_helbore")
local barrel_common = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/barrel_common")
local stock_common = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/stock_common")
local grip_common = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/grip_common")
-- local muzzle_laspistol = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/muzzle_laspistol")
-- local muzzle_lasgun = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/muzzle_lasgun")
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
    local table_merge_recursive_n = table.merge_recursive_n
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
        sight = {
            lasgun_rifle_krieg_sight_01 = {
                replacement_path = _item_ranged.."/sights/lasgun_rifle_krieg_sight_01",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .175},
            },
            lasgun_p2_us003_1545_sight_01 = {
                replacement_path = _item_ranged.."/sights/lasgun_p2_us003_1545_sight_01",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .175},
                hide_from_selection = true,
            },
        },
        muzzle = table_merge_recursive_n(nil, muzzle_lasgun_infantry, muzzle_lasgun_helbore),
        receiver = {
            lasgun_rifle_krieg_receiver_01 = {
                replacement_path = _item_ranged.."/recievers/lasgun_rifle_krieg_receiver_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -1.75, .25},
            },
            lasgun_rifle_krieg_receiver_02 = {
                replacement_path = _item_ranged.."/recievers/lasgun_rifle_krieg_receiver_02",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -1.75, .25},
            },
            lasgun_rifle_krieg_receiver_04 = {
                replacement_path = _item_ranged.."/recievers/lasgun_rifle_krieg_receiver_04",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -1.75, .25},
            },
            lasgun_rifle_krieg_receiver_05 = {
                replacement_path = _item_ranged.."/recievers/lasgun_rifle_krieg_receiver_05",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.35, -3.5, .25},
            },
            lasgun_rifle_krieg_receiver_06 = {
                replacement_path = _item_ranged.."/recievers/lasgun_rifle_krieg_receiver_06",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -1.75, .25},
            },
            lasgun_rifle_krieg_receiver_ml01 = {
                replacement_path = _item_ranged.."/recievers/lasgun_rifle_krieg_receiver_ml01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -1.75, .25},
            },
        },
        magazine = table_merge_recursive_n(nil, magazine_lasgun_infantry, magazine_lasgun_helbore),
        barrel = table_merge_recursive_n(nil, barrel_lasgun_helbore, barrel_common),
        stock = {
            lasgun_rifle_krieg_stock_01 = {
                replacement_path = _item_ranged.."/stocks/lasgun_rifle_krieg_stock_01",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.2, -3, .2},
            },
            lasgun_rifle_krieg_stock_02 = {
                replacement_path = _item_ranged.."/stocks/lasgun_rifle_krieg_stock_02",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.2, -3, .2},
            },
            lasgun_rifle_krieg_stock_04 = {
                replacement_path = _item_ranged.."/stocks/lasgun_rifle_krieg_stock_04",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.2, -3, .2},
            },
            lasgun_rifle_krieg_stock_05 = {
                replacement_path = _item_ranged.."/stocks/lasgun_rifle_krieg_stock_05",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.2, -2.5, .2},
            },
            lasgun_rifle_krieg_stock_ml01 = {
                replacement_path = _item_ranged.."/stocks/lasgun_rifle_krieg_stock_ml01",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.2, -3, .2},
            },
        },
    },
}
