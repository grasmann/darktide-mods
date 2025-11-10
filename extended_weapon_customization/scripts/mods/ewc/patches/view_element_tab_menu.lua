local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.view_element_tab_menu_is_hovered = function (self, view_element_tab_menu)
	local widgets_by_name = view_element_tab_menu._widgets_by_name
	local interaction_widget = widgets_by_name.grid_interaction
	local is_tab_menu_hovered = view_element_tab_menu._using_cursor_navigation and (interaction_widget.content.hotspot.is_hover or false)

	is_tab_menu_hovered = is_tab_menu_hovered and not view_element_tab_menu._input_disabled

	return is_tab_menu_hovered
end

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/ui/view_elements/view_element_tab_menu/view_element_tab_menu", function(instance)

    instance.hovered = function(self)
        return mod:view_element_tab_menu_is_hovered(self)
    end

end)
