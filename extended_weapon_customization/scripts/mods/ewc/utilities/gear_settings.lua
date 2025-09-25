local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local pairs = pairs
    local table = table
    local table_contains = table.contains
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.gear_id = function(self, item, fake_gear_id)
    local pt, gear_id = self:pt(), nil
    -- Check fake gear id
    if not fake_gear_id then
        -- Get real gear id from item
        gear_id = (item and item.__original_gear_id) or
            (item and (item.__is_attachment_selection_item_preview and item.__gear_id or item.gear_id)) or
            (item and (item.__is_ui_item_preview and item.__data and self:gear_id(item.__data))) or
            (item and (item.__gear_id or item.gear_id)) or
            (item and (item.__master_item and (item.__master_item.__gear_id or item.__master_item.gear_id)))
    else
        -- Get fake gear id from item
        gear_id = item and (item.__gear_id or item.gear_id)
    end
    -- Return gear id relay or gear id
    return pt.gear_id_relays[gear_id] or gear_id
end

mod.gear_id_relay = function(self, gear_id, real_gear_id)
    local pt = self:pt()
    -- Set gear id relay
    pt.gear_id_relays[gear_id] = real_gear_id
end

mod.delete_gear_id_relays = function(self, gear_id)
    local pt = self:pt()
    -- Iterate through gear id relays
    for fake_gear_id, real_gear_id in pairs(pt.gear_id_relays) do
        -- Check gear ids
        if fake_gear_id == gear_id or real_gear_id == gear_id then
            -- Delete relay
            pt.gear_id_relays[fake_gear_id] = nil
        end
    end
end

mod.gear_settings = function(self, gear_id, settings, file)
    local pt = self:pt()
    -- Check settings and gear id
    if settings and gear_id then
        -- Set gear settings
        pt.gear_settings[gear_id] = settings
        local data = pt.gear_settings[gear_id]
        -- Save gear settings
        if file then
            mod.save_lua:save_entry(gear_id, settings)
        end
        -- Set gear id settings
        data = settings
    -- Check gear id
    elseif gear_id then
        -- Get gear settings
        local data = pt.gear_settings[gear_id]
        -- Check gear settings and file
        if (not data or file) and table_contains(pt.gear_files, gear_id..".lua") then
            -- Load gear settings
            pt.gear_settings[gear_id] = mod.save_lua:load_entry(gear_id)
            -- Get gear settings
            data = pt.gear_settings[gear_id]
        end
        -- Return gear settings
        return data
    end
end

mod.delete_gear_settings = function(self, gear_id, file)
    local pt = self:pt()
    -- Delete gear settings
    pt.gear_settings[gear_id] = nil
    -- Delete gear id relays
    self:delete_gear_id_relays(gear_id)
    -- Delete file
    if file then
        mod.save_lua:delete_entry(gear_id)
    end
end
