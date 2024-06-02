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
    local math = math
    local Unit = Unit
    local CLASS = CLASS
    local pairs = pairs
    local World = World
    local Actor = Actor
    local Camera = Camera
    local get_mod = get_mod
    local vector3 = Vector3
    local math_pi = math.pi
    local tostring = tostring
    local managers = Managers
    local math_sin = math.sin
    local math_lerp = math.lerp
    local NilCursor = NilCursor
    local unit_alive = Unit.alive
    local actor_unit = Actor.unit
    local Quaternion = Quaternion
    local vector3_box = Vector3Box
    local PhysicsWorld = PhysicsWorld
    local vector3_lerp = vector3.lerp
    local vector3_zero = vector3.zero
    local unit_get_data = Unit.get_data
    local quaternion_box = QuaternionBox
    local vector3_unbox = vector3_box.unbox
    local math_easeInCubic = math.easeInCubic
    local RESOLUTION_LOOKUP = RESOLUTION_LOOKUP
    local vector3_normalize = vector3.normalize
    local world_unlink_unit = World.unlink_unit
    local quaternion_unbox = quaternion_box.unbox
    local unit_local_position = Unit.local_position
    local quaternion_multiply = Quaternion.multiply
    local quaternion_axis_angle = Quaternion.axis_angle
    local camera_screen_to_world = Camera.screen_to_world
    local unit_set_local_position = Unit.set_local_position
    local unit_set_local_rotation = Unit.set_local_rotation
    local unit_set_unit_visibility = Unit.set_unit_visibility
    local math_round_with_precision = math.round_with_precision
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local SLOT_SECONDARY = "slot_secondary"
    local WEAPON_PART_ANIMATION_TIME = .75
    local MOVE_DURATION_OUT = .5
	local MOVE_DURATION_IN = 1
    local RESET_WAIT_TIME = 5
--#endregion

-- Change light positions
mod.set_light_positions = function(self)
	if self.preview_lights and self.cosmetics_view then
		for _, unit_data in pairs(self.preview_lights) do
			-- Get default position
			local default_position = vector3_unbox(unit_data.position)
			-- Get difference to link unit position
			local weapon_spawner = self.cosmetics_view._weapon_preview._ui_weapon_spawner
			if weapon_spawner then
				local link_difference = vector3_unbox(weapon_spawner._link_unit_base_position) - vector3_unbox(weapon_spawner._link_unit_position)
				-- Position with offset
				local light_position = vector3(default_position[1], default_position[2] - link_difference[2], default_position[3])
				-- mod:info("mod.set_light_positions: "..tostring(unit_data.unit))
				unit_set_local_position(unit_data.unit, 1, light_position)
			end
		end
	end
end

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/managers/ui/ui_weapon_spawner", function(instance)

	instance.get_modding_tools = function(self)
		self.modding_tools = self.modding_tools or get_mod("modding_tools")
	end

	instance.unit_manipulation_busy = function(self)
		self:get_modding_tools()
		if self.modding_tools and self.modding_tools.unit_manipulation_busy then
			return self.modding_tools:unit_manipulation_busy()
		end
	end

	instance.unit_manipulation_remove = function(self, unit)
		self:get_modding_tools()
		if self.modding_tools and self.modding_tools.unit_manipulation_remove then
			self.modding_tools:unit_manipulation_remove(unit)
		end
	end

	instance._init_custom = function(self)
		if self._reference_name ~= "WeaponIconUI" then
			-- Rotation
			self._rotation_angle = mod._rotation_angle or 0
			self._default_rotation_angle = mod._last_rotation_angle or 0
			-- Build animation extension
			if mod.cosmetics_view then
				mod.build_animation:set({
					ui_weapon_spawner = self,
					world = self._world,
					item = mod.cosmetics_view._presentation_item,
				}, true)
			end
		end
	end

	instance.fix_streaming_without_mesh_streamer = function(self)
		local weapon_spawn_data = self._weapon_spawn_data
		if weapon_spawn_data and not weapon_spawn_data.visible then
			self:cb_on_unit_3p_streaming_complete(weapon_spawn_data.item_unit_3p)
		end
	end

	instance.fix_streaming_without_mesh_streamer_2 = function(self)
		if self._weapon_spawn_data then
			mod.weapon_spawning = nil
			self._weapon_spawn_data.streaming_complete = true
		end
	end

	instance.is_rotation_disabled = function(self)
		return self:unit_manipulation_busy() or self._rotation_input_disabled or mod.dropdown_open
	end

	instance.unlink_units = function(self)
		local weapon_spawn_data = self._weapon_spawn_data
		if weapon_spawn_data then
			local item_unit_3p = weapon_spawn_data.item_unit_3p
			local attachment_units_3p = weapon_spawn_data.attachment_units_3p
			for i = #attachment_units_3p, 1, -1 do
				local unit = attachment_units_3p[i]
				if unit and unit_alive(unit) then
					world_unlink_unit(self._world, unit)
				end
			end
			if item_unit_3p and unit_alive(item_unit_3p) then
				world_unlink_unit(self._world, item_unit_3p)
			end
		end
	end

	instance.toggle_modding_tools = function(self, value)
		self._modding_tool_toggled_on = value
	end

	instance.unit_manipulation_remove_all = function(self)
		local weapon_spawn_data = self._weapon_spawn_data
		if weapon_spawn_data and self._modding_tool_toggled_on then
			self:unit_manipulation_remove(weapon_spawn_data.item_unit_3p)
			local attachment_units_3p = weapon_spawn_data.attachment_units_3p or {}
			for _, unit in pairs(attachment_units_3p) do
				self:unit_manipulation_remove(unit)
			end
		end
	end

	instance.update_carousel = function(self, dt, t)
		if mod.cosmetics_view and mod:get("mod_option_carousel") then
			mod.cosmetics_view:try_spawning_previews()
			mod.cosmetics_view:update_attachment_previews(dt, t)
		end
	end

	instance.update_animation = function(self, dt, t)
		local weapon_spawn_data = self._weapon_spawn_data
		if weapon_spawn_data and self._link_unit_position then
			
			local link_unit = weapon_spawn_data.link_unit
			local position = vector3_unbox(self._link_unit_position)
			local animation_speed = mod:get("mod_option_weapon_build_animation_speed")
			local animation_time = WEAPON_PART_ANIMATION_TIME
			local item_unit_3p = weapon_spawn_data.item_unit_3p

			-- Camera movement
			if mod.do_move and mod:get("mod_option_camera_zoom") then
				if mod.move_position then
					local last_move_position = mod.last_move_position and vector3_unbox(mod.last_move_position) or vector3_zero()
					local move_position = vector3_unbox(mod.move_position)
					if not mod:vector3_equal(last_move_position, move_position) then
						mod.new_position = vector3_box(vector3_unbox(self._link_unit_base_position) + move_position)
						mod.move_end = t + MOVE_DURATION_IN
						mod.current_move_duration = MOVE_DURATION_IN
						mod.last_move_position = mod.move_position
						mod:play_zoom_sound(t, UISoundEvents.apparel_zoom_in)
					end

				elseif self._link_unit_base_position then
					local last_move_position = vector3_unbox(self._link_unit_position)
					local move_position = vector3_unbox(self._link_unit_base_position)
					if not mod:vector3_equal(move_position, last_move_position) then
						mod.new_position = self._link_unit_base_position
						mod.move_end = t + MOVE_DURATION_OUT
						mod.current_move_duration = MOVE_DURATION_OUT
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
						-- mod:info("CLASS.UIWeaponSpawner: "..tostring(link_unit))
						unit_set_local_position(link_unit, 1, lerp_position)
					end
					self._link_unit_position = vector3_box(lerp_position)

				elseif mod.move_end and t > mod.move_end then
					mod.move_end = nil
					if link_unit and unit_alive(link_unit) then
						-- mod:info("CLASS.UIWeaponSpawner: "..tostring(link_unit))
						unit_set_local_position(link_unit, 1, vector3_unbox(mod.new_position))
					end
					if link_unit and unit_alive(link_unit) then
						mod.link_unit_position = vector3_box(unit_local_position(link_unit, 1))
					end
					if mod.current_move_duration == MOVE_DURATION_IN and not mod:vector3_equal(vector3_unbox(mod.new_position), vector3_zero()) then
						mod.do_reset = true
					end

				end
			end
			-- mod.customization_camera:update(dt, t)

			-- Lights
			mod:set_light_positions(self)
			
			-- Camera rotation
			if mod.do_rotation then
				local new_rotation = mod.new_rotation
				if new_rotation then
					if new_rotation ~= 0 and self._default_rotation_angle ~= new_rotation then
						-- mod:play_zoom_sound(t, UISoundEvents.apparel_zoom_in)
					end
					-- self._rotation_angle = mod._last_rotation_angle or 0
					self._default_rotation_angle = new_rotation
					mod._last_rotation_angle = self._default_rotation_angle
					mod.check_rotation = true
					mod.do_reset = nil
					mod.reset_start = nil
					mod.do_rotation = nil
				end

			elseif mod.check_rotation and not mod.dropdown_open then
				if math_round_with_precision(self._rotation_angle, 1) == math_round_with_precision(self._default_rotation_angle, 1) then
					if math_round_with_precision(self._rotation_angle, 1) ~= 0 then
						mod.do_reset = true
					end
					mod.check_rotation = nil
				end

			end

			-- Reset
			if mod.do_reset and not mod.dropdown_open then
				mod.reset_start = t + RESET_WAIT_TIME
				mod.do_reset = nil

			elseif mod.reset_start and t >= mod.reset_start and not mod.dropdown_open then
				if mod.move_position then
					mod:play_zoom_sound(t, UISoundEvents.apparel_zoom_out)
				end
				mod.move_position = nil
				mod.do_move = true
				mod.reset_start = nil
				self._default_rotation_angle = 0
				mod._last_rotation_angle = 0

			elseif mod.reset_start and mod.dropdown_open then
				mod.reset_start = mod.reset_start + dt

			end

			-- Weapon part animations
			mod.build_animation:update(dt, t)
		end
	end

	instance.spawn_weapon_custom = function(self)
		local weapon_spawn_data = self._weapon_spawn_data
		if weapon_spawn_data and self._reference_name ~= "WeaponIconUI" then

			-- mod.cosmetics_view.weapon_unit = weapon_spawn_data.item_unit_3p
			-- mod.cosmetics_view.attachment_units_3p = weapon_spawn_data.attachment_units_3p or {}

			-- if modding_tools and mod.cosmetics_view._modding_tool_toggled_on then
			-- 	local gui = mod.cosmetics_view._ui_forward_renderer.gui
			-- 	modding_tools:unit_manipulation_add(weapon_spawn_data.item_unit_3p, self._camera, self._world, gui, mod.cosmetics_view._item_name)
			-- 	local attachment_units_3p = weapon_spawn_data.attachment_units_3p or {}
			-- 	for _, unit in pairs(attachment_units_3p) do
			-- 		local name = Unit.get_data(unit, "attachment_slot")
			-- 		modding_tools:unit_manipulation_add(unit, self._camera, self._world, gui, name)
			-- 	end
			-- end

			-- local item_name = mod.cosmetics_view._item_name
			local item_name = mod:item_name_from_content_string(weapon_spawn_data.item.name)
			local link_unit = weapon_spawn_data.link_unit

			mod.weapon_spawning = true

			unit_set_unit_visibility(weapon_spawn_data.item_unit_3p, true, true)

			mod.gear_settings:hide_bullets(weapon_spawn_data.attachment_units_3p)

			-- local flashlight = mod:get_attachment_slot_in_attachments(weapon_spawn_data.attachment_units_3p, "flashlight")
			local flashlight = mod.gear_settings:attachment_unit(weapon_spawn_data.attachment_units_3p, "flashlight")
			
			local attachment_name = flashlight and unit_get_data(flashlight, "attachment_name")
			if flashlight then
				mod:preview_flashlight(true, self._world, flashlight, attachment_name, true)
			end


			local t = managers.time:time("main")
			local start_seed = self._auto_spin_random_seed
			if not start_seed then
				return 0, 0
			end
			local progress_speed = 0.3
			local progress_range = 0.3
			local progress = math_sin((start_seed + t) * progress_speed) * progress_range
			local auto_tilt_angle = -(progress * 0.5)
			local auto_turn_angle = -(progress * math_pi * 0.25)

			local start_angle = self._rotation_angle or 0
			local rotation = quaternion_axis_angle(vector3(0, auto_tilt_angle, 1), -(auto_turn_angle + start_angle))
			if link_unit then

				local initial_rotation = weapon_spawn_data.rotation and quaternion_unbox(weapon_spawn_data.rotation)

				if initial_rotation then
					rotation = quaternion_multiply(rotation, initial_rotation)
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
					-- mod:info("CLASS.UIWeaponSpawner: "..tostring(link_unit))
					unit_set_local_position(link_unit, 1, unit_local_position(link_unit, 1) + position)
				else
					-- mod:info("CLASS.UIWeaponSpawner: "..tostring(link_unit))
					unit_set_local_position(link_unit, 1, vector3_unbox(self._link_unit_base_position_backup))
				end

				if not self._link_unit_base_position then
					self._link_unit_base_position = vector3_box(unit_local_position(link_unit, 1))
				end

				if mod.link_unit_position then
					local position = vector3_unbox(mod.link_unit_position)
					-- mod:info("CLASS.UIWeaponSpawner: "..tostring(link_unit))
					unit_set_local_position(link_unit, 1, position)
				end

				self._link_unit_position = vector3_box(unit_local_position(link_unit, 1))
				self._last_item_name = item_name

				mod:set_light_positions(self)
			end
		end
	end

end)

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #############################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################################################

mod:hook(CLASS.UIWeaponSpawner, "init", function(func, self, reference_name, world, camera, unit_spawner, ...)

	-- Original function
	func(self, reference_name, world, camera, unit_spawner, ...)

	-- Custom
	self:_init_custom()

end)

mod:hook(CLASS.UIWeaponSpawner, "destroy", function(func, self, ...)
	
	-- Build animation
	mod.build_animation:set(false)

	-- Original function
	func(self, ...)

end)

mod:hook(CLASS.UIWeaponSpawner, "_mouse_rotation_input", function(func, self, input_service, dt, ...)

	-- Check if rotation is disabled
	if self:is_rotation_disabled() then
		-- Execute original function without input_service
		return func(self, nil, dt, ...)
	end

	-- Original function
	return func(self, input_service, dt, ...)

end)

mod:hook(CLASS.UIWeaponSpawner, "cb_on_unit_3p_streaming_complete", function(func, self, item_unit_3p, ...)

	-- Original function
	func(self, item_unit_3p, ...)

	-- Stream fix
	self:fix_streaming_without_mesh_streamer_2()

end)

mod:hook(CLASS.UIWeaponSpawner, "_despawn_weapon", function(func, self, ...)

	-- Unlink units
	self:unlink_units()

	-- Remove unit manipulation
	self:unit_manipulation_remove_all()

	-- Original function
	func(self, ...)
	
end)

mod:hook(CLASS.UIWeaponSpawner, "update", function(func, self, dt, t, input_service, ...)

	-- Fix streaming issues when mesh streamer is deactivated
	self:fix_streaming_without_mesh_streamer()

	-- Original function
	func(self, dt, t, input_service, ...)

	if self._reference_name ~= "WeaponIconUI" and mod.cosmetics_view and not self.demo then

		-- Update carousel
		self:update_carousel(dt, t)

		-- Update animations
		self:update_animation(dt, t)

	end

end)

mod:hook(CLASS.UIWeaponSpawner, "_spawn_weapon", function(func, self, item, link_unit_name, loader, position, rotation, scale, force_highest_mip, ...)

	-- Original function
	func(self, item, link_unit_name, loader, position, rotation, scale, force_highest_mip, ...)

	-- Spawn custom weapon
	self:spawn_weapon_custom()

end)