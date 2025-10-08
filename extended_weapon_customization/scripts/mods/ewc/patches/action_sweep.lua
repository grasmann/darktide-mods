local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local CLASS = CLASS
    local script_unit = ScriptUnit
    local script_unit_extension = script_unit.extension
--#endregion

mod:hook(CLASS.ActionSweep, "start", function(func, self, action_settings, t, time_scale, action_start_params, ...)
    -- Original function
    func(self, action_settings, t, time_scale, action_start_params, ...)

    local attachment_callback_extension = script_unit_extension(self._player_unit, "attachment_callback_system")
    if attachment_callback_extension then
        attachment_callback_extension:on_attack(self._hit_units)
    end
end)
