local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local laser_pointer_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/laser_pointer_human")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local table = table
    local table_merge_recursive = table.merge_recursive
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"

return table_merge_recursive({
    invisible_flashlight = {
        replacement_path = _item_ranged.."/flashlights/invisible_flashlight",
        icon_render_unit_rotation_offset = {0, 0, 0},
        icon_render_camera_position_offset = {0, 0, 0},
        flashlight_template = "autogun_p1",
    },
    flashlight_01 = {
        replacement_path = _item_ranged.."/flashlights/flashlight_01",
        icon_render_unit_rotation_offset = {90, 0, 90 + 30},
        icon_render_camera_position_offset = {-.125, -.75, .15},
        flashlight_template = "lasgun_p1",
    },
    flashlight_02 = {
        replacement_path = _item_ranged.."/flashlights/flashlight_02",
        icon_render_unit_rotation_offset = {90, 0, 90 + 30},
        icon_render_camera_position_offset = {-.075, -.75, .15},
        flashlight_template = "autopistol_p1",
    },
    flashlight_03 = {
        replacement_path = _item_ranged.."/flashlights/flashlight_03",
        icon_render_unit_rotation_offset = {90, 0, 90 + 30},
        icon_render_camera_position_offset = {-.15, -.75, .15},
        flashlight_template = "lasgun_p3",
    },
    flashlight_05 = {
        replacement_path = _item_ranged.."/flashlights/flashlight_05",
        icon_render_unit_rotation_offset = {90, 0, 90 + 30},
        icon_render_camera_position_offset = {-.075, -.75, .15},
        flashlight_template = "autogun_p1",
    },
}, laser_pointer_human)
