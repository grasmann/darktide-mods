local mod = get_mod("servo_friend")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local class = class
local managers = Managers
local vector3_box = Vector3Box
local wwise_world = WwiseWorld
local vector3_unbox = vector3_box.unbox
local wwise_world_set_source_position = wwise_world.set_source_position

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local ServoFriendHoverSoundExtension = class("ServoFriendHoverSoundExtension", "ServoFriendBaseExtension")

mod:register_extension("ServoFriendHoverSoundExtension", "servo_friend_hover_sound_system")
mod:register_sounds({
    start_thruster = "wwise/events/weapon/play_enemy_on_fire",
    stop_thruster  = "wwise/events/weapon/stop_enemy_on_fire",
})

-- ##### ┬┌┐┌┬┌┬┐       ┌┬┐┌─┐┌─┐┌┬┐┬─┐┌─┐┬ ┬ #########################################################################
-- ##### │││││ │   ───   ││├┤ └─┐ │ ├┬┘│ │└┬┘ #########################################################################
-- ##### ┴┘└┘┴ ┴        ─┴┘└─┘└─┘ ┴ ┴└─└─┘ ┴  #########################################################################

ServoFriendHoverSoundExtension.init = function(self, extension_init_context, unit, extension_init_data)
    -- Base class
    ServoFriendHoverSoundExtension.super.init(self, extension_init_context, unit, extension_init_data)
    -- Events
    -- managers.event:register(self, "servo_friend_spawned", "on_servo_friend_spawned")
    -- managers.event:register(self, "servo_friend_destroyed", "on_servo_friend_destroyed")
    -- Settings
    self:on_settings_changed()
    -- Debug
    self:print("ServoFriendHoverSoundExtension initialized")
end

ServoFriendHoverSoundExtension.destroy = function(self)
    -- Events
    -- managers.event:unregister(self, "servo_friend_spawned")
    -- managers.event:unregister(self, "servo_friend_destroyed")
    -- Destroy
    self:destroy_hover_sound()
    -- Debug
    self:print("ServoFriendHoverSoundExtension destroyed")
    -- Base class
    ServoFriendHoverSoundExtension.super.destroy(self)
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

ServoFriendHoverSoundExtension.update = function(self, dt, t)
    -- Base class
    ServoFriendHoverSoundExtension.super.update(self, dt, t)
    -- Update
    if self.thruster_source_id then
        wwise_world_set_source_position(self._wwise_world, self.thruster_source_id, vector3_unbox(self.current_position))
    end
end

-- ##### ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ######################################################
-- ##### └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ └┐┌┘├┤ │││ │ └─┐ ######################################################
-- ##### └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘ └┘ └─┘┘└┘ ┴ └─┘ ######################################################

ServoFriendHoverSoundExtension.on_settings_changed = function(self)
    -- Base class
    ServoFriendHoverSoundExtension.super.on_settings_changed(self)
    -- Settings
    self.hover_sound_effect = self.servo_friend_extension.hover_sound_effect --mod:get("mod_option_hover_sound_effect")
    -- Respawn
    self:respawn_hover_sound()
end

ServoFriendHoverSoundExtension.on_servo_friend_spawned = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        -- Base class
        ServoFriendHoverSoundExtension.super.on_servo_friend_spawned(self)
        -- Spawn
        self:spawn_hover_sound()
    end
end

ServoFriendHoverSoundExtension.on_servo_friend_destroyed = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        -- Base class
        ServoFriendHoverSoundExtension.super.on_servo_friend_destroyed(self)
        -- Destroy
        self:destroy_hover_sound()
    end
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

ServoFriendHoverSoundExtension.spawn_hover_sound = function(self)
    if self:is_initialized() and self.hover_sound_effect and not self.thruster_source_id then
        self.thruster_source_id = self:play_sound("start_thruster")
    end
end

ServoFriendHoverSoundExtension.destroy_hover_sound = function(self)
    if self.thruster_source_id then
        self:play_sound("stop_thruster", self.thruster_source_id)
    end
    self.thruster_source_id = nil
end

ServoFriendHoverSoundExtension.respawn_hover_sound = function(self)
    self:destroy_hover_sound()
    self:spawn_hover_sound()
end

return ServoFriendHoverSoundExtension