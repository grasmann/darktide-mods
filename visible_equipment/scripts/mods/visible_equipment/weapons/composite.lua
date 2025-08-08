-- "content/items/weapons/player/ranged/sights/reflex_sight_03": {
--     "show_in_1p": "true (boolean)",
--     "base_unit": "content/weapons/player/attachments/sights/sight_reflex_03/sight_reflex_03 (string)",
--     "workflow_checklist": {
--     },
--     "is_fallback_item": "false (boolean)",
--     "tags": {
--     },
--     "feature_flags": {
--       "1": "FEATURE_item_retained (string)"
--     },
--     "attach_node": "ap_sight_01 (string)",
--     "resource_dependencies": {
--       "content/weapons/player/attachments/sights/sight_reflex_03/sight_reflex_03": "true (boolean)"
--     },
--     "attachments": {
--       "zzz_shared_material_overrides": {
--         "children": {
--         },
--         "item": " (string)"
--       }
--     },
--     "workflow_state": "RELEASABLE (string)",
--     "display_name": "n/a (string)",
--     "name": "content/items/weapons/player/ranged/sights/reflex_sight_03 (string)",
--     "item_list_faction": "Player (string)"
--   },

  local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local MasterItems = mod:original_require("scripts/backend/master_items")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local type = type
    local pairs = pairs
    local table = table
    local table_size = table.size
    local table_merge_recursive = table.merge_recursive
    local managers = Managers
    local vector3_box = Vector3Box
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local test = {
    sight = {
        model = "content/items/weapons/player/ranged/muzzles/lasgun_rifle_krieg_muzzle_02",
        name = "scope_01",
        scale = vector3_box(1, 1.5, 1),
        children = {
            sight_2 = {
                model = "content/items/weapons/player/ranged/sights/reflex_sight_03",
                name = "scope_sight_03",
                parent = "sight",
                position = vector3_box(0, .07, -.0425),
                rotation = vector3_box(0, 0, 0),
                scale = vector3_box(1.5, .4, 1.35),
                hide_mesh = {{"sight_2", 5}},
            },
            lens = {
                model = "content/items/weapons/player/ranged/bullets/rippergun_rifle_bullet_01",
                name = "scope_lens_02",
                parent = "sight",
                position = vector3_box(0, .105, 0),
                rotation = vector3_box(0, 0, 0),
                scale = vector3_box(1, .275, 1),
                data = {lens = 1},
            },
            lens_2 = {
                model = "content/items/weapons/player/ranged/bullets/rippergun_rifle_bullet_01",
                name = "scope_lens_2_02",
                parent = "sight",
                position = vector3_box(0, .065, 0),
                rotation = vector3_box(180, 0, 0),
                scale = vector3_box(1, .3, 1),
                data = {lens = 2},
            },
        },
    },
}

mod.is_composite_item = function(self, name)
    return self:persistent_table(mod.REFERENCE).composite_items[name]
end

mod.register_composite_item = function(self, name, description)
    if type(description) ~= "table" then return end
    if table_size(description) == 0 then return end
    -- self:setup_item_definitions()

    -- local function get_dependencies(item_name, dependencies)
    --     local item_definition = self:persistent_table(mod.REFERENCE).item_definitions[item_name]
    --     if item_definition then
    --         for package_name, _ in pairs(item_definition.resource_dependencies) do
    --             dependencies[package_name] = true
    --         end
    --     end
    -- end

    
    -- for attachment_slot, data in pairs(description) do
    --     local item_definition = self:persistent_table(mod.REFERENCE).item_definitions[data.model]
    --     if item_definition then
    --         for package_name, _ in pairs(item_definition.resource_dependencies) do
    --             dependencies[package_name] = true
    --         end
    --     end
    -- end

    local anchors = {}
    local dependencies = {}
    local base_unit = nil
    local function add_components(t, components)
        for attachment_slot, data in pairs(components) do
            local anchor = {
                parent = data.parent,
                position = data.position,
                rotation = data.rotation,
                scale = data.scale,
                hide_mesh = data.hide_mesh,
                data = data.data,
            }

            anchors[attachment_slot] = anchor

            t[attachment_slot] = {
                children = {},
                item = data.model,
                attachment_type = attachment_slot,
                attachment_name = data.name,
                anchor = anchor,
            }

            local master_items = MasterItems.get_cached()

            -- local item_definition = self:persistent_table(mod.REFERENCE).item_definitions[data.model]
            local item_definition = master_items[data.model]
            if item_definition then
                for package_name, _ in pairs(item_definition.resource_dependencies) do
                    dependencies[package_name] = true
                    if not data.parent and not base_unit then base_unit = package_name end
                end
            end

            if type(data.children) == "table" and table_size(data.children) > 0 then
                add_components(t[attachment_slot].children, data.children)
            end
        end
    end

    local attachments = {}

    add_components(attachments, description)

    if not base_unit then return end

    local item_definition = {
        show_in_1p = true,
        base_unit = base_unit,
        is_fallback_item = false,
        feature_flags = {
            "FEATURE_item_retained",
        },
        attach_node = "ap_sight_01",
        resource_dependencies = dependencies,
        attachments = table_merge_recursive({
            zzz_shared_material_overrides = {
                children = {},
                item = "",
            }},
            attachments
        ),
        anchors = anchors,
        workflow_state = "RELEASABLE",
        display_name = name,
        name = name,
        item_list_faction = "Player",
    }

    self:persistent_table(mod.REFERENCE).composite_items[name] = true
    self:persistent_table(mod.REFERENCE).item_definitions[name] = item_definition

    -- mod:dtf(self:persistent_table(mod.REFERENCE).item_definitions[name], "item_definition", 10)

end

mod.composite_test = function(self)
    self:register_composite_item("content/items/weapons/player/ranged/scopes/scope_1", test)
end

-- -- Reinitialize on mod reload
-- if managers and managers.player._game_state ~= nil then
-- 	mod:composite_test()
-- end
