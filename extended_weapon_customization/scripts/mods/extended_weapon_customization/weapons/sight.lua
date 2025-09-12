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
    reflex_sight_01 = {
        replacement_path = _item_ranged.."/sights/reflex_sight_01",
        icon_render_unit_rotation_offset = {90, 0, -95},
        icon_render_camera_position_offset = {.035, -.1, .175},
    },
    reflex_sight_02 = {
        replacement_path = _item_ranged.."/sights/reflex_sight_02",
        icon_render_unit_rotation_offset = {90, 0, -95},
        icon_render_camera_position_offset = {.035, -.1, .175},
    },
    reflex_sight_03 = {
        replacement_path = _item_ranged.."/sights/reflex_sight_03",
        icon_render_unit_rotation_offset = {90, 0, -95},
        icon_render_camera_position_offset = {.035, -.1, .175},
    },
    scope_01 = {
        replacement_path = _item_ranged.."/sights/scope_01",
        icon_render_unit_rotation_offset = {90, 0, -85},
        icon_render_camera_position_offset = {0, -.8, .45},
    },
}
