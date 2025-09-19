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
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local scopes = "scope_01"

return {
    attachments = {
        emblem_left = emblem_left,
        emblem_right = emblem_right,
        trinket_hook = trinket_hooks,
        flashlight = flashlights,
        receiver = {
            plasma_rifle_receiver_01 = {
                replacement_path = _item_ranged.."/recievers/plasma_rifle_receiver_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.1, -1.75, .25},
            },
            plasma_rifle_receiver_02 = {
                replacement_path = _item_ranged.."/recievers/plasma_rifle_receiver_02",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.1, -1.75, .25},
            },
            plasma_rifle_receiver_03 = {
                replacement_path = _item_ranged.."/recievers/plasma_rifle_receiver_03",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.1, -1.75, .25},
            },
            plasma_rifle_receiver_ml01 = {
                replacement_path = _item_ranged.."/recievers/plasma_rifle_receiver_ml01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.1, -1.75, .25},
            },
        },
        magazine = {
            plasma_rifle_magazine_01 = {
                replacement_path = _item_ranged.."/magazines/plasma_rifle_magazine_01",
                icon_render_unit_rotation_offset = {90, 30, 30},
                icon_render_camera_position_offset = {-.05, -1, .075},
            },
            plasma_rifle_magazine_02 = {
                replacement_path = _item_ranged.."/magazines/plasma_rifle_magazine_02",
                icon_render_unit_rotation_offset = {90, 30, 30},
                icon_render_camera_position_offset = {-.05, -1, .075},
            },
            plasma_rifle_magazine_03 = {
                replacement_path = _item_ranged.."/magazines/plasma_rifle_magazine_03",
                icon_render_unit_rotation_offset = {90, 30, 30},
                icon_render_camera_position_offset = {-.05, -1, .075},
            },
            plasma_rifle_magazine_04 = {
                replacement_path = _item_ranged.."/magazines/plasma_rifle_magazine_04",
                icon_render_unit_rotation_offset = {90, 30, 30},
                icon_render_camera_position_offset = {-.05, -1, .075},
            },
            plasma_rifle_magazine_06 = {
                replacement_path = _item_ranged.."/magazines/plasma_rifle_magazine_06",
                icon_render_unit_rotation_offset = {90, 30, 30},
                icon_render_camera_position_offset = {-.05, -1, .075},
            },
            plasma_rifle_magazine_ml01 = {
                replacement_path = _item_ranged.."/magazines/plasma_rifle_magazine_ml01",
                icon_render_unit_rotation_offset = {90, 30, 30},
                icon_render_camera_position_offset = {-.05, -1, .075},
            },
        },
        barrel = {
            plasma_rifle_barrel_01 = {
                replacement_path = _item_ranged.."/barrels/plasma_rifle_barrel_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.3, -3, .175},
            },
            plasma_rifle_barrel_02 = {
                replacement_path = _item_ranged.."/barrels/plasma_rifle_barrel_02",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.3, -3, .175},
            },
            plasma_rifle_barrel_03 = {
                replacement_path = _item_ranged.."/barrels/plasma_rifle_barrel_03",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.3, -3, .175},
            },
            plasma_rifle_barrel_04 = {
                replacement_path = _item_ranged.."/barrels/plasma_rifle_barrel_04",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.3, -3, .175},
            },
            plasma_rifle_barrel_05 = {
                replacement_path = _item_ranged.."/barrels/plasma_rifle_barrel_05",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.3, -3, .175},
            },
            plasma_rifle_barrel_07 = {
                replacement_path = _item_ranged.."/barrels/plasma_rifle_barrel_08",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.3, -3, .175},
            },
            plasma_rifle_barrel_ml01 = {
                replacement_path = _item_ranged.."/barrels/plasma_rifle_barrel_ml01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.3, -3, .175},
            },
        },
        stock = {
            plasma_rifle_stock_01 = {
                replacement_path = _item_ranged.."/stocks/plasma_rifle_stock_01",
                icon_render_unit_rotation_offset = {90, -45, -60},
                icon_render_camera_position_offset = {.035, -.5, .15},
            },
            plasma_rifle_stock_02 = {
                replacement_path = _item_ranged.."/stocks/plasma_rifle_stock_02",
                icon_render_unit_rotation_offset = {90, -45, -60},
                icon_render_camera_position_offset = {.035, -.5, .15},
            },
            plasma_rifle_stock_03 = {
                replacement_path = _item_ranged.."/stocks/plasma_rifle_stock_03",
                icon_render_unit_rotation_offset = {90, -45, -60},
                icon_render_camera_position_offset = {.035, -.5, .15},
            },
            plasma_rifle_stock_04 = {
                replacement_path = _item_ranged.."/stocks/plasma_rifle_stock_04",
                icon_render_unit_rotation_offset = {90, -45, -60},
                icon_render_camera_position_offset = {.035, -.5, .15},
            },
            plasma_rifle_stock_05 = {
                replacement_path = _item_ranged.."/stocks/plasma_rifle_stock_05",
                icon_render_unit_rotation_offset = {90, -45, -60},
                icon_render_camera_position_offset = {.035, -.5, .15},
            },
            plasma_rifle_stock_07 = {
                replacement_path = _item_ranged.."/stocks/plasma_rifle_stock_07",
                icon_render_unit_rotation_offset = {90, -45, -60},
                icon_render_camera_position_offset = {.035, -.5, .15},
            },
            plasma_rifle_stock_08 = {
                replacement_path = _item_ranged.."/stocks/plasma_rifle_stock_08",
                icon_render_unit_rotation_offset = {90, -45, -60},
                icon_render_camera_position_offset = {.035, -.5, .15},
            },
            plasma_rifle_stock_ml01 = {
                replacement_path = _item_ranged.."/stocks/plasma_rifle_stock_ml01",
                icon_render_unit_rotation_offset = {90, -45, -60},
                icon_render_camera_position_offset = {.035, -.5, .15},
            },
        },
        grip = {
            plasma_rifle_grip_01 = {
                replacement_path = _item_ranged.."/grips/plasma_rifle_grip_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            plasma_rifle_grip_02 = {
                replacement_path = _item_ranged.."/grips/plasma_rifle_grip_02",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            plasma_rifle_grip_03 = {
                replacement_path = _item_ranged.."/grips/plasma_rifle_grip_03",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            plasma_rifle_grip_04 = {
                replacement_path = _item_ranged.."/grips/plasma_rifle_grip_04",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            plasma_rifle_grip_05 = {
                replacement_path = _item_ranged.."/grips/plasma_rifle_grip_05",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
        },
    },
    attachment_slots = {
        flashlight = {
            parent_slot = "barrel",
            default_path = _item_empty_trinket,
            fix = {
                offset = {
                    position = vector3_box(.04, .27, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
    },
}
