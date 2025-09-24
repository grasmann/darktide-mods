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
    decalleft_01 = {
        replacement_path = _item_ranged.."/decals/decalleft_01",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    decalleft_02 = {
        replacement_path = _item_ranged.."/decals/decalleft_02",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
    decalleft_03 = {
        replacement_path = _item_ranged.."/decals/decalleft_03",
        icon_render_unit_rotation_offset = {-90, 180, 10},
        icon_render_camera_position_offset = {.0075, 0, .15},
    },
}
