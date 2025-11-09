local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local world = World
    local CLASS = CLASS
    local script_unit = ScriptUnit
    local unit_sway_callback = unit.sway_callback
    local unit_sight_callback = unit.sight_callback
    local unit_shield_callback = unit.shield_callback
    local script_unit_extension = script_unit.extension
    local unit_flashlight_callback = unit.flashlight_callback
    local unit_damage_type_callback = unit.damage_type_callback
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

        -- Sight update callback
        unit_sight_callback(self._unit, "update", dt, t)
        -- Damage type update callback
        unit_damage_type_callback(self._unit, "update", dt, t)
        -- Sway update callback
        unit_sway_callback(self._unit, "update", dt, t)

        -- Update first person unit
        world_update_unit_and_children(self._world, self._first_person_unit)

        -- Flashlight update callback
        unit_flashlight_callback(self._unit, "update", dt, t)
        -- Shield update callback
        unit_shield_callback(self._unit, "update", dt, t)

    end
    
end)
