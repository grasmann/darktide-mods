local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local ItemPackage = mod:original_require("scripts/foundation/managers/package/utilities/item_package")
local MasterItems = mod:original_require("scripts/backend/master_items")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local Log = Log
    local type = type
    local table = table
    local pairs = pairs
    local CLASS = CLASS
    local rawget = rawget
    local string = string
    local wc_perf = wc_perf
    local managers = Managers
    local tostring = tostring
    local log_error = Log.error
    local table_size = table.size
    local script_unit = ScriptUnit
    local table_clone = table.clone
    local string_find = string.find
    local table_remove = table.remove
    local table_contains = table.contains
    local table_is_empty = table.is_empty
    local table_clone_instance = table.clone_instance
    local script_unit_extension = script_unit.extension
    local script_unit_has_extension = script_unit.has_extension
    local script_unit_add_extension = script_unit.add_extension
    local script_unit_remove_extension = script_unit.remove_extension
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"

-- ##### ┬┌┬┐┌─┐┌┬┐  ┌─┐┌─┐┌─┐┬┌─┌─┐┌─┐┌─┐  ┌─┐┌─┐┌┬┐┌─┐┬ ┬ ###########################################################
-- ##### │ │ ├┤ │││  ├─┘├─┤│  ├┴┐├─┤│ ┬├┤   ├─┘├─┤ │ │  ├─┤ ###########################################################
-- ##### ┴ ┴ └─┘┴ ┴  ┴  ┴ ┴└─┘┴ ┴┴ ┴└─┘└─┘  ┴  ┴ ┴ ┴ └─┘┴ ┴ ###########################################################

mod.in_queue = function(self, package_name)
    local package_manager = managers.package
    if package_manager and package_manager._queue_order then
        for _, queued_package_data in pairs(package_manager._queue_order) do
            if queued_package_data.package_name == package_name then
                -- mod:echot("package "..tostring(package_name).." is in queue")
                return true
            end
        end
    end
    return false
end

mod.can_package_be_unloaded = function(self, package_name)
    -- Check package name
    if not string_find(package_name, "content/weapons/player") then return true end
    -- Check registered packages
    local used_packages = self:persistent_table(REFERENCE).used_packages
    for _, USED_PACKAGES in pairs(used_packages) do
        if USED_PACKAGES[package_name] then
            return false
        end
    end
    -- Check attachment packages
    local GLOBAL_ARRAY = self:persistent_table(REFERENCE).extensions.dependencies
    for dependency_extension, _ in pairs(GLOBAL_ARRAY) do
        local dependencies = dependency_extension:get_dependencies()
        if dependencies and #dependencies > 0 then
            for _, this_package_name in pairs(dependencies) do
                if this_package_name == package_name then
                    return false
                end
            end
        end
    end
    -- Cosmetic view
    if mod.cosmetics_view then return false end
    -- Temp trinket fix
    if string_find(package_name, "trinket") then return false end
    -- Tempt random fix
    if self:persistent_table(REFERENCE).keep_all_packages then return false end

    local package_manager = managers.package
    -- Is loading
    if package_manager:is_loading_now(package_name) or package_manager:is_loading(package_name) then return false end
    -- -- Unload
    -- if not package_manager:can_unload(package_name) then return false end
    -- Queue
    if mod:in_queue(package_name) then return false end
    return true
end

mod:hook(CLASS.MispredictPackageHandler, "_unload_item_packages", function(func, self, item, ...)
	local dependencies = ItemPackage.compile_item_instance_dependencies(item, self._item_definitions, nil, self._mission)
	for package_name, _ in pairs(dependencies) do
        if self._loaded_packages and self._loaded_packages[package_name] then
            local loaded_packages = self._loaded_packages[package_name]
            local load_id = table_remove(loaded_packages, #loaded_packages)
            managers.package:release(load_id)
            if table_is_empty(loaded_packages) then
                self._loaded_packages[package_name] = nil
            end
        else
            mod:print("MispredictPackageHandler - not loaded "..tostring(package_name))
        end
	end
end)

mod:hook(CLASS.MispredictPackageHandler, "destroy", function(func, self, ...)
    for fixed_frame, items in pairs(self._pending_unloads) do
		for i = 1, #items do
			local item = items[i]
			self:_unload_item_packages(item)
		end
	end

    -- Unload rest
    if self._loaded_packages then
        for package_name, load_ids in pairs(self._loaded_packages) do
            for _, load_id in pairs(load_ids) do
                managers.package:release(load_id)
                mod:print("MispredictPackageHandler - unloaded left over "..tostring(package_name))
            end
        end
    end

	self._pending_unloads = nil
	self._loaded_packages = nil
end)

mod.setup_item_definitions = function(self, master_items)
    if self:persistent_table(REFERENCE).item_definitions == nil then
        local master_items = master_items or MasterItems.get_cached(true)
        if master_items then
            self:persistent_table(REFERENCE).item_definitions = table_clone_instance(master_items)
            -- Bulwark shield
            local definitions = self:persistent_table(REFERENCE).item_definitions
            local bulwark_shield_string = "content/items/weapons/player/melee/ogryn_bulwark_shield_01"
            if not definitions[bulwark_shield_string] then
                local bulwark_shield_unit = "content/weapons/enemy/shields/bulwark_shield_01/bulwark_shield_01"
                local slab_shield_string = "content/items/weapons/player/melee/ogryn_slabshield_p1_m1"
                definitions[bulwark_shield_string] = table_clone(definitions[slab_shield_string])
                local bulwark_shield = definitions[bulwark_shield_string]
                bulwark_shield.name = bulwark_shield_string
                bulwark_shield.base_unit = bulwark_shield_unit
                bulwark_shield.resource_dependencies = {
                    [bulwark_shield_unit] = true,
                }
            end
        end
    end
end

-- mod:hook(CLASS.PackageSynchronizationManager, "release_unload_delayed_packages", function(func, self, ...)
--     return
-- end)
-- mod:hook(CLASS.PackageSynchronizerClient, "_update_unload_delayer", function(func, self, dt, ...)
--     return
-- end)

mod:hook(CLASS.PackageManager, "release", function(func, self, id, ...)
	local load_call_item = self._load_call_data[id]
	local package_name = load_call_item.package_name
    local load_call_list = self._package_to_load_call_item[package_name]

    -- Unload if possible
    local keep_all = mod:persistent_table(REFERENCE).keep_all_packages
    local can_unload = mod:can_package_be_unloaded(package_name) and not keep_all
    if can_unload or self._shutdown_has_started or #load_call_list > 1 then
        func(self, id, ...)
    else
        if mod:persistent_table(REFERENCE).prevent_unload[package_name] then
            mod:persistent_table(REFERENCE).prevent_unload[package_name] = mod:persistent_table(REFERENCE).prevent_unload[package_name] + 1
        else
            mod:persistent_table(REFERENCE).prevent_unload[package_name] = 1
        end
        mod:print("prevented package "..tostring(package_name).." from unloading")
    end
end)

mod:hook_require("scripts/foundation/managers/package/utilities/item_package", function(ItemPackage)

    mod:hook(ItemPackage, "compile_item_instance_dependencies", function(func, item, items_dictionary, out_result, optional_mission_template, ...)

        if item and item.attachments then
            ItemPackage.item = item

            local gear_id = mod:get_gear_id(item)

            if gear_id and not mod:is_premium_store_item() then
                mod:setup_item_definitions()

                -- Add flashlight slot
                mod:_add_custom_attachments(item, item.attachments)
                
                -- Overwrite attachments
                mod:_overwrite_attachments(item, item.attachments)
            end
        end

        return func(item, items_dictionary, out_result, optional_mission_template, ...)
    end)

end)