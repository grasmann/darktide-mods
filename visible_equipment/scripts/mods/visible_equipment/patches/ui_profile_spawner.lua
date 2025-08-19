local mod = get_mod("visible_equipment")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local ScriptCamera = mod:original_require("scripts/foundation/utilities/script_camera")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local CLASS = CLASS
    local actor = Actor
    local world = World
    local table = table
    local string = string
    local vector3 = Vector3
    local table_size = table.size
    local actor_unit = actor.unit
    local quaternion = Quaternion
    local vector3_box = Vector3Box
    local string_find = string.find
    local table_remove = table.remove
    local vector3_zero = vector3.zero
    local physics_world = PhysicsWorld
    local vector3_unbox = vector3_box.unbox
    local world_unlink_unit = world.unlink_unit
    local quaternion_identity = quaternion.identity
    local unit_world_position = unit.world_position
    local unit_world_rotation = unit.world_rotation
    local quaternion_multiply = quaternion.multiply
    local quaternion_to_vector = quaternion.to_vector
    local physics_world_raycast = physics_world.raycast
    local quaternion_from_vector = quaternion.from_vector
    local unit_set_local_position = unit.set_local_position
    local unit_set_local_rotation = unit.set_local_rotation
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

    instance.valid_instance = function(self, profile, spawned)
        if not profile then
            profile = self._character_spawn_data and self._character_spawn_data.profile
        end
        return profile and (profile.loadout[SLOT_PRIMARY] or profile.loadout[SLOT_SECONDARY])
    end

    instance.set_placement_name = function(self, placement_name)
        self._placement_name = placement_name
    end

    instance.set_slot_name = function(self, slot_name)
        self._slot_name = slot_name
    end

    instance.update_rotation = function(self, profile, slot_name)
        local item = profile and profile.loadout[slot_name]
        local gear_id = item and item.gear_id
        local placement = gear_id and mod:gear_placement(gear_id, nil, nil, true)
        local offset = placement and mod.settings.placement_camera[placement]
        local item_type = item and item.item_type
        offset = offset and item_type and offset[item_type] or offset
        if offset and offset.rotation then
            self._rotation_angle = offset.rotation + 2.25
        end
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
    -- Enable rotation input
    self._rotation_input_disabled = false
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
    -- Update placement
    if self._placement_name and self._slot_name then
        local character_spawn_data = self._character_spawn_data
        local profile = character_spawn_data and character_spawn_data.profile
        local item = profile and profile.loadout[self._slot_name]
        local gear_id = item and item.gear_id
        mod:gear_placement(gear_id, self._placement_name)
    end
end)

mod:hook(CLASS.UIProfileSpawner, "_spawn_character_profile", function(func, self, profile, profile_loader, position, rotation, scale, state_machine, animation_event, face_state_machine_key, face_animation_event, force_highest_mip, disable_hair_state_machine, optional_unit_3p, optional_ignore_state_machine, companion_data, ...)
    -- Catch profile
    if self:valid_instance(profile) then
        self.pt.catch_unit = profile
    end
    -- Ignore slots
    self._ignored_slots[SLOT_SECONDARY] = nil
    self._ignored_slots[SLOT_PRIMARY] = nil

    if self._placement_name and self._slot_name then

        force_highest_mip = false
        self._force_highest_lod_step = false
        if self._loading_profile_data then
            self._loading_profile_data.force_highest_mip = false
        end

        local item = profile and profile.loadout[self._slot_name]
        local gear_id = item and item.gear_id
        local offset = mod.settings.placement_camera[self._placement_name]
        local item_type = item and item.item_type
        offset = offset and item_type and offset[item_type] or offset

        if offset and offset.rotation then
            self._rotation_angle = offset.rotation
        end

        mod:gear_placement(gear_id, self._placement_name)
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

mod:hook(CLASS.UIProfileSpawner, "_spawn_companion", function(func, self, unit_3p, breed_name, position, rotation, attach_to_character, ...)
    -- Original function
    local companion_unit_3p = func(self, unit_3p, breed_name, position, rotation, attach_to_character, ...)
    -- local companion_attach_index = Unit.has_node(unit_3p, "ap_companion") and Unit.node(unit_3p, "ap_companion") or 1
    -- Unlink companion
    world_unlink_unit(self._world, companion_unit_3p)
    unit_set_local_position(companion_unit_3p, 1, unit_world_position(unit_3p, 1) + vector3(-.55, .65, 0))
    unit_set_local_rotation(companion_unit_3p, 1, quaternion_from_vector(vector3(0, 0, 160)))
    -- Return companion
    return companion_unit_3p
end)

mod:hook(CLASS.UIProfileSpawner, "_get_raycast_hit", function(func, self, from, to, physics_world, collision_filter, ...)
	-- Return custom raycast
	return self:custom_raycast(from, to, physics_world, collision_filter)
end)
