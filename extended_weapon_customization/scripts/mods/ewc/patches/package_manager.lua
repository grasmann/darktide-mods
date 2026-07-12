local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local CLASS = CLASS
    local table = table
    local ipairs = ipairs
    local tostring = tostring
    local table_clear = table.clear
    local table_remove = table.remove
    local table_insert = table.insert
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local temp_remove_list = {}
local pt = mod:pt()

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

local function check_package_name(package_name)
    -- Check package name is a weapon package
    if pt.resource_packages[package_name] or mod:cached_find(package_name, "content/weapons") then
        -- Add to package table
        pt.resource_packages[package_name] = true
        pt.loaded_packages[package_name] = true
    end
    -- Return package is a weapon package
    return pt.resource_packages[package_name]
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

CLASS.PackageManager.MAX_CONCURRENT_ASYNC_PACKAGES = 256

mod:hook(CLASS.PackageManager, "release", function(func, self, id, ...)
    -- Check context
    if not pt or not mod.cached_find then
        -- Original function
        return func(self, id, ...)
    end
    -- Get load call item
    local load_call_item = self._load_call_data[id]
    if load_call_item then
        -- Get package name
        local package_name = load_call_item.package_name
        -- Check package name
        check_package_name(package_name)
        -- Prevent release
        if not pt.resource_packages[package_name] then
            -- Original function
            return func(self, id, ...)
        -- else
        --     -- Release prevented
        --     mod:print("prevent release: "..tostring(package_name))
        end
    end
end)

mod:hook(CLASS.PackageManager, "update", function(func, self, dt, t, ...)
    -- Check context
    if not pt or not mod.cached_find then
        -- Original function
        return func(self, dt, t, ...)
    end
    -- Get async unload processing order
    local async_unload_processing_order = self._async_unload_processing_order
    -- Iterate through async unload processing order
	for index, package_name in ipairs(async_unload_processing_order) do
        -- Check package name
        check_package_name(package_name)
        -- Prevent release
        if pt.resource_packages[package_name] then
            -- -- Release prevented
            -- mod:print("prevent release: "..tostring(package_name))
            -- Add to temp remove list
            table_insert(temp_remove_list, index)
        end
    end
    -- Check temp remove list
    if #temp_remove_list > 0 then
        -- Iterate through temp remove list
		for i = #temp_remove_list, 1, -1 do
            -- Remove from async unload processing order
			table_remove(async_unload_processing_order, temp_remove_list[i])
		end
        -- Clear temp remove list
		table_clear(temp_remove_list)
	end
    -- Original function
    return func(self, dt, t, ...)
end)

mod:hook(CLASS.PackageManager, "_flush_unloads", function(func, self, ...)
    -- Check context
    if not pt or not mod.cached_find then
        -- Original function
        return func(self, ...)
    end
    -- Get async unload processing order
    local async_unload_processing_order = self._async_unload_processing_order
    -- Iterate through async unload processing order
    for index, package_name in ipairs(async_unload_processing_order) do
        -- Check package name
        check_package_name(package_name)
        -- Check package name
        if pt.resource_packages[package_name] then
            -- -- Release prevented
            -- mod:print("prevent release: "..tostring(package_name))
            -- Add to temp remove list
            table_insert(temp_remove_list, index)
        end
    end
    -- Check temp remove list
    if #temp_remove_list > 0 then
        -- Iterate through temp remove list
		for i = #temp_remove_list, 1, -1 do
            -- Remove from async unload processing order
			table_remove(async_unload_processing_order, temp_remove_list[i])
		end
        -- Clear temp remove list
		table_clear(temp_remove_list)
	end
    -- Original function
    return func(self, ...)
end)
