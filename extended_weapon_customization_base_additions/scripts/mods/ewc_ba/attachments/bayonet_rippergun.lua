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
    rippergun_rifle_bayonet_01 = {
        replacement_path = _item_ranged.."/bayonets/rippergun_rifle_bayonet_01",
        icon_render_unit_rotation_offset = {90, -10, 90 - 40},
        icon_render_camera_position_offset = {-.4, -5, .25},
    },
    rippergun_rifle_bayonet_02 = {
        replacement_path = _item_ranged.."/bayonets/rippergun_rifle_bayonet_02",
        icon_render_unit_rotation_offset = {90, -10, 90 - 40},
        icon_render_camera_position_offset = {-.4, -5, .25},
    },
    rippergun_rifle_bayonet_03 = {
        replacement_path = _item_ranged.."/bayonets/rippergun_rifle_bayonet_03",
        icon_render_unit_rotation_offset = {90, -10, 90 - 40},
        icon_render_camera_position_offset = {-.4, -5, .25},
    },
    rippergun_rifle_bayonet_04 = {
        replacement_path = _item_ranged.."/bayonets/rippergun_rifle_bayonet_04",
        icon_render_unit_rotation_offset = {90, -10, 90 - 40},
        icon_render_camera_position_offset = {-.4, -5, .25},
    },
    rippergun_rifle_bayonet_05 = {
        replacement_path = _item_ranged.."/bayonets/rippergun_rifle_bayonet_05",
        icon_render_unit_rotation_offset = {90, -10, 90 - 40},
        icon_render_camera_position_offset = {-.4, -5, .25},
    },
    rippergun_rifle_bayonet_ml01 = {
        replacement_path = _item_ranged.."/bayonets/rippergun_rifle_bayonet_ml01",
        icon_render_unit_rotation_offset = {90, -10, 90 - 40},
        icon_render_camera_position_offset = {-.4, -5, .25},
    },
}
