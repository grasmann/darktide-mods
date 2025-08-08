local mod = get_mod("visible_equipment")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local VisualLoadoutCustomization = mod:original_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local CLASS = CLASS
    local pairs = pairs
    local world = World
    local table = table
    local tostring = tostring
    local unit_node = unit.node
    local unit_alive = unit.alive
    local script_unit = ScriptUnit
    local unit_has_node = unit.has_node
    local table_combine = table.combine
    local unit_set_data = unit.set_data
    local unit_get_data = unit.get_data
    local table_contains = table.contains
    local world_link_unit = world.link_unit
    local world_unlink_unit = world.unlink_unit
    local world_destroy_unit = world.destroy_unit
    local script_unit_extension = script_unit.extension
    local script_unit_add_extension = script_unit.add_extension
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local process_slots = {"slot_primary", "slot_secondary"}
local catch_equipment = nil

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #############################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################################################

mod:hook_require("scripts/extension_systems/visual_loadout/equipment_component", function(instance)

    instance.destroy = function(self)
        -- Check visible equipment system
        if self.visible_equipment_system then
            -- Destroy visible equipment
            self.visible_equipment_system:destroy()
        end
        -- Clear equipment component tables
        -- self.pt.map_visible_equipment_by_equipment_component[self] = nil
        self.pt.equipment_components[self] = nil
    end

    instance.footstep = function(self)
        -- Check visible equipment system
        if self.visible_equipment_system then
            -- Destroy visible equipment
            self.visible_equipment_system:footstep()
        end
    end

    instance.update = function(self, dt, t)
        -- Check visible equipment system
        if self.visible_equipment_system then
            -- Update visible equipment
            self.visible_equipment_system:update(dt, t)
        end
    end

    instance.extensions_ready = function(self)
        -- Check visible equipment system
        if self.visible_equipment_system then
            -- Update visible equipment
            self.visible_equipment_system:extensions_ready()
        end
    end

    instance.update_objects = function(self)
        -- Check visible equipment system
        if self.visible_equipment_system then
            -- Update visible equipment
            self.visible_equipment_system:update_objects()
        end
    end

end)

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.EquipmentComponent, "init", function(func, self, world, item_definitions, unit_spawner, unit_3p, optional_extension_manager, optional_item_streaming_settings, optional_force_highest_lod_step, optional_from_ui_profile_spawner, ...)
    -- Original function
    func(self, world, item_definitions, unit_spawner, unit_3p, optional_extension_manager, optional_item_streaming_settings, optional_force_highest_lod_step, optional_from_ui_profile_spawner, ...)
    -- Set pt variable
    self.pt = mod:pt()

    self.pt.equipment_components[self] = unit_3p
    catch_equipment = self

    unit_set_data(unit_3p, "visible_equipment_component", self)

    -- Check if visible equipment extension is already added
    if not self.visible_equipment_system then
        -- Add visible equipment extension
        self.visible_equipment_system = script_unit_add_extension({}, unit_3p, "VisibleEquipmentExtension", "visible_equipment_system", {
            equipment_component = self,
        })
        -- Create equipment component tables
        -- self.pt.map_visible_equipment_by_equipment_component[self] = self.visible_equipment_system
    end
end)

mod:hook(CLASS.EquipmentComponent, "unequip_item", function(func, self, slot, ...)
    -- Check visible equipment system
    if self.visible_equipment_system then
        -- Delete slot
        self.visible_equipment_system:delete_slot(slot)
    end
    -- Original function
    func(self, slot, ...)
end)

mod:hook(CLASS.EquipmentComponent, "initialize_equipment", function(func, slot_configuration, breed_settings, optional_slot_options, ...)
    -- Original function
    local equipment = func(slot_configuration, breed_settings, optional_slot_options, ...)
    -- Catch equipment
    if catch_equipment then
        mod:pt().equipment_by_equipment_component[catch_equipment] = equipment
        catch_equipment = nil
    end
    -- Return equipment
    return equipment
end)

mod:hook(CLASS.EquipmentComponent, "wield_slot", function(func, slot, first_person_mode, ...)
    -- Original function
    func(slot, first_person_mode, ...)

    if slot.parent_unit_3p and unit_alive(slot.parent_unit_3p) then
        local equipment_component = unit_get_data(slot.parent_unit_3p, "visible_equipment_component")

        -- Check visible equipment system
        if equipment_component and equipment_component.visible_equipment_system then
            -- Load slot
            equipment_component.visible_equipment_system:wield_slot(slot)
        end
    end
end)

-- mod:hook(CLASS.EquipmentComponent, "equip_item", function(func, self, unit_3p, unit_1p, slot, item, optional_existing_unit_3p, deform_overrides, optional_breed_name, optional_mission_template, optional_equipment, optional_companion_unit_3p, ...)
--     -- Original function
--     func(self, unit_3p, unit_1p, slot, item, optional_existing_unit_3p, deform_overrides, optional_breed_name, optional_mission_template, optional_equipment, optional_companion_unit_3p, ...)
--     -- Check visible equipment system
--     if self.visible_equipment_system then
--         -- Load slot
--         self.visible_equipment_system:load_slot(slot, optional_mission_template)
--     end
-- end)

mod:hook(CLASS.EquipmentComponent, "_spawn_player_item_units", function(func, self, slot, unit_3p, unit_1p, attach_settings, optional_mission_template, optional_equipment, ...)
    -- Original function
    func(self, slot, unit_3p, unit_1p, attach_settings, optional_mission_template, optional_equipment, ...)
    -- Check visible equipment system
    if slot.item_loaded and self.visible_equipment_system then
        -- Load slot
        self.visible_equipment_system:load_slot(slot, optional_mission_template)
    end
end)

-- mod:hook(CLASS.EquipmentComponent, "_spawn_player_item_units", function(func, self, slot, unit_3p, unit_1p, attach_settings, optional_mission_template, optional_equipment, ...)
mod:hook(CLASS.EquipmentComponent, "_spawn_player_item_attachments", function(func, self, item, slot, optional_mission_template, ...)
    -- Original function
    -- func(self, slot, unit_3p, unit_1p, attach_settings, optional_mission_template, optional_equipment, ...)
    func(self, item, slot, optional_mission_template, ...)
    -- Check visible equipment system
    if self.visible_equipment_system then
        -- Load slot
        self.visible_equipment_system:load_slot(slot, optional_mission_template)
    end
end)

mod:hook(CLASS.EquipmentComponent, "update_item_visibility", function(func, equipment, wielded_slot, unit_3p, unit_1p, first_person_mode, ...)

    -- Original function
    func(equipment, wielded_slot, unit_3p, unit_1p, first_person_mode, ...)

    local equipment_component = unit_get_data(unit_3p, "visible_equipment_component")

    -- Check visible equipment system
    if equipment_component and equipment_component.visible_equipment_system then
        -- Update slot
        equipment_component.visible_equipment_system:update_item_visibility(equipment, wielded_slot)
    end

end)
