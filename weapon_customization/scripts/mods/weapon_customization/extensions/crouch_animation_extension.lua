local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local WeaponTemplate = mod:original_require("scripts/utilities/weapon/weapon_template")
local UIHud = mod:original_require("scripts/managers/ui/ui_hud")
local Recoil = mod:original_require("scripts/utilities/recoil")
local Sway = mod:original_require("scripts/utilities/sway")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local class = class
    local Unit = Unit
    local unit_has_animation_event = Unit.has_animation_event
    local unit_animation_event = Unit.animation_event
    local table = table
    local table_contains = table.contains
    local wc_perf = wc_perf
    local managers = Managers

    local math = math
    local math_abs = math.abs
    local math_ease_out_elastic = math.ease_out_elastic
    local math_easeInCubic = math.easeInCubic
	local math_easeOutCubic = math.easeOutCubic
    local math_random = math.random
    local Unit = Unit
    local unit_get_data = Unit.get_data
    local unit_alive = Unit.alive
    local unit_world_position = Unit.world_position
    local unit_world_rotation = Unit.world_rotation
    local unit_local_position = Unit.local_position
    local unit_set_local_position = Unit.set_local_position
    local unit_local_rotation = Unit.local_rotation
    local unit_set_local_rotation = Unit.set_local_rotation
    local unit_set_local_scale = Unit.set_local_scale
    local unit_set_unit_visibility = Unit.set_unit_visibility
    local unit_get_child_units = Unit.get_child_units
    local Quaternion = Quaternion
    local quaternion_box = QuaternionBox
	local quaternion_unbox = quaternion_box.unbox
    local quaternion_identity = Quaternion.identity
    local quaternion_from_euler_angles_xyz = Quaternion.from_euler_angles_xyz
    local quaternion_to_euler_angles_xyz = Quaternion.to_euler_angles_xyz
    local quaternion_multiply = Quaternion.multiply
    local quaternion_matrix4x4 = Quaternion.matrix4x4
    local Matrix4x4 = Matrix4x4
    local matrix4x4_transform = Matrix4x4.transform
    local vector3_box = Vector3Box
    local vector3_unbox = vector3_box.unbox
    local vector3 = Vector3
    local vector3_zero = vector3.zero
    local vector3_lerp = vector3.lerp
    local Camera = Camera
    local camera_world_to_screen = Camera.world_to_screen
    local World = World
    local world_update_unit_and_children = World.update_unit_and_children
    local quaternion_to_vector = function(quaternion)
        local x, y, z = quaternion_to_euler_angles_xyz(quaternion)
        return vector3(x, y, z)
    end
    local quaternion_from_vector = function(vector)
        return quaternion_from_euler_angles_xyz(vector[1], vector[2], vector[3])
    end
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local CROUCH_OPTION = "mod_option_misc_cover_on_crouch"
local CROUCH_TIME = .5
local CROUCH_POSITION = vector3_box(-.05, 0, -.2)
local CROUCH_ROTATION = vector3_box(0, -60, 0)
local IGNORE_STATES = {"ledge_vaulting"}
local CROSSHAIR_POSITION_LERP_SPEED = 35

-- ##### ┌─┐┬─┐┌─┐┬ ┬┌─┐┬ ┬  ┌─┐┌┐┌┬┌┬┐┌─┐┌┬┐┬┌─┐┌┐┌  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ######################################
-- ##### │  ├┬┘│ ││ ││  ├─┤  ├─┤│││││││├─┤ │ ││ ││││  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ######################################
-- ##### └─┘┴└─└─┘└─┘└─┘┴ ┴  ┴ ┴┘└┘┴┴ ┴┴ ┴ ┴ ┴└─┘┘└┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ######################################

local CrouchAnimationExtension = class("CrouchAnimationExtension", "WeaponCustomizationExtension")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

-- Initialize
CrouchAnimationExtension.init = function(self, extension_init_context, unit, extension_init_data)
    CrouchAnimationExtension.super.init(self, extension_init_context, unit, extension_init_data)

    managers.event:register(self, "weapon_customization_settings_changed", "on_settings_changed")

    self:on_settings_changed()

    self.initialized = true
end

CrouchAnimationExtension.delete = function(self)
    managers.event:unregister(self, "weapon_customization_settings_changed")
    self.initialized = false
    CrouchAnimationExtension.super.delete(self)
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

CrouchAnimationExtension.on_settings_changed = function(self)
    self.on = mod:get(CROUCH_OPTION)
end

CrouchAnimationExtension.on_wield_slot = function(self, slot)
    self.weapon_template = slot and WeaponTemplate.weapon_template_from_item(slot.item)
end

-- ##### ┌─┐┌─┐┌┬┐  ┬  ┬┌─┐┬  ┬ ┬┌─┐┌─┐ ###############################################################################
-- ##### │ ┬├┤  │   └┐┌┘├─┤│  │ │├┤ └─┐ ###############################################################################
-- ##### └─┘└─┘ ┴    └┘ ┴ ┴┴─┘└─┘└─┘└─┘ ###############################################################################

CrouchAnimationExtension.is_aiming = function(self)
    return self.alternate_fire_component and self.alternate_fire_component.is_active
end

CrouchAnimationExtension.is_braced = function(self)
    local template = self.weapon_template
    local alt_fire = template and template.alternate_fire_settings
    local braced = alt_fire and alt_fire.start_anim_event == "to_braced"
    return braced
end

-- CrouchAnimationExtension.is_active = function(self)
--     return self.is_crouched and not self.overwrite and not self:is_aiming()
-- end

-- ##### ┌─┐┌─┐┌┬┐  ┬  ┬┌─┐┬  ┬ ┬┌─┐┌─┐ ###############################################################################
-- ##### └─┐├┤  │   └┐┌┘├─┤│  │ │├┤ └─┐ ###############################################################################
-- ##### └─┘└─┘ ┴    └┘ ┴ ┴┴─┘└─┘└─┘└─┘ ###############################################################################

CrouchAnimationExtension.set_spectated = function(self, spectated)
    if self.initialized then
        self.spectated = spectated
    end
end

CrouchAnimationExtension.set_overwrite = function(self, overwrite)
    if self.initialized then
        self.overwrite = overwrite
    end
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

-- Update character state to check for ignore states
CrouchAnimationExtension.update_character_state = function(self)
    self.character_state = self.character_state_extension and self.character_state_extension:current_state()
end

-- Update
CrouchAnimationExtension.update = function(self, dt, t)
    local perf = wc_perf.start("CrouchAnimationExtension.update", 2)
    if self.initialized and self.on and self:get_first_person() then
        self:update_character_state()

        if self:is_braced() then
            if self.movement_state_component.is_crouching and not table_contains(IGNORE_STATES, self.character_state) and not self.overwrite then
                if unit_has_animation_event(self.first_person_unit, "to_braced") and not self.is_crouched then
                    unit_animation_event(self.first_person_unit, "to_braced")
                    self.is_crouched = true
                end
            else
                if unit_has_animation_event(self.first_person_unit, "to_unaim_braced") and self.is_crouched then
                    unit_animation_event(self.first_person_unit, "to_unaim_braced")
                    self.is_crouched = nil
                end
            end
        else
            self:update_animation(dt, t)
        end

    end
    wc_perf.stop(perf)
end

-- Update animation
CrouchAnimationExtension.update_animation = function(self, dt, t)
    local position = unit_local_position(self.first_person_unit, 1)
    self.last_real_position = vector3_box(position)
    local rotation = unit_local_rotation(self.first_person_unit, 1)
    self.last_real_rotation = quaternion_box(rotation)
    if self.initialized then
        local is_aiming = self:is_aiming()
        local is_crouching = self.movement_state_component.is_crouching
        local state_valid = not table_contains(IGNORE_STATES, self.character_state)

        -- if self.pause then return end

        if is_crouching and state_valid and not is_aiming and not self.is_crouched and not self.overwrite then
            self.is_crouched = true
            self.sound_played = nil
            self.crouch_end = t + CROUCH_TIME
        elseif (not is_crouching or not state_valid or is_aiming or self.overwrite) and self.is_crouched then
            self.is_crouched = false
            self.sound_played = nil
            self.crouch_end = t + CROUCH_TIME
        end

        -- local position = unit_local_position(self.first_person_unit, 1)
        -- self.last_real_position = vector3_box(position)
        -- local rotation = unit_local_rotation(self.first_person_unit, 1)
        -- self.last_real_rotation = quaternion_box(rotation)

        local rotation = vector3_zero()
        local position = vector3_zero()
        if self.crouch_end and self.crouch_end > t then
            if not self.sound_played then
                mod:execute_extension(self.player_unit, "visible_equipment_system", "play_equipment_sound", nil, nil, true, true)
                self.sound_played = true
            end
            local progress = (self.crouch_end - t) / CROUCH_TIME
            local anim_progress = math_ease_out_elastic(1 - progress)
            if progress > .7 then anim_progress = math_easeOutCubic(1 - progress) end
            if not self.is_crouched then
                anim_progress = math_easeInCubic(progress)
            end
            rotation = quaternion_from_vector(vector3_unbox(CROUCH_ROTATION) * anim_progress)
            position = vector3_unbox(CROUCH_POSITION) * anim_progress

        elseif self.crouch_end and self.crouch_end <= t then
            self.crouch_end = nil
        end

        if self.is_crouched and not self.crouch_end then
            rotation = quaternion_from_vector(vector3_unbox(CROUCH_ROTATION))
            position = vector3_unbox(CROUCH_POSITION)
        end

        self.position = vector3_box(position)
        self.rotation = quaternion_box(rotation)

        if (self.is_crouched or self.crouch_end) then
            self:set_position_and_rotation(position, rotation)
            -- unit_set_local_rotation(self.first_person_unit, 1, quaternion_multiply(rotation, self.rotation))
            -- local mat = quaternion_matrix4x4(rotation)
            -- local rotated_pos = matrix4x4_transform(mat, self.position)
            -- unit_set_local_position(self.first_person_unit, 1, position + rotated_pos)
            -- world_update_unit_and_children(self.world, self.first_person_unit)
        end
    end
end

CrouchAnimationExtension.set_position_and_rotation = function(self, offset_position, offset_rotation)
    if offset_position and offset_rotation then
        local position = unit_local_position(self.first_person_unit, 1)
        local rotation = unit_local_rotation(self.first_person_unit, 1)
        -- Rotation
        unit_set_local_rotation(self.first_person_unit, 1, quaternion_multiply(rotation, offset_rotation))
        -- Position
        local mat = quaternion_matrix4x4(rotation)
        local rotated_pos = matrix4x4_transform(mat, offset_position)
        unit_set_local_position(self.first_person_unit, 1, position + rotated_pos)
        world_update_unit_and_children(self.world, self.first_person_unit)
    end
end

CrouchAnimationExtension.crosshair_position = function(self, hud_element_crosshair, dt, t, ui_renderer)
	local target_x = 0
	local target_y = 0
	local ui_renderer_scale = ui_renderer.scale
	local parent = hud_element_crosshair._parent
	local player_extensions = parent:player_extensions()
	local weapon_extension = player_extensions and player_extensions.weapon
	local player_camera = parent:player_camera()

    if weapon_extension and player_camera then
		local unit_data_extension = player_extensions.unit_data
		local first_person_extention = player_extensions.first_person
		local first_person_unit = first_person_extention:first_person_unit()
		local shoot_rotation = unit_world_rotation(first_person_unit, 1)
        
        -- Adjust position
        local offset_position = self.position and vector3_unbox(self.position) or vector3_zero()
        -- mod:echot("self.position: "..tostring(self.position), 2)
        local mat = quaternion_matrix4x4(shoot_rotation)
        local rotated_pos = matrix4x4_transform(mat, offset_position)

		local shoot_position = unit_world_position(first_person_unit, 1) - rotated_pos
		local recoil_template = weapon_extension:recoil_template()
		local recoil_component = unit_data_extension:read_component("recoil")
		local movement_state_component = unit_data_extension:read_component("movement_state")
		shoot_rotation = Recoil.apply_weapon_recoil_rotation(recoil_template, recoil_component, movement_state_component, shoot_rotation)
		local sway_component = unit_data_extension:read_component("sway")
		local sway_template = weapon_extension:sway_template()
		shoot_rotation = Sway.apply_sway_rotation(sway_template, sway_component, movement_state_component, shoot_rotation)
		local range = 50
		local shoot_direction = Quaternion.forward(shoot_rotation)
		local world_aim_position = shoot_position + shoot_direction * range
		local screen_aim_position = Camera.world_to_screen(player_camera, world_aim_position)
		local abs_target_x = screen_aim_position.x
		local abs_target_y = screen_aim_position.y
		local pivot_position = hud_element_crosshair:scenegraph_world_position("pivot", ui_renderer_scale)
		local pivot_x = pivot_position[1]
		local pivot_y = pivot_position[2]
		target_x = abs_target_x - pivot_x
		target_y = abs_target_y - pivot_y
	end

	local current_x = hud_element_crosshair._crosshair_position_x * ui_renderer_scale
	local current_y = hud_element_crosshair._crosshair_position_y * ui_renderer_scale
	local ui_renderer_inverse_scale = ui_renderer.inverse_scale
	local lerp_t = math.min(CROSSHAIR_POSITION_LERP_SPEED * dt, 1)
	local x = math.lerp(current_x, target_x, lerp_t) * ui_renderer_inverse_scale
	local y = math.lerp(current_y, target_y, lerp_t) * ui_renderer_inverse_scale
	hud_element_crosshair._crosshair_position_y = y
	hud_element_crosshair._crosshair_position_x = x

	return x, y
end

CrouchAnimationExtension.adjust_crosshair = function(self, hud_element_crosshair, x, y)
    -- local x, y = self:crosshair_position(hud_element_crosshair, dt, t, ui_renderer)
    local widget = hud_element_crosshair._widget
	if widget then
        local offset_position = self.position and vector3_unbox(self.position) or vector3_zero()
		local widget_offset = widget.offset
		widget_offset[1] = x
        y = y - offset_position[3]
		widget_offset[2] = y
        return x, y
    end
    return x, y
end

-- CrouchAnimationExtension.crosshair_position = function(self, x, y)
--     local position = self.position and vector3_unbox(self.position) or vector3_zero()
--     mod:echot("diff: "..tostring(position[3]), 2)
--     return x, y + position[3] * 10 or 0
-- end

-- CrouchAnimationExtension.pause = function(self)
--     if self.initialized then
--         -- self.pause = true
--         local position = self.last_real_position and vector3_unbox(self.last_real_position)
--         if position and vector3.is_valid(position) then
--             unit_set_local_position(self.first_person_unit, 1, position)
--             mod:echot("set")
--         end
--         local rotation = self.last_real_rotation and quaternion_unbox(self.last_real_rotation)
--         if rotation and Quaternion.is_valid(position) then unit_set_local_rotation(self.first_person_unit, 1, rotation) end
--     end
-- end

-- CrouchAnimationExtension.resume = function(self)
--     if self.initialized then
--         -- self.pause = false
--         local position = self.position and vector3_unbox(self.position) or vector3_zero()
--         local rotation = self.rotation and quaternion_unbox(self.rotation) or vector3_zero()
--         self:set_position_and_rotation(position, rotation)
--     end
-- end

return CrouchAnimationExtension
