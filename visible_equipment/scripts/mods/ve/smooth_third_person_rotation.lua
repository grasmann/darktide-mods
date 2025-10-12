local mod = get_mod("visible_equipment")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local CLASS = CLASS
    local quaternion = Quaternion
    local game_session = GameSession
    local quaternion_lerp = quaternion.lerp
    local quaternion_forward = quaternion.forward
    local unit_set_local_rotation = unit.set_local_rotation
    local game_session_set_game_object_field = game_session.set_game_object_field
--#endregion

-- Third person aim fix
-- Fixes weird weapon left-right movement when playing in third person
-- Psykanium doesn't have the issue because the player is the server
mod:hook(CLASS.PlayerUnitAimExtension, "fixed_update", function(func, self, unit, dt, t, frame, ...)
	if self._is_server then
		local aim_direction = quaternion_forward(self._first_person_component.rotation)
		game_session_set_game_object_field(self._game_session_id, self._game_object_id, "aim_direction", aim_direction)
	end
    self._aim_animation_control:update(dt, t)
	self._idle_fullbody_animation_control:update(dt, t)
	self._look_delta_animation_control:update(dt, t)
end)

-- Third person animation fix
-- Fixes weird jittery character when playing in third person
mod:hook(CLASS.PlayerUnitLocomotionExtension, "update", function(func, self, unit, dt, t, ...)
    local remainder_t = t - self._last_fixed_t
    local locomotion_component = self._locomotion_component
    local look_rotation = self._first_person_extension:extrapolated_rotation()
    local current_velocity = self._locomotion_steering_component.velocity_wanted
    local target_rotation = self._locomotion_steering_component.target_rotation
    local current_rotation = locomotion_component.rotation
    local extrapolated_rot = self:_calculate_rotation(unit, remainder_t, t, locomotion_component, self._locomotion_steering_component, self._locomotion_force_rotation_component, look_rotation, current_velocity, locomotion_component.velocity_current, current_rotation, target_rotation)
	-- Original function
    func(self, unit, dt, t, ...)
    if not mod:is_in_hub() then
        unit_set_local_rotation(unit, 1, quaternion_lerp(current_rotation, extrapolated_rot, dt))
    end
end)
