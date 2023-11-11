local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local ScriptCamera = mod:original_require("scripts/foundation/utilities/script_camera")
local Crouch = mod:original_require("scripts/extension_systems/character_state_machine/character_states/utilities/crouch")
local Recoil = mod:original_require("scripts/utilities/recoil")
local ScriptViewport = mod:original_require("scripts/foundation/utilities/script_viewport")
local ScriptWorld = mod:original_require("scripts/foundation/utilities/script_world")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local table_contains = table.contains
    local vector3_box = Vector3Box
    local vector3_unbox = vector3_box.unbox
    local vector3 = Vector3
    local vector3_zero = vector3.zero
    local Quaternion = Quaternion
    local quaternion_identity = Quaternion.identity
    local quaternion_from_euler_angles_xyz = Quaternion.from_euler_angles_xyz
    local quaternion_multiply = Quaternion.multiply
    local quaternion_matrix4x4 = Quaternion.matrix4x4
    local quaternion_to_elements = Quaternion.to_elements
    local quaternion_from_elements = Quaternion.from_elements
    local matrix4x4_transform = Matrix4x4.transform
    local Camera = Camera
    local camera_local_position = Camera.local_position
    local Camera_local_rotation = Camera.local_rotation
    local Unit = Unit
    local unit_get_data = Unit.get_data
    local unit_alive = Unit.alive
    local unit_mesh = Unit.mesh
    local unit_debug_name = Unit.debug_name
    local unit_world_position = Unit.world_position
    local unit_world_rotation = Unit.world_rotation
    local unit_local_position = Unit.local_position
    local unit_local_scale = Unit.local_scale
    local unit_set_local_position = Unit.set_local_position
    local unit_local_rotation = Unit.local_rotation
    local unit_set_local_rotation = Unit.set_local_rotation
    local unit_set_local_scale = Unit.set_local_scale
    local unit_get_child_units = Unit.get_child_units
    local Mesh = Mesh
	local mesh_local_position = Mesh.local_position
	local mesh_set_local_position = Mesh.set_local_position
    local world_update_unit_and_children = World.update_unit_and_children
    local math = math
    local math_min = math.min
    local math_lerp = math.lerp
    local math_easeInCubic = math.easeInCubic
	local math_easeOutCubic = math.easeOutCubic
    local pairs = pairs
    local CLASS = CLASS
    local managers = Managers
    local type = type
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local CROUCH_OPTION = "mod_option_misc_cover_on_crouch"
local REFERENCE = "weapon_customization"
local default_sight_offset_position = vector3_box(vector3_zero())
local default_sight_offset_rotation = vector3_box(vector3_zero())
local default_sight_offset = {
    position = default_sight_offset_position,
    rotation = default_sight_offset_rotation,
}

mod.lens_units = {}

-- ##### ┌─┐┌─┐┌─┐┌─┐┌─┐  ┌─┐┬┌┬┐┬┌┐┌┌─┐ ##############################################################################
-- ##### └─┐│  │ │├─┘├┤   ├─┤│││││││││ ┬ ##############################################################################
-- ##### └─┘└─┘└─┘┴  └─┘  ┴ ┴┴┴ ┴┴┘└┘└─┘ ##############################################################################

mod.get_sight = function(self, item)
    if item and item.__master_item and item.__master_item.attachments then
        local sight = self:_recursive_find_attachment(item.__master_item.attachments, "sight_2")
        if not sight then sight = self:_recursive_find_attachment(item.__master_item.attachments, "sight") end
        if not sight then
            local fix = self:_apply_anchor_fixes(item, "no_scope_offset")
            if fix then sight = {item = "buggy_sight"} end
        end
        return sight
    end
end

mod.is_sniper = function(self, weapon)
    local master_item = weapon.item.__master_item or weapon.item
    local sight = self:_recursive_find_attachment(master_item.attachments, "sight")
    local item_name = sight and self:item_name_from_content_string(sight.item)
    local alt_fire = weapon.weapon_template and weapon.weapon_template.alternate_fire_settings
    local braced = alt_fire and alt_fire.start_anim_event == "to_braced"
    return table_contains(self.scopes, item_name) and not braced
end

mod.is_scope = function(self, sight)
    local item_name = self:item_name_from_content_string(sight.item)
    return table_contains(self.reflex_sights, item_name)
end

mod.is_sight = function(self, sight)
    local item_name = self:item_name_from_content_string(sight.item)
    return table_contains(self.sights, item_name)
end

mod.get_sight_offset = function(self, weapon, offset_type)
    local offset_type = offset_type or "scope_offset"
    local template = weapon.weapon_template.name
    local item = weapon.item
    local anchor = self.anchors[template]
    local sight_offset = anchor and anchor[offset_type]
    sight_offset = self:_apply_anchor_fixes(item, offset_type) or sight_offset
    if sight_offset then
        if not sight_offset.position then
            sight_offset.position = default_sight_offset_position
        end
        if not sight_offset.rotation then
            sight_offset.rotation = default_sight_offset_rotation
        end
        return sight_offset
    end
end

mod.get_sniper_zoom = function(self, item)
    local sight = self:_recursive_find_attachment(item.__master_item.attachments, "sight")
    local item_name = sight and self:item_name_from_content_string(sight.item)
    return self.sniper_zoom_levels[item_name] or 7
end

mod._recursive_find_unit = function(self, weapon_unit, unit_name, output)
    local unit = nil
    local output = output or {}
    -- Get unit children
	local children = unit_get_child_units(weapon_unit)
	if children then
        -- Iterate children
		for _, child in pairs(children) do
			if unit_debug_name(child) == unit_name then
                output[#output+1] = child
			else
                self:_recursive_find_unit(child, unit_name, output)
			end
		end
	end
end

-- Get flashlight unit of specified weapon unit
mod._get_lens_units = function(self, player_unit, weapon)
    self.lens_units = self.lens_units or {}
    if not self.lens_units[player_unit] or (not unit_alive(self.lens_units[player_unit][1]) or not unit_alive(self.lens_units[player_unit][2])) then
        if self:_recursive_find_attachment_name(weapon.item.__master_item.attachments, "scope_lens_01") then
            local attachment_data = self:_recursive_find_attachment(weapon.item.__master_item.attachments, "sight_2")
            if attachment_data then
                local reflex = {}
                self:_recursive_find_unit(weapon.weapon_unit, "#ID[7abb5fc7a4e06dcb]", reflex) 
                if #reflex == 0 then self:_recursive_find_unit(weapon.weapon_unit, "#ID[21bfd951c3d1b9fe]", reflex) end
                if #reflex == 1 then
                    local lenses = {}
                    self:_recursive_find_unit(reflex[1], "#ID[c54f4d16d170cfdb]", lenses)
                    if #lenses == 2 then
                        if unit_get_data(lenses[1], "lens") == 2 then
                            self.lens_units[player_unit] = {lenses[1], lenses[2]}
                        else
                            self.lens_units[player_unit] = {lenses[2], lenses[1]}
                        end
                    end
                end
            end
        end
    end
    return self.lens_units[player_unit]
end

mod:hook(CLASS.ActionAim, "start", function(func, self, action_settings, t, ...)

    -- Crouch animation
    if mod:get(CROUCH_OPTION) then
        if self._first_person_extension.crouch_braced then
            local first_person_unit = self._first_person_extension._first_person_unit
            if Unit.has_animation_event(first_person_unit, "from_cover") then
                Unit.animation_event(first_person_unit, "from_cover")
            end
            self._first_person_extension.crouch_braced = nil
            self._first_person_extension.was_crouch_braced = true
        end
    end

    -- Scope zoom
    if self._weapon and self._weapon.item then
        if mod:is_sniper(self._weapon) and not mod:is_in_third_person(self._player_unit) then
            mod:set_scope_zoom(self._player_unit, self._weapon, true)
        end
    end

    -- Sight offsets
    if self._is_local_unit and self._weapon and self._weapon.item then
        local sight = mod:get_sight(self._weapon.item)
        if sight and sight.item and sight.item ~= "" then
            mod.is_aiming = true
            self._has_scope = mod:is_scope(sight)
            self._has_sight = mod:is_sight(sight)
            self._scope_offset = mod:get_sight_offset(self._weapon) or default_sight_offset
            self._sight_offset = mod:get_sight_offset(self._weapon, "no_scope_offset") or default_sight_offset
            self.finish = function (self, reason, data, t, time_in_action)
                if self._is_local_unit and self._has_scope then
                    mod.camera_position = self._scope_offset.position
                    mod.camera_rotation = self._scope_offset.rotation
                elseif self._is_local_unit and self._has_sight then
                    mod.camera_position = self._sight_offset.position
                    mod.camera_rotation = self._sight_offset.rotation
                end
                if self._is_local_unit and mod._custom_fov then
                    mod.custom_fov = mod._custom_fov
                    mod.fov = mod._custom_fov
                end
            end
        end
    end

    -- Original function
    func(self, action_settings, t, ...)
end)

mod:hook(CLASS.ActionAim, "running_action_state", function(func, self, t, time_in_action, ...)
    -- Original function
    local ret = func(self, t, time_in_action, ...)

    -- Sight offsets
    if self._is_local_unit and self._has_scope then
        local progress = time_in_action / self._action_settings.total_time
        local position = vector3_unbox(self._scope_offset.position) * progress
        mod.camera_position = vector3_box(position)
        local rotation = vector3_unbox(self._scope_offset.rotation) * progress
        mod.camera_rotation = vector3_box(rotation)
    elseif self._is_local_unit and self._has_sight then
        local progress = time_in_action / self._action_settings.total_time
        local position = vector3_unbox(self._sight_offset.position) * progress
        mod.camera_position = vector3_box(position)
        local rotation = vector3_unbox(self._sight_offset.rotation) * progress
        mod.camera_rotation = vector3_box(rotation)
    end
    if mod._custom_fov and mod.default_custom_fov and mod.default_fov then
        local progress = time_in_action / self._action_settings.total_time
        local anim_progress = math_easeInCubic(progress)
        mod.custom_fov = math_lerp(mod.default_custom_fov, mod._custom_fov, anim_progress)
        mod.fov = math_lerp(mod.default_fov, mod._custom_fov, anim_progress)
    end

    return ret
end)

mod:hook(CLASS.ActionUnaim, "start", function(func, self, action_settings, t, ...)

    -- Scope zoom
    if self._weapon and self._weapon.item and self._weapon.item.__master_item then
        mod:set_scope_zoom(self._player_unit, self._weapon, false)
    end

    -- Sight offsets
    if self._is_local_unit and self._weapon and self._weapon.item and self._weapon.item.__master_item then
        local sight = mod:get_sight(self._weapon.item)
        if sight and sight.item and sight.item ~= "" then
            self._has_scope = mod:is_scope(sight)
            self._has_sight = mod:is_sight(sight)
            mod.is_aiming = false
            self._scope_offset = mod:get_sight_offset(self._weapon) or default_sight_offset
            self._sight_offset = mod:get_sight_offset(self._weapon, "no_scope_offset") or default_sight_offset
            self.running_action_state = function(self, t, time_in_action, ...)
                if self._is_local_unit and self._has_scope then
                    local progress = time_in_action / self._action_settings.total_time
                    local position = vector3_unbox(self._scope_offset.position) * (1 - progress)
                    mod.camera_position = vector3_box(position)
                    local rotation = vector3_unbox(self._scope_offset.rotation) * (1 - progress)
                    mod.camera_rotation = vector3_box(rotation)
                elseif self._is_local_unit and self._has_sight then
                    local progress = time_in_action / self._action_settings.total_time
                    local position = vector3_unbox(self._sight_offset.position) * (1 - progress)
                    mod.camera_position = vector3_box(position)
                    local rotation = vector3_unbox(self._sight_offset.rotation) * (1 - progress)
                    mod.camera_rotation = vector3_box(rotation)
                end
                if mod._custom_fov and mod.default_custom_fov and mod.default_fov then
                    local progress = time_in_action / self._action_settings.total_time
                    local anim_progress = math_easeOutCubic(progress)
                    mod.custom_fov = math_lerp(mod._custom_fov, mod.default_custom_fov, anim_progress)
                    mod.fov = math_lerp(mod._custom_fov, mod.default_fov, anim_progress)
                end
            end
        end
    end

    -- Original function
    func(self, action_settings, t, ...)
end)

mod:hook(CLASS.ActionUnaim, "finish", function(func, self, reason, data, t, time_in_action, ...)
    -- Original function
    func(self, reason, data, t, time_in_action, ...)

    -- Sight offsets
    if self._is_local_unit and self._has_scope then
        mod.camera_position = nil
        mod.camera_rotation = nil
    elseif self._is_local_unit and self._has_sight then
        mod.camera_position = nil
        mod.camera_rotation = nil
    end

    -- Crouch animation
    if mod:get(CROUCH_OPTION) then
        if self._first_person_extension.was_crouch_braced then
            local first_person_unit = self._first_person_extension._first_person_unit
            if Unit.has_animation_event(first_person_unit, "to_cover") then
                Unit.animation_event(first_person_unit, "to_cover")
            end
            self._first_person_extension.crouch_braced = true
            self._first_person_extension.was_crouch_braced = nil
        end
    end

end)

mod:hook_require("scripts/utilities/sway", function(instance)
    if not instance._movement_state_settings then instance._movement_state_settings = instance.movement_state_settings end
    instance.movement_state_settings = function(sway_template, movement_state_component, ...)
        if not mod._custom_fov then
            return instance._movement_state_settings(sway_template, movement_state_component, ...)
        end
    end
end)

mod:hook_require("scripts/utilities/recoil", function(instance)
    if not instance._recoil_movement_state_settings then instance._recoil_movement_state_settings = instance.recoil_movement_state_settings end
    Recoil.recoil_movement_state_settings = function(recoil_template, movement_state_component, ...)
        if not mod._custom_fov then
            return instance._recoil_movement_state_settings(recoil_template, movement_state_component, ...)
        end
    end
end)

-- ##### ┌─┐┬ ┬┌─┐┬─┐┌─┐┌─┐  ┌─┐┬┌┬┐┬┌┐┌┌─┐ ###########################################################################
-- ##### │  ├─┤├─┤├┬┘│ ┬├┤   ├─┤│││││││││ ┬ ###########################################################################
-- ##### └─┘┴ ┴┴ ┴┴└─└─┘└─┘  ┴ ┴┴┴ ┴┴┘└┘└─┘ ###########################################################################

mod:hook(CLASS.ActionOverloadCharge, "start", function(func, self, action_settings, t, time_scale, action_start_params, ...)

    -- Sight offsets
    if self._is_local_unit and self._weapon and self._weapon.item and self._weapon.item.__master_item then
        local sight = mod:get_sight(self._weapon.item)
        if sight and sight.item and sight.item ~= "" then
            self._has_scope = mod:is_scope(sight)
            self._scope_offset = mod:get_sight_offset(self._weapon) or default_sight_offset
            self._is_starting_up = true
        end
    end

    -- Original function
    func(self, action_settings, t, time_scale, action_start_params, ...)
end)

mod:hook(CLASS.ActionOverloadCharge, "running_action_state", function(func, self, t, time_in_action, ...)
    -- Original function
    local ret = func(self, t, time_in_action, ...)

    -- Sight offsets
    local time_in_action = math_min(time_in_action, 1)
    if self._is_local_unit and self._has_scope and self._is_starting_up then
        if time_in_action < 1 then
            local progress = time_in_action / 1
            local position = vector3_unbox(self._scope_offset.position) * progress
            mod.camera_position = vector3_box(position)
        else
            mod.camera_position = self._scope_offset.position
            self._is_starting_up = false
        end
    end

    return ret
end)

mod:hook(CLASS.ActionOverloadCharge, "finish", function(func, self, reason, data, t, time_in_action, ...)
    -- Original function
    func(self, reason, data, t, time_in_action, ...)

    -- Sight offsets
    if self._is_local_unit and self._weapon and self._weapon.item and self._weapon.item.__master_item then
        mod.do_camera_position_reset = {
            has_scope = self._has_scope,
            scope_offset = self._scope_offset,
            is_local_unit = self._is_local_unit,
            end_time = t + 1,
        }
    end

end)

mod.camera_position_reset = function(self, dt, t)
    if mod.do_camera_position_reset then
        local has_scope = mod.do_camera_position_reset.has_scope
        local has_sight = mod.do_camera_position_reset.has_sight
        local scope_offset = mod.do_camera_position_reset.scope_offset
        local sight_offset = mod.do_camera_position_reset.sight_offset
        local is_local_unit = mod.do_camera_position_reset.is_local_unit
        local time_in_action = 1 - (mod.do_camera_position_reset.end_time - t)
        if time_in_action < 1 then
            if is_local_unit and has_scope and scope_offset then
                local progress = time_in_action / 1
                local position = vector3_unbox(scope_offset.position) * (1 - progress)
                mod.camera_position = vector3_box(position)
            elseif is_local_unit and has_sight and sight_offset then
                local progress = time_in_action / 1
                local position = vector3_unbox(sight_offset.position) * (1 - progress)
                mod.camera_position = vector3_box(position)
            end
            if mod._custom_fov and mod.default_custom_fov and mod.default_fov then
                local progress = time_in_action / 1
                local anim_progress = math_easeOutCubic(progress)
                mod.custom_fov = math_lerp(mod._custom_fov, mod.default_custom_fov, anim_progress)
                mod.fov = math_lerp(mod._custom_fov, mod.default_fov, anim_progress)
            end
        else
            mod.camera_position = nil
            mod.do_camera_position_reset = nil
        end
    end
end

local _abort_camera_aim = function(func, self, action_settings, t, ...)

    -- Sight offsets
    if self._is_local_unit and self._weapon and self._weapon.item and self._weapon.item.__master_item then
        local sight = mod:get_sight(self._weapon.item)
        if sight and sight.item and sight.item ~= "" then
            mod.do_camera_position_reset = {
                has_scope = mod:is_scope(sight),
                has_sight = mod:is_sight(sight),
                scope_offset = mod:get_sight_offset(self._weapon) or default_sight_offset,
                sight_offset = mod:get_sight_offset(self._weapon, "no_scope_offset") or default_sight_offset,
                is_local_unit = self._is_local_unit,
                end_time = t + 1,
            }
        end
    end

    -- Scope zoom
    if mod._custom_fov then
        mod:set_scope_zoom(self._player_unit, self._weapon, false)
    end

    -- Aiming
    if self._is_local_unit then
        mod.is_aiming = false
    end

    -- Laser pointer
    mod.forced_fallback = true

    func(self, action_settings, t, ...)
end

mod.set_scope_zoom = function(self, player_unit, weapon, enabled)
    if weapon and ((enabled and not mod._custom_fov) or (not enabled and mod._custom_fov)) then
        local scales = {vector3(0, 0, 0), vector3(0, 0, 0)}
        if enabled then
            mod._custom_fov = math.rad(mod:get_sniper_zoom(weapon.item))
        else
            mod._custom_fov = nil
            mod.custom_fov = nil
            mod.fov = nil
            local lens_2 = mod:_apply_anchor_fixes(weapon.item, "lens_2")
            local lens = mod:_apply_anchor_fixes(weapon.item, "lens")
            scales = {
                vector3_unbox(lens_2 and lens_2.scale or vector3(0, 0, 0)),
                vector3_unbox(lens and lens.scale or vector3(0, 0, 0)),
            }
        end
        local lenses = mod:_get_lens_units(player_unit, weapon)
        local lenses = mod:_get_lens_units(player_unit, weapon)
        if lenses then
            if lenses[1] and unit_alive(lenses[1]) then unit_set_local_scale(lenses[1], 1, scales[1]) end
            if lenses[2] and unit_alive(lenses[2]) then unit_set_local_scale(lenses[2], 1, scales[2]) end
        end
    end
end

mod:hook(CLASS.ActionAimProjectile, "start", _abort_camera_aim)
mod:hook(CLASS.ActionChainLightning, "start", _abort_camera_aim)
mod:hook(CLASS.ActionSmiteTargeting, "start", _abort_camera_aim)
mod:hook(CLASS.ActionExplosion, "start", _abort_camera_aim)
mod:hook(CLASS.ActionVentOverheat, "start", _abort_camera_aim)
mod:hook(CLASS.ActionVentWarpCharge, "start", _abort_camera_aim)
mod:hook(CLASS.ActionPlaceForceField, "start", _abort_camera_aim)
mod:hook(CLASS.ActionActivateSpecial, "start", _abort_camera_aim)
mod:hook(CLASS.ActionInspect, "start", _abort_camera_aim)
mod:hook(CLASS.ActionOverloadExplosion, "start", _abort_camera_aim)
mod:hook(CLASS.ActionReloadShotgunSpecial, "start", _abort_camera_aim)
mod:hook(CLASS.ActionReloadShotgun, "start", _abort_camera_aim)
mod:hook(CLASS.ActionReloadState, "start", _abort_camera_aim)
mod:hook(CLASS.ActionUnwield, "start", _abort_camera_aim)

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

mod:hook(CLASS.CameraManager, "update", function(func, self, dt, t, viewport_name, yaw, pitch, roll, ...)
    mod:camera_position_reset(dt, t)
    func(self, dt, t, viewport_name, yaw, pitch, roll, ...)
end)

mod:hook(CLASS.CameraManager, "post_update", function(func, self, dt, t, viewport_name, ...)
    func(self, dt, t, viewport_name, ...)

    local weapon = mod:get_wielded_weapon()
    if weapon and mod:is_in_third_person() then
        mod:set_scope_zoom(mod.player_unit, weapon, false)
    elseif weapon and mod:is_sniper(weapon) and mod.is_aiming then
        mod:set_scope_zoom(mod.player_unit, weapon, true)
    end
    if mod._custom_fov then
        local world = Managers.world:world("level_world")
        local viewport = ScriptWorld.viewport(world, viewport_name)
        if viewport then
            local camera = ScriptViewport.camera(viewport)
            if camera then
                if not mod.default_custom_fov then mod.default_custom_fov = Camera.custom_vertical_fov(camera) end
                if not mod.default_fov then mod.default_fov = Camera.vertical_fov(camera) end
                if mod.custom_fov then Camera.set_custom_vertical_fov(camera, mod.custom_fov) end
                if mod.fov then Camera.set_vertical_fov(camera, mod.fov) end
            end
        end
    end
end)

mod:hook(CLASS.PlayerUnitFirstPersonExtension, "update_unit_position", function(func, self, unit, dt, t, ...)
    func(self, unit, dt, t, ...)
    if unit == mod.player_unit and self:is_in_first_person_mode() then
        local first_person_unit = self._first_person_unit
        if mod.camera_position then
            local position = unit_local_position(first_person_unit, 1)
            local rotation = unit_local_rotation(first_person_unit, 1)
            local mat = quaternion_matrix4x4(rotation)
            local rotated_pos = matrix4x4_transform(mat, vector3_unbox(mod.camera_position))
            unit_set_local_position(first_person_unit, 1, position - rotated_pos)
        end

        world_update_unit_and_children(self._world, first_person_unit)

        if mod.camera_rotation then
            local weapon = mod:get_wielded_weapon()
            local weapon_unit = weapon and weapon.weapon_unit
            if weapon_unit and unit_alive(weapon_unit) then
                local camera_rotation = quaternion_from_euler_angles_xyz(mod.camera_rotation[1], mod.camera_rotation[2], mod.camera_rotation[3])
                unit_set_local_rotation(weapon_unit, 1, camera_rotation)
            end
        end
    end
    if mod:get(CROUCH_OPTION) then
        local movement_state_component = self._movement_state_component
        local is_crouching = movement_state_component and movement_state_component.is_crouching
        local first_person_unit = self._first_person_unit
        if is_crouching then
            if Unit.has_animation_event(first_person_unit, "to_cover") and not self.crouch_braced then
                Unit.animation_event(first_person_unit, "to_cover")
                self.crouch_braced = true
            end
        else
            if Unit.has_animation_event(first_person_unit, "from_cover") and self.crouch_braced then
                Unit.animation_event(first_person_unit, "from_cover")
                self.crouch_braced = nil
                self.was_crouch_braced = nil
            end
        end
    end
end)
