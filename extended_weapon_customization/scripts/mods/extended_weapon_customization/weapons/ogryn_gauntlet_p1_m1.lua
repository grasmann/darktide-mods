local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local trinket_hooks = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/trinket_hook")
local emblem_left = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/emblem_left")
local emblem_right = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/emblem_right")
local flashlights = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/ogryn_flashlight")

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
local _item_melee = _item.."/melee"
local _item_ranged = _item.."/ranged"
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

return {
    attachments = {
        emblem_left = emblem_left,
        emblem_right = emblem_right,
        trinket_hook = trinket_hooks,
        flashlight = flashlights,
        barrel = {
            gauntlet_basic_barrel_01 = {
                replacement_path = _item_ranged.."/barrels/gauntlet_basic_barrel_01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {0, -9, 0},
            },
            gauntlet_basic_barrel_02 = {
                replacement_path = _item_ranged.."/barrels/gauntlet_basic_barrel_02",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {0, -9, 0},
            },
            gauntlet_basic_barrel_03 = {
                replacement_path = _item_ranged.."/barrels/gauntlet_basic_barrel_03",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {0, -9, 0},
            },
            gauntlet_basic_barrel_04 = {
                replacement_path = _item_ranged.."/barrels/gauntlet_basic_barrel_04",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {0, -9, 0},
            },
            gauntlet_basic_barrel_05 = {
                replacement_path = _item_ranged.."/barrels/gauntlet_basic_barrel_05",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {0, -9, 0},
            },
            gauntlet_basic_barrel_ml01 = {
                replacement_path = _item_ranged.."/barrels/gauntlet_basic_barrel_ml01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {0, -9, 0},
            },
        },
        body = {
            gauntlet_basic_receiver_01 = {
                replacement_path = _item_ranged.."/recievers/gauntlet_basic_receiver_01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {0, -9, 0},
            },
            gauntlet_basic_receiver_02 = {
                replacement_path = _item_ranged.."/recievers/gauntlet_basic_receiver_02",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {0, -9, 0},
            },
            gauntlet_basic_receiver_03 = {
                replacement_path = _item_ranged.."/recievers/gauntlet_basic_receiver_03",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {0, -9, 0},
            },
            gauntlet_basic_receiver_04 = {
                replacement_path = _item_ranged.."/recievers/gauntlet_basic_receiver_04",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {0, -9, 0},
            },
            gauntlet_basic_receiver_06 = {
                replacement_path = _item_ranged.."/recievers/gauntlet_basic_receiver_06",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {0, -9, 0},
            },
            gauntlet_basic_receiver_ml01 = {
                replacement_path = _item_ranged.."/recievers/gauntlet_basic_receiver_ml01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {0, -9, 0},
            },
        },
        magazine = {
            gauntlet_basic_magazine_01 = {
                replacement_path = _item_ranged.."/magazines/gauntlet_basic_magazine_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.35, -5, .25},
            },
            gauntlet_basic_magazine_02 = {
                replacement_path = _item_ranged.."/magazines/gauntlet_basic_magazine_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.35, -5, .25},
            },
        },
    },
    attachment_slots = {
        flashlight = {
            parent_slot = "body",
            default_path = _item_empty_trinket,
            fix = {
                offset = {
                    position = vector3_box(.2, .25, -.25),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
    },
}
