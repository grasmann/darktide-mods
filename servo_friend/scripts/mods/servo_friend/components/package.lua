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

local function package_already_registered(packages, package_name)
    for i = 1, #packages do
        if packages[i] == package_name then
            return true
        end
    end

    return false
end

-- ##### ┌─┐┌─┐┌─┐┬┌─┌─┐┌─┐┌─┐┌─┐ #####################################################################################
-- ##### ├─┘├─┤│  ├┴┐├─┤│ ┬├┤ └─┐ #####################################################################################
-- ##### ┴  ┴ ┴└─┘┴ ┴┴ ┴└─┘└─┘└─┘ #####################################################################################

-- Register packages
mod.register_packages = function(self, packages)
    if not packages or #packages == 0 then
        return
    end

    for _, package_name in pairs(packages) do
        if package_name and not package_already_registered(self.packages_to_load, package_name) then
            self.packages_to_load[#self.packages_to_load + 1] = package_name
        end
    end
end

-- Load packages
mod.load_packages = function(self)
    local pt = self:pt()

    pt.all_packages_loaded = false
    table_clear(pt.loaded_packages)
    table_clear(pt.finished_loading)

    if not self.package_manager or #self.packages_to_load == 0 then
        pt.all_packages_loaded = true
        self:initialize_existing_players()
        return
    end

    for _, package_name in pairs(self.packages_to_load) do
        if package_name and not pt.loaded_packages[package_name] then
            local load_callback = callback(self, "cb_on_package_loaded", package_name)
            pt.loaded_packages[package_name] = self.package_manager:load(package_name, self.REFERENCE, load_callback)
        end
    end

    if table_size(pt.loaded_packages) == 0 then
        pt.all_packages_loaded = true
        self:initialize_existing_players()
    end
end

-- Callback on package loaded
mod.cb_on_package_loaded = function(self, package_name)
    local pt = self:pt()

    if not pt.loaded_packages[package_name] or pt.finished_loading[package_name] then
        return
    end

    self:print("Package loaded: " .. package_name)
    pt.finished_loading[package_name] = true

    if table_size(pt.finished_loading) == table_size(pt.loaded_packages) then
        self:print("All packages loaded")
        pt.all_packages_loaded = true
        self:initialize_existing_players()
    end
end

-- Release packages
mod.release_packages = function(self)
    if not self.keep_packages then
        local pt = self:pt()

        if self.package_manager then
            for package_name, package_id in pairs(pt.loaded_packages) do
                if package_id then
                    self:print("Release package: " .. package_name)
                    self.package_manager:release(package_id)
                end
            end
        end

        table_clear(pt.loaded_packages)
        table_clear(pt.finished_loading)
        pt.all_packages_loaded = false
    end
end
