local mod = get_mod("weapon_customization")

local inventory_weapon_cosmetics_view_definitions = mod:original_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view_definitions")
local DropdownPassTemplates = mod:original_require("scripts/ui/pass_templates/dropdown_pass_templates")
local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
local UIFontSettings = mod:original_require("scripts/managers/ui/ui_font_settings")
local MasterItems = mod:original_require("scripts/backend/master_items")
local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")
local ScriptCamera = mod:original_require("scripts/foundation/utilities/script_camera")
local ButtonPassTemplates = mod:original_require("scripts/ui/pass_templates/button_pass_templates")
local ScriptWorld = mod:original_require("scripts/foundation/utilities/script_world")
local WeaponTemplate = mod:original_require("scripts/utilities/weapon/weapon_template")
local WeaponTemplates = mod:original_require("scripts/settings/equipment/weapon_templates/weapon_templates")
local PlayerUnitAnimationMachineSettings = mod:original_require("scripts/settings/animation/player_unit_animation_state_machine_settings")

local grid_size = inventory_weapon_cosmetics_view_definitions.grid_settings.grid_size
local edge_padding = inventory_weapon_cosmetics_view_definitions.grid_settings.edge_padding
local grid_width = grid_size[1] + edge_padding
local button_width = grid_width * 0.3
local edge = edge_padding * 0.5
local label_height = 35
local dropdown_height = 50

mod.added_cosmetics_scenegraphs = {}
mod.original_weapon_settings = {}
mod.changed_weapon_settings = {}
mod.move_duration_out = .5
mod.move_duration_in = 1
mod.reset_wait_time = 5
mod.weapon_changed = nil
mod.sound_duration = .5
mod.weapon_part_animation_entries = {}
mod.weapon_part_animation_time = .75
mod.cosmetics_view = nil

for _, attachment_slot in pairs(mod.attachment_slots) do
	mod.added_cosmetics_scenegraphs[#mod.added_cosmetics_scenegraphs+1] = attachment_slot.."_text_pivot"
	mod.added_cosmetics_scenegraphs[#mod.added_cosmetics_scenegraphs+1] = attachment_slot.."_pivot"
end

local vector3_box = Vector3Box
local vector3_unbox = vector3_box.unbox
local vector3_zero = Vector3.zero
local vector3_lerp = Vector3.lerp
local unit_alive = Unit.alive
local unit_set_local_position = Unit.set_local_position
local unit_set_local_rotation = Unit.set_local_rotation
local unit_local_position = Unit.local_position
local unit_get_child_units = Unit.get_child_units
local math_round_with_precision = math.round_with_precision
local math_easeInCubic = math.easeInCubic
local math_easeOutCubic = math.easeOutCubic
local math_ease_out_elastic = math.ease_out_elastic
local math_min = math.min
local math_max = math.max
local table_size = table.size
local table_find = table.find
local table_contains = table.contains
local table_clone = table.clone
local string_gsub = string.gsub
local string_find = string.find

local mesh_positions = {}
mod.mesh_positions = {}

mod.setup_mesh_default_positions = function(self)
	self.mesh_positions = self.mesh_positions or {}
	local attachment_slot_info = self.attachment_slot_infos[self.cosmetics_view._gear_id]
    local attachment_slots = self:get_item_attachment_slots(self.cosmetics_view._selected_item)
    for _, attachment_slot in pairs(attachment_slots) do
		local unit = attachment_slot_info.attachment_slot_to_unit[attachment_slot]
		if unit and unit_alive(unit) then
			self.mesh_positions[unit] = self.mesh_positions[unit] or {}
			local num_meshes = Unit.num_meshes(unit)
			for i = 1, num_meshes do
				self.mesh_positions[unit][i] = vector3_box(Mesh.local_position(Unit.mesh(unit, i)))
			end
		end
	end
end

local unit_set_local_position_mesh = function(unit, no_mesh_move, movement)
	if unit and unit_alive(unit) then
		local num_meshes = Unit.num_meshes(unit)
		if (not no_mesh_move or no_mesh_move == "both") and num_meshes > 0 then
			for i = 1, num_meshes do
				local mesh = Unit.mesh(unit, i)
				local unit_data = mod.mesh_positions[unit]
				local default = unit_data and unit_data[i] and vector3_unbox(unit_data[i])
				local default_position = default or vector3_zero()
				Mesh.set_local_position(mesh, unit, default_position + movement)
			end
		end
		if no_mesh_move or no_mesh_move == "both" then
			unit_set_local_position(unit, 1, movement)
		end
	end
end

-- ##### ┬ ┬┬  ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌  ┌─┐┌─┐┌─┐┬ ┬┌┐┌┌─┐┬─┐  ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ###################################
-- ##### │ ││  │││├┤ ├─┤├─┘│ ││││  └─┐├─┘├─┤││││││├┤ ├┬┘  ├┤ │ │││││   │ ││ ││││└─┐ ###################################
-- ##### └─┘┴  └┴┘└─┘┴ ┴┴  └─┘┘└┘  └─┘┴  ┴ ┴└┴┘┘└┘└─┘┴└─  └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ###################################

mod.play_attachment_sound = function(self, item, attachment_slot, attachment)
	local item_name = self.cosmetics_view._item_name
	if attachment == "default" then
		attachment = mod:get_actual_default_attachment(item, attachment_slot)
	end
	if mod.attachment[item_name] and mod.attachment[item_name][attachment_slot] then
		for _, data in pairs(mod.attachment[item_name][attachment_slot]) do
			if data.id == attachment and data.sounds then
				for _, sound in pairs(data.sounds) do
					self.cosmetics_view:_play_sound(sound)
				end
			end
		end
	end
end

mod.detach_attachment = function(self, item, attachment_slot, attachment, new_attachment, no_children)
	local item_name = self.cosmetics_view._item_name
	-- if attachment then
	self:do_weapon_part_animation(item, attachment_slot, "detach", new_attachment, no_children)
	local attachment_data = self.attachment_models[item_name][new_attachment]
	if attachment then
		attachment_data = self.attachment_models[item_name][attachment]
	end
	local movement = attachment_data.remove and vector3_unbox(attachment_data.remove) or vector3_zero()
	if not mod:vector3_equal(movement, vector3_zero()) then
		self:play_attachment_sound(item, attachment_slot, attachment)
	end
	-- else
	-- 	self:load_new_attachment(item, attachment_slot, new_attachment)
	-- 	self:do_weapon_part_animation(item, attachment_slot, "attach", new_attachment, no_children)
	-- end
end

mod.weapon_part_animation_exists = function(self, attachment_slot)
	for _, weapon_part_animation in pairs(self.weapon_part_animation_entries) do
		if weapon_part_animation.slot == attachment_slot then
			return weapon_part_animation
		end
	end
end

mod.do_weapon_part_animation = function(self, item, attachment_slot, attachment_type, new_attachment, no_children)
	local existing_animation = mod:weapon_part_animation_exists(attachment_slot)
	if not existing_animation then
		-- Main animation
		self.weapon_part_animation_entries[#self.weapon_part_animation_entries+1] = {
			slot = attachment_slot,
			type = attachment_type,
			new = new_attachment,
			old = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot, item),
		}
		-- Get auto equipy
		local auto_equips = mod:get_auto_equips(new_attachment)
		-- Get modified attachment slot
		local modified_attachment_slot = self:_recursive_find_attachment(item.attachments, attachment_slot)
		if modified_attachment_slot and modified_attachment_slot.children and not no_children then
			-- Find attached children
			local children = {}
			self:_recursive_get_attachments(modified_attachment_slot.children, children)
			if children and #children > 0 then
				-- Iterate children
				for _, child in pairs(children) do
					if not mod:weapon_part_animation_exists(child.slot) and not table_contains(auto_equips, child.slot) then
						self.weapon_part_animation_entries[#self.weapon_part_animation_entries+1] = {
							slot = child.slot,
							type = attachment_type,
							new = self:get_gear_setting(self.cosmetics_view._gear_id, child.slot),
							old = self:get_gear_setting(self.cosmetics_view._gear_id, child.slot, item),
						}
					-- elseif existing_animation and existing_animation.new ~= existing_animation.old and not table_contains(auto_equips, child.slot) then
					-- 	existing_animation.new
					end
				end
			end
		end
	elseif existing_animation and existing_animation.new == existing_animation.old and new_attachment ~= existing_animation.new then
		existing_animation.new = new_attachment
	end
end

mod.get_auto_equips = function(self, attachment)
	local equip_data = mod.attachment_models[self.cosmetics_view._item_name][attachment]
	local automatic_equip = equip_data and equip_data.automatic_equip
	local auto_slots = {}
	if automatic_equip then
		for auto_type, auto_attachment in pairs(automatic_equip) do
			auto_slots[#auto_slots+1] = auto_type
		end
	end
	return auto_slots
end

mod.resolve_auto_equips = function(self, attachment)
	local automatic_equip = mod.attachment_models[self.cosmetics_view._item_name][attachment].automatic_equip
	if automatic_equip then
		for auto_type, auto_attachment in pairs(automatic_equip) do
			self:set_gear_setting(self.cosmetics_view._gear_id, auto_type, auto_attachment)
		end
	end
end

mod.start_weapon_move = function(self, position, no_reset)
	if position then
		self.move_position = position
		self.do_move = true
		self.no_reset = no_reset
	elseif self.link_unit_position then
		self.move_position = vector3_box(vector3_zero())
		self.do_move = true
	end
end

mod.play_zoom_sound = function(self, t, sound)
	if not self.sound_end or t >= self.sound_end then
		self.sound_end = t + self.sound_duration
		self.cosmetics_view:_play_sound(sound)
	end
end

mod.resolve_no_support = function(self)
	-- Enable all dropdowns
	for _, attachment_slot in pairs(self.attachment_slots) do
		local widget = self.cosmetics_view._widgets_by_name[attachment_slot.."_custom"]
		if widget then
			widget.content.entry.disabled = false
			if widget.content.entry and widget.content.entry.widget_type == "dropdown" then
				local options_by_id = widget.content.options_by_id
				for option_index, option in pairs(widget.content.options) do
					option.disabled = false
				end
			end
		end
	end
	-- Disable no supported
	for _, attachment_slot in pairs(self.attachment_slots) do
		local item = self.cosmetics_view._selected_item
		local attachment = item and self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot, item)
		if attachment and mod.attachment_models[self.cosmetics_view._item_name] and mod.attachment_models[self.cosmetics_view._item_name][attachment] then
			local no_support = mod.attachment_models[self.cosmetics_view._item_name][attachment].no_support
			if no_support then
				for _, no_support_entry in pairs(no_support) do
					local widget = self.cosmetics_view._widgets_by_name[no_support_entry.."_custom"]
					if widget then
						widget.content.entry.disabled = true
					else
						for _, widget in pairs(self.cosmetics_view._custom_widgets) do
							if widget.content.entry and widget.content.entry.widget_type == "dropdown" then
								local options = widget.content.options
								for option_index, option in pairs(widget.content.options) do
									if option.id == no_support_entry then
										option.disabled = true
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

mod.load_new_attachment = function(self, item, attachment_slot, attachment, no_update)
	if self.cosmetics_view._gear_id then

		if attachment_slot and attachment then
			if not self.original_weapon_settings[attachment_slot] then
				if not self:get(tostring(self.cosmetics_view._gear_id).."_"..attachment_slot) then
					self.original_weapon_settings[attachment_slot] = "default"
				else
					self.original_weapon_settings[attachment_slot] = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot)
				end
			end

			self:set_gear_setting(self.cosmetics_view._gear_id, attachment_slot, attachment)

			self:resolve_auto_equips(attachment)
			self:resolve_no_support()
			

			-- -- Automatic
			-- -- local real_attachment = mod:get_actual_default_attachment(item, attachment_slot)
			-- local automatic_equip = mod.attachment_models[self.cosmetics_view._item_name][attachment].automatic_equip
            -- if automatic_equip then
            --     for auto_type, auto_attachment in pairs(automatic_equip) do
			-- 		self:set_gear_setting(self.cosmetics_view._gear_id, auto_type, auto_attachment)
            --     end
            -- end
		end

		-- self.flashlight_attached[self.cosmetics_view._gear_id] = nil

		if not no_update then
			self.cosmetics_view._presentation_item = MasterItems.create_preview_item_instance(self.cosmetics_view._selected_item)

			if self.cosmetics_view._previewed_element then
				self.cosmetics_view:_preview_element(self.cosmetics_view._previewed_element)
			else
				self.cosmetics_view:_preview_item(self.cosmetics_view._presentation_item)
			end

			self:setup_mesh_default_positions()
			self:get_changed_weapon_settings()
			-- self:update_reset_button()
		end

	end
end

-- ##### ┬ ┬┬  ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌  ┌─┐┌─┐┌─┐┬ ┬┌┐┌┌─┐┬─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################
-- ##### │ ││  │││├┤ ├─┤├─┘│ ││││  └─┐├─┘├─┤││││││├┤ ├┬┘  ├─┤│ ││ │├┴┐└─┐ #############################################
-- ##### └─┘┴  └┴┘└─┘┴ ┴┴  └─┘┘└┘  └─┘┴  ┴ ┴└┴┘┘└┘└─┘┴└─  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################

mod:hook(CLASS.UIWeaponSpawner, "init", function(func, self, reference_name, world, camera, unit_spawner, ...)
	func(self, reference_name, world, camera, unit_spawner, ...)
	if reference_name ~= "WeaponIconUI" then
		self._rotation_angle = mod._rotation_angle or 0
		self._default_rotation_angle = mod._last_rotation_angle or 0
	end
end)

mod.test_move = function(self, unit)
	if unit and unit_alive(unit) then
		local children = unit_get_child_units(unit)
		local target = 1
		for index, child in pairs(children) do
			-- if index == target then
				local position = unit_local_position(child)
				local new_position = position + Vector3(0, 0, .2)
			-- end
		end
		-- if Unit.has_animation_state_machine(unit) and Unit.has_animation_event(unit, "shoot") then
		-- 	Unit.animation_event(unit, "shoot")
		-- end
	end
end

mod:hook(CLASS.UIWeaponSpawner, "update", function(func, self, dt, t, input_service, ...)

	func(self, dt, t, input_service, ...)

	if self._reference_name ~= "WeaponIconUI" then

		mod._rotation_angle = self._rotation_angle

		local weapon_spawn_data = self._weapon_spawn_data
		if weapon_spawn_data and self._link_unit_position then
			local item_name = mod.cosmetics_view._item_name
			local link_unit = weapon_spawn_data.link_unit
			local position = vector3_unbox(self._link_unit_position)
			local animation_speed = mod:get("mod_option_weapon_build_animation_speed")
			local animation_time = mod.weapon_part_animation_time

			-- Camera movement
			if mod.do_move then
				if mod.move_position then
					local last_move_position = mod.last_move_position and vector3_unbox(mod.last_move_position) or vector3_zero()
					local move_position = vector3_unbox(mod.move_position)
					if not mod:vector3_equal(last_move_position, move_position) then
						mod.new_position = vector3_box(vector3_unbox(self._link_unit_base_position) + move_position)
						mod.move_end = t + mod.move_duration_in
						mod.current_move_duration = mod.move_duration_in
						mod.last_move_position = mod.move_position
						mod:play_zoom_sound(t, UISoundEvents.apparel_zoom_in)
					end
				elseif self._link_unit_base_position then
					local last_move_position = vector3_unbox(self._link_unit_position)
					local move_position = vector3_unbox(self._link_unit_base_position)
					if not mod:vector3_equal(move_position, last_move_position) then
						mod.new_position = self._link_unit_base_position
						mod.move_end = t + mod.move_duration_out
						mod.current_move_duration = mod.move_duration_out
						mod.last_move_position = vector3_zero()
						mod:play_zoom_sound(t, UISoundEvents.apparel_zoom_out)
					end
				end
				mod.do_move = nil
				mod.do_reset = nil
				mod.reset_start = nil
			else
				if mod.move_end and t <= mod.move_end then
					local progress = (mod.move_end - t) / mod.current_move_duration
					local anim_progress = math_easeInCubic(1 - progress)
					local lerp_position = vector3_lerp(position, vector3_unbox(mod.new_position), anim_progress)
					mod.link_unit_position = vector3_box(lerp_position)
					if link_unit and unit_alive(link_unit) then
						unit_set_local_position(link_unit, 1, lerp_position)
					end
					self._link_unit_position = vector3_box(lerp_position)
				elseif mod.move_end and t > mod.move_end then
					mod.move_end = nil
					if link_unit and unit_alive(link_unit) then
						unit_set_local_position(link_unit, 1, vector3_unbox(mod.new_position))
					end
					if link_unit and unit_alive(link_unit) then
						mod.link_unit_position = vector3_box(unit_local_position(link_unit, 1))
					end
					if mod.current_move_duration == mod.move_duration_in and not mod:vector3_equal(vector3_unbox(mod.new_position), vector3_zero()) then
						mod.do_reset = true
					end
				end
			end
			
			-- Camera rotation
			if mod.do_rotation then
				local new_rotation = mod.new_rotation or 0
				if new_rotation ~= 0 and self._default_rotation_angle ~= new_rotation then
					mod:play_zoom_sound(t, UISoundEvents.apparel_zoom_in)
				end
				self._rotation_angle = mod._last_rotation_angle or 0
				self._default_rotation_angle = new_rotation
				mod._last_rotation_angle = self._default_rotation_angle
				mod.check_rotation = true
				mod.do_reset = nil
				mod.reset_start = nil
				mod.do_rotation = nil
			elseif mod.check_rotation then
				if math_round_with_precision(self._rotation_angle, 1) == math_round_with_precision(self._default_rotation_angle, 1) then
					if math_round_with_precision(self._rotation_angle, 1) ~= 0 then
						mod.do_reset = true
					end
					mod.check_rotation = nil
				end
			end

			-- Reset
			if mod.do_reset then
				mod.reset_start = t + mod.reset_wait_time
				mod.do_reset = nil
			elseif mod.reset_start and t >= mod.reset_start then
				mod:play_zoom_sound(t, UISoundEvents.apparel_zoom_out)
				mod.move_position = nil
				mod.do_move = true
				mod.reset_start = nil
				self._default_rotation_angle = 0
				mod._last_rotation_angle = 0
			elseif mod.reset_start and mod.dropdown_open then
				mod.reset_start = mod.reset_start + dt
			end

			-- Weapon part animations
			local index = 1
			local entries = mod.weapon_part_animation_entries
			if entries then
				for _, entry in pairs(entries) do

					local attachment = mod:get_gear_setting(mod.cosmetics_view._gear_id, entry.slot, mod.cosmetics_view._selected_item)
					local attachment_slot_info = mod.attachment_slot_infos[mod.cosmetics_view._gear_id]

					local unit = attachment_slot_info.attachment_slot_to_unit[entry.slot]
					local attachment_data = attachment and mod.attachment_models[item_name][attachment]
					local movement = attachment_data and attachment_data.remove and vector3_unbox(attachment_data.remove) or vector3_zero()
					local parent = attachment_data and attachment_data.parent and attachment_data.parent

					local anchor = mod.anchors[item_name] and mod.anchors[item_name][attachment]
					anchor = mod:_apply_anchor_fixes(mod.cosmetics_view._presentation_item, unit) or anchor
					local default_position0 = unit and vector3_unbox(attachment_slot_info.unit_default_position[unit])
					local default_position1 = unit and unit_alive(unit) and unit_local_position(unit, 1)
					local default_position = anchor and anchor.position and vector3_unbox(anchor.position) or default_position0 or default_position1 or vector3_zero()

					local no_mesh_move = (parent or (attachment_data and attachment_data.no_mesh_move)) and true
					no_mesh_move = attachment_data and attachment_data.no_mesh_move or no_mesh_move
					if no_mesh_move == true then
						movement = default_position + movement
					end

					if not mod.weapon_spawning then

						if not entry.end_time then
							if attachment then
								if entry.type == "detach" or entry.type == "wobble" then
									entry.end_time = t + animation_time / animation_speed
								else
									entry.end_time = t + (animation_time + (animation_time * (index / 10))) / animation_speed
								end
							else
								entry.end_time = t
							end
						end

						if entry.end_time and entry.end_time >= t then
							if entry.type == "detach" then
								local progress = (entry.end_time - t) / (animation_time / animation_speed)
								local anim_progress = math_easeOutCubic(1 - progress)
								local lerp_position = vector3_lerp(default_position, movement, anim_progress)
								if unit and unit_alive(unit) then
									unit_set_local_position_mesh(unit, no_mesh_move, lerp_position)
								end
							elseif entry.type == "attach" then
								local progress = (entry.end_time - t) / ((animation_time + (animation_time * (index / 10))) / animation_speed)
								local anim_progress = math_easeInCubic(1 - progress)
								local lerp_position = vector3_lerp(movement, default_position, anim_progress)
								if unit and unit_alive(unit) then
									unit_set_local_position_mesh(unit, no_mesh_move, lerp_position)
								end
							elseif entry.type == "wobble" then
								local progress = (entry.end_time - t) / (animation_time / animation_speed)--(entry.end_time - t) / ((animation_time + (animation_time * (index / 10))) / animation_speed)
								local anim_progress = math_ease_out_elastic(1 - progress)
								local lerp_position = vector3_lerp(movement, default_position, anim_progress)
								lerp_position = lerp_position - default_position
								lerp_position = lerp_position * 0.1
								lerp_position = lerp_position + default_position
								if unit and unit_alive(unit) then
									unit_set_local_position_mesh(unit, no_mesh_move, lerp_position)
								end
							end
						elseif entry.end_time and entry.end_time < t then
							if entry.type == "detach" then
								if unit and unit_alive(unit) then
									unit_set_local_position_mesh(unit, no_mesh_move, movement)
								end
								entry.end_time = t + (animation_time + (animation_time * (index / 10))) / animation_speed
								entry.type = "attach"
							elseif entry.type == "attach" then
								if not mod:vector3_equal(movement, vector3_zero()) or entry.new ~= entry.old and unit then
									mod:play_attachment_sound(mod.cosmetics_view._selected_item, entry.slot, entry.new)
								end
								if unit and unit_alive(unit) then
									unit_set_local_position_mesh(unit, no_mesh_move, default_position)
								end
								entry.end_time = t + animation_time / animation_speed--t + (animation_time + (animation_time * (index / 10))) / animation_speed
								entry.type = "wobble"
							elseif entry.type == "wobble" then
								if unit and unit_alive(unit) then
									unit_set_local_position_mesh(unit, no_mesh_move, default_position)
								end
								entry.finished = true
							end
						end

						index = index + 1
					else
						if mod.weapon_spawning then
							if unit and unit_alive(unit) then unit_set_local_position_mesh(unit, no_mesh_move, movement) end
							if entry.end_time then entry.end_time = entry.end_time + dt end
						end
					end
				end

				local count = #entries
				for i, entry in pairs(entries) do
					if not entry.update_done and (entry.type == "attach" or entry.type == "wobble") then
						mod:load_new_attachment(weapon_spawn_data.item, entry.slot, entry.new, true)
						entry.update_done = true
					end
				end

				-- Detach done?
				local detach_done = 0
				for i, entry in pairs(entries) do
					if entry.update_done then
						detach_done = detach_done + 1
					end
				end

				if detach_done == count and mod.weapon_part_animation_update then
					if entries and #entries > 0 and entries[1] and string_find(entries[1].new, "default") then
						mod:start_weapon_move()
						mod.new_rotation = 0
						mod.do_rotation = true
					end
					mod:load_new_attachment(weapon_spawn_data.item)
					mod.weapon_part_animation_update = nil
				end

				-- Remove finished weapon part animations
				if not mod.weapon_part_animation_update then
					for i, entry in pairs(entries) do
						if entry.finished then
							entries[i] = nil
						end
					end
				end

				mod:update_equip_button()
				mod:update_reset_button()
				mod:update_randomize_button()
			end
		end
	end
end)

mod:hook(CLASS.UIWeaponSpawner, "_update_input_rotation", function(func, self, dt, ...)
	local weapon_spawn_data = self._weapon_spawn_data
	if not weapon_spawn_data then
		return
	end
	if not self._is_rotating and self._rotation_angle ~= self._default_rotation_angle then
		local rotation_angle = math.lerp(self._rotation_angle, self._default_rotation_angle, dt * 3)
		self:_set_rotation(rotation_angle)
	end
end)

mod:hook(CLASS.UIWeaponSpawner, "_spawn_weapon", function(func, self, item, link_unit_name, loader, position, rotation, scale, force_highest_mip, ...)
	force_highest_mip = true
	func(self, item, link_unit_name, loader, position, rotation, scale, force_highest_mip, ...)
	local weapon_spawn_data = self._weapon_spawn_data
	if weapon_spawn_data and mod.cosmetics_view and self._reference_name ~= "WeaponIconUI" then
		local item_name = mod.cosmetics_view._item_name

		mod.weapon_spawning = true

		Unit.set_unit_visibility(weapon_spawn_data.item_unit_3p, true, true)

		local link_unit = weapon_spawn_data.link_unit

		local t = Managers.time:time("main")
		local start_seed = self._auto_spin_random_seed
		if not start_seed then
			return 0, 0
		end
		local progress_speed = 0.3
		local progress_range = 0.3
		local progress = math.sin((start_seed + t) * progress_speed) * progress_range
		local auto_tilt_angle = -(progress * 0.5)
		local auto_turn_angle = -(progress * math.pi * 0.25)

		local start_angle = self._rotation_angle or 0
		local rotation = Quaternion.axis_angle(Vector3(0, auto_tilt_angle, 1), -(auto_turn_angle + start_angle))
		if link_unit then
			local initial_rotation = weapon_spawn_data.rotation and QuaternionBox.unbox(weapon_spawn_data.rotation)

			if initial_rotation then
				rotation = Quaternion.multiply(rotation, initial_rotation)
			end

			unit_set_local_rotation(link_unit, 1, rotation)

			if not self._link_unit_base_position_backup then
				self._link_unit_base_position_backup = vector3_box(unit_local_position(link_unit, 1))
			end

			if self._last_item_name and self._last_item_name ~= item_name then
				mod.do_reset = nil
				mod.reset_start = nil
				mod.move_end = nil
				mod.do_move = nil
				mod.last_move_position = nil
				mod.move_position = nil
			end
			
			if mod.attachment_models[item_name] and mod.attachment_models[item_name].customization_default_position then
				local position = vector3_unbox(mod.attachment_models[item_name].customization_default_position)
				unit_set_local_position(link_unit, 1, unit_local_position(link_unit, 1) + position)
			else
				unit_set_local_position(link_unit, 1, vector3_unbox(self._link_unit_base_position_backup))
			end

			if not self._link_unit_base_position then
				self._link_unit_base_position = vector3_box(unit_local_position(link_unit, 1))
			end

			if mod.link_unit_position then
				local position = vector3_unbox(mod.link_unit_position)
				unit_set_local_position(link_unit, 1, position)
			end

			self._link_unit_position = vector3_box(unit_local_position(link_unit, 1))
			self._last_item_name = item_name
		end

		mod:setup_mesh_default_positions()
	end
end)

mod:hook(CLASS.UIWeaponSpawner, "cb_on_unit_3p_streaming_complete", function(func, self, item_unit_3p, ...)
	func(self, item_unit_3p, ...)
	local weapon_spawn_data = self._weapon_spawn_data
	if weapon_spawn_data and mod.cosmetics_view and self._reference_name ~= "WeaponIconUI" then
		mod.weapon_spawning = nil
		local link_unit = weapon_spawn_data.link_unit
		-- mod:map_out_unit(item_unit_3p)
	end
end)

mod._recursive_get_child_units = function(self, unit, out_units)
	local attachment_slot_info = self.attachment_slot_infos[self.cosmetics_view._gear_id]
	local attachment_slot = attachment_slot_info.unit_to_attachment_slot[unit]
	local text = attachment_slot and attachment_slot or unit
	out_units[text] = {}
	local children = Unit.get_child_units(unit)
	if children then
		for _, child in pairs(children) do
			self:_recursive_get_child_units(child, out_units[text])
		end
	end
end

mod.map_out_unit = function(self, unit)
	local map = {}
	self:_recursive_get_child_units(unit, map)
	self:dtf(map, "map", 20)
end

mod.test_move = function(self, unit)
	if unit and unit_alive(unit) then

		-- self:map_out_unit(unit)

		local children = Unit.get_child_units(unit)
		-- local child = children[2] -- receiver

		local children2 = Unit.get_child_units(children[2])
		local child = children2[3] -- magazine

		local num_meshes = Unit.num_meshes(child)
		if num_meshes then mod:echo("num meshes: "..tostring(num_meshes)) end
		local from, to = 4, 12
		for i = from, to, 1 do
			-- Unit.set_mesh_visibility(child, i, false)
		end

		-- mod:dtf(Mesh, "Mesh", 10)

		-- local has_group = Unit.has_visibility_group(child, "mag")
		-- mod:echo("has group: "..tostring(has_group))

		-- Unit.set_unit_objects_visibility(child, false)
		-- Unit.set_unit_visibility(child, true, true)

	end
end

-- ##### ┌─┐┌─┐┌┬┐┌┬┐┬┌┐┌┌─┐┌─┐ #######################################################################################
-- ##### └─┐├┤  │  │ │││││ ┬└─┐ #######################################################################################
-- ##### └─┘└─┘ ┴  ┴ ┴┘└┘└─┘└─┘ #######################################################################################

mod.get_changed_weapon_settings = function(self)
	if self.cosmetics_view._gear_id then
		self.changed_weapon_settings = {}

		local attachment_slots = self:get_item_attachment_slots(self.cosmetics_view._selected_item)
		for _, attachment_slot in pairs(attachment_slots) do
			-- if self:get_gear_setting(mod.cosmetics_view._gear_id, attachment_slot) then
			self.changed_weapon_settings[attachment_slot] = self:get_gear_setting(mod.cosmetics_view._gear_id, attachment_slot)
			-- end
		end

	end
end

-- ##### ┬ ┬┬  ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ##############################################################################
-- ##### │ ││  ├┤ │ │││││   │ ││ ││││└─┐ ##############################################################################
-- ##### └─┘┴  └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ##############################################################################

mod.check_unsaved_changes = function(self, no_animation)
	if table_size(self.original_weapon_settings) > 0 then
		if self.cosmetics_view._gear_id then

			if no_animation then
				for attachment_slot, value in pairs(self.original_weapon_settings) do
					self:set_gear_setting(self.cosmetics_view._gear_id, attachment_slot, value)
				end
			else
				local index = 1
				local attachment_slots = self:get_item_attachment_slots(self.cosmetics_view._selected_item)
				-- for _, attachment_slot in pairs(attachment_slots) do
				local original_weapon_settings = table_clone(self.original_weapon_settings)
				local attachment_names = {}
				table.reverse(original_weapon_settings)
				for attachment_slot, value in pairs(original_weapon_settings) do
					attachment_names[attachment_slot] = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot, self.cosmetics_view._selected_item)
				end
				mod.weapon_part_animation_update = true
				for attachment_slot, value in pairs(original_weapon_settings) do
					-- local attachment_name = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot)
					self:detach_attachment(self.cosmetics_view._selected_item, attachment_slot, attachment_names[attachment_slot], value)
					index = index + 1
				end
			end

			self.original_weapon_settings = {}
		end
		
		mod:update_equip_button()
	end
end

mod.cb_on_demo_pressed = function(self)
	self.demo = not self.demo
	self.demo_time = .3
	self.demo_timer = 0
	self.cosmetics_view:_cb_on_ui_visibility_toggled("entry_"..tostring(3))
	self:start_weapon_move(vector3_box(Vector3(-.15, -1, 0)), true)
end

mod.cb_on_randomize_pressed = function(self, skip_animation)
	local random_attachments = mod:randomize_weapon(self.cosmetics_view._selected_item)

	skip_animation = not mod:get("mod_option_weapon_build_animation") or skip_animation

	if self.cosmetics_view._gear_id and random_attachments then

		local attachment_names = {}
		for attachment_slot, value in pairs(random_attachments) do
			attachment_names[attachment_slot] = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot, self.cosmetics_view._selected_item)
		end
		mod.weapon_part_animation_update = true
		local index = 1
		for attachment_slot, value in pairs(random_attachments) do
			-- local attachment_name = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot, self.cosmetics_view._selected_item)
			if not skip_animation then
				self:detach_attachment(self.cosmetics_view._selected_item, attachment_slot, attachment_names[attachment_slot], value, true)
			else
				-- self:detach_attachment(self.cosmetics_view._selected_item, attachment_slot, attachment_names[attachment_slot], value, true)
				self:load_new_attachment(self.cosmetics_view._selected_item, attachment_slot, value, index < table_size(random_attachments))
			end
			index = index + 1
		end

		-- self:get_changed_weapon_settings()
		-- self:update_reset_button()
		-- self:update_equip_button()
	end
end

mod.cb_on_reset_pressed = function(self, skip_animation)
	if self.cosmetics_view._gear_id and table.size(self.changed_weapon_settings) > 0 then
		
		skip_animation = not mod:get("mod_option_weapon_build_animation") or skip_animation

		-- local attachment_slots = {}
		-- self:_recursive_get_attachments(self.cosmetics_view._selected_item.attachments, attachment_slots)
		-- table.reverse(attachment_slots)
		-- for attachment_slot, data in pairs(self.changed_weapon_settings) do
		-- 	self:set(tostring(gear_id).."_"..attachment_slot, nil)
		-- end
		-- for _, attachment_slot in pairs(attachment_slots) do
		local changed_weapon_settings = table_clone(self.changed_weapon_settings)
		local attachment_names = {}
		table.reverse(changed_weapon_settings)
		for attachment_slot, value in pairs(changed_weapon_settings) do
			attachment_names[attachment_slot] = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot, self.cosmetics_view._selected_item)
		end
		mod.weapon_part_animation_update = true
		local index = 1
		for attachment_slot, data in pairs(changed_weapon_settings) do
			-- local attachment_name = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot, self.cosmetics_view._selected_item)
			if not skip_animation then
				self:detach_attachment(self.cosmetics_view._selected_item, attachment_slot, attachment_names[attachment_slot], "default")
			else
				self:load_new_attachment(self.cosmetics_view._selected_item, attachment_slot, "default", index < table.size(changed_weapon_settings))
			end
			index = index + 1
		end

		-- self:get_changed_weapon_settings()
		-- self:update_reset_button()
		-- self:update_equip_button()

		self:start_weapon_move()
		mod.new_rotation = 0
		mod.do_rotation = true
	end
	-- end
end

mod.update_randomize_button = function(self)
	local button = self.cosmetics_view._widgets_by_name.randomize_button
	local button_content = button.content
	local disabled = #mod.weapon_part_animation_entries > 0
	button_content.hotspot.disabled = disabled
end

mod.update_equip_button = function(self)
	if self.cosmetics_view._selected_tab_index == 3 then
		local button = self.cosmetics_view._widgets_by_name.equip_button
		local button_content = button.content
		local disabled = table_size(self.original_weapon_settings) == 0 or #mod.weapon_part_animation_entries > 0
		button_content.hotspot.disabled = disabled
		button_content.text = Utf8.upper(disabled and Localize("loc_weapon_inventory_equipped_button") or Localize("loc_weapon_inventory_equip_button"))
	end
end

mod.update_reset_button = function(self)
	local button = self.cosmetics_view._widgets_by_name.reset_button
	local button_content = button.content
	local disabled = table_size(self.changed_weapon_settings) == 0 or #mod.weapon_part_animation_entries > 0
	button_content.hotspot.disabled = disabled
	button_content.text = Utf8.upper(disabled and self:localize("loc_weapon_inventory_no_reset_button") or self:localize("loc_weapon_inventory_reset_button"))
end

mod.update_dropdown = function(self, widget, input_service)
	local content = widget.content
	local entry = content.entry

	if content.close_setting then
		content.close_setting = nil
		content.exclusive_focus = false
		local hotspot = content.hotspot or content.button_hotspot

		if hotspot then
			hotspot.is_selected = false
		end
		self.dropdown_open = false

		return
	end

	local is_disabled = entry.disabled or false
	content.disabled = is_disabled
	local size = {
		400,
		dropdown_height
	}
	local using_gamepad = not Managers.ui:using_cursor_navigation()
	local offset = widget.offset
	local style = widget.style
	local options = content.options
	local options_by_id = content.options_by_id
	local num_visible_options = content.num_visible_options
	local num_options = #options
	local focused = content.exclusive_focus and not is_disabled

	if focused then
		offset[3] = 90
	else
		offset[3] = 0
	end

	local selected_index = content.selected_index
	local value, new_value, real_value = nil, nil, nil
	local hotspot = content.hotspot
	local hotspot_style = style.hotspot

	if selected_index and focused then
		if using_gamepad and hotspot.on_pressed then
			new_value = options[selected_index].id
			real_value = options[selected_index].value
		end

		hotspot_style.on_pressed_sound = hotspot_style.on_pressed_fold_in_sound
	else
		hotspot_style.on_pressed_sound = hotspot_style.on_pressed_fold_out_sound
	end

	value = entry.get_function and entry:get_function() or content.internal_value or "<not selected>"
	local localization_manager = Managers.localization
	local preview_option = options_by_id[value]
	local preview_option_id = preview_option and preview_option.id
	local preview_value = preview_option and preview_option.display_name or "loc_settings_option_unavailable"
	local ignore_localization = preview_option and preview_option.ignore_localization
	content.value_text = ignore_localization and preview_value or localization_manager:localize(preview_value)
	local always_keep_order = true
	local grow_downwards = content.grow_downwards
	local new_selection_index = nil

	if not selected_index or not focused then
		for i = 1, #options do
			local option = options[i]

			if option.id == preview_option_id then
				selected_index = i

				break
			end
		end

		selected_index = selected_index or 1
	end

	if selected_index and focused then
		if input_service:get("navigate_up_continuous") then
			if grow_downwards or not grow_downwards and always_keep_order then
				new_selection_index = math_max(selected_index - 1, 1)
			else
				new_selection_index = math_min(selected_index + 1, num_options)
			end
		elseif input_service:get("navigate_down_continuous") then
			if grow_downwards or not grow_downwards and always_keep_order then
				new_selection_index = math_min(selected_index + 1, num_options)
			else
				new_selection_index = math_max(selected_index - 1, 1)
			end
		end
	end

	if new_selection_index or not content.selected_index then
		if new_selection_index then
			selected_index = new_selection_index
		end

		if num_visible_options < num_options then
			local step_size = 1 / num_options
			local new_scroll_percentage = math_min(selected_index - 1, num_options) * step_size
			content.scroll_percentage = new_scroll_percentage
			content.scroll_add = nil
		end

		content.selected_index = selected_index
	end

	local scroll_percentage = content.scroll_percentage

	if scroll_percentage then
		local step_size = 1 / (num_options - (num_visible_options - 1))
		content.start_index = math_max(1, math.ceil(scroll_percentage / step_size))
	end

	local option_hovered = false
	local option_index = 1
	local start_index = content.start_index or 1
	local end_index = math_min(start_index + num_visible_options - 1, num_options)
	local using_scrollbar = num_visible_options < num_options

	for i = start_index, end_index do
		local actual_i = i

		if not grow_downwards and always_keep_order then
			actual_i = end_index - i + start_index
		end

		local option_text_id = "option_text_" .. option_index
		local option_hotspot_id = "option_hotspot_" .. option_index
		local outline_style_id = "outline_" .. option_index
		local option_hotspot = content[option_hotspot_id]
		option_hovered = option_hovered or option_hotspot.is_hover
		option_hotspot.is_selected = actual_i == selected_index
		local option = options[actual_i]

		if option_hotspot.on_pressed and not option.disabled then
			option_hotspot.on_pressed = nil
			new_value = option.id
			real_value = option.value
			content.selected_index = actual_i
			self.dropdown_closing = true
			content.option_disabled = false
		elseif option_hotspot.on_pressed and option.disabled then
			content.option_disabled = true
		end

		local option_display_name = option.display_name
		local option_ignore_localization = option.ignore_localization
		content[option_text_id] = option_ignore_localization and option_display_name or localization_manager:localize(option_display_name)
		local options_y = size[2] * option_index
		style[option_hotspot_id].offset[2] = grow_downwards and options_y or -options_y
		style[option_hotspot_id].on_pressed_sound = not option.disabled and "wwise/events/ui/play_ui_click"
		style[option_hotspot_id].on_pressed_fold_in_sound = not option.disabled and "wwise/events/ui/play_ui_click"
		style[option_text_id].offset[2] = grow_downwards and options_y or -options_y
		local entry_length = using_scrollbar and size[1] - style.scrollbar_hotspot.size[1] or size[1]
		style[outline_style_id].size[1] = not option.disabled and entry_length or 0
		style[outline_style_id].visible = not option.disabled
		style[option_text_id].size[1] = not option.disabled and size[1] or 0
		option_index = option_index + 1
	end

	local value_changed = new_value ~= nil

	if value_changed and new_value ~= value then
		local on_activated = entry.on_activated

		on_activated(new_value, entry)
	end

	local scrollbar_hotspot = content.scrollbar_hotspot
	local scrollbar_hovered = scrollbar_hotspot.is_hover

	if (input_service:get("left_pressed") or input_service:get("confirm_pressed") or input_service:get("back")) and content.exclusive_focus and not content.wait_next_frame then
		content.wait_next_frame = true

		return
	end

	if content.wait_next_frame and not content.option_disabled then
		content.wait_next_frame = nil
		content.close_setting = true
		self.dropdown_open = false
		self.dropdown_closing = false

		return
	elseif content.wait_next_frame and content.option_disabled then
		content.option_disabled = nil
		content.wait_next_frame = nil

		return
	end
end

mod.update_custom_widgets = function(self, input_service)
    if self.cosmetics_view._custom_widgets then
        for _, widget in pairs(self.cosmetics_view._custom_widgets) do
            if widget.content and widget.content.entry and widget.content.entry.widget_type == "dropdown" then
				local pivot_name = widget.name.."_pivot"
				pivot_name = string_gsub(pivot_name, "_custom", "")
				local scenegraph_entry = self.cosmetics_view._ui_scenegraph[pivot_name]
				if scenegraph_entry and scenegraph_entry.position then
					if scenegraph_entry.position[2] > grid_size[2] / 2 then
						widget.content.grow_downwards = false
					else
						widget.content.grow_downwards = true
					end
				end
                self:update_dropdown(widget, input_service)
            end
        end
    end
end

mod.hide_custom_widgets = function(self, hide)
    if self.cosmetics_view._custom_widgets then
        for _, widget in pairs(self.cosmetics_view._custom_widgets) do
			if not widget.not_applicable then
            	widget.visible = not hide
			else
				widget.visible = false
			end
        end
		if self.cosmetics_view._custom_widgets_overlapping > 0 then
			self.cosmetics_view._widgets_by_name.panel_extension.visible = not hide
		else
			self.cosmetics_view._widgets_by_name.panel_extension.visible = false
		end
		self.cosmetics_view._widgets_by_name.reset_button.visible = not hide
		self.cosmetics_view._widgets_by_name.randomize_button.visible = not hide
		self.cosmetics_view._widgets_by_name.demo_button.visible = not hide
    end
end

-- ##### ┬  ┬┬┌─┐┬ ┬  ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ #######################################################################
-- ##### └┐┌┘│├┤ │││  ├┤ │ │││││   │ ││ ││││└─┐ #######################################################################
-- #####  └┘ ┴└─┘└┴┘  └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ #######################################################################

mod.validate_item_model = function(self, model)
	mod:setup_item_definitions()
	if model ~= "" then
		local definition = mod:persistent_table("weapon_customization").item_definitions[model]
		if definition then
			if definition.workflow_state ~= "RELEASABLE" then
				return false
			end
			if table_find(definition.feature_flags, "FEATURE_unreleased_premium_cosmetics") then
				return false
			end
			-- if table_find(definition.feature_flags, "FEATURE_premium_store") and 
			-- 		not table_find(definition.feature_flags, "FEATURE_item_retained") then
			-- 	return false
			-- end
			-- if not table_find(definition.feature_flags, "FEATURE_item_retained") then
			-- 	return false
			-- end
		end
	end
	return true
end

mod.generate_dropdown_option = function(self, id, display_name, sounds)
    return {
        id = id,
        display_name = display_name,
        ignore_localization = true,
        value = id,
		sounds = sounds,
		disabled = false,
    }
end

mod.add_custom_widget = function(self, widget)
	self.cosmetics_view._custom_widgets[#self.cosmetics_view._custom_widgets+1] = widget
end

mod.generate_custom_widgets = function(self)
	local item = self.cosmetics_view._selected_item
	if item then
		-- Iterate scenegraphs additions
		for _, added_scenegraph in pairs(self.added_cosmetics_scenegraphs) do
			-- Differentiate text and dropdown
			if string_find(added_scenegraph, "text_pivot") then
				-- Generate label
				local attachment_slot = string_gsub(added_scenegraph, "_text_pivot", "")
				self:add_custom_widget(self:generate_label(added_scenegraph, attachment_slot, item))
			else
				-- Generate dropdown
				local attachment_slot = string_gsub(added_scenegraph, "_pivot", "")
				self:add_custom_widget(self:generate_dropdown(added_scenegraph, attachment_slot, item))
			end
		end
	end
end

mod.resolve_not_applicable_attachments = function(self)
	local item = self.cosmetics_view._selected_item
	if item then
		-- Get item name
		-- local item_name = self:item_name_from_content_string(item.name)
		local item_name = self.cosmetics_view._item_name
		local move = 0
		-- Iterate attachment slots
		for index, slot in pairs(self.attachment_slots) do
			-- Check that weapon has attachment slot and more than 2 options
			-- 1st option is default
			if self.attachment[item_name] and (not self.attachment[item_name][slot] or #self.attachment[item_name][slot] <= 2) then
				-- Set not applicable in widgets to hide them
				self.cosmetics_view._widgets_by_name[slot.."_custom"].not_applicable = true
				self.cosmetics_view._widgets_by_name[slot.."_custom_text"].not_applicable = true
				-- Add to list of not applicable widgets
				self.cosmetics_view._not_applicable[#self.cosmetics_view._not_applicable+1] = slot.."_pivot"
				self.cosmetics_view._not_applicable[#self.cosmetics_view._not_applicable+1] = slot.."_text_pivot"
			end
		end
		-- Move widgets according to their applicable status
		for _, scenegraph_name in pairs(self.added_cosmetics_scenegraphs) do
			if table_contains(self.cosmetics_view._not_applicable, scenegraph_name) then
				-- Differentiate text and dropdown
				if string_find(scenegraph_name, "text_pivot") then
					move = move + label_height
				else
					move = move + dropdown_height
				end
			end
			-- Change scenegraph position
			local scenegraph_entry = self.cosmetics_view._ui_scenegraph[scenegraph_name]
			if scenegraph_entry then
				scenegraph_entry.local_position[2] = scenegraph_entry.local_position[2] - move
			end
		end
	end
end

mod.resolve_overlapping_widgets = function(self)
	local move = 0
	local overlapping = {}
	-- Iterate scenegraph entries
	for _, scenegraph_entry in pairs(self.added_cosmetics_scenegraphs) do
		-- Make sure attachment slot is applicable
		if not table_contains(self.cosmetics_view._not_applicable, scenegraph_entry) then
			-- Differentiate text and dropdown
			if string_find(scenegraph_entry, "text_pivot") then
				move = move + label_height
			else
				move = move + dropdown_height
			end
			-- Check if widget is overlapping
			if self.cosmetics_view._ui_scenegraph[scenegraph_entry].local_position[2] > grid_size[2] then
				-- Count overlapping attachment slots
				if not string_find(scenegraph_entry, "text_pivot") then
					self.cosmetics_view._custom_widgets_overlapping = self.cosmetics_view._custom_widgets_overlapping + 1
				end
				-- Add overlapping widget to list
				overlapping[#overlapping+1] = scenegraph_entry
			end
		end
	end
	-- Change extension panels size
	local extension_panel_pivot = self.cosmetics_view._ui_scenegraph.panel_extension_pivot
	extension_panel_pivot.size[2] = (85 * self.cosmetics_view._custom_widgets_overlapping) + (edge * 2)
	extension_panel_pivot.local_position[2] = grid_size[2] - 85 * (self.cosmetics_view._custom_widgets_overlapping + 1)
	-- Change overlapping widgets positions
	for _, scenegraph_name in pairs(overlapping) do
		local scenegraph_entry = self.cosmetics_view._ui_scenegraph[scenegraph_name]
		scenegraph_entry.local_position[1] = scenegraph_entry.local_position[1] + grid_width
		scenegraph_entry.local_position[2] = scenegraph_entry.local_position[2] - 85 * (self.cosmetics_view._custom_widgets_overlapping + 1)
	end
end

mod.init_custom_weapon_zoom = function(self)
	local item = self.cosmetics_view._selected_item
	if item then
		-- Get item name
		-- local item_name = self:item_name_from_content_string(item.name)
		local item_name = self.cosmetics_view._item_name
		-- Check for weapon in data
		if self.attachment_models[item_name] then
			-- Check for custom weapon zoom
			if self.attachment_models[item_name].customization_min_zoom then
				local min_zoom = self.attachment_models[item_name].customization_min_zoom
				self.cosmetics_view._min_zoom = min_zoom
			else
				self.cosmetics_view._min_zoom = -2
			end
			-- Set zoom
			self.cosmetics_view._weapon_zoom_target = self.cosmetics_view._min_zoom
			self.cosmetics_view._weapon_zoom_fraction = self.cosmetics_view._min_zoom
			self.cosmetics_view:_set_weapon_zoom(self.cosmetics_view._min_zoom)
		end
	end
end

mod.reset_stuff = function(self)
	self.demo = nil
	self.move_position = nil
	self.new_position = nil
	self.last_move_position = nil
	self.link_unit_position = nil
	self.do_move = nil
	self.move_end = nil
	self.do_reset = nil
	self.reset_start = nil
	self._last_rotation_angle = 0
	self.mesh_positions = {}
	self.weapon_part_animation_update = nil
	self.weapon_part_animation_entries = {}
end

mod.label_template = function(self, text, scenegraph_id)
	local style = table_clone(UIFontSettings.grid_title)
	style.offset = {0, 15, 1}
    return UIWidget.create_definition({
        {
            value_id = "text",
            style_id = "text",
            pass_type = "text",
            value = mod:localize(text),
            style = style,
        }
    }, scenegraph_id)
end

mod.generate_label = function(self, scenegraph, attachment_slot, item)

	-- local weapon_name = self:item_name_from_content_string(item.name)
	local item_name = self.cosmetics_view._item_name
	local style = table_clone(UIFontSettings.grid_title)
	style.offset = {0, 15, 1}
	local text = "loc_weapon_cosmetics_customization_"..attachment_slot

	if self.text_overwrite[item_name] then
		text = self.text_overwrite[item_name][text] or text
	end

    local definition = UIWidget.create_definition({
        {
            value_id = "text",
            style_id = "text",
            pass_type = "text",
            value = self:localize(text),
            style = style,
        }
    }, scenegraph, nil)

	local widget_name = attachment_slot.."_custom_text"
	local widget = self.cosmetics_view:_create_widget(widget_name, definition)

	self.cosmetics_view._widgets_by_name[widget_name] = widget
    self.cosmetics_view._widgets[#self.cosmetics_view._widgets+1] = widget

	return widget
end

mod.generate_dropdown = function(self, scenegraph, attachment_slot, item)

	local item_name = self.cosmetics_view._item_name
    local options = {}
    if mod.attachment[item_name] and mod.attachment[item_name][attachment_slot] then
        for _, data in pairs(mod.attachment[item_name][attachment_slot]) do
			local model = mod.attachment_models[item_name][data.id] and mod.attachment_models[item_name][data.id].model
			if model and mod:validate_item_model(model) then
            	options[#options+1] = mod:generate_dropdown_option(data.id, data.name, data.sounds)
			end
        end
    end

    local max_visible_options = 10
    local num_options = #options
    local num_visible_options = math_min(num_options, max_visible_options)

    local size = {grid_size[1], dropdown_height}
    local template = DropdownPassTemplates.settings_dropdown(size[1], size[2], size[1], num_visible_options, true)
	for _, pass in pairs(template) do
		if pass.content_id and string_find(pass.content_id, "option_hotspot") then
			pass.visibility_function = function(content)
				return content.parent.anim_exclusive_focus_progress > 0 and not content.disabled
			end
		end
	end
	template[7].pass_type = "texture"
	template[7].value = "content/ui/materials/backgrounds/terminal_basic"
	template[7].style.horizontal_alignment = "center"
    local definition = UIWidget.create_definition(template, scenegraph, nil, size)
    local widget_name = attachment_slot.."_custom"
    local widget = self.cosmetics_view:_create_widget(widget_name, definition)

    self.cosmetics_view._widgets_by_name[widget_name] = widget
    self.cosmetics_view._widgets[#self.cosmetics_view._widgets+1] = widget

    local content = widget.content
    content.entry = {
        options = options,
        widget_type = "dropdown",
        on_activated = function(new_value, entry)

			local attachment = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot, self.cosmetics_view._selected_item)
			mod.weapon_part_animation_update = true

			if mod:get("mod_option_weapon_build_animation") then
				self:detach_attachment(self.cosmetics_view._presentation_item, attachment_slot, attachment, new_value)
			else
				self:load_new_attachment(self.cosmetics_view._selected_item, attachment_slot, new_value)
				self:play_attachment_sound(self.cosmetics_view._selected_item, attachment_slot, new_value)
			end

			local weapon_attachments = mod.attachment_models[item_name]
			local attachment_data = weapon_attachments[new_value]
			local new_angle = attachment_data.angle or 0

			if string_find(new_value, "default") then
				mod.new_rotation = 0
				mod.do_rotation = true
			else
				mod.do_rotation = true
				mod.new_rotation = new_angle
			end

			if attachment_data.move and not string_find(new_value, "default") then
				self:start_weapon_move(attachment_data.move)
			else
				self:start_weapon_move()
			end

        end,
        get_function = function()
            return self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot)
        end,
    }
    local options_by_id = {}
    for index, option in pairs(options) do
        options_by_id[option.id] = option
    end
    content.options_by_id = options_by_id
	content.options = options
    content.num_visible_options = num_visible_options

    content.hotspot.pressed_callback = function ()
		if not mod.dropdown_open and not content.disabled then
			local selected_widget = nil
			local selected = true
			content.exclusive_focus = selected
			local hotspot = content.hotspot or content.button_hotspot
			if hotspot then
				hotspot.is_selected = selected
			end
			mod.dropdown_open = true
		end
    end

    content.area_length = size[2] * num_visible_options
    local scroll_length = math_max(size[2] * num_options - content.area_length, 0)
    content.scroll_length = scroll_length
    local spacing = 0
    local scroll_amount = scroll_length > 0 and (size[2] + spacing) / scroll_length or 0
    content.scroll_amount = scroll_amount

    return widget
end

-- ##### ┬  ┬┬┌─┐┬ ┬  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #################################################################################
-- ##### └┐┌┘│├┤ │││  ├─┤│ ││ │├┴┐└─┐ #################################################################################
-- #####  └┘ ┴└─┘└┴┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #################################################################################

mod:hook(CLASS.InventoryWeaponCosmeticsView, "init", function(func, self, settings, context, ...)
	-- Fetch instance
	mod.cosmetics_view = self
	-- Original function
	func(self, settings, context, ...)
	-- Custom attributes
	self._custom_widgets = {}
	self._not_applicable = {}
	self._custom_widgets_overlapping = 0
	self._item_name = mod:item_name_from_content_string(self._selected_item.name)
	self._gear_id = mod:get_gear_id(self._presentation_item)
	-- Overwrite draw elements function
	-- Make view legend inputs visible when UI gets hidden
	self._draw_elements = function(self, dt, t, ui_renderer, render_settings, input_service)
		local old_alpha_multiplier = render_settings.alpha_multiplier
		local alpha_multiplier = self._alpha_multiplier or 1
		local elements_array = self._elements_array
		for i = 1, #elements_array do
			local element = elements_array[i]
			if element then
				local element_name = element.__class_name
				if element_name ~= "ViewElementInventoryWeaponPreview" or element_name ~= "ViewElementInputLegend" then
					ui_renderer = self._ui_default_renderer or ui_renderer
				end
				render_settings.alpha_multiplier = element_name ~= "ViewElementInputLegend" and alpha_multiplier or 1
				element:draw(dt, t, ui_renderer, render_settings, input_service)
			end
		end
		render_settings.alpha_multiplier = old_alpha_multiplier
	end
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "on_enter", function(func, self, ...)
    func(self, ...)
	-- Fetch instance
	mod.cosmetics_view = self

    mod:generate_custom_widgets()
	mod:resolve_not_applicable_attachments()
	mod:resolve_overlapping_widgets()
	mod:init_custom_weapon_zoom()

	mod.original_weapon_settings = {}
	mod:get_changed_weapon_settings()
	mod:update_reset_button()

    mod:hide_custom_widgets(true)
	mod:resolve_no_support()

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "update", function(func, self, dt, t, input_service, ...)

    func(self, dt, t, input_service, ...)

	if mod.cosmetics_view then
		mod:update_custom_widgets(input_service)
		mod:update_equip_button()
		mod:update_reset_button()
	end

	if mod.cosmetics_view and mod.demo then
		local rotation_angle = (mod._last_rotation_angle or 0) + dt
		self._weapon_preview._ui_weapon_spawner._rotation_angle = rotation_angle
		self._weapon_preview._ui_weapon_spawner._default_rotation_angle = rotation_angle
		mod._last_rotation_angle = self._weapon_preview._ui_weapon_spawner._default_rotation_angle
		if mod.demo_timer < t then
			mod:cb_on_randomize_pressed()
			mod.demo_timer = t + mod.demo_time
		end
	end

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_handle_input", function(func, self, input_service, dt, t, ...)
	local zoom_target = self._weapon_zoom_target

	func(self, input_service, dt, t, ...)

	if mod.dropdown_open then
		self._weapon_zoom_target = zoom_target
	end
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_register_button_callbacks", function(func, self, ...)
	func(self, ...)
	local widgets_by_name = self._widgets_by_name
	local reset_button = widgets_by_name.reset_button
	reset_button.content.hotspot.pressed_callback = callback(mod, "cb_on_reset_pressed")
	local randomize_button = widgets_by_name.randomize_button
	randomize_button.content.hotspot.pressed_callback = callback(mod, "cb_on_randomize_pressed")
	local demo_button = widgets_by_name.demo_button
	demo_button.content.hotspot.pressed_callback = callback(mod, "cb_on_demo_pressed")
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_set_weapon_zoom", function(func, self, fraction, ...)
	if not mod.dropdown_open then
		func(self, fraction, ...)
	end
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_draw_widgets", function(func, self, dt, t, input_service, ui_renderer, render_settings, ...)
	local always_visible_widget_names = self._always_visible_widget_names
	local alpha_multiplier = self._render_settings and self._render_settings.alpha_multiplier or 1
	local anim_alpha_speed = 3

	if self._visibility_toggled_on then
		alpha_multiplier = math_min(alpha_multiplier + dt * anim_alpha_speed, 1)
	else
		alpha_multiplier = math_max(alpha_multiplier - dt * anim_alpha_speed, 0)
	end

	local always_visible_widget_names = self._always_visible_widget_names
	self._alpha_multiplier = alpha_multiplier
	local widgets = self._widgets
	local num_widgets = #widgets

	for i = 1, num_widgets do
		local widget = widgets[i]
		local widget_name = widget.name
		self._render_settings.alpha_multiplier = always_visible_widget_names[widget_name] and 1 or alpha_multiplier

		UIWidget.draw(widget, ui_renderer)
	end
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "on_exit", function(func, self, ...)
	
	mod:reset_stuff()
	
	local weapon_spawner = self._weapon_preview._ui_weapon_spawner
	local default_position = weapon_spawner._link_unit_base_position
	weapon_spawner._link_unit_position = default_position
	weapon_spawner._rotation_angle = 0
	weapon_spawner._default_rotation_angle = 0

	if weapon_spawner._weapon_spawn_data then
		local link_unit = weapon_spawner._weapon_spawn_data.link_unit
		unit_set_local_position(link_unit, 1, vector3_unbox(default_position))
	end

	mod:check_unsaved_changes(true)

	func(self, ...)

	mod.cosmetics_view = nil
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "cb_on_equip_pressed", function(func, self, ...)
	if self._selected_tab_index == 3 then
		mod.original_weapon_settings = {}
		mod:update_equip_button()

		mod:attachment_package_snapshot(self._selected_item)

		local old_packages, new_packages = mod:attachment_package_snapshot(self._presentation_item)
		if new_packages and #new_packages > 0 then
			local weapon_spawner = self._weapon_preview._ui_weapon_spawner
			local reference_name = weapon_spawner._reference_name .. "_weapon_item_loader_" .. tostring(weapon_spawner._weapon_loader_index)
			for _, new_package in pairs(new_packages) do
				Managers.package:load(new_package, reference_name, nil, true)
			end
		end

		local package_synchronizer_client = Managers.package_synchronization:synchronizer_client()
		if package_synchronizer_client then
			package_synchronizer_client:reevaluate_all_profiles_packages()
		end

		mod:redo_weapon_attachments(self._presentation_item)
		self._presentation_item.item_type = self._selected_item.item_type
		self._presentation_item.gear_id = self._selected_item.gear_id
		mod.weapon_changed = true
		mod.changed_weapon = self._presentation_item

		mod:get_changed_weapon_settings()

		mod.reset_start = Managers.time:time("main")
	else
		func(self, ...)
	end
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_setup_menu_tabs", function(func, self, content, ...)
	local item_name = self._item_name
	if item_name and mod.attachment[item_name] then
		content[3] = {
			display_name = "loc_weapon_cosmetics_customization",
			slot_name = "slot_weapon_skin",
			item_type = "WEAPON_SKIN",
			icon = "content/ui/materials/icons/system/settings/category_gameplay",
			filter_on_weapon_template = true,
			apply_on_preview = function (real_item, presentation_item)
				self:_preview_item(presentation_item)
			end
		}
	end
	func(self, content, ...)
	if item_name and mod.attachment[item_name] then
		self._tab_menu_element._widgets_by_name.entry_0.content.size[1] = button_width
		self._tab_menu_element._widgets_by_name.entry_1.content.size[1] = button_width
		self._tab_menu_element._widgets_by_name.entry_2.content.size[1] = button_width
	end
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "cb_switch_tab", function(func, self, index, ...)
	if index == 3 then
        self:present_grid_layout({})
        self._item_grid._widgets_by_name.grid_empty.visible = false
        mod:hide_custom_widgets(false)
		mod.original_weapon_settings = {}
		mod:get_changed_weapon_settings()
		mod:update_equip_button()
		mod:update_reset_button()
    else
		local t = Managers.time:time("main")
		mod.reset_start = t
		mod:check_unsaved_changes(true)
        mod:hide_custom_widgets(true)
    end
    func(self, index, ...)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_select_starting_item_by_slot_name", function(func, self, slot_name, optional_start_index, ...)
	if self._selected_tab_index < 3 then
		func(self, slot_name, optional_start_index, ...)
	end
end)

mod:hook_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view_definitions", function(instance)

	local top = 85
	local z = 1

	local y = top - edge
	for _, scenegraph_id in pairs(mod.added_cosmetics_scenegraphs) do
		if string_find(scenegraph_id, "text_pivot") then
			y = y + label_height
		else
			y = y + dropdown_height
		end
		instance.scenegraph_definition[scenegraph_id] = {
			vertical_alignment = "top",
			parent = "grid_tab_panel",
			horizontal_alignment = "left",
			size = {grid_size[1], label_height},
			position = {edge, y, z}
		}
	end

	instance.scenegraph_definition.panel_extension_pivot = {
		vertical_alignment = "top",
		parent = "grid_tab_panel",
		horizontal_alignment = "left",
		size = {grid_width + edge, 340 + edge * 2},
		position = {grid_width - 10, grid_size[2] - 425, z}
	}

	local equip_button_size = {374, 76}
	instance.scenegraph_definition.reset_button = {
		vertical_alignment = "bottom",
		parent = "equip_button",
		horizontal_alignment = "right",
		size = equip_button_size,
		position = {0, -equip_button_size[2] - 15, 1}
	}
	instance.widget_definitions.reset_button = UIWidget.create_definition(table_clone(ButtonPassTemplates.default_button), "reset_button", {
		gamepad_action = "confirm_pressed",
		text = Utf8.upper(mod:localize("loc_weapon_inventory_reset_button")),
		hotspot = {
			on_pressed_sound = UISoundEvents.weapons_skin_confirm
		}
	})
	
	instance.scenegraph_definition.randomize_button = {
		vertical_alignment = "bottom",
		parent = "equip_button",
		horizontal_alignment = "right",
		size = equip_button_size,
		position = {0, -equip_button_size[2] * 2 - 15 * 2, 1}
	}
	instance.widget_definitions.randomize_button = UIWidget.create_definition(table_clone(ButtonPassTemplates.default_button), "randomize_button", {
		gamepad_action = "confirm_pressed",
		text = Utf8.upper(mod:localize("loc_weapon_inventory_randomize_button")),
		hotspot = {
			on_pressed_sound = UISoundEvents.weapons_skin_confirm
		}
	})

	instance.scenegraph_definition.demo_button = {
		vertical_alignment = "bottom",
		parent = "equip_button",
		horizontal_alignment = "right",
		size = equip_button_size,
		position = {0, -equip_button_size[2] * 3 - 15 * 3, 1}
	}
	instance.widget_definitions.demo_button = UIWidget.create_definition(table_clone(ButtonPassTemplates.default_button), "demo_button", {
		gamepad_action = "confirm_pressed",
		text = Utf8.upper(mod:localize("loc_weapon_inventory_demo_button")),
		hotspot = {
			on_pressed_sound = UISoundEvents.weapons_skin_confirm
		}
	})

	instance.widget_definitions.panel_extension = UIWidget.create_definition({
		{
			value = "content/ui/materials/backgrounds/terminal_basic",
			style_id = "background",
			pass_type = "texture",
			style = {
				vertical_alignment = "bottom",
				scale_to_material = true,
				horizontal_alignment = "left",
				offset = {0, 0, 0},
				size_addition = {0, -1},
				color = Color.terminal_grid_background(255, true),
			}
		},
		{
			value = "content/ui/materials/frames/dropshadow_medium",
			style_id = "input_progress_frame",
			pass_type = "texture",
			style = {
				vertical_alignment = "bottom",
				scale_to_material = true,
				horizontal_alignment = "right",
				offset = {10, 10, 4},
				default_offset = {10, 0, 4},
				size = {0, 10},
				color = {255, 226, 199, 126},
				-- size_addition = {20, 20}
			}
		}
	}, "panel_extension_pivot")

	if #instance.legend_inputs == 1 then
		instance.legend_inputs[#instance.legend_inputs+1] = {
			on_pressed_callback = "_cb_on_ui_visibility_toggled",
			input_action = "hotkey_menu_special_2",
			display_name = "loc_menu_toggle_ui_visibility_off",
			alignment = "right_alignment"
		}
	end

	instance.always_visible_widget_names.background = true

end)

-- ##### ┬ ┬┌─┐┬  ┌─┐ #################################################################################################
-- ##### ├─┤├┤ │  ├─┘ #################################################################################################
-- ##### ┴ ┴└─┘┴─┘┴   #################################################################################################

mod.vector3_equal = function(self, v1, v2)
	return v1[1] == v2[1] and v1[2] == v2[2] and v1[3] == v2[3]
end
