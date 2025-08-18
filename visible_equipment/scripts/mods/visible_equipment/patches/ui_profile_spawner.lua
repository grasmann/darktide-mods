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

    instance.get_profile = function(self, profile)
        return self._character_spawn_data and self._character_spawn_data.profile or self._loading_profile_data and self._loading_profile_data.profile or profile
    end

    instance.valid_instance = function(self, profile, spawned)
        if not profile then
            profile = self._character_spawn_data and self._character_spawn_data.profile
        end
        return profile and (profile.loadout[SLOT_PRIMARY] or profile.loadout[SLOT_SECONDARY])
    end

    instance.placement_entry = function(self, profile)
        local profile = self:get_profile(profile)
        if profile then
            local slot_body_torso = profile.loadout.slot_body_torso and profile.loadout.slot_body_torso.__master_item or profile.loadout.slot_body_torso
            local slot_gear_head = profile.loadout.slot_gear_head and profile.loadout.slot_gear_head.__master_item or profile.loadout.slot_gear_head
            local slot_primary = profile.loadout.slot_primary and not profile.loadout.slot_secondary
            local slot_secondary = profile.loadout.slot_secondary and not profile.loadout.slot_primary
            if (not slot_body_torso or not slot_body_torso.dev_name) and (not slot_gear_head or not slot_gear_head.dev_name) and (slot_primary or slot_secondary) then
                return true
            end
        end
    end

    instance.placement_slot = function(self, profile)
        local profile = self:get_profile(profile)
        if profile then
            local slot_body_torso = profile.loadout.slot_body_torso and profile.loadout.slot_body_torso.__master_item or profile.loadout.slot_body_torso
            local slot_gear_head = profile.loadout.slot_gear_head and profile.loadout.slot_gear_head.__master_item or profile.loadout.slot_gear_head
            local slot_primary = profile.loadout.slot_primary and profile.loadout.slot_primary.dev_name
            local slot_secondary = profile.loadout.slot_secondary and profile.loadout.slot_secondary.dev_name
            if (not slot_body_torso or not slot_body_torso.dev_name) and (not slot_gear_head or not slot_gear_head.dev_name) and (slot_primary or slot_secondary) then
                return true
            end
        end
    end

    instance.position_camera = function(self, profile)
        -- local set_default_camera = true

        if self.default_pose and self._camera then
            ScriptCamera.set_local_position(self._camera, vector3_unbox(self.default_pose.position))
            self._rotation_angle = self.default_pose.rotation
        end

        -- local player_profile = profile or self:get_profile()
        local profile = self:get_profile(profile)
        if (self:placement_entry(profile) and (self._reference_name == "PortraitUI" or self._reference_name == "InventoryCosmeticsView")) or self:placement_slot(profile) then

            -- force_highest_mip = false
            -- self._force_highest_lod_step = false
            -- if self._loading_profile_data then
            --     self._loading_profile_data.force_highest_mip = false
            -- end

            local primary = profile.loadout[SLOT_PRIMARY]
            local secondary = profile.loadout[SLOT_SECONDARY]

            local gear_id = primary and primary.gear_id or secondary and secondary.gear_id

            -- local placement = mod.next_ui_profile_spawner_placement_name[player_profile.character_id] or (gear_id and mod:gear_placement(gear_id, nil, nil, true)) or player_profile.placement_name
            local placement = mod.next_ui_profile_spawner_placement_name[profile] or profile.placement_name --or (gear_id and mod:gear_placement(gear_id, nil, nil, true))
            placement = placement or (self:placement_slot(profile) and mod:gear_placement(gear_id))
            if placement and self._camera then

                mod.next_ui_profile_spawner_placement_name[profile] = nil  

                local offset = mod.settings.placement_camera[placement] --or mod.settings.placement_camera.default
                local item_type = primary and primary.item_type or secondary and secondary.item_type
                offset = offset and item_type and offset[item_type] or offset
                local camera_position = offset and offset.position and vector3_unbox(offset.position) --or vector3_zero()

                if camera_position then
                    if self._reference_name == "InventoryCosmeticsView" then
                        camera_position = camera_position + vector3(0, 3, 0)
                    end

                    ScriptCamera.set_local_position(self._camera, camera_position)

                    self._rotation_angle = offset and offset.rotation or 0
                end

                -- mod:gear_placement(gear_id, placement)

                -- set_default_camera = false
            end
        end

        -- if set_default_camera then
        --     if self.default_pose and self._camera then
        --         ScriptCamera.set_local_position(self._camera, vector3_unbox(self.default_pose.position))
        --         self._rotation_angle = self.default_pose.rotation
        --     end
        -- end
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

    -- local player_profile = self:get_profile()
    -- if (self:placement_entry(player_profile) and (self._reference_name == "PortraitUI" or self._reference_name == "InventoryCosmeticsView")) or self:placement_slot(player_profile) then

    --     -- force_highest_mip = false
    --     -- self._force_highest_lod_step = false
    --     -- if self._loading_profile_data then
    --     --     self._loading_profile_data.force_highest_mip = false
    --     -- end

    --     local primary = player_profile.loadout[SLOT_PRIMARY]
    --     local secondary = player_profile.loadout[SLOT_SECONDARY]

    --     local gear_id = primary and primary.gear_id or secondary and secondary.gear_id

    --     local placement = mod.next_ui_profile_spawner_placement_name[player_profile.character_id] or (gear_id and mod:gear_placement(gear_id)) or player_profile.placement_name
    --     if placement and self._camera then

    --         local offset = mod.settings.placement_camera[placement] or mod.settings.placement_camera.default
    --         local camera_position = offset and offset.position and vector3_unbox(offset.position) or vector3_zero()

    --         if self._reference_name == "InventoryCosmeticsView" then
    --             camera_position = camera_position + vector3(0, 3, 0)
    --         end

    --         ScriptCamera.set_local_position(self._camera, camera_position)

    --         self._rotation_angle = offset and offset.rotation or 0

    --         -- mod:gear_placement(gear_id, placement)
    --     end
    -- end

    -- Original function
    func(self, unit_3p, timeout, ...)
    -- Check spawn data
    if self:valid_instance() then
        -- Update equipment component
        self._character_spawn_data.equipment_component:extensions_ready()
    end
    
end)

-- mod:hook(CLASS.UIProfileSpawner, "_despawn_current_character_profile", function(func, self, ...)
--     -- Original function
--     func(self, ...)

--     if self.default_pose then
--         ScriptCamera.set_local_position(self._camera, vector3_unbox(self.default_pose.position))
--         self._rotation_angle = self.default_pose.rotation
--     end
-- end)

mod:hook(CLASS.UIProfileSpawner, "_spawn_character_profile", function(func, self, profile, profile_loader, position, rotation, scale, state_machine, animation_event, face_state_machine_key, face_animation_event, force_highest_mip, disable_hair_state_machine, optional_unit_3p, optional_ignore_state_machine, companion_data, ...)
    -- Catch profile
    if self:valid_instance(profile) then
        self.pt.catch_unit = profile
    end
    -- Ignore slots
    self._ignored_slots[SLOT_SECONDARY] = nil
    self._ignored_slots[SLOT_PRIMARY] = nil

    -- Get camera data
    if not self.default_pose and self._camera then
        self.default_pose = {
            position = vector3_box(ScriptCamera.local_position(self._camera)),
            rotation = self._rotation_angle,
        }
    end

    if self.default_pose and self._camera then
        ScriptCamera.set_local_position(self._camera, vector3_unbox(self.default_pose.position))
        self._rotation_angle = self.default_pose.rotation
    end

    -- local set_default_camera = true
    -- local player_profile = self:get_profile(profile)
    if (self:placement_entry(profile) and (self._reference_name == "PortraitUI" or self._reference_name == "InventoryCosmeticsView")) or self:placement_slot(profile) then

        force_highest_mip = false
        self._force_highest_lod_step = false
        if self._loading_profile_data then
            self._loading_profile_data.force_highest_mip = false
        end

        local primary = profile.loadout[SLOT_PRIMARY]
        local secondary = profile.loadout[SLOT_SECONDARY]

        local gear_id = primary and primary.gear_id or secondary and secondary.gear_id

        local placement = mod.next_ui_profile_spawner_placement_name[profile] or profile.placement_name --or (gear_id and mod:gear_placement(gear_id, nil, nil, true))
        placement = placement or (self:placement_slot(profile) and mod:gear_placement(gear_id))
        if placement and self._camera then

            mod.next_ui_profile_spawner_placement_name[profile] = nil

            local offset = mod.settings.placement_camera[placement] --or mod.settings.placement_camera.default
            local item_type = primary and primary.item_type or secondary and secondary.item_type
            offset = offset and item_type and offset[item_type] or offset
            local camera_position = offset and offset.position and vector3_unbox(offset.position) --or vector3_zero()
            if camera_position then

                if self._reference_name == "InventoryCosmeticsView" then
                    camera_position = camera_position + vector3(0, 3, 0)
                end

                ScriptCamera.set_local_position(self._camera, camera_position)

                self._rotation_angle = offset and offset.rotation or 0

                mod:gear_placement(gear_id, placement)
            end

            -- set_default_camera = false
        end
    end

    -- if set_default_camera then
    --     if self.default_pose and self._camera then
    --         ScriptCamera.set_local_position(self._camera, vector3_unbox(self.default_pose.position))
    --         self._rotation_angle = self.default_pose.rotation
    --     end
    -- end

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
