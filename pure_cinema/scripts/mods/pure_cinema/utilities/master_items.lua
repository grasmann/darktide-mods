local mod = get_mod("pure_cinema")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local MinionVisualLoadoutTemplates = mod:original_require("scripts/settings/minion_visual_loadout/minion_visual_loadout_templates")
local ItemPackage = mod:original_require("scripts/foundation/managers/package/utilities/item_package")
local master_items = mod:original_require("scripts/backend/master_items")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local pairs = pairs
    local table = table
    local CLASS = CLASS
    local table_clear = table.clear
    local table_contains = table.contains
    local table_clone_instance = table.clone_instance
-- #endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local pt = mod:pt()
local _debug_modified_breed_templates = false
local _temp_dump = {}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

if not pt.master_item_listener then
    pt.master_item_listener = master_items.add_listener(function()
        pt.master_items_loaded = true
        mod:inject_master_items()
    end)
end

mod.inject_master_items = function(self)

    table_clear(_temp_dump)

    for breed_name, breed_weapons in pairs(mod.settings.enemy_weapons) do

        for slot_name, slot_weapons in pairs(breed_weapons) do

            for _, weapon_template in pairs(slot_weapons) do
                
                -- New weapon
                local new_enemy_weapon = table_clone_instance(master_items.get_item(weapon_template.template))

                -- Modify template
                new_enemy_weapon.name = weapon_template.name

                if weapon_template.attachment then

                    -- Get attachment
                    local attachment = master_items.get_item(weapon_template.attachment)
                    new_enemy_weapon.attachments = {
                        overwrite = {
                            item = attachment,
                            children = {},
                        }
                    }

                end

                if weapon_template.wielded_attach_node then
                    new_enemy_weapon.wielded_attach_node = weapon_template.wielded_attach_node
                end

                local master_item_definitions = master_items.get_cached()

                -- Inject master item
                master_item_definitions[new_enemy_weapon.name] = new_enemy_weapon

                -- Load packages
                local resource_packages = ItemPackage.compile_item_instance_dependencies(new_enemy_weapon, master_item_definitions)
                if resource_packages then
                    mod:load_packages(resource_packages)
                end

                -- Inject loadout
                local visual_templates = MinionVisualLoadoutTemplates[breed_name]
                for zone_name, zone_data in pairs(visual_templates) do
                    for _, template in pairs(zone_data) do
                        local slots = template.slots
                        if slots and slots[slot_name] then
                            local slot_data = slots[slot_name]
                            if not table_contains(slots[slot_name].items, new_enemy_weapon.name) then
                                slot_data.items[#slot_data.items + 1] = new_enemy_weapon.name
                                if _debug_modified_breed_templates then
                                    _temp_dump[visual_templates] = breed_name
                                end
                            end
                        end
                    end
                end

            end

        end

    end

    if _debug_modified_breed_templates then
        for visual_templates, breed_name in pairs(_temp_dump) do
            mod:dtf(visual_templates, "visual_templates_"..breed_name, 10)
        end
    end

end
