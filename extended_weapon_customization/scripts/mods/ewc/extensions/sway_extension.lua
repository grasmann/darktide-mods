local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local math = math
    local table = table
    local class = class
    local vector3 = Vector3
    local managers = Managers
    local unit_node = unit.node
    local math_lerp = math.lerp
    local unit_alive = unit.alive
    local math_clamp = math.clamp
    local quaternion = Quaternion
    local script_unit = ScriptUnit
    local vector3_box = Vector3Box
    local vector3_zero = vector3.zero
    local vector3_lerp = vector3.lerp
    -- local table_contains = table.contains
    local vector3_unbox = vector3_box.unbox
    local quaternion_multiply = quaternion.multiply
    local unit_local_position = unit.local_position
    local unit_local_rotation = unit.local_rotation
    local quaternion_to_vector = quaternion.to_vector
    local unit_set_local_scale = unit.set_local_scale
    local script_unit_extension = script_unit.extension
    local quaternion_from_vector = quaternion.from_vector
    local unit_set_local_position = unit.set_local_position
    local unit_set_local_rotation = unit.set_local_rotation
--#endregion

-- ##### ┌─┐┬┌─┐┬ ┬┌┬┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ #################################################################
-- ##### └─┐││ ┬├─┤ │ └─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ #################################################################
-- ##### └─┘┴└─┘┴ ┴ ┴ └─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ #################################################################

local SwayExtension = class("SwayExtension")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local SLOT_PRIMARY = "slot_primary"
local SLOT_SECONDARY = "slot_secondary"
local LOCKED_ACTIONS = {
    "action_bash_light_from_block_no_ammo",
    "action_reload_shotgun",
    "action_reload_state",
    "action_reload_loop",
    "action_bash_light",
    "action_bash_heavy",
    "action_bash_start",
    "action_bash_right",
    "action_pushfollow",
    "action_unwield",
    "action_inspect",
    "action_reload",
    "action_wield",
    "action_bash",
    "action_push",
}

-- ##### ┬┌┐┌┬┌┬┐┬┌─┐┬  ┬┌─┐┌─┐┌┬┐┬┌─┐┌┐┌ #############################################################################
-- ##### │││││ │ │├─┤│  │┌─┘├─┤ │ ││ ││││ #############################################################################
-- ##### ┴┘└┘┴ ┴ ┴┴ ┴┴─┘┴└─┘┴ ┴ ┴ ┴└─┘┘└┘ #############################################################################

SwayExtension.init = function(self, extension_init_context, unit, extension_init_data)
    -- Data
    self.unit = unit
    self.player = extension_init_data.player
    -- Extensions
    self.visual_loadout_extension = extension_init_data.visual_loadout_extension
    self.first_person_extension = script_unit_extension(self.unit, "first_person_system")
    self.unit_data_extension = script_unit_extension(unit, "unit_data_system")
    self.alternate_fire_component = self.unit_data_extension:read_component("alternate_fire")
    self.movement_state_component = self.unit_data_extension:read_component("movement_state")
    self.weapon_action_component = self.unit_data_extension:read_component("weapon_action")
    -- Settings
    self.wielded_slot = extension_init_data.wielded_slot
    self.rotation = vector3_box(vector3_zero())
    self.crouch_rotation = vector3_box(vector3_zero())
    self.crouch_position = vector3_box(vector3_zero())
    self.momentum_x = 0
    self.momentum_y = 0
    -- Register Events
    managers.event:register(self, "ewc_reloaded", "on_mod_reload")
    managers.event:register(self, "ewc_settings_changed", "on_settings_changed")
    managers.event:register(self, "ewc_cutscene", "on_cutscene")
    -- Set initial values
    self:on_settings_changed()
end

SwayExtension.delete = function(self)
    -- Unregister Events
    managers.event:unregister(self, "ewc_reloaded")
    managers.event:unregister(self, "ewc_settings_changed")
    managers.event:unregister(self, "ewc_cutscene")
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

SwayExtension.on_settings_changed = function(self)
    self.sway = mod:get("mod_option_sway")
    self.crouch = mod:get("mod_option_crouch")
    self.crouch_melee = mod:get("mod_option_crouch_melee")
end

SwayExtension.on_cutscene = function(self, cutscene_playing)
    if not cutscene_playing then
        -- Execute "on_wield"
        self:on_wield(self.wielded_slot)
    end
end

SwayExtension.on_wield = function(self, wielded_slot)
    self.wielded_slot = wielded_slot
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

SwayExtension.is_ogryn = function(self)
    local player = self.player
    local profile = player and player:profile()
    return profile and profile.archetype.name == "ogryn"
end

SwayExtension.get_breed = function(self)
    return self:is_ogryn() and "ogryn" or "human"
end

SwayExtension.is_aiming = function(self)
    return self.alternate_fire_component and self.alternate_fire_component.is_active
end

SwayExtension.is_in_first_person_mode = function(self)
    return self.first_person_extension and self.first_person_extension:is_in_first_person_mode()
end

SwayExtension.first_person_unit = function(self)
    return self.first_person_extension and self.first_person_extension:first_person_unit()
end

SwayExtension.is_crouching = function(self)
    return self.movement_state_component and self.movement_state_component.is_crouching
end

SwayExtension.weapon_action = function(self)
    return self.weapon_action_component and self.weapon_action_component.current_action_name
end

SwayExtension.weapon_action_allowed = function(self, optional_current_action_name)
    local current_action_name = optional_current_action_name or self:weapon_action()
    return not mod:cached_table_contains(LOCKED_ACTIONS, current_action_name)
end

SwayExtension.update = function(self, dt, t)
    -- Only update if in first person
    if self:is_in_first_person_mode() then
        -- Get first person unit
        local first_person_unit = self:first_person_unit()
        -- Check first person unit
        if first_person_unit and unit_alive(first_person_unit) then
            -- Get aim node
            local node = unit_node(first_person_unit, "ap_aim")
            -- Get unit rotation as vector
            local rotation = quaternion_to_vector(unit_local_rotation(first_person_unit, 1))
            -- Get position and rotation
            local unit_position = unit_local_position(first_person_unit, node)
            local unit_rotation = unit_local_rotation(first_person_unit, node)

            -- Update crouch
            if self.crouch and (self.wielded_slot ~= SLOT_PRIMARY or self.crouch_melee) then

                local apply_crouching = self:is_crouching() and self:weapon_action_allowed() and not self:is_aiming()

                local is_ogryn = self:is_ogryn()
                local crouch_rotation = apply_crouching and (is_ogryn and vector3(0, -60, 0) or vector3(0, -60, 0)) or vector3_zero()
                local crouch_position = apply_crouching and (is_ogryn and vector3(0, 0, -.35) or vector3(0, 0, -.15)) or vector3_zero()

                local current_crouch_rotation = vector3_unbox(self.crouch_rotation)
                local new_crouch_rotation = vector3_lerp(current_crouch_rotation, crouch_rotation, dt * 10)

                self.crouch_rotation:store(new_crouch_rotation)

                local current_crouch_position = vector3_unbox(self.crouch_position)
                local new_crouch_position = vector3_lerp(current_crouch_position, crouch_position, dt * 10)

                self.crouch_position:store(new_crouch_position)

                unit_rotation = quaternion_multiply(unit_rotation, quaternion_from_vector(new_crouch_rotation))
                unit_position = unit_position + new_crouch_position

            end

            -- Update sway
            if self.sway then

                local min, max = -2.5, 2.5
                local diff = vector3_unbox(self.rotation) - rotation
                local momentum_x = math_clamp(diff[3], min, max) * (self:is_aiming() and .5 or 1)
                local momentum_y = math_clamp(diff[1], min, max) * (self:is_aiming() and .5 or 1)
                
                if (momentum_x > 0 and momentum_x > self.momentum_x) or (momentum_x < 0 and momentum_x < self.momentum_x) then
                    self.momentum_x = math_lerp(self.momentum_x, momentum_x, dt * 4)
                else
                    self.momentum_x = math_lerp(self.momentum_x, momentum_x, dt * 10)
                end

                self.momentum_y = math_lerp(self.momentum_y, momentum_y, dt * 4)

                local angle_x = self.momentum_x
                -- reduce the angle_x
                angle_x = angle_x % 360
                -- force it to be the positive remainder, so that 0 <= angle_x < 360
                angle_x = (angle_x + 360) % 360
                -- force into the minimum absolute value residue class, so that -180 < angle_x <= 180
                if angle_x > 180 then angle_x = angle_x - 360 end
                angle_x = angle_x * -1
                angle_x = angle_x * .05

                unit_position = unit_position + vector3(angle_x, 0, self.momentum_y * .05)
                unit_rotation = quaternion_multiply(unit_rotation, quaternion_from_vector(vector3(self.momentum_y * .05, -angle_x * 60, angle_x)))

            end

            -- Set position and rotation
            unit_set_local_position(first_person_unit, node, unit_position)
            unit_set_local_rotation(first_person_unit, node, unit_rotation)

            -- Store rotation
            self.rotation:store(rotation)

            -- Return
            return
        end

    end

    -- Reset momentum
    self.momentum_x = 0
    self.momentum_y = 0

end
