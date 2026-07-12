local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local trinket_hooks = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/trinket_hook")
local flashlights = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/flashlight")
local emblem_left = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/emblem_left")
local emblem_right = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/emblem_right")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local table = table
    local vector3 = Vector3
    local vector3_box = Vector3Box
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
-- local _item_ranged = _item.."/ranged"
local _item_melee = _item.."/melee"
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

return {
    attachments = {
        emblem_left = emblem_left,
        emblem_right = emblem_right,
        trinket_hook = trinket_hooks,
        left = {
            transonic_knife_p1_m1 = {
                replacement_path = _item_melee.."/transonic_knife_p1_m1",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.115, -1.5, .25},
            },
            -- transonic_knife_p1_ml01 = {
            --     replacement_path = _item_melee.."/transonic_knife_p1_ml01",
            --     icon_render_unit_rotation_offset = {90, 0, 45},
            --     icon_render_camera_position_offset = {-.115, -1.5, .25},
            -- },
            -- transonic_knife_p1_deluxe01 = {
            --     replacement_path = _item_melee.."/transonic_knife_p1_deluxe01",
            --     icon_render_unit_rotation_offset = {90, 0, 45},
            --     icon_render_camera_position_offset = {-.115, -1.5, .25},
            -- },
            -- transonic_sword_p1_m1 = {
            --     replacement_path = _item_melee.."/transonic_sword_p1_m1",
            --     icon_render_unit_rotation_offset = {90, 0, 45},
            --     icon_render_camera_position_offset = {-.115, -1.5, .25},
            -- },
            -- transonic_sword_p1_ml01 = {
            --     replacement_path = _item_melee.."/transonic_sword_p1_ml01",
            --     icon_render_unit_rotation_offset = {90, 0, 45},
            --     icon_render_camera_position_offset = {-.115, -1.5, .25},
            -- },
            -- transonic_sword_p1_deluxe01 = {
            --     replacement_path = _item_melee.."/transonic_sword_p1_deluxe01",
            --     icon_render_unit_rotation_offset = {90, 0, 45},
            --     icon_render_camera_position_offset = {-.115, -1.5, .25},
            -- },
        },
        right = {
            -- transonic_knife_p1_m1 = {
            --     replacement_path = _item_melee.."/transonic_knife_p1_m1",
            --     icon_render_unit_rotation_offset = {90, 0, 45},
            --     icon_render_camera_position_offset = {-.115, -1.5, .25},
            -- },
            -- transonic_knife_p1_ml01 = {
            --     replacement_path = _item_melee.."/transonic_knife_p1_ml01",
            --     icon_render_unit_rotation_offset = {90, 0, 45},
            --     icon_render_camera_position_offset = {-.115, -1.5, .25},
            -- },
            -- transonic_knife_p1_deluxe01 = {
            --     replacement_path = _item_melee.."/transonic_knife_p1_deluxe01",
            --     icon_render_unit_rotation_offset = {90, 0, 45},
            --     icon_render_camera_position_offset = {-.115, -1.5, .25},
            -- },
            transonic_sword_p1_m1 = {
                replacement_path = _item_melee.."/transonic_sword_p1_m1",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.115, -1.5, .25},
            },
            -- transonic_sword_p1_ml01 = {
            --     replacement_path = _item_melee.."/transonic_sword_p1_ml01",
            --     icon_render_unit_rotation_offset = {90, 0, 45},
            --     icon_render_camera_position_offset = {-.115, -1.5, .25},
            -- },
            -- transonic_sword_p1_deluxe01 = {
            --     replacement_path = _item_melee.."/transonic_sword_p1_deluxe01",
            --     icon_render_unit_rotation_offset = {90, 0, 45},
            --     icon_render_camera_position_offset = {-.115, -1.5, .25},
            -- },
        },
    },
}
