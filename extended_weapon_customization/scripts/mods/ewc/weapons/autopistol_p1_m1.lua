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

return {
    attachments = {
        emblem_left = emblem_left,
        emblem_right = emblem_right,
        trinket_hook = trinket_hooks,
        flashlight = flashlights,
        receiver = {
            autogun_pistol_receiver_01 = {
                replacement_path = _item_ranged.."/recievers/autogun_pistol_receiver_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.115, -1.5, .25},
            },
            autogun_pistol_receiver_02 = {
                replacement_path = _item_ranged.."/recievers/autogun_pistol_receiver_02",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.115, -1.5, .25},
            },
            autogun_pistol_receiver_03 = {
                replacement_path = _item_ranged.."/recievers/autogun_pistol_receiver_03",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.115, -1.5, .25},
            },
            autogun_pistol_receiver_04 = {
                replacement_path = _item_ranged.."/recievers/autogun_pistol_receiver_04",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.115, -1.5, .25},
            },
            autogun_pistol_receiver_05 = {
                replacement_path = _item_ranged.."/recievers/autogun_pistol_receiver_05",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.115, -1.5, .25},
            },
            autogun_pistol_receiver_ml01 = {
                replacement_path = _item_ranged.."/recievers/autogun_pistol_receiver_ml01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.115, -1.5, .25},
            },
        },
        barrel = {
            autogun_pistol_barrel_01 = {
                replacement_path = _item_ranged.."/barrels/autogun_pistol_barrel_01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.09, -1, .1},
            },
            autogun_pistol_barrel_02 = {
                replacement_path = _item_ranged.."/barrels/autogun_pistol_barrel_02",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.09, -1, .1},
            },
            autogun_pistol_barrel_03 = {
                replacement_path = _item_ranged.."/barrels/autogun_pistol_barrel_03",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.09, -1, .1},
            },
            autogun_pistol_barrel_04 = {
                replacement_path = _item_ranged.."/barrels/autogun_pistol_barrel_04",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.09, -1, .1},
            },
            autogun_pistol_barrel_05 = {
                replacement_path = _item_ranged.."/barrels/autogun_pistol_barrel_05",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.09, -1, .1},
            },
        },
        magazine = {
            autogun_pistol_magazine_01 = {
                replacement_path = _item_ranged.."/magazines/autogun_pistol_magazine_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.125, -1.25, -.05},
            },
        },
        sight = {
            autogun_pistol_sight_01 = {
                replacement_path = _item_ranged.."/sights/autogun_pistol_sight_01",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .175},
            }
        },
        muzzle = {
            autogun_pistol_muzzle_01 = {
                replacement_path = _item_ranged.."/muzzles/autogun_pistol_muzzle_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.07, -.5, .15},
            },
            autogun_pistol_muzzle_02 = {
                replacement_path = _item_ranged.."/muzzles/autogun_pistol_muzzle_02",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.07, -.5, .15},
            },
            autogun_pistol_muzzle_03 = {
                replacement_path = _item_ranged.."/muzzles/autogun_pistol_muzzle_03",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.07, -.5, .15},
            },
            autogun_pistol_muzzle_04 = {
                replacement_path = _item_ranged.."/muzzles/autogun_pistol_muzzle_04",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.07, -.5, .15},
            },
            autogun_pistol_muzzle_05 = {
                replacement_path = _item_ranged.."/muzzles/autogun_pistol_muzzle_05",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.11, -.6, .15},
            },
            autogun_pistol_muzzle_ml01 = {
                replacement_path = _item_ranged.."/muzzles/autogun_pistol_muzzle_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.07, -.5, .15},
            },
        },
        grip = {
            autogun_rifle_grip_01 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            autogun_rifle_grip_02 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_02",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            autogun_rifle_grip_03 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_03",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            autogun_rifle_grip_ml01 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
        },
    },
}
