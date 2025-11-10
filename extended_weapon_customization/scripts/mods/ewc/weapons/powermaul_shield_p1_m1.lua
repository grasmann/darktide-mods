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
local _item_melee = _item.."/melee"
local _item_ranged = _item.."/ranged"

local short_heads = "human_power_maul_short_head_01|human_power_maul_short_head_ml01|human_power_maul_short_head_deluxe01"
local medium_heads = "human_power_maul_short_head_02|human_power_maul_short_head_ml02|human_power_maul_short_head_deluxe02"
local long_heads = "human_power_maul_short_head_03"

local short_connectors = "human_power_maul_short_connector_03"
local medium_connectors = "human_power_maul_short_connector_02|human_power_maul_short_connector_ml02|human_power_maul_short_connector_deluxe02"
local long_connectors = "human_power_maul_short_connector_01|human_power_maul_short_connector_ml01|human_power_maul_short_connector_deluxe01"

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
        }
    },
    fixes = {
        {attachment_slot = "head",
            requirements = {
                connector = {
                    has = short_connectors,
                },
                head = {
                    has = short_heads,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.175),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "head",
            requirements = {
                connector = {
                    has = short_connectors,
                },
                head = {
                    has = medium_heads,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.11),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "head",
            requirements = {
                connector = {
                    has = medium_connectors,
                },
                head = {
                    has = short_heads,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.06),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "head",
            requirements = {
                connector = {
                    has = medium_connectors,
                },
                head = {
                    has = long_heads,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .12),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "head",
            requirements = {
                connector = {
                    has = long_connectors,
                },
                head = {
                    has = medium_heads,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .064),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "head",
            requirements = {
                connector = {
                    has = long_connectors,
                },
                head = {
                    has = long_heads,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .172),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
    },
}
