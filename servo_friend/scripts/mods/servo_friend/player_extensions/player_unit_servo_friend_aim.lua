-- File: servo_friend/scripts/mods/servo_friend/player_extensions/player_unit_servo_friend_aim.lua
local mod = get_mod("servo_friend")

local unit = Unit
local vector3 = Vector3
local managers = Managers
local quaternion = Quaternion
local vector3_zero = vector3.zero
local vector3_lerp = vector3.lerp
local vector3_unbox = Vector3Box.unbox
local vector3_distance = vector3.distance
local vector3_normalize = vector3.normalize
local quaternion_look = quaternion.look
local quaternion_lerp = quaternion.lerp
local quaternion_unbox = QuaternionBox.unbox
local quaternion_forward = quaternion.forward
local quaternion_identity = quaternion.identity
local quaternion_multiply = quaternion.multiply
local quaternion_from_euler_angles_xyz = quaternion.from_euler_angles_xyz
local unit_local_rotation = unit.local_rotation
local unit_set_local_rotation = unit.set_local_rotation
local unit_local_position = unit.local_position
local physics_world_raycast = PhysicsWorld.raycast

return function(Extension)
    -- ##### ┌─┐┬┌┬┐ ######################################################################################################
    -- ##### ├─┤││││ ######################################################################################################
    -- ##### ┴ ┴┴┴ ┴ ######################################################################################################

    Extension.aim_target = function(self, optional_offset, optional_unit, optional_length, optional_collision_filter)
        return mod:aim_target(optional_offset, optional_unit, optional_length, optional_collision_filter)
    end

    Extension.set_aim_position = function(self, position)
        self.aim_position:store(position)
    end

    Extension.rotation_speed = function(self)
        return self.is_aim_locked and 12 or 6
    end

    Extension.update_aim = function(self, dt, t)
        if self:servo_friend_alive() then
            local player_position = self:new_target_position()
            local distance = vector3_distance(vector3_unbox(self.current_position), player_position)
            local locked_aiming_priority = self.locked_aiming_priority and self:is_aiming()
            local block = self.self_focus_on_block and self:is_blocking()
            local vent = self.self_focus_on_vent and self:is_venting()

            if not locked_aiming_priority and self.found_something_valid and not (block or vent) then
                local found_position = vector3_unbox(self.aim_position)
                if found_position then
                    local distance = vector3_distance(vector3_unbox(self.current_position), found_position)
                    if distance < self.max_distance then
                        local direction = vector3_normalize(found_position - vector3_unbox(self.current_position))
                        local rotation = quaternion_look(direction)
                        self.target_rotation:store(rotation)
                    else
                        self:execute_extension(self.servo_friend_unit, "servo_friend_point_of_interest_system",
                            "clear_current")
                    end
                end
            elseif not locked_aiming_priority and distance > self.min_distance and not (block or vent) then
                local rotation = quaternion_look(player_position - vector3_unbox(self.current_position))
                self.target_rotation:store(rotation)
            elseif not locked_aiming_priority and (block or vent) then
                local direction = vector3_normalize(player_position - vector3_unbox(self.current_position))
                local rotation = quaternion_look(direction)
                self.target_rotation:store(rotation)
            elseif self.first_person_extension then
                local rotation = unit_local_rotation(self.first_person_unit, 1)
                self.target_rotation:store(rotation)
            end

            local current_rotation = self.current_rotation and quaternion_unbox(self.current_rotation) or
                unit_local_rotation(self.servo_friend_unit, 1)
            local target_rotation = self.target_rotation and quaternion_unbox(self.target_rotation) or
                quaternion_identity()
            local new_rotation = quaternion_lerp(current_rotation, target_rotation,
                self:clamped_dt(dt, self:rotation_speed()))

            if vector3.dot(quaternion_forward(current_rotation), quaternion_forward(new_rotation)) > 0.99999 then
                new_rotation = current_rotation
            end

            local lean_rotation = quaternion_from_euler_angles_xyz(0, self.lean, 0)
            self.current_rotation:store(new_rotation)

            if self.avoid_daemonhost then
                new_rotation = self:daemonhosts_change_aim(dt, t, new_rotation) or new_rotation
            end

            local disable_lean = self:is_nuncio_aquila() and self.found_something_valid

            if disable_lean then
                unit_set_local_rotation(self.servo_friend_unit, 1, new_rotation)
            else
                unit_set_local_rotation(self.servo_friend_unit, 1, quaternion_multiply(new_rotation, lean_rotation))
            end
        end
    end

    Extension.is_point_in_cone = function(self, target_position, position, direction, depth, radius)
        return mod:is_point_in_cone(target_position, position, direction, depth, radius)
    end

    Extension.get_vectors_almost_same = function(self, v1, v2, tolerance)
        return mod:get_vectors_almost_same(v1, v2, tolerance)
    end

    Extension.is_in_line_of_sight = function(self, from, to)
        return mod:is_in_line_of_sight(from, to)
    end

    Extension.filter_daemonhost_units = function(self, units)
        local filtered_units = {}
        if units then
            for i = 1, #units do
                local listed_unit = units[i]
                if self:is_unit_alive(listed_unit) then
                    filtered_units[#filtered_units + 1] = listed_unit
                end
            end
        end
        return filtered_units
    end

    -- ##### ┌┬┐┌─┐┌─┐┌┬┐┌─┐┌┐┌┬ ┬┌─┐┌─┐┌┬┐ ###############################################################################
    -- #####  ││├─┤├┤ ││││ ││││├─┤│ │└─┐ │  ###############################################################################
    -- ##### ─┴┘┴ ┴└─┘┴ ┴└─┘┘└┘┴ ┴└─┘└─┘ ┴  ###############################################################################

    Extension.check_for_daemonhosts = function(self, dt, t)
        local side_system = managers.state.extension:system("side_system")

        local villains_side = side_system:get_side_from_name("villains")
        local allies = self:filter_daemonhost_units(villains_side:alive_units_by_tag("allied", "witch"))

        local heroes_side = side_system:get_side_from_name("heroes")
        local enemies = self:filter_daemonhost_units(heroes_side:alive_units_by_tag("enemy", "witch"))

        if #allies ~= #enemies then
            self:print("different daemonhost counts")
        end

        if #allies > #enemies then
            self.daemonhosts = allies
        else
            self.daemonhosts = enemies
        end
    end

    Extension.daemonhosts_change_aim = function(self, dt, t, new_rotation, aim_target)
        local was_in_cone = self.is_in_cone

        local from = unit_local_position(self.servo_friend_unit, 1)
        local direction = quaternion_forward(new_rotation)

        if self.daemonhosts and #self.daemonhosts > 0 then
            for i = 1, #self.daemonhosts do
                local daemonhost_unit = self.daemonhosts[i]

                if self:is_unit_alive(daemonhost_unit) then
                    local from = unit_local_position(self.servo_friend_unit, 1)
                    local daemonhost_position = unit_local_position(daemonhost_unit, 1)
                    local daemonhost_los = self:is_in_line_of_sight(from, daemonhost_position)

                    self.is_in_cone = self:is_point_in_cone(daemonhost_position, from, direction, 15, 10)

                    if self.is_in_cone and daemonhost_los then
                        if not was_in_cone then
                            managers.event:trigger("servo_friend_overwrite_color", 1, 0, 0, self.servo_friend_unit,
                                self.player_unit)
                            managers.event:trigger("servo_friend_overwrite_volumetric_intensity", 3,
                                self.servo_friend_unit,
                                self.player_unit)
                            managers.event:trigger("servo_friend_talk", dt, t, "avoid_daemonhost", self
                                .servo_friend_unit,
                                self.player_unit)
                        end

                        local player_position = unit_local_position(self.player_unit, 1)
                        local vector_to_position = vector3_normalize(daemonhost_position - player_position)
                        local avoid_position = daemonhost_position - vector_to_position * 10

                        local current_avoid_daemonhost_position = self.avoid_daemonhost_position and
                            vector3_unbox(self.avoid_daemonhost_position) or vector3_zero()
                        local lerp_position = vector3_lerp(current_avoid_daemonhost_position, avoid_position,
                            self:clamped_dt(dt, self:rotation_speed()))
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
            managers.event:trigger("servo_friend_overwrite_volumetric_intensity", self.servo_friend_unit,
                self.player_unit)
        end

        if self.found_something_valid then
            self.avoid_daemonhost_position:store(vector3_zero())
            return new_rotation
        end

        local _, hit_position, _, _, hit_actor = physics_world_raycast(self._physics_world, from, direction, 1000,
            "closest", "types", "both", "collision_filter", "filter_minion_line_of_sight_check")

        if hit_position and not self:get_vectors_almost_same(self.avoid_daemonhost_position, vector3_zero(), .1) then
            local current_avoid_daemonhost_position = self.avoid_daemonhost_position and
                vector3_unbox(self.avoid_daemonhost_position)
            local lerp_position = vector3_lerp(current_avoid_daemonhost_position, hit_position,
                self:clamped_dt(dt, self:rotation_speed()))
            self.avoid_daemonhost_position:store(lerp_position)

            local new_direction = vector3_normalize(lerp_position - from)
            local new_rotation = quaternion_lerp(new_rotation, quaternion_look(new_direction),
                self:clamped_dt(dt, self:rotation_speed()))

            return new_rotation
        else
            self.avoid_daemonhost_position:store(vector3_zero())
        end
    end
end
