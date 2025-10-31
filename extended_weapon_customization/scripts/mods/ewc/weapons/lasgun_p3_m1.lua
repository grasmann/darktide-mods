local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local magazine_lasgun_recon = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/magazine_lasgun_recon")
local muzzle_lasgun_recon = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/muzzle_lasgun_recon")
local barrel_lasgun_recon = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/barrel_lasgun_recon")
local barrel_common = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/barrel_common")
local trinket_hooks = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/trinket_hook")
local stock_common = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/stock_common")
local emblem_right = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/emblem_right")
local grip_common = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/grip_common")
local emblem_left = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/emblem_left")
local grip_lasgun = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/grip_lasgun")
local flashlights = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/flashlight")

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
        flashlight = flashlights,
        sight = {
            lasgun_rifle_elysian_sight_01 = {
                replacement_path = _item_ranged.."/sights/lasgun_rifle_elysian_sight_01",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .175},
                hide_from_selection = true,
            },
            lasgun_rifle_elysian_sight_02 = {
                replacement_path = _item_ranged.."/sights/lasgun_rifle_elysian_sight_02",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .175},
                hide_from_selection = true,
            },
            lasgun_rifle_elysian_sight_03 = {
                replacement_path = _item_ranged.."/sights/lasgun_rifle_elysian_sight_03",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .175},
                hide_from_selection = true,
            },
        },
        muzzle = muzzle_lasgun_recon,
        receiver = {
            lasgun_rifle_elysian_receiver_01 = {
                replacement_path = _item_ranged.."/recievers/lasgun_rifle_elysian_receiver_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.25, -3, .25},
            },
            lasgun_rifle_elysian_receiver_02 = {
                replacement_path = _item_ranged.."/recievers/lasgun_rifle_elysian_receiver_02",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.25, -3, .25},
            },
            lasgun_rifle_elysian_receiver_03 = {
                replacement_path = _item_ranged.."/recievers/lasgun_rifle_elysian_receiver_03",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.25, -3, .25},
            },
            lasgun_rifle_elysian_receiver_04 = {
                replacement_path = _item_ranged.."/recievers/lasgun_rifle_elysian_receiver_04",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.25, -3, .25},
            },
            lasgun_rifle_elysian_receiver_05 = {
                replacement_path = _item_ranged.."/recievers/lasgun_rifle_elysian_receiver_05",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.25, -3, .25},
            },
            lasgun_rifle_elysian_receiver_06 = {
                replacement_path = _item_ranged.."/recievers/lasgun_rifle_elysian_receiver_06",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.25, -3, .25},
            },
            lasgun_rifle_elysian_receiver_07 = {
                replacement_path = _item_ranged.."/recievers/lasgun_rifle_elysian_receiver_07",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.25, -3, .25},
            },
            lasgun_rifle_elysian_receiver_08 = {
                replacement_path = _item_ranged.."/recievers/lasgun_rifle_elysian_receiver_08",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.25, -3, .25},
            },
            lasgun_rifle_elysian_receiver_ml01 = {
                replacement_path = _item_ranged.."/recievers/lasgun_rifle_elysian_receiver_ml01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.25, -3, .25},
            },
        },
        magazine = magazine_lasgun_recon,
        barrel = table_merge_recursive_n(nil, barrel_lasgun_recon, barrel_common),
        stock = {
            lasgun_rifle_elysian_stock_01 = {
                replacement_path = _item_ranged.."/stocks/lasgun_rifle_elysian_stock_01",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.1, -2, .2},
            },
            lasgun_rifle_elysian_stock_02 = {
                replacement_path = _item_ranged.."/stocks/lasgun_rifle_elysian_stock_02",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.1, -2, .2},
            },
            lasgun_rifle_elysian_stock_03 = {
                replacement_path = _item_ranged.."/stocks/lasgun_rifle_elysian_stock_03",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.1, -2, .2},
            },
            lasgun_rifle_elysian_stock_04 = {
                replacement_path = _item_ranged.."/stocks/lasgun_rifle_elysian_stock_04",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.1, -2, .2},
            },
            lasgun_rifle_elysian_stock_ml01 = {
                replacement_path = _item_ranged.."/stocks/lasgun_rifle_elysian_stock_ml01",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.1, -2, .2},
            },
        },
        grip = table_merge_recursive_n(nil, grip_lasgun, grip_common),
    },
}
