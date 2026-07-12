-- File: extended_weapon_customization/scripts/mods/ewc/patches/item_package.lua
local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
local CLASS = CLASS
local pairs = pairs
local type = type
local string_match = string.match
local Managers = Managers
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local WEAPON_RANGED = "WEAPON_RANGED"
local WEAPON_MELEE = "WEAPON_MELEE"
local VALID_ITEM_TYPES = { WEAPON_MELEE, WEAPON_RANGED }

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/foundation/managers/package/utilities/item_package", function(instance)
    local function inject_weapon_package(resource_name, result)
        if type(resource_name) == "string" then
            -- 1. Try standard weapon package: content/weapons/player/[type]/[weapon]/[weapon]
            local w_type, w_name = string_match(resource_name, "^content/weapons/player/([^/]+)/([^/]+)/")
            if w_type and w_name then
                local pkg = "content/weapons/player/" .. w_type .. "/" .. w_name .. "/" .. w_name
                if Managers.package:package_is_known(pkg) then
                    result[pkg] = true
                end

                -- 2. Try suffix package for MTX skins
                local suffix = string_match(resource_name, "_([a-z]+%d%d)")
                if suffix then
                    local pkg_suffix = pkg .. "_" .. suffix
                    if Managers.package:package_is_known(pkg_suffix) then
                        result[pkg_suffix] = true
                    end
                end
            end

            -- 3. Try exact folder package: A/B/C/D -> A/B/C/C
            local dir_path = string_match(resource_name, "^(.+)/[^/]+$")
            if dir_path then
                local folder_name = string_match(dir_path, "/([^/]+)$")
                if folder_name then
                    local pkg = dir_path .. "/" .. folder_name
                    if Managers.package:package_is_known(pkg) then
                        result[pkg] = true
                    end
                end

                -- 4. Try 1 level up folder package: A/B/C/D/E -> A/B/C/C
                local parent_dir = string_match(dir_path, "^(.+)/[^/]+$")
                if parent_dir then
                    local parent_folder = string_match(parent_dir, "/([^/]+)$")
                    if parent_folder then
                        local pkg = parent_dir .. "/" .. parent_folder
                        if Managers.package:package_is_known(pkg) then
                            result[pkg] = true
                        end
                    end
                end
            end
        end
    end

    mod:hook(instance, "compile_item_instance_dependencies",
        function(func, item, items_dictionary, out_result, optional_mission_template, ...)
            -- Check item
            if item and mod:cached_table_contains(VALID_ITEM_TYPES, item.item_type) then
                if not mod:player_owns_item(item) then
                    -- Randomize item
                    item = mod:handle_husk_item(item)
                end
                -- Modify item
                mod:modify_item(item)
                -- Fixes
                mod:apply_attachment_fixes(item)
            end

            -- Original function
            local result = func(item, items_dictionary, out_result, optional_mission_template, ...)

            -- Inject custom attachment and material overrides dependencies
            if item and mod:cached_table_contains(VALID_ITEM_TYPES, item.item_type) and item.attachments then
                local gear_id = mod:gear_id(item)
                local attachment_slots = mod:fetch_attachment_slots(item.attachments)
                for slot, data in pairs(attachment_slots) do
                    local attachment_item_name = data.item
                    if attachment_item_name and attachment_item_name ~= "" then
                        local attachment_item = items_dictionary[attachment_item_name]
                        if attachment_item then
                            if attachment_item.base_unit then
                                inject_weapon_package(attachment_item.base_unit, result)
                            end
                            if attachment_item.base_unit_1p then
                                inject_weapon_package(attachment_item.base_unit_1p, result)
                            end
                            if attachment_item.resource_dependencies then
                                for resource_name, _ in pairs(attachment_item.resource_dependencies) do
                                    if Managers.package:package_is_known(resource_name) then
                                        result[resource_name] = true
                                    end
                                    inject_weapon_package(resource_name, result)
                                end
                            end
                        end
                    end

                    if gear_id then
                        local material_overrides = mod:gear_material_overrides(item, gear_id, slot)
                        if material_overrides and material_overrides.material_overrides then
                            for i = 1, #material_overrides.material_overrides do
                                local override_name = material_overrides.material_overrides[i]
                                local override_item_name = mod:item_from_material_name(override_name)
                                local override_item = items_dictionary[override_item_name]
                                if override_item and override_item.resource_dependencies then
                                    for resource_name, _ in pairs(override_item.resource_dependencies) do
                                        if Managers.package:package_is_known(resource_name) then
                                            result[resource_name] = true
                                        end
                                        inject_weapon_package(resource_name, result)
                                    end
                                end
                            end
                        end
                    end
                end

                -- Failsafe: sweep existing keys to extract packages (handles native items with missing dependencies)
                local extracted_packages = {}
                for resource_name, _ in pairs(result) do
                    inject_weapon_package(resource_name, extracted_packages)
                end
                for pkg, _ in pairs(extracted_packages) do
                    result[pkg] = true
                end
            end

            return result
        end)

    mod:hook(instance, "compile_resource_dependencies", function(func, item_entry_data, resource_dependencies, ...)
        -- Check item
        if item_entry_data and mod:cached_table_contains(VALID_ITEM_TYPES, item_entry_data.item_type) then
            if not mod:player_owns_item(item_entry_data) then
                -- Randomize item
                item_entry_data = mod:handle_husk_item(item_entry_data)
            end
            -- Modify item
            mod:modify_item(item_entry_data)
            -- Fixes
            mod:apply_attachment_fixes(item_entry_data)
        end
        -- Original function
        return func(item_entry_data, resource_dependencies, ...)
    end)
end)
