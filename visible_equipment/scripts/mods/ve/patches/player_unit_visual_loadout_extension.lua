local mod = get_mod("visible_equipment")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local CLASS = CLASS
    local managers = Managers
    local quaternion = Quaternion
    local unit_set_data = unit.set_data
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook_require("scripts/extension_systems/visual_loadout/player_unit_visual_loadout_extension", function(instance)

    instance.update_slot_placement = function(self, slot_name, optional_placement_name_to_save)
        local player = self._player
	    local profile = player and player:profile()
        local item = profile and profile.loadout[slot_name]
        local gear_id = item and mod:gear_id(item)
        mod:gear_placement(gear_id, optional_placement_name_to_save)
    end

    instance.update_equipment_component = function(self)
        local equipment_component = self._equipment_component
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

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "init", function(func, self, extension_init_context, unit, extension_init_data, game_object_data_or_game_session, unit_spawn_parameter_or_game_object_id, ...)
    -- Set pt variable
    self.pt = mod:pt()
    -- Create equipment component tables
    unit_set_data(unit, "visible_equipment_profile", extension_init_data.player:profile())
    -- Events
    managers.event:register(self, "visible_equipment_placement_saved", "update_placement")
    managers.event:register(self, "visible_equipment_update_placements", "update_placements")
    -- Original function
    func(self, extension_init_context, unit, extension_init_data, game_object_data_or_game_session, unit_spawn_parameter_or_game_object_id, ...)
end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "extensions_ready", function(func, self, world, unit, ...)
    -- Original function
    func(self, world, unit, ...)
    -- Update equipment component
    self._equipment_component:extensions_ready()
end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "update", function(func, self, unit, dt, t, ...)
    -- Original function
    func(self, unit, dt, t, ...)
    -- Update equipment component
    self._equipment_component:update(dt, t)
end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "destroy", function(func, self, ...)
    -- Events
    managers.event:unregister(self, "visible_equipment_placement_saved")
    managers.event:unregister(self, "visible_equipment_update_placements")
    -- Destroy equipment component
    self._equipment_component:destroy()
    -- Original function
    func(self, ...)
end)
