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

return {
    power_falchion_blade_01 = {
        replacement_path = _item_melee.."/blades/power_falchion_blade_01",
        icon_render_unit_rotation_offset = {90, 30, 0},
        icon_render_camera_position_offset = {-.025, -2.5, .7},
        damage_type = "metal_slashing_medium",
    },
    power_falchion_blade_02 = {
        replacement_path = _item_melee.."/blades/power_falchion_blade_02",
        icon_render_unit_rotation_offset = {90, 30, 0},
        icon_render_camera_position_offset = {-.025, -2.5, .7},
        damage_type = "metal_slashing_medium",
    },
    power_falchion_blade_ml01 = {
        replacement_path = _item_melee.."/blades/power_falchion_blade_ml01",
        icon_render_unit_rotation_offset = {90, 30, 0},
        icon_render_camera_position_offset = {-.025, -2.5, .7},
        damage_type = "metal_slashing_medium",
    },
}
