local mod = get_mod("servo_friend")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local table = table
local pairs = pairs
local callback = callback
local table_size = table.size
local table_clear = table.clear

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

mod.packages_to_load = {}

-- ##### ┌─┐┌─┐┌─┐┬┌─┌─┐┌─┐┌─┐┌─┐ #####################################################################################
-- ##### ├─┘├─┤│  ├┴┐├─┤│ ┬├┤ └─┐ #####################################################################################
-- ##### ┴  ┴ ┴└─┘┴ ┴┴ ┴└─┘└─┘└─┘ #####################################################################################

-- Register packages
mod.register_packages = function(self, packages)
    local pt = self:pt()
    -- Check packages
    if packages and #packages > 0 then
        -- Iterate packages
        for _, package in pairs(packages) do
            -- Add package
            self.packages_to_load[#self.packages_to_load+1] = package
        end
    end
end

-- Load packages
mod.load_packages = function(self)
    local pt = self:pt()
    if not pt.all_packages_loaded then
        -- Clear loaded packages
        table_clear(pt.loaded_packages)
        table_clear(pt.finished_loading)
        -- Iterate packages
        for _, package_name in pairs(self.packages_to_load) do
            -- Create callback
            local callback = callback(self, "cb_on_package_loaded", package_name)
            -- Load package
            pt.loaded_packages[package_name] = self.package_manager:load(package_name, self.REFERENCE, callback)
        end
    end
end

-- Callback on package loaded
mod.cb_on_package_loaded = function(self, package_name)
    local pt = self:pt()
    self:print("Package loaded: " .. package_name)
    -- Mark package as loaded
    pt.finished_loading[package_name] = true
    -- Check if all packages are loaded
    if table_size(pt.finished_loading) == table_size(pt.loaded_packages) then
        self:print("All packages loaded")
        -- Set flag
        pt.all_packages_loaded = true
        -- Attempt to load players
        self:initialize_existing_players()
    end
end

-- Release packages
mod.release_packages = function(self)
    if not self.keep_packages then
        local pt = self:pt()
        -- Iterate loaded packages
        for package_name, package_id in pairs(pt.loaded_packages) do
            self:print("Release package: " .. package_name)
            -- Release package
            self.package_manager:release(package_id)
        end
        -- Clear loaded packages
        table_clear(pt.loaded_packages)
        table_clear(pt.finished_loading)
        -- Reset flag
        pt.all_packages_loaded = false
    end
end