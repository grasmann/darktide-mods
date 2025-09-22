local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local trinket_hooks = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/weapons/trinket_hook")
local flashlights = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/weapons/flashlight")
local sights = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/weapons/sight")
local rails = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/weapons/rail")
local emblem_left = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/weapons/emblem_left")
local emblem_right = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/weapons/emblem_right")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local table = table
    local vector3 = Vector3
    local vector3_box = Vector3Box
    -- local vector3_zero = vector3.zero
    -- local table_merge_recursive = table.merge_recursive
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"

-- local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
-- local scopes = "scope_01"

return {
    attachments = {
        emblem_left = emblem_left,
        emblem_right = emblem_right,
        trinket_hook = trinket_hooks,
        flashlight = flashlights,
        -- rail = rails,
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
    -- fixes = {
    --     {attachment_slot = "sight_offset",
    --         requirements = {
    --             sight = {
    --                 has = reflex_sights.."|"..scopes,
    --             },
    --         },
    --         fix = {
    --             offset = {
    --                 position = vector3_box(0, 0, -.0085),
    --                 rotation = vector3_box(0, 0, 0),
    --             },
    --         },
    --     },
    --     {attachment_slot = "sight",
    --         requirements = {
    --             sight = {
    --                 has = reflex_sights.."|"..scopes,
    --             },
    --         },
    --         fix = {
    --             offset = {
    --                 position = vector3_box(0, -.04, 0),
    --                 rotation = vector3_box(0, 0, 0),
    --             },
    --         },
    --     },
    --     {attachment_slot = "rail",
    --         requirements = {
    --             sight = {
    --                 has = reflex_sights.."|"..scopes,
    --             },
    --         },
    --         fix = {
    --             -- attach = {
    --             --     rail = "lasgun_rifle_rail_01",
    --             -- },
    --             offset = {
    --                 position = vector3_box(0, -.05, 0),
    --                 rotation = vector3_box(0, 0, 0),
    --                 scale = vector3_box(1, 1, 1),
    --                 node = 1,
    --             },
    --         },
    --     },
    -- },
}
