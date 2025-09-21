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
            hatchet_grip_01 = {
                replacement_path = _item_melee.."/grips/hatchet_grip_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .2},
            },
            hatchet_grip_02 = {
                replacement_path = _item_melee.."/grips/hatchet_grip_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .2},
            },
            hatchet_grip_03 = {
                replacement_path = _item_melee.."/grips/hatchet_grip_03",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .2},
            },
            hatchet_grip_04 = {
                replacement_path = _item_melee.."/grips/hatchet_grip_04",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .2},
            },
            hatchet_grip_05 = {
                replacement_path = _item_melee.."/grips/hatchet_grip_05",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .2},
            },
            hatchet_grip_06 = {
                replacement_path = _item_melee.."/grips/hatchet_grip_06",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .2},
            },
        },
        head = {
            hatchet_head_01 = {
                replacement_path = _item_melee.."/heads/hatchet_head_01",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.17, -2.75, .3},
            },
            hatchet_head_02 = {
                replacement_path = _item_melee.."/heads/hatchet_head_02",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.17, -2.75, .3},
            },
            hatchet_head_03 = {
                replacement_path = _item_melee.."/heads/hatchet_head_03",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.17, -2.75, .3},
            },
            hatchet_head_04 = {
                replacement_path = _item_melee.."/heads/hatchet_head_04",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.17, -2.75, .3},
            },
            hatchet_head_05 = {
                replacement_path = _item_melee.."/heads/hatchet_head_05",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.17, -2.75, .3},
            },
            hatchet_head_06 = {
                replacement_path = _item_melee.."/heads/hatchet_head_06",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.17, -2.75, .3},
            },
            hatchet_head_ml01 = {
                replacement_path = _item_melee.."/heads/hatchet_head_ml01",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.17, -2.75, .3},
            },
        },
        pommel = {
            hatchet_pommel_01 = {
                replacement_path = _item_melee.."/pommels/hatchet_pommel_01",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {0, -.5, .05},
            },
            hatchet_pommel_02 = {
                replacement_path = _item_melee.."/pommels/hatchet_pommel_02",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {0, -.5, .05},
            },
            hatchet_pommel_03 = {
                replacement_path = _item_melee.."/pommels/hatchet_pommel_03",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {0, -.5, .05},
            },
            hatchet_pommel_04 = {
                replacement_path = _item_melee.."/pommels/hatchet_pommel_04",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {0, -.5, .05},
            },
            hatchet_pommel_ml01 = {
                replacement_path = _item_melee.."/pommels/hatchet_pommel_ml01",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {0, -.5, .05},
            },
        },
    },
}
