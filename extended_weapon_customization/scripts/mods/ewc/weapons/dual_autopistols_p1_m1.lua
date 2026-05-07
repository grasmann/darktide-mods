local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local trinket_hooks = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/trinket_hook")
local flashlights = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/flashlight")
local emblem_left = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/emblem_left")
local emblem_right = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/emblem_right")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local table = table
    local vector3 = Vector3
    local vector3_box = Vector3Box
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

return {
    attachments = {
        emblem_left = emblem_left,
        emblem_right = emblem_right,
        trinket_hook = trinket_hooks,
        flashlight = flashlights,
        left = {
            autopistol_compact_p1_m1_01 = {
                replacement_path = _item_ranged.."/autopistol_compact_p1_m1_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.115, -1.5, .25},
            },
            autopistol_compact_p1_m1_02 = {
                replacement_path = _item_ranged.."/autopistol_compact_p1_m1_02",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.115, -1.5, .25},
            },
            autopistol_compact_p1_deluxe01_01 = {
                replacement_path = _item_ranged.."/autopistol_compact_p1_deluxe01_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.115, -1.5, .25},
            },
            autopistol_compact_p1_deluxe01_02 = {
                replacement_path = _item_ranged.."/autopistol_compact_p1_deluxe01_02",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.115, -1.5, .25},
            },
            autopistol_compact_p1_ml01_01 = {
                replacement_path = _item_ranged.."/autopistol_compact_p1_ml01_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.115, -1.5, .25},
            },
            autopistol_compact_p1_ml01_02 = {
                replacement_path = _item_ranged.."/autopistol_compact_p1_ml01_02",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.115, -1.5, .25},
            },
        },
        right = {
            autopistol_compact_p1_m1_01 = {
                replacement_path = _item_ranged.."/autopistol_compact_p1_m1_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.115, -1.5, .25},
            },
            autopistol_compact_p1_m1_02 = {
                replacement_path = _item_ranged.."/autopistol_compact_p1_m1_02",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.115, -1.5, .25},
            },
            autopistol_compact_p1_deluxe01_01 = {
                replacement_path = _item_ranged.."/autopistol_compact_p1_deluxe01_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.115, -1.5, .25},
            },
            autopistol_compact_p1_deluxe01_02 = {
                replacement_path = _item_ranged.."/autopistol_compact_p1_deluxe01_02",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.115, -1.5, .25},
            },
            autopistol_compact_p1_ml01_01 = {
                replacement_path = _item_ranged.."/autopistol_compact_p1_ml01_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.115, -1.5, .25},
            },
            autopistol_compact_p1_ml01_02 = {
                replacement_path = _item_ranged.."/autopistol_compact_p1_ml01_02",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.115, -1.5, .25},
            },
        },
        -- receiver = {
        --     autogun_pistol_compact_receiver_01 = {
        --         replacement_path = _item_ranged.."/recievers/autogun_pistol_compact_receiver_01",
        --         icon_render_unit_rotation_offset = {90, 0, 45},
        --         icon_render_camera_position_offset = {-.115, -1.5, .25},
        --     },
        --     autogun_pistol_compact_receiver_deluxe01 = {
        --         replacement_path = _item_ranged.."/recievers/autogun_pistol_compact_receiver_deluxe01",
        --         icon_render_unit_rotation_offset = {90, 0, 45},
        --         icon_render_camera_position_offset = {-.115, -1.5, .25},
        --     },
        --     autogun_pistol_compact_receiver_ml01 = {
        --         replacement_path = _item_ranged.."/recievers/autogun_pistol_compact_receiver_ml01",
        --         icon_render_unit_rotation_offset = {90, 0, 45},
        --         icon_render_camera_position_offset = {-.115, -1.5, .25},
        --     },
        -- },
        -- magazine = {
        --     autogun_pistol_compact_magazine_01 = {
        --         replacement_path = _item_ranged.."/magazines/autogun_pistol_compact_magazine_01",
        --         icon_render_unit_rotation_offset = {90, 0, 30},
        --         icon_render_camera_position_offset = {-.125, -1.25, -.05},
        --     },
        -- },
        -- barrel = {
        --     autogun_pistol_compact_barrel_01 = {
        --         replacement_path = _item_ranged.."/barrels/autogun_pistol_compact_barrel_01",
        --         icon_render_unit_rotation_offset = {90, -20, 90 - 30},
        --         icon_render_camera_position_offset = {-.09, -1, .1},
        --     },
        --     autogun_pistol_compact_barrel_deluxe01 = {
        --         replacement_path = _item_ranged.."/barrels/autogun_pistol_compact_barrel_deluxe01",
        --         icon_render_unit_rotation_offset = {90, -20, 90 - 30},
        --         icon_render_camera_position_offset = {-.09, -1, .1},
        --     },
        --     autogun_pistol_compact_barrel_deluxe02 = {
        --         replacement_path = _item_ranged.."/barrels/autogun_pistol_compact_barrel_deluxe02",
        --         icon_render_unit_rotation_offset = {90, -20, 90 - 30},
        --         icon_render_camera_position_offset = {-.09, -1, .1},
        --     },
        --     autogun_pistol_compact_barrel_ml01 = {
        --         replacement_path = _item_ranged.."/barrels/autogun_pistol_compact_barrel_ml01",
        --         icon_render_unit_rotation_offset = {90, -20, 90 - 30},
        --         icon_render_camera_position_offset = {-.09, -1, .1},
        --     },
        -- },
        -- addon = {
        --     autogun_pistol_compact_addon_01 = {
        --         replacement_path = _item_ranged.."/misc/autogun_pistol_compact_addon_01",
        --         icon_render_unit_rotation_offset = {90, 0, 30},
        --         icon_render_camera_position_offset = {-.07, -.5, .15},
        --     },
        --     autogun_pistol_compact_addon_02 = {
        --         replacement_path = _item_ranged.."/misc/autogun_pistol_compact_addon_02",
        --         icon_render_unit_rotation_offset = {90, 0, 30},
        --         icon_render_camera_position_offset = {-.07, -.5, .15},
        --     },
        --     autogun_pistol_compact_addon_deluxe01_ver01 = {
        --         replacement_path = _item_ranged.."/misc/autogun_pistol_compact_addon_deluxe01_ver01",
        --         icon_render_unit_rotation_offset = {90, 0, 30},
        --         icon_render_camera_position_offset = {-.07, -.5, .15},
        --     },
        --     autogun_pistol_compact_addon_deluxe01_ver02 = {
        --         replacement_path = _item_ranged.."/misc/autogun_pistol_compact_addon_deluxe01_ver02",
        --         icon_render_unit_rotation_offset = {90, 0, 30},
        --         icon_render_camera_position_offset = {-.07, -.5, .15},
        --     },
        --     autogun_pistol_compact_addon_ml01_ver01 = {
        --         replacement_path = _item_ranged.."/misc/autogun_pistol_compact_addon_ml01_ver01",
        --         icon_render_unit_rotation_offset = {90, 0, 30},
        --         icon_render_camera_position_offset = {-.07, -.5, .15},
        --     },
        --     autogun_pistol_compact_addon_ml01_ver02 = {
        --         replacement_path = _item_ranged.."/misc/autogun_pistol_compact_addon_ml01_ver02",
        --         icon_render_unit_rotation_offset = {90, 0, 30},
        --         icon_render_camera_position_offset = {-.07, -.5, .15},
        --     },
        -- },
        -- grip = {
        --     autogun_pistol_compact_grip_01 = {
        --         replacement_path = _item_ranged.."/grips/autogun_pistol_compact_grip_01",
        --         icon_render_unit_rotation_offset = {90, 0, 30},
        --         icon_render_camera_position_offset = {.075, -1, .05},
        --     },
        --     autogun_pistol_compact_grip_deluxe01 = {
        --         replacement_path = _item_ranged.."/grips/autogun_pistol_compact_grip_deluxe01",
        --         icon_render_unit_rotation_offset = {90, 0, 30},
        --         icon_render_camera_position_offset = {.075, -1, .05},
        --     },
        --     autogun_pistol_compact_grip_ml01 = {
        --         replacement_path = _item_ranged.."/grips/autogun_pistol_compact_grip_ml01",
        --         icon_render_unit_rotation_offset = {90, 0, 30},
        --         icon_render_camera_position_offset = {.075, -1, .05},
        --     },
        -- },
    },
}
