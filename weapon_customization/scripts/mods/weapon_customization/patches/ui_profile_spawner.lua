local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
	local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
	local Unit = Unit
	local pairs = pairs
	local CLASS = CLASS
	local Actor = Actor
	local World = World
	local Camera = Camera
	local vector3 = Vector3
	local managers = Managers
	local NilCursor = NilCursor
	local actor_unit = Actor.unit
	local unit_alive = Unit.alive
	local script_unit = ScriptUnit
	local PhysicsWorld = PhysicsWorld
	local unit_get_data = Unit.get_data
	local vector3_normalize = vector3.normalize
	local world_unlink_unit = World.unlink_unit
	local world_destroy_unit = World.destroy_unit
	local world_physics_world = World.physics_world
	local physics_world_raycast = PhysicsWorld.raycast
	local script_unit_extension = script_unit.extension
	local camera_screen_to_world = Camera.screen_to_world
	local script_unit_has_extension = script_unit.has_extension
	local script_unit_add_extension = script_unit.add_extension
	local script_unit_remove_extension = script_unit.remove_extension
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local OPTION_VISIBLE_EQUIPMENT_NO_HUB = "mod_option_visible_equipment_disable_in_hub"
	local OPTION_VISIBLE_EQUIPMENT = "mod_option_visible_equipment"
	local WEAPON_CUSTOMIZATION_TAB = "tab_weapon_customization"
	local SLOT_SECONDARY = "slot_secondary"
	local SLOT_PRIMARY = "slot_primary"
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/managers/ui/ui_profile_spawner", function(instance)

	instance.get_inventory_view = function(self)
		self.inventory_view = self.inventory_view or mod:get_view("inventory_view")
	end

	instance.is_customization_tab = function(self)
		self:get_inventory_view()
		local inventory_view = self.inventory_view
		local tab_context = inventory_view and inventory_view._active_category_tab_context
		return tab_context and tab_context.display_name == WEAPON_CUSTOMIZATION_TAB
	end

	instance.update_visible_equipment = function(self, dt, t)
		local spawn_data = self._character_spawn_data
		if spawn_data then
			local unit = spawn_data.unit_3p
			if unit and unit_alive(unit) then
				local visible_equipment_extension = script_unit_extension(unit, "visible_equipment_system")
				local hub = not mod:is_in_hub() or not self.disable_visible_equipment_system_in_hub
				local use_visible_equipment_system = self.use_visible_equipment_system and hub
				if use_visible_equipment_system then
					if visible_equipment_extension then
						-- Update VisibleEquipmentExtension
						visible_equipment_extension:load_slots()
						visible_equipment_extension:update(dt, t)
					else
						-- Add VisibleEquipmentExtension
						script_unit_add_extension({
							world = self._world,
						}, unit, "VisibleEquipmentExtension", "visible_equipment_system", {
							profile = spawn_data.profile,
							is_local_unit = true,
							player_unit = unit,
							equipment_component = spawn_data.equipment_component,
							equipment = spawn_data.slots,
							wielded_slot = spawn_data.wielded_slot,
							ui_profile_spawner = true,
						})

					end
				elseif visible_equipment_extension then
					-- Remove VisibleEquipmentExtension
					visible_equipment_extension:delete_slots()
					mod:remove_extension(unit, "visible_equipment_system")
				end
			end
		end
	end

	instance.remove_custom_extensions = function(self)
		if self._character_spawn_data then
			mod:execute_extension(self._character_spawn_data.unit_3p, "visible_equipment_system", "delete_slots")
			mod:execute_extension(self._character_spawn_data.unit_3p, "visible_equipment_system", "delete")
			mod:remove_extension(self._character_spawn_data.unit_3p, "visible_equipment_system")
		end
		if self.help_units then
			for _, data in pairs(self.help_units) do
				world_unlink_unit(self._world, data.unit)
				world_destroy_unit(self._world, data.unit)
			end
			self.help_units = nil
		end
	end

	instance.update_custom_extensions = function(self, dt, t)
		-- Visible equipment
		self:update_visible_equipment(dt, t)
	end

	instance.preview_flashlight = function(self, slot_id)
		if self._character_spawn_data then
			local slot = self._character_spawn_data.slots[SLOT_SECONDARY]
			local attachments_3p = slot.attachments_by_unit_3p and slot.attachments_by_unit_3p[slot.unit_3p]
			local flashlight = mod.gear_settings:attachment_unit(attachments_3p, "flashlight")
			local attachment_name = flashlight and unit_get_data(flashlight, "attachment_name")
			if flashlight and attachment_name and slot_id == SLOT_SECONDARY then
				mod:preview_flashlight(true, self._world, flashlight, attachment_name, true)
			else
				mod:preview_flashlight(false, self._world, flashlight, attachment_name, true)
			end
		end
	end

	instance.wield_custom = function(self, slot_id)
		if self._character_spawn_data then
			local slot = self._character_spawn_data.slots[slot_id]
			mod:execute_extension(self._character_spawn_data.unit_3p, "visible_equipment_system", "on_wield_slot", slot)
		end
	end

	instance.on_settings_changed = function(self)
        self.use_visible_equipment_system = mod:get("mod_option_visible_equipment")
        self.disable_visible_equipment_system_in_hub = mod:get("mod_option_visible_equipment_disable_in_hub")
    end

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

end)

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #############################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################################################

mod:hook(CLASS.UIProfileSpawner, "init", function(func, self, reference_name, world, camera, unit_spawner, force_highest_lod_step, optional_mission_template, ...)

	-- Original function
	func(self, reference_name, world, camera, unit_spawner, force_highest_lod_step, optional_mission_template, ...)

	managers.event:register(self, "weapon_customization_settings_changed", "on_settings_changed")

	self._rotation_input_disabled = false

	self:on_settings_changed()

end)

mod:hook(CLASS.UIProfileSpawner, "destroy", function(func, self, ...)

	-- Extensions
	self:remove_custom_extensions()

	managers.event:unregister(self, "weapon_customization_settings_changed")

	-- Original function
	func(self, ...)

end)

mod:hook(CLASS.UIProfileSpawner, "update", function(func, self, dt, t, input_service, ...)

	self._rotation_input_disabled = false

	-- Original function
	func(self, dt, t, input_service, ...)

	if self:spawned() and not self:loading() and self:spawned_character_unit() then

		-- Visible equipment
		self:update_custom_extensions(dt, t)

	end

end)

mod:hook(CLASS.UIProfileSpawner, "ignore_slot", function(func, self, slot_id, ...)

	-- Skip primary and secondary slots
	if slot_id ~= SLOT_PRIMARY and slot_id ~= SLOT_SECONDARY then
		-- Original function
		func(self, slot_id, ...)
	end

end)

mod:hook(CLASS.UIProfileSpawner, "_spawn_character_profile", function(func, self, profile, profile_loader, position, rotation, scale, state_machine, animation_event, face_state_machine_key, face_animation_event, force_highest_mip, disable_hair_state_machine, optional_unit_3p, optional_ignore_state_machine, ...)

	self._ignored_slots[SLOT_SECONDARY] = nil
	self._ignored_slots[SLOT_PRIMARY] = nil

	-- Original function
	func(self, profile, profile_loader, position, rotation, scale, state_machine, animation_event, face_state_machine_key, face_animation_event, force_highest_mip, disable_hair_state_machine, optional_unit_3p, optional_ignore_state_machine, ...)

	local data = self._loading_profile_data or self._character_spawn_data
	if data then
		if not data.state_machine or mod:cached_find(data.state_machine, "end_of_round") then
			if (not data.profile.loadout[SLOT_SECONDARY] or not data.profile.loadout[SLOT_SECONDARY].__master_item) and data.profile.visual_loadout and data.profile.visual_loadout[SLOT_SECONDARY] then
				self:_change_slot_item(SLOT_SECONDARY, data.profile.visual_loadout[SLOT_SECONDARY])
			end
			if (not data.profile.loadout[SLOT_PRIMARY] or not data.profile.loadout[SLOT_PRIMARY].__master_item) and data.profile.visual_loadout and data.profile.visual_loadout[SLOT_PRIMARY] then
				self:_change_slot_item(SLOT_PRIMARY, data.profile.visual_loadout[SLOT_PRIMARY])
			end
		end
	end

end)

mod:hook(CLASS.UIProfileSpawner, "cb_on_unit_3p_streaming_complete", function(func, self, unit_3p, ...)

	-- Original function
	func(self, unit_3p, ...)

	-- Visible equipment
	self:update_visible_equipment()

	local data = self._loading_profile_data or self._character_spawn_data
	if data then
		if not data.state_machine or mod:cached_find(data.state_machine, "end_of_round") then
			if not data.profile.loadout[SLOT_PRIMARY] or (not data.wielded_slot or data.wielded_slot.name ~= SLOT_PRIMARY) then
				mod:execute_extension(data.unit_3p, "visible_equipment_system", "unwield_slot_by_name", SLOT_PRIMARY)
			end
			if not data.profile.loadout[SLOT_SECONDARY] or (not data.wielded_slot or data.wielded_slot.name ~= SLOT_SECONDARY) then
				mod:execute_extension(data.unit_3p, "visible_equipment_system", "unwield_slot_by_name", SLOT_SECONDARY)
			end
		end
	end

end)

mod:hook(CLASS.UIProfileSpawner, "wield_slot", function(func, self, slot_id, ...)

	-- Original function
	func(self, slot_id, ...)

	-- Wield custom extensions
	self:wield_custom(slot_id)

	local data = self._loading_profile_data or self._character_spawn_data
	if data then
		if not data.state_machine or mod:cached_find(data.state_machine, "end_of_round") then
			if (not data.profile.loadout[slot_id] or not data.profile.loadout[slot_id].__master_item) and data.profile.visual_loadout and data.profile.visual_loadout[slot_id] then
				self:_change_slot_item(slot_id, data.profile.visual_loadout[slot_id])
			end
		end
	end

	-- Flashlight
	self:preview_flashlight(slot_id)

end)

mod:hook(CLASS.UIProfileSpawner, "_despawn_players_characters", function(func, self, ...)

	-- Extensions
	self:remove_custom_extensions()

	-- Original function
	func(self, ...)

end)

mod:hook(CLASS.UIProfileSpawner, "_get_raycast_hit", function(func, self, from, to, physics_world, collision_filter, ...)
	-- Return custom raycast
	return self:custom_raycast(from, to, physics_world, collision_filter)
end)