local mod = get_mod("visible_equipment")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local CLASS = CLASS
    local pairs = pairs
    local unit_alive = unit.alive
    local script_unit = ScriptUnit
    local script_unit_extension = script_unit.extension
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #############################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################################################

mod:hook_require("scripts/ui/views/inventory_cosmetics_view/inventory_cosmetics_view", function(instance)

    instance.update_placements = function(self)
		local profile_spawner = self._profile_spawner
        if profile_spawner and profile_spawner._character_spawn_data then
            local character_spawn_data = profile_spawner._character_spawn_data
            local equipment_component = character_spawn_data.equipment_component
            if equipment_component then
                equipment_component:position_objects()
                equipment_component:animate_equipment()
            end
        end
	end

    instance.reset_real_placement = function(self)
        local slot = self._selected_slot
        local slot_name = slot and slot.name
        local item = self._presentation_profile.loadout[slot_name]
        local gear_id = item and item.gear_id
        if gear_id then
            mod:gear_placement(gear_id, nil, true)
        end
    end

    instance.update_rotation = function(self, profile, slot_name)
        if self._profile_spawner then
            self._profile_spawner:update_rotation(profile, slot_name)
        end
    end

end)

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.InventoryCosmeticsView, "on_enter", function(func, self, ...)
    -- Original function
    func(self, ...)
    
    local slot = self._selected_slot
    local slot_name = slot and slot.name
    local item = self._presentation_profile.loadout[slot_name]
    local gear_id = item and item.gear_id
    self.placement_name = gear_id and mod:gear_placement(gear_id)
    self.selected_placement = self.placement_name
    self:_update_equip_button_status()
end)

mod:hook(CLASS.InventoryCosmeticsView, "cb_on_equip_pressed", function(func, self, ...)
    if self.selected_placement then
        local slot = self._selected_slot
        local slot_name = slot and slot.name

        local item = self._presentation_profile.loadout[slot_name]
        local gear_id = item and item.gear_id
        if gear_id then
            mod:gear_placement(gear_id, self.selected_placement, true)
            
            local equipped_item = self:equipped_item_in_slot(slot_name)
            self._equip_button_status = "equipped"

            local item_grid = self._item_grid
            local widgets = item_grid and item_grid._grid_widgets
            if widgets then
                for i, widget in pairs(widgets) do
                    if widget.content.placement_name == self.selected_placement then
                        widget.content.current = true
                    else
                        widget.content.current = false
                    end
                end
            end

            self.placement_name = self.selected_placement
            -- self.selected_placement = nil
            self:_update_equip_button_status()
            self:_play_sound(UISoundEvents.apparel_equip_small)

            self._refresh_tab = true
        end
    end
    -- Original function
    func(self, ...)
end)

mod:hook(CLASS.InventoryCosmeticsView, "_spawn_profile", function(func, self, profile, initial_rotation, disable_rotation_input, ...)
    -- Original function
    func(self, profile, initial_rotation, disable_rotation_input, ...)
    -- Set custom camera
    local slot = self._selected_slot
    local slot_name = slot and slot.name
    if slot_name then
        self:update_rotation(self._presentation_profile, slot_name)
    end
end)

mod:hook(CLASS.InventoryCosmeticsView, "_update_equip_button_status", function(func, self, ...)
    local button = self._widgets_by_name.equip_button
	local button_content = button.content
    local inactive = false
    if (self.selected_placement and self.selected_placement == self.placement_name) then
        inactive = true
    end
    button_content.hotspot.disabled = inactive
    if inactive then
        return "equipped"
    else
        return "equip"
    end
    -- Original function
    return func(self, ...)
end)

mod:hook(CLASS.InventoryCosmeticsView, "on_exit", function(func, self, ...)
    -- Original function
    func(self, ...)
    -- Reset gear_id equipment position
    self:reset_real_placement()
    -- Update inventory background view placement
    local inventory_background_view = mod:get_view("inventory_background_view")
    if inventory_background_view then
        -- Update equipment position
        inventory_background_view:update_placements()
    end
    local inventory_view = mod:get_view("inventory_view")
    if self._refresh_tab and inventory_view then
        -- Refresh tab view
        inventory_view:refresh_tab()
        self._refresh_tab = false
    end
end)

mod:hook(CLASS.InventoryCosmeticsView, "_preview_element", function(func, self, element, ...)
    -- self.placement_name = self.placement_name or element.placement_name
    -- Original function
    func(self, element, ...)
    -- Update equipment component
    self:update_placements()
    -- self:update_rotation(self._presentation_profile, self.placement_name)
end)

mod:hook(CLASS.InventoryCosmeticsView, "_stop_previewing", function(func, self, ...)
    -- Original function
    func(self, ...)
    -- Update equipment component
    self:update_placements()
end)
