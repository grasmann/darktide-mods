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
    local Unit = Unit
    local math = math
    local Unit = Unit
    local class = class
    local table = table
    local World = World
    local Camera = Camera
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

local SLOT_SECONDARY = "slot_secondary"
local SWAY_OPTION = "mod_option_misc_sway"
local SWAY_OPTION_AIM = "mod_option_misc_sway_aim"
local CROSSHAIR_POSITION_LERP_SPEED = 35

-- ##### ┌─┐┬ ┬┌─┐┬ ┬  ┌─┐┌┐┌┬┌┬┐┌─┐┌┬┐┬┌─┐┌┐┌  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ############################################
-- ##### └─┐│││├─┤└┬┘  ├─┤│││││││├─┤ │ ││ ││││  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ############################################
-- ##### └─┘└┴┘┴ ┴ ┴   ┴ ┴┘└┘┴┴ ┴┴ ┴ ┴ ┴└─┘┘└┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ############################################

local SwayAnimationExtension = class("SwayAnimationExtension", "WeaponCustomizationExtension")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

-- Initialize
SwayAnimationExtension.init = function(self, extension_init_context, unit, extension_init_data)
    SwayAnimationExtension.super.init(self, extension_init_context, unit, extension_init_data)

    managers.event:register(self, "weapon_customization_settings_changed", "on_settings_changed")

    self.position = vector3_box(vector3_zero())
    self.rotate_animation = vector3_box(vector3_zero())

    self:on_settings_changed()

    self.initialized = true
end

SwayAnimationExtension.delete = function(self)
    managers.event:unregister(self, "weapon_customization_settings_changed")
    self.initialized = false
    SwayAnimationExtension.super.delete(self)
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

SwayAnimationExtension.on_settings_changed = function(self)
    self.on = mod:get(SWAY_OPTION)
    self.on_aim = mod:get(SWAY_OPTION_AIM)
end

SwayAnimationExtension.on_wield_slot = function(self, slot)
    self.weapon_template = slot and WeaponTemplate.weapon_template_from_item(slot.item)
    self.ranged_weapon = slot and slot.name == SLOT_SECONDARY
end

-- ##### ┌─┐┌─┐┌┬┐  ┬  ┬┌─┐┬  ┬ ┬┌─┐┌─┐ ###############################################################################
-- ##### │ ┬├┤  │   └┐┌┘├─┤│  │ │├┤ └─┐ ###############################################################################
-- ##### └─┘└─┘ ┴    └┘ ┴ ┴┴─┘└─┘└─┘└─┘ ###############################################################################

SwayAnimationExtension.is_aiming = function(self)
    return self.alternate_fire_component and self.alternate_fire_component.is_active
end

SwayAnimationExtension.is_braced = function(self)
    local template = self.weapon_template
    local alt_fire = template and template.alternate_fire_settings
    local braced = alt_fire and alt_fire.start_anim_event == "to_braced"
    return braced
end

-- ##### ┌─┐┌─┐┌┬┐  ┬  ┬┌─┐┬  ┬ ┬┌─┐┌─┐ ###############################################################################
-- ##### └─┐├┤  │   └┐┌┘├─┤│  │ │├┤ └─┐ ###############################################################################
-- ##### └─┘└─┘ ┴    └┘ ┴ ┴┴─┘└─┘└─┘└─┘ ###############################################################################

SwayAnimationExtension.set_spectated = function(self, spectated)
    if self.initialized then
        self.spectated = spectated
    end
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

-- Update
SwayAnimationExtension.update = function(self, dt, t)
    if self.initialized and self.on and self:get_first_person() then
        self:update_animation(dt, t)
    end
end

-- Update animation
SwayAnimationExtension.update_animation = function(self, dt, t)
    -- local position = unit_local_position(self.first_person_unit, 1)
    -- self.last_real_position = vector3_box(unit_local_position(self.first_person_unit, 1))
    

    local not_aiming_or_braced = not self:is_aiming() or self:is_braced()
    if self.initialized and self:get_first_person() and (not_aiming_or_braced or self.on_aim) and self.first_person_unit and unit_alive(self.first_person_unit) then
        -- Get rotation
        local original_rotation = unit_local_rotation(self.first_person_unit, 1)
        local last_player_rotation = self.last_real_rotation and quaternion_unbox(self.last_real_rotation) or original_rotation
        local rotation_diff = quaternion_to_vector(last_player_rotation) - quaternion_to_vector(original_rotation)
        local pitch_diff = (Quaternion.pitch(last_player_rotation) - Quaternion.pitch(original_rotation)) * 5
        self.last_real_rotation = quaternion_box(original_rotation)

        local rotation = vector3_zero()
        local position = vector3_zero()
        local new_rotation = quaternion_identity()
        local new_position = vector3_zero()
        local current_rotation = self.rotate_animation and vector3_unbox(self.rotate_animation)
        local current = current_rotation or vector3_zero()

        local yaw = rotation_diff[3]
        -- reduce the yaw  
        yaw = yaw % 360;
        -- force it to be the positive remainder, so that 0 <= yaw < 360  
        yaw = (yaw + 360) % 360;  
        -- force into the minimum absolute value residue class, so that -180 < yaw <= 180  
        if yaw > 180 then yaw = yaw - 360 end
        yaw = yaw * .1
        yaw = yaw * -1

        local mat = quaternion_matrix4x4(quaternion_from_vector(rotation))
        local rotated_pos = matrix4x4_transform(mat, vector3(pitch_diff, 0, yaw))

        current = current + rotated_pos * .25
        current = current - current * (dt * 8)

        for i = 1, 3 do
            current[i] = math.clamp(current[i], -2.5, 2.5)
        end

        local new_euler_rotation = quaternion_from_vector(current)
        new_rotation = Quaternion.multiply(quaternion_from_vector(rotation), new_euler_rotation)
        new_position = position + vector3(current[3] * .75, 0, current[1]) * .05

        self.position:store(new_position)

        self:set_position_and_rotation(new_position, new_rotation)

        self.rotate_animation:store(current)
    end
end

SwayAnimationExtension.offset_position = function(self)
    return self.position
end

SwayAnimationExtension.offset_rotation = function(self)
    return self.rotate_animation
end

SwayAnimationExtension.set_position_and_rotation = function(self, offset_position, offset_rotation)
    if offset_position and offset_rotation and self.first_person_unit and unit_alive(self.first_person_unit) then
        local position = unit_local_position(self.first_person_unit, 1)
        local rotation = unit_local_rotation(self.first_person_unit, 1)
        -- Rotation
        unit_set_local_rotation(self.first_person_unit, 1, quaternion_multiply(rotation, offset_rotation))
        -- Position
        local mat = quaternion_matrix4x4(rotation)
        local rotated_pos = matrix4x4_transform(mat, offset_position)
        -- mod:info("SwayAnimationExtension.set_position_and_rotation: "..tostring(self.first_person_unit))
        unit_set_local_position(self.first_person_unit, 1, position + rotated_pos)
        -- world_update_unit_and_children(self.world, self.first_person_unit)
    end
end

SwayAnimationExtension.crosshair_position = function(self, hud_element_crosshair, dt, t, ui_renderer)
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

SwayAnimationExtension.adjust_crosshair = function(self, hud_element_crosshair, x, y)
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

return SwayAnimationExtension
