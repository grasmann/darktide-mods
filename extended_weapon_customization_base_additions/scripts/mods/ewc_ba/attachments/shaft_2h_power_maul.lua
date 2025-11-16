local mod = get_mod("extended_weapon_customization_base_additions")

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
    ["2h_power_maul_shaft_01"] = {
        replacement_path = _item_melee.."/shafts/2h_power_maul_shaft_01",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {.025, -2.25, .4},
    },
    ["2h_power_maul_shaft_02"] = {
        replacement_path = _item_melee.."/shafts/2h_power_maul_shaft_02",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {.025, -2.25, .4},
    },
    ["2h_power_maul_shaft_03"] = {
        replacement_path = _item_melee.."/shafts/2h_power_maul_shaft_03",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {.025, -2.25, .4},
    },
    ["2h_power_maul_shaft_04"] = {
        replacement_path = _item_melee.."/shafts/2h_power_maul_shaft_04",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {.025, -2.25, .4},
    },
    ["2h_power_maul_shaft_05"] = {
        replacement_path = _item_melee.."/shafts/2h_power_maul_shaft_05",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {.025, -2.25, .4},
    },
    ["2h_power_maul_shaft_06"] = {
        replacement_path = _item_melee.."/shafts/2h_power_maul_shaft_06",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {.025, -2.25, .4},
    },
    ["2h_power_maul_shaft_07"] = {
        replacement_path = _item_melee.."/shafts/2h_power_maul_shaft_07",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {.025, -2.25, .4},
    },
    ["2h_power_maul_shaft_ml01"] = {
        replacement_path = _item_melee.."/shafts/2h_power_maul_shaft_ml01",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {.025, -2.25, .4},
    },
}
