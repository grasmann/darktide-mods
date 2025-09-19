local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local trinket_hooks = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/trinket_hook")
local emblem_left = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/emblem_left")
local emblem_right = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/emblem_right")

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
        pommel = {
            power_maul_pommel_01 = {
                replacement_path = _item_melee.."/pommels/power_maul_pommel_01",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {0, -3, .1},
            },
            power_maul_pommel_02 = {
                replacement_path = _item_melee.."/pommels/power_maul_pommel_02",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {0, -3, .1},
            },
            power_maul_pommel_03 = {
                replacement_path = _item_melee.."/pommels/power_maul_pommel_03",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {0, -3, .1},
            },
            power_maul_pommel_04 = {
                replacement_path = _item_melee.."/pommels/power_maul_pommel_04",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {0, -3, .1},
            },
            power_maul_pommel_05 = {
                replacement_path = _item_melee.."/pommels/power_maul_pommel_05",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {0, -3, .1},
            },
            power_maul_pommel_06 = {
                replacement_path = _item_melee.."/pommels/power_maul_pommel_06",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {0, -3, .1},
            },
            power_maul_pommel_ml01 = {
                replacement_path = _item_melee.."/pommels/power_maul_pommel_ml01",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {0, -3, .1},
            },
        },
        shaft = {
            power_maul_shaft_01 = {
                replacement_path = _item_ranged.."/shafts/power_maul_shaft_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -8, 1.25},
            },
            power_maul_shaft_02 = {
                replacement_path = _item_ranged.."/shafts/power_maul_shaft_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -8, 1.25},
            },
            power_maul_shaft_03 = {
                replacement_path = _item_ranged.."/shafts/power_maul_shaft_03",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -8, 1.25},
            },
            power_maul_shaft_04 = {
                replacement_path = _item_ranged.."/shafts/power_maul_shaft_04",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -8, 1.25},
            },
            power_maul_shaft_05 = {
                replacement_path = _item_ranged.."/shafts/power_maul_shaft_05",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -8, 1.25},
            },
            power_maul_shaft_06 = {
                replacement_path = _item_ranged.."/shafts/power_maul_shaft_06",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -8, 1.25},
            },
            power_maul_shaft_07 = {
                replacement_path = _item_ranged.."/shafts/power_maul_shaft_07",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -8, 1.25},
            },
            power_maul_shaft_ml01 = {
                replacement_path = _item_ranged.."/shafts/power_maul_shaft_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -8, 1.25},
            },
        },
        head = {
            power_maul_head_01 = {
                replacement_path = _item_melee.."/heads/power_maul_head_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -8, 1.25},
            },
            power_maul_head_02 = {
                replacement_path = _item_melee.."/heads/power_maul_head_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -8, 1.25},
            },
            power_maul_head_03 = {
                replacement_path = _item_melee.."/heads/power_maul_head_03",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -8, 1.25},
            },
            power_maul_head_04 = {
                replacement_path = _item_melee.."/heads/power_maul_head_04",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -8, 1.25},
            },
            power_maul_head_05 = {
                replacement_path = _item_melee.."/heads/power_maul_head_05",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -8, 1.25},
            },
            power_maul_head_06 = {
                replacement_path = _item_melee.."/heads/power_maul_head_06",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -8, 1.25},
            },
            power_maul_head_ml01 = {
                replacement_path = _item_melee.."/heads/power_maul_head_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -8, 1.25},
            },
        },
    },
}
