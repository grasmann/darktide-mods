local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local CLASS = CLASS
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local WEAPON_RANGED = "WEAPON_RANGED"
local WEAPON_MELEE = "WEAPON_MELEE"
local VALID_ITEM_TYPES = {WEAPON_MELEE, WEAPON_RANGED}

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/foundation/managers/package/utilities/item_package", function(instance)
    
    mod:hook(instance, "compile_item_instance_dependencies", function(func, item, items_dictionary, out_result, optional_mission_template, ...)
        -- Check item
        if item and mod:cached_table_contains(VALID_ITEM_TYPES, item.item_type) then
            -- Modify item
            mod:modify_item(item)
            -- Fixes
            mod:apply_attachment_fixes(item)
        end
        -- Original function
        return func(item, items_dictionary, out_result, optional_mission_template, ...)
    end)

    mod:hook(instance, "compile_resource_dependencies", function(func, item_entry_data, resource_dependencies, ...)
        -- Check item
        if item_entry_data and mod:cached_table_contains(VALID_ITEM_TYPES, item_entry_data.item_type) then
            -- Modify item
            mod:modify_item(item_entry_data)
            -- Fixes
            mod:apply_attachment_fixes(item_entry_data)
        end
        -- Original function
        return func(item_entry_data, resource_dependencies, ...)
    end)

end)
