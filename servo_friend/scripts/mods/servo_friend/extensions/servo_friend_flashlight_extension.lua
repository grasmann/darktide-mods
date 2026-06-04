-- File: servo_friend/scripts/mods/servo_friend/extensions/servo_friend_flashlight_extension.lua
local mod = get_mod("servo_friend")
local Recoil = require("scripts/utilities/recoil")
local Sway = require("scripts/utilities/sway")

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
local actor = Actor
local vector3 = Vector3
local geometry = Geometry
local managers = Managers
local quaternion = Quaternion
local script_unit = ScriptUnit
local wwise_world = WwiseWorld
local physics_world = PhysicsWorld
local unit_light = unit.light
local vector3_box = Vector3Box
local vector3_zero = vector3.zero
local actor_unit = actor.unit
local vector3_unbox = vector3_box.unbox
local world_link_unit = world.link_unit
local unit_world_position = unit.world_position
local unit_world_rotation = unit.world_rotation
local light_set_enabled = light.set_enabled
local world_unlink_unit = world.unlink_unit
local vector3_distance = vector3.distance
local world_move_particles = world.move_particles
local quaternion_look = quaternion.look
local world_destroy_unit = world.destroy_unit
local quaternion_forward = quaternion.forward
local quaternion_identity = quaternion.identity
local world_spawn_unit_ex = world.spawn_unit_ex
local vector3_normalize = vector3.normalize
local light_set_intensity = light.set_intensity
local light_set_falloff_end = light.set_falloff_end
local light_set_ies_profile = light.set_ies_profile
local world_create_particles = world.create_particles
local light_set_color_filter = light.set_color_filter
local physics_world_raycast = physics_world.raycast
local world_destroy_particles = world.destroy_particles
local unit_set_local_position = unit.set_local_position
local light_set_casts_shadows = light.set_casts_shadows
local light_set_falloff_start = light.set_falloff_start
local light_set_spot_reflector = light.set_spot_reflector
local light_set_spot_angle_end = light.set_spot_angle_end
local script_unit_has_extension = script_unit.has_extension
local light_set_spot_angle_start = light.set_spot_angle_start
local light_color_with_intensity = light.color_with_intensity
local world_find_particles_variable = world.find_particles_variable
local world_set_particles_variable = world.set_particles_variable
local wwise_world_make_manual_source = wwise_world.make_manual_source
local unit_set_vector3_for_materials = unit.set_vector3_for_materials
local light_set_volumetric_intensity = light.set_volumetric_intensity
local wwise_world_set_source_position = wwise_world.set_source_position
local geometry_closest_point_on_line = geometry.closest_point_on_line
local wwise_world_destroy_manual_source = wwise_world.destroy_manual_source
local wwise_world_trigger_resource_event = wwise_world.trigger_resource_event
local light_set_correlated_color_temperature = light.set_correlated_color_temperature

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local flashlight_unit_small = "content/weapons/player/attachments/flashlights/flashlight_02/flashlight_02"
local flashlight_unit_large = "content/weapons/player/attachments/flashlights/flashlight_01/flashlight_01"
local laser_particle_name = "content/fx/particles/enemies/plasma_gun_laser_sight"
local laser_length_variable_name = "hit_distance"
local laser_sound_event = "wwise/events/weapon/play_combat_weapon_las_sniper_target_beam"
local laser_stop_sound_event = "wwise/events/weapon/stop_combat_weapon_las_sniper_target_beam"
local laser_max_distance = 50
local laser_min_distance = 1
local laser_y_offset = 1
local laser_x = 0.05
local laser_z = 0.5
local hit_idx_distance = 2
local hit_idx_actor = 4

local packages_to_load = {
    flashlight_unit_large,
    flashlight_unit_small,
    laser_particle_name,
}
local flashlight_profiles = {
    small = {
        unit = flashlight_unit_small,
        ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_02",
        color_temperature = 7300,
        spot_reflector = false,
        intensity = 10,
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
        intensity = 16,
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
    self.locked_aiming_laser = false
    self.locked_aiming_laser_sound = false
    self.locked_aiming_laser_tags = false
    self.locked_aiming_laser_id = nil
    self.locked_aiming_laser_variable_index = nil
    self.locked_aiming_laser_source_id = nil
    -- Manual override state. nil means use mod_option_flashlight automatic policy.
    self.user_state = nil
    -- Events
    managers.event:register(self, "servo_friend_overwrite_color", "on_servo_friend_overwrite_color")
    managers.event:register(self, "servo_friend_reset_color", "on_servo_friend_reset_color")
    managers.event:register(self, "servo_friend_overwrite_volumetric_intensity",
        "on_servo_friend_overwrite_volumetric_intensity")
    managers.event:register(self, "servo_friend_reset_volumetric_intensity", "on_servo_friend_reset_volumetric_intensity")
    -- Settings
    self:on_settings_changed()
    -- Debug
    self:print("ServoFriendFlashlightExtension initialized")
end

ServoFriendFlashlightExtension.destroy = function(self)
    -- Deinit
    self.user_state = nil
    -- Events
    managers.event:unregister(self, "servo_friend_overwrite_color")
    managers.event:unregister(self, "servo_friend_overwrite_volumetric_intensity")
    managers.event:unregister(self, "servo_friend_reset_color")
    managers.event:unregister(self, "servo_friend_reset_volumetric_intensity")
    -- Destroy
    self:destroy_locked_aiming_laser()
    self:destroy_flashlight()
    -- Debug
    self:print("ServoFriendFlashlightExtension destroyed")
    -- Base class
    ServoFriendFlashlightExtension.super.destroy(self)
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─ ###########################################################################################

ServoFriendFlashlightExtension.update = function(self, dt, t)
    -- Base class
    ServoFriendFlashlightExtension.super.update(self, dt, t)
    self:update_locked_aiming_laser(dt, t)
end

-- ##### ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ######################################################
-- ##### └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ └┐┌┘├┤ │││ │ └─┐ ######################################################
-- ##### └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘ └┘ └─┘┘└┘ ┴ └─┘ ######################################################

ServoFriendFlashlightExtension.on_settings_changed = function(self, setting_id)
    -- Base class
    ServoFriendFlashlightExtension.super.on_settings_changed(self)

    local servo_friend_extension = self.servo_friend_extension

    if not servo_friend_extension then
        self:destroy_locked_aiming_laser()
        return
    end

    local archetype_name = nil
    local red_setting_id = nil
    local green_setting_id = nil
    local blue_setting_id = nil

    if servo_friend_extension.archetype_name then
        archetype_name = servo_friend_extension:archetype_name()

        if archetype_name then
            red_setting_id = mod:get_archetype_setting_id(archetype_name, "mod_option_flashlight_color_red")
            green_setting_id = mod:get_archetype_setting_id(archetype_name, "mod_option_flashlight_color_green")
            blue_setting_id = mod:get_archetype_setting_id(archetype_name, "mod_option_flashlight_color_blue")
        end
    end

    -- Settings
    self.flashlight                = servo_friend_extension.flashlight
    self.flashlight_shadows        = servo_friend_extension.flashlight_shadows
    self.flashlight_type           = servo_friend_extension.flashlight_type
    self.flashlight_template       = flashlight_profiles[self.flashlight_type]
    self.r                         = servo_friend_extension.r
    self.g                         = servo_friend_extension.g
    self.b                         = servo_friend_extension.b

    self.locked_aiming_laser       = self.is_local_unit and servo_friend_extension.locked_aiming_laser or false
    self.locked_aiming_laser_sound = self.is_local_unit and servo_friend_extension.locked_aiming_laser_sound or false
    self.locked_aiming_laser_tags  = self.is_local_unit and servo_friend_extension.locked_aiming_laser_tags or false

    if not self.locked_aiming_laser then
        self:destroy_locked_aiming_laser()
    elseif not self.locked_aiming_laser_sound then
        self:destroy_locked_aiming_laser_sound()
    end

    local should_respawn = setting_id == nil or setting_id == "mod_option_flashlight_type"
    local color_changed  = setting_id == nil or
        setting_id == red_setting_id or
        setting_id == green_setting_id or
        setting_id == blue_setting_id

    if setting_id == "mod_option_flashlight" then
        self.user_state = nil
    end

    if should_respawn then
        self:respawn_flashlight()
        return
    end

    if not self.light then
        return
    end

    if setting_id == "mod_option_flashlight" then
        self:set_enabled()
    elseif color_changed then
        self:set_color(self.r, self.g, self.b)
    end
end

ServoFriendFlashlightExtension.on_servo_friend_spawned = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        ServoFriendFlashlightExtension.super.on_servo_friend_spawned(self)
        self:spawn_flashlight()
    end
end

ServoFriendFlashlightExtension.on_servo_friend_destroyed = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        ServoFriendFlashlightExtension.super.on_servo_friend_destroyed(self)
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

ServoFriendFlashlightExtension.on_servo_friend_overwrite_volumetric_intensity = function(self, value, servo_friend_unit,
                                                                                         player_unit)
    if self:is_me(servo_friend_unit) then
        self:set_volumetric_intensity(value)
    end
end

ServoFriendFlashlightExtension.on_servo_friend_reset_volumetric_intensity = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        self:set_volumetric_intensity()
    end
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

ServoFriendFlashlightExtension.wants_flashlight_on = function(self)
    if self.user_state ~= nil then
        return self.user_state
    end

    if self.flashlight == "always_on" then
        return true
    end

    if self.flashlight == "all_missions" then
        return not self:is_in_hub()
    end

    if self.flashlight == "only_dark_missions" then
        return not self:is_in_hub() and self.dark_mission
    end

    return false
end

ServoFriendFlashlightExtension.tag_enemy_laser_position = function(self)
    if not self.locked_aiming_laser_tags or not self.servo_friend_unit then
        return nil
    end

    local point_of_interest_extension = mod:servo_friend_extension(
        self.servo_friend_unit,
        "servo_friend_point_of_interest_system"
    )

    if not self:extension_valid(point_of_interest_extension) or not point_of_interest_extension.tag_enemy_laser_position then
        return nil
    end

    return point_of_interest_extension:tag_enemy_laser_position()
end

ServoFriendFlashlightExtension.wants_locked_aiming_laser = function(self)
    local servo_friend_extension = self.servo_friend_extension

    if not self.is_local_unit
        or not self.locked_aiming_laser
        or not self:flashlight_unit_alive()
        or not self:extension_valid(servo_friend_extension)
    then
        return false
    end

    if servo_friend_extension.is_aim_locked then
        return true
    end

    return self:tag_enemy_laser_position() ~= nil
end

ServoFriendFlashlightExtension.flashlight_unit_alive = function(self)
    return mod:is_unit_alive(self.flashlight_unit)
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

ServoFriendFlashlightExtension.spawn_flashlight = function(self)
    if self:is_initialized() and self:servo_friend_alive() and not self:flashlight_unit_alive() then
        local player_position = self:player_position()
        local flashlight_profile = flashlight_profiles[self.flashlight_type]

        if flashlight_profile then
            local flashlight_unit = flashlight_profile.unit
            self.flashlight_unit = world_spawn_unit_ex(self._world, flashlight_unit, nil, player_position,
                quaternion_identity())
            world_link_unit(self._world, self.flashlight_unit, 1, self.servo_friend_unit, 1)

            local offset = flashlight_profile.offset and vector3_unbox(flashlight_profile.offset) or vector3_zero()
            unit_set_local_position(self.flashlight_unit, 1, offset)

            self.light = unit_light(self.flashlight_unit, 1)
            self:set_light()
        end
    end
end

ServoFriendFlashlightExtension.destroy_flashlight = function(self)
    self:destroy_locked_aiming_laser()

    if self.light then
        light_set_enabled(self.light, false)
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

ServoFriendFlashlightExtension.set_enabled = function(self, play_feedback)
    if self.light then
        local enabled = self:wants_flashlight_on()

        light_set_enabled(self.light, enabled)

        if play_feedback and self.is_local_unit then
            if enabled then
                self:play_sound("selection")
            else
                self:play_sound("wrong")
            end
        end
    end
end

ServoFriendFlashlightExtension.set_light = function(self)
    if self.light then
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

ServoFriendFlashlightExtension.locked_aiming_laser_shooting_vector = function(self)
    local player_unit = self.player_unit
    local servo_friend_extension = self.servo_friend_extension
    local first_person_extension = servo_friend_extension and servo_friend_extension.first_person_extension or
        player_unit and script_unit_has_extension(player_unit, "first_person_system")
    local first_person_unit = servo_friend_extension and servo_friend_extension.first_person_unit or
        first_person_extension and first_person_extension:first_person_unit()

    if not mod:is_unit_alive(first_person_unit) then
        return nil, nil
    end

    local shoot_rotation = unit_world_rotation(first_person_unit, 1)
    local unit_data_extension = servo_friend_extension and servo_friend_extension.unit_data or
        player_unit and script_unit_has_extension(player_unit, "unit_data_system")
    local weapon_extension = player_unit and script_unit_has_extension(player_unit, "weapon_system")

    if unit_data_extension and weapon_extension then
        local movement_state_component = unit_data_extension:read_component("movement_state")
        local locomotion_component = unit_data_extension:read_component("locomotion")
        local inair_state_component = unit_data_extension:read_component("inair_state")
        local recoil_component = unit_data_extension:read_component("recoil")
        local sway_component = unit_data_extension:read_component("sway")

        shoot_rotation = Recoil.apply_weapon_recoil_rotation(
            weapon_extension:recoil_template(),
            recoil_component,
            movement_state_component,
            locomotion_component,
            inair_state_component,
            shoot_rotation
        )

        shoot_rotation = Sway.apply_sway_rotation(
            weapon_extension:sway_template(),
            sway_component,
            shoot_rotation
        )
    end

    return unit_world_position(first_person_unit, 1), quaternion_forward(shoot_rotation)
end

ServoFriendFlashlightExtension.locked_aiming_laser_crosshair_target_position = function(self)
    local shoot_position, shoot_direction = self:locked_aiming_laser_shooting_vector()

    if not shoot_position or not shoot_direction then
        return nil
    end

    local distance = laser_max_distance

    if self._physics_world then
        local hits = physics_world_raycast(
            self._physics_world,
            shoot_position,
            shoot_direction,
            laser_max_distance,
            "all",
            "collision_filter",
            "filter_debug_unit_selector"
        )

        if hits then
            for i = 1, #hits do
                local hit = hits[i]
                local hit_distance = hit and hit[hit_idx_distance]
                local hit_actor = hit and hit[hit_idx_actor]
                local hit_unit = hit_actor and actor_unit(hit_actor)

                if hit_unit
                    and hit_unit ~= self.player_unit
                    and hit_unit ~= self.servo_friend_unit
                    and hit_unit ~= self.flashlight_unit
                    and hit_distance
                    and hit_distance > laser_min_distance
                    and hit_distance < distance
                then
                    distance = hit_distance
                end
            end
        end
    end

    return shoot_position + shoot_direction * distance
end

ServoFriendFlashlightExtension.locked_aiming_laser_target_position = function(self)
    if self.locked_aiming_laser_tags then
        local tag_position = self:tag_enemy_laser_position()

        if tag_position then
            return tag_position
        end
    end

    local servo_friend_extension = self.servo_friend_extension

    if self:extension_valid(servo_friend_extension) and servo_friend_extension.is_aim_locked then
        return self:locked_aiming_laser_crosshair_target_position()
    end

    return nil
end

ServoFriendFlashlightExtension.spawn_locked_aiming_laser = function(self)
    if self.locked_aiming_laser_id or not self._world or not self:flashlight_unit_alive() then
        return
    end

    local muzzle_position = unit_world_position(self.flashlight_unit, 1)

    self.locked_aiming_laser_id = world_create_particles(self._world, laser_particle_name, muzzle_position)
    self.locked_aiming_laser_variable_index = world_find_particles_variable(
        self._world,
        laser_particle_name,
        laser_length_variable_name
    )
end

ServoFriendFlashlightExtension.destroy_locked_aiming_laser_sound = function(self)
    if self.locked_aiming_laser_source_id and self._wwise_world then
        wwise_world_trigger_resource_event(
            self._wwise_world,
            laser_stop_sound_event,
            self.locked_aiming_laser_source_id
        )
        wwise_world_destroy_manual_source(self._wwise_world, self.locked_aiming_laser_source_id)
    end

    self.locked_aiming_laser_source_id = nil
end

ServoFriendFlashlightExtension.destroy_locked_aiming_laser = function(self)
    self:destroy_locked_aiming_laser_sound()

    if self.locked_aiming_laser_id and self._world then
        world_destroy_particles(self._world, self.locked_aiming_laser_id)
    end

    self.locked_aiming_laser_id = nil
    self.locked_aiming_laser_variable_index = nil
end

ServoFriendFlashlightExtension.update_locked_aiming_laser_sound = function(self, muzzle_position, target_position)
    if not self.locked_aiming_laser_sound or not self._wwise_world then
        self:destroy_locked_aiming_laser_sound()
        return
    end

    local player_position = mod:is_unit_alive(self.player_unit) and unit_world_position(self.player_unit, 1) or
        muzzle_position
    local source_position = geometry_closest_point_on_line(player_position, muzzle_position, target_position)

    if not self.locked_aiming_laser_source_id then
        self.locked_aiming_laser_source_id = wwise_world_make_manual_source(
            self._wwise_world,
            source_position,
            quaternion_identity()
        )

        if self.locked_aiming_laser_source_id then
            wwise_world_trigger_resource_event(self._wwise_world, laser_sound_event, self.locked_aiming_laser_source_id)
        end
    else
        wwise_world_set_source_position(self._wwise_world, self.locked_aiming_laser_source_id, source_position)
    end
end

ServoFriendFlashlightExtension.update_locked_aiming_laser = function(self, dt, t)
    if not self:wants_locked_aiming_laser() then
        self:destroy_locked_aiming_laser()
        return
    end

    local target_position = self:locked_aiming_laser_target_position()

    if not target_position then
        self:destroy_locked_aiming_laser()
        return
    end

    self:spawn_locked_aiming_laser()

    if not self.locked_aiming_laser_id or not self:flashlight_unit_alive() then
        return
    end

    local muzzle_position = unit_world_position(self.flashlight_unit, 1)
    local distance = vector3_distance(muzzle_position, target_position)

    if distance <= 0.01 then
        return
    end

    world_move_particles(
        self._world,
        self.locked_aiming_laser_id,
        muzzle_position,
        quaternion_look(vector3_normalize(target_position - muzzle_position))
    )

    if self.locked_aiming_laser_variable_index then
        world_set_particles_variable(
            self._world,
            self.locked_aiming_laser_id,
            self.locked_aiming_laser_variable_index,
            vector3(laser_x, distance + laser_y_offset, laser_z)
        )
    end

    self:update_locked_aiming_laser_sound(muzzle_position, target_position)
end

mod.player_flashlight_toggle = function(self, player_unit, send)
    local pt = self:pt()

    player_unit = player_unit or self:local_player_unit()
    if not self:is_unit_alive(player_unit) then
        return
    end

    local player_unit_first_person_extension = script_unit_has_extension(player_unit, "first_person_system")
    local first_person_unit = player_unit_first_person_extension and player_unit_first_person_extension._unit
    local player_unit_servo_friend_extension = first_person_unit and pt.player_unit_extensions[first_person_unit]
    local servo_friend_unit = player_unit_servo_friend_extension and player_unit_servo_friend_extension
        .servo_friend_unit
    local flashlight_extension = servo_friend_unit and
        self:servo_friend_extension(servo_friend_unit, "servo_friend_flashlight_system")

    if flashlight_extension then
        flashlight_extension.user_state = not flashlight_extension:wants_flashlight_on()
        flashlight_extension:set_enabled(true)
    end
end

mod.flashlight_toggle = function()
    mod:player_flashlight_toggle(nil, true)
end

return ServoFriendFlashlightExtension
