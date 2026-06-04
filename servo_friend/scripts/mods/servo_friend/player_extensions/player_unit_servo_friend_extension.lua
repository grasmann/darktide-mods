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

mod.servo_friend_builtin_appearance_implementations = mod.servo_friend_builtin_appearance_implementations or {
    spineless = {
        unit = "content/environment/cinematic/servo_skull_scanning_static",
    },
    dominant = {
        unit = "content/weapons/player/pickups/pup_servo_skull_scanning/pup_servo_skull_scanning",
    },
    decoder = {
        unit = "content/weapons/player/pickups/pup_skull_decoder/pup_skull_decoder",
        corrective_rotation_z = 90,
    },
    decoder_2 = {
        unit = "content/weapons/player/pickups/pup_skull_decoder_02/pup_skull_decoder_02",
        corrective_rotation_z = 90,
    },
    nuncio_aquila = {
        unit = "content/weapons/player/ranged/drone_area_buff/wpn_drone_area_buff",
        corrective_rotation_z = -90,
        verified_hover_fwd_state = true,
    },
}

local PRIORITY_ORDER_SETTINGS = {
    balanced = { locked_aiming_priority = false, alert_mode_only_when_idle = false },
    focus_targets = { locked_aiming_priority = false, alert_mode_only_when_idle = true },
    locked_aiming = { locked_aiming_priority = true, alert_mode_only_when_idle = true },
    alerts = { locked_aiming_priority = true, alert_mode_only_when_idle = false },
}

local FOCUS_TAGS_AND_MARKERS_SETTINGS = {
    off = { tagged_enemies = false, tagged_items = false, world_markers = false },
    tagged_enemies = { tagged_enemies = true, tagged_items = false, world_markers = false },
    tagged_items = { tagged_enemies = false, tagged_items = true, world_markers = false },
    world_markers = { tagged_enemies = false, tagged_items = false, world_markers = true },
    tagged_enemies_and_items = { tagged_enemies = true, tagged_items = true, world_markers = false },
    tagged_enemies_and_world_markers = { tagged_enemies = true, tagged_items = false, world_markers = true },
    tagged_items_and_world_markers = { tagged_enemies = false, tagged_items = true, world_markers = true },
    all = { tagged_enemies = true, tagged_items = true, world_markers = true },
}

local function _append_unique_package(packages, seen_packages, package_name)
    if type(package_name) == "string" and package_name ~= "" and not seen_packages[package_name] then
        seen_packages[package_name] = true
        packages[#packages + 1] = package_name
    end
end

local function _merge_appearance_definition(target, source)
    if type(source) ~= "table" then
        return
    end

    local existing_packages = target.packages
    local merged_packages = {}
    local seen_packages = {}

    if type(existing_packages) == "table" then
        for i = 1, #existing_packages do
            _append_unique_package(merged_packages, seen_packages, existing_packages[i])
        end
    end

    for key, value in pairs(source) do
        if key ~= "packages" then
            target[key] = value
        end
    end

    if type(source.packages) == "table" then
        for i = 1, #source.packages do
            _append_unique_package(merged_packages, seen_packages, source.packages[i])
        end
    end

    if #merged_packages > 0 then
        target.packages = merged_packages
    end
end

local function _resolve_appearance_definition(self, appearance_name, appearance_definitions, resolving)
    if type(appearance_name) ~= "string" or appearance_name == "" then
        return nil
    end

    if resolving[appearance_name] then
        return nil
    end

    resolving[appearance_name] = true

    local appearance_definition = appearance_definitions and appearance_definitions[appearance_name] or nil
    local builtin_definition = self.servo_friend_builtin_appearance_implementations and
        self.servo_friend_builtin_appearance_implementations[appearance_name] or nil

    if not appearance_definition and not builtin_definition then
        resolving[appearance_name] = nil
        return nil
    end

    local merged_definition = {}
    local base_appearance = appearance_definition and appearance_definition.base_appearance or
        builtin_definition and builtin_definition.base_appearance or nil

    if type(base_appearance) == "string" and base_appearance ~= "" and base_appearance ~= appearance_name then
        local base_definition = _resolve_appearance_definition(self, base_appearance, appearance_definitions, resolving)

        _merge_appearance_definition(merged_definition, base_definition)
    end

    _merge_appearance_definition(merged_definition, builtin_definition)
    _merge_appearance_definition(merged_definition, appearance_definition)

    merged_definition.name = appearance_name
    resolving[appearance_name] = nil

    return merged_definition
end

mod.servo_friend_get_appearance_definition = function(self, appearance_name)
    local appearance_definitions = self:servo_friend_build_appearance_registry()

    return _resolve_appearance_definition(self, appearance_name, appearance_definitions, {})
end

mod.servo_friend_get_spawnable_appearance_names = mod.servo_friend_get_spawnable_appearance_names or function(self)
    local _, appearance_names = self:servo_friend_build_appearance_registry()
    local spawnable_appearance_names = {}

    for i = 1, #appearance_names do
        local appearance_name = appearance_names[i]
        local appearance_definition = self:servo_friend_get_appearance_definition(appearance_name)

        if appearance_definition and type(appearance_definition.unit) == "string" and appearance_definition.unit ~= "" then
            spawnable_appearance_names[#spawnable_appearance_names + 1] = appearance_name
        end
    end

    return spawnable_appearance_names
end

mod.servo_friend_register_appearance_packages = function(self)
    local appearance_names = self:servo_friend_get_spawnable_appearance_names()
    local packages_to_load = {}
    local seen_packages = {}

    local function add_package(package_name)
        if type(package_name) == "string" and package_name ~= "" and not seen_packages[package_name] then
            seen_packages[package_name] = true
            packages_to_load[#packages_to_load + 1] = package_name
        end
    end

    local function add_package_list(package_list)
        if type(package_list) ~= "table" then
            return
        end

        for i = 1, #package_list do
            add_package(package_list[i])
        end
    end

    local function add_decoration_packages(decoration)
        if type(decoration) ~= "table" then
            return
        end

        add_package(decoration.unit)
        add_package_list(decoration.packages)
    end

    for i = 1, #appearance_names do
        local appearance_definition = self:servo_friend_get_appearance_definition(appearance_names[i])

        if appearance_definition then
            add_package(appearance_definition.unit)
            add_package_list(appearance_definition.packages)

            if type(appearance_definition.decorations) == "table" then
                for j = 1, #appearance_definition.decorations do
                    add_decoration_packages(appearance_definition.decorations[j])
                end
            end
        end
    end

    self:register_packages(packages_to_load)

    return packages_to_load
end

mod:servo_friend_register_appearance_packages()

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

PlayerUnitServoFriendExtension.appearance_definition = function(self)
    return mod:servo_friend_get_appearance_definition(self.appearance)
end

PlayerUnitServoFriendExtension.default_appearance_name = function(self)
    local default_appearance_name = mod:servo_friend_get_default_appearance_name()
    local appearance_definition = mod:servo_friend_get_appearance_definition(default_appearance_name)

    if appearance_definition and appearance_definition.unit then
        return appearance_definition.name
    end

    local spawnable_appearance_names = mod:servo_friend_get_spawnable_appearance_names()

    return spawnable_appearance_names[1] or "spineless"
end

PlayerUnitServoFriendExtension.validate_appearance_name = function(self, appearance_name)
    if appearance_name == "off" then
        return "off"
    end

    local appearance_definition = appearance_name and mod:servo_friend_get_appearance_definition(appearance_name) or nil

    if appearance_definition and appearance_definition.unit then
        return appearance_definition.name
    end

    return self:default_appearance_name()
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
    self.locked_aiming_laser = false
    self.locked_aiming_laser_sound = false
    self.locked_aiming_laser_tags = false
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
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─ ###########################################################################################

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

    local appearance_definition = self:appearance_definition()

    if not appearance_definition or not appearance_definition.verified_hover_fwd_state then
        return
    end

    unit_animation_event(self.servo_friend_unit, "hover_fwd")
end

PlayerUnitServoFriendExtension.spawn_servo_friend = function(self, dt, t)
    if self:is_initialized() and self:all_packages_loaded() and not self:servo_friend_alive() then
        if self.appearance == "off" then
            return
        end

        self:print("Spawning servo_friend")

        local appearance_definition = self:appearance_definition()

        if not appearance_definition or type(appearance_definition.unit) ~= "string" or appearance_definition.unit == "" then
            self.appearance = self:default_appearance_name()
            appearance_definition = self:appearance_definition()
        end

        if not appearance_definition or type(appearance_definition.unit) ~= "string" or appearance_definition.unit == "" then
            return
        end

        local player_position = self:player_position()
        local rotation = quaternion_identity()

        self.servo_friend_unit = world_spawn_unit_ex(self._world, appearance_definition.unit, nil, player_position,
            rotation)

        self:add_extensions()
        self:extensions_settings_changed()
        self:activate_special_appearance_state()

        local corrective_rotation_z = appearance_definition.corrective_rotation_z
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
-- #####  ││├┤ └─┐ │ ├┬┘│ │└┬┘  ########################################################################################
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

PlayerUnitServoFriendExtension.on_settings_changed = function(self, setting_id)
    local archetype_name = self:archetype_name()
    local appearance_setting_id = nil

    if archetype_name then
        appearance_setting_id = mod:get_archetype_setting_id(archetype_name, "mod_option_appearance")
    end

    self.flashlight    = mod:get("mod_option_flashlight")

    local type_setting = mod:get("mod_option_flashlight_type")

    if type_setting == "small_quality" then
        self.flashlight_type    = "small"
        self.flashlight_shadows = true
    elseif type_setting == "large_quality" then
        self.flashlight_type    = "large"
        self.flashlight_shadows = true
    elseif type_setting == "large_default" then
        self.flashlight_type    = "large"
        self.flashlight_shadows = false
    else -- "small_default" or nil
        self.flashlight_type    = "small"
        self.flashlight_shadows = false
    end

    self.r                       = mod:get_archetype_setting("mod_option_flashlight_color_red", archetype_name)
    self.g                       = mod:get_archetype_setting("mod_option_flashlight_color_green", archetype_name)
    self.b                       = mod:get_archetype_setting("mod_option_flashlight_color_blue", archetype_name)

    local focus_tags_and_markers = mod:get("mod_option_focus_tags_and_markers") or "all"
    local focus_settings         = FOCUS_TAGS_AND_MARKERS_SETTINGS[focus_tags_and_markers] or
        FOCUS_TAGS_AND_MARKERS_SETTINGS.all

    self.focus_tagged_enemies    = focus_settings.tagged_enemies
    self.focus_tagged_items      = focus_settings.tagged_items
    self.focus_world_markers     = focus_settings.world_markers

    if self.is_local_unit then
        self.only_own_tags = mod:get("mod_option_only_own_tags") == "only_mine"
    else
        self.only_own_tags = true
    end

    self.roaming_area              = mod:get("mod_option_roaming_area") or 0
    self.use_free_roaming          = self.roaming_area > 0
    self.use_roaming_area          = self.roaming_area > 0

    local locked_aiming_setting    = mod:get("mod_option_locked_aiming")
    local locked_aiming_laser      = locked_aiming_setting == "on_with_laser" or
        locked_aiming_setting == "on_with_laser_and_sound" or
        locked_aiming_setting == "on_with_laser_and_tags" or
        locked_aiming_setting == "on_with_laser_and_tags_and_sound"
    local locked_aiming_laser_tags = locked_aiming_setting == "on_with_laser_and_tags" or
        locked_aiming_setting == "on_with_laser_and_tags_and_sound"

    self.locked_aiming             = locked_aiming_setting == "on"
        or locked_aiming_setting == "on_with_sound"
        or locked_aiming_laser
        or locked_aiming_setting == true
    self.locked_aiming_laser       = self.is_local_unit and locked_aiming_laser or false
    self.locked_aiming_laser_sound = self.is_local_unit and (
        locked_aiming_setting == "on_with_laser_and_sound" or
        locked_aiming_setting == "on_with_laser_and_tags_and_sound"
    ) or false
    self.locked_aiming_laser_tags  = self.is_local_unit and locked_aiming_laser_tags or false

    local priority_order           = mod:get("mod_option_priority_order") or "balanced"
    local priority_settings        = PRIORITY_ORDER_SETTINGS[priority_order] or PRIORITY_ORDER_SETTINGS.balanced

    self.locked_aiming_priority    = priority_settings.locked_aiming_priority
    self.alert_mode_only_when_idle = priority_settings.alert_mode_only_when_idle

    if self.is_local_unit then
        self.aim_sound = (locked_aiming_setting == "on_with_sound" or mod:get("mod_option_aim_sound") == true)
    else
        self.aim_sound = false
    end

    self.debug                  = mod:get("mod_option_debug")

    local focus_self            = mod:get("mod_option_focus_self") or "both"

    self.self_focus_on_block    = focus_self == "block" or focus_self == "both"
    self.self_focus_on_vent     = focus_self == "vent" or focus_self == "both"

    self.hover_sound_effect     = mod:get("mod_option_hover_sound_effect")
    self.hover_particle_effect  = true

    self.appearance             = self:validate_appearance_name(mod:get_archetype_setting("mod_option_appearance",
        archetype_name))

    self.avoid_daemonhost       = mod:get("mod_option_avoid_daemonhost")
    self.avoid_going_into_walls = mod:get("mod_option_avoid_going_into_walls")

    local alert_mode            = mod:get("mod_option_alert_mode") or "off"

    if not self.is_local_unit then
        if alert_mode == "sound" then
            alert_mode = "off"
        elseif alert_mode == "lights_and_sound" then
            alert_mode = "lights"
        end
    end

    self.alert_mode        = alert_mode ~= "off"
    self.alert_mode_lights = alert_mode == "lights" or alert_mode == "lights_and_sound"
    self.alert_mode_sound  = alert_mode == "sound" or alert_mode == "lights_and_sound"

    if setting_id == appearance_setting_id then
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
-- #####  ┴ ┴┴ ┴└─  ###################################################################################################

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
