local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local WeaponTemplate = mod:original_require("scripts/utilities/weapon/weapon_template")
    local UIHud = mod:original_require("scripts/managers/ui/ui_hud")
    local Recoil = mod:original_require("scripts/utilities/recoil")
    local Sway = mod:original_require("scripts/utilities/sway")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local Unit = Unit
    local math = math
    local Unit = Unit
    local class = class
    local table = table
    local World = World
    local Camera = Camera
    local wc_perf = wc_perf
    local vector3 = Vector3
    local managers = Managers
    local math_abs = math.abs
    local Matrix4x4 = Matrix4x4
    local unit_alive = Unit.alive
    local Quaternion = Quaternion
    local vector3_box = Vector3Box
    local math_random = math.random
    local vector3_zero = vector3.zero
    local vector3_lerp = vector3.lerp
    local unit_get_data = Unit.get_data
    local quaternion_box = QuaternionBox
    local table_contains = table.contains
    local vector3_unbox = vector3_box.unbox
    local math_easeOutCubic = math.easeOutCubic
    local math_easeInCubic = math.easeInCubic
    local quaternion_unbox = quaternion_box.unbox
    local unit_world_position = Unit.world_position
    local unit_world_rotation = Unit.world_rotation
    local unit_local_position = Unit.local_position
    local unit_local_rotation = Unit.local_rotation
    local quaternion_identity = Quaternion.identity
    local quaternion_multiply = Quaternion.multiply
    local matrix4x4_transform = Matrix4x4.transform
    local unit_animation_event = Unit.animation_event
    local unit_set_local_scale = Unit.set_local_scale
    local unit_get_child_units = Unit.get_child_units
    local quaternion_matrix4x4 = Quaternion.matrix4x4
    local quaternion_to_vector = Quaternion.to_vector
    local math_ease_out_elastic = math.ease_out_elastic
    local camera_world_to_screen = Camera.world_to_screen
    local quaternion_from_vector = Quaternion.from_vector
    local unit_set_local_position = Unit.set_local_position
    local unit_set_local_rotation = Unit.set_local_rotation
    local unit_has_animation_event = Unit.has_animation_event
    local unit_set_unit_visibility = Unit.set_unit_visibility
    local quaternion_to_euler_angles_xyz = Quaternion.to_euler_angles_xyz
    local world_update_unit_and_children = World.update_unit_and_children
    local quaternion_from_euler_angles_xyz = Quaternion.from_euler_angles_xyz
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local CROUCH_TIME = .5
    local SLOT_SECONDARY = "slot_secondary"
    local IGNORE_STATES = {"ledge_vaulting"}
    local CROSSHAIR_POSITION_LERP_SPEED = 35
    local CROUCH_ROTATION = vector3_box(0, -60, 0)
    local CROUCH_POSITION = vector3_box(-.05, 0, -.2)
--#endregion

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
    -- Events
    managers.event:register(self, "weapon_customization_settings_changed", "on_settings_changed")
    -- Settings
    self:on_settings_changed()
    -- Init
    self.initialized = true
end

CrouchAnimationExtension.delete = function(self)
    -- Events
    managers.event:unregister(self, "weapon_customization_settings_changed")
    -- Init
    self.initialized = false
    -- Delete
    CrouchAnimationExtension.super.delete(self)
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

CrouchAnimationExtension.on_settings_changed = function(self)
    self.on = mod:get("mod_option_misc_cover_on_crouch")
end

CrouchAnimationExtension.on_wield_slot = function(self, slot)
    -- Template
    self.weapon_template = slot and WeaponTemplate.weapon_template_from_item(slot.item)
    -- Ranged weapon
    self.ranged_weapon = slot and slot.name == SLOT_SECONDARY
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
        if not self:is_braced() then
            self:update_animation(dt, t)
        end
    end
    wc_perf.stop(perf)
end

-- Update animation
CrouchAnimationExtension.update_animation = function(self, dt, t)
    if self.initialized and self:get_first_person() then
        -- Get parameters
        local is_aiming = self:is_aiming()
        local is_crouching = self.movement_state_component.is_crouching
        local state_valid = not table_contains(IGNORE_STATES, self.character_state)

        -- Start animation
        if self.ranged_weapon and is_crouching and state_valid and not is_aiming and not self.is_crouched and not self.overwrite then
            -- Start crouch animation
            self.is_crouched = true
            self.sound_played = nil
            self.crouch_end = t + CROUCH_TIME
        elseif (not is_crouching or not state_valid or is_aiming or self.overwrite or not self.ranged_weapon) and self.is_crouched then
            -- Start uncrouch animation
            self.is_crouched = false
            self.sound_played = nil
            self.crouch_end = t + CROUCH_TIME
        end

        -- Null init
        local rotation = quaternion_from_vector(vector3_zero())
        local position = vector3_zero()

        -- Update animation
        if self.crouch_end and self.crouch_end > t then
            -- Play equipment sound
            if not self.sound_played then
                mod:execute_extension(self.player_unit, "visible_equipment_system", "play_equipment_sound", nil, nil, true, true)
                self.sound_played = true
            end
            -- Lerp values
            local progress = (self.crouch_end - t) / CROUCH_TIME
            local anim_progress = math_ease_out_elastic(1 - progress)
            if progress > .7 then anim_progress = math_easeOutCubic(1 - progress) end
            if not self.is_crouched then anim_progress = math_easeInCubic(progress) end
            rotation = quaternion_from_vector(vector3_unbox(CROUCH_ROTATION) * anim_progress)
            position = vector3_unbox(CROUCH_POSITION) * anim_progress

        elseif self.crouch_end and self.crouch_end <= t then
            -- Unset timer
            self.crouch_end = nil
        end

        -- Set crouch values
        if self.is_crouched and not self.crouch_end then
            rotation = quaternion_from_vector(vector3_unbox(CROUCH_ROTATION))
            position = vector3_unbox(CROUCH_POSITION)
        end

        -- Save values
        self.position = vector3_box(position)
        self.rotation = quaternion_box(rotation)

        -- Set position and rotation
        self:set_position_and_rotation(position, rotation)
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

return CrouchAnimationExtension
