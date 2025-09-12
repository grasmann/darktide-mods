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
            combat_sword_grip_01 = {
                replacement_path = _item_melee.."/grips/combat_sword_grip_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1, .2},
            },
            combat_sword_grip_02 = {
                replacement_path = _item_melee.."/grips/combat_sword_grip_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1, .2},
            },
            combat_sword_grip_03 = {
                replacement_path = _item_melee.."/grips/combat_sword_grip_03",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1, .2},
            },
            combat_sword_grip_04 = {
                replacement_path = _item_melee.."/grips/combat_sword_grip_04",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1, .2},
            },
            combat_sword_grip_05 = {
                replacement_path = _item_melee.."/grips/combat_sword_grip_05",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1, .2},
            },
            combat_sword_grip_06 = {
                replacement_path = _item_melee.."/grips/combat_sword_grip_06",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1, .2},
            },
            combat_sword_grip_ml01 = {
                replacement_path = _item_melee.."/grips/combat_sword_grip_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1, .2},
            },
        },
        body = {
            combat_sword_blade_01 = {
                replacement_path = _item_melee.."/blades/combat_sword_blade_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -2.5, .8},
            },
            combat_sword_blade_02 = {
                replacement_path = _item_melee.."/blades/combat_sword_blade_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -2.5, .8},
            },
            combat_sword_blade_03 = {
                replacement_path = _item_melee.."/blades/combat_sword_blade_03",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -2.5, .8},
            },
            combat_sword_blade_04 = {
                replacement_path = _item_melee.."/blades/combat_sword_blade_04",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -2.5, .8},
            },
            combat_sword_blade_05 = {
                replacement_path = _item_melee.."/blades/combat_sword_blade_05",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -2.5, .8},
            },
            combat_sword_blade_06 = {
                replacement_path = _item_melee.."/blades/combat_sword_blade_06",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -2.5, .8},
            },
            combat_sword_blade_07 = {
                replacement_path = _item_melee.."/blades/combat_sword_blade_07",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -2.5, .8},
            },
            combat_sword_blade_ml01 = {
                replacement_path = _item_melee.."/blades/combat_sword_blade_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -2.5, .8},
            },
        },
    },
}
