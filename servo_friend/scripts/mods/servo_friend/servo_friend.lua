local mod = get_mod("servo_friend")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local PointOfInterestManager = mod:io_dofile("servo_friend/scripts/mods/servo_friend/managers/point_of_interest_manager")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local math = math
local unit = Unit
local table = table
local pairs = pairs
local actor = Actor
local get_mod = get_mod
local vector3 = Vector3
local managers = Managers
local math_abs = math.abs
local actor_unit = actor.unit
local unit_alive = unit.alive
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
local vector3_normalize = vector3.normalize
local quaternion_forward = quaternion.forward
local unit_local_rotation = unit.local_rotation
local unit_world_position = unit.world_position
local physics_world_raycast = physics_world.raycast

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

mod.REFERENCE = "servo_friend"
mod.debug_mode = false

mod:persistent_table(mod.REFERENCE, {
    player_unit_extensions = {},
    all_packages_loaded = false,
    permanent_packages = {},
    loaded_extensions = {},
    finished_loading = {},
    loaded_packages = {},
    sound_events = {},
    extensions = {},
    systems = {},
})

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
    mod:on_settings_changed(setting_id)
end

mod.update = function()
    local dt, t = mod:delta_time(), mod:time()
    mod:update_point_of_interest_manager(dt, t)
    mod:update_repeating_sounds(dt, t)
end

mod.on_game_state_changed = function(status, state_name)
    -- Destroy players
    -- mod:destroy_existing_players()
end

-- ##### ┌─┐┌─┐┌┬┐┌┬┐┬┌┐┌┌─┐┌─┐  ┌─┐┬ ┬┌─┐┌┐┌┌─┐┌─┐┌┬┐ ################################################################
-- ##### └─┐├┤  │  │ │││││ ┬└─┐  │  ├─┤├─┤││││ ┬├┤  ││ ################################################################
-- ##### └─┘└─┘ ┴  ┴ ┴┘└┘└─┘└─┘  └─┘┴ ┴┴ ┴┘└┘└─┘└─┘─┴┘ ################################################################

mod.on_settings_changed = function(self, setting_id)
    if self.initialized then
        -- Settings
        self.debug_mode = self:get("mod_option_debug")
        self.distribution = self:get("mod_option_distribution")
        self.keep_packages = self:get("mod_option_keep_packages")
        -- Init players
        if setting_id == "mod_option_distribution" then
            self:destroy_existing_players()
            self:initialize_existing_players()
        end
        -- Events
        managers.event:trigger("servo_friend_settings_changed")
        self:settings_changed_existing_players(setting_id)
    end
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

mod.update_point_of_interest_manager = function(self, dt, t)
    if self.point_of_interest_manager then
        self.point_of_interest_manager:update(dt, t)
    end
end

-- ##### ┬┌┐┌┬┌┬┐       ┌┬┐┌─┐┌─┐┌┬┐┬─┐┌─┐┬ ┬ #########################################################################
-- ##### │││││ │   ───   ││├┤ └─┐ │ ├┬┘│ │└┬┘ #########################################################################
-- ##### ┴┘└┘┴ ┴        ─┴┘└─┘└─┘ ┴ ┴└─└─┘ ┴  #########################################################################

mod.init = function(self)
    -- References
    self.world_manager = managers.world
    self.package_manager = managers.package
    self.time_manager = managers.time
    -- self.event_manager = managers.event
    self.point_of_interest_manager = PointOfInterestManager:new()
    -- Packages
    self:load_packages()
    -- end
    -- P2P
    self.p2p = get_mod("rtc")
    -- Init
    self.initialized = true
    -- Init players
    self:initialize_existing_players()
    -- Options
    self:on_settings_changed()
end

mod.deinit = function(self)
    -- Destroy point of interest manager
    self.point_of_interest_manager:destroy()
    -- Stop repeating sounds
    self:stop_all_repeating_sounds()
    -- Destroy units
    self:destroy_existing_players()
    -- Initialize
    self.initialized = false
    -- Release packages
    self:release_packages()
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.pt = function(self)
    return self:persistent_table(mod.REFERENCE)
end

mod.print = function(self, message)
    if self.debug_mode then self:echo(message) end
end

mod.is_unit_alive = function(self, unit)
    return unit and unit_alive(unit)
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

mod.is_in_line_of_sight = function(self, from, to, optional_physics_world, optional_collision_filter)
    if to and from then
        local to_target = to - from
        local distance = vector3_length(to_target)
        local direction = vector3_normalize(to_target)
        optional_physics_world = optional_physics_world or self:physics_world()
        optional_collision_filter = optional_collision_filter or "filter_minion_line_of_sight_check"
        local hits, hits_n = physics_world_raycast(optional_physics_world, from, direction, distance, "all", "types", "both", "collision_filter", "filter_minion_line_of_sight_check")
        if hits then
            local INDEX_DISTANCE = 2
            for i = 1, hits_n do
                local hit = hits[i]
                local hit_distance = hit[INDEX_DISTANCE]
                if hit_distance and hit_distance < distance * .8 then
                    return false
                end
            end
        end
        return true
    end
end

mod.aim_target = function(self, optional_offset, optional_unit, optional_length, optional_collision_filter, optional_physics_world, optional_direction)
    optional_physics_world = optional_physics_world or self:physics_world()
    optional_offset = optional_offset or vector3_zero()
    optional_unit = optional_unit  or self:local_player_unit()
    optional_length = optional_length or 1000
    optional_collision_filter = optional_collision_filter or "filter_player_character_shooting_projectile"

    local from = unit_world_position(optional_unit, 1) + optional_offset

    if not optional_direction then
        local camera_forward = quaternion_forward(unit_local_rotation(optional_unit, 1))
        local to = from + camera_forward * optional_length + optional_offset
        local to_target = to - from
        optional_direction = vector3_normalize(to_target)
    end

	local _, hit_position, _, _, hit_actor = physics_world_raycast(optional_physics_world, from, optional_direction, optional_length, "closest", "types", "both", "collision_filter", optional_collision_filter)
    local hit_unit = hit_actor and actor_unit(hit_actor)
    return hit_position, hit_unit
end

mod.p2p_command = function(self, command, target, data)
    if self.p2p then
        target = target or "all"
        return self.p2p.send(self, command, target, data)
    end
end

-- ##### ┬  ┌─┐┌─┐┌┬┐  ┌─┐┌─┐┌┬┐┌─┐┌─┐┌┐┌┌─┐┌┐┌┌┬┐┌─┐ #################################################################
-- ##### │  │ │├─┤ ││  │  │ ││││├─┘│ ││││├┤ │││ │ └─┐ #################################################################
-- ##### ┴─┘└─┘┴ ┴─┴┘  └─┘└─┘┴ ┴┴  └─┘┘└┘└─┘┘└┘ ┴ └─┘ #################################################################

mod:io_dofile("servo_friend/scripts/mods/servo_friend/components/players")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/components/world")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/components/extensions")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/components/servo_friend_extensions")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/components/sound")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/components/time")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/components/package")

-- ##### ┬  ┌─┐┌─┐┌┬┐  ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌┌─┐ ##############################
-- ##### │  │ │├─┤ ││  └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││└─┐ ##############################
-- ##### ┴─┘└─┘┴ ┴─┴┘  └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘└─┘ ##############################

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
mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_alert_extension")

-- ##### ┬  ┌─┐┌─┐┌┬┐  ┌─┐┬  ┌─┐┬ ┬┌─┐┬─┐  ┬ ┬┌┐┌┬┌┬┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ #####################################
-- ##### │  │ │├─┤ ││  ├─┘│  ├─┤└┬┘├┤ ├┬┘  │ │││││ │   ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ #####################################
-- ##### ┴─┘└─┘┴ ┴─┴┘  ┴  ┴─┘┴ ┴ ┴ └─┘┴└─  └─┘┘└┘┴ ┴   └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ #####################################

mod:io_dofile("servo_friend/scripts/mods/servo_friend/player_extensions/player_unit_servo_friend_extension")