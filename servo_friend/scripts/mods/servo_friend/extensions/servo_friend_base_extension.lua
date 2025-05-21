local mod = get_mod("servo_friend")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local unit = Unit
local math = math
local pairs = pairs
local class = class
local world = World
local table = table
local vector3 = Vector3
local managers = Managers
local script_unit = ScriptUnit
local vector3_box = Vector3Box
local vector3_zero = vector3.zero
local physics_world = PhysicsWorld
local world_physics_world = world.physics_world
local script_unit_extension = script_unit.extension
local script_unit_has_extension = script_unit.has_extension

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local ServoFriendBaseExtension = class("ServoFriendBaseExtension")

ServoFriendBaseExtension.init = function(self, extension_init_context, unit, extension_init_data)
    -- References
    self.world_manager = managers.world
    self.package_manager = managers.package
    self.time_manager = managers.time
    -- World
    self._world = self:world()
    self._physics_world = self:physics_world()
    self._wwise_world = self:wwise_world()
    -- Data
    self.player_unit = extension_init_data.player_unit
    self.is_local_unit = extension_init_data.is_local_unit
    self.servo_friend_extension = script_unit_has_extension(self.player_unit, "player_unit_servo_friend_system")
    self.servo_friend_unit = self:servo_friend_unit()
    self.first_person_extension = script_unit_extension(self.player_unit, "first_person_system")
    self.first_person_unit = self.first_person_extension:first_person_unit()
    self.init_context = extension_init_context
    self.init_data = extension_init_data
    self.unit = unit
    self.max_distance = 20
    self.min_distance = 10
    self.current_position = vector3_box(vector3_zero())
    -- Events
    managers.event:register(self, "servo_friend_sync_current_position", "on_sync_current_position")
    managers.event:register(self, "servo_friend_spawned", "on_servo_friend_spawned")
    managers.event:register(self, "servo_friend_destroyed", "on_servo_friend_destroyed")
    -- Initialize
    self.initialized = true
    -- Settings
    -- self:on_settings_changed()
    -- Debug
    self:print("ServoFriendBaseExtension initialized")
end

ServoFriendBaseExtension.p2p_command = function(self, command, target, data)
    return mod:p2p_command(command, target, data)
end

ServoFriendBaseExtension.destroy = function(self)
    -- Initialize
    self.initialized = false
    -- Events
    managers.event:unregister(self, "servo_friend_sync_current_position")
    managers.event:unregister(self, "servo_friend_spawned")
    managers.event:unregister(self, "servo_friend_destroyed")
    -- Debug
    self:print("ServoFriendBaseExtension destroyed")
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

ServoFriendBaseExtension.update = function(self, dt, t)
end

-- ##### ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ######################################################
-- ##### └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ └┐┌┘├┤ │││ │ └─┐ ######################################################
-- ##### └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘ └┘ └─┘┘└┘ ┴ └─┘ ######################################################

ServoFriendBaseExtension.is_me = function(self, unit)
    return unit == self.servo_friend_unit
end

ServoFriendBaseExtension.on_settings_changed = function(self, servo_friend_unit, player_unit)
    self.debug_mode = self:extension_valid(self.servo_friend_extension) and self.servo_friend_extension.debug --mod:get("mod_option_debug")
end

ServoFriendBaseExtension.on_sync_current_position = function(self, current_position_box, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        self.current_position = current_position_box
    end
end

ServoFriendBaseExtension.is_initialized = function(self, servo_friend_unit, player_unit)
    return self:extension_valid(self.servo_friend_extension) and self.servo_friend_extension:is_initialized() and self.initialized
end

ServoFriendBaseExtension.on_servo_friend_spawned = function(self, servo_friend_unit, player_unit)
end

ServoFriendBaseExtension.on_servo_friend_destroyed = function(self, servo_friend_unit, player_unit)
end

-- ##### ┌─┐┌─┐┌┬┐┌┬┐┌─┐┌┐┌ ###########################################################################################
-- ##### │  │ ││││││││ ││││ ###########################################################################################
-- ##### └─┘└─┘┴ ┴┴ ┴└─┘┘└┘ ###########################################################################################

ServoFriendBaseExtension.random_option = function(self, values)
    return mod:random_option(values)
end

ServoFriendBaseExtension.pt = function(self)
    return mod:persistent_table(mod.REFERENCE)
end

ServoFriendBaseExtension.extension_valid = function(self, extension)
    return mod:extension_valid(extension)
end

ServoFriendBaseExtension.servo_friend_alive = function(self)
    return self:extension_valid(self.servo_friend_extension) and self.servo_friend_extension:servo_friend_alive()
end

ServoFriendBaseExtension.servo_friend_unit = function(self)
    return self:extension_valid(self.servo_friend_extension) and self.servo_friend_extension.servo_friend_unit
end

ServoFriendBaseExtension.player_position = function(self)
    return self:extension_valid(self.servo_friend_extension) and self.servo_friend_extension:player_position()
end

ServoFriendBaseExtension.player_rotation = function(self)
    return self:extension_valid(self.servo_friend_extension) and self.servo_friend_extension:player_rotation()
end

ServoFriendBaseExtension.player_unit_alive = function(self)
    return self.player_unit and self:is_unit_alive(self.player_unit)
end

ServoFriendBaseExtension.found_something_valid = function(self)
    return self:extension_valid(self.servo_friend_extension) and self.servo_friend_extension:has_found_something_valid()
end

ServoFriendBaseExtension.current_positioning_height = function(self)
    return self:extension_valid(self.servo_friend_extension) and self.servo_friend_extension:current_positioning_height()
end

ServoFriendBaseExtension.movement_speed = function(self)
    return self:extension_valid(self.servo_friend_extension) and self.servo_friend_extension:movement_speed()
end

ServoFriendBaseExtension.aim_target = function(self, optional_offset, optional_unit, optional_length, optional_collision_filter)
    return self:extension_valid(self.servo_friend_extension) and self.servo_friend_extension:aim_target(optional_offset, optional_unit or self.first_person_unit, optional_length, optional_collision_filter)
end

-- ##### ┌┬┐┌─┐┌┐ ┬ ┬┌─┐ ##############################################################################################
-- #####  ││├┤ ├┴┐│ ││ ┬ ##############################################################################################
-- ##### ─┴┘└─┘└─┘└─┘└─┘ ##############################################################################################

ServoFriendBaseExtension.print = function(self, message)
    mod:print(message)
end

-- ##### ┬─┐┌─┐┬ ┬┌─┐┌─┐┌─┐┌┬┐ ########################################################################################
-- ##### ├┬┘├─┤└┬┘│  ├─┤└─┐ │  ########################################################################################
-- ##### ┴└─┴ ┴ ┴ └─┘┴ ┴└─┘ ┴  ########################################################################################

ServoFriendBaseExtension.is_in_line_of_sight = function(self, from, to)
    return mod:is_in_line_of_sight(from, to, self._physics_world)
end

-- ##### ┬ ┬┬ ┬┌┐  ####################################################################################################
-- ##### ├─┤│ │├┴┐ ####################################################################################################
-- ##### ┴ ┴└─┘└─┘ ####################################################################################################

ServoFriendBaseExtension.is_in_hub = function(self)
    return mod:is_in_hub()
end

-- ##### ┌─┐┌─┐┬ ┬┌┐┌┌┬┐┌─┐ ###########################################################################################
-- ##### └─┐│ ││ ││││ ││└─┐ ###########################################################################################
-- ##### └─┘└─┘└─┘┘└┘─┴┘└─┘ ###########################################################################################

ServoFriendBaseExtension.play_sound = function(self, sound_event, optional_source_id)
    return mod:play_sound(sound_event, optional_source_id)
end

ServoFriendBaseExtension.start_repeating_sound = function(self, sound_event, optional_source_id)
    return mod:start_repeating_sound(sound_event, optional_source_id)
end

ServoFriendBaseExtension.stop_repeating_sound = function(self, repeating_id)
    return mod:stop_repeating_sound(repeating_id)
end

-- ##### ┌┬┐┌─┐┬─┐┬┌─  ┌┬┐┬┌─┐┌─┐┬┌─┐┌┐┌ ##############################################################################
-- #####  ││├─┤├┬┘├┴┐  ││││└─┐└─┐││ ││││ ##############################################################################
-- ##### ─┴┘┴ ┴┴└─┴ ┴  ┴ ┴┴└─┘└─┘┴└─┘┘└┘ ##############################################################################

ServoFriendBaseExtension.is_dark_mission = function(self)
    return mod:is_dark_mission()
end

-- ##### ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌┌─┐ ################################################################################
-- ##### ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││└─┐ ################################################################################
-- ##### └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘└─┘ ################################################################################

ServoFriendBaseExtension.add_extension = function(self, unit, system, extension_init_context, extension_init_data)
    return mod:add_extension(unit, system, extension_init_context, extension_init_data)
end

ServoFriendBaseExtension.remove_extension = function(self, unit, system)
    return mod:remove_extension(unit, system)
end

ServoFriendBaseExtension.execute_extension = function(self, unit, system, function_name, ...)
    return mod:execute_extension(unit, system, function_name, ...)
end

-- ##### ┬ ┬┌─┐┬─┐┬  ┌┬┐ ##############################################################################################
-- ##### ││││ │├┬┘│   ││ ##############################################################################################
-- ##### └┴┘└─┘┴└─┴─┘─┴┘ ##############################################################################################

ServoFriendBaseExtension.world = function(self)
    return self.world_manager and self.world_manager:world("level_world")
end

ServoFriendBaseExtension.wwise_world = function(self)
    return self._world and self.world_manager and self.world_manager:wwise_world(self._world)
end

ServoFriendBaseExtension.physics_world = function(self)
    return self._world and world_physics_world(self._world)
end

-- ##### ┌┬┐┬┌┬┐┌─┐ ###################################################################################################
-- #####  │ ││││├┤  ###################################################################################################
-- #####  ┴ ┴┴ ┴└─┘ ###################################################################################################

ServoFriendBaseExtension.time = function(self)
    return mod:game_time() or mod:main_time()
end

ServoFriendBaseExtension.delta_time = function(self)
    return mod:game_delta_time() or mod:main_delta_time()
end

return ServoFriendBaseExtension