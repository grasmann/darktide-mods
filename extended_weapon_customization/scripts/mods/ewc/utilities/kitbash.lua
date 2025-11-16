local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local master_items = mod:original_require("scripts/backend/master_items")
local ItemMaterialOverrides = mod:original_require("scripts/settings/equipment/item_material_overrides/item_material_overrides")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local type = type
    local pairs = pairs
    local table = table
    local tostring = tostring
    local vector3_box = Vector3Box
    local table_clone = table.clone
    local table_merge_recursive = table.merge_recursive
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local pt = mod:pt()

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.load_kitbash_collection = function(self, kitbash_collection)
    local preload = not pt.game_initialized
    -- Iterate through kitbash collection
    for kitbash_name, data in pairs(kitbash_collection) do
        -- Preload or load
        if preload then
            -- Preload kitbash item
            self:kitbash_preload(kitbash_name, data)
        else
            -- Kitbash item directly
            self:kitbash_item(kitbash_name, data)
        end
    end
end

mod.kitbash_preload = function(self, name, data)
    -- Add kitbash entry to preload table
    pt.kitbash_entries[name] = data
end

mod.kitbash_item = function(self, name, data)
    if data and type(data) == "table" then

        self:print("kitbashing item "..tostring(name))

        if not data.is_full_item then

            -- Get kitbash template
            local template = table_clone(master_items.get_item("content/items/weapons/player/trinkets/unused_trinket"))
            if template then

                -- Merge data
                template = table_merge_recursive(template, data)

                -- Set attachments
                -- template.attachments = data.attachments

                -- Add resource dependencies
                local resource_dependencies = template.resource_dependencies or {
                    ["content/characters/empty_item/empty_item"] = true,
                }

                if data.material_overrides then
                    for _, material_override_name in pairs(data.material_overrides) do

                        local material_override_data = ItemMaterialOverrides[material_override_name]

                        if material_override_data and material_override_data.texture_overrides then

                            for texture_slot, texture_override_data in pairs(material_override_data.texture_overrides) do
                                resource_dependencies[texture_override_data.resource] = true
                                mod:print("added material override "..tostring(material_override_name).." resource "..tostring(texture_override_data.resource))
                            end

                        end

                    end
                end

                -- Add shared material overrides
                if template.attachments then

                    if not data.disable_shared_material_overrides and not template.attachments.zzz_shared_material_overrides then
                        template.attachments.zzz_shared_material_overrides = {
                            item = "",
                            children = {},
                        }
                    else
                        template.attachments.zzz_shared_material_overrides = nil
                    end

                    local attachment_slots = self:fetch_attachment_slots(template.attachments)
                    for attachment_slot, data in pairs(attachment_slots) do
                        local item = master_items.get_item(data.item)
                        if item then

                            resource_dependencies = table_merge_recursive(resource_dependencies, item.resource_dependencies)

                            if item.material_overrides then
                                for _, material_override_name in pairs(item.material_overrides) do

                                    local material_override_data = ItemMaterialOverrides[material_override_name]

                                    if material_override_data and material_override_data.texture_overrides then

                                        for texture_slot, texture_override_data in pairs(material_override_data.texture_overrides) do
                                            resource_dependencies[texture_override_data.resource] = true
                                            mod:print("added material override "..tostring(material_override_name).." resource "..tostring(texture_override_data.resource))
                                        end

                                    end

                                end
                            end
                        end
                    end

                end

                template.resource_dependencies = resource_dependencies

                -- Other attributes
                template.show_in_1p = true
                template.item_list_faction = "Player"
                template.material_overrides = nil
                template.rarity = nil
                template.slots = nil
                template.source = nil
                template.feature_flags = {
                    "FEATURE_item_retained",
                }
                template.item_type = nil --"KITBASH"
                template.name = name
                template.is_fallback_item = false
                template.is_kitbash = true

                -- Inject item into master items
                master_items.get_cached()[template.name] = template

            end

        else

            data.is_kitbash = true

            local resource_dependencies = data.resource_dependencies or {}

            if data.material_overrides then
                for _, material_override_name in pairs(data.material_overrides) do

                    local material_override_data = ItemMaterialOverrides[material_override_name]

                    if material_override_data and material_override_data.texture_overrides then

                        for texture_slot, texture_override_data in pairs(material_override_data.texture_overrides) do
                            resource_dependencies[texture_override_data.resource] = true
                            mod:print("added material override "..tostring(material_override_name).." resource "..tostring(texture_override_data.resource))
                        end

                    end

                end
            end

            if data.attachments then

                -- Add shared material overrides
                if not data.disable_shared_material_overrides and not data.attachments.zzz_shared_material_overrides then
                    data.attachments.zzz_shared_material_overrides = {
                        item = "",
                        children = {},
                    }
                else
                    data.attachments.zzz_shared_material_overrides = nil
                end

                local attachment_slots = self:fetch_attachment_slots(data.attachments)
                for attachment_slot, attachment_slot_data in pairs(attachment_slots) do
                    local item = master_items.get_item(attachment_slot_data.item)
                    if item then

                        resource_dependencies = table_merge_recursive(resource_dependencies, item.resource_dependencies)

                        if item.material_overrides then
                            for _, material_override_name in pairs(item.material_overrides) do

                                local material_override_data = ItemMaterialOverrides[material_override_name]

                                if material_override_data and material_override_data.texture_overrides then

                                    for texture_slot, texture_override_data in pairs(material_override_data.texture_overrides) do
                                        resource_dependencies[texture_override_data.resource] = true
                                        mod:print("added material override "..tostring(material_override_name).." resource "..tostring(texture_override_data.resource))
                                    end

                                end

                            end
                        end
                    end
                end

            end

            data.resource_dependencies = resource_dependencies

            -- Inject item into master items
            master_items.get_cached()[data.name] = data

        end
    end
end

mod.try_kitbash_load = function(self)
    -- Check loaded
    if not self.kitbash_loaded then

        self:print("loading kitbash items")

        local kitbash_entries = pt.kitbash_entries
        if kitbash_entries then
            -- Iterate through kitbash entries
            for kitbash_name, data in pairs(kitbash_entries) do
                -- Kitbash item
                self:kitbash_item(kitbash_name, data)
            end
        end

        self:print("kitbash items finished loading")

        -- Set loaded
        self.kitbash_loaded = true
    end
end
