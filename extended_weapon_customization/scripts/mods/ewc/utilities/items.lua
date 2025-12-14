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
    -- local string_split = string.split
    local unit_get_data = unit.get_data
    -- local table_contains = table.contains
    local table_clone_safe = table.clone_safe
    local unit_sight_callback = unit.sight_callback
    local unit_shield_callback = unit.shield_callback
    local script_unit_extension = script_unit.extension
    local unit_attachment_callback = unit.attachment_callback
    local unit_flashlight_callback = unit.flashlight_callback
    local unit_damage_type_callback = unit.damage_type_callback
    local table_clone_instance_safe = table.clone_instance_safe
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local pt = mod:pt()
local temp_random_attachment_list = {}
local PROCESS_ITEM_TYPES = {"WEAPON_MELEE", "WEAPON_RANGED"}
local _item = "content/items/weapons/player"
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

-- ##### ┬─┐┌─┐┌─┐┬ ┬┬─┐┌─┐┬┬  ┬┌─┐  ┌─┐┌┬┐┌┬┐┌─┐┌─┐┬ ┬┌┬┐┌─┐┌┐┌┌┬┐  ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ########################
-- ##### ├┬┘├┤ │  │ │├┬┘└─┐│└┐┌┘├┤   ├─┤ │  │ ├─┤│  ├─┤│││├┤ │││ │   ├┤ │ │││││   │ ││ ││││└─┐ ########################
-- ##### ┴└─└─┘└─┘└─┘┴└─└─┘┴ └┘ └─┘  ┴ ┴ ┴  ┴ ┴ ┴└─┘┴ ┴┴ ┴└─┘┘└┘ ┴   └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ########################

mod.overwrite_attachment = function(self, attachments, target_slot, replacement_path)
    if not attachments then return end
    for slot, data in pairs(attachments) do
        if slot == target_slot and data then
            data.item = replacement_path
            local attachment_item = pt.master_items_loaded and master_items.get_item(replacement_path)
            data.material_overrides = attachment_item and attachment_item.material_overrides or (data.material_overrides or {})
        end
        if data and data.children then
            self:overwrite_attachment(data.children, target_slot, replacement_path)
        end
    end
end

mod.inject_attachment_slot_info = function(self, attachments, target_slot, slot_info)
    for slot, data in pairs(attachments) do
        if slot == target_slot then
            data.attachment_slot = target_slot
        end
        if data.children then
            self:inject_attachment_slot_info(data.children, target_slot, slot_info)
        end
    end
end

mod.clear_attachment = function(self, attachments, target_slot)
    for slot, data in pairs(attachments) do
        if slot == target_slot then
            attachments[slot] = nil
            mod:print("clearing attachment slot "..tostring(slot))
        elseif data.children then
            self:clear_attachment_fixes(data.children, target_slot)
        end
    end
end

mod.inject_material_overrides = function(self, attachments, target_slot, material_overrides)
    for slot, data in pairs(attachments) do
        if slot == target_slot then
            data.material_overrides = material_overrides
        end
        if data.children then
            self:overwrite_attachment(data.children, target_slot, material_overrides)
        end
    end
end

mod.inject_attachment = function(self, attachments, slot_name, inject_data)
    
    -- self:clear_attachment(attachments, slot_name)

    for slot, attachment_data in pairs(attachments) do
        if slot == inject_data.parent_slot then

            attachment_data.children = attachment_data.children or {}

            local existing_children = attachment_data.children[slot_name] and attachment_data.children[slot_name].children and table_clone_safe(attachment_data.children[slot_name].children)
            local existing_item = attachment_data.children and attachment_data.children[slot_name] and attachment_data.children[slot_name].item or inject_data.default_path
            local item = existing_item and pt.master_items_loaded and master_items.get_item(existing_item)
            local material_overrides = item and item.material_overrides or inject_data.material_overrides

            -- attachment_data.children[slot_name] = attachment_data.children[slot_name] or {
            --     item = inject_data.default_path,
            --     children = {},
            --     fix = inject_data.fix,
            -- }

            -- mod:print("injecting attachment slot "..tostring(slot_name).." into "..tostring(slot))
            -- if inject_data.fix and inject_data.fix.offset then
            --     mod:print("fix: p:"..tostring(inject_data.fix.offset.position)..", r:"..tostring(inject_data.fix.offset.rotation)..", s:"..tostring(inject_data.fix.offset.scale)..", n:"..tostring(inject_data.fix.offset.node))
            -- end

            -- local material_overrides = inject_data.material_overrides

            -- if existing_item and existing_item ~= "" then
            --     local item = master_items.get_item(existing_item)
            --     material_overrides = item and item.material_overrides
            -- end

            attachment_data.children[slot_name] = {
                item = existing_item or "",
                children = existing_children or {},
                fix = inject_data.fix,
                material_overrides = material_overrides or {},
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
    if not attachments then return nil end
    local attachment_item_path = nil
    for slot, data in pairs(attachments) do
        if data then
            if type(data.item) == "table" and data.item.attachments then
                attachment_item_path = self:fetch_attachment(data.item.attachments, target_slot)
            end
            if slot == target_slot then
                attachment_item_path = data.item
            elseif data.children then
                attachment_item_path = self:fetch_attachment(data.children, target_slot)
            end
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

mod.item_has = function(self, item, attribute_name)
    if item and item.attachments then
        local attachment_slots = self:fetch_attachment_slots(item.attachments)
        if attachment_slots then
            for attachment_slot, data in pairs(attachment_slots) do
                local replacement_path = data.item
                local attachment_data = self.settings.attachment_data_by_item_string[replacement_path]
                if attachment_data and attachment_data[attribute_name] then
                    return true
                end
            end
        end
    end
end

mod.item_data = function(self, item_data)
    -- Get correct item data
    local data = item_data and ((item_data.__attachment_customization and item_data.__master_item) or (item_data.__is_ui_item_preview and item_data.__data))
    -- Return
    return data or item_data
end

mod.reset_item = function(self, item_data)
    if not item_data then return end
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

mod.generate_random_attachment_list = function(self, item_data, target_slot)
    if not item_data then return end
    -- Get item info
    local item = self:item_data(item_data)
    -- Clear temp tables
    table_clear(temp_random_attachment_list)
    -- Get slot attachments
    local attachments = self.settings.attachments[item.weapon_template]
    local slot_attachments = attachments and attachments[target_slot]
    -- Check slot attachments
    if slot_attachments then

        -- Get possible random slot attachments
        for attachment_name, attachment_data in pairs(slot_attachments) do
            local add_to_list = true
            -- Check requirement
            if attachment_data.randomization_requirement then
                local attachment_data_origin = pt.attachment_data_origin
                local origin_mod = attachment_data_origin[attachment_data] or self
                local requirement_value = origin_mod:get(attachment_data.randomization_requirement)
                add_to_list = requirement_value
                if not add_to_list then
                    self:print(tostring(attachment_name).." skipped in randomization: "..tostring(attachment_data.randomization_requirement).." == "..tostring(requirement_value))
                end
            end
            -- Hide from selection
            if attachment_data.hide_from_selection then
                add_to_list = false
            end
            -- Add to list
            if add_to_list then
                temp_random_attachment_list[attachment_name] = attachment_data
            end
        end

    end
    -- Return new gear settings
    return temp_random_attachment_list
end

mod.randomize_item = function(self, item_data)
    if not item_data then return end
    -- Get item info
    local item = self:item_data(item_data)
    -- -- Original item
    -- local original_item = item and master_items.get_item(item.name)
    -- Create new gear settings
    local new_gear_settings = {}
    -- Get attachment slots
    local attachment_slots = self:fetch_attachment_slots(item.attachments)
    -- Iterate through attachment slots
    for attachment_slot, data in pairs(attachment_slots) do
        -- Get possible random attachments
        local possible_attachments = self:generate_random_attachment_list(item_data, attachment_slot)
        local num_attachments = table_size(possible_attachments)
        -- Check number
        if num_attachments > 0 then
            local rnd = math_random(1, num_attachments)
            local i, selected_data = 1, nil
            -- Get random nth attachment
            for attachment_name, attachment_data in pairs(possible_attachments) do
                if i == rnd then
                    selected_data = attachment_data
                    break
                end
                i = i + 1
            end
            -- Check selected data
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
    -- Clear mod items
    table_clear(pt.items)
end

mod.clear_mod_item = function(self, gear_id)
    -- Check gear id and mod item
    if gear_id and pt.items[gear_id] then
        -- Clear mod item
        pt.items[gear_id] = nil
    end
end

mod.sweep_gear_id = function(self, gear_id)
    self:clear_mod_item(gear_id)
    self:clear_husk_item(gear_id)
    self:delete_gear_settings(gear_id)
    self:delete_gear_id_relays(gear_id)
end

mod.mod_item_exists = function(self, gear_id)
    return pt.items[gear_id]
end

mod.mod_item = function(self, gear_id, item_data)
    -- Check gear id and mod item
    if gear_id and not pt.items[gear_id] then
        -- Get item info
        local item = self:item_data(item_data)
        local item_type = item and item.item_type or "unknown"
        -- Check supported item type
        -- if table_contains(PROCESS_ITEM_TYPES, item_type) then
        if mod:cached_table_contains(PROCESS_ITEM_TYPES, item_type) then
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
    local item_type = item and item.item_type
    -- Check supported item type
    -- if table_contains(PROCESS_ITEM_TYPES, item_type) and item.attachments then
    if mod:cached_table_contains(PROCESS_ITEM_TYPES, item_type) and item.attachments then

        -- Get gear settings
        local gear_id = mod:gear_id(item, fake_gear_id)
        local gear_settings = optional_settings or gear_id and mod:gear_settings(gear_id)

        -- Inject custom attachments
        local weapon_template = item.weapon_template
        local custom_attachment_slots = weapon_template and self.settings.attachment_slots[weapon_template]
        if custom_attachment_slots then
            -- Iterate through custom attachment slots
            for slot_name, inject_data in pairs(custom_attachment_slots) do
                -- Get - mod of origin - weapon - slot - specific attachment slot definition
                local attachment_string = mod:fetch_attachment(item.attachments, slot_name) or gear_settings and gear_settings[slot_name]
                local attachment_data = attachment_string and self.settings.attachment_data_by_item_string[attachment_string]
                local mod_of_origin = attachment_data and pt.attachment_data_origin[attachment_data] or mod
                local attachment_slot_by_mod_by_weapon_by_name = self.settings.attachment_slot_by_mod_by_weapon_by_name
                local weapon_attachment_slots = mod_of_origin and attachment_slot_by_mod_by_weapon_by_name[mod_of_origin] and attachment_slot_by_mod_by_weapon_by_name[mod_of_origin][weapon_template]
                local mod_inject_data = weapon_attachment_slots and weapon_attachment_slots[slot_name] --or inject_data
                if mod_inject_data then
                    -- If an attachment slot was found use it
                    inject_data = mod_inject_data
                    -- mod:print("mod-specific attachment slot "..tostring(slot_name).." found in mod "..tostring(mod_of_origin:get_name()).." for item "..tostring(attachment_string).." for weapon "..tostring(weapon_template))
                    -- if inject_data.fix and inject_data.fix.offset then
                    --     mod:print("fix: p:"..tostring(inject_data.fix.offset.position)..", r:"..tostring(inject_data.fix.offset.rotation)..", s:"..tostring(inject_data.fix.offset.scale)..", n:"..tostring(inject_data.fix.offset.node))
                    -- end
                else
                    -- If no attachment slot was found delete fix
                    -- inject_data.fix = nil
                end
                if item.attachments then
                    self:inject_attachment(item.attachments, slot_name, inject_data)
                end
            end
        end

        local all_attachment_slots = self:fetch_attachment_slots(item.attachments)
        for attachment_slot, data in pairs(all_attachment_slots) do
            self:inject_attachment_slot_info(item.attachments, attachment_slot)
        end

        -- Overwrite attachments
        if gear_settings then
            -- Iterate through gear settings
            for slot, replacement_path in pairs(gear_settings) do
                if slot ~= "material_overrides" then
                    -- Overwrite attachment
                    mod:overwrite_attachment(item.attachments, slot, replacement_path)
                end
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
                -- local attachment_slot_parts = string_split(attachment_slot_string, ".")
                local attachment_slot_parts = mod:cached_split(attachment_slot_string, ".")
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
    return pt.husk_items[gear_id]
end

mod.husk_item_changed = function(self, gear_id, real_item)
    local husk_item = pt.husk_items[gear_id]
    return real_item.weapon_template ~= husk_item.weapon_template
end

mod.create_husk_item = function(self, gear_id, item)
    pt.husk_items[gear_id] = table_clone_instance_safe(item)
    return pt.husk_items[gear_id]
end

mod.clear_husk_item = function(self, gear_id)
    pt.husk_items[gear_id] = nil
end

mod.husk_item = function(self, gear_id)
    return pt.husk_items[gear_id]
end

mod.handle_husk_item = function(self, item)
    if not item then
        return nil
    end
    -- Check if slot is supported, random players is enabled and item is valid
    local item_type = item and item.item_type or "unknown"
    -- Check conditions - correct item type, random players and item
    -- if table_contains(PROCESS_ITEM_TYPES, item_type) and mod:get("mod_option_randomize_players") and item and item.attachments then
    if mod:cached_table_contains(PROCESS_ITEM_TYPES, item_type) and mod:get("mod_option_randomize_players") and item and item.attachments then
        -- Get gear id
        local gear_id = mod:gear_id(item)
        if not gear_id then
            return item
        end

        local mod_item = mod:create_husk_item(gear_id, item)
        if not mod_item then
            return item
        end

        local master_item = master_items.get_item(mod_item.name)
        if not master_item then
            return item
        end

        local old_gear_settings = mod:gear_settings(gear_id)
        local random_gear_settings = old_gear_settings or mod:randomize_item(mod_item)
        -- Set gear settings
        if random_gear_settings then
            mod:gear_settings(gear_id, random_gear_settings)
            -- Modify item
            mod:modify_item(mod_item, nil, random_gear_settings)
            -- Attachment fixes
            mod:apply_attachment_fixes(mod_item)
        end

        -- Return mod item
        return mod_item
    end
    return item
end

mod.handle_store_item = function(self, item, offer_id)
    if not item then
        return nil
    end

    local item_type = item.item_type or "unknown"

    -- if table_contains(PROCESS_ITEM_TYPES, item_type) 
    if mod:cached_table_contains(PROCESS_ITEM_TYPES, item_type) and mod:get("mod_option_randomize_store") and item.attachments then

        local gear_id = mod:gear_id(item)
        if not gear_id then
            return item
        end

        local mod_item = mod:create_husk_item(gear_id, item)
        if not mod_item then
            return item
        end

        local master_item = master_items.get_item(mod_item.name)
        if not master_item then
            return item
        end

        local old_gear_settings = mod:gear_settings(offer_id)
        local random_gear_settings = old_gear_settings or mod:randomize_item(mod_item)
        -- Set gear settings
        if random_gear_settings then
            mod:gear_settings(gear_id, random_gear_settings)
            mod:gear_settings(offer_id, random_gear_settings)
            -- Modify item
            mod:modify_item(mod_item, nil, random_gear_settings)
            -- Attachment fixes
            mod:apply_attachment_fixes(mod_item)
        end
        
        -- Return mod item
        return mod_item
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
    unit_sight_callback(me, "on_equip_weapon")
    -- Relay weapon reload to damage type extension
    unit_damage_type_callback(me, "on_equip_weapon")
    -- Relay weapon reload to flashlight extension
    unit_flashlight_callback(me, "on_equip_weapon")
    -- Relay weapon reload to attachment callback extension
    unit_attachment_callback(me, "on_equip_weapon")
    -- Relay weapon reload to shield extension
    unit_shield_callback(me, "on_equip_weapon")
end
