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
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

local invisible_flashlight = {
    attachments = {
        flashlight = {
            item = _item_ranged.."/flashlights/flashlight_01",
            fix = {
                offset = {
                    node = 1,
                    position = vector3_box(.075, 0, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(.001, .001, .001),
                },
            },
            children = {},
        },
    },
    display_name = "loc_invisible_flashlight",
    description = "loc_description_invisible_flashlight",
    attach_node = "ap_flashlight_01",
    dev_name = "invisible_flashlight",
    disable_vfx_spawner_exclusion = true,
}

if not mod:pt().game_initialized then
    mod:kitbash_preload(_item_ranged.."/flashlights/invisible_flashlight", invisible_flashlight)
else
    mod:kitbash_item(_item_ranged.."/flashlights/invisible_flashlight", invisible_flashlight)
end

return {
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
}
