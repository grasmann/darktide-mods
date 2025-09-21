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
    local pt, gear_id = self:pt()
    if not fake_gear_id then
        gear_id = (item and item.__original_gear_id) or
            (item and (item.__is_attachment_selection_item_preview and item.__gear_id or item.gear_id)) or
            (item and (item.__is_ui_item_preview and item.__data and self:gear_id(item.__data))) or
            (item and (item.__gear_id or item.gear_id)) or
            (item and (item.__master_item and (item.__master_item.__gear_id or item.__master_item.gear_id)))
    else
        gear_id = item and (item.__gear_id or item.gear_id)
    end
    return pt.gear_id_relays[gear_id] or gear_id
end

mod.gear_id_relay = function(self, gear_id, real_gear_id)
    local pt = self:pt()
    pt.gear_id_relays[gear_id] = real_gear_id
end

mod.gear_settings = function(self, gear_id, settings, file)
    local pt = self:pt()
    if settings and gear_id then
        pt.gear_settings[gear_id] = settings
        local data = pt.gear_settings[gear_id]
        if file then
            mod.save_lua:save_entry(gear_id, settings)
        end
        data = settings
    elseif gear_id then
        local data = pt.gear_settings[gear_id]
        if (not data or file) and table_contains(pt.gear_files, gear_id..".lua") then
            pt.gear_settings[gear_id] = mod.save_lua:load_entry(gear_id)
            data = pt.gear_settings[gear_id]
        end
        return data
    end
end

mod.delete_gear_settings = function(self, gear_id, file)
    local pt = self:pt()
    pt.gear_settings[gear_id] = nil
    for fake_gear_id, real_gear_id in pairs(pt.gear_id_relays) do
        if fake_gear_id == gear_id or real_gear_id == gear_id then
            pt.gear_id_relays[fake_gear_id] = nil
        end
    end
    if file then
        mod.save_lua:delete_entry(gear_id)
    end
end
