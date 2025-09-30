local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

-- local laser_pointer_functions = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/laser_pointer")
local fire_blade_functions = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/fire_blade")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local vector3_box = Vector3Box
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_melee = _item.."/melee"

return {
    fire_blade_01 = {
        replacement_path = _item_melee.."/blades/power_sword_blade_06",
        icon_render_unit_rotation_offset = {90, 0, 90 + 30},
        icon_render_camera_position_offset = {-.125, -.75, .15},
        -- flashlight_template = "laser_pointer_01",
        -- laser_node = 2,
        -- laser_offset = vector3_box(0, .02, 0),
        -- crosshair_type = "ironsight",
        custom_selection_group = "fire_blades",
        ui_item_init = function(world, attachment_unit, attachment_data)
            fire_blade_functions.spawn_preview_fire_blade(world, attachment_unit, attachment_data)
        end,
        ui_item_deinit = function(world, attachment_unit, attachment_data)
            fire_blade_functions.despwan_preview_fire_blade(world, attachment_unit, attachment_data)
        end,
        on_item_init = function(world, attachment_unit, attachment_data)
            fire_blade_functions.spawn_fire_blade(world, attachment_unit, attachment_data)
        end,
        on_item_deinit = function(world, attachment_unit, attachment_data)
            fire_blade_functions.despawn_fire_blade(world, attachment_unit, attachment_data)
        end,
        on_perspective_change = function(flashlight_extension)
            fire_blade_functions.respawn_fire_blade(flashlight_extension)
        end,
        on_item_update = function(flashlight_extension, dt, t)
            fire_blade_functions.update_fire_blade(flashlight_extension, dt, t)
        end,
        on_update_item_visibility = function(flashlight_extension, wielded_slot)
            fire_blade_functions.update_fire_blade_visibility(flashlight_extension, wielded_slot)
        end,
    },
}
