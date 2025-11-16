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
    ["2h_force_sword_blade_01"] = {
        replacement_path = _item_melee.."/blades/2h_force_sword_blade_01",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {0, -4, .95},
        damage_type = "metal_slashing_heavy",
    },
    ["2h_force_sword_blade_02"] = {
        replacement_path = _item_melee.."/blades/2h_force_sword_blade_02",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {0, -4, .95},
        damage_type = "metal_slashing_heavy",
    },
    ["2h_force_sword_blade_03"] = {
        replacement_path = _item_melee.."/blades/2h_force_sword_blade_03",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {0, -4, .95},
        damage_type = "metal_slashing_heavy",
    },
    ["2h_force_sword_blade_04"] = {
        replacement_path = _item_melee.."/blades/2h_force_sword_blade_04",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {0, -4, .95},
        damage_type = "metal_slashing_heavy",
    },
    ["2h_force_sword_blade_05"] = {
        replacement_path = _item_melee.."/blades/2h_force_sword_blade_05",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {0, -4, .95},
        damage_type = "metal_slashing_heavy",
    },
    ["2h_force_sword_blade_ml01"] = {
        replacement_path = _item_melee.."/blades/2h_force_sword_blade_ml01",
        icon_render_unit_rotation_offset = {90, -30, 0},
        icon_render_camera_position_offset = {0, -4, .95},
        damage_type = "metal_slashing_heavy",
    },
}
