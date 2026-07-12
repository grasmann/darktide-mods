local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local trinket_hooks = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/trinket_hook")
local emblem_right = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/emblem_right")
local emblem_left = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/emblem_left")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local type = type
    local table = table
    local pairs = pairs
    local select = select
    local vector3 = Vector3
    local vector3_box = Vector3Box
    local table_clone = table.clone
    local vector3_zero = vector3.zero
    local table_merge_recursive = table.merge_recursive
    local table_merge_recursive_n = table.merge_recursive_n
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
        barrel = {
            phosphor_pistol_barrel_01 = {
                replacement_path = _item_ranged.."/barrels/phosphor_pistol_barrel_01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.175, -2, 0},
            },
            phosphor_pistol_barrel_ml01 = {
                replacement_path = _item_ranged.."/barrels/phosphor_pistol_barrel_ml01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.175, -2, 0},
            },
            phosphor_pistol_barrel_deluxe01 = {
                replacement_path = _item_ranged.."/barrels/phosphor_pistol_barrel_deluxe01",
                icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                icon_render_camera_position_offset = {-.175, -2, 0},
            },
        },
        magazine = {
            phosphor_pistol_magazine_01 = {
                replacement_path = _item_ranged.."/magazines/phosphor_pistol_magazine_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
            phosphor_pistol_magazine_ml01 = {
                replacement_path = _item_ranged.."/magazines/phosphor_pistol_magazine_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
            phosphor_pistol_magazine_deluxe01 = {
                replacement_path = _item_ranged.."/magazines/phosphor_pistol_magazine_deluxe01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1, .15},
            },
        },
        body = {
            phosphor_pistol_receiver_01 = {
                replacement_path = _item_ranged.."/recievers/phosphor_pistol_receiver_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.175, -2, .25},
            },
            phosphor_pistol_receiver_ml01 = {
                replacement_path = _item_ranged.."/recievers/phosphor_pistol_receiver_ml01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.175, -2, .25},
            },
            phosphor_pistol_receiver_deluxe01 = {
                replacement_path = _item_ranged.."/recievers/phosphor_pistol_receiver_deluxe01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.175, -2, .25},
                -- validation_default = true,
                -- detach_attachments = {
                --     "grip",
                -- },
                -- validate_attachments = {
                --     "grip",
                -- },
            },
        },
        grip = {
            phosphor_pistol_grip_01 = {
                replacement_path = _item_ranged.."/grips/phosphor_pistol_grip_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            phosphor_pistol_grip_ml01 = {
                replacement_path = _item_ranged.."/grips/phosphor_pistol_grip_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            phosphor_pistol_grip_deluxe01 = {
                replacement_path = _item_ranged.."/grips/phosphor_pistol_grip_deluxe01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
                -- validation_default = true,
                -- detach_attachments = {
                --     "body",
                -- },
                -- validate_attachments = {
                --     "body",
                -- },
            },
        },
    },
    fixes = {
        {attachment_slot = "grip",
            requirements = {
                body = {
                    has = "phosphor_pistol_receiver_deluxe01",
                },
            },
            fix = {
                attach = {
                    grip = "phosphor_pistol_grip_deluxe01",
                },
            },
        },
        {attachment_slot = "body",
            requirements = {
                grip = {
                    has = "phosphor_pistol_grip_deluxe01",
                },
            },
            fix = {
                attach = {
                    body = "phosphor_pistol_receiver_deluxe01",
                },
            },
        },
    },
}
