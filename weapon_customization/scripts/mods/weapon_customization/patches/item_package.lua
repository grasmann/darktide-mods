local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local pairs = pairs
    local type = type
    local rawget = rawget
    local Log = Log
    local log_error = Log.error
    local string = string
    local string_find = string.find
    local CLASS = CLASS
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"

-- ##### ┬┌┬┐┌─┐┌┬┐  ┌─┐┌─┐┌─┐┬┌─┌─┐┌─┐┌─┐  ┌─┐┌─┐┌┬┐┌─┐┬ ┬ ###########################################################
-- ##### │ │ ├┤ │││  ├─┘├─┤│  ├┴┐├─┤│ ┬├┤   ├─┘├─┤ │ │  ├─┤ ###########################################################
-- ##### ┴ ┴ └─┘┴ ┴  ┴  ┴ ┴└─┘┴ ┴┴ ┴└─┘└─┘  ┴  ┴ ┴ ┴ └─┘┴ ┴ ###########################################################

mod:hook(CLASS.MispredictPackageHandler, "_unload_item_packages", function(func, self, item, ...)
    if self._loaded_packages == nil then
        return
    end
    return func(self, item, ...)
end)

mod:hook(CLASS.InventoryWeaponsView, "_equip_item", function(func, self, slot_name, item, ...)
    func(self, slot_name, item, ...)
    -- Update used packages
    if not self._equip_button_disabled and (slot_name == "slot_primary" or slot_name == "slot_secondary") then
        -- Update used packages
        mod:update_modded_packages()
    end
end)

mod:hook(CLASS.PackageManager, "release", function(func, self, id, ...)
	local load_call_item = self._load_call_data[id]
	local package_name = load_call_item.package_name
    -- Get modded packages
    mod:update_modded_packages()
    -- Check if package is used
    local package_used = false
    for _, USED_PACKAGES in pairs(mod:persistent_table(REFERENCE).used_packages) do
        for used_package_name, _ in pairs(USED_PACKAGES) do
            if used_package_name == package_name then
                package_used = true
                break
            end
        end
        if package_used then break end
    end
    -- Temp trinket fix
    if string_find(package_name, "trinkets") then package_used = true end
    -- Tempt random fix
    if mod.keep_all_packages then package_used = true end
    -- Unload if possible
    if not package_used or self._shutdown_has_started then
        func(self, id, ...)
    end
end)

mod:hook_require("scripts/foundation/managers/package/utilities/item_package", function(instance)

    mod:hook(instance, "compile_item_instance_dependencies", function(func, item, items_dictionary, out_result, optional_mission_template, ...)
        if item and item.attachments then
            instance.item = item

            -- instance.processing_item = item
            local gear_id = mod:get_gear_id(item)

            local in_possesion_of_player = mod:item_in_possesion_of_player(item)
            local in_possesion_of_other_player = mod:item_in_possesion_of_other_player(item)
            local in_store = mod:item_in_store(item)
            local store = in_store and mod:get("mod_option_randomization_store")
            local player = in_possesion_of_other_player and mod:get("mod_option_randomization_players")
            local randomize = store or player
            if randomize and gear_id then
                if not mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] then
                    local master_item = item.__master_item or item
                    local random_attachments = mod:randomize_weapon(master_item)
                    mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] = random_attachments
                    -- Auto equip
                    for attachment_slot, value in pairs(random_attachments) do
                        if not mod.add_custom_attachments[attachment_slot] then
                            mod:resolve_auto_equips(item, value)
                        end
                    end
                    for attachment_slot, value in pairs(random_attachments) do
                        if mod.add_custom_attachments[attachment_slot] then
                            mod:resolve_auto_equips(item, value)
                        end
                    end
                    -- Special resolve
                    for attachment_slot, value in pairs(random_attachments) do
                        if mod.add_custom_attachments[attachment_slot] then
                            mod:resolve_special_changes(item, value)
                        end
                    end
                    for attachment_slot, value in pairs(random_attachments) do
                        if not mod.add_custom_attachments[attachment_slot] then
                            mod:resolve_special_changes(item, value)
                        end
                    end
                end
            end

            if gear_id then
                mod:setup_item_definitions()

                -- Add flashlight slot
                mod:_add_custom_attachments(item, item.attachments)
                
                -- Overwrite attachments
                mod:_overwrite_attachments(item, item.attachments)

                local found_packages = mod:get_modded_item_packages(item.attachments)
                for _, package_name in pairs(found_packages) do
                    mod:persistent_table(REFERENCE).used_packages.hub[package_name] = true
                end
            end
        -- else
        --     instance.item = nil
        end

        local item_instance_dependencies = func(item, items_dictionary, out_result, optional_mission_template, ...)
        -- if mod.cosmetics_view then
        --     mod:dtf(item_instance_dependencies, "item_instance_dependencies", 5)
        -- end
        return item_instance_dependencies
    end)

    -- mod:hook(instance, "_resolve_item_packages_recursive", function(func, attachments, items_dictionary, result, ...)
    --     for key, value in pairs(attachments) do
    --         if key == "item" then
    --             local item_name = type(value) == "table" and value.name or value
    
    --             if item_name ~= "" then
    --                 local item_entry = rawget(items_dictionary, item_name)
    
    --                 if not item_entry then
    --                     log_error("ItemPackage", "Unable to find item %s", item_name)
    --                     return
    --                 end
    
    --                 local child_attachments = item_entry.attachments
    
    --                 if child_attachments then
    --                     instance._resolve_item_packages_recursive(child_attachments, items_dictionary, result)
    --                 end
    
    --                 local resource_dependencies = item_entry.resource_dependencies
    
    --                 for resource_name, _ in pairs(resource_dependencies) do
    --                     result[resource_name] = true
    --                 end
    --             end
    --         elseif type(value) == "table" then
    --             instance._resolve_item_packages_recursive(value, items_dictionary, result)
    --         end
    --     end
    -- end)

end)