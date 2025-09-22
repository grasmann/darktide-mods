local mod = get_mod("extended_weapon_customization")

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
            item = _item_ranged.."/flashlights/flashlight_ogryn_01",
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
    display_name = "loc_invisible_flashlight_ogryn",
    description = "loc_description_invisible_flashlight_ogryn",
    attach_node = "ap_flashlight_01",
    dev_name = "invisible_flashlight_ogryn",
    disable_vfx_spawner_exclusion = true,
}

-- if not mod:pt().game_initialized then
--     mod:kitbash_preload(invisible_flashlight.attachments, _item_ranged.."/flashlights/invisible_flashlight_ogryn", invisible_flashlight.display_name, invisible_flashlight.description, invisible_flashlight.attach_node, invisible_flashlight.dev_name, true)
-- else
--     mod:kitbash_item(invisible_flashlight.attachments, _item_ranged.."/flashlights/invisible_flashlight_ogryn", invisible_flashlight.display_name, invisible_flashlight.description, invisible_flashlight.attach_node, invisible_flashlight.dev_name, true)
-- end

return {
    invisible_flashlight_ogryn = {
        replacement_path = _item_ranged.."/flashlights/invisible_flashlight_ogryn",
        icon_render_unit_rotation_offset = {0, 0, 0},
        icon_render_camera_position_offset = {0, 0, 0},
    },
    flashlight_ogryn_01 = {
        replacement_path = _item_ranged.."/flashlights/flashlight_ogryn_01",
        icon_render_unit_rotation_offset = {90, 0, 90 + 30},
        icon_render_camera_position_offset = {-.125, -1.75, .15},
    },
    flashlight_ogryn_long_01 = {
        replacement_path = _item_ranged.."/flashlights/flashlight_ogryn_long_01",
        icon_render_unit_rotation_offset = {90, 0, 90 + 30},
        icon_render_camera_position_offset = {-.125, -1.75, .15},
    },
}
