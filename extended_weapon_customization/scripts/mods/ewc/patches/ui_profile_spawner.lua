local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local master_items = mod:original_require("scripts/backend/master_items")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local CLASS = CLASS
    local tostring = tostring
    local managers = Managers
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local pt = mod:pt()
local SLOT_PRIMARY = "slot_primary"
local SLOT_SECONDARY = "slot_secondary"
local PROCESS_SLOTS = {SLOT_PRIMARY, SLOT_SECONDARY}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.ui_profile_spawner_change_equipment = function(self, ui_profile_spawner)
    if not ui_profile_spawner.ewc_equipment_changed then
        local loading_profile_data = ui_profile_spawner._loading_profile_data
        -- local character_spawn_data = ui_profile_spawner._character_spawn_data
        local data = loading_profile_data --character_spawn_data or loading_profile_data
        local data_profile = data and data.profile
        if data_profile and data_profile.visual_loadout then
            mod:print("attempting to change equipment for character "..tostring(data_profile.name))

            mod:print("changing primary item")
            -- ui_profile_spawner:_change_slot_item(SLOT_PRIMARY, data_profile.loadout[SLOT_PRIMARY], data_profile.loadout, data_profile.visual_loadout)
            data_profile.visual_loadout[SLOT_PRIMARY] = data_profile.loadout[SLOT_PRIMARY]
            mod:print("changing secondary item")
            -- ui_profile_spawner:_change_slot_item(SLOT_SECONDARY, data_profile.loadout[SLOT_SECONDARY], data_profile.loadout, data_profile.visual_loadout)
            data_profile.visual_loadout[SLOT_SECONDARY] = data_profile.loadout[SLOT_SECONDARY]

            ui_profile_spawner:_sync_profile_changes()

            ui_profile_spawner.ewc_equipment_changed = true
        end
    end
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.UIProfileSpawner, "ignore_slot", function(func, self, slot_id, ...)
	-- Skip primary and secondary slots
	if slot_id ~= SLOT_PRIMARY and slot_id ~= SLOT_SECONDARY then
		-- Original function
		func(self, slot_id, ...)
	end
end)

mod:hook(CLASS.UIProfileSpawner, "spawn_profile", function(func, self, profile, position, rotation, scale, state_machine_or_nil, animation_event_or_nil, face_state_machine_key_or_nil, face_animation_event_or_nil, force_highest_mip_or_nil, disable_hair_state_machine_or_nil, optional_unit_3p, optional_ignore_state_machine, companion_data, ...)
    self.ewc_equipment_changed = nil
    -- Unset ignore slots
    -- So that the real equipped items are loaded
    if not self._placement_name then
        self._ignored_slots[SLOT_SECONDARY] = nil
        self._ignored_slots[SLOT_PRIMARY] = nil
    end
    -- Original function
    func(self, profile, position, rotation, scale, state_machine_or_nil, animation_event_or_nil, face_state_machine_key_or_nil, face_animation_event_or_nil, force_highest_mip_or_nil, disable_hair_state_machine_or_nil, optional_unit_3p, optional_ignore_state_machine, companion_data, ...)
end)

-- mod:hook(CLASS.UIProfileSpawner, "cb_on_unit_3p_streaming_complete", function(func, self, unit_3p, timeout, ...)
--     -- Original function
--     func(self, unit_3p, timeout, ...)
-- end)

mod:hook(CLASS.UIProfileSpawner, "wield_slot", function(func, self, slot_id, ...)

    local world = self._world
	local character_spawn_data = self._character_spawn_data
    if character_spawn_data then

        local wielded_slot = character_spawn_data.wielded_slot
	    local slot_id = wielded_slot and wielded_slot.name
	    local slot = slot_id and character_spawn_data.slots[slot_id]
        local equipped_items = character_spawn_data.equipped_items
        local slot_item = equipped_items and equipped_items[slot_id]

        if slot and slot.unit_3p and slot.attachments_by_unit_3p and slot.attachments_by_unit_3p[slot.unit_3p] then
            mod:execute_attachment_callbacks_in_item(slot_item, world, slot.attachments_by_unit_3p[slot.unit_3p], "ui_item_deinit")
        end

    end

    -- Original function
    func(self, slot_id, ...)

    local character_spawn_data = self._character_spawn_data
    if character_spawn_data then

	    local slot = slot_id and character_spawn_data.slots[slot_id]
        local equipped_items = character_spawn_data.equipped_items
        local slot_item = equipped_items and equipped_items[slot_id]

        if slot and slot.unit_3p and slot.attachments_by_unit_3p and slot.attachments_by_unit_3p[slot.unit_3p] then
            mod:execute_attachment_callbacks_in_item(slot_item, world, slot.attachments_by_unit_3p[slot.unit_3p], "ui_item_init")
        end

    end

end)
