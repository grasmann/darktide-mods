local mod = get_mod("servo_friend")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local math = math
local unit = Unit
local type = type
local pairs = pairs
local class = class
local CLASS = CLASS
local world = World
local table = table
local vector3 = Vector3
local math_abs = math.abs
local managers = Managers
local matrix4x4 = Matrix4x4
local math_sign = math.sign
local math_acos = math.acos
local math_lerp = math.lerp
local table_size = table.size
local unit_alive = unit.alive
local quaternion = Quaternion
local math_clamp = math.clamp
local vector3_up = vector3.up
local script_unit = ScriptUnit
local vector3_box = Vector3Box
local vector3_dot = vector3.dot
local math_random = math.random
local vector3_zero = vector3.zero
local vector3_lerp = vector3.lerp
local physics_world = PhysicsWorld
local vector3_cross = vector3.cross
local quaternion_box = QuaternionBox
local quaternion_look = quaternion.look
local quaternion_lerp = quaternion.lerp
local vector3_unbox = vector3_box.unbox
local vector3_distance = vector3.distance
local vector3_normalize = vector3.normalize
local world_destroy_unit = world.destroy_unit
local quaternion_forward = quaternion.forward
local quaternion_unbox = quaternion_box.unbox
local quaternion_multiply = quaternion.multiply
local quaternion_identity = quaternion.identity
local world_spawn_unit_ex = world.spawn_unit_ex
local unit_local_position = unit.local_position
local unit_world_position = unit.world_position
local matrix4x4_transform = matrix4x4.transform
local unit_local_rotation = unit.local_rotation
local quaternion_matrix4x4 = quaternion.matrix4x4
local script_unit_extension = script_unit.extension
local physics_world_raycast = physics_world.raycast
local unit_set_local_rotation = unit.set_local_rotation
local unit_set_local_position = unit.set_local_position
local script_unit_add_extension = script_unit.add_extension
local script_unit_has_extension = script_unit.has_extension
local script_unit_remove_extension = script_unit.remove_extension
local quaternion_from_euler_angles_xyz = quaternion.from_euler_angles_xyz

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local WALK = "walk"
local SPRINT = "sprint"
local spineless_servo_friend_unit = "content/environment/cinematic/servo_skull_scanning_static"
local dominant_servo_friend_unit = "content/weapons/player/pickups/pup_servo_skull_scanning/pup_servo_skull_scanning"
local decoder_servo_friend_unit = "content/weapons/player/pickups/pup_skull_decoder/pup_skull_decoder"
local decoder_2_servo_friend_unit = "content/weapons/player/pickups/pup_skull_decoder_02/pup_skull_decoder_02"
local servo_friend_units = {
    spineless = spineless_servo_friend_unit,
    dominant = dominant_servo_friend_unit,
    decoder = decoder_servo_friend_unit,
    decoder_2 = decoder_2_servo_friend_unit,
}
local packages_to_load = {
    spineless_servo_friend_unit,
    dominant_servo_friend_unit,
    decoder_servo_friend_unit,
    decoder_2_servo_friend_unit,
}

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local PlayerUnitServoFriendExtension = class("PlayerUnitServoFriendExtension")

mod:register_packages(packages_to_load)

PlayerUnitServoFriendExtension.print = function(self, message)
    mod:print(message)
end

PlayerUnitServoFriendExtension.pt = function(self)
    return mod:pt()
end

PlayerUnitServoFriendExtension.is_initialized = function(self)
    return mod.initialized and self.initialized
end

-- ##### ┬┌┐┌┬┌┬┐       ┌┬┐┌─┐┌─┐┌┬┐┬─┐┌─┐┬ ┬ #########################################################################
-- ##### │││││ │   ───   ││├┤ └─┐ │ ├┬┘│ │└┬┘ #########################################################################
-- ##### ┴┘└┘┴ ┴        ─┴┘└─┘└─┘ ┴ ┴└─└─┘ ┴  #########################################################################

PlayerUnitServoFriendExtension.init = function(self, extension_init_context, unit, extension_init_data)
    -- References
    self.world_manager = managers.world
    self.package_manager = managers.package
    self.time_manager = managers.time
    -- self.event_manager = managers.event
    -- Worlds
    self.hub = self:is_in_hub()
    self._world = self:world()
    self._physics_world = self:physics_world()
    self._wwise_world = self:wwise_world()
    -- Extensions
    self.unit_data = script_unit_extension(unit, "unit_data_system")
    self.alternate_fire_component = self.unit_data and self.unit_data:read_component("alternate_fire")
    self.first_person_extension = script_unit_extension(unit, "first_person_system")
    self.weapon_action_component = self.unit_data:read_component("weapon_action")
    self.sprint_character_state_component = self.unit_data and self.unit_data:read_component("sprint_character_state")
    self.hub_jog_character_state = self.unit_data and self.unit_data:read_component("hub_jog_character_state")
    self.movement_state_component = self.unit_data and self.unit_data:read_component("movement_state")
    self.locomotion_extension = script_unit_extension(unit, "locomotion_system")
    -- Units
    self.unit = unit
    self.player_unit = unit
    self.is_local_unit = extension_init_data.is_local_unit
    self.servo_friend_unit = nil
    self.first_person_unit = self.first_person_extension:first_person_unit()
    -- Position
    self.current_position = vector3_box(vector3_zero())
    self.last_position = vector3_box(vector3_zero())
    self.target_position = vector3_box(vector3_zero())
    self.aim_position = vector3_box(vector3_zero())
    -- Daemonhost
    self.avoid_daemonhost_position = vector3_box(vector3_zero())
    self.check_daemonhosts_timer = 0
    self.check_daemonhosts_time = 5
    self.daemonhosts = {}
    -- Leaning
    self.lean = 0
    self.prev_direction = vector3_box(vector3_zero())
    -- Aim
    self.current_rotation = quaternion_box(quaternion_identity())
    self.target_rotation = quaternion_box(quaternion_identity())
    self.last_rotation = quaternion_box(quaternion_identity())
    -- Data
    self.init_context = extension_init_context
    self.init_data = extension_init_data
    self.found_something_valid = false
    self.busy = false
    self.is_aim_locked = false
    self.max_distance = 20
    self.min_distance = 10
    self.position_was_corrected = false
    self.character_height = self.first_person_extension:extrapolated_character_height()
    -- Events
    managers.event:register(self, "servo_friend_set_target_position", "on_servo_friend_set_target_position")
    -- Init
    self.initialized = true
    -- Settings
    self:on_settings_changed()
    -- Debug
    self:print("PlayerUnitServoFriendExtension initialized")
end

PlayerUnitServoFriendExtension.p2p_command = function(self, command, target, data)
    return mod:p2p_command(command, target, data)
end

PlayerUnitServoFriendExtension.destroy = function(self)
    -- Deinit
    self.initialized = false
    -- Events
    managers.event:unregister(self, "servo_friend_set_target_position")
    -- Destroy
    self:destroy_servo_friend()
    -- Debug
    self:print("PlayerUnitServoFriendExtension destroyed")
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

PlayerUnitServoFriendExtension.all_packages_loaded = function(self)
    local pt = self:pt()
    return pt.all_packages_loaded
end

PlayerUnitServoFriendExtension.update = function(self, dt, t)

    -- Check if initialized and all packages are loaded
    if self:is_initialized() and self:all_packages_loaded() and not self.appearance_changed then
        -- Spawn servo friend
        self:spawn_servo_friend(dt, t)
    else
        -- Destroy servo friend
        self:destroy_servo_friend()
        -- mod:echo("PlayerUnitServoFriendExtension: not initialized or all packages not loaded")
    end

    -- Check if servo friend is alive
    if self:servo_friend_alive() then
        -- Update
        self:update_extensions(dt, t)
        self:update_movement(dt, t)
        self:update_aim(dt, t)
        self:check_for_daemonhosts(dt, t)
    end

end

PlayerUnitServoFriendExtension.extensions_settings_changed = function(self, setting_id)
    -- self:execute_extensions("on_settings_changed", setting_id)
    if self:servo_friend_alive() then
        local pt = self:pt()
        if pt.loaded_extensions[self.servo_friend_unit] and table_size(pt.loaded_extensions[self.servo_friend_unit]) > 0 then
            for system, extension in pairs(pt.loaded_extensions[self.servo_friend_unit]) do
                if self:extension_valid(extension) and extension.on_settings_changed then
                    extension:on_settings_changed(setting_id)
                end
            end
        end
    end
end

PlayerUnitServoFriendExtension.update_extensions = function(self, dt, t)
    -- self:execute_extensions("update", dt, t)
    if self:servo_friend_alive() then
        local pt = self:pt()
        if pt.loaded_extensions[self.servo_friend_unit] and table_size(pt.loaded_extensions[self.servo_friend_unit]) > 0 then
            for system, extension in pairs(pt.loaded_extensions[self.servo_friend_unit]) do
                if self:extension_valid(extension) and extension.update then
                    extension:update(dt, t)
                end
            end
        end
    end
end

PlayerUnitServoFriendExtension.execute_extensions = function(self, function_name, ...)
    if self:servo_friend_alive() then
        local pt = self:pt()
        if pt.loaded_extensions[self.servo_friend_unit] and table_size(pt.loaded_extensions[self.servo_friend_unit]) > 0 then
            for system, extension in pairs(pt.loaded_extensions[self.servo_friend_unit]) do
                if self:extension_valid(extension) and type(extension[function_name]) == "function" then
                    return extension[function_name](extension, ...)
                end
            end
        end
    end
end

PlayerUnitServoFriendExtension.remove_extensions = function(self)
    if self:servo_friend_alive() then
        local pt = self:pt()
        if pt.loaded_extensions[self.servo_friend_unit] and table_size(pt.loaded_extensions[self.servo_friend_unit]) > 0 then
            for system, extension in pairs(pt.loaded_extensions[self.servo_friend_unit]) do
                mod:execute_extension(self.servo_friend_unit, system, "destroy")
                self:servo_friend_remove_extension(self.servo_friend_unit, system)
            end
            pt.loaded_extensions[self.servo_friend_unit] = nil
        end
    end
end

PlayerUnitServoFriendExtension.add_extensions = function(self)
    if self:servo_friend_alive() then
        local pt = self:pt()
        for extension_name, system_name in pairs(pt.systems) do
            if not self:servo_friend_extension(self.servo_friend_unit, system_name) then
                self:servo_friend_add_extension(self.servo_friend_unit, system_name, nil, {
                    player_unit = self.unit,
                    is_local_unit = self.is_local_unit,
                })
            end
        end
    end
end

PlayerUnitServoFriendExtension.servo_friend_alive = function(self)
    return self.servo_friend_unit and unit_alive(self.servo_friend_unit)
end

-- ##### ┌─┐┌─┐┌─┐┬ ┬┌┐┌ ##############################################################################################
-- ##### └─┐├─┘├─┤││││││ ##############################################################################################
-- ##### └─┘┴  ┴ ┴└┴┘┘└┘ ##############################################################################################

PlayerUnitServoFriendExtension.respawn_servo_friend = function(self, dt, t)
    self:destroy_servo_friend()
    self:spawn_servo_friend(dt, t)
end

PlayerUnitServoFriendExtension.spawn_servo_friend = function(self, dt, t)
    
    if self:is_initialized() and self:all_packages_loaded() and not self:servo_friend_alive() then

        self:print("Spawning servo friend")

        local player_position = self:player_position()
        local servo_friend_unit = servo_friend_units[self.appearance]
        local rotation = quaternion_identity()

        self.servo_friend_unit = world_spawn_unit_ex(self._world, servo_friend_unit, nil, player_position, rotation)

        -- Add extensions
        self:add_extensions()
        -- local pt = self:pt()
        -- for extension_name, system_name in pairs(pt.systems) do
        --     if not self:servo_friend_extension(self.servo_friend_unit, system_name) then
        --         self:servo_friend_add_extension(self.servo_friend_unit, system_name, nil, {
        --             player_unit = self.unit,
        --             is_local_unit = self.is_local_unit,
        --         })
        --     end
        -- end

        -- Settings changed
        self:extensions_settings_changed()

        -- Rotate decoder variants
        if self.appearance == "decoder" or self.appearance == "decoder_2" then
            unit_set_local_rotation(self.servo_friend_unit, 3, quaternion_from_euler_angles_xyz(0, 0, 90))
        end

        -- Position
        self.current_position:store(player_position)
        self:set_target_position(self:new_target_position())

        -- Talk
        managers.event:trigger("servo_friend_talk", dt, t, "spawned", self.servo_friend_unit, self.player_unit)

        -- Events
        managers.event:trigger("servo_friend_spawned", self.servo_friend_unit, self.player_unit)
    end

end

-- ##### ┌┬┐┌─┐┌─┐┌┬┐┬─┐┌─┐┬ ┬ ########################################################################################
-- #####  ││├┤ └─┐ │ ├┬┘│ │└┬┘ ########################################################################################
-- ##### ─┴┘└─┘└─┘ ┴ ┴└─└─┘ ┴  ########################################################################################

PlayerUnitServoFriendExtension.destroy_servo_friend = function(self)

    self:print("Destroying servo friend")

    if self:servo_friend_alive() then

        -- Events
        managers.event:trigger("servo_friend_destroyed", self.servo_friend_unit, self.player_unit)

        -- Remove extensions
        self:remove_extensions()
        
        -- Destroy servo friend unit
        world_destroy_unit(self._world, self.servo_friend_unit)

    end

    -- Reset variables
    self.servo_friend_unit = nil
    self.appearance_changed = nil

end

-- ##### ┌─┐┬  ┌─┐┬ ┬┌─┐┬─┐ ###########################################################################################
-- ##### ├─┘│  ├─┤└┬┘├┤ ├┬┘ ###########################################################################################
-- ##### ┴  ┴─┘┴ ┴ ┴ └─┘┴└─ ###########################################################################################

PlayerUnitServoFriendExtension.player_position = function(self)
    return unit_world_position(self.unit, 1)
end

PlayerUnitServoFriendExtension.player_rotation = function(self)
    return unit_local_rotation(self.first_person_unit, 1)
end

PlayerUnitServoFriendExtension.is_in_hub = function(self)
    return mod:is_in_hub()
end

PlayerUnitServoFriendExtension.is_crouching = function(self)
    return self.movement_state_component and self.movement_state_component.is_crouching
end

PlayerUnitServoFriendExtension.is_in_first_person = function(self)
    return self.first_person_extension and self.first_person_extension:is_in_first_person_mode()
end

PlayerUnitServoFriendExtension.is_blocking = function(self)
    return self.weapon_action_component and self.weapon_action_component.current_action_name == "action_block"
end

PlayerUnitServoFriendExtension.is_aiming = function(self)
	return (self.alternate_fire_component and self.alternate_fire_component.is_active) or (self.weapon_action_component and self.weapon_action_component.current_action_name == "action_charge")
end

PlayerUnitServoFriendExtension.is_venting = function(self)
    return self.weapon_action_component and self.weapon_action_component.current_action_name == "action_vent"
end

PlayerUnitServoFriendExtension.is_walking = function(self)
    return self.player_unit_locomotion_extension and self.player_unit_locomotion_extension:move_speed_squared() > 0.01 and not self:is_sprinting()
end

PlayerUnitServoFriendExtension.is_sprinting = function(self)
    local is_sprinting = self.sprint_character_state_component and self.sprint_character_state_component.is_sprinting
    return self.is_in_hub and self.hub_jog_character_state and self.hub_jog_character_state.move_state == SPRINT or is_sprinting
end

-- ##### ┬ ┬┌─┐┬─┐┬  ┌┬┐ ##############################################################################################
-- ##### ││││ │├┬┘│   ││ ##############################################################################################
-- ##### └┴┘└─┘┴└─┴─┘─┴┘ ##############################################################################################

PlayerUnitServoFriendExtension.world = function(self)
    return mod:world()
end

PlayerUnitServoFriendExtension.wwise_world = function(self)
    return mod:wwise_world()
end

PlayerUnitServoFriendExtension.physics_world = function(self)
    return mod:physics_world()
end

-- ##### ┌┬┐┌─┐┬  ┬┌─┐┌┬┐┌─┐┌┐┌┌┬┐ ####################################################################################
-- ##### ││││ │└┐┌┘├┤ │││├┤ │││ │  ####################################################################################
-- ##### ┴ ┴└─┘ └┘ └─┘┴ ┴└─┘┘└┘ ┴  ####################################################################################

PlayerUnitServoFriendExtension.new_target_position = function(self, position)
    local positioning_height = self:current_positioning_height()
    return (position or self:player_position()) + vector3(0, 0, positioning_height)
end

PlayerUnitServoFriendExtension.current_positioning_height = function(self)
    local crouch_multiplier = self:is_crouching() and .75 or 1
    local hub_multiplier = self:is_in_hub() and .75 or 1
    local base_height = self:is_in_first_person() and self.character_height * 1.5 or self.character_height * 2
    return (base_height * crouch_multiplier) * hub_multiplier
end

PlayerUnitServoFriendExtension.set_target_position = function(self, position)
    self.last_position:store(vector3_unbox(self.current_position))
    self.target_position:store(position)
end

PlayerUnitServoFriendExtension.movement_speed = function(self)
    return (self.found_something_valid and 4) or (self:is_sprinting() and 8) or (self:is_walking() and 6) or (self.is_aim_locked and 12) or 4
end

PlayerUnitServoFriendExtension.clamped_dt = function(self, dt, multiplier)
    return math_clamp(dt, 0, 1) * multiplier
end

PlayerUnitServoFriendExtension.update_movement = function(self, dt, t)
    -- Check servo friend unit
    if self:servo_friend_alive() then
        -- Data
        local aim_was_locked = self.is_aim_locked
        local is_aiming = self:is_aiming()
        self.is_aim_locked = false
        local block = self.self_focus_on_block and self:is_blocking()
        local vent = self.self_focus_on_vent and self:is_venting()
        local no_valid_or_aiming = not self.found_something_valid or is_aiming
        local locked_aiming_priority = self.locked_aiming_priority and is_aiming
        -- Check current interest
        if (not self.found_something_valid or locked_aiming_priority) and (is_aiming or locked_aiming_priority or block or vent) then
            -- Check if locked aiming is active
            if self.locked_aiming and is_aiming then
                -- Get first person extension rotation
                -- local rotation = self.first_person_extension:extrapolated_rotation()
                local rotation = unit_local_rotation(self.first_person_unit, 1)
                -- Get first person unit position
                local new_position = unit_world_position(self.first_person_unit, 1)
                -- Rotate offset position
                local mat = quaternion_matrix4x4(rotation)
                local rotated_pos = matrix4x4_transform(mat, vector3(.5, 1, .2))
                local final_pos = new_position + rotated_pos
                -- Set new target position
                self:set_target_position(final_pos)
                -- Lock aim
                self.is_aim_locked = true
                -- Lock aim sound
                if self.aim_sound and not aim_was_locked then
                    self:play_sound("selection")
                end
            elseif block or vent then
                self:set_target_position(self:player_position() + vector3(0, 0, self.character_height * 2))
            else
                -- Default movement
                self:set_target_position(self:new_target_position())
            end
        elseif not self.busy and not self.found_something_valid then
            -- Default movement
            self:set_target_position(self:new_target_position())
        end
        -- Unlock aim sound
        if self.aim_sound and not self.is_aim_locked and aim_was_locked then
            self:play_sound("wrong")
        end
        -- Update movement
        local current_position = self.current_position and vector3_unbox(self.current_position) or unit_local_position(self.servo_friend_unit, 1)
        local target_position = self.target_position and vector3_unbox(self.target_position) or vector3_zero()
        local movement_speed = self:movement_speed()
        local player_position = self:player_position()

        -- local new_position = vector3_lerp(current_position, target_position, dt * movement_speed)
        local new_position = vector3_lerp(current_position, target_position, self:clamped_dt(dt, movement_speed))
        local current_distance = vector3_distance(current_position, player_position)
        local target_distance = vector3_distance(current_position, target_position)
        local new_distance = vector3_distance(new_position, player_position)
        -- Impose roaming area restrictions
        if self.found_something_valid and self.use_roaming_area and current_distance > self.roaming_area then
            local dynamic_speed = movement_speed * ((current_distance / self.roaming_area) - 1)
            -- new_position = vector3_lerp(current_position, self:new_target_position(), dt * dynamic_speed)
            new_position = vector3_lerp(current_position, self:new_target_position(), self:clamped_dt(dt, dynamic_speed))
        else
            if self.found_something_valid and self.use_roaming_area and new_distance > self.roaming_area then
                -- new_position = current_position
                local dynamic_speed = movement_speed * ((current_distance / self.roaming_area) - 1)
                -- new_position = vector3_lerp(new_position, current_position, dt * dynamic_speed)
                new_position = vector3_lerp(new_position, current_position, self:clamped_dt(dt, dynamic_speed))
            else
                if self.use_roaming_area then
                    local dynamic_speed = movement_speed * ((current_distance / self.roaming_area) - 1)
                    -- new_position = vector3_lerp(new_position, current_position, dt * dynamic_speed)
                    new_position = vector3_lerp(new_position, current_position, self:clamped_dt(dt, dynamic_speed))
                else
                    local dynamic_speed = movement_speed * math_clamp(target_distance, 0, 1)
                    -- new_position = vector3_lerp(current_position, target_position, dt * dynamic_speed)
                    new_position = vector3_lerp(current_position, target_position, self:clamped_dt(dt, dynamic_speed))
                end
            end
        end
        -- Inject movement based leaning
        local current_rotation = unit_local_rotation(self.servo_friend_unit, 1)
        local currDir = vector3_normalize(quaternion_forward(current_rotation))
        local prevDir = self.prev_direction and vector3_unbox(self.prev_direction) or currDir
        self.prev_direction:store(currDir)
        local curveAxis = vector3_cross(prevDir, currDir)
        local angleBetween = math_acos(math_clamp(vector3_dot(prevDir, currDir), -1.0, 1.0))
        local turnDirection = math_sign(vector3_dot(curveAxis, vector3_up()))
        local new_lean = -turnDirection * math_clamp(angleBetween * 1500, 0, 45)
        -- self.lean = -turnDirection * math_clamp(angleBetween * 1000, 0, 45)
        -- self.lean = math_lerp(self.lean, new_lean, dt * self:rotation_speed())
        self.lean = math_lerp(self.lean, new_lean, self:clamped_dt(dt, self:rotation_speed()))
        -- new_position = new_position + vector3(0, 0, self.lean)
        -- Correct nan
        if new_position[1] ~= new_position[1] then
            new_position = player_position
        end
        -- Set current position
        self.current_position:store(new_position)
        -- Sync position
        managers.event:trigger("servo_friend_sync_current_position", self.current_position, self.servo_friend_unit, self.player_unit)
        -- Set new position
        if not self.disable_lean_altitude then
            new_position = new_position - vector3(0, 0, math_abs(self.lean) * 0.005)
        end
        unit_set_local_position(self.servo_friend_unit, 1, new_position)
        -- Recall when distance > max distance
        local player_distance = vector3_distance(player_position, current_position)
        if not self.use_roaming_area and player_distance > self.max_distance then
            -- managers.event:trigger("servo_friend_clear_current_point_of_interest")
            self:execute_extension(self.servo_friend_unit, "servo_friend_point_of_interest_system", "clear_current")
            self:set_target_position(self:new_target_position())
        end
    end
end

-- ##### ┌─┐┬┌┬┐ ######################################################################################################
-- ##### ├─┤││││ ######################################################################################################
-- ##### ┴ ┴┴┴ ┴ ######################################################################################################

PlayerUnitServoFriendExtension.aim_target = function(self, optional_offset, optional_unit, optional_length, optional_collision_filter)
    return mod:aim_target(optional_offset, optional_unit, optional_length, optional_collision_filter)
end

PlayerUnitServoFriendExtension.set_aim_position = function(self, position)
    self.aim_position:store(position)
end

PlayerUnitServoFriendExtension.rotation_speed = function(self)
    return self.is_aim_locked and 12 or 6
end

PlayerUnitServoFriendExtension.update_aim = function(self, dt, t)
    -- local pt = self:pt()
    -- Check servo friend unit
    if self:servo_friend_alive() then
        -- Data
        local player_position = self:new_target_position()
        local distance = vector3_distance(vector3_unbox(self.current_position), player_position)
        local locked_aiming_priority = self.locked_aiming_priority and self:is_aiming()
        local block = self.self_focus_on_block and self:is_blocking()
        local vent = self.self_focus_on_vent and self:is_venting()
        -- Check current interest
        if not locked_aiming_priority and self.found_something_valid and not (block or vent) then
            local found_position = vector3_unbox(self.aim_position)
            if found_position then
                -- Check distance
                local distance = vector3_distance(vector3_unbox(self.current_position), found_position)
                if distance < self.max_distance then --and self:do_ray_cast(tag_position) then
                    -- Set new target rotation
                    local direction = vector3_normalize(found_position - vector3_unbox(self.current_position))
                    local rotation = quaternion_look(direction)
                    self.target_rotation:store(rotation)
                else
                    -- Clear current interest
                    -- managers.event:trigger("servo_friend_clear_current_point_of_interest")
                    self:execute_extension(self.servo_friend_unit, "servo_friend_point_of_interest_system", "clear_current")
                end
            end
        elseif not locked_aiming_priority and distance > self.min_distance and not (block or vent) then
            -- Return to player
            local rotation = quaternion_look(player_position - vector3_unbox(self.current_position))
            self.target_rotation:store(rotation)
        elseif not locked_aiming_priority and (block or vent) then
            -- Block
            local direction = vector3_normalize(player_position - vector3_unbox(self.current_position))
            local rotation = quaternion_look(direction)
            self.target_rotation:store(rotation)
        elseif self.first_person_extension then
            -- Default rotation
            -- local rotation = self.first_person_extension:extrapolated_rotation()
            local rotation = unit_local_rotation(self.first_person_unit, 1)
            self.target_rotation:store(rotation)
        end
        -- Rotate towards aim target
        -- local current_rotation = unit_local_rotation(self.servo_friend_unit, 1)
        local current_rotation = self.current_rotation and quaternion_unbox(self.current_rotation) or unit_local_rotation(self.servo_friend_unit, 1)
        local target_rotation = self.target_rotation and quaternion_unbox(self.target_rotation) or quaternion_identity()
        -- local new_rotation = quaternion_lerp(current_rotation, target_rotation, dt * self:rotation_speed())
        local new_rotation = quaternion_lerp(current_rotation, target_rotation, self:clamped_dt(dt, self:rotation_speed()))
        -- Lean
        local lean_rotation = quaternion_from_euler_angles_xyz(0, self.lean, 0)
        -- Store current rotation without lean!
        self.current_rotation:store(new_rotation)
        -- Daemonhost
        if self.avoid_daemonhost then
            new_rotation = self:daemonhosts_change_aim(dt, t, new_rotation) or new_rotation
        end
        -- Set unit rotation with lean!
        unit_set_local_rotation(self.servo_friend_unit, 1, quaternion_multiply(new_rotation, lean_rotation))
    end
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

PlayerUnitServoFriendExtension.has_found_something_valid = function(self)
    return self.found_something_valid
end

PlayerUnitServoFriendExtension.is_point_in_cone = function(self, target_position, position, direction, depth, radius)
    return mod:is_point_in_cone(target_position, position, direction, depth, radius)
end

PlayerUnitServoFriendExtension.get_vectors_almost_same = function(self, v1, v2, tolerance)
    return mod:get_vectors_almost_same(v1, v2, tolerance)
end

PlayerUnitServoFriendExtension.is_in_line_of_sight = function(self, from, to)
    return mod:is_in_line_of_sight(from, to)
end

-- ##### ┌┬┐┌─┐┌─┐┌┬┐┌─┐┌┐┌┬ ┬┌─┐┌─┐┌┬┐ ###############################################################################
-- #####  ││├─┤├┤ ││││ ││││├─┤│ │└─┐ │  ###############################################################################
-- ##### ─┴┘┴ ┴└─┘┴ ┴└─┘┘└┘┴ ┴└─┘└─┘ ┴  ###############################################################################

PlayerUnitServoFriendExtension.check_for_daemonhosts = function(self, dt, t)
    local side_system = managers.state.extension:system("side_system")
    local side = side_system:get_side_from_name("villains")
    local allies = side:alive_units_by_tag("allied", "witch")

    local side_system = managers.state.extension:system("side_system")
    local side = side_system:get_side_from_name("heroes")
    local enemies = side:alive_units_by_tag("enemy", "witch")

    if #allies ~= #enemies then
        self:print("different daemonhost counts")
    end

    if #allies > #enemies then
        self.daemonhosts = allies
    else
        self.daemonhosts = enemies
    end
end

PlayerUnitServoFriendExtension.daemonhosts_change_aim = function(self, dt, t, new_rotation, aim_target)
    -- local pt = self:pt()

    local was_in_cone = self.is_in_cone

    local from = unit_local_position(self.servo_friend_unit, 1)
    local direction = quaternion_forward(new_rotation)

    -- local daemonhost_units = self:daemonhosts(dt, t)
    if self.daemonhosts and #self.daemonhosts > 0 then

        for _, daemonhost_unit in pairs(self.daemonhosts) do
        -- for i = #self.daemonhosts, 1, -1 do
            if daemonhost_unit and unit_alive(daemonhost_unit) then
                local from = unit_local_position(self.servo_friend_unit, 1)
                local daemonhost_position = unit_local_position(daemonhost_unit, 1)
                local daemonhost_los = self:is_in_line_of_sight(from, daemonhost_position)

                self.is_in_cone = self:is_point_in_cone(daemonhost_position, from, direction, 15, 10)

                if self.is_in_cone and daemonhost_los then

                    if not was_in_cone then
                        managers.event:trigger("servo_friend_overwrite_color", 1, 0, 0, self.servo_friend_unit, self.player_unit)
                        managers.event:trigger("servo_friend_overwrite_volumetric_intensity", 3, self.servo_friend_unit, self.player_unit)
                        managers.event:trigger("servo_friend_talk", dt, t, "avoid_daemonhost", self.servo_friend_unit, self.player_unit)
                    end

                    local player_position = unit_local_position(self.player_unit, 1)
                    local vector_to_position = vector3_normalize(daemonhost_position - player_position)
                    local avoid_position = daemonhost_position - vector_to_position * 10
                    -- local avoid_position = from - vector3(0, 0, 1) + vector_to_position

                    local current_avoid_daemonhost_position = self.avoid_daemonhost_position and vector3_unbox(self.avoid_daemonhost_position) or vector3_zero()
                    -- local lerp_position = vector3_lerp(current_avoid_daemonhost_position, avoid_position, dt * self:rotation_speed())
                    local lerp_position = vector3_lerp(current_avoid_daemonhost_position, avoid_position, self:clamped_dt(dt, self:rotation_speed()))
                    self.avoid_daemonhost_position:store(lerp_position)

                    local new_direction = vector3_normalize(lerp_position - from)
                    local new_rotation = quaternion_look(new_direction)
                    return new_rotation
                end
            end
        end
    end

    self.is_in_cone = false

    if was_in_cone then
        managers.event:trigger("servo_friend_reset_color", self.servo_friend_unit, self.player_unit)
        managers.event:trigger("servo_friend_overwrite_volumetric_intensity", self.servo_friend_unit, self.player_unit)
    end

    local _, hit_position, _, _, hit_actor = physics_world_raycast(self._physics_world, from, direction, 1000,
        "closest", "types", "both", "collision_filter", "filter_minion_line_of_sight_check")

    if hit_position and not self:get_vectors_almost_same(self.avoid_daemonhost_position, vector3_zero(), .1) then

        local current_avoid_daemonhost_position = self.avoid_daemonhost_position and vector3_unbox(self.avoid_daemonhost_position)
        -- local lerp_position = vector3_lerp(current_avoid_daemonhost_position, hit_position, dt * self:rotation_speed())
        local lerp_position = vector3_lerp(current_avoid_daemonhost_position, hit_position, self:clamped_dt(dt, self:rotation_speed()))
        self.avoid_daemonhost_position:store(lerp_position)

        local new_direction = vector3_normalize(lerp_position - from)
        -- local new_rotation = quaternion_lerp(new_rotation, quaternion_look(new_direction), dt * self:rotation_speed())
        local new_rotation = quaternion_lerp(new_rotation, quaternion_look(new_direction), self:clamped_dt(dt, self:rotation_speed()))

        return new_rotation
    else
        self.avoid_daemonhost_position:store(vector3_zero())
    end

end

-- ##### ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ######################################################
-- ##### └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ └┐┌┘├┤ │││ │ └─┐ ######################################################
-- ##### └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘ └┘ └─┘┘└┘ ┴ └─┘ ######################################################

PlayerUnitServoFriendExtension.random_option = function(self, values)
    return mod:random_option(values)
end

PlayerUnitServoFriendExtension.on_settings_changed = function(self, setting_id)
    -- Settings
    self.flashlight         = mod:get("mod_option_flashlight")
    self.flashlight_shadows = mod:get("mod_option_flashlight_shadows")
    self.flashlight_no_hub  = mod:get("mod_option_flashlight_no_hub")
    self.flashlight_type    = mod:get("mod_option_flashlight_type")
    self.r                  = mod:get("mod_option_flashlight_color_red")
    self.g                  = mod:get("mod_option_flashlight_color_green")
    self.b                  = mod:get("mod_option_flashlight_color_blue")

    if not self.is_local_unit then
        self.flashlight        = self:random_option({"always_on", "only_dark_missions", "off"})
        self.flashlight_no_hub = true
        self.flashlight_type   = self:random_option({"small", "large"})
        self.r                 = math_random(.5, 1)
        self.g                 = math_random(.5, 1)
        self.b                 = math_random(.5, 1)
    end

    self.focus_tagged_enemies = mod:get("mod_option_focus_tagged_enemies")
    self.focus_tagged_items   = mod:get("mod_option_focus_tagged_items")
    self.focus_world_markers  = mod:get("mod_option_focus_world_markers")
    self.only_own_tags        = mod:get("mod_option_only_own_tags")

    if not self.is_local_unit then
        self.focus_tagged_enemies = math_random(0, 1) > 0.5
        self.focus_tagged_items   = math_random(0, 1) > 0.5
        self.focus_world_markers  = math_random(0, 1) > 0.5
        self.only_own_tags        = math_random(0, 1) > 0.5
    end

    self.use_free_roaming = mod:get("mod_option_use_free_roaming")

    if not self.is_local_unit then
        self.use_free_roaming = math_random(0, 1) > 0.5
    end

    self.locked_aiming          = mod:get("mod_option_locked_aiming")
    self.locked_aiming_priority = mod:get("mod_option_locked_aiming_priority")
    self.aim_sound              = mod:get("mod_option_aim_sound")
    self.self_focus_on_block    = mod:get("mod_option_focus_self_on_block")
    self.self_focus_on_vent     = mod:get("mod_option_focus_self_on_vent")
    self.appearance             = mod:get("mod_option_appearance")
    self.debug                  = mod:get("mod_option_debug")
    self.use_roaming_area       = mod:get("mod_option_use_roaming_area")
    self.roaming_area           = mod:get("mod_option_roaming_area")

    self.hover_particle_effect  = mod:get("mod_option_hover_particle_effect")
    self.hover_sound_effect     = mod:get("mod_option_hover_sound_effect")

    if not self.is_local_unit then
        self.locked_aiming          = math_random(0, 1) > 0.5
        self.locked_aiming_priority = math_random(0, 1) > 0.5
        self.aim_sound              = math_random(0, 1) > 0.5
        self.self_focus_on_block    = math_random(0, 1) > 0.5
        self.self_focus_on_vent     = math_random(0, 1) > 0.5
        self.appearance             = self:random_option({"spineless", "dominant", "decoder", "decoder_2"})
        self.use_roaming_area       = math_random(0, 1) > 0.5
        self.roaming_area           = math_random(5, 20)
    end

    self.avoid_daemonhost       = mod:get("mod_option_avoid_daemonhost")
    self.avoid_going_into_walls = mod:get("mod_option_avoid_going_into_walls")

    self.alert_mode = mod:get("mod_option_alert_mode")
    self.alert_mode_lights = mod:get("mod_option_alert_mode_lights")
    self.alert_mode_sound = mod:get("mod_option_alert_mode_sound")
    self.alert_mode_only_when_idle = mod:get("mod_option_alert_mode_only_when_idle")

    if not self.is_local_unit then
        self.alert_mode_lights = math_random(0, 1) > 0.5
        self.alert_mode_only_when_idle = math_random(0, 1) > 0.5
    end

    -- Respawn servo friend when appearance is changed
    if self.is_local_unit and setting_id == "mod_option_appearance" then
        self.appearance_changed = true
    end

    if setting_id == "mod_option_hover_particle_effect" then
        self.appearance_changed = true
    end

    -- Reset
    self.busy = false

    -- Relay to extensions
    self:extensions_settings_changed(setting_id)
end

PlayerUnitServoFriendExtension.on_servo_friend_set_target_position = function(self, target_position, aim_position, something_valid, busy, disable_lean_altitude)
    self.found_something_valid = something_valid
    self.busy = busy
    self.disable_lean_altitude = disable_lean_altitude or false
    if target_position then self:set_target_position(target_position) end
    if aim_position then self:set_aim_position(aim_position) end
end

-- ##### ┌─┐┌─┐┬ ┬┌┐┌┌┬┐┌─┐ ###########################################################################################
-- ##### └─┐│ ││ ││││ ││└─┐ ###########################################################################################
-- ##### └─┘└─┘└─┘┘└┘─┴┘└─┘ ###########################################################################################

PlayerUnitServoFriendExtension.play_sound = function(self, sound_event, optional_source_id, position)
    return mod:play_sound(sound_event, optional_source_id, position)
end

-- ##### ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌┌─┐ ############################################
-- ##### └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││└─┐ ############################################
-- ##### └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘└─┘ ############################################

PlayerUnitServoFriendExtension.servo_friend_extension = function(self, unit, system_or_extension)
    return mod:servo_friend_extension(unit, system_or_extension)
end

PlayerUnitServoFriendExtension.servo_friend_add_extension = function(self, unit, system, extension_init_context, extension_init_data)
    return mod:servo_friend_add_extension(unit, system, extension_init_context, extension_init_data)
end

PlayerUnitServoFriendExtension.servo_friend_remove_extension = function(self, unit, system)
    return mod:servo_friend_remove_extension(unit, system)
end

-- ##### ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌┌─┐ ################################################################################
-- ##### ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││└─┐ ################################################################################
-- ##### └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘└─┘ ################################################################################

PlayerUnitServoFriendExtension.extension_valid = function(self, extension)
    return mod:extension_valid(extension)
end

PlayerUnitServoFriendExtension.add_extension = function(self, unit, system, extension_init_context, extension_init_data)
    return mod:add_extension(unit, system, extension_init_context, extension_init_data)
end

PlayerUnitServoFriendExtension.remove_extension = function(self, unit, system)
    return mod:remove_extension(unit, system)
end

PlayerUnitServoFriendExtension.execute_extension = function(self, unit, system, function_name, ...)
    return mod:execute_extension(unit, system, function_name, ...)
end

-- ##### ┌┬┐┬┌┬┐┌─┐ ###################################################################################################
-- #####  │ ││││├┤  ###################################################################################################
-- #####  ┴ ┴┴ ┴└─┘ ###################################################################################################

PlayerUnitServoFriendExtension.time = function(self)
    return mod:game_time() or mod:main_time()
end

PlayerUnitServoFriendExtension.delta_time = function(self)
    return mod:game_delta_time() or mod:main_delta_time()
end

-- ##### ┬ ┬┌─┐┌─┐┬┌─┌─┐ ##############################################################################################
-- ##### ├─┤│ ││ │├┴┐└─┐ ##############################################################################################
-- ##### ┴ ┴└─┘└─┘┴ ┴└─┘ ##############################################################################################

mod:hook(CLASS.PlayerHuskFirstPersonExtension, "extensions_ready", function(func, self, world, unit, ...)
    -- Original function
    func(self, world, unit, ...)
    -- Player spawned
    mod:initialize_player_unit(self)
end)

mod:hook(CLASS.PlayerHuskFirstPersonExtension, "destroy", function(func, self, ...)
    -- Player destroyed
    mod:destroy_player_unit(self._unit)
    -- Original function
    func(self, ...)
end)

mod:hook(CLASS.PlayerHuskFirstPersonExtension, "update", function(func, self, unit, dt, t, ...)
    -- Original function
    func(self, unit, dt, t, ...)
    -- Update player
    mod:update_player_unit(self, dt, t)
end)

mod:hook(CLASS.PlayerUnitFirstPersonExtension, "extensions_ready", function(func, self, world, unit, ...)
    -- Original function
    func(self, world, unit, ...)
    -- Player spawned
    mod:initialize_player_unit(self)
end)

mod:hook(CLASS.PlayerUnitFirstPersonExtension, "destroy", function(func, self, ...)
    -- Player destroyed
    mod:destroy_player_unit(self._unit)
    -- Original function
    func(self, ...)
end)

mod:hook(CLASS.PlayerUnitFirstPersonExtension, "update", function(func, self, unit, dt, t, ...)
    -- Original function
    func(self, unit, dt, t, ...)
    -- Update player
    mod:update_player_unit(self, dt, t)
end)

return PlayerUnitServoFriendExtension