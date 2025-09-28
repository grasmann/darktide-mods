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
    autogun_rifle_receiver_01 = {
        replacement_path = _item_ranged.."/recievers/autogun_rifle_receiver_01",
        icon_render_unit_rotation_offset = {90, 0, 45},
        icon_render_camera_position_offset = {-.175, -2, .25},
    },
    autogun_rifle_receiver_ml01 = {
        replacement_path = _item_ranged.."/recievers/autogun_rifle_receiver_ml01",
        icon_render_unit_rotation_offset = {90, 0, 45},
        icon_render_camera_position_offset = {-.175, -2, .25},
    },
}
