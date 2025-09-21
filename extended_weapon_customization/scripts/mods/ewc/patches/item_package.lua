local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local CLASS = CLASS
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/foundation/managers/package/utilities/item_package", function(instance)
    
    mod:hook(instance, "compile_item_instance_dependencies", function(func, item, items_dictionary, out_result, optional_mission_template, ...)
        -- Modify item
        mod:modify_item(item)
        -- Fixes
        mod:apply_attachment_fixes(item)
        -- Original function
        return func(item, items_dictionary, out_result, optional_mission_template, ...)
    end)

    mod:hook(instance, "compile_resource_dependencies", function(func, item_entry_data, resource_dependencies, ...)
        -- Modify item
        mod:modify_item(item_entry_data)
        -- Fixes
        mod:apply_attachment_fixes(item_entry_data)
        -- Original function
        return func(item_entry_data, resource_dependencies, ...)
    end)

end)
