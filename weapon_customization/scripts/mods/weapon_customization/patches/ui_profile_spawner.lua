local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
    local Unit = Unit
    local CLASS = CLASS
    local script_unit = ScriptUnit
    local unit_get_data = Unit.get_data
    local script_unit_has_extension = script_unit.has_extension
    local script_unit_add_extension = script_unit.add_extension
    local script_unit_remove_extension = script_unit.remove_extension
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local WEAPON_CUSTOMIZATION_TAB = "tab_weapon_customization"
    local SLOT_SECONDARY = "slot_secondary"
    local OPTION_VISIBLE_EQUIPMENT = "mod_option_visible_equipment"
    local OPTION_VISIBLE_EQUIPMENT_NO_HUB = "mod_option_visible_equipment_disable_in_hub"
--#endregion

mod:hook_require("scripts/managers/ui/ui_profile_spawner", function(instance)
	
	instance.get_inventory_view = function(self)
		self.inventory_view = self.inventory_view or mod:get_view("inventory_view")
	end

	instance.set_animation = function(self)
		self._last_state_machine = self._pending_state_machine or self._last_state_machine
		self._last_animation_event = self._pending_animation_event or self._last_animation_event
		self._last_face_animation_event = self._pending_face_animation_event or self._last_face_animation_event
		self._last_animation_variable_data = self._pending_animation_variable_data or self._last_animation_variable_data
	end

	instance.reset_animation = function(self)
		self._pending_state_machine = self._pending_state_machine or self._last_state_machine
		self._pending_animation_event = self._pending_animation_event or self._last_animation_event
		self._pending_face_animation_event = self._pending_face_animation_event or self._last_face_animation_event
		self._pending_animation_variable_data = self._pending_animation_variable_data or self._last_animation_variable_data
	end

	instance.freeze_animation = function(self)
		self:get_inventory_view()
		if self.inventory_view then
			local tab_context = self.inventory_view._active_category_tab_context
			local is_tab = tab_context and tab_context.display_name == WEAPON_CUSTOMIZATION_TAB
			if is_tab then
				self:reset_animation()
				self.inventory_view:freeze_animation()
			end
		end
	end

	instance.unfreeze_animation = function(self)
		self:get_inventory_view()
		if self.inventory_view then
			local tab_context = self.inventory_view._active_category_tab_context
			local is_tab = tab_context and tab_context.display_name == WEAPON_CUSTOMIZATION_TAB
			if is_tab then
				self.inventory_view:unfreeze_animation()
				self:reset_animation()
			end
		end
	end

end)

mod:hook(CLASS.UIProfileSpawner, "update", function(func, self, dt, t, input_service, ...)

	self:get_inventory_view()

	-- Original function
	func(self, dt, t, input_service, ...)

	-- Visible equipment
	if self._character_spawn_data then
		mod:execute_extension(self._character_spawn_data.unit_3p, "visible_equipment_system", "load_slots")
		mod:execute_extension(self._character_spawn_data.unit_3p, "visible_equipment_system", "update", dt, t)
	end

	if self.inventory_view then
		local tab_context = self.inventory_view._active_category_tab_context
		local is_tab = tab_context and tab_context.display_name == WEAPON_CUSTOMIZATION_TAB
		if is_tab and not self.inventory_view.frozen then
			self:_apply_pending_animation_data()
		end
	end

end)

mod:hook(CLASS.UIProfileSpawner, "ignore_slot", function(func, self, slot_id, ...)
    if slot_id ~= "slot_primary" and slot_id ~= SLOT_SECONDARY then
        -- Original function
        func(self, slot_id, ...)
    end
end)

mod:hook(CLASS.UIProfileSpawner, "cb_on_unit_3p_streaming_complete", function(func, self, unit_3p, ...)
    -- Original function
    func(self, unit_3p, ...)
    -- Visible equipment
    if self._character_spawn_data and not script_unit_has_extension(unit_3p, "visible_equipment_system") and mod:get(OPTION_VISIBLE_EQUIPMENT) and not self.no_spawn then
        -- Add VisibleEquipmentExtension
        self.visible_equipment_extension = script_unit_add_extension({
            world = self._world,
        }, unit_3p, "VisibleEquipmentExtension", "visible_equipment_system", {
            profile = self._character_spawn_data.profile,
            is_local_unit = true,
            player_unit = unit_3p,
            equipment_component = self._character_spawn_data.equipment_component,
            equipment = self._character_spawn_data.slots,
            wielded_slot = self._character_spawn_data.wielded_slot,
            ui_profile_spawner = true,
        })
        self._rotation_input_disabled = false
    end
end)

mod:hook(CLASS.UIProfileSpawner, "wield_slot", function(func, self, slot_id, ...)
    -- Original function
    func(self, slot_id, ...)
    -- Flashlight
    if self._character_spawn_data then
        local slot = self._character_spawn_data.slots[SLOT_SECONDARY]
        local flashlight = mod:get_attachment_slot_in_attachments(slot.attachments_3p, "flashlight")
        local attachment_name = flashlight and unit_get_data(flashlight, "attachment_name")
        if flashlight and attachment_name and slot_id == SLOT_SECONDARY then
            mod:preview_flashlight(true, self._world, flashlight, attachment_name, true)
        else
            mod:preview_flashlight(false, self._world, flashlight, attachment_name, true)
        end
    end
end)

mod:hook(CLASS.UIProfileSpawner, "destroy", function(func, self, ...)
    -- Visible equipment
    if self._character_spawn_data then
        mod:remove_extension(self._character_spawn_data.unit_3p, "visible_equipment_system")
    end
    -- Original function
    func(self, ...)
end)

mod:hook(CLASS.UIProfileSpawner, "assign_animation_event", function(func, self, animation_event, ...)

    self:unfreeze_animation()

	func(self, animation_event, ...)

	self:freeze_animation()

end)

mod:hook(CLASS.UIProfileSpawner, "_apply_pending_animation_data", function(func, self, ...)

	self:set_animation()
	self:unfreeze_animation()

	func(self, ...)

	self:freeze_animation()

end)

mod:hook(CLASS.UIProfileSpawner, "_update_items_visibility", function(func, self, ...)

    self:set_animation()
	self:unfreeze_animation()

	func(self, ...)

	self:freeze_animation()

end)