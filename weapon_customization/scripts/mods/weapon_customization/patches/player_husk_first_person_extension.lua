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
    local World = World
    local world_update_unit_and_children = World.update_unit_and_children
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data

--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/extension_systems/first_person/player_husk_first_person_extension", function(instance)

    instance.destroy_custom_extensions = function(self)
        -- Crouch
        mod:remove_extension(self._unit, "crouch_system")
        -- Sway
        mod:remove_extension(self._unit, "sway_system")
    end

    instance.update_custom_extensions = function(self, dt, t)
        -- SwayAnimationExtension
        mod:execute_extension(self._unit, "sway_system", "update", dt, t)
        -- CrouchAnimationExtension
        mod:execute_extension(self._unit, "crouch_system", "update", dt, t)
        -- Weapon DOF
        mod:execute_extension(self._unit, "weapon_dof_system", "update", dt, t)
    end

    instance.update_custom_position_and_rotation = function(self)
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
    end

end)

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #############################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################################################

mod:hook(CLASS.PlayerHuskFirstPersonExtension, "update", function(func, self, unit, dt, t, ...)

    -- Original function
    func(self, unit, dt, t, ...)

    -- Update custom extensions
    self:update_custom_extensions(dt, t)

end)

mod:hook(CLASS.PlayerHuskFirstPersonExtension, "destroy", function(func, self, ...)

    -- Destroy custom extensions
    self:destroy_custom_extensions()

    -- Original function
	func(self, ...)

end)

mod:hook(CLASS.PlayerHuskFirstPersonExtension, "update_unit_position_and_rotation", function(func, self, position_3p_unit, force_update_unit_and_children, ...)

    -- Original function
    func(self, position_3p_unit, force_update_unit_and_children, ...)

    -- Update custom extensions
    self:update_custom_position_and_rotation()

    -- Update first person unit
    if force_update_unit_and_children then
        world_update_unit_and_children(self._world, self._first_person_unit)
    end

end)