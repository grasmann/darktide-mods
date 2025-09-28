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
    lasgun_rifle_elysian_barrel_01 = {
        replacement_path = _item_ranged.."/barrels/lasgun_rifle_elysian_barrel_01",
        icon_render_unit_rotation_offset = {90, -20, 90 - 30},
        icon_render_camera_position_offset = {-.115, -1.5, 0},
    },
    lasgun_rifle_elysian_barrel_02 = {
        replacement_path = _item_ranged.."/barrels/lasgun_rifle_elysian_barrel_02",
        icon_render_unit_rotation_offset = {90, -20, 90 - 30},
        icon_render_camera_position_offset = {-.115, -1.5, 0},
    },
    lasgun_rifle_elysian_barrel_03 = {
        replacement_path = _item_ranged.."/barrels/lasgun_rifle_elysian_barrel_03",
        icon_render_unit_rotation_offset = {90, -20, 90 - 30},
        icon_render_camera_position_offset = {-.115, -1.5, 0},
    },
    lasgun_rifle_elysian_barrel_04 = {
        replacement_path = _item_ranged.."/barrels/lasgun_rifle_elysian_barrel_04",
        icon_render_unit_rotation_offset = {90, -20, 90 - 30},
        icon_render_camera_position_offset = {-.115, -1.5, 0},
    },
    lasgun_rifle_elysian_barrel_05 = {
        replacement_path = _item_ranged.."/barrels/lasgun_rifle_elysian_barrel_05",
        icon_render_unit_rotation_offset = {90, -20, 90 - 30},
        icon_render_camera_position_offset = {-.115, -1.5, 0},
    },
}
