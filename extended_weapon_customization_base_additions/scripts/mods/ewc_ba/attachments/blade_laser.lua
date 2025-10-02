local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local attack_settings = mod:original_require("scripts/settings/damage/attack_settings")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local pairs = pairs
    local table = table
    local world = World
    local get_mod = get_mod
    local vector3 = Vector3
    local managers = Managers
    local tostring = tostring
    local unit_node = unit.node
    local matrix4x4 = Matrix4x4
    local quaternion = Quaternion
    local unit_alive = unit.alive
    local vector3_box = Vector3Box
    local script_unit = ScriptUnit
    local unit_light = unit.light
    local table_clear = table.clear
    local vector3_zero = vector3.zero
    local physics_world = PhysicsWorld
    local unit_has_node = unit.has_node
    local table_contains = table.contains
    local quaternion_look = quaternion.look
    local vector3_unbox = vector3_box.unbox
    local unit_local_pose = unit.local_pose
    local unit_world_pose = unit.world_pose
    local vector3_distance = vector3.distance
    local vector3_normalize = vector3.normalize
    local matrix4x4_identity = matrix4x4.identity
    local matrix4x4_multiply = matrix4x4.multiply
    local quaternion_forward = quaternion.forward
    local matrix4x4_rotation = matrix4x4.rotation
    local quaternion_multiply = quaternion.multiply
    local matrix4x4_set_scale = matrix4x4.set_scale
    local matrix4x4_transform = matrix4x4.transform
    local unit_local_position = unit.local_position
    local unit_local_rotation = unit.local_rotation
    local quaternion_identity = quaternion.identity
    local unit_world_rotation = unit.world_rotation
    local unit_world_position = unit.world_position
    local quaternion_matrix4x4 = quaternion.matrix4x4
    local world_move_particles = world.move_particles
    local world_link_particles = world.link_particles
    local physics_world_raycast = physics_world.raycast
    local script_unit_extension = script_unit.extension
    local quaternion_from_vector = quaternion.from_vector
    local world_create_particles = world.create_particles
    local world_destroy_particles = world.destroy_particles
    local matrix4x4_set_translation = matrix4x4.set_translation
    local script_unit_has_extension = script_unit.has_extension
    local world_are_particles_playing = world.are_particles_playing
    local world_set_particles_variable = world.set_particles_variable
    local world_find_particles_variable = world.find_particles_variable
    local world_set_particles_life_time = world.set_particles_life_time
    local world_stop_spawning_particles = world.stop_spawning_particles
    local world_set_particles_use_custom_fov = world.set_particles_use_custom_fov
    local matrix4x4_from_quaternion_position = matrix4x4.from_quaternion_position
    local world_set_particles_material_vector3 = world.set_particles_material_vector3
    local world_set_particles_light_intensity_exponent = world.set_particles_light_intensity_exponent
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"

local attack_types = attack_settings.attack_types
local IMPACT_SOUND = "wwise/events/minions/play_traitor_captain_shield_bullet_hits"
local IMPACT_EFFECT = "content/fx/particles/weapons/grenades/flame_grenade_hostile_fire_lingering_green"
local FIRE_PARTICLE_NAME = "content/fx/particles/weapons/rifles/plasma_gun/plasma_gun_charge"
local LASER_PARTICLE = "content/fx/particles/enemies/sniper_laser_sight"
local LASER_LENGTH_VARIABLE_NAME = "hit_distance"
local FADE_IN_TIME = 1
local SLOT_PRIMARY = "slot_primary"
local FIRE_COLOR = vector3_box(1, 0, 0)
local LASER_X, LASER_Z = 0.05, 0.5
local _empty_offset = {
    position = vector3_box(0, 0, 0),
    rotation = vector3_box(0, 0, 0),
    scale = vector3_box(1, 1, 1),
    node = 1,
}
local context = {
    laser_blade_distortion_particles = {},
    laser_blade_laser_particles = {},
    laser_point_dot_particle = {},
}

local function spawn_distortion_particle_effect(world, attachment_unit, attachment_data, optional_custom_fov)
    local custom_fov = not not optional_custom_fov
    local offset = attachment_data.particle_offset or _empty_offset
    local fire_node = offset.node or 1

    local position_offset = vector3(0, 0, 0)
    local rotation_offset = quaternion_from_vector(vector3(-90, 0, 0))
    local pose = matrix4x4_from_quaternion_position(rotation_offset, position_offset)
    local scale_offset = vector3(1, 1, 1)

    local particle_id = world_create_particles(world, FIRE_PARTICLE_NAME, position_offset, rotation_offset, scale_offset)

    world_set_particles_use_custom_fov(world, particle_id, custom_fov)

    matrix4x4_set_scale(pose, scale_offset)
    world_link_particles(world, particle_id, attachment_unit, fire_node, pose, "destroy")

    return particle_id
end

local function spawn_laser_particle_effect(world, attachment_unit, attachment_data, optional_custom_fov)
    local particle_name = attachment_data.particle_effect_name or LASER_PARTICLE
    local custom_fov = not not optional_custom_fov
    local offset = attachment_data.particle_offset or _empty_offset
    local fire_node = offset.node or 1

    local position_offset = vector3(0, 0, .08)
    local rotation_offset = quaternion_from_vector(vector3(0, 90, 90))
    local pose = matrix4x4_from_quaternion_position(rotation_offset, position_offset)
    local scale_offset = vector3(1, 1, 1)
    matrix4x4_set_scale(pose, scale_offset)

    local laser_particle_effect = world_create_particles(world, particle_name, position_offset, rotation_offset, scale_offset)
    world_set_particles_use_custom_fov(world, laser_particle_effect, custom_fov)

    world_link_particles(world, laser_particle_effect, attachment_unit, fire_node, pose, "destroy")

    local laser_variable_index = world_find_particles_variable(world, particle_name, LASER_LENGTH_VARIABLE_NAME)
    world_set_particles_variable(world, laser_particle_effect, laser_variable_index, vector3(.3, .65, .3))

    return laser_particle_effect
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

local function despawn_preview_effect(world, particle_effect, attachment_unit)
    if context[particle_effect] and context[particle_effect][attachment_unit] then
        if world_are_particles_playing(world, context[particle_effect][attachment_unit]) then
            world_stop_spawning_particles(world, context[particle_effect][attachment_unit])
        end
        world_destroy_particles(world, context[particle_effect][attachment_unit])
        context[particle_effect][attachment_unit] = nil
    end
end

local function despwan_preview_blade(world, attachment_unit, attachment_data)
    
    despawn_preview_effect(world, "laser_blade_distortion_particles", attachment_unit)
    despawn_preview_effect(world, "laser_blade_laser_particles", attachment_unit)

end

local function spawn_preview_blade(world, attachment_unit, attachment_data)

    context.laser_blade_distortion_particles[attachment_unit] = spawn_distortion_particle_effect(world, attachment_unit, attachment_data, false)
    context.laser_blade_laser_particles[attachment_unit] = spawn_laser_particle_effect(world, attachment_unit, attachment_data, false)

    local custom_fov = false --not not optional_custom_fov
    local offset = attachment_data.particle_offset or _empty_offset
    local fire_node = offset.node or 1

    local position_offset = vector3(0, 0, .725)
    local rotation_offset = quaternion_from_vector(vector3(0, 0, 0))
    local pose = matrix4x4_from_quaternion_position(rotation_offset, position_offset)
    local scale_offset = vector3(1, 1, 1)
    matrix4x4_set_scale(pose, scale_offset)

    local laser_point_dot_particle = world_create_particles(world, "content/fx/particles/enemies/red_glowing_eyes", position_offset, rotation_offset, scale_offset)

    world_set_particles_use_custom_fov(world, laser_point_dot_particle, custom_fov)

    -- Set colors
    local fire_color = attachment_data.fire_color and vector3_unbox(attachment_data.fire_color) or vector3_unbox(FIRE_COLOR)
    world_set_particles_material_vector3(world, laser_point_dot_particle, "eye_socket", "material_variable_21872256", vector3(1 * fire_color[1], 1 * fire_color[2], 1 * fire_color[3]))
    world_set_particles_material_vector3(world, laser_point_dot_particle, "eye_glow", "trail_color", vector3(.1 * fire_color[1], .1 * fire_color[2], .1 * fire_color[3]))
    world_set_particles_material_vector3(world, laser_point_dot_particle, "eye_flash_init", "material_variable_21872256", vector3(.05 * fire_color[1], .05 * fire_color[2], .05 * fire_color[3]))

    world_link_particles(world, laser_point_dot_particle, attachment_unit, fire_node, pose, "destroy")

    context.laser_point_dot_particle[attachment_unit] = laser_point_dot_particle

end

local function despawn_blade_effect(attachment_callback_extension, particle_effect)
    if attachment_callback_extension[particle_effect] then
        local world = attachment_callback_extension.world
        -- for i = #context[particle_effect][attachment_unit], 1, -1 do
        if world_are_particles_playing(world, attachment_callback_extension[particle_effect]) then
            world_stop_spawning_particles(world, attachment_callback_extension[particle_effect])
        end
        world_destroy_particles(world, attachment_callback_extension[particle_effect])
        attachment_callback_extension[particle_effect] = nil
        -- end
    end
end

local function despawn_blade(attachment_callback_extension, attachment_slot_data, optional_no_sound)
    local no_sound = not not optional_no_sound
    if attachment_callback_extension.laser_blade_distortion_particle then

        despawn_blade_effect(attachment_callback_extension, "laser_blade_distortion_particle")
        despawn_blade_effect(attachment_callback_extension, "laser_blade_laser_particle")

        local fx_extension = script_unit_has_extension(attachment_callback_extension.unit, "fx_system")
        if not no_sound and fx_extension then
            fx_extension:trigger_wwise_event("wwise/events/weapon/play_flamethrower_interrupt", false, attachment_callback_extension.unit, 1)
            fx_extension:trigger_wwise_event("wwise/events/weapon/stop_aoe_liquid_fire_green_loop", false, attachment_callback_extension.unit, 1)
        end

    end

end

local function spawn_blade(attachment_callback_extension, attachment_slot_data, optional_no_sound, optional_no_animation)
    local no_sound = not not optional_no_sound
    local no_animation = not not optional_no_animation
    local player_visibility = script_unit_has_extension(attachment_callback_extension.unit, "player_visibility_system")
    local player_invisible = player_visibility and not player_visibility:visible()
    local inventory_view = mod:get_view("inventory_view")
    if not attachment_callback_extension.laser_blade_distortion_particle and attachment_callback_extension.wielded_slot == attachment_slot_data.slot_name and not player_invisible and not inventory_view then

        local attachment_unit = attachment_callback_extension:current_attachment_unit(attachment_slot_data.attachment_slot)
        if attachment_unit and unit_alive(attachment_unit) then

            local custom_fov = attachment_callback_extension.first_person_extension:is_in_first_person_mode()
            local attachment_data = attachment_slot_data.attachment_data
            local world = attachment_callback_extension.world
            local particle_name = attachment_data.particle_effect_name or LASER_PARTICLE

            attachment_callback_extension.laser_blade_distortion_particle = spawn_distortion_particle_effect(world, attachment_unit, attachment_data, custom_fov)

            attachment_callback_extension.laser_variable_index = world_find_particles_variable(world, particle_name, LASER_LENGTH_VARIABLE_NAME)

            attachment_callback_extension.laser_blade_laser_particle = spawn_laser_particle_effect(world, attachment_unit, attachment_data, custom_fov)

            local position_offset = vector3(0, 0, .08)
            local rotation_offset = quaternion_from_vector(vector3(0, 0, 0))
            local pose = matrix4x4_from_quaternion_position(rotation_offset, position_offset)
            local scale_offset = vector3(1, 1, 1)
            matrix4x4_set_scale(pose, scale_offset)

            local vent_particle = world_create_particles(world, "content/fx/particles/weapons/rifles/plasma_gun/plasma_vent_valve", position_offset, rotation_offset, scale_offset)
            local offset = attachment_data.particle_offset or _empty_offset
            local fire_node = offset.node or 1

            world_set_particles_use_custom_fov(world, vent_particle, custom_fov)
            world_set_particles_life_time(world, vent_particle, FADE_IN_TIME)

            world_link_particles(world, vent_particle, attachment_unit, fire_node, pose, "destroy")

            attachment_callback_extension.vent_particle = vent_particle

            local fx_extension = script_unit_has_extension(attachment_callback_extension.unit, "fx_system")
            if not no_sound and fx_extension then
                fx_extension:trigger_wwise_event("wwise/events/weapon/play_flametrower_alt_fire_on", false, attachment_callback_extension.unit, 1)
                fx_extension:trigger_wwise_event("wwise/events/weapon/play_aoe_liquid_fire_green_loop", false, attachment_callback_extension.unit, 1)
            end

            if not no_animation then
                attachment_callback_extension.laser_start_fade_in = true
            end

        end

    end

end

local function update_blade(attachment_callback_extension, attachment_slot_data, dt, t)

    if attachment_callback_extension.laser_start_fade_t then

        if t > attachment_callback_extension.laser_start_fade_t then

            attachment_callback_extension.laser_start_fade_t = nil

            if attachment_callback_extension.laser_blade_laser_particle and attachment_callback_extension.laser_variable_index then
                local attachment_data = attachment_slot_data.attachment_data
                local particle_name = attachment_data.particle_effect_name or LASER_PARTICLE
                local world = attachment_callback_extension.world
                world_set_particles_variable(world, attachment_callback_extension.laser_blade_laser_particle, attachment_callback_extension.laser_variable_index, vector3(.3, .65, .3))
            end

        else

            if attachment_callback_extension.laser_blade_laser_particle and attachment_callback_extension.laser_variable_index then
                local attachment_data = attachment_slot_data.attachment_data
                local particle_name = attachment_data.particle_effect_name or LASER_PARTICLE
                local world = attachment_callback_extension.world
                local progress = 1 - (attachment_callback_extension.laser_start_fade_t - t) / FADE_IN_TIME
                local current_value = vector3(.3, .65, .3) * progress
                world_set_particles_variable(world, attachment_callback_extension.laser_blade_laser_particle, attachment_callback_extension.laser_variable_index, current_value)
            end

        end

    elseif attachment_callback_extension.laser_start_fade_in then

        attachment_callback_extension.laser_start_fade_t = t + FADE_IN_TIME
        attachment_callback_extension.laser_start_fade_in = nil

    end

end

local function update_blade_visibility(attachment_callback_extension, attachment_slot_data, wielded_slot)
    local player_visibility = script_unit_has_extension(attachment_callback_extension.unit, "player_visibility_system")
    local player_invisible = player_visibility and not player_visibility:visible()
    local inventory_view = mod:get_view("inventory_view")
    if wielded_slot ~= attachment_slot_data.slot_name or player_invisible or inventory_view then
        despawn_blade(attachment_callback_extension, attachment_slot_data)
    else
        spawn_blade(attachment_callback_extension, attachment_slot_data)
    end
end

local function respawn_blade(attachment_callback_extension, attachment_slot_data)
    despawn_blade(attachment_callback_extension, attachment_slot_data, true, true)
    spawn_blade(attachment_callback_extension, attachment_slot_data, true, true)
end

local function impact_blade(attachment_callback_extension, attachment_slot_data, hit_position, hit_unit, attack_type, damage_profile, optional_no_sound)
    
    local attachment_unit = attachment_callback_extension:current_attachment_unit(attachment_slot_data.attachment_slot)
    if attack_type == attack_types.melee and damage_profile.melee_attack_strength and attachment_unit and unit_alive(attachment_unit) then

        local no_sound = not not optional_no_sound
        local custom_fov = attachment_callback_extension.first_person_extension:is_in_first_person_mode()
        local attacker_position = unit_world_position(attachment_callback_extension.unit, 1)
        -- local hit_rotation = quaternion_look(attacker_position - hit_position)
        local hit_rotation = quaternion_identity()
        local world = attachment_callback_extension.world

        local scale_offset = vector3(.1, .1, .1)
        local has_hip = unit_has_node(hit_unit, "j_hips")
        local attach_node = has_hip and unit_node(hit_unit, "j_hips") or 1
        local attachment_data = attachment_slot_data.attachment_data
        local particle_name = attachment_data.impact_particle_effect_name or IMPACT_EFFECT

        hit_position = hit_position or unit_world_position(hit_unit, attach_node)

        local particle_id = world_create_particles(world, particle_name, hit_position, hit_rotation, scale_offset)

        world_set_particles_use_custom_fov(world, particle_id, false)
        world_set_particles_life_time(world, particle_id, 1)

        local position_offset = unit_local_position(hit_unit, attach_node) - vector3(0, 0, 1)
        local rotation_offset = unit_local_rotation(hit_unit, attach_node)
        local pose = matrix4x4_from_quaternion_position(rotation_offset, position_offset)
        matrix4x4_set_scale(pose, scale_offset)
        world_link_particles(world, particle_id, hit_unit, attach_node, pose, "destroy")

        local fx_extension = script_unit_has_extension(attachment_callback_extension.unit, "fx_system")
        if not no_sound and fx_extension then
            fx_extension:trigger_wwise_event("wwise/events/minions/play_traitor_captain_shield_bullet_hits", false, hit_unit, 1)
        end

        -- local pose = matrix4x4_from_quaternion_position(hit_position, hit_rotation)
        -- local scale_offset = vector3(1, 1, 1)
        -- matrix4x4_set_scale(pose, scale_offset)
        -- world_link_particles(world, particle_id, hit_unit, fire_node, pose, "destroy")

    end

end

local function attack_blade(attachment_callback_extension, attachment_slot_data, hit_units, optional_no_sound)

    local no_sound = not not optional_no_sound
    local attachment_unit = attachment_callback_extension:current_attachment_unit(attachment_slot_data.attachment_slot)
    if attachment_callback_extension.wielded_slot == attachment_slot_data.slot_name and attachment_unit and unit_alive(attachment_unit) then

        local fx_extension = script_unit_has_extension(attachment_callback_extension.unit, "fx_system")
        if not no_sound and fx_extension then
            fx_extension:trigger_wwise_event("wwise/events/weapon/play_shockmaul_1h_p2_swing", false, attachment_unit, 1)
        end

    end
end

return {
    update_blade_visibility = update_blade_visibility,
    despwan_preview_blade = despwan_preview_blade,
    spawn_preview_blade = spawn_preview_blade,
    despawn_blade = despawn_blade,
    respawn_blade = respawn_blade,
    update_blade = update_blade,
    impact_blade = impact_blade,
    attack_blade = attack_blade,
    spawn_blade = spawn_blade,
}