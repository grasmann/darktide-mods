local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local magazine_lasgun_infantry = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/magazine_lasgun_infantry")
local magazine_lasgun_helbore = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/magazine_lasgun_helbore")
-- local magazine_lasgun = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/magazine_lasgun")
local grip_lasgun = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/grip_lasgun")
-- local barrel_lasgun = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/barrel_lasgun")
local barrel_lasgun_infantry = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/barrel_lasgun_infantry")
local barrel_common = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/barrel_common")
local stock_common = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/stock_common")
local grip_common = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/grip_common")
local muzzle_laspistol = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/muzzle_laspistol")
local muzzle_lasgun = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/muzzle_lasgun")
local trinket_hooks = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/trinket_hook")
local emblem_right = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/emblem_right")
local emblem_left = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/emblem_left")
local flashlights = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/flashlight")
local sights = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/sight")
local rails = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/rail")

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
        grip = table_merge_recursive_n(nil, grip_lasgun, grip_common),
        stock = table_merge_recursive({
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
        }, stock_common),
        muzzle = table_merge_recursive_n(nil, muzzle_lasgun, muzzle_laspistol),
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
            lasgun_rifle_receiver_01_cinematic_01 = {
                replacement_path = _item_ranged.."/recievers/lasgun_rifle_receiver_01_cinematic_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -2.75, .25},
                hide_from_selection = true,
            },
            lasgun_rifle_receiver_01_cinematic_02 = {
                replacement_path = _item_ranged.."/recievers/lasgun_rifle_receiver_01_cinematic_02",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -2.75, .25},
                hide_from_selection = true,
            },
            lasgun_rifle_receiver_01_cinematic_03 = {
                replacement_path = _item_ranged.."/recievers/lasgun_rifle_receiver_01_cinematic_03",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -2.75, .25},
                hide_from_selection = true,
            },
        },
        magazine = table_merge_recursive_n(nil, magazine_lasgun_infantry, magazine_lasgun_helbore),
        barrel = table_merge_recursive_n(nil, barrel_lasgun_infantry, barrel_common),
    },
}
