local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local trinket_hooks = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/trinket_hook")
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
local _item_melee = _item.."/melee"
local _item_ranged = _item.."/ranged"

return {
    attachments = {
        emblem_left = emblem_left,
        emblem_right = emblem_right,
        trinket_hook = trinket_hooks,
        grip = {
            ["2h_force_sword_grip_01"] = {
                replacement_path = _item_melee.."/grips/2h_force_sword_grip_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -.5, .05},
            },
            ["2h_force_sword_grip_02"] = {
                replacement_path = _item_melee.."/grips/2h_force_sword_grip_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -.5, .05},
            },
            ["2h_force_sword_grip_03"] = {
                replacement_path = _item_melee.."/grips/2h_force_sword_grip_03",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -.5, .05},
            },
            ["2h_force_sword_grip_04"] = {
                replacement_path = _item_melee.."/grips/2h_force_sword_grip_04",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -.5, .05},
            },
            ["2h_force_sword_grip_05"] = {
                replacement_path = _item_melee.."/grips/2h_force_sword_grip_05",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -.5, .05},
            },
            ["2h_force_sword_grip_ml01"] = {
                replacement_path = _item_melee.."/grips/2h_force_sword_grip_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -.5, .05},
            },
        },
        blade = {
            ["2h_force_sword_blade_01"] = {
                replacement_path = _item_melee.."/blades/2h_force_sword_blade_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -4, .95},
            },
            ["2h_force_sword_blade_02"] = {
                replacement_path = _item_melee.."/blades/2h_force_sword_blade_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -4, .95},
            },
            ["2h_force_sword_blade_03"] = {
                replacement_path = _item_melee.."/blades/2h_force_sword_blade_03",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -4, .95},
            },
            ["2h_force_sword_blade_04"] = {
                replacement_path = _item_melee.."/blades/2h_force_sword_blade_04",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -4, .95},
            },
            ["2h_force_sword_blade_05"] = {
                replacement_path = _item_melee.."/blades/2h_force_sword_blade_05",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -4, .95},
            },
            ["2h_force_sword_blade_ml01"] = {
                replacement_path = _item_melee.."/blades/2h_force_sword_blade_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -4, .95},
            },
        },
        pommel = {
            ["2h_force_sword_pommel_01"] = {
                replacement_path = _item_melee.."/pommels/2h_force_sword_pommel_01",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {0, -.5, .05},
            },
            ["2h_force_sword_pommel_02"] = {
                replacement_path = _item_melee.."/pommels/2h_force_sword_pommel_02",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {0, -.5, .05},
            },
            ["2h_force_sword_pommel_03"] = {
                replacement_path = _item_melee.."/pommels/2h_force_sword_pommel_03",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {0, -.5, .05},
            },
            ["2h_force_sword_pommel_04"] = {
                replacement_path = _item_melee.."/pommels/2h_force_sword_pommel_04",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {0, -.5, .05},
            },
            ["2h_force_sword_pommel_05"] = {
                replacement_path = _item_melee.."/pommels/2h_force_sword_pommel_05",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {0, -.5, .05},
            },
            ["2h_force_sword_pommel_ml01"] = {
                replacement_path = _item_melee.."/pommels/2h_force_sword_pommel_ml01",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {0, -.5, .05},
            },
        },
        hilt = {
            ["2h_force_sword_hilt_01"] = {
                replacement_path = _item_melee.."/hilts/2h_force_sword_hilt_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1.5, .5},
            },
            ["2h_force_sword_hilt_02"] = {
                replacement_path = _item_melee.."/hilts/2h_force_sword_hilt_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1.5, .5},
            },
            ["2h_force_sword_hilt_03"] = {
                replacement_path = _item_melee.."/hilts/2h_force_sword_hilt_03",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1.5, .5},
            },
            ["2h_force_sword_hilt_04"] = {
                replacement_path = _item_melee.."/hilts/2h_force_sword_hilt_04",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1.5, .5},
            },
            ["2h_force_sword_hilt_05"] = {
                replacement_path = _item_melee.."/hilts/2h_force_sword_hilt_05",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1.5, .5},
            },
            ["2h_force_sword_hilt_ml01"] = {
                replacement_path = _item_melee.."/hilts/2h_force_sword_hilt_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1.5, .5},
            },
        },
    },
}
