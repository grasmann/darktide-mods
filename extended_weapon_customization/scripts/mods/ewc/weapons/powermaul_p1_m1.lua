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

return {
    attachments = {
        emblem_left = emblem_left,
        emblem_right = emblem_right,
        trinket_hook = trinket_hooks,
        shaft = {
            human_power_maul_shaft_01 = {
                replacement_path = _item_ranged.."/shafts/human_power_maul_shaft_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.025, -1, .2},
            },
            human_power_maul_shaft_02 = {
                replacement_path = _item_ranged.."/shafts/human_power_maul_shaft_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.025, -1, .2},
            },
            human_power_maul_shaft_03 = {
                replacement_path = _item_ranged.."/shafts/human_power_maul_shaft_03",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.025, -1, .2},
            },
            human_power_maul_shaft_04 = {
                replacement_path = _item_ranged.."/shafts/human_power_maul_shaft_04",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.025, -1, .2},
            },
            human_power_maul_shaft_05 = {
                replacement_path = _item_ranged.."/shafts/human_power_maul_shaft_05",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.025, -1, .2},
            },
            human_power_maul_shaft_06 = {
                replacement_path = _item_ranged.."/shafts/human_power_maul_shaft_06",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.025, -1, .2},
            },
            human_power_maul_shaft_ml01 = {
                replacement_path = _item_ranged.."/shafts/human_power_maul_shaft_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.025, -1, .2},
            },
        },
        head = {
            human_power_maul_head_01 = {
                replacement_path = _item_melee.."/heads/human_power_maul_head_01",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.025, -1.25, .3},
            },
            human_power_maul_head_02 = {
                replacement_path = _item_melee.."/heads/human_power_maul_head_02",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.025, -1.25, .3},
            },
            human_power_maul_head_03 = {
                replacement_path = _item_melee.."/heads/human_power_maul_head_03",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.025, -1.25, .3},
            },
            human_power_maul_head_04 = {
                replacement_path = _item_melee.."/heads/human_power_maul_head_04",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.025, -1.25, .3},
            },
            human_power_maul_head_05 = {
                replacement_path = _item_melee.."/heads/human_power_maul_head_05",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.025, -1.25, .3},
            },
            human_power_maul_head_06 = {
                replacement_path = _item_melee.."/heads/human_power_maul_head_06",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.025, -1.25, .3},
            },
            human_power_maul_head_ml01 = {
                replacement_path = _item_melee.."/heads/human_power_maul_head_ml01",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.025, -1.25, .3},
            },
        },
        connector = {
            human_power_maul_connector_01 = {
                replacement_path = _item_melee.."/connectors/human_power_maul_connector_01",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {-.025, -.75, .275},
            },
            human_power_maul_connector_02 = {
                replacement_path = _item_melee.."/connectors/human_power_maul_connector_02",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {-.025, -.75, .275},
            },
            human_power_maul_connector_03 = {
                replacement_path = _item_melee.."/connectors/human_power_maul_connector_03",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {-.025, -.75, .275},
            },
            human_power_maul_connector_04 = {
                replacement_path = _item_melee.."/connectors/human_power_maul_connector_04",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {-.025, -.75, .275},
            },
            human_power_maul_connector_05 = {
                replacement_path = _item_melee.."/connectors/human_power_maul_connector_05",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {-.025, -.75, .275},
            },
            human_power_maul_connector_06 = {
                replacement_path = _item_melee.."/connectors/human_power_maul_connector_06",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {-.025, -.75, .275},
            },
            human_power_maul_connector_07 = {
                replacement_path = _item_melee.."/connectors/human_power_maul_connector_07",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {-.025, -.75, .275},
            },
            human_power_maul_connector_ml01 = {
                replacement_path = _item_melee.."/connectors/human_power_maul_connector_ml01",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {-.025, -.75, .275},
            },
        },
    },
}
