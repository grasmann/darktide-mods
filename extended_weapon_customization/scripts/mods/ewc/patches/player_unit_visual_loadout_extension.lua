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
    local table = table
    local CLASS = CLASS
    local script_unit = ScriptUnit
    local table_contains = table.contains
    local script_unit_extension = script_unit.extension
    local script_unit_add_extension = script_unit.add_extension
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
                -- from_ui_profile_spawner = self._equipment_component._from_ui_profile_spawner,
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
                -- from_ui_profile_spawner = self._equipment_component._from_ui_profile_spawner,
            }
        )
    end

    self.flashlight_extension_update = true
    self.sight_extension_update = true
    self.attachment_callback_extension_update = true

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
        mod.pressed_once_t = nil
        mod.custom_twice_cooldown = 2
        mod.pressed_twice = true
    end

    if table_contains(PROCESS_SLOTS, slot_name) then
        self.attachment_callback_extension_update = true
    end

end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "fixed_update", function(func, self, unit, dt, t, frame, ...)
    -- Original function
    func(self, unit, dt, t, frame, ...)

    if self.flashlight_extension_update then
        if self:is_slot_unit_spawned(SLOT_SECONDARY) then
            local flashlight_extension = script_unit_extension(self._unit, "flashlight_system")
            if flashlight_extension then
                flashlight_extension:on_equip_weapon()
            end
            self.flashlight_extension_update = nil
        end
    end

    if self.sight_extension_update then
        if self:is_slot_unit_spawned(SLOT_SECONDARY) then
            local sight_extension = script_unit_extension(self._unit, "sight_system")
            if sight_extension then
                sight_extension:on_equip_weapon()
            end
            self.sight_extension_update = nil
        end
    end

    local attachment_callback_extension = script_unit_extension(self._unit, "attachment_callback_system")
    if attachment_callback_extension then
        
        if self.attachment_callback_extension_update then
            if self:is_slot_unit_spawned(SLOT_SECONDARY) and self:is_slot_unit_spawned(SLOT_PRIMARY) then
                attachment_callback_extension:on_equip_weapon()
                self.attachment_callback_extension_update = nil
            end
        end

        attachment_callback_extension:update(dt, t)
    end
    
end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "destroy", function(func, self, ...)

    if script_unit_extension(self._unit, "sight_system") then
        script_unit_remove_extension(self._unit, "sight_system")
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
