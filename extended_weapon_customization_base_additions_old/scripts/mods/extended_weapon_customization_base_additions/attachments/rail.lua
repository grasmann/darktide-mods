local mod = get_mod("ewc_ba")

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
    lasgun_rifle_rail_01 = {
        replacement_path = _item_ranged.."/rails/lasgun_rifle_rail_01",
        icon_render_unit_rotation_offset = {90, 0, 30},
        icon_render_camera_position_offset = {.075, -1, .05},
    },
    lasgun_pistol_rail_01 = {
        replacement_path = _item_ranged.."/rails/lasgun_pistol_rail_01",
        icon_render_unit_rotation_offset = {90, 0, 30},
        icon_render_camera_position_offset = {.075, -1, .05},
    },
}
