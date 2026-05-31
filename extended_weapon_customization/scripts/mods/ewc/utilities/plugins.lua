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
    local string_sub = string.sub
    local table_clear = table.clear
    local table_clone = table.clone
    local table_concat = table.concat
    local table_combine = table.combine
    local table_contains = table.contains
    local table_merge_recursive = table.merge_recursive
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "extended_weapon_customization"
local pt = mod:pt()
local temp_requirement_parts = {}
local temp_query_params = {}
local temp_inner_query_params = {}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.handle_attachment_query = function(self, query)
    -- Check query
    if string_sub(query, 1, 6) == "query:" then

        -- Check debug
        local debug = self:cached_find(query, "debug")
        if debug then
            -- Debug
            self:print("")
            self:print("handling attachment query:")
        end

        -- Split string with cache
        temp_query_params = self:cached_split(query, ":")

        -- Check parameters
        if temp_query_params and temp_query_params[2] then
            -- Split string with cache
            temp_inner_query_params = self:cached_split(temp_query_params[2], ",")
            -- Check parameters
            if temp_inner_query_params and temp_inner_query_params[1] and temp_inner_query_params[1] ~= "debug" then
                -- Pull attachment list and return
                return self:pull_attachment_list_string(temp_inner_query_params[1], temp_inner_query_params[2], temp_inner_query_params[3], temp_inner_query_params[4], debug)
            end
        end
    end

    -- Return query
    return query

end

mod.pull_attachment_list_string = function(self, weapon_template, optional_target_slot, optional_target_plugin, optional_exclude, debug)

    local attachment_names = {}
    local excluded_names = {}
    local plugin_list = {}

    -- Get attachment slot parameter
    local target_slot = optional_target_slot ~= "debug" and optional_target_slot or false
    -- Get mods
    local dmf = get_mod("DMF")

    -- Check dmf
    if dmf then

        -- Check exclude parameter
        if optional_target_plugin and optional_target_plugin ~= "debug" then
            -- Check string or table
            if type(optional_target_plugin) == "string" then
                -- Split string with cache
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
        if optional_exclude and optional_exclude ~= "debug" then
            -- Check string or table
            if type(optional_exclude) == "string" then
                -- Split string with cache
                excluded_names = self:cached_split(optional_exclude, "|")
            elseif type(optional_exclude) == "table" then
                -- Use table
                excluded_names = optional_exclude
            end
        end

        -- Check debug
        if debug then
            -- Debug query parameters
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
                                    if not table_contains(excluded_names, attachment_slot) and (not target_slot or target_slot == attachment_slot) then
                                        -- Iterate through attachment list
                                        for attachment_name, attachment_data in pairs(attachment_list) do
                                            -- Check exclude
                                            if not table_contains(excluded_names, attachment_name) then
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

        -- Check debug
        if debug then
            -- Debug attachment list
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

    table_clear(pt.loaded_plugins)

    -- Iterate through all mods
    for _, plugin_mod in pairs(DMF.mods) do
        -- Check if the mod has a extended_weapon_customization_plugin
        if type(plugin_mod) == "table" and plugin_mod.extended_weapon_customization_plugin then
            -- Check if the mod has a extended_weapon_customization_plugin
            local plugin = plugin_mod.extended_weapon_customization_plugin
            if plugin then

                -- Loaded plugins
                if plugin_mod ~= self then
                    pt.loaded_plugins[plugin_mod:get_name()] = plugin
                end

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
                    self:update_lookup_tables(plugin.attachments, nil, nil, nil, nil, plugin_mod, plugin_mod ~= self)
                end

                -- Load plugin attachment slots
                if plugin.attachment_slots then
                    -- Attachment slots are key based - merge table
                    self.settings.attachment_slots = table_merge_recursive(self.settings.attachment_slots, plugin.attachment_slots)
                    -- Update attachment slots
                    self:update_attachment_slot_lookup_tables(plugin.attachment_slots, nil, plugin_mod, true)
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
            
            self:print("loaded plugin "..tostring(plugin_mod:localize("mod_title") or plugin_mod:localize("mod_name") or plugin_mod:get_name()))
            plugins[plugin_mod] = plugin
            
        end
    end

    return plugins
end
