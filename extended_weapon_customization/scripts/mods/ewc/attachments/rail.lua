local mod = get_mod("extended_weapon_customization")

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
    stubgun_pistol_rail_off = {
        replacement_path = _item_ranged.."/rails/stubgun_pistol_rail_off",
        icon_render_unit_rotation_offset = {90, 0, 30},
        icon_render_camera_position_offset = {.075, -1, .05},
        hide_from_selection = true,
    },
    lasgun_rifle_rail_01 = {
        replacement_path = _item_ranged.."/rails/lasgun_rifle_rail_01",
        icon_render_unit_rotation_offset = {90, 0, 30},
        icon_render_camera_position_offset = {.075, -1, .05},
        hide_from_selection = true,
    },
    lasgun_pistol_rail_01 = {
        replacement_path = _item_ranged.."/rails/lasgun_pistol_rail_01",
        icon_render_unit_rotation_offset = {90, 0, 30},
        icon_render_camera_position_offset = {.075, -1, .05},
        hide_from_selection = true,
    },
}
