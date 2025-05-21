local mod = get_mod("servo_friend")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local unit = Unit
local math = math
local CLASS = CLASS
local class = class
local pairs = pairs
local vector3 = Vector3
local math_abs = math.abs
local managers = Managers
local math_huge = math.huge
local matrix4x4 = Matrix4x4
local math_clamp = math.clamp
local quaternion = Quaternion
local unit_alive = unit.alive
local vector3_box = Vector3Box
local script_unit = ScriptUnit
local math_random = math.random
local vector3_zero = vector3.zero
local vector3_unbox = vector3_box.unbox
local vector3_distance = vector3.distance
local vector3_normalize = vector3.normalize
local quaternion_forward = quaternion.forward
local unit_world_rotation = unit.world_rotation
local matrix4x4_transform = matrix4x4.transform
local unit_world_position = unit.world_position
local quaternion_matrix4x4 = quaternion.matrix4x4
local script_unit_has_extension = script_unit.has_extension

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local ServoFriendInspectExtension = class("ServoFriendInspectExtension", "ServoFriendBaseExtension")

mod:register_extension("ServoFriendInspectExtension", "servo_friend_inspect_system")

-- ##### ┬┌┐┌┬┌┬┐       ┌┬┐┌─┐┌─┐┌┬┐┬─┐┌─┐┬ ┬ #########################################################################
-- ##### │││││ │   ───   ││├┤ └─┐ │ ├┬┘│ │└┬┘ #########################################################################
-- ##### ┴┘└┘┴ ┴        ─┴┘└─┘└─┘ ┴ ┴└─└─┘ ┴  #########################################################################

ServoFriendInspectExtension.init = function(self, extension_init_context, unit, extension_init_data)
    -- Base class
    ServoFriendInspectExtension.super.init(self, extension_init_context, unit, extension_init_data)
    -- Data
    self.inspecting = false
    self.was_inspecting = false
    self.look_delta_x = 0
    self.look_delta_y = 0
    self.weapon_unit_1p = nil
    self.weapon_unit_3p = nil
    self.attachments_1p = nil
    self.attachments_3p = nil
    self.aim_target_unit = nil
    self.aim_target_timer = 0
    self.aim_target_time = 1
    -- Events
    -- managers.event:register(self, "servo_friend_spawned", "on_servo_friend_spawned")
    -- managers.event:register(self, "servo_friend_destroyed", "on_servo_friend_destroyed")
    managers.event:register(self, "servo_friend_inspect_started", "on_servo_friend_inspect_started")
    managers.event:register(self, "servo_friend_inspect_finished", "on_servo_friend_inspect_finished")
    -- Settings
    self:on_settings_changed()
end

ServoFriendInspectExtension.destroy = function(self)
    -- Events
    -- managers.event:unregister(self, "servo_friend_spawned")
    -- managers.event:unregister(self, "servo_friend_destroyed")
    managers.event:unregister(self, "servo_friend_inspect_started")
    managers.event:unregister(self, "servo_friend_inspect_finished")
    -- Base class
    ServoFriendInspectExtension.super.destroy(self)
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

ServoFriendInspectExtension.closest_attachment = function(self)
    if self.attachments_1p and #self.attachments_1p > 0 then
        local current_position = vector3_unbox(self.current_position)
        local closest = math_huge
        local closest_unit = nil
        for _, unit in pairs(self.attachments_1p) do
            local attachment_position = unit_world_position(unit, 1)
            local distance = vector3_distance(current_position, attachment_position)
            if distance < closest then
                closest = distance
                closest_unit = unit
            end
        end
        return closest_unit, closest
    end
    return self.weapon_unit_1p
end

ServoFriendInspectExtension.update = function(self, dt, t)
    -- Base class
    ServoFriendInspectExtension.super.update(self, dt, t)
    -- Inspect
    if self:is_initialized() and self:servo_friend_alive() then

        if self.inspecting then
            self.was_inspecting = true
            -- Get first person extension rotation
            local rotation = self.first_person_extension:extrapolated_rotation()
            local first_person_unit = self.first_person_extension:first_person_unit()
            -- Get first person unit position
            local new_position = unit_world_position(first_person_unit, 1)
            -- if self.weapon_unit_1p then
            --     new_position = unit_world_position(self.weapon_unit_1p, 1)
            -- end
            local current_position = vector3_unbox(self.current_position)
            -- Aim target
            local aim_position = new_position
            if t > self.aim_target_timer then
                self.aim_target_unit = self:closest_attachment()
                -- Timer
                self.aim_target_timer = t + self.aim_target_time
            end
            -- Aim target unit
            if self.aim_target_unit and unit_alive(self.aim_target_unit) then
                aim_position = unit_world_position(self.aim_target_unit, 1)
            end
            -- Rotate offset position
            local mat = quaternion_matrix4x4(rotation)
            -- Position variation
            -- mod:echo("look delta x: "..tostring(self.look_delta_x).." y: "..tostring(self.look_delta_y))
            local x_change = math_clamp(self.look_delta_x, -1, 1) * .7
            local y_change = math_clamp(self.look_delta_y, -1, 1) * .7
            local z_change = (1 - math_clamp(math_abs(self.look_delta_x), 0, 1)) * .6
            local rotated_change = matrix4x4_transform(mat, vector3(-x_change * 1.25, -y_change * 1.5, z_change))
            new_position = new_position + rotated_change
            -- Rotate offset position
            -- local mat = quaternion_matrix4x4(rotation)
            local rotated_pos = matrix4x4_transform(mat, vector3(0, .2, .2))
            local target_position = new_position + rotated_pos
            -- Set new target position
            self.servo_friend_extension:on_servo_friend_set_target_position(target_position, aim_position, true, false)
        elseif self.was_inspecting then
            self.was_inspecting = false
            -- Set new target position
            self.servo_friend_extension:on_servo_friend_set_target_position(nil, nil)
        end
    end
end

-- ##### ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ######################################################
-- ##### └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ └┐┌┘├┤ │││ │ └─┐ ######################################################
-- ##### └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘ └┘ └─┘┘└┘ ┴ └─┘ ######################################################

ServoFriendInspectExtension.on_settings_changed = function(self)
    -- Base class
    ServoFriendInspectExtension.super.on_settings_changed(self)
end

ServoFriendInspectExtension.on_servo_friend_spawned = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        -- Base class
        ServoFriendInspectExtension.super.on_servo_friend_spawned(self)
        -- Init
        self.aim_target_timer = 0
    end
end

ServoFriendInspectExtension.on_servo_friend_destroyed = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        -- Base class
        ServoFriendInspectExtension.super.on_servo_friend_destroyed(self)
    end
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

ServoFriendInspectExtension.on_servo_friend_inspect_started = function(self, servo_friend_unit, player_unit)
    if player_unit == self.player_unit then
        self.inspecting = true
        -- Disable transparency
        managers.event:trigger("servo_friend_transparency_disabled", self.servo_friend_unit, self.player_unit)
        managers.event:trigger("servo_friend_roaming_disabled", self.servo_friend_unit, self.player_unit)
        -- Get visual loadout extension
        local visual_loadout_extension = script_unit_has_extension(self.player_unit, "visual_loadout_system")
        -- Check visual loadout extension
        if visual_loadout_extension then
            -- Get currently wielded slot
            local inventory = visual_loadout_extension._inventory_component
            local currently_wielded_slot = inventory.wielded_slot
            -- Check currently wielded slot
            if inventory and inventory.wielded_slot then
                -- Get servo friend inspect extension
                local servo_friend_inspect_extension = mod:servo_friend_extension(self.servo_friend_unit, "servo_friend_inspect_system")
                -- Check servo friend inspect extension
                if servo_friend_inspect_extension then
                    -- Get unit and attachments
                    local unit_1p, unit_3p, attachments_1p, attachments_3p = visual_loadout_extension:unit_and_attachments_from_slot(inventory.wielded_slot)
                    servo_friend_inspect_extension.weapon_unit_1p = unit_1p
                    servo_friend_inspect_extension.weapon_unit_3p = unit_3p
                    servo_friend_inspect_extension.attachments_1p = attachments_1p
                    servo_friend_inspect_extension.attachments_3p = attachments_3p
                end
            end
        end
    end
end

ServoFriendInspectExtension.on_servo_friend_inspect_finished = function(self, servo_friend_unit, player_unit)
    if player_unit == self.player_unit then
        self.inspecting = false
        -- Enable transparency
        managers.event:trigger("servo_friend_transparency_enabled", self.servo_friend_unit, self.player_unit)
        managers.event:trigger("servo_friend_roaming_enabled", self.servo_friend_unit, self.player_unit)
        -- Get servo friend inspect extension
        local servo_friend_inspect_extension = mod:servo_friend_extension(self.servo_friend_unit, "servo_friend_inspect_system")
        -- Check servo friend inspect extension
        if servo_friend_inspect_extension then
            -- Reset
            servo_friend_inspect_extension.weapon_unit_1p = nil
            servo_friend_inspect_extension.weapon_unit_3p = nil
            servo_friend_inspect_extension.attachments_1p = nil
            servo_friend_inspect_extension.attachments_3p = nil
        end
    end
end

-- ##### ┬ ┬┌─┐┌─┐┬┌─┌─┐ ##############################################################################################
-- ##### ├─┤│ ││ │├┴┐└─┐ ##############################################################################################
-- ##### ┴ ┴└─┘└─┘┴ ┴└─┘ ##############################################################################################

mod:hook(CLASS.ActionInspect, "start", function(func, self, action_settings, t, ...)
    -- Original function
    func(self, action_settings, t, ...)
    -- Inspect started
    managers.event:trigger("servo_friend_inspect_started", nil, self._player_unit)
end)

mod:hook(CLASS.ActionInspect, "finish", function(func, self, reason, data, t, time_in_action, ...)
    -- Original function
    func(self, reason, data, t, time_in_action, ...)
    -- Inspect finished
    managers.event:trigger("servo_friend_inspect_finished", nil, self._player_unit)
end)

mod:hook(CLASS.ThirdPersonLookDeltaAnimationControl, "update", function(func, self, dt, t, game_object_id, ...)
    -- Original function
    func(self, dt, t, game_object_id, ...)
    -- Update servo friend
    local weapon_lock_view_component = self._weapon_lock_view_component
	local weapon_lock_view_component_state = weapon_lock_view_component.state
    if weapon_lock_view_component_state == "weapon_lock" or weapon_lock_view_component_state == "weapon_lock_no_delta" then
        -- local pt = mod:pt()
        local servo_friend_extension = script_unit_has_extension(self._unit, "player_unit_servo_friend_system")
        if servo_friend_extension then
            local servo_friend_inspect_extension = mod:servo_friend_extension(servo_friend_extension.servo_friend_unit, "servo_friend_inspect_system")
            if servo_friend_inspect_extension then
                servo_friend_inspect_extension.look_delta_x = self._look_delta_x
                servo_friend_inspect_extension.look_delta_y = self._look_delta_y
            end
        end
    end
end)

return ServoFriendInspectExtension