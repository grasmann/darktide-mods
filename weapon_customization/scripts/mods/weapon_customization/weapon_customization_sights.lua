local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local ScriptCamera = mod:original_require("scripts/foundation/utilities/script_camera")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local table_contains = table.contains
    local vector3_box = Vector3Box
    local vector3_unbox = vector3_box.unbox
    local vector3 = Vector3
    local vector3_zero = vector3.zero
    local quaternion_identity = Quaternion.identity
    local quaternion_from_euler_angles_xyz = Quaternion.from_euler_angles_xyz
    local quaternion_multiply = Quaternion.multiply
    local quaternion_matrix4x4 = Quaternion.matrix4x4
    local matrix4x4_transform = Matrix4x4.transform
    local camera_local_position = Camera.local_position
    local Camera_local_rotation = Camera.local_rotation
    local unit_alive = Unit.alive
    local unit_local_position = Unit.local_position
    local unit_set_local_position = Unit.set_local_position
    local unit_local_rotation = Unit.local_rotation
    local unit_set_local_rotation = Unit.set_local_rotation
    local unit_get_child_units = Unit.get_child_units
    local world_update_unit_and_children = World.update_unit_and_children
    local math_min = math.min
    local pairs = pairs
    local CLASS = CLASS
    local managers = Managers
    local type = type
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local default_sight_offset_position = vector3_box(vector3_zero())
local default_sight_offset_rotation = vector3_box(vector3_zero())
local default_sight_offset = {
    position = default_sight_offset_position,
    rotation = default_sight_offset_rotation,
}

-- ##### ┌─┐┌─┐┌─┐┌─┐┌─┐  ┌─┐┬┌┬┐┬┌┐┌┌─┐ ##############################################################################
-- ##### └─┐│  │ │├─┘├┤   ├─┤│││││││││ ┬ ##############################################################################
-- ##### └─┘└─┘└─┘┴  └─┘  ┴ ┴┴┴ ┴┴┘└┘└─┘ ##############################################################################

mod.get_sight = function(self, item)
    if item and item.__master_item and item.__master_item.attachments then
        local sight = self:_recursive_find_attachment(item.__master_item.attachments, "sight_2")
        if not sight then sight = self:_recursive_find_attachment(item.__master_item.attachments, "sight") end
        return sight
    end
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

mod:hook(CLASS.ActionAim, "start", function(func, self, action_settings, t, ...)
    if self._is_local_unit and self._weapon and self._weapon.item then
        local sight = mod:get_sight(self._weapon.item)
        if sight and sight.item and sight.item ~= "" then
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
            end
        end
    end
    func(self, action_settings, t, ...)
end)

mod:hook(CLASS.ActionAim, "running_action_state", function(func, self, t, time_in_action, ...)
    local ret = func(self, t, time_in_action, ...)
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
    return ret
end)

mod:hook(CLASS.ActionUnaim, "start", function(func, self, action_settings, t, ...)
    if self._is_local_unit and self._weapon and self._weapon.item and self._weapon.item.__master_item then
        local sight = mod:get_sight(self._weapon.item)
        if sight and sight.item and sight.item ~= "" then
            self._has_scope = mod:is_scope(sight)
            self._has_sight = mod:is_sight(sight)
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
            end
        end
    end
    func(self, action_settings, t, ...)
end)

mod:hook(CLASS.ActionUnaim, "finish", function(func, self, reason, data, t, time_in_action, ...)
    func(self, reason, data, t, time_in_action, ...)
    if self._is_local_unit and self._has_scope then
        mod.camera_position = nil
        mod.camera_rotation = nil
    elseif self._is_local_unit and self._has_sight then
        mod.camera_position = nil
        mod.camera_rotation = nil
    end
end)

-- ##### ┌─┐┬ ┬┌─┐┬─┐┌─┐┌─┐  ┌─┐┬┌┬┐┬┌┐┌┌─┐ ###########################################################################
-- ##### │  ├─┤├─┤├┬┘│ ┬├┤   ├─┤│││││││││ ┬ ###########################################################################
-- ##### └─┘┴ ┴┴ ┴┴└─└─┘└─┘  ┴ ┴┴┴ ┴┴┘└┘└─┘ ###########################################################################

mod:hook(CLASS.ActionOverloadCharge, "start", function(func, self, action_settings, t, time_scale, action_start_params, ...)
    if self._is_local_unit and self._weapon and self._weapon.item and self._weapon.item.__master_item then
        local sight = mod:get_sight(self._weapon.item)
        if sight and sight.item and sight.item ~= "" then
            self._has_scope = mod:is_scope(sight)
            self._scope_offset = mod:get_sight_offset(self._weapon) or default_sight_offset
            self._is_starting_up = true
        end
    end
    func(self, action_settings, t, time_scale, action_start_params, ...)
end)

mod:hook(CLASS.ActionOverloadCharge, "running_action_state", function(func, self, t, time_in_action, ...)
    local ret = func(self, t, time_in_action, ...)
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
    func(self, reason, data, t, time_in_action, ...)
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
        local scope_offset = mod.do_camera_position_reset.scope_offset
        local is_local_unit = mod.do_camera_position_reset.is_local_unit
        local time_in_action = 1 - (mod.do_camera_position_reset.end_time - t)
        if time_in_action < 1 then
            if is_local_unit and has_scope then
                local progress = time_in_action / 1
                local position = vector3_unbox(scope_offset.position) * (1 - progress)
                mod.camera_position = vector3_box(position)
            end
        else
            mod.camera_position = nil
            mod.do_camera_position_reset = nil
        end
    end
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

mod:hook(CLASS.CameraManager, "update", function(func, self, dt, t, viewport_name, yaw, pitch, roll, ...)
    mod:camera_position_reset(dt, t)
    func(self, dt, t, viewport_name, yaw, pitch, roll, ...)
end)

mod:hook(CLASS.PlayerUnitFirstPersonExtension, "update_unit_position", function(func, self, unit, dt, t, ...)
    func(self, unit, dt, t, ...)
    if unit == mod.player_unit and self:is_in_first_person_mode() then
        local first_person_unit = self._first_person_unit
        local position = unit_local_position(first_person_unit, 1)
        local rotation = unit_local_rotation(first_person_unit, 1)
        if mod.camera_position then
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
end)
