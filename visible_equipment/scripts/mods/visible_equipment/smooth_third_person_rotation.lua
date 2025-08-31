local mod = get_mod("visible_equipment")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local CLASS = CLASS
    local managers = Managers
    local quaternion = Quaternion
    local unit_set_data = unit.set_data
    local quaternion_lerp = quaternion.lerp
    local unit_local_rotation = unit.local_rotation
    local unit_set_local_rotation = unit.set_local_rotation
--#endregion

mod:hook(CLASS.PlayerUnitLocomotionExtension, "update", function(func, self, unit, dt, t, ...)

    local current_rotation = unit_local_rotation(unit, 1)
    local remainder_t = t - self._last_fixed_t
    local locomotion_component = self._locomotion_component
    local look_rotation = self._first_person_extension:extrapolated_rotation()
    local current_velocity = self._locomotion_steering_component.velocity_wanted
    local target_rotation = self._locomotion_steering_component.target_rotation
    local current_rotation = locomotion_component.rotation
    local extrapolated_rot = self:_calculate_rotation(unit, remainder_t, t, locomotion_component, self._locomotion_steering_component, self._locomotion_force_rotation_component, look_rotation, current_velocity, locomotion_component.velocity_current, current_rotation, target_rotation)

	-- Original function
    func(self, unit, dt, t, ...)

	unit_set_local_rotation(unit, 1, quaternion_lerp(current_rotation, extrapolated_rot, dt))
end)
