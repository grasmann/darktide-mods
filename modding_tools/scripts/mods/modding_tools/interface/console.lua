local mod = get_mod("modding_tools")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local console = mod:io_dofile("modding_tools/scripts/mods/modding_tools/classes/console")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
    local table = table
    local table_insert = table.insert
--#endregion

-- ##### ┌─┐┌─┐┌┐┌┌─┐┌─┐┬  ┌─┐ ########################################################################################
-- ##### │  │ ││││└─┐│ ││  ├┤  ########################################################################################
-- ##### └─┘└─┘┘└┘└─┘└─┘┴─┘└─┘ ########################################################################################

mod.console = console:new()

-- ##### ┬┌┐┌┌┬┐┌─┐┬─┐┌─┐┌─┐┌─┐┌─┐ ####################################################################################
-- ##### ││││ │ ├┤ ├┬┘├┤ ├─┤│  ├┤  ####################################################################################
-- ##### ┴┘└┘ ┴ └─┘┴└─└  ┴ ┴└─┘└─┘ ####################################################################################

mod.console_print = function(self, ...)
    if self.console then
        self.console:print(...)
    else
        table_insert(self:console_delay_buffer(), {...})
    end
end

-- mod.console_set_mod = function(self, mod)
--     if self.console then
--         self.console:set_mod(mod)
--     end
-- end

mod.console_toggle = function(self, visible)
    if self.console then self.console:show(visible) end
end

mod.console_hotkey = function()
    if mod.console then
        mod.console:toggle()
    end
end

mod.console_show = function(self, show)
    if self.console then
        self.console:show(show)
    end
end

mod.console_delay_buffer = function(self)
    return self:persistent_table("modding_tools").console.delay_buffer
end

mod.console_unload = function(self)
    if self.console then
		self.console:delete()
		self.console = nil
	end
end