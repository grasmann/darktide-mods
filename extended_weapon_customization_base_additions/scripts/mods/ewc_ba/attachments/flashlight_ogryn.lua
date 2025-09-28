local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local flashlight_modded_ogryn = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/flashlight_modded_ogryn")
local laser_pointer_ogryn = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/laser_pointer_ogryn")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local table = table
    local vector3 = Vector3
    local vector3_box = Vector3Box
    local vector3_zero = vector3.zero
    local table_merge_recursive = table.merge_recursive
    local table_merge_recursive_n = table.merge_recursive_n
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"

return table_merge_recursive_n({
    flashlight_ogryn_01 = {
        replacement_path = _item_ranged.."/flashlights/flashlight_ogryn_01",
        icon_render_unit_rotation_offset = {90, 0, 90 + 30},
        icon_render_camera_position_offset = {-.125, -1.75, .15},
        flashlight_template = "ogryn_heavy_stubber_p2",
    },
    flashlight_ogryn_long_01 = {
        replacement_path = _item_ranged.."/flashlights/flashlight_ogryn_long_01",
        icon_render_unit_rotation_offset = {90, 0, 90 + 30},
        icon_render_camera_position_offset = {-.125, -1.75, .15},
        flashlight_template = "ogryn_heavy_stubber_p2",
    },
}, laser_pointer_ogryn, flashlight_modded_ogryn)
