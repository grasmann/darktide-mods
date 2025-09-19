local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local trinket_hooks = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/trinket_hook")
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
local _item_melee = _item.."/melee"
local _item_ranged = _item.."/ranged"

return {
    attachments = {
        emblem_left = emblem_left,
        emblem_right = emblem_right,
        trinket_hook = trinket_hooks,
        grip = {
            chain_sword_grip_01 = {
                replacement_path = _item_melee.."/grips/chain_sword_grip_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .2},
            },
            chain_sword_grip_02 = {
                replacement_path = _item_melee.."/grips/chain_sword_grip_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .2},
            },
            chain_sword_grip_03 = {
                replacement_path = _item_melee.."/grips/chain_sword_grip_03",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .2},
            },
            chain_sword_grip_04 = {
                replacement_path = _item_melee.."/grips/chain_sword_grip_04",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .2},
            },
            chain_sword_grip_05 = {
                replacement_path = _item_melee.."/grips/chain_sword_grip_05",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .2},
            },
            chain_sword_grip_06 = {
                replacement_path = _item_melee.."/grips/chain_sword_grip_06",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .2},
            },
            chain_sword_grip_07 = {
                replacement_path = _item_melee.."/grips/chain_sword_grip_07",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .2},
            },
            chain_sword_grip_08 = {
                replacement_path = _item_melee.."/grips/chain_sword_grip_08",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .2},
            },
            chain_sword_grip_09 = {
                replacement_path = _item_melee.."/grips/chain_sword_grip_09",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .2},
            },
            chain_sword_grip_10 = {
                replacement_path = _item_melee.."/grips/chain_sword_grip_10",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .2},
            },
            chain_sword_grip_ml01 = {
                replacement_path = _item_melee.."/grips/chain_sword_grip_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .2},
            },
        },
        body = {
            chain_sword_full_01 = {
                replacement_path = _item_melee.."/full/chain_sword_full_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -2.25, .7},
            },
            chain_sword_full_02 = {
                replacement_path = _item_melee.."/full/chain_sword_full_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -2.25, .7},
            },
            chain_sword_full_03 = {
                replacement_path = _item_melee.."/full/chain_sword_full_03",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -2.25, .7},
            },
            chain_sword_full_04 = {
                replacement_path = _item_melee.."/full/chain_sword_full_04",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -2.25, .7},
            },
            chain_sword_full_05 = {
                replacement_path = _item_melee.."/full/chain_sword_full_05",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -2.25, .7},
            },
            chain_sword_full_06 = {
                replacement_path = _item_melee.."/full/chain_sword_full_06",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -2.25, .7},
            },
            chain_sword_full_07 = {
                replacement_path = _item_melee.."/full/chain_sword_full_07",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -2.25, .7},
            },
            chain_sword_full_08 = {
                replacement_path = _item_melee.."/full/chain_sword_full_08",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -2.25, .7},
            },
            chain_sword_full_09 = {
                replacement_path = _item_melee.."/full/chain_sword_full_09",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -2.25, .7},
            },
            chain_sword_full_10 = {
                replacement_path = _item_melee.."/full/chain_sword_full_10",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -2.25, .7},
            },
            chain_sword_full_11 = {
                replacement_path = _item_melee.."/full/chain_sword_full_11",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -2.25, .7},
            },
            chain_sword_full_ml01 = {
                replacement_path = _item_melee.."/full/chain_sword_full_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -2.25, .7},
            },
        },
        chain = {
            chain_sword_chain_01 = {
                replacement_path = _item_melee.."/chains/chain_sword_chain_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -2.25, .7},
            },
            chain_sword_chain_01_gold_01 = {
                replacement_path = _item_melee.."/chains/chain_sword_chain_01_gold_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -2.25, .7},
            },
        },
    },
}
