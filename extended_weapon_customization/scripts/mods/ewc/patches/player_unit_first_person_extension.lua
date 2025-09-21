local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local world = World
    local CLASS = CLASS
    local script_unit = ScriptUnit
    local script_unit_extension = script_unit.extension
    local world_update_unit_and_children = world.update_unit_and_children
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

-- mod:hook(CLASS.PlayerUnitFirstPersonExtension, "update", function(func, self, unit, dt, t, ...)
mod:hook(CLASS.PlayerUnitFirstPersonExtension, "update_unit_position", function(func, self, unit, dt, t, ...)
    -- Original function
    func(self, unit, dt, t, ...)

    if self._first_person_unit then

        -- script_unit_remove_extension(self._unit, "sight_system")
        local sight_extension = script_unit_extension(self._unit, "sight_system")
        if sight_extension then

            sight_extension:update(dt, t)

            -- -- Update first person unit
            -- world_update_unit_and_children(self._world, self._first_person_unit)

        end

        local sway_extension = script_unit_extension(self._unit, "sway_system")
        if sway_extension then

            sway_extension:update(dt, t)

            -- -- Update first person unit
            -- world_update_unit_and_children(self._world, self._first_person_unit)

        end

        -- Update first person unit
        world_update_unit_and_children(self._world, self._first_person_unit)

    end
    
end)
