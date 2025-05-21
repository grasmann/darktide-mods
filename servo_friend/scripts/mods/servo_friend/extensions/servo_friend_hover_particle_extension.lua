local mod = get_mod("servo_friend")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local class = class
local world = World
local vector3 = Vector3
local managers = Managers
local matrix4x4 = Matrix4x4
local quaternion = Quaternion
local matrix4x4_identity = matrix4x4.identity
local matrix4x4_set_scale = matrix4x4.set_scale
local quaternion_identity = quaternion.identity
local world_link_particles = world.link_particles
local world_create_particles = world.create_particles
local world_destroy_particles = world.destroy_particles
local matrix4x4_set_translation = matrix4x4.set_translation
local world_are_particles_playing = world.are_particles_playing
local world_stop_spawning_particles = world.stop_spawning_particles

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local hover_particle_effect = "content/fx/particles/weapons/rifles/plasma_gun/plasma_gun_charge"

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local ServoFriendHoverParticleExtension = class("ServoFriendHoverParticleExtension", "ServoFriendBaseExtension")

mod:register_extension("ServoFriendHoverParticleExtension", "servo_friend_hover_particle_system")
mod:register_packages({
    hover_particle_effect,
})

-- ##### ┬┌┐┌┬┌┬┐       ┌┬┐┌─┐┌─┐┌┬┐┬─┐┌─┐┬ ┬ #########################################################################
-- ##### │││││ │   ───   ││├┤ └─┐ │ ├┬┘│ │└┬┘ #########################################################################
-- ##### ┴┘└┘┴ ┴        ─┴┘└─┘└─┘ ┴ ┴└─└─┘ ┴  #########################################################################

ServoFriendHoverParticleExtension.init = function(self, extension_init_context, unit, extension_init_data)
    -- Base class
    ServoFriendHoverParticleExtension.super.init(self, extension_init_context, unit, extension_init_data)
    -- Data
    self.hover_particle_effect_id = nil
    -- Events
    -- managers.event:register(self, "servo_friend_spawned", "on_servo_friend_spawned")
    -- managers.event:register(self, "servo_friend_destroyed", "on_servo_friend_destroyed")
    -- Settings
    self:on_settings_changed()
    -- Debug
    self:print("ServoFriendHoverParticleExtension initialized")
end

ServoFriendHoverParticleExtension.destroy = function(self)
    -- Events
    -- managers.event:unregister(self, "servo_friend_spawned")
    -- managers.event:unregister(self, "servo_friend_destroyed")
    -- Destroy
    self:destroy_hover_particle_effect()
    -- Debug
    self:print("ServoFriendHoverParticleExtension destroyed")
    -- Base class
    ServoFriendHoverParticleExtension.super.destroy(self)
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

ServoFriendHoverParticleExtension.update = function(self, dt, t)
    -- Base class
    ServoFriendHoverParticleExtension.super.update(self, dt, t)
end

-- ##### ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ######################################################
-- ##### └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ └┐┌┘├┤ │││ │ └─┐ ######################################################
-- ##### └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘ └┘ └─┘┘└┘ ┴ └─┘ ######################################################

ServoFriendHoverParticleExtension.on_settings_changed = function(self, setting_id)
    -- Base class
    ServoFriendHoverParticleExtension.super.on_settings_changed(self)
    -- Settings
    self.hover_particle_effect = self.servo_friend_extension.hover_particle_effect --mod:get("mod_option_hover_particle_effect")
    -- Respawn
    if setting_id == "mod_option_hover_particle_effect" then
        self:respawn_hover_particle_effect()
    end
end

ServoFriendHoverParticleExtension.on_servo_friend_spawned = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        -- Base class
        ServoFriendHoverParticleExtension.super.on_servo_friend_spawned(self)
        -- Spawn
        self:spawn_hover_particle_effect()
    end
end

ServoFriendHoverParticleExtension.on_servo_friend_destroyed = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        -- Destroy
        self:destroy_hover_particle_effect()
        -- Base class
        ServoFriendHoverParticleExtension.super.on_servo_friend_destroyed(self)
    end
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

ServoFriendHoverParticleExtension.respawn_hover_particle_effect = function(self)
    self:destroy_hover_particle_effect()
    self:spawn_hover_particle_effect()
end

ServoFriendHoverParticleExtension.destroy_hover_particle_effect = function(self)
    if self.hover_particle_effect_id then
        if world_are_particles_playing(self._world, self.hover_particle_effect_id) then
            world_stop_spawning_particles(self._world, self.hover_particle_effect_id)
        end
        world_destroy_particles(self._world, self.hover_particle_effect_id)
        self.hover_particle_effect_id = nil
    end
end

ServoFriendHoverParticleExtension.spawn_hover_particle_effect = function(self)
    if self:is_initialized() and self.hover_particle_effect and self:servo_friend_alive() and not self.hover_particle_effect_id then
        local player_position = self:player_position()
        local unit_world_pose = matrix4x4_identity()
        local rotation = quaternion_identity()
        self.hover_particle_effect_id = world_create_particles(self._world, hover_particle_effect, player_position, rotation)
        matrix4x4_set_translation(unit_world_pose, vector3(0, 0, -.15))
        matrix4x4_set_scale(unit_world_pose, vector3(.001, .001, .001))
        world_link_particles(self._world, self.hover_particle_effect_id, self.servo_friend_unit, 1, unit_world_pose, "destroy")
    end
end

return ServoFriendHoverParticleExtension