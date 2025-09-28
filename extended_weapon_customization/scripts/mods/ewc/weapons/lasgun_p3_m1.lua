local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local magazine_lasgun_recon = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/magazine_lasgun_recon")
-- local magazine_lasgun = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/magazine_lasgun")
local grip_lasgun = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/grip_lasgun")
-- local barrel_lasgun = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/barrel_lasgun")
local barrel_lasgun_recon = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/barrel_lasgun_recon")
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
        sight = table_merge_recursive({
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
        }, sights),
        muzzle = table_merge_recursive_n(nil, muzzle_lasgun, muzzle_laspistol),
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
            lasgun_rifle_elysian_stock_ml01 = {
                replacement_path = _item_ranged.."/stocks/lasgun_rifle_elysian_stock_ml01",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.1, -2, .2},
            },
        },
        grip = table_merge_recursive_n(nil, grip_lasgun, grip_common),
    },
    fixes = {
        {attachment_slot = "sight_offset",
            requirements = {
                sight = {
                    has = reflex_sights.."|"..scopes,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.0335),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        {attachment_slot = "sight",
            requirements = {
                sight = {
                    has = reflex_sights.."|"..scopes,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .05, .0075),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        {attachment_slot = "rail",
            requirements = {
                sight = {
                    has = reflex_sights.."|"..scopes,
                },
            },
            fix = {
                attach = {
                    rail = "lasgun_rifle_rail_01",
                },
                offset = {
                    position = vector3_box(0, .0185, .0075),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, .9, 1),
                    node = 1,
                },
            },
        },
    },
}
