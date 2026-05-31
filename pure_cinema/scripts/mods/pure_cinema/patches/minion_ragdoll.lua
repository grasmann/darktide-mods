local mod = get_mod("pure_cinema")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local Vo = mod:original_require("scripts/utilities/vo")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local math = math
    local CLASS = CLASS
    local vector3 = Vector3
    local managers = Managers
    local unit_node = unit.node
    local unit_alive = unit.alive
    local unit_world = unit.world
    local vector3_up = vector3.up
    local vector3_box = Vector3Box
    local script_unit = ScriptUnit
    local wwise_world = WwiseWorld
    local math_random = math.random
    local vector3_down = vector3.down
    local physics_world = PhysicsWorld
    local unit_has_node = unit.has_node
    local vector3_unbox = vector3_box.unbox
    local unit_world_position = unit.world_position
    local unit_world_rotation = unit.world_rotation
    local script_unit_extension = script_unit.extension
    local wwise_world_make_auto_source = wwise_world.make_auto_source
    local physics_world_immediate_overlap = physics_world.immediate_overlap
    local wwise_world_trigger_resource_event = wwise_world.trigger_resource_event
-- #endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local MIN_PUSH_FORCE = 15
local MAX_PUSH_FORCE = 35
local MIN_FREQUENCY = 1
local MAX_FREQUENCY = 5
local DEFAULT_HIT_ZONE_NAME = "torso"
local RAGDOLL_PUSH_CACHE_SIZE = 50
local STRUGGLE_DELAY = .5
local STRUGGLE_FREQUENCY = .1
local FALL_FREQUENCY = .2
local STRUGGLE_TIME_MIN = 10
local STRUGGLE_TIME_MAX = 40
local _ragdoll_collidor = {
    chaos_ogryn_bulwark = vector3_box(0.75, 1, 0.75),
    chaos_ogryn_executor = vector3_box(0.75, 1, 0.75),
    chaos_ogryn_gunner = vector3_box(0.75, 1, 0.75),
    cultist_mutant = vector3_box(0.75, 1, 0.75),
    chaos_hound = vector3_box(0.5, .6, 0.5),
}
local _ragdoll_fall = {
    chaos_ogryn_bulwark = 1.5,
    chaos_ogryn_executor = 1.5,
    chaos_ogryn_gunner = 1.5,
    cultist_mutant = 1,
}
local sound_light = "wwise/events/minions/play_chaos_hound_armoured_footsteps_land"
local sound_medium = "wwise/events/minions/play_plague_ogryn_footsteps_land"
local sound_heavy = "wwise/events/minions/play_chaos_spawn_leap_land"
local sound_metal = "wwise/events/minions/play_enemy_character_foley_plague_ogryn_stomp_metal"
local _fall_sounds = {
    renegade_rifleman = sound_medium,
    renegade_assault = sound_medium,
    renegade_plasma_gunner = sound_metal,
    cultist_gunner = sound_medium,
    renegade_gunner = sound_medium,
    renegade_shocktrooper = sound_medium,
    renegade_flamer = sound_medium,
    renegade_executor = sound_metal,
    renegade_berzerker = sound_metal,
    chaos_ogryn_bulwark = sound_heavy,
    chaos_ogryn_executor = sound_metal,
    chaos_ogryn_gunner = sound_heavy,
    cultist_mutant = sound_medium,
    renegade_melee = sound_medium,
}

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/managers/minion/minion_ragdoll", function(instance)

    instance.apply_push_force = function(self, unit, push_direction)

        local hit_zone_name_or_nil = "torso"

        if self._removed_ragdolls[unit] then
            return
        end

        local push_force = self._ragdoll_struggle_strength[unit] or MAX_PUSH_FORCE

        local ragdoll_push_direction = push_direction

        if not self._breed[unit] then
            return
        end

        local breed = self._breed[unit]
        local hit_zone_ragdoll_pushes = breed.hit_zone_ragdoll_pushes
        local push_force_data = hit_zone_ragdoll_pushes[hit_zone_name_or_nil]
        local current_cache_index = self._delayed_ragdoll_push_index

        if current_cache_index < RAGDOLL_PUSH_CACHE_SIZE then
            current_cache_index = current_cache_index + 1

            local rnd_multiplier = math_random(100, 300) / 100

            push_force = push_force * rnd_multiplier

            local delayed_ragdoll_push_cache = self._delayed_ragdoll_push_cache
            local data = delayed_ragdoll_push_cache[current_cache_index]

            data.unit = unit
            data.attack_direction = vector3_box(ragdoll_push_direction)
            data.push_force = push_force
            data.hit_zone_name = hit_zone_name_or_nil
            data.push_force_data = push_force_data
            self._delayed_ragdoll_push_index = current_cache_index

        end

    end

    instance.fall_faster = function(self, unit, optional_multiplier)
        
        local breed_name = self._breed_name[unit]
        local breed_multiplier = optional_multiplier or breed_name and _ragdoll_fall[breed_name] or .5

        local ragdoll_push_direction = vector3_down() * breed_multiplier

        self:apply_push_force(unit, ragdoll_push_direction)

    end

    instance.struggle_ragdoll = function(self, unit, optional_direction)

        local push_direction = math_random(1, 4) == 1
        local ragdoll_push_direction = push_direction and vector3_up() or vector3_down()

        self:apply_push_force(unit, ragdoll_push_direction)

    end

    instance.finish_struggle = function(self, unit)

        self._ragdoll_struggle[unit] = nil
        self._ragdoll_struggle_delay[unit] = nil
        self._ragdoll_struggle_strength[unit] = nil
        self._ragdoll_struggle_frequency[unit] = nil
        self._ragdoll_struggle_time[unit] = nil
        self._ragdoll_struggle_length[unit] = nil

    end

    instance.check_if_ragdoll_landed = function(self, unit)
        if unit and unit_alive(unit) then
            local breed_name = self._breed_name[unit]
            local breed_size = breed_name and _ragdoll_collidor[breed_name]
            breed_size = breed_size and vector3_unbox(breed_size)

            local node = unit_has_node(unit, "j_neck") and unit_node(unit, "j_neck") or 1
            local position = unit_world_position(unit, node)
            local rotation = unit_world_rotation(unit, node)
            local size = breed_size or vector3(0.25, .3, 0.25)
            local collision_filter = "filter_minion_shooting_no_friendly_fire"
            local world = unit_world(unit)
            local physics_world = mod:physics_world(world)
            local _, num_hits = physics_world_immediate_overlap(physics_world, "shape", "capsule", "position", position, "rotation", rotation, "size", size, "collision_filter", collision_filter)
            if num_hits > 0 then
                return true
            end
        end
    end

    instance.trigger_inventory_wwise_event = function(self, unit, event_name)
        if unit and unit_alive(unit) then
            local world = unit_world(unit)
            local wwise_world = mod:wwise_world(world)

            local auto_source_id = wwise_world_make_auto_source(wwise_world, unit, 1)

            wwise_world_trigger_resource_event(wwise_world, event_name, auto_source_id)
        end
    end

    instance.on_settings_changed = function(self)
        self.struggle = mod:get("struggle")
        self.struggle_on_death_chance = mod:get("struggle_on_death_chance")
        self.heavier_ragdolls = mod:get("heavier_ragdolls")
        self.fall_sounds_collision_check = mod:get("fall_sounds_collision_check")
    end

    instance.destroy = function(self)

        -- Unregister Events
        managers.event:unregister(self, "pure_cinema_settings_changed")

    end

end)

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.MinionRagdoll, "init", function(func, self, ...)

    -- Original function
    func(self, ...)

    self._breed = {}
    self._breed_name = {}

    self._ragdoll_struggle = {}
    self._ragdoll_struggle_delay = {}
    self._ragdoll_struggle_strength = {}
    self._ragdoll_struggle_frequency = {}
    self._ragdoll_struggle_time = {}
    self._ragdoll_struggle_length = {}

    self._land_time = {}
    self._ragdoll_landed = {}

    -- Register Events
    managers.event:register(self, "pure_cinema_settings_changed", "on_settings_changed")
    
    -- Set initial values
    self:on_settings_changed()

end)

mod:hook(CLASS.MinionRagdoll, "create_ragdoll", function(func, self, death_data, ...)

    local unit_data_extension = script_unit_extension(death_data.unit, "unit_data_system")
    self._breed[death_data.unit] = unit_data_extension and unit_data_extension:breed()
    local breed_name = self._breed[death_data.unit] and self._breed[death_data.unit].name
    self._breed_name[death_data.unit] = breed_name

    -- Original function
    func(self, death_data, ...)

    local t = mod:time()

    if self.struggle and math_random(1, 100) <= self.struggle_on_death_chance then

        self._ragdoll_struggle[death_data.unit] = t
        self._ragdoll_struggle_delay[death_data.unit] = t
        self._ragdoll_struggle_strength[death_data.unit] = math_random(MIN_PUSH_FORCE, MAX_PUSH_FORCE)
        self._ragdoll_struggle_frequency[death_data.unit] = math_random(MIN_FREQUENCY, MAX_FREQUENCY) * .1
        self._ragdoll_struggle_time[death_data.unit] = t
        self._ragdoll_struggle_length[death_data.unit] = math_random(STRUGGLE_TIME_MIN, STRUGGLE_TIME_MAX)

    else

        self:finish_struggle(death_data.unit)

    end

    self:fall_faster(death_data.unit, 2)

end)

mod:hook(CLASS.MinionRagdoll, "_remove_ragdoll", function(func, self, unit, ...)

    self._breed[unit] = nil
    self._breed_name[unit] = nil
    self._land_time[unit] = nil
    self._ragdoll_landed[unit] = nil

    self:finish_struggle(unit)

    -- Original function
    func(self, unit, ...)

end)

mod:hook(CLASS.MinionRagdoll, "update", function(func, self, soft_cap_out_of_bounds_units, ...)

    -- Original function
    func(self, soft_cap_out_of_bounds_units, ...)

    local t = mod:time()
    local ragdolls, num_ragdolls = self._ragdolls, self._num_ragdolls

	for i = num_ragdolls, 1, -1 do
		local ragdoll_unit = ragdolls[i]

        if self.fall_sounds_collision_check and not self._ragdoll_landed[ragdoll_unit] then

            self._land_time[ragdoll_unit] = self._land_time[ragdoll_unit] or t

            if t - self._land_time[ragdoll_unit] > FALL_FREQUENCY then
                
                self._ragdoll_landed[ragdoll_unit] = self:check_if_ragdoll_landed(ragdoll_unit)

                if self._ragdoll_landed[ragdoll_unit] then

                    -- self:trigger_inventory_wwise_event(ragdoll_unit, "wwise/events/minions/play_plague_ogryn_footsteps_land")
                    -- self:trigger_inventory_wwise_event(ragdoll_unit, "wwise/events/minions/play_chaos_spawn_leap_land")

                    local sound = _fall_sounds[self._breed_name[ragdoll_unit]] or sound_light

                    self:trigger_inventory_wwise_event(ragdoll_unit, sound)

                end

            end

        end

        if self.heavier_ragdolls and not self._ragdoll_landed[ragdoll_unit] then

                self:fall_faster(ragdoll_unit)

        end

        if self._ragdoll_struggle_delay[ragdoll_unit] and t - self._ragdoll_struggle_delay[ragdoll_unit] >= STRUGGLE_DELAY then

            self._ragdoll_struggle_delay[ragdoll_unit] = nil

        elseif not self._ragdoll_struggle_delay[ragdoll_unit] then

            if self._ragdoll_struggle_time[ragdoll_unit] and t - self._ragdoll_struggle_time[ragdoll_unit] >= self._ragdoll_struggle_length[ragdoll_unit] then

                self:finish_struggle(ragdoll_unit)

            else

                local frequency = self._ragdoll_struggle_frequency[ragdoll_unit] or STRUGGLE_FREQUENCY

                if self._ragdoll_struggle[ragdoll_unit] and t - self._ragdoll_struggle[ragdoll_unit] >= frequency then

                    self:struggle_ragdoll(ragdoll_unit)

                    self._ragdoll_struggle[ragdoll_unit] = t

                end

            end

        end

	end

end)
