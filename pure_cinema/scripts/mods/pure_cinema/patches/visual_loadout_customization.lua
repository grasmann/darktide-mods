local mod = get_mod("pure_cinema")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local CLASS = CLASS
    local world = World
-- #endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.VisualLoadoutCustomization, "_spawn_attachment", function(func, item_data, attach_settings, parent_unit, optional_mission_template, optional_as_leaf_override_attach_node, optional_as_leaf_map_mode, ...)

    local _force_link = item_data.force_link_children

    if attach_settings.is_minion then
        attach_settings.skip_link_children = true
        item_data.force_link_children = false
        optional_as_leaf_map_mode = world.LINK_MODE_NODE_NAME
    end

    local a, b, c, d, e, f, g, h, i, j, k, l, m, n = func(item_data, attach_settings, parent_unit, optional_mission_template, optional_as_leaf_override_attach_node, optional_as_leaf_map_mode, ...)

    item_data.force_link_children = _force_link

    return a, b, c, d, e, f, g, h, i, j, k, l, m, n

end)

mod:hook(CLASS.VisualLoadoutCustomization, "spawn_item", function(func, item_data, attach_settings, parent_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment, ...)

    local _force_link = item_data.force_link_children

    if attach_settings.is_minion then
        attach_settings.skip_link_children = true
        item_data.force_link_children = false
    end

    local a, b, c, d, e, f, g, h, i, j, k, l, m, n = func(item_data, attach_settings, parent_unit, optional_map_attachment_name_to_unit, optional_extract_attachment_units_bind_poses, optional_extract_item_names, optional_mission_template, optional_equipment, ...)

    item_data.force_link_children = _force_link

    return a, b, c, d, e, f, g, h, i, j, k, l, m, n

end)
