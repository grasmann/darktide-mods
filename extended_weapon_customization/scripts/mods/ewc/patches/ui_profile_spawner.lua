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

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/managers/ui/ui_profile_spawner", function(instance)

    instance.change_equipment = function(self)
        self:change_item(SLOT_SECONDARY)
        self:change_item(SLOT_PRIMARY)
        self:_sync_profile_changes()
    end

    instance.change_item = function(self, slot_name)
        local data = self._loading_profile_data or self._character_spawn_data
        local loadout_item = data and data.profile.loadout and data.profile.loadout[slot_name]
        local visual_item = data and data.profile.visual_loadout and data.profile.visual_loadout[slot_name]
        if (not loadout_item or not loadout_item.__master_item) and visual_item then
            data.profile.loadout[slot_name] = visual_item
            -- if data.equipped_items then data.equipped_items[slot_name] = visual_item end
            -- if data.loading_items then data.loading_items[slot_name] = visual_item and visual_item.name end
        end
    end

end)

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
    -- Unset ignore slots
    -- So that the real equipped items are loaded
    if not self._placement_name then
        self._ignored_slots[SLOT_SECONDARY] = nil
        self._ignored_slots[SLOT_PRIMARY] = nil
    end
    
    -- Original function
    func(self, profile, position, rotation, scale, state_machine_or_nil, animation_event_or_nil, face_state_machine_key_or_nil, face_animation_event_or_nil, force_highest_mip_or_nil, disable_hair_state_machine_or_nil, optional_unit_3p, optional_ignore_state_machine, companion_data, ...)

    -- Real equipment
    self:change_equipment()

end)

mod:hook(CLASS.UIProfileSpawner, "_spawn_character_profile", function(func, self, profile, profile_loader, position, rotation, scale, state_machine, animation_event, face_state_machine_key, face_animation_event, force_highest_mip, disable_hair_state_machine, optional_unit_3p, optional_ignore_state_machine, companion_data, ...)
    
    -- Original function
    func(self, profile, profile_loader, position, rotation, scale, state_machine, animation_event, face_state_machine_key, face_animation_event, force_highest_mip, disable_hair_state_machine, optional_unit_3p, optional_ignore_state_machine, companion_data, ...)

    -- Real equipment
    self:change_equipment()

end)

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
