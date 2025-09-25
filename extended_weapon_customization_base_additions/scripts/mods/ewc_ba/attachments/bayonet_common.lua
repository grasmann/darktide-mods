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
    bayonet_01 = {
        replacement_path = _item_ranged.."/bayonets/bayonet_01",
        icon_render_unit_rotation_offset = {45, 0, 30},
        icon_render_camera_position_offset = {-.1, -2, 0},
    },
    bayonet_02 = {
        replacement_path = _item_ranged.."/bayonets/bayonet_02",
        icon_render_unit_rotation_offset = {45, 0, 30},
        icon_render_camera_position_offset = {-.15, -2.5, -.1},
    },
    bayonet_03 = {
        replacement_path = _item_ranged.."/bayonets/bayonet_03",
        icon_render_unit_rotation_offset = {45, 0, 30},
        icon_render_camera_position_offset = {-.15, -2, -.1},
    },
    bayonet_05 = {
        replacement_path = _item_ranged.."/bayonets/bayonet_05",
        icon_render_unit_rotation_offset = {45, 0, 30},
        icon_render_camera_position_offset = {-.1, -2, 0},
    },
}
