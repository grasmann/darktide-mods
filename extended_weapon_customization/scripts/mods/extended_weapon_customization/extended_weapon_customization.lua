local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local CLASS = CLASS
    local pairs = pairs
    local table = table
    local managers = Managers
    local script_unit = ScriptUnit
    local table_contains = table.contains
    local script_unit_extension = script_unit.extension
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local FixedFrame = mod:original_require("scripts/utilities/fixed_frame")

mod.save_lua = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/utilities/save")
mod.plugins = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/utilities/plugins")
mod.settings = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/utilities/settings")

local REFERENCE = "extended_weapon_customization"
local PROCESS_SLOTS = {"WEAPON_SKIN", "WEAPON_MELEE", "WEAPON_RANGED"}

mod:persistent_table(REFERENCE, {
    gear_files = mod:get("gear_files") or {},
    gear_settings = {},
    cached_items = {},
    gear_id_relays = {},
})

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.pt = function(self)
    return self:persistent_table(REFERENCE)
end

mod.time = function(self)
    return self:game_time() or self:main_time()
end

mod.main_time = function(self)
    local time_manager = managers.time
	return time_manager and time_manager:has_timer("main") and time_manager:time("main")
end

mod.game_time = function(self)
    local time_manager = managers.time
	return time_manager and time_manager:has_timer("gameplay") and time_manager:time("gameplay")
end

mod.me = function(self)
    -- Get player
    local player = managers.player and managers.player:local_player_safe(1)
    -- Return player unit
    return player and player.player_unit
end

mod.get_view = function(self, view_name)
    local ui_manager = managers.ui
    return ui_manager:view_active(view_name) and ui_manager:view_instance(view_name) or nil
end

mod.gear_id = function(self, item, fake_gear_id)
    local pt, gear_id = self:pt()
    if not fake_gear_id then
        gear_id = (item and item.__original_gear_id) or
            (item and (item.__is_attachment_selection_item_preview and item.__gear_id or item.gear_id)) or
            (item and (item.__is_ui_item_preview and item.__data and self:gear_id(item.__data))) or
            (item and (item.__gear_id or item.gear_id)) or
            (item and (item.__master_item and (item.__master_item.__gear_id or item.__master_item.gear_id)))
    else
        gear_id = item and (item.__gear_id or item.gear_id)
    end
    return pt.gear_id_relays[gear_id] or gear_id
end

mod.gear_id_relay = function(self, gear_id, real_gear_id)
    local pt = self:pt()
    pt.gear_id_relays[gear_id] = real_gear_id
end

mod.gear_settings = function(self, gear_id, settings, file)
    local pt = self:pt()
    if settings and gear_id then
        pt.gear_settings[gear_id] = settings --pt.gear_settings[gear_id] or {}
        local data = pt.gear_settings[gear_id]
        if file then
            mod.save_lua:save_entry(gear_id, settings)
        end
        data = settings
    elseif gear_id then
        local data = pt.gear_settings[gear_id]
        if (not data or file) and table_contains(pt.gear_files, gear_id..".lua") then
            pt.gear_settings[gear_id] = mod.save_lua:load_entry(gear_id)
            data = pt.gear_settings[gear_id]
        end
        return data
    end
end

mod.delete_gear_settings = function(self, gear_id)
    local pt = self:pt()
    pt.gear_settings[gear_id] = nil
end

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

mod.fetch_attachment = function(self, attachments, target_slot)
    local attachment_item_path = nil
    for slot, data in pairs(attachments) do
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
    local item = item_data and (item_data.__is_ui_item_preview and item_data.__data) or item_data
    local item_type = item_data and item_data.item_type
    -- if item_type == "WEAPON_MELEE" or item_type == "WEAPON_RANGED" and item.attachments then
    if table_contains(PROCESS_SLOTS, item_type) and item.attachments then
        local pt = mod:pt()
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

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

mod.on_all_mods_loaded = function()
    mod.loaded_plugins = mod:load_plugins()
end

mod.on_setting_changed = function(setting_id)
    managers.event:trigger("extended_weapon_customization_settings_changed")
end

mod.on_unload = function(exit_game) end

mod.clear_chat = function()
	managers.event:trigger("event_clear_notifications")
end

-- ##### ┌─┐┌─┐┌┬┐┌─┐┬ ┬┌─┐┌─┐ ########################################################################################
-- ##### ├─┘├─┤ │ │  ├─┤├┤ └─┐ ########################################################################################
-- ##### ┴  ┴ ┴ ┴ └─┘┴ ┴└─┘└─┘ ########################################################################################

mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/extensions/common")
mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/patches/inventory_weapon_cosmetics_view_definitions")
mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/patches/ui_character_profile_package_loader")
mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/patches/inventory_weapon_cosmetics_view")
mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/patches/visual_loadout_customization")
mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/patches/equipment_component")
mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/patches/item_icon_loader_ui")
mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/patches/view_element_grid")
mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/patches/weapon_icon_ui")
mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/patches/item_package")
mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/patches/master_items")
