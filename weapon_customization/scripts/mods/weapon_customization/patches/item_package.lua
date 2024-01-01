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
-- local GLOBAL_ARRAY = mod:persistent_table(REFERENCE).extensions.dependencies

-- ##### ┬┌┬┐┌─┐┌┬┐  ┌─┐┌─┐┌─┐┬┌─┌─┐┌─┐┌─┐  ┌─┐┌─┐┌┬┐┌─┐┬ ┬ ###########################################################
-- ##### │ │ ├┤ │││  ├─┘├─┤│  ├┴┐├─┤│ ┬├┤   ├─┘├─┤ │ │  ├─┤ ###########################################################
-- ##### ┴ ┴ └─┘┴ ┴  ┴  ┴ ┴└─┘┴ ┴┴ ┴└─┘└─┘  ┴  ┴ ┴ ┴ └─┘┴ ┴ ###########################################################

--#region Old 
    -- mod.update_modded_packages = function(self)

    --     local perf = wc_perf.start("mod.update_modded_packages", 2)

    --     -- Reset used packages
    --     local new_used_packages = {}
    --     -- Get modded packages
    --     local found_packages = self:get_modded_packages()
    --     for _, package_name in pairs(found_packages) do
    --         new_used_packages[package_name] = true
    --     end
    --     -- Set packages
    --     self:persistent_table(REFERENCE).used_packages.attachments = new_used_packages

    --     wc_perf.stop(perf)

    -- end

    -- mod.get_modded_packages = function(self)
    --     local found_packages = {}
    --     -- if table_size(self:persistent_table(REFERENCE).used_packages.attachments) == 0 then
    --         self:setup_item_definitions()
    --         -- self:load_needed_packages()
    --         -- local players = managers.player:players()
    --         -- if player_or_nil then players = {player_or_nil} end
    --         -- for _, player in pairs(players) do
    --         --     local player_unit = player.player_unit
    --             -- if self.weapon_extension then
    --             -- local weapon_extension = self.weapon_extension --player_unit and script_unit.extension(player_unit, "weapon_system")
    --             if self.weapon_extension then
    --                 local weapons = self.weapon_extension._weapons
    --                 for slot_name, weapon in pairs(weapons) do
    --                     if weapon and weapon.item and weapon.item.attachments then
    --                         local packages =self:get_modded_item_packages(weapon.item.attachments)
    --                         local original_packages = {}
    --                         if weapon.item.original_attachments then
    --                             original_packages = self:get_modded_item_packages(weapon.item.original_attachments)
    --                         end
    --                         for _, package_name in pairs(packages) do
    --                             -- self:persistent_table(REFERENCE).used_packages.attachments[package] = true
    --                             found_packages[#found_packages+1] = package_name
    --                         end
    --                         for _, package_name in pairs(original_packages) do
    --                             -- self:persistent_table(REFERENCE).used_packages.attachments[package] = true
    --                             found_packages[#found_packages+1] = package_name
    --                         end
    --                     end
    --                 end
    --             end
    --         -- end
    --     -- end
    --     return found_packages
    -- end

    -- mod.get_modded_item_packages = function(self, attachments)
    --     local found_attachments = {}
    --     local found_packages = {}
    --     self:_recursive_get_attachments(attachments, found_attachments, true)
    --     for _, attachment_data in pairs(found_attachments) do
    --         local item_string = attachment_data.item
    --         if item_string and item_string ~= "" then
    --             local item_definition = self:persistent_table(REFERENCE).item_definitions[item_string]
    --             if item_definition and item_definition.resource_dependencies then
    --                 for package_name, _ in pairs(item_definition.resource_dependencies) do
    --                     -- self:persistent_table(REFERENCE).used_packages.attachments[package_name] = true
    --                     found_packages[#found_packages+1] = package_name
    --                 end
    --             end
    --         end
    --     end
    --     return found_packages
    -- end

    -- mod.fetch_used_packages = function(self)
    --     local players = managers.player:players()
    --     for _, player in pairs(players) do
    --         local player_unit = player.player_unit
    --         local dependencies = mod:execute_extension(player_unit, "visible_equipment_system", "get_used_packages")
    --         -- if script_unit_has_extension(player_unit, "visible_equipment_system") then
    --         --     local extension = script_unit_extension(player_unit, "visible_equipment_system")

    --         -- end
    --     end
    -- end

    -- mod.clear_packages = function(self)
    --     self:persistent_table(REFERENCE).used_packages.attachments = {}
    -- end

    -- mod.replace_packages = function(self, item)
    --     self:remove_from_packages(item)
    --     self:add_to_packages(item)
    -- end

    -- mod.add_to_packages = function(self, item)
    --     local gear_id = self:get_gear_id(item)
    --     local definitions = self:persistent_table(REFERENCE).item_definitions
    --     local used_packages = self:persistent_table(REFERENCE).used_packages.attachments
    --     local dependencies = ItemPackage.compile_item_instance_dependencies(item, definitions)
    --     if dependencies then
    --         local count = 0
    --         for package_name, _ in pairs(dependencies) do
    --             used_packages[package_name] = used_packages[package_name] or {}
    --             used_packages[package_name][#used_packages[package_name]+1] = gear_id
    --             count = count + 1
    --         end
    --         self:print("added "..tostring(count).." packages for "..tostring(gear_id))
    --     end
    --     self:print_packages()
    -- end

    -- mod.print_packages = function(self)
    --     local used_packages = self:persistent_table(REFERENCE).used_packages.attachments
    --     local package_count, reference_count = 0, 0
    --     for package_name, entry in pairs(used_packages) do
    --         package_count = package_count + 1
    --         reference_count = reference_count + #entry
    --     end
    --     self:print("packages "..tostring(package_count).." references: "..tostring(reference_count))
    -- end

    -- mod.remove_from_packages = function(self, item)
    --     local gear_id = self:get_gear_id(item)
    --     local definitions = self:persistent_table(REFERENCE).item_definitions
    --     local used_packages = self:persistent_table(REFERENCE).used_packages.attachments
    --     local dependencies = ItemPackage.compile_item_instance_dependencies(item, definitions)
    --     if dependencies then
    --         local count = 0
    --         for package_name, _ in pairs(dependencies) do
    --             if used_packages[package_name] then
    --                 for i = #used_packages[package_name], 1, -1 do
    --                     if used_packages[package_name][i] == gear_id then
    --                         table_remove(used_packages[package_name], i)
    --                         count = count + 1
    --                     end
    --                 end
    --                 if #used_packages[package_name] == 0 then
    --                     used_packages[package_name] = nil
    --                 end
    --             end
    --         end
    --         self:print("removed "..tostring(count).." packages for "..tostring(gear_id))
    --     end
    --     self:print_packages()
    -- end

    -- mod.can_package_be_unloaded = function(self, package_name)
    --     -- Check registered packages
    --     local used_packages = self:persistent_table(REFERENCE).used_packages
    --     for _, USED_PACKAGES in pairs(used_packages) do
    --         if USED_PACKAGES[package_name] then
    --             return false
    --         end
    --     end
    --     -- Check attachment packages
    --     local GLOBAL_ARRAY = self:persistent_table(REFERENCE).extensions.dependencies
    --     -- local players = managers.player:players()
    --     -- for _, player in pairs(players) do
    --     for dependency_extension, _ in pairs(GLOBAL_ARRAY) do
    --         -- local player_unit = player.player_unit
    --         -- local dependencies = mod:execute_extension(player_unit, "visible_equipment_system", "get_dependencies")
    --         local dependencies = dependency_extension:get_dependencies()
    --         if dependencies and #dependencies > 0 then
    --             for _, this_package_name in pairs(dependencies) do
    --                 if this_package_name == package_name then
    --                     return false
    --                 end
    --             end
    --         end
    --     end
    --     -- Cosmetic view
    --     if mod.cosmetics_view then return false end
    --     -- Temp trinket fix
    --     -- if string_find(package_name, "trinket") then return false end
    --     -- Tempt random fix
    --     if self:persistent_table(REFERENCE).keep_all_packages then return false end
    --     return true
    -- end

    -- mod:hook(CLASS.MispredictPackageHandler, "destroy", function(func, self, ...)
    --     for fixed_frame, items in pairs(self._pending_unloads) do
    --         for i = 1, #items do
    --             local item = items[i]
    --             self:_unload_item_packages(item)
    --         end
    --     end
    
    --     -- Unload rest
    --     -- for package_name, load_ids in pairs(self._loaded_packages) do
    --     --     for _, load_id in pairs(load_ids) do
    --     --         managers.package:release(load_id)
    --     --     end
    --     -- end
    
    --     -- if self._loaded_packages and #self._loaded_packages > 0 then
    --     --     for i = #self._loaded_packages, 1, -1 do
    --     --         mod:print("MispredictPackageHandler - failed unloading "..tostring(package_name))
    --     --         -- local load_id = table.remove(self._loaded_packages, #self._loaded_packages)
    --     -- 	    -- managers.package:release(load_id)
    --     --         -- if table.is_empty(self._loaded_packages) then
    --     --         --     self._loaded_packages[package_name] = nil
    --     --         -- end
    --     --     end
    --     -- end
    
    --     self._pending_unloads = nil
    --     self._loaded_packages = nil
    -- end)
--#endregion

mod.in_queue = function(self, package_name)
    local package_manager = managers.package
    if package_manager and package_manager._queue_order then
        for _, queued_package_data in pairs(package_manager._queue_order) do
            if queued_package_data.package_name == package_name then
                mod:echot("package "..tostring(package_name).." is in queue")
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

--#region Old
    -- mod:hook(CLASS.InventoryWeaponsView, "_equip_item", function(func, self, slot_name, item, ...)
    --     func(self, slot_name, item, ...)
    --     -- Update used packages
    --     if not self._equip_button_disabled and (slot_name == "slot_primary" or slot_name == "slot_secondary") then
    --         -- Update used packages
    --         -- mod:update_modded_packages()
    --     end
    -- end)

    -- mod.setup_item_definitions = function(self, master_items)
    --     if self:persistent_table(REFERENCE).item_definitions == nil then
    --         local master_items = master_items or MasterItems.get_cached()
    --         if master_items then
    --             self:persistent_table(REFERENCE).item_definitions = table_clone_instance(master_items)
    --             -- -- Bulwark shield
    --             -- local definitions = self:persistent_table(REFERENCE).item_definitions
    --             -- -- if not definitions[bulwark_shield_string] then
    --             --     local bulwark_shield_string = "content/items/weapons/player/melee/ogryn_bulwark_shield_01"
    --             --     local bulwark_shield_unit = "content/weapons/enemy/shields/bulwark_shield_01/bulwark_shield_01"
    --             --     definitions[bulwark_shield_string] = table_clone(definitions["content/items/weapons/player/melee/ogryn_slabshield_p1_m1"])
    --             --     local bulwark_shield = definitions[bulwark_shield_string]
    --             --     bulwark_shield.name = bulwark_shield_string
    --             --     bulwark_shield.base_unit = bulwark_shield_unit
    --             --     bulwark_shield.resource_dependencies = {
    --             --         [bulwark_shield_unit] = true,
    --             --     }
    --             -- -- end
    --         end
    --     end
    --     -- local definitions = self:persistent_table(REFERENCE).item_definitions
    --     -- -- if not definitions["content/items/weapons/player/ranged/sights/scope_01"] then
    --     --     definitions["content/items/weapons/player/ranged/sights/scope_01"] = table_clone(definitions["content/items/weapons/minions/ranged/renegade_sniper_rifle"])
    --     --     local scope = definitions["content/items/weapons/player/ranged/sights/scope_01"]
    --     --     scope.reset_scene_graph_on_unlink = nil
    --     --     scope.item_list_faction = "Player"
    --     --     scope.show_in_1p = true
    --     --     scope.attach_node = "ap_sight_01"
    --     --     scope.attachments = {
    --     --         zzz_shared_material_overrides = {
    --     --           children = {},
    --     --           item = "",
    --     --         }
    --     --     }
    --     --     scope.name = "content/items/weapons/player/ranged/sights/scope_01"
    --     --     scope.fx_sources = nil
    --     --     scope.material_overrides = nil
    --     --     scope.wielded_attach_node = nil
    --     --     scope.unwielded_attach_node = nil
    --     -- -- end
    --     -- -- if self:persistent_table(REFERENCE).bulwark_item_definitions == nil then
    --     -- --     local master_items = MasterItems.get_cached()
    --     -- --     if master_items then
    --     -- --         self:persistent_table(REFERENCE).bulwark_item_definitions = table_clone_instance(MasterItems.get_cached())
    --     -- --         self:persistent_table(REFERENCE).bulwark_item_definitions["content/items/weapons/minions/shields/chaos_ogryn_bulwark_shield_01"] = self:persistent_table(REFERENCE).bulwark_item_definitions["content/items/weapons/player/melee/ogryn_slabshield_p1_m1"]
    --     -- --         self:persistent_table(REFERENCE).bulwark_item_definitions["content/items/weapons/minions/shields/chaos_ogryn_bulwark_shield_01"].base_unit = "content/weapons/enemy/shields/bulwark_shield_01/bulwark_shield_01"
    --     -- --     end
    --     -- -- end
    -- end

    -- mod:hook(CLASS.PackageManager, "release", function(func, self, id, ...)
    --     local load_call_item = self._load_call_data[id]
    --     local package_name = load_call_item.package_name
    --     -- local load_call_list = self._package_to_load_call_item[package_name]
    
    --     -- for i = #load_call_list, 1, -1 do
    --     -- 	if load_call_list[i] == load_call_item then
    --     -- 		table.remove(load_call_list, i)
    --     -- 	end
    --     -- end
    
    --     -- local table_ok = not table.is_empty(load_call_list)
    
    --     -- if not table_ok then
    --     --     mod:echo("table not ok")
    --     -- end
    --     -- Get modded packages
    --     -- mod:update_modded_packages()
    --     -- -- Check if package is used
    --     -- local used_packages = mod:persistent_table(REFERENCE).used_packages
    --     -- local package_used = false
    --     -- for _, USED_PACKAGES in pairs(used_packages) do
    --     --     for used_package_name, _ in pairs(USED_PACKAGES) do
    --     --         if used_package_name == package_name then
    --     --             package_used = true
    --     --             break
    --     --         end
    --     --     end
    --     --     if package_used then break end
    --     -- end
    --     -- -- Temp trinket fix
    --     -- if string_find(package_name, "trinket") then package_used = true end
    --     -- -- Tempt random fix
    --     -- if mod.keep_all_packages then package_used = true end
    --     -- Unload if possible
    --     local keep_all = mod:persistent_table(REFERENCE).keep_all_packages
    --     if (mod:can_package_be_unloaded(package_name) and not keep_all) or self._shutdown_has_started then
    --         func(self, id, ...)
    --     else mod:print("prevented package "..tostring(package_name).." from unloading") end
    
    --     -- local queued_callback_items = self._queued_callback_items
    
    --     -- for i = #queued_callback_items, 1, -1 do
    --     -- 	if queued_callback_items[i] == load_call_item then
    --     -- 		table.remove(queued_callback_items, i)
    --     -- 	end
    --     -- end
    
    --     -- self._load_call_data[id] = nil
    -- end)
--#endregion

mod.setup_item_definitions = function(self, master_items)
    if self:persistent_table(REFERENCE).item_definitions == nil then
        local master_items = master_items or MasterItems.get_cached()
        if master_items then
            self:persistent_table(REFERENCE).item_definitions = table_clone_instance(master_items)
            -- -- Bulwark shield
            -- local definitions = self:persistent_table(REFERENCE).item_definitions
            -- -- if not definitions[bulwark_shield_string] then
            --     local bulwark_shield_string = "content/items/weapons/player/melee/ogryn_bulwark_shield_01"
            --     local bulwark_shield_unit = "content/weapons/enemy/shields/bulwark_shield_01/bulwark_shield_01"
            --     definitions[bulwark_shield_string] = table_clone(definitions["content/items/weapons/player/melee/ogryn_slabshield_p1_m1"])
            --     local bulwark_shield = definitions[bulwark_shield_string]
            --     bulwark_shield.name = bulwark_shield_string
            --     bulwark_shield.base_unit = bulwark_shield_unit
            --     bulwark_shield.resource_dependencies = {
            --         [bulwark_shield_unit] = true,
            --     }
            -- -- end
        end
    end
end

mod:hook(CLASS.PackageSynchronizerClient, "_update_unload_delayer", function(func, self, dt, ...)
    return
end)

-- mod:hook(CLASS.PackageManager, "init", function(func, self, ...)
--     -- Original function
--     func(self, ...)
--     self.in_queue = function(self, package_name)
        
--     end
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

mod.randomize_item = function(self, item)

end

mod:hook_require("scripts/foundation/managers/package/utilities/item_package", function(ItemPackage)

    mod:hook(ItemPackage, "compile_item_instance_dependencies", function(func, item, items_dictionary, out_result, optional_mission_template, ...)

        if item and item.attachments then
            ItemPackage.item = item

            local gear_id = mod:get_gear_id(item)

            -- local in_possesion_of_player = mod:is_owned_by_player(item)
            -- local in_possesion_of_other_player = mod:is_owned_by_other_player(item)
            -- local in_store = mod:is_store_item(item) and not mod:is_premium_store_item(item)
            -- local in_premium_store = mod:is_premium_store_item(item)
            -- local store = in_store and mod:get("mod_option_randomization_store")
            -- local other_player = in_possesion_of_other_player and mod:get("mod_option_randomization_players")
            -- local randomize = store or other_player
            -- if randomize and gear_id then
            --     if not mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] then
            --         -- mod:print("randomize "..tostring(gear_id))
            --         local master_item = item.__master_item or item
            --         local random_attachments = mod:randomize_weapon(master_item)
            --         mod:persistent_table(REFERENCE).temp_gear_settings[gear_id] = random_attachments
            --         -- Auto equip
            --         for attachment_slot, value in pairs(random_attachments) do
            --             if not mod.add_custom_attachments[attachment_slot] then
            --                 mod:resolve_auto_equips(item, value)
            --             end
            --         end
            --         for attachment_slot, value in pairs(random_attachments) do
            --             if mod.add_custom_attachments[attachment_slot] then
            --                 mod:resolve_auto_equips(item, value)
            --             end
            --         end
            --         -- Special resolve
            --         for attachment_slot, value in pairs(random_attachments) do
            --             if mod.add_custom_attachments[attachment_slot] then
            --                 mod:resolve_special_changes(item, value)
            --             end
            --         end
            --         for attachment_slot, value in pairs(random_attachments) do
            --             if not mod.add_custom_attachments[attachment_slot] then
            --                 mod:resolve_special_changes(item, value)
            --             end
            --         end
            --     end
            -- end

            if gear_id and not mod:is_premium_store_item() then
                mod:setup_item_definitions()

                -- Add flashlight slot
                mod:_add_custom_attachments(item, item.attachments)
                
                -- Overwrite attachments
                mod:_overwrite_attachments(item, item.attachments)

                -- local found_packages = mod:get_modded_item_packages(item.attachments)
                -- for _, package_name in pairs(found_packages) do
                --     mod:persistent_table(REFERENCE).used_packages.hub[package_name] = true
                -- end
            end
        end

        -- mod:setup_item_definitions()
        -- items_dictionary = mod:persistent_table(REFERENCE).item_definitions

        local item_instance_dependencies = func(item, items_dictionary, out_result, optional_mission_template, ...)
        -- if mod.cosmetics_view then
        --     local item_name = mod:item_name_from_content_string(item.name)
        --     mod:dtf(item_instance_dependencies, "item_instance_dependencies_"..tostring(item_name), 5)
        -- end
        return item_instance_dependencies
    end)

end)