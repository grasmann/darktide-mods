local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local CLASS = CLASS
    local script_unit = ScriptUnit
    local script_unit_extension = script_unit.extension
    local unit_attachment_callback = unit.attachment_callback
--#endregion

mod:hook(CLASS.ActionSweep, "start", function(func, self, action_settings, t, time_scale, action_start_params, ...)
    -- Original function
    func(self, action_settings, t, time_scale, action_start_params, ...)
    -- Attachment callback
    unit_attachment_callback(self._player_unit, "on_attack", self._hit_units)
end)
