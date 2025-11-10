local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local ViewElementTabMenuSettings = mod:original_require("scripts/ui/view_elements/view_element_tab_menu/view_element_tab_menu_settings")
local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local button_size = ViewElementTabMenuSettings.button_size

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/ui/view_elements/view_element_tab_menu/view_element_tab_menu_definitions", function(instance)

    instance.scenegraph_definition.grid_interaction = {
        horizontal_alignment = "left",
        parent = "entry_pivot",
        vertical_alignment = "top",
        size = {button_size[1], 900},
        position = {0, 0, 0},
    }

    instance.widget_definitions.grid_interaction = UIWidget.create_definition({
        {
            content_id = "hotspot",
            pass_type = "hotspot",
        },
    }, "grid_interaction")

end)
