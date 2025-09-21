local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local pairs = pairs
    local CLASS = CLASS
    local callback = callback
    local managers = Managers
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local WEAPON_OPTIONS_VIEW = "inventory_weapons_view_weapon_options"

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod.view_element_grid_find_button = function(self, view_element_grid, layout)
    for _, button in pairs(layout) do
        if button.customize then return true end
    end
end

mod.view_element_grid_inject_button = function(self, view_element_grid, layout)
    if not self:view_element_grid_find_button(view_element_grid, layout) then
        layout[#layout+1] = {
            display_icon = "",
            customize = true,
            widget_type = "button",
            display_name = mod:localize("mod_customize_button"),
            callback = callback(self, "view_element_grid_cb_on_customize_pressed", view_element_grid),
        }
        view_element_grid._menu_settings.grid_size[1] = 300
        view_element_grid._menu_settings.mask_size[1] = 300
        view_element_grid._menu_settings.grid_size[2] = #layout * 86
        view_element_grid._menu_settings.mask_size[2] = #layout * 86
    end
end

mod.view_element_grid_cb_on_customize_pressed = function(self, view_element_grid)
    if not managers.ui:view_active("inventory_weapon_cosmetics_view") then
        view_element_grid._customize_view_opened = true
        managers.ui:open_view("inventory_weapon_cosmetics_view", nil, nil, nil, nil, {
            player = view_element_grid._preview_player,
            preview_item = view_element_grid._parent._previewed_item,
            parent = view_element_grid._parent,
            customize_attachments = true,
            new_items_gear_ids = view_element_grid._parent and view_element_grid._parent._new_items_gear_ids,
        })
    end
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.ViewElementGrid, "present_grid_layout", function(func, self, layout, content_blueprints, left_click_callback, right_click_callback, display_name, optional_grow_direction, optional_on_present_callback, optional_left_double_click_callback, ...)
    if self.__destroyed then return end
    -- Inject button
    if self._element_view_id == WEAPON_OPTIONS_VIEW then
        mod:view_element_grid_inject_button(self, layout)
    end
    -- Original function
    func(self, layout, content_blueprints, left_click_callback, right_click_callback, display_name, optional_grow_direction, optional_on_present_callback, optional_left_double_click_callback, ...)
    -- Update size
    self:_update_window_size()
end)

mod:hook(CLASS.ViewElementGrid, "_create_entry_widget_from_config", function(func, self, config, suffix, callback_name, secondary_callback_name, double_click_callback_name, ...)
    -- Check widget type
    if not config.widget_type then
        -- Set widget type
        config.widget_type = "gear_set"
    end
    -- Original function
    return func(self, config, suffix, callback_name, secondary_callback_name, double_click_callback_name, ...)
end)
