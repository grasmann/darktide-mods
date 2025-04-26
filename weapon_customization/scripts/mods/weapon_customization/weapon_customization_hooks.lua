local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local NetworkLookup = mod:original_require("scripts/network_lookup/network_lookup")
    local WeaponTemplate = mod:original_require("scripts/utilities/weapon/weapon_template")
    local ScriptViewport = mod:original_require("scripts/foundation/utilities/script_viewport")
    local ScriptWorld = mod:original_require("scripts/foundation/utilities/script_world")
    local ScriptCamera = mod:original_require("scripts/foundation/utilities/script_camera")
    -- local ReloadStates = mod:original_require("scripts/extension_systems/weapon/utilities/reload_states")
    local AlternateFire = mod:original_require("scripts/utilities/alternate_fire")
    local PlayerUnitVisualLoadout = mod:original_require("scripts/extension_systems/visual_loadout/utilities/player_unit_visual_loadout")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local Unit = Unit
    local CLASS = CLASS
    local pairs = pairs
    local table = table
    local tostring = tostring
    local managers = Managers
    local Viewport = Viewport
    local table_enum = table.enum
    local vector3_box = Vector3Box
    local script_unit = ScriptUnit
    local unit_get_data = Unit.get_data
    local vector3_unbox = vector3_box.unbox
    local script_unit_extension = script_unit.extension
    local table_merge_recursive = table.merge_recursive
    local script_unit_has_extension = script_unit.has_extension
    local script_unit_add_extension = script_unit.add_extension
    local script_unit_remove_extension = script_unit.remove_extension
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local SLOT_SECONDARY = "slot_secondary"
    local REFERENCE = "weapon_customization"
    local OPTION_VISIBLE_EQUIPMENT = "mod_option_visible_equipment"
    local OPTION_VISIBLE_EQUIPMENT_NO_HUB = "mod_option_visible_equipment_disable_in_hub"
    local DELETION_STATES = table_enum("default", "in_network_layers", "removing_units")

    mod.entry_key_to_widget = {}
--#endregion

-- ##### ┌─┐┬ ┌┬┐┌─┐┬─┐┌┐┌┌─┐┌┬┐┌─┐  ┌─┐┬┬─┐┌─┐ #######################################################################
-- ##### ├─┤│  │ ├┤ ├┬┘│││├─┤ │ ├┤   ├┤ │├┬┘├┤  #######################################################################
-- ##### ┴ ┴┴─┘┴ └─┘┴└─┘└┘┴ ┴ ┴ └─┘  └  ┴┴└─└─┘ #######################################################################

mod:hook_require("scripts/utilities/alternate_fire", function(instance)
    mod:hook(instance, "stop", function(func, alternate_fire_component, peeking_component, first_person_extension, weapon_tweak_templates_component, animation_extension, weapon_template, skip_stop_anim, player_unit, from_action_input)
        local gameplay_time = mod.time_manager:time("gameplay")
        -- Sights
        mod:execute_extension(player_unit, "sight_system", "on_aim_stop", gameplay_time)
        -- Weapon DOF
        mod:execute_extension(player_unit, "weapon_dof_system", "on_aim_stop", gameplay_time)
        -- Original function
        return func(alternate_fire_component, peeking_component, first_person_extension, weapon_tweak_templates_component, animation_extension, weapon_template, skip_stop_anim, player_unit, from_action_input)
    end)
end)

-- ##### ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌  ┬─┐┌─┐┌┐┌┌─┐┌─┐┌┬┐  ┬ ┬┬┌─┐┬  ┌┬┐ ##########################################################
-- ##### ├─┤│   │ ││ ││││  ├┬┘├─┤││││ ┬├┤  ││  ││││├┤ │   ││ ##########################################################
-- ##### ┴ ┴└─┘ ┴ ┴└─┘┘└┘  ┴└─┴ ┴┘└┘└─┘└─┘─┴┘  └┴┘┴└─┘┴─┘─┴┘ ##########################################################

mod:hook(CLASS.ActionRangedWield, "start", function(func, self, action_settings, t, time_scale, action_start_params, ...)
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
    -- Weapon DOF
    mod:execute_extension(self._player_unit, "weapon_dof_system", "on_aim_start", t)
    -- Original function
    func(self, action_settings, t, ...)
end)

-- ##### ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌┐┌┌─┐┬┌┬┐ ##############################################################################
-- ##### ├─┤│   │ ││ ││││  │ ││││├─┤││││ ##############################################################################
-- ##### ┴ ┴└─┘ ┴ ┴└─┘┘└┘  └─┘┘└┘┴ ┴┴┴ ┴ ##############################################################################

mod:hook(CLASS.ActionUnaim, "start", function(func, self, action_settings, t, ...)
    -- Sights
    mod:execute_extension(self._player_unit, "sight_system", "on_unaim_start", t)
    -- Weapon DOF
    mod:execute_extension(self._player_unit, "weapon_dof_system", "on_unaim_start", t)
    -- Original function
    func(self, action_settings, t, ...)
end)

-- ##### ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌  ┌─┐┌─┐┌─┐┌─┐┬┌─┐┬   ####################################################
-- ##### ├─┤│   │ ││ ││││  │││├┤ ├─┤├─┘│ ││││  └─┐├─┘├┤ │  │├─┤│   ####################################################
-- ##### ┴ ┴└─┘ ┴ ┴└─┘┘└┘  └┴┘└─┘┴ ┴┴  └─┘┘└┘  └─┘┴  └─┘└─┘┴┴ ┴┴─┘ ####################################################

-- ActionWindup.start = function (self, action_settings, t, time_scale, params)
mod:hook(CLASS.ActionWindup, "start", function(func, self, action_settings, t, time_scale, params, ...)
    -- Sights
    mod:execute_extension(self._player_unit, "sight_system", "on_unaim_start", t)
    -- Weapon DOF
    mod:execute_extension(self._player_unit, "weapon_dof_system", "on_unaim_start", t)
    -- Original function
    func(self, action_settings, t, time_scale, params, ...)
end)

mod:hook(CLASS.ActionSweep, "start", function(func, self, action_settings, t, time_scale, action_start_params, ...)
    -- Sights
    mod:execute_extension(self._player_unit, "sight_system", "on_aim_stop", t)
    -- Weapon DOF
    mod:execute_extension(self._player_unit, "weapon_dof_system", "on_aim_stop", t)
    -- Original function
    func(self, action_settings, t, time_scale, action_start_params, ...)
end)

-- ##### ┌─┐┬ ┬┌─┐┬ ┬ #################################################################################################
-- ##### ├─┘│ │└─┐├─┤ #################################################################################################
-- ##### ┴  └─┘└─┘┴ ┴ #################################################################################################

mod:hook(CLASS.ActionWeaponBase, "start", function(func, self, action_settings, t, time_scale, action_start_params, ...)
    if action_settings.kind == "push" then
        -- Sights
        mod:execute_extension(self._player_unit, "sight_system", "on_unaim_start", t)
        -- Weapon DOF
        mod:execute_extension(self._player_unit, "weapon_dof_system", "on_unaim_start", t)
    end
    -- Original function
    func(self, action_settings, t, time_scale, action_start_params, ...)
end)

-- ##### ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌┐┌┬ ┬┬┌─┐┬  ┌┬┐ ########################################################################
-- ##### ├─┤│   │ ││ ││││  │ ││││││││├┤ │   ││ ########################################################################
-- ##### ┴ ┴└─┘ ┴ ┴└─┘┘└┘  └─┘┘└┘└┴┘┴└─┘┴─┘─┴┘ ########################################################################

mod:hook(CLASS.ActionUnwield, "start", function(func, self, action_settings, t, time_scale, action_start_params, ...)
    -- Sights
    mod:execute_extension(self._player_unit, "sight_system", "on_unaim_start", t)
    -- Weapon DOF
    mod:execute_extension(self._player_unit, "weapon_dof_system", "on_unaim_start", t)
    -- Original function
    func(self, action_settings, t, time_scale, action_start_params, ...)
end)

mod:hook(CLASS.ActionUnwield, "finish", function(func, self, reason, data, t, time_in_action, ...)
    -- Original function
    func(self, reason, data, t, time_in_action, ...)
    -- Sights
    mod:execute_extension(self._player_unit, "sight_system", "on_aim_stop", t)
    -- Weapon DOF
    mod:execute_extension(self._player_unit, "weapon_dof_system", "on_aim_stop", t)
end)

-- ##### ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌  ┌─┐┬ ┬┌─┐┬─┐┌─┐┌─┐  ┌─┐┬  ┬┌─┐┬─┐┬  ┌─┐┌─┐┌┬┐ ##############################################
-- ##### ├─┤│   │ ││ ││││  │  ├─┤├─┤├┬┘│ ┬├┤   │ │└┐┌┘├┤ ├┬┘│  │ │├─┤ ││ ##############################################
-- ##### ┴ ┴└─┘ ┴ ┴└─┘┘└┘  └─┘┴ ┴┴ ┴┴└─└─┘└─┘  └─┘ └┘ └─┘┴└─┴─┘└─┘┴ ┴─┴┘ ##############################################

mod:hook(CLASS.ActionOverloadCharge, "start", function(func, self, action_settings, t, time_scale, action_start_params, ...)
    -- Sights
    mod:execute_extension(self._player_unit, "sight_system", "on_aim_start", t)
    -- Weapon DOF
    mod:execute_extension(self._player_unit, "weapon_dof_system", "on_aim_start", t)
    -- Original function
    func(self, action_settings, t, time_scale, action_start_params, ...)
end)

mod:hook(CLASS.ActionOverloadCharge, "finish", function(func, self, reason, data, t, time_in_action, ...)
    -- Original function
    func(self, reason, data, t, time_in_action, ...)
    -- Sights
    mod:execute_extension(self._player_unit, "sight_system", "on_aim_stop", t)
    -- Weapon DOF
    mod:execute_extension(self._player_unit, "weapon_dof_system", "on_aim_stop", t)
end)

-- ##### ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌  ┬  ┬┌─┐┌┐┌┌┬┐  ┌─┐┬  ┬┌─┐┬─┐┬ ┬┌─┐┌─┐┌┬┐ ###################################################
-- ##### ├─┤│   │ ││ ││││  └┐┌┘├┤ │││ │   │ │└┐┌┘├┤ ├┬┘├─┤├┤ ├─┤ │  ###################################################
-- ##### ┴ ┴└─┘ ┴ ┴└─┘┘└┘   └┘ └─┘┘└┘ ┴   └─┘ └┘ └─┘┴└─┴ ┴└─┘┴ ┴ ┴  ###################################################

mod:hook(CLASS.ActionVentOverheat, "start", function(func, self, action_settings, t, time_scale, action_start_params, ...)
    -- Laser pointer
    mod:execute_extension(self._player_unit, "laser_pointer_system", "set_lock", false, action_settings.total_time)
    -- Crouch
    mod:execute_extension(self._player_unit, "crouch_system", "set_overwrite", true)
    -- Original function
    func(self, action_settings, t, time_scale, action_start_params, ...)
end)

mod:hook(CLASS.ActionVentOverheat, "finish", function(func, self, reason, data, t, time_in_action, ...)
    -- Laser pointer
    mod:execute_extension(self._player_unit, "laser_pointer_system", "set_lock", nil, self._action_settings.total_time)
    -- Crouch
    mod:execute_extension(self._player_unit, "crouch_system", "set_overwrite", false)
    -- Original function
    func(self, reason, data, t, time_in_action, ...)
end)

-- ##### ┬─┐┌─┐┬  ┌─┐┌─┐┌┬┐  ┌─┐┬ ┬┌─┐┌┬┐┌─┐┬ ┬┌┐┌ ####################################################################
-- ##### ├┬┘├┤ │  │ │├─┤ ││  └─┐├─┤│ │ │ │ ┬│ ││││ ####################################################################
-- ##### ┴└─└─┘┴─┘└─┘┴ ┴─┴┘  └─┘┴ ┴└─┘ ┴ └─┘└─┘┘└┘ ####################################################################

mod:hook(CLASS.ActionReloadShotgun, "start", function(func, self, action_settings, t, time_scale, ...)
    -- Laser pointer
    mod:execute_extension(self._player_unit, "laser_pointer_system", "set_lock", false, action_settings.total_time)
    -- Crouch
    mod:execute_extension(self._player_unit, "crouch_system", "set_overwrite", true)
    -- Sights
    mod:execute_extension(self._player_unit, "sight_system", "on_unaim_start", t)
    -- Weapon DOF
    mod:execute_extension(self._player_unit, "weapon_dof_system", "on_unaim_start", t)
    -- Original function
    func(self, action_settings, t, time_scale, ...)
end)

mod:hook(CLASS.ActionReloadShotgun, "finish", function(func, self, reason, data, t, time_in_action, ...)
    -- Laser pointer
    mod:execute_extension(self._player_unit, "laser_pointer_system", "set_lock", nil, self._action_settings.total_time)
    -- Crouch
    mod:execute_extension(self._player_unit, "crouch_system", "set_overwrite", false)
    -- Original function
    func(self, reason, data, t, time_in_action, ...)
end)

-- ##### ┌─┐┌─┐┌─┐┌─┐┬┌─┐┬    ┬─┐┌─┐┬  ┌─┐┌─┐┌┬┐ ######################################################################
-- ##### └─┐├─┘├┤ │  │├─┤│    ├┬┘├┤ │  │ │├─┤ ││ ######################################################################
-- ##### └─┘┴  └─┘└─┘┴┴ ┴┴─┘  ┴└─└─┘┴─┘└─┘┴ ┴─┴┘ ######################################################################

mod:hook(CLASS.ActionRangedLoadSpecial, "start", function(func, self, action_settings, t, time_scale, ...)
    -- Sights
    mod:execute_extension(self._player_unit, "sight_system", "on_unaim_start", t)
    -- Weapon DOF
    mod:execute_extension(self._player_unit, "weapon_dof_system", "on_unaim_start", t)
    -- Original function
    func(self, action_settings, t, time_scale, ...)
end)

-- ##### ┬─┐┌─┐┬  ┌─┐┌─┐┌┬┐  ┌─┐┌┬┐┌─┐┌┬┐┌─┐ ##########################################################################
-- ##### ├┬┘├┤ │  │ │├─┤ ││  └─┐ │ ├─┤ │ ├┤  ##########################################################################
-- ##### ┴└─└─┘┴─┘└─┘┴ ┴─┴┘  └─┘ ┴ ┴ ┴ ┴ └─┘ ##########################################################################

mod:hook(CLASS.ActionReloadState, "start", function(func, self, action_settings, t, time_scale, ...)
    -- Laser pointer
    mod:execute_extension(self._player_unit, "laser_pointer_system", "set_lock", false, action_settings.total_time)
    -- Crouch
    mod:execute_extension(self._player_unit, "crouch_system", "set_overwrite", true)
    -- Sights
    mod:execute_extension(self._player_unit, "sight_system", "on_unaim_start", t)
    -- Weapon DOF
    mod:execute_extension(self._player_unit, "weapon_dof_system", "on_unaim_start", t)
    -- Original function
    func(self, action_settings, t, time_scale, ...)
end)

mod:hook(CLASS.ActionReloadState, "_update_functionality", function(func, self, reload_state, time_in_action, time_scale, dt, t, ...)
    -- Crouch
    local action_reload_component = self._action_reload_component
    if action_reload_component.has_refilled_ammunition then
        mod:execute_extension(self._player_unit, "crouch_system", "set_overwrite", false)
    end
    -- Original function
    func(self, reload_state, time_in_action, time_scale, dt, t, ...)
end)

--#region Old
    -- mod:hook(CLASS.ActionReloadState, "_start_reload_state", function(func, self, reload_template, inventory_slot_component, action_reload_component, t, ...)
    --     mod:execute_extension(self._player_unit, "crouch_system", "set_overwrite", false)
    --     func(self, reload_template, inventory_slot_component, action_reload_component, t, ...)
    -- end)
--#endregion

mod:hook(CLASS.ActionReloadState, "finish", function(func, self, reason, data, t, time_in_action, ...)
    -- Laser pointer
    mod:execute_extension(self._player_unit, "laser_pointer_system", "set_lock", nil, self._action_settings.total_time)
    -- Crouch
    mod:execute_extension(self._player_unit, "crouch_system", "set_overwrite", false)
    -- Original function
    func(self, reason, data, t, time_in_action, ...)
end)

-- ##### ┬┌┐┌┌─┐┌─┐┌─┐┌─┐┌┬┐ ##########################################################################################
-- ##### ││││└─┐├─┘├┤ │   │  ##########################################################################################
-- ##### ┴┘└┘└─┘┴  └─┘└─┘ ┴  ##########################################################################################

mod:hook(CLASS.ActionInspect, "start", function(func, self, action_settings, t, ...)
    -- Sights
    mod:execute_extension(self._player_unit, "sight_system", "on_inspect_start", t)
    -- Laser pointer
    mod:execute_extension(self._player_unit, "laser_pointer_system", "set_lock", false, action_settings.total_time)
    -- Crouch
    mod:execute_extension(self._player_unit, "crouch_system", "set_overwrite", true)
    -- Original function
    func(self, action_settings, ...)
end)

mod:hook(CLASS.ActionInspect, "finish", function(func, self, reason, data, t, time_in_action, ...)
    -- Sights
    mod:execute_extension(self._player_unit, "sight_system", "on_inspect_end", t)
    -- Laser pointer
    mod:execute_extension(self._player_unit, "laser_pointer_system", "set_lock", nil, self._action_settings.total_time)
    -- Crouch
    mod:execute_extension(self._player_unit, "crouch_system", "set_overwrite", false)
    -- Original function
    func(self, reason, data, t, time_in_action, ...)
end)

-- ##### ┌─┐┌─┐┌┬┐┌─┐┬─┐┌─┐  ┌┬┐┌─┐┌┐┌┌─┐┌─┐┌─┐┬─┐ ####################################################################
-- ##### │  ├─┤│││├┤ ├┬┘├─┤  │││├─┤│││├─┤│ ┬├┤ ├┬┘ ####################################################################
-- ##### └─┘┴ ┴┴ ┴└─┘┴└─┴ ┴  ┴ ┴┴ ┴┘└┘┴ ┴└─┘└─┘┴└─ ####################################################################

mod:hook(CLASS.CameraManager, "post_update", function(func, self, dt, t, viewport_name, ...)
    -- Original function
    func(self, dt, t, viewport_name, ...)
    -- Get unit
    local camera_nodes = self._camera_nodes[viewport_name]
    local current_node = self:_current_node(camera_nodes)
    local root_unit = current_node:root_unit()
    -- Sights
    mod:execute_extension(root_unit, "sight_system", "update_zoom", viewport_name)
end)

mod:hook(CLASS.CameraManager, "shading_callback", function(func, self, world, shading_env, viewport, default_shading_environment_resource, ...)
    -- Original function
    func(self, world, shading_env, viewport, default_shading_environment_resource, ...)
    -- Camera data
    local camera_data = self._viewport_camera_data[viewport] or self._viewport_camera_data[Viewport.get_data(viewport, "overridden_viewport")]
    -- Extensions
    if self._world == world then
        -- Get unit
        local viewport_name = Viewport.get_data(viewport, "name")
        local camera_nodes = self._camera_nodes[viewport_name]
        local current_node = self:_current_node(camera_nodes)
        local root_unit = current_node:root_unit()
        -- Sight
        -- mod:execute_extension(root_unit, "sight_system", "apply_weapon_dof", shading_env)
        mod:execute_extension(root_unit, "weapon_dof_system", "apply_weapon_dof", shading_env)
    end
end)

-- ##### ┌─┐┬  ┌─┐┬ ┬┌─┐┬─┐  ┬ ┬┌┐┌┬┌┬┐  ┌─┐─┐ ┬  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##########################################
-- ##### ├─┘│  ├─┤└┬┘├┤ ├┬┘  │ │││││ │   ├┤ ┌┴┬┘  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##########################################
-- ##### ┴  ┴─┘┴ ┴ ┴ └─┘┴└─  └─┘┘└┘┴ ┴   └  ┴ └─  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##########################################

-- mod:hook(CLASS.PlayerUnitFxExtension, "_create_particles_wrapper", function(func, self, world, particle_name, position, rotation, scale, ...)
--     -- Original function
--     local effect_id = func(self, world, particle_name, position, rotation, scale, ...)
--     -- Laser pointer
--     mod:execute_extension(self._unit, "laser_pointer_system", "particles_wrapper_created", particle_name, effect_id)
--     -- Return value
--     return effect_id
-- end)

-- ##### ┬ ┬┬ ┬┌┬┐  ┌─┐┬  ┌─┐┌┬┐┌─┐┌┐┌┌┬┐  ┌─┐┬─┐┌─┐┌─┐┌─┐┬ ┬┌─┐┬┬─┐ ##################################################
-- ##### ├─┤│ │ ││  ├┤ │  ├┤ │││├┤ │││ │   │  ├┬┘│ │└─┐└─┐├─┤├─┤│├┬┘ ##################################################
-- ##### ┴ ┴└─┘─┴┘  └─┘┴─┘└─┘┴ ┴└─┘┘└┘ ┴   └─┘┴└─└─┘└─┘└─┘┴ ┴┴ ┴┴┴└─ ##################################################

--#region Old
    -- mod:hook(CLASS.HudElementCrosshair, "_draw_widgets", function(func, self, dt, t, input_service, ui_renderer, render_settings, ...)
    --     local parent = self._parent
    --     local player_extensions = parent and parent:player_extensions()
    --     local unit = player_extensions and player_extensions.unit
    --     if unit and self._widget then
    --         local is_hiding_crosshair = mod:execute_extension(unit, "sight_system", "is_hiding_crosshair")
            
    --         self._widget.visible = not is_hiding_crosshair
    --     end
    --     -- mod:execute_extension(unit, "crouch_system", "pause")
    --     func(self, dt, t, input_service, ui_renderer, render_settings, ...)
    --     -- mod:execute_extension(unit, "crouch_system", "resume")
    --     -- if unit then
    --     --     mod:execute_extension(unit, "crouch_system", "adjust_crosshair", self)
    --     -- end
    -- end)
--#endregion

mod:hook(CLASS.HudElementCrosshair, "_get_current_crosshair_type", function(func, self, crosshair_settings, ...)
    -- Original function
    local crosshair_type = func(self, crosshair_settings, ...)
    -- Hide?
	local player_extensions = self._parent and self._parent:player_extensions()
    local unit = player_extensions and player_extensions.unit
    if unit then
        crosshair_type = mod:execute_extension(unit, "sight_system", "crosshair", crosshair_type)
    end

    -- if unit and script_unit_has_extension(unit, "sight_system") then
    --     local sight_extension = script_unit_extension(unit, "sight_system")
    --     if mod:execute_extension(unit, "sight_system", "is_hiding_crosshair") then
    --         crosshair_type = "ironsight"
    --     end
    -- end
    --  Return
    return crosshair_type
end)

-- mod:hook(CLASS.HudElementCrosshair, "_crosshair_position", function(func, self, dt, t, ui_renderer, ...)
--     local parent = self._parent
--     local player_extensions = parent and parent:player_extensions()
--     local unit = player_extensions and player_extensions.unit
--     local x, y = func(self, dt, t, ui_renderer, ...)
--     if script_unit_has_extension(unit, "crouch_system") then
--         -- return mod:execute_extension(unit, "crouch_system", "crosshair_position", self, dt, t, ui_renderer)
--         return mod:execute_extension(unit, "crouch_system", "adjust_crosshair", self, x, y)
--     else
--         return x, y
--     end
--     -- return mod:execute_extension(unit, "crouch_system", "adjust_crosshair", self)
-- end)

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

mod.setting_id_to_widget = {}

-- ##### ┌─┐┌─┐┌─┐┌┬┐┌─┐┌┬┐┌─┐┌─┐┌─┐ ##################################################################################
-- ##### ├┤ │ ││ │ │ └─┐ │ ├┤ ├─┘└─┐ ##################################################################################
-- ##### └  └─┘└─┘ ┴ └─┘ ┴ └─┘┴  └─┘ ##################################################################################

-- Capture footsteps for equipment animation
-- mod:hook_require("scripts/utilities/footstep", function(instance)
--     mod:hook(instance, "trigger_material_footstep", function(func, sound_alias, wwise_world, physics_world, source_id, unit, node, query_from, query_to, optional_set_speed_parameter, optional_set_first_person_parameter, ...)
--         mod:execute_extension(unit, "visible_equipment_system", "on_footstep")
--         return func(sound_alias, wwise_world, physics_world, source_id, unit, node, query_from, query_to, optional_set_speed_parameter, optional_set_first_person_parameter, ...)
--     end)
-- end)

mod:hook_require("scripts/utilities/material_fx", function(instance)
    mod:hook(instance, "trigger_material_fx", function(func, unit, world, wwise_world, physics_world, sound_alias, source_id, query_from, query_to, optional_set_speed_parameter, optional_set_first_person_parameter, use_cached_material_hit, ...)
        mod:execute_extension(unit, "visible_equipment_system", "on_footstep")
        return func(unit, world, wwise_world, physics_world, sound_alias, source_id, query_from, query_to, optional_set_speed_parameter, optional_set_first_person_parameter, use_cached_material_hit, ...)
    end)
end)

-- mod:hook(CLASS.PlayerVisibilityExtension, "init", function(func, self, extension_init_context, unit, extension_init_data, ...)
--     func(self, extension_init_context, unit, extension_init_data, ...)
--     Unit.set_unit_visibility(self._unit, true, true)
--     -- Unit.set_scalar_for_materials(self._unit, "inv_jitter_alpha", .01, true)
--     mod:echo("init")
-- end)

-- mod:hook(CLASS.PlayerVisibilityExtension, "hide", function(func, self, ...)
--     func(self, ...)
--     Unit.set_unit_visibility(self._unit, true, true)
--     -- Unit.set_scalar_for_materials(self._unit, "inv_jitter_alpha", .01, true)
-- 	-- if self._is_visible then
-- 	-- 	self:_take_snapshot()
-- 	-- 	-- Unit.set_unit_visibility(self._unit, false, true)
--     --     Unit.set_scalar_for_materials(self._unit, "inv_jitter_alpha", .01, true)

-- 	-- 	if self._first_person_unit then
-- 	-- 		Unit.set_unit_visibility(self._first_person_unit, false, true)
-- 	-- 	end

-- 	-- 	self._is_visible = false
-- 	-- end
--     mod:echo("hide")
-- end)

-- mod:hook(CLASS.PlayerVisibilityExtension, "show", function(func, self, ...)
-- 	-- if not self._is_visible then
-- 	-- 	self:_restore_snapshot()

-- 	-- 	self._is_visible = true
-- 	-- end

--     func(self, ...)
--     -- Unit.set_unit_visibility(self._unit, true, true)
--     -- Unit.set_scalar_for_materials(self._unit, "inv_jitter_alpha", 1, true)
--     mod:echo("show")
-- end)

-- ##### ┌┬┐┬┌─┐┌─┐┬┌─┐┌┐┌  ┬┌┐┌┌┬┐┬─┐┌─┐  ┬  ┬┬┌─┐┬ ┬ ################################################################
-- ##### ││││└─┐└─┐││ ││││  ││││ │ ├┬┘│ │  └┐┌┘│├┤ │││ ################################################################
-- ##### ┴ ┴┴└─┘└─┘┴└─┘┘└┘  ┴┘└┘ ┴ ┴└─└─┘   └┘ ┴└─┘└┴┘ ################################################################

--#endregion ToDo
    -- mod:hook(CLASS.MissionIntroView, "update", function(func, self, dt, t, input_service, ...)
    --     -- Original function
    --     func(self, dt, t, input_service, ...)
    -- --     -- Iterate slots
    -- --     for i, slot in pairs(self._spawn_slots) do
    -- --         if slot.occupied and not slot.was_processed then
    -- --             local profile_spawner = slot.profile_spawner
    -- --             local spawn_data = profile_spawner and profile_spawner._character_spawn_data
    -- --             local player_unit = spawn_data and spawn_data.unit_3p
    -- --             if player_unit then
    -- --                 mod:echo("process load slot "..tostring(slot.index))
    -- --                 -- Extensions
    -- --                 profile_spawner.no_spawn = true
    -- --                 mod:remove_extension(player_unit, "visible_equipment_system")
    -- --                 self.visible_equipment_extension = script_unit_add_extension({
    -- --                     world = self._world_spawner:world(),
    -- --                 }, slot.spawn_point_unit, "VisibleEquipmentExtension", "visible_equipment_system", {
    -- --                     -- player = mod:player_from_unit(unit_3p),
    -- --                     profile = spawn_data.profile,
    -- --                     player_unit = slot.spawn_point_unit,
    -- --                     equipment_component = spawn_data.equipment_component,
    -- --                     equipment = spawn_data.slots,
    -- --                     loading_spawn_point = slot.index,
    -- --                 })
    -- --                 slot.was_processed = true
    -- --             end
    -- --         elseif not slot.occupied then
    -- --             mod:remove_extension(slot.spawn_point_unit, "visible_equipment_system")
    -- --             slot.was_processed = nil
    -- --         elseif slot.occupied and slot.was_processed then
    -- --             mod:execute_extension(slot.spawn_point_unit, "visible_equipment_system", "load_slots")
    -- --             mod:execute_extension(slot.spawn_point_unit, "visible_equipment_system", "update", dt, t)
    -- --         end
    -- --     end
    --     -- Cutscene
    --     managers.event:trigger("weapon_customization_mission_intro", true)
    -- end)

    -- mod:hook(CLASS.LobbyView, "on_enter", function(func, self, ...)
    --     -- Original function
    --     func(self, ...)
    --     -- Cutscene
    --     managers.event:trigger("weapon_customization_cutscene", true)
    -- end)

    -- mod:hook(CLASS.LobbyView, "on_exit", function(func, self, ...)
    --     -- -- Extensions
    --     -- for i, slot in pairs(self._spawn_slots) do
    --     --     if slot.occupied and slot.was_processed then
    --     --         mod:remove_extension(slot.spawn_point_unit, "visible_equipment_system")
    --     --     end
    --     -- end
    --     -- Cutscene
    --     managers.event:trigger("weapon_customization_cutscene", false)
    --     -- Original function
    --     func(self, ...)
    -- end)

    -- mod:hook(CLASS.LobbyView, "update", function(func, self, ...)
    --     -- Original function
    --     func(self, ...)
    --     -- Cutscene
    --     managers.event:trigger("weapon_customization_cutscene", true)
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
--#endregion

-- ##### ┌─┐┬ ┬┌┬┐┌─┐┌─┐┌─┐┌┐┌┌─┐  ┬  ┬┬┌─┐┬ ┬ ########################################################################
-- ##### │  │ │ │ └─┐│  ├┤ │││├┤   └┐┌┘│├┤ │││ ########################################################################
-- ##### └─┘└─┘ ┴ └─┘└─┘└─┘┘└┘└─┘   └┘ ┴└─┘└┴┘ ########################################################################

-- CinematicSceneSystem

mod:hook(CLASS.CutsceneView, "on_enter", function(func, self, ...)
    -- Original function
    func(self, ...)
    -- Cutscene
    managers.event:trigger("weapon_customization_cutscene", true)
    -- Exit function
    self.on_exit = function(self)
        managers.event:trigger("weapon_customization_cutscene", false)
    end
end)

-- mod:hook(CLASS.CutsceneView, "on_exit", function(func, self, ...)
--     -- Cutscene
--     managers.event:trigger("weapon_customization_cutscene", false)
--     -- Original function
--     func(self, ...)
-- end)

mod:hook(CLASS.CutsceneView, "update", function(func, self, dt, t, input_service, ...)
    -- Original function
    func(self, dt, t, input_service, ...)
    -- Cutscene
    managers.event:trigger("weapon_customization_cutscene", true)
end)

mod:hook_require("scripts/game_states/game/state_victory_defeat", function(instance)
	mod:hook(instance, "on_enter", function(func, self, parent, params, creation_context, ...)
        mod:echo("custcene enter")
		managers.event:trigger("weapon_customization_cutscene", true)
	end)
	mod:hook(instance, "update", function(func, self, main_dt, main_t, ...)
        mod:echo("custcene update")
		managers.event:trigger("weapon_customization_cutscene", true)
	end)
	mod:hook(instance, "on_exit", function(func, self, ...)
        mod:echo("custcene exit")
		managers.event:trigger("weapon_customization_cutscene", false)
	end)
end)

-- ##### ┌┬┐┌─┐┬┌┐┌  ┌┬┐┌─┐┌┐┌┬ ┬  ┬  ┬┬┌─┐┬ ┬ ########################################################################
-- ##### │││├─┤││││  │││├┤ ││││ │  └┐┌┘│├┤ │││ ########################################################################
-- ##### ┴ ┴┴ ┴┴┘└┘  ┴ ┴└─┘┘└┘└─┘   └┘ ┴└─┘└┴┘ ########################################################################

mod:hook(CLASS.MainMenuView, "init", function(func, self, settings, context, ...)
    -- Original function
    func(self, settings, context, ...)
    -- Mod
    self._pass_input = true
end)

mod:hook(CLASS.LobbyView, "init", function(func, self, settings, context, ...)
    -- Original function
    func(self, settings, context, ...)
    -- Mod
    self._pass_input = true
end)

mod:hook(CLASS.ResultView, "init", function(func, self, settings, context, ...)
    -- Original function
    func(self, settings, context, ...)
    -- Mod
    self._pass_input = true
end)