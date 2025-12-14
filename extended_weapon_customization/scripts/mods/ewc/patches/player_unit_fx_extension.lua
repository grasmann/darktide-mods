local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local VisualLoadoutCustomization = mod:original_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization")

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

	spawners[VisualLoadoutCustomization.ROOT_ATTACH_NAME] = {
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
		local parent_id_name = attachment_name_lookup and attachment_name_lookup[parent_unit] or VisualLoadoutCustomization.ROOT_ATTACH_NAME

		sources[parent_id_name] = _register_sound_source(wwise_source_node_cache, parent_unit, node_name, wwise_world, source_name)
	end

	if not table.is_empty(sources) then
		return sources
	end

	sources[VisualLoadoutCustomization.ROOT_ATTACH_NAME] = _register_sound_source(wwise_source_node_cache, parent_unit, 1, wwise_world, source_name)

	return sources
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.PlayerUnitFxExtension, "_register_vfx_spawner", function(func, self, spawners, spawner_name, parent_unit, attachments_by_unit, attachment_name_lookup, node_name, should_add_3p_node, ...)

    local result

	if attachments_by_unit and not table_is_empty(attachments_by_unit[parent_unit]) then
        result = _register_vfx_spawner_from_attachments(parent_unit, attachments_by_unit, attachment_name_lookup, node_name, spawner_name)
    end

    if not result or table_is_empty(result) then
		local node = unit_has_node(parent_unit, node_name) and unit_node(parent_unit, node_name) or 1

        result = {}
        result[VisualLoadoutCustomization.ROOT_ATTACH_NAME] = {
			unit = parent_unit,
			node = node,
            node_3p = should_add_3p_node and (
                unit_has_node(self._unit, node_name) and unit_node(self._unit, node_name) or 1
            ) or nil,
		}
	end

    spawners[spawner_name] = result
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
