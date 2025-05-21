local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local NetworkLookup = mod:original_require("scripts/network_lookup/network_lookup")
    local WeaponTemplate = mod:original_require("scripts/utilities/weapon/weapon_template")
    local ScriptViewport = mod:original_require("scripts/foundation/utilities/script_viewport")
    local ScriptWorld = mod:original_require("scripts/foundation/utilities/script_world")
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
    local script_unit_extension = script_unit.extension
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

    instance.remove_custom_extensions = function(self, slot_name)
        -- Sights
        mod:remove_extension(self._unit, "sight_system")
        -- Weapon DOF
        mod:remove_extension(self._unit, "weapon_dof_system")
        -- Flashlights
        mod:remove_extension(self._unit, "flashlight_system")
        -- Laserpointer
        mod:execute_extension(self._unit, "laser_pointer_system", "despawn_all")
        mod:remove_extension(self._unit, "laser_pointer_system")
        -- Visible equipment
        mod:execute_extension(self._unit, "visible_equipment_system", "delete_slots")
        mod:execute_extension(self._unit, "visible_equipment_system", "delete")
        mod:remove_extension(self._unit, "visible_equipment_system")

        mod:execute_extension(self._unit, "weapon_sling_system", "delete_slots")
        mod:remove_extension(self._unit, "weapon_sling_system")
        -- Crouch
        mod:remove_extension(self._unit, "crouch_system")
        -- Sway
        mod:remove_extension(self._unit, "sway_system")
    end

    instance.update_sling = function(self, dt, t)
		local sling_extension = script_unit_extension(self._unit, "weapon_sling_system")
        if self.use_sling_system and self.use_visible_equipment_system then
            if sling_extension then
                -- Update WeaponSlingExtension
                sling_extension:load_slots()
                sling_extension:update(dt, t)

            else
                -- Add WeaponSlingExtension
                script_unit_add_extension({
                    world = self._equipment_component._world,
                }, self._unit, "WeaponSlingExtension", "weapon_sling_system", {
                    player = self._player,
                    profile = self._player:profile(),
                    is_local_unit = true,
                    player_unit = self._unit,
                    equipment_component = self._equipment_component,
                    equipment = self._equipment,
                    wielded_slot = self._equipment[self._inventory_component.wielded_slot],
                })

            end
        elseif sling_extension then
            -- Remove WeaponSlingExtension
            -- mod:execute_extension(self._unit, "weapon_sling_system", "delete_slots")
            sling_extension:delete_slots()
            mod:remove_extension(self._unit, "weapon_sling_system")

        end
	end

    instance.update_visible_equipment = function(self, dt, t)
        local visible_equipment_extension = script_unit_extension(self._unit, "visible_equipment_system")
        local hub = not mod:is_in_hub() or not self.disable_visible_equipment_system_in_hub
        local use_visible_equipment_system = self.use_visible_equipment_system and hub
        if use_visible_equipment_system then
            if visible_equipment_extension then
                -- Update VisibleEquipmentExtension
                visible_equipment_extension:load_slots()
                visible_equipment_extension:update(dt, t)

            else
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

            end
        elseif visible_equipment_extension then
            -- Remove VisibleEquipmentExtension
            visible_equipment_extension:delete_slots()
            mod:remove_extension(self._unit, "visible_equipment_system")

        end
    end

    instance.update_sight = function(self, dt, t)
        local sight_extension = script_unit_extension(self._unit, "sight_system")
        if self.use_sight_system then
            if sight_extension then
                -- Update SightExtension
                sight_extension:update(self._unit, dt, t)

            else
                local weapon_unit = self._weapon_extension._weapons[SLOT_SECONDARY]
                -- local attachment_units = self._equipment[SLOT_SECONDARY].attachments_1p
                local slot = self._equipment[SLOT_SECONDARY]
                local attachment_units = slot.attachments_by_unit_1p and slot.attachments_by_unit_1p[slot.unit_1p]
                if weapon_unit and attachment_units then
                    -- Add SightExtension
                    script_unit_add_extension({
                        world = self._equipment_component._world,
                    }, self._unit, "SightExtension", "sight_system", {
                        player = self._player,
                        player_unit = self._player.player_unit,
                        is_local_unit = self._is_local_unit,
                        ranged_weapon = table_merge_recursive(weapon_unit, {attachment_units = attachment_units}),
                        wielded_slot = self._equipment[self._inventory_component.wielded_slot],
                        equipment_component = self._equipment_component,
                        equipment = self._equipment,
                    })
                end

            end
        elseif sight_extension then
            -- Remove VisibleEquipmentExtension
            mod:remove_extension(self._unit, "sight_system")

        end
    end

    instance.update_weapon_dof = function(self, dt, t)
        local weapon_dof_extensions = script_unit_extension(self._unit, "weapon_dof_system")
        if self.use_dof_system then
            if not weapon_dof_extensions then
                local weapon_unit = self._weapon_extension._weapons[SLOT_SECONDARY]
                -- local attachment_units = self._equipment[SLOT_SECONDARY].attachments_1p
                -- local attachment_units = self._equipment[SLOT_SECONDARY].attachments_1p[self._equipment[SLOT_SECONDARY].unit_1p]
                local slot = self._equipment[SLOT_SECONDARY]
                local attachment_units = slot.attachments_by_unit_1p and slot.attachments_by_unit_1p[slot.unit_1p]
                if weapon_unit and attachment_units then
                    -- Add WeaponDOFExtension
                    script_unit_add_extension({
                        world = self._equipment_component._world,
                    }, self._unit, "WeaponDOFExtension", "weapon_dof_system", {
                        player = self._player,
                        player_unit = self._player.player_unit,
                        is_local_unit = self._is_local_unit,
                        ranged_weapon = table_merge_recursive(weapon_unit, {attachment_units = attachment_units}),
                        wielded_slot = self._equipment[self._inventory_component.wielded_slot],
                    })

                end
            end
        elseif weapon_dof_extensions then
            -- Remove WeaponDOFExtension
            mod:remove_extension(self._unit, "weapon_dof_system")

        end
    end

    instance.update_crouch = function(self, dt, t)
        local crouch_animation_extension = script_unit_extension(self._unit, "crouch_system")
        if self.use_crouch_animation_system then
            if not crouch_animation_extension then
                -- Add CrouchAnimationExtension
                script_unit_add_extension({
                    world = self._equipment_component._world,
                }, self._unit, "CrouchAnimationExtension", "crouch_system", {
                    player_unit = self._unit,
                    is_local_unit = self._is_local_unit,
                })

            end
        elseif crouch_animation_extension then
            -- Remove CrouchAnimationExtension
            mod:remove_extension(self._unit, "crouch_system")

        end
    end

    instance.update_sway = function(self, dt, t)
        local sway_extension = script_unit_extension(self._unit, "sway_system")
        if self.use_sway_system then
            if not sway_extension then
                -- Add SwayExtension
                script_unit_add_extension({
                    world = self._equipment_component._world,
                }, self._unit, "SwayAnimationExtension", "sway_system", {
                    player_unit = self._unit,
                    is_local_unit = self._is_local_unit,
                })

            end
        elseif sway_extension then
            -- Remove SwayExtension
            mod:remove_extension(self._unit, "sway_system")

        end
    end

    local lol = false
    instance.update_flashlight = function(self, dt, t)
        local flashlight_extension = script_unit_extension(self._unit, "flashlight_system")
        if self.use_flashlight_system then
            -- if flashlight_extension then
            --     -- Update FlashlightExtension
            --     flashlight_extension:update(dt, t)

            -- else
            if not flashlight_extension then
                local slot = self._equipment[SLOT_SECONDARY]
                if slot then
                    -- Add FlashlightExtension
                    -- if not lol then
                    --     mod:dtf(slot, "slot", 10)
                    --     lol = true
                    -- end
                    local flashlight_unit_1p = mod.gear_settings:attachment_unit(slot.attachments_by_unit_1p and slot.attachments_by_unit_1p[slot.unit_1p], "flashlight")
                    local flashlight_unit_3p = mod.gear_settings:attachment_unit(slot.attachments_by_unit_3p and slot.attachments_by_unit_3p[slot.unit_3p], "flashlight")
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
                            -- ranged_weapon = table_merge_recursive(self._weapon_extension._weapons[SLOT_SECONDARY],
                            --     {attachment_units = self._equipment[SLOT_SECONDARY].attachments_1p}),
                            ranged_weapon = table_merge_recursive(self._weapon_extension._weapons[SLOT_SECONDARY],
                                {attachment_units = slot.attachments_by_unit_1p and slot.attachments_by_unit_1p[slot.unit_1p]}),

                                -- attachments_by_unit_1p
                        })
                    end
                end

            end
        elseif flashlight_extension then
            -- Remove FlashlightExtension
            mod:remove_extension(self._unit, "flashlight_system")

        end
    end

    instance.on_settings_changed = function(self)
        self.use_sling_system = mod:get("mod_option_sling")
        self.use_crouch_animation_system = mod:get("mod_option_crouch_animation")
        self.use_dof_system = mod:get("mod_option_misc_weapon_dof")
        self.use_sway_system = mod:get("mod_option_sway")
        self.use_flashlight_system = mod:get("mod_option_flashlight")
        self.use_sight_system = mod:get("mod_option_scopes")
        self.use_visible_equipment_system = mod:get("mod_option_visible_equipment")
        self.disable_visible_equipment_system_in_hub = mod:get("mod_option_visible_equipment_disable_in_hub")
    end
    
end)

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #########################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #########################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #########################################################################

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "init", function(func, self, extension_init_context, unit, extension_init_data, game_object_data_or_game_session, unit_spawn_parameter_or_game_object_id, ...)

    self.wc_initialized = true

    -- Original function
    func(self, extension_init_context, unit, extension_init_data, game_object_data_or_game_session, unit_spawn_parameter_or_game_object_id, ...)

    managers.event:register(self, "weapon_customization_settings_changed", "on_settings_changed")

    self:on_settings_changed()

end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "extensions_ready", function(func, self, world, unit, ...)

    -- Original function
    func(self, world, unit, ...)

    mod:on_player_unit_loaded(self._unit)

end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "destroy", function(func, self, ...)

    self.wc_initialized = false

    -- Remove custom extensions
    self:remove_custom_extensions()

    mod:on_player_unit_destroyed(self._unit)

    managers.event:unregister(self, "weapon_customization_settings_changed")

    -- Original function
    func(self, ...)

end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "update", function(func, self, unit, dt, t, ...)

    -- Original function
    func(self, unit, dt, t, ...)

    if self.wc_initialized and self:unit_3p_from_slot(SLOT_SECONDARY) then

        -- Visible equipment
        self:update_visible_equipment(dt, t)

        -- Sling
        -- self:update_sling(dt, t)

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

    end

end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "_equip_item_to_slot", function(func, self, item, slot_name, t, optional_existing_unit_3p, from_server_correction_occurred, ...)
    
    -- Original function
    func(self, item, slot_name, t, optional_existing_unit_3p, from_server_correction_occurred, ...)

    -- Extensions
    if self.wc_initialized and slot_name == SLOT_SECONDARY then
        self:remove_custom_extensions()
    end

end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "_unequip_item_from_slot", function(func, self, slot_name, from_server_correction_occurred, fixed_frame, from_destroy, ...)

    -- Original function
    func(self, slot_name, from_server_correction_occurred, fixed_frame, from_destroy, ...)

    -- Remove custom extensions
    if self.wc_initialized and slot_name == SLOT_SECONDARY then
        self:remove_custom_extensions()
    end

end)