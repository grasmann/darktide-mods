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

local pt = mod:pt()
local attack_types = attack_settings.attack_types
local IMPACT_SOUND = "wwise/events/minions/play_traitor_captain_shield_bullet_hits"
local IMPACT_EFFECT = "content/fx/particles/weapons/grenades/flame_grenade_hostile_fire_lingering_green"
local DISTORTION_EFFECT = "content/fx/particles/weapons/rifles/plasma_gun/plasma_gun_charge"
local SWING_SOUND = "wwise/events/weapon/play_shockmaul_1h_p2_swing"
local LASER_PARTICLE = "content/fx/particles/enemies/sniper_laser_sight"
local UNWIELD_SOUND = "wwise/events/weapon/play_flamethrower_interrupt"
local LASER_ON = "wwise/events/weapon/play_flametrower_alt_fire_on"
local PLAY_LASER_LOOP = "wwise/events/weapon/play_aoe_liquid_fire_green_loop"
local STOP_LASER_LOOP = "wwise/events/weapon/stop_aoe_liquid_fire_green_loop"
local LASER_LENGTH_VARIABLE_NAME = "hit_distance"
local FADE_IN_TIME = 1
local SLOT_PRIMARY = "slot_primary"
local FIRE_COLOR = vector3_box(1, 0, 0)
local FIRE_SIZE = vector3_box(.3, .65, .3)
local LASER_X, LASER_Z = 0.05, 0.5
local CUSTOMIZATION_MENU_OFFSET = vector3_box(-.12, .02, -.04)
local _empty_offset = {
    position = vector3_box(0, 0, 0),
    rotation = vector3_box(0, 0, 0),
    scale = vector3_box(1, 1, 1),
    node = 1,
}
local context = {
    laser_blade_distortion_particles = {},
    laser_blade_laser_particles = {},
    laser_point_dot_particle2 = {},
    laser_point_dot_particle = {},
    vent_particle = {},
}

-- ##### ┌─┐┌─┐┬ ┬┌┐┌┌┬┐┌─┐ ###########################################################################################
-- ##### └─┐│ ││ ││││ ││└─┐ ###########################################################################################
-- ##### └─┘└─┘└─┘┘└┘─┴┘└─┘ ###########################################################################################

local function play_sound_effect(sound_effect, player_unit, unit, node, optional_no_sound)
    local no_sound = not not optional_no_sound
    local node = node or 1
    local fx_extension = script_unit_has_extension(player_unit, "fx_system")
    if not no_sound and fx_extension then
        fx_extension:trigger_wwise_event(sound_effect, false, unit, node)
    end
end

-- ##### ┌─┐┌─┐┌─┐┬ ┬┌┐┌  ┌─┐┌─┐┬─┐┌┬┐┬┌─┐┬  ┌─┐┌─┐ ###################################################################
-- ##### └─┐├─┘├─┤││││││  ├─┘├─┤├┬┘ │ ││  │  ├┤ └─┐ ###################################################################
-- ##### └─┘┴  ┴ ┴└┴┘┘└┘  ┴  ┴ ┴┴└─ ┴ ┴└─┘┴─┘└─┘└─┘ ###################################################################

local function laser_node(attachment_data)          return attachment_data.laser_node           or attachment_data.fire_node        or 1 end
local function vent_offset(attachment_data)         return attachment_data.vent_offset          or attachment_data.laser_1_offset   or attachment_data.laser_offset     or vector3_box(vector3_zero()) end
local function distortion_offset(attachment_data)   return attachment_data.distortion_offset                                                                            or vector3_box(vector3_zero()) end
local function laser_1_offset(attachment_data)      return attachment_data.laser_1_offset       or attachment_data.laser_offset                                         or vector3_box(vector3_zero()) end
local function laser_2_offset(attachment_data)      return attachment_data.laser_2_offset       or attachment_data.laser_offset                                         or vector3_box(vector3_zero()) end
local function laser_3_offset(attachment_data)      return attachment_data.laser_3_offset       or attachment_data.laser_offset                                         or vector3_box(vector3_zero()) end
local function distortion_size(attachment_data)     return attachment_data.distortion_size                                                                              or vector3_box(vector3_zero()) end
local function laser_1_size(attachment_data)        return attachment_data.laser_1_size         or attachment_data.fire_size                                            or vector3_box(vector3_zero()) end
local function laser_2_size(attachment_data)        return attachment_data.laser_2_size         or attachment_data.tip_size_1                                           or vector3_box(vector3_zero()) end
local function laser_3_size(attachment_data)        return attachment_data.laser_3_size         or attachment_data.tip_size_2                                           or vector3_box(vector3_zero()) end

local function spawn_lingering_flame(world, attachment_unit, attachment_data, hit_unit, hit_position)
    if hit_unit and unit_alive(hit_unit) then
        local scale_offset = vector3(.1, .1, .1)
        local has_hip = unit_has_node(hit_unit, "j_hips")
        local attach_node = has_hip and unit_node(hit_unit, "j_hips") or 1
        local particle_name = attachment_data.impact_particle_effect_name or IMPACT_EFFECT

        local particle_id = world_create_particles(world, particle_name, hit_position, quaternion_identity(), scale_offset)

        world_set_particles_use_custom_fov(world, particle_id, false)
        world_set_particles_life_time(world, particle_id, 1)

        local position_offset = unit_local_position(hit_unit, attach_node) - vector3(0, 0, 1)
        local rotation_offset = unit_local_rotation(hit_unit, attach_node)
        local pose = matrix4x4_from_quaternion_position(rotation_offset, position_offset)
        matrix4x4_set_scale(pose, scale_offset)

        world_link_particles(world, particle_id, hit_unit, attach_node, pose, "destroy")
    end
end

local function spawn_distortion_particle_effect(world, attachment_unit, attachment_data, optional_custom_fov, customization_item)
    local custom_fov = not not optional_custom_fov
    -- local fire_node = attachment_data._fire_node or 1
    local laser_node = laser_node(attachment_data)

    local attachment_position = unit_local_position(attachment_unit, laser_node)
    local attachment_rotation = unit_local_rotation(attachment_unit, laser_node)

    local mat = quaternion_matrix4x4(attachment_rotation)

    -- local distortion_offset = attachment_data._distortion_offset and vector3_unbox(attachment_data._distortion_offset) or vector3(0, 0, -.8)
    local distortion_offset = vector3_unbox(distortion_offset(attachment_data))
    local position_offset = attachment_position + matrix4x4_transform(mat, distortion_offset)

    if customization_item then
        local offset = vector3_unbox(CUSTOMIZATION_MENU_OFFSET)
        position_offset = position_offset + matrix4x4_transform(mat, offset)
    end

    local rotation_offset = quaternion_multiply(attachment_rotation, quaternion_from_vector(vector3(-90, 0, 0)))

    local pose = matrix4x4_from_quaternion_position(rotation_offset, position_offset)
    local distortion_size = attachment_data.distortion_size and vector3_unbox(attachment_data.distortion_size) or vector3(1, 1, 1)

    local particle_id = world_create_particles(world, DISTORTION_EFFECT, position_offset, rotation_offset, distortion_size)

    world_set_particles_use_custom_fov(world, particle_id, custom_fov)

    matrix4x4_set_scale(pose, distortion_size)
    world_link_particles(world, particle_id, attachment_unit, laser_node, pose, "destroy")

    return particle_id
end

local function spawn_laser_particle_effect(world, attachment_unit, attachment_data, optional_custom_fov, customization_item)
    local particle_name = attachment_data.particle_effect_name or LASER_PARTICLE
    local custom_fov = not not optional_custom_fov
    -- local fire_node = attachment_data._fire_node or 1
    local laser_node = laser_node(attachment_data)
    -- local fire_size = attachment_data._fire_size and vector3_unbox(attachment_data._fire_size) or FIRE_SIZE
    local fire_size = vector3_unbox(laser_1_size(attachment_data))

    local attachment_position = unit_local_position(attachment_unit, laser_node)
    local attachment_rotation = unit_local_rotation(attachment_unit, laser_node)

    local mat = quaternion_matrix4x4(attachment_rotation)

    -- local laser_offset = attachment_data._laser_offset and vector3_unbox(attachment_data._laser_offset) or vector3(0, 0, -.625)
    local laser_offset = vector3_unbox(laser_1_offset(attachment_data))
    local position_offset = attachment_position + matrix4x4_transform(mat, laser_offset)

    if customization_item then
        local offset = vector3_unbox(CUSTOMIZATION_MENU_OFFSET)
        position_offset = position_offset + matrix4x4_transform(mat, offset)
    end

    local rotation_offset = quaternion_multiply(attachment_rotation, quaternion_from_vector(vector3(0, 90, 90)))

    local pose = matrix4x4_from_quaternion_position(rotation_offset, position_offset)
    local scale_offset = vector3(1, 1, 1)
    matrix4x4_set_scale(pose, scale_offset)

    local laser_particle_effect = world_create_particles(world, particle_name, position_offset, rotation_offset, scale_offset)
    world_set_particles_use_custom_fov(world, laser_particle_effect, custom_fov)

    world_link_particles(world, laser_particle_effect, attachment_unit, laser_node, pose, "destroy")

    local laser_variable_index = world_find_particles_variable(world, particle_name, LASER_LENGTH_VARIABLE_NAME)
    world_set_particles_variable(world, laser_particle_effect, laser_variable_index, fire_size)

    return laser_particle_effect
end

local function spawn_laser_tip_particle_effects(world, attachment_unit, attachment_data, optional_custom_fov, customization_item, optional_no_animation)
    local no_animation = not not optional_no_animation
    local particle_name = attachment_data.particle_effect_name or LASER_PARTICLE
    local custom_fov = not not optional_custom_fov
    -- local fire_node = attachment_data._fire_node or 1
    local laser_node = laser_node(attachment_data)

    local attachment_position = unit_local_position(attachment_unit, laser_node)
    local attachment_rotation = unit_local_rotation(attachment_unit, laser_node)

    local mat = quaternion_matrix4x4(attachment_rotation)

    -- local position_offset = attachment_position + matrix4x4_transform(mat, vector3(0, 0, .025))
    -- local laser_offset = attachment_data._laser_offset and vector3_unbox(attachment_data._laser_offset) or vector3(0, 0, -.625)
    local laser_offset = vector3_unbox(laser_2_offset(attachment_data))
    local position_offset = attachment_position + matrix4x4_transform(mat, laser_offset)

    if customization_item then
        local offset = vector3_unbox(CUSTOMIZATION_MENU_OFFSET)
        position_offset = position_offset + matrix4x4_transform(mat, offset)
    end

    local rotation_offset = quaternion_multiply(attachment_rotation, quaternion_from_vector(vector3(0, 90, 90)))

    local pose = matrix4x4_from_quaternion_position(rotation_offset, position_offset)
    local scale_offset = vector3(1, 1, 1)
    matrix4x4_set_scale(pose, scale_offset)

    local laser_point_dot_particle = world_create_particles(world, particle_name, position_offset, rotation_offset, scale_offset)

    world_set_particles_use_custom_fov(world, laser_point_dot_particle, custom_fov)

    world_link_particles(world, laser_point_dot_particle, attachment_unit, laser_node, pose, "destroy")

    local laser_variable_index = world_find_particles_variable(world, particle_name, LASER_LENGTH_VARIABLE_NAME)
    -- local tip_size_1 = attachment_data._tip_size_1 and vector3_unbox(attachment_data._tip_size_1) or vector3(.25, .02, .25)
    local tip_size_1 = vector3_unbox(laser_2_size(attachment_data))
    local offset = no_animation and tip_size_1 or vector3(0, 0, 0)
    world_set_particles_variable(world, laser_point_dot_particle, laser_variable_index, offset)
    

    -- local laser_offset = attachment_data._laser_offset and vector3_unbox(attachment_data._laser_offset) or vector3(0, 0, -.625)
    local laser_offset = vector3_unbox(laser_3_offset(attachment_data))
    local position_offset = attachment_position + matrix4x4_transform(mat, laser_offset)

    local pose = matrix4x4_from_quaternion_position(rotation_offset, position_offset)
    local scale_offset = vector3(1, 1, 1)
    matrix4x4_set_scale(pose, scale_offset)

    local laser_point_dot_particle2 = world_create_particles(world, particle_name, position_offset, rotation_offset, scale_offset)

    world_set_particles_use_custom_fov(world, laser_point_dot_particle2, custom_fov)

    world_link_particles(world, laser_point_dot_particle2, attachment_unit, laser_node, pose, "destroy")

    local laser_variable_index = world_find_particles_variable(world, particle_name, LASER_LENGTH_VARIABLE_NAME)
    -- local tip_size_2 = attachment_data._tip_size_2 and vector3_unbox(attachment_data._tip_size_2) or vector3(.175, .03, .175)
    local tip_size_2 = vector3_unbox(laser_3_size(attachment_data))
    local offset = no_animation and tip_size_2 or vector3(0, 0, 0)
    world_set_particles_variable(world, laser_point_dot_particle2, laser_variable_index, offset)

    return laser_point_dot_particle, laser_point_dot_particle2

end

local function spawn_vent_particle_effect(world, attachment_unit, attachment_data, optional_custom_fov, customization_item)
    local custom_fov = not not optional_custom_fov
    -- local fire_node = attachment_data._fire_node or 1
    local laser_node = laser_node(attachment_data)

    local attachment_position = unit_local_position(attachment_unit, laser_node)
    local attachment_rotation = unit_local_rotation(attachment_unit, laser_node)

    local mat = quaternion_matrix4x4(attachment_rotation)

    -- local laser_offset = attachment_data.laser_offset and vector3_unbox(attachment_data.laser_offset) or vector3(0, 0, -.625)
    local laser_offset = vector3_unbox(vent_offset(attachment_data))
    local position_offset = attachment_position + matrix4x4_transform(mat, laser_offset)

    if customization_item then
        local offset = vector3_unbox(CUSTOMIZATION_MENU_OFFSET)
        position_offset = position_offset + matrix4x4_transform(mat, offset)
    end

    local rotation_offset = quaternion_multiply(attachment_rotation, quaternion_from_vector(vector3(0, 0, 0)))

    local pose = matrix4x4_from_quaternion_position(rotation_offset, position_offset)
    local scale_offset = vector3(1, 1, 1)
    matrix4x4_set_scale(pose, scale_offset)

    local vent_particle = world_create_particles(world, "content/fx/particles/weapons/rifles/plasma_gun/plasma_vent_valve", position_offset, rotation_offset, scale_offset)

    world_set_particles_use_custom_fov(world, vent_particle, custom_fov)
    world_set_particles_life_time(world, vent_particle, FADE_IN_TIME)

    world_link_particles(world, vent_particle, attachment_unit, laser_node, pose, "destroy")

    return vent_particle
end

-- ##### ┌─┐┬─┐┌─┐┬  ┬┬┌─┐┬ ┬       ┬ ┬┬  ┬┌┬┐┌─┐┌┬┐┌─┐   ┌─┐┬─┐┌─┐┌─┐┬┬  ┌─┐  ┌─┐┌─┐┌─┐┬ ┬┌┐┌┌─┐┬─┐ ##################
-- ##### ├─┘├┬┘├┤ └┐┌┘│├┤ │││  ───  │ ││  │ │ ├┤ │││└─┐   ├─┘├┬┘│ │├┤ ││  ├┤   └─┐├─┘├─┤││││││├┤ ├┬┘ ##################
-- ##### ┴  ┴└─└─┘ └┘ ┴└─┘└┴┘       └─┘┴  ┴ ┴ └─┘┴ ┴└─┘┘  ┴  ┴└─└─┘└  ┴┴─┘└─┘  └─┘┴  ┴ ┴└┴┘┘└┘└─┘┴└─ ##################

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
    despawn_preview_effect(world, "laser_point_dot_particle", attachment_unit)
    despawn_preview_effect(world, "laser_point_dot_particle2", attachment_unit)
    despawn_preview_effect(world, "vent_particle", attachment_unit)

end

-- ##### ┌─┐┌─┐ ┬ ┬┬┌─┐┌─┐┌─┐┌┬┐  ┌┐ ┬  ┌─┐┌┬┐┌─┐ #####################################################################
-- ##### ├┤ │─┼┐│ ││├─┘├─┘├┤  ││  ├┴┐│  ├─┤ ││├┤  #####################################################################
-- ##### └─┘└─┘└└─┘┴┴  ┴  └─┘─┴┘  └─┘┴─┘┴ ┴─┴┘└─┘ #####################################################################

local function spawn_preview_blade(world, attachment_unit, attachment_data, customization_item)

    context.laser_blade_distortion_particles[attachment_unit] = spawn_distortion_particle_effect(world, attachment_unit, attachment_data, false, customization_item)
    context.laser_blade_laser_particles[attachment_unit] = spawn_laser_particle_effect(world, attachment_unit, attachment_data, false, customization_item)
    context.laser_point_dot_particle[attachment_unit], context.laser_point_dot_particle2[attachment_unit] = spawn_laser_tip_particle_effects(world, attachment_unit, attachment_data, false, customization_item, true)
    context.vent_particle[attachment_unit] = spawn_vent_particle_effect(world, attachment_unit, attachment_data, false, customization_item)

end

local function despawn_blade_effect(attachment_callback_extension, particle_effect)
    if attachment_callback_extension[particle_effect] then
        local world = attachment_callback_extension.world
        if world_are_particles_playing(world, attachment_callback_extension[particle_effect]) then
            world_stop_spawning_particles(world, attachment_callback_extension[particle_effect])
        end
        world_destroy_particles(world, attachment_callback_extension[particle_effect])
        attachment_callback_extension[particle_effect] = nil
    end
end

local function despawn_blade(attachment_callback_extension, attachment_slot_data, optional_no_sound)
    local no_sound = not not optional_no_sound
    if attachment_callback_extension.laser_blade_distortion_particle then

        despawn_blade_effect(attachment_callback_extension, "laser_blade_distortion_particle")
        despawn_blade_effect(attachment_callback_extension, "laser_blade_laser_particle")
        despawn_blade_effect(attachment_callback_extension, "vent_particle")
        despawn_blade_effect(attachment_callback_extension, "laser_point_dot_particle")
        despawn_blade_effect(attachment_callback_extension, "laser_point_dot_particle2")

        play_sound_effect(UNWIELD_SOUND, attachment_callback_extension.unit, attachment_callback_extension.unit, 1, no_sound)
        play_sound_effect(STOP_LASER_LOOP, attachment_callback_extension.unit, attachment_callback_extension.unit, 1, no_sound)

    end

    attachment_callback_extension.laser_start_fade_in = nil
    attachment_callback_extension.laser_start_fade_t = nil

end

local function can_spawn_blade(attachment_callback_extension, attachment_slot_data, optional_wielded_slot)
    local player_visibility = script_unit_has_extension(attachment_callback_extension.unit, "player_visibility_system")
    local player_invisible = player_visibility and not player_visibility:visible()
    local inventory_view = mod:get_view("inventory_view")
    local wielded_slot = optional_wielded_slot or attachment_callback_extension.wielded_slot
    return wielded_slot == attachment_slot_data.slot_name and not player_invisible and not inventory_view and not mod:is_cutscene_active()
end

local function spawn_blade(attachment_callback_extension, attachment_slot_data, optional_no_sound, optional_no_animation)
    local no_sound = not not optional_no_sound
    local no_animation = not not optional_no_animation
    -- local player_visibility = script_unit_has_extension(attachment_callback_extension.unit, "player_visibility_system")
    -- local player_invisible = player_visibility and not player_visibility:visible()
    -- local inventory_view = mod:get_view("inventory_view")
    -- if not attachment_callback_extension.laser_blade_distortion_particle and attachment_callback_extension.wielded_slot == attachment_slot_data.slot_name and not player_invisible and not inventory_view then
    if not attachment_callback_extension.laser_blade_distortion_particle and can_spawn_blade(attachment_callback_extension, attachment_slot_data) then

        local attachment_unit = attachment_callback_extension:current_attachment_unit(attachment_slot_data.attachment_slot)
        if attachment_unit and unit_alive(attachment_unit) then

            local custom_fov = attachment_callback_extension.first_person_extension:is_in_first_person_mode()
            local attachment_data = attachment_slot_data.attachment_data
            local world = attachment_callback_extension.world
            local particle_name = attachment_data.particle_effect_name or LASER_PARTICLE

            attachment_callback_extension.laser_blade_distortion_particle = spawn_distortion_particle_effect(world, attachment_unit, attachment_data, custom_fov)

            attachment_callback_extension.laser_variable_index = world_find_particles_variable(world, particle_name, LASER_LENGTH_VARIABLE_NAME)

            attachment_callback_extension.laser_blade_laser_particle = spawn_laser_particle_effect(world, attachment_unit, attachment_data, custom_fov)

            attachment_callback_extension.vent_particle = spawn_vent_particle_effect(world, attachment_unit, attachment_data, custom_fov)

            attachment_callback_extension.laser_point_dot_particle, attachment_callback_extension.laser_point_dot_particle2 = spawn_laser_tip_particle_effects(world, attachment_unit, attachment_data, false, false, optional_no_animation)

            -- local fire_node = attachment_data._fire_node or 1
            local laser_node = laser_node(attachment_data)
            play_sound_effect(LASER_ON, attachment_callback_extension.unit, attachment_unit, laser_node, no_sound)
            play_sound_effect(PLAY_LASER_LOOP, attachment_callback_extension.unit, attachment_unit, laser_node, no_sound)

            if not no_animation then
                attachment_callback_extension.laser_start_fade_in = true
            end

        end

    end

end

local function update_blade(attachment_callback_extension, attachment_slot_data, dt, t)

    if attachment_callback_extension.laser_start_fade_t then

        local attachment_data = attachment_slot_data.attachment_data
        local particle_name = attachment_data.particle_effect_name or LASER_PARTICLE
        local world = attachment_callback_extension.world
        -- local fire_size = attachment_data._fire_size and vector3_unbox(attachment_data._fire_size) or FIRE_SIZE
        local fire_size = laser_1_size(attachment_data)

        if t > attachment_callback_extension.laser_start_fade_t then

            attachment_callback_extension.laser_start_fade_t = nil

            if attachment_callback_extension.laser_blade_laser_particle and attachment_callback_extension.laser_variable_index then
                world_set_particles_variable(world, attachment_callback_extension.laser_blade_laser_particle, attachment_callback_extension.laser_variable_index, fire_size)
            end

            if attachment_callback_extension.laser_point_dot_particle and attachment_callback_extension.laser_variable_index then
                -- local tip_size_1 = attachment_data._tip_size_1 and vector3_unbox(attachment_data._tip_size_1) or vector3(.25, .02, .25)
                local tip_size_1 = laser_2_size(attachment_data)
                world_set_particles_variable(world, attachment_callback_extension.laser_point_dot_particle, attachment_callback_extension.laser_variable_index, tip_size_1)
            end

            if attachment_callback_extension.laser_point_dot_particle2 and attachment_callback_extension.laser_variable_index then
                -- local tip_size_2 = attachment_data.tip_size_2 and vector3_unbox(attachment_data.tip_size_2) or vector3(.175, .03, .175)
                local tip_size_2 = laser_3_size(attachment_data)
                world_set_particles_variable(world, attachment_callback_extension.laser_point_dot_particle2, attachment_callback_extension.laser_variable_index, tip_size_2)
            end

        else

            local progress = 1 - (attachment_callback_extension.laser_start_fade_t - t) / FADE_IN_TIME

            if attachment_callback_extension.laser_blade_laser_particle and attachment_callback_extension.laser_variable_index then
                local current_value = fire_size * progress
                world_set_particles_variable(world, attachment_callback_extension.laser_blade_laser_particle, attachment_callback_extension.laser_variable_index, current_value)
            end

        end

    elseif attachment_callback_extension.laser_start_fade_in then

        attachment_callback_extension.laser_start_fade_t = t + FADE_IN_TIME
        attachment_callback_extension.laser_start_fade_in = nil

    end

end

local function update_blade_visibility(attachment_callback_extension, attachment_slot_data, wielded_slot)
    -- local player_visibility = script_unit_has_extension(attachment_callback_extension.unit, "player_visibility_system")
    -- local player_invisible = player_visibility and not player_visibility:visible()
    -- local inventory_view = mod:get_view("inventory_view")
    -- if wielded_slot ~= attachment_slot_data.slot_name or player_invisible or inventory_view then
    if can_spawn_blade(attachment_callback_extension, attachment_slot_data, wielded_slot) then
        spawn_blade(attachment_callback_extension, attachment_slot_data)
    else
        despawn_blade(attachment_callback_extension, attachment_slot_data)
    end
end

local function respawn_blade(attachment_callback_extension, attachment_slot_data)
    despawn_blade(attachment_callback_extension, attachment_slot_data, true, true)
    spawn_blade(attachment_callback_extension, attachment_slot_data, true, true)
end

local function impact_blade(attachment_callback_extension, attachment_slot_data, hit_position, hit_unit, attack_type, damage_profile, optional_no_sound)
    
    local attachment_unit = attachment_callback_extension:current_attachment_unit(attachment_slot_data.attachment_slot)
    if attack_type == attack_types.melee and damage_profile.melee_attack_strength and attachment_unit and unit_alive(attachment_unit) and hit_unit and unit_alive(hit_unit) then

        local no_sound = not not optional_no_sound
        local world = attachment_callback_extension.world

        local has_hip = unit_has_node(hit_unit, "j_hips")
        local attach_node = has_hip and unit_node(hit_unit, "j_hips") or 1
        local attachment_data = attachment_slot_data.attachment_data

        hit_position = hit_position or unit_world_position(hit_unit, attach_node)

        spawn_lingering_flame(world, attachment_unit, attachment_data, hit_unit, hit_position)

        -- local fire_node = attachment_data._fire_node or 1
        local laser_node = laser_node(attachment_data)
        play_sound_effect(IMPACT_SOUND, attachment_callback_extension.unit, attachment_unit, laser_node, no_sound)

    end

end

local function attack_blade(attachment_callback_extension, attachment_slot_data, hit_units, optional_no_sound)

    local no_sound = not not optional_no_sound
    local attachment_unit = attachment_callback_extension:current_attachment_unit(attachment_slot_data.attachment_slot)
    if attachment_callback_extension.wielded_slot == attachment_slot_data.slot_name and attachment_unit and unit_alive(attachment_unit) then

        local attachment_data = attachment_slot_data.attachment_data
        -- local fire_node = attachment_data._fire_node or 1
        local laser_node = laser_node(attachment_data)
        play_sound_effect(SWING_SOUND, attachment_callback_extension.unit, attachment_unit, laser_node, no_sound)

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