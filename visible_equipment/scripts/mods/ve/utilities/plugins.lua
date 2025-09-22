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
    local tostring = tostring
    local table_combine = table.combine
    local table_merge_recursive = table.merge_recursive
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
    for _, plugin_mod in pairs(DMF.mods) do
        -- Check if the mod has a visible_equipment_plugin
        if type(plugin_mod) == "table" and plugin_mod.visible_equipment_plugin then

            -- Check if the mod has a visible_equipment_plugin
            local plugin = plugin_mod.visible_equipment_plugin
            if plugin then
                -- Merge settings from plugin

                if plugin.offsets then
                    self.settings.offsets = table_merge_recursive(self.settings.offsets, plugin.offsets)
                end

                if plugin.animations then
                    self.settings.animations = table_merge_recursive(self.settings.animations, plugin.animations)
                end

                if plugin.sounds then
                    self.settings.sounds = table_merge_recursive(self.settings.sounds, plugin.sounds)
                end

                if plugin.backpacks then
                    self.settings.backpacks = table_merge_recursive(self.settings.backpacks, plugin.backpacks)
                end

                if plugin.momentum then
                    self.settings.momentum = table_merge_recursive(self.settings.momentum, plugin.momentum)
                end

                if plugin.placements then
                    self.settings.placements = table_merge_recursive(self.settings.placements, plugin.placements)
                end

                if plugin.placement_camera then
                    self.settings.placement_camera = table_merge_recursive(self.settings.placement_camera, plugin.placement_camera)
                end
            end

            mod:echo("Loaded plugin "..tostring(plugin_mod:get_name()))

            plugins[plugin_mod] = plugin

        end
    end

    return plugins
end