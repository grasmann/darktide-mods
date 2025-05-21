local mod = get_mod("servo_friend")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local unit = Unit
local math = math
local pairs = pairs
local world = World
local class = class
local CLASS = CLASS
local light = Light
local vector3 = Vector3
local managers = Managers
local quaternion = Quaternion
local unit_light = unit.light
local unit_alive = unit.alive
local vector3_box = Vector3Box
local script_unit = ScriptUnit
local vector3_zero = vector3.zero
local vector3_unbox = vector3_box.unbox
local world_link_unit = world.link_unit
local light_set_enabled = light.set_enabled
local world_unlink_unit = world.unlink_unit
local world_destroy_unit = world.destroy_unit
local quaternion_identity = quaternion.identity
local world_spawn_unit_ex = world.spawn_unit_ex
local light_set_intensity = light.set_intensity
local light_set_falloff_end = light.set_falloff_end
local light_set_ies_profile = light.set_ies_profile
local light_set_color_filter = light.set_color_filter
local unit_set_local_position = unit.set_local_position
local light_set_casts_shadows = light.set_casts_shadows
local light_set_falloff_start = light.set_falloff_start
local light_set_spot_reflector = light.set_spot_reflector
local light_set_spot_angle_end = light.set_spot_angle_end
local script_unit_has_extension = script_unit.has_extension
local light_set_spot_angle_start = light.set_spot_angle_start
local light_color_with_intensity = light.color_with_intensity
local unit_set_vector3_for_materials = unit.set_vector3_for_materials
local light_set_volumetric_intensity = light.set_volumetric_intensity
local light_set_correlated_color_temperature = light.set_correlated_color_temperature

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local flashlight_unit_small = "content/weapons/player/attachments/flashlights/flashlight_02/flashlight_02"
local flashlight_unit_large = "content/weapons/player/attachments/flashlights/flashlight_01/flashlight_01"
local packages_to_load = {
    flashlight_unit_large,
    flashlight_unit_small,
}
local flashlight_profiles = {
    small = {
        unit = flashlight_unit_small,
        ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_02",
        color_temperature = 7300,
        spot_reflector = false,
        intensity= 10,
        spot_angle_start = 0,
        spot_angle_end = 0.6,
        falloff_start = 0,
        falloff_end = 70,
        volumetric_intensity = 0.3,
        offset = vector3_box(vector3(.05, 0, 0)),
    },
    large = {
        unit = flashlight_unit_large,
        ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_03",
        color_temperature = 6200,
        spot_reflector = false,
        intensity= 16,
        spot_angle_start = 0,
        spot_angle_end = 1.5,
        falloff_start = 0,
        falloff_end = 40,
        volumetric_intensity = 0.15,
        offset = vector3_box(vector3(.075, 0, 0)),
    },
}

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local ServoFriendFlashlightExtension = class("ServoFriendFlashlightExtension", "ServoFriendBaseExtension")

mod:register_extension("ServoFriendFlashlightExtension", "servo_friend_flashlight_system")
mod:register_packages(packages_to_load)

-- ##### ┬┌┐┌┬┌┬┐       ┌┬┐┌─┐┌─┐┌┬┐┬─┐┌─┐┬ ┬ #########################################################################
-- ##### │││││ │   ───   ││├┤ └─┐ │ ├┬┘│ │└┬┘ #########################################################################
-- ##### ┴┘└┘┴ ┴        ─┴┘└─┘└─┘ ┴ ┴└─└─┘ ┴  #########################################################################

ServoFriendFlashlightExtension.init = function(self, extension_init_context, unit, extension_init_data)
    -- Base class
    ServoFriendFlashlightExtension.super.init(self, extension_init_context, unit, extension_init_data)
    -- Data
    self.dark_mission = self:is_dark_mission()
    self.flashlight_unit = nil
    self.light = nil
    self.user_state = nil
    -- Events
    -- managers.event:register(self, "servo_friend_spawned", "on_servo_friend_spawned")
    -- managers.event:register(self, "servo_friend_destroyed", "on_servo_friend_destroyed")
    managers.event:register(self, "servo_friend_overwrite_color", "on_servo_friend_overwrite_color")
    managers.event:register(self, "servo_friend_reset_color", "on_servo_friend_reset_color")
    managers.event:register(self, "servo_friend_overwrite_volumetric_intensity", "on_servo_friend_overwrite_volumetric_intensity")
    managers.event:register(self, "servo_friend_reset_volumetric_intensity", "on_servo_friend_reset_volumetric_intensity")
    -- -- P2P
    -- if mod.p2p and not mod.p2p_flashlight_registered then
    --     mod.p2p.register(mod, "flashlight_toggle", function(player, data)
    --         mod:echo(player:name() .. " flashlight_toggle: " .. data.user_state)
    --         local player_unit = player and player.player_unit
    --         if player_unit then mod:player_flashlight_toggle(player_unit) end
    --     end)
    --     mod.p2p_flashlight_registered = true
    -- end
    -- Settings
    self:on_settings_changed()
    -- Debug
    self:print("ServoFriendFlashlightExtension initialized")
end

ServoFriendFlashlightExtension.destroy = function(self)
    -- Deinit
    self.user_state = false
    -- Events
    -- managers.event:unregister(self, "servo_friend_spawned")
    -- managers.event:unregister(self, "servo_friend_destroyed")
    managers.event:unregister(self, "servo_friend_overwrite_color")
    managers.event:unregister(self, "servo_friend_overwrite_volumetric_intensity")
    managers.event:unregister(self, "servo_friend_reset_color")
    -- Destroy
    self:destroy_flashlight()
    -- Debug
    self:print("ServoFriendFlashlightExtension destroyed")
    -- Base class
    ServoFriendFlashlightExtension.super.destroy(self)
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

ServoFriendFlashlightExtension.update = function(self, dt, t)
    -- Base class
    ServoFriendFlashlightExtension.super.update(self, dt, t)
end

-- ##### ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ######################################################
-- ##### └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ └┐┌┘├┤ │││ │ └─┐ ######################################################
-- ##### └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘ └┘ └─┘┘└┘ ┴ └─┘ ######################################################

ServoFriendFlashlightExtension.on_settings_changed = function(self)
    -- Base class
    ServoFriendFlashlightExtension.super.on_settings_changed(self)
    -- Settings
    self.flashlight          = self.servo_friend_extension.flashlight
    self.flashlight_shadows  = self.servo_friend_extension.flashlight_shadows
    self.flashlight_no_hub   = self.servo_friend_extension.flashlight_no_hub
    self.flashlight_type     = self.servo_friend_extension.flashlight_type
    self.flashlight_template = flashlight_profiles[self.flashlight_type]
    self.r                   = self.servo_friend_extension.r
    self.g                   = self.servo_friend_extension.g
    self.b                   = self.servo_friend_extension.b
    -- Respawn
    self:respawn_flashlight()
end

ServoFriendFlashlightExtension.on_servo_friend_spawned = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        -- Base class
        ServoFriendFlashlightExtension.super.on_servo_friend_spawned(self)
        -- Spawn
        self:spawn_flashlight()
    end
end

ServoFriendFlashlightExtension.on_servo_friend_destroyed = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        -- Base class
        ServoFriendFlashlightExtension.super.on_servo_friend_destroyed(self)
        -- Destroy
        self:destroy_flashlight()
    end
end

ServoFriendFlashlightExtension.on_servo_friend_overwrite_color = function(self, r, g, b, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        self:set_color(r, g, b)
    end
end

ServoFriendFlashlightExtension.on_servo_friend_reset_color = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        self:set_color(self.r, self.g, self.b)
    end
end

ServoFriendFlashlightExtension.on_servo_friend_overwrite_volumetric_intensity = function(self, value, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        self:set_volumetric_intensity(value)
    end
end

ServoFriendFlashlightExtension.servo_friend_reset_volumetric_intensity = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        self:set_volumetric_intensity()
    end
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

ServoFriendFlashlightExtension.wants_flashlight_on = function(self)
    if self.user_state ~= nil then return self.user_state end
    local hub = not self:is_in_hub() or not self.flashlight_no_hub
    local dark_mission = self.flashlight == "only_dark_missions" and self.dark_mission
    return (self.flashlight == "always_on" or dark_mission) and hub
end

ServoFriendFlashlightExtension.flashlight_unit_alive = function(self)
    return mod:is_unit_alive(self.flashlight_unit)
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

ServoFriendFlashlightExtension.spawn_flashlight = function(self)
    if self:is_initialized() and not self:flashlight_unit_alive() then
        local player_position = self:player_position()
        local flashlight_profile = flashlight_profiles[self.flashlight_type]
        if flashlight_profile then
            local flashlight_unit = flashlight_profile.unit
            -- Spawn
            self.flashlight_unit = world_spawn_unit_ex(self._world, flashlight_unit, nil, player_position, quaternion_identity())
            -- Link
            world_link_unit(self._world, self.flashlight_unit, 1, self.servo_friend_unit, 1)
            -- Offset
            local offset = self.flashlight_template.offset and vector3_unbox(self.flashlight_template.offset) or vector3_zero()
            unit_set_local_position(self.flashlight_unit, 1, offset)
            -- Light
            self.light = unit_light(self.flashlight_unit, 1)
            self:set_light()
        end
    end
end

ServoFriendFlashlightExtension.destroy_flashlight = function(self)
    if self.light then
        self.user_state = false
        self:set_enabled(false)
        self.light = nil
    end
    if self:flashlight_unit_alive() then
        world_unlink_unit(self._world, self.flashlight_unit)
        world_destroy_unit(self._world, self.flashlight_unit)
        self.flashlight_unit = nil
    end
end

ServoFriendFlashlightExtension.respawn_flashlight = function(self)
    self:destroy_flashlight()
    self:spawn_flashlight()
end

ServoFriendFlashlightExtension.set_color = function(self, r, g, b)
    if self.light then
        light_set_color_filter(self.light, vector3(r, g, b))
        local color = light_color_with_intensity(self.light) or vector3_zero()
        unit_set_vector3_for_materials(self.flashlight_unit, "light_color", color)
    end
end

ServoFriendFlashlightExtension.set_volumetric_intensity = function(self, volumetric_intensity)
    if self.light then
        light_set_volumetric_intensity(self.light, volumetric_intensity or self.flashlight_template.volumetric_intensity)
    end
end

ServoFriendFlashlightExtension.set_enabled = function(self)
    if self.light then
        light_set_enabled(self.light, self:wants_flashlight_on())
        if self.is_local_unit then
            if self.user_state then
                self:play_sound("selection")
            else
                self:play_sound("wrong")
            end
        end
    end
end

ServoFriendFlashlightExtension.set_light = function(self)
    if self.light then
        -- light_set_enabled(self.light, self:wants_flashlight_on())
        self:set_enabled()
        light_set_casts_shadows(self.light, self.flashlight_shadows)
        light_set_ies_profile(self.light, self.flashlight_template.ies_profile)
        light_set_correlated_color_temperature(self.light, self.flashlight_template.color_temperature)
        light_set_spot_reflector(self.light, self.flashlight_template.spot_reflector)
        light_set_intensity(self.light, self.flashlight_template.intensity)
        light_set_spot_angle_start(self.light, self.flashlight_template.spot_angle_start)
        light_set_spot_angle_end(self.light, self.flashlight_template.spot_angle_end)
        light_set_falloff_start(self.light, self.flashlight_template.falloff_start)
        light_set_falloff_end(self.light, self.flashlight_template.falloff_end)
        self:set_volumetric_intensity(self.flashlight_template.volumetric_intensity)
        self:set_color(self.r, self.g, self.b)
    end
end

local command_table = {user_state = false}
mod.player_flashlight_toggle = function(self, player_unit, send)
    local pt = self:pt()
    player_unit = player_unit or self:local_player_unit()
    local player_unit_first_person_extension = script_unit_has_extension(player_unit, "first_person_system")
    local first_person_unit = player_unit_first_person_extension and player_unit_first_person_extension._unit
    local player_unit_servo_friend_extension = first_person_unit and pt.player_unit_extensions[first_person_unit]
    local servo_friend_unit = player_unit_servo_friend_extension and player_unit_servo_friend_extension.servo_friend_unit
    local flashlight_extension = servo_friend_unit and self:servo_friend_extension(servo_friend_unit, "servo_friend_flashlight_system")
    if flashlight_extension then
        flashlight_extension.user_state = not flashlight_extension.user_state
        flashlight_extension:set_enabled()
        -- if send then
        --     command_table.user_state = flashlight_extension.user_state
        --     self:p2p_command("flashlight_toggle", servo_friend_unit, command_table)
        -- end
    end
end

mod.flashlight_toggle = function()
    mod:player_flashlight_toggle(nil, true)
end

return ServoFriendFlashlightExtension