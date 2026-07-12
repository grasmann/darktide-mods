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

return {
    attachments = {
        emblem_left = emblem_left,
        emblem_right = emblem_right,
        trinket_hook = trinket_hooks,
        grip = {
            power_sword_grip_07 = {
                replacement_path = _item_melee.."/grips/power_sword_grip_07",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.025, -.5, .1},
            },
            power_sword_grip_07_ml01 = {
                replacement_path = _item_melee.."/grips/power_sword_grip_07_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.025, -.5, .1},
            },
            power_sword_grip_deluxe01 = {
                replacement_path = _item_melee.."/grips/power_sword_grip_deluxe01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.025, -.5, .1},
            },
        },
        blade = {
            power_sword_blade_08 = {
                replacement_path = _item_melee.."/blades/power_sword_blade_08",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.025, -2.5, .7},
            },
            power_sword_blade_08_ml01 = {
                replacement_path = _item_melee.."/blades/power_sword_blade_08_ml01",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.025, -2.5, .7},
            },
            power_sword_blade_deluxe01 = {
                replacement_path = _item_melee.."/blades/power_sword_blade_deluxe01",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.025, -2.5, .7},
            },
        },
        pommel = {
            power_sword_pommel_07 = {
                replacement_path = _item_melee.."/pommels/power_sword_pommel_07",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {0, -.5, .075},
            },
            power_sword_pommel_07_ml01 = {
                replacement_path = _item_melee.."/pommels/power_sword_pommel_07_ml01",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {0, -.5, .075},
            },
            power_sword_pommel_deluxe01 = {
                replacement_path = _item_melee.."/pommels/power_sword_pommel_deluxe01",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {0, -.5, .075},
            },
        },
    },
}
