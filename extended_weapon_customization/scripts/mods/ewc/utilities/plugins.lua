local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local type = type
    local pairs = pairs
    local table = table
    local get_mod = get_mod
    local tostring = tostring
    local table_clone = table.clone
    local table_combine = table.combine
    local table_merge_recursive = table.merge_recursive
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "extended_weapon_customization"
local pt = mod:pt()

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.load_plugins = function(self)
    local DMF = get_mod("DMF")
    local plugins = {}

    -- Iterate through all mods
    for _, plugin_mod in pairs(DMF.mods) do
        -- Check if the mod has a extended_weapon_customization_plugin
        if type(plugin_mod) == "table" and plugin_mod.extended_weapon_customization_plugin then
            -- Check if the mod has a extended_weapon_customization_plugin
            local plugin = plugin_mod.extended_weapon_customization_plugin
            if plugin then

                -- Load plugin fixes
                if plugin.fixes then
                    -- Iterate through fixes
                    for weapon_template, fixes in pairs(plugin.fixes) do
                        -- Check fix table for weapon
                        if self.settings.fixes[weapon_template] then
                            -- Iterate through weapon fixes
                            for _, fix in pairs(fixes) do
                                -- Add fix to table
                                self.settings.fixes[weapon_template][#self.settings.fixes[weapon_template]+1] = fix
                            end
                        else
                            -- Create fix table
                            self.settings.fixes[weapon_template] = fixes
                        end
                    end
                end

                -- Load plugin attachments
                if plugin.attachments then
                    -- Attachments are key based - merge table
                    self.settings.attachments = table_merge_recursive(self.settings.attachments, plugin.attachments)
                    -- Update lookup tables
                    mod:update_lookup_tables(plugin.attachments, nil, nil, nil, plugin_mod)
                end

                -- Load plugin attachment slots
                if plugin.attachment_slots then
                    -- Attachment slots are key based - merge table
                    self.settings.attachment_slots = table_merge_recursive(self.settings.attachment_slots, plugin.attachment_slots)
                end

                -- Load plugin kitbashs
                if plugin.kitbashs then
                    -- Load kitbash items
                    self:load_kitbash_collection(plugin.kitbashs)
                end

                -- Load plugin hide_attachment_slots_in_menu
                if plugin.hide_attachment_slots_in_menu then
                    -- Hidden attachment slots are index based - combine table
                    self.settings.hide_attachment_slots_in_menu = table_combine(self.settings.hide_attachment_slots_in_menu, plugin.hide_attachment_slots_in_menu)
                end

                -- Load plugin flashlight templates
                if plugin.flashlight_templates then
                    -- Flashlight templates are key based - merge table
                    self.settings.flashlight_templates = table_merge_recursive(self.settings.flashlight_templates, plugin.flashlight_templates)
                    -- Update flashlight templates
                    self:update_flashlight_templates(self.settings.flashlight_templates)
                end

                if plugin.packages_to_load then
                    -- Packages are key based - merge table
                    self.settings.packages_to_load = table_merge_recursive(self.settings.packages_to_load, plugin.packages_to_load)
                end

            end
            
            mod:print("loaded plugin "..tostring(plugin_mod:localize("mod_title") or plugin_mod:localize("mod_name") or plugin_mod:get_name()))
            plugins[plugin_mod] = plugin
        end
    end

    return plugins
end
