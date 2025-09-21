local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local VisualLoadoutCustomization = mod:original_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local log = Log
    local unit = Unit
    local pairs = pairs
    local table = table
    local CLASS = CLASS
    local string = string
    local tostring = tostring
    local unit_node = unit.node
    local string_format = string.format
    local log_exception = log.exception
    local unit_has_node = unit.has_node
    local table_is_empty = table.is_empty
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

local function _register_vfx_spawner_from_attachments(parent_unit, attachments_by_unit, attachment_name_lookup, node_name, spawner_name)
	local spawners = {}

	for unit, attachments in pairs(attachments_by_unit) do
		for i = 1, #attachments do
			local attachment_unit = attachments[i]

            if not mod:pt().exclude_from_vfx_spawner[attachment_unit] then

                if unit_has_node(attachment_unit, node_name) then
                    local attachment_name = attachment_name_lookup[unit]
                    local node = unit_node(attachment_unit, node_name)

                    spawners[attachment_name] = {
                        unit = attachment_unit,
                        node = node,
                    }

                    break
                end
            end
		end
	end

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

	local attachment_string = ""
	local attachments = attachments_by_unit[parent_unit]

	for ii = 1, #attachments do
		local unit = attachments[ii]

		attachment_string = string_format("%s%s, ", attachment_string, tostring(unit))
	end

	log_exception("PlayerUnitFxExtension", "Could not register vfx spawner %q. Node %q could not be found in any of the given attachment (%q) units nor parent unit (%q)", spawner_name, node_name, attachment_string, tostring(parent_unit))

	spawners[VisualLoadoutCustomization.ROOT_ATTACH_NAME] = {
		node = 1,
		unit = parent_unit,
	}

	return spawners
end

mod:hook(CLASS.PlayerUnitFxExtension, "_register_vfx_spawner", function(func, self, spawners, spawner_name, parent_unit, attachments_by_unit, attachment_name_lookup, node_name, should_add_3p_node, ...)
	if attachments_by_unit and not table_is_empty(attachments_by_unit[parent_unit]) then
		local spawner = _register_vfx_spawner_from_attachments(parent_unit, attachments_by_unit, attachment_name_lookup, node_name, spawner_name)

		spawners[spawner_name] = spawner
	else
		spawners[spawner_name] = {}

		local node = unit_has_node(parent_unit, node_name) and unit_node(parent_unit, node_name) or 1
		local node_3p

		if should_add_3p_node then
			node_3p = unit_has_node(self._unit, node_name) and unit_node(self._unit, node_name) or 1
		end

		spawners[spawner_name][VisualLoadoutCustomization.ROOT_ATTACH_NAME] = {
			unit = parent_unit,
			node = node,
			node_3p = node_3p,
		}
	end
end)
