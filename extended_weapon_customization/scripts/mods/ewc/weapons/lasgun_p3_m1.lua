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
            lasgun_rifle_elysian_sight_01 = {
                replacement_path = _item_ranged.."/sights/lasgun_rifle_elysian_sight_01",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .175},
            },
            lasgun_rifle_elysian_sight_02 = {
                replacement_path = _item_ranged.."/sights/lasgun_rifle_elysian_sight_02",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .175},
            },
            lasgun_rifle_elysian_sight_03 = {
                replacement_path = _item_ranged.."/sights/lasgun_rifle_elysian_sight_03",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .175},
            },
        }, sights),
        muzzle = {
            lasgun_rifle_elysian_muzzle_01 = {
                replacement_path = _item_ranged.."/muzzles/lasgun_rifle_elysian_muzzle_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
            lasgun_rifle_elysian_muzzle_02 = {
                replacement_path = _item_ranged.."/muzzles/lasgun_rifle_elysian_muzzle_02",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
            lasgun_rifle_elysian_muzzle_03 = {
                replacement_path = _item_ranged.."/muzzles/lasgun_rifle_elysian_muzzle_03",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
            lasgun_rifle_elysian_muzzle_ml01 = {
                replacement_path = _item_ranged.."/muzzles/lasgun_rifle_elysian_muzzle_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
        },
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
        magazine = {
            lasgun_elysian_magazine_01 = {
                replacement_path = _item_ranged.."/magazines/lasgun_elysian_magazine_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.1, -1.5, -.05},
            },
            lasgun_elysian_magazine_ml01 = {
                replacement_path = _item_ranged.."/magazines/lasgun_elysian_magazine_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.1, -1.5, -.05},
            },
        },
        barrel = {
            lasgun_rifle_elysian_barrel_01 = {
                replacement_path = _item_ranged.."/barrels/lasgun_rifle_elysian_barrel_01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.115, -1.5, 0},
            },
            lasgun_rifle_elysian_barrel_02 = {
                replacement_path = _item_ranged.."/barrels/lasgun_rifle_elysian_barrel_02",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.115, -1.5, 0},
            },
            lasgun_rifle_elysian_barrel_03 = {
                replacement_path = _item_ranged.."/barrels/lasgun_rifle_elysian_barrel_03",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.115, -1.5, 0},
            },
            lasgun_rifle_elysian_barrel_04 = {
                replacement_path = _item_ranged.."/barrels/lasgun_rifle_elysian_barrel_04",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.115, -1.5, 0},
            },
            lasgun_rifle_elysian_barrel_05 = {
                replacement_path = _item_ranged.."/barrels/lasgun_rifle_elysian_barrel_05",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.115, -1.5, 0},
            },
        },
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
        grip = {
            lasgun_rifle_elysian_grip_02 = {
                replacement_path = _item_ranged.."/grips/lasgun_rifle_elysian_grip_02",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            lasgun_rifle_elysian_grip_03 = {
                replacement_path = _item_ranged.."/grips/lasgun_rifle_elysian_grip_03",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            lasgun_rifle_elysian_grip_ml01 = {
                replacement_path = _item_ranged.."/grips/lasgun_rifle_elysian_grip_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
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
