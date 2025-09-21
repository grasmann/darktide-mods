local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local trinket_hooks = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/weapons/trinket_hook")
local emblem_left = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/weapons/emblem_left")
local emblem_right = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/weapons/emblem_right")

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
            combat_knife_grip_01 = {
                replacement_path = _item_melee.."/grips/combat_knife_grip_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1, .2},
            },
            combat_knife_grip_02 = {
                replacement_path = _item_melee.."/grips/combat_knife_grip_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1, .2},
            },
            combat_knife_grip_03 = {
                replacement_path = _item_melee.."/grips/combat_knife_grip_03",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1, .2},
            },
            combat_knife_grip_04 = {
                replacement_path = _item_melee.."/grips/combat_knife_grip_04",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1, .2},
            },
            combat_knife_grip_05 = {
                replacement_path = _item_melee.."/grips/combat_knife_grip_05",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1, .2},
            },
            combat_knife_grip_06 = {
                replacement_path = _item_melee.."/grips/combat_knife_grip_06",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1, .2},
            },
            combat_knife_grip_07 = {
                replacement_path = _item_melee.."/grips/combat_knife_grip_07",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1, .2},
            },
            combat_knife_grip_ml01 = {
                replacement_path = _item_melee.."/grips/combat_knife_grip_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1, .2},
            },
        },
        blade = {
            combat_knife_blade_01 = {
                replacement_path = _item_melee.."/blades/combat_knife_blade_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1, .4},
            },
            combat_knife_blade_02 = {
                replacement_path = _item_melee.."/blades/combat_knife_blade_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1, .4},
            },
            combat_knife_blade_03 = {
                replacement_path = _item_melee.."/blades/combat_knife_blade_03",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1, .4},
            },
            combat_knife_blade_04 = {
                replacement_path = _item_melee.."/blades/combat_knife_blade_04",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1, .4},
            },
            combat_knife_blade_05 = {
                replacement_path = _item_melee.."/blades/combat_knife_blade_05",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1, .4},
            },
            combat_knife_blade_06 = {
                replacement_path = _item_melee.."/blades/combat_knife_blade_06",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1, .4},
            },
            combat_knife_blade_07 = {
                replacement_path = _item_melee.."/blades/combat_knife_blade_07",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1, .4},
            },
            combat_knife_blade_08 = {
                replacement_path = _item_melee.."/blades/combat_knife_blade_08",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1, .4},
            },
            combat_knife_blade_09 = {
                replacement_path = _item_melee.."/blades/combat_knife_blade_09",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1, .4},
            },
            combat_knife_blade_ml01 = {
                replacement_path = _item_melee.."/blades/combat_knife_blade_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1, .4},
            },
        },
    },
}
