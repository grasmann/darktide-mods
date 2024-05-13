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
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data

--#endregion

mod:hook(CLASS.PlayerUnitFirstPersonExtension, "destroy", function(func, self, ...)
    -- Crouch
    mod:remove_extension(self._unit, "crouch_system")
    -- Sway
    mod:remove_extension(self._unit, "sway_system")
    -- Original function
	func(self, ...)
end)

mod:hook(CLASS.PlayerUnitFirstPersonExtension, "update_unit_position", function(func, self, unit, dt, t, ...)
    -- Original function
    func(self, unit, dt, t, ...)
    -- Sights
    mod:execute_extension(unit, "sight_system", "update_position_and_rotation", self)
    -- Weapon DOF
    mod:execute_extension(unit, "weapon_dof_system", "update", dt, t)
    -- Sway
    mod:execute_extension(unit, "sway_system", "update", dt, t)
    -- Crouch
    mod:execute_extension(unit, "crouch_system", "update", dt, t)
    -- Flashlight / laser pointer
    mod:execute_extension(unit, "flashlight_system", "update", dt, t)
end)