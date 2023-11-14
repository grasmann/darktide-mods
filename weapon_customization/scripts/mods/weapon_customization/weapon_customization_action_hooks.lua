local mod = get_mod("weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local CLASS = CLASS
    local script_unit = ScriptUnit
    local script_unit_has_extension = script_unit.has_extension
    local script_unit_extension = script_unit.extension
    local script_unit_remove_extension = script_unit.remove_extension
    local script_unit_add_extension = script_unit.add_extension
--#endregion

mod.movement_state_component_to_unit = {}

mod.remove_extension = function(self, unit, system)
    if script_unit_has_extension(unit, system) then
		script_unit_remove_extension(unit, system)
	end
end

mod.execute_extension = function(self, unit, system, function_name, ...)
    if script_unit_has_extension(unit, system) then
        local extension = script_unit_extension(unit, system)
        if extension[function_name] then
            extension[function_name](extension, ...)
        end
    end
end

-- ##### ┌─┐┬ ┌┬┐┌─┐┬─┐┌┐┌┌─┐┌┬┐┌─┐  ┌─┐┬┬─┐┌─┐ #######################################################################
-- ##### ├─┤│  │ ├┤ ├┬┘│││├─┤ │ ├┤   ├┤ │├┬┘├┤  #######################################################################
-- ##### ┴ ┴┴─┘┴ └─┘┴└─┘└┘┴ ┴ ┴ └─┘  └  ┴┴└─└─┘ #######################################################################

mod:hook_require("scripts/utilities/alternate_fire", function(instance)
    if not instance._stop then instance._stop = instance.stop end
    instance.stop = function(alternate_fire_component, peeking_component, first_person_extension, weapon_tweak_templates_component,
            animation_extension, weapon_template, skip_stop_anim, player_unit, from_action_input)
        instance._stop(alternate_fire_component, peeking_component, first_person_extension, weapon_tweak_templates_component,
            animation_extension, weapon_template, skip_stop_anim, player_unit, from_action_input)

        if script_unit_has_extension(player_unit, "sights_system") then
            local sights_extension = script_unit_extension(player_unit, "sights_system")
            local gameplay_time = mod.time_manager:time("gameplay")
            sights_extension:on_aim_stop(gameplay_time)
        end
    end
end)

-- ##### ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌  ┬─┐┌─┐┌┐┌┌─┐┌─┐┌┬┐  ┬ ┬┬┌─┐┬  ┌┬┐ ##########################################################
-- ##### ├─┤│   │ ││ ││││  ├┬┘├─┤││││ ┬├┤  ││  ││││├┤ │   ││ ##########################################################
-- ##### ┴ ┴└─┘ ┴ ┴└─┘┘└┘  ┴└─┴ ┴┘└┘└─┘└─┘─┴┘  └┴┘┴└─┘┴─┘─┴┘ ##########################################################

mod:hook(CLASS.ActionRangedWield, "start", function(func, self, action_settings, t, time_scale, action_start_params, ...)
    if script_unit_has_extension(self._player_unit, "sights_system") then
        local sights_extension = script_unit_extension(self._player_unit, "sights_system")
        sights_extension:on_ranged_wield()
    end

    -- Original function
    func(self, action_settings, t, time_scale, action_start_params, ...)
end)

-- ##### ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌  ┌─┐┬┌┬┐ ####################################################################################
-- ##### ├─┤│   │ ││ ││││  ├─┤││││ ####################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴└─┘┘└┘  ┴ ┴┴┴ ┴ ####################################################################################

mod:hook(CLASS.ActionAim, "start", function(func, self, action_settings, t, ...)
    if script_unit_has_extension(self._player_unit, "sights_system") then
        local sights_extension = script_unit_extension(self._player_unit, "sights_system")
        sights_extension:on_aim_start(t)
    end

    -- Finish event
    self.finish = function(self, reason, data, t, time_in_action)
        if script_unit_has_extension(self._player_unit, "sights_system") then
            local sights_extension = script_unit_extension(self._player_unit, "sights_system")
            sights_extension:on_aim_finish()
        end
    end

    -- Original function
    func(self, action_settings, t, ...)
end)

mod:hook(CLASS.ActionAim, "running_action_state", function(func, self, t, time_in_action, ...)
    -- Original function
    local ret = func(self, t, time_in_action, ...)

    if script_unit_has_extension(self._player_unit, "sights_system") then
        local sights_extension = script_unit_extension(self._player_unit, "sights_system")
        sights_extension:on_aim_running(time_in_action, self._action_settings.total_time)
    end

    return ret
end)

-- ##### ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌┐┌┌─┐┬┌┬┐ ##############################################################################
-- ##### ├─┤│   │ ││ ││││  │ ││││├─┤││││ ##############################################################################
-- ##### ┴ ┴└─┘ ┴ ┴└─┘┘└┘  └─┘┘└┘┴ ┴┴┴ ┴ ##############################################################################

mod:hook(CLASS.ActionUnaim, "start", function(func, self, action_settings, t, ...)
    if script_unit_has_extension(self._player_unit, "sights_system") then
        local sights_extension = script_unit_extension(self._player_unit, "sights_system")
        sights_extension:on_unaim_start(t)
    end

    -- Running event
    self.running_action_state = function(self, t, time_in_action, ...)
        if script_unit_has_extension(self._player_unit, "sights_system") then
            local sights_extension = script_unit_extension(self._player_unit, "sights_system")
            sights_extension:on_unaim_running()
        end
    end

    -- Original function
    func(self, action_settings, t, ...)
end)

mod:hook(CLASS.ActionUnaim, "finish", function(func, self, reason, data, t, time_in_action, ...)
    if script_unit_has_extension(self._player_unit, "sights_system") then
        local sights_extension = script_unit_extension(self._player_unit, "sights_system")
        sights_extension:on_unaim_finish()
    end

    -- Original function
    func(self, reason, data, t, time_in_action, ...)
end)

-- ##### ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌  ┌─┐┬ ┬┌─┐┬─┐┌─┐┌─┐  ┌─┐┬  ┬┌─┐┬─┐┬  ┌─┐┌─┐┌┬┐ ##############################################
-- ##### ├─┤│   │ ││ ││││  │  ├─┤├─┤├┬┘│ ┬├┤   │ │└┐┌┘├┤ ├┬┘│  │ │├─┤ ││ ##############################################
-- ##### ┴ ┴└─┘ ┴ ┴└─┘┘└┘  └─┘┴ ┴┴ ┴┴└─└─┘└─┘  └─┘ └┘ └─┘┴└─┴─┘└─┘┴ ┴─┴┘ ##############################################

mod:hook(CLASS.ActionOverloadCharge, "start", function(func, self, action_settings, t, time_scale, action_start_params, ...)
    if script_unit_has_extension(self._player_unit, "sights_system") then
        local sights_extension = script_unit_extension(self._player_unit, "sights_system")
        sights_extension:on_aim_start()
    end

    -- Original function
    func(self, action_settings, t, time_scale, action_start_params, ...)
end)

mod:hook(CLASS.ActionOverloadCharge, "running_action_state", function(func, self, t, time_in_action, ...)
    -- Original function
    local ret = func(self, t, time_in_action, ...)

    if script_unit_has_extension(self._player_unit, "sights_system") then
        local sights_extension = script_unit_extension(self._player_unit, "sights_system")
        sights_extension:on_aim_running(time_in_action, self._action_settings.total_time)
    end

    return ret
end)

mod:hook(CLASS.ActionOverloadCharge, "finish", function(func, self, reason, data, t, time_in_action, ...)
    -- Original function
    func(self, reason, data, t, time_in_action, ...)

    if script_unit_has_extension(self._player_unit, "sights_system") then
        local sights_extension = script_unit_extension(self._player_unit, "sights_system")
        local gameplay_time = mod.time_manager:time("gameplay")
        sights_extension:on_aim_stop(gameplay_time)
    end

end)

-- ##### ┌─┐┬  ┌─┐┬ ┬┌─┐┬─┐  ┬ ┬┌┐┌┬┌┬┐  ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ###############################
-- ##### ├─┘│  ├─┤└┬┘├┤ ├┬┘  │ │││││ │   │││├┤ ├─┤├─┘│ ││││  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ###############################
-- ##### ┴  ┴─┘┴ ┴ ┴ └─┘┴└─  └─┘┘└┘┴ ┴   └┴┘└─┘┴ ┴┴  └─┘┘└┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ###############################

mod:hook(CLASS.PlayerUnitWeaponExtension, "extensions_ready", function(func, self, world, unit, ...)
    -- Original function
    func(self, world, unit, ...)

    -- Extensions
	-- if script_unit_has_extension(self._unit, "sights_system") then
	-- 	script_unit_remove_extension(self._unit, "sights_system")
	-- end
    mod:remove_extension(self._unit, "sights_system")
    self.sights_extension = script_unit_add_extension({
		world = self._world,
	}, self._unit, "SightsExtension", "sights_system", {
		player = self._player,
        is_local_unit = self._is_local_unit,
	})
end)

mod:hook(CLASS.PlayerUnitWeaponExtension, "update", function(func, self, unit, dt, t, ...)
    -- Original function
    func(self, unit, dt, t, ...)

    if self.sights_extension then
		self.sights_extension:update(unit, dt, t)
	end
end)

mod:hook(CLASS.PlayerUnitWeaponExtension, "on_wieldable_slot_equipped", function(func, self, item, slot_name, weapon_unit, fx_sources,
        t, optional_existing_unit_3p, from_server_correction_occurred, ...)
    -- Original function
    func(self, item, slot_name, weapon_unit, fx_sources, t, optional_existing_unit_3p, from_server_correction_occurred, ...)

    if slot_name == "slot_secondary" and script_unit_has_extension(self._unit, "sights_system") then
        local sights_extension = script_unit_extension(self._unit, "sights_system")
        sights_extension:on_weapon_equipped()
    end
end)

mod:hook(CLASS.PlayerUnitWeaponExtension, "on_wieldable_slot_unequipped", function(func, self, slot_name, from_server_correction_occurred, ...)
    if slot_name == "slot_secondary" and script_unit_has_extension(self._unit, "sights_system") then
        local sights_extension = script_unit_extension(self._unit, "sights_system")
        sights_extension:on_weapon_unequipped()
    end

    -- Original function
    func(self, slot_name, from_server_correction_occurred, ...)
end)

-- ##### ┌─┐┬  ┌─┐┬ ┬┌─┐┬─┐  ┬ ┬┌┐┌┬┌┬┐  ┌─┐┬┬─┐┌─┐┌┬┐  ┌─┐┌─┐┬─┐┌─┐┌─┐┌┐┌  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ################
-- ##### ├─┘│  ├─┤└┬┘├┤ ├┬┘  │ │││││ │   ├┤ │├┬┘└─┐ │   ├─┘├┤ ├┬┘└─┐│ ││││  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ################
-- ##### ┴  ┴─┘┴ ┴ ┴ └─┘┴└─  └─┘┘└┘┴ ┴   └  ┴┴└─└─┘ ┴   ┴  └─┘┴└─└─┘└─┘┘└┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ################

mod:hook(CLASS.PlayerUnitFirstPersonExtension, "extensions_ready", function(func, self, world, unit, ...)
    -- Original function
    func(self, world, unit, ...)

    -- Extensions
	-- if script_unit_has_extension(self._unit, "crouch_system") then
	-- 	script_unit_remove_extension(self._unit, "crouch_system")
	-- end
    mod:remove_extension(self._unit, "crouch_system")
    self.sights_extension = script_unit_add_extension({
		world = self._world,
	}, self._unit, "CrouchAnimationExtension", "crouch_system", {
		player = self._player,
        is_local_unit = self._is_local_unit,
	})
end)

mod:hook(CLASS.PlayerUnitFirstPersonExtension, "update_unit_position", function(func, self, unit, dt, t, ...)
    func(self, unit, dt, t, ...)

    if not mod.movement_state_component_to_unit[self._movement_state_component] then
        mod.movement_state_component_to_unit[self._movement_state_component] = self._unit
    end

    if script_unit_has_extension(self._unit, "sights_system") then
        local sights_extension = script_unit_extension(self._unit, "sights_system")
        sights_extension:update_position_and_rotation(self)
    end

    -- if script_unit_has_extension(self._unit, "crouch_system") then
    --     local sights_extension = script_unit_extension(self._unit, "crouch_system")
    --     sights_extension:update(self)
    -- end
    mod:execute_extension(self._unit, "crouch_system", "update")

end)

-- ##### ┌─┐┌─┐┌┬┐┌─┐┬─┐┌─┐  ┌┬┐┌─┐┌┐┌┌─┐┌─┐┌─┐┬─┐ ####################################################################
-- ##### │  ├─┤│││├┤ ├┬┘├─┤  │││├─┤│││├─┤│ ┬├┤ ├┬┘ ####################################################################
-- ##### └─┘┴ ┴┴ ┴└─┘┴└─┴ ┴  ┴ ┴┴ ┴┘└┘┴ ┴└─┘└─┘┴└─ ####################################################################

mod:hook(CLASS.CameraManager, "post_update", function(func, self, dt, t, viewport_name, ...)
    func(self, dt, t, viewport_name, ...)

    local player = mod:player_from_viewport(viewport_name)
    if player and script_unit_has_extension(player.player_unit, "sights_system") then
        local sights_extension = script_unit_extension(player.player_unit, "sights_system")
        sights_extension:update_zoom(viewport_name)
    end

end)

-- mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "unequip_item_from_slot", function(func, self, slot_name, fixed_frame, ...)
--     if slot_name == "slot_secondary" and script_unit_has_extension(self._unit, "sights_system") then
--         local sights_extension = script_unit_extension(self._unit, "sights_system")
--         sights_extension:on_weapon_unequipped()
--     end

--     -- Original function
--     func(self, slot_name, fixed_frame, ...)
-- end)

-- mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "equip_item_to_slot", function(func, self, item, slot_name, optional_existing_unit_3p, t, ...)
--     -- Original function
--     func(self, item, slot_name, optional_existing_unit_3p, t, ...)

--     if slot_name == "slot_secondary" and script_unit_has_extension(self._unit, "sights_system") then
--         local sights_extension = script_unit_extension(self._unit, "sights_system")
--         sights_extension:on_weapon_equipped()
--     end
-- end)
