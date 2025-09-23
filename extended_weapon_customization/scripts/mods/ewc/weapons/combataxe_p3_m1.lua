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
    local vector3 = Vector3
    local vector3_box = Vector3Box
    local vector3_zero = vector3.zero
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
        pommel = {
            shovel_pommel_01 = {
                replacement_path = _item_melee.."/pommels/shovel_pommel_01",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {0, -.5, .05},
                validation_default = true,
                validate_attachments = {
                    "grip",
                    "head",
                },
            },
            shovel_pommel_02 = {
                replacement_path = _item_melee.."/pommels/shovel_pommel_02",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {0, -.5, .1},
                validate_attachments = {
                    "grip",
                    "head",
                },
            },
            shovel_pommel_03 = {
                replacement_path = _item_melee.."/pommels/shovel_pommel_03",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {0, -.5, .1},
                validate_attachments = {
                    "grip",
                    "head",
                },
            },
            shovel_pommel_04 = {
                replacement_path = _item_melee.."/pommels/shovel_pommel_04",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {0, -.5, .1},
                validate_attachments = {
                    "grip",
                    "head",
                },
            },
            shovel_pommel_05 = {
                replacement_path = _item_melee.."/pommels/shovel_pommel_05",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {0, -.5, .1},
                validate_attachments = {
                    "grip",
                    "head",
                },
            },
            shovel_pommel_ml01 = {
                replacement_path = _item_melee.."/pommels/shovel_pommel_ml01",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {0, -.5, .1},
                validate_attachments = {
                    "grip",
                    "head",
                },
            },
            krieg_shovel_full_01 = {
                replacement_path = _item_melee.."/full/krieg_shovel_full_01",
                detach_attachments = {
                    "grip",
                    "head",
                },
                icon_render_unit_rotation_offset = {90, 0, 0},
                icon_render_camera_position_offset = {0, -3, .5},
            },
            prologue_shovel_full_01 = {
                replacement_path = _item_melee.."/full/prologue_shovel_full_01",
                detach_attachments = {
                    "grip",
                    "head",
                },
                icon_render_unit_rotation_offset = {90, 0, 0},
                icon_render_camera_position_offset = {0, -3, .5},
            },
        },
        grip = {
            shovel_grip_01 = {
                replacement_path = _item_melee.."/grips/shovel_grip_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -.75, .2},
                validation_default = true,
                detach_attachments = {
                    "krieg_shovel_full_01",
                    "prologue_shovel_full_01",
                },
                validate_attachments = {
                    "pommel",
                    "head",
                },
            },
            shovel_grip_02 = {
                replacement_path = _item_melee.."/grips/shovel_grip_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -.75, .2},
                detach_attachments = {
                    "krieg_shovel_full_01",
                    "prologue_shovel_full_01",
                },
                validate_attachments = {
                    "pommel",
                    "head",
                },
            },
            shovel_grip_03 = {
                replacement_path = _item_melee.."/grips/shovel_grip_03",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -.75, .2},
                detach_attachments = {
                    "krieg_shovel_full_01",
                    "prologue_shovel_full_01",
                },
                validate_attachments = {
                    "pommel",
                    "head",
                },
            },
            shovel_grip_04 = {
                replacement_path = _item_melee.."/grips/shovel_grip_04",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -.75, .2},
                detach_attachments = {
                    "krieg_shovel_full_01",
                    "prologue_shovel_full_01",
                },
                validate_attachments = {
                    "pommel",
                    "head",
                },
            },
            shovel_grip_05 = {
                replacement_path = _item_melee.."/grips/shovel_grip_05",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -.75, .2},
                detach_attachments = {
                    "krieg_shovel_full_01",
                    "prologue_shovel_full_01",
                },
                validate_attachments = {
                    "pommel",
                    "head",
                },
            },
            shovel_grip_ml01 = {
                replacement_path = _item_melee.."/grips/shovel_grip_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -.75, .2},
                detach_attachments = {
                    "krieg_shovel_full_01",
                    "prologue_shovel_full_01",
                },
                validate_attachments = {
                    "pommel",
                    "head",
                },
            },
        },
        head = {
            shovel_head_01 = {
                replacement_path = _item_melee.."/heads/shovel_head_01",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .5},
                validation_default = true,
                detach_attachments = {
                    "krieg_shovel_full_01",
                    "prologue_shovel_full_01",
                },
                validate_attachments = {
                    "pommel",
                    "grip",
                },
            },
            shovel_head_02 = {
                replacement_path = _item_melee.."/heads/shovel_head_02",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .5},
                detach_attachments = {
                    "krieg_shovel_full_01",
                    "prologue_shovel_full_01",
                },
                validate_attachments = {
                    "pommel",
                    "grip",
                },
            },
            shovel_head_03 = {
                replacement_path = _item_melee.."/heads/shovel_head_03",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .5},
                detach_attachments = {
                    "krieg_shovel_full_01",
                    "prologue_shovel_full_01",
                },
                validate_attachments = {
                    "pommel",
                    "grip",
                },
            },
            shovel_head_04 = {
                replacement_path = _item_melee.."/heads/shovel_head_04",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .5},
                detach_attachments = {
                    "krieg_shovel_full_01",
                    "prologue_shovel_full_01",
                },
                validate_attachments = {
                    "pommel",
                    "grip",
                },
            },
            shovel_head_05 = {
                replacement_path = _item_melee.."/heads/shovel_head_05",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .5},
                detach_attachments = {
                    "krieg_shovel_full_01",
                    "prologue_shovel_full_01",
                },
                validate_attachments = {
                    "pommel",
                    "grip",
                },
            },
            shovel_head_ml01 = {
                replacement_path = _item_melee.."/heads/shovel_head_ml01",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.05, -1.5, .5},
                detach_attachments = {
                    "krieg_shovel_full_01",
                    "prologue_shovel_full_01",
                },
                validate_attachments = {
                    "pommel",
                    "grip",
                },
            },
        },
    },
}
