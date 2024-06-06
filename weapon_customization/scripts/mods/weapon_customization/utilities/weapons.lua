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
	local color = Color
	local math = math
	local unit_alive = Unit.alive
	local type = type
	local Unit = Unit
	local table = table
	local pairs = pairs
	local unit_world_pose = Unit.world_pose
	local unit_get_data = Unit.get_data
	local string = string
	local unit_set_data = Unit.set_data
	local World = World
	local world_create_particles = World.create_particles
	local unit_world_position = Unit.world_position
	local unit_world_rotation = Unit.world_rotation
	local world_destroy_particles = World.destroy_particles
	local world_stop_spawning_particles = World.stop_spawning_particles
	local vector3 = Vector3
	local tostring = tostring
	local world_set_particles_use_custom_fov = World.set_particles_use_custom_fov
	local unit_box = Unit.box
	local world_link_particles = World.link_particles
	local managers = Managers
	local matrix4x4 = Matrix4x4
	local matrix4x4_identity = matrix4x4.identity
	local matrix4x4_set_scale = matrix4x4.set_scale
	local script_unit = ScriptUnit
	local string_find = string.find
	local math_random = math.random
	local table_contains = table.contains
	local matrix4x4_transform = Matrix4x4.transform
	local math_random_array_entry = math.random_array_entry
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local REFERENCE = "weapon_customization"
	local REWARD_ITEM = "reward_item"
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.spawn_premium_effects = function(self, item, item_unit, attachment_units, world)
	if attachment_units and self:has_premium_skin(item) then
		self:echot("premium skin - glow")
		-- local particle_name = "content/fx/particles/interacts/servoskull_visibility_hover"
		-- local particle_name = "content/fx/particles/enemies/red_glowing_eyes"
		-- local particle_name = "content/fx/particles/abilities/psyker_warp_charge_shout"
		-- local particle_name = "content/fx/particles/enemies/buff_stummed";
		local particle_name = "content/fx/particles/abilities/chainlightning/protectorate_chainlightning_hands_charge";
		local color = color(255, 255, 0, 0)
		-- local intensity = 10
		local world_scale = vector3(.1, .1, .1)
		local unit = attachment_units[1] --item_unit
		-- for _, unit in pairs(attachment_units) do
			if unit and unit_alive(unit) and not unit_get_data(unit, "premium_particle") then
				local world_position = unit_world_position(unit, 1)
				local world_rotation = unit_world_rotation(unit, 1)
				local particle_id = world_create_particles(world, particle_name, world_position, world_rotation, world_scale)
				local unit_world_pose = unit_world_pose(unit, 1)
				-- Matrix4x4.set_translation(unit_world_pose, vector3(0, distance, 0))
				matrix4x4_set_scale(unit_world_pose, vector3(.1, .1, .1))
				world_link_particles(world, particle_id, unit, 1, matrix4x4_identity(), "destroy")
				world_set_particles_use_custom_fov(world, particle_id, true)
				unit_set_data(unit, "premium_particle", particle_id)
			end
		-- end
	end
end

mod.despawn_premium_effects = function(self, item, item_unit, attachment_units, world)
	if attachment_units then
		for _, unit in pairs(attachment_units) do
			if unit and unit_alive(unit) then
				local particle_id = unit_get_data(unit, "premium_particle")
				if particle_id then
					world_stop_spawning_particles(world, particle_id)
					world_destroy_particles(world, particle_id)
				end
				unit_set_data(unit, "premium_particle", nil)
			end
		end
	end
end

mod.random_chance = {
    bayonet = "mod_option_randomization_bayonet",
    flashlight = "mod_option_randomization_flashlight",
}

mod.randomize_weapon = function(self, item)
    local random_attachments = {}
    local possible_attachments = {}
    local no_support_entries = {}
    local trigger_move_entries = {}
    local item_name = self:item_name_from_content_string(item.name)
    -- local attachment_slots = self:get_item_attachment_slots(item)
	local attachment_slots = mod.gear_settings:possible_attachment_slots(item)
	local gear_id = mod.gear_settings:item_to_gear_id(item)
	local base_mod_only = self:get("mod_option_randomization_only_base_mod")
    for _, attachment_slot in pairs(attachment_slots) do
        if self.attachment[item_name] and self.attachment[item_name][attachment_slot] and not table_contains(self.automatic_slots, attachment_slot) then
            local chance_success = true
            if self.random_chance[attachment_slot] then
                local chance_option = self.random_chance[attachment_slot]
                local chance = self:get(chance_option)
                -- local already_has_attachment = self:get_actual_default_attachment(item, attachment_slot)
				local already_has_attachment = mod.gear_settings:default_attachment(item, attachment_slot)
                if already_has_attachment then chance = 100 end
                local random_chance = math_random(100)
                chance_success = random_chance <= chance
            end
            if chance_success then
                for _, data in pairs(self.attachment[item_name][attachment_slot]) do
                    if not string_find(data.id, "default") and not data.no_randomize and self.attachment_models[item_name][data.id] and (data.original_mod or not base_mod_only) then
                        possible_attachments[attachment_slot] = possible_attachments[attachment_slot] or {}
                        possible_attachments[attachment_slot][#possible_attachments[attachment_slot]+1] = data.id
                    end
                end
                if possible_attachments[attachment_slot] then
                    local random_attachment = math_random_array_entry(possible_attachments[attachment_slot])
                    -- if attachment_slot == "flashlight" then random_attachment = "laser_pointer" end
                    random_attachments[attachment_slot] = random_attachment
                    local attachment_data = self.attachment_models[item_name][random_attachment]
                    local no_support = attachment_data and attachment_data.no_support
                    -- local trigger_move = attachment_data and attachment_data.trigger_move
                    attachment_data = mod.gear_settings:apply_fixes(item, attachment_slot) or attachment_data
                    no_support = attachment_data.no_support or no_support
                    -- trigger_move = attachment_data.trigger_move or trigger_move
                    -- if trigger_move then
                    --     for _, trigger_move_entry in pairs(trigger_move) do
                    --         if not table_contains(trigger_move_entries, trigger_move_entry) and not possible_attachments[trigger_move_entry] then
                    --             trigger_move_entries[#trigger_move_entries+1] = trigger_move_entry
                    --         end
                    --     end
                    -- end
                    if no_support then
                        for _, no_support_entry in pairs(no_support) do
                            no_support_entries[#no_support_entries+1] = no_support_entry
                        end
                    end
                end
            end
        end
    end
    -- No support
    for _, no_support_entry in pairs(no_support_entries) do
        for attachment_slot, random_attachment in pairs(random_attachments) do
            while random_attachment == no_support_entry do
                random_attachment = math_random_array_entry(possible_attachments[attachment_slot])
                random_attachments[attachment_slot] = random_attachment
            end
            if attachment_slot == no_support_entry then
                random_attachments[no_support_entry] = "default"
            end
        end
    end
    -- Trigger move
    for _, trigger_move_entry in pairs(trigger_move_entries) do
		random_attachments[trigger_move_entry] = self.gear_settings:get(item, trigger_move_entry)
    end
    return random_attachments
end

-- Get equipped weapon from gear id
mod.get_weapon_from_gear_id = function(self, from_gear_id)
	if self.weapon_extension and self.weapon_extension._weapons then
		-- Iterate equipped itemslots
		for slot_name, weapon in pairs(self.weapon_extension._weapons) do
			-- Check gear id
			local gear_id = mod.gear_settings:item_to_gear_id(weapon.item)
			if from_gear_id == gear_id then
				-- Check weapon unit
				if weapon.weapon_unit then
					return slot_name, weapon
				end
			end
		end
	end
end

mod.has_flashlight = function(self, item)
	local flashlight = self.gear_settings:get(item, "flashlight")
	return flashlight and flashlight ~= "laser_pointer"
end

mod.is_owned_by_other_player = function(self, item)
	-- local in_possesion_of_player = mod.gear_settings:player_item(item_data)
	return not self.gear_settings:player_item(item) and not self:is_store_item(item) and not self:is_premium_store_item(item)
end

mod.is_store_item = function(self, item)
	return mod:get_view("credits_vendor_view") or mod:get_view("marks_vendor_view")
end

mod.is_premium_store_item = function(self, item)
	return mod:get_view("store_view") or mod:get_view("store_item_detail_view")
end

mod.not_trinket = function(self, attachment_slot)
	return attachment_slot ~= "slot_trinket_1" and attachment_slot ~= "slot_trinket_2" and true
end

mod.has_premium_skin = function(self, item)
	local item = item.__master_item or item
	local item_name = self:item_name_from_content_string(item.name)
	local weapon_skin = item.slot_weapon_skin
	if weapon_skin and type(weapon_skin) == "string" and weapon_skin ~= "" then
		self:setup_item_definitions()
		weapon_skin = self:persistent_table(REFERENCE).item_definitions[weapon_skin]
	end
	if weapon_skin and type(weapon_skin) == "table" and weapon_skin.attachments then
		-- mod:echot(weapon_skin.name)
		-- mod:dtf(weapon_skin, "weapon_skin", 6)
		if weapon_skin.feature_flags then
			-- if table_contains(weapon_skin.feature_flags, "FEATURE_premium_store") then
			-- 	mod:echot("flag: "..tostring(weapon_skin.feature_flags[1]))
			-- end
			return table_contains(weapon_skin.feature_flags, "FEATURE_premium_store")
			-- for _, flag in pairs(weapon_skin.feature_flags) do
			-- 	mod:echot("flag: "..tostring(flag))
			-- end
		end
	end
end

mod.get_gear_size = function(self) end

-- Redo weapon attachments by unequipping and reequipping weapon
mod.redo_weapon_attachments = function(self, item)
	local gear_id = mod.gear_settings:item_to_gear_id(item)
	local slot_name, weapon = self:get_weapon_from_gear_id(gear_id)
	if weapon then
		-- Get gameplay time
		local gameplay_time = self.time_manager:time("gameplay")
		-- Get latest frame
		local latest_frame = FixedFrame.get_latest_fixed_time()
		-- Reset flashlight cache
		-- self.attached_flashlights[gear_id] = {}
		-- self:persistent_table(REFERENCE).flashlight_on = false
		-- Reset laser pointer cache
		-- self:reset_laser_pointer()
		-- self.attached_laser_pointers[gear_id] = {}
		-- Sights
		-- local sights_extension = script_unit.extension(self.player_unit, "sights_system")
		mod:remove_extension(mod.player_unit, "visible_equipment_system")
		-- Unequip
		self.visual_loadout_extension:unequip_item_from_slot(slot_name, latest_frame)
		-- Equip
		self.visual_loadout_extension:equip_item_to_slot(item, slot_name, nil, gameplay_time)
		-- sights_extension:on_weapon_equipped()
		self:print("redo_weapon_attachments - done")
		-- Trigger flashlight update
		self._update_flashlight = true
	else self:print("redo_weapon_attachments - weapon is nil") end
end

local points = {}
mod.weapon_points = function(self, attachments)
	points = {}
	for _, unit in pairs(attachments) do
		if unit and Unit.alive(unit) then
			local tm, half_size = Unit.box(unit)
			points[unit] = {}
			points[unit][#points[unit]+1] = matrix4x4_transform(tm, vector3(half_size.x, half_size.y, -half_size.z))
			points[unit][#points[unit]+1] = matrix4x4_transform(tm, vector3(half_size.x, -half_size.y, -half_size.z))
			points[unit][#points[unit]+1] = matrix4x4_transform(tm, vector3(-half_size.x, -half_size.y, -half_size.z))
			points[unit][#points[unit]+1] = matrix4x4_transform(tm, vector3(-half_size.x, half_size.y, -half_size.z))
			points[unit][#points[unit]+1] = matrix4x4_transform(tm, vector3(half_size.x, half_size.y, half_size.z))
			points[unit][#points[unit]+1] = matrix4x4_transform(tm, vector3(half_size.x, -half_size.y, half_size.z))
			points[unit][#points[unit]+1] = matrix4x4_transform(tm, vector3(-half_size.x, -half_size.y, half_size.z))
			points[unit][#points[unit]+1] = matrix4x4_transform(tm, vector3(-half_size.x, half_size.y, half_size.z))
		end
	end
	return points
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
