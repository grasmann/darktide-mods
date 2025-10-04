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
local _item_ranged = _item.."/ranged"
local _item_melee = _item.."/melee"
local _item_npc = "content/items/weapons/npc"

return {
    ["2h_power_sword_hilt_01"] = {
        replacement_path = _item_melee.."/hilts/2h_power_sword_hilt_01",
        icon_render_unit_rotation_offset = {90, -20, 30},
        icon_render_camera_position_offset = {-.05, -1.5, .3},
    },
    ["2h_power_sword_hilt_02"] = {
        replacement_path = _item_melee.."/hilts/2h_power_sword_hilt_02",
        icon_render_unit_rotation_offset = {90, -20, 30},
        icon_render_camera_position_offset = {-.05, -1.5, .3},
    },
    ["2h_power_sword_hilt_03"] = {
        replacement_path = _item_melee.."/hilts/2h_power_sword_hilt_03",
        icon_render_unit_rotation_offset = {90, -20, 30},
        icon_render_camera_position_offset = {-.05, -1.5, .3},
    },
    ["2h_power_sword_hilt_ml01"] = {
        replacement_path = _item_melee.."/hilts/2h_power_sword_hilt_ml01",
        icon_render_unit_rotation_offset = {90, -20, 30},
        icon_render_camera_position_offset = {-.05, -1.5, .3},
    },
}
