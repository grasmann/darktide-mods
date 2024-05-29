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
	local NilCursor = NilCursor
	local actor_unit = Actor.unit
	local unit_alive = Unit.alive
	local script_unit = ScriptUnit
	local PhysicsWorld = PhysicsWorld
	local unit_get_data = Unit.get_data
	local vector3_normalize = vector3.normalize
	local world_physics_world = World.physics_world
	local physics_world_raycast = PhysicsWorld.raycast
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

	instance.update_visible_equipment = function(self)
		if self._character_spawn_data then
			local spawn_data = self._character_spawn_data
			local unit = spawn_data.unit_3p
			if unit and unit_alive(unit) then
				if not script_unit_has_extension(unit, "visible_equipment_system") and mod:get(OPTION_VISIBLE_EQUIPMENT) and not self.no_spawn then
					-- Add VisibleEquipmentExtension
					script_unit_add_extension({
						world = self._world,
					}, unit, "VisibleEquipmentExtension", "visible_equipment_system", {
						profile = self._character_spawn_data.profile,
						is_local_unit = true,
						player_unit = unit,
						equipment_component = self._character_spawn_data.equipment_component,
						equipment = self._character_spawn_data.slots,
						wielded_slot = self._character_spawn_data.wielded_slot,
						ui_profile_spawner = true,
					})
				end
				self._rotation_input_disabled = false
			end
		end
	end

	instance.remove_custom_extensions = function(self)

		if self.help_units then
			for _, data in pairs(self.help_units) do
				World.unlink_unit(self._world, data.unit)
				World.destroy_unit(self._world, data.unit)
			end
			self.help_units = nil
		end

		if self._character_spawn_data then
			mod:remove_extension(self._character_spawn_data.unit_3p, "visible_equipment_system")
		end
	end

	instance.update_custom_extensions = function(self, dt, t)
		if self._character_spawn_data then
			mod:execute_extension(self._character_spawn_data.unit_3p, "visible_equipment_system", "load_slots")
			mod:execute_extension(self._character_spawn_data.unit_3p, "visible_equipment_system", "update", dt, t)
		end
	end

	instance.preview_flashlight = function(self, slot_id)
		if self._character_spawn_data then
			local slot = self._character_spawn_data.slots[SLOT_SECONDARY]
			-- local flashlight = mod:get_attachment_slot_in_attachments(slot.attachments_3p, "flashlight")
			local flashlight = mod.gear_settings:attachment_unit(slot.attachments_3p, "flashlight")
			
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

end)

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #############################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################################################

mod:hook(CLASS.UIProfileSpawner, "update", function(func, self, dt, t, input_service, ...)

	-- Original function
	func(self, dt, t, input_service, ...)

	-- Visible equipment
	self:update_custom_extensions(dt, t)

end)

mod:hook(CLASS.UIProfileSpawner, "ignore_slot", function(func, self, slot_id, ...)

	-- Skip primary and secondary slots
	if slot_id ~= SLOT_PRIMARY and slot_id ~= SLOT_SECONDARY then
		-- Original function
		func(self, slot_id, ...)
	end

end)

mod:hook(CLASS.UIProfileSpawner, "cb_on_unit_3p_streaming_complete", function(func, self, unit_3p, ...)

	-- Original function
	func(self, unit_3p, ...)

	-- Visible equipment
	self:update_visible_equipment()

end)

mod:hook(CLASS.UIProfileSpawner, "wield_slot", function(func, self, slot_id, ...)

	-- Original function
	func(self, slot_id, ...)

	-- Wield custom extensions
	self:wield_custom(slot_id)

	-- Flashlight
	self:preview_flashlight(slot_id)

end)

mod:hook(CLASS.UIProfileSpawner, "destroy", function(func, self, ...)

	-- Extensions
	self:remove_custom_extensions()

	-- Original function
	func(self, ...)

end)

mod:hook(CLASS.UIProfileSpawner, "_get_raycast_hit", function(func, self, from, to, physics_world, collision_filter, ...)
	local character_spawn_data = self._character_spawn_data
	local unit_3p = character_spawn_data and character_spawn_data.unit_3p

	local result, other = physics_world_raycast(physics_world, from, to, 30, "all", "collision_filter", collision_filter)

	if not result then
		return
	end

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
end)