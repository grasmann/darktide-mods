local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local NetworkLookup = mod:original_require("scripts/network_lookup/network_lookup")
local Promise = mod:original_require("scripts/foundation/utilities/promise")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local table = table
    local CLASS = CLASS
    local script_unit = ScriptUnit
    -- local table_contains = table.contains
    local unit_sight_callback = unit.sight_callback
    local unit_shield_callback = unit.shield_callback
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

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "init", function(func, self, extension_init_context, unit, extension_init_data, ...)

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
                wielded_slot = self._inventory_component.wielded_slot,
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
                wielded_slot = self._inventory_component.wielded_slot,
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
                is_local_unit = true,
                visual_loadout_extension = self,
                player = extension_init_data.player,
                wielded_slot = self._inventory_component.wielded_slot,
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
                wielded_slot = self._inventory_component.wielded_slot,
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
                wielded_slot = self._inventory_component.wielded_slot,
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
                wielded_slot = self._inventory_component.wielded_slot,
            }
        )
    end

    self.flashlight_extension_update = true
    self.sight_extension_update = true
    self.attachment_callback_extension_update = true
    self.shield_extension_update = true
    self.damage_type_extension_update = true

end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "equip_item_to_slot", function(func, self, item, slot_name, optional_existing_unit_3p, t, ...)
    -- Original function
    func(self, item, slot_name, optional_existing_unit_3p, t, ...)

    if slot_name == SLOT_SECONDARY then
        self.sight_extension_update = true
        self.flashlight_extension_update = true
    elseif slot_name == "slot_pocketable" or slot_name == "slot_pocketable_small" then
        -- Reset timer for flashlight input
        -- To prevent flashlight toggle when picking up items
        mod:reset_flashlight_input_timer()
    end

    -- if table_contains(PROCESS_SLOTS, slot_name) then
    if mod:cached_table_contains(PROCESS_SLOTS, slot_name) then
        self.attachment_callback_extension_update = true
        self.shield_extension_update = true
        self.damage_type_extension_update = true
    end

end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "fixed_update", function(func, self, unit, dt, t, frame, ...)
    -- Original function
    func(self, unit, dt, t, frame, ...)

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

    if self.shield_extension_update then
        if self:is_slot_unit_spawned(SLOT_SECONDARY) and self:is_slot_unit_spawned(SLOT_PRIMARY) then
            unit_shield_callback(self._unit, "on_equip_weapon")
            self.shield_extension_update = nil
        end
    end

    if self.damage_type_extension_update then
        if self:is_slot_unit_spawned(SLOT_SECONDARY) and self:is_slot_unit_spawned(SLOT_PRIMARY) then
            unit_damage_type_callback(self._unit, "on_equip_weapon")
            self.damage_type_extension_update = nil
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

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "destroy", function(func, self, ...)

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

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "resolve_gear_sound", function(func, self, sound_alias, optional_external_properties, ...)
	local allow_default, event, has_husk_events = func(self, sound_alias, optional_external_properties, ...)
	local inventory_component = self._inventory_component
	local current_wielded_slot = inventory_component.wielded_slot
	local item = self:item_from_slot(current_wielded_slot)
	local gear_id = mod:gear_id(item)

	if gear_id and mod.fx_overrides[gear_id] and mod.fx_overrides[gear_id][sound_alias] then
		event = mod.fx_overrides[gear_id][sound_alias]
	end

	return allow_default, event, has_husk_events
end)
