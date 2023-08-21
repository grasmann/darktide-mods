local mod = get_mod("weapon_customization")

local FlashlightTemplates = mod:original_require("scripts/settings/equipment/flashlight_templates")
mod._flicker_settings = FlashlightTemplates.default.flicker

function mod.on_game_state_changed(status, state_name)
	mod:load_packages()
	mod.initialized = false
end

-- mod:hook(CLASS.UnitSpawnerManager, "spawn_unit", function(func, self, unit_name, ...)
-- 	-- mod:echo(unit_name)
-- 	return func(self, unit_name, ...)
-- end)

-- mod:hook(CLASS.PackageManager, "load", function(func, self, package_name, reference_name, callback, prioritize, ...)
-- 	-- if string.find(package_name, "attachments") then
-- 	-- 	mod:echo("package:"..package_name)
-- 	-- end
-- 	return func(self, package_name, reference_name, callback, prioritize, ...)
-- end)

mod.hide_attachments = function(self, gear_id_or_nil, reference, attachment_name_or_nil, hide)
	if gear_id_or_nil and mod.weapon_attachments[gear_id_or_nil] and mod.weapon_attachments[gear_id_or_nil][reference] then
		for index, attachment in pairs(mod.weapon_attachments[gear_id_or_nil][reference]) do
			if not attachment_name_or_nil or (attachment and attachment.attachment_name == attachment_name_or_nil) then
				mod:hide_attachment(attachment, hide)
			end
		end
	elseif not gear_id_or_nil then
		for _, gear_attachment in pairs(mod.weapon_attachments) do
			for this_reference, reference_attachment in pairs(gear_attachment) do
				if this_reference == reference then
					for index, attachment in pairs(reference_attachment) do
						if not attachment_name_or_nil or (attachment and attachment.attachment_name == attachment_name_or_nil) then
							mod:hide_attachment(attachment, hide)
						end
					end
				end
			end
		end
	end
end

mod.hide_attachment = function(self, attachment, hide)
	if attachment and Unit.alive(attachment.attachment_unit) then
		Unit.set_unit_visibility(attachment.attachment_unit, not hide)
	end
end

mod.redo_weapon_attachments = function(self, gear_id, world)
	local player_unit = Managers.player:local_player(1).player_unit
	-- self:destroy_attachments(gear_id, world, world)
	local level_world = Managers.world:world("level_world")
	self:destroy_attachments(gear_id, "Player")
	self:destroy_attachments(gear_id, "InventoryBackgroundView")
	self:destroy_attachments(gear_id, "VisualLoadoutCustomization")
	local weapon_extension = ScriptUnit.extension(player_unit, "weapon_system")
	if weapon_extension._weapons then
		for slot_name, weapon in pairs(weapon_extension._weapons) do
			if weapon.item.__gear_id == gear_id then
				if weapon.weapon_unit then
					-- mod:dtf(weapon, "weapon", 5)
					local visual_loadout_extension = ScriptUnit.extension(player_unit, "visual_loadout_system")
					local slot_name = weapon.item.__gear.slots[1]
					-- local unit_data_extension = ScriptUnit.extension(player_unit, "unit_data_system")
					-- local fixed_frame = unit_data_extension:last_received_fixed_frame()
					-- local mispredicted_frame = fixed_frame - 1
					-- local mispredicted_frame_t = mispredicted_frame * GameParameters.fixed_time_step
					local fixed_time_step = GameParameters.fixed_time_step
					local gameplay_time = Managers.time:time("gameplay")
					local latest_frame = math.floor(gameplay_time / fixed_time_step)
					visual_loadout_extension:unequip_item_from_slot(slot_name, latest_frame)
					-- self:load_weapon_customization(weapon.item, weapon.weapon_unit)
					local time_manager = Managers.time
					local t = time_manager:time("gameplay")
					visual_loadout_extension:equip_item_to_slot(weapon.item, slot_name, nil, gameplay_time)
				end
			end
		end
	end
end

mod.load_weapon_customization = function(self, item, weapon_unit, third_person, world, reference, allow_several)
	local gear_id, original_gear_id = mod:get_gear_id(item)
	original_gear_id = original_gear_id or gear_id
	allow_several = false
	if gear_id then
		for _, attachment_slot in pairs(mod.attachment_slots) do
			local attachment = mod:get(tostring(original_gear_id).."_"..attachment_slot)
			local item_name = self:item_name_from_content_string(item.name)
			if attachment and attachment ~= "default" and mod.attachment_models[item_name][attachment] then
				local model = mod.attachment_models[item_name][attachment].model
				local attachment_type = mod.attachment_models[item_name][attachment].type
				if model then
					self:spawn_attachment(item, weapon_unit, model, attachment_type, third_person, world, reference, allow_several)
				end
			end
		end
	end
end

mod.item_name_from_content_string = function(self, content_string)
	return content_string:gsub('.*[%/%\\]', '')
end

mod.weapon_attachments = {}

mod.spawn_attachment = function(self, item, weapon_unit, attachment_name, attachment_type, third_person, world, reference, allow_several)
	if mod.anchors then
		local item_name = self:item_name_from_content_string(item.name)
		if mod.anchors[item_name] and mod.anchors[item_name][attachment_name] then
			local anchor = mod.anchors[item_name][attachment_name]
			if third_person then anchor = mod.anchors[item_name][attachment_name].third_person end
			local position = Vector3Box.unbox(anchor.position)
			local rotation_euler = Vector3Box.unbox(anchor.rotation)
			local rotation = Quaternion.from_euler_angles_xyz(rotation_euler[1], rotation_euler[2], rotation_euler[3])
			local scale = Vector3Box.unbox(anchor.scale)
			local hide = anchor.hide
			self:_spawn_attachment(item, weapon_unit, attachment_name, attachment_type, position, rotation, scale, hide, world, reference, allow_several)
		end
	end
end

mod.attachments_possible = function(self, item)
	local name = self:item_name_from_content_string(item.name)
	return mod.anchors[name] ~= nil
end

mod.is_spawned = function(self, gear_id, reference, attachment_name)
	if mod.weapon_attachments[gear_id] and mod.weapon_attachments[gear_id][reference] then
		for index, attachment in pairs(mod.weapon_attachments[gear_id][reference]) do
			if attachment.attachment_name == attachment_name and Unit.alive(attachment.attachment_unit) then
				return true
			end
		end
	end
end

mod.hide_parts = function(self)
	local found = false
	for _, gear_attachment in pairs(self.weapon_attachments) do
		for _, reference_attachment in pairs(gear_attachment) do
			for _, attachment in pairs(reference_attachment) do
				local hide = attachment.hide
				local weapon_unit = attachment.weapon_unit
				if hide and Unit.alive(weapon_unit) then
					local main_childs = Unit.get_child_units(weapon_unit)
					if main_childs then
						for _, main_child in pairs(main_childs) do
							local weapon_parts = Unit.get_child_units(main_child)
							if weapon_parts then
								for _, weapon_part in pairs(weapon_parts) do
									local debug_name = Unit.debug_name(weapon_part)
									if debug_name == hide then
										mod.hidden_units[weapon_part] = attachment.attachment_unit
										Unit.set_unit_visibility(weapon_part, false)
										local num_meshes = Unit.num_meshes(weapon_part)
										for m = 1, num_meshes, 1 do
											Unit.set_mesh_visibility(weapon_part, m, false)
										end
										found = true
									else
										-- mod:echo(debug_name)
									end
								end
							end
						end
					end
				end
			end
		end
	end
	if not found then
		-- mod:echo("parts: nothing found")
	end
end

mod.hidden_units = {}

local test = false
mod._spawn_attachment = function(self, item, weapon_unit, attachment_name, attachment_type, position, rotation, scale, hide, world, reference, allow_several)
	local gear_id = mod:get_gear_id(item) --item.__is_preview_item and item.__original_gear_id or item.__gear_id
	if not mod:is_spawned(gear_id, reference, attachment_name) or allow_several then
		local attachment_unit = World.spawn_unit_ex(world, attachment_name, nil, nil)
		World.link_unit(world, attachment_unit, 1, weapon_unit, 1)
		Unit.set_local_position(attachment_unit, 1, position)
		Unit.set_local_rotation(attachment_unit, 1, rotation)
		-- local scale = Vector3(2, 2, 2)
		Unit.set_local_scale(attachment_unit, 1, scale)
		-- local debug_unit = Unit.debug_name(attachment_unit)
		-- local debugged_units = self:debugged_units()
		-- -- mod:echo(debug_unit)
		-- if not table.contains(debugged_units, debug_unit) then
		-- 	mod:dtf({debug_unit}, "debug_unit_"..debug_unit, 1)
		-- end

		if not test then
			if Unit.has_data(weapon_unit, "attached_items") then
				local data = Unit.get_data(weapon_unit, "attached_items")
				mod:dtf(data, "attached_items", 5)
			end
			test = true
		end

		if hide then
			-- local weapon_template = mod:weapon_template_from_item(item)
			-- local anim_state_machine_1p = weapon_template.anim_state_machine_1p
			-- Unit.set_animation_state_machine(attachment_unit, anim_state_machine_1p)
			
			-- self:hide_parts()
			local main_childs = Unit.get_child_units(weapon_unit)
			if main_childs then
				for _, main_child in pairs(main_childs) do
					local weapon_parts = Unit.get_child_units(main_child)
					if weapon_parts then
						for _, weapon_part in pairs(weapon_parts) do
							if Unit.debug_name(weapon_part) == hide then
								mod.hidden_units[weapon_part] = attachment_unit
								Unit.set_unit_visibility(weapon_part, false)
								local num_meshes = Unit.num_meshes(weapon_part)
								for m = 1, num_meshes, 1 do
									Unit.set_mesh_visibility(weapon_part, m, false)
								end
							end
						end
					end
				end
			end
		end
		-- mod:echo("load:"..tostring(gear_id).." "..reference.." "..attachment_name)
		mod.weapon_attachments[gear_id] = mod.weapon_attachments[gear_id] or {}
		mod.weapon_attachments[gear_id][reference] = mod.weapon_attachments[gear_id][reference] or {}
		mod.weapon_attachments[gear_id][reference][#mod.weapon_attachments[gear_id][reference]+1] = {
			item = item,
			weapon_unit = weapon_unit,
			attachment_unit = attachment_unit,
			attachment_name = attachment_name,
			attachment_type = attachment_type,
			world = world,
			hide = hide,
			gear_id = gear_id,
			reference = reference,
		}
		mod.current_attachment = mod.weapon_attachments[gear_id][reference][#mod.weapon_attachments[gear_id][reference]]
	else
		-- mod:echo("already:"..tostring(gear_id).." "..reference.." "..attachment_name)
		mod:hide_attachments(gear_id, reference, attachment_name, false)
	end
end

mod.destroy_attachments = function(self, gear_id_or_nil, reference_or_nil)
	if gear_id_or_nil then
		self:destroy_attachments_for_gear(gear_id_or_nil, reference_or_nil)
	elseif reference_or_nil then
		self:destroy_attachments_for_reference(reference_or_nil)
	end
	-- if gear_id and mod.weapon_attachments[gear_id] and mod.weapon_attachments[gear_id][reference] then
	-- 	for index, attachment in pairs(mod.weapon_attachments[gear_id][reference]) do
	-- 		-- mod:echo("destroy:"..tostring(gear_id).." "..reference)
	-- 		if Unit.alive(attachment.attachment_unit) then
	-- 			World.unlink_unit(attachment.world, attachment.attachment_unit)
	-- 			World.destroy_unit(attachment.world, attachment.attachment_unit)
	-- 		end
	-- 	end
	-- 	mod.weapon_attachments[gear_id][reference] = {}
	-- elseif not gear_id then
	-- 	for _, gear_attachment in pairs(self.weapon_attachments) do
	-- 		for this_reference, reference_attachment in pairs(gear_attachment) do
	-- 			if this_reference == reference then
	-- 				for _, attachment in pairs(reference_attachment) do
	-- 					-- mod:echo("destroy:"..tostring(attachment.gear_id).." "..reference)
	-- 					if Unit.alive(attachment.attachment_unit) then
	-- 						World.unlink_unit(attachment.world, attachment.attachment_unit)
	-- 						World.destroy_unit(attachment.world, attachment.attachment_unit)
	-- 					end
	-- 				end
	-- 			end
	-- 		end
	-- 	end
	-- end
end



mod.destroy_attachments_for_reference = function(self, reference)
	-- Iterate gear attachments
	for _, gear_attachment in pairs(self.weapon_attachments) do
		-- Check reference
		if gear_attachment[reference] then
			-- Iterate attachments in reference
			for index, attachment in pairs(gear_attachment[reference]) do
				self:destroy_attachment(attachment)
			end
			gear_attachment[reference] = nil
		end
		if table.size(gear_attachment) == 0 then
			gear_attachment = nil
		end
	end
end

mod.destroy_attachments_for_gear = function(self, gear_id, reference_or_nil)
	-- Check gear_id and presence in attachments
	if gear_id and mod.weapon_attachments[gear_id] then
		-- Iterate through references
		local reference_found = false
		for reference, reference_attachment in pairs(mod.weapon_attachments[gear_id]) do
			-- Check reference nil or reference match
			if not reference_or_nil or reference == reference_or_nil then
				-- Iterate attachments in reference
				for index, attachment in pairs(reference_attachment) do
					self:destroy_attachment(attachment)
				end
				reference_attachment = nil
				reference_found = true
			end
		end
		if table.size(mod.weapon_attachments[gear_id]) == 0 then
			mod.weapon_attachments[gear_id] = nil
		end
		if not reference_found then
			-- mod:echo("destroy: reference "..tostring(reference_or_nil).." not found")
		end
	else
		-- mod:echo("destroy: gear_id "..tostring(gear_id).." not found")
	end
end

mod.destroy_attachment = function(self, attachment)
	-- Check attachment and unit
	if attachment and Unit.alive(attachment.attachment_unit) then
		-- mod:echo("destroy:"..tostring(attachment.gear_id).." "..attachment.reference.." "..attachment.attachment_name)
		World.unlink_unit(attachment.world, attachment.attachment_unit)
		World.destroy_unit(attachment.world, attachment.attachment_unit)
		-- attachment = nil
	end
end

mod.destroy_all_attachments = function(self)
	for _, gear_attachment in pairs(self.weapon_attachments) do
		for _, reference_attachment in pairs(gear_attachment) do
			for _, attachment in pairs(reference_attachment) do
				-- mod:echo("destroy:"..tostring(attachment.gear_id).." "..reference)
				-- if Unit.alive(attachment.attachment_unit) then
				-- 	World.unlink_unit(attachment.world, attachment.attachment_unit)
				-- 	World.destroy_unit(attachment.world, attachment.attachment_unit)
				-- end
				self:destroy_attachment(attachment)
			end
		end
	end
	mod.weapon_attachments = {}
end

mod.has_flashlight_attachment = function(self, item)
	local gear_id = self:get_gear_id(item, true)
	local attachment = self:get(tostring(gear_id).."_special")
	return attachment ~= nil
end

mod.get_flashlight_attachments = function(self, item)
	local results = nil
	local world = Managers.world:world("level_world")
	local gear_id = mod:get_gear_id(item) --item.__is_preview_item and item.__original_gear_id or item.__gear_id
	local reference = "Player"--..tostring(item.__original_gear_id)..tostring(item.__gear_id)
	if mod.weapon_attachments[gear_id] and mod.weapon_attachments[gear_id][reference] then
		for index = #mod.weapon_attachments[gear_id][reference], 1, -1 do
			local attachment = mod.weapon_attachments[gear_id][reference][index]
			if attachment.attachment_type == "flashlight" and Unit.alive(attachment.attachment_unit) and attachment.world == world then
				results = results or {}
				results[#results+1] = attachment
			end
		end
		return results
	end
end

mod.init_context = function(self)
	if not self.visual_loadout_extension then
		self.initialized = false
	end
	if not self.initialized then
		self.player_manager = Managers.player
		local player = self.player_manager:local_player(1)
		if player then
			self.player_unit = player.player_unit
			if self.player_unit then
				self.fx_extension = ScriptUnit.extension(self.player_unit, "fx_system")
				local unit_data = ScriptUnit.extension(self.player_unit, "unit_data_system")
				if unit_data then
					self.inventory_component = unit_data:read_component("inventory")
					self.visual_loadout_extension = ScriptUnit.extension(self.player_unit, "visual_loadout_system")
					if self.visual_loadout_extension then
						self.first_person_extension = ScriptUnit.extension(self.player_unit, "first_person_system")
						if self.first_person_extension then
							self.first_person_unit = self.first_person_extension:first_person_unit()
							if self.first_person_unit then
								-- self.flashlight = Unit.light(self.first_person_unit, 1)
								self.initialized = true
							end
						end
					end
				end
			end
		end
	end
end

mod.toggle_flashlight = function(self)
	self:init_context()
	if mod.initialized then
		local item = self.visual_loadout_extension:item_from_slot(self.inventory_component.wielded_slot)
		if item then
			local flashlight_attachments = self:get_flashlight_attachments(item)
			if flashlight_attachments then
				for _, flashlight_attachment in pairs(flashlight_attachments) do
					flashlight_attachment.enabled = not flashlight_attachment.enabled
					local light = Unit.light(flashlight_attachment.attachment_unit, 1)
					if flashlight_attachment.enabled then
						Light.set_correlated_color_temperature(light, 7000)
						Light.set_intensity(light, 40)
						Light.set_volumetric_intensity(light, 0.3)
						Light.set_casts_shadows(light, true)
						Light.set_falloff_end(light, 45)
						Light.set_enabled(light, true)
						self.fx_extension:trigger_wwise_event("wwise/events/player/play_foley_gear_flashlight_on", false, self.player_unit, 1)
					else
						Light.set_correlated_color_temperature(light, 8000)
						Light.set_intensity(light, 1)
						Light.set_volumetric_intensity(light, 0.1)
						Light.set_casts_shadows(light, false)
						Light.set_falloff_end(light, 10)
						Light.set_enabled(light, false)
						self.fx_extension:trigger_wwise_event("wwise/events/player/play_foley_gear_flashlight_off", false, self.player_unit, 1)
					end
				end
			end
		end
	end
end

mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_packages")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_anchors")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_debug")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_patch")
mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_view")

-- mod:echo("Init ####################")
