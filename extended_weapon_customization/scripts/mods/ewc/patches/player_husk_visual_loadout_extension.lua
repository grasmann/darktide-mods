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
    local ferror = ferror
    local network = Network
    local tostring = tostring
    local managers = Managers
    local crashify = Crashify
    local script_unit = ScriptUnit
    local table_contains = table.contains
    local network_peer_id = network.peer_id
    local script_unit_extension = script_unit.extension
    local crashify_print_exception = crashify.print_exception
    local script_unit_add_extension = script_unit.add_extension
    local script_unit_remove_extension = script_unit.remove_extension
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local SLOT_SECONDARY = "slot_secondary"
local SLOT_PRIMARY = "slot_primary"
local PROCESS_SLOTS = {SLOT_PRIMARY, SLOT_SECONDARY}
-- local sight_extension_update = false
-- local flashlight_extension_update = false
-- local attachment_callback_extension_update = false

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod.player_husk_visual_loadout_extension_randomize = function(self, player_husk_visual_loadout_extension, item, slot_name) --, player, slot_name, visual_loadout)
    local husk_item = mod:handle_husk_item(item)
    if husk_item then
        local player = player_husk_visual_loadout_extension._player
        local profile = player:profile()
        local visual_loadout = profile.visual_loadout
        -- Set modded item in profile
        visual_loadout[slot_name] = husk_item
        -- Reevaluate packages
        mod:print("reevaluate_packages "..tostring(player))
        mod:reevaluate_packages(player)
    end
    return item
end

mod:hook(CLASS.PlayerHuskVisualLoadoutExtension, "init", function(func, self, extension_init_context, unit, extension_init_data, ...)
    -- Original function
    func(self, extension_init_context, unit, extension_init_data, ...)

    self.flashlight_extension_update = true
    self.sight_extension_update = true
    self.attachment_callback_extension_update = true

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
                -- from_ui_profile_spawner = self._equipment_component._from_ui_profile_spawner,
            }
        )
    end

    if not script_unit_extension(self._unit, "attachment_callback_system") then
        script_unit_add_extension(
            {
                world = self._equipment_component._world,
            },
            self._unit,
            "AttachmentCallbackExtension",
            "attachment_callback_system",
            {
                visual_loadout_extension = self,
                player = self._player,
                -- from_ui_profile_spawner = self._equipment_component._from_ui_profile_spawner,
            }
        )
    end

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
                -- local attachment_callback_extension = script_unit_extension(self._unit, "attachment_callback_system")
                -- if attachment_callback_extension then
                attachment_callback_extension:on_equip_weapon()
                -- end
                self.attachment_callback_extension_update = nil
            end
        end

        -- local attachment_callback_extension = script_unit_extension(self._unit, "attachment_callback_system")
        -- if attachment_callback_extension then
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
    -- mod:player_husk_visual_loadout_extension_randomize(item, player, slot_name, visual_loadout)
    item = mod:player_husk_visual_loadout_extension_randomize(self, item, slot_name)

    local optional_existing_unit_3p
	local debug_item_name = NetworkLookup.player_item_names[debug_item_id]
	local client_item_name = item and item.name

	if client_item_name ~= debug_item_name then
		client_item_name = client_item_name or "N/A"

		local channel_peer_id = network_peer_id(channel_id)
		local player_peer_id = player:peer_id()

		crashify_print_exception("PlayerHuskVisualLoadoutExtension", "Client has a different item than server has in player profile.")
		ferror("[PlayerHuskVisualLoadoutExtension] Profile item mismatch. Failed to equip item `%s` in slot `%s`. Client item was `%s`", debug_item_name, slot_name, client_item_name)
	end

	self:_equip_item_to_slot(slot_name, item, optional_existing_unit_3p)

end)
