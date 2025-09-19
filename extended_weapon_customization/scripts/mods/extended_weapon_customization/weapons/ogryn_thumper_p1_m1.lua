local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local trinket_hooks = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/trinket_hook")
local emblem_left = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/emblem_left")
local emblem_right = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/emblem_right")
local flashlights = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/ogryn_flashlight")
local sights = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/sight")
local rails = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/rail")

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
        emblem_left = emblem_left,
        emblem_right = emblem_right,
        trinket_hook = trinket_hooks,
        flashlight = flashlights,
        sight = {
            shotgun_grenade_sight_01 = {
                replacement_path = _item_ranged.."/sights/shotgun_grenade_sight_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.3, -5, 0},
            },
            shotgun_grenade_sight_03 = {
                replacement_path = _item_ranged.."/sights/shotgun_grenade_sight_03",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.3, -5, 0},
            },
            shotgun_grenade_sight_04 = {
                replacement_path = _item_ranged.."/sights/shotgun_grenade_sight_04",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -5, 0},
            },
            shotgun_grenade_sight_ml01 = {
                replacement_path = _item_ranged.."/sights/shotgun_grenade_sight_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.3, -5, 0},
            },
        },
        body = {
            shotgun_grenade_full_01 = {
                replacement_path = _item_melee.."/full/shotgun_grenade_full_01",
                icon_render_unit_rotation_offset = {90, 20, 90 - 30},
                icon_render_camera_position_offset = {-.55, -7, 1},
            },
            shotgun_grenade_full_02 = {
                replacement_path = _item_melee.."/full/shotgun_grenade_full_02",
                icon_render_unit_rotation_offset = {90, 20, 90 - 30},
                icon_render_camera_position_offset = {-.55, -7, 1},
            },
            shotgun_grenade_full_03 = {
                replacement_path = _item_melee.."/full/shotgun_grenade_full_03",
                icon_render_unit_rotation_offset = {90, 20, 90 - 30},
                icon_render_camera_position_offset = {-.55, -7, 1},
            },
            shotgun_grenade_full_04 = {
                replacement_path = _item_melee.."/full/shotgun_grenade_full_04",
                icon_render_unit_rotation_offset = {90, 20, 90 - 30},
                icon_render_camera_position_offset = {-.55, -7, 1},
            },
            shotgun_grenade_full_05 = {
                replacement_path = _item_melee.."/full/shotgun_grenade_full_05",
                icon_render_unit_rotation_offset = {90, 20, 90 - 30},
                icon_render_camera_position_offset = {-.55, -7, 1},
            },
            shotgun_grenade_full_06 = {
                replacement_path = _item_melee.."/full/shotgun_grenade_full_06",
                icon_render_unit_rotation_offset = {90, 20, 90 - 30},
                icon_render_camera_position_offset = {-.55, -7, 1},
            },
            shotgun_grenade_full_ml01 = {
                replacement_path = _item_melee.."/full/shotgun_grenade_full_ml01",
                icon_render_unit_rotation_offset = {90, 20, 90 - 30},
                icon_render_camera_position_offset = {-.55, -7, 1},
            },
        },
        grip = {
            shotgun_grenade_grip_01 = {
                replacement_path = _item_ranged.."/grips/shotgun_grenade_grip_01",
                icon_render_unit_rotation_offset = {90, -20, -90 - 45},
                icon_render_camera_position_offset = {-.5, -8, 0},
            },
            shotgun_grenade_grip_02 = {
                replacement_path = _item_ranged.."/grips/shotgun_grenade_grip_02",
                icon_render_unit_rotation_offset = {90, -20, -90 - 45},
                icon_render_camera_position_offset = {-.5, -8, 0},
            },
            shotgun_grenade_grip_03 = {
                replacement_path = _item_ranged.."/grips/shotgun_grenade_grip_03",
                icon_render_unit_rotation_offset = {90, -20, -90 - 45},
                icon_render_camera_position_offset = {-.5, -8, 0},
            },
            shotgun_grenade_grip_04 = {
                replacement_path = _item_ranged.."/grips/shotgun_grenade_grip_04",
                icon_render_unit_rotation_offset = {90, -20, -90 - 45},
                icon_render_camera_position_offset = {-.5, -8, 0},
            },
            shotgun_grenade_grip_05 = {
                replacement_path = _item_ranged.."/grips/shotgun_grenade_grip_05",
                icon_render_unit_rotation_offset = {90, -20, -90 - 45},
                icon_render_camera_position_offset = {-.5, -8, 0},
            },
            shotgun_grenade_grip_ml01 = {
                replacement_path = _item_ranged.."/grips/shotgun_grenade_grip_ml01",
                icon_render_unit_rotation_offset = {90, -20, -90 - 45},
                icon_render_camera_position_offset = {-.5, -8, 0},
            },
        },
    },
    attachment_slots = {
        flashlight = {
            parent_slot = "sight",
            default_path = _item_empty_trinket,
            fix = {
                offset = {
                    position = vector3_box(.16, 0, -.14),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
    },
}
