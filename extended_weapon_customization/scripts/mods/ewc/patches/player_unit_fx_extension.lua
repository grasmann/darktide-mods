local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local VisualLoadoutCustomization = mod:original_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization")
local VisualLoadoutExtractData = mod:original_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_extract_data")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local pairs = pairs
    local table = table
    local CLASS = CLASS
	local tonumber = tonumber
    local unit_node = unit.node
	local table_size = table.size
	local wwise_world = WwiseWorld
	local script_unit = ScriptUnit
    local unit_has_node = unit.has_node
    local table_is_empty = table.is_empty
	local script_unit_extension = script_unit.extension
	local wwise_world_make_manual_source = wwise_world.make_manual_source
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local pt = mod:pt()

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

-- local function _register_vfx_spawner_from_attachment_list(attachments_by_unit, attachment_name_lookup, node_name, spawners)
-- 	local spawners = spawners or {}
-- 	local exclude_from_vfx_spawner = pt.exclude_from_vfx_spawner
-- 	for unit, attachments in pairs(attachments_by_unit) do
-- 		for i = 1, #attachments do
-- 			local attachment_unit = attachments[i]

--             if not exclude_from_vfx_spawner[attachment_unit] then

--                 if unit_has_node(attachment_unit, node_name) then
--                     local attachment_name = attachment_name_lookup[unit]
--                     local node = unit_node(attachment_unit, node_name)

--                     spawners[attachment_name] = {
--                         unit = attachment_unit,
--                         node = node,
--                     }

--                     break
--                 end
--             end

-- 			-- Sub-attachments
-- 			if attachments_by_unit[attachment_unit] then
-- 				_register_vfx_spawner_from_attachment_list(attachments_by_unit[attachment_unit], attachment_name_lookup, node_name, spawners)
-- 			end
-- 		end
-- 	end
-- 	return spawners
-- end

local function _register_vfx_spawner_from_attachments(parent_unit, attachments_by_unit, attachment_name_lookup, node_name, spawner_name)
	local spawners = {}
	local exclude_from_vfx_spawner = pt.exclude_from_vfx_spawner

	for unit, attachments in pairs(attachments_by_unit) do
		for i = 1, #attachments do
			local attachment_unit = attachments[i]

            if not exclude_from_vfx_spawner[attachment_unit] then

                if unit_has_node(attachment_unit, node_name) then
                    local attachment_name = attachment_name_lookup[unit]
                    local node = unit_node(attachment_unit, node_name)

                    spawners[attachment_name] = {
                        unit = attachment_unit,
                        node = node,
                    }

                    break
                end

				if attachments_by_unit[attachment_unit] then

					for _, sub_attachment_unit in pairs(attachments_by_unit[attachment_unit]) do
						if unit_has_node(sub_attachment_unit, node_name) then
							local sub_attachment_name = attachment_name_lookup[sub_attachment_unit]
							local sub_node = unit_node(sub_attachment_unit, node_name)

							spawners[sub_attachment_name] = {
								unit = sub_attachment_unit,
								node = sub_node,
							}

							break

						end
					end

				end

            end
		end
	end

	-- local spawners = _register_vfx_spawner_from_attachment_list(attachments_by_unit, attachment_name_lookup, node_name)

	if unit_has_node(parent_unit, node_name) then
		local parent_id_name = attachment_name_lookup[parent_unit]
		local node = unit_node(parent_unit, node_name)

		spawners[parent_id_name] = {
			unit = parent_unit,
			node = node,
		}
	end

	if not table_is_empty(spawners) then
		return spawners
	end

	spawners[VisualLoadoutExtractData.ROOT_ATTACH_NAME] = {
		node = 1,
		unit = parent_unit,
	}

	return spawners
end

local function _register_sound_source(wwise_source_node_cache, unit, node_name, wwise_world, source_name)
	if not wwise_source_node_cache[unit] then
		wwise_source_node_cache[unit] = {}
	end

	local unit_cache = wwise_source_node_cache[unit]

	if not unit_cache[node_name] then
		local node = tonumber(node_name) or unit_node(unit, node_name)
		local source = wwise_world_make_manual_source(wwise_world, unit, node)

		unit_cache[node_name] = {
			num_registered_sources = 0,
			source = source,
		}
	end

	local cache = unit_cache[node_name]

	cache.num_registered_sources = cache.num_registered_sources + 1

	local source_name_to_node_cache_lookup = {
		unit = unit,
		node_name = node_name,
	}

	wwise_source_node_cache[source_name] = source_name_to_node_cache_lookup

	return cache.source
end

local function _register_sound_sources(wwise_source_node_cache, parent_unit, attachments_by_unit, attachment_name_lookup, node_name, wwise_world, source_name)
	local has_any_attachments = false
	local sources = {}

	if attachments_by_unit then
		for unit, attachments in pairs(attachments_by_unit) do
			local num_attachments = #attachments

			for ii = 1, num_attachments do
				has_any_attachments = true

				local attachment_unit = attachments[ii]

				if unit_has_node(attachment_unit, node_name) then
					local attachment_name = attachment_name_lookup[unit]

					sources[attachment_name] = _register_sound_source(wwise_source_node_cache, attachment_unit, node_name, wwise_world, source_name)

					break
				end

				if attachments_by_unit[attachment_unit] then

					for _, sub_attachment_unit in pairs(attachments_by_unit[attachment_unit]) do
						if unit_has_node(sub_attachment_unit, node_name) then
							local attachment_name = attachment_name_lookup[unit]

							sources[attachment_name] = _register_sound_source(wwise_source_node_cache, sub_attachment_unit, node_name, wwise_world, source_name)

						end
					end

				end

			end
		end
	end

	if unit_has_node(parent_unit, node_name) then
		local parent_id_name = attachment_name_lookup and attachment_name_lookup[parent_unit] or VisualLoadoutExtractData.ROOT_ATTACH_NAME

		sources[parent_id_name] = _register_sound_source(wwise_source_node_cache, parent_unit, node_name, wwise_world, source_name)
	end

	if not table.is_empty(sources) then
		return sources
	end

	sources[VisualLoadoutExtractData.ROOT_ATTACH_NAME] = _register_sound_source(wwise_source_node_cache, parent_unit, 1, wwise_world, source_name)

	return sources
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.PlayerUnitFxExtension, "sound_source", function(func, self, source_name, optional_attachment_name, ...)

	-- Original function
	local sound_source = self._sources[source_name]
	local sound_source_id = func(self, source_name, optional_attachment_name, ...)

	sound_source_id = sound_source_id or sound_source[VisualLoadoutExtractData.ROOT_ATTACH_NAME]

	return sound_source_id

end)

mod:hook(CLASS.PlayerUnitFxExtension, "vfx_spawner_unit_and_node", function(func, self, spawner_name, optional_attachment_name, ...)
	local vfx_spawner = self._vfx_spawners[spawner_name]
	local reference_attachment_name = optional_attachment_name or VisualLoadoutExtractData.ROOT_ATTACH_NAME

	vfx_spawner = vfx_spawner and vfx_spawner[reference_attachment_name] or vfx_spawner

	if vfx_spawner then

		-- Spawner found
		return func(self, spawner_name, optional_attachment_name, ...)

	else

		-- Fallback to the first spawner in the group
		for spawner, _ in pairs(self._vfx_spawners) do
			vfx_spawner = spawner and spawner[reference_attachment_name] or spawner[VisualLoadoutExtractData.ROOT_ATTACH_NAME]
			break
		end

		if vfx_spawner then

			-- Fallback to the first spawner
			local unit_3p = vfx_spawner.node_3p and self._unit or vfx_spawner.unit
			local node_3p = vfx_spawner.node_3p or vfx_spawner.node

			return vfx_spawner.unit, vfx_spawner.node, unit_3p, node_3p

		else

			-- Absolute fallback to the player unit and node 1 if no spawner is found
			-- This is a last resort and should not happen in normal circumstances
			return self._unit, 1, self._unit, 1

		end
	end

end)

mod:hook(CLASS.PlayerUnitFxExtension, "_register_vfx_spawner", function(func, self, spawners, spawner_name, parent_unit, attachments_by_unit, attachment_name_lookup, node_name, should_add_3p_node, ...)

    local result

	if attachments_by_unit and not table_is_empty(attachments_by_unit[parent_unit]) then
        result = _register_vfx_spawner_from_attachments(parent_unit, attachments_by_unit, attachment_name_lookup, node_name, spawner_name)
    end

    if not result or table_is_empty(result) then
		local node = unit_has_node(parent_unit, node_name) and unit_node(parent_unit, node_name) or 1
		local node_3p
		if should_add_3p_node then
			node_3p = unit_has_node(self._unit, node_name) and unit_node(self._unit, node_name) or 1
		end

        result = {}

        result[VisualLoadoutExtractData.ROOT_ATTACH_NAME] = {
			unit = parent_unit,
			node = node,
            node_3p = node_3p,
		}
	end

    spawners[spawner_name] = result
end)

-- trigger_gear_wwise_event_with_source
mod:hook(CLASS.PlayerUnitFxExtension, "trigger_gear_wwise_event_with_source", function(func, self, sound_alias, external_properties, source_name, sync_to_clients, include_client, optional_attachment_name, ...)
	-- local is_resim = self._unit_data_extension.is_resimulating

	-- if is_resim then
	-- 	return
	-- end

	-- local resolved, event_name, has_husk_events = self._visual_loadout_extension:resolve_gear_sound(sound_alias, external_properties)

	-- if resolved then
	-- 	local source = self._sources[source_name]
	-- 	local reference_attachment_name = optional_attachment_name or VisualLoadoutExtractData.ROOT_ATTACH_NAME

	-- 	source = source[reference_attachment_name]

	-- 	if sync_to_clients and self._is_server then
	-- 		local channel_id, game_object_id = self._player:channel_id(), self._game_object_id
	-- 		local event_id = NetworkLookup.player_character_sounds[event_name]
	-- 		local source_id = NetworkLookup.player_character_fx_sources[source_name]
	-- 		local attachment_id = NetworkLookup.player_attachment_names[reference_attachment_name]

	-- 		if include_client then
	-- 			Managers.state.game_session:send_rpc_clients("rpc_play_player_sound", game_object_id, event_id, source_id, attachment_id, not not has_husk_events)
	-- 		else
	-- 			Managers.state.game_session:send_rpc_clients_except("rpc_play_player_sound", channel_id, game_object_id, event_id, source_id, attachment_id, not not has_husk_events)
	-- 		end
	-- 	end

	-- 	return self:trigger_wwise_event(event_name, has_husk_events, source)
	-- end

	return func(self, sound_alias, external_properties, source_name, sync_to_clients, include_client, optional_attachment_name, ...)

end)

-- trigger_exclusive_gear_wwise_event
mod:hook(CLASS.PlayerUnitFxExtension, "trigger_exclusive_gear_wwise_event", function(func, self, sound_alias, external_properties, optional_position, optional_except_sender, optional_parameter_name, optional_parameter_value, ...)
	-- local is_resim = self._unit_data_extension.is_resimulating

	-- if is_resim then
	-- 	return
	-- end

	-- local resolved, event_name, _ = self._visual_loadout_extension:resolve_gear_sound(sound_alias, external_properties)

	-- if not resolved then
	-- 	return
	-- end

	-- self:trigger_exclusive_wwise_event(event_name, optional_position, optional_except_sender, optional_parameter_name, optional_parameter_value)

	return func(self, sound_alias, external_properties, optional_position, optional_except_sender, optional_parameter_name, optional_parameter_value, ...)

end)

mod:hook(CLASS.PlayerUnitFxExtension, "_register_sound_source", function(func, self, sources, source_name, parent_unit, attachments_by_unit, attachment_name_lookup, optional_node_name, ...)
	local wwise_source_node_cache = self._wwise_source_node_cache
	local wwise_world = self._wwise_world
	local source_by_attachment = _register_sound_sources(wwise_source_node_cache, parent_unit, attachments_by_unit, attachment_name_lookup, optional_node_name or 1, wwise_world, source_name)

	sources[source_name] = source_by_attachment
end)

mod:hook(CLASS.PlayerUnitFxExtension, "spawn_unit_particles", function(func, self, particle_name, spawner_name, link, orphaned_policy, position_offset, rotation_offset, scale, all_clients, create_network_index, optional_attachment_name, ...)

	local unit_data_extension = self._unit_data_extension
	local inventory_component = unit_data_extension:read_component("inventory")
	local current_wielded_slot = inventory_component.wielded_slot
	local item = self._visual_loadout_extension:item_from_slot(current_wielded_slot)
	local gear_id = mod:gear_id(item)

	if gear_id and mod.fx_overrides[gear_id] and mod.fx_overrides[gear_id][particle_name] then
		particle_name = mod.fx_overrides[gear_id][particle_name] or particle_name
	end

	-- Original function
	return func(self, particle_name, spawner_name, link, orphaned_policy, position_offset, rotation_offset, scale, all_clients, create_network_index, optional_attachment_name, ...)
end)

mod:hook(CLASS.PlayerUnitFxExtension, "_spawn_unit_fx_line", function(func, self, line_effect, is_critical_strike, spawner_name, end_position, link, orphaned_policy, scale, append_husk_to_event_name, optional_attachment_name, ...)

	-- Check if spawner group exists
	if not self._vfx_spawners[spawner_name] then
		-- Create new spawner group
		self._vfx_spawners[spawner_name] = {}
	else
		-- Find first attachment from spawner group
		for k, v in pairs(self._vfx_spawners[spawner_name]) do
			optional_attachment_name = k
			break
		end
	end

	local reference_attachment_name = optional_attachment_name or VisualLoadoutExtractData.ROOT_ATTACH_NAME

	-- Check if reference attachment exists
	if not self._vfx_spawners[spawner_name][reference_attachment_name] then
		-- Create new reference attachment
		self._vfx_spawners[spawner_name][reference_attachment_name] = {
			node = 1,
			node_3p = 1,
			unit = self._unit,
		}
	end

	-- Original function
	return func(self, line_effect, is_critical_strike, spawner_name, end_position, link, orphaned_policy, scale, append_husk_to_event_name, optional_attachment_name, ...)

end)

mod:hook(CLASS.PlayerUnitFxExtension, "_spawn_unit_particles", function(func, self, particle_name, spawner_name, link, orphaned_policy, position_offset, rotation_offset, scale, create_network_index, optional_attachment_name, ...)

	-- Check if spawner group exists
	if not self._vfx_spawners[spawner_name] then
		-- Create new spawner group
		self._vfx_spawners[spawner_name] = {}
	else
		-- Find first attachment from spawner group
		for k, v in pairs(self._vfx_spawners[spawner_name]) do
			optional_attachment_name = k
			break
		end
	end

	local reference_attachment_name = optional_attachment_name or VisualLoadoutExtractData.ROOT_ATTACH_NAME

	-- Check if reference attachment exists
	if not self._vfx_spawners[spawner_name][reference_attachment_name] then
		-- Create new reference attachment
		self._vfx_spawners[spawner_name][reference_attachment_name] = {
			node = 1,
			node_3p = 1,
			unit = self._unit,
		}
	end

	-- Original function
	return func(self, particle_name, spawner_name, link, orphaned_policy, position_offset, rotation_offset, scale, create_network_index, optional_attachment_name, ...)

end)
