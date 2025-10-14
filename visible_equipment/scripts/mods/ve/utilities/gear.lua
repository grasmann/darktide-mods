local mod = get_mod("visible_equipment")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local type = type
    local pairs = pairs
    local table = table
    local table_contains = table.contains
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local pt = mod:pt()

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

-- mod.gear_id = function(self, item)
--     return item and (item.gear_id or item.__gear_id)
-- end
mod.gear_id = function(self, item, fake_gear_id)
    local gear_id = nil
    -- local fake_gear_id = fake_gear_id or true
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
    -- return pt.gear_id_relays[gear_id] or gear_id
    return gear_id
end

mod.gear_placement = function(self, gear_id, placement, file, no_default)

    if placement and gear_id then

        pt.gear_placements[gear_id] = pt.gear_placements[gear_id] or {}
        local data = pt.gear_placements[gear_id]

        if file then
            mod.save_lua:save_entry(gear_id, data)
        end

        data.placement = placement

    elseif gear_id then

        local data = pt.gear_placements[gear_id]

        if (not data or file) and table_contains(pt.cache, gear_id..".lua") then
            pt.gear_placements[gear_id] = mod.save_lua:load_entry(gear_id)
            data = pt.gear_placements[gear_id]
        end

        return (data and data.placement) or (not no_default and "default")
        
    end

end

mod.fetch_attachment = function(self, attachments, target_slot)
    local attachment_item_path = nil
    for slot, data in pairs(attachments) do
        if type(data.item) == "table" and data.item.attachments then
            attachment_item_path = self:fetch_attachment(data.item.attachments, target_slot)
        end
        if slot == target_slot then
            attachment_item_path = data.item
        elseif data.children then
            attachment_item_path = self:fetch_attachment(data.children, target_slot)
        end
        if attachment_item_path then break end
    end
    return attachment_item_path
end
