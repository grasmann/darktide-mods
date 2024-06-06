local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local MasterItems = mod:original_require("scripts/backend/master_items")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local pairs = pairs
    local class = class
    local table = table
    local CLASS = CLASS
    local table_clone = table.clone
    local table_clone_instance = table.clone_instance
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local REFERENCE = "weapon_customization"
    local DEBUG = false
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local DataCache = class("DataCache")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

mod.try_init_cache = function(self)
    if self.all_mods_loaded and (not self.data_cache or DEBUG) then
        if MasterItems.get_cached() then
            self.data_cache = DataCache:new()
        end
    end
end

-- Initialize
DataCache.init = function(self)
    self.attachments = mod.attachment
    self.attachment_models = mod.attachment_models
    self.attachment_fixes = mod.anchors
    self.item_definitions = self:setup_item_definitions()
    self.cache = mod:persistent_table(REFERENCE).cache

    self:cache_attachment_data()

    self.initialized = true
end

DataCache.setup_item_definitions = function(self)
    if mod:persistent_table(REFERENCE).item_definitions == nil then
        local master_items = MasterItems.get_cached()
        if master_items then
            mod:persistent_table(REFERENCE).item_definitions = table_clone_instance(master_items)

            -- Bulwark shield
            local definitions = mod:persistent_table(REFERENCE).item_definitions
            local bulwark_shield_string = "content/items/weapons/player/melee/ogryn_bulwark_shield_01"
            if not definitions[bulwark_shield_string] then
                local bulwark_shield_unit = "content/weapons/enemy/shields/bulwark_shield_01/bulwark_shield_01"
                definitions[bulwark_shield_string] = table_clone(definitions["content/items/weapons/player/melee/ogryn_slabshield_p1_m1"])
                local bulwark_shield = definitions[bulwark_shield_string]
                bulwark_shield.name = bulwark_shield_string
                bulwark_shield.base_unit = bulwark_shield_unit
                bulwark_shield.resource_dependencies = {
                    [bulwark_shield_unit] = true,
                }
            end

        end
    end
    return mod:persistent_table(REFERENCE).item_definitions
end

DataCache.cache_attachment_data = function(self)
    if not self.cache.initialized or true then

        for item_name, attachments in pairs(mod.attachment) do
            local melee = "content/items/weapons/player/melee/"..item_name
            local ranged = "content/items/weapons/player/ranged/"..item_name
            local item_string = self.item_definitions[melee] and melee or self.item_definitions[ranged] and ranged
            local item = self.item_definitions[item_string]
            if item then
                -- Cache full item string -> item name
                self.cache.item_names[item_string] = item_name
                -- Cache item name -> full item string
                self.cache.item_strings[item_name] = item_string
                -- Cache item name -> attachment slots
                self.cache.attachment_slots[item_name] = mod.gear_settings:possible_attachment_slots(item, true)
                self.cache.attachment_list[item_name] = {}
                for _, slot in pairs(self.cache.attachment_slots[item_name]) do
                    -- Cache item name -> possible attachments by slot
                    self.cache.attachment_list[item_name][slot] = mod.gear_settings:possible_attachments(item, slot)
                end
                self.cache.default_attachments[item_name] = {}
                for _, slot in pairs(self.cache.attachment_slots[item_name]) do
                    -- Cache item name -> default attachment by slot
                    self.cache.default_attachments[item_name][slot] = mod.gear_settings:default_attachment(item, slot)
                end
            end
        end

        -- Cache initialized
        self.cache.initialized = true

        self:debug_dump()
    end
end

DataCache.item_name_to_default_attachment = function(self, item_name, attachment_slot)
    return self.cache.default_attachments[item_name] and self.cache.default_attachments[item_name][attachment_slot]
end

DataCache.item_name_to_attachment_list = function(self, item_name, attachment_slot_or_nil)
    if attachment_slot_or_nil then
        return self.cache.attachment_list[item_name] and self.cache.attachment_list[item_name][attachment_slot_or_nil]
    else
        return self.cache.attachment_list[item_name] and self.cache.attachment_list[item_name]["all"]
    end
end

DataCache.item_name_to_attachment_slots = function(self, item)
    return self.cache.attachment_slots[item]
end

DataCache.item_name_to_attachments = function(self, item_name)
    return self.cache.attachments[item_name]
end

DataCache.item_name_to_item_string = function(self, item_name)
    return self.cache.item_strings[item_name]
end

DataCache.item_string_to_item_name = function(self, item_string)
    return self.cache.item_names[item_string]
end

DataCache.debug_dump = function(self)
    mod:dtf(self.cache, "self.cache", 10)
end

return DataCache