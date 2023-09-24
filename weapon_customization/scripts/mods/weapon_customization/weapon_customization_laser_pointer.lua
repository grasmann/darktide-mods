local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local LagCompensation = mod:original_require("scripts/utilities/lag_compensation")
local FlashlightTemplates = mod:original_require("scripts/settings/equipment/flashlight_templates")
local UISettings = mod:original_require("scripts/settings/ui/ui_settings")
local Recoil = mod:original_require("scripts/utilities/recoil")
local Sway = mod:original_require("scripts/utilities/sway")
local Breed = mod:original_require("scripts/utilities/breed")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local table_contains = table.contains
    local table_remove = table.remove
    local table_size = table.size
    local math_abs = math.abs
    local math_huge = math.huge
    local unit_alive = Unit.alive
    local unit_world_position = Unit.world_position
    local unit_world_rotation = Unit.world_rotation
    local unit_get_child_units = Unit.get_child_units
    local unit_light = Unit.light
    local unit_debug_name = Unit.debug_name
    local actor_unit = Actor.unit
    local quaternion_identity = Quaternion.identity
    local quaternion_forward = Quaternion.forward
    local quaternion_matrix4x4 = Quaternion.matrix4x4
    local quaternion_look = Quaternion.look
    local matrix4x4_identity = Matrix4x4.identity
    local matrix4x4_transform = Matrix4x4.transform
    local matrix4x4_set_translation = Matrix4x4.set_translation
    local matrix4x4_set_scale = Matrix4x4.set_scale
    local vector3_box = Vector3Box
    local vector3 = Vector3
    local vector3_zero = vector3.zero
    local vector3_normalize = vector3.normalize
    local vector3_length = vector3.length
    local vector3_distance = vector3.distance
    local world_physics_world = World.physics_world
    local world_create_particles = World.create_particles
    local world_destroy_particles = World.destroy_particles
    local world_find_particles_variable = World.find_particles_variable
    local world_set_particles_variable = World.set_particles_variable
    local world_set_particles_material_vector3 = World.set_particles_material_vector3
    local world_link_particles = World.link_particles
    local world_move_particles = World.move_particles
    local physics_world_raycast = PhysicsWorld.raycast
    local light_set_casts_shadows = Light.set_casts_shadows
    local light_set_enabled = Light.set_enabled
    local pairs = pairs
    local CLASS = CLASS
    local script_unit = ScriptUnit
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local LASER_PARTICLE_EFFECT = "content/fx/particles/enemies/sniper_laser_sight"
local LASER_DOT = "content/fx/particles/enemies/red_glowing_eyes"
local LASER_LENGTH_VARIABLE_NAME = "hit_distance"
local MAX_DISTANCE = 1000
local INTERVAL = .1
local TIME = .5
local DOT_TIME = .75
local HIT_TIME = .25
local LINE_EFFECT = {
    vfx = LASER_PARTICLE_EFFECT,
    keep_aligned = true,
    link = true,
    vfx_width = .1,
    emitters = {
        vfx = {
            default = LASER_PARTICLE_EFFECT,
            start = LASER_PARTICLE_EFFECT,
        },
        interval = {
            distance = MAX_DISTANCE,
            increase = 0
        },
    },
}

mod._laser_pointer_template = {
    spot_reflector = false,
    intensity = .1,
    color_temperature = 6000,
    color_filter = vector3_box(255, 0, 0),
    cast_shadows = false,
    ies_profile = "content/environment/ies_profiles/narrow/narrow_05",
    volumetric_intensity = .001,
    spot_angle = {
        max = 1.1,
        min = 0,
    },
    falloff = {
        far = 45,
        near = 0,
    },
    flicker = FlashlightTemplates.assault.flicker,
}
mod.laser_pointer_flicker = {
	min_octave_percentage = 0.25,
	frequence_multiplier = 2,
	persistance = 3,
	chance = 0.35,
	fade_out = true,
	octaves = 8,
	duration = {
		max = 3,
		min = 2
	},
	interval = {
		max = 30,
		min = 15
	}
}
mod.laser_pointer_flicker_wild = {
	min_octave_percentage = 0.25,
	frequence_multiplier = 10,
	persistance = 3,
	chance = 1,
	fade_out = true,
	octaves = 8,
	duration = {
		max = 3,
		min = 2
	},
	interval = {
		max = 0,
		min = 0
	}
}
mod.weapon_dot = nil
mod.laser_dot = nil
mod.attached_laser_pointers = {}
mod.laser_timer = 0
mod.laser_counts = 5
mod.use_fallback = false
mod.acceptable_states = {
    "walking",
    "sliding",
    "jumping",
    "falling",
    "dodging",
    "ledge_vaulting",
}
mod.unaccetable_states = {}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

-- Compare vectors with tolerance
mod.vectors_almost_same = function(self, v1, v2, tolerance)
    if math_abs(v1[1] - v2[1]) < tolerance and math_abs(v1[2] - v2[2]) < tolerance and math_abs(v1[3] - v2[3]) < tolerance then
        return true
    end
end

-- Check if wielded slot has laser pointer attachment
mod.has_laser_pointer_attachment = function(self)
	if self.initialized then
        -- Get wielded item
		local item = self.visual_loadout_extension:item_from_slot(self.inventory_component.wielded_slot)
        -- Gear id
        local gear_id = self:get_gear_id(item)
        if gear_id and self:get_gear_setting(gear_id, "flashlight") then
            -- Check
            return self:_has_laser_pointer_attachment(item)
        end
	end
end

-- Check if item has laser pointer attachment
mod._has_laser_pointer_attachment = function(self, item)
    -- Check item
	local attachments = item and item.attachments
    attachments = attachments or item and item.__master_item and item.__master_item.attachments
	if attachments then
        -- Check laser pointer
		local laser_pointer = self:_recursive_find_attachment_name(attachments, "laser_pointer")
		return laser_pointer
	end
end

-- Get laser pointer unit of wielded weapon
mod.get_laser_pointer_unit = function(self)
    -- Get wielded weapon
	local weapon = self:get_wielded_weapon()
    -- Check weapon and laser pointer
	if weapon and self:has_laser_pointer_attachment() then
		local gear_id = self:get_gear_id(weapon.item)
        self.attached_laser_pointers[gear_id] = self.attached_laser_pointers[gear_id] or {}
		-- Check if unit set but not alive
		if table_size(self.attached_laser_pointers[gear_id]) > 0 then
			if not unit_alive(self.attached_laser_pointers[gear_id].unit_1p) or not unit_alive(self.attached_laser_pointers[gear_id].unit_3p) then
				self.attached_laser_pointers[gear_id] = {}
				self:print("get_laser_pointer_unit - laser pointer unit destroyed", self._debug_skip_some)
			end
		end
		-- Search for laser pointer unit
		if table_size(self.attached_laser_pointers[gear_id]) == 0 then
			-- self.attached_laser_pointers[gear_id] = self:_get_laser_pointer_unit(weapon.weapon_unit)
            local weapon_3p = self.visual_loadout_extension:unit_3p_from_slot("slot_secondary")
            self.attached_laser_pointers[gear_id] = {
                unit_1p = self:_get_laser_pointer_unit(weapon.weapon_unit),
                unit_3p = self:_get_laser_pointer_unit(weapon_3p),
            }
            self:set_flashlight_template(self.attached_laser_pointers[gear_id].unit_1p, self._laser_pointer_template)
            self:set_flashlight_template(self.attached_laser_pointers[gear_id].unit_3p, self._laser_pointer_template)
		end
		-- Return cached unit
		return self.attached_laser_pointers[gear_id].unit_1p, self.attached_laser_pointers[gear_id].unit_3p
	else self:print("get_laser_pointer_unit - weapon is nil", self._debug_skip_some) end
end

-- Get laser pointer unit of specified weapon unit
mod._get_laser_pointer_unit = function(self, weapon_unit)
	self:print("_get_laser_pointer_unit - searching laser pointer unit", self._debug_skip_some)
	local laser_pointer = nil
    -- Get unit children
	local children = unit_get_child_units(weapon_unit)
	if children then
        -- Iterate children
		for _, child in pairs(children) do
            -- Check for known laser pointer names
			local unit_name = unit_debug_name(child)
			if self.attachment_units[unit_name] and table_contains(self.laser_pointers, self.attachment_units[unit_name]) then
				laser_pointer = child
			else
				laser_pointer = self:_get_laser_pointer_unit(child)
			end
			if laser_pointer then break end
		end
	else self:print("_get_laser_pointer_unit - main_childs is nil", self._debug_skip_some) end
	return laser_pointer
end

-- Calculate laser end position
mod.calculate_laser_end_position = function(self)
    local laser_pointer_1p, laser_pointer_3p = self:get_laser_pointer_unit()
    local laser_pointer = laser_pointer_1p
    local is_in_third_person = self:is_in_third_person()
    if is_in_third_person then laser_pointer = laser_pointer_3p end
    if laser_pointer and unit_alive(laser_pointer) then
        -- Laser pointer position
        local laser_position = unit_world_position(laser_pointer, 2)
        local laser_rotation = unit_world_rotation(laser_pointer, 2)
        local laser_forward = quaternion_forward(laser_rotation)

        -- Camera direction
        local camera_position = Managers.state.camera:camera_position(self.player.viewport_name)
        local camera_rotation = Managers.state.camera:camera_rotation(self.player.viewport_name)
        local camera_forward = quaternion_forward(camera_rotation)
        if is_in_third_person then
            if self.first_person_extension and self.unit_data and self.weapon_extension then
                local first_person_unit = self.first_person_extension:first_person_unit()
                local shoot_rotation = unit_world_rotation(first_person_unit, 1)
                local movement_state_component = self.unit_data:read_component("movement_state")
                shoot_rotation = Recoil.apply_weapon_recoil_rotation(self.weapon_extension:recoil_template(), self.unit_data:read_component("recoil"), movement_state_component, shoot_rotation)
                shoot_rotation = Sway.apply_sway_rotation(self.weapon_extension:sway_template(), self.unit_data:read_component("sway"), movement_state_component, shoot_rotation)
                camera_forward = quaternion_forward(shoot_rotation)
                camera_position = unit_world_position(first_person_unit, 1)
            end
        end

        -- Calculate laser pointer end position
        local end_position = vector3_zero()
        local hit_position = nil
        local end_direction = nil
        local forced_fallback = self.forced_fallback or false
        local hit_actor = nil
        local camera_hit_distance = math_huge
        local big_tolerance, small_tolerance = .2, .1
        local forward_vector = nil
        if is_in_third_person then big_tolerance, small_tolerance = .4, .2 end
        if (self:vectors_almost_same(camera_forward, laser_forward, big_tolerance) or (not self.use_fallback and self:vectors_almost_same(camera_forward, laser_forward, small_tolerance))) and not forced_fallback then
            forward_vector = camera_forward
            local target_position = camera_position + forward_vector * MAX_DISTANCE
            hit_position, end_direction, _, hit_actor = self:_ray_cast(camera_position, target_position, MAX_DISTANCE)
            end_position = hit_position
            camera_hit_distance = vector3_distance(camera_position, end_position)
        else
            forced_fallback = true
            forward_vector = laser_forward
            local target_position = laser_position + laser_forward * MAX_DISTANCE
            hit_position, end_direction, _, hit_actor = self:_ray_cast(laser_position, target_position, MAX_DISTANCE)
            if hit_position then
                end_position = hit_position
            else
                end_position = laser_position + laser_forward * MAX_DISTANCE
            end
        end
        if hit_actor then
            local hit_unit = actor_unit(hit_actor)
            local side_system = Managers.state.extension:system("side_system")
            local is_enemy = side_system:is_enemy(self.player_unit, hit_unit)
            hit_actor = is_enemy
        end
        return laser_position, end_position, end_direction, forced_fallback, camera_hit_distance, hit_actor, camera_position, forward_vector
    else self:print("calculate_laser_end_position laser pointer unit nil") end
end

mod.toggle_laser_light = function(self, laser_pointer_state, retain)
    local laser_pointer_state = laser_pointer_state or self:persistent_table("weapon_customization").laser_pointer_on
    local laser_pointer_1p, laser_pointer_3p = self:get_laser_pointer_unit()
    local light_1p = unit_light(laser_pointer_1p, 1)
    local light_3p = unit_light(laser_pointer_3p, 1)
    if light_1p then
        -- Set values
        light_set_enabled(light_1p, laser_pointer_state == 2)
        light_set_casts_shadows(light_1p, self:get("mod_option_flashlight_shadows"))
    end
    if light_3p then
        -- Set values
        light_set_enabled(light_3p, laser_pointer_state == 2)
        light_set_casts_shadows(light_3p, self:get("mod_option_flashlight_shadows"))
    end
    if not retain and laser_pointer_state == 2 and self:get("mod_option_flashlight_flicker_start") then
        self.start_flicker_now = true
    end
end

-- Toggle laser pointer
mod.toggle_laser = function(self, retain, optional_value)
    if self.initialized then
        local laser_pointer_1p, laser_pointer_3p = self:get_laser_pointer_unit()
        local laser_pointer = laser_pointer_1p
        if self:is_in_third_person() then laser_pointer = laser_pointer_3p end
        if laser_pointer and unit_alive(laser_pointer) then
            local laser_pointer_state = self:persistent_table("weapon_customization").laser_pointer_on + 1
            if retain then laser_pointer_state = laser_pointer_state - 1 end
            -- Optional overwrite value
            if optional_value then
                laser_pointer_state = optional_value
            end
            -- Wrap
            if laser_pointer_state > 2 then
                laser_pointer_state = 0
            end
            -- Toggle
            if laser_pointer_state > 0 then
                -- self:despawn_dots()
                self:despawn_all_lasers()
                if not retain then self.fx_extension:trigger_wwise_event("wwise/events/player/play_foley_gear_flashlight_on", false, self.player_unit, 1) end
                if self:get("mod_option_laser_pointer_wild") and laser_pointer_state == 2 then
                    self:set_flicker_template(self.laser_pointer_flicker)
                else
                    self:set_flicker_template(self._flicker_settings)
                end
            else
                if not retain then self.fx_extension:trigger_wwise_event("wwise/events/player/play_foley_gear_flashlight_off", false, self.player_unit, 1) end
                self:despawn_all_lasers()
            end
            self:toggle_laser_light(laser_pointer_state, retain)
            self:persistent_table("weapon_customization").laser_pointer_on = laser_pointer_state
        end
    end
end

mod.world = function(self)
    return Managers.world:world("level_world")
end

mod.despawn_dots = function(self)
    if self.weapon_dot then
        world_destroy_particles(self:world(), self.weapon_dot)
        self.weapon_dot = nil
    end
    if self.laser_dot then
        world_destroy_particles(self:world(), self.laser_dot)
        self.laser_dot = nil
    end
end

-- Despawn all laser pointer particles
mod.despawn_all_lasers = function(self)
    for i, particle in pairs(self:persistent_table("weapon_customization").spawned_lasers) do
        self:despawn_laser(particle.effect_id)
    end
    self:persistent_table("weapon_customization").spawned_lasers = {}
    self:despawn_dots()
end

-- Despawn laser pointer particle
mod.despawn_laser = function(self, effect_id)
    world_destroy_particles(self:world(), effect_id)
end

-- Spawn laser pointer particle
mod.spawn_laser = function(self)
    local position, end_position = self:calculate_laser_end_position()
    self:check_fx_spawner()
    local spawner_name = "slot_primary_laser_pointer_1p"
    if self:is_in_third_person() then spawner_name = "slot_primary_laser_pointer_3p" end
    self.fx_extension:_spawn_unit_fx_line(LINE_EFFECT, true, spawner_name, end_position, true, "stop", vector3(1, 1, 1), false)
end

-- Execute raycast
mod._ray_cast = function(self, from, to, distance)
    local physics_world = world_physics_world(self:world())
    local rewind_ms = LagCompensation.rewind_ms(false, true, self.player)
	local collision_filter = "filter_player_character_shooting_projectile"
	local to_target = to - from
	local direction = vector3_normalize(to_target)
	local _, hit_position, _, _, hit_actor = physics_world_raycast(physics_world, from, direction, MAX_DISTANCE, "closest", "types", "both", "collision_filter", collision_filter, "rewind_ms", rewind_ms)

	if not hit_position then
		hit_position = from + direction * distance
	end

	local hit_distance = vector3_length(hit_position - from)

	return hit_position, direction, hit_distance, hit_actor
end

mod.reset_laser_pointer = function(self)
    self:persistent_table("weapon_customization").laser_pointer_on = 0
    self:despawn_all_lasers()
	self.laser_timer = 0
end

mod.check_fx_spawner = function(self)
    local spawner = self.fx_extension._vfx_spawners["slot_primary_laser_pointer_1p"]
    -- Unregister spawner if necessary
    if spawner and (not spawner.unit or not unit_alive(spawner.unit)) then
        self.fx_extension._vfx_spawners["slot_primary_laser_pointer_1p"] = nil
        self.fx_extension._vfx_spawners["slot_primary_laser_pointer_3p"] = nil
        spawner = nil
    end
    local laser_pointer_1p, laser_pointer_3p = mod:get_laser_pointer_unit()
    if laser_pointer_1p and laser_pointer_3p then
        -- Register spawner if necessary
        if not spawner then
            self.fx_extension._vfx_spawners["slot_primary_laser_pointer_1p"] = {
                node = 2,
                unit = laser_pointer_1p,
            }
            self.fx_extension._vfx_spawners["slot_primary_laser_pointer_3p"] = {
                node = 2,
                unit = laser_pointer_3p,
            }
        end
    end
end

mod.update_laser_pointer = function(self)
    if self:has_laser_pointer_attachment() then
        local _, changed = self:is_in_third_person()
        if changed then
            self:toggle_laser(true)
        end
        if self:character_state_changed() then
            self:toggle_laser_light(nil, true)
        end
    end
end

-- ##### ┬ ┬┌─┐┌─┐┬┌─┌─┐ ##############################################################################################
-- ##### ├─┤│ ││ │├┴┐└─┐ ##############################################################################################
-- ##### ┴ ┴└─┘└─┘┴ ┴└─┘ ##############################################################################################

mod:hook(CLASS.InventoryWeaponsView, "_equip_item", function(func, self, slot_name, item, ...)
    func(self, slot_name, item, ...)
    local ITEM_TYPES = UISettings.ITEM_TYPES
	local item_type = item.item_type
    if item_type == ITEM_TYPES.WEAPON_RANGED then
        mod:reset_laser_pointer()
    end
end)

mod:hook(CLASS.PlayerUnitFxExtension, "update", function(func, self, unit, dt, t, ...)
    if mod.initialized and unit == mod.player_unit then
        if mod:has_laser_pointer_attachment() then
            mod.use_fallback = not table_contains(mod.acceptable_states, mod.character_state_machine_extension:current_state())
            if mod:persistent_table("weapon_customization").laser_pointer_on > 0 then
                if t > mod.laser_timer then
                    if #mod:persistent_table("weapon_customization").spawned_lasers < mod.laser_counts then
                        mod:spawn_laser()
                        mod.laser_timer = t + INTERVAL
                    end
                end
            else
                mod:despawn_all_lasers()
            end
        else
            mod:despawn_all_lasers()
        end
    end
    func(self, unit, dt, t, ...)
end)

mod:hook(CLASS.PlayerUnitFxExtension, "post_update", function(func, self, unit, dt, t, ...)
    if mod.initialized and unit == mod.player_unit then
        local laser_pointer_1p, laser_pointer_3p = mod:get_laser_pointer_unit()
        local laser_pointer = laser_pointer_1p
        local is_in_third_person = mod:is_in_third_person()
        if is_in_third_person then laser_pointer = laser_pointer_3p end
        if laser_pointer and unit_alive(laser_pointer) then

            if #mod:persistent_table("weapon_customization").spawned_lasers > 0 then
                local aligned_vfx = self._aligned_vfx
                -- Get end position
                local position, end_position, direction, forced_fallback, camera_hit_distance, hit_actor = mod:calculate_laser_end_position()
                -- Set distance
                local distance = vector3_distance(position, end_position)
                local variable_index = world_find_particles_variable(self._world, LASER_PARTICLE_EFFECT, LASER_LENGTH_VARIABLE_NAME)
                -- Dot
                local laser_position = unit_world_position(laser_pointer, 1)
                local weapon_dot_position = laser_position + direction * .05
                if not mod.weapon_dot and mod:get("mod_option_laser_pointer_weapon_dot") then
                    mod.weapon_dot = world_create_particles(self._world, LASER_DOT, vector3_zero(), quaternion_identity())
                end
                if mod.weapon_dot then
                    local unit_world_pose = matrix4x4_identity()
	                matrix4x4_set_translation(unit_world_pose, vector3(0, .065, 0))
                    matrix4x4_set_scale(unit_world_pose, vector3(.5, .5, .5))
                    world_link_particles(self._world, mod.weapon_dot, laser_pointer, 2, unit_world_pose, "destroy")
                    world_set_particles_material_vector3(self._world, mod.weapon_dot, "eye_glow", "trail_color", vector3(0, 0, 0))
                end
                if not mod.laser_dot then
                    mod.laser_dot = world_create_particles(self._world, LASER_DOT, end_position)
                    world_set_particles_material_vector3(self._world, mod.laser_dot, "eye_glow", "trail_color", vector3(0, 0, 0))
                else
                    local laser_pos = end_position
                    if not mod.use_fallback and not forced_fallback then
                        local camera_position = Managers.state.camera:camera_position(mod.player.viewport_name)
                        local camera_rotation = Managers.state.camera:camera_rotation(mod.player.viewport_name)
                        local camera_forward = quaternion_forward(camera_rotation)
                        local distance_target = 6
                        if mod.laser_hit and t < mod.laser_hit then distance_target = 10 end
                        if not is_in_third_person then
                            if hit_actor then
                                laser_pos = camera_position + camera_forward * (2 / mod:get("mod_option_laser_pointer_dot_size"))
                            elseif camera_hit_distance < distance_target then
                                laser_pos = camera_position + camera_forward * (camera_hit_distance / mod:get("mod_option_laser_pointer_dot_size"))
                            else
                                laser_pos = camera_position + camera_forward * (distance_target / mod:get("mod_option_laser_pointer_dot_size"))
                            end
                        elseif is_in_third_person then
                            local distance = vector3_distance(camera_position, end_position)
                            local to_camera = end_position - camera_position
                            local to_camera_direction = vector3_normalize(to_camera)
                            laser_pos = laser_pos - to_camera_direction * distance
                            if hit_actor then
                                laser_pos = laser_pos + to_camera_direction * (2 / mod:get("mod_option_laser_pointer_dot_size"))
                            elseif camera_hit_distance < distance_target then
                                laser_pos = laser_pos + to_camera_direction * (camera_hit_distance / mod:get("mod_option_laser_pointer_dot_size"))
                            else
                                laser_pos = laser_pos + to_camera_direction * (distance_target / mod:get("mod_option_laser_pointer_dot_size"))
                            end
                        end
                        if mod.laser_hit and t > mod.laser_hit then
                            mod.laser_hit = nil
                        end
                    end
                    world_move_particles(self._world, mod.laser_dot, laser_pos)
                end

                -- Iterate particles
                for i, particle in pairs(mod:persistent_table("weapon_customization").spawned_lasers) do
                    -- Check how old particle
                    if t > particle.end_time then
                        -- Despawn effect
                        mod:despawn_laser(particle.effect_id)
                        table_remove(mod:persistent_table("weapon_customization").spawned_lasers, i)
                    else
                        -- Update particle effect
                        world_set_particles_variable(self._world, particle.effect_id, variable_index, vector3(.1, distance, distance))
                        -- Update end position
                        for index, data in pairs(aligned_vfx.buffer) do
                            if data.particle_id == particle.effect_id then
                                data.end_position:store(end_position)
                            end
                        end
                    end
                end
            else
                mod:despawn_all_lasers()
            end
        end
    end
    func(self, unit, dt, t, ...)
end)

mod:hook(CLASS.HudElementCrosshair, "_draw_widgets", function(func, self, dt, t, input_service, ui_renderer, render_settings, ...)
    if mod:get("mod_option_deactivate_crosshair") and mod:has_laser_pointer_attachment() and mod:persistent_table("weapon_customization").laser_pointer_on > 0 then
        if self._widget then self._widget.visible = false end
    else
        if self._widget then self._widget.visible = true end
    end
    func(self, dt, t, input_service, ui_renderer, render_settings, ...)
end)

mod:hook(CLASS.PlayerUnitFxExtension, "_create_particles_wrapper", function(func, self, world, particle_name, position, rotation, scale, ...)
    local effect_id = func(self, world, particle_name, position, rotation, scale, ...)
    if particle_name == LASER_PARTICLE_EFFECT then
        mod:persistent_table("weapon_customization").spawned_lasers[#mod:persistent_table("weapon_customization").spawned_lasers+1] = {
            effect_id = effect_id,
            end_time = mod.time_manager:time("gameplay") + TIME,
        }
    end
    return effect_id
end)

-- ##### ┌─┐┌─┐┬  ┬  ┌─┐┬ ┬  ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌ #######################################################################
-- ##### ├┤ │ ││  │  │ ││││  │││├┤ ├─┤├─┘│ ││││ #######################################################################
-- ##### └  └─┘┴─┘┴─┘└─┘└┴┘  └┴┘└─┘┴ ┴┴  └─┘┘└┘ #######################################################################

mod:hook(CLASS.ActionVentOverheat, "start", function(func, self, action_settings, t, time_scale, action_start_params, ...)
    mod.forced_fallback = true
    func(self, action_settings, t, time_scale, action_start_params, ...)
end)

mod:hook(CLASS.ActionVentOverheat, "finish", function(func, self, reason, data, t, time_in_action, ...)
    mod.forced_fallback = false
    func(self, reason, data, t, time_in_action, ...)
end)

mod:hook(CLASS.ActionReloadShotgun, "start", function(func, self, action_settings, t, time_scale, ...)
    mod.forced_fallback = true
    func(self, action_settings, t, time_scale, ...)
end)

mod:hook(CLASS.ActionReloadShotgun, "finish", function(func, self, reason, data, t, time_in_action, ...)
    mod.forced_fallback = false
    func(self, reason, data, t, time_in_action, ...)
end)

mod:hook(CLASS.ActionReloadState, "start", function(func, self, action_settings, t, time_scale, ...)
    mod.forced_fallback = true
    func(self, action_settings, t, time_scale, ...)
end)

mod:hook(CLASS.ActionReloadState, "finish", function(func, self, reason, data, t, time_in_action, ...)
    mod.forced_fallback = false
    func(self, reason, data, t, time_in_action, ...)
end)

mod:hook(CLASS.ActionInspect, "start", function(func, self, action_settings, ...)
    mod.forced_fallback = true
    func(self, action_settings, ...)
end)

mod:hook(CLASS.ActionInspect, "finish", function(func, self, reason, data, t, time_in_action, ...)
    mod.forced_fallback = false
    func(self, reason, data, t, time_in_action, ...)
end)

-- ##### ┬ ┬┬┌┬┐  ┬┌┐┌┌┬┐┬┌─┐┌─┐┌┬┐┌─┐┬─┐  ┌─┐┬  ┌─┐┌─┐┬ ┬ ############################################################
-- ##### ├─┤│ │   ││││ ││││  ├─┤ │ │ │├┬┘  ├┤ │  ├─┤└─┐├─┤ ############################################################
-- ##### ┴ ┴┴ ┴   ┴┘└┘─┴┘┴└─┘┴ ┴ ┴ └─┘┴└─  └  ┴─┘┴ ┴└─┘┴ ┴ ############################################################

mod:hook(CLASS.AttackReportManager, "add_attack_result", function(func, self, damage_profile, attacked_unit, attacking_unit, attack_direction, hit_world_position, hit_weakspot, damage,
	attack_result, attack_type, damage_efficiency, ...)
	-- local player = mod:player_from_unit(attacking_unit)
	if attacking_unit == mod.player_unit and mod:get("mod_option_laser_pointer_hit_indicator") then
		local unit_data_extension = script_unit.has_extension(attacked_unit, "unit_data_system")
		local breed_or_nil = unit_data_extension and unit_data_extension:breed()
		local target_is_minion = breed_or_nil and Breed.is_minion(breed_or_nil)

        if target_is_minion then
            if mod.laser_dot then
                world_destroy_particles(mod:world(), mod.laser_dot)
                mod.laser_dot = nil
                mod.laser_hit = mod.time_manager:time("gameplay") + HIT_TIME

                local player_unit_data_extension = ScriptUnit.has_extension(attacking_unit, "unit_data_system")
                local critical_strike_component = player_unit_data_extension:read_component("critical_strike")
                mod.laser_hit_critical = critical_strike_component.is_active

                mod.laser_hit_weakspot = hit_weakspot
            end
        end
    end
	-- Original function
	return func(self, damage_profile, attacked_unit, attacking_unit, attack_direction, hit_world_position, hit_weakspot, damage, attack_result, attack_type, damage_efficiency, ...)
end)

-- ##### ┬┌┐┌┬┌┬┐┬┌─┐┬  ┬┌─┐┌─┐ #######################################################################################
-- ##### │││││ │ │├─┤│  │┌─┘├┤  #######################################################################################
-- ##### ┴┘└┘┴ ┴ ┴┴ ┴┴─┘┴└─┘└─┘ #######################################################################################

mod:despawn_all_lasers()
