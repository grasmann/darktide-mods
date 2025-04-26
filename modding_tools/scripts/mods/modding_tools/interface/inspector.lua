local mod = get_mod("modding_tools")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local inspector = mod:io_dofile("modding_tools/scripts/mods/modding_tools/classes/inspector")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
    local pairs = pairs
    local table_clear = table.clear
--#endregion

-- ##### ┬┌┐┌┌─┐┌─┐┌─┐┌─┐┌┬┐┌─┐┬─┐ ####################################################################################
-- ##### ││││└─┐├─┘├┤ │   │ │ │├┬┘ ####################################################################################
-- ##### ┴┘└┘└─┘┴  └─┘└─┘ ┴ └─┘┴└─ ####################################################################################

mod.inspector_tabs = {}
mod.inspector = inspector:new()

-- ##### ┬┌┐┌┌┬┐┌─┐┬─┐┌─┐┌─┐┌─┐┌─┐ ####################################################################################
-- ##### ││││ │ ├┤ ├┬┘├┤ ├─┤│  ├┤  ####################################################################################
-- ##### ┴┘└┘ ┴ └─┘┴└─└  ┴ ┴└─┘└─┘ ####################################################################################

mod.inspector_close_tab = function(self, inspector_tab)
    for i, other_tab in pairs(self.inspector_tabs) do
        if other_tab == inspector_tab then
            self.inspector_tabs[i]:show(false)
            self.inspector_tabs[i]:destroy()
            self.inspector_tabs[i] = nil
            break
        end
    end
end

mod.inspector_switch_tab = function(self, inspector_tab)
    self:inspectors_hide()
    inspector_tab:show(true)
end

mod.inspectors_hide = function(self)
    self.inspector:show(false)
    for i, inspector_tab in pairs(self.inspector_tabs) do
        inspector_tab:show(false)
    end
end

mod.inspect_new = function(self, key, obj)
    self.inspector_tabs[#self.inspector_tabs+1] = inspector:new()
    self.inspector_tabs[#self.inspector_tabs]:navigate(key, obj)
end

mod.inspect = function(self, key, obj)
    if self.inspector and not self.inspector.destroyed then
        if not self.inspector.current then
            self.inspector:navigate(key, obj)
        else
            self:inspect_new(key, obj)
        end
    end
end

mod.inspector_unload = function(self)
    if self.inspector then
        self.inspector:delete()
        self.inspector = nil
    end
    for i, inspector_tab in pairs(self.inspector_tabs) do
		if inspector_tab then inspector_tab:delete() end
	end
    table_clear(self.inspector_tabs)
end

mod.inspector_toggle = function(self, visible)
    if self.inspector then self.inspector:show(visible) end
    for i, inspector_tab in pairs(self.inspector_tabs) do
        if inspector_tab then inspector_tab:show(visible) end
    end
end