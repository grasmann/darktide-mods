local mod = get_mod("servo_friend")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local unit = Unit
local math = math
local class = class
local pairs = pairs
local vector3 = Vector3
local managers = Managers
local math_abs = math.abs
local math_huge = math.huge
local script_unit = ScriptUnit
local vector3_distance = vector3.distance
local unit_local_position = unit.local_position
local script_unit_has_extension = script_unit.has_extension

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local ServoFriendPointOfInterestManager = class("ServoFriendPointOfInterestManager")

-- ##### ┬┌┐┌┬┌┬┐       ┌┬┐┌─┐┌─┐┌┬┐┬─┐┌─┐┬ ┬ #########################################################################
-- ##### │││││ │   ───   ││├┤ └─┐ │ ├┬┘│ │└┬┘ #########################################################################
-- ##### ┴┘└┘┴ ┴        ─┴┘└─┘└─┘ ┴ ┴└─└─┘ ┴  #########################################################################

ServoFriendPointOfInterestManager.init = function(self)
    -- Data
    self.points = {}
    self.assigned = {}
    self.previous_distance = {}
    self.min_reassign_distance = 5
    -- Events
    managers.event:register(self, "servo_friend_point_of_interest_created", "on_servo_friend_point_of_interest_created")
    managers.event:register(self, "servo_friend_point_of_interest_removed", "on_servo_friend_point_of_interest_removed")
    -- Initialize
    self.initialized = true
    -- Debug
    self:print("ServoFriendPointOfInterestManager initialized")
end

ServoFriendPointOfInterestManager.p2p_command = function(self, command, target, data)
    return mod:p2p_command(command, target, data)
end

ServoFriendPointOfInterestManager.destroy = function(self)
    -- Initialize
    self.initialized = false
    -- Events
    managers.event:unregister(self, "servo_friend_point_of_interest_created")
    managers.event:unregister(self, "servo_friend_point_of_interest_removed")
    -- Debug
    self:print("ServoFriendPointOfInterestManager destroyed")
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

ServoFriendPointOfInterestManager.pt = function(self)
    return mod:pt()
end

ServoFriendPointOfInterestManager.print = function(self, message)
    return mod:print(message)
end

ServoFriendPointOfInterestManager.is_initialized = function(self)
    return mod.initialized and self.initialized
end

ServoFriendPointOfInterestManager.is_unit_alive = function(self, unit)
    return mod:is_unit_alive(unit)
end

ServoFriendPointOfInterestManager.extension_valid = function(self, extension)
    return mod:extension_valid(extension)
end

ServoFriendPointOfInterestManager.update = function(self, dt, t)
    
    if self:is_initialized() then

        local pt = self:pt()

        for object, interest_type in pairs(self.points) do

            local closest_extension = nil
            local closest_distance = math_huge

            -- Find closest servo friend
            for unit, extension in pairs(pt.player_unit_extensions) do
                if self:extension_valid(extension) and self:is_unit_alive(extension.servo_friend_unit) then

                    local servo_friend_position = unit_local_position(extension.servo_friend_unit, 1)

                    local point_of_interest_extension = script_unit_has_extension(extension.servo_friend_unit, "servo_friend_point_of_interest_system")
                    if self:extension_valid(point_of_interest_extension) then

                        local found_position, target_position = point_of_interest_extension:validate_point_of_interest(object, interest_type)
                        if found_position then

                            local distance = vector3_distance(servo_friend_position, found_position)
                            if distance < closest_distance then
                                closest_distance = distance
                                closest_extension = point_of_interest_extension
                            end

                        end
                    end
                end
            end

            -- Found a servo friend
            local previous_distance = self.previous_distance[object] or math_huge
            local distance_difference = math_abs(closest_distance - previous_distance)
            if self:extension_valid(closest_extension) and distance_difference > self.min_reassign_distance then

                -- Dismiss
                self:dismiss(closest_extension, object)

                -- Assign
                self:assign(closest_extension, object, interest_type)

                -- Previous
                self.previous_distance[object] = closest_distance

            end
        end
    end
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

ServoFriendPointOfInterestManager.dismiss = function(self, next_extension, object, force)
    -- Check if already assigned
    local assigned_extension = self.assigned[object]
    -- If already assigned and not deleted, unassign except if next extension is the same
    if force or (assigned_extension and next_extension ~= assigned_extension) then
        -- Remove from assigned extension
        if self:extension_valid(assigned_extension) then
            assigned_extension:remove(object)
        end
        -- Clear
        self.assigned[object] = nil
    end
end

ServoFriendPointOfInterestManager.assign = function(self, extension, object, interest_type, force)
    -- If not already assigned and not deleted
    if force or (self:extension_valid(extension) and self.assigned[object] ~= extension) then
        -- Set assigned extension
        self.assigned[object] = extension
        -- Add point of interest to extension
        extension:add(object, interest_type)
    end
end

-- ##### ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ######################################################
-- ##### └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ └┐┌┘├┤ │││ │ └─┐ ######################################################
-- ##### └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘ └┘ └─┘┘└┘ ┴ └─┘ ######################################################

ServoFriendPointOfInterestManager.on_servo_friend_point_of_interest_created = function(self, object, interest_type)
    self.points[object] = interest_type
end

ServoFriendPointOfInterestManager.on_servo_friend_point_of_interest_removed = function(self, object)
    self:dismiss(nil, object, true)
    self.points[object] = nil
    self.assigned[object] = nil
    self.previous_distance[object] = nil
end

return ServoFriendPointOfInterestManager