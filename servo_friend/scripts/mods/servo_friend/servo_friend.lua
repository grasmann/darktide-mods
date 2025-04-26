local mod = get_mod("servo_friend")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local math = math
local unit = Unit
local table = table
local pairs = pairs
local CLASS = CLASS
local world = World
local actor = Actor
local vector3 = Vector3
local callback = callback
local managers = Managers
local math_abs = math.abs
local actor_unit = actor.unit
local unit_alive = unit.alive
local table_size = table.size
local quaternion = Quaternion
local wwise_world = WwiseWorld
local script_unit = ScriptUnit
local vector3_box = Vector3Box
local math_random = math.random
local vector3_dot = vector3.dot
local table_clear = table.clear
local vector3_zero = vector3.zero
local physics_world = PhysicsWorld
local vector3_length = vector3.length
local vector3_unbox = vector3_box.unbox
local vector3_normalize = vector3.normalize
local quaternion_forward = quaternion.forward
local unit_local_rotation = unit.local_rotation
local unit_world_position = unit.world_position
local world_physics_world = world.physics_world
local physics_world_raycast = physics_world.raycast
local script_unit_extension = script_unit.extension
local script_unit_has_extension = script_unit.has_extension
local script_unit_add_extension = script_unit.add_extension
local script_unit_remove_extension = script_unit.remove_extension
local wwise_world_make_auto_source = wwise_world.make_auto_source
local wwise_world_trigger_resource_event = wwise_world.trigger_resource_event

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "servo_friend"
local packages_to_load = {}

mod:persistent_table(REFERENCE, {
    player_unit_extensions = {},
    loaded_extensions = {},
    finished_loading = {},
    loaded_packages = {},
    sound_events = {},
    extensions = {},
    systems = {},
})

mod.print = function(self, message)
    if self.debug then self:echo(message) end
end

mod.register_persistent_data = function(self, key, data, overwrite)
    local pt = self:pt()
    if not pt[key] or overwrite then
        pt[key] = data
    end
end

-- ##### ┌┬┐┌┬┐┌─┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ###############################################################################
-- #####  │││││├┤   ├┤ └┐┌┘├┤ │││ │ └─┐ ###############################################################################
-- ##### ─┴┘┴ ┴└    └─┘ └┘ └─┘┘└┘ ┴ └─┘ ###############################################################################

mod.on_all_mods_loaded = function()
    mod:init()
end

mod.on_unload = function(exit_game)
    mod:deinit()
end

mod.on_setting_changed = function(setting_id)
    -- Settings
    mod.debug = mod:get("mod_option_debug")
    -- Events
    mod.event_manager:trigger("servo_friend_settings_changed")
end

-- ##### ┬┌┐┌┬┌┬┐       ┌┬┐┌─┐┌─┐┌┬┐┬─┐┌─┐┬ ┬ #########################################################################
-- ##### │││││ │   ───   ││├┤ └─┐ │ ├┬┘│ │└┬┘ #########################################################################
-- ##### ┴┘└┘┴ ┴        ─┴┘└─┘└─┘ ┴ ┴└─└─┘ ┴  #########################################################################

mod.init = function(self)
    -- References
    self.world_manager = managers.world
    self.package_manager = managers.package
    self.time_manager = managers.time
    self.event_manager = managers.event
    -- Packages
    local pt = self:pt()
    table_clear(pt.loaded_packages)
    table_clear(pt.finished_loading)
    self.all_packages_loaded = false
    self:load_packages()
    -- Options
    self.on_setting_changed()
    -- Init players
    self:initialize_existing_players()
end

mod.deinit = function(self)
    -- Destroy units
    self:destroy_existing_players()
    -- Release packages
    self:release_packages()
end

-- ##### ┌─┐─┐ ┬┬┌─┐┌┬┐┬┌┐┌┌─┐  ┌─┐┬  ┌─┐┬ ┬┌─┐┬─┐┌─┐ #################################################################
-- ##### ├┤ ┌┴┬┘│└─┐ │ │││││ ┬  ├─┘│  ├─┤└┬┘├┤ ├┬┘└─┐ #################################################################
-- ##### └─┘┴ └─┴└─┘ ┴ ┴┘└┘└─┘  ┴  ┴─┘┴ ┴ ┴ └─┘┴└─└─┘ #################################################################

mod.initialize_existing_players = function(self)
    local players = managers.player:players()
    for _, player in pairs(players) do
        local player_unit = player.player_unit
        if player_unit and unit_alive(player_unit) then
            mod:initialize_player_unit(player.player_unit)
        end
    end
end

mod.destroy_existing_players = function(self)
    local pt = self:pt()
    for unit, extension in pairs(pt.player_unit_extensions) do
        extension:destroy()
        script_unit_remove_extension(unit, "player_unit_servo_friend_system")
    end
    table_clear(pt.player_unit_extensions)
end

-- ##### ┌─┐┬  ┌─┐┬ ┬┌─┐┬─┐ ###########################################################################################
-- ##### ├─┘│  ├─┤└┬┘├┤ ├┬┘ ###########################################################################################
-- ##### ┴  ┴─┘┴ ┴ ┴ └─┘┴└─ ###########################################################################################

mod.local_player = function(self)
    return managers.player:local_player_safe(1)
end

mod.aim_target = function(self, optional_offset, optional_unit, optional_length, optional_collision_filter, optional_physics_world)
    optional_physics_world = optional_physics_world or self:physics_world()
    optional_offset = optional_offset or vector3_zero()
    optional_unit = optional_unit  or self:local_player()
    optional_length = optional_length or 1000
    optional_collision_filter = optional_collision_filter or "filter_player_character_shooting_projectile"

    local from = unit_world_position(optional_unit, 1) + optional_offset
    local camera_forward = quaternion_forward(unit_local_rotation(optional_unit, 1))
    local to = from + camera_forward * optional_length + optional_offset
	local to_target = to - from
	local direction = vector3_normalize(to_target)

	local _, hit_position, _, _, hit_actor = physics_world_raycast(optional_physics_world, from, direction, optional_length, "closest", "types", "both", "collision_filter", optional_collision_filter)
    local hit_unit = hit_actor and actor_unit(hit_actor)
    return hit_position, hit_unit
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.pt = function(self)
    return self:persistent_table(REFERENCE)
end

mod.random_option = function(self, values)
    local rnd = math_random(1, #values)
    return values[rnd]
end

mod.is_in_hub = function(self)
	local game_mode_name = managers.state.game_mode:game_mode_name()
	local is_in_hub = game_mode_name == "hub"
	return is_in_hub
end

mod.is_dark_mission = function(self)
    local template = managers.state.circumstance and managers.state.circumstance:template()
    if template and template.mutators then
        for _, mutator in pairs(template.mutators) do
            if mutator == "mutator_darkness_los" then
                self:print("dark mission!")
                return true
            end
        end
    end
    self:print("no dark mission")
end

mod.is_in_psykanium = function(self)
    local game_mode_name = managers.state.game_mode:game_mode_name()
	return game_mode_name == "training_grounds" or game_mode_name == "shooting_range"
end

mod.get_vectors_almost_same = function(self, v1, v2, tolerance)
    local tolerance = tolerance or .5
    local v1 = v1 or vector3_zero()
    local v2 = v2 or vector3_zero()
    if math_abs(v1[1] - v2[1]) < tolerance and math_abs(v1[2] - v2[2]) < tolerance and math_abs(v1[3] - v2[3]) < tolerance then
        return true
    end
end

-- Checks if a point is inside a cone
mod.is_point_in_cone = function(self, target_position, position, direction, depth, radius)
    local axis = vector3_normalize(direction)
    local tip_to_point = target_position - position
    local projection_length = vector3_dot(tip_to_point, axis)

    -- Is the point outside the depth of the cone?
    if projection_length < 0 or projection_length > depth then
        return false
    end

    -- Distance from the cone axis
    local closest_point_on_axis = position + axis * projection_length
    local radial_vector = target_position - closest_point_on_axis
    local radial_distance = vector3_length(radial_vector)

    -- Calculate maximum allowed radius at this depth (linear)
    local max_radius_at_projection = (projection_length / depth) * radius

    return radial_distance <= max_radius_at_projection
end

mod.is_in_line_of_sight = function(self, from, to, optional_physics_world)
    if to and from then
        local to_target = to - from
        local distance = vector3_length(to_target)
        local direction = vector3_normalize(to_target)
        optional_physics_world = optional_physics_world or self:physics_world()
        local hits, hits_n = physics_world_raycast(optional_physics_world, from, direction, distance, "all", "types", "both", "collision_filter", "filter_minion_line_of_sight_check")
        if hits then
            local INDEX_DISTANCE = 2
            for i = 1, hits_n do
                local hit = hits[i]
                local hit_distance = hit[INDEX_DISTANCE]
                if hit_distance and hit_distance < distance * .95 then
                    return false
                end
            end
        end
        return true
    end
end

-- ##### ┬ ┬┌─┐┬─┐┬  ┌┬┐ ##############################################################################################
-- ##### ││││ │├┬┘│   ││ ##############################################################################################
-- ##### └┴┘└─┘┴└─┴─┘─┴┘ ##############################################################################################

mod.world = function(self)
    return self.world_manager and self.world_manager:world("level_world")
end

mod.wwise_world = function(self)
    local world = self:world()
    return world and self.world_manager and self.world_manager:wwise_world(world)
end

mod.physics_world = function(self)
    local world = self:world()
    return world and world_physics_world(world)
end

-- ##### ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌┌─┐ ################################################################################
-- ##### ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││└─┐ ################################################################################
-- ##### └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘└─┘ ################################################################################

mod.register_extension = function(self, extension, system)
    local pt = self:pt()
    pt.extensions[system] = extension
    pt.systems[extension] = system
end

mod.add_extension = function(self, unit, system, extension_init_context, extension_init_data)
    local pt = self:pt()
    local extension = pt.extensions[system]
    if extension and not script_unit_has_extension(unit, system) then
        return script_unit_add_extension(extension_init_context, unit, extension, system, extension_init_data)
    end
end

mod.remove_extension = function(self, unit, system)
    if script_unit_has_extension(unit, system) then
		return script_unit_remove_extension(unit, system)
	end
end

mod.execute_extension = function(self, unit, system, function_name, ...)
    if script_unit_has_extension(unit, system) then
        local extension = script_unit_extension(unit, system)
        if extension[function_name] and not extension.__deleted then
            return extension[function_name](extension, ...)
        end
    end
end

-- ##### ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌┌─┐ ############################################
-- ##### └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││└─┐ ############################################
-- ##### └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘└─┘ ############################################

mod.servo_friend_extension = function(self, unit, system_or_extension)
    local pt = self:pt()
    local system = pt.systems[system_or_extension] or system_or_extension
    return script_unit_has_extension(unit, system)
end

mod.servo_friend_add_extension = function(self, unit, system, extension_init_context, extension_init_data)
    if self:add_extension(unit, system, extension_init_context, extension_init_data) then
        local pt = self:pt()
        local extension = script_unit_extension(unit, system)
        if not pt.loaded_extensions[unit] then
            pt.loaded_extensions[unit] = {}
        end
        pt.loaded_extensions[unit][system] = extension
        return extension
    end
end

mod.servo_friend_remove_extension = function(self, unit, system)
    if self:remove_extension(unit, system) then
        local pt = self:pt()
        if pt.loaded_extensions[unit] then
            pt.loaded_extensions[unit][system] = nil
        end
        return true
    end
end

-- ##### ┌─┐┌─┐┬ ┬┌┐┌┌┬┐┌─┐ ###########################################################################################
-- ##### └─┐│ ││ ││││ ││└─┐ ###########################################################################################
-- ##### └─┘└─┘└─┘┘└┘─┴┘└─┘ ###########################################################################################

mod.register_sounds = function(self, sounds)
    local pt = self:pt()
    if sounds then
        for event, sound in pairs(sounds) do
            pt.sound_events[event] = sound
        end
    end
end

mod.play_sound = function(self, sound_event, optional_source_id, position)
    local pt = self:pt()
    if pt.wwise_world then
        local sound_effect = pt.sound_events[sound_event]
        if sound_effect then
            position = position or vector3_unbox(self.current_position)
            local source_id = optional_source_id or wwise_world_make_auto_source(pt.wwise_world, position)
            wwise_world_trigger_resource_event(pt.wwise_world, sound_effect, source_id)
            return source_id
        end
    end
end

-- ##### ┌─┐┌─┐┌─┐┬┌─┌─┐┌─┐┌─┐┌─┐ #####################################################################################
-- ##### ├─┘├─┤│  ├┴┐├─┤│ ┬├┤ └─┐ #####################################################################################
-- ##### ┴  ┴ ┴└─┘┴ ┴┴ ┴└─┘└─┘└─┘ #####################################################################################

mod.register_packages = function(self, packages)
    local pt = self:pt()
    if packages then
        for _, package in pairs(packages) do
            packages_to_load[#packages_to_load+1] = package
        end
    end
end

mod.load_packages = function(self)
    local pt = mod:pt()
    for _, package_name in pairs(packages_to_load) do
        local callback = callback(self, "cb_on_package_loaded", package_name)
        pt.loaded_packages[package_name] = self.package_manager:load(package_name, REFERENCE, callback)
    end
end

mod.cb_on_package_loaded = function(self, package_name)
    local pt = mod:pt()
    self:print("Package loaded: " .. package_name)
    pt.finished_loading[package_name] = true
    if table_size(pt.finished_loading) == table_size(pt.loaded_packages) then
        self:print("All packages loaded")
        self.all_packages_loaded = true
    end
end

mod.release_packages = function(self)
    local pt = mod:pt()
    for package_name, package_id in pairs(pt.loaded_packages) do
        self:print("Release package: " .. package_name)
        self.package_manager:release(package_id)
    end
    self.all_packages_loaded = false
end

mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_base_extension")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_tag_extension")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_marker_extension")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_point_of_interest_extension")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_hover_particle_extension")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_hover_sound_extension")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_flashlight_extension")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_voice_extension")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_roaming_extension")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_transparency_extension")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_out_of_bounds_extension")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_inspect_extension")

mod:io_dofile("servo_friend/scripts/mods/servo_friend/player_extensions/player_unit_servo_friend_extension")