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
local _item_melee = _item.."/melee"

return {
    force_sword_pommel_01 = {
        replacement_path = _item_melee.."/pommels/force_sword_pommel_01",
        icon_render_unit_rotation_offset = {90, 45, 0},
        icon_render_camera_position_offset = {0, -.5, .05},
    },
    force_sword_pommel_02 = {
        replacement_path = _item_melee.."/pommels/force_sword_pommel_02",
        icon_render_unit_rotation_offset = {90, 45, 0},
        icon_render_camera_position_offset = {0, -.5, .05},
    },
    force_sword_pommel_03 = {
        replacement_path = _item_melee.."/pommels/force_sword_pommel_03",
        icon_render_unit_rotation_offset = {90, 45, 0},
        icon_render_camera_position_offset = {0, -.5, .05},
    },
    force_sword_pommel_04 = {
        replacement_path = _item_melee.."/pommels/force_sword_pommel_04",
        icon_render_unit_rotation_offset = {90, 45, 0},
        icon_render_camera_position_offset = {0, -.5, .05},
    },
    force_sword_pommel_05 = {
        replacement_path = _item_melee.."/pommels/force_sword_pommel_05",
        icon_render_unit_rotation_offset = {90, 45, 0},
        icon_render_camera_position_offset = {0, -.5, .05},
    },
    force_sword_pommel_ml01 = {
        replacement_path = _item_melee.."/pommels/force_sword_pommel_ml01",
        icon_render_unit_rotation_offset = {90, 45, 0},
        icon_render_camera_position_offset = {0, -.5, .05},
    },
}
