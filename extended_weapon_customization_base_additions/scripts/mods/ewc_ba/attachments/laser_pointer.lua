local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local FlashlightTemplates = mod:original_require("scripts/settings/equipment/flashlight_templates")
local LagCompensation = mod:original_require("scripts/utilities/lag_compensation")
local Recoil = mod:original_require("scripts/utilities/recoil")
local Sway = mod:original_require("scripts/utilities/sway")

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
    local table_contains = table.contains
    local quaternion_look = quaternion.look
    local vector3_unbox = vector3_box.unbox
    local unit_local_pose = unit.local_pose
    local unit_world_pose = unit.world_pose
    local vector3_distance = vector3.distance
    local vector3_normalize = vector3.normalize
    local quaternion_forward = quaternion.forward
    local quaternion_multiply = quaternion.multiply
    local matrix4x4_set_scale = matrix4x4.set_scale
    local matrix4x4_transform = matrix4x4.transform
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
    local world_stop_spawning_particles = world.stop_spawning_particles
    local world_set_particles_use_custom_fov = world.set_particles_use_custom_fov
    local matrix4x4_from_quaternion_position = matrix4x4.from_quaternion_position
    local world_set_particles_material_vector3 = world.set_particles_material_vector3
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"

local LASER_PARTICLE_NAME_OUTDOORS = "content/fx/particles/enemies/renegade_sniper/renegade_sniper_beam_outdoors"
local LOCK_STATES = {"walking", "sliding", "jumping", "falling", "dodging", "ledge_vaulting"}
local LASER_PARTICLE_NAME = "content/fx/particles/enemies/sniper_laser_sight"
local LASER_DOT = "content/fx/particles/enemies/red_glowing_eyes"
local LASER_LENGTH_VARIABLE_NAME = "hit_distance"
local SLOT_SECONDARY = "slot_secondary"
local LASER_X, LASER_Z = 0.05, 0.5
local ANGLE_THRESHOLD = .25
local LASER_Y_OFFSET = 1
local LOCKED_ACTIONS = {
    "action_bash_light_from_block_no_ammo",
    "action_reload_shotgun",
    "action_reload_state",
    "action_reload_loop",
    "action_bash_light",
    "action_bash_heavy",
    "action_bash_start",
    "action_bash_right",
    "action_pushfollow",
    "action_unwield",
    "action_inspect",
    "action_reload",
    "action_wield",
    "action_bash",
    "action_push",
}
local context = {
    preview_laser_particle_id = {},
    preview_laser_w_dot_id = {},
}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

local function despwan_preview_lasers(world, attachment_unit, attachment_data)
        
    if context.preview_laser_particle_id[attachment_unit] then

        if world_are_particles_playing(world, context.preview_laser_particle_id[attachment_unit]) then
            world_stop_spawning_particles(world, context.preview_laser_particle_id[attachment_unit])
        end

        world_destroy_particles(world, context.preview_laser_particle_id[attachment_unit])

        context.preview_laser_particle_id[attachment_unit] = nil

    end

    if context.preview_laser_w_dot_id[attachment_unit] then

        if world_are_particles_playing(world, context.preview_laser_w_dot_id[attachment_unit]) then
            world_stop_spawning_particles(world, context.preview_laser_w_dot_id[attachment_unit])
        end

        world_destroy_particles(world, context.preview_laser_w_dot_id[attachment_unit])

        context.preview_laser_w_dot_id[attachment_unit] = nil

    end

end

local function spawn_preview_laser(world, attachment_unit, attachment_data)

    despwan_preview_lasers(world, attachment_unit, attachment_data)

    local laser_node = attachment_data.laser_node or 2

    local flashlight_rotation = unit_world_rotation(attachment_unit, laser_node)

    local flashlight_position = unit_world_position(attachment_unit, laser_node)
    local particle_id = world_create_particles(world, LASER_PARTICLE_NAME, flashlight_position, flashlight_rotation)
    -- mod:echo("spawned laser "..tostring(particle_id))

    world_set_particles_use_custom_fov(world, particle_id, false)

    local laser_variable_index = world_find_particles_variable(world, LASER_PARTICLE_NAME, LASER_LENGTH_VARIABLE_NAME)

    world_move_particles(world, particle_id, flashlight_position, flashlight_rotation)

    world_set_particles_variable(world, particle_id, laser_variable_index, vector3(LASER_X, 10, LASER_Z))

    local laser_offset = attachment_data.laser_offset and vector3_unbox(attachment_data.laser_offset) or vector3(0, 0, 0)

    local pose = unit_local_pose(attachment_unit, laser_node)
    matrix4x4_set_translation(pose, laser_offset)

    world_link_particles(world, particle_id, attachment_unit, laser_node, pose, "destroy")

    context.preview_laser_particle_id[attachment_unit] = particle_id



    local laser_w_dot_id = world_create_particles(world, LASER_DOT, flashlight_position)
    world_set_particles_use_custom_fov(world, laser_w_dot_id, false)
    -- mod:echo("spawned laser weapon dot "..tostring(laser_w_dot_id))

    world_link_particles(world, laser_w_dot_id, attachment_unit, laser_node, pose, "destroy")

    world_set_particles_material_vector3(world, laser_w_dot_id, "eye_socket", "material_variable_21872256", vector3(1, 0, 0))
    world_set_particles_material_vector3(world, laser_w_dot_id, "eye_glow", "trail_color", vector3(0, 0, 0))
    world_set_particles_material_vector3(world, laser_w_dot_id, "eye_flash_init", "material_variable_21872256", vector3(.01, 0, 0))

    context.preview_laser_w_dot_id[attachment_unit] = laser_w_dot_id



    local light = unit_light(attachment_unit, 1)
    local ewc = get_mod("extended_weapon_customization")
    local flashlight_template_name = attachment_data.flashlight_template or "default"
    local flashlight_template = ewc.settings.flashlight_templates[flashlight_template_name] or FlashlightTemplates[flashlight_template_name] or FlashlightTemplates.default

    ewc:set_template_for_light(light, flashlight_template.light.third_person)
    ewc:set_light_color_for_unit(light, attachment_unit)
    ewc:set_light(light, true)

end

local function spawn_laser_pointer(flashlight_extension)
    if not flashlight_extension.laser_particle_id then

        local mission = managers.state.mission:mission()
        local zone_id = mission.zone_id
        local particle_name = LASER_PARTICLE_NAME

        if zone_id == "dust" then
            particle_name = LASER_PARTICLE_NAME_OUTDOORS
        end

        local flashlight_unit = flashlight_extension:current_flashlight_unit()
        if flashlight_unit and unit_alive(flashlight_unit) then

            local attachment_data = flashlight_extension.attachment_data
            local laser_node = attachment_data.laser_node or 2

            local flashlight_rotation = unit_world_rotation(flashlight_unit, laser_node)
            local mat = quaternion_matrix4x4(flashlight_rotation)

            local laser_offset = flashlight_extension.laser_offset and vector3_unbox(flashlight_extension.laser_offset) or vector3(0, 0, 0)
            local flashlight_position = unit_world_position(flashlight_unit, laser_node) + matrix4x4_transform(mat, laser_offset)

            flashlight_extension.laser_particle_id = world_create_particles(flashlight_extension.world, particle_name, flashlight_position)
            world_set_particles_use_custom_fov(flashlight_extension.world, flashlight_extension.laser_particle_id, true)
            flashlight_extension.laser_variable_index = world_find_particles_variable(flashlight_extension.world, particle_name, LASER_LENGTH_VARIABLE_NAME)
            -- mod:echo("spawned laser "..tostring(flashlight_extension.laser_particle_id))

            -- local pose = unit_local_pose(flashlight_unit, laser_node)
            local pose = matrix4x4_from_quaternion_position(flashlight_rotation, flashlight_position)
            -- matrix4x4_set_translation(pose, matrix4x4_transform(mat, laser_offset))

            flashlight_extension.laser_w_dot_id = world_create_particles(flashlight_extension.world, LASER_DOT, flashlight_position)
            world_set_particles_use_custom_fov(flashlight_extension.world, flashlight_extension.laser_w_dot_id, true)
            -- mod:echo("spawned laser weapon dot "..tostring(flashlight_extension.laser_w_dot_id))

            world_link_particles(flashlight_extension.world, flashlight_extension.laser_w_dot_id, flashlight_unit, laser_node, pose, "destroy")

            world_set_particles_material_vector3(flashlight_extension.world, flashlight_extension.laser_w_dot_id, "eye_socket", "material_variable_21872256", vector3(1, 0, 0))
            world_set_particles_material_vector3(flashlight_extension.world, flashlight_extension.laser_w_dot_id, "eye_glow", "trail_color", vector3(0, 0, 0))
            world_set_particles_material_vector3(flashlight_extension.world, flashlight_extension.laser_w_dot_id, "eye_flash_init", "material_variable_21872256", vector3(.01, 0, 0))

            flashlight_extension.laser_l_dot_id = world_create_particles(flashlight_extension.world, LASER_DOT, flashlight_position)
            world_set_particles_use_custom_fov(flashlight_extension.world, flashlight_extension.laser_l_dot_id, true)
            -- mod:echo("spawned laser weapon dot "..tostring(flashlight_extension.laser_l_dot_id))

            world_set_particles_material_vector3(flashlight_extension.world, flashlight_extension.laser_l_dot_id, "eye_socket", "material_variable_21872256", vector3(1, 0, 0))
            world_set_particles_material_vector3(flashlight_extension.world, flashlight_extension.laser_l_dot_id, "eye_glow", "trail_color", vector3(0, 0, 0))
            world_set_particles_material_vector3(flashlight_extension.world, flashlight_extension.laser_l_dot_id, "eye_flash_init", "material_variable_21872256", vector3(.5, 0, 0))

        end
        
    end
end

local function update_laser_pointer(flashlight_extension, dt, t)
    if flashlight_extension.laser_particle_id and flashlight_extension.laser_variable_index then

        local flashlight_unit = flashlight_extension:current_flashlight_unit()
        if flashlight_unit or not unit_alive(flashlight_unit) then

            local attachment_data = flashlight_extension.attachment_data
            local laser_node = attachment_data.laser_node or 2

            local character_state_extension = script_unit_extension(flashlight_extension.unit, "character_state_machine_system")
            local character_state = character_state_extension and character_state_extension:current_state()
            local character_state_name = character_state and character_state.name or ""
            local locked = table_contains(LOCK_STATES, character_state_name)

            local flashlight_rotation = unit_world_rotation(flashlight_unit, laser_node)
            local mat = quaternion_matrix4x4(flashlight_rotation)

            local laser_offset = attachment_data.laser_offset and vector3_unbox(attachment_data.laser_offset) or vector3(0, 0, 0)

            local flashlight_position = unit_world_position(flashlight_unit, laser_node) + matrix4x4_transform(mat, laser_offset)
            local laser_aim_direction = vector3_normalize(quaternion_forward(flashlight_rotation))

            local laser_raw_direction = flashlight_position + laser_aim_direction * 1000

            local first_person_unit = flashlight_extension.first_person_extension:first_person_unit()
            local node = unit_node(first_person_unit, "ap_aim")
            local aim_position = unit_world_position(first_person_unit, node)
            local aim_rotation = unit_world_rotation(first_person_unit, node)



            local sway_extension = script_unit_extension(flashlight_extension.unit, "sway_system")
            if sway_extension then
                local crouch_position = vector3_unbox(sway_extension.crouch_position)
                aim_position = aim_position - crouch_position
            end

            local sight_extension = script_unit_extension(flashlight_extension.unit, "sight_system")
            if sight_extension then
                local sight_position = vector3_unbox(sight_extension.current_offset.position)
                local sight_rotation = vector3_unbox(sight_extension.current_offset.rotation)

                aim_position = aim_position - matrix4x4_transform(mat, sight_position)
                -- aim_rotation = quaternion_multiply(aim_rotation, quaternion_from_vector(sight_rotation))
                aim_rotation = quaternion_multiply(aim_rotation, quaternion_from_vector(sight_rotation * -1))
            end



            local unit_data_extension = script_unit_extension(flashlight_extension.unit, "unit_data_system")

            local weapon_extension = script_unit_has_extension(flashlight_extension.unit, "weapon_system")
            
            local recoil_template = weapon_extension:recoil_template()
            local recoil_component = unit_data_extension:read_component("recoil")
            local movement_state_component = unit_data_extension:read_component("movement_state")
            aim_rotation = Recoil.apply_weapon_recoil_rotation(recoil_template, recoil_component, movement_state_component, aim_rotation)

            local sway_component = unit_data_extension:read_component("sway")
            local sway_template = weapon_extension:sway_template()
            aim_rotation = Sway.apply_sway_rotation(sway_template, sway_component, movement_state_component, aim_rotation)






            local aim_direction = vector3_normalize(quaternion_forward(aim_rotation))



            local _, laser_aim_position, _, _, hit_actor = physics_world_raycast(flashlight_extension.physics_world, aim_position, aim_direction, 1000, "closest", "types", "both",
                "collision_filter", "filter_player_character_shooting_projectile", "rewind_ms", LagCompensation.rewind_ms(false, true, flashlight_extension.player))
            
            laser_aim_position = laser_aim_position or laser_raw_direction


            local rotation = quaternion_look(laser_aim_position - flashlight_position)



            local diff = vector3_normalize(laser_aim_position - flashlight_position) - vector3_normalize(laser_raw_direction - flashlight_position)
            

            local weapon_action_component = unit_data_extension:read_component("weapon_action")
            local current_action_name = weapon_action_component.current_action_name



            if table_contains(LOCKED_ACTIONS, current_action_name) then
                locked = false
            end

            if diff[1] > ANGLE_THRESHOLD or diff[1] < -ANGLE_THRESHOLD or diff[2] > ANGLE_THRESHOLD or diff[2] < -ANGLE_THRESHOLD or diff[3] > ANGLE_THRESHOLD or diff[3] < -ANGLE_THRESHOLD then
                locked = false
            end

            if not locked then
                -- rotation = flashlight_rotation
                laser_aim_position = laser_raw_direction
                rotation = quaternion_look(laser_aim_position - flashlight_position)

            end

            world_move_particles(flashlight_extension.world, flashlight_extension.laser_particle_id, flashlight_position, rotation)

            local distance = vector3_distance(flashlight_position, laser_aim_position)

            world_set_particles_variable(flashlight_extension.world, flashlight_extension.laser_particle_id, flashlight_extension.laser_variable_index, vector3(LASER_X, distance, LASER_Z))

            if flashlight_extension.laser_l_dot_id then

                world_set_particles_material_vector3(flashlight_extension.world, flashlight_extension.laser_l_dot_id, "eye_socket", "material_variable_21872256", vector3(100 / distance, 0, 0))
                world_move_particles(flashlight_extension.world, flashlight_extension.laser_l_dot_id, laser_aim_position, rotation)

            end

            if flashlight_extension.laser_w_dot_id then

                world_move_particles(flashlight_extension.world, flashlight_extension.laser_w_dot_id, flashlight_position, rotation)

            end

        end

    end
end

local function despawn_laser_pointer(flashlight_extension)
    if flashlight_extension.laser_particle_id then

        if world_are_particles_playing(flashlight_extension.world, flashlight_extension.laser_particle_id) then
            world_stop_spawning_particles(flashlight_extension.world, flashlight_extension.laser_particle_id)
        end

        world_destroy_particles(flashlight_extension.world, flashlight_extension.laser_particle_id)

        flashlight_extension.laser_particle_id = nil

    end

    if flashlight_extension.laser_w_dot_id then

        if world_are_particles_playing(flashlight_extension.world, flashlight_extension.laser_w_dot_id) then
            world_stop_spawning_particles(flashlight_extension.world, flashlight_extension.laser_w_dot_id)
        end
        
        world_destroy_particles(flashlight_extension.world, flashlight_extension.laser_w_dot_id)

        flashlight_extension.laser_w_dot_id = nil

    end

    if flashlight_extension.laser_l_dot_id then

        if world_are_particles_playing(flashlight_extension.world, flashlight_extension.laser_l_dot_id) then
            world_stop_spawning_particles(flashlight_extension.world, flashlight_extension.laser_l_dot_id)
        end
        
        world_destroy_particles(flashlight_extension.world, flashlight_extension.laser_l_dot_id)

        flashlight_extension.laser_l_dot_id = nil

    end
end

local function update_laser_pointer_visibility(flashlight_extension, wielded_slot)
    local player_visibility = script_unit_has_extension(flashlight_extension.unit, "player_visibility_system")
    local player_invisible = player_visibility and not player_visibility:visible()
    local inventory_view = mod:get_view("inventory_view")
    if wielded_slot ~= SLOT_SECONDARY or player_invisible or inventory_view then
        despawn_laser_pointer(flashlight_extension)
    elseif flashlight_extension.on then
        spawn_laser_pointer(flashlight_extension)
    end
end

local function respawn_laser_pointer(flashlight_extension)
    despawn_laser_pointer(flashlight_extension)
    update_laser_pointer_visibility(flashlight_extension, flashlight_extension.wielded_slot)
end

return {
    update_laser_pointer_visibility = update_laser_pointer_visibility,
    despwan_preview_lasers = despwan_preview_lasers,
    despawn_laser_pointer = despawn_laser_pointer,
    respawn_laser_pointer = respawn_laser_pointer,
    update_laser_pointer = update_laser_pointer,
    spawn_preview_laser = spawn_preview_laser,
    spawn_laser_pointer = spawn_laser_pointer,
}