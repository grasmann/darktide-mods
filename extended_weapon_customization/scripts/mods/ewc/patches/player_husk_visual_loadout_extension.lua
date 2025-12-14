local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local NetworkLookup = mod:original_require("scripts/network_lookup/network_lookup")
local Promise = mod:original_require("scripts/foundation/utilities/promise")
local MasterItems = mod:original_require("scripts/backend/master_items")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local math = math
    local unit = Unit
    local table = table
    local CLASS = CLASS
    local string = string
    local tostring = tostring
    local managers = Managers
    local math_uuid = math.uuid
    local script_unit = ScriptUnit
    -- local string_find = string.find
    -- local table_contains = table.contains
    local unit_sight_callback = unit.sight_callback
    local unit_shield_callback = unit.shield_callback
    local table_clone_instance = table.clone_instance
    local script_unit_extension = script_unit.extension
    local unit_attachment_callback = unit.attachment_callback
    local unit_flashlight_callback = unit.flashlight_callback
    local script_unit_add_extension = script_unit.add_extension
    local unit_damage_type_callback = unit.damage_type_callback
    local script_unit_remove_extension = script_unit.remove_extension
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local SLOT_SECONDARY = "slot_secondary"
local SLOT_PRIMARY = "slot_primary"
local PROCESS_SLOTS = {SLOT_PRIMARY, SLOT_SECONDARY}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod.player_husk_visual_loadout_extension_randomize = function(self, item)
    return mod:handle_husk_item(item)
end

mod:hook(CLASS.PlayerHuskVisualLoadoutExtension, "init", function(func, self, extension_init_context, unit, extension_init_data, ...)

    local world = extension_init_context.world

    -- Original function
    func(self, extension_init_context, unit, extension_init_data, ...)

    if not script_unit_extension(unit, "sight_system") then
        script_unit_add_extension(
            {
                world = world
            },
            unit,
            "SightExtension",
            "sight_system",
            {
                visual_loadout_extension = self,
                wielded_slot = self._wielded_slot,
            }
        )
    end

    if not script_unit_extension(unit, "sway_system") then
        script_unit_add_extension(
            {
                world = world
            },
            unit,
            "SwayExtension",
            "sway_system",
            {
                visual_loadout_extension = self,
                player = extension_init_data.player,
                wielded_slot = self._wielded_slot,
            }
        )
    end

    if not script_unit_extension(unit, "flashlight_system") then
        script_unit_add_extension(
            {
                world = world,
            },
            unit,
            "FlashlightExtension",
            "flashlight_system",
            {
                is_local_unit = false,
                visual_loadout_extension = self,
                player = extension_init_data.player,
                wielded_slot = self._wielded_slot,
            }
        )
    end

    if not script_unit_extension(unit, "attachment_callback_system") then
        script_unit_add_extension(
            {
                world = world,
            },
            unit,
            "AttachmentCallbackExtension",
            "attachment_callback_system",
            {
                visual_loadout_extension = self,
                player = extension_init_data.player,
                wielded_slot = self._wielded_slot,
            }
        )
    end

    if not script_unit_extension(unit, "shield_transparency_system") then
        script_unit_add_extension(
            {
                world = world,
            },
            unit,
            "ShieldTransparencyExtension",
            "shield_transparency_system",
            {
                visual_loadout_extension = self,
                player = extension_init_data.player,
                wielded_slot = self._wielded_slot,
            }
        )
    end

    if not script_unit_extension(unit, "damage_type_system") then
        script_unit_add_extension(
            {
                world = world,
            },
            unit,
            "DamageTypeExtension",
            "damage_type_system",
            {
                visual_loadout_extension = self,
                player = extension_init_data.player,
                wielded_slot = self._wielded_slot,
            }
        )
    end

    self.flashlight_extension_update = true
    self.sight_extension_update = true
    self.attachment_callback_extension_update = true
    self.shield_extension_update = true
    self.damage_type_extension_update = true

end)

mod:hook(CLASS.PlayerHuskVisualLoadoutExtension, "_equip_item_to_slot", function(func, self, slot_name, item, optional_existing_unit_3p, ...)
    -- Original function
    func(self, slot_name, item, optional_existing_unit_3p, ...)

    if slot_name == SLOT_SECONDARY then
        self.sight_extension_update = true
        self.flashlight_extension_update = true
    end

    -- if table_contains(PROCESS_SLOTS, slot_name) then
    if mod:cached_table_contains(PROCESS_SLOTS, slot_name) then
        self.attachment_callback_extension_update = true
        self.shield_extension_update = true
        self.damage_type_extension_update = true
    end

end)

mod:hook(CLASS.PlayerHuskVisualLoadoutExtension, "wield_slot", function(func, self, slot_name, ...)

    -- Original function
    func(self, slot_name, ...)

    local equipment = self._equipment
    local equipment_component = self._equipment_component
    local first_person_mode = self._first_person_extension:is_in_first_person_mode()
    equipment_component.wield_slot(equipment[slot_name], first_person_mode)

end)

mod:hook(CLASS.PlayerHuskVisualLoadoutExtension, "update", function(func, self, unit, dt, t, ...)
    -- Original function
    func(self, unit, dt, t, ...)

    if self.flashlight_extension_update then
        if self:is_slot_unit_spawned(SLOT_SECONDARY) then
            unit_flashlight_callback(self._unit, "on_equip_weapon")
            self.flashlight_extension_update = nil
        end
    end

    if self.sight_extension_update then
        if self:is_slot_unit_spawned(SLOT_SECONDARY) then
            unit_sight_callback(self._unit, "on_equip_weapon")
            self.sight_extension_update = nil
        end
    end

    if self.damage_type_extension_update then
        if self:is_slot_unit_spawned(SLOT_SECONDARY) and self:is_slot_unit_spawned(SLOT_PRIMARY) then
            unit_damage_type_callback(self._unit, "on_equip_weapon")
            self.damage_type_extension_update = nil
        end
    end

    if self.shield_extension_update then
        if self:is_slot_unit_spawned(SLOT_SECONDARY) and self:is_slot_unit_spawned(SLOT_PRIMARY) then
            unit_shield_callback(self._unit, "on_equip_weapon")
            self.shield_extension_update = nil
        end
    end

    if self.attachment_callback_extension_update then
        if self:is_slot_unit_spawned(SLOT_SECONDARY) and self:is_slot_unit_spawned(SLOT_PRIMARY) then
            unit_attachment_callback(self._unit, "on_equip_weapon")
            self.attachment_callback_extension_update = nil
        end
    end

    unit_attachment_callback(self._unit, "update", dt, t)
    
end)

mod:hook(CLASS.PlayerHuskVisualLoadoutExtension, "destroy", function(func, self, ...)

    if script_unit_extension(self._unit, "sight_system") then
        script_unit_remove_extension(self._unit, "sight_system")
    end

    if script_unit_extension(self._unit, "shield_transparency_system") then
        script_unit_remove_extension(self._unit, "shield_transparency_system")
    end

    if script_unit_extension(self._unit, "damage_type_system") then
        script_unit_remove_extension(self._unit, "damage_type_system")
    end

    if script_unit_extension(self._unit, "sway_system") then
        script_unit_remove_extension(self._unit, "sway_system")
    end
    
    if script_unit_extension(self._unit, "flashlight_system") then
        script_unit_remove_extension(self._unit, "flashlight_system")
    end

    if script_unit_extension(self._unit, "attachment_callback_system") then
        script_unit_remove_extension(self._unit, "attachment_callback_system")
    end

    -- Original function
    func(self, ...)
end)

mod:hook(CLASS.PlayerHuskVisualLoadoutExtension, "rpc_player_equip_item_from_profile_to_slot", function(func, self, channel_id, go_id, slot_id, debug_item_id, ...)

    local slot_name = NetworkLookup.player_inventory_slot_names[slot_id]
    local player = self._player
    local profile = player:profile()
    local item = profile.visual_loadout[slot_name]
    local optional_existing_unit_3p

    -- if table_contains(PROCESS_SLOTS, slot_name) and item then
    if mod:cached_table_contains(PROCESS_SLOTS, slot_name) and item then
        -- Randomize weapon for other player
        mod:print("rpc_player_equip_item_from_profile_to_slot player "..tostring(player:name()).." slot "..tostring(slot_name))
        mod:print("rpc_player_equip_item_from_profile_to_slot item"..tostring(item.name).." gear_id "..tostring(mod:gear_id(item)))
        -- Replace visual loadout
        profile.visual_loadout[slot_name] = mod:player_husk_visual_loadout_extension_randomize(item)
        mod:reevaluate_packages(player)
        -- Reevaluate packages
        mod:print("reevaluate_packages "..tostring(player))
        mod:reevaluate_packages(player)
    end

	self:_equip_item_to_slot(slot_name, item, optional_existing_unit_3p)

end)

mod:hook(CLASS.PlayerHuskVisualLoadoutExtension, "resolve_gear_sound", function(func, self, sound_alias, optional_external_properties, ...)
	local allow_default, event, has_husk_events = func(self, sound_alias, optional_external_properties, ...)
    local current_wielded_slot = self._wielded_slot or "unarmed"
	local item = self:item_from_slot(current_wielded_slot)
	local gear_id = mod:gear_id(item)

	if gear_id and mod.fx_overrides[gear_id] and mod.fx_overrides[gear_id][sound_alias] then
		event = mod.fx_overrides[gear_id][sound_alias]
	end

	return allow_default, event, has_husk_events
end)
