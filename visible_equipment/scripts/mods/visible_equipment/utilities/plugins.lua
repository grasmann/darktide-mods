local mod = get_mod("visible_equipment")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    -- local unit = Unit
    local type = type
    local pairs = pairs
    local table = table
    local get_mod = get_mod
    local table_combine = table.combine
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "visible_equipment"

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.load_plugins = function(self)
    local DMF = get_mod("DMF")
    local plugins = {}

    -- Iterate through all mods
    for _, mod_entry in pairs(DMF.mods) do
        -- Check if the mod has a visible_equipment_plugin
        if type(mod_entry) == "table" and mod_entry.visible_equipment_plugin then

            local plugin = mod_entry.visible_equipment_plugin

            if plugin and plugin.offsets then
                
            end

            if plugin and plugin.animations then

            end

            if plugin and plugin.sounds then

            end

            plugins[mod_entry] = plugin

        end
    end

    return plugins
end