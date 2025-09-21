local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local CLASS = CLASS
    local script_unit = ScriptUnit
    local script_unit_extension = script_unit.extension
    local script_unit_add_extension = script_unit.add_extension
    local script_unit_remove_extension = script_unit.remove_extension
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local SLOT_SECONDARY = "slot_secondary"

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "init", function(func, self, extension_init_context, unit, extension_init_data, ...)
    -- Original function
    func(self, extension_init_context, unit, extension_init_data, ...)

    -- Destroy mispredict handler
    self._mispredict_package_handler = nil

    script_unit_add_extension(
        {
            world = self._world
        },
        self._unit,
        "SightExtension",
        "sight_system",
        {
            visual_loadout_extension = self,
        }
    )

    script_unit_add_extension(
        {
            world = self._world
        },
        self._unit,
        "SwayExtension",
        "sway_system",
        {
            visual_loadout_extension = self,
        }
    )

end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "equip_item_to_slot", function(func, self, item, slot_name, optional_existing_unit_3p, t, ...)
    -- Original function
    func(self, item, slot_name, optional_existing_unit_3p, t, ...)

    if slot_name == SLOT_SECONDARY then
        local sight_extension = script_unit_extension(self._unit, "sight_system")
        if sight_extension then
            sight_extension:on_equip_weapon()
        end
    end
end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "destroy", function(func, self, ...)

    script_unit_remove_extension(self._unit, "sight_system")

    -- Original function
    func(self, ...)
end)
