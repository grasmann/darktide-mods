local mod = get_mod("visible_equipment")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local ButtonPassTemplates = mod:original_require("scripts/ui/pass_templates/button_pass_templates")
local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")
local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local utf8 = Utf8
    local table = table
    local CLASS = CLASS
    local pairs = pairs
    local Localize = Localize
    local managers = Managers
    local callback = callback
    local utf8_upper = utf8.upper
    local unit_alive = unit.alive
    local script_unit = ScriptUnit
    local table_contains = table.contains
    local script_unit_extension = script_unit.extension
--#endregion

local SLOT_PRIMARY = "slot_primary"
local SLOT_SECONDARY = "slot_secondary"
local SLOT_GEAR_EXTRA_COSMETIC = "slot_gear_extra_cosmetic"
local SLOT_ANIMATION_END_OF_ROUND = "slot_animation_end_of_round"
local supported_slot_names = {SLOT_PRIMARY, SLOT_SECONDARY, SLOT_ANIMATION_END_OF_ROUND}

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
        local profile = mod:profile()
        local slot_name = self._selected_slot and self._selected_slot.name
        local equipped_item = slot_name and profile.loadout[slot_name]
        local gear_id = equipped_item and mod:gear_id(equipped_item)
        if gear_id then
            mod:gear_placement(gear_id, self.original_placement)
        end
    end

    instance.update_rotation = function(self, profile, slot_name)
        if self._profile_spawner then
            self._profile_spawner:update_rotation(profile, slot_name)
        end
    end

    instance.is_valid_slot = function(self, slot_name)
        return table_contains(supported_slot_names, slot_name)
    end

    instance.cb_on_save_script_pressed = function(self)
        -- mod:echo("cb_on_save_script_pressed")
    end

    instance._update_save_script_button_status = function(self)
        local button = self._widgets_by_name.save_script_button
        if button then button.visible = false end
    end

    instance.previewed_item_in_slot = function (self, slot_name)
        local current_loadout = self._preview_profile_equipped_items
        local slot_item = current_loadout and current_loadout[slot_name]
        local item = slot_item and self:_get_item_from_inventory(slot_item)

        return item
    end

end)

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.InventoryCosmeticsView, "on_enter", function(func, self, ...)
    -- Original function
    func(self, ...)
    -- Init
    local slot_name = self._selected_slot and self._selected_slot.name
    if self:is_valid_slot(slot_name) then
        local item = slot_name and self._presentation_profile.loadout[slot_name]
        local gear_id = item and mod:gear_id(item)
        self.placement_name = gear_id and mod:gear_placement(gear_id, nil, true)
        self.original_placement = self.placement_name
        self.selected_placement = self.placement_name
        -- Update equip button
        self:_update_equip_button_status()
    end
end)

-- mod:hook(CLASS.InventoryCosmeticsView, "_spawn_profile", function(func, self, profile, initial_rotation, disable_rotation_input, ...)

    
--     func(self, profile, initial_rotation, disable_rotation_input, ...)

-- end)

mod:hook(CLASS.InventoryCosmeticsView, "_register_button_callbacks", function(func, self, ...)
    -- Original function
    func(self, ...)
    -- Add save script button
    local widgets_by_name = self._widgets_by_name
	widgets_by_name.save_script_button.content.hotspot.pressed_callback = callback(self, "cb_on_save_script_pressed")
end)

mod:hook(CLASS.InventoryCosmeticsView, "update", function(func, self, dt, t, input_service, ...)
    -- Original function
    func(self, dt, t, input_service, ...)
    -- Update save script button
    self:_update_save_script_button_status()
end)

mod:hook(CLASS.InventoryCosmeticsView, "cb_on_equip_pressed", function(func, self, ...)
    if self.selected_placement then
        local slot_name = self._selected_slot and self._selected_slot.name
        if self:is_valid_slot(slot_name) or slot_name == SLOT_GEAR_EXTRA_COSMETIC then
            local item = self._presentation_profile.loadout[slot_name]
            local gear_id = item and mod:gear_id(item)
            if gear_id then
                mod:gear_placement(gear_id, self.selected_placement, true)
                
                self._equip_button_status = "equipped"

                local widgets = self._item_grid and self._item_grid._grid_widgets
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
                self.original_placement = self.selected_placement

                -- Update equip button
                self:_update_equip_button_status()
                -- Sound
                self:_play_sound(UISoundEvents.apparel_equip_small)

                -- Relay event to main menu background, inventory background, player
                managers.event:trigger("visible_equipment_placement_saved", slot_name, self.selected_placement)

            end
        end
    end
    -- Original function
    func(self, ...)

    if not self.selected_placement then
        local slot_name = self._selected_slot and self._selected_slot.name
        if slot_name == SLOT_GEAR_EXTRA_COSMETIC then
            -- Relay event to main menu background, inventory background, player
            managers.event:trigger("visible_equipment_update_placements")
        end
    end
end)

mod:hook(CLASS.InventoryCosmeticsView, "_spawn_profile", function(func, self, profile, initial_rotation, disable_rotation_input, ...)
    local slot_name = self._selected_slot and self._selected_slot.name
    -- Replace weapons
    local profile = self:is_valid_slot(slot_name) and mod:profile() or profile
    -- Original function
    func(self, profile, initial_rotation, disable_rotation_input, ...)
    -- Set custom camera
    if self:is_valid_slot(slot_name) then
        self:update_rotation(self._presentation_profile, slot_name)
    end
    -- if slot_name == SLOT_ANIMATION_END_OF_ROUND then
    --     local profile_spawner = self._profile_spawner
    --     profile_spawner:_set_auto_rotation_return(true)
    -- end
end)

mod:hook(CLASS.InventoryCosmeticsView, "_update_equip_button_status", function(func, self, ...)
    -- Update equip button
    local slot_name = self._selected_slot and self._selected_slot.name
    if self:is_valid_slot(slot_name) then
        local button = self._widgets_by_name.equip_button
        local button_content = button and button.content
        local inactive = false
        if (self.selected_placement and self.selected_placement == self.placement_name) then
            inactive = true
        end
        if button_content then
            button_content.hotspot.disabled = inactive
        end
        if inactive then
            return "equipped"
        end
    end
    -- Original function
    return func(self, ...)
end)

mod:hook(CLASS.InventoryCosmeticsView, "on_exit", function(func, self, ...)
    -- local slot = self._selected_slot
    local slot_name = self._selected_slot and self._selected_slot.name
    if self:is_valid_slot(slot_name) or slot_name == SLOT_GEAR_EXTRA_COSMETIC then
        -- Reset gear_id equipment position
        self:reset_real_placement()
    end
    -- Relay event to main menu background, inventory background, player
    managers.event:trigger("visible_equipment_placement_saved", slot_name, self.original_placement)
    -- Original function
    func(self, ...)
end)

mod:hook(CLASS.InventoryCosmeticsView, "_preview_element", function(func, self, element, ...)
    -- Original function
    func(self, element, ...)
    -- local slot = self._selected_slot
    local slot_name = self._selected_slot and self._selected_slot.name
    if self:is_valid_slot(slot_name) or slot_name == SLOT_GEAR_EXTRA_COSMETIC then
        -- Update equipment component
        self:update_placements()
    end
end)

mod:hook(CLASS.InventoryCosmeticsView, "_stop_previewing", function(func, self, ...)
    -- Original function
    func(self, ...)
    -- local slot = self._selected_slot
    local slot_name = self._selected_slot and self._selected_slot.name
    if self:is_valid_slot(slot_name) or slot_name == SLOT_GEAR_EXTRA_COSMETIC then
        -- Update equipment component
        self:update_placements()
    end
end)
