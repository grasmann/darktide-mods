local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local ItemMaterialOverridesGearMaterials = mod:original_require("scripts/settings/equipment/item_material_overrides/item_material_overrides_gear_materials")
local ItemMaterialOverridesGearPatterns = mod:original_require("scripts/settings/equipment/item_material_overrides/item_material_overrides_gear_patterns")
local ItemMaterialOverridesGearColors = mod:original_require("scripts/settings/equipment/item_material_overrides/item_material_overrides_gear_colors")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local pairs = pairs
    local table = table
    local table_contains = table.contains
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local pt = mod:pt()
local OVERRIDE_TYPE = table.enum("color", "pattern", "wear")
local ALL_OVERRIDE_TYPES = {OVERRIDE_TYPE.color, OVERRIDE_TYPE.pattern, OVERRIDE_TYPE.wear}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.clear_gear_material_overrides = function(self, item, fake_gear_id, optional_slot_name, optional_override_types)
    local gear_id = self:gear_id(item, fake_gear_id)

    -- Check if gear id has material overrides
    if pt.gear_material_overrides[gear_id] then

        -- Get attachment slots from item
        local attachment_slots = mod:fetch_attachment_slots(item.attachments)
        -- Iterate through attachment slots
        for attachment_slot, data in pairs(attachment_slots) do

            -- Check if optional slot name matches attachment slot
            if not optional_slot_name or optional_slot_name == attachment_slot then

                -- Check if attachment slot has material overrides
                if pt.gear_material_overrides[gear_id][attachment_slot] then

                    -- Get override types
                    local override_types = optional_override_types or ALL_OVERRIDE_TYPES
                    -- Iterate through override types
                    for _, override_type in pairs(override_types) do

                        -- Get material overrides
                        local material_overrides = pt.gear_material_overrides[gear_id][attachment_slot].material_overrides
                        -- Iterate through material overrides
                        for index, material_override in pairs(material_overrides) do
                            -- Check if override type matches
                            if self:override_type(material_override) == override_type then
                                -- Remove material override
                                material_overrides[index] = nil
                            end
                        end

                    end

                end

            end

        end

    end

end

mod.override_type = function(self, material_override)
    if ItemMaterialOverridesGearColors[material_override] then return OVERRIDE_TYPE.color end
    if ItemMaterialOverridesGearPatterns[material_override] then return OVERRIDE_TYPE.pattern end
    if ItemMaterialOverridesGearMaterials[material_override] then return OVERRIDE_TYPE.wear end
end

mod.remove_override_type = function(self, material_overrides, remove_type)
    for index, material_override in pairs(material_overrides) do
        if self:override_type(material_override) == remove_type then
            material_overrides[index] = nil
            return
        end
    end
end

mod.gear_material_overrides = function(self, item, fake_gear_id, slot_name, optional_material_overrides)
    local gear_id = self:gear_id(item, fake_gear_id)
    if optional_material_overrides then

        pt.gear_material_overrides[gear_id] = pt.gear_material_overrides[gear_id] or {}

        if optional_material_overrides == false then

            pt.gear_material_overrides[gear_id][slot_name] = nil

        else

            pt.gear_material_overrides[gear_id][slot_name] = pt.gear_material_overrides[gear_id][slot_name] or {
                material_overrides = {},
            }

            if optional_material_overrides.material_overrides then
                for _, material_override in pairs(optional_material_overrides.material_overrides) do

                    local override_type = self:override_type(material_override)
                    self:remove_override_type(pt.gear_material_overrides[gear_id][slot_name].material_overrides, override_type)

                    -- Set setting
                    pt.gear_material_overrides[gear_id][slot_name].material_overrides[#pt.gear_material_overrides[gear_id][slot_name].material_overrides+1] = material_override

                end
            end

        end
    else
        return pt.gear_material_overrides[gear_id] and pt.gear_material_overrides[gear_id][slot_name]
    end
end

mod.gear_id = function(self, item, fake_gear_id)
    local gear_id = nil
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
    -- Set gear id relay
    pt.gear_id_relays[gear_id] = real_gear_id
end

mod.delete_gear_id_relays = function(self, gear_id)
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
    -- Check settings and gear id
    if settings and gear_id then
        -- Add material overrides
        if settings and pt.gear_material_overrides[gear_id] then
            settings.material_overrides = pt.gear_material_overrides[gear_id]
        end
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
        -- Add material overrides
        if data and data.material_overrides then
            pt.gear_material_overrides[gear_id] = data.material_overrides
        end
        -- Return gear settings
        return data
    end
end

mod.delete_gear_settings = function(self, gear_id, file)
    -- Delete gear settings
    pt.gear_settings[gear_id] = nil
    -- Delete gear id relays
    self:delete_gear_id_relays(gear_id)
    -- Delete file
    if file then
        mod.save_lua:delete_entry(gear_id)
    end
end
