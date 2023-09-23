local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local ItemPackage = mod:original_require("scripts/foundation/managers/package/utilities/item_package")
local MasterItems = mod:original_require("scripts/backend/master_items")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local string_find = string.find
    local string_format = string.format
    local table_contains = table.contains
    local table_remove = table.remove
    local table_clone = table.clone
    local math_uuid = math.uuid
    local unit_debug_name = Unit.debug_name
    local unit_set_local_position = Unit.set_local_position
    local unit_local_position = Unit.local_position
    local unit_world_position = Unit.world_position
    local level_units = Level.units
    local vector3 = Vector3
    local vector3_box = Vector3Box
    local pairs = pairs
    local CLASS = CLASS
    local BUILD = BUILD
    local type = type
    local rawget = rawget
    local rawset = rawset
    local ferror = ferror
    local tostring = tostring
    local setmetatable = setmetatable
    local Application = Application
    local log_error = Log.error
    local log_warning = Log.warning
--#endregion

-- ##### ┌─┐┬  ┬┌─┐┬┌─┌─┐┬─┐  ┌─┐┬─┐ ┬ ################################################################################
-- ##### ├┤ │  ││  ├┴┐├┤ ├┬┘  ├┤ │┌┴┬┘ ################################################################################
-- ##### └  ┴─┘┴└─┘┴ ┴└─┘┴└─  └  ┴┴ └─ ################################################################################

mod:hook(CLASS.UIWorldSpawner, "_create_world", function(func, self, world_name, layer, timer_name, optional_view_name, optional_flags, ...)
    optional_flags = {
		Application.ENABLE_VOLUMETRICS,
        Application.ENABLE_RAY_TRACING,
    }
    return func(self, world_name, layer, timer_name, optional_view_name, optional_flags, ...)
end)

-- ##### ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌  ┌─┐┬─┐┌─┐┬  ┬┬┌─┐┬ ┬ #####################################################################
-- ##### │││├┤ ├─┤├─┘│ ││││  ├─┘├┬┘├┤ └┐┌┘│├┤ │││ #####################################################################
-- ##### └┴┘└─┘┴ ┴┴  └─┘┘└┘  ┴  ┴└─└─┘ └┘ ┴└─┘└┴┘ #####################################################################

mod:hook(CLASS.UIWorldSpawner, "spawn_level", function(func, self, level_name, included_object_sets, position, rotation, ignore_level_background, ...)
    func(self, level_name, included_object_sets, position, rotation, ignore_level_background, ...)
    if string_find(self._world_name, "ViewElementInventoryWeaponPreview") then
        local level_units = level_units(self._level, true)
        local unknown_units = {}
        if level_units then
            local move_units = {
                "#ID[7fb88579bf209537]", -- background
                "#ID[7c763e4de74815e3]", -- lights
            }
            local light_units = {
                "#ID[be13f33921de73ac]", -- lights
            }

            mod.preview_lights = {}

            for _, unit in pairs(level_units) do
                if table_contains(move_units, unit_debug_name(unit)) then
                    unit_set_local_position(unit, 1, unit_local_position(unit, 1) + vector3(0, 6, 0))
                end
                if table_contains(light_units, unit_debug_name(unit)) then
                    mod.preview_lights[#mod.preview_lights+1] = {
                        unit = unit,
                        position = vector3_box(unit_local_position(unit, 1)),
                    }
                end
            end
        end
    end
end)

-- ##### ┬┌┬┐┌─┐┌┬┐  ┌─┐┌─┐┌─┐┬┌─┌─┐┌─┐┌─┐┌─┐ #########################################################################
-- ##### │ │ ├┤ │││  ├─┘├─┤│  ├┴┐├─┤│ ┬├┤ └─┐ #########################################################################
-- ##### ┴ ┴ └─┘┴ ┴  ┴  ┴ ┴└─┘┴ ┴┴ ┴└─┘└─┘└─┘ #########################################################################

mod:hook(CLASS.MispredictPackageHandler, "_unload_item_packages", function(func, self, item, ...)
end)

mod:hook(CLASS.MispredictPackageHandler, "destroy", function(func, self, ...)
    if mod.cosmetics_view then
        return
    end
	for fixed_frame, items in pairs(self._pending_unloads) do
		for i = 1, #items do
			local item = items[i]

			self:_unload_item_packages(item)
		end
	end
	self._pending_unloads = nil
	self._loaded_packages = nil
end)

mod.attachment_package_snapshot = function(self, item, test_data)
    local packages = test_data or {}
    if not test_data then
        local attachments = item.__master_item.attachments
        ItemPackage._resolve_item_packages_recursive(attachments, MasterItems.get_cached(), packages)
    end
    if self.old_package_snapshot then
        self.new_package_snapshot = packages
        return self:attachment_package_resolve()
    else
        self.old_package_snapshot = packages
    end
end

mod.attachment_package_resolve = function(self)
    if self.old_package_snapshot and self.new_package_snapshot then
        local old_packages = {}
        for name, _ in pairs(self.old_package_snapshot) do
            if not self.new_package_snapshot[name] then
                old_packages[#old_packages+1] = name
            end
        end
        local new_packages = {}
        for name, _ in pairs(self.new_package_snapshot) do
            if not self.old_package_snapshot[name] then
                new_packages[#new_packages+1] = name
            end
        end
        self.old_package_snapshot = nil
        self.new_package_snapshot = nil
        return old_packages, new_packages
    end
end

-- ##### ┌┬┐┌─┐┌─┐┌┬┐┌─┐┬─┐  ┬┌┬┐┌─┐┌┬┐  ┌┬┐┌─┐┌┬┐┬┌─┐┬┌─┐┌─┐┌┬┐┬┌─┐┌┐┌  ┌─┐┬─┐┌─┐┌─┐┬ ┬ ##############################
-- ##### │││├─┤└─┐ │ ├┤ ├┬┘  │ │ ├┤ │││  ││││ │ │││├┤ ││  ├─┤ │ ││ ││││  │  ├┬┘├─┤└─┐├─┤ ##############################
-- ##### ┴ ┴┴ ┴└─┘ ┴ └─┘┴└─  ┴ ┴ └─┘┴ ┴  ┴ ┴└─┘─┴┘┴└  ┴└─┘┴ ┴ ┴ ┴└─┘┘└┘  └─┘┴└─┴ ┴└─┘┴ ┴ ##############################

mod:hook_require("scripts/backend/master_items", function(instance)

    local FALLBACK_ITEMS_BY_SLOT = {
        slot_body_hair = "content/items/characters/player/human/attachments_default/slot_body_hair",
        slot_animation_emote_5 = "content/items/animations/emotes/emote_human_greeting_001_wave_01",
        slot_body_tattoo = "content/items/characters/player/human/attachments_default/slot_body_torso",
        slot_gear_extra_cosmetic = "content/items/characters/player/human/attachments_default/slot_attachment",
        slot_animation_emote_3 = "content/items/animations/emotes/emote_human_greeting_001_wave_01",
        slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_pale_01",
        slot_pocketable = "content/items/pocketable/empty_pocketable",
        slot_attachment_1 = "content/items/characters/player/human/attachments_default/slot_attachment",
        slot_body_face_scar = "content/items/characters/player/human/attachments_default/slot_body_face",
        slot_attachment_2 = "content/items/characters/player/human/attachments_default/slot_attachment",
        slot_trinket_1 = "content/items/weapons/player/trinkets/empty_trinket",
        slot_attachment_3 = "content/items/characters/player/human/attachments_default/slot_attachment",
        slot_body_face_implant = "content/items/characters/player/human/attachments_default/slot_body_face",
        slot_gear_upperbody = "content/items/characters/player/human/attachments_default/slot_gear_torso",
        slot_body_face_hair = "content/items/characters/player/human/attachments_default/slot_body_face",
        slot_body_legs = "content/items/characters/player/human/attachments_default/slot_body_legs",
        slot_secondary = "content/items/weapons/player/melee/unarmed",
        slot_body_face = "content/items/characters/player/human/attachments_default/slot_body_face",
        slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_blue_01",
        slot_weapon_skin = "content/items/weapons/player/skins/lasgun/lasgun_p1_m001",
        slot_gear_lowerbody = "content/items/characters/player/human/attachments_default/slot_gear_legs",
        slot_portrait_frame = "content/items/2d/portrait_frames/portrait_frame_default",
        slot_body_face_tattoo = "content/items/characters/player/human/attachments_default/slot_body_face",
        slot_insignia = "content/items/2d/insignias/insignia_default",
        slot_body_torso = "content/items/characters/player/human/attachments_default/slot_body_torso",
        slot_primary = "content/items/weapons/player/melee/unarmed",
        slot_unarmed = "content/items/weapons/player/melee/unarmed",
        slot_device = "content/items/devices/empty_device",
        slot_animation_end_of_round = "content/items/animations/emotes/emote_human_greeting_001_wave_01",
        slot_animation_emote_4 = "content/items/animations/emotes/emote_human_greeting_001_wave_01",
        slot_animation_emote_1 = "content/items/animations/emotes/emote_human_greeting_001_wave_01",
        slot_gear_head = "content/items/characters/player/human/attachments_default/slot_gear_head",
        slot_body_arms = "content/items/characters/player/human/attachments_default/slot_body_arms",
        slot_skin_set = "content/items/characters/player/sets/empty_set",
        slot_animation_emote_2 = "content/items/animations/emotes/emote_human_greeting_001_wave_01",
        slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_brown_01"
    }
    
    if BUILD == "release" then
        FALLBACK_ITEMS_BY_SLOT.slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/empty_face_tattoo"
        FALLBACK_ITEMS_BY_SLOT.slot_body_face_scar = "content/items/characters/player/human/face_scars/empty_face_scar"
        FALLBACK_ITEMS_BY_SLOT.slot_body_face_hair = "content/items/characters/player/human/face_hair/empty_face_hair"
        FALLBACK_ITEMS_BY_SLOT.slot_body_hair = "content/items/characters/player/human/hair/empty_hair"
        FALLBACK_ITEMS_BY_SLOT.slot_body_tattoo = "content/items/characters/player/human/body_tattoo/empty_body_tattoo"
        FALLBACK_ITEMS_BY_SLOT.slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_blue_01"
        FALLBACK_ITEMS_BY_SLOT.slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_brown_01"
        FALLBACK_ITEMS_BY_SLOT.slot_gear_extra_cosmetic = "items/characters/player/human/backpacks/empty_backpack"
        FALLBACK_ITEMS_BY_SLOT.slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear"
        FALLBACK_ITEMS_BY_SLOT.slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/empty_lowerbody"
        FALLBACK_ITEMS_BY_SLOT.slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/empty_upperbody"
    end

    local function _fallback_item(gear)
        local instance_id = gear.masterDataInstance.id
    
        log_error("MasterItemCache", string_format("No master data for item with id %s", instance_id))
    
        local slot = gear.slots and gear.slots[1]
        local fallback_name = slot and FALLBACK_ITEMS_BY_SLOT[slot]
    
        if not fallback_name then
            log_error("MasterItemCache", string_format("No fallback item found for %s in slot %s", instance_id, slot))
    
            return nil
        end
    
        log_warning("MasterItemCache", string_format("Using fallback with name %s", fallback_name))
    
        local fallback = rawget(instance.get_cached(), fallback_name)
    
        return fallback
    end

    local function _merge_item_data_recursive(dest, source)
        for key, value in pairs(source) do
            local is_table = type(value) == "table"
    
            if value == source then
                dest[key] = dest
            elseif is_table and type(dest[key]) == "table" then
                _merge_item_data_recursive(dest[key], value)
            else
                dest[key] = value
            end
        end
    
        return dest
    end

    local function _validate_overrides(overrides)
        local traits = overrides.traits
    
        if traits then
            for i = #traits, 1, -1 do
                local data = traits[i]
                local trait_id = data.id
                local trait_exists = rawget(instance.get_cached(), trait_id)
    
                if not trait_exists then
                    table_remove(traits, i)
                end
            end
        end
    
        local perks = overrides.perks
    
        if perks then
            for i = #perks, 1, -1 do
                local data = perks[i]
                local perk_id = data.id
                local perk_exists = rawget(instance.get_cached(), perk_id)
    
                if not perk_exists then
                    table_remove(perks, i)
                end
            end
        end
    end

    local function _update_master_data(item_instance)
        rawset(item_instance, "__master_ver", instance.get_cached_version())
    
        local gear = rawget(item_instance, "__gear")
        local item = rawget(instance.get_cached(), gear.masterDataInstance.id)
        item = item or _fallback_item(gear)
    
        if item then
            local clone = table_clone(item)
            local overrides = gear.masterDataInstance.overrides
    
            if overrides then
                _validate_overrides(overrides)
                _merge_item_data_recursive(clone, overrides)
            end
    
            local count = gear.count
    
            if count then
                clone.count = count
            end
    
            local temp_overrides = rawget(item_instance, "__temp_overrides")
    
            if temp_overrides then
                _merge_item_data_recursive(clone, temp_overrides)
            end
    
            rawset(item_instance, "__master_item", clone)
            rawset(item_instance, "set_temporary_overrides", function (self, new_temp_overrides)
                rawset(item_instance, "__temp_overrides", new_temp_overrides)
    
                return _update_master_data(item_instance)
            end)
    
            return true
        end
    
        return false
    end

    local function _item_plus_overrides(gear, gear_id, is_preview_item)
        local item_instance = {
            __gear = gear,
            __gear_id = is_preview_item and math_uuid() or gear_id,
            __original_gear_id = is_preview_item and gear_id,
            __is_preview_item = is_preview_item and true or false
        }
    
        setmetatable(item_instance, {
            __index = function (t, field_name)
                local master_ver = rawget(item_instance, "__master_ver")
    
                if master_ver ~= instance.get_cached_version() then
                    local success = _update_master_data(item_instance)
    
                    if not success then
                        log_error("MasterItems", "[_item_plus_overrides][1] could not update master data with %s", gear.masterDataInstance.id)
    
                        return nil
                    end
                end
    
                if field_name == "gear_id" then
                    return rawget(item_instance, "__gear_id")
                end
    
                if field_name == "gear" then
                    return rawget(item_instance, "__gear")
                end
    
                local master_item = rawget(item_instance, "__master_item")
    
                if not master_item then
                    log_warning("MasterItemCache", string_format("No master data for item with id %s", gear.masterDataInstance.id))
    
                    return nil
                end
    
                local field_value = master_item[field_name]
    
                if field_name == "rarity" and field_value == -1 then
                    return nil
                end
    
                return field_value
            end,
            __newindex = function (t, field_name, value)
                if is_preview_item then
                    rawset(t, field_name, value)
                else
                    -- ferror("Not allowed to modify inventory items - %s[%s]", rawget(item_instance, "__gear_id"), field_name)
                    rawget(item_instance, "__gear_id")
                end
            end,
            __tostring = function (t)
                local master_item = rawget(item_instance, "__master_item")
    
                return string_format("master_item: [%s] gear_id: [%s]", tostring(master_item and master_item.name), tostring(rawget(item_instance, "__gear_id")))
            end
        })
    
        local success = _update_master_data(item_instance)
    
        if not success then
            log_error("MasterItems", "[_item_plus_overrides][2] could not update master data with %s", gear.masterDataInstance.id)
    
            return nil
        end
    
        return item_instance
    end

    instance.get_item_instance = function (gear, gear_id)
        if not gear then
            log_warning("MasterItemCache", string_format("Gear list missing gear with id %s", gear_id))
    
            return nil
        else
            return _item_plus_overrides(gear, gear_id)
        end
    end
end)
