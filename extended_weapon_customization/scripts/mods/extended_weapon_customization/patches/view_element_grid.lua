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

mod:hook_require("scripts/ui/view_elements/view_element_grid/view_element_grid", function(instance)

    instance.find_button = function(self, layout)
        for _, button in pairs(layout) do
            if button.customize then return true end
        end
    end

    instance.inject_button = function(self, layout)
        if not self:find_button(layout) then
            layout[#layout+1] = {
                display_icon = "",
                customize = true,
                widget_type = "button",
                display_name = mod:localize("mod_customize_button"),
                callback = callback(self, "cb_on_customize_pressed"),
            }
            self._menu_settings.grid_size[1] = 300
            self._menu_settings.mask_size[1] = 300
            self._menu_settings.grid_size[2] = #layout * 86
            self._menu_settings.mask_size[2] = #layout * 86
        end
    end

    instance.cb_on_customize_pressed = function(self)
        -- mod:echo("cb_on_customize_pressed")
        if not managers.ui:view_active("inventory_weapon_cosmetics_view") then
            self._customize_view_opened = true
            managers.ui:open_view("inventory_weapon_cosmetics_view", nil, nil, nil, nil, {
                player = self._preview_player,
                preview_item = self._parent._previewed_item,
                parent = self._parent,
                customize_attachments = true,
                new_items_gear_ids = self._parent and self._parent._new_items_gear_ids,
            })
        end
    end

end)

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.ViewElementGrid, "present_grid_layout", function(func, self, layout, content_blueprints, left_click_callback, right_click_callback, display_name, optional_grow_direction, optional_on_present_callback, optional_left_double_click_callback, ...)
    if self.__destroyed then return end
    -- Inject button
    if self._element_view_id == WEAPON_OPTIONS_VIEW then
        self:inject_button(layout)
    end
    -- Original function
    func(self, layout, content_blueprints, left_click_callback, right_click_callback, display_name, optional_grow_direction, optional_on_present_callback, optional_left_double_click_callback, ...)
    -- Update size
    self:_update_window_size()
end)
