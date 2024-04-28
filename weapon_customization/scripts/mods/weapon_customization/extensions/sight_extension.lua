local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local ScriptCamera = mod:original_require("scripts/foundation/utilities/script_camera")
local Crouch = mod:original_require("scripts/extension_systems/character_state_machine/character_states/utilities/crouch")
local Recoil = mod:original_require("scripts/utilities/recoil")
local Sway = mod:original_require("scripts/utilities/sway")
local ScriptViewport = mod:original_require("scripts/foundation/utilities/script_viewport")
local ScriptWorld = mod:original_require("scripts/foundation/utilities/script_world")
local RecoilTemplate = mod:original_require("scripts/settings/equipment/recoil_templates")
local WieldableSlotScripts = mod:original_require("scripts/extension_systems/visual_loadout/utilities/wieldable_slot_scripts")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
	local Unit = Unit
	local math = math
	local type = type
	local table = table
	local World = World
	local pairs = pairs
	local CLASS = CLASS
	local class = class
	-- local unpack = unpack
	local Camera = Camera
	local vector3 = Vector3
	local wc_perf = wc_perf
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
	local matrix4x4_transform = Matrix4x4.transform
	local camera_vertical_fov = Camera.vertical_fov
	local unit_world_position = Unit.world_position
	local unit_world_rotation = Unit.world_rotation
	local unit_local_position = Unit.local_position
	local unit_local_rotation = Unit.local_rotation
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
	local script_unit_has_extension = script_unit.has_extension
	local camera_custom_vertical_fov = Camera.custom_vertical_fov
	local world_stop_spawning_particles = World.stop_spawning_particles
	local shading_environment_set_scalar = ShadingEnvironment.set_scalar
	local camera_set_custom_vertical_fov = Camera.set_custom_vertical_fov
	local world_update_unit_and_children = World.update_unit_and_children
	local quaternion_to_euler_angles_xyz = Quaternion.to_euler_angles_xyz
	local quaternion_from_euler_angles_xyz = Quaternion.from_euler_angles_xyz
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"
local EFFECT_OPTION = "mod_option_scopes_particle"
local EFFECT = "content/fx/particles/screenspace/screen_ogryn_dash"
local SOUND_OPTION = "mod_option_scopes_sound"
local SOUND = "wwise/events/weapon/play_lasgun_p3_mag_button"
-- local SIGHT_A = "#ID[7abb5fc7a4e06dcb]"
-- local SIGHT_B = "#ID[21bfd951c3d1b9fe]"
-- local LENS_A = "#ID[827a5604cb4ec7ff]"
-- local LENS_B = "#ID[c54f4d16d170cfdb]"

local SIGHT = "sight_2"
local LENS_A = "lens"
local LENS_B = "lens_2"
local SCOPE_OFFSET = "scope_offset"
local SNIPER_OFFSET = "sniper_offset"
local NO_SCOPE_OFFSET = "no_scope_offset"
local SLOT_SECONDARY = "slot_secondary"
local SLOT_UNARMED = "slot_unarmed"

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
	self.equipment_component = extension_init_data.equipment_component
	self.equipment = extension_init_data.equipment
	self.is_starting_aim = nil
	self._is_aiming = nil
	self.aim_timer = nil
	self.position_offset = nil
	self.rotation_offset = nil
	self.default_vertical_fov = nil
	self.vertical_fov = nil
	self.default_custom_vertical_fov = nil
	self.custom_vertical_fov = nil
	self.offset = nil
	-- self.sniper_offset = nil
	self.sights = {}
	self.lenses = {}
	self.sniper_recoil_template = nil
	self.sniper_sway_template = nil
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

SightExtension.is_hiding_crosshair = function(self)
	-- Check cache
	-- if self._is_hiding_crosshair == nil then
	-- Get value
	local laser = self.deactivate_crosshair_laser and mod:execute_extension(self.player_unit, "laser_pointer_system", "is_active")
	local sniper_or_scope = self:is_sniper() or self:is_scope()
	local aiming = self.deactivate_crosshair_aiming and self._is_aiming and sniper_or_scope
	self._is_hiding_crosshair = laser or aiming
	-- end
	-- Return cache
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
	local lens_2 = mod:_apply_anchor_fixes(self.ranged_weapon.item, "lens_2")
	local lens = mod:_apply_anchor_fixes(self.ranged_weapon.item, "lens")
	self.lens_scales = {
		lens_2 and lens_2.scale or vector3_box(vector3_zero()),
		lens and lens.scale or vector3_box(vector3_zero()),
	}
end

SightExtension.set_weapon_values = function(self)
	self.is_starting_aim = nil
	self._is_aiming = nil
	self.aim_timer = nil
	self.position_offset = nil
	self.rotation_offset = nil
	self.default_vertical_fov = nil
	self.vertical_fov = nil
	self.default_custom_vertical_fov = nil
	self.custom_vertical_fov = nil
	self.item_name = mod:item_name_from_content_string(self.ranged_weapon.item.name)
	self.sights = {
		mod:_recursive_find_attachment(self.ranged_weapon.item.attachments, "sight"),
		mod:_recursive_find_attachment(self.ranged_weapon.item.attachments, "sight_2"),
	}
	self.lenses = {
		mod:_recursive_find_attachment(self.ranged_weapon.item.attachments, "scope_lens_01"),
		mod:_recursive_find_attachment(self.ranged_weapon.item.attachments, "scope_lens_02"),
	}
	self:set_lens_units()
	self.sight_unit = mod:get_attachment_slot_in_attachments(self.ranged_weapon.attachment_units, "sight_3")
	    or mod:get_attachment_slot_in_attachments(self.ranged_weapon.attachment_units, "sight_2")
	    or mod:get_attachment_slot_in_attachments(self.ranged_weapon.attachment_units, "sight")
	self.sight = self.sights[2] or self.sights[1] --self:get_sight()
	self.sight_name = self.sights[1] and mod:item_name_from_content_string(self.sights[1].item)
	self.offset = nil
	if self:is_scope() or self:is_sniper() then
		self:set_sight_offset()
	elseif self:is_sight() then
		self:set_sight_offset(NO_SCOPE_OFFSET)
	end
	self.sniper_zoom = nil
	if self:is_sniper() then
		self.sniper_zoom = mod.sniper_zoom_levels[self.sight_name] or 7
		self:set_sniper_scope_unit()
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
	self.offset = mod:_apply_anchor_fixes(self.ranged_weapon.item, offset_type) or sight_offset or {position = vector3_box(vector3_zero())}
end

SightExtension.set_sniper_scope_unit = function(self)
	if self.ranged_weapon.attachment_units then
		self.sniper_scope_unit = mod:get_attachment_slot_in_attachments(self.ranged_weapon.attachment_units, "sight")
	end
end

SightExtension.set_lens_units = function(self)
	local reflex = {}
	mod:_recursive_find_unit_by_slot(self.ranged_weapon.weapon_unit, SIGHT, reflex)
	if #reflex >= 1 then
		local lenses = {}
		mod:_recursive_find_unit_by_slot(self.ranged_weapon.weapon_unit, LENS_A, lenses)
		mod:_recursive_find_unit_by_slot(self.ranged_weapon.weapon_unit, LENS_B, lenses)
		if #lenses >= 2 then
			local scope_sight = mod:_apply_anchor_fixes(self.ranged_weapon.item, "sight_2")
			self.default_reticle_position = scope_sight and scope_sight.position
			if unit_get_data(lenses[1], "lens") == 2 then
				self.lens_units = {lenses[1], lenses[2], reflex[1]}
			else
				self.lens_units = {lenses[2], lenses[1], reflex[1]}
			end
			unit_set_unit_visibility(reflex[1], false)
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
	self.sniper_recoil_template = nil
	self.sniper_sway_template = nil
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
	if self:is_wielded() then
		self._is_hiding_crosshair = nil
		self.is_starting_aim = nil
		self._is_aiming = nil
		self.aim_timer = t + self.reset_time
		if self.particle_effect then
			if self.particle_effect > 0 then
				world_stop_spawning_particles(self.world, self.particle_effect)
				world_destroy_particles(self.world, self.particle_effect)
			end
			self.particle_effect = nil
		end
	end
end

SightExtension.on_unaim_start = function(self, t)
	if self:is_wielded() then
		self._is_hiding_crosshair = nil
		self.is_starting_aim = nil
		self._is_aiming = nil
		self.aim_timer = t + self.reset_time
	end
end

SightExtension.on_settings_changed = function(self)
	self.reticle_size = mod:get("mod_option_scopes_reticle_size")
	self.sniper_sound = mod:get("mod_option_scopes_sound")
	self.sniper_effect = mod:get("mod_option_scopes_particle")
	self.deactivate_crosshair_laser = mod:get("mod_option_deactivate_crosshair_laser")
	self.deactivate_crosshair_aiming = mod:get("mod_option_deactivate_crosshair_aiming")
	self.scopes_recoil = mod:get("mod_option_scopes_recoil")
	self.scopes_sway = mod:get("mod_option_scopes_sway")
	self.weapon_dof = mod:get("mod_option_misc_weapon_dof")
	self.sniper_recoil_template = nil
	self.sniper_sway_template = nil
end

SightExtension.on_inspect_start = function(self, t)
	self._is_starting_inspect = true
	self._inspecting = true
	self.aim_timer = t + self.reset_time
end

SightExtension.on_inspect_end = function(self, t)
	self._is_starting_inspect = false
	self._inspecting = false
	self.aim_timer = t + self.reset_time
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

local reticle_multiplier = .5

SightExtension.update = function(self, unit, dt, t)
	local perf = wc_perf.start("SightExtension.update", 2)
	if self.initialized then

		-- local equipment_component = self.equipment_component
		-- local equipment = self._equipment

		-- self.visual_loadout_extension:_update_item_visibility(self:get_first_person())

		-- equipment_component.wield_slot(self.wielded_slot, self:get_first_person())
		-- self:_update_item_visibility(self._is_in_first_person_mode)

		-- self._profile_properties = equipment_component.resolve_profile_properties(equipment, slot_name, self._archetype_property, self._selected_voice_property)
		-- local slot_scripts = self.visual_loadout_extension._wieldable_slot_scripts and
			-- self.visual_loadout_extension._wieldable_slot_scripts[self.wielded_slot.name]

		-- if slot_scripts then
		-- 	WieldableSlotScripts.unwield(slot_scripts)
		-- 	WieldableSlotScripts.wield(slot_scripts)
		-- end

		-- if self.visual_loadout_extension then
			-- self.visual_loadout_extension:unwield_slot(self.wielded_slot.name)
			-- self.visual_loadout_extension:wield_slot(self.wielded_slot.name)
		-- self.visual_loadout_extension:force_update_item_visibility()
		-- end

		if self.sniper_zoom and self.lens_units and self.lens_units[3] and self.default_reticle_position
				and not self.is_starting_aim and not self._is_aiming then
			local default_offset = vector3_unbox(self.default_reticle_position)
			unit_set_local_position(self.lens_units[3], 1, default_offset)
		end

		if self.is_starting_aim or self._is_starting_inspect then
			if self.aim_timer and t <= self.aim_timer then
				local time_in_action = math_clamp01(self.start_time - (self.aim_timer - t))
				local progress = time_in_action / self.start_time
				local anim_progress = math.ease_sine(progress)
				if self.sniper_zoom then

					if self.sniper_scope_unit and unit_alive(self.sniper_scope_unit) then
						local sight = mod:_apply_anchor_fixes(self.ranged_weapon.item, "sight")
						local scale_default = sight and sight.scale and vector3_unbox(sight.scale) or vector3(1, 1, 1)
						local aim_scale = self.offset.aim_scale or .5
						local apply_scale = vector3_lerp(scale_default, vector3(scale_default[1], aim_scale, scale_default[3]), anim_progress)
						unit_set_local_scale(self.sniper_scope_unit, 1, apply_scale)
					end

					if self.default_vertical_fov and self.default_custom_vertical_fov then
						local custom_fov = self.offset.custom_fov and math_rad(self.offset.custom_fov) or math_rad(self.sniper_zoom)
						local fov = self.offset.fov and math_rad(self.offset.fov) or math_rad(self.sniper_zoom)
						-- local apply_fov = math_rad(self.sniper_zoom)
						self.custom_vertical_fov = math_lerp(self.default_custom_vertical_fov, custom_fov, anim_progress)
						self.vertical_fov = math_lerp(self.default_vertical_fov, fov, anim_progress)
					end

				end
				if self.offset then
					if self.offset.position then
						local position = vector3_lerp(vector3_zero(), vector3_unbox(self.offset.position), anim_progress)
						self.position_offset = vector3_box(position)
						if self.sniper_zoom and self.lens_units and self.lens_units[3] and self.default_reticle_position then
							local default_offset = vector3_unbox(self.default_reticle_position)
							local rotation = unit_local_rotation(self.lens_units[3], 1)
							local forward = Quaternion.forward(rotation)
							-- local max = forward * reticle_multiplier
							local current_reticle_offset = forward * (self.reticle_size * reticle_multiplier)
							local reticle_offset = vector3_lerp(default_offset, default_offset + current_reticle_offset, anim_progress)
							unit_set_local_position(self.lens_units[3], 1, reticle_offset)
							unit_set_unit_visibility(self.lens_units[3], true)
						end
					end
					if self.offset.rotation then
						local rotation = vector3_lerp(vector3_zero(), vector3_unbox(self.offset.rotation), anim_progress)
						self.rotation_offset = vector3_box(rotation)
					end
				end
			elseif self.aim_timer and t > self.aim_timer then
				self.is_starting_aim = nil
				if self.sniper_zoom then

					if self.sniper_scope_unit and unit_alive(self.sniper_scope_unit) then
						local sight = mod:_apply_anchor_fixes(self.ranged_weapon.item, "sight")
						local aim_scale = self.offset.aim_scale or .5
						local scale_default = sight and sight.scale and vector3_unbox(sight.scale) or vector3(1, 1, 1)
						unit_set_local_scale(self.sniper_scope_unit, 1, vector3(scale_default[1], aim_scale, scale_default[3]))
					end

					if self.sniper_zoom and self.lens_units and self.lens_units[3] and self.default_reticle_position then
						local default_offset = vector3_unbox(self.default_reticle_position)
						local rotation = unit_local_rotation(self.lens_units[3], 1)
						local forward = Quaternion.forward(rotation)
						-- local max = forward * reticle_multiplier
						local current_reticle_offset = forward * (self.reticle_size * reticle_multiplier)
						unit_set_local_position(self.lens_units[3], 1, default_offset + current_reticle_offset)
					end

					local custom_fov = self.offset.custom_fov and math_rad(self.offset.custom_fov) or math_rad(self.sniper_zoom)
					local fov = self.offset.fov and math_rad(self.offset.fov) or math_rad(self.sniper_zoom)
					-- local apply_fov = math_rad(self.sniper_zoom)
					self.custom_vertical_fov = custom_fov
					self.vertical_fov = fov
				end
				if self.offset then
					if self.offset.position then self.position_offset = self.offset.position end
					if self.offset.rotation then self.rotation_offset = self.offset.rotation end
				end
				self.anim_state = Unit.animation_get_state(self.first_person_unit)
				self.aim_timer = nil
			end
		else
			if self.aim_timer and t <= self.aim_timer then
				local time_in_action = math_clamp01(self.reset_time - (self.aim_timer - t))
				local progress = time_in_action / self.reset_time
				local anim_progress = math.ease_sine(progress)
				if self.sniper_zoom then

					if self.sniper_scope_unit and unit_alive(self.sniper_scope_unit) then
						local sight = mod:_apply_anchor_fixes(self.ranged_weapon.item, "sight")
						local scale_default = sight and sight.scale and vector3_unbox(sight.scale) or vector3(1, 1, 1)
						local aim_scale = self.offset.aim_scale or .5
						local apply_scale = vector3_lerp(vector3(scale_default[1], aim_scale, scale_default[3]), scale_default, anim_progress)
						unit_set_local_scale(self.sniper_scope_unit, 1, apply_scale)
					end

					if self.default_vertical_fov and self.default_custom_vertical_fov then
						local custom_fov = self.offset.custom_fov and math_rad(self.offset.custom_fov) or math_rad(self.sniper_zoom)
						local fov = self.offset.fov and math_rad(self.offset.fov) or math_rad(self.sniper_zoom)
						-- local apply_fov = math_rad(self.sniper_zoom)
						self.custom_vertical_fov = math_lerp(custom_fov, self.default_custom_vertical_fov, anim_progress)
						self.vertical_fov = math_lerp(fov, self.default_vertical_fov, anim_progress)
					end

				end
				if self.offset then
					if self.offset.position then
						local position = vector3_lerp(vector3_unbox(self.offset.position), vector3_zero(), anim_progress)
						self.position_offset = vector3_box(position)
						if self.sniper_zoom and self.lens_units and self.lens_units[3] and self.default_reticle_position then
							local default_offset = vector3_unbox(self.default_reticle_position)
							local rotation = unit_local_rotation(self.lens_units[3], 1)
							local forward = Quaternion.forward(rotation)
							-- local max = forward * reticle_multiplier
							local current_reticle_offset = forward * (self.reticle_size * reticle_multiplier)
							local reticle_offset = vector3_lerp(default_offset + current_reticle_offset, default_offset, anim_progress)
							unit_set_local_position(self.lens_units[3], 1, reticle_offset)
						end
					end
					if self.offset.rotation then
						local rotation = vector3_lerp(vector3_unbox(self.offset.rotation), vector3_zero(), anim_progress)
						self.rotation_offset = vector3_box(rotation)
					end
				end
			elseif self.aim_timer and t > self.aim_timer then
				if self.sniper_zoom then

					if self.sniper_scope_unit and unit_alive(self.sniper_scope_unit) then
						local sight = mod:_apply_anchor_fixes(self.ranged_weapon.item, "sight")
						local scale_default = sight and sight.scale and vector3_unbox(sight.scale) or vector3(1, 1, 1)
						unit_set_local_scale(self.sniper_scope_unit, 1, scale_default)
					end

					if self.lens_units and self.lens_units[3] and self.default_reticle_position then
						local default_offset = vector3_unbox(self.default_reticle_position)
						unit_set_unit_visibility(self.lens_units[3], false)
						unit_set_local_position(self.lens_units[3], 1, default_offset)
					end
				end
				self.custom_vertical_fov = nil
				self.vertical_fov = nil
				self.position_offset = nil
				self.rotation_offset = nil
				self.aim_timer = nil
			end
		end

		self:update_scope_lenses()
	end
	wc_perf.stop(perf)
end

local fix_items = {"stubrevolver_p1_m1"}--, "stubrevolver_p1_m2"}

SightExtension.set_animation_state = function(self)
	if self.anim_state and self:is_aiming() and table_contains(fix_items, self.item_name) then
		if self.first_person_unit and unit_alive(self.first_person_unit) then
			Unit.animation_set_state(self.first_person_unit, unpack(self.anim_state))
		end
	end
end

SightExtension.revolver_fix = function(self, t)
	
	-- if self:is_aiming() and table_contains(fix_items, self.item_name) then

		self:set_animation_state()

		-- if self.anim_state then
		-- 	Unit.animation_set_state(self.first_person_unit, unpack(self.anim_state))
		-- end

		-- local animation_extension = script_unit.extension(self.player_unit, "animation_system")
		-- animation_extension:inventory_slot_wielded(self.ranged_weapon.weapon_template, t)

		-- local unit_data_extension = script_unit.extension(self.player_unit, "unit_data_system")
		-- local alternate_fire_component = unit_data_extension:write_component("alternate_fire")
		-- alternate_fire_component.is_active = true
		-- alternate_fire_component.start_t = t
		-- local alternate_fire_settings = self.ranged_weapon.weapon_template.alternate_fire_settings
		-- local start_anim_event = alternate_fire_settings.start_anim_event
		-- local start_anim_event_3p = alternate_fire_settings.start_anime_event_3p or start_anim_event

		-- if start_anim_event and start_anim_event_3p then
		-- 	animation_extension:anim_event_1p(start_anim_event)
		-- 	animation_extension:anim_event(start_anim_event_3p)
		-- end

	-- end

end

local mesh_slots = {"sight", SIGHT, "sight_3", LENS_A, LENS_B}

SightExtension.update_position_and_rotation = function(self)

	local new_position = vector3_zero()

	if self.initialized and self:get_first_person() then -- and self:is_aiming() then

		-- local recoil = Quaternion.identity()
		-- local weapon_rotation = unit_local_rotation(self.ranged_weapon.weapon_unit, 1)
		
		-- local gear_info = slot_infos[slot_info_id]
		-- local position_offset = self.position_offset and vector3_unbox(self.position_offset) or vector3_zero()

		-- mod:echot("position_offset: "..tostring(position_offset).." slot_info_id: "..tostring(slot_info_id))

		-- local receiver = mod:get_attachment_slot_in_attachments(self.ranged_beam.attachment_units, "receiver")
		-- if self.ranged_weapon.weapon_unit and unit_alive(self.ranged_weapon.weapon_unit) then
		-- 	local position_offset = self.position_offset and vector3_unbox(self.position_offset) or vector3_zero()

		-- 	unit_set_local_position(self.ranged_weapon.weapon_unit, 4, position_offset)
		-- end

		if self.ranged_weapon.attachment_units and self.ranged_weapon.weapon_unit and unit_alive(self.ranged_weapon.weapon_unit) and self.ranged_weapon.item then
			local slot_info_id = mod:get_slot_info_id(self.ranged_weapon.item)
			local slot_infos = mod:persistent_table(REFERENCE).attachment_slot_infos
			local gear_info = slot_infos[slot_info_id]
			if gear_info then
			
				
				-- position_offset = position_offset + position_offset * ((mod.test_index - 1) * .001)
				-- mod:echot("position_offset: "..tostring(position_offset))
				-- if self.visual_loadout_extension and self.wielded_slot then
				-- 	self.visual_loadout_extension:wield_slot(self.wielded_slot.name)
				-- end
				

				if self.ranged_weapon.attachment_units and #self.ranged_weapon.attachment_units > 0 then
					-- local children = unit_get_child_units(self.ranged_weapon.weapon_unit)
					-- local unit = self.ranged_weapon.attachment_units[1]
					-- for _, unit in pairs(children) do
						local root_attachment = self.offset.root or "receiver"
						-- local unit = mod:get_attachment_slot_in_attachments(self.ranged_weapon.attachment_units, root_attachment)
						local units = table.icombine(self.ranged_weapon.attachment_units, {self.ranged_weapon.weapon_unit})
						for _, unit in pairs(units) do
							if unit and unit_alive(unit) then

								local attachment_name = unit_get_data(unit, "attachment_name")
								local attachment_slot = unit_get_data(unit, "attachment_slot")
								local parent_unit = self.ranged_weapon.weapon_unit --unit_get_data(unit, "parent_unit")
								local parent_node = 1 --unit_get_data(unit, "parent_node")
								-- mod:echot(attachment_slot)

								local gear_rotation = gear_info.unit_changed_rotation[unit] and quaternion_unbox(gear_info.unit_changed_position[unit])
								local unit_default_rotation = gear_rotation or Quaternion.identity()
								local gear_position = gear_info.unit_changed_position[unit] and vector3_unbox(gear_info.unit_changed_position[unit])
								local unit_default_position = gear_position or vector3_zero()

								local position_offset = self.position_offset and vector3_unbox(self.position_offset) or vector3_zero()
								local rotation_offset = self.rotation_offset and quaternion_unbox(self.rotation_offset) or vector3_zero()

								if attachment_slot == root_attachment then
									local mat = quaternion_matrix4x4(unit_local_rotation(parent_unit, parent_node))
									unit_set_local_position(unit, 1, matrix4x4_transform(mat, unit_default_position + position_offset))
									-- unit_set_local_position(unit, 1, unit_default_position + position_offset)
								end

								local moving_parts = self.offset.moving_parts and (self.offset.moving_parts[attachment_name] or self.offset.moving_parts[attachment_slot])

								local nodes = moving_parts and moving_parts.nodes
								-- if not moving_parts then moving_parts = {} end
								if nodes then
									local node_list = nodes[1] == 0 and table.icombine(nodes, {mod.test_index}) or nodes
									for _, node in pairs(node_list) do
										if node > 0 and not table_contains(node_list, node * -1) then
											local mat = quaternion_matrix4x4(unit_local_rotation(parent_unit, parent_node))
											unit_set_local_position(unit, node, matrix4x4_transform(mat, unit_default_position + position_offset))
											-- unit_set_local_position(unit, node, unit_default_position + position_offset)
										end
									end
								end

								local meshes = moving_parts and moving_parts.meshes
								if meshes then
									local mesh_list = meshes[1] == 0 and table.icombine(meshes, {mod.test_index}) or meshes
									local mesh_count = unit_num_meshes(unit)
									for _, mesh in pairs(mesh_list) do
										if mesh > 0 and mesh <= mesh_count and not table_contains(mesh_list, mesh * -1) then
											local mat = quaternion_matrix4x4(unit_local_rotation(parent_unit, parent_node))
											mesh_set_local_position(unit_mesh(unit, mesh), unit, matrix4x4_transform(mat, unit_default_position + position_offset))
											-- mesh_set_local_position(unit_mesh(unit, mesh), unit, unit_default_position + position_offset)
										end
									end
								end

								if attachment_slot == root_attachment then
									local rotation = quaternion_from_euler_angles_xyz(rotation_offset[1], rotation_offset[2], rotation_offset[3])
									local new_rotation = Quaternion.multiply(unit_default_rotation, rotation)
									unit_set_local_rotation(unit, 1, new_rotation)
								end

								local nodes_freeze_rotation = moving_parts and moving_parts.nodes_freeze_rotation
								if nodes_freeze_rotation then
									local node_list = nodes_freeze_rotation[1] == 0 and table.icombine(nodes_freeze_rotation, {mod.test_index}) or nodes_freeze_rotation
									for _, node in pairs(node_list) do
										if node > 0 then
											unit_set_local_rotation(unit, node, Quaternion.identity())
										end
									end
								end
							end
						end
					-- end
				end

				-- if self.ranged_weapon.weapon_unit and unit_alive(self.ranged_weapon.weapon_unit) then
				-- 	local unit = self.ranged_weapon.weapon_unit
					
				-- 	local unit_default_position = gear_info.unit_changed_position[unit] and vector3_unbox(gear_info.unit_changed_position[unit]) or vector3_zero()
					-- local mesh_count = unit_num_meshes(unit)
					-- for j = 1, mesh_count do
					-- 	local mesh = unit_mesh(unit, j)
					-- 	local mesh_position = mod.mesh_positions_changed[unit] and mod.mesh_positions_changed[unit][j] and vector3_unbox(mod.mesh_positions_changed[unit][j]) or unit_default_position
					-- 	mesh_set_local_position(mesh, unit, mesh_position + position_offset)
					-- end
				-- 	-- local unit_position = unit_world_position(unit, 1)
				-- 	-- unit_set_local_position(unit, 1, unit_default_position + position_offset)
				-- 	-- mod:unit_set_local_position_mesh(slot_info_id, unit, unit_default_position + position_offset)
				-- end

				-- for i, unit in pairs(self.ranged_weapon.attachment_units) do

				-- 	if unit and unit_alive(unit) then
				-- 		-- if not gear_info.unit_default_position[unit] then
				-- 		-- 	gear_info.unit_default_position[unit] = unit_local_position(unit, 1)
				-- 		-- -- end
				-- 		-- if gear_info.unit_default_position[unit] then
				-- 		-- 	local unit_default_position = gear_info.unit_default_position[unit] and vector3_unbox(gear_info.unit_default_position[unit]) or unit_local_position(unit, 1)
				-- 		-- -- local mesh_position = gear_info and gear_info.unit_mesh_position[unit] and vector3_unbox(gear_info.unit_mesh_position[unit]) or vector3_zero()
				-- 		-- -- local unit_position = unit_world_position(unit, 1)
				-- 		-- -- local mesh_rotation = gear_info and gear_info.unit_mesh_rotation[unit]
				-- 		-- 	mod:unit_set_local_position_mesh(slot_info_id, unit, unit_default_position + position_offset)
				-- 		-- end

				-- 		local attachment_slot = unit_get_data(unit, "attachment_slot")
				-- 		local unit_default_position = gear_info.unit_changed_position[unit] and vector3_unbox(gear_info.unit_changed_position[unit]) or vector3_zero()

				-- 		if table.contains(mesh_slots, attachment_slot) then
				-- 			local mesh_count = unit_num_meshes(unit)
				-- 			local attachment = unit_get_data(unit, "attachment_slot")
				-- 			-- mod:echot("attachment: "..tostring(attachment).." mesh_count: "..tostring(mesh_count))
				-- 			for j = 1, mesh_count do
				-- 				local mesh = unit_mesh(unit, j)
				-- 				local mesh_position = mod.mesh_positions_changed[unit] and mod.mesh_positions_changed[unit][j] and vector3_unbox(mod.mesh_positions_changed[unit][j]) or unit_default_position
				-- 				mesh_set_local_position(mesh, unit, mesh_position + position_offset)
				-- 			end
				-- 		else
				-- 			-- mod:echot("unit not found: "..tostring(unit))
				-- 			-- unit_set_local_position(unit, 1, unit_default_position + position_offset)
				-- 		end
				-- 		-- local unit_default_position = gear_info.unit_default_position[unit] and vector3_unbox(gear_info.unit_default_position[unit]) or vector3_zero()
				-- 		-- unit_set_local_position(unit, 1, unit_default_position + position_offset)
				-- 	-- else
				-- 	-- 	mod:echot("unit not found: "..tostring(unit))
				-- 	end

				end

				-- mod:echot("position_offset: "..tostring(position_offset))

				-- world_update_unit_and_children(self.world, self.ranged_weapon.weapon_unit)
			end
		end

	-- 	local input_ext = script_unit.extension(self.player_unit, "input_system")
	-- 	local yaw, pitch, roll = input_ext:get_orientation()
	-- 	local orientation = self.player and self.player.get_orientation and self.player:get_orientation()
	-- 	if orientation then
	-- 		yaw = orientation and orientation.yaw or yaw
	-- 		pitch = orientation and orientation.pitch or pitch
	-- 		roll = orientation and orientation.roll or roll
	-- 		local orientation_rotation = Quaternion.from_yaw_pitch_roll(orientation.yaw, orientation.pitch, orientation.roll)
	-- 		local diff = Quaternion.pitch(Quaternion.multiply(orientation_rotation, Quaternion.inverse(unit_local_rotation(self.first_person_unit, 1))))
	-- 		mod:echot("diff: "..tostring(diff))
	-- 		-- unit_set_local_rotation(self.first_person_unit, 1, orientation_rotation)
	-- 		-- world_update_unit_and_children(self.world, self.first_person_unit)
	-- 		local position_offset = self.position_offset and vector3_unbox(self.position_offset) or vector3_zero()

	-- 		if self.weapon_extension and self:is_sniper() then
	-- 			-- local input_ext = script_unit.extension(self.player_unit, "input_system")
	-- 			-- local yaw, pitch, roll = input_ext:get_orientation()
	-- 			-- rotation = Quaternion.from_yaw_pitch_roll(yaw, pitch, roll)
				
	-- 			local recoil_template = self.weapon_extension:recoil_template()
	-- 			local recoil_component = self.unit_data:read_component("recoil")
	-- 			local movement_state_component = self.unit_data:read_component("movement_state")
	-- 			local pitch_offset, yaw_offset = Recoil.first_person_offset(recoil_template, recoil_component, movement_state_component)
	-- 			-- local level = mod.sniper_recoil_level[self.sight_name]
	-- 			local back = mod.sniper_back_offset[self.sight_name] or .5
	-- 			recoil = Quaternion.from_yaw_pitch_roll(yaw_offset * back, pitch_offset * back, 0)
	-- 		local new_rotation = quaternion_from_euler_angles_xyz(Quaternion.yaw(rotation), Quaternion.pitch(rotation) - diff * 100, Quaternion.roll(rotation))
	-- 		unit_set_local_rotation(self.ranged_weapon.weapon_unit, 1, new_rotation)

	-- 			-- position_offset = position_offset + vector3(0, -pitch_offset, 0)
	-- 		end

	-- 		local rotation_offset = self.rotation_offset and vector3_unbox(self.rotation_offset) or vector3_zero()
	-- 		rotation = Quaternion.multiply(rotation, quaternion_from_euler_angles_xyz(rotation_offset[1], rotation_offset[2], rotation_offset[3]))
	-- 		-- rotation = Quaternion.multiply(rotation, diff)
	-- 		rotation = Quaternion.multiply(rotation, Quaternion.inverse(recoil))
	-- 		-- unit_set_local_rotation(self.first_person_unit, 10, rotation)

	-- 		local offset = self.sniper_offset or self.offset
	-- 		if offset then
	-- 			local mat = quaternion_matrix4x4(rotation)
				
	-- 			new_position = matrix4x4_transform(mat, vector3_unbox(offset.position) + vector3(0, diff, 0))
				
	-- 			-- new_position = new_position + vector3(0, -1, 0)
				
	-- 		end
	-- 	end
	-- end

	-- self.camera_offset = vector3_box(new_position)
	-- unit_set_local_position(self.ranged_weapon.weapon_unit, 1, -new_position)

	-- world_update_unit_and_children(self.world, self.first_person_unit)

end

SightExtension.update_scope_lenses = function(self)
	local scales = {vector3_zero(), vector3_zero()}
	if (not self._is_aiming and not self._inspecting) and self.aim_timer == nil and self.lens_scales then
		scales = {
			self.lens_scales[1] and vector3_unbox(self.lens_scales[1]) or vector3_zero(),
			self.lens_scales[2] and vector3_unbox(self.lens_scales[2]) or vector3_zero(),
		}
	end
	if self.sniper_zoom and self.lens_units then
		if self.lens_units[1] and unit_alive(self.lens_units[1]) then
			unit_set_local_scale(self.lens_units[1], 1, scales[1])
		end
		if self.lens_units[2] and unit_alive(self.lens_units[2]) then
			unit_set_local_scale(self.lens_units[2], 1, scales[2])
		end
	elseif self.sniper_zoom and not self.lens_units then
		self:set_lens_units()
	end
	if self.sniper_effect and self:get_first_person() and (self._is_aiming or self._inspecting) and self.sniper_zoom then
		if not self.particle_effect then
			self.particle_effect = world_create_particles(self.world, EFFECT, vector3(0, 0, 1))
		end
	elseif self.particle_effect then
		if self.particle_effect > 0 then
			world_stop_spawning_particles(self.world, self.particle_effect)
			world_destroy_particles(self.world, self.particle_effect)
		end
		self.particle_effect = nil
	end
end

SightExtension.update_zoom = function(self, viewport_name)
	if self.initialized and self:get_first_person() then
		local viewport = ScriptWorld.viewport(self.world, viewport_name)
		local camera = viewport and ScriptViewport.camera(viewport)
		if camera and self._is_aiming then
			-- local offset = self.sniper_offset or self.offset
			-- local unit = self.sniper_scope_unit or self.sight_unit
			-- if offset and self:is_aiming() and not self.is_starting_aim and unit then
			-- 	-- ScriptCamera.set_local_position(camera, -vector3_unbox(self.camera_offset))
			-- 	-- local offset = vector3_unbox(self.camera_offset)
			-- 	ScriptCamera.set_local_rotation(camera, unit_world_rotation(unit, 1))
			-- 	-- local back = mod.sniper_back_offset[self.sight_name] or .5
			-- 	local sniper_offset = offset and vector3_unbox(offset.position) or vector3_zero()
			-- 	ScriptCamera.set_local_position(camera, unit_world_position(unit, 1)
			-- 		+ vector3(0, 0, sniper_offset[3])
			-- 		- quaternion_forward(ScriptCamera.rotation(camera)) * sniper_offset[2])
			-- 		-- - quaternion_forward(ScriptCamera.rotation(camera)) * back)

			-- 	-- unit_set_local_rotation(self.sight_unit, 1, unit_local_rotation(self.first_person_unit, 1))

			-- 		-- + vector3(0, 0, offset[3]))
			-- 	-- ScriptCamera.force_update(self.world, camera)
			-- 	-- Camera.set_local_position(camera, self.sight_unit, vector3_unbox(self.camera_offset))

			-- 	unit_set_local_position(self.ranged_weapon.weapon_unit, 1, -vector3_unbox(self.camera_offset))

			-- end

			-- local camera_unit = Camera.get_data(camera, "unit")
			-- if camera_unit and self.camera_offset then
			-- 	mod:echot("SightExtension.update_zoom: "..tostring(camera_unit))
			-- 	unit_set_local_position(camera_unit, mod.test_index, -vector3_unbox(self.camera_offset))
			-- 	world_update_unit_and_children(self.world, camera_unit)
			-- end

			self:set_default_fov(camera_vertical_fov(camera), camera_custom_vertical_fov(camera))
			if self.custom_vertical_fov then camera_set_custom_vertical_fov(camera, self.custom_vertical_fov) end
			if self.vertical_fov then camera_set_vertical_fov(camera, self.vertical_fov) end
			-- local position = ScriptCamera.position(camera)
			-- mod:info("SightExtension.update_zoom: "..tostring(camera))
			-- ScriptCamera.set_local_position(camera, position)
		end
	end
end

-- ##### ┬─┐┌─┐┌─┐┌─┐┬┬    ┌─┐┌┐┌┌┬┐  ┌─┐┬ ┬┌─┐┬ ┬ ####################################################################
-- ##### ├┬┘├┤ │  │ │││    ├─┤│││ ││  └─┐│││├─┤└┬┘ ####################################################################
-- ##### ┴└─└─┘└─┘└─┘┴┴─┘  ┴ ┴┘└┘─┴┘  └─┘└┴┘┴ ┴ ┴  ####################################################################

SightExtension.get_sniper_sway_template = function(self, sway_template)
	if not self.sniper_sway_template and sway_template and self:is_sniper() then
		self.sniper_sway_template = table.clone(sway_template)
		for state, data in pairs(self.sniper_sway_template) do
			if data.max_sway then
				for angle_name, value in pairs(data.max_sway) do
					local sway_state = self.sniper_sway_template[state]
					local max_sway = sway_state.max_sway[angle_name]
					self.sniper_sway_template[state].max_sway[angle_name] = value * self.scopes_sway
				end
			end
			if data.continuous_sway then
				for angle_name, value in pairs(data.continuous_sway) do
					local sway_state = self.sniper_sway_template[state]
					local continuous_sway = sway_state.continuous_sway[angle_name]
					self.sniper_sway_template[state].continuous_sway[angle_name] = value * self.scopes_sway
				end
			end
		end
		return self.sniper_sway_template
	elseif self.sniper_sway_template and not self:is_sniper() then
		self.sniper_sway_template = nil
	elseif self.sniper_sway_template and self:is_sniper() and self._is_aiming then
		return self.sniper_sway_template
	end
	return sway_template
end

SightExtension.get_sniper_recoil_template = function(self, recoil_template)
	if not self.sniper_recoil_template and recoil_template and self:is_sniper() then
		self.sniper_recoil_template = table.clone(recoil_template)
		for state, data in pairs(self.sniper_recoil_template) do
			if data.offset_range then
				for offset_data_i, offset_data in pairs(data.offset_range) do
					if offset_data.pitch then
						for value_i, value in pairs(offset_data.pitch) do
							local recoil_state = self.sniper_recoil_template[state]
							local offset_range = recoil_state.offset_range[offset_data_i]
							local pitch_value = offset_range.pitch[value_i]
							self.sniper_recoil_template[state].offset_range[offset_data_i].pitch[value_i] = value * self.scopes_recoil
						end
					end
				end
			end
		end
		return self.sniper_recoil_template
	elseif self.sniper_recoil_template and not self:is_sniper() then
		self.sniper_recoil_template = nil
	elseif self.sniper_recoil_template and self:is_sniper() and self._is_aiming then
		return self.sniper_recoil_template
	end
	return recoil_template
end

return SightExtension
