local mod = get_mod("servo_friend")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local unit = Unit
local world = World
local table = table
local class = class
local pairs = pairs
local CLASS = CLASS
local vector3 = Vector3
local managers = Managers
local unit_alive = unit.alive
local table_clear = table.clear
local vector3_distance = vector3.distance
local unit_local_position = unit.local_position
local unit_set_local_position = unit.set_local_position
local world_update_out_of_bounds_checker = world.update_out_of_bounds_checker

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
    self.max_distance = 20
    -- Events
    -- managers.event:register(self, "servo_friend_spawned", "on_servo_friend_spawned")
    -- managers.event:register(self, "servo_friend_destroyed", "on_servo_friend_destroyed")
    -- managers.event:register(self, "servo_friend_out_of_bounds_check", "on_servo_friend_out_of_bounds_check")
    -- Settings
    self:on_settings_changed()
    -- Debug
    self:print("ServoFriendOutOfBoundsExtension initialized")
end

ServoFriendOutOfBoundsExtension.destroy = function(self)
    -- Events
    -- managers.event:unregister(self, "servo_friend_spawned")
    -- managers.event:unregister(self, "servo_friend_destroyed")
    -- managers.event:unregister(self, "servo_friend_out_of_bounds_check")
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
    -- -- Out of bounds check
    -- self:on_servo_friend_out_of_bounds_check()
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

-- mod.servo_friend_out_of_bounds_check = function(self)
--     -- local pt = self:pt()
--     -- for unit, extension in pairs(pt.player_unit_extensions) do
--     --     self:execute_extension(extension.servo_friend_unit, "servo_friend_out_of_bounds_system", "on_servo_friend_out_of_bounds_check", extension.servo_friend_unit, extension.player_unit)
--     -- end
-- end

ServoFriendOutOfBoundsExtension.on_servo_friend_out_of_bounds_check = function(self, servo_friend_unit, player_unit)
    if self:is_initialized() and self:is_me(servo_friend_unit) and self:servo_friend_alive() and self:player_unit_alive() then
        local position = unit_local_position(self.servo_friend_unit, 1)
        local player_position = unit_local_position(self.player_unit, 1)
        -- local distance = vector3_distance(position, player_position)
        -- if distance > self.max_distance * 3 or position[1] ~= position[1] then
        mod:echo("Servo friend was out of bounds position:"..tostring(position).." corrected:"..tostring(player_position))
        self:execute_extension(self.servo_friend_unit, "servo_friend_point_of_interest_system", "clear")
        self.servo_friend_extension:on_servo_friend_set_target_position(player_position, player_position)
        unit_set_local_position(self.servo_friend_unit, 1, player_position)
        return true
        -- end
    end
end

mod.test_servo_friend_out_of_bounds = function(self, unit)
    local pt = self:pt()
    if unit and self:is_unit_alive(unit) and pt.loaded_extensions[unit] then
        local out_of_bounds_extension = pt.loaded_extensions[unit].servo_friend_out_of_bounds_system
        local player_unit = out_of_bounds_extension and out_of_bounds_extension.player_unit
        if player_unit and self:is_unit_alive(player_unit) then
            -- return true, player_unit
            return out_of_bounds_extension:on_servo_friend_out_of_bounds_check(unit, player_unit)
        end
    end
end

-- ##### ┬ ┬┌─┐┌─┐┬┌─┌─┐ ##############################################################################################
-- ##### ├─┤│ ││ │├┴┐└─┐ ##############################################################################################
-- ##### ┴ ┴└─┘└─┘┴ ┴└─┘ ##############################################################################################

-- mod:hook(CLASS.OutOfBoundsManager, "pre_update", function(func, self, shared_state, ...)
--     -- Out of bounds check
--     mod:servo_friend_out_of_bounds_check()
--     -- Original function
--     func(self, shared_state, ...)
-- end)

mod:hook(CLASS.OutOfBoundsManager, "pre_update", function(func, self, shared_state, ...)
	local hard_cap_out_of_bounds_units = shared_state.hard_cap_out_of_bounds_units
	local soft_cap_out_of_bounds_units = shared_state.soft_cap_out_of_bounds_units
	local world = shared_state.world

	table_clear(soft_cap_out_of_bounds_units)
	table_clear(hard_cap_out_of_bounds_units)

	world_update_out_of_bounds_checker(world, hard_cap_out_of_bounds_units, soft_cap_out_of_bounds_units)

    for i = #hard_cap_out_of_bounds_units, 1, -1 do
        local unit = hard_cap_out_of_bounds_units[i]
        mod:test_servo_friend_out_of_bounds(unit)
        -- local servo_friend, player_unit = mod:unit_is_servo_friend(unit)
        -- if servo_friend then
        --     mod:echo("Servo friend was out of bounds")
        --     local position = unit_local_position(player_unit, 1)
        --     unit_set_local_position(unit, 1, position)
        -- end
	end
    -- Original function
    func(self, shared_state, ...)
end)

-- mod:hook(CLASS.OutOfBoundsManager, "update", function(func, self, shared_state, ...)
--     -- Out of bounds check
--     mod:servo_friend_out_of_bounds_check()
--     -- Original function
--     func(self, shared_state, ...)
-- end)

return ServoFriendOutOfBoundsExtension