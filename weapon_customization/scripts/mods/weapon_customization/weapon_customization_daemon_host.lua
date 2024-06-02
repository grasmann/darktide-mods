local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local HitZone = mod:original_require("scripts/utilities/attack/hit_zone")
local MinionPerception = mod:original_require("scripts/utilities/minion_perception")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
	local wwiseWorld_stop_event = WwiseWorld.stop_event
	local Unit = Unit
    local unit_world_position = Unit.world_position
    local unit_world_rotation = Unit.world_rotation
    local unit_node = Unit.node
    local unit_alive = Unit.alive
    local actor_unit = Actor.unit
    local quaternion_forward = Quaternion.forward
    local physics_world_raycast = PhysicsWorld.raycast
	local table = table
    local table_clear = table.clear
	local table_remove = table.remove
    local HEALTH_ALIVE = HEALTH_ALIVE
    local CLASS = CLASS
    local managers = Managers
    local script_unit = ScriptUnit
	local tostring = tostring
	local pairs = pairs
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local AGGRO_CHECK_INTERVAL = .5
local MAX_SMOKE_PARTICLES = 5
local SMOKE_PARTICLES_TIME = 2
local SPARK_PARTICLES_TIME = 1
local FLASHLIGHT_AGGRO_MUTATORS = {
	"mutator_darkness_los",
	"mutator_ventilation_purge_los"
}
local HANDLED_UNITS = {}
local INDEX_POSITION = 1
local INDEX_DISTANCE = 2
local INDEX_ACTOR = 4
local SPARKS_SMOKE_PARTICLE = "content/fx/particles/weapons/swords/chainsword/chain_axe_special_weapon_activate_sparks_smoke"
local SPARKS_PARTICLE = "content/fx/particles/impacts/weapons/chainsword/chainsword_grinding_sparks_loop_01"
local SPARK_SOUND = "wwise/events/weapon/play_psyker_chain_lightning"
local SPARK_SOUND_STOP = "wwise/events/weapon/stop_psyker_chain_lightning"
local DAEMONHOST_PACKAGES = {SPARK_SOUND, SPARK_SOUND_STOP, SPARKS_SMOKE_PARTICLE, SPARKS_PARTICLE}
local REFERENCE = "weapon_customization"

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.falloff_position_rotation = function(self)
    local flashlight = self:get_flashlight_unit() or self:get_laser_pointer_unit()
    if flashlight and unit_alive(flashlight) then
        local flashlight_template = self:get_flashlight_template()
        local distance = flashlight_template.light.first_person.falloff.far
        local position = unit_world_position(flashlight, 1)
        local rotation = unit_world_rotation(flashlight, 1)
        return distance, position, rotation
    end
end

mod.trigger_flashlight_daemon_host_reaction = function(self, t, intensity)
	local mutator_manager = managers.state.mutator
	local has_flashlight_aggro = false

	for i = 1, #FLASHLIGHT_AGGRO_MUTATORS do
		if mutator_manager:mutator(FLASHLIGHT_AGGRO_MUTATORS[i]) then
			has_flashlight_aggro = true
			break
		end
	end

	-- if not has_flashlight_aggro then
	-- 	return
	-- end

	local falloff, position, rotation = self:falloff_position_rotation()

	if not falloff then
		return
	end

	local aggro_distance = falloff * intensity
	local check_rotation = rotation
	local check_direction = quaternion_forward(check_rotation)
    local physics_world = self:physics_world()
	local hits = physics_world_raycast(physics_world, position, check_direction, falloff, "all", "types", "both", "max_hits", 100,
		"collision_filter", "filter_player_character_shooting_raycast", "rewind_ms", 0)

	if not hits or #hits == 0 then
		return
	end

	local num_hits = #hits

	table_clear(HANDLED_UNITS)

	for index = 1, num_hits do
		repeat
			local hit = hits[index]
			local hit_distance = hit.distance or hit[INDEX_DISTANCE]
			local hit_actor = hit.actor or hit[INDEX_ACTOR]
			local hit_position = hit.position or hit[INDEX_POSITION]

			if not hit_actor then
				break
			end

			local hit_unit = actor_unit(hit_actor)

			if HANDLED_UNITS[hit_unit] then
				break
			end

			HANDLED_UNITS[hit_unit] = true

			local side_system = managers.state.extension:system("side_system")
			local is_enemy = side_system:is_enemy(self.player_unit, hit_unit)
            local unit_data_extension = script_unit.extension(hit_unit, "unit_data_system")
			local breed = unit_data_extension and unit_data_extension:breed()

			if is_enemy and breed and breed.name == "chaos_daemonhost" and HEALTH_ALIVE[hit_unit] then
				local within_aggro_distance = hit_distance < aggro_distance

                if within_aggro_distance then
                    local flashlight = self:get_flashlight_unit() or self:get_laser_pointer_unit()
                    if flashlight and unit_alive(flashlight) then
                        -- Play sound
						if not self.spark_sound then
                        	self.spark_sound = self.fx_extension:trigger_wwise_event(SPARK_SOUND, false, flashlight, 1)
						end
						-- Flicker
						self.flicker_wild = true
						-- VFX Spawner
						self:check_fx_spawner()
						local spawner_name = "slot_primary_laser_pointer_1p"
    					if self:is_in_third_person() then spawner_name = "slot_primary_laser_pointer_3p" end
						-- Smoke
						self.smoke_particles = self.smoke_particles or {}
						if managers.package:has_loaded(SPARKS_SMOKE_PARTICLE) and #self.smoke_particles < MAX_SMOKE_PARTICLES then
							self.smoke_particles[#self.smoke_particles+1] = self.fx_extension:_spawn_unit_particles(SPARKS_SMOKE_PARTICLE, spawner_name, true, "stop")
						end
						-- Sparks
						if managers.package:has_loaded(SPARKS_PARTICLE) and not self.spark_particles then
							self.spark_particles = self.fx_extension:_spawn_unit_particles(SPARKS_PARTICLE, spawner_name, true, "stop")
						end
						-- Timer
						self.smoke_particle_end = t + SMOKE_PARTICLES_TIME
						self.spark_particle_end = t + SPARK_PARTICLES_TIME
						-- Drain Battery
						self.battery_drain_multiplier = (self.battery_drain_multiplier or 1) + 5
                    end
                end
			end
		until true
	end
end

mod.check_daemon_host_packages = function(self)
	for _, package in pairs(DAEMONHOST_PACKAGES) do
		if not self:persistent_table(REFERENCE).loaded_packages.needed[package] then
			self:persistent_table(REFERENCE).used_packages.needed[package] = true
			self:persistent_table(REFERENCE).loaded_packages.needed[package] = managers.package:load(package, REFERENCE)
		end
	end
end

mod.daemon_host_update = function(self, t)
    if self.initialized then
		-- Check packages
        self:check_daemon_host_packages()
		-- Get values
        local time_since_aggro = t - (self._last_aggro_time or 0)
        local flashlight_on = self:persistent_table(REFERENCE).flashlight_on
        local laser_pointer_on = self:persistent_table(REFERENCE).laser_pointer_on == 1
        local laser_pointer_full = self:persistent_table(REFERENCE).laser_pointer_on == 2
		-- Execute aggro process
        if (flashlight_on or laser_pointer_on or laser_pointer_full) and HEALTH_ALIVE[self.player_unit] and AGGRO_CHECK_INTERVAL < time_since_aggro then
            local intensity = laser_pointer_full and .4 or (flashlight_on or laser_pointer_on) and .2 or 0
            self:trigger_flashlight_daemon_host_reaction(t, intensity)
            self._last_aggro_time = t
        end
		-- Sound
		if self.spark_sound and t >= self.spark_particle_end then
			-- Get flashlight unit
			local flashlight = self:get_flashlight_unit() or self:get_laser_pointer_unit()
            if flashlight and unit_alive(flashlight) then
				-- Play stop sound
				self.fx_extension:trigger_wwise_event(SPARK_SOUND_STOP, false, flashlight, 1)
			end
			self.spark_sound = nil
		end
		-- Smoke
		if self.smoke_particle_end and t >= self.smoke_particle_end then
			if self.smoke_particles and #self.smoke_particles > 0 then
				if self.smoke_particles[1] > 0 then self.fx_extension:destroy_player_particles(self.smoke_particles[1]) end
				table_remove(self.smoke_particles, 1)
				self.smoke_particle_end = t + SMOKE_PARTICLES_TIME
			end
		end
		-- Sparks
		if self.spark_particle_end and t >= self.spark_particle_end then
			if self.spark_particles and self.spark_particles > 0 then self.fx_extension:destroy_player_particles(self.spark_particles) end
			self.spark_particles = nil
			self.flicker_wild = nil
			-- Battery
			self.battery_drain_multiplier = 1
		end
    end
end
