local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local master_items = mod:original_require("scripts/backend/master_items")
-- mod:dtf(master_items:get_cached(), "master_items", 20)

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    -- local unit = Unit
    local pairs = pairs
    local table = table
    local vector3_box = Vector3Box
    local table_clone = table.clone
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.load_kitbash_collection = function(self, kitbash_collection)
    local pt = self:pt()
    local preload = not pt.game_initialized
    -- Iterate through kitbash collection
    for kitbash_name, kitbash_data in pairs(kitbash_collection) do
        -- Preload or load
        if preload then
            mod:kitbash_preload(kitbash_data.attachments, kitbash_name, kitbash_data.display_name, kitbash_data.description, kitbash_data.attach_node, kitbash_data.dev_name, kitbash_data.disable_vfx_spawner_exclusion)
        else
            mod:kitbash_item(kitbash_data.attachments, kitbash_name, kitbash_data.display_name, kitbash_data.description, kitbash_data.attach_node, kitbash_data.dev_name, kitbash_data.disable_vfx_spawner_exclusion)
        end
    end
end

mod.kitbash_preload = function(self, structure, name, display_name, description, attach_node, optional_dev_name, disable_vfx_spawner_exclusion)
    -- Add kitbash entry to preload table
    self:pt().kitbash_entries[name] = {
        name = name,
        display_name = display_name,
        description = description,
        attach_node = attach_node,
        attachments = structure,
        dev_name = optional_dev_name,
        disable_vfx_spawner_exclusion = disable_vfx_spawner_exclusion,
    }
end

mod.kitbash_item = function(self, structure, name, display_name, description, attach_node, optional_dev_name, disable_vfx_spawner_exclusion)
    -- Get kitbash template
    local template = table_clone(master_items.get_item("content/items/weapons/player/trinkets/unused_trinket"))
    if template then
        -- Modify item
        template.show_in_1p = true
        template.item_list_faction = "Player"
        template.attachments = structure
        template.feature_flags = {}
        template.attach_node = attach_node
        template.description = description
        template.slots = {}
        template.item_type = "KITBASH"
        template.dev_name = optional_dev_name or ""
        template.name = name
        template.display_name = display_name
        template.is_fallback_item = nil
        template.is_kitbash = true
        template.disable_vfx_spawner_exclusion = disable_vfx_spawner_exclusion
        -- Inject item into master items
        master_items.get_cached()[template.name] = template
    end
end

mod.try_kitbash_load = function(self)
    -- Check loaded
    if not self.kitbash_loaded then
        local kitbash_entries = self:pt().kitbash_entries
        -- Iterate through kitbash entries
        for name, kitbash_entry in pairs(kitbash_entries) do
            -- Kitbash item
            self:kitbash_item(kitbash_entry.attachments, name, kitbash_entry.display_name, kitbash_entry.description, kitbash_entry.attach_node, kitbash_entry.dev_name, kitbash_entry.disable_vfx_spawner_exclusion)
        end
        -- Set loaded
        self.kitbash_loaded = true
    end
end

mod:kitbash_preload(
    {
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
    "content/items/weapons/player/ranged/sights/scope_01",
    "loc_scope_01",
    "loc_description_scope_01",
    "ap_sight",
    "loc_scope_01",
    true
)
