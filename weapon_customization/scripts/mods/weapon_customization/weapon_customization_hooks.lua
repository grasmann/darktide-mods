local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local NetworkLookup = mod:original_require("scripts/network_lookup/network_lookup")
local WeaponTemplate = mod:original_require("scripts/utilities/weapon/weapon_template")

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
    local Unit = Unit
    local unit_get_data = Unit.get_data
    local unit_alive = Unit.alive
    local unit_debug_name = Unit.debug_name
    local managers = Managers
    local pairs = pairs
    local table = table
    local table_enum = table.enum
    local table_clone = table.clone
    local table_contains = table.contains
    local table_merge_recursive = table.merge_recursive
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"
local DELETION_STATES = table.enum("default", "in_network_layers", "removing_units")
local OPTION_VISIBLE_EQUIPMENT = "mod_option_visible_equipment"
local SLOT_SECONDARY = "slot_secondary"

-- ##### ┌─┐┬ ┌┬┐┌─┐┬─┐┌┐┌┌─┐┌┬┐┌─┐  ┌─┐┬┬─┐┌─┐ #######################################################################
-- ##### ├─┤│  │ ├┤ ├┬┘│││├─┤ │ ├┤   ├┤ │├┬┘├┤  #######################################################################
-- ##### ┴ ┴┴─┘┴ └─┘┴└─┘└┘┴ ┴ ┴ └─┘  └  ┴┴└─└─┘ #######################################################################

mod:hook_require("scripts/utilities/alternate_fire", function(instance)

    if not instance._stop then instance._stop = instance.stop end
    instance.stop = function(alternate_fire_component, peeking_component, first_person_extension, weapon_tweak_templates_component,
            animation_extension, weapon_template, skip_stop_anim, player_unit, from_action_input)
        instance._stop(alternate_fire_component, peeking_component, first_person_extension, weapon_tweak_templates_component,
            animation_extension, weapon_template, skip_stop_anim, player_unit, from_action_input)
        local gameplay_time = mod.time_manager:time("gameplay")
        mod:execute_extension(player_unit, "sight_system", "on_aim_stop", gameplay_time)
    end

    if not instance._stop then instance._stop = instance.stop end
    instance.stop = function(alternate_fire_component, peeking_component, first_person_extension, weapon_tweak_templates_component,
            animation_extension, weapon_template, skip_stop_anim, player_unit, from_action_input)
        instance._stop(alternate_fire_component, peeking_component, first_person_extension, weapon_tweak_templates_component,
            animation_extension, weapon_template, skip_stop_anim, player_unit, from_action_input)
        local gameplay_time = mod.time_manager:time("gameplay")
        mod:execute_extension(player_unit, "sight_system", "on_aim_stop", gameplay_time)
    end

end)





-- ##### ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌  ┬─┐┌─┐┌┐┌┌─┐┌─┐┌┬┐  ┬ ┬┬┌─┐┬  ┌┬┐ ##########################################################
-- ##### ├─┤│   │ ││ ││││  ├┬┘├─┤││││ ┬├┤  ││  ││││├┤ │   ││ ##########################################################
-- ##### ┴ ┴└─┘ ┴ ┴└─┘┘└┘  ┴└─┴ ┴┘└┘└─┘└─┘─┴┘  └┴┘┴└─┘┴─┘─┴┘ ##########################################################

mod:hook(CLASS.ActionRangedWield, "start", function(func, self, action_settings, t, time_scale, action_start_params, ...)
    -- Sights
    mod:execute_extension(self._player_unit, "sight_system", "on_ranged_wield")
    -- Laser pointer
    mod:execute_extension(self._player_unit, "laser_pointer_system", "set_lock", false, self._action_settings.total_time)
    -- Finish event
    self.finish = function(self, reason, data, t, time_in_action)
        self.super.finish(self, reason, data, t, time_in_action)
        -- Laser pointer
        mod:execute_extension(self._player_unit, "laser_pointer_system", "set_lock", nil, self._action_settings.total_time)
    end
    -- Original function
    func(self, action_settings, t, time_scale, action_start_params, ...)
end)

-- ##### ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌  ┌─┐┬┌┬┐ ####################################################################################
-- ##### ├─┤│   │ ││ ││││  ├─┤││││ ####################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴└─┘┘└┘  ┴ ┴┴┴ ┴ ####################################################################################

mod:hook(CLASS.ActionAim, "start", function(func, self, action_settings, t, ...)
    -- Sights
    mod:execute_extension(self._player_unit, "sight_system", "on_aim_start", t)
    -- Finish event
    self.finish = function(self, reason, data, t, time_in_action)
        self.super.finish(self, reason, data, t, time_in_action)
        -- Sights
        mod:execute_extension(self._player_unit, "sight_system", "on_aim_finish")
    end
    -- Original function
    func(self, action_settings, t, ...)
end)

-- ##### ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌┐┌┌─┐┬┌┬┐ ##############################################################################
-- ##### ├─┤│   │ ││ ││││  │ ││││├─┤││││ ##############################################################################
-- ##### ┴ ┴└─┘ ┴ ┴└─┘┘└┘  └─┘┘└┘┴ ┴┴┴ ┴ ##############################################################################

mod:hook(CLASS.ActionUnaim, "start", function(func, self, action_settings, t, ...)
    -- Sights
    mod:execute_extension(self._player_unit, "sight_system", "on_unaim_start", t)
    -- Original function
    func(self, action_settings, t, ...)
end)

mod:hook(CLASS.ActionUnaim, "finish", function(func, self, reason, data, t, time_in_action, ...)
    -- Sights
    mod:execute_extension(self._player_unit, "sight_system", "on_unaim_finish")
    -- Original function
    func(self, reason, data, t, time_in_action, ...)
end)

-- ##### ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌  ┌─┐┬ ┬┌─┐┬─┐┌─┐┌─┐  ┌─┐┬  ┬┌─┐┬─┐┬  ┌─┐┌─┐┌┬┐ ##############################################
-- ##### ├─┤│   │ ││ ││││  │  ├─┤├─┤├┬┘│ ┬├┤   │ │└┐┌┘├┤ ├┬┘│  │ │├─┤ ││ ##############################################
-- ##### ┴ ┴└─┘ ┴ ┴└─┘┘└┘  └─┘┴ ┴┴ ┴┴└─└─┘└─┘  └─┘ └┘ └─┘┴└─┴─┘└─┘┴ ┴─┴┘ ##############################################

mod:hook(CLASS.ActionOverloadCharge, "start", function(func, self, action_settings, t, time_scale, action_start_params, ...)
    -- Sights
    mod:execute_extension(self._player_unit, "sight_system", "on_aim_start", t)
    -- Original function
    func(self, action_settings, t, time_scale, action_start_params, ...)
end)

mod:hook(CLASS.ActionOverloadCharge, "finish", function(func, self, reason, data, t, time_in_action, ...)
    -- Original function
    func(self, reason, data, t, time_in_action, ...)
    -- Sights
    mod:execute_extension(self._player_unit, "sight_system", "on_aim_stop", t)
end)

-- ##### ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌  ┬  ┬┌─┐┌┐┌┌┬┐  ┌─┐┬  ┬┌─┐┬─┐┬ ┬┌─┐┌─┐┌┬┐ ###################################################
-- ##### ├─┤│   │ ││ ││││  └┐┌┘├┤ │││ │   │ │└┐┌┘├┤ ├┬┘├─┤├┤ ├─┤ │  ###################################################
-- ##### ┴ ┴└─┘ ┴ ┴└─┘┘└┘   └┘ └─┘┘└┘ ┴   └─┘ └┘ └─┘┴└─┴ ┴└─┘┴ ┴ ┴  ###################################################

mod:hook(CLASS.ActionVentOverheat, "start", function(func, self, action_settings, t, time_scale, action_start_params, ...)
    mod:execute_extension(self._player_unit, "laser_pointer_system", "set_lock", false, self._action_settings.total_time)
    func(self, action_settings, t, time_scale, action_start_params, ...)
end)

mod:hook(CLASS.ActionVentOverheat, "finish", function(func, self, reason, data, t, time_in_action, ...)
    mod:execute_extension(self._player_unit, "laser_pointer_system", "set_lock", nil, self._action_settings.total_time)
    func(self, reason, data, t, time_in_action, ...)
end)

-- ##### ┬─┐┌─┐┬  ┌─┐┌─┐┌┬┐  ┌─┐┬ ┬┌─┐┌┬┐┌─┐┬ ┬┌┐┌ ####################################################################
-- ##### ├┬┘├┤ │  │ │├─┤ ││  └─┐├─┤│ │ │ │ ┬│ ││││ ####################################################################
-- ##### ┴└─└─┘┴─┘└─┘┴ ┴─┴┘  └─┘┴ ┴└─┘ ┴ └─┘└─┘┘└┘ ####################################################################

mod:hook(CLASS.ActionReloadShotgun, "start", function(func, self, action_settings, t, time_scale, ...)
    mod:execute_extension(self._player_unit, "laser_pointer_system", "set_lock", false, self._action_settings.total_time)
    func(self, action_settings, t, time_scale, ...)
end)

mod:hook(CLASS.ActionReloadShotgun, "finish", function(func, self, reason, data, t, time_in_action, ...)
    mod:execute_extension(self._player_unit, "laser_pointer_system", "set_lock", nil, self._action_settings.total_time)
    func(self, reason, data, t, time_in_action, ...)
end)

-- ##### ┬─┐┌─┐┬  ┌─┐┌─┐┌┬┐  ┌─┐┌┬┐┌─┐┌┬┐┌─┐ ##########################################################################
-- ##### ├┬┘├┤ │  │ │├─┤ ││  └─┐ │ ├─┤ │ ├┤  ##########################################################################
-- ##### ┴└─└─┘┴─┘└─┘┴ ┴─┴┘  └─┘ ┴ ┴ ┴ ┴ └─┘ ##########################################################################

mod:hook(CLASS.ActionReloadState, "start", function(func, self, action_settings, t, time_scale, ...)
    mod:execute_extension(self._player_unit, "laser_pointer_system", "set_lock", false, self._action_settings.total_time)
    func(self, action_settings, t, time_scale, ...)
end)

mod:hook(CLASS.ActionReloadState, "finish", function(func, self, reason, data, t, time_in_action, ...)
    mod:execute_extension(self._player_unit, "laser_pointer_system", "set_lock", nil, self._action_settings.total_time)
    func(self, reason, data, t, time_in_action, ...)
end)

-- ##### ┬┌┐┌┌─┐┌─┐┌─┐┌─┐┌┬┐ ##########################################################################################
-- ##### ││││└─┐├─┘├┤ │   │  ##########################################################################################
-- ##### ┴┘└┘└─┘┴  └─┘└─┘ ┴  ##########################################################################################

mod:hook(CLASS.ActionInspect, "start", function(func, self, action_settings, ...)
    mod:execute_extension(self._player_unit, "laser_pointer_system", "set_lock", false, self._action_settings.total_time)
    func(self, action_settings, ...)
end)

mod:hook(CLASS.ActionInspect, "finish", function(func, self, reason, data, t, time_in_action, ...)
    mod:execute_extension(self._player_unit, "laser_pointer_system", "set_lock", nil, self._action_settings.total_time)
    func(self, reason, data, t, time_in_action, ...)
end)






-- ##### ┌─┐┬  ┌─┐┬ ┬┌─┐┬─┐  ┬ ┬┌┐┌┬┌┬┐  ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ###############################
-- ##### ├─┘│  ├─┤└┬┘├┤ ├┬┘  │ │││││ │   │││├┤ ├─┤├─┘│ ││││  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ###############################
-- ##### ┴  ┴─┘┴ ┴ ┴ └─┘┴└─  └─┘┘└┘┴ ┴   └┴┘└─┘┴ ┴┴  └─┘┘└┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ###############################

-- mod:hook(CLASS.PlayerUnitWeaponExtension, "extensions_ready", function(func, self, world, unit, ...)
--     -- Original function
--     func(self, world, unit, ...)
--     -- Extensions
--     if not script_unit_has_extension(self._unit, "sight_system") then
--         self.sights_extension = script_unit_add_extension({
--             world = self._world,
--         }, self._unit, "SightExtension", "sight_system", {
--             player = self._player,
--             is_local_unit = self._is_local_unit,
--         })
--     end
-- end)

-- mod:hook(CLASS.PlayerUnitWeaponExtension, "update", function(func, self, unit, dt, t, ...)
--     -- Original function
--     func(self, unit, dt, t, ...)
--     -- Extensions
--     mod:execute_extension(self._unit, "sight_system", "update", unit, dt, t)
-- end)

mod:hook(CLASS.PlayerUnitWeaponExtension, "recoil_template", function(func, self, ...)
    local recoil_template = func(self, ...)
    -- Sights sniper template
    if script_unit_has_extension(self._unit, "sight_system") then
        local sight_extension = script_unit_extension(self._unit, "sight_system")
        recoil_template = sight_extension:get_sniper_recoil_template(recoil_template) or recoil_template
    end
    -- Original function
    return recoil_template
end)

mod:hook(CLASS.PlayerUnitWeaponExtension, "sway_template", function(func, self, ...)
    local sway_template = func(self, ...)
    -- Sights sniper template
    if script_unit_has_extension(self._unit, "sight_system") then
        local sight_extension = script_unit_extension(self._unit, "sight_system")
        sway_template = sight_extension:get_sniper_sway_template(sway_template) or sway_template
    end
    -- Original function
    return sway_template
end)

-- mod:hook(CLASS.PlayerUnitWeaponExtension, "on_wieldable_slot_equipped", function(func, self, item, slot_name, weapon_unit, fx_sources,
--         t, optional_existing_unit_3p, from_server_correction_occurred, ...)
--     -- Original function
--     func(self, item, slot_name, weapon_unit, fx_sources, t, optional_existing_unit_3p, from_server_correction_occurred, ...)
--     -- Extensions
--     if slot_name == SLOT_SECONDARY then
--         mod:execute_extension(self._unit, "sight_system", "on_weapon_equipped")
--     end
-- end)

-- mod:hook(CLASS.PlayerUnitWeaponExtension, "on_wieldable_slot_unequipped", function(func, self, slot_name, from_server_correction_occurred, ...)
--     -- Extensions
--     if slot_name == SLOT_SECONDARY then
--         mod:execute_extension(self._unit, "sight_system", "on_weapon_unequipped")
--     end
--     -- Original function
--     func(self, slot_name, from_server_correction_occurred, ...)
-- end)






-- ##### ┌─┐┬  ┌─┐┬ ┬┌─┐┬─┐  ┬ ┬┌┐┌┬┌┬┐  ┌─┐┬┬─┐┌─┐┌┬┐  ┌─┐┌─┐┬─┐┌─┐┌─┐┌┐┌  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ################
-- ##### ├─┘│  ├─┤└┬┘├┤ ├┬┘  │ │││││ │   ├┤ │├┬┘└─┐ │   ├─┘├┤ ├┬┘└─┐│ ││││  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ################
-- ##### ┴  ┴─┘┴ ┴ ┴ └─┘┴└─  └─┘┘└┘┴ ┴   └  ┴┴└─└─┘ ┴   ┴  └─┘┴└─└─┘└─┘┘└┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ################

mod:hook(CLASS.PlayerUnitFirstPersonExtension, "extensions_ready", function(func, self, world, unit, ...)
    -- Original function
    func(self, world, unit, ...)
    -- Crouch
    if not script_unit_has_extension(self._unit, "crouch_system") then
        self.crouch_animation_extension = script_unit_add_extension({
            world = self._world,
        }, self._unit, "CrouchAnimationExtension", "crouch_system", {
            player_unit = self._unit,
            is_local_unit = self._is_local_unit,
        })
    end
end)

-- mod:hook(CLASS.PlayerUnitFirstPersonExtension, "fixed_update", function(func, self, unit, dt, t, frame, ...)
--     -- if not mod.test546584694856 then 
--     --     mod:echo("sway no sights_extension: "..tostring(unit))
--     --     mod.test546584694856 = true
--     -- end
--     -- Recoil.first_person_offset(unit)
--     mod:recoil_sway_set_temp_player_unit(self._unit)
--     -- Original function
--     func(self, unit, dt, t, frame, ...)
-- end)

mod:hook(CLASS.PlayerUnitFirstPersonExtension, "destroy", function(func, self, ...)
    -- Crouch
    mod:remove_extension(self._unit, "crouch_system")
    -- Original function
	func(self, ...)
end)

mod:hook(CLASS.PlayerUnitFirstPersonExtension, "update_unit_position", function(func, self, unit, dt, t, ...)
    -- Original function
    func(self, unit, dt, t, ...)
    -- -- movement_state_component to unit
    -- mod:persistent_table(REFERENCE).references[self._movement_state_component] = self._unit
    -- if not mod.test76543574 then
    --     mod:echo(tostring(self._movement_state_component).." = "..tostring(self._unit))
    --     mod.test76543574 = true
    -- end
    -- Sights
    mod:execute_extension(unit, "sight_system", "update_position_and_rotation", self)
    -- Crouch
    mod:execute_extension(unit, "crouch_system", "update")
end)






-- ##### ┌─┐┬  ┌─┐┬ ┬┌─┐┬─┐  ┬ ┬┬ ┬┌─┐┬┌─  ┌─┐┬┬─┐┌─┐┌┬┐  ┌─┐┌─┐┬─┐┌─┐┌─┐┌┐┌  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##############
-- ##### ├─┘│  ├─┤└┬┘├┤ ├┬┘  ├─┤│ │└─┐├┴┐  ├┤ │├┬┘└─┐ │   ├─┘├┤ ├┬┘└─┐│ ││││  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##############
-- ##### ┴  ┴─┘┴ ┴ ┴ └─┘┴└─  ┴ ┴└─┘└─┘┴ ┴  └  ┴┴└─└─┘ ┴   ┴  └─┘┴└─└─┘└─┘┘└┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##############

mod:hook(CLASS.PlayerHuskFirstPersonExtension, "extensions_ready", function(func, self, world, unit, ...)
    -- Original function
    func(self, world, unit, ...)
    -- Crouch
    if not script_unit_has_extension(self._unit, "crouch_system") then
        self.crouch_animation_extension = script_unit_add_extension({
            world = self._world,
        }, self._unit, "CrouchAnimationExtension", "crouch_system", {
            player_unit = self._unit,
            is_local_unit = self._is_local_unit,
        })
    end
end)

mod:hook(CLASS.PlayerHuskFirstPersonExtension, "destroy", function(func, self, ...)
    -- Crouch
    mod:remove_extension(self._unit, "crouch_system")
    -- Original function
	func(self, ...)
end)

mod:hook(CLASS.PlayerHuskFirstPersonExtension, "update_unit_position_and_rotation", function(func, self, position_3p_unit, force_update_unit_and_children, ...)
    -- Original function
    func(self, position_3p_unit, force_update_unit_and_children, ...)
    -- -- movement_state_component to unit
    -- local unit_data_extension = script_unit_extension(self._unit, "unit_data_system")
    -- local movement_state_component = unit_data_extension:read_component("movement_state")
    -- mod:persistent_table(REFERENCE).references[movement_state_component] = self._unit
    -- if not mod.test3274625346 then
    --     mod:echo(tostring(movement_state_component).." = "..tostring(self._unit))
    --     mod.test3274625346 = true
    -- end
    -- local unit_data_extension = script_unit_extension(self._unit, "unit_data_system")
	-- local movement_state_component = unit_data_extension:read_component("movement_state")
    -- mod.movement_state_component_to_unit[movement_state_component] = self._unit
    -- Sights
    mod:execute_extension(self._unit, "sight_system", "update_position_and_rotation", self)
    mod:execute_extension(self._unit, "sight_system", "set_spectated", self._is_first_person_spectated)
    -- Crouch
    mod:execute_extension(self._unit, "crouch_system", "update")
    -- Flashlight / laser pointer
    -- managers.event:trigger("weapon_customization_spectating", self._unit, self._is_first_person_spectated)
    mod:execute_extension(self._unit, "flashlight_system", "set_spectated", self._is_first_person_spectated)
    -- mod:execute_extension(self._unit, "laser_pointer_system", "set_spectated", self._is_first_person_spectated)
end)






-- ##### ┌─┐┌─┐┌┬┐┌─┐┬─┐┌─┐  ┌┬┐┌─┐┌┐┌┌─┐┌─┐┌─┐┬─┐ ####################################################################
-- ##### │  ├─┤│││├┤ ├┬┘├─┤  │││├─┤│││├─┤│ ┬├┤ ├┬┘ ####################################################################
-- ##### └─┘┴ ┴┴ ┴└─┘┴└─┴ ┴  ┴ ┴┴ ┴┘└┘┴ ┴└─┘└─┘┴└─ ####################################################################

mod:hook(CLASS.CameraManager, "post_update", function(func, self, dt, t, viewport_name, ...)
    -- Original function
    func(self, dt, t, viewport_name, ...)
    -- Extensions
    -- local player = mod:player_from_viewport(viewport_name)
    -- if player and player.player_unit then
    -- mod:execute_extension(player.player_unit, "sight_system", "update_zoom", viewport_name)
    -- end
    managers.event:trigger("weapon_customization_update_zoom", viewport_name)
end)






-- ##### ┌─┐┬  ┌─┐┬ ┬┌─┐┬─┐  ┬ ┬┌┐┌┬┌┬┐  ┬  ┬┬┌─┐┬ ┬┌─┐┬    ┬  ┌─┐┌─┐┌┬┐┌─┐┬ ┬┌┬┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ #########
-- ##### ├─┘│  ├─┤└┬┘├┤ ├┬┘  │ │││││ │   └┐┌┘│└─┐│ │├─┤│    │  │ │├─┤ │││ ││ │ │   ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ #########
-- ##### ┴  ┴─┘┴ ┴ ┴ └─┘┴└─  └─┘┘└┘┴ ┴    └┘ ┴└─┘└─┘┴ ┴┴─┘  ┴─┘└─┘┴ ┴─┴┘└─┘└─┘ ┴   └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ #########

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "extensions_ready", function(func, self, world, unit, ...)
    -- Original function
    func(self, world, unit, ...)
    -- Mod
    mod:player_unit_loaded()
end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "_equip_item_to_slot", function(func, self, item, slot_name, t, optional_existing_unit_3p, from_server_correction_occurred, ...)
    -- Original function
    func(self, item, slot_name, t, optional_existing_unit_3p, from_server_correction_occurred, ...)
    if slot_name == SLOT_SECONDARY then
        -- Sights
        mod:remove_extension(self._unit, "sight_system")
        -- Flashlights
        mod:remove_extension(self._unit, "flashlight_system")
    end
end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "_unequip_item_from_slot", function(func, self, slot_name, from_server_correction_occurred, fixed_frame, from_destroy, ...)
    if slot_name == SLOT_SECONDARY then
        -- Sights
        mod:remove_extension(self._unit, "sight_system")
        -- Flashlights
        mod:remove_extension(self._unit, "flashlight_system")
    end
    -- Original function
    func(self, slot_name, from_server_correction_occurred, fixed_frame, from_destroy, ...)
end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "destroy", function(func, self, ...)
    -- Mod
    mod:player_unit_destroyed(self._unit)
    -- Visible equipment
    mod:remove_extension(self._unit, "visible_equipment_system")
    -- Sights
    mod:remove_extension(self._unit, "sight_system")
    -- Flashlights
    mod:remove_extension(self._unit, "flashlight_system")
    -- Original function
    func(self, ...)
end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "update", function(func, self, unit, dt, t, ...)
    -- Original function
    func(self, unit, dt, t, ...)
    -- Visible equipment
    local visible_equipment_system = script_unit_has_extension(self._unit, "visible_equipment_system")
    if not visible_equipment_system and mod:get(OPTION_VISIBLE_EQUIPMENT) then
        script_unit_add_extension({
            world = self._equipment_component._world,
        }, self._unit, "VisibleEquipmentExtension", "visible_equipment_system", {
            player_unit = self._unit,
            profile = self._player:profile(),
            is_local_unit = self._is_local_unit,
            equipment_component = self._equipment_component,
            equipment = self._equipment,
            wielded_slot = self._equipment[self._inventory_component.wielded_slot],
        })
    elseif visible_equipment_system and not mod:get(OPTION_VISIBLE_EQUIPMENT) then
        mod:remove_extension(self._unit, "visible_equipment_system")
    elseif visible_equipment_system and mod:get(OPTION_VISIBLE_EQUIPMENT) then
        mod:execute_extension(self._unit, "visible_equipment_system", "load_slots")
        mod:execute_extension(self._unit, "visible_equipment_system", "update", dt, t)
    end
    -- Sights
    if not script_unit_has_extension(self._unit, "sight_system") and self._weapon_extension._weapons[SLOT_SECONDARY] then
        script_unit_add_extension({
            world = self._equipment_component._world,
        }, self._unit, "SightExtension", "sight_system", {
            player = self._player,
            player_unit = self._player.player_unit,
            is_local_unit = self._is_local_unit,
            ranged_weapon = table_merge_recursive(self._weapon_extension._weapons[SLOT_SECONDARY],
                {attachment_units = self._equipment[SLOT_SECONDARY].attachments_1p})
            -- ranged_weapon = self._weapon_extension._weapons[SLOT_SECONDARY],
            -- ranged_weapon = self._equipment[SLOT_SECONDARY],
        })
    else
        mod:execute_extension(self._unit, "sight_system", "update", unit, dt, t)
    end
    -- Flashlights
    local slot = self._equipment[SLOT_SECONDARY]
    if not script_unit_has_extension(self._unit, "flashlight_system") and slot then
        local flashlight_unit_1p = mod:get_attachment_slot_in_attachments(slot.attachments_1p, "flashlight")
        local flashlight_unit_3p = mod:get_attachment_slot_in_attachments(slot.attachments_3p, "flashlight")
        local inventory_component = self._inventory_component
	    local wielded_slot_name = inventory_component and inventory_component.wielded_slot
        if flashlight_unit_1p and flashlight_unit_3p then
            script_unit_add_extension({
                world = self._equipment_component._world,
            }, self._unit, "FlashlightExtension", "flashlight_system", {
                player = self._player,
                player_unit = self._unit,
                is_local_unit = self._is_local_unit,
                flashlight_unit_1p = flashlight_unit_1p,
                flashlight_unit_3p = flashlight_unit_3p,
                wielded_slot = wielded_slot_name and self._equipment[wielded_slot_name],
            })
        end
    else
        mod:execute_extension(self._unit, "flashlight_system", "update", dt, t)
    end

    -- local unit_data_extension = script_unit.has_extension(self._unit, "unit_data_system")
    -- local alternate_fire_component = unit_data_extension and unit_data_extension:read_component("alternate_fire")
    -- if alternate_fire_component and alternate_fire_component.is_active then
    --     mod:execute_extension(self._unit, "sight_system", "set_aiming", true, t)
    -- elseif alternate_fire_component and not alternate_fire_component.is_active then
    --     mod:execute_extension(self._unit, "sight_system", "set_aiming", false, t)
    -- end

    -- local unit_data_extension = script_unit.has_extension(self._unit, "unit_data_system")
    -- local character_state_component = unit_data_extension and unit_data_extension:read_component("character_state")
    -- if character_state_component then
    --     if not mod.test8437589437593 then
    --         mod:dtf(character_state_component, "character_state_component", 5)
    --         mod.test8437589437593 = true
    --     end
    --     -- if character_state_component.is_aiming then
    --     --     mod:echot("aiming")
    --     --     mod:execute_extension(self._unit, "sight_system", "set_aiming", true, t)
    --     -- else
    --     --     mod:execute_extension(self._unit, "sight_system", "set_aiming", false, t)
    --     -- end
    -- end
end)






-- ##### ┌─┐┬  ┌─┐┬ ┬┌─┐┬─┐  ┬ ┬┌┐┌┬┌┬┐  ┌─┐─┐ ┬  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##########################################
-- ##### ├─┘│  ├─┤└┬┘├┤ ├┬┘  │ │││││ │   ├┤ ┌┴┬┘  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##########################################
-- ##### ┴  ┴─┘┴ ┴ ┴ └─┘┴└─  └─┘┘└┘┴ ┴   └  ┴ └─  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##########################################

mod:hook(CLASS.PlayerUnitFxExtension, "_create_particles_wrapper", function(func, self, world, particle_name, position, rotation, scale, ...)
    -- Original function
    local effect_id = func(self, world, particle_name, position, rotation, scale, ...)
    -- Laser pointer
    mod:execute_extension(self._unit, "laser_pointer_system", "particles_wrapper_created", particle_name, effect_id)
    -- Return value
    return effect_id
end)






-- ##### ┌─┐┬  ┌─┐┬ ┬┌─┐┬─┐  ┬ ┬┬ ┬┌─┐┬┌─  ┬  ┬┬┌─┐┬ ┬┌─┐┬    ┬  ┌─┐┌─┐┌┬┐┌─┐┬ ┬┌┬┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ #######
-- ##### ├─┘│  ├─┤└┬┘├┤ ├┬┘  ├─┤│ │└─┐├┴┐  └┐┌┘│└─┐│ │├─┤│    │  │ │├─┤ │││ ││ │ │   ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ #######
-- ##### ┴  ┴─┘┴ ┴ ┴ └─┘┴└─  ┴ ┴└─┘└─┘┴ ┴   └┘ ┴└─┘└─┘┴ ┴┴─┘  ┴─┘└─┘┴ ┴─┴┘└─┘└─┘ ┴   └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ #######

mod:hook(CLASS.PlayerHuskVisualLoadoutExtension, "extensions_ready", function(func, self, world, unit, ...)
    -- Original function
    func(self, world, unit, ...)
    -- Wielded slot function
    self.current_wielded_slot = function(self)
        return self._equipment[self._wielded_slot]
    end
    -- Mod
    mod:husk_unit_loaded()
end)

mod:hook(CLASS.PlayerHuskVisualLoadoutExtension, "_equip_item_to_slot", function(func, self, slot_name, item, optional_existing_unit_3p, ...)
    -- Original function
    func(self, slot_name, item, optional_existing_unit_3p, ...)
    if slot_name == SLOT_SECONDARY then
        -- Sights
        mod:remove_extension(self._unit, "sight_system")
        -- Flashlights
        mod:remove_extension(self._unit, "flashlight_system")
    end
end)

mod:hook(CLASS.PlayerHuskVisualLoadoutExtension, "wield_slot", function(func, self, slot_name, ...)
    -- Original function
    func(self, slot_name, ...)

    local wielded_slot = self:current_wielded_slot()
    if wielded_slot then
        -- mod:echo("husk wield "..tostring(wielded_slot.name).." - "..tostring(wielded_slot))
        -- Flashlights
        mod:execute_extension(self._unit, "flashlight_system", "on_wield_slot", wielded_slot)
        -- Laser pointer
        -- mod:execute_extension(self._unit, "laser_pointer_system", "on_wield_slot", wielded_slot)
    end
end)

mod:hook(CLASS.PlayerHuskVisualLoadoutExtension, "unwield_slot", function(func, self, slot_name, ...)
    -- local wielded_slot = self:current_wielded_slot()
    local slot = self._equipment[slot_name]
    if slot then
        -- mod:echo("husk UNwield "..tostring(slot.name).." - "..tostring(slot))
        -- Visible equipment
        mod:execute_extension(self._unit, "visible_equipment_system", "on_unwield_slot", slot)
        -- Flashlights
        mod:execute_extension(self._unit, "flashlight_system", "on_unwield_slot", slot)
        -- Laser pointer
        -- mod:execute_extension(self._unit, "laser_pointer_system", "on_unwield_slot", slot)
    end
    -- Original function
    func(self, slot_name, ...)
end)

mod:hook(CLASS.PlayerHuskVisualLoadoutExtension, "rpc_player_unequip_item_from_slot", function(func, self, channel_id, go_id, slot_id, ...)
    local slot_name = NetworkLookup.player_inventory_slot_names[slot_id]
    if slot_name == SLOT_SECONDARY then
        -- Sights
        mod:remove_extension(self._unit, "sight_system")
        -- Flashlights
        mod:remove_extension(self._unit, "flashlight_system")
    end
    -- Original function
    func(self, channel_id, go_id, slot_id, ...)
end)

mod:hook(CLASS.PlayerHuskVisualLoadoutExtension, "destroy", function(func, self, ...)
    -- Visible equipment
    mod:remove_extension(self._unit, "visible_equipment_system")
    -- Sights
    mod:remove_extension(self._unit, "sight_system")
    -- Flashlights
    mod:remove_extension(self._unit, "flashlight_system")
    -- Original function
    func(self, ...)
end)

mod:hook(CLASS.PlayerHuskVisualLoadoutExtension, "update", function(func, self, unit, dt, t, ...)
    -- Original function
    func(self, unit, dt, t, ...)
    -- Visible equipment
    local visible_equipment_system = script_unit_has_extension(self._unit, "visible_equipment_system")
    if not visible_equipment_system and mod:get(OPTION_VISIBLE_EQUIPMENT) then
        script_unit_add_extension({
            world = self._equipment_component._world,
        }, self._unit, "VisibleEquipmentExtension", "visible_equipment_system", {
            player_unit = self._unit,
            profile = self._player:profile(),
            is_local_unit = self._is_local_unit,
            equipment_component = self._equipment_component,
            equipment = self._equipment,
            wielded_slot = self._equipment[self._wielded_slot],
        })
    elseif visible_equipment_system and not mod:get(OPTION_VISIBLE_EQUIPMENT) then
        mod:remove_extension(self._unit, "visible_equipment_system")
    elseif visible_equipment_system and mod:get(OPTION_VISIBLE_EQUIPMENT) then
        mod:execute_extension(self._unit, "visible_equipment_system", "load_slots")
        mod:execute_extension(self._unit, "visible_equipment_system", "update", dt, t)
    end
    -- Sights
    if not script_unit_has_extension(self._unit, "sight_system") then
        local slot = self._equipment[SLOT_SECONDARY]
        if slot then
            local weapon_template = WeaponTemplate.weapon_template_from_item(slot.item)
            if weapon_template then
                script_unit_add_extension({
                    world = self._equipment_component._world,
                }, self._unit, "SightExtension", "sight_system", {
                    player = self._player,
                    player_unit = self._player.player_unit,
                    is_local_unit = self._is_local_unit,
                    ranged_weapon = table_merge_recursive(slot, {weapon_template = weapon_template, weapon_unit = slot.unit_1p, attachment_units = slot.attachments_1p}
                    ),
                })
            end
        end
    else
        mod:execute_extension(self._unit, "sight_system", "update", unit, dt, t)
    end
    -- Flashlights
    local slot = self._equipment[SLOT_SECONDARY]
    if not script_unit_has_extension(self._unit, "flashlight_system") and slot then
        local flashlight_unit_1p = mod:get_attachment_slot_in_attachments(slot.attachments_1p, "flashlight")
        local flashlight_unit_3p = mod:get_attachment_slot_in_attachments(slot.attachments_3p, "flashlight")
        if flashlight_unit_1p and flashlight_unit_3p then
            -- mod:echo("husk create "..tostring(self._wielded_slot).." - "..tostring(slot))
            script_unit_add_extension({
                world = self._equipment_component._world,
            }, self._unit, "FlashlightExtension", "flashlight_system", {
                player = self._player,
                player_unit = self._unit,
                is_local_unit = self._is_local_unit,
                flashlight_unit_1p = flashlight_unit_1p,
                flashlight_unit_3p = flashlight_unit_3p,
                wielded_slot = self._equipment[self._wielded_slot],
            })
        end
    else
        mod:execute_extension(self._unit, "flashlight_system", "update", dt, t)
    end

    local unit_data_extension = script_unit.has_extension(self._unit, "unit_data_system")
    local alternate_fire_component = unit_data_extension and unit_data_extension:read_component("alternate_fire")
    if alternate_fire_component and alternate_fire_component.is_active then
        mod:execute_extension(self._unit, "sight_system", "set_aiming", true, t)
    elseif alternate_fire_component and not alternate_fire_component.is_active then
        mod:execute_extension(self._unit, "sight_system", "set_aiming", false, t)
    end

    -- local unit_data_extension = script_unit.has_extension(self._unit, "unit_data_system")
    -- local character_state_component = unit_data_extension and unit_data_extension:read_component("character_state")
    -- if character_state_component then
    --     if character_state_component.is_aiming then
    --         mod:echot("aiming")
    --         mod:execute_extension(self._unit, "sight_system", "set_aiming", true, t)
    --     else
    --         mod:execute_extension(self._unit, "sight_system", "set_aiming", false, t)
    --     end
    -- end
end)






-- ##### ┌─┐┌─┐ ┬ ┬┬┌─┐┌┬┐┌─┐┌┐┌┌┬┐  ┌─┐┌─┐┌┬┐┌─┐┌─┐┌┐┌┌─┐┌┐┌┌┬┐ ######################################################
-- ##### ├┤ │─┼┐│ ││├─┘│││├┤ │││ │   │  │ ││││├─┘│ ││││├┤ │││ │  ######################################################
-- ##### └─┘└─┘└└─┘┴┴  ┴ ┴└─┘┘└┘ ┴   └─┘└─┘┴ ┴┴  └─┘┘└┘└─┘┘└┘ ┴  ######################################################

mod:hook(CLASS.EquipmentComponent, "wield_slot", function(func, slot, first_person_mode, ...)
    -- Original function
    func(slot, first_person_mode, ...)
    if slot.name then
        -- mod:echo("wield "..tostring(slot.name).." - "..tostring(slot))
        -- Visible equipment
        mod:execute_extension(slot.parent_unit_3p, "visible_equipment_system", "on_wield_slot", slot)
        -- Flashlights
        mod:execute_extension(slot.parent_unit_3p, "flashlight_system", "on_wield_slot", slot)
        -- Laser pointer
        -- mod:execute_extension(slot.parent_unit_3p, "laser_pointer_system", "on_wield_slot", slot)
    end
end)

mod:hook(CLASS.EquipmentComponent, "unwield_slot", function(func, slot, first_person_mode, ...)
    if slot.name then
        -- mod:echo("UNwield "..tostring(slot.name).." - "..tostring(slot))
        -- Visible equipment
        mod:execute_extension(slot.parent_unit_3p, "visible_equipment_system", "on_unwield_slot", slot)
        -- Flashlights
        mod:execute_extension(slot.parent_unit_3p, "flashlight_system", "on_unwield_slot", slot)
        -- Laser pointer
        -- mod:execute_extension(slot.parent_unit_3p, "laser_pointer_system", "on_unwield_slot", slot)
    end
    -- Original function
    func(slot, first_person_mode, ...)
end)

mod:hook(CLASS.EquipmentComponent, "equip_item", function(func, self, unit_3p, unit_1p, slot, item, optional_existing_unit_3p,
        deform_overrides, optional_breed_name, optional_mission_template, ...)
    -- Original function
    func(self, unit_3p, unit_1p, slot, item, optional_existing_unit_3p, deform_overrides, optional_breed_name, optional_mission_template, ...)
    -- Flashlights
    -- mod:remove_extension(unit_3p, "flashlight_system")
    mod:execute_extension(unit_3p, "flashlight_system", "on_equip_slot", slot)
    -- Visible equipment
    if slot.name == "slot_gear_extra_cosmetic" then
        mod:execute_extension(unit_3p, "visible_equipment_system", "position_equipment")
    end
end)

mod:hook(CLASS.EquipmentComponent, "unequip_item", function(func, self, slot, ...)
    -- Visible equipment
    mod:execute_extension(slot.parent_unit_3p, "visible_equipment_system", "on_unequip_slot", slot)
    -- Original function
    func(self, slot, ...)
end)

mod:hook(CLASS.EquipmentComponent, "update_item_visibility", function(func, equipment, wielded_slot, unit_3p, unit_1p, first_person_mode, ...)
    -- Original function
    func(equipment, wielded_slot, unit_3p, unit_1p, first_person_mode, ...)
    -- Visible equipment
    mod:execute_extension(unit_3p, "visible_equipment_system", "on_update_item_visibility", wielded_slot)
end)






-- ##### ┬ ┬┬  ┌─┐┬─┐┌─┐┌─┐┬┬  ┌─┐  ┌─┐┌─┐┌─┐┬ ┬┌┐┌┌─┐┬─┐ #############################################################
-- ##### │ ││  ├─┘├┬┘│ │├┤ ││  ├┤   └─┐├─┘├─┤││││││├┤ ├┬┘ #############################################################
-- ##### └─┘┴  ┴  ┴└─└─┘└  ┴┴─┘└─┘  └─┘┴  ┴ ┴└┴┘┘└┘└─┘┴└─ #############################################################

mod:hook(CLASS.UIProfileSpawner, "ignore_slot", function(func, self, slot_id, ...)
    if slot_id ~= "slot_primary" and slot_id ~= SLOT_SECONDARY then
        -- Original function
        func(self, slot_id, ...)
    end
end)

mod:hook(CLASS.UIProfileSpawner, "cb_on_unit_3p_streaming_complete", function(func, self, unit_3p, ...)
    -- Original function
    func(self, unit_3p, ...)
    -- Visible equipment
    if self._character_spawn_data and not script_unit_has_extension(unit_3p, "visible_equipment_system") and mod:get(OPTION_VISIBLE_EQUIPMENT) and not self.no_spawn then
        -- local spawn_data = self._character_spawn_data
        self.visible_equipment_extension = script_unit_add_extension({
            world = self._world,
        }, unit_3p, "VisibleEquipmentExtension", "visible_equipment_system", {
            profile = self._character_spawn_data.profile,
            is_local_unit = true,
            player_unit = unit_3p,
            equipment_component = self._character_spawn_data.equipment_component,
            equipment = self._character_spawn_data.slots,
            wielded_slot = self._character_spawn_data.wielded_slot,
            ui_profile_spawner = true,
        })
        self._rotation_input_disabled = false
    end
end)

mod:hook(CLASS.UIProfileSpawner, "wield_slot", function(func, self, slot_id, ...)
    func(self, slot_id, ...)

    if self._character_spawn_data then
        local slot = self._character_spawn_data.slots[SLOT_SECONDARY]
        local flashlight = mod:get_attachment_slot_in_attachments(slot.attachments_3p, "flashlight")
        local attachment_name = flashlight and unit_get_data(flashlight, "attachment_name")
        if flashlight and attachment_name and slot_id == SLOT_SECONDARY then
            mod:preview_flashlight(true, self._world, flashlight, attachment_name, true)
        else
            mod:preview_flashlight(false, self._world, flashlight, attachment_name, true)
        end
    end
end)

mod:hook(CLASS.UIProfileSpawner, "update", function(func, self, dt, t, input_service, ...)
    -- Original function
    func(self, dt, t, input_service, ...)
    -- Visible equipment
    if self._character_spawn_data then
        mod:execute_extension(self._character_spawn_data.unit_3p, "visible_equipment_system", "load_slots")
        mod:execute_extension(self._character_spawn_data.unit_3p, "visible_equipment_system", "update", dt, t)
    end
end)

mod:hook(CLASS.UIProfileSpawner, "destroy", function(func, self, ...)
    -- Visible equipment
    if self._character_spawn_data then
        mod:remove_extension(self._character_spawn_data.unit_3p, "visible_equipment_system")
    end
    -- Original function
    func(self, ...)
end)






-- ##### ┬ ┬┬  ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌  ┌─┐┌─┐┌─┐┬ ┬┌┐┌┌─┐┬─┐ ##############################################################
-- ##### │ ││  │││├┤ ├─┤├─┘│ ││││  └─┐├─┘├─┤││││││├┤ ├┬┘ ##############################################################
-- ##### └─┘┴  └┴┘└─┘┴ ┴┴  └─┘┘└┘  └─┘┴  ┴ ┴└┴┘┘└┘└─┘┴└─ ##############################################################

mod:hook(CLASS.UIWeaponSpawner, "cb_on_unit_3p_streaming_complete", function(func, self, item_unit_3p, ...)
	func(self, item_unit_3p, ...)
    if self._weapon_spawn_data then
        mod.weapon_spawning = nil
        self._weapon_spawn_data.streaming_complete = true
	end
end)


mod:hook(CLASS.UIWeaponSpawner, "_despawn_weapon", function(func, self, ...)
    -- Mod
	mod:ui_weapon_spawner_despawn_weapon(self)
    -- Original function
	func(self, ...)
end)






-- ##### ┬ ┬┬ ┬┌┬┐  ┌─┐┬  ┌─┐┌┬┐┌─┐┌┐┌┌┬┐  ┌─┐┬─┐┌─┐┌─┐┌─┐┬ ┬┌─┐┬┬─┐ ##################################################
-- ##### ├─┤│ │ ││  ├┤ │  ├┤ │││├┤ │││ │   │  ├┬┘│ │└─┐└─┐├─┤├─┤│├┬┘ ##################################################
-- ##### ┴ ┴└─┘─┴┘  └─┘┴─┘└─┘┴ ┴└─┘┘└┘ ┴   └─┘┴└─└─┘└─┘└─┘┴ ┴┴ ┴┴┴└─ ##################################################
mod:hook(CLASS.HudElementCrosshair, "_draw_widgets", function(func, self, dt, t, input_service, ui_renderer, render_settings, ...)
    local parent = self._parent
    if parent then
        local player_extensions = parent:player_extensions()
        if player_extensions and player_extensions.unit and self._widget then
            local is_hiding_crosshair = mod:execute_extension(player_extensions.unit, "sight_system", "is_hiding_crosshair")
            
            self._widget.visible = not is_hiding_crosshair
        end
    end
    func(self, dt, t, input_service, ui_renderer, render_settings, ...)
end)






-- ##### ┌┐ ┌─┐┌─┐┌─┐  ┬  ┬┬┌─┐┬ ┬ ####################################################################################
-- ##### ├┴┐├─┤└─┐├┤   └┐┌┘│├┤ │││ ####################################################################################
-- ##### └─┘┴ ┴└─┘└─┘   └┘ ┴└─┘└┴┘ ####################################################################################

mod:hook(CLASS.BaseView, "_on_view_load_complete", function(func, self, loaded, ...)
    -- Original function
    func(self, loaded, ...)
    -- Options
    if self.view_name == "dmf_options_view" then
		mod.update_options()
	end
end)






-- ##### ┌─┐┌─┐┌─┐┌┬┐┌─┐┌┬┐┌─┐┌─┐┌─┐ ##################################################################################
-- ##### ├┤ │ ││ │ │ └─┐ │ ├┤ ├─┘└─┐ ##################################################################################
-- ##### └  └─┘└─┘ ┴ └─┘ ┴ └─┘┴  └─┘ ##################################################################################



local steps = 0
-- Capture footsteps for equipment animation
mod:hook_require("scripts/utilities/footstep", function(instance)
    mod:hook(instance, "trigger_material_footstep", function(func, sound_alias, wwise_world, physics_world, source_id, unit, node, query_from, query_to, optional_set_speed_parameter, optional_set_first_person_parameter, ...)

        mod:execute_extension(unit, "visible_equipment_system", "on_footstep")

        return func(sound_alias, wwise_world, physics_world, source_id, unit, node, query_from,
        query_to, optional_set_speed_parameter, optional_set_first_person_parameter, ...)
    end)
end)






-- ##### ┌┬┐┬┌─┐┌─┐┬┌─┐┌┐┌  ┬┌┐┌┌┬┐┬─┐┌─┐  ┬  ┬┬┌─┐┬ ┬ ################################################################
-- ##### ││││└─┐└─┐││ ││││  ││││ │ ├┬┘│ │  └┐┌┘│├┤ │││ ################################################################
-- ##### ┴ ┴┴└─┘└─┘┴└─┘┘└┘  ┴┘└┘ ┴ ┴└─└─┘   └┘ ┴└─┘└┴┘ ################################################################

-- mod:hook(CLASS.MissionIntroView, "update", function(func, self, dt, t, input_service, ...)
--     -- Original function
--     func(self, dt, t, input_service, ...)
--     -- Iterate slots
--     for i, slot in pairs(self._spawn_slots) do
--         if slot.occupied and not slot.was_processed then
--             local profile_spawner = slot.profile_spawner
--             local spawn_data = profile_spawner and profile_spawner._character_spawn_data
--             local player_unit = spawn_data and spawn_data.unit_3p
--             if player_unit then
--                 mod:echo("process load slot "..tostring(slot.index))
--                 -- Extensions
--                 profile_spawner.no_spawn = true
--                 mod:remove_extension(player_unit, "visible_equipment_system")
--                 self.visible_equipment_extension = script_unit_add_extension({
--                     world = self._world_spawner:world(),
--                 }, slot.spawn_point_unit, "VisibleEquipmentExtension", "visible_equipment_system", {
--                     -- player = mod:player_from_unit(unit_3p),
--                     profile = spawn_data.profile,
--                     player_unit = slot.spawn_point_unit,
--                     equipment_component = spawn_data.equipment_component,
--                     equipment = spawn_data.slots,
--                     loading_spawn_point = slot.index,
--                 })
--                 slot.was_processed = true
--             end
--         elseif not slot.occupied then
--             mod:remove_extension(slot.spawn_point_unit, "visible_equipment_system")
--             slot.was_processed = nil
--         elseif slot.occupied and slot.was_processed then
--             mod:execute_extension(slot.spawn_point_unit, "visible_equipment_system", "load_slots")
--             mod:execute_extension(slot.spawn_point_unit, "visible_equipment_system", "update", dt, t)
--         end
--     end
-- end)

-- mod:hook(CLASS.MissionIntroView, "on_exit", function(func, self, ...)
--     -- Extensions
--     for i, slot in pairs(self._spawn_slots) do
--         if slot.occupied and slot.was_processed then
--             mod:remove_extension(slot.spawn_point_unit, "visible_equipment_system")
--         end
--     end
--     -- Original function
--     func(self, ...)
-- end)

-- mod:hook(CLASS.MissionIntroView, "event_mission_intro_trigger_players_event", function(func, self, animation_event, ...)
--     -- Extensions
--     for i, slot in pairs(self._spawn_slots) do
--         if slot.occupied and slot.was_processed then
--             mod:execute_extension(slot.spawn_point_unit, "visible_equipment_system", "trigger_step", 1, 3)
--         end
--     end
--     -- Original function
--     func(self, animation_event, ...)
-- end)






-- ##### ┌─┐┬ ┬┌┬┐┌─┐┌─┐┌─┐┌┐┌┌─┐  ┬  ┬┬┌─┐┬ ┬ ########################################################################
-- ##### │  │ │ │ └─┐│  ├┤ │││├┤   └┐┌┘│├┤ │││ ########################################################################
-- ##### └─┘└─┘ ┴ └─┘└─┘└─┘┘└┘└─┘   └┘ ┴└─┘└┴┘ ########################################################################

mod:hook(CLASS.CutsceneView, "on_enter", function(func, self, ...)
    func(self, ...)
    managers.event:trigger("weapon_customization_cutscene", true)

    self.on_exit = function(self)
        managers.event:trigger("weapon_customization_cutscene", false)
    end

end)






-- ##### ┌┬┐┌─┐┬┌┐┌  ┌┬┐┌─┐┌┐┌┬ ┬  ┬  ┬┬┌─┐┬ ┬ ########################################################################
-- ##### │││├─┤││││  │││├┤ ││││ │  └┐┌┘│├┤ │││ ########################################################################
-- ##### ┴ ┴┴ ┴┴┘└┘  ┴ ┴└─┘┘└┘└─┘   └┘ ┴└─┘└┴┘ ########################################################################

mod:hook(CLASS.MainMenuView, "init", function(func, self, settings, context, ...)
    func(self, settings, context, ...)
    self._pass_input = true
end)
