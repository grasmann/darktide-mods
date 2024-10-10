local mod = get_mod("modding_tools")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
	local CLASS = CLASS
	local ipairs = ipairs
	local managers = Managers
	local table_sort = table.sort
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #############################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################################################

-- mod:hook(CLASS.UIHud, "init", function(func, self, elements, visibility_groups, params, ...)
-- 	-- Original function
-- 	func(self, elements, visibility_groups, params, ...)
-- 	-- Setup forward gui
-- 	mod:inject_forward_gui_into_class(self)
-- end)

mod:hook(CLASS.UIHud, "update", function(func, self, ...)
	-- Setup forward gui
	mod:inject_forward_gui_into_class(self)
	-- Original function
	func(self, ...)
end)

mod:hook(CLASS.UIHud, "destroy", function(func, self, disable_world_bloom, ...)
	-- self._elements_array = self._elements_array or {}
	-- Destroy forward gui
	mod:destroy_forward_gui_in_class(self)
	-- Original function
	return func(self, disable_world_bloom, ...)
end)