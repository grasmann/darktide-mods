local mod = get_mod("weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
    local CLASS = CLASS
    local World = World
    local managers = Managers
    local world_update_unit_and_children = World.update_unit_and_children
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/extension_systems/first_person/player_unit_first_person_extension", function(instance)

    instance.update_custom_extensions = function(self, dt, t)
        -- Sights
        if self.use_sight_system then mod:execute_extension(self._unit, "sight_system", "update_position_and_rotation", self) end
        -- Weapon DOF
        if self.use_dof_system then mod:execute_extension(self._unit, "weapon_dof_system", "update", dt, t) end
        -- Sway
        if self.use_sway_system then mod:execute_extension(self._unit, "sway_system", "update", dt, t) end
        -- Crouch
        if self.use_crouch_animation_system then mod:execute_extension(self._unit, "crouch_system", "update", dt, t) end
        -- Flashlight / laser pointer
        if self.use_flashlight_system then mod:execute_extension(self._unit, "flashlight_system", "update", dt, t) end
    end

    instance.on_settings_changed = function(self)
        self.use_crouch_animation_system = mod:get("mod_option_crouch_animation")
        self.use_dof_system = mod:get("mod_option_misc_weapon_dof")
        self.use_sway_system = mod:get("mod_option_sway")
        self.use_flashlight_system = mod:get("mod_option_flashlight")
        self.use_sight_system = mod:get("mod_option_scopes")
    end

end)

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #########################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #########################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #########################################################################

mod:hook(CLASS.PlayerUnitFirstPersonExtension, "init", function(func, self, extension_init_context, unit, extension_init_data, ...)

    -- Original function
    func(self, extension_init_context, unit, extension_init_data, ...)

    -- Register event
    managers.event:register(self, "weapon_customization_settings_changed", "on_settings_changed")

    -- Set settings
    self:on_settings_changed()

end)

mod:hook(CLASS.PlayerUnitFirstPersonExtension, "destroy", function(func, self, ...)

    -- Unregister event
    managers.event:unregister(self, "weapon_customization_settings_changed")

    -- Original function
    func(self, ...)

end)

mod:hook(CLASS.PlayerUnitFirstPersonExtension, "update_unit_position", function(func, self, unit, dt, t, ...)

    -- Original function
    func(self, unit, dt, t, ...)

    -- Update custom extensions
    self:update_custom_extensions(dt, t)

    -- Update first person unit
    world_update_unit_and_children(self._world, self._first_person_unit)

end)