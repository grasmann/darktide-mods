local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local pairs = pairs
    local class = class
    local wc_perf = wc_perf
    local managers = Managers
    local tostring = tostring
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"
local SLOT_PRIMARY = "slot_primary"
local SLOT_SECONDARY = "slot_secondary"

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local DependencyExtension = class("DependencyExtension")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

DependencyExtension.init = function(self, extension_init_context, unit, extension_init_data)
    self.equipment = extension_init_data.equipment
    local GLOBAL_ARRAY = mod:persistent_table(REFERENCE).extensions.dependencies
    GLOBAL_ARRAY[self] = true
    self.unit = unit
end

DependencyExtension.delete = function(self)
    local GLOBAL_ARRAY = mod:persistent_table(REFERENCE).extensions.dependencies
    GLOBAL_ARRAY[self] = nil
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

DependencyExtension.get_dependencies = function(self)
    local perf = wc_perf.start("DependencyExtension.get_dependencies", 2)
    mod:setup_item_definitions()
    local found_packages = {}
    for slot_name, slot in pairs(self.equipment) do
        if slot_name == SLOT_SECONDARY or slot_name == SLOT_PRIMARY then
            local item = slot.item
            local item_definition = item and mod:persistent_table(REFERENCE).item_definitions[item.name]
            if item_definition and item_definition.resource_dependencies then
                for package_name, _ in pairs(item_definition.resource_dependencies) do
                    found_packages[#found_packages+1] = package_name
                end
            end
        end
    end
    wc_perf.stop(perf)
    return found_packages
end