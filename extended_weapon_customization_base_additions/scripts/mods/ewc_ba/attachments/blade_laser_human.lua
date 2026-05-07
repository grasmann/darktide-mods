local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local laser_blade_functions = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_laser")

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
    laser_blade_01 = {
        replacement_path = _item_melee.."/blades/laser_blade_01",
        icon_render_unit_rotation_offset = {90, 30, 0},
        icon_render_camera_position_offset = {-.025, -2.5, .7},
        particle_effect_name = "content/fx/particles/enemies/sniper_laser_sight",
        impact_particle_effect_name = "content/fx/particles/weapons/grenades/flame_grenade_hostile_fire_lingering",
        custom_selection_group = "laser_blades_red",
        ui_item_init = function(world, attachment_unit, attachment_data)
            laser_blade_functions.spawn_preview_blade(world, attachment_unit, attachment_data)
        end,
        ui_item_deinit = function(world, attachment_unit, attachment_data)
            laser_blade_functions.despwan_preview_blade(world, attachment_unit, attachment_data)
        end,

        on_impact = function(attachment_callback_extension, attachment_slot_data, hit_position, hit_unit, attack_type, damage_profile)
            laser_blade_functions.impact_blade(attachment_callback_extension, attachment_slot_data, hit_position, hit_unit, attack_type, damage_profile)
        end,
        on_attack = function(attachment_callback_extension, attachment_slot_data, hit_units)
            laser_blade_functions.attack_blade(attachment_callback_extension, attachment_slot_data, hit_units)
        end,

        on_wield = function(attachment_callback_extension, attachment_slot_data)
            laser_blade_functions.spawn_blade(attachment_callback_extension, attachment_slot_data)
        end,
        on_unwield = function(attachment_callback_extension, attachment_slot_data)
        end,
        on_perspective_change = function(attachment_callback_extension, attachment_slot_data)
            laser_blade_functions.respawn_blade(attachment_callback_extension, attachment_slot_data)
        end,
        on_update = function(attachment_callback_extension, attachment_slot_data, dt, t)
            laser_blade_functions.update_blade(attachment_callback_extension, attachment_slot_data, dt, t)
        end,
        on_update_item_visibility = function(attachment_callback_extension, attachment_slot_data, wielded_slot)
            laser_blade_functions.update_blade_visibility(attachment_callback_extension, attachment_slot_data, wielded_slot)
        end,
    },
    laser_blade_green_01 = {
        replacement_path = _item_melee.."/blades/laser_blade_green_01",
        icon_render_unit_rotation_offset = {90, 30, 0},
        icon_render_camera_position_offset = {-.025, -2.5, .7},
        particle_effect_name = "content/fx/particles/enemies/plasma_gun_laser_sight",
        impact_particle_effect_name = "content/fx/particles/weapons/grenades/flame_grenade_hostile_fire_lingering_green",
        custom_selection_group = "laser_blades_green",
        ui_item_init = function(world, attachment_unit, attachment_data)
            laser_blade_functions.spawn_preview_blade(world, attachment_unit, attachment_data)
        end,
        ui_item_deinit = function(world, attachment_unit, attachment_data)
            laser_blade_functions.despwan_preview_blade(world, attachment_unit, attachment_data)
        end,

        on_impact = function(attachment_callback_extension, attachment_slot_data, hit_position, hit_unit, attack_type, damage_profile)
            laser_blade_functions.impact_blade(attachment_callback_extension, attachment_slot_data, hit_position, hit_unit, attack_type, damage_profile)
        end,
        on_attack = function(attachment_callback_extension, attachment_slot_data, hit_units)
            laser_blade_functions.attack_blade(attachment_callback_extension, attachment_slot_data, hit_units)
        end,

        on_wield = function(attachment_callback_extension, attachment_slot_data)
            laser_blade_functions.spawn_blade(attachment_callback_extension, attachment_slot_data)
            -- laser_blade_functions.update_blade_visibility(attachment_callback_extension, attachment_slot_data, attachment_callback_extension.wielded_slot)
        end,
        on_unwield = function(attachment_callback_extension, attachment_slot_data)
            -- laser_blade_functions.despawn_blade(attachment_callback_extension, attachment_slot_data)
        end,
        on_perspective_change = function(attachment_callback_extension, attachment_slot_data)
            laser_blade_functions.respawn_blade(attachment_callback_extension, attachment_slot_data)
        end,
        on_update = function(attachment_callback_extension, attachment_slot_data, dt, t)
            laser_blade_functions.update_blade(attachment_callback_extension, attachment_slot_data, dt, t)
        end,
        on_update_item_visibility = function(attachment_callback_extension, attachment_slot_data, wielded_slot)
            laser_blade_functions.update_blade_visibility(attachment_callback_extension, attachment_slot_data, wielded_slot)
        end,
    },
}
