local mod = get_mod("modding_tools")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
    local CLASS = CLASS
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #############################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################################################

-- Main update loop
mod:hook(CLASS.UIManager, "post_update", function(func, self, dt, t, ...)
    -- Original function
    func(self, dt, t, ...)
    -- Get input service
    local input_service = self:input_service()
    -- Check input service
    if input_service then
        -- Update unit manipulation extensions
        mod:_update_unit_manipulation_extensions(dt, t, input_service)
        -- Update the inspector
        mod.inspector_busy = mod.inspector and mod.inspector:update(dt, t, input_service)
        -- Update the console
        mod.console_busy = mod.console and mod.console:update(dt, t, input_service)
        -- Update watcher
        mod.watcher_busy = mod.watcher and mod.watcher:update(dt, t, input_service)
        -- Disable input
        self._disable_input = mod:unit_manipulation_busy() or mod.inspector_busy or mod.console_busy or mod.watcher_busy
    end
end)