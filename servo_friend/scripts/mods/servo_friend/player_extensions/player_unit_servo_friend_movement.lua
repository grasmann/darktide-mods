-- File: servo_friend/scripts/mods/servo_friend/player_extensions/player_unit_servo_friend_movement.lua
local mod = get_mod("servo_friend")

local math = math
local unit = Unit
local vector3 = Vector3
local managers = Managers
local math_abs = math.abs
local math_max = math.max
local math_sign = math.sign
local math_lerp = math.lerp
local math_acos = math.acos
local math_clamp = math.clamp
local vector3_up = vector3.up
local vector3_dot = vector3.dot
local vector3_zero = vector3.zero
local vector3_lerp = vector3.lerp
local vector3_cross = vector3.cross
local vector3_unbox = Vector3Box.unbox
local vector3_distance = vector3.distance
local vector3_normalize = vector3.normalize
local unit_local_position = unit.local_position
local unit_set_local_position = unit.set_local_position
local quaternion_unbox = QuaternionBox.unbox
local quaternion_forward = Quaternion.forward
local quaternion_matrix4x4 = Quaternion.matrix4x4
local matrix4x4_transform = Matrix4x4.transform

return function(Extension)
    -- ##### ┌┬┐┌─┐┬  ┬┌─┐┌┬┐┌─┐┌┐┌┌┬┐ ####################################################################################
    -- ##### ││││ │└┐┌┘├┤ │││├┤ │││ │  ####################################################################################
    -- ##### ┴ ┴└─┘ └┘ └─┘┴ ┴└─┘┘└┘ ┴  ####################################################################################

    Extension.new_target_position = function(self, position)
        local positioning_height = self:current_positioning_height()
        return (position or self:player_position()) + vector3(0, 0, positioning_height)
    end

    Extension.current_positioning_height = function(self)
        local crouch_multiplier = self:is_crouching() and .75 or 1
        local hub_multiplier = self:is_in_hub() and .75 or 1
        local base_height = self:is_in_first_person() and self.character_height * 1.5 or self.character_height * 2
        return (base_height * crouch_multiplier) * hub_multiplier
    end

    Extension.set_target_position = function(self, position)
        self.last_position:store(vector3_unbox(self.current_position))
        self.target_position:store(position)
    end

    Extension.movement_speed = function(self)
        return (self.found_something_valid and 4) or (self:is_sprinting() and 8) or (self:is_walking() and 6) or
            (self.is_aim_locked and 12) or 4
    end

    Extension.update_movement = function(self, dt, t)
        -- Check servo_friend unit
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
                    local rotation = unit.local_rotation(self.first_person_unit, 1)
                    -- Get first person unit position
                    local new_position = unit.world_position(self.first_person_unit, 1)
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
            local current_position = self.current_position and vector3_unbox(self.current_position) or
                unit_local_position(self.servo_friend_unit, 1)
            local target_position = self.target_position and vector3_unbox(self.target_position) or vector3_zero()
            local movement_speed = self:movement_speed()
            local player_position = self:player_position()

            local new_position = vector3_lerp(current_position, target_position, self:clamped_dt(dt, movement_speed))
            local current_distance = vector3_distance(current_position, player_position)
            local target_distance = vector3_distance(current_position, target_position)
            local new_distance = vector3_distance(new_position, player_position)

            -- Impose roaming area restrictions
            if self.found_something_valid and self.use_roaming_area and current_distance > self.roaming_area then
                local dynamic_speed = movement_speed * math_max(0, (current_distance / self.roaming_area) - 1)
                new_position = vector3_lerp(current_position, self:new_target_position(),
                    self:clamped_dt(dt, dynamic_speed))
            else
                if self.found_something_valid and self.use_roaming_area and new_distance > self.roaming_area then
                    local dynamic_speed = movement_speed * math_max(0, (current_distance / self.roaming_area) - 1)
                    new_position = vector3_lerp(new_position, current_position, self:clamped_dt(dt, dynamic_speed))
                else
                    if self.use_roaming_area then
                        local dynamic_speed = movement_speed * math_max(0, (current_distance / self.roaming_area) - 1)
                        new_position = vector3_lerp(new_position, current_position, self:clamped_dt(dt, dynamic_speed))
                    else
                        local dynamic_speed = movement_speed * math_clamp(target_distance, 0, 1)
                        new_position = vector3_lerp(current_position, target_position, self:clamped_dt(dt, dynamic_speed))
                    end
                end
            end

            -- Inject movement based leaning
            local current_rotation = self.current_rotation and quaternion_unbox(self.current_rotation) or
                unit.local_rotation(self.servo_friend_unit, 1)

            local disable_lean = self:is_nuncio_aquila() and self.found_something_valid

            if disable_lean or dt > 0.1 then
                self.lean = 0
                if dt > 0.1 then
                    self.prev_direction:store(vector3_normalize(quaternion_forward(current_rotation)))
                end
            else
                local currDir = vector3_normalize(quaternion_forward(current_rotation))
                local prevDir = self.prev_direction and vector3_unbox(self.prev_direction) or currDir
                self.prev_direction:store(currDir)
                local curveAxis = vector3_cross(prevDir, currDir)
                local angleBetween = math_acos(math_clamp(vector3_dot(prevDir, currDir), -1.0, 1.0))

                local new_lean = 0
                if angleBetween > 0.005 and angleBetween < 0.5 then
                    local turnDirection = math_sign(vector3_dot(curveAxis, vector3_up()))
                    new_lean = -turnDirection * math_clamp((angleBetween - 0.005) * 1500, 0, 45)
                end

                self.lean = math_lerp(self.lean, new_lean, self:clamped_dt(dt, self:rotation_speed()))
            end

            -- Correct nan
            if new_position[1] ~= new_position[1] then
                new_position = player_position
            end
            -- Set current position
            self.current_position:store(new_position)
            -- Sync position
            managers.event:trigger("servo_friend_sync_current_position", self.current_position, self.servo_friend_unit,
                self.player_unit)
            -- Set new position
            if not self.disable_lean_altitude and not disable_lean then
                new_position = new_position - vector3(0, 0, math_abs(self.lean) * 0.005)
            end

            -- Kill Physics Micro-Jitter
            local actual_current_pos = unit_local_position(self.servo_friend_unit, 1)
            if vector3_distance(actual_current_pos, new_position) < 0.001 then
                new_position = actual_current_pos
            end

            unit_set_local_position(self.servo_friend_unit, 1, new_position)

            -- Recall when distance > max distance
            local player_distance = vector3_distance(player_position, current_position)
            if not self.use_roaming_area and player_distance > self.max_distance then
                self:execute_extension(self.servo_friend_unit, "servo_friend_point_of_interest_system", "clear_current")
                self:set_target_position(self:new_target_position())
            end
        end
    end
end
