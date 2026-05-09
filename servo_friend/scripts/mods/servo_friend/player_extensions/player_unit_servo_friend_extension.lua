-- File: servo_friend/scripts/mods/servo_friend/player_extensions/player_unit_servo_friend_extension.lua
local mod = get_mod("servo_friend")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local unit = Unit
local type = type
local pairs = pairs
local class = class
local CLASS = CLASS
local world = World
local table = table
local vector3 = Vector3
local managers = Managers
local math_clamp = math.clamp
local table_size = table.size
local quaternion = Quaternion
local script_unit = ScriptUnit
local vector3_box = Vector3Box
local math_random = math.random
local vector3_zero = vector3.zero
local quaternion_box = QuaternionBox
local world_destroy_unit = world.destroy_unit
local quaternion_identity = quaternion.identity
local world_spawn_unit_ex = world.spawn_unit_ex
local unit_set_local_rotation = unit.set_local_rotation
local unit_animation_event = unit.animation_event
local script_unit_extension = script_unit.extension
local quaternion_from_euler_angles_xyz = quaternion.from_euler_angles_xyz

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local spineless_servo_friend_unit = "content/environment/cinematic/servo_skull_scanning_static"
local dominant_servo_friend_unit = "content/weapons/player/pickups/pup_servo_skull_scanning/pup_servo_skull_scanning"
local decoder_servo_friend_unit = "content/weapons/player/pickups/pup_skull_decoder/pup_skull_decoder"
local decoder_2_servo_friend_unit = "content/weapons/player/pickups/pup_skull_decoder_02/pup_skull_decoder_02"
local nuncio_aquila_servo_friend_unit = "content/weapons/player/ranged/drone_area_buff/wpn_drone_area_buff"

local servo_friend_units = {
    spineless = spineless_servo_friend_unit,
    dominant = dominant_servo_friend_unit,
    decoder = decoder_servo_friend_unit,
    decoder_2 = decoder_2_servo_friend_unit,
    nuncio_aquila = nuncio_aquila_servo_friend_unit
}

local servo_friend_rotation_z_by_appearance = {
    decoder = 90,
    decoder_2 = 90,
    nuncio_aquila = -90,
}

local packages_to_load = {
    spineless_servo_friend_unit,
    dominant_servo_friend_unit,
    decoder_servo_friend_unit,
    decoder_2_servo_friend_unit,
    nuncio_aquila_servo_friend_unit,
}

local appearances_with_verified_hover_fwd_state = {
    nuncio_aquila = true,
}

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local PlayerUnitServoFriendExtension = class("PlayerUnitServoFriendExtension")

-- Inject external logic into extension prototype
mod:io_dofile("servo_friend/scripts/mods/servo_friend/player_extensions/player_unit_servo_friend_state")(
    PlayerUnitServoFriendExtension)
mod:io_dofile("servo_friend/scripts/mods/servo_friend/player_extensions/player_unit_servo_friend_movement")(
    PlayerUnitServoFriendExtension)
mod:io_dofile("servo_friend/scripts/mods/servo_friend/player_extensions/player_unit_servo_friend_aim")(
    PlayerUnitServoFriendExtension)

mod:register_packages(packages_to_load)

PlayerUnitServoFriendExtension.print = function(self, message)
    mod:print(message)
end

PlayerUnitServoFriendExtension.pt = function(self)
    return mod:pt()
end

PlayerUnitServoFriendExtension.is_initialized = function(self)
    return mod.initialized and self.initialized
end

PlayerUnitServoFriendExtension.is_unit_alive = function(self, unit)
    return mod:is_unit_alive(unit)
end

PlayerUnitServoFriendExtension.clamped_dt = function(self, dt, multiplier)
    return math_clamp(dt, 0, 1) * multiplier
end

-- ##### ┬┌┐┌┬┌┬┐       ┌┬┐┌─┐┌─┐┌┬┐┬─┐┌─┐┬ ┬ #########################################################################
-- ##### │││││ │   ───   ││├┤ └─┐ │ ├┬┘│ │└┬┘ #########################################################################
-- ##### ┴┘└┘┴ ┴        ─┴┘└─┘└─┘ ┴ ┴└─└─┘ ┴  #########################################################################

PlayerUnitServoFriendExtension.init = function(self, extension_init_context, unit, extension_init_data)
    -- References
    self.world_manager = managers.world
    self.package_manager = managers.package
    self.time_manager = managers.time

    -- Worlds
    self.hub = self:is_in_hub()
    self._world = self:world()
    self._physics_world = self:physics_world()
    self._wwise_world = self:wwise_world()

    -- Extensions
    self.unit_data = script_unit_extension(unit, "unit_data_system")
    self.alternate_fire_component = self.unit_data and self.unit_data:read_component("alternate_fire")
    self.first_person_extension = script_unit_extension(unit, "first_person_system")
    self.weapon_action_component = self.unit_data:read_component("weapon_action")
    self.sprint_character_state_component = self.unit_data and self.unit_data:read_component("sprint_character_state")
    self.hub_jog_character_state = self.unit_data and self.unit_data:read_component("hub_jog_character_state")
    self.movement_state_component = self.unit_data and self.unit_data:read_component("movement_state")
    self.locomotion_extension = script_unit_extension(unit, "locomotion_system")

    -- Units
    self.unit = unit
    self.player_unit = unit
    self.is_local_unit = extension_init_data.is_local_unit
    self.servo_friend_unit = nil
    self.first_person_unit = self.first_person_extension:first_person_unit()
    self._archetype_name = nil

    -- Position
    self.current_position = vector3_box(vector3_zero())
    self.last_position = vector3_box(vector3_zero())
    self.target_position = vector3_box(vector3_zero())
    self.aim_position = vector3_box(vector3_zero())

    -- Daemonhost
    self.avoid_daemonhost_position = vector3_box(vector3_zero())
    self.check_daemonhosts_timer = 0
    self.check_daemonhosts_time = 5
    self.daemonhosts = {}

    -- Leaning
    self.lean = 0
    self.prev_direction = vector3_box(vector3_zero())

    -- Aim
    self.current_rotation = quaternion_box(quaternion_identity())
    self.target_rotation = quaternion_box(quaternion_identity())
    self.last_rotation = quaternion_box(quaternion_identity())

    -- Data
    self.init_context = extension_init_context
    self.init_data = extension_init_data
    self.found_something_valid = false
    self.busy = false
    self.is_aim_locked = false
    self.max_distance = 20
    self.min_distance = 10
    self.position_was_corrected = false
    self.character_height = self.first_person_extension:extrapolated_character_height()

    -- Events
    managers.event:register(self, "servo_friend_set_target_position", "on_servo_friend_set_target_position")

    -- Init
    self.initialized = true
    self:on_settings_changed()
    self:print("PlayerUnitServoFriendExtension initialized")
end

PlayerUnitServoFriendExtension.p2p_command = function(self, command, target, data)
    return mod:p2p_command(command, target, data)
end

PlayerUnitServoFriendExtension.destroy = function(self)
    self.initialized = false
    managers.event:unregister(self, "servo_friend_set_target_position")
    self:destroy_servo_friend()
    self:print("PlayerUnitServoFriendExtension destroyed")
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

PlayerUnitServoFriendExtension.all_packages_loaded = function(self)
    local pt = self:pt()
    return pt.all_packages_loaded
end

PlayerUnitServoFriendExtension.update = function(self, dt, t)
    if self:is_initialized() and self:all_packages_loaded() and not self.appearance_changed then
        self:spawn_servo_friend(dt, t)
    else
        self:destroy_servo_friend()
    end

    if self:servo_friend_alive() then
        self:update_extensions(dt, t)
        self:update_movement(dt, t)
        self:update_aim(dt, t)
        self:check_for_daemonhosts(dt, t)
    end
end

PlayerUnitServoFriendExtension.extensions_settings_changed = function(self, setting_id)
    if self:servo_friend_alive() then
        local pt = self:pt()
        if pt.loaded_extensions[self.servo_friend_unit] and table_size(pt.loaded_extensions[self.servo_friend_unit]) > 0 then
            for system, extension in pairs(pt.loaded_extensions[self.servo_friend_unit]) do
                if self:extension_valid(extension) and extension.on_settings_changed then
                    extension:on_settings_changed(setting_id)
                end
            end
        end
    end
end

PlayerUnitServoFriendExtension.update_extensions = function(self, dt, t)
    if self:servo_friend_alive() then
        local pt = self:pt()
        if pt.loaded_extensions[self.servo_friend_unit] and table_size(pt.loaded_extensions[self.servo_friend_unit]) > 0 then
            for system, extension in pairs(pt.loaded_extensions[self.servo_friend_unit]) do
                if self:extension_valid(extension) and extension.update then
                    extension:update(dt, t)
                end
            end
        end
    end
end

PlayerUnitServoFriendExtension.execute_extensions = function(self, function_name, ...)
    if self:servo_friend_alive() then
        local pt = self:pt()
        if pt.loaded_extensions[self.servo_friend_unit] and table_size(pt.loaded_extensions[self.servo_friend_unit]) > 0 then
            for system, extension in pairs(pt.loaded_extensions[self.servo_friend_unit]) do
                if self:extension_valid(extension) and type(extension[function_name]) == "function" then
                    return extension[function_name](extension, ...)
                end
            end
        end
    end
end

PlayerUnitServoFriendExtension.remove_extensions = function(self)
    if self:servo_friend_alive() then
        local pt = self:pt()
        if pt.loaded_extensions[self.servo_friend_unit] and table_size(pt.loaded_extensions[self.servo_friend_unit]) > 0 then
            for system, extension in pairs(pt.loaded_extensions[self.servo_friend_unit]) do
                mod:execute_extension(self.servo_friend_unit, system, "destroy")
                self:servo_friend_remove_extension(self.servo_friend_unit, system)
            end
            pt.loaded_extensions[self.servo_friend_unit] = nil
        end
    end
end

PlayerUnitServoFriendExtension.add_extensions = function(self)
    if self:servo_friend_alive() then
        local pt = self:pt()
        for extension_name, system_name in pairs(pt.systems) do
            if not self:servo_friend_extension(self.servo_friend_unit, system_name) then
                self:servo_friend_add_extension(self.servo_friend_unit, system_name, nil, {
                    player_unit = self.unit,
                    is_local_unit = self.is_local_unit,
                })
            end
        end
    end
end

PlayerUnitServoFriendExtension.servo_friend_alive = function(self)
    return self:is_unit_alive(self.servo_friend_unit)
end

-- ##### ┌─┐┌─┐┌─┐┬ ┬┌┐┌ ##############################################################################################
-- ##### └─┐├─┘├─┤││││││ ##############################################################################################
-- ##### └─┘┴  ┴ ┴└┴┘┘└┘ ##############################################################################################

PlayerUnitServoFriendExtension.respawn_servo_friend = function(self, dt, t)
    self:destroy_servo_friend()
    self:spawn_servo_friend(dt, t)
end

PlayerUnitServoFriendExtension.activate_special_appearance_state = function(self)
    if not self:servo_friend_alive() then
        return
    end

    if not appearances_with_verified_hover_fwd_state[self.appearance] then
        return
    end

    unit_animation_event(self.servo_friend_unit, "hover_fwd")
end

PlayerUnitServoFriendExtension.spawn_servo_friend = function(self, dt, t)
    if self:is_initialized() and self:all_packages_loaded() and not self:servo_friend_alive() then
        self:print("Spawning servo_friend")

        local player_position = self:player_position()
        local servo_friend_unit = servo_friend_units[self.appearance]
        local rotation = quaternion_identity()

        self.servo_friend_unit = world_spawn_unit_ex(self._world, servo_friend_unit, nil, player_position, rotation)

        self:add_extensions()
        self:extensions_settings_changed()
        self:activate_special_appearance_state()

        local corrective_rotation_z = servo_friend_rotation_z_by_appearance[self.appearance]
        if corrective_rotation_z ~= nil then
            unit_set_local_rotation(self.servo_friend_unit, 3,
                quaternion_from_euler_angles_xyz(0, 0, corrective_rotation_z))
        end

        self.current_position:store(player_position)
        self:set_target_position(self:new_target_position())

        managers.event:trigger("servo_friend_talk", dt, t, "spawned", self.servo_friend_unit, self.player_unit)
        managers.event:trigger("servo_friend_spawned", self.servo_friend_unit, self.player_unit)
    end
end

-- ##### ┌┬┐┌─┐┌─┐┌┬┐┬─┐┌─┐┬ ┬ ########################################################################################
-- #####  ││├┤ └─┐ │ ├┬┘│ │└┬┘ ########################################################################################
-- ##### ─┴┘└─┘└─┘ ┴ ┴└─└─┘ ┴  ########################################################################################

PlayerUnitServoFriendExtension.destroy_servo_friend = function(self)
    self:print("Destroying servo_friend")

    if self:servo_friend_alive() then
        managers.event:trigger("servo_friend_destroyed", self.servo_friend_unit, self.player_unit)
        self:remove_extensions()
        world_destroy_unit(self._world, self.servo_friend_unit)
    end

    self.servo_friend_unit = nil
    self.appearance_changed = nil
end

-- ##### ┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ######################################################
-- ##### └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ └┐┌┘├┤ │││ │ └─┐ ######################################################
-- ##### └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘ └┘ └─┘┘└┘ ┴ └─┘ ######################################################

PlayerUnitServoFriendExtension.random_option = function(self, values)
    return mod:random_option(values)
end

PlayerUnitServoFriendExtension.on_settings_changed = function(self, setting_id)
    local archetype_name = self:archetype_name()
    local appearance_setting_id = nil
    local hover_particle_effect_setting_id = nil

    if self.is_local_unit and archetype_name then
        appearance_setting_id = mod:get_archetype_setting_id(archetype_name, "mod_option_appearance")
        hover_particle_effect_setting_id = mod:get_archetype_setting_id(archetype_name,
            "mod_option_hover_particle_effect")
    end

    self.flashlight         = mod:get("mod_option_flashlight")
    self.flashlight_shadows = mod:get("mod_option_flashlight_shadows")
    self.flashlight_no_hub  = mod:get("mod_option_flashlight_no_hub")
    self.flashlight_type    = mod:get("mod_option_flashlight_type")

    if self.is_local_unit then
        self.r = mod:get_archetype_setting("mod_option_flashlight_color_red", archetype_name)
        self.g = mod:get_archetype_setting("mod_option_flashlight_color_green", archetype_name)
        self.b = mod:get_archetype_setting("mod_option_flashlight_color_blue", archetype_name)
    else
        self.r = math_random(.5, 1)
        self.g = math_random(.5, 1)
        self.b = math_random(.5, 1)
    end

    if not self.is_local_unit then
        self.flashlight        = self:random_option({ "always_on", "only_dark_missions", "off" })
        self.flashlight_no_hub = true
        self.flashlight_type   = self:random_option({ "small", "large" })
    end

    self.focus_tagged_enemies = mod:get("mod_option_focus_tagged_enemies")
    self.focus_tagged_items   = mod:get("mod_option_focus_tagged_items")
    self.focus_world_markers  = mod:get("mod_option_focus_world_markers")
    self.only_own_tags        = mod:get("mod_option_only_own_tags")

    if not self.is_local_unit then
        self.focus_tagged_enemies = math_random(0, 1) > 0.5
        self.focus_tagged_items   = math_random(0, 1) > 0.5
        self.focus_world_markers  = math_random(0, 1) > 0.5
        self.only_own_tags        = math_random(0, 1) > 0.5
    end

    self.use_free_roaming = mod:get("mod_option_use_free_roaming")

    if not self.is_local_unit then
        self.use_free_roaming = math_random(0, 1) > 0.5
    end

    self.locked_aiming          = mod:get("mod_option_locked_aiming")
    self.locked_aiming_priority = mod:get("mod_option_locked_aiming_priority")
    self.aim_sound              = mod:get("mod_option_aim_sound")
    self.self_focus_on_block    = mod:get("mod_option_focus_self_on_block")
    self.self_focus_on_vent     = mod:get("mod_option_focus_self_on_vent")
    self.debug                  = mod:get("mod_option_debug")
    self.use_roaming_area       = mod:get("mod_option_use_roaming_area")
    self.roaming_area           = mod:get("mod_option_roaming_area")

    self.hover_sound_effect     = mod:get("mod_option_hover_sound_effect")

    if self.is_local_unit then
        self.appearance = mod:get_archetype_setting("mod_option_appearance", archetype_name)
        self.hover_particle_effect = mod:get_archetype_setting("mod_option_hover_particle_effect", archetype_name)
    else
        self.appearance             = self:random_option({ "spineless", "dominant", "decoder", "decoder_2",
            "nuncio_aquila" })
        self.hover_particle_effect  = math_random(0, 1) > 0.5
        self.locked_aiming          = math_random(0, 1) > 0.5
        self.locked_aiming_priority = math_random(0, 1) > 0.5
        self.aim_sound              = math_random(0, 1) > 0.5
        self.self_focus_on_block    = math_random(0, 1) > 0.5
        self.self_focus_on_vent     = math_random(0, 1) > 0.5
        self.use_roaming_area       = math_random(0, 1) > 0.5
        self.roaming_area           = math_random(5, 20)
    end

    self.avoid_daemonhost          = mod:get("mod_option_avoid_daemonhost")
    self.avoid_going_into_walls    = mod:get("mod_option_avoid_going_into_walls")

    self.alert_mode                = mod:get("mod_option_alert_mode")
    self.alert_mode_lights         = mod:get("mod_option_alert_mode_lights")
    self.alert_mode_sound          = mod:get("mod_option_alert_mode_sound")
    self.alert_mode_only_when_idle = mod:get("mod_option_alert_mode_only_when_idle")

    if not self.is_local_unit then
        self.alert_mode_lights = math_random(0, 1) > 0.5
        self.alert_mode_only_when_idle = math_random(0, 1) > 0.5
    end

    if self.is_local_unit and setting_id == appearance_setting_id then
        self.appearance_changed = true
    end

    if self.is_local_unit and setting_id == hover_particle_effect_setting_id then
        self.appearance_changed = true
    end

    self.busy = false
    self:extensions_settings_changed(setting_id)
end

PlayerUnitServoFriendExtension.on_servo_friend_set_target_position = function(self, target_position, aim_position,
                                                                              something_valid, busy,
                                                                              disable_lean_altitude)
    self.found_something_valid = something_valid
    self.busy = busy
    self.disable_lean_altitude = disable_lean_altitude or false
    if target_position then self:set_target_position(target_position) end
    if aim_position then self:set_aim_position(aim_position) end
end

-- ##### ┌─┐┌─┐┬ ┬┌┐┌┌┬┐┌─┐ ###########################################################################################
-- ##### └─┐│ ││ ││││ ││└─┐ ###########################################################################################
-- ##### └─┘└─┘└─┘┘└┘─┴┘└─┘ ###########################################################################################

PlayerUnitServoFriendExtension.play_sound = function(self, sound_event, optional_source_id, position)
    return mod:play_sound(sound_event, optional_source_id, position)
end

-- ##### ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌┌─┐ ############################################
-- ##### └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││└─┐ ############################################
-- ##### └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘└─┘ ############################################

PlayerUnitServoFriendExtension.servo_friend_extension = function(self, unit, system_or_extension)
    return mod:servo_friend_extension(unit, system_or_extension)
end

PlayerUnitServoFriendExtension.servo_friend_add_extension = function(self, unit, system, extension_init_context,
                                                                     extension_init_data)
    return mod:servo_friend_add_extension(unit, system, extension_init_context, extension_init_data)
end

PlayerUnitServoFriendExtension.servo_friend_remove_extension = function(self, unit, system)
    return mod:servo_friend_remove_extension(unit, system)
end

-- ##### ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌┌─┐ ################################################################################
-- ##### ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││└─┐ ################################################################################
-- ##### └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘└─┘ ################################################################################

PlayerUnitServoFriendExtension.extension_valid = function(self, extension)
    return mod:extension_valid(extension)
end

PlayerUnitServoFriendExtension.add_extension = function(self, unit, system, extension_init_context, extension_init_data)
    return mod:add_extension(unit, system, extension_init_context, extension_init_data)
end

PlayerUnitServoFriendExtension.remove_extension = function(self, unit, system)
    return mod:remove_extension(unit, system)
end

PlayerUnitServoFriendExtension.execute_extension = function(self, unit, system, function_name, ...)
    return mod:execute_extension(unit, system, function_name, ...)
end

-- ##### ┌┬┐┬┌┬┐┌─┐ ###################################################################################################
-- #####  │ ││││├┤  ###################################################################################################
-- #####  ┴ ┴┴ ┴└─┘ ###################################################################################################

PlayerUnitServoFriendExtension.time = function(self)
    return mod:game_time() or mod:main_time()
end

PlayerUnitServoFriendExtension.delta_time = function(self)
    return mod:game_delta_time() or mod:main_delta_time()
end

-- ##### ┬ ┬┌─┐┌─┐┬┌─┌─┐ ##############################################################################################
-- ##### ├─┤│ ││ │├┴┐└─┐ ##############################################################################################
-- ##### ┴ ┴└─┘└─┘┴ ┴└─┘ ##############################################################################################

mod:hook(CLASS.PlayerHuskFirstPersonExtension, "extensions_ready", function(func, self, world, unit, ...)
    func(self, world, unit, ...)
    mod:initialize_player_unit(self)
end)

mod:hook(CLASS.PlayerHuskFirstPersonExtension, "destroy", function(func, self, ...)
    mod:destroy_player_unit(self._unit)
    func(self, ...)
end)

mod:hook(CLASS.PlayerHuskFirstPersonExtension, "update", function(func, self, unit, dt, t, ...)
    func(self, unit, dt, t, ...)
    mod:update_player_unit(self, dt, t)
end)

mod:hook(CLASS.PlayerUnitFirstPersonExtension, "extensions_ready", function(func, self, world, unit, ...)
    func(self, world, unit, ...)
    mod:initialize_player_unit(self)
end)

mod:hook(CLASS.PlayerUnitFirstPersonExtension, "destroy", function(func, self, ...)
    mod:destroy_player_unit(self._unit)
    func(self, ...)
end)

mod:hook(CLASS.PlayerUnitFirstPersonExtension, "update", function(func, self, unit, dt, t, ...)
    func(self, unit, dt, t, ...)
    mod:update_player_unit(self, dt, t)
end)

return PlayerUnitServoFriendExtension
