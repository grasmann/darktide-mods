local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local FixedFrame = mod:original_require("scripts/utilities/fixed_frame")

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

local REFERENCE = "weapon_customization"
local REWARD_ITEM = "reward_item"

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
    local attachment_slots = self:get_item_attachment_slots(item)
    local gear_id = self:get_gear_id(item)
    for _, attachment_slot in pairs(attachment_slots) do
        if self.attachment[item_name][attachment_slot] and not table_contains(self.automatic_slots, attachment_slot) then
            local chance_success = true
            if self.random_chance[attachment_slot] then
                local chance_option = self.random_chance[attachment_slot]
                local chance = self:get(chance_option)
                local already_has_attachment = self:get_actual_default_attachment(item, attachment_slot)
                if already_has_attachment then chance = 100 end
                local random_chance = math_random(100)
                chance_success = random_chance <= chance
            end
            if chance_success then
                for _, data in pairs(self.attachment[item_name][attachment_slot]) do
                    if not string_find(data.id, "default") and not data.no_randomize and self.attachment_models[item_name][data.id] then
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
                    attachment_data = self:_apply_anchor_fixes(item, attachment_slot) or attachment_data
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
	-- -- Auto equip
	-- for attachment_slot, value in pairs(random_attachments) do
	-- 	if not mod.add_custom_attachments[attachment_slot] then
	-- 		mod:resolve_auto_equips(item, value)
	-- 	end
	-- end
	-- for attachment_slot, value in pairs(random_attachments) do
	-- 	if mod.add_custom_attachments[attachment_slot] then
	-- 		mod:resolve_auto_equips(item, value)
	-- 	end
	-- end
	-- -- Special resolve
	-- for attachment_slot, value in pairs(random_attachments) do
	-- 	if mod.add_custom_attachments[attachment_slot] then
	-- 		mod:resolve_special_changes(item, value)
	-- 	end
	-- end
	-- for attachment_slot, value in pairs(random_attachments) do
	-- 	if not mod.add_custom_attachments[attachment_slot] then
	-- 		mod:resolve_special_changes(item, value)
	-- 	end
	-- end
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
        random_attachments[trigger_move_entry] = self:get_gear_setting(gear_id, trigger_move_entry, item)
    end
    return random_attachments
end

-- -- Get currently wielded weapon
-- mod.get_wielded_weapon = function(self)
-- 	if self.initialized then
-- 		local inventory_component = self.weapon_extension._inventory_component
-- 		local weapons = self.weapon_extension._weapons
-- 		return self.weapon_extension:_wielded_weapon(inventory_component, weapons)
-- 	end
-- end

-- -- Get wielded slot
-- mod.get_wielded_slot = function(self)
-- 	local inventory_component = self.weapon_extension._inventory_component
-- 	return inventory_component.wielded_slot
-- end

-- -- Get wielded 3p unit
-- mod.get_wielded_weapon_3p = function(self)
-- 	return self.visual_loadout_extension:unit_3p_from_slot("slot_secondary")
-- end

-- Get equipped weapon from gear id
mod.get_weapon_from_gear_id = function(self, from_gear_id)
	if self.weapon_extension and self.weapon_extension._weapons then
		-- Iterate equipped itemslots
		for slot_name, weapon in pairs(self.weapon_extension._weapons) do
			-- Check gear id
			local gear_id = mod:get_gear_id(weapon.item)
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
	local gear_id = self:get_gear_id(item)
	local flashlight = gear_id and self:get_gear_setting(gear_id, "flashlight")
	return flashlight and flashlight ~= "laser_pointer"
end

-- Get gear id from item
mod.get_gear_id = function(self, item)
	local gear_id = item and (item.__gear and item.__gear.uuid or item.__original_gear_id or item.__gear_id or item.gear_id)
	return gear_id or REWARD_ITEM --and mod.gear_id_to_offer_id[gear_id] or gear_id
end

mod.get_real_gear_id = function(self, item)
	local gear_id = item and (item.__original_gear_id or item.__gear and item.__gear.uuid or item.__gear_id or item.gear_id)
	return gear_id or REWARD_ITEM --and mod.gear_id_to_offer_id[gear_id] or gear_id
end

-- Get slot info id
mod.get_slot_info_id = function(self, item)
	local slot_info_id = item and (item.gear_id or item.__gear_id or item.__original_gear_id or item.__gear and item.__gear.uuid)
	return slot_info_id or REWARD_ITEM --and mod.gear_id_to_offer_id[slot_info_id] or slot_info_id
end

mod.is_owned_by_player = function(self, item)
	local gear_id = self:get_gear_id(item)
	return gear_id and mod.player_items[gear_id] or mod:get_view("inventory_view") or mod:get_view("inventory_weapons_view") or mod:get_cosmetic_view()
end

mod.is_owned_by_other_player = function(self, item)
	return not self:is_owned_by_player(item) and not self:is_store_item(item) and not self:is_premium_store_item(item)
end

mod.is_store_item = function(self, item)
	return mod:get_view("credits_vendor_view") or mod:get_view("marks_vendor_view")
end

mod.is_premium_store_item = function(self, item)
	return mod:get_view("store_view") or mod:get_view("store_item_detail_view")
end

-- mod.save_equipment_file = function(self, gear_id)

-- end

-- Set attachment for specified gear id and slot
mod.set_gear_setting = function(self, gear_id, attachment_slot, optional_attachment_or_nil)
	if self:persistent_table(REFERENCE).temp_gear_settings[gear_id] then
		if not optional_attachment_or_nil or (optional_attachment_or_nil and (string_find(optional_attachment_or_nil, "default") or optional_attachment_or_nil == "default")) then
			self:persistent_table(REFERENCE).temp_gear_settings[gear_id][attachment_slot] = nil
		else
			self:persistent_table(REFERENCE).temp_gear_settings[gear_id][attachment_slot] = optional_attachment_or_nil
		end
	else
		if not optional_attachment_or_nil or (optional_attachment_or_nil and (string_find(optional_attachment_or_nil, "default") or optional_attachment_or_nil == "default")) then
			self:set(tostring(gear_id).."_"..attachment_slot, nil)
		else
			self:set(tostring(gear_id).."_"..attachment_slot, optional_attachment_or_nil)
		end
	end
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

-- Get attachment from specified gear id and slot
-- Optional: Item to get real default attachment
mod.get_gear_setting = function(self, gear_id, attachment_slot, optional_item_or_nil)
	-- local item = optional_item_or_nil and optional_item_or_nil.__master_item or optional_item_or_nil
	local in_premium_store = mod:is_premium_store_item()
	-- if mod:not_trinket(attachment_slot) then
	local attachment = nil
	-- Check skin
	-- if optional_item_or_nil then
	-- 	if mod:has_premium_skin(optional_item_or_nil) then
	-- 		mod:echot("Premium Skin!")
	-- 		attachment = self:get_actual_default_attachment(optional_item_or_nil, attachment_slot)
	-- 	end
	-- end
	-- if optional_item_or_nil and mod:has_premium_skin(optional_item_or_nil) then
	-- 	mod:echot("Premium Skin!")
	-- 	local item_name = self:item_name_from_content_string(optional_item_or_nil.name)
	-- 	local weapon_skin = optional_item_or_nil.slot_weapon_skin
	-- 	if weapon_skin and type(weapon_skin) == "string" and weapon_skin ~= "" then
	-- 		self:setup_item_definitions()
	-- 		weapon_skin = self:persistent_table(REFERENCE).item_definitions[weapon_skin]
	-- 	end
	-- 	if weapon_skin and type(weapon_skin) == "table" and weapon_skin.attachments then
	-- 		local attachment_data = self:_recursive_find_attachment(weapon_skin.attachments, attachment_slot)
	-- 		if attachment_data and self.attachment_models[item_name] then
	-- 			for attachment_name, model_data in pairs(self.attachment_models[item_name]) do
	-- 				if model_data.model == attachment_data.item then
	-- 					attachment = attachment_name
	-- 					break
	-- 				end
	-- 			end
	-- 			-- attachment = attachment_data.attachment_name
	-- 			-- mod:echo("attachment_name: "..tostring(attachment_data.attachment_name))
	-- 			-- attachment = mod:get_actual_default_attachment(optional_item_or_nil, attachment_slot)
	-- 			-- mod:echo("attachment_name: "..tostring(attachment))
	-- 			-- mod:echo("attachment: "..tostring(attachment))
	-- 		end
	-- 	end
	-- end
	-- Check manual changes
	if not attachment then
		attachment = self:get(tostring(gear_id).."_"..attachment_slot)
	end
	-- Check temp
	if not attachment and self:persistent_table(REFERENCE).temp_gear_settings[gear_id] then
		attachment = self:persistent_table(REFERENCE).temp_gear_settings[gear_id][attachment_slot]
	end
	-- Check default
	if not attachment and optional_item_or_nil then
		-- Get real vanilla attachment
		attachment = self:get_actual_default_attachment(optional_item_or_nil, attachment_slot)
	end
	-- Check mod default
	if not attachment and optional_item_or_nil then
		local item_name = self:item_name_from_content_string(optional_item_or_nil.name)
		-- Get custom slot default
		if self.attachment[item_name] and self.attachment[item_name][attachment_slot] and #self.attachment[item_name][attachment_slot] > 0 then
			attachment = self.attachment[item_name][attachment_slot][1].id
		end
	end
	return attachment
	-- end
end

mod.get_gear_size = function(self)

end

-- Redo weapon attachments by unequipping and reequipping weapon
mod.redo_weapon_attachments = function(self, item)
	local gear_id = mod:get_gear_id(item)
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

mod.weapon_points = function(self, attachments)
	local points = {}
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
