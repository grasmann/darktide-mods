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
local _minion = "content/items/weapons/minions"
local _item_melee = _item.."/melee"
local _item_ranged = _item.."/ranged"
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

local _ogryn_shields = "ogryn_shield_01|ogryn_shield_02|ogryn_shield_03|ogryn_shield_04|ogryn_shield_05|ogryn_shield_06|ogryn_shield_07"

return {
    attachments = {
        emblem_left = emblem_left,
        emblem_right = emblem_right,
        trinket_hook = trinket_hooks,
        shaft = {
            human_power_maul_short_shaft_01 = {
                replacement_path = _item_ranged.."/shafts/human_power_maul_short_shaft_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.025, -1, .2},
            },
            human_power_maul_short_shaft_02 = {
                replacement_path = _item_ranged.."/shafts/human_power_maul_short_shaft_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.025, -1, .2},
            },
            human_power_maul_short_shaft_03 = {
                replacement_path = _item_ranged.."/shafts/human_power_maul_short_shaft_03",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.025, -1, .2},
            },
            human_power_maul_short_shaft_ml01 = {
                replacement_path = _item_ranged.."/shafts/human_power_maul_short_shaft_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.025, -1, .2},
            },
            human_power_maul_short_shaft_ml02 = {
                replacement_path = _item_ranged.."/shafts/human_power_maul_short_shaft_ml02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.025, -1, .2},
            },
            human_power_maul_short_shaft_deluxe01 = {
                replacement_path = _item_ranged.."/shafts/human_power_maul_short_shaft_deluxe01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.025, -1, .2},
            },
            human_power_maul_short_shaft_deluxe02 = {
                replacement_path = _item_ranged.."/shafts/human_power_maul_short_shaft_deluxe02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.025, -1, .2},
            },
        },
        head = {
            human_power_maul_short_head_01 = {
                replacement_path = _item_melee.."/heads/human_power_maul_short_head_01",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.025, -1.25, .3},
            },
            human_power_maul_short_head_02 = {
                replacement_path = _item_melee.."/heads/human_power_maul_short_head_02",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.025, -1.25, .2},
            },
            human_power_maul_short_head_03 = {
                replacement_path = _item_melee.."/heads/human_power_maul_short_head_03",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.025, -1.25, .1},
            },
            human_power_maul_short_head_ml01 = {
                replacement_path = _item_melee.."/heads/human_power_maul_short_head_ml01",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.025, -1.25, .3},
            },
            human_power_maul_short_head_ml02 = {
                replacement_path = _item_melee.."/heads/human_power_maul_short_head_ml02",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.025, -1.25, .2},
            },
            human_power_maul_short_head_deluxe01 = {
                replacement_path = _item_melee.."/heads/human_power_maul_short_head_deluxe01",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.025, -1.25, .3},
            },
            human_power_maul_short_head_deluxe02 = {
                replacement_path = _item_melee.."/heads/human_power_maul_short_head_deluxe02",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.025, -1.25, .2},
            },
        },
        connector = {
            human_power_maul_short_connector_01 = {
                replacement_path = _item_melee.."/connectors/human_power_maul_short_connector_01",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {-.025, -.75, .275},
            },
            human_power_maul_short_connector_02 = {
                replacement_path = _item_melee.."/connectors/human_power_maul_short_connector_02",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {-.025, -.75, .275},
            },
            human_power_maul_short_connector_03 = {
                replacement_path = _item_melee.."/connectors/human_power_maul_short_connector_03",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {-.025, -.75, .275},
            },
            human_power_maul_short_connector_ml01 = {
                replacement_path = _item_melee.."/connectors/human_power_maul_short_connector_ml01",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {-.025, -.75, .275},
            },
            human_power_maul_short_connector_ml02 = {
                replacement_path = _item_melee.."/connectors/human_power_maul_short_connector_ml02",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {-.025, -.75, .275},
            },
            human_power_maul_short_connector_deluxe01 = {
                replacement_path = _item_melee.."/connectors/human_power_maul_short_connector_deluxe01",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {-.025, -.75, .275},
            },
            human_power_maul_short_connector_deluxe02 = {
                replacement_path = _item_melee.."/connectors/human_power_maul_short_connector_deluxe02",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {-.025, -.75, .275},
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
            ogryn_shield_01 = {
                replacement_path = _item.."/shields/ogryn_shield_01",
                icon_render_unit_rotation_offset = {90, 15, 90 + 60},
                icon_render_camera_position_offset = {.3, -14, .05},
            },
            ogryn_shield_02 = {
                replacement_path = _item.."/shields/ogryn_shield_02",
                icon_render_unit_rotation_offset = {90, 15, 90 + 60},
                icon_render_camera_position_offset = {.3, -14, .05},
            },
            ogryn_shield_03 = {
                replacement_path = _item.."/shields/ogryn_shield_03",
                icon_render_unit_rotation_offset = {90, 15, 90 + 60},
                icon_render_camera_position_offset = {.3, -14, .05},
            },
            ogryn_shield_04 = {
                replacement_path = _item.."/shields/ogryn_shield_04",
                icon_render_unit_rotation_offset = {90, 15, 90 + 60},
                icon_render_camera_position_offset = {.3, -14, .05},
            },
            ogryn_shield_05 = {
                replacement_path = _item.."/shields/ogryn_shield_05",
                icon_render_unit_rotation_offset = {90, 15, 90 + 60},
                icon_render_camera_position_offset = {.3, -14, .05},
            },
            ogryn_shield_06 = {
                replacement_path = _item.."/shields/ogryn_shield_06",
                icon_render_unit_rotation_offset = {90, 15, 90 + 60},
                icon_render_camera_position_offset = {.3, -14, .05},
            },
            ogryn_shield_07 = {
                replacement_path = _item.."/shields/ogryn_shield_07",
                icon_render_unit_rotation_offset = {90, 15, 90 + 60},
                icon_render_camera_position_offset = {.3, -14, .05},
            },
            bulwark_shield_01 = {
                replacement_path = _item.."/shields/bulwark_shield_01",
                icon_render_unit_rotation_offset = {90, 15, 90 + 60},
                icon_render_camera_position_offset = {.5, -14, .3},
            },
        }
    },
    fixes = {
        {attachment_slot = "left",
            requirements = {
                left = {
                    has = _ogryn_shields,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(.5, .5, .5),
                    node = 1,
                },
            },
        },
        {attachment_slot = "left",
            requirements = {
                left = {
                    has = "bulwark_shield_01",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.025),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(.5, .5, .5),
                    node = 1,
                },
            },
        },
    },
    kitbashs = {
        [_item.."/shields/bulwark_shield_01"] = {
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
        [_item.."/shields/ogryn_shield_01"] = {
            attachments = {
                left = {
                    item = _item_melee.."/ogryn_slabshield_p1_m1",
                    children = {},
                },
            },
            display_name = "loc_ogryn_shield_01",
            description = "loc_description_ogryn_shield_01",
            attach_node = "j_leftweaponattach",
            dev_name = "loc_ogryn_shield_01",
            disable_vfx_spawner_exclusion = true,
        },
        [_item.."/shields/ogryn_shield_02"] = {
            attachments = {
                left = {
                    item = _item_melee.."/ogryn_slabshield_p1_m2",
                    children = {},
                },
            },
            display_name = "loc_ogryn_shield_02",
            description = "loc_description_ogryn_shield_02",
            attach_node = "j_leftweaponattach",
            dev_name = "loc_ogryn_shield_02",
            disable_vfx_spawner_exclusion = true,
        },
        [_item.."/shields/ogryn_shield_03"] = {
            attachments = {
                left = {
                    item = _item_melee.."/ogryn_slabshield_p1_m3",
                    children = {},
                },
            },
            display_name = "loc_ogryn_shield_03",
            description = "loc_description_ogryn_shield_03",
            attach_node = "j_leftweaponattach",
            dev_name = "loc_ogryn_shield_03",
            disable_vfx_spawner_exclusion = true,
        },
        [_item.."/shields/ogryn_shield_04"] = {
            attachments = {
                left = {
                    item = _item_melee.."/ogryn_slabshield_p1_04",
                    children = {},
                },
            },
            display_name = "loc_ogryn_shield_04",
            description = "loc_description_ogryn_shield_04",
            attach_node = "j_leftweaponattach",
            dev_name = "loc_ogryn_shield_04",
            disable_vfx_spawner_exclusion = true,
        },
        [_item.."/shields/ogryn_shield_05"] = {
            attachments = {
                left = {
                    item = _item_melee.."/ogryn_slabshield_p1_05",
                    children = {},
                },
            },
            display_name = "loc_ogryn_shield_05",
            description = "loc_description_ogryn_shield_05",
            attach_node = "j_leftweaponattach",
            dev_name = "loc_ogryn_shield_05",
            disable_vfx_spawner_exclusion = true,
        },
        [_item.."/shields/ogryn_shield_06"] = {
            attachments = {
                left = {
                    item = _item_melee.."/ogryn_slabshield_p1_06",
                    children = {},
                },
            },
            display_name = "loc_ogryn_shield_06",
            description = "loc_description_ogryn_shield_06",
            attach_node = "j_leftweaponattach",
            dev_name = "loc_ogryn_shield_06",
            disable_vfx_spawner_exclusion = true,
        },
        [_item.."/shields/ogryn_shield_07"] = {
            attachments = {
                left = {
                    item = _item_melee.."/ogryn_slabshield_p1_ml01",
                    children = {},
                },
            },
            display_name = "loc_ogryn_shield_07",
            description = "loc_description_ogryn_shield_07",
            attach_node = "j_leftweaponattach",
            dev_name = "loc_ogryn_shield_07",
            disable_vfx_spawner_exclusion = true,
        },
    }
}
