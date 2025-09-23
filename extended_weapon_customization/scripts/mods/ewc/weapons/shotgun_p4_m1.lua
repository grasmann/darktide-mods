local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local trinket_hooks = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/trinket_hook")
local flashlights = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/flashlight")
local sights = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/sight")
local rails = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/rail")
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
local _item_ranged = _item.."/ranged"

local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local scopes = "scope_01"

return {
    attachments = {
        emblem_left = emblem_left,
        emblem_right = emblem_right,
        trinket_hook = trinket_hooks,
        flashlight = flashlights,
        rail = rails,
        sight = table_merge_recursive({
            shotgun_pump_action_sight_01 = {
                replacement_path = _item_ranged.."/sights/shotgun_pump_action_sight_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -2.75, .25},
            },
            shotgun_pump_action_sight_02 = {
                replacement_path = _item_ranged.."/sights/shotgun_pump_action_sight_02",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.15, -2.75, .25},
            },
        }, sights),
        receiver = {
            assault_shotgun_receiver_01 = {
                replacement_path = _item_ranged.."/recievers/assault_shotgun_receiver_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.4, -4.75, .25},
            },
            assault_shotgun_receiver_02 = {
                replacement_path = _item_ranged.."/recievers/assault_shotgun_receiver_02",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.475, -5, .25},
            },
            assault_shotgun_receiver_03 = {
                replacement_path = _item_ranged.."/recievers/assault_shotgun_receiver_03",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.4, -4.75, .25},
            },
            assault_shotgun_receiver_deluxe01 = {
                replacement_path = _item_ranged.."/recievers/assault_shotgun_receiver_deluxe01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.4, -4.75, .25},
            },
            assault_shotgun_receiver_ml01 = {
                replacement_path = _item_ranged.."/recievers/assault_shotgun_receiver_ml01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.4, -4.75, .25},
            },
        },
        grip = {
            assault_shotgun_grip_01 = {
                replacement_path = _item_ranged.."/grips/assault_shotgun_grip_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.05, -1.5, .125},
            },
            assault_shotgun_grip_deluxe01 = {
                replacement_path = _item_ranged.."/grips/assault_shotgun_grip_deluxe01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.05, -1.5, .125},
            },
            assault_shotgun_grip_ml01 = {
                replacement_path = _item_ranged.."/grips/assault_shotgun_grip_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.05, -1.5, .125},
            },
        },
        underbarrel = {
            assault_shotgun_underbarrel_01 = {
                replacement_path = _item_ranged.."/underbarrels/assault_shotgun_underbarrel_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.05, -1.5, .15},
            },
            assault_shotgun_underbarrel_02 = {
                replacement_path = _item_ranged.."/underbarrels/assault_shotgun_underbarrel_02",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.05, -1.5, .15},
            },
        },
    },
}
