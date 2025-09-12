local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local trinket_hooks = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/trinket_hook")

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
        trinket_hook = trinket_hooks,
        grip = {
            ["2h_chain_sword_grip_01"] = {
                replacement_path = _item_melee.."/grips/2h_chain_sword_grip_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .2},
            },
            ["2h_chain_sword_grip_02"] = {
                replacement_path = _item_melee.."/grips/2h_chain_sword_grip_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .2},
            },
            ["2h_chain_sword_grip_03"] = {
                replacement_path = _item_melee.."/grips/2h_chain_sword_grip_03",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .2},
            },
            ["2h_chain_sword_grip_04"] = {
                replacement_path = _item_melee.."/grips/2h_chain_sword_grip_04",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .2},
            },
            ["2h_chain_sword_grip_ml01"] = {
                replacement_path = _item_melee.."/grips/2h_chain_sword_grip_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .2},
            },
        },
        body = {
            ["2h_chain_sword_body_01"] = {
                replacement_path = _item_melee.."/full/2h_chain_sword_body_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -3.25, .95},
            },
            ["2h_chain_sword_body_02"] = {
                replacement_path = _item_melee.."/full/2h_chain_sword_body_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -3.25, .95},
            },
            ["2h_chain_sword_body_03"] = {
                replacement_path = _item_melee.."/full/2h_chain_sword_body_03",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -3.25, .95},
            },
            ["2h_chain_sword_body_04"] = {
                replacement_path = _item_melee.."/full/2h_chain_sword_body_04",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -3.25, .95},
            },
            ["2h_chain_sword_body_06"] = {
                replacement_path = _item_melee.."/full/2h_chain_sword_body_06",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -3.25, .95},
            },
            ["2h_chain_sword_body_07"] = {
                replacement_path = _item_melee.."/full/2h_chain_sword_body_07",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -3.25, .95},
            },
            ["2h_chain_sword_body_ml01"] = {
                replacement_path = _item_melee.."/full/2h_chain_sword_body_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -3.25, .95},
            },
        },
        chain = {
            ["2h_chain_sword_chain_01"] = {
                replacement_path = _item_melee.."/chains/2h_chain_sword_chain_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -3.25, .95},
            },
            ["2h_chain_sword_chain_01_gold_01"] = {
                replacement_path = _item_melee.."/chains/2h_chain_sword_chain_01_gold_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -3.25, .95},
            },
        },
    },
}
