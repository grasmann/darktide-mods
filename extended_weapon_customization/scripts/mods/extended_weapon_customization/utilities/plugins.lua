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
                -- Merge settings from plugin

                if plugin.fixes then
                    self.settings.fixes = table_merge_recursive(self.settings.fixes, plugin.fixes)
                end

                if plugin.attachments then
                    self.settings.attachments = table_merge_recursive(self.settings.attachments, plugin.attachments)

                    local attachment_data_by_item_string = {}
                    local attachment_name_by_item_string = {}

                    for weapon_template, attachments in pairs(plugin.attachments) do
                        for attachment_slot, attachment_entires in pairs(attachments) do
                            for attachment_name, attachment_data in pairs(attachment_entires) do
                                attachment_data_by_item_string[attachment_data.replacement_path] = attachment_data
                                attachment_name_by_item_string[attachment_data.replacement_path] = attachment_name
                            end
                        end
                    end

                    local attachment_data_by_attachment_name = {}

                    for weapon_template, attachments in pairs(plugin.attachments) do
                        for attachment_slot, attachment_entires in pairs(attachments) do
                            for attachment_name, attachment_data in pairs(attachment_entires) do
                                attachment_data_by_attachment_name[attachment_name] = attachment_data
                            end
                        end
                    end

                    self.settings.attachment_data_by_item_string = table_merge_recursive(self.settings.attachment_data_by_item_string, attachment_data_by_item_string)
                    self.settings.attachment_name_by_item_string = table_merge_recursive(self.settings.attachment_name_by_item_string, attachment_name_by_item_string)
                    self.settings.attachment_data_by_attachment_name = table_merge_recursive(self.settings.attachment_data_by_attachment_name, attachment_data_by_attachment_name)

                end

                if plugin.attachment_slots then
                    self.settings.attachment_slots = table_merge_recursive(self.settings.attachment_slots, plugin.attachment_slots)
                end

                if plugin.kitbash then
                    for kitbash_name, kitbash_data in pairs(plugin.kitbash) do
                        if not pt.game_initialized then
                            self:kitbash_preload(kitbash_data.attachments, kitbash_name, kitbash_data.display_name, kitbash_data.description, kitbash_data.attach_node, kitbash_data.dev_name)
                        else
                            self:kitbash_item(kitbash_data.attachments, kitbash_name, kitbash_data.display_name, kitbash_data.description, kitbash_data.attach_node, kitbash_data.dev_name)
                        end
                    end
                end

            end

            mod:echo("Loaded plugin "..tostring(plugin_mod:get_name()))

            plugins[plugin_mod] = plugin

        end
    end

    return plugins
end
