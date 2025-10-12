local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local pairs = pairs
    local table = table
    local callback = callback
    local managers = Managers
    local tostring = tostring
    local table_clear = table.clear
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "extended_weapon_customization"
local pt = mod:pt()

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.load_packages = function(self)
    local package_manager = managers.package
    if package_manager then
        for package_name, _ in pairs(self.settings.packages_to_load) do
            -- Debug
            self:print("loading package "..tostring(package_name))
            -- Create callback
            local callback = callback(self, "package_loaded", package_name)
            -- Load package
            pt.loading_packages[package_name] = package_manager:load(package_name, REFERENCE, callback, true)
        end
    end
end

mod.package_loaded = function(self, package_name)
    -- Set loaded package id
    pt.loaded_packages[package_name] = pt.loading_packages[package_name]
    -- Unset loading package id
    pt.loading_packages[package_name] = nil
    -- Debug
    self:print("package loaded "..tostring(package_name).." - "..tostring(pt.loaded_packages[package_name]))
end

mod.release_packages = function(self)
    -- Debug
    self:print("releasing all packages")
    -- Iterate through packages
    for package_name, package_id in pairs(pt.loaded_packages) do
        -- Release package
        self:release_package(package_id, package_name)
    end
    -- Clear loaded package ids
    table_clear(pt.loaded_packages)
end

mod.release_package = function(self, package_id, package_name)
    local package_manager = managers.package
    if package_manager then
        -- Debug
        self:print("releasing package "..tostring(package_name).." - "..tostring(package_id))
        -- Unset loaded package id
        pt.loaded_packages[package_name] = nil
        -- Release package
        package_manager:release(package_id)
    end
end
