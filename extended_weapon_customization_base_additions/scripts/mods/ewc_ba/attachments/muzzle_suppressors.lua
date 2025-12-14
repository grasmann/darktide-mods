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

return {
    autogun_rifle_suppressed_muzzle_01 = {
        replacement_path = _item_ranged.."/muzzles/autogun_rifle_suppressed_muzzle_01",
        icon_render_unit_rotation_offset = {90, 0, 30},
        icon_render_camera_position_offset = {-.225, -2.25, .15},
        damage_type = "suppressed",
        custom_selection_group = "suppressors",
    },
    autogun_rifle_suppressed_muzzle_02 = {
        replacement_path = _item_ranged.."/muzzles/autogun_rifle_suppressed_muzzle_02",
        icon_render_unit_rotation_offset = {90, 0, 30},
        icon_render_camera_position_offset = {-.225, -2.25, .15},
        damage_type = "suppressed",
        custom_selection_group = "suppressors",
    },
    autogun_rifle_suppressed_muzzle_03 = {
        replacement_path = _item_ranged.."/muzzles/autogun_rifle_suppressed_muzzle_03",
        icon_render_unit_rotation_offset = {90, 0, 30},
        icon_render_camera_position_offset = {-.225, -2.25, .15},
        damage_type = "suppressed",
        custom_selection_group = "suppressors",
    },
}
