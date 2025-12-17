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
    local unit_light = unit.light
    local quaternion = Quaternion
    local unit_alive = unit.alive
    local vector3_box = Vector3Box
    local script_unit = ScriptUnit
    local table_clear = table.clear
    local vector3_zero = vector3.zero
    local physics_world = PhysicsWorld
    local table_contains = table.contains
    local unit_num_lights = unit.num_lights
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

local pt = mod:pt()
local LOCK_STATES = {"walking", "sliding", "jumping", "falling", "dodging", "ledge_vaulting"}
local LASER_PARTICLE = "content/fx/particles/enemies/sniper_laser_sight"
local DOT_PARTICLE = "content/fx/particles/enemies/red_glowing_eyes"
local LASER_COLOR = vector3_box(1, 0, 0)
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
    preview_laser_laser_particles = {},
    preview_laser_wweapon_dot_particles = {},
}

local function color_light_in_attachment(attachment_unit, attachment_data)
    -- Check unit
    if attachment_unit and unit_alive(attachment_unit) then
        if unit_num_lights(attachment_unit) > 0 then
            local light = unit_light(attachment_unit, 1)
            local ewc = get_mod("extended_weapon_customization")
            local flashlight_template_name = attachment_data.flashlight_template or "default"
            local flashlight_template = ewc.settings.flashlight_templates[flashlight_template_name] or FlashlightTemplates[flashlight_template_name] or FlashlightTemplates.default

            ewc:set_template_for_light(light, flashlight_template.light.third_person)
            ewc:set_light_color_for_unit(light, attachment_unit)
            ewc:set_light(light, true)
        end
    end
end

-- ##### ┌─┐┌─┐┌─┐┬ ┬┌┐┌  ┌─┐┌─┐┬─┐┌┬┐┬┌─┐┬  ┌─┐  ┌─┐┌─┐┌─┐┌─┐┌─┐┌┬┐┌─┐ ###############################################
-- ##### └─┐├─┘├─┤││││││  ├─┘├─┤├┬┘ │ ││  │  ├┤   ├┤ ├┤ ├┤ ├┤ │   │ └─┐ ###############################################
-- ##### └─┘┴  ┴ ┴└┴┘┘└┘  ┴  ┴ ┴┴└─ ┴ ┴└─┘┴─┘└─┘  └─┘└  └  └─┘└─┘ ┴ └─┘ ###############################################

local function spawn_laser_particle_effect(world, attachment_unit, attachment_data, flashlight_position, flashlight_rotation, optional_link, optional_custom_fov)
    local laser_node = attachment_data.laser_node or 2
    local laser_particle = attachment_data.laser_particle_effect or LASER_PARTICLE
    local laser_offset = attachment_data.laser_offset and vector3_unbox(attachment_data.laser_offset) or vector3(0, 0, 0)
    local link = not not optional_link
    local custom_fov = optional_custom_fov or false
    -- Create laser pointer particle effect
    local particle_id = world_create_particles(world, laser_particle, flashlight_position, flashlight_rotation)
    world_set_particles_use_custom_fov(world, particle_id, custom_fov)
    world_move_particles(world, particle_id, flashlight_position, flashlight_rotation)
    -- Set laser pointer distance variable
    local laser_variable_index = world_find_particles_variable(world, laser_particle, LASER_LENGTH_VARIABLE_NAME)
    world_set_particles_variable(world, particle_id, laser_variable_index, vector3(LASER_X, 10, LASER_Z))
    -- Link
    if link then
        -- Offset pose
        local pose = unit_local_pose(attachment_unit, laser_node)
        matrix4x4_set_translation(pose, laser_offset)
        -- Link to attachment
        world_link_particles(world, particle_id, attachment_unit, laser_node, pose, "destroy")
    end
    -- Save id
    return particle_id
end

local function spawn_weapon_dot_particle_effect(world, attachment_unit, attachment_data, flashlight_position, flashlight_rotation, optional_custom_fov)
    local laser_node = attachment_data.laser_node or 2
    local dot_particle = attachment_data.dot_particle_effect or DOT_PARTICLE
    local laser_color = attachment_data.laser_color and vector3_unbox(attachment_data.laser_color) or vector3_unbox(LASER_COLOR)
    local laser_offset = attachment_data.laser_offset and vector3_unbox(attachment_data.laser_offset) or vector3(0, 0, 0)
    local custom_fov = optional_custom_fov or false
    -- Create weapon dot particle effect
    local laser_pointer_weapon_dot_particle = world_create_particles(world, dot_particle, flashlight_position)
    world_set_particles_use_custom_fov(world, laser_pointer_weapon_dot_particle, custom_fov)
    -- Offset pose
    local pose = unit_local_pose(attachment_unit, laser_node)
    matrix4x4_set_translation(pose, laser_offset)
    -- Link to attachment
    world_link_particles(world, laser_pointer_weapon_dot_particle, attachment_unit, laser_node, pose, "destroy")
    -- Set colors
    world_set_particles_material_vector3(world, laser_pointer_weapon_dot_particle, "eye_socket", "material_variable_21872256", vector3(1 * laser_color[1], 1 * laser_color[2], 1 * laser_color[3]))
    world_set_particles_material_vector3(world, laser_pointer_weapon_dot_particle, "eye_glow", "trail_color", vector3(.01 * laser_color[1], .01 * laser_color[2], .01 * laser_color[3]))
    world_set_particles_material_vector3(world, laser_pointer_weapon_dot_particle, "eye_flash_init", "material_variable_21872256", vector3(.01 * laser_color[1], .01 * laser_color[2], .01 * laser_color[3]))
    -- Save id
    return laser_pointer_weapon_dot_particle
end

local function spawn_laser_dot_particle_effect(world, attachment_unit, attachment_data, flashlight_position, flashlight_rotation, optional_custom_fov)
    local dot_particle = attachment_data.dot_particle_effect or DOT_PARTICLE
    local laser_color = attachment_data.laser_color and vector3_unbox(attachment_data.laser_color) or vector3_unbox(LASER_COLOR)
    local custom_fov = optional_custom_fov or false
    -- Create laser dot particle effect
    local laser_pointer_laser_dot_particle = world_create_particles(world, dot_particle, flashlight_position)
    world_set_particles_use_custom_fov(world, laser_pointer_laser_dot_particle, custom_fov)
    -- Set colors
    world_set_particles_material_vector3(world, laser_pointer_laser_dot_particle, "eye_socket", "material_variable_21872256", vector3(1 * laser_color[1], 1 * laser_color[2], 1 * laser_color[3]))
    world_set_particles_material_vector3(world, laser_pointer_laser_dot_particle, "eye_glow", "trail_color", vector3(.01 * laser_color[1], .01 * laser_color[2], .01 * laser_color[3]))
    world_set_particles_material_vector3(world, laser_pointer_laser_dot_particle, "eye_flash_init", "material_variable_21872256", vector3(.5 * laser_color[1], .5 * laser_color[2], .5 * laser_color[3]))
    -- Save id
    return laser_pointer_laser_dot_particle
end

-- ### ┌─┐┬─┐┌─┐┬  ┬┬┌─┐┬ ┬  ┬  ┌─┐┌─┐┌─┐┬─┐       ┬ ┬┬  ┬┌┬┐┌─┐┌┬┐┌─┐   ┌─┐┬─┐┌─┐┌─┐┬┬  ┌─┐  ┌─┐┌─┐┌─┐┬ ┬┌┐┌┌─┐┬─┐ ###
-- ### ├─┘├┬┘├┤ └┐┌┘│├┤ │││  │  ├─┤└─┐├┤ ├┬┘  ───  │ ││  │ │ ├┤ │││└─┐   ├─┘├┬┘│ │├┤ ││  ├┤   └─┐├─┘├─┤││││││├┤ ├┬┘ ###
-- ### ┴  ┴└─└─┘ └┘ ┴└─┘└┴┘  ┴─┘┴ ┴└─┘└─┘┴└─       └─┘┴  ┴ ┴ └─┘┴ ┴└─┘┘  ┴  ┴└─└─┘└  ┴┴─┘└─┘  └─┘┴  ┴ ┴└┴┘┘└┘└─┘┴└─ ###

local function despawn_preview_effect(world, particle_name, attachment_unit)
    -- Check unit
    if attachment_unit and unit_alive(attachment_unit) then
        -- Check running effect for unit
        if context[particle_name] and context[particle_name][attachment_unit] then
            -- Stop effect
            if world_are_particles_playing(world, context[particle_name][attachment_unit]) then
                world_stop_spawning_particles(world, context[particle_name][attachment_unit])
            end
            -- Destroy
            world_destroy_particles(world, context[particle_name][attachment_unit])
            -- Set nil
            context[particle_name][attachment_unit] = nil
        end
    end
end

local function despwan_preview_lasers(world, attachment_unit, attachment_data)
    -- Check unit
    if attachment_unit and unit_alive(attachment_unit) then
        despawn_preview_effect(world, "preview_laser_laser_particles", attachment_unit)
        despawn_preview_effect(world, "preview_laser_wweapon_dot_particles", attachment_unit)
    end
end

local function spawn_preview_laser(world, attachment_unit, attachment_data)
    -- Check unit
    if attachment_unit and unit_alive(attachment_unit) then
        despwan_preview_lasers(world, attachment_unit, attachment_data)

        -- Attachment data
        local laser_node = attachment_data.laser_node or 2
        local laser_particle = attachment_data.laser_particle_effect or LASER_PARTICLE
        local dot_particle = attachment_data.dot_particle_effect or DOT_PARTICLE
        local laser_color = attachment_data.laser_color and vector3_unbox(attachment_data.laser_color) or vector3_unbox(LASER_COLOR)
        local laser_offset = attachment_data.laser_offset and vector3_unbox(attachment_data.laser_offset) or vector3(0, 0, 0)
        local pose = unit_local_pose(attachment_unit, laser_node)

        -- Attachment unit data
        local flashlight_rotation = unit_world_rotation(attachment_unit, laser_node)
        local flashlight_position = unit_world_position(attachment_unit, laser_node)

        -- Create laser pointer particle effect
        context.preview_laser_laser_particles[attachment_unit] = spawn_laser_particle_effect(world, attachment_unit, attachment_data, flashlight_position, flashlight_rotation, true, false)

        -- Create weapon dot particle effect
        context.preview_laser_wweapon_dot_particles[attachment_unit] = spawn_weapon_dot_particle_effect(world, attachment_unit, attachment_data, flashlight_position, flashlight_rotation, false)

        -- Color light in attachment unit
        color_light_in_attachment(attachment_unit, attachment_data)
    end
end

-- ##### ┌─┐┌─┐ ┬ ┬┬┌─┐┌─┐┌─┐┌┬┐  ┬  ┌─┐┌─┐┌─┐┬─┐ #####################################################################
-- ##### ├┤ │─┼┐│ ││├─┘├─┘├┤  ││  │  ├─┤└─┐├┤ ├┬┘ #####################################################################
-- ##### └─┘└─┘└└─┘┴┴  ┴  └─┘─┴┘  ┴─┘┴ ┴└─┘└─┘┴└─ #####################################################################

local function can_spawn_laser_pointer(flashlight_extension)
    local player_visibility = script_unit_has_extension(flashlight_extension.unit, "player_visibility_system")
    local player_invisible = player_visibility and not player_visibility:visible()
    local inventory_view = mod:get_view("inventory_view")
    return flashlight_extension:is_wielded() and not player_invisible and not inventory_view and not mod:is_cutscene_active()
end

local function spawn_laser_pointer(flashlight_extension)
    -- Visibility
    -- local player_visibility = script_unit_has_extension(flashlight_extension.unit, "player_visibility_system")
    -- local player_invisible = player_visibility and not player_visibility:visible()
    -- local inventory_view = mod:get_view("inventory_view")
    -- Check if laser should be on
    -- if flashlight_extension.on and not flashlight_extension.laser_pointer_laser_particle and flashlight_extension:is_wielded() and not player_invisible and not inventory_view then
    if flashlight_extension.on and not flashlight_extension.laser_pointer_laser_particle and can_spawn_laser_pointer(flashlight_extension) then
        -- Get current attachment unit
        local flashlight_unit = flashlight_extension:current_flashlight_unit()
        -- Check unit
        if flashlight_unit and unit_alive(flashlight_unit) then
            
            -- Get attachment data
            local is_first_person = flashlight_extension.first_person_extension:is_in_first_person_mode()
            local attachment_data = flashlight_extension.attachment_data
            local laser_node = attachment_data.laser_node or 2
            local laser_particle = attachment_data.laser_particle_effect or LASER_PARTICLE
            local world = flashlight_extension.world

            -- Get position / rotation
            local flashlight_rotation = unit_world_rotation(flashlight_unit, laser_node)
            local mat = quaternion_matrix4x4(flashlight_rotation)
            local laser_offset = flashlight_extension.laser_offset and vector3_unbox(flashlight_extension.laser_offset) or vector3(0, 0, 0)
            local flashlight_position = unit_world_position(flashlight_unit, laser_node) + matrix4x4_transform(mat, laser_offset)
            
            -- Offset pose
            local pose = unit_local_pose(flashlight_unit, laser_node)
            matrix4x4_set_translation(pose, laser_offset)

            -- Create laser particle effect
            flashlight_extension.laser_pointer_laser_particle = spawn_laser_particle_effect(world, flashlight_unit, attachment_data, flashlight_position, flashlight_rotation, false, is_first_person)
            -- Set laser pointer distance variable
            flashlight_extension.laser_variable_index = world_find_particles_variable(world, laser_particle, LASER_LENGTH_VARIABLE_NAME)
            
            -- Create weapon dot particle effect
            flashlight_extension.laser_pointer_weapon_dot_particle = spawn_weapon_dot_particle_effect(world, flashlight_unit, attachment_data, flashlight_position, flashlight_rotation, is_first_person)
            
            -- Create laser dot particle effect
            flashlight_extension.laser_pointer_laser_dot_particle = spawn_laser_dot_particle_effect(world, flashlight_unit, attachment_data, flashlight_position, flashlight_rotation, is_first_person)

            -- Color light in attachment unit
            color_light_in_attachment(flashlight_unit, attachment_data)

        end
    end
end

local function despawn_laser_pointer_effect(flashlight_extension, particle_effect)
    if flashlight_extension[particle_effect] then
        -- Stop particles
        if world_are_particles_playing(flashlight_extension.world, flashlight_extension[particle_effect]) then
            world_stop_spawning_particles(flashlight_extension.world, flashlight_extension[particle_effect])
        end
        -- Destroy
        world_destroy_particles(flashlight_extension.world, flashlight_extension[particle_effect])
        -- Set nil
        flashlight_extension[particle_effect] = nil
    end
end

local function despawn_laser_pointer(flashlight_extension)
    despawn_laser_pointer_effect(flashlight_extension, "laser_pointer_laser_particle")
    despawn_laser_pointer_effect(flashlight_extension, "laser_pointer_weapon_dot_particle")
    despawn_laser_pointer_effect(flashlight_extension, "laser_pointer_laser_dot_particle")
end

local function respawn_laser_pointer(flashlight_extension)
    despawn_laser_pointer(flashlight_extension)
    spawn_laser_pointer(flashlight_extension)
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐  ┌─┐┌─┐┬─┐┌┬┐┬┌─┐┬  ┌─┐  ┌─┐┌─┐┌─┐┌─┐┌─┐┌┬┐┌─┐ ############################################
-- ##### │ │├─┘ ││├─┤ │ ├┤   ├─┘├─┤├┬┘ │ ││  │  ├┤   ├┤ ├┤ ├┤ ├┤ │   │ └─┐ ############################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘  ┴  ┴ ┴┴└─ ┴ ┴└─┘┴─┘└─┘  └─┘└  └  └─┘└─┘ ┴ └─┘ ############################################

local function update_laser_pointer(flashlight_extension, dt, t)
    if flashlight_extension.laser_pointer_laser_particle and flashlight_extension.laser_variable_index and can_spawn_laser_pointer(flashlight_extension) then

        local flashlight_unit = flashlight_extension:current_flashlight_unit()
        if flashlight_unit or not unit_alive(flashlight_unit) then

            -- First person aim position / rotation
            local first_person_unit = flashlight_extension.first_person_extension:first_person_unit()
            local node = unit_node(first_person_unit, "ap_aim")
            local aim_position = unit_world_position(first_person_unit, node)
            local aim_rotation = unit_world_rotation(first_person_unit, node)

            -- Get attachment data
            local attachment_data = flashlight_extension.attachment_data
            local laser_node = attachment_data.laser_node or 2
            local laser_color = attachment_data.laser_color and vector3_unbox(attachment_data.laser_color) or vector3_unbox(LASER_COLOR)
            local laser_offset = attachment_data.laser_offset and vector3_unbox(attachment_data.laser_offset) or vector3(0, 0, 0)

            -- Character state check
            local character_state_extension = script_unit_extension(flashlight_extension.unit, "character_state_machine_system")
            local character_state = character_state_extension and character_state_extension:current_state()
            local character_state_name = character_state and character_state.name or ""

            -- Flashlight rotation / position
            local flashlight_rotation = unit_world_rotation(flashlight_unit, laser_node)
            local mat = quaternion_matrix4x4(flashlight_rotation)
            local flashlight_position = unit_world_position(flashlight_unit, laser_node) + matrix4x4_transform(mat, laser_offset)

            -- Direction
            local laser_aim_direction = vector3_normalize(quaternion_forward(flashlight_rotation))
            local laser_raw_direction = flashlight_position + laser_aim_direction * 1000

            -- Apply sway value
            local sway_extension = script_unit_extension(flashlight_extension.unit, "sway_system")
            if sway_extension then
                local crouch_position = vector3_unbox(sway_extension.crouch_position)
                aim_position = aim_position - crouch_position
            end

            -- Apply sight offset
            local sight_extension = script_unit_extension(flashlight_extension.unit, "sight_system")
            if sight_extension then
                local sight_position = vector3_unbox(sight_extension.current_offset.position)
                local sight_rotation = vector3_unbox(sight_extension.current_offset.rotation)
                aim_position = aim_position - matrix4x4_transform(mat, sight_position)
                aim_rotation = quaternion_multiply(aim_rotation, quaternion_from_vector(sight_rotation * -1))
            end

            -- Weapon data
            local unit_data_extension = script_unit_extension(flashlight_extension.unit, "unit_data_system")
            local weapon_extension = script_unit_has_extension(flashlight_extension.unit, "weapon_system")
            if weapon_extension then
                -- Apply recoil
                local recoil_template = weapon_extension:recoil_template()
                local recoil_component = unit_data_extension:read_component("recoil")
                local movement_state_component = unit_data_extension:read_component("movement_state")
                -- local first_person_component = unit_data_extension:read_component("first_person")
                local inair_state_component = unit_data_extension:read_component("inair_state")
                local locomotion_component = unit_data_extension:read_component("locomotion")
                -- local rotation = first_person_component.rotation
                aim_rotation = Recoil.apply_weapon_recoil_rotation(recoil_template, recoil_component, movement_state_component, locomotion_component, inair_state_component, aim_rotation)
                -- Apply game sway
                local sway_component = unit_data_extension:read_component("sway")
                local sway_template = weapon_extension:sway_template()
                aim_rotation = Sway.apply_sway_rotation(sway_template, sway_component, aim_rotation)
            end

            -- Aim rotation
            local aim_direction = vector3_normalize(quaternion_forward(aim_rotation))

            -- Raycast
            local _, laser_aim_position, _, _, hit_actor = physics_world_raycast(flashlight_extension.physics_world, aim_position, aim_direction, 1000, "closest", "types", "both",
                "collision_filter", "filter_player_character_shooting_projectile", "rewind_ms", LagCompensation.rewind_ms(false, true, flashlight_extension.player))
            
            -- Resulting aim position
            laser_aim_position = laser_aim_position or laser_raw_direction

            -- Resulting aim rotation
            local rotation = quaternion_look(laser_aim_position - flashlight_position)
            
            -- Aim lock
            local locked = table_contains(LOCK_STATES, character_state_name)
            -- Aim difference
            local diff = vector3_normalize(laser_aim_position - flashlight_position) - vector3_normalize(laser_raw_direction - flashlight_position)
            if diff[1] > ANGLE_THRESHOLD or diff[1] < -ANGLE_THRESHOLD or diff[2] > ANGLE_THRESHOLD or diff[2] < -ANGLE_THRESHOLD or diff[3] > ANGLE_THRESHOLD or diff[3] < -ANGLE_THRESHOLD then
                locked = false
            end
            -- Weapon action
            local weapon_action_component = unit_data_extension:read_component("weapon_action")
            local current_action_name = weapon_action_component.current_action_name
            if table_contains(LOCKED_ACTIONS, current_action_name) then
                locked = false
            end
            -- Aiming
            if flashlight_extension.alternate_fire_component.is_active then
                locked = true
            end
            -- If locked then apply raw laser pointer position / rotation
            if not locked then
                laser_aim_position = laser_raw_direction
                rotation = quaternion_look(laser_aim_position - flashlight_position)
            end

            -- Move particles to flashlight position and rotate towards aim point
            world_move_particles(flashlight_extension.world, flashlight_extension.laser_pointer_laser_particle, flashlight_position, rotation)

            -- Get distance to aim point
            local distance = vector3_distance(flashlight_position, laser_aim_position)

            -- Set laser pointer distance variable
            world_set_particles_variable(flashlight_extension.world, flashlight_extension.laser_pointer_laser_particle, flashlight_extension.laser_variable_index, vector3(LASER_X, distance, LASER_Z))

            -- Update laser dot
            if flashlight_extension.laser_pointer_laser_dot_particle then
                -- Get distance dot size
                local dot_size = vector3((100 / distance) * laser_color[1], (100 / distance) * laser_color[2], (100 / distance) * laser_color[3])
                -- Set dot size
                world_set_particles_material_vector3(flashlight_extension.world, flashlight_extension.laser_pointer_laser_dot_particle, "eye_socket", "material_variable_21872256", dot_size)
                -- Move to aim point
                world_move_particles(flashlight_extension.world, flashlight_extension.laser_pointer_laser_dot_particle, laser_aim_position, rotation)
            end

            -- Update weapon dot
            if flashlight_extension.laser_pointer_weapon_dot_particle then
                -- Move to flashlight position
                world_move_particles(flashlight_extension.world, flashlight_extension.laser_pointer_weapon_dot_particle, flashlight_position, rotation)
            end

        end
    elseif not can_spawn_laser_pointer(flashlight_extension) then
        despawn_laser_pointer(flashlight_extension)
    end
end

local function update_laser_pointer_visibility(flashlight_extension, wielded_slot)
    -- local player_visibility = script_unit_has_extension(flashlight_extension.unit, "player_visibility_system")
    -- local player_invisible = player_visibility and not player_visibility:visible()
    -- local inventory_view = mod:get_view("inventory_view")
    -- if wielded_slot ~= SLOT_SECONDARY or player_invisible or inventory_view then
    if flashlight_extension.on and can_spawn_laser_pointer(flashlight_extension) then
        spawn_laser_pointer(flashlight_extension)
    else
        despawn_laser_pointer(flashlight_extension)
    end
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