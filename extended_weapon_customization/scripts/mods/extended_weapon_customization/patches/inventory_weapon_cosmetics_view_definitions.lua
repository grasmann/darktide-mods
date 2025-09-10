local mod = get_mod("extended_weapon_customization")

local inventory_weapon_cosmetics_view_definitions = mod:original_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view_definitions")
local master_items = mod:original_require("scripts/backend/master_items")
local items = mod:original_require("scripts/utilities/items")
local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")
local Promise = mod:original_require("scripts/foundation/utilities/promise")
local ViewElementTabMenu = mod:original_require("scripts/ui/view_elements/view_element_tab_menu/view_element_tab_menu")
local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
local ButtonPassTemplates = mod:original_require("scripts/ui/pass_templates/button_pass_templates")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local utf8 = Utf8
    local math = math
    local table = table
    local pairs = pairs
    local CLASS = CLASS
    local string = string
    local vector3 = Vector3
    local callback = callback
    local managers = Managers
    local localize = Localize
    local math_uuid = math.uuid
    local utf8_upper = utf8.upper
    local quaternion = Quaternion
    local vector3_zero = vector3.zero
    local string_format = string.format
    local quaternion_box = QuaternionBox
    local quaternion_identity = quaternion.identity
    local table_clone_instance = table.clone_instance
    local quaternion_from_vector = quaternion.from_vector
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local WEAPON_OPTIONS_VIEW = "inventory_weapons_view_weapon_options"

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view_definitions", function(instance)

    instance.scenegraph_definition.item_grid_pivot.position[1] = 320
    instance.scenegraph_definition.button_pivot.position[1] = -290
    instance.scenegraph_definition.button_pivot_background.position[1] = 75
    instance.scenegraph_definition.info_box.position[1] = 0
    instance.scenegraph_definition.equip_button.position[1] = -100

    instance.widget_definitions.button_pivot_background = UIWidget.create_definition({
		{
			pass_type = "texture",
			style_id = "background",
			value = "content/ui/materials/backgrounds/terminal_basic",
			value_id = "background",
			style = {
				horizontal_alignment = "center",
				scale_to_material = true,
				vertical_alignment = "center",
				color = Color.terminal_grid_background(255, true),
				size_addition = {170, 20},
				offset = {0, 0, 0},
			},
		},
		{
			pass_type = "texture",
			value = "content/ui/materials/frames/tab_frame_upper",
			style = {
				horizontal_alignment = "center",
				vertical_alignment = "top",
				color = Color.white(255, true),
				size = {300, 14},
				offset = {0, -5, 1},
			},
		},
		{
			pass_type = "texture",
			value = "content/ui/materials/frames/tab_frame_lower",
			style = {
				horizontal_alignment = "center",
				vertical_alignment = "bottom",
				color = Color.white(255, true),
				size = {299, 14},
				offset = {0, 5, 1},
			},
		},
	}, "button_pivot_background")

end)
