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

mod:hook_require("scripts/extension_systems/first_person/player_unit_first_person_extension", function(instance)

    instance.destroy_custom_extensions = function(self)
        -- Crouch
        mod:remove_extension(self._unit, "crouch_system")
        -- Sway
        mod:remove_extension(self._unit, "sway_system")
    end

    instance.update_custom_extensions = function(self, dt, t)
        -- Sights
        mod:execute_extension(self._unit, "sight_system", "update_position_and_rotation", self)
        -- Weapon DOF
        mod:execute_extension(self._unit, "weapon_dof_system", "update", dt, t)
        -- Sway
        mod:execute_extension(self._unit, "sway_system", "update", dt, t)
        -- Crouch
        mod:execute_extension(self._unit, "crouch_system", "update", dt, t)
        -- Flashlight / laser pointer
        mod:execute_extension(self._unit, "flashlight_system", "update", dt, t)
    end

end)

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #############################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################################################

mod:hook(CLASS.PlayerUnitFirstPersonExtension, "destroy", function(func, self, ...)

    -- Destroy custom extensions
    self:destroy_custom_extensions()

    -- Original function
	func(self, ...)

end)

mod:hook(CLASS.PlayerUnitFirstPersonExtension, "update_unit_position", function(func, self, unit, dt, t, ...)

    -- Original function
    func(self, unit, dt, t, ...)

    -- Update custom extensions
    self:update_custom_extensions(dt, t)

    -- Update first person unit
    world_update_unit_and_children(self._world, self._first_person_unit)

end)