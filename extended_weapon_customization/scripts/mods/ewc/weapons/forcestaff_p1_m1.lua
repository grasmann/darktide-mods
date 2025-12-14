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
local _item_ranged = _item.."/ranged"
local _item_melee = _item.."/melee"

return {
    attachments = {
        emblem_left = emblem_left,
        emblem_right = emblem_right,
        trinket_hook = trinket_hooks,
        head = {
            force_staff_head_01 = {
                replacement_path = _item_melee.."/heads/force_staff_head_01",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.075, -2.25, .3},
            },
            force_staff_head_02 = {
                replacement_path = _item_melee.."/heads/force_staff_head_02",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.075, -2.25, .3},
            },
            force_staff_head_03 = {
                replacement_path = _item_melee.."/heads/force_staff_head_03",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.075, -2.25, .3},
            },
            force_staff_head_04 = {
                replacement_path = _item_melee.."/heads/force_staff_head_04",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.075, -2.25, .3},
            },
            force_staff_head_05 = {
                replacement_path = _item_melee.."/heads/force_staff_head_05",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.075, -2.25, .3},
            },
            force_staff_head_06 = {
                replacement_path = _item_melee.."/heads/force_staff_head_06",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.075, -2.25, .3},
            },
            force_staff_head_07 = {
                replacement_path = _item_melee.."/heads/force_staff_head_07",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.075, -2.25, .3},
            },
            force_staff_head_08 = {
                replacement_path = _item_melee.."/heads/force_staff_head_08",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.075, -2.25, .3},
            },
            force_staff_head_09 = {
                replacement_path = _item_melee.."/heads/force_staff_head_09",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.075, -2.25, .3},
            },
            force_staff_head_10 = {
                replacement_path = _item_melee.."/heads/force_staff_head_10",
                icon_render_unit_rotation_offset = {90, 30, 0},
                icon_render_camera_position_offset = {-.075, -2.25, .3},
            },
        },
        body = {
            force_staff_full_01 = {
                replacement_path = _item_melee.."/full/force_staff_full_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.025, -1.5, .4},
            },
            force_staff_full_02 = {
                replacement_path = _item_melee.."/full/force_staff_full_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.025, -1.5, .4},
            },
            force_staff_full_03 = {
                replacement_path = _item_melee.."/full/force_staff_full_03",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.025, -1.5, .4},
            },
            force_staff_full_04 = {
                replacement_path = _item_melee.."/full/force_staff_full_04",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.025, -1.5, .4},
            },
            force_staff_full_05 = {
                replacement_path = _item_melee.."/full/force_staff_full_05",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1.5, .4},
            },
            force_staff_full_06 = {
                replacement_path = _item_melee.."/full/force_staff_full_06",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1.5, .4},
            },
            force_staff_full_ml01 = {
                replacement_path = _item_melee.."/full/force_staff_full_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {.025, -1.5, .4},
            },
        },
        shaft_upper = {
            force_staff_shaft_upper_01 = {
                replacement_path = _item_ranged.."/shafts/force_staff_shaft_upper_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1.5, .5},
            },
            force_staff_shaft_upper_02 = {
                replacement_path = _item_ranged.."/shafts/force_staff_shaft_upper_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1.5, .5},
            },
            force_staff_shaft_upper_03 = {
                replacement_path = _item_ranged.."/shafts/force_staff_shaft_upper_03",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1.5, .5},
            },
            force_staff_shaft_upper_04 = {
                replacement_path = _item_ranged.."/shafts/force_staff_shaft_upper_04",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1.5, .5},
            },
            force_staff_shaft_upper_05 = {
                replacement_path = _item_ranged.."/shafts/force_staff_shaft_upper_05",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1.5, .5},
            },
            force_staff_shaft_upper_06 = {
                replacement_path = _item_ranged.."/shafts/force_staff_shaft_upper_06",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1.5, .5},
            },
            force_staff_shaft_upper_ml01 = {
                replacement_path = _item_ranged.."/shafts/force_staff_shaft_upper_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {0, -1.5, .5},
            },
        },
        shaft_lower = {
            force_staff_shaft_lower_01 = {
                replacement_path = _item_ranged.."/shafts/force_staff_shaft_lower_01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.16, -4, -1.2},
            },
            force_staff_shaft_lower_02 = {
                replacement_path = _item_ranged.."/shafts/force_staff_shaft_lower_02",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.16, -4, -1.2},
            },
            force_staff_shaft_lower_03 = {
                replacement_path = _item_ranged.."/shafts/force_staff_shaft_lower_03",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.16, -4, -1.2},
            },
            force_staff_shaft_lower_04 = {
                replacement_path = _item_ranged.."/shafts/force_staff_shaft_lower_04",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.16, -4, -1.2},
            },
            force_staff_shaft_lower_05 = {
                replacement_path = _item_ranged.."/shafts/force_staff_shaft_lower_05",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.16, -4, -1.2},
            },
            force_staff_shaft_lower_06 = {
                replacement_path = _item_ranged.."/shafts/force_staff_shaft_lower_06",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.16, -4, -1.2},
            },
            force_staff_shaft_lower_ml01 = {
                replacement_path = _item_ranged.."/shafts/force_staff_shaft_lower_ml01",
                icon_render_unit_rotation_offset = {90, -30, 0},
                icon_render_camera_position_offset = {-.16, -4, -1.2},
            },
        },
    },
    fixes = {
        {attachment_slot = "view_settings",
            fix = {
                max_zoom = 12,
            },
        },
    },
}
