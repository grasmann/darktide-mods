local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
	local ScriptCamera = mod:original_require("scripts/foundation/utilities/script_camera")
	local Crouch = mod:original_require("scripts/extension_systems/character_state_machine/character_states/utilities/crouch")
	local Recoil = mod:original_require("scripts/utilities/recoil")
	local Sway = mod:original_require("scripts/utilities/sway")
	local Spread = mod:original_require("scripts/utilities/spread")
	local ScriptViewport = mod:original_require("scripts/foundation/utilities/script_viewport")
	local ScriptWorld = mod:original_require("scripts/foundation/utilities/script_world")
	local RecoilTemplate = mod:original_require("scripts/settings/equipment/recoil_templates")
	local WieldableSlotScripts = mod:original_require("scripts/extension_systems/visual_loadout/utilities/wieldable_slot_scripts")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
	local Unit = Unit
	local math = math
	local type = type
	local Mesh = Mesh
	local table = table
	local World = World
	local pairs = pairs
	local CLASS = CLASS
	local class = class
	local unpack = unpack
	local Camera = Camera
	local vector3 = Vector3
	local math_rad = math.rad
	local managers = Managers
	local Viewport = Viewport
	local Matrix4x4 = Matrix4x4
	local math_lerp = math.lerp
	local unit_mesh = Unit.mesh
	local Quaternion = Quaternion
	local unit_alive = Unit.alive
	local math_clamp = math.clamp
	local vector3_box = Vector3Box
	local script_unit = ScriptUnit
	local vector3_zero = vector3.zero
	local vector3_lerp = vector3.lerp
	local math_clamp01 = math.clamp01
	local unit_get_data = Unit.get_data
	local table_contains = table.contains
	local unit_num_meshes = Unit.num_meshes
	local vector3_unbox = vector3_box.unbox
	local unit_local_scale = Unit.local_scale
	local math_easeInCubic = math.easeInCubic
	local quaternion_unbox = QuaternionBox.unbox
	local quaternion_forward = Quaternion.forward
	local ShadingEnvironment = ShadingEnvironment
	local mesh_local_position = Mesh.local_position
	local mesh_local_rotation = Mesh.local_rotation
	local matrix4x4_transform = Matrix4x4.transform
	local camera_vertical_fov = Camera.vertical_fov
	local unit_world_position = Unit.world_position
	local unit_world_rotation = Unit.world_rotation
	local unit_local_position = Unit.local_position
	local unit_local_rotation = Unit.local_rotation
	local unit_animation_event = Unit.animation_event
	local quaternion_matrix4x4 = Quaternion.matrix4x4
	local unit_set_local_scale = Unit.set_local_scale
	local unit_get_child_units = Unit.get_child_units
	local camera_world_position = Camera.world_position
	local script_unit_extension = script_unit.extension
	local world_create_particles = World.create_particles
	local mesh_set_local_position = Mesh.set_local_position
	local camera_set_vertical_fov = Camera.set_vertical_fov
	local unit_set_local_position = Unit.set_local_position
	local unit_set_local_rotation = Unit.set_local_rotation
	local world_destroy_particles = World.destroy_particles
	local unit_set_unit_visibility = Unit.set_unit_visibility
	local unit_has_animation_event = Unit.has_animation_event
	local script_unit_has_extension = script_unit.has_extension
	local camera_custom_vertical_fov = Camera.custom_vertical_fov
	local unit_set_scalar_for_materials = Unit.set_scalar_for_materials
	local world_stop_spawning_particles = World.stop_spawning_particles
	local shading_environment_set_scalar = ShadingEnvironment.set_scalar
	local camera_set_custom_vertical_fov = Camera.set_custom_vertical_fov
	local world_update_unit_and_children = World.update_unit_and_children
	local quaternion_to_euler_angles_xyz = Quaternion.to_euler_angles_xyz
	local quaternion_from_euler_angles_xyz = Quaternion.from_euler_angles_xyz
	local unit_set_shader_pass_flag_for_meshes = Unit.set_shader_pass_flag_for_meshes
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local REFERENCE = "weapon_customization"
	local EFFECT = "content/fx/particles/screenspace/screen_ogryn_dash"
	local SOUND = "wwise/events/weapon/play_lasgun_p3_mag_button"
	local SIGHT = "sight_2"
	local LENS_A = "lens"
	local LENS_B = "lens_2"
	local SCOPE_OFFSET = "scope_offset"
	local NO_SCOPE_OFFSET = "no_scope_offset"
	local SLOT_SECONDARY = "slot_secondary"
	local SLOT_UNARMED = "slot_unarmed"
	local reticle_multiplier = .5
	local MIN_TRANSPARENCY = .15
	local sight_fallback = {position = vector3_box(vector3_zero())}
--#endregion

-- ##### ┌─┐┬┌─┐┬ ┬┌┬┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ #################################################################
-- ##### └─┐││ ┬├─┤ │ └─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ #################################################################
-- ##### └─┘┴└─┘┴ ┴ ┴ └─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ #################################################################

local SightExtension = class("SightExtension", "WeaponCustomizationExtension")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

SightExtension.init = function(self, extension_init_context, unit, extension_init_data)
	SightExtension.super.init(self, extension_init_context, unit, extension_init_data)

	self.wielded_slot = extension_init_data.wielded_slot or SLOT_UNARMED
	self.ranged_weapon = extension_init_data.ranged_weapon
	self.gear_id = mod.gear_settings:item_to_gear_id(self.ranged_weapon.item)
	self.equipment_component = extension_init_data.equipment_component
	self.equipment = extension_init_data.equipment
	self.is_starting_aim = nil
	self._is_aiming = nil
	self._is_unaiming = nil
	self.scope_detached = false
	self.aim_timer = nil
	self.position_offset = vector3_box(vector3_zero())
	self.rotation_offset = vector3_box(vector3_zero())
	self.default_vertical_fov = nil
	self.vertical_fov = nil
	self.default_custom_vertical_fov = nil
	self.custom_vertical_fov = nil
	self.offset = nil
	self.sights = {}
	self.lenses = {}
	self.lens_scales = {
		vector3_box(vector3_zero()),
		vector3_box(vector3_zero()),
	}
	self.default_reticle_position = vector3_box(vector3_zero())
	self.lens_transparency = MIN_TRANSPARENCY
	self.first_person_component = self.unit_data:read_component("first_person")

	managers.event:register(self, "weapon_customization_settings_changed", "on_settings_changed")
	managers.event:register(self, "weapon_customization_update_zoom", "update_zoom")

	self:on_settings_changed()
	self:set_weapon_values()
	
	self.initialized = true
end

SightExtension.delete = function(self)
	managers.event:unregister(self, "weapon_customization_settings_changed")
	managers.event:unregister(self, "weapon_customization_update_zoom")
	self.initialized = false
	self.offset = vector3_zero()
	SightExtension.super.delete(self)
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

SightExtension.is_braced = function(self)
	-- Check cache
	if self._is_braced == nil then
		-- Get value
		local template = self.ranged_weapon.weapon_template
		local alt_fire = template and template.alternate_fire_settings
		self._is_braced = alt_fire and alt_fire.start_anim_event == "to_braced"
	end
	-- Return cache
	return self._is_braced
end

SightExtension.crosshair = function(self, crosshair_type)
	if self:is_hiding_crosshair() then
		return "ironsight"
	end
	-- if crosshair_type == "ironsight" then
	-- 	local template = self.ranged_weapon.weapon_template
	-- 	return template.crosshair.crosshair_type
	-- end
	return crosshair_type
end

SightExtension.is_hiding_crosshair = function(self)
	-- Get value
	local laser = self.deactivate_crosshair_laser and mod:execute_extension(self.player_unit, "laser_pointer_system", "is_active")
	local sniper_or_scope = self:is_sniper() or self:is_scope()
	local aiming = self.deactivate_crosshair_aiming and self._is_aiming and sniper_or_scope
	self._is_hiding_crosshair = (laser or aiming) and self:get_first_person()
	-- Return
	return self._is_hiding_crosshair
end

SightExtension.is_aiming = function(self)
	return self.alternate_fire_component and self.alternate_fire_component.is_active
end

SightExtension.is_scope = function(self)
	-- Check cache
	if self._is_scope == nil then
		-- Get value
		self._is_scope = table_contains(mod.reflex_sights, self.sight_name)
	end
	-- Return cache
	return self._is_scope
end

SightExtension.is_sight = function(self)
	return not self:is_scope() and not self:is_sniper()
end

SightExtension.is_sniper = function(self)
	-- Check cache
	if self._is_sniper == nil then
		-- Get value
		self._is_sniper = table_contains(mod.scopes, self.sight_name) and not self:is_braced()
	end
	-- Return cache
	return self._is_sniper
end

SightExtension.is_sniper_or_scope = function(self)
	return self:is_scope() or self:is_sniper()
end

SightExtension.is_wielded = function(self)
	return self.wielded_slot and self.wielded_slot.name == SLOT_SECONDARY
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

SightExtension.set_spectated = function(self, spectated)
	self.spectated = spectated
end

SightExtension.set_aiming = function(self, aiming, t)
	if aiming and not self._is_aiming then
		self:on_aim_start(t)
	elseif not aiming and self._is_aiming then
		self:on_aim_stop(t)
	end
end

SightExtension.set_lens_scales = function(self)
	local lens_2 = mod.gear_settings:apply_fixes(self.ranged_weapon.item, "lens_2")
	local lens = mod.gear_settings:apply_fixes(self.ranged_weapon.item, "lens")
	self.lens_scales[1]:store(lens_2 and lens_2.scale and vector3_unbox(lens_2.scale) or vector3_zero())
	self.lens_scales[2]:store(lens and lens.scale and vector3_unbox(lens.scale) or vector3_zero())
end

SightExtension.set_weapon_values = function(self)
	self.is_starting_aim = nil
	self._is_aiming = nil
	self.aim_timer = nil
	self.default_vertical_fov = nil
	self.vertical_fov = nil
	self.default_custom_vertical_fov = nil
	self.custom_vertical_fov = nil
	self.item_name = mod.gear_settings:short_name(self.ranged_weapon.item.name)
	self.sights = {
		mod.gear_settings:_recursive_find_attachment(self.ranged_weapon.item.attachments, "sight"),
		mod.gear_settings:_recursive_find_attachment(self.ranged_weapon.item.attachments, "sight_2"),
	}
	-- self:set_lens_units()
	-- self.sight_unit = mod:get_attachment_slot_in_attachments(self.ranged_weapon.attachment_units, "sight_3")
	--     or mod:get_attachment_slot_in_attachments(self.ranged_weapon.attachment_units, "sight_2")
	--     or mod:get_attachment_slot_in_attachments(self.ranged_weapon.attachment_units, "sight")
	self.sight_unit = mod.gear_settings:attachment_unit(self.ranged_weapon.attachment_units, "sight_3")
	    or mod.gear_settings:attachment_unit(self.ranged_weapon.attachment_units, "sight_2")
	    or mod.gear_settings:attachment_unit(self.ranged_weapon.attachment_units, "sight")
	if self.sight_unit and unit_alive(self.sight_unit) then
		unit_set_shader_pass_flag_for_meshes(self.sight_unit, "one_bit_alpha", true, true)
	end
	self.sight = self.sights[2] or self.sights[1] --self:get_sight()
	self.sight_name = self.sights[1] and mod.gear_settings:short_name(self.sights[1].item)
	self.offset = nil
	if self:is_scope() or self:is_sniper() then
		self:set_sight_offset()
	elseif self:is_sight() then
		self:set_sight_offset(NO_SCOPE_OFFSET)
	end
	self.sniper_zoom = nil
	if self:is_sniper() then
		-- self.camera_manager = managers.state.camera
		self.sniper_zoom = mod.sniper_zoom_levels[self.sight_name] or 7
		self:set_sniper_scope_unit()
		self.lenses = {
			mod.gear_settings:_recursive_find_attachment(self.ranged_weapon.item.attachments, "lens"),
			mod.gear_settings:_recursive_find_attachment(self.ranged_weapon.item.attachments, "lens_2"),
		}
		self:set_lens_units()
	end
	self:set_lens_scales()
	self.start_time = self.ranged_weapon.weapon_template.actions.action_zoom
		and self.ranged_weapon.weapon_template.actions.action_zoom.total_time
		or self.ranged_weapon.weapon_template.actions.action_wield.total_time
	self.reset_time = self.ranged_weapon.weapon_template.actions.action_unzoom 
		and self.ranged_weapon.weapon_template.actions.action_unzoom.total_time
		or self.ranged_weapon.weapon_template.actions.action_wield.total_time
end

SightExtension.set_sight_offset = function(self, offset_type)
	local offset_type = offset_type or SCOPE_OFFSET
	local anchor = mod.anchors[self.ranged_weapon.weapon_template.name]
	local sight_offset = anchor and anchor[offset_type]
	self.offset = mod.gear_settings:apply_fixes(self.ranged_weapon.item, offset_type) or sight_offset or sight_fallback --or {position = vector3_box(vector3_zero())}
end

SightExtension.set_sniper_scope_unit = function(self)
	if self.ranged_weapon.attachment_units then
		-- self.sniper_scope_unit = mod:get_attachment_slot_in_attachments(self.ranged_weapon.attachment_units, "sight")
		self.sniper_scope_unit = mod.gear_settings:attachment_unit(self.ranged_weapon.attachment_units, "sight")
		self.sniper_sight_data  = mod.gear_settings:apply_fixes(self.ranged_weapon.item, "sight")
	end
end

SightExtension.set_lens_units = function(self)
	local reflex = {}
	-- table.clear(reflex)
	-- mod:_recursive_find_unit_by_slot(self.ranged_weapon.weapon_unit, SIGHT, reflex)
	reflex[1] = mod.gear_settings:attachment_unit(self.ranged_weapon.attachment_units, SIGHT)
	if #reflex >= 1 then
		local lenses = {}
		-- table.clear(lenses)
		-- mod:_recursive_find_unit_by_slot(self.ranged_weapon.weapon_unit, LENS_A, lenses)
		-- mod:_recursive_find_unit_by_slot(self.ranged_weapon.weapon_unit, LENS_B, lenses)
		lenses[1] = mod.gear_settings:attachment_unit(self.ranged_weapon.attachment_units, LENS_A)
		lenses[2] = mod.gear_settings:attachment_unit(self.ranged_weapon.attachment_units, LENS_B)
		if #lenses >= 2 then
			local scope_sight = mod.gear_settings:apply_fixes(self.ranged_weapon.item, "sight_2")
			self.lens_mesh = unit_get_data(lenses[1], "lens_mesh") or 1
			self.default_reticle_position:store(mesh_local_position(unit_mesh(reflex[1], self.lens_mesh)))
			if unit_get_data(lenses[1], "lens") == 2 then
				self.lens_units = {lenses[1], lenses[2], reflex[1]}
			else
				self.lens_units = {lenses[2], lenses[1], reflex[1]}
			end
			unit_set_unit_visibility(reflex[1], false)
			if self.offset.lense_transparency then
				unit_set_shader_pass_flag_for_meshes(lenses[1], "one_bit_alpha", true, true)
				unit_set_shader_pass_flag_for_meshes(lenses[2], "one_bit_alpha", true, true)
			end
		end
	end
end

SightExtension.set_default_fov = function(self, default_vertical_fov, default_custom_vertical_fov)
	if not self.default_vertical_fov then self.default_vertical_fov = default_vertical_fov end
	if not self.default_custom_vertical_fov then self.default_custom_vertical_fov = default_custom_vertical_fov end
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

SightExtension.on_aim_start = function(self, t)
	if self:is_wielded() then
		self._is_hiding_crosshair = nil
		self.is_starting_aim = true
		self._is_aiming = true
		self.aim_timer = t + self.start_time
		if self.sniper_zoom and self.lens_units then
			if self.lens_units[1] and unit_alive(self.lens_units[1]) and self.fx_extension and self.sniper_sound then
				self.fx_extension:trigger_wwise_event(SOUND, false, self.lens_units[1], 1)
			end
		end
	end
end

SightExtension.on_equip_slot = function(self, slot)
	self._is_aiming = nil
	self._is_scope = nil
	self._is_sniper = nil
	self._is_braced = nil
end

SightExtension.on_wield_slot = function(self, slot)
	self._is_braced = nil
	self._is_scope = nil
	self._is_sniper = nil
	self.wielded_slot = slot
	if self._is_aiming then
		self._is_aiming = nil
		self.aim_timer = mod:game_time() + self.reset_time
	end
end

SightExtension.on_aim_stop = function(self, t)
	if self:is_wielded() and (self._is_aiming or self.is_starting_aim) then
		self._is_hiding_crosshair = nil
		self.is_starting_aim = nil
		self._is_aiming = nil
		self.aim_timer = t + self.reset_time
		self:destroy_particle_effect()
	end
end

SightExtension.on_unaim_start = function(self, t)
	if self:is_wielded() and (self._is_aiming or self.is_starting_aim) then
		self._is_hiding_crosshair = nil
		self.is_starting_aim = nil
		self._is_aiming = nil
		self._is_unaiming = true
		self.aim_timer = t + self.reset_time
	end
end

SightExtension.on_settings_changed = function(self)
	self.reticle_size = mod:get("mod_option_scopes_reticle_size")
	self.sniper_sound = mod:get("mod_option_scopes_sound")
	self.sniper_effect = mod:get("mod_option_scopes_particle")
	self.deactivate_crosshair_laser = mod:get("mod_option_deactivate_crosshair_laser")
	self.deactivate_crosshair_aiming = mod:get("mod_option_deactivate_crosshair_aiming")
	self.weapon_dof = mod:get("mod_option_misc_weapon_dof")
	self.lense_transparency_target = mod:get("mod_option_scopes_lens_transparency")
	self.hide_reticle = mod:get("mod_option_scopes_hide_when_not_aiming")
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

SightExtension.update = function(self, unit, dt, t)
	if self.initialized then

		if self.sniper_zoom and self.lens_units and self.lens_units[3] and unit_alive(self.lens_units[3]) and self.default_reticle_position
				and not self.is_starting_aim and not self._is_aiming then
			local default_offset = vector3_unbox(self.default_reticle_position)
			mesh_set_local_position(unit_mesh(self.lens_units[3], self.lens_mesh), self.lens_units[3], default_offset)
		end

		if self.is_starting_aim or self._is_starting_inspect then
			if self.aim_timer and t <= self.aim_timer then
				local time_in_action = math_clamp01(self.start_time - (self.aim_timer - t))
				local progress = time_in_action / self.start_time
				local anim_progress = math.ease_sine(progress)
				if self.sniper_zoom then

					self.lens_transparency = math_lerp(MIN_TRANSPARENCY, self.lense_transparency_target, anim_progress)

					if self.sniper_scope_unit and unit_alive(self.sniper_scope_unit) then
						-- local sight = mod.gear_settings:apply_fixes(self.ranged_weapon.item, "sight")
						local scale_default = self.sniper_sight_data and self.sniper_sight_data.scale
							and vector3_unbox(self.sniper_sight_data.scale) or vector3(1, 1, 1)
						local aim_scale = self.offset.aim_scale or .5
						local apply_scale = vector3_lerp(scale_default, vector3(scale_default[1], aim_scale, scale_default[3]), anim_progress)
						unit_set_local_scale(self.sniper_scope_unit, 1, apply_scale)
					end

					if self.default_vertical_fov and self.default_custom_vertical_fov then
						local custom_fov = self.offset.custom_fov and math_rad(self.offset.custom_fov) or math_rad(self.sniper_zoom)
						local fov = self.offset.fov and math_rad(self.offset.fov) or math_rad(self.sniper_zoom)
						self.custom_vertical_fov = math_lerp(self.default_custom_vertical_fov, custom_fov, anim_progress)
						self.vertical_fov = math_lerp(self.default_vertical_fov, fov, anim_progress)
					end

				end
				if self.offset then
					if self.offset.position then
						local position = vector3_lerp(vector3_zero(), vector3_unbox(self.offset.position), anim_progress)
						self.position_offset:store(position)

						if self.sniper_zoom and self.lens_units and self.lens_units[3] and unit_alive(self.lens_units[3]) and self.default_reticle_position then
							local default_offset = vector3_unbox(self.default_reticle_position)
							local rotation = unit_local_rotation(self.lens_units[3], 1)
							local forward = Quaternion.forward(rotation)
							local current_reticle_offset = forward * (self.reticle_size * reticle_multiplier)
							local reticle_offset = vector3_lerp(default_offset, default_offset + current_reticle_offset, anim_progress)
							mesh_set_local_position(unit_mesh(self.lens_units[3], self.lens_mesh), self.lens_units[3], reticle_offset)
							unit_set_unit_visibility(self.lens_units[3], true)
						end

					end
					if self.offset.rotation then
						local rotation = vector3_lerp(vector3_zero(), vector3_unbox(self.offset.rotation), anim_progress)
						self.rotation_offset:store(rotation)
					end
				end
			elseif self.aim_timer and t > self.aim_timer then
				self.is_starting_aim = nil
				if self.sniper_zoom then

					self.lens_transparency = self.lense_transparency_target

					if self.sniper_scope_unit and unit_alive(self.sniper_scope_unit) then
						-- local sight = mod.gear_settings:apply_fixes(self.ranged_weapon.item, "sight")
						local aim_scale = self.offset.aim_scale or .5
						local scale_default = self.sniper_sight_data and self.sniper_sight_data.scale
							and vector3_unbox(self.sniper_sight_data.scale) or vector3(1, 1, 1)
						unit_set_local_scale(self.sniper_scope_unit, 1, vector3(scale_default[1], aim_scale, scale_default[3]))
					end

					if self.sniper_zoom and self.lens_units and self.lens_units[3] and unit_alive(self.lens_units[3]) and self.default_reticle_position then
						local default_offset = vector3_unbox(self.default_reticle_position)
						local rotation = unit_local_rotation(self.lens_units[3], 1)
						local forward = Quaternion.forward(rotation)
						local current_reticle_offset = forward * (self.reticle_size * reticle_multiplier)
						mesh_set_local_position(unit_mesh(self.lens_units[3], self.lens_mesh), self.lens_units[3], default_offset + current_reticle_offset)
					end

					local custom_fov = self.offset.custom_fov and math_rad(self.offset.custom_fov) or math_rad(self.sniper_zoom)
					local fov = self.offset.fov and math_rad(self.offset.fov) or math_rad(self.sniper_zoom)
					self.custom_vertical_fov = custom_fov
					self.vertical_fov = fov
				end
				if self.offset then
					if self.offset.position then self.position_offset:store(vector3_unbox(self.offset.position)) end
					if self.offset.rotation then self.rotation_offset:store(vector3_unbox(self.offset.rotation)) end
				end
				self.aim_timer = nil
			end
		else
			if self.aim_timer and t <= self.aim_timer then
				local time_in_action = math_clamp01(self.reset_time - (self.aim_timer - t))
				local progress = time_in_action / self.reset_time
				local anim_progress = math.ease_sine(progress)
				if self.sniper_zoom then

					self.lens_transparency = math_lerp(self.lense_transparency_target, MIN_TRANSPARENCY, anim_progress)

					if self.sniper_scope_unit and unit_alive(self.sniper_scope_unit) then
						-- local sight = mod.gear_settings:apply_fixes(self.ranged_weapon.item, "sight")
						local scale_default = self.sniper_sight_data and self.sniper_sight_data.scale
							and vector3_unbox(self.sniper_sight_data.scale) or vector3(1, 1, 1)
						local aim_scale = self.offset.aim_scale or .5
						local apply_scale = vector3_lerp(vector3(scale_default[1], aim_scale, scale_default[3]), scale_default, anim_progress)
						unit_set_local_scale(self.sniper_scope_unit, 1, apply_scale)
					end

					if self.default_vertical_fov and self.default_custom_vertical_fov then
						local custom_fov = self.offset.custom_fov and math_rad(self.offset.custom_fov) or math_rad(self.sniper_zoom)
						local fov = self.offset.fov and math_rad(self.offset.fov) or math_rad(self.sniper_zoom)
						self.custom_vertical_fov = math_lerp(custom_fov, self.default_custom_vertical_fov, anim_progress)
						self.vertical_fov = math_lerp(fov, self.default_vertical_fov, anim_progress)
					end

				end
				if self.offset then
					if self.offset.position then
						local position = vector3_lerp(vector3_unbox(self.offset.position), vector3_zero(), anim_progress)
						self.position_offset:store(position)

						if self.sniper_zoom and self.lens_units and self.lens_units[3] and unit_alive(self.lens_units[3]) and self.default_reticle_position then
							local default_offset = vector3_unbox(self.default_reticle_position)
							local rotation = unit_local_rotation(self.lens_units[3], 1)
							local forward = Quaternion.forward(rotation)
							local current_reticle_offset = forward * (self.reticle_size * reticle_multiplier)
							local reticle_offset = vector3_lerp(default_offset + current_reticle_offset, default_offset, anim_progress)
							mesh_set_local_position(unit_mesh(self.lens_units[3], self.lens_mesh), self.lens_units[3], reticle_offset)
						end

					end
					if self.offset.rotation then
						local rotation = vector3_lerp(vector3_unbox(self.offset.rotation), vector3_zero(), anim_progress)
						self.rotation_offset:store(rotation)
					end
				end
			elseif self.aim_timer and t > self.aim_timer then
				if self.sniper_zoom then

					self.lens_transparency = MIN_TRANSPARENCY

					if self.sniper_scope_unit and unit_alive(self.sniper_scope_unit) then
						-- local sight = mod.gear_settings:apply_fixes(self.ranged_weapon.item, "sight")
						local scale_default = self.sniper_sight_data and self.sniper_sight_data.scale
							and vector3_unbox(self.sniper_sight_data.scale) or vector3(1, 1, 1)
						unit_set_local_scale(self.sniper_scope_unit, 1, scale_default)
					end

					if self.sniper_zoom and self.lens_units and self.lens_units[3] and unit_alive(self.lens_units[3]) and self.default_reticle_position then
						local default_offset = vector3_unbox(self.default_reticle_position)
						unit_set_unit_visibility(self.lens_units[3], false)
						mesh_set_local_position(unit_mesh(self.lens_units[3], self.lens_mesh), self.lens_units[3], default_offset)
					end
				end
				self.custom_vertical_fov = nil
				self.vertical_fov = nil
				self.position_offset:store(vector3_zero())
				self.rotation_offset:store(vector3_zero())
				self.aim_timer = nil
				self._is_unaiming = nil
			end
		end

		self:update_scope_lenses()
	end
end

SightExtension.update_position_and_rotation = function(self)
	if self.initialized and self:get_first_person() and self.ranged_weapon.weapon_unit and unit_alive(self.ranged_weapon.weapon_unit)
			and self.first_person_unit and unit_alive(self.first_person_unit) then
		-- Position
		local position_offset = self.position_offset and vector3_unbox(self.position_offset) or vector3_zero()
		local mat = quaternion_matrix4x4(unit_local_rotation(self.ranged_weapon.weapon_unit, 1))
		local node = Unit.node(self.first_person_unit, "ap_aim")
		unit_set_local_position(self.first_person_unit, node, matrix4x4_transform(mat, position_offset))
		-- Rotation
		if self.is_local_unit then
			local rotation_offset = self.rotation_offset and quaternion_unbox(self.rotation_offset) or vector3_zero()
			local rotation = quaternion_from_euler_angles_xyz(rotation_offset[1], rotation_offset[2], rotation_offset[3])
			unit_set_local_rotation(self.ranged_weapon.weapon_unit, 1, rotation)
		end

		-- if not self.is_local_unit then
		-- 	unit_set_local_rotation(self.first_person_unit, node, Quaternion.multiply(unit_local_rotation(self.first_person_unit, node), -rotation))
		-- end

		-- world_update_unit_and_children(self.world, self.first_person_unit)
	end
end

SightExtension.destroy_particle_effect = function(self)
	if self.particle_effect and self.particle_effect > 0 then
		world_stop_spawning_particles(self.world, self.particle_effect)
		world_destroy_particles(self.world, self.particle_effect)
	end
	self.particle_effect = nil
end

SightExtension.update_scope_lenses = function(self)
	local scales1, scales2 = vector3_zero(), vector3_zero()
	if (not self._is_aiming and not self._inspecting) and self.aim_timer == nil and self.lens_scales then
		scales1, scales2 = self.lens_scales[1] and vector3_unbox(self.lens_scales[1]) or vector3_zero(),
			self.lens_scales[2] and vector3_unbox(self.lens_scales[2]) or vector3_zero()
	end
	if self.sniper_zoom and self.lens_units then
		if self.lens_units[1] and unit_alive(self.lens_units[1]) then
			if self.offset.lense_transparency then
				if self.lens_transparency > 1 then unit_set_local_scale(self.lens_units[1], 1, scales1) end
				unit_set_scalar_for_materials(self.lens_units[1], "inv_jitter_alpha", self.lens_transparency, true)
			else
				unit_set_scalar_for_materials(self.lens_units[1], "inv_jitter_alpha", 1, true)
				unit_set_local_scale(self.lens_units[1], 1, scales1)
			end
		end
		if self.lens_units[2] and unit_alive(self.lens_units[2]) then
			if self.offset.lense_transparency then
				if self.lens_transparency > 1 then unit_set_local_scale(self.lens_units[2], 1, scales2) end
				unit_set_scalar_for_materials(self.lens_units[2], "inv_jitter_alpha", self.lens_transparency, true)
			else
				unit_set_scalar_for_materials(self.lens_units[2], "inv_jitter_alpha", 1, true)
				unit_set_local_scale(self.lens_units[2], 1, scales2)
			end
		end
		-- if self:is_scope() and self.sight_unit and unit_alive(self.sight_unit) then
		-- 	if self.offset.lense_transparency and self.hide_reticle then
		-- 		unit_set_scalar_for_materials(self.sight_unit, "inv_jitter_alpha", self.lens_transparency, true)
		-- 	else
		-- 		unit_set_scalar_for_materials(self.sight_unit, "inv_jitter_alpha", 0, true)
		-- 	end
		-- end
	-- elseif self.sniper_zoom and not self.lens_units then
	-- 	self:set_lens_units()
	end
	if self.sniper_effect and self:get_first_person() and (self._is_aiming or self._inspecting) and self.sniper_zoom then
		if not self.particle_effect then
			self.particle_effect = world_create_particles(self.world, EFFECT, vector3(0, 0, 1))
		end
	else
		self:destroy_particle_effect()
	end
end

SightExtension.update_zoom = function(self, viewport_name)
	if self.initialized and self:get_first_person() then
		local viewport = ScriptWorld.viewport(self.world, viewport_name)
		local camera = viewport and ScriptViewport.camera(viewport)
		if camera then --and (self._is_aiming or self._is_unaiming) then
			self:set_default_fov(camera_vertical_fov(camera), camera_custom_vertical_fov(camera))
			if self.custom_vertical_fov then camera_set_custom_vertical_fov(camera, self.custom_vertical_fov) end
			if self.vertical_fov then camera_set_vertical_fov(camera, self.vertical_fov) end
		end
	end
end

local reload_animations = {"reload_end_long", "reload_end"}
local reload_actions = {"action_reload", "action_reload_loop", "action_reload_shotgun", "action_reload_state", "action_brace_reload", "action_start_reload"}

SightExtension.on_detach_scope = function(self)
	-- if self.weapon_action_component and self.weapon_action_component.current_action_name then
	-- 	if not table_contains(reload_actions, self.weapon_action_component.current_action_name) then
		if self:can_detach_scope() then
			mod:echo(self.weapon_action_component.current_action_name)

			self.scope_detached = not self.scope_detached
			for _, anim_name in pairs(reload_animations) do
				if unit_has_animation_event(self.first_person_unit, anim_name) then
					mod:echo("Detaching "..anim_name)
					unit_animation_event(self.first_person_unit, anim_name)
				end
			end
		end
	-- 	end
	-- end
end

SightExtension.can_detach_scope = function(self)
	if self.weapon_action_component and self.weapon_action_component.current_action_name then
		if not table_contains(reload_actions, self.weapon_action_component.current_action_name) then
			return true
		end
	end
	return false
end

mod.can_detach_scope = function(self)
	return self:execute_extension(self.player_unit, "sight_system", "can_detach_scope")
end

mod.is_scope_used = function(self)
    return self:execute_extension(self.player_unit, "sight_system", "is_sniper")
end

return SightExtension
