local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local ItemPackage = mod:original_require("scripts/foundation/managers/package/utilities/item_package")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local pairs = pairs
    local table = table
    local CLASS = CLASS
    local ferror = ferror
    local managers = Managers
    local application = Application
    local table_insert = table.insert
    local table_remove = table.remove
    local table_is_empty = table.is_empty
    local application_resource_package = application.resource_package
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.MispredictPackageHandler, "_load_item_packages", function(func, self, item, ...)
    -- Modify item
    mod:modify_item(item)
    -- Fixes
    mod:apply_attachment_fixes(item)

    -- ##### Original function ########################################################################################
	local mission = self._mission
	local dependencies = ItemPackage.compile_item_instance_dependencies(item, self._item_definitions, nil, mission)
	local package_manager = managers.package
    -- Iterate through dependencies
	for package_name, _ in pairs(dependencies) do
        -- Check if package is known
        if package_manager:package_is_known(package_name) then
            -- Load package
            local load_id = package_manager:load(package_name, "MispredictPackageHandler", nil, true)
            self._loaded_packages[package_name] = self._loaded_packages[package_name] or {}
            table_insert(self._loaded_packages[package_name], load_id)
        else
            ferror("MispredictPackageHandler attempted to load a package when it should only increase reference counts,\tsomething has gone wrong with package loading if this has occured")
        end
	end
    -- ##### Original function ########################################################################################
end)

mod:hook(CLASS.MispredictPackageHandler, "_unload_item_packages", function(func, self, item, ...)
    -- Modify item
    mod:modify_item(item)
    -- Fixes
    mod:apply_attachment_fixes(item)

    -- ##### Original function ########################################################################################
	local mission = self._mission
	local dependencies = ItemPackage.compile_item_instance_dependencies(item, self._item_definitions, nil, mission)
    local package_manager = managers.package
    -- Iterate through dependencies
	for package_name, _ in pairs(dependencies) do
        -- Get loaded packages
        local loaded_packages = self._loaded_packages[package_name]
        -- ##### Check loaded packages ################################################################################
        if loaded_packages then
            -- Unload package
            local load_id = table_remove(loaded_packages, #loaded_packages)
            package_manager:release(load_id)
            -- Check if loaded packages is empty
            if table_is_empty(loaded_packages) then
                -- Remove loaded packages
                self._loaded_packages[package_name] = nil
            end
        end
        -- ##### Check loaded packages ################################################################################
	end
    -- ##### Original function ########################################################################################
end)

mod:hook(CLASS.MispredictPackageHandler, "destroy", function(func, self, ...)
	for fixed_frame, items in pairs(self._pending_unloads) do
		for i = 1, #items do
			local item = items[i]
			self:_unload_item_packages(item)
		end
	end
    -- if next(self._loaded_packages) then
	-- 	table.dump(self._loaded_packages)
	-- 	ferror("MispredictPackageHandler loaded packages and has not correctly unloaded them")
	-- end
	self._pending_unloads = nil
	self._loaded_packages = nil
end)
