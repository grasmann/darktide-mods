local mod = get_mod("ewc_ba")

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
    trinket_hook_05_steel_v = {
        replacement_path = _item.."/trinkets/trinket_hook_05_steel_v",
        icon_render_unit_rotation_offset = {90, 45, 90 + 30},
        icon_render_camera_position_offset = {-.04, .3, .15},
    },
    trinket_hook_02_90 = {
        replacement_path = _item.."/trinkets/trinket_hook_02_90",
        icon_render_unit_rotation_offset = {90, 45, 90 + 30},
        icon_render_camera_position_offset = {-.035, .3, .15},
    },
    trinket_hook_01_v = {
        replacement_path = _item.."/trinkets/trinket_hook_01_v",
        icon_render_unit_rotation_offset = {90, 45, 90 + 30},
        icon_render_camera_position_offset = {-.035, .3, .15},
    },
    trinket_hook_05_coated = {
        replacement_path = _item.."/trinkets/trinket_hook_05_coated",
        icon_render_unit_rotation_offset = {90, 45, 90 + 30},
        icon_render_camera_position_offset = {-.04, .3, .15},
    },
    trinket_hook_05_carbon_v = {
        replacement_path = _item.."/trinkets/trinket_hook_05_carbon_v",
        icon_render_unit_rotation_offset = {90, 45, 90 + 30},
        icon_render_camera_position_offset = {-.04, .3, .15},
    },
    trinket_hook_03_v = {
        replacement_path = _item.."/trinkets/trinket_hook_03_v",
        icon_render_unit_rotation_offset = {90, 45, 90 + 30},
        icon_render_camera_position_offset = {-.05, .3, .125},
    },
    trinket_hook_05_gold_v = {
        replacement_path = _item.."/trinkets/trinket_hook_05_gold_v",
        icon_render_unit_rotation_offset = {90, 45, 90 + 30},
        icon_render_camera_position_offset = {-.04, .3, .15},
    },
    trinket_hook_04_gold_v = {
        replacement_path = _item.."/trinkets/trinket_hook_04_gold_v",
        icon_render_unit_rotation_offset = {90, 45, 90 + 30},
        icon_render_camera_position_offset = {-.04, .3, .15},
    },
    trinket_hook_02 = {
        replacement_path = _item.."/trinkets/trinket_hook_02",
        icon_render_unit_rotation_offset = {90, 45, 90 + 30},
        icon_render_camera_position_offset = {-.04, .3, .15},
    },
    trinket_hook_03 = {
        replacement_path = _item.."/trinkets/trinket_hook_03",
        icon_render_unit_rotation_offset = {90, 45, 90 + 30},
        icon_render_camera_position_offset = {-.05, .3, .125},
    },
    trinket_hook_04_steel_v = {
        replacement_path = _item.."/trinkets/trinket_hook_04_steel_v",
        icon_render_unit_rotation_offset = {90, 45, 90 + 30},
        icon_render_camera_position_offset = {-.04, .3, .15},
    },
    trinket_hook_04_carbon = {
        replacement_path = _item.."/trinkets/trinket_hook_04_carbon",
        icon_render_unit_rotation_offset = {90, 45, 90 + 30},
        icon_render_camera_position_offset = {-.04, .3, .15},
    },
    trinket_hook_04_gold = {
        replacement_path = _item.."/trinkets/trinket_hook_04_gold",
        icon_render_unit_rotation_offset = {90, 45, 90 + 30},
        icon_render_camera_position_offset = {-.04, .3, .15},
    },
    trinket_hook_04_carbon_v = {
        replacement_path = _item.."/trinkets/trinket_hook_04_carbon_v",
        icon_render_unit_rotation_offset = {90, 45, 90 + 30},
        icon_render_camera_position_offset = {-.04, .3, .15},
    },
    trinket_hook_04_coated = {
        replacement_path = _item.."/trinkets/trinket_hook_04_coated",
        icon_render_unit_rotation_offset = {90, 45, 90 + 30},
        icon_render_camera_position_offset = {-.04, .3, .15},
    },
    trinket_hook_01 = {
        replacement_path = _item.."/trinkets/trinket_hook_01",
        icon_render_unit_rotation_offset = {90, 45, 90 + 30},
        icon_render_camera_position_offset = {-.035, .3, .15},
    },
    trinket_hook_04_steel = {
        replacement_path = _item.."/trinkets/trinket_hook_04_steel",
        icon_render_unit_rotation_offset = {90, 45, 90 + 30},
        icon_render_camera_position_offset = {-.04, .3, .15},
    },
    trinket_hook_02_45 = {
        replacement_path = _item.."/trinkets/trinket_hook_02_45",
        icon_render_unit_rotation_offset = {90, 45, 90 + 30},
        icon_render_camera_position_offset = {-.04, .3, .15},
    },
    trinket_hook_05_gold = {
        replacement_path = _item.."/trinkets/trinket_hook_05_gold",
        icon_render_unit_rotation_offset = {90, 45, 90 + 30},
        icon_render_camera_position_offset = {-.04, .3, .15},
    },
    trinket_hook_05_steel = {
        replacement_path = _item.."/trinkets/trinket_hook_05_steel",
        icon_render_unit_rotation_offset = {90, 45, 90 + 30},
        icon_render_camera_position_offset = {-.04, .3, .15},
    },
    trinket_hook_04_coated_v = {
        replacement_path = _item.."/trinkets/trinket_hook_04_coated_v",
        icon_render_unit_rotation_offset = {90, 45, 90 + 30},
        icon_render_camera_position_offset = {-.04, .3, .15},
    },
    trinket_hook_05_carbon = {
        replacement_path = _item.."/trinkets/trinket_hook_05_carbon",
        icon_render_unit_rotation_offset = {90, 45, 90 + 30},
        icon_render_camera_position_offset = {-.04, .3, .15},
    },
    trinket_hook_05_coated_v = {
        replacement_path = _item.."/trinkets/trinket_hook_05_coated_v",
        icon_render_unit_rotation_offset = {90, 45, 90 + 30},
        icon_render_camera_position_offset = {-.04, .3, .15},
    },
}
