local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
	local FixedFrame = mod:original_require("scripts/utilities/fixed_frame")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
	local math = math
	local type = type
	local Unit = Unit
	local color = Color
	local table = table
	local pairs = pairs
	local World = World
	local string = string
	local vector3 = Vector3
	local tostring = tostring
	local matrix4x4 = Matrix4x4
	local unit_alive = Unit.alive
	local unit_get_data = Unit.get_data
	local unit_set_data = Unit.set_data
	local table_contains = table.contains
	local unit_world_pose = Unit.world_pose
	local matrix4x4_identity = matrix4x4.identity
	local unit_world_position = Unit.world_position
	local unit_world_rotation = Unit.world_rotation
	local matrix4x4_set_scale = matrix4x4.set_scale
	local matrix4x4_transform = Matrix4x4.transform
	local world_link_particles = World.link_particles
	local world_create_particles = World.create_particles
	local world_destroy_particles = World.destroy_particles
	local world_stop_spawning_particles = World.stop_spawning_particles
	local world_set_particles_use_custom_fov = World.set_particles_use_custom_fov
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local REFERENCE = "weapon_customization"
	local REWARD_ITEM = "reward_item"
	local weapon_points = {}
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

-- mod.spawn_premium_effects = function(self, item, item_unit, attachment_units, world)
-- 	if attachment_units and self:has_premium_skin(item) then
-- 		local particle_name = "content/fx/particles/abilities/chainlightning/protectorate_chainlightning_hands_charge"
-- 		local color = color(255, 255, 0, 0)
-- 		-- local intensity = 10
-- 		local world_scale = vector3(.1, .1, .1)
-- 		local unit = attachment_units[1] --item_unit
-- 		-- for _, unit in pairs(attachment_units) do
-- 			if unit and unit_alive(unit) and not unit_get_data(unit, "premium_particle") then
-- 				local world_position = unit_world_position(unit, 1)
-- 				local world_rotation = unit_world_rotation(unit, 1)
-- 				local particle_id = world_create_particles(world, particle_name, world_position, world_rotation, world_scale)
-- 				local unit_world_pose = unit_world_pose(unit, 1)
-- 				-- Matrix4x4.set_translation(unit_world_pose, vector3(0, distance, 0))
-- 				matrix4x4_set_scale(unit_world_pose, vector3(.1, .1, .1))
-- 				world_link_particles(world, particle_id, unit, 1, matrix4x4_identity(), "destroy")
-- 				world_set_particles_use_custom_fov(world, particle_id, true)
-- 				unit_set_data(unit, "premium_particle", particle_id)
-- 			end
-- 		-- end
-- 	end
-- end

-- mod.despawn_premium_effects = function(self, item, item_unit, attachment_units, world)
-- 	if attachment_units then
-- 		for _, unit in pairs(attachment_units) do
-- 			if unit and unit_alive(unit) then
-- 				local particle_id = unit_get_data(unit, "premium_particle")
-- 				if particle_id then
-- 					world_stop_spawning_particles(world, particle_id)
-- 					world_destroy_particles(world, particle_id)
-- 				end
-- 				unit_set_data(unit, "premium_particle", nil)
-- 			end
-- 		end
-- 	end
-- end

mod.random_chance = {
    bayonet = "mod_option_randomization_bayonet",
    flashlight = "mod_option_randomization_flashlight",
}

-- Get equipped weapon from gear id
-- mod.get_weapon_from_gear_id = function(self, from_gear_id)
-- 	if self.weapon_extension and self.weapon_extension._weapons then
-- 		-- Iterate equipped itemslots
-- 		for slot_name, weapon in pairs(self.weapon_extension._weapons) do
-- 			-- Check gear id
-- 			local gear_id = mod.gear_settings:item_to_gear_id(weapon.item)
-- 			if from_gear_id == gear_id then
-- 				-- Check weapon unit
-- 				if weapon.weapon_unit then
-- 					return slot_name, weapon
-- 				end
-- 			end
-- 		end
-- 	end
-- end

-- mod.has_flashlight = function(self, item)
-- 	local flashlight = self.gear_settings:get(item, "flashlight")
-- 	return flashlight and flashlight ~= "laser_pointer"
-- end

mod.is_owned_by_other_player = function(self, item)
	return not self.gear_settings:player_item(item) and not self:is_store_item(item) and not self:is_premium_store_item(item)
end

mod.is_store_item = function(self, item)
	return self:get_view("credits_vendor_view") or self:get_view("marks_vendor_view")
end

mod.is_premium_store_item = function(self, item)
	return self:get_view("store_view") or self:get_view("store_item_detail_view")
end

-- mod.not_trinket = function(self, attachment_slot)
-- 	return attachment_slot ~= "slot_trinket_1" and attachment_slot ~= "slot_trinket_2" and true
-- end

-- mod.has_premium_skin = function(self, item)
-- 	local item = item.__master_item or item
-- 	local item_name = self.gear_settings:short_name(item.name)
-- 	local weapon_skin = item.slot_weapon_skin
-- 	if weapon_skin and type(weapon_skin) == "string" and weapon_skin ~= "" then
-- 		self:setup_item_definitions()
-- 		weapon_skin = self:persistent_table(REFERENCE).item_definitions[weapon_skin]
-- 	end
-- 	if weapon_skin and type(weapon_skin) == "table" and weapon_skin.attachments then
-- 		-- mod:dtf(weapon_skin, "weapon_skin", 6)
-- 		if weapon_skin.feature_flags then
-- 			-- if table_contains(weapon_skin.feature_flags, "FEATURE_premium_store") then
-- 			-- end
-- 			return table_contains(weapon_skin.feature_flags, "FEATURE_premium_store")
-- 			-- for _, flag in pairs(weapon_skin.feature_flags) do
-- 			-- end
-- 		end
-- 	end
-- end

-- mod.get_gear_size = function(self) end

-- Redo weapon attachments by unequipping and reequipping weapon
mod.redo_weapon_attachments = function(self, item)
	local gear_settings = self.gear_settings
	local gear_id = gear_settings:item_to_gear_id(item)
	local slot_name, weapon = gear_settings:get_weapon_from_gear_id(gear_id)
	if weapon then
		-- Remove visible equipment extension
		mod:execute_extension(mod.player_unit, "visible_equipment_system", "delete_slots")
		mod:execute_extension(mod.player_unit, "visible_equipment_system", "delete")
		mod:remove_extension(mod.player_unit, "visible_equipment_system")
		-- Unequip
		self.visual_loadout_extension:unequip_item_from_slot(slot_name, FixedFrame.get_latest_fixed_time())
		-- Equip
		self.visual_loadout_extension:equip_item_to_slot(item, slot_name, nil, self.time_manager:time("gameplay"))
		-- sights_extension:on_weapon_equipped()
		self:print("redo_weapon_attachments - done")
		-- Trigger flashlight update
		self._update_flashlight = true
	else self:print("redo_weapon_attachments - weapon is nil") end
end

mod.weapon_points = function(self, attachments)
	table.clear(weapon_points)
	for _, unit in pairs(attachments) do
		if unit and Unit.alive(unit) then
			local tm, half_size = Unit.box(unit)
			weapon_points[unit] = weapon_points[unit] or {}
			weapon_points[unit][1] = matrix4x4_transform(tm, vector3(half_size.x, half_size.y, -half_size.z))
			weapon_points[unit][2] = matrix4x4_transform(tm, vector3(half_size.x, -half_size.y, -half_size.z))
			weapon_points[unit][3] = matrix4x4_transform(tm, vector3(-half_size.x, -half_size.y, -half_size.z))
			weapon_points[unit][4] = matrix4x4_transform(tm, vector3(-half_size.x, half_size.y, -half_size.z))
			weapon_points[unit][5] = matrix4x4_transform(tm, vector3(half_size.x, half_size.y, half_size.z))
			weapon_points[unit][6] = matrix4x4_transform(tm, vector3(half_size.x, -half_size.y, half_size.z))
			weapon_points[unit][7] = matrix4x4_transform(tm, vector3(-half_size.x, -half_size.y, half_size.z))
			weapon_points[unit][8] = matrix4x4_transform(tm, vector3(-half_size.x, half_size.y, half_size.z))
		end
	end
	return weapon_points
end

mod.weapon_size = function(self, attachments)
	local points = self:weapon_points(attachments);
	local maxDistance = 0
	for unit1, unit_points1 in pairs(points) do
		for unit2, unit_points2 in pairs(points) do
			if unit1 ~= unit2 then
				for i1, position1 in pairs(unit_points1) do
					for i2, position2 in pairs(unit_points2) do
						if i1 ~= i2 then
							local distance = vector3.distance(position1, position2)
							maxDistance = math.max(maxDistance, distance)
						end
					end
				end
			end
		end
	end
	return maxDistance
end
