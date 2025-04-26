local mod = get_mod("weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
    local CLASS = CLASS
    local World = World
    local managers = Managers
    local script_unit = ScriptUnit
    local script_unit_extension = script_unit.extension
    local world_update_unit_and_children = World.update_unit_and_children
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/extension_systems/first_person/player_husk_first_person_extension", function(instance)

    instance.update_custom_extensions = function(self)
        -- Sights
        if self.use_sight_system then
            local sight_extension = script_unit_extension(self._unit, "sight_system")
            if sight_extension then
                sight_extension:set_spectated(self._is_first_person_spectated)
                sight_extension:update_position_and_rotation(self)
            end
        end
        -- Weapon DOF
        if self.use_dof_system then mod:execute_extension(self._unit, "weapon_dof_system", "set_spectated", self._is_first_person_spectated) end
        -- Flashlight / laser pointer
        if self.use_flashlight_system then mod:execute_extension(self._unit, "flashlight_system", "set_spectated", self._is_first_person_spectated) end
        -- Crouch
        if self.use_crouch_animation_system then mod:execute_extension(self._unit, "crouch_system", "set_spectated", self._is_first_person_spectated) end
        -- Sway
        if self.use_sway_system then mod:execute_extension(self._unit, "sway_system", "set_spectated", self._is_first_person_spectated) end
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

mod:hook(CLASS.PlayerHuskFirstPersonExtension, "init", function(func, self, extension_init_context, unit, extension_init_data, ...)

    self.wc_initialized = true

    -- Original function
    func(self, extension_init_context, unit, extension_init_data, ...)

    -- Register event
    managers.event:register(self, "weapon_customization_settings_changed", "on_settings_changed")

    -- Set settings
    self:on_settings_changed()

end)

mod:hook(CLASS.PlayerHuskFirstPersonExtension, "destroy", function(func, self, ...)

    self.wc_initialized = false

    -- Unregister event
    managers.event:unregister(self, "weapon_customization_settings_changed")

    -- Original function
    func(self, ...)

end)

mod:hook(CLASS.PlayerHuskFirstPersonExtension, "update_unit_position_and_rotation", function(func, self, position_3p_unit, force_update_unit_and_children, ...)

    -- Original function
    func(self, position_3p_unit, force_update_unit_and_children, ...)

    if self.wc_initialized and self._first_person_unit then

        -- Update custom extensions
        self:update_custom_extensions()

        -- Update first person unit
        if force_update_unit_and_children then
            world_update_unit_and_children(self._world, self._first_person_unit)
        end

    end

end)