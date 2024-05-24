local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Performance
    local ItemPackage = mod:original_require("scripts/foundation/managers/package/utilities/item_package")
    local MasterItems = mod:original_require("scripts/backend/master_items")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local Log = Log
    local Xbox = Xbox
    local type = type
    local table = table
    local pairs = pairs
    local CLASS = CLASS
    local IS_XBS = IS_XBS
    local rawget = rawget
    local string = string
    local wc_perf = wc_perf
    local managers = Managers
    local tostring = tostring
    local callback = callback
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

--#region Data
    local REFERENCE = "weapon_customization"
--#endregion

-- ##### ┌─┐┬  ┌─┐┌┐ ┌─┐┬    ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ################################################################
-- ##### │ ┬│  │ │├┴┐├─┤│    ├┤ │ │││││   │ ││ ││││└─┐ ################################################################
-- ##### └─┘┴─┘└─┘└─┘┴ ┴┴─┘  └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ################################################################

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

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/foundation/managers/package/utilities/item_package", function(instance)

    instance.add_custom_resources = function(self, item, result_out)
        mod:setup_item_definitions()
        local gear_id = mod.gear_settings:item_to_gear_id(item)
        if gear_id then
            local item_name = mod:item_name_from_content_string(item.name)
            local attachment_slots = mod:get_item_attachment_slots(item)
            for _, attachment_slot in pairs(attachment_slots) do
                local attachment = mod.gear_settings:get(item, attachment_slot)
                local item_data = attachment and mod.attachment_models[item_name]
                local attachment_data = item_data and item_data[attachment]
                local model = attachment_data and attachment_data.model
                local original_item = model and mod:persistent_table(REFERENCE).item_definitions[model]
                if original_item and original_item.resource_dependencies then
                    for resource, _ in pairs(original_item.resource_dependencies) do
                        result_out[resource] = true
                    end
                end
            end
        end
    end

    mod:hook(instance, "compile_item_instance_dependencies", function(func, item, items_dictionary, out_result, optional_mission_template, ...)

        -- Mod definitions
        mod:setup_item_definitions()

        -- Get gear id
        local gear_id = mod.gear_settings:item_to_gear_id(item)

        -- Check item and attachments
        if item and item.attachments and gear_id and not mod:is_premium_store_item() then
            
            -- Add flashlight slot
            mod:_add_custom_attachments(item, item.attachments)
            
            -- Overwrite attachments
            mod:_overwrite_attachments(item, item.attachments)

        end

        local result = func(item, items_dictionary, out_result, optional_mission_template, ...)

        if item and item.attachments then

            -- Add custom resources
            instance:add_custom_resources(item.__master_item or item, result)

        end

        -- Return dependencies
        return result

    end)

end)

-- ##### ┌┬┐┬┌─┐┌─┐┬─┐┌─┐┌┬┐┬┌─┐┌┬┐  ┌─┐┌─┐┌─┐┬┌─┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌┐┌┌┬┐┬  ┌─┐┬─┐ #####################################
-- ##### ││││└─┐├─┘├┬┘├┤  ││││   │   ├─┘├─┤│  ├┴┐├─┤│ ┬├┤   ├─┤├─┤│││ │││  ├┤ ├┬┘ #####################################
-- ##### ┴ ┴┴└─┘┴  ┴└─└─┘─┴┘┴└─┘ ┴   ┴  ┴ ┴└─┘┴ ┴┴ ┴└─┘└─┘  ┴ ┴┴ ┴┘└┘─┴┘┴─┘└─┘┴└─ #####################################

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