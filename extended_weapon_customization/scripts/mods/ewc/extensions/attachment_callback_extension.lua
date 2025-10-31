local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local pairs = pairs
    local class = class
    local managers = Managers
    local unit_alive = unit.alive
    local script_unit = ScriptUnit
    local script_unit_extension = script_unit.extension
--#endregion

-- ##### ┌─┐┬┌─┐┬ ┬┌┬┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ #################################################################
-- ##### └─┐││ ┬├─┤ │ └─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ #################################################################
-- ##### └─┘┴└─┘┴ ┴ ┴ └─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ #################################################################

local AttachmentCallbackExtension = class("AttachmentCallbackExtension")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local SUPPORTED_FUNCTIONS = {
    "on_wield",
    "on_unwield",
    "on_equip_weapon",
    "on_unequip_weapon",
    "on_perspective_change",
    "on_update",
    "on_update_item_visibility",
}
local SUPPORTED_SLOTS = {
    "slot_primary",
    "slot_secondary",
}

-- ##### ┬┌┐┌┬┌┬┐┬┌─┐┬  ┬┌─┐┌─┐┌┬┐┬┌─┐┌┐┌ #############################################################################
-- ##### │││││ │ │├─┤│  │┌─┘├─┤ │ ││ ││││ #############################################################################
-- ##### ┴┘└┘┴ ┴ ┴┴ ┴┴─┘┴└─┘┴ ┴ ┴ ┴└─┘┘└┘ #############################################################################

AttachmentCallbackExtension.init = function(self, extension_init_context, unit, extension_init_data)
    -- Set data
    self.unit = unit
    self.player = extension_init_data.player
    self.world = extension_init_context.world
    -- Get extensions
    self.visual_loadout_extension = extension_init_data.visual_loadout_extension
    self.fx_extension = script_unit_extension(self.unit, "fx_system")
    self.first_person_extension = script_unit_extension(self.unit, "first_person_system")
    self.unit_data_extension = script_unit_extension(self.unit, "unit_data_system")
    self.alternate_fire_component = self.unit_data_extension:read_component("alternate_fire")
    self.movement_state_component = self.unit_data_extension:read_component("movement_state")
    -- Set null data
    self.wielded_slot = extension_init_data.wielded_slot
    self.attachments = {}
    self.attachment_slots = {}
    -- Register events
    managers.event:register(self, "ewc_reloaded", "on_mod_reload")
    managers.event:register(self, "ewc_settings_changed", "on_settings_changed")
    managers.event:register(self, "ewc_cutscene", "on_cutscene")
    -- Set initial values
    self:on_settings_changed()
end

AttachmentCallbackExtension.delete = function(self)
    -- Unregister events
    managers.event:unregister(self, "ewc_reloaded")
    managers.event:unregister(self, "ewc_settings_changed")
    managers.event:unregister(self, "ewc_cutscene")
end

AttachmentCallbackExtension.current_attachment_unit = function(self, attachment_slot)
    -- Check perspective
    if self.first_person_extension:is_in_first_person_mode() then
        -- Return first person attachment unit
        return self.attachments[attachment_slot] and self.attachments[attachment_slot].unit_1p
    else
        -- Return third person attachment unit
        return self.attachments[attachment_slot] and self.attachments[attachment_slot].unit_3p
    end
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

AttachmentCallbackExtension.on_cutscene = function(self, cutscene_playing)
    if not cutscene_playing then
        -- Execute "on_wield" for attachments
        self:on_wield(self.wielded_slot)
    end
end

AttachmentCallbackExtension.on_settings_changed = function(self)
end

AttachmentCallbackExtension.on_equip_weapon = function(self)
    -- Fetch new attachment callbacks
    self:fetch_attachments_with_callbacks()
    -- Execute "on_equip_weapon" for attachments
    self:attachment_callback("on_equip_weapon")
end

AttachmentCallbackExtension.on_mod_reload = function(self)
    -- Fetch new attachment callbacks
    self:fetch_attachments_with_callbacks()
end

AttachmentCallbackExtension.on_wield = function(self, wielded_slot)
    -- Set wielded slot
    self.wielded_slot = wielded_slot
    -- Execute "on_wield" for attachments
    self:attachment_callback("on_wield", wielded_slot)
end

AttachmentCallbackExtension.on_impact = function(self, hit_position, hit_unit, attack_type, damage_profile)
    -- Execute "on_impact" for attachments
    self:attachment_callback("on_impact", hit_position, hit_unit, attack_type, damage_profile)
end

AttachmentCallbackExtension.on_attack = function(self, hit_units)
    -- Execute "on_attack" for attachments
    self:attachment_callback("on_attack", hit_units)
end

AttachmentCallbackExtension.on_update_item_visibility = function(self, wielded_slot)
    -- Execute "on_update_item_visibility" for attachments
    self:attachment_callback("on_update_item_visibility", wielded_slot)
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

AttachmentCallbackExtension.update = function(self, dt, t)
    -- Detect perspective change
    local first_person = self.first_person_extension:is_in_first_person_mode()
    local perspective_change = first_person ~= self.last_first_person
    self.last_first_person = first_person
    -- Check change
    if perspective_change then
        -- Execute "on_perspective_change" for attachments
        self:attachment_callback("on_perspective_change")
    end
    -- Execute "on_update" for attachments
    self:attachment_callback("on_update", dt, t)
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

AttachmentCallbackExtension.attachment_callback = function(self, callback_name, ...)
    -- Iterate through attachments
    for attachment_slot, attachment_slot_data in pairs(self.attachments) do
        -- Get data
        local attachment_unit = self:current_attachment_unit(attachment_slot)
        local attachment_data = attachment_slot_data.attachment_data
        -- Check callback
        if attachment_data[callback_name] then
            -- Call callback
            attachment_data[callback_name](self, attachment_slot_data, ...) -- Forward arguments
        end
    end
end

mod.execute_attachment_callbacks_in_item = function(self, item, world, attachment_units, function_name, ...)
    if item and item.attachments then
        -- Get item attachment slots
        local attachment_slots = mod:fetch_attachment_slots(item.attachments)
        if attachment_slots then
            -- Iterate through attachment slots
            for attachment_slot, data in pairs(attachment_slots) do
                -- Get item path
                local item_path = data.item
                -- Get attachment data
                local attachment_data = item_path and mod.settings.attachment_data_by_item_string[item_path]
                -- Check attachment data and if it has function name
                if attachment_data and attachment_data[function_name] then
                    -- Get attachment unit
                    local attachment_unit = attachment_units and mod:find_in_units(attachment_units, attachment_slot)
                    if attachment_unit and unit_alive(attachment_unit) then
                        -- Execute
                        attachment_data[function_name](world, attachment_unit, attachment_data, ...) -- Forward arguments
                    end
                end
            end
        end
    end
end

AttachmentCallbackExtension.fetch_attachments_with_callbacks = function(self)
    -- Null data
    self.attachments = {}
    self.attachment_slots = {}
    -- Iterate through supported slots
    for _, slot_name in pairs(SUPPORTED_SLOTS) do
        -- Check if slot exists
        if self.visual_loadout_extension._equipment[slot_name] then
            -- Get item
            local item = self.visual_loadout_extension:item_from_slot(slot_name)
            -- Check item and attachments
            if item and item.attachments then
                -- Get units
                local unit_1p, unit_3p, attachments_by_unit_1p, attachments_by_unit_3p = self.visual_loadout_extension:unit_and_attachments_from_slot(slot_name)
                local attachments_1p = attachments_by_unit_1p and attachments_by_unit_1p[unit_1p]
                local attachments_3p = attachments_by_unit_3p and attachments_by_unit_3p[unit_3p]
                -- Get attachment slots
                self.attachment_slots[item] = mod:fetch_attachment_slots(item.attachments)
                -- Iterate through attachments slots
                for attachment_slot, data in pairs(self.attachment_slots[item]) do
                    -- Get attachment data
                    local attachment_data = mod.settings.attachment_data_by_item_string[data.item]
                    if attachment_data then
                        local has_callbacks = false
                        -- Check for callbacks
                        for _, callback_name in pairs(SUPPORTED_FUNCTIONS) do
                            has_callbacks = attachment_data[callback_name]
                            if has_callbacks then break end
                        end
                        -- Check callbacks
                        if has_callbacks then
                            -- Get attachment unit
                            local attachment_unit_1p = mod:find_in_units(attachments_1p, attachment_slot)
                            local attachment_unit_3p = mod:find_in_units(attachments_3p, attachment_slot)
                            -- Register attachment slot callback
                            self.attachments[attachment_slot] = {
                                item = item,
                                attachment_data = attachment_data,
                                unit_1p = attachment_unit_1p,
                                unit_3p = attachment_unit_3p,
                                attachment_slot = attachment_slot,
                                slot_name = slot_name,
                            }
                        end
                    end
                end
            end
        end
    end
end
