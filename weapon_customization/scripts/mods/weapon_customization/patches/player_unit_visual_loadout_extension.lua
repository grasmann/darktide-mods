local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local NetworkLookup = mod:original_require("scripts/network_lookup/network_lookup")
    local WeaponTemplate = mod:original_require("scripts/utilities/weapon/weapon_template")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
    local table = table
    local CLASS = CLASS
    local managers = Managers
    local script_unit = ScriptUnit
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
    local OPTION_VISIBLE_EQUIPMENT = "mod_option_visible_equipment"
    local OPTION_VISIBLE_EQUIPMENT_NO_HUB = "mod_option_visible_equipment_disable_in_hub"
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/extension_systems/visual_loadout/player_unit_visual_loadout_extension", function(instance)

    instance.remove_custom_extensions = function(self)
        -- Sights
        mod:remove_extension(self._unit, "sight_system")
        -- Weapon DOF
        mod:remove_extension(self._unit, "weapon_dof_system")
        -- Flashlights
        mod:remove_extension(self._unit, "flashlight_system")
        -- Visible equipment
        mod:remove_extension(self._unit, "visible_equipment_system")
    end

    instance.update_visible_equipment = function(self, dt, t)
        local visible_equipment_system = script_unit_has_extension(self._unit, "visible_equipment_system")
        local visible_equipment_system_option = mod:get(OPTION_VISIBLE_EQUIPMENT)
        local hub = not mod:is_in_hub() or not mod:get(OPTION_VISIBLE_EQUIPMENT_NO_HUB)
        if not visible_equipment_system and visible_equipment_system_option and not managers.ui:has_active_view() and hub then
            -- Add VisibleEquipmentExtension
            script_unit_add_extension({
                world = self._equipment_component._world,
            }, self._unit, "VisibleEquipmentExtension", "visible_equipment_system", {
                player = self._player,
                player_unit = self._unit,
                profile = self._player:profile(),
                is_local_unit = self._is_local_unit,
                equipment_component = self._equipment_component,
                equipment = self._equipment,
                wielded_slot = self._equipment[self._inventory_component.wielded_slot],
            })
        elseif visible_equipment_system and (not mod:get(OPTION_VISIBLE_EQUIPMENT) or not hub) then
            -- Remove VisibleEquipmentExtension
            mod:remove_extension(self._unit, "visible_equipment_system")
        elseif visible_equipment_system and visible_equipment_system_option then
            -- Update VisibleEquipmentExtension
            mod:execute_extension(self._unit, "visible_equipment_system", "load_slots")
            -- mod:execute_extension(self._unit, "visibl                    _equipment_system", "update", dt, t)
        end
    end

    instance.update_sight = function(self, dt, t)
        if not script_unit_has_extension(self._unit, "sight_system") and self._weapon_extension._weapons[SLOT_SECONDARY] then
            -- Add SightExtension
            script_unit_add_extension({
                world = self._equipment_component._world,
            }, self._unit, "SightExtension", "sight_system", {
                player = self._player,
                player_unit = self._player.player_unit,
                is_local_unit = self._is_local_unit,
                ranged_weapon = table_merge_recursive(self._weapon_extension._weapons[SLOT_SECONDARY],
                    {attachment_units = self._equipment[SLOT_SECONDARY].attachments_1p}),
                wielded_slot = self._equipment[self._inventory_component.wielded_slot],
                equipment_component = self._equipment_component,
                equipment = self._equipment,
            })
        else
            -- Update SightExtension
            mod:execute_extension(self._unit, "sight_system", "update", self._unit, dt, t)
        end
    end

    instance.update_weapon_dof = function(self, dt, t)
        if not script_unit_has_extension(self._unit, "weapon_dof_system") and self._weapon_extension._weapons[SLOT_SECONDARY] then
            -- Add WeaponDOFExtension
            script_unit_add_extension({
                world = self._equipment_component._world,
            }, self._unit, "WeaponDOFExtension", "weapon_dof_system", {
                player = self._player,
                player_unit = self._player.player_unit,
                is_local_unit = self._is_local_unit,
                ranged_weapon = table_merge_recursive(self._weapon_extension._weapons[SLOT_SECONDARY],
                    {attachment_units = self._equipment[SLOT_SECONDARY].attachments_1p}),
                wielded_slot = self._equipment[self._inventory_component.wielded_slot],
            })
        end
    end

    instance.update_crouch = function(self, dt, t)
        if not script_unit_has_extension(self._unit, "crouch_system") then
            script_unit_add_extension({
                world = self._equipment_component._world,
            }, self._unit, "CrouchAnimationExtension", "crouch_system", {
                player_unit = self._unit,
                is_local_unit = self._is_local_unit,
            })
        end
    end

    instance.update_sway = function(self, dt, t)
        if not script_unit_has_extension(self._unit, "sway_system") then
            script_unit_add_extension({
                world = self._equipment_component._world,
            }, self._unit, "SwayAnimationExtension", "sway_system", {
                player_unit = self._unit,
                is_local_unit = self._is_local_unit,
            })
        end
    end

    instance.update_flashlight = function(self, dt, t)
        local slot = self._equipment[SLOT_SECONDARY]
        if not script_unit_has_extension(self._unit, "flashlight_system") and slot then
            -- local flashlight_unit_1p = mod:get_attachment_slot_in_attachments(slot.attachments_1p, "flashlight")
            -- local flashlight_unit_3p = mod:get_attachment_slot_in_attachments(slot.attachments_3p, "flashlight")
            local flashlight_unit_1p = mod.gear_settings:attachment_unit(slot.attachments_1p, "flashlight")
            local flashlight_unit_3p = mod.gear_settings:attachment_unit(slot.attachments_3p, "flashlight")
            
            -- local inventory_component = self._inventory_component
            -- local wielded_slot_name = inventory_component and inventory_component.wielded_slot
            if flashlight_unit_1p and flashlight_unit_3p then
                -- Add FlashlightExtension
                script_unit_add_extension({
                    world = self._equipment_component._world,
                }, self._unit, "FlashlightExtension", "flashlight_system", {
                    player = self._player,
                    player_unit = self._unit,
                    is_local_unit = self._is_local_unit,
                    flashlight_unit_1p = flashlight_unit_1p,
                    flashlight_unit_3p = flashlight_unit_3p,
                    -- wielded_slot = wielded_slot_name and self._equipment[wielded_slot_name],
                    wielded_slot = self._equipment[self._inventory_component.wielded_slot],
                    ranged_weapon = table_merge_recursive(self._weapon_extension._weapons[SLOT_SECONDARY],
                        {attachment_units = self._equipment[SLOT_SECONDARY].attachments_1p}),
                })
            end
        else
            -- Update FlashlightExtension
            -- mod:execute_extension(self._unit, "flashlight_system", "update", dt, t)
        end
    end

    instance.destroy_mispredict_handler = function(self)
        if self._mispredict_package_handler then
            -- self._mispredict_package_handler:destroy()
            self._mispredict_package_handler = nil
        end
    end

end)

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #################################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #################################################################################

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "init", function(func, self, extension_init_context, unit, extension_init_data, game_object_data_or_game_session, unit_spawn_parameter_or_game_object_id, ...)

    -- Original function
    func(self, extension_init_context, unit, extension_init_data, game_object_data_or_game_session, unit_spawn_parameter_or_game_object_id, ...)

    -- Destroy mispredict handler
    self:destroy_mispredict_handler()

end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "extensions_ready", function(func, self, world, unit, ...)
    
    -- Sights
    mod:remove_extension(self._unit, "sight_system")
    
    -- Original function
    func(self, world, unit, ...)
    
    -- Mod
    mod:on_player_unit_loaded(self._unit)

end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "_equip_item_to_slot", function(func, self, item, slot_name, t, optional_existing_unit_3p, from_server_correction_occurred, ...)
    
    -- Original function
    func(self, item, slot_name, t, optional_existing_unit_3p, from_server_correction_occurred, ...)

    -- Extensions
    if slot_name == SLOT_SECONDARY then
        self:remove_custom_extensions()
    end

end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "_unequip_item_from_slot", function(func, self, slot_name, from_server_correction_occurred, fixed_frame, from_destroy, ...)

    -- Remove custom extensions
    if slot_name == SLOT_SECONDARY then
        self:remove_custom_extensions()
    end

    -- Original function
    func(self, slot_name, from_server_correction_occurred, fixed_frame, from_destroy, ...)

end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "destroy", function(func, self, ...)

    -- Remove custom extensions
    self:remove_custom_extensions()

    -- Mod
    mod:on_player_unit_destroyed(self._unit)

    -- Original function
    func(self, ...)

end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "post_update", function(func, self, unit, dt, t, context, ...)

    -- Original function
    func(self, unit, dt, t, context, ...)

    -- Visibile equipment
    mod:execute_extension(self._unit, "visible_equipment_system", "update", dt, t)

end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "update", function(func, self, unit, dt, t, ...)

    -- Original function
    func(self, unit, dt, t, ...)

    -- Visible equipment
    self:update_visible_equipment(dt, t)

    -- Sights
    self:update_sight(dt, t)

    -- Weapon DOF
    self:update_weapon_dof(dt, t)

    -- CrouchAnimationExtension
    self:update_crouch(dt, t)

    -- SwayAnimationExtension
    self:update_sway(dt, t)

    -- Flashlights
    self:update_flashlight(dt, t)

end)