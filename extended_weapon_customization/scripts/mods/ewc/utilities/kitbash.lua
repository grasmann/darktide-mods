local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local master_items = mod:original_require("scripts/backend/master_items")

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

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.load_kitbash_collection = function(self, kitbash_collection)
    local pt = self:pt()
    local preload = not pt.game_initialized
    -- Iterate through kitbash collection
    for kitbash_name, data in pairs(kitbash_collection) do
        -- Preload or load
        if preload then
            -- mod:kitbash_preload(kitbash_data.attachments, kitbash_name, kitbash_data.display_name, kitbash_data.description, kitbash_data.attach_node, kitbash_data.dev_name, kitbash_data.disable_vfx_spawner_exclusion)
            self:kitbash_preload(kitbash_name, data)
        else
            -- mod:kitbash_item(kitbash_data.attachments, kitbash_name, kitbash_data.display_name, kitbash_data.description, kitbash_data.attach_node, kitbash_data.dev_name, kitbash_data.disable_vfx_spawner_exclusion)
            self:kitbash_item(kitbash_name, data)
        end
    end
end

-- mod.kitbash_preload = function(self, structure, name, display_name, description, attach_node, optional_dev_name, disable_vfx_spawner_exclusion)
mod.kitbash_preload = function(self, name, data)
    -- Add kitbash entry to preload table
    self:pt().kitbash_entries[name] = data
end

-- mod.kitbash_item = function(self, structure, name, display_name, description, attach_node, optional_dev_name, disable_vfx_spawner_exclusion)
mod.kitbash_item = function(self, name, data)
    if data and type(data) == "table" then
        -- Get kitbash template
        local template = table_clone(master_items.get_item("content/items/weapons/player/trinkets/unused_trinket"))
        if template then
            -- Modify item

            template = table_merge_recursive(template, data)

            template.show_in_1p = true
            template.item_list_faction = "Player"

            -- Copy attachments
            template.structure = table_clone(data.attachments)
            template.attachments = self:clear_attachment_fixes(data.attachments)

            -- Add shared material overrides
            if not template.attachments.zzz_shared_material_overrides then
                template.attachments.zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                }
            end

            -- Add resource dependencies
            local resource_dependencies = {
                ["content/characters/empty_item/empty_item"] = true,
            }
            local attachment_slots = self:fetch_attachment_slots(template.attachments)
            for attachment_slot, data in pairs(attachment_slots) do
                local item = master_items.get_item(data.item)
                if item then
                    resource_dependencies = table_merge_recursive(resource_dependencies, item.resource_dependencies)
                end
            end
            template.resource_dependencies = resource_dependencies

            template.material_overrides = nil
            template.rarity = nil
            template.slots = nil
            template.source = nil
            template.feature_flags = {
                "FEATURE_item_retained",
            }
            -- template.attach_node = data.attach_node
            -- template.description = data.description or name
            template.slots = nil
            template.item_type = nil --"KITBASH"
            -- template.dev_name = data.dev_name or name
            template.name = name
            -- template.display_name = data.display_name or name
            template.is_fallback_item = false
            template.is_kitbash = true
            -- template.disable_vfx_spawner_exclusion = data.disable_vfx_spawner_exclusion
            -- Inject item into master items
            master_items.get_cached()[template.name] = template

        end
    end
end

mod.try_kitbash_load = function(self)
    -- Check loaded
    if not self.kitbash_loaded then

        self:print("loading kitbash items")

        local kitbash_entries = self:pt().kitbash_entries
        if kitbash_entries then
            -- Iterate through kitbash entries
            for kitbash_name, data in pairs(kitbash_entries) do
                -- Kitbash item
                -- self:kitbash_item(kitbash_entry.attachments, name, kitbash_entry.display_name, kitbash_entry.description, kitbash_entry.attach_node, kitbash_entry.dev_name, kitbash_entry.disable_vfx_spawner_exclusion)
                self:kitbash_item(kitbash_name, data)
            end
        end

        self:print("kitbash items finished loading")
        self:dtf(master_items.get_cached(), "master_items", 20)

        -- Set loaded
        self.kitbash_loaded = true
    end
end


mod:kitbash_preload(
    "content/items/weapons/player/ranged/sights/scope_01",
    {
        attachments = {
            base = {
                item = "content/items/weapons/player/ranged/sights/reflex_sight_03",
                fix = {
                    disable_in_ui = true,
                    offset = {
                        node = 1,
                        position = vector3_box(0, 0, .115),
                        rotation = vector3_box(0, 0, 0),
                        scale = vector3_box(1, 1, 1),
                    },
                },
                children = {
                    body = {
                        item = "content/items/weapons/player/ranged/muzzles/lasgun_rifle_krieg_muzzle_02",
                        fix = {
                            offset = {
                                node = 1,
                                position = vector3_box(0, -.04, .05),
                                rotation = vector3_box(0, 0, 0),
                                scale = vector3_box(1.5, 1.5, 1.5),
                            },
                        },
                        children = {
                            lense_1 = {
                                item = "content/items/weapons/player/ranged/bullets/rippergun_rifle_bullet_01",
                                fix = {
                                    offset = {
                                        node = 1,
                                        position = vector3_box(0, .085, 0),
                                        rotation = vector3_box(0, 0, 0),
                                        scale = vector3_box(1, .35, 1),
                                    },
                                },
                            },
                            lense_2 = {
                                item = "content/items/weapons/player/ranged/bullets/rippergun_rifle_bullet_01",
                                fix = {
                                    offset = {
                                        node = 1,
                                        position = vector3_box(0, .075, 0),
                                        rotation = vector3_box(180, 0, 0),
                                        scale = vector3_box(1, .35, 1),
                                    },
                                },
                            },
                        },
                    },
                },
            },
        },
        attach_node = "ap_sight",
        display_name = "loc_scope_01",
        description = "loc_description_scope_01",
        dev_name = "loc_scope_01",
        disable_vfx_spawner_exclusion = true
    }
)

-- mod:kitbash_preload(
--     {
--         base = {
--             item = "content/items/weapons/player/ranged/sights/reflex_sight_03",
--             fix = {
--                 disable_in_ui = true,
--                 offset = {
--                     node = 1,
--                     position = vector3_box(0, 0, .115),
--                     rotation = vector3_box(0, 0, 0),
--                     scale = vector3_box(1, 1, 1),
--                 },
--             },
--             children = {
--                 body = {
--                     item = "content/items/weapons/player/ranged/muzzles/lasgun_rifle_krieg_muzzle_02",
--                     fix = {
--                         offset = {
--                             node = 1,
--                             position = vector3_box(0, -.04, .05),
--                             rotation = vector3_box(0, 0, 0),
--                             scale = vector3_box(1.5, 1.5, 1.5),
--                         },
--                     },
--                     children = {
--                         lense_1 = {
--                             item = "content/items/weapons/player/ranged/bullets/rippergun_rifle_bullet_01",
--                             fix = {
--                                 offset = {
--                                     node = 1,
--                                     position = vector3_box(0, .085, 0),
--                                     rotation = vector3_box(0, 0, 0),
--                                     scale = vector3_box(1, .35, 1),
--                                 },
--                             },
--                         },
--                         lense_2 = {
--                             item = "content/items/weapons/player/ranged/bullets/rippergun_rifle_bullet_01",
--                             fix = {
--                                 offset = {
--                                     node = 1,
--                                     position = vector3_box(0, .075, 0),
--                                     rotation = vector3_box(180, 0, 0),
--                                     scale = vector3_box(1, .35, 1),
--                                 },
--                             },
--                         },
--                     },
--                 },
--             },
--         },
--     },
--     "content/items/weapons/player/ranged/sights/scope_01",
--     "loc_scope_01",
--     "loc_description_scope_01",
--     "ap_sight",
--     "loc_scope_01",
--     true
-- )
