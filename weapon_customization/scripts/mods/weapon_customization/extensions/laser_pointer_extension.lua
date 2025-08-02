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
local AttackSettings = mod:original_require("scripts/settings/damage/attack_settings")
local VisualLoadoutCustomization = mod:original_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local math = math
    local Unit = Unit
    local table = table
    local Actor = Actor
    local World = World
    local Color = Color
    local pairs = pairs
    local CLASS = CLASS
    local vector3 = Vector3
    local get_mod = get_mod
    local math_abs = math.abs
    local managers = Managers
    local Matrix4x4 = Matrix4x4
    local unit_alive = Unit.alive
    local actor_unit = Actor.unit
    local Quaternion = Quaternion
    local vector3_box = Vector3Box
    local script_unit = ScriptUnit
    local table_clear = table.clear
    local DebugDrawer = DebugDrawer
    local vector3_zero = vector3.zero
    local vector3_lerp = vector3.lerp
    local table_contains = table.contains
    local math_easeCubic = math.easeCubic
    local unit_world_pose = Unit.world_pose
    local matrix4x4_scale = Matrix4x4.scale
    local vector3_unbox = vector3_box.unbox
    local vector3_distance = vector3.distance
    local vector3_normalize = vector3.normalize
    local quaternion_forward = Quaternion.forward
    local matrix4x4_multiply = Matrix4x4.multiply
    local matrix4x4_identity = Matrix4x4.identity
    local matrix4x4_rotation = Matrix4x4.rotation
    local quaternion_multiply = Quaternion.multiply
    local unit_world_position = Unit.world_position
    local unit_world_rotation = Unit.world_rotation
    local quaternion_identity = Quaternion.identity
    local matrix4x4_transform = Matrix4x4.transform
    local matrix4x4_set_scale = Matrix4x4.set_scale
    local world_physics_world = World.physics_world
    local world_link_particles = World.link_particles
    local world_move_particles = World.move_particles
    local physics_world_raycast = PhysicsWorld.raycast
    local matrix4x4_translation = Matrix4x4.translation
    local quaternion_from_vector = Quaternion.from_vector
    local world_create_particles = World.create_particles
    local world_destroy_particles = World.destroy_particles
    local matrix4x4_set_translation = Matrix4x4.set_translation
    local world_set_particles_variable = World.set_particles_variable
    local world_stop_spawning_particles = World.stop_spawning_particles
    local world_find_particles_variable = World.find_particles_variable
    local world_set_particles_use_custom_fov = World.set_particles_use_custom_fov
    local world_set_particles_material_vector3 = World.set_particles_material_vector3
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"
local SLOT_SECONDARY = "slot_secondary"
local LASER_PARTICLE_EFFECT = "content/fx/particles/enemies/sniper_laser_sight"
local LASER_DOT = "content/fx/particles/enemies/red_glowing_eyes"
local LOCK_TIME = .15
local LOCK_TOLERANCE = .5
local MAX_DISTANCE = 1000
local LINE_EFFECT = {
    vfx = LASER_PARTICLE_EFFECT,
    keep_aligned = true,
    link = true,
    vfx_width = .1,
    emitters = {
        vfx = {default = LASER_PARTICLE_EFFECT, start = LASER_PARTICLE_EFFECT},
        interval = {distance = MAX_DISTANCE, increase = 0},
    },
}
local SPAWNER_NAME = "slot_secondary_laser_pointer_1p"
local SPAWNER_NAME_3P = "slot_secondary_laser_pointer_3p"
local LOCK_STATES = {"walking", "sliding", "jumping", "falling", "dodging", "ledge_vaulting"}
local SWAY_MULTIPLIER = 2.5
local SWAY_MULTIPLIER_AIMING = 5
-- local CROUCH_OPTION = "mod_option_crouch_animation"

-- ##### ┬  ┌─┐┌─┐┌─┐┬─┐  ┌─┐┌─┐┬┌┐┌┌┬┐┌─┐┬─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ #############################################
-- ##### │  ├─┤└─┐├┤ ├┬┘  ├─┘│ │││││ │ ├┤ ├┬┘  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ #############################################
-- ##### ┴─┘┴ ┴└─┘└─┘┴└─  ┴  └─┘┴┘└┘ ┴ └─┘┴└─  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ #############################################

local LaserPointerExtension = class("LaserPointerExtension", "WeaponCustomizationExtension")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

LaserPointerExtension.init = function(self, extension_init_context, unit, extension_init_data)
    LaserPointerExtension.super.init(self, extension_init_context, unit, extension_init_data)

    self.weapon_fov_mod = get_mod("weapon_fov")
    self.weapon_fov_mod_hooked = false
    -- self:hook_weapon_fov_mod()
	self.laser_pointer_unit = extension_init_data.flashlight_unit_1p
	self.laser_pointer_unit_3p = extension_init_data.flashlight_unit_3p
    -- if self:is_weapon_fov_installed() then
    --     Unit.set_shader_pass_flag_for_meshes_in_unit_and_childs(self.laser_pointer_unit, "custom_fov", false)
    -- end
    self.on = extension_init_data.on or self.is_local_unit and mod:flashlight_active() or false
    local wielded_slot = extension_init_data.wielded_slot
    self.wielded = wielded_slot and wielded_slot.name == SLOT_SECONDARY
    self.weapon_fov_last_mode = nil
    self.end_position = vector3_box(vector3_zero())
    self.hit_position = vector3_box(vector3_zero())
    self.hit_direction = vector3_box(vector3_zero())
    self.hit_actor = nil
    self.hit_distance = nil
    self.lock = nil
    self.lock_timer = nil
    self.laser_effect_ids = {}
    self.last_lock = {
        end_position = vector3_box(vector3_zero()),
        hit_position = vector3_box(vector3_zero()),
        hit_distance = vector3_box(vector3_zero()),
        hit_direction = vector3_box(vector3_zero()),
        hit_actor = vector3_box(vector3_zero()),
    }
    self.last_unlock = {
        end_position = vector3_box(vector3_zero()),
        hit_position = vector3_box(vector3_zero()),
        hit_distance = vector3_box(vector3_zero()),
        hit_direction = vector3_box(vector3_zero()),
        hit_actor = vector3_box(vector3_zero()),
    }
    self.dot_weapon_effect_id = nil
    self.dot_eccect_id = nil
    self.hit_marker_dots = {}

    managers.event:register(self, "weapon_customization_cutscene", "set_cutscene")
    managers.event:register(self, "weapon_customization_respawn_laser_pointers", "respawn_all")

    self:on_settings_changed()

    self.initialized = true
end

mod:hook(Unit, "set_shader_pass_flag_for_meshes_in_unit_and_childs", function(func, unit, name, value, ...)
	func(unit, name, value, ...)
    if managers.event and name == "custom_fov" then managers.event:trigger("weapon_customization_respawn_laser_pointers") end
end)

LaserPointerExtension.delete = function(self)
    managers.event:unregister(self, "weapon_customization_cutscene")
    managers.event:unregister(self, "weapon_customization_respawn_laser_pointers")
    self.initialized = false
    self.on = false
    self:despawn_laser()
    self:despawn_weapon_dot()
    self:despawn_laser_dot()
end

-- ##### ┌─┐┌─┐┌┬┐  ┬  ┬┌─┐┬  ┬ ┬┌─┐┌─┐ ###############################################################################
-- ##### │ ┬├┤  │   └┐┌┘├─┤│  │ │├┤ └─┐ ###############################################################################
-- ##### └─┘└─┘ ┴    └┘ ┴ ┴┴─┘└─┘└─┘└─┘ ###############################################################################

LaserPointerExtension.get_laser_pointer_unit = function(self)
    if self:get_first_person() then
        return self.laser_pointer_unit
    end
    return self.laser_pointer_unit_3p
end

LaserPointerExtension.get_spawner_name = function(self)
    if self:get_first_person() then
        return SPAWNER_NAME
    end
    return SPAWNER_NAME_3P
end

LaserPointerExtension.sway_multiplier = function(self)
    if self:is_aiming() then
        return SWAY_MULTIPLIER_AIMING
    end
    return SWAY_MULTIPLIER
end

LaserPointerExtension.is_aiming = function(self)
	return self.alternate_fire_component and self.alternate_fire_component.is_active
end

LaserPointerExtension.is_active = function(self)
    return self:is_wielded() and self.on
end

LaserPointerExtension.is_wielded = function(self)
    return self.wielded
end

LaserPointerExtension.is_braced = function(self)
    local template = self.ranged_weapon.weapon_template
    local alt_fire = template and template.alternate_fire_settings
    local braced = alt_fire and alt_fire.start_anim_event == "to_braced"
    return braced
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

LaserPointerExtension.update_all = function(self, dt, t)
    if self.initialized then
        self:update_lock(dt, t)
        self:update_character_state(dt, t)
        self:update_weapon_fov(dt, t)
        self:update_laser_end_point(dt, t)
        self:update_laser(dt, t)
    end
end

LaserPointerExtension.update = function(self, dt, t)
    self:update_all(dt, t)
    self.last_first_person = self:get_first_person()
end

LaserPointerExtension.update_lock = function(self, dt, t)
    self.lock = table_contains(LOCK_STATES, self.character_state and self.character_state.name or "")
    -- mod:echo((self.character_state and self.character_state.name or "").." -> "..tostring(self.lock))
    -- local is_crouching = self.movement_state_component and self.movement_state_component.is_crouching
    -- if mod:get(CROUCH_OPTION) and is_crouching then
    --     self.lock = false
    -- end
    if self.lock_overwrite ~= nil then
        self.lock = self.lock_overwrite
    end
end

LaserPointerExtension.update_character_state = function(self, dt, t)
    if self.character_state_extension then
        self.character_state = self.character_state_extension:current_state()
        self.character_state_was_changed = self.character_state ~= self.last_character_state
        if self.character_state_was_changed then
            self.last_character_state = self.character_state
        end
    end
end

LaserPointerExtension.target_fallback = function(self)
    local laser_pointer_unit = self:get_laser_pointer_unit()
    local laser_position = unit_world_position(laser_pointer_unit, 2)
    local laser_rotation = unit_world_rotation(laser_pointer_unit, 2)
    local laser_forward = quaternion_forward(laser_rotation)
    return vector3(laser_position + laser_forward * MAX_DISTANCE)
end

LaserPointerExtension.update_laser_end_point = function(self, dt, t)
    local laser_pointer_unit = self:get_laser_pointer_unit()
    local first_person = self:get_first_person()

    if self.initialized and laser_pointer_unit and unit_alive(laser_pointer_unit) then
        --#region Get data
            -- Laser pointer position
            local laser_position = unit_world_position(laser_pointer_unit, 2)
            local laser_rotation = unit_world_rotation(laser_pointer_unit, 2)
            local laser_forward = quaternion_forward(laser_rotation)

            -- Sway
            local aiming = not self:is_aiming() or mod:get("mod_option_misc_sway_aim")
            local sway = aiming and mod:execute_extension(self.player_unit, "sway_system", "offset_rotation")
            sway = (sway and vector3_unbox(sway) or vector3_zero()) * self:sway_multiplier()
            local sway_rotation = quaternion_from_vector(sway)

            -- Camera direction
            local camera_position = laser_position
            -- local camera_rotation = laser_rotation
            local camera_rotation = quaternion_multiply(laser_rotation, sway_rotation)
            local camera_forward = quaternion_forward(camera_rotation)
            local player_viewport = self.player.viewport_name
            if managers.state.camera:has_camera(player_viewport) then
                camera_position = managers.state.camera:camera_position(player_viewport)
                -- camera_rotation = managers.state.camera:camera_rotation(player_viewport)
                camera_rotation = quaternion_multiply(managers.state.camera:camera_rotation(player_viewport), sway_rotation)
                camera_forward = quaternion_forward(camera_rotation)
            end
            if not first_person then
                local shoot_rotation = unit_world_rotation(self.first_person_unit, 1)
                if self.weapon_extension and self.unit_data then
                    local movement_state_component = self.unit_data:read_component("movement_state")
                    shoot_rotation = Recoil.apply_weapon_recoil_rotation(self.weapon_extension:recoil_template(), self.unit_data:read_component("recoil"), movement_state_component, shoot_rotation)
                    shoot_rotation = Sway.apply_sway_rotation(self.weapon_extension:sway_template(), self.unit_data:read_component("sway"), movement_state_component, shoot_rotation)
                    shoot_rotation = quaternion_multiply(shoot_rotation, sway_rotation)
                end
                camera_forward = quaternion_forward(shoot_rotation)
                camera_position = unit_world_position(self.first_person_unit, 1)
            end
        --#endregion

        local target_position = camera_position + camera_forward * MAX_DISTANCE
        self:do_ray_cast(camera_position, target_position, MAX_DISTANCE)
        self.end_position:store(self.hit_position and vector3_unbox(self.hit_position) or target_position)

        if self.lock and self:get_vectors_almost_same(camera_forward, laser_forward, LOCK_TOLERANCE) then
            -- self.last_lock = {
            --     end_position = self.end_position,
            --     hit_position = self.hit_position,
            --     hit_distance = self.hit_distance,
            --     hit_direction = self.hit_direction,
            --     hit_actor = self.hit_actor,
            -- }
            self.last_lock.end_position = self.end_position
            self.last_lock.hit_position = self.hit_position
            self.last_lock.hit_distance = self.hit_distance
            self.last_lock.hit_direction = self.hit_direction
            self.last_lock.hit_actor = self.hit_actor

            if self.lock_timer and self.lock_timer >= t and self.last_unlock then
                local progress = (self.lock_timer - t) / LOCK_TIME
                local anim_progress = math_easeCubic(1 - progress)
                local lock_position = vector3_unbox(self.last_unlock.end_position)
                local lerp_end_position = vector3_lerp(lock_position, target_position, anim_progress)
                self.end_position:store(lerp_end_position)
            elseif self.lock_timer and self.lock_timer < t then
                self.lock_timer = nil
            end
            self.unlock_timer = t + LOCK_TIME

        else
            target_position = laser_position + laser_forward * MAX_DISTANCE
            self.end_position:store(target_position)

            -- self.last_unlock = {
            --     end_position = self.end_position,
            --     hit_position = self.hit_position,
            --     hit_distance = self.hit_distance,
            --     hit_direction = self.hit_direction,
            --     hit_actor = self.hit_actor,
            -- }
            self.last_unlock.end_position = self.end_position
            self.last_unlock.hit_position = self.hit_position
            self.last_unlock.hit_distance = self.hit_distance
            self.last_unlock.hit_direction = self.hit_direction
            self.last_unlock.hit_actor = self.hit_actor

            if self.unlock_timer and self.unlock_timer >= t and self.last_lock then
                local progress = (self.unlock_timer - t) / LOCK_TIME
                local anim_progress = math_easeCubic(1 - progress)
                local lock_position = vector3_unbox(self.last_lock.end_position)
                local lerp_end_position = vector3_lerp(lock_position, target_position, anim_progress)
                self.end_position:store(lerp_end_position)
                if not self:get_vectors_almost_same(camera_forward, laser_forward, LOCK_TOLERANCE) then
                    self.unlock_timer = nil
                    self.end_position:store(target_position)
                end
            elseif self.unlock_timer and self.unlock_timer < t then
                self.unlock_timer = nil
            end
            self.lock_timer = t + LOCK_TIME
        end

    end
end

LaserPointerExtension.update_effect_fov = function(self, effect_id)
    if self:is_weapon_fov_installed() and self:get_first_person() then
        world_set_particles_use_custom_fov(self.world, effect_id, false)
    end
end

LaserPointerExtension.update_laser = function(self, dt, t)
    local first_person = self:get_first_person()
    local braced = mod:execute_extension(self.player_unit, "sight_system", "is_braced")
    local deactivate = self.deactivate_laser_aiming and self:is_aiming()
    if deactivate and first_person and not braced then
        self:despawn_all()
    elseif self.initialized then
        self:spawn_all()
        self:update_laser_particle(dt, t)
        self:update_laser_dot(dt, t)
        self:update_weapon_dot(dt, t)
    end
end

LaserPointerExtension.update_laser_particle = function(self, dt, t)
    if self.last_first_person ~= self:get_first_person() then
        self:despawn_laser()
        self:spawn_laser()
    end
    if self.initialized and self.fx_extension then
        local aligned_vfx = self.fx_extension._aligned_vfx
        local distance = self.hit_distance or MAX_DISTANCE
        local laser_pointer_unit = self:get_laser_pointer_unit()
        local laser_position = unit_world_position(laser_pointer_unit, 2)
        local end_position = vector3_unbox(self.end_position)
        local hit_direction = vector3_unbox(self.hit_direction)
        -- local first_person = self:get_first_person()
        local variable_index = world_find_particles_variable(self.world, LASER_PARTICLE_EFFECT, "hit_distance")
        -- self.fx_extension:_update_aligned_vfx()
        -- self.fx_extension:_update_aligned_vfx()
        for laser_index, laser_effect_id in pairs(self.laser_effect_ids) do
            -- local scale = .1
            -- if laser_index / self.laser_count > .66 then
            --     scale = .025
            -- elseif laser_index / self.laser_count > .33 then
            --     scale = .05
            -- elseif laser_index > 2 then
            --     scale = .075
            -- end
            local rotation = Quaternion.look(end_position - laser_position)
            -- mod:echo("rotation: "..tostring(rotation))
		    World.move_particles(self.world, laser_effect_id, laser_position, rotation)
            world_set_particles_variable(self.world, laser_effect_id, variable_index, vector3(.02, distance, .5))
            self:update_effect_fov(laser_effect_id)
            -- -- Weapon FOV compatibility
            -- if self:is_weapon_fov_installed() and first_person then
            --     world_set_particles_use_custom_fov(self.world, laser_effect_id, false)
            -- end
            -- Weapon FOV compatibility
            -- local first_person = not self:get_first_person()
            -- if self:is_weapon_fov_installed() and first_person then
            
            -- end
            -- Update end position
            for index, data in pairs(aligned_vfx.buffer) do
                if data.particle_id == laser_effect_id then
                    data.end_position:store(end_position)
                end
            end
        end
        
        -- for laser_index, laser_effect_id in pairs(self.laser_effect_ids) do
        --     -- world_set_particles_use_custom_fov(self.world, laser_effect_id, false)
        --     -- -- Weapon FOV compatibility
        --     -- if self:is_weapon_fov_installed() and first_person then
        --     --     world_set_particles_use_custom_fov(self.world, laser_effect_id, false)
        --     -- end
        --     self:update_effect_fov(laser_effect_id)
        -- end
    end
end

LaserPointerExtension.update_laser_dot = function(self, dt, t)
    if self.initialized and self.laser_dot_effect_id then
        local laser_pointer_unit = self:get_laser_pointer_unit()
        if not laser_pointer_unit or not unit_alive(laser_pointer_unit) then
            return
        end
        local first_person = self:get_first_person()
        local end_position = vector3_unbox(self.end_position)
        local distance_target = 6

        local aiming = not self:is_aiming() or mod:get("mod_option_misc_sway_aim")
        local sway = aiming and mod:execute_extension(self.player_unit, "sway_system", "offset_rotation")
        sway = (sway and vector3_unbox(sway) or vector3_zero()) * (self:sway_multiplier() * .8)
        local sway_rotation = quaternion_from_vector(sway)
        local camera_position = unit_world_position(laser_pointer_unit, 2)
        -- local camera_rotation = unit_world_rotation(laser_pointer_unit, 2)
        local camera_rotation = quaternion_multiply(unit_world_rotation(laser_pointer_unit, 2), sway_rotation)
        local camera_forward = quaternion_forward(camera_rotation)
        if self.lock and first_person then
            if managers.state.camera:has_camera(self.player.viewport_name) then
                camera_position = managers.state.camera:camera_position(self.player.viewport_name)
                -- camera_rotation = managers.state.camera:camera_rotation(self.player.viewport_name)
                camera_rotation = quaternion_multiply(managers.state.camera:camera_rotation(self.player.viewport_name), sway_rotation)
            end
            camera_forward = quaternion_forward(camera_rotation)
            if self.hit_enemy then
                end_position = camera_position + camera_forward * (2 / self.laser_dot_size)
            elseif self.hit_distance < distance_target then
                end_position = camera_position + camera_forward * (self.hit_distance / self.laser_dot_size)
            else
                end_position = camera_position + camera_forward * (distance_target / self.laser_dot_size)
            end
        elseif self.lock then
            end_position = vector3_unbox(self.hit_position)

            if managers.state.camera:has_camera(self.player.viewport_name) then
                camera_position = managers.state.camera:camera_position(self.player.viewport_name)
                camera_rotation = quaternion_multiply(managers.state.camera:camera_rotation(self.player.viewport_name), sway_rotation)
            -- elseif managers.state.camera:has_camera(mod.player.viewport_name) then
            --     camera_position = managers.state.camera:camera_position(mod.player.viewport_name)
            end
            -- camera_position = unit_world_position(self.first_person_unit, 1)
            local distance = vector3_distance(camera_position, end_position)
            local to_camera = end_position - camera_position
            local to_camera_direction = vector3_normalize(to_camera)
            end_position = end_position - to_camera_direction * distance
            if self.hit_enemy then
                end_position = end_position + to_camera_direction * (2 / self.laser_dot_size)
            elseif self.hit_distance < distance_target then
                end_position = end_position + to_camera_direction * (self.hit_distance / self.laser_dot_size)
            else
                end_position = end_position + to_camera_direction * (distance_target / self.laser_dot_size)
            end
        end

        -- if self:is_weapon_fov_installed() and first_person then
        --     world_set_particles_use_custom_fov(self.world, self.laser_dot_effect_id, false)
        -- end
        -- self:update_effect_fov(self.laser_dot_effect_id)

        world_move_particles(self.world, self.laser_dot_effect_id, end_position)
    end
end

LaserPointerExtension.update_weapon_dot = function(self, dt, t)
    if self.last_first_person ~= self:get_first_person() then
        self:despawn_weapon_dot()
        self:spawn_weapon_dot()
    end
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

LaserPointerExtension.do_ray_cast = function(self, from, to, distance)
	local to_target = to - from
	local direction = vector3_normalize(to_target)
	local _, hit_position, _, _, hit_actor = physics_world_raycast(self.physics_world,
        from, direction, MAX_DISTANCE, "closest", "types", "both",
        "collision_filter", "filter_player_character_shooting_projectile", "rewind_ms", LagCompensation.rewind_ms(false, true, self.player))
	if not hit_position then
		hit_position = from + direction * distance
	end
    self.hit_distance = vector3_distance(from, hit_position)
    self.hit_position:store(hit_position)
    self.hit_direction:store(direction)
    self.hit_actor = hit_actor
    local hit_unit = self.hit_actor and actor_unit(self.hit_actor)
    self.hit_enemy = hit_unit and self.side_extension and self.side_extension:is_enemy(self.player_unit, hit_unit)
end

LaserPointerExtension.despawn_all = function(self)
    self:despawn_laser()
    self:despawn_weapon_dot()
    self:despawn_laser_dot()
end

LaserPointerExtension.spawn_all = function(self)
    self:spawn_laser()
    self:spawn_weapon_dot()
    self:spawn_laser_dot()
end

LaserPointerExtension.respawn_all = function(self)
    self:despawn_all()
    if self:is_active() then
        self:spawn_all()
    end
end

LaserPointerExtension.spawn_laser = function(self)
    local common = self.initialized and self.fx_extension
    local husk = self.is_local_unit or (self.team_lasers or self.spectated)
    local particle = #self.laser_effect_ids == 0
    local slot = self:is_wielded()
    if self.on and common and particle and husk and slot then
        self:set_fx_spawner()
        local spawner_name = self:get_spawner_name()
        local unit = self.fx_extension._vfx_spawners[spawner_name][VisualLoadoutCustomization.ROOT_ATTACH_NAME].unit
        if unit and unit_alive(unit) then
            self.end_position:store(self.end_position and vector3_unbox(self.end_position) or self:target_fallback())
            for i = 1, self.laser_count do
                self.fx_extension:_spawn_unit_fx_line(LINE_EFFECT, true, spawner_name, vector3_unbox(self.end_position), false, "destroy", vector3(1, 1, 1), false)
            end
        end
    end
end

LaserPointerExtension.spawn_laser_setup = function(self, effect_id)
    self.laser_effect_ids[#self.laser_effect_ids+1] = effect_id
    self:update_effect_fov(effect_id)
end

-- LaserPointerExtension.set_shader_pass_flag_for_meshes_in_unit_and_childs = function(self)

-- end

-- mod:hook(Unit, "set_shader_pass_flag_for_meshes_in_unit_and_childs", function(func, unit, name, value, ...)
-- 	func(unit, name, value, ...)

-- end)

-- mod:hook(CLASS.PlayerUnitFxExtension, "_spawn_unit_particles", function(func, self, particle_name, spawner_name, link, orphaned_policy, position_offset, rotation_offset, scale, create_network_index, ...)
mod:hook(CLASS.PlayerUnitFxExtension, "_spawn_unit_particles", function(func, self, particle_name, spawner_name, link, orphaned_policy, position_offset, rotation_offset, scale, create_network_index, optional_attachment_name, ...)
    -- Original function
    local effect_id = func(self, particle_name, spawner_name, link, orphaned_policy, position_offset, rotation_offset, scale, create_network_index, ...)
    -- Check if laser particle and initialize
    if particle_name == LASER_PARTICLE_EFFECT and (spawner_name == SPAWNER_NAME or spawner_name == SPAWNER_NAME_3P) then
        mod:execute_extension(self._unit, "laser_pointer_system", "spawn_laser_setup", effect_id)
    end
    -- Return
    return effect_id
end)

LaserPointerExtension.despawn_laser = function(self)
    local count = #self.laser_effect_ids
    for _, laser_effect_id in pairs(self.laser_effect_ids) do
        if laser_effect_id > 0 then
            world_stop_spawning_particles(self.world, laser_effect_id)
            world_destroy_particles(self.world, laser_effect_id)
        end
    end
    table_clear(self.laser_effect_ids)
end

LaserPointerExtension.spawn_weapon_dot = function(self)
    local common = self.initialized
    local particle = not self.dot_weapon_effect_id
    local husk = self.is_local_unit or (self.team_lasers or self.spectated)
    local slot = self:is_wielded()
    if self.on and common and particle and self.weapon_dot and husk and slot then
        local unit_world_pose = matrix4x4_identity()
        local laser_pointer_unit = self:get_laser_pointer_unit()
        if laser_pointer_unit and unit_alive(laser_pointer_unit) then
            local laser_position = unit_world_position(laser_pointer_unit, 1)
            local first_person = self:get_first_person()

            self.dot_weapon_effect_id = world_create_particles(self.world, LASER_DOT, vector3_zero(), quaternion_identity())
            matrix4x4_set_translation(unit_world_pose, vector3(0, .065, 0))
            matrix4x4_set_scale(unit_world_pose, vector3(.01, .01, .01))
            world_link_particles(self.world, self.dot_weapon_effect_id, laser_pointer_unit, 2, unit_world_pose, "destroy")
            world_set_particles_material_vector3(self.world, self.dot_weapon_effect_id, "eye_socket", "material_variable_21872256", vector3(1, 0, 0))
            world_set_particles_material_vector3(self.world, self.dot_weapon_effect_id, "eye_glow", "trail_color", vector3(0, 0, 0))
            world_set_particles_material_vector3(self.world, self.dot_weapon_effect_id, "eye_flash_init", "material_variable_21872256", vector3(.01, 0, 0))

            self:update_effect_fov(self.dot_weapon_effect_id)
        end
    end
end

LaserPointerExtension.despawn_weapon_dot = function(self)
    if self.dot_weapon_effect_id and self.dot_weapon_effect_id > 0 then
        world_stop_spawning_particles(self.world, self.dot_weapon_effect_id)
        world_destroy_particles(self.world, self.dot_weapon_effect_id)
    end
    self.dot_weapon_effect_id = nil
end

LaserPointerExtension.spawn_laser_dot = function(self)
    local common = self.initialized
    local particle = not self.laser_dot_effect_id
    local husk = self.is_local_unit or (self.team_lasers or self.spectated)
    local slot = self:is_wielded()
    if self.on and common and particle and self.end_position and husk and slot then
        local end_position = vector3_unbox(self.end_position)
        self.laser_dot_effect_id = world_create_particles(self.world, LASER_DOT, end_position)

        local distance = vector3_distance(unit_world_position(self.first_person_unit, 1), end_position) - .5
        local unit_world_pose = matrix4x4_identity()
        matrix4x4_set_translation(unit_world_pose, vector3(0, distance, 0))
        matrix4x4_set_scale(unit_world_pose, vector3(.1, .1, .1) * self.hit_indicator_size)
        world_link_particles(self.world, self.laser_dot_effect_id, self.first_person_unit, 1, unit_world_pose, "destroy")
        world_set_particles_material_vector3(self.world, self.laser_dot_effect_id, "eye_socket", "material_variable_21872256", vector3(1, 0, 0))
        world_set_particles_material_vector3(self.world, self.laser_dot_effect_id, "eye_glow", "trail_color", vector3(0, 0, 0))
        world_set_particles_material_vector3(self.world, self.laser_dot_effect_id, "eye_flash_init", "material_variable_21872256", vector3(.1, 0, 0))

        self:update_effect_fov(self.laser_dot_effect_id)
    end
end

LaserPointerExtension.despawn_laser_dot = function(self)
    if self.laser_dot_effect_id and self.laser_dot_effect_id > 0 then
        world_stop_spawning_particles(self.world, self.laser_dot_effect_id)
        world_destroy_particles(self.world, self.laser_dot_effect_id)
    end
    self.laser_dot_effect_id = nil
end

-- ##### ┌─┐┌─┐┌┬┐  ┬  ┬┌─┐┬  ┬ ┬┌─┐┌─┐ ###############################################################################
-- ##### └─┐├┤  │   └┐┌┘├─┤│  │ │├┤ └─┐ ###############################################################################
-- ##### └─┘└─┘ ┴    └┘ ┴ ┴┴─┘└─┘└─┘└─┘ ###############################################################################

LaserPointerExtension.set_spectated = function(self, spectated)
    self.spectated = spectated
end

LaserPointerExtension.set_enabled = function(self, value)
    self.on = value --or self.on
    self:respawn_all()
end

LaserPointerExtension.set_lock = function(self, value, delay_time)
    self.lock_time_overwrite = delay_time and LOCK_TIME + delay_time
    self.lock_overwrite = value
end

LaserPointerExtension.set_fx_spawner = function(self)
    if self.fx_extension then
        local vfx_spawner_1p = self.fx_extension._vfx_spawners[SPAWNER_NAME] and self.fx_extension._vfx_spawners[SPAWNER_NAME][VisualLoadoutCustomization.ROOT_ATTACH_NAME]
        if not vfx_spawner_1p then
            self.fx_extension._vfx_spawners[SPAWNER_NAME] = {
                [VisualLoadoutCustomization.ROOT_ATTACH_NAME] = {
                    node = 2,
                    node_3p = 2,
                    unit = self.laser_pointer_unit,
                }
            }
        else
            -- local vfx_spawner_1p = self.fx_extension._vfx_spawners[SPAWNER_NAME][VisualLoadoutCustomization.ROOT_ATTACH_NAME]
            vfx_spawner_1p.unit = self.laser_pointer_unit
            vfx_spawner_1p.node = 2
            vfx_spawner_1p.node_3p = 2
        end
        local vfx_spawner_3p = self.fx_extension._vfx_spawners[SPAWNER_NAME_3P] and self.fx_extension._vfx_spawners[SPAWNER_NAME_3P][VisualLoadoutCustomization.ROOT_ATTACH_NAME]
        if not vfx_spawner_3p then
            self.fx_extension._vfx_spawners[SPAWNER_NAME_3P] = {
                [VisualLoadoutCustomization.ROOT_ATTACH_NAME] = {
                    node = 2,
                    node_3p = 2,
                    unit = self.laser_pointer_unit_3p,
                }
            }
        else
            -- local vfx_spawner_3p = self.fx_extension._vfx_spawners[SPAWNER_NAME_3P][VisualLoadoutCustomization.ROOT_ATTACH_NAME]
            vfx_spawner_3p.unit = self.laser_pointer_unit_3p
            vfx_spawner_3p.node = 2
            vfx_spawner_3p.node_3p = 2
        end
    end
end

LaserPointerExtension.set_cutscene = function(self, is_cutscene)
    self.cut_scene = is_cutscene
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

LaserPointerExtension.on_settings_changed = function(self)
    self.weapon_dot = mod:get("mod_option_laser_pointer_weapon_dot")
    self.laser_dot_size = mod:get("mod_option_laser_pointer_dot_size")
    self.laser_count_team = mod:get("mod_option_laser_pointer_count_others")
    self.laser_count = not self.is_local_unit and self.laser_count_team or mod:get("mod_option_laser_pointer_count")
    self.team_lasers = mod:get("mod_option_randomization_laser_pointer")
    self.hit_indicator_size = mod:get("mod_option_laser_pointer_hit_indicator_size")
    self.deactivate_laser_aiming = mod:get("mod_option_deactivate_laser_aiming")
    self:respawn_all()
end

LaserPointerExtension.on_wield_slot = function(self, slot)
    self.wielded = slot.name == SLOT_SECONDARY
    self:respawn_all()
end

LaserPointerExtension.on_unwield_slot = function(self, slot)
    if slot.name == SLOT_SECONDARY then
        self.wielded = false
        self:despawn_all()
    end
end

-- ##### ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌  ┌─┐┌─┐┬  ┬  ┌─┐┌─┐┌┬┐┌─┐┌─┐┌┬┐┬┌┐ ┬┬  ┬┌┬┐┬ ┬ ############################################
-- ##### │││├┤ ├─┤├─┘│ ││││  ├┤ │ │└┐┌┘  │  │ ││││├─┘├─┤ │ │├┴┐││  │ │ └┬┘ ############################################
-- ##### └┴┘└─┘┴ ┴┴  └─┘┘└┘  └  └─┘ └┘   └─┘└─┘┴ ┴┴  ┴ ┴ ┴ ┴└─┘┴┴─┘┴ ┴  ┴  ############################################

LaserPointerExtension.is_weapon_fov_installed = function(self)
    if self.weapon_fov_installed == nil then
        self.weapon_fov_installed = not not self.weapon_fov_mod
    end
    return self.weapon_fov_installed
end

LaserPointerExtension.update_weapon_fov = function(self)
    if self:is_weapon_fov_installed() then
        local current_fov_mode = self.weapon_fov_mod:get("fov_mode")
        if current_fov_mode ~= self.weapon_fov_last_mode then
            self:respawn_all()
            self.weapon_fov_last_mode = current_fov_mode
        end
    end
end

-- ##### ┌─┐┬  ┌─┐┌┐ ┌─┐┬   ###########################################################################################
-- ##### │ ┬│  │ │├┴┐├─┤│   ###########################################################################################
-- ##### └─┘┴─┘└─┘└─┘┴ ┴┴─┘ ###########################################################################################

mod.preview_laser = {}

mod.toggle_laser_pointer = function(self)
    self:execute_extension(self.player_unit, "laser_pointer_system", "on_toggle")
end

mod.has_laser_pointer = function(self, item)
    local laser_pointer = self.gear_settings:get(item, "flashlight")
	return laser_pointer and laser_pointer == "laser_pointer"
end

-- Toggle laser pointer
mod.set_preview_laser = function(self, state, laser_pointer_unit, world)
    if state and laser_pointer_unit and world then
        local previews = self.preview_laser[laser_pointer_unit]
        if not previews then
            previews = {}

            local pose = matrix4x4_identity()
            local spawner_pose = unit_world_pose(laser_pointer_unit, 2)
            local spawn_pose = matrix4x4_multiply(pose, spawner_pose)
            local local_player_unit = managers.player:local_player(1).player_unit
            local LASER_COUNT = mod:get("mod_option_laser_pointer_count")
            for i = 1, LASER_COUNT do
                previews[#previews+1] = world_create_particles(world, LASER_PARTICLE_EFFECT,
                    matrix4x4_translation(spawn_pose), matrix4x4_rotation(spawn_pose), matrix4x4_scale(spawn_pose))
                world_link_particles(world, previews[#previews], laser_pointer_unit, 2, pose, "destroy")
            end
            self.preview_laser[laser_pointer_unit] = previews
        end
    elseif not state and laser_pointer_unit and self.preview_laser[laser_pointer_unit] and world then
        local previews = self.preview_laser[laser_pointer_unit]
        for _, preview_id in pairs(previews) do
            if preview_id > 0 then
                world_stop_spawning_particles(world, preview_id)
                world_destroy_particles(world, preview_id)
            end
        end
        self.preview_laser[laser_pointer_unit] = nil
    end
end

return LaserPointerExtension
