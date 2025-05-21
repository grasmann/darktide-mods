local mod = get_mod("servo_friend")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local unit = Unit
local math = math
local table = table
local CLASS = CLASS
local class = class
local pairs = pairs
local vector3 = Vector3
local tostring = tostring
local managers = Managers
local math_max = math.max
local math_huge = math.huge
local unit_alive = unit.alive
local vector3_box = Vector3Box
local table_clear = table.clear
local math_random = math.random
local table_remove = table.remove
local physics_world = PhysicsWorld
local vector3_unbox = vector3_box.unbox
local vector3_distance = vector3.distance
local vector3_normalize = vector3.normalize
local unit_world_position = unit.world_position
local physics_world_raycast = physics_world.raycast

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local ServoFriendPointOfInterestExtension = class("ServoFriendPointOfInterestExtension", "ServoFriendBaseExtension")

mod:register_extension("ServoFriendPointOfInterestExtension", "servo_friend_point_of_interest_system")

-- ##### ┬┌┐┌┬┌┬┐       ┌┬┐┌─┐┌─┐┌┬┐┬─┐┌─┐┬ ┬ #########################################################################
-- ##### │││││ │   ───   ││├┤ └─┐ │ ├┬┘│ │└┬┘ #########################################################################
-- ##### ┴┘└┘┴ ┴        ─┴┘└─┘└─┘ ┴ ┴└─└─┘ ┴  #########################################################################

ServoFriendPointOfInterestExtension.init = function(self, extension_init_context, unit, extension_init_data)
    -- Base class
    ServoFriendPointOfInterestExtension.super.init(self, extension_init_context, unit, extension_init_data)
    -- Initialize
    self.points = {}
    self.closest = {
        object = nil,
        type = nil,
    }
    self.previous = nil
    self.valid = false
    -- Events
    -- managers.event:register(self, "servo_friend_point_of_interest_created", "add")
    managers.event:register(self, "servo_friend_point_of_interest_removed", "remove")
    -- managers.event:register(self, "servo_friend_spawned", "on_servo_friend_spawned")
    -- managers.event:register(self, "servo_friend_destroyed", "on_servo_friend_destroyed")
    managers.event:register(self, "servo_friend_clear_current_point_of_interest", "on_servo_friend_clear_current_point_of_interest")
    managers.event:register(self, "servo_friend_clear_points_of_interest", "on_servo_friend_clear_points_of_interest")
    -- Settings
    self:on_settings_changed()
    -- Debug
    self:print("ServoFriendPointOfInterestExtension initialized")
end

ServoFriendPointOfInterestExtension.destroy = function(self)
    -- Events
    -- managers.event:unregister(self, "servo_friend_point_of_interest_created")
    managers.event:unregister(self, "servo_friend_point_of_interest_removed")
    -- managers.event:unregister(self, "servo_friend_spawned")
    -- managers.event:unregister(self, "servo_friend_destroyed")
    managers.event:unregister(self, "servo_friend_clear_current_point_of_interest")
    managers.event:unregister(self, "servo_friend_clear_points_of_interest")
    -- Debug
    self:print("ServoFriendPointOfInterestExtension destroyed")
    -- Base class
    ServoFriendPointOfInterestExtension.super.destroy(self)
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

ServoFriendPointOfInterestExtension.update = function(self, dt, t)
    -- Base class
    ServoFriendPointOfInterestExtension.super.update(self, dt, t)
    if self:is_initialized() then
        -- Update
        local closest = math_huge
        local was_valid = self.valid
        self.valid = false
        local target_position = vector3_unbox(self.current_position)
        local found_position = nil
        local found_object = nil
        local found_type = nil
        local player_position = self:player_position()
        local current_position = vector3_unbox(self.current_position)
        -- Find new point of interest
        for object, interest_type in pairs(self.points) do
            if not object.__deleted then
                -- Point of interest is tag
                local is_enemy = interest_type == "tag_enemy"
                local is_item = interest_type == "tag"
                if is_item or is_enemy then
                    -- Check enemy or item
                    local enemy = is_enemy and self.focus_tagged_enemies
                    local item = is_item and self.focus_tagged_items
                    if enemy or item then
                        -- Check tagged unit
                        local tag_unit = object:target_unit()
                        if tag_unit and unit_alive(tag_unit) then
                            -- Get positions
                            local tag_position = unit_world_position(tag_unit, 1)
                            -- If enemy add offset
                            local enemy_height = self:enemy_height(object)
                            if enemy then tag_position = tag_position + vector3(0, 0, enemy_height) end
                            found_position = tag_position
                        end
                    end
                elseif interest_type == "marker" then
                    if object.world_position then
                        local position = vector3_unbox(object.world_position)
                        found_position = position
                    end
                end
                -- Check found position
                local position_los = self:is_in_line_of_sight(current_position, found_position)
                local player_los = self:is_in_line_of_sight(current_position, player_position)
                if found_position and position_los and player_los then
                    -- Check maximum distance
                    local distance = vector3_distance(current_position, found_position)
                    local player_distance = vector3_distance(player_position, found_position)
                    local no_recall = self.use_roaming_area or player_distance < self.max_distance
                    if distance < self.max_distance and no_recall then --and self:do_ray_cast(tag_position) then
                        if distance < closest then
                            closest = distance
                            self.valid = true
                            -- Check minimum distance
                            if distance > self.min_distance then
                                -- Move closer to unit
                                local from_target = current_position - found_position
                                local direction = vector3_normalize(from_target)
                                target_position = found_position + (direction * self.min_distance)
                            end
                            -- Set interest
                            found_object = object
                            found_type = interest_type
                            if is_item then
                                target_position[3] = math_max(target_position[3], found_position[3] + 2)
                            end
                        end
                    end
                end
            end
            -- found_position, target_position, found_object, found_type = self:validate_point_of_interest(object, interest_type)
            -- self.valid = found_object ~= nil
        end
        if self.valid and found_position and found_object and found_type then
            -- Talk if different interest
            if not self:is_current(found_object) then
                local event_name = found_type == "tag_enemy" and "tagged_enemy" or found_type == "tag" and "tagged_item" or "marker"
                managers.event:trigger("servo_friend_talk", dt, t, event_name, self.servo_friend_unit, self.player_unit)
            end
            -- Set new interest
            self:set(found_object, found_type)
            -- Set position
            self.servo_friend_extension:on_servo_friend_set_target_position(target_position, found_position, self.valid)
        elseif was_valid then
            managers.event:trigger("servo_friend_talk", dt, t, "objective_canceled", self.servo_friend_unit, self.player_unit)
            -- Set new interest
            self:set(nil, nil)
            -- Set position
            self.servo_friend_extension:on_servo_friend_set_target_position(nil, nil)
        end
    end
end

ServoFriendPointOfInterestExtension.validate_point_of_interest = function(self, object, interest_type)
    if not object.__deleted then
        local found_position = nil
        local found_object = nil
        local found_type = nil
        local closest = math_huge
        local player_position = self:player_position()
        local current_position = vector3_unbox(self.current_position)
        local target_position = nil
        -- Point of interest is tag
        local is_enemy = interest_type == "tag_enemy"
        local is_item = interest_type == "tag"
        if is_item or is_enemy then
            -- Check enemy or item
            local enemy = is_enemy and self.focus_tagged_enemies
            local item = is_item and self.focus_tagged_items
            if enemy or item then
                -- Check tagged unit
                local tag_unit = object:target_unit()
                if tag_unit and unit_alive(tag_unit) then
                    -- Get positions
                    local tag_position = unit_world_position(tag_unit, 1)
                    -- If enemy add offset
                    local enemy_height = self:enemy_height(object)
                    if enemy then tag_position = tag_position + vector3(0, 0, enemy_height) end
                    found_position = tag_position
                end
            end
        elseif interest_type == "marker" then
            if object.world_position then
                local position = vector3_unbox(object.world_position)
                found_position = position
            end
        end
        -- Check found position
        local position_los = self:is_in_line_of_sight(current_position, found_position)
        local player_los = self:is_in_line_of_sight(current_position, player_position)
        if found_position and position_los and player_los then
            -- Check maximum distance
            local distance = vector3_distance(current_position, found_position)
            local player_distance = vector3_distance(player_position, found_position)
            local no_recall = self.use_roaming_area or player_distance < self.max_distance
            if distance < self.max_distance and no_recall then
                if distance < closest then
                    closest = distance
                    -- self.valid = true
                    -- Check minimum distance
                    if distance > self.min_distance then
                        -- Move closer to unit
                        local from_target = current_position - found_position
                        local direction = vector3_normalize(from_target)
                        target_position = found_position + (direction * self.min_distance)
                    end
                    -- Set interest
                    found_object = object
                    found_type = interest_type
                    return found_position, target_position, found_object, found_type
                end
            end
        end
    end
end

-- ##### ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ######################################################
-- ##### └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ └┐┌┘├┤ │││ │ └─┐ ######################################################
-- ##### └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘ └┘ └─┘┘└┘ ┴ └─┘ ######################################################

ServoFriendPointOfInterestExtension.on_settings_changed = function(self)
    -- Base class
    ServoFriendPointOfInterestExtension.super.on_settings_changed(self)
    -- Settings
    self.focus_tagged_enemies = self.servo_friend_extension.focus_tagged_enemies
    self.focus_tagged_items   = self.servo_friend_extension.focus_tagged_items
    self.only_own_tags        = self.servo_friend_extension.only_own_tags
    self.use_roaming_area     = self.servo_friend_extension.use_roaming_area
    self.roaming_area         = self.servo_friend_extension.roaming_area
end

ServoFriendPointOfInterestExtension.on_servo_friend_spawned = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        -- Base class
        ServoFriendPointOfInterestExtension.super.on_servo_friend_spawned(self)
        -- Clear
        self:clear_current()
        self:clear()
    end
end

ServoFriendPointOfInterestExtension.on_servo_friend_destroyed = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        -- Base class
        ServoFriendPointOfInterestExtension.super.on_servo_friend_destroyed(self)
    end
end

ServoFriendPointOfInterestExtension.on_servo_friend_clear_current_point_of_interest = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        self:clear_current()
    end
end

ServoFriendPointOfInterestExtension.on_servo_friend_clear_points_of_interest = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        self:clear()
    end
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

ServoFriendPointOfInterestExtension.enemy_height = function(self, object)
    local breed = object._breed
    return breed and breed.base_height or 2
end

ServoFriendPointOfInterestExtension.is_valid = function(self)
    return self.valid
end

ServoFriendPointOfInterestExtension.is_current = function(self, object)
    return self.closest.object == object
end

ServoFriendPointOfInterestExtension.was_previous = function(self, object)
    return self.previous == object
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

ServoFriendPointOfInterestExtension.set = function(self, object, interest_type)
    self.closest.object = object
    self.closest.type = interest_type
end

ServoFriendPointOfInterestExtension.clear_current = function(self)
    self:set(nil, nil)
    self.servo_friend_extension:on_servo_friend_set_target_position(nil, nil)
end

ServoFriendPointOfInterestExtension.validate = function(self, object)
    if self:is_current(object) then
        self:clear_current()
    end
end

ServoFriendPointOfInterestExtension.clear = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        self:clear_current()
        table_clear(self.points)
    end
end

ServoFriendPointOfInterestExtension.add = function(self, object, interest_type)
    self.points[object] = interest_type
end

ServoFriendPointOfInterestExtension.remove = function(self, object)
    self:validate(object)
    self.points[object] = nil
end

return ServoFriendPointOfInterestExtension