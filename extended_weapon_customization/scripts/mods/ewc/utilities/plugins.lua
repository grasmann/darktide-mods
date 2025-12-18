local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local type = type
    local pairs = pairs
    local table = table
    local string = string
    local get_mod = get_mod
    local tostring = tostring
    local table_clear = table.clear
    local table_clone = table.clone
    local table_concat = table.concat
    -- local string_split = string.split
    local table_combine = table.combine
    -- local table_contains = table.contains
    local table_merge_recursive = table.merge_recursive
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "extended_weapon_customization"
local pt = mod:pt()
-- local split_cache = {}
-- local temp_exclude = {}
-- local temp_plugins = {}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

-- local function pull_cache(query, seperator)
--     local cache = split_cache[query]
--     local result = cache or string_split(query, seperator)
--     if not split_cache[query] then split_cache[query] = result end
--     return result
-- end

mod.pull_attachment_list_string = function(self, weapon_template, optional_target_slot, optional_target_plugin, optional_exclude, debug)
    local attachment_names = {}
    local excluded_names = {}
    local plugin_list = {}
    -- Get attachment slot parameter
    local target_slot = optional_target_slot ~= "debug" and optional_target_slot or false
    -- Get plugins parameter
    -- local target_plugin = optional_target_plugin ~= "debug" and optional_target_plugin or false
    -- if type(target_plugins) == "string" then target_plugins = {target_plugins} end
    -- Get mods
    local dmf = get_mod("DMF")
    -- Check dmf
    if dmf then

        -- Compile plugin list
        -- table_clear(temp_plugins)
        -- Check exclude parameter
        if optional_target_plugin and optional_target_plugin ~= "debug" then
            -- Check string or table
            if type(optional_target_plugin) == "string" then
                -- Split string with cache
                -- temp_exclude = pull_cache(optional_target_plugin, "|")
                plugin_list = self:cached_split(optional_target_plugin, "|")
            elseif type(optional_target_plugin) == "table" then
                -- Use table
                plugin_list = optional_target_plugin
            end
        else
            for _, plugin_mod in pairs(dmf.mods) do
                -- Check if the mod has a extended_weapon_customization_plugin
                if type(plugin_mod) == "table" and (plugin_mod.extended_weapon_customization_plugin or plugin_mod == self) then
                    plugin_list[#plugin_list+1] = plugin_mod:get_name()
                end
            end
        end

        -- Compile exclude list
        -- table_clear(excluded_names)
        -- Check exclude parameter
        if optional_exclude and optional_exclude ~= "debug" then
            -- Check string or table
            if type(optional_exclude) == "string" then
                -- Split string with cache
                -- temp_exclude = pull_cache(optional_exclude, "|")
                excluded_names = self:cached_split(optional_exclude, "|")
            elseif type(optional_exclude) == "table" then
                -- Use table
                excluded_names = optional_exclude
            end
        end

        if debug then
            self:print("weapon_template: "..tostring(weapon_template))
            self:print("attachment_slot: "..tostring(target_slot))
            self:print("plugin_name: "..tostring(optional_target_plugin))
            for index, target_plugin in pairs(plugin_list) do
                self:print("plugin_name "..tostring(index)..": "..tostring(target_plugin))
            end
            self:print("exclude: "..tostring(optional_exclude))
            for index, exclude in pairs(excluded_names) do
                self:print("exclude "..tostring(index)..": "..tostring(exclude))
            end
        end

        -- Iterate through all mods
        for _, plugin_mod in pairs(dmf.mods) do
            -- Check if the mod has a extended_weapon_customization_plugin
            if type(plugin_mod) == "table" and (plugin_mod.extended_weapon_customization_plugin or plugin_mod == self) then
                -- Iterate through target plugins
                for _, target_plugin in pairs(plugin_list) do
                    -- Check target plugin
                    if not target_plugin or target_plugin == "all" or target_plugin == plugin_mod:get_name() then
                        -- Check if the mod has a extended_weapon_customization_plugin
                        local plugin = plugin_mod.extended_weapon_customization_plugin or pt.extended_weapon_customization_plugin
                        if plugin then
                            -- Get weapon attachments
                            local attachments = plugin.attachments[weapon_template]
                            if attachments then
                                -- Iterate through attachments
                                for attachment_slot, attachment_list in pairs(attachments) do
                                    -- Check if target slot
                                    -- if not target_slot or (target_slot == attachment_slot and not table_contains(excluded_names, attachment_slot)) then
                                    if not mod:cached_table_contains(excluded_names, attachment_slot) and (not target_slot or target_slot == attachment_slot) then
                                        -- Iterate through attachment list
                                        for attachment_name, attachment_data in pairs(attachment_list) do
                                            -- Origin
                                            -- local is_mod_of_origin = pt.attachment_data_origin[attachment_data] == plugin_mod
                                            -- Check exclude
                                            -- if not table_contains(temp_exclude, attachment_name) then
                                            if not mod:cached_table_contains(excluded_names, attachment_name) then --and is_mod_of_origin then
                                                -- Add attachment
                                                attachment_names[#attachment_names+1] = attachment_name
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        if debug then
            for index, attachment_name in pairs(attachment_names) do
                self:print("attachment "..tostring(index)..": "..tostring(attachment_name))
            end
            self:print("")
        end

        -- Return attachment string
        return table_concat(attachment_names, "|")

    end
end

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
                    self:update_lookup_tables(plugin.attachments, nil, nil, nil, plugin_mod)
                end

                -- Load plugin attachment slots
                if plugin.attachment_slots then
                    -- Attachment slots are key based - merge table
                    self.settings.attachment_slots = table_merge_recursive(self.settings.attachment_slots, plugin.attachment_slots)
                    -- Update attachment slots
                    mod:update_attachment_slot_lookup_tables(plugin.attachment_slots, nil, plugin_mod)
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

                if plugin.damage_types then
                    -- Gibbing settings are key based - merge table
                    self.settings.damage_types = table_merge_recursive(self.settings.damage_types, plugin.damage_types)
                end

            end
            
            mod:print("loaded plugin "..tostring(plugin_mod:localize("mod_title") or plugin_mod:localize("mod_name") or plugin_mod:get_name()))
            plugins[plugin_mod] = plugin
        end
    end

    return plugins
end
