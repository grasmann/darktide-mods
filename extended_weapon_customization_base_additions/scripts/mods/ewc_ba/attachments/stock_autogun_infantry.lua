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
    autogun_rifle_stock_01 = {
        replacement_path = _item_ranged.."/stocks/autogun_rifle_stock_01",
        icon_render_unit_rotation_offset = {90, -10, 30},
        icon_render_camera_position_offset = {.1, -1.5, .2},
    },
    autogun_rifle_stock_02 = {
        replacement_path = _item_ranged.."/stocks/autogun_rifle_stock_02",
        icon_render_unit_rotation_offset = {90, -10, 30},
        icon_render_camera_position_offset = {.1, -1.5, .2},
    },
    autogun_rifle_stock_03 = {
        replacement_path = _item_ranged.."/stocks/autogun_rifle_stock_03",
        icon_render_unit_rotation_offset = {90, -10, 30},
        icon_render_camera_position_offset = {.1, -1.5, .2},
    },
    autogun_rifle_stock_04 = {
        replacement_path = _item_ranged.."/stocks/autogun_rifle_stock_04",
        icon_render_unit_rotation_offset = {90, -10, 30},
        icon_render_camera_position_offset = {.1, -1.5, .2},
    },
    autogun_rifle_stock_ml01 = {
        replacement_path = _item_ranged.."/stocks/autogun_rifle_stock_ml01",
        icon_render_unit_rotation_offset = {90, -10, 30},
        icon_render_camera_position_offset = {.1, -1.5, .2},
    },
}
