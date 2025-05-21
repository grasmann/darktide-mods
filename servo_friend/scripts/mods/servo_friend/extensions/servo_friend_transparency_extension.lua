local mod = get_mod("servo_friend")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local unit = Unit
local class = class
local vector3 = Vector3
local managers = Managers
local unit_alive = unit.alive
local vector3_box = Vector3Box
local vector3_unbox = vector3_box.unbox
local vector3_distance = vector3.distance
local unit_world_position = unit.world_position
local unit_set_scalar_for_materials = unit.set_scalar_for_materials
local unit_set_shader_pass_flag_for_meshes = unit.set_shader_pass_flag_for_meshes

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local ServoFriendTransparencyExtension = class("ServoFriendTransparencyExtension", "ServoFriendBaseExtension")

mod:register_extension("ServoFriendTransparencyExtension", "servo_friend_transparency_system")

-- ##### ┬┌┐┌┬┌┬┐       ┌┬┐┌─┐┌─┐┌┬┐┬─┐┌─┐┬ ┬ #########################################################################
-- ##### │││││ │   ───   ││├┤ └─┐ │ ├┬┘│ │└┬┘ #########################################################################
-- ##### ┴┘└┘┴ ┴        ─┴┘└─┘└─┘ ┴ ┴└─└─┘ ┴  #########################################################################

ServoFriendTransparencyExtension.init = function(self, extension_init_context, unit, extension_init_data)
    -- Base class
    ServoFriendTransparencyExtension.super.init(self, extension_init_context, unit, extension_init_data)
    -- Data
    self.enabled = true
    -- Events
    -- managers.event:register(self, "servo_friend_spawned", "on_servo_friend_spawned")
    -- managers.event:register(self, "servo_friend_destroyed", "on_servo_friend_destroyed")
    managers.event:register(self, "servo_friend_transparency_enabled", "on_servo_friend_transparency_enabled")
    managers.event:register(self, "servo_friend_transparency_disabled", "on_servo_friend_transparency_disabled")
    -- Settings
    self:on_settings_changed()
end

ServoFriendTransparencyExtension.destroy = function(self)
    -- Events
    -- managers.event:unregister(self, "servo_friend_spawned")
    -- managers.event:unregister(self, "servo_friend_destroyed")
    managers.event:unregister(self, "servo_friend_transparency_enabled")
    managers.event:unregister(self, "servo_friend_transparency_disabled")
    -- Base class
    ServoFriendTransparencyExtension.super.destroy(self)
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

ServoFriendTransparencyExtension.update = function(self, dt, t)
    -- Base class
    ServoFriendTransparencyExtension.super.update(self, dt, t)
    -- Update
    -- local player_position = mod:player_position()
    if self:is_initialized() and self:servo_friend_alive() then
        local pt = self:pt()
        -- local first_person_extension = mod.first_person_unit
        local first_person_position = unit_world_position(self.first_person_unit, 1)
        local current_position = vector3_unbox(self.current_position)
        local distance = vector3_distance(first_person_position, current_position)
        local alpha = 0
        if not self.enabled then
            alpha = 0
        elseif distance <= 1 then
            alpha = 1 - distance
            -- unit_set_scalar_for_materials(pt.servo_friend_unit, "inv_jitter_alpha", 1 - distance, true)
        -- else
        --     unit_set_scalar_for_materials(pt.servo_friend_unit, "inv_jitter_alpha", 1, true)
        end
        unit_set_scalar_for_materials(self.servo_friend_unit, "inv_jitter_alpha", alpha, true)
        -- if pt.flashlight_unit and unit_alive(pt.flashlight_unit) then
        --     unit_set_scalar_for_materials(pt.flashlight_unit, "inv_jitter_alpha", alpha, true)
        -- end
    end
end

-- ##### ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ######################################################
-- ##### └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ └┐┌┘├┤ │││ │ └─┐ ######################################################
-- ##### └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘ └┘ └─┘┘└┘ ┴ └─┘ ######################################################

ServoFriendTransparencyExtension.on_settings_changed = function(self)
    -- Base class
    ServoFriendTransparencyExtension.super.on_settings_changed(self)
end

ServoFriendTransparencyExtension.on_servo_friend_spawned = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        -- Base class
        ServoFriendTransparencyExtension.super.on_servo_friend_spawned(self)
        -- Shader flag
        if self:is_me(servo_friend_unit) and self:servo_friend_alive() then
            local pt = self:pt()
            unit_set_shader_pass_flag_for_meshes(self.servo_friend_unit, "one_bit_alpha", true, true)
            -- if pt.flashlight_unit and unit_alive(pt.flashlight_unit) then
            --     unit_set_shader_pass_flag_for_meshes(pt.flashlight_unit, "one_bit_alpha", true, true)
            -- end
        end
    end
end

ServoFriendTransparencyExtension.on_servo_friend_destroyed = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        -- Base class
        ServoFriendTransparencyExtension.super.on_servo_friend_destroyed(self)
    end
end

ServoFriendTransparencyExtension.on_servo_friend_transparency_enabled = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        self.enabled = true
    end
end

ServoFriendTransparencyExtension.on_servo_friend_transparency_disabled = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        self.enabled = false
    end
end

return ServoFriendTransparencyExtension