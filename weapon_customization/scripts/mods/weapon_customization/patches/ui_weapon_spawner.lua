local mod = get_mod("weapon_customization")

--#region Require
	-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #####################################################################################
	-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #####################################################################################
	-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #####################################################################################

    local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")
--#endregion

--#region Performance
	-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ########################################################################
	-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ########################################################################
	-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ########################################################################

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

--#region Data
	-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #############################################################################################
	-- #####  ││├─┤ │ ├─┤ #############################################################################################
	-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #############################################################################################

	local SLOT_SECONDARY = "slot_secondary"
    local WEAPON_PART_ANIMATION_TIME = .75
    local MOVE_DURATION_OUT = .5
	local MOVE_DURATION_IN = 1
    local RESET_WAIT_TIME = 5
	local SOUND_DURATION = .5
--#endregion

--#region Global Functions 
	-- ##### ┌─┐┬  ┌─┐┌┐ ┌─┐┬   ###########################################################################################
	-- ##### │ ┬│  │ │├┴┐├─┤│   ###########################################################################################
	-- ##### └─┘┴─┘└─┘└─┘┴ ┴┴─┘ ###########################################################################################

	-- Change light positions
	mod.set_light_positions = function(self)
		-- Get cosmetic view
		self:get_cosmetic_view()
		local preview_lights = self.preview_lights
		local cosmetics_view = self.cosmetics_view
		local weapon_spawner = cosmetics_view and cosmetics_view._weapon_preview._ui_weapon_spawner
		if preview_lights and cosmetics_view then
			for _, unit_data in pairs(preview_lights) do
				-- Get default position
				local default_position = vector3_unbox(unit_data.position)
				-- Get difference to link unit position
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
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

local function ease_out_elastic_custom(t)
	if t == 0 or t == 1 then return t end
	return 2^(-10 * t) * math_sin((t - 1.4 * 0.25) * (2 * math.pi) / 1.4) + 1
end

mod:hook(CLASS.UIUnitSpawner, "_world_delete_units", function(func, self, world, units_list, num_units, ...)
	-- Unlink units
	for i = 1, num_units do
		if unit_alive(units_list[i]) then
			world_unlink_unit(world, units_list[i])
		end
	end
	-- Original function
	func(self, world, units_list, num_units, ...)
end)

mod:hook_require("scripts/managers/ui/ui_weapon_spawner", function(instance)

	instance.get_cosmetic_view = function(self)
		self.cosmetics_view = self.cosmetics_view or mod:get_view("inventory_weapon_cosmetics_view")
	end

	instance.sync_set = function(self, name, value)
		self[name] = value
		mod[name] = self[name]
	end

	instance.preview_flashlight = function(self)
		if self._weapon_spawn_data then
			local unit_3p = self._weapon_spawn_data.item_unit_3p
			local attachment_units_3p = self._weapon_spawn_data.attachment_units_3p and self._weapon_spawn_data.attachment_units_3p[unit_3p]
			-- local flashlight = mod.gear_settings:attachment_unit(self._weapon_spawn_data.attachment_units_3p, "flashlight")
			local flashlight = mod.gear_settings:attachment_unit(attachment_units_3p, "flashlight")
			local attachment_name = flashlight and unit_get_data(flashlight, "attachment_name")
			if flashlight and attachment_name then
				mod:preview_flashlight(true, self._world, flashlight, attachment_name, true)
			end
		end
	end

	-- ┌┬┐┌─┐┌┬┐┌┬┐┬┌┐┌┌─┐  ┌┬┐┌─┐┌─┐┬  ┌─┐
	-- ││││ │ ││ │││││││ ┬   │ │ ││ ││  └─┐
	-- ┴ ┴└─┘─┴┘─┴┘┴┘└┘└─┘   ┴ └─┘└─┘┴─┘└─┘

	instance.get_modding_tools = function(self)
		self.modding_tools = self.modding_tools or get_mod("modding_tools")
	end

	instance.unit_manipulation_busy = function(self)
		self:get_modding_tools()
		if self.modding_tools then return self.modding_tools:unit_manipulation_busy() end
	end

	instance.unit_manipulation_remove = function(self, unit)
		self:get_modding_tools()
		if self.modding_tools then self.modding_tools:unit_manipulation_remove(unit) end
	end

	instance.toggle_modding_tools = function(self, value)
		self._modding_tool_toggled_on = value or not self._modding_tool_toggled_on
	end

	instance.unit_manipulation_remove_all = function(self)
		self:get_modding_tools()
		local weapon_spawn_data = self._weapon_spawn_data
		if weapon_spawn_data then
			self:unit_manipulation_remove(weapon_spawn_data.item_unit_3p)
			local unit_3p = weapon_spawn_data.item_unit_3p
			local attachment_units_3p = weapon_spawn_data.attachment_units_3p and weapon_spawn_data.attachment_units_3p[unit_3p]
			-- for _, unit in pairs(weapon_spawn_data.attachment_units_3p) do
			for _, unit in pairs(attachment_units_3p) do
				self:unit_manipulation_remove(unit)
			end
		end
	end

	-- ┌─┐┌─┐┌┬┐┌─┐┬─┐┌─┐  ┌┬┐┌─┐┬  ┬┌─┐┌┬┐┌─┐┌┐┌┌┬┐
	-- │  ├─┤│││├┤ ├┬┘├─┤  ││││ │└┐┌┘├┤ │││├┤ │││ │ 
	-- └─┘┴ ┴┴ ┴└─┘┴└─┴ ┴  ┴ ┴└─┘ └┘ └─┘┴ ┴└─┘┘└┘ ┴ 

	instance.initiate_camera_movement = function(self, position)
		if position and not vector3.equal(vector3_unbox(self.move_position), vector3_unbox(position)) then
			self.move_position:store(vector3_unbox(position))
			mod.move_position = self.move_position
			self:sync_set("do_move", true)
		elseif not position and not vector3.equal(vector3_unbox(self.move_position), vector3_zero()) then
			self.move_position:store(vector3_zero())
			mod.move_position = self.move_position
			self:sync_set("do_move", true)
		end
	end

	instance.play_zoom_sound = function(self, t, sound)
		if self.cosmetics_view and not self.sound_end or t >= self.sound_end then
			self.sound_end = t + SOUND_DURATION
			self.cosmetics_view:_play_sound(sound)
		end
	end

	instance.update_camera_movement = function(self, dt, t)
		-- Current position
		local position = self._link_unit_position and vector3_unbox(self._link_unit_position) or vector3_zero()
		-- Camera movement
		if self.do_move and mod:get("mod_option_camera_zoom") then
			if not vector3.equal(vector3_unbox(self.move_position), vector3_zero()) then
				-- Set new position
				self.new_position:store(vector3_unbox(self._link_unit_base_position) + vector3_unbox(self.move_position))
				mod.new_position = self.new_position
				-- Set other
				self:sync_set("move_end", t + MOVE_DURATION_IN)
				self:sync_set("current_move_duration", MOVE_DURATION_IN)
				self:sync_set("last_move_position", self.move_position)
				-- Play sound
				self:play_zoom_sound(t, UISoundEvents.apparel_zoom_in)

			elseif not vector3.equal(vector3_unbox(self.move_position), vector3_unbox(self._link_unit_base_position)) then
				-- Set new position
				self.new_position:store(vector3_unbox(self._link_unit_base_position))
				mod.new_position = self.new_position
				-- Set other
				self:sync_set("move_end", t + MOVE_DURATION_OUT)
				self:sync_set("current_move_duration", MOVE_DURATION_OUT)
				-- Set last position
				self.last_move_position:store(vector3_zero())
				mod.last_move_position = self.last_move_position
				-- Play sound
				self:play_zoom_sound(t, UISoundEvents.apparel_zoom_out)
			end

			self:sync_set("do_move", nil)

			self.do_reset = nil
			self.reset_start = nil

		elseif mod.build_animation:is_busy() then
			if self.move_end then
				self:sync_set("move_end", self.move_end + dt)
			end

		elseif self.move_end and t <= self.move_end then
			local lerp_position = vector3_lerp(position, vector3_unbox(self.new_position), math_easeInCubic(1 - ((self.move_end - t) / self.current_move_duration)))
			-- Check link unit
			if self._weapon_spawn_data.link_unit and unit_alive(self._weapon_spawn_data.link_unit) then
				-- Set link unit position
				unit_set_local_position(self._weapon_spawn_data.link_unit, 1, lerp_position)
			end
			-- Set new link unit position
			self._link_unit_position:store(lerp_position)
			mod._link_unit_position = self._link_unit_position

		elseif self.move_end and t > self.move_end then
			self:sync_set("move_end", nil)
			-- Check link unit
			if self._weapon_spawn_data.link_unit and unit_alive(self._weapon_spawn_data.link_unit) then
				-- Set link unit position
				unit_set_local_position(self._weapon_spawn_data.link_unit, 1, vector3_unbox(self.new_position))
			end
			-- Set new link unit position
			self._link_unit_position:store(vector3_unbox(self.new_position))
			mod._link_unit_position = self._link_unit_position

			if self.current_move_duration == MOVE_DURATION_IN and not mod:vector3_equal(vector3_unbox(self.new_position), vector3_zero()) then
				self.do_reset = true
			end

		end
	end

	-- ┌─┐┌─┐┌┬┐┌─┐┬─┐┌─┐  ┌─┐┌─┐┌─┐┌┬┐
	-- │  ├─┤│││├┤ ├┬┘├─┤  ┌─┘│ ││ ││││
	-- └─┘┴ ┴┴ ┴└─┘┴└─┴ ┴  └─┘└─┘└─┘┴ ┴

	instance.init_custom_weapon_zoom = function(self)
		local item = self._weapon_spawn_data and self._weapon_spawn_data.item
		item = item or self._loading_weapon_data and self._loading_weapon_data.item
		if item then
			-- Get item name
			local item_name = mod.gear_settings:short_name(item.name)
			-- Check for weapon in data
			if mod.attachment_models[item_name] then
				-- Check for custom weapon zoom
				if mod.attachment_models[item_name].customization_min_zoom then
					self._min_zoom = mod.attachment_models[item_name].customization_min_zoom
				else
					self._min_zoom = -2
				end
				-- Set zoom
				self._weapon_zoom_target = self._min_zoom
				self._weapon_zoom_fraction = self._min_zoom
				self:_set_weapon_zoom(self._min_zoom)
			end
		end
	end

	-- ┌─┐┌─┐┌┬┐┬ ┬┌─┐
	-- └─┐├┤  │ │ │├─┘
	-- └─┘└─┘ ┴ └─┘┴  

	instance.custom_init = function(self)
		if self._reference_name ~= "WeaponIconUI" then
			self.use_carousel = mod:get("mod_option_carousel")
			-- Setup Movement
			self:sync_set("do_move", mod.do_move)
			self:sync_set("move_end", mod.move_end)
			self:sync_set("current_move_duration", mod.current_move_duration or MOVE_DURATION_IN)
			self:sync_set("last_move_position", mod.last_move_position or vector3_box(vector3_zero()))
			self:sync_set("move_position", mod.move_position or vector3_box(vector3_zero()))
			self:sync_set("new_position", mod.new_position or vector3_box(vector3_zero()))
			self:sync_set("_link_unit_position", mod._link_unit_position or vector3_box(vector3_zero()))
			-- Setup Rotation
			self:sync_set("do_rotation", mod.do_rotation)
			self:sync_set("_rotation_angle", mod._rotation_angle or 0)
			self:sync_set("_target_rotation_angle", mod._target_rotation_angle or self._rotation_angle)
			self:sync_set("_last_rotation_angle", mod._last_rotation_angle or self._rotation_angle)
			self:sync_set("is_doing_rotation", mod.is_doing_rotation)
			self:sync_set("_default_rotation_angle", self._last_rotation_angle or 0)
			self:sync_set("start_rotation", mod.start_rotation)
			self:sync_set("rotation_time", mod.rotation_time)
			-- Get cosmetic view
			self:get_cosmetic_view()
			-- Build animation extension
			-- if mod.cosmetics_view then
			if self.cosmetics_view then
				mod.build_animation:set({
					ui_weapon_spawner = self,
					world = self._world,
					item = self.cosmetics_view._presentation_item,
				}, true)
			end
			self:init_custom_weapon_zoom()
		end
	end

	-- ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌  ┬─┐┌─┐┌┬┐┌─┐┌┬┐┬┌─┐┌┐┌
	-- │││├┤ ├─┤├─┘│ ││││  ├┬┘│ │ │ ├─┤ │ ││ ││││
	-- └┴┘└─┘┴ ┴┴  └─┘┘└┘  ┴└─└─┘ ┴ ┴ ┴ ┴ ┴└─┘┘└┘

	instance.stop_rotation = function(self)
		self:sync_set("do_rotation", nil)
		self:sync_set("start_rotation", nil)
		self:sync_set("is_doing_rotation", nil)
	end

	instance.is_rotation_disabled = function(self)
		return not self.is_doing_rotation and (self:unit_manipulation_busy() or self._rotation_input_disabled or mod.dropdown_open)
	end

	instance.initiate_weapon_rotation = function(self, new_angle, length)
		if not self.is_doing_rotation or (new_angle and new_angle ~= self._target_rotation_angle) then
			self:sync_set("_last_rotation_angle", self._rotation_angle)
			if new_angle and self._target_rotation_angle ~= new_angle then
				self:sync_set("_target_rotation_angle", new_angle)
				self:sync_set("do_rotation", true)
			elseif not new_angle and self._target_rotation_angle ~= 0 then
				self:sync_set("_target_rotation_angle", 0)
				self:sync_set("do_rotation", true)
			end
			self:sync_set("rotation_time", length or 1)
		end
	end

	instance.update_weapon_rotation = function(self, dt, t)
		if self.do_rotation then
			self:sync_set("is_doing_rotation", true)
			self:sync_set("do_rotation", nil)
			self:sync_set("start_rotation", t)

		elseif mod.build_animation:is_busy() then
			if self.start_rotation then
				self:sync_set("start_rotation", self.start_rotation + dt)
			end

		elseif self.start_rotation and t < self.start_rotation + self.rotation_time then
			local progress = (t - self.start_rotation) / self.rotation_time
			local anim_progress = ease_out_elastic_custom(progress)
			self:sync_set("_rotation_angle", math.lerp(self._last_rotation_angle, self._target_rotation_angle, anim_progress))

		elseif self.start_rotation and t > self.start_rotation + self.rotation_time then
			self:sync_set("_rotation_angle", self._target_rotation_angle)
			self:sync_set("start_rotation", nil)
			self:sync_set("is_doing_rotation", nil)
		end
	end

	-- ┌─┐┬  ┌─┐┌─┐┌┐┌┬ ┬┌─┐
	-- │  │  ├┤ ├─┤││││ │├─┘
	-- └─┘┴─┘└─┘┴ ┴┘└┘└─┘┴  

	instance.unlink_units = function(self)
		local weapon_spawn_data = self._weapon_spawn_data
		local world = self._unit_spawner._world
		if weapon_spawn_data then
			local unit_3p = weapon_spawn_data.item_unit_3p
			local attachment_units_3p = weapon_spawn_data.attachment_units_3p and weapon_spawn_data.attachment_units_3p[unit_3p]
			-- for i = #weapon_spawn_data.attachment_units_3p, 1, -1 do
			-- 	if weapon_spawn_data.attachment_units_3p[i] and unit_alive(weapon_spawn_data.attachment_units_3p[i]) then
			-- 		world_unlink_unit(world, weapon_spawn_data.attachment_units_3p[i])
			-- 	end
			-- end
			for i = #attachment_units_3p, 1, -1 do
				if attachment_units_3p[i] and unit_alive(attachment_units_3p[i]) then
					world_unlink_unit(world, attachment_units_3p[i])
				end
			end
			if weapon_spawn_data.item_unit_3p and unit_alive(weapon_spawn_data.item_unit_3p) then
				world_unlink_unit(world, weapon_spawn_data.item_unit_3p)
			end
		end
	end

	-- ┌─┐┌─┐┬─┐┌─┐┬ ┬┌─┐┌─┐┬  
	-- │  ├─┤├┬┘│ ││ │└─┐├┤ │  
	-- └─┘┴ ┴┴└─└─┘└─┘└─┘└─┘┴─┘

	instance.update_carousel = function(self, dt, t)
		if self.use_carousel then
			-- Get cosmetic view
			self:get_cosmetic_view()
			local cosmetics_view = self.cosmetics_view
			if cosmetics_view then
				cosmetics_view:try_spawning_previews()
				cosmetics_view:update_attachment_previews(dt, t)
			end
		end
	end

	-- ┌─┐┌─┐┌─┐┬ ┬┌┐┌  ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌
	-- └─┐├─┘├─┤││││││  │││├┤ ├─┤├─┘│ ││││
	-- └─┘┴  ┴ ┴└┴┘┘└┘  └┴┘└─┘┴ ┴┴  └─┘┘└┘

	instance.spawn_weapon_custom = function(self)
		if self._weapon_spawn_data then
			self.weapon_spawning = true
			-- Get item name
			local item_name = mod.gear_settings:short_name(self._weapon_spawn_data.item.name)
			-- Hide Bullets
			mod.gear_settings:hide_bullets(self._weapon_spawn_data.attachment_units_3p)
			-- Set Flashlight
			self:preview_flashlight()
			-- Set Rotation
			local progress = math_sin(((self._auto_spin_random_seed or 0) + managers.time:time("main")) * 0.3) * 0.3
			local auto_tilt_angle = -(progress * 0.5)
			local auto_turn_angle = -(progress * math_pi * 0.25)
			-- Set Rotation
			local rotation = quaternion_axis_angle(vector3(0, auto_tilt_angle, 1), -(auto_turn_angle + (self._rotation_angle or 0)))
			-- Check link unit
			if self._weapon_spawn_data.link_unit then
				-- Get initial rotation
				local initial_rotation = self._weapon_spawn_data.rotation and quaternion_unbox(self._weapon_spawn_data.rotation)
				-- Apply initial rotation
				if initial_rotation then
					rotation = quaternion_multiply(rotation, initial_rotation)
				end
				-- Set weapon rotation
				unit_set_local_rotation(self._weapon_spawn_data.link_unit, 1, rotation)
				-- Backup base position
				if not self._link_unit_base_position_backup then
					self._link_unit_base_position_backup = vector3_box(unit_local_position(self._weapon_spawn_data.link_unit, 1))
				end
				-- Reset position
				if self._last_item_name and self._last_item_name ~= item_name then
					self.do_reset = nil
					self.reset_start = nil
					self:sync_set("move_end", nil)
					self:sync_set("do_move", nil)
					self.last_move_position:store(vector3_zero())
					mod.last_move_position = self.last_move_position
					self.move_position:store(vector3_zero())
					mod.move_position = self.move_position
				end
				if mod.attachment_models[item_name] and mod.attachment_models[item_name].customization_default_position then
					unit_set_local_position(self._weapon_spawn_data.link_unit, 1, unit_local_position(self._weapon_spawn_data.link_unit, 1)
						+ vector3_unbox(mod.attachment_models[item_name].customization_default_position))
				else
					unit_set_local_position(self._weapon_spawn_data.link_unit, 1, vector3_unbox(self._link_unit_base_position_backup))
				end
				if not self._link_unit_base_position then
					self._link_unit_base_position = vector3_box(unit_local_position(self._weapon_spawn_data.link_unit, 1))
				end
				if not vector3.equal(vector3_unbox(self._link_unit_position), vector3_zero()) then
					unit_set_local_position(self._weapon_spawn_data.link_unit, 1, vector3_unbox(self._link_unit_position))
				end
				self._link_unit_position:store(unit_local_position(self._weapon_spawn_data.link_unit, 1))
				mod._link_unit_position = self._link_unit_position
				self._last_item_name = item_name
				mod:set_light_positions(self)
			end
		end
	end

end)

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #########################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #########################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #########################################################################

mod:hook(CLASS.UIWeaponSpawner, "init", function(func, self, reference_name, world, camera, unit_spawner, ...)

	-- Get cosmetic view
	self:get_cosmetic_view()

	-- Original function
	func(self, reference_name, world, camera, unit_spawner, ...)

	-- Custom init
	self:custom_init()

end)

mod:hook(CLASS.UIWeaponSpawner, "destroy", function(func, self, ...)

	-- Build animation
	mod.build_animation:set(false)

	-- Original function
	func(self, ...)

end)

mod:hook(CLASS.UIWeaponSpawner, "_mouse_rotation_input", function(func, self, input_service, dt, ...)

	if input_service and input_service:get("left_pressed") then
		self:stop_rotation()
	end

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
	if self._weapon_spawn_data then
		-- Weapon not spawning anymore
		self.weapon_spawning = nil
		-- Set streaming complete
		self._weapon_spawn_data.streaming_complete = true
	end

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
	if self._weapon_spawn_data and not self._weapon_spawn_data.visible then
		self:cb_on_unit_3p_streaming_complete(self._weapon_spawn_data.item_unit_3p)
	end

	-- Original function
	func(self, dt, t, input_service, ...)

	if self._reference_name ~= "WeaponIconUI" then
		-- Update carousel
		self:update_carousel(dt, t)
		-- Update rotation
		self:update_weapon_rotation(dt, t)
		-- Check if weapon is spawned
		if self._weapon_spawn_data then
			-- Update animations
			self:update_camera_movement(dt, t)
			-- Set light positions
			mod:set_light_positions(self)
			-- Weapon part animations
			mod.build_animation:update(dt, t)
		end
	end
end)

mod:hook(CLASS.UIWeaponSpawner, "_spawn_weapon", function(func, self, item, link_unit_name, loader, position, rotation, scale, force_highest_mip, ...)

	-- Original function
	func(self, item, link_unit_name, loader, position, rotation, scale, force_highest_mip, ...)

	if self._reference_name ~= "WeaponIconUI" then
		-- Spawn custom weapon
		self:spawn_weapon_custom()
	end

end)