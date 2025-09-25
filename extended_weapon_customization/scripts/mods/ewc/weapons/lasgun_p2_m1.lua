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
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

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
        }, sights),
        muzzle = {
            lasgun_rifle_krieg_muzzle_02 = {
                replacement_path = _item_ranged.."/muzzles/lasgun_rifle_krieg_muzzle_02",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.2, -1.5, .15},
            },
            lasgun_rifle_krieg_muzzle_04 = {
                replacement_path = _item_ranged.."/muzzles/lasgun_rifle_krieg_muzzle_04",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
            lasgun_rifle_krieg_muzzle_05 = {
                replacement_path = _item_ranged.."/muzzles/lasgun_rifle_krieg_muzzle_05",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
            lasgun_rifle_krieg_muzzle_06 = {
                replacement_path = _item_ranged.."/muzzles/lasgun_rifle_krieg_muzzle_06",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
            lasgun_rifle_krieg_muzzle_ml01 = {
                replacement_path = _item_ranged.."/muzzles/lasgun_rifle_krieg_muzzle_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
        },
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
            lasgun_rifle_krieg_receiver_03 = {
                replacement_path = _item_ranged.."/recievers/lasgun_rifle_krieg_receiver_03",
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
        magazine = {
            lasgun_krieg_magazine_01 = {
                replacement_path = _item_ranged.."/magazines/lasgun_krieg_magazine_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.1, -1.5, -.05},
            },
        },
        barrel = {
            lasgun_rifle_krieg_barrel_01 = {
                replacement_path = _item_ranged.."/barrels/lasgun_rifle_krieg_barrel_01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.2, -2.5, 0},
            },
            lasgun_rifle_krieg_barrel_02 = {
                replacement_path = _item_ranged.."/barrels/lasgun_rifle_krieg_barrel_02",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.25, -3, -.02},
            },
            lasgun_rifle_krieg_barrel_04 = {
                replacement_path = _item_ranged.."/barrels/lasgun_rifle_krieg_barrel_04",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.2, -2.5, 0},
            },
            lasgun_rifle_krieg_barrel_05 = {
                replacement_path = _item_ranged.."/barrels/lasgun_rifle_krieg_barrel_05",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.2, -2.5, 0},
            },
            lasgun_rifle_krieg_barrel_06 = {
                replacement_path = _item_ranged.."/barrels/lasgun_rifle_krieg_barrel_06",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.2, -2.5, 0},
            },
            lasgun_rifle_krieg_barrel_07 = {
                replacement_path = _item_ranged.."/barrels/lasgun_rifle_krieg_barrel_07",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.175, -2, 0},
            },
            lasgun_rifle_krieg_barrel_08 = {
                replacement_path = _item_ranged.."/barrels/lasgun_rifle_krieg_barrel_08",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.2, -2.5, 0},
            },
            lasgun_rifle_krieg_barrel_ml01 = {
                replacement_path = _item_ranged.."/barrels/lasgun_rifle_krieg_barrel_ml01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.2, -2.5, 0},
            },
        },
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
    fixes = {
        {attachment_slot = "sight_offset",
            requirements = {
                sight = {
                    has = reflex_sights.."|"..scopes,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.0275),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
    },
}
