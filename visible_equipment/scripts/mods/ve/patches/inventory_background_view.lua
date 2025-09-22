local mod = get_mod("visible_equipment")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local CLASS = CLASS
    local managers = Managers
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #############################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################################################

mod:hook_require("scripts/ui/views/inventory_background_view/inventory_background_view", function(instance)

    instance.update_slot_placement = function(self, slot_name, optional_placement_name_to_save)
        local player = self._preview_player
	    local profile = self._presentation_profile or player and player:profile()
        local item = profile and profile.loadout[slot_name]
        local gear_id = item and mod:gear_id(item)
        mod:gear_placement(gear_id, optional_placement_name_to_save)
    end

    instance.update_equipment_component = function(self)
        local profile_spawner = self._profile_spawner
        local character_spawn_data = profile_spawner and profile_spawner._character_spawn_data
        local equipment_component = character_spawn_data and character_spawn_data.equipment_component
        if equipment_component then
            equipment_component:position_objects()
            equipment_component:animate_equipment()
        end
    end

	instance.update_placements = function(self)
        if self._destroyed then return end

        self:update_slot_placement("slot_primary")
        self:update_slot_placement("slot_secondary")
        self:update_equipment_component()

	end

    instance.update_placement = function(self, slot_name, placement_name)
        if self._destroyed then return end

        self:update_slot_placement(slot_name, placement_name)
        self:update_equipment_component()
	end

end)

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.InventoryBackgroundView, "init", function(func, self, settings, context, ...)
    -- Original function
    func(self, settings, context, ...)
    -- Events
    managers.event:register(self, "visible_equipment_placement_saved", "update_placement")
end)

mod:hook(CLASS.InventoryBackgroundView, "on_enter", function(func, self, ...)
    -- Original function
    func(self, ...)
    -- Update equipment position
    self:update_placements()
end)

-- InventoryBackgroundView._equip_slot_item = function (self, slot_name, item, force_update)
mod:hook(CLASS.InventoryBackgroundView, "_equip_slot_item", function(func, self, slot_name, item, force_update, ...)
    -- Original function
    func(self, slot_name, item, force_update, ...)
    -- Update equipment position
    self:update_placements()
end)
