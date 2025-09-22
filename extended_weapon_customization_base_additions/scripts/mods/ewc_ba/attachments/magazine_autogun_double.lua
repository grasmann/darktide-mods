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
    autogun_rifle_magazine_01_double = {
        replacement_path = _item_ranged.."/magazines/autogun_rifle_magazine_01_double",
        icon_render_unit_rotation_offset = {90, 0, 30},
        icon_render_camera_position_offset = {-.09, -1.5, -.1},
    },
    autogun_rifle_magazine_02_double = {
        replacement_path = _item_ranged.."/magazines/autogun_rifle_magazine_02_double",
        icon_render_unit_rotation_offset = {90, 0, 30},
        icon_render_camera_position_offset = {-.09, -1.5, -.1},
    },
    autogun_rifle_magazine_03_double = {
        replacement_path = _item_ranged.."/magazines/autogun_rifle_magazine_03_double",
        icon_render_unit_rotation_offset = {90, 0, 30},
        icon_render_camera_position_offset = {-.09, -1.5, -.1},
    },
    autogun_rifle_ak_magazine_01_double = {
        replacement_path = _item_ranged.."/magazines/autogun_rifle_ak_magazine_01_double",
        icon_render_unit_rotation_offset = {90, 0, 30},
        icon_render_camera_position_offset = {-.09, -1.5, -.1},
    },
}
