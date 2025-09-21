local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local trinket_hooks = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/weapons/trinket_hook")
local emblem_left = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/weapons/emblem_left")
local emblem_right = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/weapons/emblem_right")

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

local _ogryn_assault_shields = "ogryn_assault_shield_01|ogryn_assault_shield_02|ogryn_assault_shield_03"

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
        left = {
            ogryn_slabshield_p1_m1 = {
                replacement_path = _item_melee.."/ogryn_slabshield_p1_m1",
                icon_render_unit_rotation_offset = {90, 15, 90 + 60},
                icon_render_camera_position_offset = {.3, -14, .05},
            },
            ogryn_slabshield_p1_m2 = {
                replacement_path = _item_melee.."/ogryn_slabshield_p1_m2",
                icon_render_unit_rotation_offset = {90, 15, 90 + 60},
                icon_render_camera_position_offset = {.3, -14, .05},
            },
            ogryn_slabshield_p1_m3 = {
                replacement_path = _item_melee.."/ogryn_slabshield_p1_m3",
                icon_render_unit_rotation_offset = {90, 15, 90 + 60},
                icon_render_camera_position_offset = {.3, -14, .05},
            },
            ogryn_slabshield_p1_04 = {
                replacement_path = _item_melee.."/ogryn_slabshield_p1_04",
                icon_render_unit_rotation_offset = {90, 15, 90 + 60},
                icon_render_camera_position_offset = {.3, -14, .05},
            },
            ogryn_slabshield_p1_05 = {
                replacement_path = _item_melee.."/ogryn_slabshield_p1_05",
                icon_render_unit_rotation_offset = {90, 15, 90 + 60},
                icon_render_camera_position_offset = {.3, -14, .05},
            },
            ogryn_slabshield_p1_06 = {
                replacement_path = _item_melee.."/ogryn_slabshield_p1_06",
                icon_render_unit_rotation_offset = {90, 15, 90 + 60},
                icon_render_camera_position_offset = {.3, -14, .05},
            },
            ogryn_slabshield_p1_ml01 = {
                replacement_path = _item_melee.."/ogryn_slabshield_p1_ml01",
                icon_render_unit_rotation_offset = {90, 15, 90 + 60},
                icon_render_camera_position_offset = {.3, -14, .05},
            },
            ogryn_assault_shield_01 = {
                replacement_path = _item.."/shields/ogryn_assault_shield_01",
                icon_render_unit_rotation_offset = {90, 15, 90 + 60},
                icon_render_camera_position_offset = {.2, -7, .05},
            },
            ogryn_assault_shield_02 = {
                replacement_path = _item.."/shields/ogryn_assault_shield_02",
                icon_render_unit_rotation_offset = {90, 15, 90 + 60},
                icon_render_camera_position_offset = {.2, -7, .05},
            },
            ogryn_assault_shield_03 = {
                replacement_path = _item.."/shields/ogryn_assault_shield_03",
                icon_render_unit_rotation_offset = {90, 15, 90 + 60},
                icon_render_camera_position_offset = {.2, -7, .05},
            },
        },
    },
    fixes = {
        {attachment_slot = "left",
            requirements = {
                left = {
                    has = _ogryn_assault_shields,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(2, 2, 2),
                    node = 1,
                },
            },
        },
    },
    kitbashs = {
        [_item.."/shields/ogryn_assault_shield_01"] = {
            attachments = {
                left = {
                    item = _item.."/shields/assault_shield_01",
                    children = {},
                },
            },
            display_name = "loc_ogryn_assault_shield_01",
            description = "loc_description_ogryn_assault_shield_01",
            attach_node = "j_leftweaponattach",
            dev_name = "loc_ogryn_assault_shield_01",
            disable_vfx_spawner_exclusion = true,
        },
        [_item.."/shields/ogryn_assault_shield_02"] = {
            attachments = {
                left = {
                    item = _item.."/shields/assault_shield_ml01",
                    children = {},
                },
            },
            display_name = "loc_ogryn_assault_shield_02",
            description = "loc_description_ogryn_assault_shield_02",
            attach_node = "j_leftweaponattach",
            dev_name = "loc_ogryn_assault_shield_02",
            disable_vfx_spawner_exclusion = true,
        },
        [_item.."/shields/ogryn_assault_shield_03"] = {
            attachments = {
                left = {
                    item = _item.."/shields/assault_shield_deluxe01",
                    children = {},
                },
            },
            display_name = "loc_ogryn_assault_shield_03",
            description = "loc_description_ogryn_assault_shield_03",
            attach_node = "j_leftweaponattach",
            dev_name = "loc_ogryn_assault_shield_03",
            disable_vfx_spawner_exclusion = true,
        },
        [_item.."/shields/ogryn_bulwark_shield_01"] = {
            attachments = {
                left = {
                    item = _minion.."/shields/chaos_ogryn_bulwark_shield_01",
                    children = {},
                },
            },
            display_name = "loc_bulwark_shield_01",
            description = "loc_description_bulwark_shield_01",
            attach_node = "j_leftweaponattach",
            dev_name = "loc_bulwark_shield_01",
            disable_vfx_spawner_exclusion = true,
        },
    },
}
