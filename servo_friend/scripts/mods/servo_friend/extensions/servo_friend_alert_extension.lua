local mod = get_mod("servo_friend")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local unit = Unit
local class = class
local CLASS = CLASS
local world = World
local light = Light
local table = table
local vector3 = Vector3
local managers = Managers
local unit_alive = unit.alive
local quaternion = Quaternion
local unit_light = unit.light
local vector3_box = Vector3Box
local wwise_world = WwiseWorld
local script_unit = ScriptUnit
local table_remove = table.remove
local vector3_zero = vector3.zero
local world_link_unit = world.link_unit
local vector3_unbox = vector3_box.unbox
local light_set_enabled = light.set_enabled
local world_unlink_unit = world.unlink_unit
local world_destroy_unit = world.destroy_unit
local light_set_intensity = light.set_intensity
local unit_local_rotation = unit.local_rotation
local quaternion_multiply = quaternion.multiply
local world_spawn_unit_ex = world.spawn_unit_ex
local quaternion_identity = quaternion.identity
local unit_set_local_scale = unit.set_local_scale
local light_set_ies_profile = light.set_ies_profile
local script_unit_extension = script_unit.extension
local light_set_falloff_end = light.set_falloff_end
local light_set_color_filter = light.set_color_filter
local light_set_casts_shadows = light.set_casts_shadows
local unit_set_local_position = unit.set_local_position
local unit_set_local_rotation = unit.set_local_rotation
local light_set_falloff_start = light.set_falloff_start
local light_set_spot_reflector = light.set_spot_reflector
local unit_set_unit_visibility = unit.set_unit_visibility
local light_set_spot_angle_end = light.set_spot_angle_end
local script_unit_has_extension = script_unit.has_extension
local light_color_with_intensity = light.color_with_intensity
local light_set_spot_angle_start = light.set_spot_angle_start
local light_set_volumetric_intensity = light.set_volumetric_intensity
local unit_set_vector3_for_materials = unit.set_vector3_for_materials
local wwise_world_set_source_position = wwise_world.set_source_position
local quaternion_from_euler_angles_xyz = quaternion.from_euler_angles_xyz
local light_set_correlated_color_temperature = light.set_correlated_color_temperature

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local NUM_LIGHTS_PER_FRIEND = 4
local alert_sound_effect = "wwise/events/minions/play_terror_event_alarm"
local light_unit = "content/weapons/player/attachments/flashlights/flashlight_01/flashlight_01"
local packages_to_load = {
    light_unit,
    alert_sound_effect,
}
local light_profile = {
    ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_03",
    color_temperature = 6200,
    spot_reflector = false,
    intensity= 24,
    spot_angle_start = 0,
    spot_angle_end = 1.5,
    falloff_start = 0,
    falloff_end = 10,
    volumetric_intensity = 1.6,
}

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local ServoFriendAlertExtension = class("ServoFriendAlertExtension", "ServoFriendBaseExtension")

mod:register_extension("ServoFriendAlertExtension", "servo_friend_alert_system")
mod:register_sounds({
    start_alert = alert_sound_effect,
})
mod:register_packages(packages_to_load)

-- ##### ┬┌┐┌┬┌┬┐       ┌┬┐┌─┐┌─┐┌┬┐┬─┐┌─┐┬ ┬ #########################################################################
-- ##### │││││ │   ───   ││├┤ └─┐ │ ├┬┘│ │└┬┘ #########################################################################
-- ##### ┴┘└┘┴ ┴        ─┴┘└─┘└─┘ ┴ ┴└─└─┘ ┴  #########################################################################

ServoFriendAlertExtension.init = function(self, extension_init_context, unit, extension_init_data)
    -- Base class
    ServoFriendAlertExtension.super.init(self, extension_init_context, unit, extension_init_data)
    -- Data
    self.units = {}
    self.lights = {}
    self.active = false
    self.music_parameter_extension = script_unit_has_extension(self.player_unit, "music_parameter_system")
    -- Events
    -- managers.event:register(self, "servo_friend_spawned", "on_servo_friend_spawned")
    -- managers.event:register(self, "servo_friend_destroyed", "on_servo_friend_destroyed")
    managers.event:register(self, "servo_friend_alert_started", "on_servo_friend_alert_started")
    managers.event:register(self, "servo_friend_alert_finished", "on_servo_friend_alert_finished")
    -- Settings
    self:on_settings_changed()
    -- Lights
    self:spawn_lights()
    -- Debug
    self:print("ServoFriendAlertExtension initialized")
end

ServoFriendAlertExtension.destroy = function(self)
    -- Events
    -- managers.event:unregister(self, "servo_friend_spawned")
    -- managers.event:unregister(self, "servo_friend_destroyed")
    managers.event:unregister(self, "servo_friend_alert_started")
    managers.event:unregister(self, "servo_friend_alert_finished")
    -- Destroy
    self:stop_alert()
    self:destroy_lights()
    -- Debug
    self:print("ServoFriendAlertExtension destroyed")
    -- Base class
    ServoFriendAlertExtension.super.destroy(self)
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

ServoFriendAlertExtension.update = function(self, dt, t)
    -- Base class
    ServoFriendAlertExtension.super.update(self, dt, t)
    -- Lights
    if self:is_initialized() and self:light_units_alive() then
        self:update_lights(dt, t)
    end
    -- Activation
    local has_found_something_valid = self.servo_friend_extension:has_found_something_valid()
    local only_when_idle = not self.alert_mode_only_when_idle or not has_found_something_valid
    if self:is_initialized() and self:wants_alert_active() and only_when_idle then
        self:start_alert()
    else
        self:stop_alert()
    end
end

ServoFriendAlertExtension.update_lights = function(self, dt, t)
    for i = 1, NUM_LIGHTS_PER_FRIEND do
        local new_rotation = quaternion_multiply(unit_local_rotation(self.units[i], 1), quaternion_from_euler_angles_xyz(dt * 100, 0, dt * 100))
        unit_set_local_rotation(self.units[i], 1, new_rotation)
    end
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

ServoFriendAlertExtension.wants_alert_active = function(self)
    if self.music_parameter_extension then
        local vector_horde_near = self.music_parameter_extension:vector_horde_near()
        local ambush_horde_near = self.music_parameter_extension:ambush_horde_near()
        local last_man_standing = self.music_parameter_extension:last_man_standing()
        local boss_near = self.music_parameter_extension:boss_near()
        return vector_horde_near or ambush_horde_near or last_man_standing or boss_near
    end
end

ServoFriendAlertExtension.light_units_alive = function(self)
    return self.units and #self.units > 0 and self.units[1] and unit_alive(self.units[1])
end

ServoFriendAlertExtension.light_rotation = function(self)
    return 360 / NUM_LIGHTS_PER_FRIEND
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

ServoFriendAlertExtension.start_alert = function(self)
    if self:is_initialized() and self.alert_mode and not self.active then
        -- Active
        self.active = true
        -- Lights
        if self.alert_mode_lights then
            self:enable_light(true)
        end
        -- Sound
        if self.alert_mode_sound then
            self:play_alert_sound()
        end
    end
end

ServoFriendAlertExtension.stop_alert = function(self)
    if self.active then
        -- Active
        self.active = false
        -- Lights
        self:enable_light(false)
        -- Sound
        self:stop_alert_sound()
    end
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

ServoFriendAlertExtension.respawn_alert_sound = function(self)
    self:stop_alert_sound()
    self:play_alert_sound()
end

ServoFriendAlertExtension.play_alert_sound = function(self)
    if self:is_initialized() and self.alert_mode_sound and self:wants_alert_active() then
        local dt, t = self:delta_time(), self:time()
        managers.event:trigger("servo_friend_talk", dt, t, "start_alert", self.servo_friend_unit, self.player_unit)
    end
end

ServoFriendAlertExtension.stop_alert_sound = function(self)
    local dt, t = self:delta_time(), self:time()
    managers.event:trigger("servo_friend_talk", dt, t, "stop_alert", self.servo_friend_unit, self.player_unit)
end

ServoFriendAlertExtension.respawn_lights = function(self)
    self:destroy_lights()
    self:spawn_lights()
end

ServoFriendAlertExtension.spawn_lights = function(self)

    if self:is_initialized() and not self:light_units_alive() then

        local player_position = self:player_position()
        local rotation_per_unit = self:light_rotation()

        for i = 1, NUM_LIGHTS_PER_FRIEND do
            -- Spawn
            self.units[i] = world_spawn_unit_ex(self._world, light_unit, nil, player_position, quaternion_identity())
            -- Link
            world_link_unit(self._world, self.units[i], 1, self.servo_friend_unit, 1)
            -- Position / rotation
            unit_set_local_position(self.units[i], 1, vector3(0, 0, 0))
            unit_set_local_rotation(self.units[i], 1, quaternion_from_euler_angles_xyz(0, (i - 1) * rotation_per_unit, 90))
            unit_set_local_scale(self.units[i], 1, vector3(0.1, 0.1, 0.1))
            -- Light
            self.lights[i] = unit_light(self.units[i], 1)
            self:set_light(self.lights[i])
        end

    end

end

ServoFriendAlertExtension.destroy_lights = function(self)
    if self:light_units_alive() then
        for i = NUM_LIGHTS_PER_FRIEND, 1, -1 do
            world_unlink_unit(self._world, self.units[i])
            world_destroy_unit(self._world, self.units[i])
            table_remove(self.units, i)
            table_remove(self.lights, i)
        end
    end
end

ServoFriendAlertExtension.set_light = function(self, light)
    if light then
        light_set_casts_shadows(light, false)
        light_set_ies_profile(light, light_profile.ies_profile)
        light_set_correlated_color_temperature(light, light_profile.color_temperature)
        light_set_spot_reflector(light, light_profile.spot_reflector)
        light_set_intensity(light, light_profile.intensity)
        light_set_spot_angle_start(light, light_profile.spot_angle_start)
        light_set_spot_angle_end(light, light_profile.spot_angle_end)
        light_set_falloff_start(light, light_profile.falloff_start)
        light_set_falloff_end(light, light_profile.falloff_end)
        light_set_volumetric_intensity(light, light_profile.volumetric_intensity)
        light_set_color_filter(light, vector3(1, 0, 0))
    end
end

ServoFriendAlertExtension.enable_light = function(self, enabled)
    if self:light_units_alive() then
        for i = 1, NUM_LIGHTS_PER_FRIEND do
            light_set_enabled(self.lights[i], enabled)
        end
    end
end

-- ##### ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ######################################################
-- ##### └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ └┐┌┘├┤ │││ │ └─┐ ######################################################
-- ##### └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘ └┘ └─┘┘└┘ ┴ └─┘ ######################################################

ServoFriendAlertExtension.on_settings_changed = function(self)
    -- Base class
    ServoFriendAlertExtension.super.on_settings_changed(self)
    -- Settings
    self.alert_mode = self.servo_friend_extension.alert_mode
    self.alert_mode_lights = self.servo_friend_extension.alert_mode_lights
    self.alert_mode_sound = self.servo_friend_extension.alert_mode_sound
    self.alert_mode_only_when_idle = self.servo_friend_extension.alert_mode_only_when_idle
    -- Respawn
    self:stop_alert()
end

ServoFriendAlertExtension.on_servo_friend_spawned = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        -- Base class
        ServoFriendAlertExtension.super.on_servo_friend_spawned(self)
    end
end

ServoFriendAlertExtension.on_servo_friend_destroyed = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        -- Destroy
        self:stop_alert()
        -- Base class
        ServoFriendAlertExtension.super.on_servo_friend_destroyed(self)
    end
end

ServoFriendAlertExtension.on_servo_friend_alert_started = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) or not servo_friend_unit then
        -- Spawn
        self:start_alert()
    end
end

ServoFriendAlertExtension.servo_friend_alert_finished = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) or not servo_friend_unit then
        -- Destroy
        self:stop_alert()
    end
end

return ServoFriendAlertExtension