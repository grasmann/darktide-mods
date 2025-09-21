local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local math = math
    local class = class
    local CLASS = CLASS
    local world = World
    local pairs = pairs
    local vector3 = Vector3
    local managers = Managers
    local tostring = tostring
    local unit_node = unit.node
    local math_lerp = math.lerp
    local math_clamp = math.clamp
    local quaternion = Quaternion
    local script_unit = ScriptUnit
    local vector3_box = Vector3Box
    local vector3_zero = vector3.zero
    local vector3_lerp = vector3.lerp
    local vector3_unbox = vector3_box.unbox
    local quaternion_multiply = quaternion.multiply
    local unit_local_position = unit.local_position
    local unit_world_rotation = unit.world_rotation
    local unit_local_rotation = unit.local_rotation
    local quaternion_to_vector = quaternion.to_vector
    local script_unit_extension = script_unit.extension
    local quaternion_from_vector = quaternion.from_vector
    local unit_set_local_position = unit.set_local_position
    local unit_set_local_rotation = unit.set_local_rotation
    local script_unit_add_extension = script_unit.add_extension
    local script_unit_remove_extension = script_unit.remove_extension
    local world_update_unit_and_children = world.update_unit_and_children
--#endregion

-- ##### ┌─┐┬┌─┐┬ ┬┌┬┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ #################################################################
-- ##### └─┐││ ┬├─┤ │ └─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ #################################################################
-- ##### └─┘┴└─┘┴ ┴ ┴ └─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ #################################################################

local SwayExtension = class("SwayExtension")

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

SwayExtension.init = function(self, extension_init_context, unit, extension_init_data)
    self.unit = unit

    self.visual_loadout_extension = extension_init_data.visual_loadout_extension
    self.first_person_extension = script_unit_extension(self.unit, "first_person_system")
    self.unit_data_extension = script_unit_extension(unit, "unit_data_system")
    self.alternate_fire_component = self.unit_data_extension:read_component("alternate_fire")
    self.first_person_unit = self.first_person_extension:first_person_unit()

    self.rotation = vector3_box(vector3_zero())
    self.momentum_x = 0
    self.momentum_y = 0

    managers.event:register(self, "extended_weapon_customization_settings_changed", "on_settings_changed")

    self:on_settings_changed()

end

SwayExtension.on_settings_changed = function(self)
    self.active = mod:get("mod_option_sway")
end

SwayExtension.delete = function(self)
    managers.event:unregister(self, "extended_weapon_customization_settings_changed")
    self.active = false
end

SwayExtension.update = function(self, dt, t)

    if self.active and self.first_person_extension and self.first_person_extension:is_in_first_person_mode() then

        local node = unit_node(self.first_person_unit, "ap_aim")
        local rotation = quaternion_to_vector(unit_local_rotation(self.first_person_unit, 1))
        
        local min, max = -2.5, 2.5
        local diff = vector3_unbox(self.rotation) - rotation
        local momentum_x = math_clamp(diff[3], min, max)
        local momentum_y = math_clamp(diff[1], min, max)
        
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

        local unit_position = unit_local_position(self.first_person_unit, node)
        local unit_rotation = unit_local_rotation(self.first_person_unit, node)

        unit_set_local_position(self.first_person_unit, node, unit_position + vector3(angle_x, 0, self.momentum_y * .05))
        unit_set_local_rotation(self.first_person_unit, node, quaternion_from_vector(vector3(self.momentum_y * .05, -angle_x * 60, angle_x)))

        self.rotation:store(rotation)

    else
        
        self.momentum_x = 0
        self.momentum_y = 0

    end

end
