local mod = get_mod("visible_equipment")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local CLASS = CLASS
    local actor = Actor
    local actor_unit = actor.unit
    local physics_world = PhysicsWorld
    local physics_world_raycast = physics_world.raycast
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local SLOT_PRIMARY = "slot_primary"
local SLOT_SECONDARY = "slot_secondary"

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/managers/ui/ui_profile_spawner", function(instance)

	instance.custom_raycast = function(self, from, to, physics_world, collision_filter)
		local character_spawn_data = self._character_spawn_data or self._loading_profile_data
		local unit_3p = character_spawn_data and character_spawn_data.unit_3p

		if not unit_3p then return end

		local result, other = physics_world_raycast(physics_world, from, to, 100, "all", "collision_filter", collision_filter)

		if not result then return end

		local INDEX_ACTOR = 4
		local num_hits = #result
		for i = 1, num_hits do
			local hit = result[i]
			local hit_actor = hit[INDEX_ACTOR]
			local hit_unit = actor_unit(hit_actor)
			if hit_unit == unit_3p then
				return hit_unit, hit_actor
			end
		end
	end

    instance.valid_instance = function(self, profile)
        if not profile and self._character_spawn_data then
            profile = self._character_spawn_data.profile
        end
        return profile and (profile.loadout[SLOT_PRIMARY] or profile.loadout[SLOT_SECONDARY])
    end

end)

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.UIProfileSpawner, "init", function(func, self, reference_name, world, camera, unit_spawner, force_highest_lod_step, optional_mission_template, ...)
    -- Set pt variable
    self.pt = mod:pt()
    -- Original function
    func(self, reference_name, world, camera, unit_spawner, force_highest_lod_step, optional_mission_template, ...)
    -- Enable rotation input
    self._rotation_input_disabled = false
end)

mod:hook(CLASS.UIProfileSpawner, "update", function(func, self, dt, t, input_service, ...)
    -- Original function
    func(self, dt, t, input_service, ...)
    -- Check spawn data
    if self:valid_instance() then
        -- Update equipment component
        self._character_spawn_data.equipment_component:update(dt, t)
    end
end)

mod:hook(CLASS.UIProfileSpawner, "cb_on_unit_3p_streaming_complete", function(func, self, unit_3p, timeout, ...)
    -- Original function
    func(self, unit_3p, timeout, ...)
    -- Check spawn data
    if self:valid_instance() then
        -- Update equipment component
        self._character_spawn_data.equipment_component:extensions_ready()
    end
end)

mod:hook(CLASS.UIProfileSpawner, "_spawn_character_profile", function(func, self, profile, profile_loader, position, rotation, scale, state_machine, animation_event, face_state_machine_key, face_animation_event, force_highest_mip, disable_hair_state_machine, optional_unit_3p, optional_ignore_state_machine, companion_data, ...)
    -- Catch profile
    if self:valid_instance(profile) then
        self.pt.catch_unit = profile
    end
    -- Original function
    func(self, profile, profile_loader, position, rotation, scale, state_machine, animation_event, face_state_machine_key, face_animation_event, force_highest_mip, disable_hair_state_machine, optional_unit_3p, optional_ignore_state_machine, companion_data, ...)
end)

mod:hook(CLASS.UIProfileSpawner, "ignore_slot", function(func, self, slot_id, ...)
	-- Skip primary and secondary slots
	if slot_id ~= SLOT_PRIMARY and slot_id ~= SLOT_SECONDARY then
		-- Original function
		func(self, slot_id, ...)
	end
end)

-- mod:hook(CLASS.UIProfileSpawner, "_update_ingore_slots", function(func, self, ...)

-- end)

-- mod:hook(CLASS.UIProfileSpawner, "_handle_input", function(func, self, input_service, dt, ...)
--     -- Original function
--     func(self, input_service, dt, ...)
-- end)

mod:hook(CLASS.UIProfileSpawner, "_get_raycast_hit", function(func, self, from, to, physics_world, collision_filter, ...)
	-- Return custom raycast
	return self:custom_raycast(from, to, physics_world, collision_filter)
end)
