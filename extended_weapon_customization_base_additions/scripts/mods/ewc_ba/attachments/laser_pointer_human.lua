local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local laser_pointer_functions = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/laser_pointer")

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

return {
    laser_pointer_01 = {
        replacement_path = _item_ranged.."/laser_pointers/laser_pointer_01",
        icon_render_unit_rotation_offset = {90, 0, 90 + 30},
        icon_render_camera_position_offset = {-.125, -.75, .15},
        attachment_selection_position_offset = {0, 0, 0},
        attachment_selection_rotation_offset = 3,

        flashlight_template = "laser_pointer_01",
        laser_particle_effect = "content/fx/particles/enemies/sniper_laser_sight",
        dot_particle_effect = "content/fx/particles/enemies/red_glowing_eyes",
        laser_color = vector3_box(1, 0, 0),
        laser_node = 2,
        laser_offset = vector3_box(0, .02, 0),
        crosshair_type = "ironsight",
        custom_selection_group = "laser_pointers",
        ui_item_init = function(world, attachment_unit, attachment_data)
            laser_pointer_functions.spawn_preview_laser(world, attachment_unit, attachment_data)
        end,
        ui_item_deinit = function(world, attachment_unit, attachment_data)
            laser_pointer_functions.despwan_preview_lasers(world, attachment_unit, attachment_data)
        end,
        on_flashlight_on = function(flashlight_extension)
            laser_pointer_functions.spawn_laser_pointer(flashlight_extension)
        end,
        on_perspective_change = function(flashlight_extension)
            laser_pointer_functions.respawn_laser_pointer(flashlight_extension)
        end,
        on_flashlight_update = function(flashlight_extension, dt, t)
            laser_pointer_functions.update_laser_pointer(flashlight_extension, dt, t)
        end,
        on_update_item_visibility = function(flashlight_extension, wielded_slot)
            laser_pointer_functions.update_laser_pointer_visibility(flashlight_extension, wielded_slot)
        end,
        on_flashlight_off = function(flashlight_extension)
            laser_pointer_functions.despawn_laser_pointer(flashlight_extension)
        end,
    },
    laser_pointer_02 = {
        replacement_path = _item_ranged.."/laser_pointers/laser_pointer_02",
        icon_render_unit_rotation_offset = {90, 0, 90 + 30},
        icon_render_camera_position_offset = {-.075, -.75, .15},
        flashlight_template = "laser_pointer_02",
        laser_particle_effect = "content/fx/particles/enemies/sniper_laser_sight",
        dot_particle_effect = "content/fx/particles/enemies/red_glowing_eyes",
        laser_color = vector3_box(1, 0, 0),
        laser_node = 2,
        laser_offset = vector3_box(0, .02, 0),
        crosshair_type = "ironsight",
        custom_selection_group = "laser_pointers",
        ui_item_init = function(world, attachment_unit, attachment_data)
            laser_pointer_functions.spawn_preview_laser(world, attachment_unit, attachment_data)
        end,
        ui_item_deinit = function(world, attachment_unit, attachment_data)
            laser_pointer_functions.despwan_preview_lasers(world, attachment_unit, attachment_data)
        end,
        on_flashlight_on = function(flashlight_extension)
            laser_pointer_functions.spawn_laser_pointer(flashlight_extension)
        end,
        on_perspective_change = function(flashlight_extension)
            laser_pointer_functions.respawn_laser_pointer(flashlight_extension)
        end,
        on_flashlight_update = function(flashlight_extension, dt, t)
            laser_pointer_functions.update_laser_pointer(flashlight_extension, dt, t)
        end,
        on_update_item_visibility = function(flashlight_extension, wielded_slot)
            laser_pointer_functions.update_laser_pointer_visibility(flashlight_extension, wielded_slot)
        end,
        on_flashlight_off = function(flashlight_extension)
            laser_pointer_functions.despawn_laser_pointer(flashlight_extension)
        end,
    },
    laser_pointer_03 = {
        replacement_path = _item_ranged.."/laser_pointers/laser_pointer_03",
        icon_render_unit_rotation_offset = {90, 0, 90 + 30},
        icon_render_camera_position_offset = {-.15, -.75, .15},
        flashlight_template = "laser_pointer_03",
        laser_particle_effect = "content/fx/particles/enemies/sniper_laser_sight",
        dot_particle_effect = "content/fx/particles/enemies/red_glowing_eyes",
        laser_color = vector3_box(1, 0, 0),
        laser_node = 2,
        laser_offset = vector3_box(0, .02, 0),
        crosshair_type = "ironsight",
        custom_selection_group = "laser_pointers",
        ui_item_init = function(world, attachment_unit, attachment_data)
            laser_pointer_functions.spawn_preview_laser(world, attachment_unit, attachment_data)
        end,
        ui_item_deinit = function(world, attachment_unit, attachment_data)
            laser_pointer_functions.despwan_preview_lasers(world, attachment_unit, attachment_data)
        end,
        on_flashlight_on = function(flashlight_extension)
            laser_pointer_functions.spawn_laser_pointer(flashlight_extension)
        end,
        on_perspective_change = function(flashlight_extension)
            laser_pointer_functions.respawn_laser_pointer(flashlight_extension)
        end,
        on_flashlight_update = function(flashlight_extension, dt, t)
            laser_pointer_functions.update_laser_pointer(flashlight_extension, dt, t)
        end,
        on_update_item_visibility = function(flashlight_extension, wielded_slot)
            laser_pointer_functions.update_laser_pointer_visibility(flashlight_extension, wielded_slot)
        end,
        on_flashlight_off = function(flashlight_extension)
            laser_pointer_functions.despawn_laser_pointer(flashlight_extension)
        end,
    },
    laser_pointer_05 = {
        replacement_path = _item_ranged.."/laser_pointers/laser_pointer_05",
        icon_render_unit_rotation_offset = {90, 0, 90 + 30},
        icon_render_camera_position_offset = {-.075, -.75, .15},
        flashlight_template = "laser_pointer_05",
        laser_particle_effect = "content/fx/particles/enemies/sniper_laser_sight",
        dot_particle_effect = "content/fx/particles/enemies/red_glowing_eyes",
        laser_color = vector3_box(1, 0, 0),
        laser_node = 2,
        laser_offset = vector3_box(0, .02, 0),
        crosshair_type = "ironsight",
        custom_selection_group = "laser_pointers",
        ui_item_init = function(world, attachment_unit, attachment_data)
            laser_pointer_functions.spawn_preview_laser(world, attachment_unit, attachment_data)
        end,
        ui_item_deinit = function(world, attachment_unit, attachment_data)
            laser_pointer_functions.despwan_preview_lasers(world, attachment_unit, attachment_data)
        end,
        on_flashlight_on = function(flashlight_extension)
            laser_pointer_functions.spawn_laser_pointer(flashlight_extension)
        end,
        on_perspective_change = function(flashlight_extension)
            laser_pointer_functions.respawn_laser_pointer(flashlight_extension)
        end,
        on_flashlight_update = function(flashlight_extension, dt, t)
            laser_pointer_functions.update_laser_pointer(flashlight_extension, dt, t)
        end,
        on_update_item_visibility = function(flashlight_extension, wielded_slot)
            laser_pointer_functions.update_laser_pointer_visibility(flashlight_extension, wielded_slot)
        end,
        on_flashlight_off = function(flashlight_extension)
            laser_pointer_functions.despawn_laser_pointer(flashlight_extension)
        end,
    },
    laser_pointer_green_01 = {
        replacement_path = _item_ranged.."/laser_pointers/laser_pointer_green_01",
        icon_render_unit_rotation_offset = {90, 0, 90 + 30},
        icon_render_camera_position_offset = {-.125, -.75, .15},
        flashlight_template = "laser_pointer_green_01",
        laser_particle_effect = "content/fx/particles/enemies/plasma_gun_laser_sight",
        dot_particle_effect = "content/fx/particles/enemies/red_glowing_eyes",
        laser_color = vector3_box(0, 1, 0),
        laser_node = 2,
        laser_offset = vector3_box(0, .02, 0),
        crosshair_type = "ironsight",
        custom_selection_group = "laser_pointers_green",
        ui_item_init = function(world, attachment_unit, attachment_data)
            laser_pointer_functions.spawn_preview_laser(world, attachment_unit, attachment_data)
        end,
        ui_item_deinit = function(world, attachment_unit, attachment_data)
            laser_pointer_functions.despwan_preview_lasers(world, attachment_unit, attachment_data)
        end,
        on_flashlight_on = function(flashlight_extension)
            laser_pointer_functions.spawn_laser_pointer(flashlight_extension)
        end,
        on_perspective_change = function(flashlight_extension)
            laser_pointer_functions.respawn_laser_pointer(flashlight_extension)
        end,
        on_flashlight_update = function(flashlight_extension, dt, t)
            laser_pointer_functions.update_laser_pointer(flashlight_extension, dt, t)
        end,
        on_update_item_visibility = function(flashlight_extension, wielded_slot)
            laser_pointer_functions.update_laser_pointer_visibility(flashlight_extension, wielded_slot)
        end,
        on_flashlight_off = function(flashlight_extension)
            laser_pointer_functions.despawn_laser_pointer(flashlight_extension)
        end,
    },
    laser_pointer_green_02 = {
        replacement_path = _item_ranged.."/laser_pointers/laser_pointer_green_02",
        icon_render_unit_rotation_offset = {90, 0, 90 + 30},
        icon_render_camera_position_offset = {-.075, -.75, .15},
        flashlight_template = "laser_pointer_green_02",
        laser_particle_effect = "content/fx/particles/enemies/plasma_gun_laser_sight",
        dot_particle_effect = "content/fx/particles/enemies/red_glowing_eyes",
        laser_color = vector3_box(0, 1, 0),
        laser_node = 2,
        laser_offset = vector3_box(0, .02, 0),
        crosshair_type = "ironsight",
        custom_selection_group = "laser_pointers_green",
        ui_item_init = function(world, attachment_unit, attachment_data)
            laser_pointer_functions.spawn_preview_laser(world, attachment_unit, attachment_data)
        end,
        ui_item_deinit = function(world, attachment_unit, attachment_data)
            laser_pointer_functions.despwan_preview_lasers(world, attachment_unit, attachment_data)
        end,
        on_flashlight_on = function(flashlight_extension)
            laser_pointer_functions.spawn_laser_pointer(flashlight_extension)
        end,
        on_perspective_change = function(flashlight_extension)
            laser_pointer_functions.respawn_laser_pointer(flashlight_extension)
        end,
        on_flashlight_update = function(flashlight_extension, dt, t)
            laser_pointer_functions.update_laser_pointer(flashlight_extension, dt, t)
        end,
        on_update_item_visibility = function(flashlight_extension, wielded_slot)
            laser_pointer_functions.update_laser_pointer_visibility(flashlight_extension, wielded_slot)
        end,
        on_flashlight_off = function(flashlight_extension)
            laser_pointer_functions.despawn_laser_pointer(flashlight_extension)
        end,
    },
    laser_pointer_green_03 = {
        replacement_path = _item_ranged.."/laser_pointers/laser_pointer_green_03",
        icon_render_unit_rotation_offset = {90, 0, 90 + 30},
        icon_render_camera_position_offset = {-.15, -.75, .15},
        flashlight_template = "laser_pointer_green_03",
        laser_particle_effect = "content/fx/particles/enemies/plasma_gun_laser_sight",
        dot_particle_effect = "content/fx/particles/enemies/red_glowing_eyes",
        laser_color = vector3_box(0, 1, 0),
        laser_node = 2,
        laser_offset = vector3_box(0, .02, 0),
        crosshair_type = "ironsight",
        custom_selection_group = "laser_pointers_green",
        ui_item_init = function(world, attachment_unit, attachment_data)
            laser_pointer_functions.spawn_preview_laser(world, attachment_unit, attachment_data)
        end,
        ui_item_deinit = function(world, attachment_unit, attachment_data)
            laser_pointer_functions.despwan_preview_lasers(world, attachment_unit, attachment_data)
        end,
        on_flashlight_on = function(flashlight_extension)
            laser_pointer_functions.spawn_laser_pointer(flashlight_extension)
        end,
        on_perspective_change = function(flashlight_extension)
            laser_pointer_functions.respawn_laser_pointer(flashlight_extension)
        end,
        on_flashlight_update = function(flashlight_extension, dt, t)
            laser_pointer_functions.update_laser_pointer(flashlight_extension, dt, t)
        end,
        on_update_item_visibility = function(flashlight_extension, wielded_slot)
            laser_pointer_functions.update_laser_pointer_visibility(flashlight_extension, wielded_slot)
        end,
        on_flashlight_off = function(flashlight_extension)
            laser_pointer_functions.despawn_laser_pointer(flashlight_extension)
        end,
    },
    laser_pointer_green_05 = {
        replacement_path = _item_ranged.."/laser_pointers/laser_pointer_green_05",
        icon_render_unit_rotation_offset = {90, 0, 90 + 30},
        icon_render_camera_position_offset = {-.075, -.75, .15},
        flashlight_template = "laser_pointer_green_05",
        laser_particle_effect = "content/fx/particles/enemies/plasma_gun_laser_sight",
        dot_particle_effect = "content/fx/particles/enemies/red_glowing_eyes",
        laser_color = vector3_box(0, 1, 0),
        laser_node = 2,
        laser_offset = vector3_box(0, .02, 0),
        crosshair_type = "ironsight",
        custom_selection_group = "laser_pointers_green",
        ui_item_init = function(world, attachment_unit, attachment_data)
            laser_pointer_functions.spawn_preview_laser(world, attachment_unit, attachment_data)
        end,
        ui_item_deinit = function(world, attachment_unit, attachment_data)
            laser_pointer_functions.despwan_preview_lasers(world, attachment_unit, attachment_data)
        end,
        on_flashlight_on = function(flashlight_extension)
            laser_pointer_functions.spawn_laser_pointer(flashlight_extension)
        end,
        on_perspective_change = function(flashlight_extension)
            laser_pointer_functions.respawn_laser_pointer(flashlight_extension)
        end,
        on_flashlight_update = function(flashlight_extension, dt, t)
            laser_pointer_functions.update_laser_pointer(flashlight_extension, dt, t)
        end,
        on_update_item_visibility = function(flashlight_extension, wielded_slot)
            laser_pointer_functions.update_laser_pointer_visibility(flashlight_extension, wielded_slot)
        end,
        on_flashlight_off = function(flashlight_extension)
            laser_pointer_functions.despawn_laser_pointer(flashlight_extension)
        end,
    },
}
