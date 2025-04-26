local mod = get_mod("modding_tools")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local gui_injector = mod:io_dofile("modding_tools/scripts/mods/modding_tools/classes/gui_injector")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
    local CLASS = CLASS
    local pairs = pairs
--#endregion

-- ##### ┌─┐┌─┐┌┐┌┌─┐┌─┐┬  ┌─┐ ########################################################################################
-- ##### │  │ ││││└─┐│ ││  ├┤  ########################################################################################
-- ##### └─┘└─┘┘└┘└─┘└─┘┴─┘└─┘ ########################################################################################

mod.gui_injector = gui_injector:new()

-- ##### ┬┌┐┌ ┬┌─┐┌─┐┌┬┐  ┌─┐┌─┐┬─┐┬ ┬┌─┐┬─┐┌┬┐  ┌─┐┬ ┬┬ ##############################################################
-- ##### ││││ │├┤ │   │   ├┤ │ │├┬┘│││├─┤├┬┘ ││  │ ┬│ ││ ##############################################################
-- ##### ┴┘└┘└┘└─┘└─┘ ┴   └  └─┘┴└─└┴┘┴ ┴┴└──┴┘  └─┘└─┘┴ ##############################################################

mod.forward_gui = function(self)
    return self.gui_injector:forward_gui()
end

mod.destroy_forward_guis = function(self)
    return self.gui_injector:destroy_forward_guis()
end

mod.inject_forward_gui_into_class = function(self, instance)
    return self.gui_injector:inject_forward_gui_into_class(instance)
end

mod.destroy_forward_gui_in_class = function(self, instance)
    return self.gui_injector:destroy_forward_gui_in_class(instance)
end

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #############################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################################################

mod:hook(CLASS.UIHud, "update", function(func, self, ...)
	-- Setup forward gui
	mod:inject_forward_gui_into_class(self)
	-- Original function
	func(self, ...)
end)

mod:hook(CLASS.UIHud, "destroy", function(func, self, disable_world_bloom, ...)
	-- Destroy forward gui
	mod:destroy_forward_gui_in_class(self)
	-- Original function
	return func(self, disable_world_bloom, ...)
end)

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
        mod.inspector_busy = mod.inspector and mod.inspector.visible and mod.inspector:update(dt, t, input_service)
        for i, inspector_tab in pairs(mod.inspector_tabs) do
            mod.inspector_busy = inspector_tab and inspector_tab.visible and inspector_tab:update(dt, t, input_service)
        end
        -- Update the console
        mod.console_busy = mod.console and mod.console:update(dt, t, input_service)
        -- Update watcher
        mod.watcher_busy = mod.watcher and mod.watcher:update(dt, t, input_service)
        -- Disable input
        self._disable_input = mod:unit_manipulation_busy() or mod.inspector_busy or mod.console_busy or mod.watcher_busy
    end
end)