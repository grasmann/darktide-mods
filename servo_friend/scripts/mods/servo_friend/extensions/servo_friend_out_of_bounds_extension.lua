local mod = get_mod("servo_friend")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local unit = Unit
local class = class
local pairs = pairs
local CLASS = CLASS
local vector3 = Vector3
local managers = Managers
local unit_alive = unit.alive
local vector3_distance = vector3.distance
local unit_local_position = unit.local_position
local unit_set_local_position = unit.set_local_position

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local ServoFriendOutOfBoundsExtension = class("ServoFriendOutOfBoundsExtension", "ServoFriendBaseExtension")

mod:register_extension("ServoFriendOutOfBoundsExtension", "servo_friend_out_of_bounds_system")

-- ##### ┬┌┐┌┬┌┬┐       ┌┬┐┌─┐┌─┐┌┬┐┬─┐┌─┐┬ ┬ #########################################################################
-- ##### │││││ │   ───   ││├┤ └─┐ │ ├┬┘│ │└┬┘ #########################################################################
-- ##### ┴┘└┘┴ ┴        ─┴┘└─┘└─┘ ┴ ┴└─└─┘ ┴  #########################################################################

ServoFriendOutOfBoundsExtension.init = function(self, extension_init_context, unit, extension_init_data)
    -- Base class
    ServoFriendOutOfBoundsExtension.super.init(self, extension_init_context, unit, extension_init_data)
    -- Data
    self.event_manager = managers.event
    self.max_distance = 20
    self.initialized = true
    -- Events
    self.event_manager:register(self, "servo_friend_spawned", "on_servo_friend_spawned")
    self.event_manager:register(self, "servo_friend_destroyed", "on_servo_friend_destroyed")
    self.event_manager:register(self, "servo_friend_out_of_bounds_check", "on_servo_friend_out_of_bounds_check")
    -- Settings
    self:on_settings_changed()
    -- Debug
    self:print("ServoFriendOutOfBoundsExtension initialized")
end

ServoFriendOutOfBoundsExtension.destroy = function(self)
    -- Data
    self.initialized = false
    -- Events
    self.event_manager:unregister(self, "servo_friend_spawned")
    self.event_manager:unregister(self, "servo_friend_destroyed")
    self.event_manager:unregister(self, "servo_friend_out_of_bounds_check")
    -- Debug
    self:print("ServoFriendOutOfBoundsExtension destroyed")
    -- Base class
    ServoFriendOutOfBoundsExtension.super.destroy(self)
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

ServoFriendOutOfBoundsExtension.update = function(self, dt, t)
    -- Base class
    ServoFriendOutOfBoundsExtension.super.update(self, dt, t)
    -- Out of bounds check
    self:on_servo_friend_out_of_bounds_check()
end

-- ##### ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ######################################################
-- ##### └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ └┐┌┘├┤ │││ │ └─┐ ######################################################
-- ##### └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘ └┘ └─┘┘└┘ ┴ └─┘ ######################################################

ServoFriendOutOfBoundsExtension.on_settings_changed = function(self)
    -- Base class
    ServoFriendOutOfBoundsExtension.super.on_settings_changed(self)
end

ServoFriendOutOfBoundsExtension.on_servo_friend_spawned = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        -- Base class
        ServoFriendOutOfBoundsExtension.super.on_servo_friend_spawned(self)
    end
end

ServoFriendOutOfBoundsExtension.on_servo_friend_destroyed = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        -- Base class
        ServoFriendOutOfBoundsExtension.super.on_servo_friend_destroyed(self)
    end
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

mod.servo_friend_out_of_bounds_check = function(self)
    local pt = self:pt()
    for unit, extension in pairs(pt.player_unit_extensions) do
        self:execute_extension(extension.servo_friend_unit, "servo_friend_out_of_bounds_system", "on_servo_friend_out_of_bounds_check", extension.servo_friend_unit, extension.player_unit)
    end
end

ServoFriendOutOfBoundsExtension.on_servo_friend_out_of_bounds_check = function(self, servo_friend_unit, player_unit)
    if self.initialized and self:is_me(servo_friend_unit) and self:servo_friend_alive() and self.player_unit and unit_alive(self.player_unit) then
        local position = unit_local_position(self.servo_friend_unit, 1)
        local player_position = unit_local_position(self.player_unit, 1)
        local distance = vector3_distance(position, player_position)
        if distance > self.max_distance * 3 or position[1] ~= position[1] then
            self:print("Servo friend was far away from player during out of bounds check")
            self:execute_extension(self.servo_friend_unit, "servo_friend_point_of_interest_system", "clear")
            self.servo_friend_extension:on_servo_friend_set_target_position(player_position, player_position)
            unit_set_local_position(self.servo_friend_unit, 1, player_position)
        end
    end
end

-- ##### ┬ ┬┌─┐┌─┐┬┌─┌─┐ ##############################################################################################
-- ##### ├─┤│ ││ │├┴┐└─┐ ##############################################################################################
-- ##### ┴ ┴└─┘└─┘┴ ┴└─┘ ##############################################################################################

-- Old hooks
-- mod:hook(CLASS.OutOfBoundsManager, "pre_update", function(func, self, shared_state, ...)
--     mod:servo_friend_out_of_bounds_check()
--     func(self, shared_state, ...)
-- end)

-- mod:hook(CLASS.OutOfBoundsManager, "update", function(func, self, shared_state, ...)
--     mod:servo_friend_out_of_bounds_check()
--     func(self, shared_state, ...)
-- end)

mod:hook(CLASS.OutOfBoundsManager, "post_update", function(func, self, shared_state, ...)
    mod:servo_friend_out_of_bounds_check()
    func(self, shared_state, ...)
end)

return ServoFriendOutOfBoundsExtension