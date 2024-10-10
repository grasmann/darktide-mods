local mod = get_mod("modding_tools")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local watcher = mod:io_dofile("modding_tools/scripts/mods/modding_tools/classes/watcher")
--#endregion

-- ##### ┌─┐┌─┐┌┐┌┌─┐┌─┐┬  ┌─┐ ########################################################################################
-- ##### │  │ ││││└─┐│ ││  ├┤  ########################################################################################
-- ##### └─┘└─┘┘└┘└─┘└─┘┴─┘└─┘ ########################################################################################

mod.watcher = watcher:new()

-- ##### ┬┌┐┌┌┬┐┌─┐┬─┐┌─┐┌─┐┌─┐┌─┐ ####################################################################################
-- ##### ││││ │ ├┤ ├┬┘├┤ ├─┤│  ├┤  ####################################################################################
-- ##### ┴┘└┘ ┴ └─┘┴└─└  ┴ ┴└─┘└─┘ ####################################################################################

mod.watch = function(self, ...)
    if self.watcher and not self.watcher.destroyed then
        self.watcher:watch(...)
    end
end

mod.watcher_set_mod = function(self, mod)
    if self.watcher and not self.watcher.destroyed then
        self.watcher:set_mod(mod)
    end
end

mod.watcher_hotkey = function()
    if mod.watcher and not mod.watcher.destroyed then
        mod.watcher:toggle()
    end
end

mod.watcher_show = function(self, show)
    if self.watcher and not self.watcher.destroyed then
        self.watcher:show(show)
    end
end