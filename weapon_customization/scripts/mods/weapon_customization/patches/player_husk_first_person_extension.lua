local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require

--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
    local CLASS = CLASS
    local script_unit = ScriptUnit
    local script_unit_has_extension = script_unit.has_extension
    local script_unit_add_extension = script_unit.add_extension
    local script_unit_remove_extension = script_unit.remove_extension
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data

--#endregion

-- mod:hook(CLASS.PlayerHuskFirstPersonExtension, "extensions_ready", function(func, self, world, unit, ...)
--     -- Original function
--     func(self, world, unit, ...)
--     -- Add SwayAnimationExtension
--     if not script_unit_has_extension(self._unit, "sway_system") then
--         self.crouch_animation_extension = script_unit_add_extension({
--             world = self._world,
--         }, self._unit, "SwayAnimationExtension", "sway_system", {
--             player_unit = self._unit, is_local_unit = self._is_local_unit,
--         })
--     end
--     -- Add CrouchAnimationExtension
--     if not script_unit_has_extension(self._unit, "crouch_system") then
--         self.crouch_animation_extension = script_unit_add_extension({
--             world = self._world,
--         }, self._unit, "CrouchAnimationExtension", "crouch_system", {
--             player_unit = self._unit, is_local_unit = self._is_local_unit,
--         })
--     end
-- end)

mod:hook(CLASS.PlayerHuskFirstPersonExtension, "update", function(func, self, unit, dt, t, ...)
    -- Original function
    func(self, unit, dt, t, ...)
    -- SwayAnimationExtension
    mod:execute_extension(self._unit, "sway_system", "update", dt, t)
    -- CrouchAnimationExtension
    mod:execute_extension(self._unit, "crouch_system", "update", dt, t)
    -- Weapon DOF
    mod:execute_extension(self._unit, "weapon_dof_system", "update", dt, t)
end)

-- mod:hook(CLASS.PlayerHuskFirstPersonExtension, "destroy", function(func, self, ...)
--     -- Crouch
--     mod:remove_extension(self._unit, "crouch_system")
--     -- Sway
--     mod:remove_extension(self._unit, "sway_system")
--     -- Original function
-- 	func(self, ...)
-- end)

mod:hook(CLASS.PlayerHuskFirstPersonExtension, "update_unit_position_and_rotation", function(func, self, position_3p_unit, force_update_unit_and_children, ...)
    -- Original function
    func(self, position_3p_unit, force_update_unit_and_children, ...)
    -- Sights
    mod:execute_extension(self._unit, "sight_system", "set_spectated", self._is_first_person_spectated)
    mod:execute_extension(self._unit, "sight_system", "update_position_and_rotation", self)
    -- Weapon DOF
    mod:execute_extension(self._unit, "weapon_dof_system", "set_spectated", self._is_first_person_spectated)
    -- Flashlight / laser pointer
    mod:execute_extension(self._unit, "flashlight_system", "set_spectated", self._is_first_person_spectated)
    -- Crouch
    mod:execute_extension(self._unit, "crouch_system", "set_spectated", self._is_first_person_spectated)
    -- Sway
    mod:execute_extension(self._unit, "sway_system", "set_spectated", self._is_first_person_spectated)
end)