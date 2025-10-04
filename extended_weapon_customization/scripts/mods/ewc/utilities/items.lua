local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local FixedFrame = mod:original_require("scripts/utilities/fixed_frame")
local master_items = mod:original_require("scripts/backend/master_items")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local type = type
    local math = math
    local pairs = pairs
    local table = table
    local string = string
    local tostring = tostring
    local managers = Managers
    local unit_alive = unit.alive
    local table_size = table.size
    local table_find = table.find
    local script_unit = ScriptUnit
    local table_clear = table.clear
    local math_random = math.random
    local string_split = string.split
    local unit_get_data = unit.get_data
    local table_contains = table.contains
    local table_clone_safe = table.clone_safe
    local script_unit_extension = script_unit.extension
    local table_clone_instance_safe = table.clone_instance_safe
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local PROCESS_ITEM_TYPES = {"WEAPON_SKIN", "WEAPON_MELEE", "WEAPON_RANGED"}
local _item = "content/items/weapons/player"
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

-- ##### ┬─┐┌─┐┌─┐┬ ┬┬─┐┌─┐┬┬  ┬┌─┐  ┌─┐┌┬┐┌┬┐┌─┐┌─┐┬ ┬┌┬┐┌─┐┌┐┌┌┬┐  ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ########################
-- ##### ├┬┘├┤ │  │ │├┬┘└─┐│└┐┌┘├┤   ├─┤ │  │ ├─┤│  ├─┤│││├┤ │││ │   ├┤ │ │││││   │ ││ ││││└─┐ ########################
-- ##### ┴└─└─┘└─┘└─┘┴└─└─┘┴ └┘ └─┘  ┴ ┴ ┴  ┴ ┴ ┴└─┘┴ ┴┴ ┴└─┘┘└┘ ┴   └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ########################

mod.overwrite_attachment = function(self, attachments, target_slot, replacement_path)
    for slot, data in pairs(attachments) do
        if slot == target_slot then
            data.item = replacement_path
        end
        if data.children then
            self:overwrite_attachment(data.children, target_slot, replacement_path)
        end
    end
end

mod.inject_attachment = function(self, attachments, slot_name, inject_data)
    for slot, attachment_data in pairs(attachments) do
        if slot == inject_data.parent_slot then
            attachment_data.children = attachment_data.children or {}
            attachment_data.children[slot_name] = attachment_data.children[slot_name] or {
                item = inject_data.default_path,
                children = {},
                fix = inject_data.fix,
            }
            break
        end
        if attachment_data.children then
            self:inject_attachment(attachment_data.children, slot_name, inject_data)
        end
    end
end

mod.fetch_attachment_parent = function(self, attachments, target_slot)
    local attachment_parent = nil
    for slot, data in pairs(attachments) do
        if table_find(data, target_slot) then
            attachment_parent = slot
        elseif data.children then
            attachment_parent = self:fetch_attachment_parent(data.children, target_slot)
        end
        if attachment_parent then break end
    end
    return attachment_parent
end

mod.fetch_attachment_fixes = function(self, attachments, attachment_fixes)
    local attachment_fixes = attachment_fixes or {}
    for slot, data in pairs(attachments) do
        if data.fix then
            attachment_fixes[data.fix] = slot
        end
        if data.children then
            self:fetch_attachment_fixes(data.children, attachment_fixes)
        end
    end
    return attachment_fixes
end

mod.clear_attachment_fixes = function(self, attachments)
    for slot, data in pairs(attachments) do
        data.fix = nil
        if data.children then
            self:clear_attachment_fixes(data.children)
        end
    end
    return attachments
end

mod.fetch_attachment = function(self, attachments, target_slot)
    local attachment_item_path = nil
    for slot, data in pairs(attachments) do
        if type(data.item) == "table" and data.item.attachments then
            attachment_item_path = self:fetch_attachment(data.item.attachments, target_slot)
        end
        if slot == target_slot then
            attachment_item_path = data.item
        elseif data.children then
            attachment_item_path = self:fetch_attachment(data.children, target_slot)
        end
        if attachment_item_path then break end
    end
    return attachment_item_path
end

mod.fetch_attachment_data = function(self, attachments, target_slot)
    local attachment_item_data = nil
    for slot, data in pairs(attachments) do
        if slot == target_slot then
            attachment_item_data = data
        elseif data.children then
            attachment_item_data = self:fetch_attachment_data(data.children, target_slot)
        end
        if attachment_item_data then break end
    end
    return attachment_item_data
end

mod.fetch_attachment_slots = function(self, attachments, attachment_slots)
    local attachment_slots = attachment_slots or {}
    for slot, data in pairs(attachments) do
        attachment_slots[slot] = data
        if data.children then
            self:fetch_attachment_slots(data.children, attachment_slots)
        end
    end
    return attachment_slots
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.item_data = function(self, item_data)
    -- Get correct item data
    local data = item_data and (item_data.__attachment_customization and item_data.__master_item) or (item_data.__is_ui_item_preview and item_data.__data)
    -- local item = item_data.attachments.slot_trinket_1.item
    -- data = (data and data.attachments and data.attachments.slot_trinket_1 and data.attachments.slot_trinket_1.item and type(item_data.attachments.slot_trinket_1.item) == "table" and item_data.attachments.slot_trinket_1.item) or data
    -- Return
    return data or item_data
end

mod.reset_item = function(self, item_data)
    -- Get item info
    local item = self:item_data(item_data)
    -- Get attachment slots
    local attachment_slots = self:fetch_attachment_slots(item.attachments)
    -- Get original item
    local original_item = master_items.get_item(item.name)
    -- Iterate through attachment slots
    for attachment_slot, data in pairs(attachment_slots) do
        -- Get original attachment
        local original_attachment = self:fetch_attachment(original_item.attachments, attachment_slot) or _item_empty_trinket
        -- Overwrite attachment
        self:overwrite_attachment(item.attachments, attachment_slot, original_attachment)
    end
end

mod.randomize_item = function(self, item_data)
    -- Get item info
    local item = self:item_data(item_data)
    -- Create new gear settings
    local new_gear_settings = {}
    -- Get attachment slots
    local attachment_slots = self:fetch_attachment_slots(item.attachments)
    -- Iterate through attachment slots
    for attachment_slot, data in pairs(attachment_slots) do
        -- Get slot attachments
        local attachments = self.settings.attachments[item.weapon_template]
        local slot_attachments = attachments and attachments[attachment_slot]
        -- Check slot attachments
        if slot_attachments then
            -- Get random slot attachment
            local num_attachments = table_size(slot_attachments)
            local rnd = math_random(1, num_attachments)
            -- Get nth attachment
            local i, selected_data = 1, nil
            for attachment_name, attachment_data in pairs(slot_attachments) do
                if i == rnd then
                    selected_data = attachment_data
                    break
                end
                i = i + 1
            end
            -- Check selected attachment
            if selected_data then
                -- Overwrite attachment
                self:overwrite_attachment(item.attachments, attachment_slot, selected_data.replacement_path)
                -- Set attachment in gear settings
                new_gear_settings[attachment_slot] = selected_data.replacement_path
            end

        end
    end
    -- Return new gear settings
    return new_gear_settings
end

mod.clear_mod_items = function(self)
    local pt = self:pt()
    -- Clear mod items
    table_clear(pt.items)
end

mod.clear_mod_item = function(self, gear_id)
    local pt = self:pt()
    -- Check gear id and mod item
    if gear_id and pt.items[gear_id] then
        -- Clear mod item
        pt.items[gear_id] = nil
    end
end

mod.sweep_gear_id = function(self, gear_id)
    self:clear_mod_item(gear_id)
    self:delete_gear_settings(gear_id)
    self:delete_gear_id_relays(gear_id)
end

mod.mod_item = function(self, gear_id, item_data)
    local pt = self:pt()
    -- Check gear id and mod item
    if gear_id and not pt.items[gear_id] then
        -- Get item info
        local item = self:item_data(item_data)
        local item_type = item_data and item_data.item_type or "unknown"
        -- Check supported item type
        if table_contains(PROCESS_ITEM_TYPES, item_type) then
            mod:print("cloning item "..tostring(gear_id))
            -- Clone item to mod items
            pt.items[gear_id] = table_clone_instance_safe(item_data)
        end
    end
    -- Check gear id and mod item
    if gear_id and pt.items[gear_id] then
        -- Return mod item
        return pt.items[gear_id]
    end
    -- Return default
    return item_data
end

mod.modify_item = function(self, item_data, fake_gear_id, optional_settings)
    -- Get item info
    local item = self:item_data(item_data)
    local item_type = item_data and item_data.item_type
    -- Check supported item type
    if table_contains(PROCESS_ITEM_TYPES, item_type) and item.attachments then
        local pt = mod:pt()

        -- Inject custom attachments
        local weapon_template = item.weapon_template
        local custom_attachment_slots = weapon_template and self.settings.attachment_slots[weapon_template]
        if custom_attachment_slots then
            -- Iterate through custom attachment slots
            for slot_name, inject_data in pairs(custom_attachment_slots) do
                -- Check if attachment slot exists
                if not self:fetch_attachment(item.attachments, slot_name) then
                    -- Inject attachment
                    self:inject_attachment(item.attachments, slot_name, inject_data)
                end
            end
        end

        -- Overwrite attachments
        local gear_id = mod:gear_id(item, fake_gear_id)
        local gear_settings = optional_settings or gear_id and mod:gear_settings(gear_id)
        if gear_settings then
            -- Iterate through gear settings
            for slot, replacement_path in pairs(gear_settings) do
                -- Overwrite attachment
                mod:overwrite_attachment(item.attachments, slot, replacement_path)
            end
        end

    end
end



mod.find_in_units = function(self, attachment_units, target_attachment_slot)
    -- Check
    if attachment_units then
        -- Iterate through attachments
        for i = 1, #attachment_units do
            -- Get attachment unit
            local attachment_unit = attachment_units[i]
            -- Check attachment unit
            if attachment_unit and unit_alive(attachment_unit) then

                -- Get attachment slot
                local attachment_slot_string = unit_get_data(attachment_unit, "attachment_slot")
                -- Shorten to last part
                local attachment_slot_parts = string_split(attachment_slot_string, ".")
                local attachment_slot = attachment_slot_parts and attachment_slot_parts[#attachment_slot_parts]

                -- Check attachment slot and light in attachment unit
                if attachment_slot == target_attachment_slot then --and unit_num_lights(attachment_unit) > 0 then

                    return attachment_unit

                end
            end
        end
    end
end

-- ##### ┬ ┬┬ ┬┌─┐┬┌─  ┬┌┬┐┌─┐┌┬┐┌─┐ ##################################################################################
-- ##### ├─┤│ │└─┐├┴┐  │ │ ├┤ │││└─┐ ##################################################################################
-- ##### ┴ ┴└─┘└─┘┴ ┴  ┴ ┴ └─┘┴ ┴└─┘ ##################################################################################

mod.husk_item_exists = function(self, gear_id)
    local pt = mod:pt()
    return pt.husk_weapon_templates[gear_id]
end

mod.husk_item_changed = function(self, gear_id, real_item)
    local pt = mod:pt()
    local husk_item = pt.husk_weapon_templates[gear_id]
    return real_item.weapon_template ~= husk_item.weapon_template
end

mod.create_husk_item = function(self, gear_id, item)
    local pt = mod:pt()
    pt.husk_weapon_templates[gear_id] = item
end

mod.husk_item = function(self, gear_id)
    local pt = mod:pt()
    return pt.husk_weapon_templates[gear_id]
end

mod.handle_husk_item = function(self, item)
    -- Check if slot is supported, random players is enabled and item is valid
    local item = self:item_data(item)
    local item_type = item and item.item_type or "unknown"
    if table_contains(PROCESS_ITEM_TYPES, item_type) and mod:get("mod_option_randomize_players") and item and item.attachments then
        -- Get gear id
        local gear_id = mod:gear_id(item)
        -- Check if mark of husk item was changed
        if mod:husk_item_exists() and mod:husk_item_changed(gear_id, item) then
            mod:print("changed husk item "..tostring(gear_id))
            -- Delete mod item, gear settings and relays
            mod:sweep_gear_id(gear_id)
        end
        -- Check if husk item exists
        if not mod:husk_item_exists() then
            -- Mod item
            mod:print("cloning husk item "..tostring(gear_id))
            local mod_item = mod:mod_item(gear_id, item)
            -- Randomize item
            mod:print("randomizing husk item "..tostring(gear_id))
            local random_gear_settings = mod:randomize_item(item)
            -- Set gear settings
            mod:gear_settings(gear_id, random_gear_settings)
            -- Set husk item
            mod:create_husk_item(gear_id, mod_item)
            -- Return mod item
            return mod_item
        else
            return mod:husk_item(gear_id)
        end
    end
    return item
end

-- ##### ┬─┐┌─┐┬  ┌─┐┌─┐┌┬┐  ┌─┐┌─┐┌─┐┬┌─┌─┐┌─┐┌─┐┌─┐ #################################################################
-- ##### ├┬┘├┤ │  │ │├─┤ ││  ├─┘├─┤│  ├┴┐├─┤│ ┬├┤ └─┐ #################################################################
-- ##### ┴└─└─┘┴─┘└─┘┴ ┴─┴┘  ┴  ┴ ┴└─┘┴ ┴┴ ┴└─┘└─┘└─┘ #################################################################

-- Reevaluate packages (when new attachments are added)
mod.reevaluate_packages = function(self, optional_player)
    -- Get package synchronizer client
    local package_synchronizer_client = managers.package_synchronization:synchronizer_client()
    -- Reevaluate all profile packages
    if package_synchronizer_client then
        local player = optional_player or managers.player:local_player(1)
        local peer_id = player:peer_id()
        local local_player_id = player:local_player_id()
        if package_synchronizer_client:peer_enabled(peer_id) then
            package_synchronizer_client:player_profile_packages_changed(peer_id, local_player_id)
        end
    end
end

-- ##### ┬─┐┌─┐┬  ┌─┐┌─┐┌┬┐  ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌ #######################################################################
-- ##### ├┬┘├┤ │  │ │├─┤ ││  │││├┤ ├─┤├─┘│ ││││ #######################################################################
-- ##### ┴└─└─┘┴─┘└─┘┴ ┴─┴┘  └┴┘└─┘┴ ┴┴  └─┘┘└┘ #######################################################################

-- Redo weapon attachments by unequipping and reequipping weapon
mod.redo_weapon_attachments = function(self, item)
    -- Get info
    local me = mod:me()
    local slot_name = item and item.slots[1]
    -- Get visual loadout extension
    local visual_loadout_extension = script_unit_extension(me, "visual_loadout_system")
	if slot_name and visual_loadout_extension then
        -- Current item
        local current_item = visual_loadout_extension:item_from_slot(slot_name)
        -- Check if same item
        if self:gear_id(current_item) == self:gear_id(item) then
            -- Unequip item
            visual_loadout_extension:unequip_item_from_slot(slot_name, FixedFrame.get_latest_fixed_time())
            -- Reequip item
            visual_loadout_extension:equip_item_to_slot(item, slot_name, nil, self:time())
        end
    end
    -- Relay weapon reload to sight extension
    local sight_extension = script_unit_extension(me, "sight_system")
    if sight_extension then
        sight_extension:on_equip_weapon()
    end
    -- Relay weapon reload to sight extension
    local flashlight_extension = script_unit_extension(me, "flashlight_system")
    if flashlight_extension then
        flashlight_extension:on_equip_weapon()
    end
    -- Relay weapon reload to attachment callback extension
    local attachment_callback_extension = script_unit_extension(me, "attachment_callback_system")
    if attachment_callback_extension then
        attachment_callback_extension:on_equip_weapon()
    end
end
