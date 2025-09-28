local mod = get_mod("extended_weapon_customization")

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
local PROCESS_SLOTS = {"WEAPON_MELEE", "WEAPON_RANGED"}
local sight_extension_update = false
local flashlight_extension_update = false

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "init", function(func, self, extension_init_context, unit, extension_init_data, ...)
    -- Original function
    func(self, extension_init_context, unit, extension_init_data, ...)

    -- Destroy mispredict handler
    self._mispredict_package_handler = nil

    if not script_unit_extension(self._unit, "sight_system") then
        script_unit_add_extension(
            {
                world = self._equipment_component._world
            },
            self._unit,
            "SightExtension",
            "sight_system",
            {
                visual_loadout_extension = self,
            }
        )
    end

    if not script_unit_extension(self._unit, "sway_system") then
        script_unit_add_extension(
            {
                world = self._equipment_component._world
            },
            self._unit,
            "SwayExtension",
            "sway_system",
            {
                visual_loadout_extension = self,
                player = self._player,
            }
        )
    end

    if not script_unit_extension(self._unit, "flashlight_system") then
        script_unit_add_extension(
            {
                world = self._equipment_component._world,
            },
            self._unit,
            "FlashlightExtension",
            "flashlight_system",
            {
                visual_loadout_extension = self,
                player = self._player,
                from_ui_profile_spawner = self._equipment_component._from_ui_profile_spawner,
            }
        )
    end

end)

mod:hook(CLASS.PlayerHuskVisualLoadoutExtension, "_equip_item_to_slot", function(func, self, slot_name, item, optional_existing_unit_3p, ...)
    if table_contains(PROCESS_SLOTS, slot_name) then
        local gear_id = mod:gear_id(item)
        local random_gear_settings = mod:randomize_item(item)
        mod:gear_settings(gear_id, random_gear_settings)
    end
    -- Original function
    func(self, slot_name, item, optional_existing_unit_3p, ...)
end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "equip_item_to_slot", function(func, self, item, slot_name, optional_existing_unit_3p, t, ...)
    -- Original function
    func(self, item, slot_name, optional_existing_unit_3p, t, ...)

    if slot_name == SLOT_SECONDARY then
        sight_extension_update = true
        flashlight_extension_update = true
    elseif slot_name == "slot_pocketable" or slot_name == "slot_pocketable_small" then
        -- Reset timer for flashlight input
        -- To prevent flashlight toggle when picking up items
        mod.pressed_once_t = nil
        mod.custom_twice_cooldown = 2
        mod.pressed_twice = true
    end
end)

-- mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "update", function(func, self, dt, t, ...)
mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "fixed_update", function(func, self, unit, dt, t, frame, ...)
    -- Original function
    func(self, unit, dt, t, frame, ...)

    if flashlight_extension_update then
        if self:is_slot_unit_spawned(SLOT_SECONDARY) then
            local flashlight_extension = script_unit_extension(self._unit, "flashlight_system")
            if flashlight_extension then
                flashlight_extension:on_equip_weapon()
            end
            flashlight_extension_update = nil
        end
    end

    if sight_extension_update then
        if self:is_slot_unit_spawned(SLOT_SECONDARY) then
            local sight_extension = script_unit_extension(self._unit, "sight_system")
            if sight_extension then
                sight_extension:on_equip_weapon()
            end
            sight_extension_update = nil
        end
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

    -- Original function
    func(self, ...)
end)
