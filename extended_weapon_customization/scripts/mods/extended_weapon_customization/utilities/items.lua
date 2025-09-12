local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local FixedFrame = mod:original_require("scripts/utilities/fixed_frame")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local type = type
    local pairs = pairs
    local table = table
    local managers = Managers
    local table_find = table.find
    local script_unit = ScriptUnit
    local table_contains = table.contains
    local table_clone_safe = table.clone_safe
    local script_unit_extension = script_unit.extension
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local PROCESS_SLOTS = {"WEAPON_SKIN", "WEAPON_MELEE", "WEAPON_RANGED"}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

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

mod.modify_item = function(self, item_data, fake_gear_id, optional_settings)
    local item = item_data and (item_data.__is_ui_item_preview and item_data.__data) or item_data --item_data.__master_item or item_data
    local item_type = item_data and item_data.item_type
    -- if item_type == "WEAPON_MELEE" or item_type == "WEAPON_RANGED" and item.attachments then
    if table_contains(PROCESS_SLOTS, item_type) and item.attachments then
        local pt = mod:pt()

        local weapon_template = item.weapon_template
        local custom_attachment_slots = weapon_template and self.settings.attachment_slots[weapon_template]
        if custom_attachment_slots then
            for slot_name, inject_data in pairs(custom_attachment_slots) do
                -- Check if attachment slot exists
                if not self:fetch_attachment(item.attachments, slot_name) then
                    self:inject_attachment(item.attachments, slot_name, inject_data)
                end
            end
        end

        local gear_id = mod:gear_id(item, fake_gear_id)
        local gear_settings = optional_settings or gear_id and mod:gear_settings(gear_id)
        if gear_settings then
            for slot, replacement_path in pairs(gear_settings) do
                mod:overwrite_attachment(item.attachments, slot, replacement_path)
            end
        end

    end
end

-- Reevaluate packages (when new attachments are added)
mod.reevaluate_packages = function(self)
    -- Get package synchronizer client
    local package_synchronizer_client = managers.package_synchronization:synchronizer_client()
    -- Reevaluate all profile packages
    if package_synchronizer_client then
        local player = managers.player:local_player(1)
        local peer_id = player:peer_id()
        if package_synchronizer_client:peer_enabled(peer_id) then
            package_synchronizer_client:player_profile_packages_changed(peer_id, 1)
        end
    end
end

-- Redo weapon attachments by unequipping and reequipping weapon
mod.redo_weapon_attachments = function(self, item)
    local me = mod:me()
    local slot_name = item and item.slots[1]
    local visual_loadout_extension = script_unit_extension(me, "visual_loadout_system")
	if slot_name and visual_loadout_extension then
        visual_loadout_extension:unequip_item_from_slot(slot_name, FixedFrame.get_latest_fixed_time())
        visual_loadout_extension:equip_item_to_slot(item, slot_name, nil, self:time())
    end
end
