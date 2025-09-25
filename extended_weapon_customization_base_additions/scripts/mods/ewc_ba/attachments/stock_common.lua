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
    stock_01 = {
        replacement_path = _item_ranged.."/stocks/stock_01",
        icon_render_unit_rotation_offset = {90, -10, 30},
        icon_render_camera_position_offset = {.1, -1.5, .2},
    },
    stock_02 = {
        replacement_path = _item_ranged.."/stocks/stock_02",
        icon_render_unit_rotation_offset = {90, -10, 30},
        icon_render_camera_position_offset = {.1, -1.5, .2},
    },
    stock_03 = {
        replacement_path = _item_ranged.."/stocks/stock_03",
        icon_render_unit_rotation_offset = {90, -10, 30},
        icon_render_camera_position_offset = {.1, -1.5, .2},
    },
    stock_04 = {
        replacement_path = _item_ranged.."/stocks/stock_04",
        icon_render_unit_rotation_offset = {90, -10, 30},
        icon_render_camera_position_offset = {.1, -1.5, .2},
    },
    stock_05 = {
        replacement_path = _item_ranged.."/stocks/stock_05",
        icon_render_unit_rotation_offset = {90, -10, 30},
        icon_render_camera_position_offset = {.1, -1.5, .2},
    },
}
