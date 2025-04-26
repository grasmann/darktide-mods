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
    local WEAPON_MELEE = "WEAPON_MELEE"
    local WEAPON_RANGED = "WEAPON_RANGED"
    local OPTION_VISIBLE_EQUIPMENT = "mod_option_visible_equipment"
    local OPTION_VISIBLE_EQUIPMENT_NO_HUB = "mod_option_visible_equipment_disable_in_hub"
    local gear_id_inc = 1
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

mod:hook_require("scripts/settings/player_character/player_character_constants", function(instance)

    instance.slot_configuration.slot_primary.mispredict_packages = true
    instance.slot_configuration.slot_secondary.mispredict_packages = true

end)

mod:hook_require("scripts/foundation/managers/package/utilities/item_package", function(instance)

    instance.add_custom_resources = function(self, item, out_result)
        local result = out_result or {}
        -- Setup master items backup
        mod:setup_item_definitions()
        -- Check item
        if item and item.name then
            -- Get item name
            local item_name = mod.gear_settings:short_name(item.name)

            -- Iterate attachment slots
            for _, attachment_slot in pairs(mod.attachment_slots) do
                -- Get attachment
                -- local attachment = mod.gear_settings:get(item, attachment_slot)
                local attachment = mod.gear_settings:_recursive_find_attachment(item.attachments, attachment_slot)
                if attachment then
                    local attachment_name = attachment and attachment.attachment_name or mod.gear_settings:default_attachment(item, attachment_slot)
                    if attachment_name then
                        -- Get item data
                        local item_data = attachment_name and mod.attachment_models[item_name]
                        -- Get attachment data
                        local attachment_data = item_data and item_data[attachment_name]
                        -- Get model
                        local model = attachment_data and attachment_data.model
                        -- Get original item
                        local original_item = model and mod:persistent_table(REFERENCE).item_definitions[model]
                        -- Check original item and dependencies
                        if original_item and original_item.resource_dependencies then
                            -- Iterate dependencies
                            for resource, _ in pairs(original_item.resource_dependencies) do
                                -- Add resource
                                result[resource] = true
                                -- item.resource_dependencies[resource] = true
                            end
                        end
                    end
                end
            end

            -- Sounds
			local sounds = mod.gear_settings:sound_packages(item)
			for sound, _ in pairs(sounds) do
                result[sound] = true
                -- item.resource_dependencies[sound] = true
            end

        end

        return result
    end

    instance._validate_item_name = function(item)
		if item == "" then
			return nil
		end
	
		return item
	end

    mod:hook(CLASS.ItemPackage, "compile_item_dependencies", function(func, item, items_dictionary, out_result, optional_mission_template, ...)
        -- Setup master items backup
        mod:setup_item_definitions()

        local item_entry = item

        if type(item_entry) == "string" then
            item_entry = rawget(mod:persistent_table(REFERENCE).item_definitions, item_entry)
        end

        if not item_entry then
            Log.error("ItemPackage", "Unable to find item %s", item)

            return
        end

        local player_item = item_entry.item_list_faction == "Player"
        local weapon_item = item_entry.item_type == WEAPON_MELEE or item_entry.item_type == WEAPON_RANGED
        local attachments = item_entry and item_entry.attachments

        -- local weapon_skin = instance._validate_item_name(item_entry.slot_weapon_skin) or {}
		-- if type(weapon_skin) == "string" then
        --     weapon_skin = mod:persistent_table(REFERENCE).item_definitions[weapon_skin]
        -- end
        -- weapon_skin.attachments = weapon_skin.attachments or {}
        -- attachments = weapon_skin.attachments
            -- resource_dependencies = weapon_skin.resource_dependencies
		-- end

        -- Check item and attachments
        if item_entry and attachments and weapon_item and player_item and not mod:is_premium_store_item() then
            -- Add custom attachments
            mod.gear_settings:_add_custom_attachments(item_entry, attachments)
            -- Overwrite attachments
            mod.gear_settings:_overwrite_attachments(item_entry, attachments)
        end

        local result = func(item_entry, mod:persistent_table(REFERENCE).item_definitions, out_result, optional_mission_template, ...)

        if item_entry and attachments and weapon_item and player_item and not mod:is_premium_store_item() then
            -- Add custom resources
            result = instance:add_custom_resources(item_entry, result)
        end

        out_result = result

        -- Return dependencies
        return result

        -- local result = out_result or {}
        -- local item_entry = item
    
        -- if type(item_entry) == "string" then
        --     item_entry = rawget(items_dictionary, item_entry)
        -- end
    
        -- if not item_entry then
        --     Log.error("ItemPackage", "Unable to find item %s", item)
    
        --     return
        -- end
    
        -- return ItemPackage.compile_item_instance_dependencies(item_entry, items_dictionary, result, optional_mission_template)
    end)

    local test_count = 1

    mod:hook(instance, "compile_item_instance_dependencies", function(func, item, items_dictionary, out_result, optional_mission_template, ...)
        -- Setup master items backup
        mod:setup_item_definitions()

        local real_item = mod.gear_settings:_real_item(item)
        local player_item = real_item.item_list_faction == "Player"
        local weapon_item = real_item.item_type == WEAPON_MELEE or real_item.item_type == WEAPON_RANGED
        local attachments = real_item and real_item.attachments
        -- local resource_dependencies = item and item.resource_dependencies

        -- local weapon_skin = instance._validate_item_name(item.slot_weapon_skin) or {}
		-- if type(weapon_skin) == "string" then
        --     weapon_skin = mod:persistent_table(REFERENCE).item_definitions[weapon_skin]
        -- end
        -- weapon_skin.attachments = weapon_skin.attachments or {}
        -- attachments = weapon_skin.attachments
            -- resource_dependencies = weapon_skin.resource_dependencies
		-- end

        -- Check item and attachments
        if real_item and attachments and weapon_item and player_item and not mod:is_premium_store_item() then
            -- Add custom attachments
            mod.gear_settings:_add_custom_attachments(real_item, attachments)
            -- Overwrite attachments
            mod.gear_settings:_overwrite_attachments(real_item, attachments)
        end

        -- local result = func(item, items_dictionary, out_result, optional_mission_template, ...)
        local result = func(item, mod:persistent_table(REFERENCE).item_definitions, out_result, optional_mission_template, ...)

        if real_item and attachments and weapon_item and player_item and not mod:is_premium_store_item() then
            -- Add custom resources
            result = instance:add_custom_resources(real_item, result)
        else
            -- mod:dtf(real_item, "item_data_"..tostring(test_count), 5)
            -- test_count = test_count + 1
            -- mod:echo("real_item: "..tostring(real_item.name))
        end

        -- mod:dtf(real_item, "item_data_"..tostring(test_count), 10)

        out_result = result

        -- Return dependencies
        return result
    end)

end)

-- ##### ┌┬┐┬┌─┐┌─┐┬─┐┌─┐┌┬┐┬┌─┐┌┬┐  ┌─┐┌─┐┌─┐┬┌─┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌┐┌┌┬┐┬  ┌─┐┬─┐ #####################################
-- ##### ││││└─┐├─┘├┬┘├┤  ││││   │   ├─┘├─┤│  ├┴┐├─┤│ ┬├┤   ├─┤├─┤│││ │││  ├┤ ├┬┘ #####################################
-- ##### ┴ ┴┴└─┘┴  ┴└─└─┘─┴┘┴└─┘ ┴   ┴  ┴ ┴└─┘┴ ┴┴ ┴└─┘└─┘  ┴ ┴┴ ┴┘└┘─┴┘┴─┘└─┘┴└─ #####################################

mod.can_package_release = function(self, package_name)
    local persitent_table = self:persistent_table(REFERENCE)
    local loaded_package = persitent_table.loaded_packages.visible_equipment[package_name]
    if not persitent_table.package_info[package_name] then
        persitent_table.package_info[package_name] = {
            player_content = self:cached_find(package_name, "content/weapons/player"),
            weapon_sound = self:cached_find(package_name, "wwise/events/weapon"),
            player_sound = self:cached_find(package_name, "wwise/events/player"),
        }
    end
    -- local weapon_package = self:cached_find(package_name, "content/weapons/player") or self:cached_find(package_name, "wwise/events/weapon") or self:cached_find(package_name, "wwise/events/player")
    local package_info = persitent_table.package_info[package_name]
    local weapon_package = package_info and (package_info.player_content or package_info.weapon_sound or package_info.player_sound)
    local option = self:get("mod_option_keep_packages")
    if persitent_table.loaded_packages.needed[package_name] then return false end
    if (loaded_package or weapon_package) and option == "always" then return false end
    if (loaded_package or weapon_package) and (option == "hub" and self:is_in_hub()) then return false end
    return true
end

-- mod:hook(CLASS.PackageManager, "_release_internal", function(func, self, package_name, ...)
--     if mod:can_package_release(package_name) then
--         return func(self, package_name, ...)
--     end

-- end)

mod:hook(CLASS.PackageManager, "release", function(func, self, id, ...)
    local load_call_item = self._load_call_data[id]
	local package_name = load_call_item.package_name
    if mod:can_package_release(package_name) then
        return func(self, id, ...)
    end
end)

mod:hook(CLASS.MispredictPackageHandler, "_load_item_packages", function(func, self, item, ...)
    mod:setup_item_definitions()

    local mission = self._mission
	-- local dependencies = ItemPackage.compile_item_instance_dependencies(item, self._item_definitions, nil, mission)
    local dependencies = ItemPackage.compile_item_instance_dependencies(item, mod:persistent_table(REFERENCE).item_definitions, nil, mission)
	local package_manager = managers.package

	for package_name, _ in pairs(dependencies) do
		if package_manager:package_is_known(package_name) then
			local load_id = package_manager:load(package_name, "MispredictPackageHandler", nil, true)

			self._loaded_packages[package_name] = self._loaded_packages[package_name] or {}

			table.insert(self._loaded_packages[package_name], load_id)
		-- else
		-- 	ferror("MispredictPackageHandler attempted to load a package when it should only increase reference counts,\tsomething has gone wrong with package loading if this has occured")
		end
	end
end)

mod:hook(CLASS.MispredictPackageHandler, "_unload_item_packages", function(func, self, item, ...)
    mod:setup_item_definitions()

	-- local dependencies = ItemPackage.compile_item_instance_dependencies(item, self._item_definitions, nil, self._mission)
    local dependencies = ItemPackage.compile_item_instance_dependencies(item, mod:persistent_table(REFERENCE).item_definitions, nil, self._mission)
	for package_name, _ in pairs(dependencies) do
        if self._loaded_packages and self._loaded_packages[package_name] and mod:can_package_release(package_name) then
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
            if mod:can_package_release(package_name) then
                for _, load_id in pairs(load_ids) do
                    managers.package:release(load_id)
                    mod:print("MispredictPackageHandler - unloaded left over "..tostring(package_name))
                end
            end
        end
    end
	self._pending_unloads = nil
	self._loaded_packages = nil
end)