local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    -- local unit = Unit
    local type = type
    local pairs = pairs
    local table = table
    local get_mod = get_mod
    local tostring = tostring
    local table_combine = table.combine
    local table_merge_recursive = table.merge_recursive
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "extended_weapon_customization"

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.load_plugins = function(self)
    local DMF = get_mod("DMF")
    local plugins = {}

    local pt = self:pt()

    -- Iterate through all mods
    for _, plugin_mod in pairs(DMF.mods) do
        -- Check if the mod has a extended_weapon_customization_plugin
        if type(plugin_mod) == "table" and plugin_mod.extended_weapon_customization_plugin then
            -- Check if the mod has a extended_weapon_customization_plugin
            local plugin = plugin_mod.extended_weapon_customization_plugin
            if plugin then

                if plugin.fixes then
                    self.settings.fixes = table_merge_recursive(self.settings.fixes, plugin.fixes)
                end

                if plugin.attachments then
                    self.settings.attachments = table_merge_recursive(self.settings.attachments, plugin.attachments)
                    mod:update_lookup_tables(plugin.attachments)
                end

                if plugin.attachment_slots then
                    self.settings.attachment_slots = table_merge_recursive(self.settings.attachment_slots, plugin.attachment_slots)
                end

                if plugin.kitbashs then
                    self:load_kitbash_collection(plugin.kitbashs)
                end

            end
            mod:echo("Loaded plugin "..tostring(plugin_mod:get_name()))
            plugins[plugin_mod] = plugin
        end
    end

    return plugins
end
