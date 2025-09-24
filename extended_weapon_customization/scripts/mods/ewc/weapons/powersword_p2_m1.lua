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
local _minion = "content/items/weapons/minions"
local _item_melee = _item.."/melee"
local _item_ranged = _item.."/ranged"
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

return {
    attachments = {
        emblem_left = emblem_left,
        emblem_right = emblem_right,
        trinket_hook = trinket_hooks,
        grip = {
            power_falchion_grip_01 = {
                replacement_path = _item_melee.."/grips/power_falchion_grip_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -1.25, .1},
            },
            power_falchion_grip_02 = {
                replacement_path = _item_melee.."/grips/power_falchion_grip_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.075, -1.5, .1},
            },
            power_falchion_grip_ml01 = {
                replacement_path = _item_melee.."/grips/power_falchion_grip_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.05, -1.25, .1},
            },
        },
        blade = {
            power_falchion_blade_01 = {
                replacement_path = _item_melee.."/blades/power_falchion_blade_01",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.025, -2.5, .7},
            },
            power_falchion_blade_02 = {
                replacement_path = _item_melee.."/blades/power_falchion_blade_02",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.025, -2.5, .7},
            },
            power_falchion_blade_ml01 = {
                replacement_path = _item_melee.."/blades/power_falchion_blade_ml01",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.025, -2.5, .7},
            },
        },
        pommel = {
            power_falchion_pommel_01 = {
                replacement_path = _item_melee.."/pommels/power_falchion_pommel_01",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {0, -.5, .075},
            },
            power_falchion_pommel_02 = {
                replacement_path = _item_melee.."/pommels/power_falchion_pommel_02",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {0, -.5, .075},
            },
        },
        hilt = {
            power_sword_hilt_01 = {
                replacement_path = _item_melee.."/hilts/power_sword_hilt_01",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {-.025, -.75, .275},
            },
        },
    },
}
