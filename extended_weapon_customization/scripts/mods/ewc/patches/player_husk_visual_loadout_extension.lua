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

mod.player_husk_visual_loadout_extension_randomize = function(self, player, item, slot_name) --, player, slot_name, visual_loadout)
    -- local husk_item = mod:handle_husk_item(item, player)
    -- if husk_item then
    --     -- local player = player_husk_visual_loadout_extension._player
    --     -- local profile = player:profile()
    --     -- local visual_loadout = profile.visual_loadout
    --     -- Set modded item in profile
    --     -- visual_loadout[slot_name] = husk_item
    --     -- Reevaluate packages
    --     -- mod:print("reevaluate_packages "..tostring(player))
    --     -- mod:reevaluate_packages(player)
    -- end
    -- return item
    return mod:handle_husk_item(item, player)
end

mod:hook(CLASS.PlayerHuskVisualLoadoutExtension, "init", function(func, self, extension_init_context, unit, extension_init_data, ...)

    local world = extension_init_context.world

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
                is_local_unit = false,
                visual_loadout_extension = self,
                player = extension_init_data.player,
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
                -- from_ui_profile_spawner = self._equipment_component._from_ui_profile_spawner,
            }
        )
    end

    -- Original function
    func(self, extension_init_context, unit, extension_init_data, ...)

    self.flashlight_extension_update = true
    self.sight_extension_update = true
    self.attachment_callback_extension_update = true

    -- Destroy mispredict handler
    self._mispredict_package_handler = nil

end)

mod:hook(CLASS.PlayerHuskVisualLoadoutExtension, "_equip_item_to_slot", function(func, self, slot_name, item, optional_existing_unit_3p, ...)
    -- Original function
    func(self, slot_name, item, optional_existing_unit_3p, ...)

    if slot_name == SLOT_SECONDARY then
        self.sight_extension_update = true
        self.flashlight_extension_update = true
    end

    if table_contains(PROCESS_SLOTS, slot_name) then
        self.attachment_callback_extension_update = true
    end

end)

mod:hook(CLASS.PlayerHuskVisualLoadoutExtension, "wield_slot", function(func, self, slot_name, ...)

    -- Original function
    func(self, slot_name, ...)

    local equipment = self._equipment
    local equipment_component = self._equipment_component
    local first_person_mode = self._first_person_extension:is_in_first_person_mode()
    equipment_component.wield_slot(equipment[slot_name], first_person_mode)

end)

mod:hook(CLASS.PlayerHuskVisualLoadoutExtension, "update", function(func, self, unit, dt, t, ...)
    -- Original function
    func(self, unit, dt, t, ...)

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

mod:hook(CLASS.PlayerHuskVisualLoadoutExtension, "destroy", function(func, self, ...)

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

mod:hook(CLASS.PlayerHuskVisualLoadoutExtension, "rpc_player_equip_item_from_profile_to_slot", function(func, self, channel_id, go_id, slot_id, debug_item_id, ...)

    local slot_name = NetworkLookup.player_inventory_slot_names[slot_id]
	local player = self._player
	local profile = player:profile()
	local visual_loadout = profile.visual_loadout
	local item = visual_loadout[slot_name]

    -- Randomize weapon for other player
    -- item = 
    mod:player_husk_visual_loadout_extension_randomize(player, item, slot_name)

	self:_equip_item_to_slot(slot_name, item)

end)
