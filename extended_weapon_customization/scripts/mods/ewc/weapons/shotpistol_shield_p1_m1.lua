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
        barrel = {
            shotpistol_barrel_01 = {
                replacement_path = _item_ranged.."/barrels/shotpistol_barrel_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.225, -2, .2},
            },
            shotpistol_barrel_ml01 = {
                replacement_path = _item_ranged.."/barrels/shotpistol_barrel_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.225, -2, .2},
            },
            shotpistol_barrel_deluxe01 = {
                replacement_path = _item_ranged.."/barrels/shotpistol_barrel_deluxe01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.225, -2, .2},
            },
        },
        body = {
            shotpistol_body_01 = {
                replacement_path = _item_ranged.."/full/shotpistol_body_01",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {0, -2, .2},
            },
            shotpistol_body_ml01 = {
                replacement_path = _item_ranged.."/full/shotpistol_body_ml01",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {0, -2, .2},
            },
            shotpistol_body_deluxe01 = {
                replacement_path = _item_ranged.."/full/shotpistol_body_deluxe01",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {0, -2, .2},
            },
        },
        left = {
            assault_shield_p1_m1 = {
                replacement_path = _item_melee.."/assault_shield_p1_m1",
                icon_render_unit_rotation_offset = {90, 15, 90 + 60},
                icon_render_camera_position_offset = {.2, -7, .05},
            },
            assault_shield_ml01 = {
                replacement_path = _item.."/shields/assault_shield_ml01",
                icon_render_unit_rotation_offset = {90, 15, 90 + 60},
                icon_render_camera_position_offset = {.2, -7, .05},
            },
            assault_shield_deluxe01 = {
                replacement_path = _item.."/shields/assault_shield_deluxe01",
                icon_render_unit_rotation_offset = {90, 15, 90 + 60},
                icon_render_camera_position_offset = {.2, -7, .05},
            },
        },
    },
}
