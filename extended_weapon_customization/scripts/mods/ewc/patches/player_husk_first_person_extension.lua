local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local world = World
    local CLASS = CLASS
    local tostring = tostring
    local script_unit = ScriptUnit
    local script_unit_extension = script_unit.extension
    local world_update_unit_and_children = world.update_unit_and_children
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.PlayerHuskFirstPersonExtension, "update_unit_position_and_rotation", function(func, self, position_3p_unit, force_update_unit_and_children, ...)
    -- Original function
    func(self, position_3p_unit, force_update_unit_and_children, ...)

    if self._first_person_unit then

        local dt, t = mod:delta_time(), mod:time()

        -- script_unit_remove_extension(self._unit, "sight_system")
        local sight_extension = script_unit_extension(self._unit, "sight_system")
        if sight_extension then
            sight_extension:update(dt, t)
        end

        local sway_extension = script_unit_extension(self._unit, "sway_system")
        if sway_extension then
            sway_extension:update(dt, t)
        end

        -- Update first person unit
        world_update_unit_and_children(self._world, self._first_person_unit)

        local flashlight_extension = script_unit_extension(self._unit, "flashlight_system")
        if flashlight_extension then
            flashlight_extension:update(dt, t)
        end

    end
    
end)
