local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local inventory_weapon_cosmetics_view_definitions = mod:original_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view_definitions")
local ItemMaterialOverridesGearMaterials = mod:original_require("scripts/settings/equipment/item_material_overrides/item_material_overrides_gear_materials")
local ItemMaterialOverridesGearPatterns = mod:original_require("scripts/settings/equipment/item_material_overrides/item_material_overrides_gear_patterns")
local ItemMaterialOverridesGearColors = mod:original_require("scripts/settings/equipment/item_material_overrides/item_material_overrides_gear_colors")
local ViewElementTabMenu = mod:original_require("scripts/ui/view_elements/view_element_tab_menu/view_element_tab_menu")
local WwiseGameSyncSettings = mod:original_require("scripts/settings/wwise_game_sync/wwise_game_sync_settings")
local DropdownPassTemplates = mod:original_require("scripts/ui/pass_templates/dropdown_pass_templates")
local ButtonPassTemplates = mod:original_require("scripts/ui/pass_templates/button_pass_templates")
local ScriptCamera = mod:original_require("scripts/foundation/utilities/script_camera")
local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")
local InputDevice = mod:original_require("scripts/managers/input/input_device")
local master_items = mod:original_require("scripts/backend/master_items")
local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
local items = mod:original_require("scripts/utilities/items")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local utf8 = Utf8
    local math = math
    local table = table
    local pairs = pairs
    local CLASS = CLASS
    local color = Color
    local string = string
    local vector3 = Vector3
    local vector2 = Vector2
    local get_mod = get_mod
    local callback = callback
    local managers = Managers
    local localize = Localize
    local tostring = tostring
    local math_max = math.max
    local math_min = math.min
    local math_ceil = math.ceil
    local math_lerp = math.lerp
    local math_uuid = math.uuid
    local string_len = string.len
    local utf8_upper = utf8.upper
    local string_sub = string.sub
    local table_clear = table.clear
    local color_white = color.white
    -- local string_gsub = string.gsub
    local string_upper = string.upper
    local string_format = string.format
    -- local table_contains = table.contains
    local has_localization = HasLocalization
    local color_terminal_grid_background = color.terminal_grid_background
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local pt = mod:pt()
local temp_detached = {}
local temp_validated = {}
local temp_mod_count = {}
local temp_group_index = {}
local empty_table = {}
local empty_position = {0, 0, 0}
local alternate_fire_setting = "alternate_fire"
local crosshair_list_setting = "crosshair"
local damage_type_active_setting = "damage_type_active"
local dropdown_size = {400, 38}
local OVERRIDE_TYPE = table.enum("color", "pattern", "wear")

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

-- Get selectable attachment count from attachment data list
mod.selectable_attachment_count = function(self, attachment_entries)
    local count = 0
    -- Iterate through attachment entries
    for attachment_name, attachment_data in pairs(attachment_entries) do
        -- Check if attachment is selectable
        if not attachment_data.hide_from_selection then
            -- Increment count
            count = count + 1
        end
    end
    -- Return count
    return count
end

-- Modify inventory weapon cosmetics view definitions
mod.inventory_weapon_cosmetics_view_adjust_definitions = function(self, instance)

    instance.scenegraph_definition.item_grid_pivot.position[1] = 320
	instance.scenegraph_definition.button_pivot.position[1] = -270
	instance.scenegraph_definition.button_pivot_background.position[1] = 55
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
				color = color_terminal_grid_background(255, true),
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
				color = color_white(255, true),
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
				color = color_white(255, true),
				size = {299, 14},
				offset = {0, 5, 1},
			},
		},
	}, "button_pivot_background")

end

local compare_item_name = function(a, b)
    local a_display_name, b_display_name = a.id or "", b.id or ""

    a_display_name = a_display_name:gsub("[\n\r]", "")
    b_display_name = b_display_name:gsub("[\n\r]", "")

    if a_display_name < b_display_name then
        return true
    elseif b_display_name < a_display_name then
        return false
    end

    return nil
end

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view", function(instance)

    instance.selected_slot_name = function(self)
        local tab_content = self._tabs_content and self._selected_tab_index and self._tabs_content[self._selected_tab_index]
        return tab_content and tab_content.slot_name
    end

    -- ##### Update items #############################################################################################

    instance.update_presentation_item = function(self, optional_item)

        -- Get item
        local item = optional_item or self._selected_item
        -- Create presentation item from item
        self._presentation_item = master_items.create_preview_item_instance(item, true)
        -- Generate gear id
        local gear_id = math_uuid()
        -- Set presentation item gear id
        self._presentation_item.gear_id = gear_id
        self._presentation_item.__gear_id = gear_id
        self._presentation_item.__original_gear_id = gear_id
        self._presentation_item.__attachment_customization = true

        -- Mark gear id origin
        pt.items_originating_from_customization_menu[gear_id] = true
        -- Preview presentation item
        self:_preview_item(self._presentation_item)

        -- Switch tab
        self:cb_switch_tab(1)

    end

    instance.update_real_world_item = function(self, optional_item)

        -- Get item
        local item = optional_item or self._selected_item

        -- -- Gear id
        -- local gear_id = mod:gear_id(item)
        -- -- Clear cached item
        -- mod:clear_mod_item(gear_id)

        -- Trigger item icon update
        managers.ui:item_icon_updated(item)
        managers.event:trigger("event_item_icon_updated", item)
        managers.event:trigger("event_replace_list_item", item)

        -- Reevaluate packages
        mod:reevaluate_packages()
        -- Redo weapon attachments
        mod:redo_weapon_attachments(self._selected_item)

    end

    instance.reload_gear_settings = function(self)
        -- Clear material overrides for item
        mod:clear_gear_material_overrides(self._selected_item)
        -- Get gear id
        local gear_id = mod:gear_id(self._selected_item)
        -- Reload gear settings from file
        if not mod:gear_settings(gear_id, nil, true) then
            mod:clear_gear_material_overrides(self._presentation_item)
        end
    end

    -- ##### Hover alpha fade #########################################################################################

    instance.set_widget_alpha_multiplier = function(self, alpha_multiplier, tab_menu_alpha_multiplier, item_grid_alpha_multiplier, toggle_buttons_alpha_multiplier, control_buttons_alpha_multiplier, material_override_alpha_multiplier)

        -- Set widgets in inventory weapon cosmetics view
        for _, widget in pairs(self._widgets_by_name) do
            widget.alpha_multiplier = alpha_multiplier
        end

        local tab_menu_alpha_multiplier = tab_menu_alpha_multiplier or alpha_multiplier
        -- Set tab menu widgets
        if self._widgets_by_name.button_pivot_background then
            -- Set background residing in inventory weapon cosmetics view
            self._widgets_by_name.button_pivot_background.alpha_multiplier = tab_menu_alpha_multiplier
            -- Check tab menu
            if self._tab_menu_element then
                -- Set widgets in tab menu
                for _, widget in pairs(self._tab_menu_element._widgets_by_name) do
                    widget.alpha_multiplier = tab_menu_alpha_multiplier
                end
            end
        end

        local item_grid_alpha_multiplier = item_grid_alpha_multiplier or alpha_multiplier
        -- Set item grid widgets
        if self._item_grid then
            -- Set widgets in item grid
            for _, widget in pairs(self._item_grid._widgets_by_name) do
                widget.alpha_multiplier = item_grid_alpha_multiplier
            end
        end

        local toggle_buttons_alpha_multiplier = toggle_buttons_alpha_multiplier or alpha_multiplier
        -- Set toggle button widgets
        if self._widgets_by_name.alternate_fire_toggle then
            self._widgets_by_name.alternate_fire_toggle.alpha_multiplier = toggle_buttons_alpha_multiplier
        end
        if self._widgets_by_name.crosshair_toggle then
            self._widgets_by_name.crosshair_toggle.alpha_multiplier = toggle_buttons_alpha_multiplier
        end
        if self._widgets_by_name.damage_type_toggle then
            self._widgets_by_name.damage_type_toggle.alpha_multiplier = toggle_buttons_alpha_multiplier
        end

        local control_buttons_alpha_multiplier = control_buttons_alpha_multiplier or alpha_multiplier
        -- Set random, reset and equip buttons
        if self._widgets_by_name.equip_button then
            self._widgets_by_name.equip_button.alpha_multiplier = control_buttons_alpha_multiplier
        end
        if self._widgets_by_name.reset_button then
            self._widgets_by_name.reset_button.alpha_multiplier = control_buttons_alpha_multiplier
        end
        if self._widgets_by_name.random_button then
            self._widgets_by_name.random_button.alpha_multiplier = control_buttons_alpha_multiplier
        end

        local material_override_alpha_multiplier = material_override_alpha_multiplier or alpha_multiplier
        -- Set color, pattern and wear
        if self._widgets_by_name.color_dropdown then
            self._widgets_by_name.color_dropdown.alpha_multiplier = material_override_alpha_multiplier
        end
        if self._widgets_by_name.pattern_dropdown then
            self._widgets_by_name.pattern_dropdown.alpha_multiplier = material_override_alpha_multiplier
        end
        if self._widgets_by_name.wear_dropdown then
            self._widgets_by_name.wear_dropdown.alpha_multiplier = material_override_alpha_multiplier
        end
        if self._widgets_by_name.color_button then
            self._widgets_by_name.color_button.alpha_multiplier = material_override_alpha_multiplier
        end
        if self._widgets_by_name.pattern_button then
            self._widgets_by_name.pattern_button.alpha_multiplier = material_override_alpha_multiplier
        end
        if self._widgets_by_name.wear_button then
            self._widgets_by_name.wear_button.alpha_multiplier = material_override_alpha_multiplier
        end
        if self._widgets_by_name.color_text then
            self._widgets_by_name.color_text.alpha_multiplier = material_override_alpha_multiplier
        end
        if self._widgets_by_name.pattern_text then
            self._widgets_by_name.pattern_text.alpha_multiplier = material_override_alpha_multiplier
        end
        if self._widgets_by_name.wear_text then
            self._widgets_by_name.wear_text.alpha_multiplier = material_override_alpha_multiplier
        end

    end

    -- ##### Control button callbacks #################################################################################

    instance.cb_on_reset_pressed = function(self)

        -- Toggle flags
        mod.is_in_customization_menu = nil
        mod.customization_menu_slot_name = nil

        -- Clear item origin table
        table_clear(pt.items_originating_from_customization_menu)

        -- Reset item
        local gear_id = mod:gear_id(self._selected_item)
        mod:delete_gear_settings(gear_id, true)
        mod:reset_item(self._selected_item, true)

        -- Reset presentation item
        local fake_gear_id = mod:gear_id(self._presentation_item, true)
        mod:delete_gear_settings(fake_gear_id, true)
        mod:reset_item(self._presentation_item, true)

        -- Get attachment slots from item
        local attachment_slots = mod:fetch_attachment_slots(self._selected_item.attachments)
        -- Iterate through attachment slots
        for attachment_slot, data in pairs(attachment_slots) do
            -- Attachment info
            local attachment_item_path = mod:fetch_attachment(self._selected_item.attachments, attachment_slot)
            local attachment_item = master_items.get_item(attachment_item_path)
            -- Set selected element name
            self["_equipped_"..attachment_slot.."_name"] = attachment_item_path or "content/items/weapons/player/trinkets/unused_trinket"
            self["_selected_"..attachment_slot.."_name"] = attachment_item_path or "content/items/weapons/player/trinkets/unused_trinket"
            -- Set selected element
            self["_equipped_"..attachment_slot] = attachment_item
            self["_selected_"..attachment_slot] = attachment_item

        end

        -- Update real world item
        self:update_real_world_item()
        -- Update presentation item
        self:update_presentation_item()

        -- Mark gear id origin
        pt.items_originating_from_customization_menu[fake_gear_id] = true

        -- Preview presentation item
        self:_preview_item(self._presentation_item)

        -- Switch tab
        local index = self._selected_tab_index
        self._selected_tab_index = nil
        self:cb_switch_tab(index)

        -- Toggle flags
        mod.is_in_customization_menu = true

    end

    instance.cb_on_random_pressed = function(self)

        -- Advance tutorial
        if self.tutorial_step == 5 then
            self.tutorial_step = 6
        end

        -- Toggle flags
        mod.is_in_customization_menu = nil
        mod.customization_menu_slot_name = nil

        -- Clear item origin table
        table_clear(pt.items_originating_from_customization_menu)

        -- Randomize item
        local new_gear_settings = mod:randomize_item(self._selected_item)
        -- Apply new gear settings to item
        local gear_id = mod:gear_id(self._selected_item)
        mod:gear_settings(gear_id, new_gear_settings, true)
        -- Modify item
        mod:modify_item(self._selected_item, false, new_gear_settings)
        -- Apply fixes
        mod:apply_attachment_fixes(self._selected_item)

        -- Iterate through gear settings
        for attachment_slot, replacement_path in pairs(new_gear_settings) do
            -- Attachment info
            local attachment_item = master_items.get_item(replacement_path)
            -- Set selected element name
            self["_equipped_"..attachment_slot.."_name"] = replacement_path or "content/items/weapons/player/trinkets/unused_trinket"
            self["_selected_"..attachment_slot.."_name"] = replacement_path or "content/items/weapons/player/trinkets/unused_trinket"
            -- Set selected element
            self["_equipped_"..attachment_slot] = attachment_item
            self["_selected_"..attachment_slot] = attachment_item
        end

        -- Update real world item
        self:update_real_world_item()
        -- Update presentation item
        self:update_presentation_item()

        -- Mark gear id origin
        local fake_gear_id = mod:gear_id(self._presentation_item, true)
        pt.items_originating_from_customization_menu[fake_gear_id] = true

        -- Preview presentation item
        self:_preview_item(self._presentation_item)

        -- Switch tab
        local index = self._selected_tab_index
        self._selected_tab_index = nil
        self:cb_switch_tab(index)

        -- Toggle flags
        mod.is_in_customization_menu = true


    end

    -- ##### Toggle overrides buttons callbacks #######################################################################

    instance.cb_on_alternate_fire_toggle_pressed = function(self, init)
        
        -- Get gear id
        local gear_id = mod:gear_id(self._selected_item)
        -- Get alternate fire setting
        local alternate_fire_list = mod:get(alternate_fire_setting) or {}
        if not init then
            -- Toggle alternate fire
            alternate_fire_list[gear_id] = not alternate_fire_list[gear_id]
        elseif not alternate_fire_list[gear_id] then
            alternate_fire_list[gear_id] = true
        end
        -- Set alternate fire setting
        mod:set(alternate_fire_setting, alternate_fire_list)

        -- Advance tutorial
        if self.tutorial_step == 4 then
            self.tutorial_step = 5
        end

    end

    instance.cb_on_crosshair_toggle_pressed = function(self, init)

        -- Get gear id
        local gear_id = mod:gear_id(self._selected_item)
        -- Get crosshair setting
        local crosshair_list = mod:get(crosshair_list_setting) or {}
        if not init then
            -- Toggle crosshair
            crosshair_list[gear_id] = not crosshair_list[gear_id]
        elseif not crosshair_list[gear_id] then
            crosshair_list[gear_id] = true
        end
        -- Set crosshair setting
        mod:set(crosshair_list_setting, crosshair_list)

        -- Advance tutorial
        if self.tutorial_step == 4 then
            self.tutorial_step = 5
        end

    end

    instance.cb_on_damage_type_toggle_pressed = function(self, init)

        -- Get gear id
        local gear_id = mod:gear_id(self._selected_item)
        -- Get damage type active setting
        local damage_type_active_list = mod:get(damage_type_active_setting) or {}
        if not init then
            -- Toggle damage type
            damage_type_active_list[gear_id] = not damage_type_active_list[gear_id]
        elseif not damage_type_active_list[gear_id] then
            damage_type_active_list[gear_id] = true
        end
        -- Set damage type setting
        mod:set(damage_type_active_setting, damage_type_active_list)

        -- Advance tutorial
        if self.tutorial_step == 4 then
            self.tutorial_step = 5
        end

    end

    -- ##### Item grid callbacks ######################################################################################

    instance.cb_on_grid_entry_right_pressed = function(self, widget, element)
        instance.super.cb_on_grid_entry_left_pressed(self, widget, element)
        
        -- Advance tutorial
        if self.tutorial_step == 3 then
            self.tutorial_step = 4
        end

        -- Preview element
        self:_preview_element(element)

        -- Equip
        self:cb_on_equip_pressed()

    end

    instance.cb_on_grid_entry_left_pressed = function(self, widget, element)
        instance.super.cb_on_grid_entry_left_pressed(self, widget, element)

        -- Advance tutorial
        if self.tutorial_step == 3 then
            self.tutorial_step = 4
        end

    end

    -- ##### Tutorial functions #######################################################################################

    instance.cb_on_tip_1_pressed = function(self)
        self.tutorial_step = self.tutorial_step + 1
    end

    instance.tutorial = function(self)

        -- Check if tutorial is finished
        if self.finished_tutorial then

            -- Hide tutorial window
            if self._widgets_by_name.tip_1 then
                self._widgets_by_name.tip_1.alpha_multiplier = 0
            end

            -- Hide tutorial button
            if self._widgets_by_name.tip_1_button then
                self._widgets_by_name.tip_1_button.alpha_multiplier = 0
                self._widgets_by_name.tip_1_button.content.hotspot.disabled = true
            end

            return false

        else

            -- Set tutorial step
            self.tutorial_step = self.tutorial_step or 1

            -- Set base alpha
            self:set_widget_alpha_multiplier(.25, .25, .25, .25, .25, .25)

            -- Set tutorial text
            if self.tutorial_step == 1 then
                self:set_widget_alpha_multiplier(.25, .25, .25, .25, .25, .25)
                self._widgets_by_name.tip_1.content.title = mod:localize("mod_tips_title_01")
                self._widgets_by_name.tip_1.content.text = mod:localize("mod_tips_01")

            elseif self.tutorial_step == 2 then
                self:set_widget_alpha_multiplier(.25, 1, .25, .25, .25, .25)
                self._widgets_by_name.tip_1.content.title = mod:localize("mod_tips_title_02")
                self._widgets_by_name.tip_1.content.text = mod:localize("mod_tips_02")

            elseif self.tutorial_step == 3 then
                self:set_widget_alpha_multiplier(.25, .25, 1, .25, .25, .25)
                self._widgets_by_name.tip_1.content.title = mod:localize("mod_tips_title_03")
                self._widgets_by_name.tip_1.content.text = mod:localize("mod_tips_03")

            elseif self.tutorial_step == 4 then
                self:set_widget_alpha_multiplier(.25, .25, .25, 1, .25, .25)
                self._widgets_by_name.tip_1.content.title = mod:localize("mod_tips_title_04")
                self._widgets_by_name.tip_1.content.text = mod:localize("mod_tips_04")

            elseif self.tutorial_step == 5 then
                self:set_widget_alpha_multiplier(.25, .25, .25, .25, .25, 1)
                self._widgets_by_name.tip_1.content.title = mod:localize("mod_tips_title_05")
                self._widgets_by_name.tip_1.content.text = mod:localize("mod_tips_05")

            elseif self.tutorial_step == 6 then
                self:set_widget_alpha_multiplier(.25, .25, .25, .25, 1, .25)
                self._widgets_by_name.tip_1.content.title = mod:localize("mod_tips_title_06")
                self._widgets_by_name.tip_1.content.text = mod:localize("mod_tips_06")

            elseif self.tutorial_step == 7 then
                -- Reset alpha
                self:set_widget_alpha_multiplier(1, 1, 1, 1, 1, 1)
                -- Finish tutorial
                self.finished_tutorial = true
                -- Save tutorial finished
                mod:set("customization_menu_finished_tutorial", true)
            end

            -- Show tutorial window
            if self._widgets_by_name.tip_1 then
                self._widgets_by_name.tip_1.alpha_multiplier = 1
            end

            -- Show tutorial button
            if self._widgets_by_name.tip_1_button then
                self._widgets_by_name.tip_1_button.alpha_multiplier = 1
                self._widgets_by_name.tip_1_button.content.hotspot.disabled = false
            end

            return true

        end

    end

    -- ##### Remove overrides callbacks ###############################################################################

    instance.cb_on_color_pressed = function(self)
        self.selected_color_override = ""
        self:_preview_item(self._presentation_item)
    end

    instance.cb_on_pattern_pressed = function(self)
        self.selected_pattern_override = ""
        self:_preview_item(self._presentation_item)
    end

    instance.cb_on_wear_pressed = function(self)
        self.selected_wear_override = ""
        self:_preview_item(self._presentation_item)
    end

    -- ##### Dropdown functions #######################################################################################

    instance.update_dropdown = function(self, widget, input_service, dt, t)
		local content = widget.content
		local entry = content.entry
		local value = entry.get_function and entry:get_function() or content.internal_value or "<not selected>"
		local selected_option = content.options[content.selected_index]
	
		if content.close_setting then
			content.close_setting = nil
	
			content.exclusive_focus = false
			local hotspot = content.hotspot or content.button_hotspot
	
			if hotspot then
				hotspot.is_selected = false
			end

            self.dropdown_open = false

			return
		end

        local size = vector2(content.dropdown_size[1], content.dropdown_size[2])
		local using_gamepad = not managers.ui:using_cursor_navigation()
		local offset = widget.offset
		local style = widget.style
		local options = content.options
		local options_by_id = content.options_by_id
		local num_visible_options = content.num_visible_options
		local num_options = #options
		local focused = content.exclusive_focus --and not is_disabled
	
		if focused then
			offset[3] = 90
		else
			offset[3] = 0
		end
	
		local selected_index = content.selected_index
		local new_value, real_value = nil, nil
		local hotspot = content.hotspot
		local hotspot_style = style.hotspot
	
		if selected_index and focused then
			if using_gamepad and hotspot.on_pressed then
				new_value = options[selected_index].id
				real_value = options[selected_index].value
			end
	
			hotspot_style.on_pressed_sound = hotspot_style.on_pressed_fold_in_sound
		else
			hotspot_style.on_pressed_sound = hotspot_style.on_pressed_fold_out_sound
		end
	
		
	
		local localization_manager = managers.localization
		local preview_option = options_by_id[value]
		local preview_option_id = preview_option and preview_option.id
		local preview_value = preview_option and preview_option.display_name or "loc_settings_option_unavailable"
		local ignore_localization = preview_option and preview_option.ignore_localization
		content.value_text = ignore_localization and preview_value or localization_manager:localize(preview_value)
		local always_keep_order = true
		local grow_downwards = content.grow_downwards
		local new_selection_index = nil
	
		if not selected_index or not focused then
			for i = 1, #options do
				local option = options[i]
	
				if option.id == preview_option_id then
					selected_index = i
	
					break
				end
			end
	
			selected_index = selected_index or 1
		end
	
		if selected_index and focused then
            local scroll_axis = input_service:get("scroll_axis") or vector3(0, 0, 0)
			if input_service:get("navigate_up_continuous") or scroll_axis[2] > 0 then
				if grow_downwards or not grow_downwards and always_keep_order then
					new_selection_index = math_max(selected_index - 1, 1)
				else
					new_selection_index = math_min(selected_index + 1, num_options)
				end
			elseif input_service:get("navigate_down_continuous") or scroll_axis[2] < 0 then
				if grow_downwards or not grow_downwards and always_keep_order then
					new_selection_index = math_min(selected_index + 1, num_options)
				else
					new_selection_index = math_max(selected_index - 1, 1)
				end
			end
		end
	
		if new_selection_index or not content.selected_index then
			if new_selection_index then
				selected_index = new_selection_index
			end
	
			if num_visible_options < num_options then
				local step_size = 1 / num_options
				local new_scroll_percentage = math_min(selected_index - 1, num_options) * step_size
				content.scroll_percentage = new_scroll_percentage
				content.scroll_add = nil
			end
	
			content.selected_index = selected_index
		end

        if num_visible_options < num_options then
            local step_size = 1 / num_options
            local new_scroll_percentage = math_min(selected_index - 1, num_options) * step_size
            content.scroll_percentage = new_scroll_percentage
            content.scroll_add = nil
        end
	
		local scroll_percentage = content.scroll_percentage
	
		if scroll_percentage then
			local step_size = 1 / (num_options - (num_visible_options - 1))
			content.start_index = math_max(1, math_ceil(scroll_percentage / step_size))
		end

        local option_hovered = false
		local option_index = 1
		local start_index = content.start_index or 1
		local end_index = math_min(start_index + num_visible_options - 1, num_options)
		local using_scrollbar = num_visible_options < num_options
	
        content.hovered_option = nil

		for i = start_index, end_index do
			local actual_i = i
	
			if not grow_downwards and always_keep_order then
				actual_i = end_index - i + start_index
			end
	
			local option_text_id = "option_text_" .. option_index
			local option_hotspot_id = "option_hotspot_" .. option_index
			local outline_style_id = "outline_" .. option_index
			local option_hotspot = content[option_hotspot_id]
			option_hovered = option_hovered or option_hotspot.is_hover
			option_hotspot.is_selected = actual_i == selected_index
			local option = options[actual_i]
	
			if option_hotspot.is_hover then
                content.hovered_option = option
			end
	
			if option_hotspot.on_pressed and not option.disabled then
				-- if not mod.build_animation:is_busy() then
					option_hotspot.on_pressed = nil
					new_value = option.id
					real_value = option.value
					content.selected_index = actual_i
					content.option_disabled = false
				-- end
			elseif option_hotspot.on_pressed and option.disabled then
				content.option_disabled = true
			end
	
			local option_display_name = option.display_name
			local option_ignore_localization = option.ignore_localization
			content[option_text_id] = option_ignore_localization and option_display_name or localization_manager:localize(option_display_name)
			option_index = option_index + 1
		end

        local value_changed = new_value ~= nil

        if value_changed and new_value ~= value then
			local on_activated = entry.on_activated

			on_activated(new_value, entry)
		end
	
		local scrollbar_hotspot = content.scrollbar_hotspot
		local scrollbar_hovered = scrollbar_hotspot.is_hover
	
		if (input_service:get("left_pressed") or input_service:get("confirm_pressed") or input_service:get("back")) and content.exclusive_focus and not content.wait_next_frame then
            content.wait_next_frame = true
            content.reset = true
	
			return
		end
	
		if content.wait_next_frame and not content.option_disabled then
			content.wait_next_frame = nil
			content.close_setting = true
			self.dropdown_closing = false
	
			return
		elseif content.wait_next_frame and content.option_disabled then
			content.option_disabled = nil
			content.wait_next_frame = nil
	
			return
		end

    end

    instance.create_dropdown = function(self, dropdown_name, options, size)

        local dropdown_size = size or dropdown_size
        local num_visible_options = math_min(10, #options)
        local template = DropdownPassTemplates.settings_dropdown(dropdown_size[1], dropdown_size[2], dropdown_size[1], num_visible_options, true)
        for index, pass in pairs(template) do
            if pass.style_id == "text" then
                pass.style.font_size = 16
            end
        end
        local definition = UIWidget.create_definition(template, dropdown_name, nil, dropdown_size)
        local widget = self:_create_widget(dropdown_name, definition)

		self._widgets[#self._widgets+1] = widget
        self._widgets_by_name[dropdown_name] = widget

        table.sort(options, compare_item_name)

        local content = widget.content
        local options_by_id = {}
		for index, option in pairs(options) do
			options_by_id[option.id] = option
		end
        content.dropdown_size = size
		content.options_by_id = options_by_id
		content.options = options
        content.num_visible_options = num_visible_options
        content.grow_downwards = true
        content.entry = {
			options = options,
			widget_type = "dropdown",
			on_activated = function(new_value, entry)
                -- local tab_content = self._tabs_content[self._selected_tab_index]
                -- local slot_name = tab_content.slot_name
                local slot_name = self:selected_slot_name()
                local selected_option = content.options[content.selected_index]
                if selected_option then

                    if dropdown_name == "color_dropdown" then
                        self.selected_color_override = new_value
                    elseif dropdown_name == "pattern_dropdown" then
                        self.selected_pattern_override = new_value
                    elseif dropdown_name == "wear_dropdown" then
                        self.selected_wear_override = new_value
                    end

                    mod:gear_material_overrides(self._presentation_item, nil, slot_name, selected_option.material_overrides)
                    mod:gear_material_overrides(self._selected_item, nil, slot_name, selected_option.material_overrides)

                    self:_preview_item(self._presentation_item)

                end
			end,
			get_function = function()

                if content.selected_index then

                    -- local tab_content = self._tabs_content[self._selected_tab_index]
                    -- local slot_name = tab_content.slot_name

                    local slot_name = self:selected_slot_name()
                    local material_override = mod:gear_material_overrides(self._presentation_item, nil, slot_name)
                    if material_override then
                        for _, option in pairs(options) do
                            -- if material_override.material_overrides and table_contains(material_override.material_overrides, option.value) then
                            if material_override.material_overrides and mod:cached_table_contains(material_override.material_overrides, option.value) then
                                return option.value
                            end
                        end
                    end

                end
			end,
		}

        content.hotspot.pressed_callback = function ()

            local selected_widget = nil
            local selected = true
            content.exclusive_focus = selected
            local hotspot = content.hotspot or content.button_hotspot
            if hotspot then
                hotspot.is_selected = selected
            end

            self.dropdown_open = true

		end

        local num_options = #options

        content.area_length = dropdown_size[2] * content.num_visible_options

        local scroll_length = math.max(dropdown_size[2] * num_options - content.area_length, 0)

        content.scroll_length = scroll_length

        local spacing = 0
        local scroll_amount = scroll_length > 0 and (dropdown_size[2] + spacing) / scroll_length or 0

        content.scroll_amount = scroll_amount

    end

    -- ##### Create specific dropdowns ################################################################################

    instance.create_color_dropdown = function(self)

        local color_options = {}
        -- Get color options
        local gear_colors = ItemMaterialOverridesGearColors
        -- Iterate through color options
        for material_override_name, data in pairs(gear_colors) do
            -- Generate display name
            local display_name = material_override_name
            -- display_name = string_gsub(display_name, "color_", "")
            display_name = mod:cached_gsub(display_name, "color_", "")
            -- display_name = string_gsub(display_name, "colour_", "")
            display_name = mod:cached_gsub(display_name, "colour_", "")
            -- display_name = string_gsub(display_name, "_", " ")
            display_name = mod:cached_gsub(display_name, "_", " ")
            -- display_name = string_gsub(display_name, "%f[%a].", string_upper)
            display_name = mod:cached_gsub(display_name, "%f[%a].", string_upper)
            -- Add color option
            color_options[#color_options+1] = {
                id = material_override_name,
                display_name = display_name,
                ignore_localization = true,
                value = material_override_name,
                disabled = false,
                material_overrides = {
                    material_overrides = {
                        material_override_name,
                    }
                },
            }
        end

        -- Create dropdown
        self:create_dropdown("color_dropdown", color_options, {350, 38})

    end

    instance.create_pattern_dropdown = function(self)

        local pattern_options = {}
        -- Get pattern options
        local gear_patterns = ItemMaterialOverridesGearPatterns
        -- Iterate through pattern options
        for material_override_name, data in pairs(gear_patterns) do
            -- Check for supported pattern
            if data.texture_overrides and data.texture_overrides.coat_pattern then
                -- Generate display name
                local display_name = material_override_name
                -- display_name = string_gsub(display_name, "pattern_", "")
                display_name = mod:cached_gsub(display_name, "pattern_", "")
                -- display_name = string_gsub(display_name, "_", " ")
                display_name = mod:cached_gsub(display_name, "_", " ")
                -- display_name = string_gsub(display_name, "%f[%a].", string_upper)
                display_name = mod:cached_gsub(display_name, "%f[%a].", string_upper)
                -- Add pattern option
                pattern_options[#pattern_options+1] = {
                    id = material_override_name,
                    display_name = display_name,
                    ignore_localization = true,
                    value = material_override_name,
                    disabled = false,
                    material_overrides = {
                        material_overrides = {
                            material_override_name,
                        }
                    },
                }
            end
        end

        -- Create dropdown
        self:create_dropdown("pattern_dropdown", pattern_options, {350, 38})

    end

    instance.create_wear_dropdown = function(self)

        local wear_options = {}
        -- Get wear options
        local gear_wears = ItemMaterialOverridesGearMaterials
        -- Iterate through wear options
        for property_override_name, data in pairs(gear_wears) do
            -- Check for supported wear
            if data.property_overrides and data.property_overrides.chip_dirt then
                -- Generate display name
                local display_name = property_override_name
                -- display_name = string_gsub(display_name, "wear_", "")
                display_name = mod:cached_gsub(display_name, "wear_", "")
                -- display_name = string_gsub(display_name, "_", " ")
                display_name = mod:cached_gsub(display_name, "_", " ")
                -- display_name = string_gsub(display_name, "%f[%a].", string_upper)
                display_name = mod:cached_gsub(display_name, "%f[%a].", string_upper)
                -- Add wear option
                wear_options[#wear_options+1] = {
                    id = property_override_name,
                    display_name = display_name,
                    ignore_localization = true,
                    value = property_override_name,
                    disabled = false,
                    material_overrides = {
                        material_overrides = {
                            property_override_name,
                        }
                    },
                }
            end
        end

        -- Create dropdown
        self:create_dropdown("wear_dropdown", wear_options, {300, 38})

    end

end)

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

-- Initialize view
mod:hook(CLASS.InventoryWeaponCosmeticsView, "init", function(func, self, settings, context, ...)

    -- Original function
    func(self, settings, context, ...)

    -- Modding tools
    self.modding_tools = get_mod("modding_tools")

    -- Custom init
    self.customize_attachments = context.customize_attachments

    -- Check customization menu
    if self.customize_attachments then

        -- Modify view definitions
        mod:inventory_weapon_cosmetics_view_adjust_definitions(self._definitions)

        -- Get selected item template
        local weapon_template = self._selected_item.weapon_template
        -- Get supported attachment slots
        local attachments = weapon_template and mod.settings.attachments[weapon_template]
        -- Check attachments
        if attachments then
            -- Iterate through attachments
            for attachment_slot, attachment_entries in pairs(attachments) do
                -- Attachment ino
                local attachment_item_path = mod:fetch_attachment(self._selected_item.attachments, attachment_slot)
                -- Set selected element name
                self["_equipped_"..attachment_slot.."_name"] = attachment_item_path or "content/items/weapons/player/trinkets/unused_trinket"
                self["_selected_"..attachment_slot.."_name"] = attachment_item_path or "content/items/weapons/player/trinkets/unused_trinket"
                -- Check attachment path
                if attachment_item_path then
                    -- Get attachment item
                    local attachment_item = master_items.get_item(attachment_item_path)
                    -- Set selected element
                    self["_equipped_"..attachment_slot] = attachment_item
                    self["_selected_"..attachment_slot] = attachment_item
                end
            end
        end

    end

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_setup_menu_tabs", function(func, self, content, ...)

    -- Check customization menu
    if self.customize_attachments and content then

        self._tabs_content = content

        local grid_size = inventory_weapon_cosmetics_view_definitions.grid_settings.grid_size
        local id = "tab_menu"
        local layer = 10
        local button_size = {230, 40}
        local button_spacing = 10
        local tab_menu_settings = {
            grow_vertically = true,
            vertical_alignment = "top",
            button_size = button_size,
            button_spacing = button_spacing,
            input_label_offset = {25, 30},
            fixed_button_size = true,
        }
        local tab_menu_element = self:_add_element(ViewElementTabMenu, id, layer, tab_menu_settings)

        self._tab_menu_element = tab_menu_element

        local input_action_left = "navigate_secondary_left_pressed"
        local input_action_right = "navigate_secondary_right_pressed"

        tab_menu_element:set_input_actions(input_action_left, input_action_right)
        tab_menu_element:set_is_handling_navigation_input(true)

        local tab_button_template = table.clone(ButtonPassTemplates.tab_menu_button)

        tab_button_template[1].style = {
            on_pressed_sound = UISoundEvents.tab_secondary_button_pressed,
        }

        local tab_ids = {}

        for i = 1, #content do
            local tab_content = content[i]
            local display_name = "attachment_slot_"..tab_content.display_name
            local display_icon = tab_content.icon
            local pressed_callback = callback(self, "cb_switch_tab", i)
            local tab_id = tab_menu_element:add_entry(display_name, pressed_callback, tab_button_template, display_icon)

            tab_ids[i] = tab_id
        end

        local total_height = button_size[2] * #content + button_spacing * #content

        self:_set_scenegraph_size("button_pivot_background", nil, total_height + 30)

        self._tab_ids = tab_ids

        self:_update_tab_bar_position()

        return
    end

    -- Original function
    func(self, content, ...)

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "cb_switch_tab", function(func, self, index, ...)

    -- Check customization menu and tab content
    if self.customize_attachments and self._tabs_content then

        -- Reload gear settings
        self:reload_gear_settings()

        -- Reset overrides
        self.selected_color_override = nil
        self.selected_pattern_override = nil
        self.selected_wear_override = nil

        -- Get weapon template
        local weapon_template = self._selected_item.weapon_template
        -- Get supported attachment
        local attachments = weapon_template and mod.settings.attachments[weapon_template]

        -- Get tab content
        local content = self._tabs_content[index]
        if content then

            -- Get slot name
            local slot_name = content.slot_name
            -- Set flags
            mod.customization_menu_slot_name = slot_name

            -- Get mod name
            local mod_name = mod:get_name()

            -- Get original item and attachment and check if empty
            local original_item = master_items.get_item(self._selected_item.name)
            local original_attachment = original_item and original_item.attachments and mod:fetch_attachment(original_item.attachments, slot_name)
            local original_attachment_is_empty = original_attachment == "content/items/weapons/player/trinkets/unused_trinket" or original_attachment == ""

            -- Check index changed
            if index ~= self._selected_tab_index then

                -- Check selected index
                if self._selected_tab_index then

                    -- Set selected element name
                    self["_selected_"..slot_name.."_name"] = mod:fetch_attachment(self._selected_item.attachments, slot_name)
                    -- Get selected element
                    local real_item = master_items.get_item(self["_selected_"..slot_name.."_name"])

                    -- Apply on preview
                    self._tabs_content[self._selected_tab_index].apply_on_preview(real_item, self._presentation_item)

                    -- Set originating from customization menu
                    local gear_id = mod:gear_id(self._presentation_item, true)
                    pt.items_originating_from_customization_menu[gear_id] = true

                    -- Preview presentation item
                    self:_preview_item(self._presentation_item)

                end

                -- Set selected index
                self._selected_tab_index = index

                -- Set selected tab
                self._tab_menu_element:set_selected_index(index)

                local generate_visual_item_function = content.generate_visual_item_function
                local get_empty_item_function = content.get_empty_item

                -- Set grid display name
                self._grid_display_name = content.display_name

                -- Check not using cursor navigation
                if not self._using_cursor_navigation then
                    -- Play sound
                    self:_play_sound(UISoundEvents.tab_secondary_button_pressed)
                end

                -- Create layout
                local layout = {}
                local current_group_index = 1

                -- Clear mod count
                table_clear(temp_mod_count)
                table_clear(temp_group_index)

                -- Add empty item when original item doesn't have attachment slot or nothing equipped
                if original_attachment_is_empty and get_empty_item_function then

                    -- Create empty item
                    local empty_item = get_empty_item_function(self._selected_item, self._presentation_item)

                    -- Increaes mod count
                    temp_mod_count[mod_name] = temp_mod_count[mod_name] or 0
                    temp_mod_count[mod_name] = temp_mod_count[mod_name] + 1

                    -- Increase group index
                    if not temp_group_index[mod_name] then
                        temp_group_index[mod_name] = current_group_index
                        current_group_index = current_group_index + 1
                    end

                    -- Indices
                    local group_index = string_format("%04d", temp_group_index[mod_name])
                    local attachment_index = string_format("%04d", temp_mod_count[mod_name])
                    -- Generate sort string
                    local sort_string = mod_name.."_"..group_index.."_"..attachment_index

                    -- Add to layout
                    layout[#layout + 1] = {
                        is_empty = true,
                        item = empty_item,
                        slot_name = slot_name,
                        sort_data = {
                            display_name = sort_string,
                        },
                    }

                end

                -- Add attachments
                local attachment_entries = attachments[slot_name]
                -- Check attachment entries and count bigger 1
                if attachment_entries and mod:selectable_attachment_count(attachment_entries) > 1 then
                    -- Iterate through attachment entries
                    for attachment_name, attachment_data in pairs(attachment_entries) do
                        -- Check if attachment is not hidden
                        if not attachment_data.hide_from_selection then

                            -- Get attachment item
                            local attachment_item = master_items.get_item(attachment_data.replacement_path)
                            -- Create visual item
                            local item = generate_visual_item_function(slot_name, attachment_item, attachment_data)

                            -- Get mod of origin
                            local origin_mod = pt.attachment_data_origin[attachment_data] or mod
                            -- Get group name
                            local group_name = attachment_data.custom_selection_group or origin_mod:get_name()

                            -- Increaes mod count
                            temp_mod_count[group_name] = temp_mod_count[group_name] or 0
                            temp_mod_count[group_name] = temp_mod_count[group_name] + 1

                            -- Increase group index
                            if not temp_group_index[group_name] then
                                temp_group_index[group_name] = current_group_index
                                current_group_index = current_group_index + 1
                            end

                            -- Indices
                            local group_index = string_format("%04d", temp_group_index[group_name])
                            local attachment_index = string_format("%04d", attachment_data.selection_index or temp_mod_count[group_name])
                            -- Generate sort string
                            local sort_string = group_name.."_"..group_index.."_"..attachment_index

                            -- Add to layout
                            layout[#layout+1] = {
                                widget_type = "gear_set",
                                item = item,
                                real_item = attachment_item,
                                attachment_data = attachment_data,
                                slot_name = slot_name,
                                sort_data = {
                                    display_name = sort_string,
                                },
                            }

                        end

                    end
                end

                -- Add selection group headers
                for group_name, count in pairs(temp_mod_count) do

                    -- Localize group name
                    local localization_name = "loc_ewc_"..tostring(group_name)

                    -- Indices
                    local group_index = string_format("%04d", temp_group_index[group_name])
                    local attachment_index = string_format("%04d", 0)
                    -- Generate sort string
                    local sort_string = group_name.."_"..group_index.."_"..attachment_index

                    -- Add to layout
                    layout[#layout+1] = {
                        widget_type = "sub_header",
                        slot_name = slot_name,
                        display_name = localization_name,
                        sort_data = {
                            display_name = sort_string,
                        },
                    }

                end

                -- Set layout
                self._offer_items_layout = layout
                -- Sort layout
                self:_sort_grid_layout(self._sort_options[1].sort_function)
                -- Present layout
                self:_present_layout_by_slot_filter()

            end

            -- Advance tutorial
            if self.tutorial_step == 2 then
                self.tutorial_step = 3
            end

            return
        end
    end

    -- Check element
    if not self._tabs_content[index] then
        -- Return; prevent crash
        return
    end

    -- Original function
    func(self, index, ...)

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_setup_sort_options", function(func, self, ...)

    -- Check customization menu
    if self.customize_attachments then

        -- Set sort options
        if not self._sort_options then
            self._sort_options = {
                {
                    display_name = localize("loc_inventory_item_grid_sort_title_format_increasing_letters", true, {
                        sort_name = localize("loc_inventory_item_grid_sort_title_name"),
                    }),
                    sort_function = items.sort_element_key_comparator({"<", "sort_data", items.compare_item_name}),
                },
                {
                    display_name = localize("loc_inventory_item_grid_sort_title_format_decreasing_letters", true, {
                        sort_name = localize("loc_inventory_item_grid_sort_title_name"),
                    }),
                    sort_function = items.sort_element_key_comparator({">", "sort_data", items.compare_item_name}),
                },
            }
        end

        -- Set sort button callback
        local sort_callback = callback(self, "cb_on_sort_button_pressed")

        -- Set sort button
        self._item_grid:setup_sort_button(self._sort_options, sort_callback)

        return
    end

    -- Original function
    func(self, ...)

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "draw", function(func, self, dt, t, input_service, layer, ...)

    -- Check customization menu
    if self.customize_attachments then

        -- Get hovered value for view widgets
        local item_grid_hovered = self._item_grid and self._item_grid:hovered()
        local tab_menu_hovered = self._tab_menu_element and self._tab_menu_element:hovered()
        local equip_button_hovered = self._widgets_by_name.equip_button and self._widgets_by_name.equip_button.content.hotspot.is_hover

        -- Get hovered value for custom widgets
        local reset_button_hovered = self._widgets_by_name.reset_button and self._widgets_by_name.reset_button.content.hotspot.is_hover
        local random_button_hovered = self._widgets_by_name.random_button and self._widgets_by_name.random_button.content.hotspot.is_hover

        local alternate_fire_toggle_hovered = self._widgets_by_name.alternate_fire_toggle and self._widgets_by_name.alternate_fire_toggle.content.hotspot.is_hover
        local crosshair_toggle_hovered = self._widgets_by_name.crosshair_toggle and self._widgets_by_name.crosshair_toggle.content.hotspot.is_hover
        local damage_type_toggle_hovered = self._widgets_by_name.damage_type_toggle and self._widgets_by_name.damage_type_toggle.content.hotspot.is_hover

        local color_override_hovered = self._widgets_by_name.color_dropdown and self._widgets_by_name.color_dropdown.content.hotspot.is_hover or self._widgets_by_name.color_dropdown.content.hovered_option
        local pattern_override_hovered = self._widgets_by_name.pattern_dropdown and self._widgets_by_name.pattern_dropdown.content.hotspot.is_hover or self._widgets_by_name.pattern_dropdown.content.hovered_option
        local wear_override_hovered = self._widgets_by_name.wear_dropdown and self._widgets_by_name.wear_dropdown.content.hotspot.is_hover or self._widgets_by_name.wear_dropdown.content.hovered_option

        local color_button_hovered = self._widgets_by_name.color_button and self._widgets_by_name.color_button.visible and self._widgets_by_name.color_button.content.hotspot.is_hover
        local pattern_button_hovered = self._widgets_by_name.pattern_button and self._widgets_by_name.pattern_button.visible and self._widgets_by_name.pattern_button.content.hotspot.is_hover
        local wear_button_hovered = self._widgets_by_name.wear_button and self._widgets_by_name.wear_button.visible and self._widgets_by_name.wear_button.content.hotspot.is_hover

        -- Check if tutorial is active
        if not self:tutorial() then
            -- Check if any custom widgets are hovered
            if self.customize_attachments and not item_grid_hovered and not tab_menu_hovered
                    and not equip_button_hovered and not reset_button_hovered and not random_button_hovered
                    and not alternate_fire_toggle_hovered and not crosshair_toggle_hovered and not damage_type_toggle_hovered
                    and not color_override_hovered and not pattern_override_hovered and not wear_override_hovered
                    and not color_button_hovered and not pattern_button_hovered and not wear_button_hovered then
                -- Fade out custom widgets when no custom widgets are hovered
                self.animated_alpha_multiplier = math_lerp(self.animated_alpha_multiplier, .3, dt * 4)
            else
                -- Fade in custom widgets when any custom widgets are hovered
                self.animated_alpha_multiplier = math_lerp(self.animated_alpha_multiplier, 1, dt * 4)
            end
        end

    end

    -- Original function
    func(self, dt, t, input_service, layer, ...)

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "update", function(func, self, dt, t, input_service, ...)
    -- Original function
    func(self, dt, t, input_service, ...)

    if self.customize_attachments and self._tabs_content and self._selected_tab_index and self._tabs_content[self._selected_tab_index] then
        -- local content = self._tabs_content[self._selected_tab_index]
        -- local slot_name = content.slot_name
        local slot_name = self:selected_slot_name()

        local disable_button = true
        if self["_selected_"..slot_name.."_name"] ~= self["_equipped_"..slot_name.."_name"] or self.selected_color_override or self.selected_pattern_override or self.selected_wear_override then
            disable_button = false
        end

        local widgets_by_name = self._widgets_by_name
        -- local button = widgets_by_name.equip_button
        local button_content = widgets_by_name.equip_button.content

        button_content.hotspot.disabled = disable_button
        button_content.text = utf8_upper(disable_button and localize("loc_weapon_inventory_equipped_button") or localize("loc_weapon_inventory_equip_button"))

        -- local reset_button = widgets_by_name.reset_button
        if widgets_by_name.reset_button then
            local button_content = widgets_by_name.reset_button.content
            local gear_id = mod:gear_id(self._selected_item)
            button_content.hotspot.disabled = not mod:gear_settings(gear_id)
        end

        -- Auto rotate
        local weapon_preview = self._weapon_preview
        local ui_weapon_spawner = weapon_preview and weapon_preview._ui_weapon_spawner
        if ui_weapon_spawner and not self.modding_tools then
            if self.current_default_rotation_angle ~= ui_weapon_spawner._default_rotation_angle then
                ui_weapon_spawner._default_rotation_angle = math_lerp(ui_weapon_spawner._default_rotation_angle, self.current_default_rotation_angle, dt)
            end
            if ui_weapon_spawner._rotation_angle ~= ui_weapon_spawner._default_rotation_angle and not ui_weapon_spawner._is_rotating then
                ui_weapon_spawner._rotation_angle = math_lerp(ui_weapon_spawner._rotation_angle, ui_weapon_spawner._default_rotation_angle, dt)
            end
        end

        local grid_widgets = self._item_grid:widgets()
        if grid_widgets then
            for i = 1, #grid_widgets do
                local widget = grid_widgets[i]

                if widget then
                    local content = widget.content
                    local element = content and content.element
                    local real_item = element and element.real_item
                    local item_path = real_item and real_item.name
                    local attachment_data = mod.settings.attachment_data_by_item_string[item_path]
                    if attachment_data and attachment_data.replacement_path == self["_equipped_"..slot_name.."_name"] then
                        content.owned = ""
                    else
                        content.owned = nil
                    end

                end
            end
        end

        local has_alternate_fire = mod:item_has(self._selected_item, "alternate_fire") or not self.finished_tutorial
        -- local alternate_fire_toggle = widgets_by_name.alternate_fire_toggle
        if has_alternate_fire and widgets_by_name.alternate_fire_toggle then
            local gear_id = mod:gear_id(self._selected_item)
            local alternate_fire_list = mod:get(alternate_fire_setting)
            local alternate_fire_value = alternate_fire_list and alternate_fire_list[gear_id]
            if alternate_fire_value == nil then alternate_fire_value = true end
            local text_color = not alternate_fire_value and {255, 0, 0} or {255, 255, 255}
            widgets_by_name.alternate_fire_toggle.content.text = string_format("{#color(%d,%d,%d)}%s{#reset()}", text_color[1], text_color[2], text_color[3], localize("loc_weapon_inventory_alternate_fire_toggle"))
        end
        
        -- local alternate_fire_toggle_widget = widgets_by_name and widgets_by_name.alternate_fire_toggle
        if widgets_by_name.alternate_fire_toggle then widgets_by_name.alternate_fire_toggle.visible = has_alternate_fire end

        local has_crosshair = mod:item_has(self._selected_item, "crosshair_type") or not self.finished_tutorial
        -- local crosshair_toggle = widgets_by_name.crosshair_toggle
        if has_crosshair and widgets_by_name.crosshair_toggle then
            local gear_id = mod:gear_id(self._selected_item)
            local crosshair_list = mod:get(crosshair_list_setting)
            local crosshair_value = crosshair_list and crosshair_list[gear_id]
            if crosshair_value == nil then crosshair_value = true end
            local text_color = not crosshair_value and {255, 0, 0} or {255, 255, 255}
            widgets_by_name.crosshair_toggle.content.text = string_format("{#color(%d,%d,%d)}%s{#reset()}", text_color[1], text_color[2], text_color[3], localize("loc_weapon_inventory_crosshair_toggle"))
        end
        
        -- local crosshair_toggle_widget = widgets_by_name and widgets_by_name.crosshair_toggle
        if widgets_by_name.crosshair_toggle then widgets_by_name.crosshair_toggle.visible = has_crosshair end

        local has_damage_type = mod:item_has(self._selected_item, "damage_type") or not self.finished_tutorial
        -- local damage_type_toggle = widgets_by_name.damage_type_toggle
        if has_damage_type and widgets_by_name.damage_type_toggle then
            local gear_id = mod:gear_id(self._selected_item)
            -- local damage_type_list = mod:get(damage_type_setting)
            -- local damage_type_value = damage_type_list and damage_type_list[gear_id]
            local damage_type_active_list = mod:get(damage_type_active_setting) or {}
            local damage_type_value = damage_type_active_list and damage_type_active_list[gear_id]
            if damage_type_value == nil then damage_type_value = true end
            local text_color = not damage_type_value and {255, 0, 0} or {255, 255, 255}
            widgets_by_name.damage_type_toggle.content.text = string_format("{#color(%d,%d,%d)}%s{#reset()}", text_color[1], text_color[2], text_color[3], localize("loc_weapon_inventory_damage_type_toggle"))
        end
        
        -- local damage_type_toggle_widget = widgets_by_name and widgets_by_name.damage_type_toggle
        if widgets_by_name.damage_type_toggle then widgets_by_name.damage_type_toggle.visible = has_damage_type end

        -- local color_dropdown = widgets_by_name.color_dropdown
        self:update_dropdown(widgets_by_name.color_dropdown, input_service, dt, t)
        -- local pattern_dropdown = widgets_by_name.pattern_dropdown
        self:update_dropdown(widgets_by_name.pattern_dropdown, input_service, dt, t)
        -- local wear_dropdown = widgets_by_name.wear_dropdown
        self:update_dropdown(widgets_by_name.wear_dropdown, input_service, dt, t)

        -- local color_button = widgets_by_name and widgets_by_name.color_button
        -- local pattern_button = widgets_by_name and widgets_by_name.pattern_button
        -- local wear_button = widgets_by_name and widgets_by_name.wear_button

        if widgets_by_name.color_button then widgets_by_name.color_button.visible = widgets_by_name.color_dropdown.content.entry.get_function() end
        if widgets_by_name.pattern_button then widgets_by_name.pattern_button.visible = widgets_by_name.pattern_dropdown.content.entry.get_function() end
        if widgets_by_name.wear_button then widgets_by_name.wear_button.visible = widgets_by_name.wear_dropdown.content.entry.get_function() end

    else
        local widgets_by_name = self._widgets_by_name

        -- local reset_button = widgets_by_name and widgets_by_name.reset_button
        -- local random_button = widgets_by_name and widgets_by_name.random_button

        -- local alternate_fire_toggle = widgets_by_name and widgets_by_name.alternate_fire_toggle
        -- local crosshair_toggle = widgets_by_name and widgets_by_name.crosshair_toggle
        -- local damage_type_toggle = widgets_by_name and widgets_by_name.damage_type_toggle

        -- local tip_1 = widgets_by_name and widgets_by_name.tip_1
        -- local tip_1_button = widgets_by_name and widgets_by_name.tip_1_button

        -- local color_dropdown = widgets_by_name and widgets_by_name.color_dropdown
        -- local pattern_dropdown = widgets_by_name and widgets_by_name.pattern_dropdown
        -- local wear_dropdown = widgets_by_name and widgets_by_name.wear_dropdown

        -- local color_button = widgets_by_name and widgets_by_name.color_button
        -- local pattern_button = widgets_by_name and widgets_by_name.pattern_button
        -- local wear_button = widgets_by_name and widgets_by_name.wear_button

        -- local color_text = widgets_by_name and widgets_by_name.color_text
        -- local pattern_text = widgets_by_name and widgets_by_name.pattern_text
        -- local wear_text = widgets_by_name and widgets_by_name.wear_text

        if widgets_by_name.reset_button then widgets_by_name.reset_button.visible = false end
        if widgets_by_name.random_button then widgets_by_name.random_button.visible = false end
        
        if widgets_by_name.alternate_fire_toggle then widgets_by_name.alternate_fire_toggle.visible = false end
        if widgets_by_name.crosshair_toggle then widgets_by_name.crosshair_toggle.visible = false end
        if widgets_by_name.damage_type_toggle then widgets_by_name.damage_type_toggle.visible = false end
        
        if widgets_by_name.tip_1 then widgets_by_name.tip_1.visible = false end
        if widgets_by_name.tip_1_button then widgets_by_name.tip_1_button.visible = false end
        
        if widgets_by_name.color_dropdown then widgets_by_name.color_dropdown.visible = false end
        if widgets_by_name.pattern_dropdown then widgets_by_name.pattern_dropdown.visible = false end
        if widgets_by_name.wear_dropdown then widgets_by_name.wear_dropdown.visible = false end
        
        if widgets_by_name.color_text then widgets_by_name.color_text.visible = false end
        if widgets_by_name.pattern_text then widgets_by_name.pattern_text.visible = false end
        if widgets_by_name.wear_text then widgets_by_name.wear_text.visible = false end

        if widgets_by_name.color_button then widgets_by_name.color_button.visible = false end
        if widgets_by_name.pattern_button then widgets_by_name.pattern_button.visible = false end
        if widgets_by_name.wear_button then widgets_by_name.wear_button.visible = false end
    end
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "selected_item_name_in_slot", function(func, self, slot_name, ...)

    -- Check customization menu and slot name
    if slot_name and self.customize_attachments then
        -- Return selected name
        return self["_selected_"..slot_name.."_name"]
    end

    -- Original function
    return func(self, slot_name, ...)

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "equipped_item_name_in_slot", function(func, self, slot_name, ...)

    -- Check customization menu and slot name
    if slot_name and self.customize_attachments then
        -- Return equipped name
        return self["_equipped_"..slot_name.."_name"]
    end

    -- Original function
    return func(self, slot_name, ...)

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_destroy_forward_gui", function(func, self, ...)

    -- Check customization menu
    if self.customize_attachments then
        -- Set flags
        mod.is_in_customization_menu = nil
        mod.customization_menu_slot_name = nil
        -- Clear item origin table
        table_clear(pt.items_originating_from_customization_menu)

        -- Check selected material overrides
        if self.selected_color_override or self.selected_pattern_override or self.selected_wear_override then

            -- Reload gear settings
            self:reload_gear_settings()

            -- Reset selected material overrides
            self.selected_color_override = nil
            self.selected_pattern_override = nil
            self.selected_wear_override = nil

        end

    end
    
    -- Original function
    func(self, ...)

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "on_enter", function(func, self, ...)
    if self.customize_attachments then
        CLASS.InventoryWeaponCosmeticsView.super.on_enter(self)

        mod.is_in_customization_menu = true

        self.finished_tutorial = mod:get("customization_menu_finished_tutorial")

        self._render_settings.alpha_multiplier = 0

        self:_setup_forward_gui()

        self._background_widget = self:_create_widget("background", inventory_weapon_cosmetics_view_definitions.background_widget)

        if not self._selected_item then
            return
        end

        local grid_size = inventory_weapon_cosmetics_view_definitions.grid_settings.grid_size

        self._content_blueprints = mod:original_require("scripts/ui/view_content_blueprints/item_blueprints")(grid_size)

        self:_setup_input_legend()

        local tabs_content = {}

        if self._presentation_item then

            local gear_id = math_uuid()

            self._presentation_item.gear_id = gear_id
            self._presentation_item.__gear_id = gear_id
            self._presentation_item.__original_gear_id = gear_id
            self._presentation_item.__attachment_customization = true

            pt.items_originating_from_customization_menu[gear_id] = true

            local weapon_template = self._presentation_item.weapon_template
            local attachments = weapon_template and mod.settings.attachments[weapon_template]
            if attachments then
                for attachment_slot, attachment_entries in pairs(attachments) do
                    
                    -- if mod:selectable_attachment_count(attachment_entries) > 1 and not table_contains(mod.settings.hide_attachment_slots_in_menu, attachment_slot) then
                    if mod:selectable_attachment_count(attachment_entries) > 1 and not mod:cached_table_contains(mod.settings.hide_attachment_slots_in_menu, attachment_slot) then
                        tabs_content[#tabs_content+1] = {
                            display_name = attachment_slot,
                            slot_name = attachment_slot,
                            get_item_filters = function (slot_name, item_type)
                                local slot_filter = slot_name and {
                                    slot_name,
                                }
                                return slot_filter, nil
                            end,
                            setup_selected_item_function = function (real_item, selected_item)
                                if real_item.name == self["_selected_"..attachment_slot.."_name"] then
                                    self["_selected_"..attachment_slot] = real_item
                                end
                            end,
                            get_empty_item = function (selected_item, presentation_item)
                                local empty_master_item = master_items.get_item("content/items/weapons/player/trinkets/unused_trinket")
                                local item = items.weapon_trinket_preview_item(empty_master_item)
                                item.empty_item = true
                                return item
                            end,
                            generate_visual_item_function = function (slot_name, real_item, attachment_data)

                                local real_item = real_item or self["_selected_"..slot_name]
                                local attachment_item = master_items.get_item(real_item.name)
                                local visual_item = items.weapon_trinket_preview_item(real_item)

                                local gear_id = math_uuid()

                                visual_item.gear_id = gear_id
                                visual_item.__attachment_customization = true
                                attachment_item.icon_render_unit_rotation_offset = attachment_data and attachment_data.icon_render_unit_rotation_offset or {90, 0, 0}
                                attachment_item.icon_render_camera_position_offset = attachment_data and attachment_data.icon_render_camera_position_offset or {0, -1, 0}

                                mod:gear_settings(gear_id, {
                                    [slot_name] = real_item and real_item.name or "",
                                })

                                mod:modify_item(visual_item.__data or visual_item.__master_item or visual_item)

                                return visual_item
                                
                            end,
                            apply_on_preview = function (real_item, presentation_item)

                                if real_item then
                                    self["_selected_"..attachment_slot.."_name"] = real_item.name
                                    self["_selected_"..attachment_slot] = real_item
                                end

                            end,
                        }
                    end
                end
            end
        end

        if not self._on_enter_anim_id then
            self._on_enter_anim_id = self:_start_animation("on_enter", self._widgets_by_name, self)
        end

        self.attachment_selection_rotation_offset = 0
        self.current_default_rotation_angle = 0

        if self._presentation_item then
            self:_setup_weapon_preview()

            local gear_id = mod:gear_id(self._presentation_item, true)
            pt.items_originating_from_customization_menu[gear_id] = true

            self:_preview_item(self._presentation_item)
            self._weapon_preview:center_align(0, {-.3, 0, -.2})
        end

        self:present_grid_layout({})
        self:_register_button_callbacks()
        self:_fetch_inventory_items(tabs_content)
        self:_setup_menu_tabs(tabs_content)
        self:cb_switch_tab(1)

        local weapon_preview = self._weapon_preview

        if weapon_preview then
            weapon_preview:center_align(1, {-.3, 0, -.2})
        end

        if self._widgets_by_name.tip_1 then
            self._widgets_by_name.tip_1.content.title = "title test title"
            self._widgets_by_name.tip_1.content.text = "test test text"
        end

        self:create_color_dropdown()
        self:create_pattern_dropdown()
        self:create_wear_dropdown()

        return
    end
    -- Original function
    func(self, ...)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_preview_element", function(func, self, element, ...)

    -- Check customization menu and content tabs
    if self.customize_attachments and self._tabs_content then

        -- Check element
        if element then

            -- Variables
            local selected_tab_index = self._selected_tab_index
            local content = self._tabs_content[selected_tab_index]
            local apply_on_preview = content.apply_on_preview
            local presentation_item = self._presentation_item
            local slot_name = content.slot_name
            local replacement_path = content.replacement_path
            local item = element.item
            local real_item = element.real_item

            -- Set preview item and element
            self._previewed_item = item
            self._previewed_element = element

            local attachment_display_name

            -- Check real item
            if real_item then

                -- Get attachment data
                local attachment_data = mod.settings.attachment_data_by_item_string[real_item.name]
                local attachments = mod.settings.attachments[presentation_item.weapon_template]

                -- local detached, validated = {}, {}
                table_clear(temp_detached)
                table_clear(temp_validated)

                -- Offsets
                if attachment_data then
                    -- self.attachment_selection_position_offset = attachment_data.attachment_selection_position_offset or empty_position
                    self.attachment_selection_rotation_offset = attachment_data.attachment_selection_rotation_offset
                    -- self.attachment_selection_zoom_offset = attachment_data.attachment_selection_zoom_offset or 0
                end

                -- Detach attachments
                -- Automatic attachment conflict management
                if attachment_data and attachment_data.detach_attachments then
                    -- Iterate through detach attachments
                    for _, attachment_slot_or_attachment_name in pairs(attachment_data.detach_attachments) do
                        -- Check attachment
                        if attachments[attachment_slot_or_attachment_name] then
                            -- Remove attachment slot
                            mod:modify_item(presentation_item, nil, {
                                [attachment_slot_or_attachment_name] = "content/items/weapons/player/trinkets/unused_trinket"
                            })
                            -- Temp detached
                            temp_detached[attachment_slot_or_attachment_name] = true
                            -- Set selected element name
                            self["_selected_"..attachment_slot_or_attachment_name.."_name"] = "content/items/weapons/player/trinkets/unused_trinket"
                        else
                            -- Iterate through attachments and remove attachment with specific name
                            for attachment_slot, attachment_entries in pairs(attachments) do
                                -- Check attachment name
                                if self["_selected_"..attachment_slot.."_name"] == attachment_slot_or_attachment_name then
                                    -- Remove attachment slot
                                    mod:modify_item(presentation_item, nil, {
                                        [attachment_slot] = "content/items/weapons/player/trinkets/unused_trinket"
                                    })
                                    -- Temp detached
                                    temp_detached[attachment_slot] = true
                                    -- Set selected element name
                                    self["_selected_"..attachment_slot.."_name"] = "content/items/weapons/player/trinkets/unused_trinket"
                                    -- Specific attachment detached; break
                                    break
                                end
                            end
                        end
                    end
                end

                -- Overwrite selected
                for attachment_slot, attachment_entries in pairs(attachments) do
                    -- Get selected or saved attachment
                    local selected_or_saved = (slot_name == attachment_slot and self["_selected_"..attachment_slot.."_name"]) or self["_equipped_"..attachment_slot.."_name"]
                    -- Check attachment name and not detached
                    if selected_or_saved and not temp_detached[attachment_slot] then
                        -- Set attachment
                        mod:modify_item(presentation_item, nil, {
                            [attachment_slot] = selected_or_saved
                        })
                        -- Set selected element name
                        self["_selected_"..attachment_slot.."_name"] = selected_or_saved
                        -- Temp validated
                        temp_validated[attachment_slot] = true
                    end
                end

                -- Validate attachments
                if attachment_data and attachment_data.validate_attachments then
                    -- Iterate through validate attachment slots
                    for _, attachment_slot in pairs(attachment_data.validate_attachments) do
                        -- Check attachment and not validated and empty item
                        if attachments and attachments[attachment_slot] and (not temp_validated[attachment_slot] or self["_selected_"..attachment_slot.."_name"] == "content/items/weapons/player/trinkets/unused_trinket") then
                            -- Get replacement path
                            local replacement_path = self["_equipped_"..attachment_slot.."_name"]
                            -- Iterate through attachments and set first with validation default
                            for attachment_name, attachment_data in pairs(attachments[attachment_slot]) do
                                -- Check validation default
                                if attachment_data.validation_default then
                                    -- Set replacement path
                                    replacement_path = attachment_data.replacement_path
                                    -- Validation target found; break
                                    break
                                end
                            end
                            -- Set attachment
                            mod:modify_item(presentation_item, nil, {
                                [attachment_slot] = replacement_path
                            })
                            -- Set selected element name
                            self["_selected_"..attachment_slot.."_name"] = replacement_path
                        end
                    end
                end

                -- Check display name for localization
                if real_item.display_name and real_item.display_name ~= "" and real_item.display_name ~= "n/a" then
                    -- Test localize display name
                    local test_localize = localize(real_item.display_name)
                    -- if has_localization(real_item.display_name) then
                    -- if test_localize ~= "<"..real_item.display_name..">" then
                    if string_sub(test_localize, 1, 1) ~= "<" and string_sub(test_localize, -1) ~= ">" then
                        attachment_display_name = test_localize
                    end
                end

            else
                -- Set selected element name to empty item
                self["_selected_"..slot_name.."_name"] = "content/items/weapons/player/trinkets/unused_trinket"
            end

            -- Set selected element
            mod:modify_item(presentation_item, nil, {
                [slot_name] = real_item and real_item.name or "content/items/weapons/player/trinkets/unused_trinket"
            })

            -- Apply on preview callback
            apply_on_preview(real_item, presentation_item)

            -- Set originating from customization menu
            local gear_id = mod:gear_id(presentation_item, true)
            pt.items_originating_from_customization_menu[gear_id] = true

            -- Preview presentation item
            self:_preview_item(presentation_item)

            local widgets_by_name = self._widgets_by_name
            -- Generate attachment name
            if not attachment_display_name or attachment_display_name == "" then
                attachment_display_name = mod.settings.attachment_name_by_item_string[real_item and real_item.name] or "empty"
                -- attachment_display_name = string_gsub(attachment_display_name, "_", " ")
                attachment_display_name = mod:cached_gsub(attachment_display_name, "_", " ")
                -- attachment_display_name = string_gsub(attachment_display_name, "%f[%a].", string_upper)
                attachment_display_name = mod:cached_gsub(attachment_display_name, "%f[%a].", string_upper)
            end
            -- Set display name
            widgets_by_name.sub_display_name.content.text = string_format("%s • %s", items.weapon_card_display_name(self._selected_item), items.weapon_card_sub_display_name(self._selected_item))
            widgets_by_name.display_name.content.text = attachment_display_name

            return
        end
    end

    -- Check element
    if not element then
        -- Return; prevent crash
        return
    end

    -- Original function
    func(self, element, ...)

end)

-- Handle material overrides and rotation angle when in customization menu
mod:hook(CLASS.InventoryWeaponCosmeticsView, "_preview_item", function(func, self, item, ...)

    -- Original function
    func(self, item, ...)

    -- Check customization menu
    if self.customize_attachments then

        -- self.ewc_view_settings = mod:collect_fixes(self._presentation_item, "view_settings")
        -- mod:echo("view_settings: "..tostring(self.ewc_view_settings))
        -- self._max_zoom = self.ewc_view_settings and self.ewc_view_settings.max_zoom or 4
        -- mod:echo("zoom: "..tostring(self._max_zoom))
        -- self:_update_weapon_preview_viewport()

        -- local tab_content = self._tabs_content and self._tabs_content[self._selected_tab_index]
        -- local slot_name = tab_content and tab_content.slot_name
        local slot_name = self:selected_slot_name()

        -- Get attachment slots from item
        local attachment_slots = mod:fetch_attachment_slots(self._selected_item.attachments)
        -- Iterate through attachment slots
        for attachment_slot, data in pairs(attachment_slots) do
            -- Get material overrides from item
            local material_overrides = mod:gear_material_overrides(self._selected_item, nil, attachment_slot)
            -- Check material overrides
            if material_overrides then
                -- Apply material overrides to presentation item
                mod:gear_material_overrides(self._presentation_item, nil, attachment_slot, material_overrides)
            end
        end

        if slot_name and self.selected_color_override == "" then
            mod:clear_gear_material_overrides(self._presentation_item, nil, slot_name, {OVERRIDE_TYPE.color})
        end

        if slot_name and self.selected_pattern_override == "" then
            mod:clear_gear_material_overrides(self._presentation_item, nil, slot_name, {OVERRIDE_TYPE.pattern})
        end

        if slot_name and self.selected_wear_override == "" then
            mod:clear_gear_material_overrides(self._presentation_item, nil, slot_name, {OVERRIDE_TYPE.wear})
        end

        -- Get weapon preview
        local weapon_preview = self._weapon_preview
        -- Get ui weapon spawner
        local ui_weapon_spawner = weapon_preview and weapon_preview._ui_weapon_spawner
        -- Check ui weapon spawner
        if ui_weapon_spawner then
            -- Set default rotation angle
            if self.current_default_rotation_angle then
                ui_weapon_spawner._default_rotation_angle = self.current_default_rotation_angle
                ui_weapon_spawner._rotation_angle = self.current_default_rotation_angle
            end
            -- Set current default rotation angle
            self.current_default_rotation_angle = self.attachment_selection_rotation_offset or 0
        end

    end

end)

-- Save attachment settings when in customization menu
mod:hook(CLASS.InventoryWeaponCosmeticsView, "cb_on_equip_pressed", function(func, self, ...)

    -- Check customization menu
    if self.customize_attachments then

        -- Get slot name
        local slot_name = self:selected_slot_name()
        
        -- Set flags
        mod.is_in_customization_menu = nil
        mod.customization_menu_slot_name = nil

        -- Clear item origin table
        table_clear(pt.items_originating_from_customization_menu)

        -- Get gear id
        local gear_id = mod:gear_id(self._selected_item)

        -- Create new gear settings
        local gear_settings = {}

        -- Get possible attachment slots
        local attachments = mod.settings.attachments[self._selected_item.weapon_template]

        -- Iterate through attachment slots
        for attachment_slot, attachment_name in pairs(attachments) do
            -- Set gear setting for attachment slot
            gear_settings[attachment_slot] = self["_selected_"..attachment_slot.."_name"] or "content/items/weapons/player/trinkets/unused_trinket"
            -- Set equipped name
            self["_equipped_"..attachment_slot.."_name"] = gear_settings[attachment_slot]
        end

        -- Get attachment slots from item
        local attachment_slots = mod:fetch_attachment_slots(self._presentation_item.attachments)
        -- Iterate through attachment slots
        for attachment_slot, data in pairs(attachment_slots) do
            -- Get material overrides from item
            local material_overrides = mod:gear_material_overrides(self._presentation_item, nil, attachment_slot)
            -- Check material overrides
            if material_overrides then
                -- Apply material overrides to presentation item
                mod:gear_material_overrides(self._selected_item, nil, attachment_slot, material_overrides)
                -- gear_settings.material_overrides = gear_settings.material_overrides or {}
                -- gear_settings.material_overrides[attachment_slot] = material_overrides
            end
        end

        -- Reset color overrides
        if slot_name and self.selected_color_override == "" then
            mod:clear_gear_material_overrides(self._selected_item, nil, slot_name, {OVERRIDE_TYPE.color})
        end

        -- Reset pattern overrides
        if slot_name and self.selected_pattern_override == "" then
            mod:clear_gear_material_overrides(self._selected_item, nil, slot_name, {OVERRIDE_TYPE.pattern})
        end

        -- Reset wear overrides
        if slot_name and self.selected_wear_override == "" then
            mod:clear_gear_material_overrides(self._selected_item, nil, slot_name, {OVERRIDE_TYPE.wear})
        end

        -- Clear selected material overrides
        self.selected_color_override = nil
        self.selected_pattern_override = nil
        self.selected_wear_override = nil

        self:cb_on_alternate_fire_toggle_pressed(true)
        self:cb_on_crosshair_toggle_pressed(true)
        self:cb_on_damage_type_toggle_pressed(true)

        -- Set new gear settings
        mod:gear_settings(gear_id, gear_settings, true)

        -- Update real world item
        self:update_real_world_item()

        -- Update inventory background view
        local inventory_background_view = mod:get_view("inventory_background_view")
        if inventory_background_view then
            inventory_background_view:event_force_refresh_inventory()
        end

        -- Set flag
        mod.is_in_customization_menu = true

        -- Switch tab
        self:cb_switch_tab(self._selected_tab_index)

        return
    else
        -- Delete item from item cache
        local gear_id = mod:gear_id(self._selected_item)
        mod:clear_mod_item(gear_id)
    end

    -- Original function
    func(self, ...)

end)

-- Only fetch inventory items if not in customization menu; prevent crash
mod:hook(CLASS.InventoryWeaponCosmeticsView, "_fetch_inventory_items", function(func, self, tabs_content, ...)

    -- Check customization menu
	if self.customize_attachments then
        -- Set empty table
        self._items_by_slot = empty_table
        -- Prevent original function; prevent crash;
        return
    end

    -- Original function
    return func(self, tabs_content, ...)

end)

-- Only handle input if item grid is not hovered or dropdown open
mod:hook(CLASS.InventoryWeaponCosmeticsView, "_handle_input", function(func, self, input_service, dt, t, ...)

    -- Check item grid hovered or dropdown open
    if not self._item_grid:hovered() and not self.dropdown_open then
        -- Original function
        func(self, input_service, dt, t, ...)
    end

end)

-- Register button callbacks for custom widgets or hide custom widgets
mod:hook(CLASS.InventoryWeaponCosmeticsView, "_register_button_callbacks", function(func, self, ...)

    -- Original function
    func(self, ...)

    -- Get custom widgets
    local widgets_by_name = self._widgets_by_name
    
    -- local reset_button = widgets_by_name and widgets_by_name.reset_button
    -- local random_button = widgets_by_name and widgets_by_name.random_button

    -- local color_button = widgets_by_name and widgets_by_name.color_button
    -- local pattern_button = widgets_by_name and widgets_by_name.pattern_button
    -- local wear_button = widgets_by_name and widgets_by_name.wear_button
    
    -- local alternate_fire_toggle = widgets_by_name and widgets_by_name.alternate_fire_toggle
    -- local crosshair_toggle = widgets_by_name and widgets_by_name.crosshair_toggle
    -- local damage_type_toggle = widgets_by_name and widgets_by_name.damage_type_toggle

    -- local tip_1_button = widgets_by_name and widgets_by_name.tip_1_button

    -- Check customization menu
    if self.customize_attachments then
        -- Set callbacks for control buttons
        if widgets_by_name.reset_button then widgets_by_name.reset_button.content.hotspot.pressed_callback = callback(self, "cb_on_reset_pressed") end
        if widgets_by_name.random_button then widgets_by_name.random_button.content.hotspot.pressed_callback = callback(self, "cb_on_random_pressed") end
        -- Set callbacks for material override buttons
        if widgets_by_name.color_button then widgets_by_name.color_button.content.hotspot.pressed_callback = callback(self, "cb_on_color_pressed") end
        if widgets_by_name.pattern_button then widgets_by_name.pattern_button.content.hotspot.pressed_callback = callback(self, "cb_on_pattern_pressed") end
        if widgets_by_name.wear_button then widgets_by_name.wear_button.content.hotspot.pressed_callback = callback(self, "cb_on_wear_pressed") end
        -- Set callbacks for override toggle buttons
        if widgets_by_name.alternate_fire_toggle then widgets_by_name.alternate_fire_toggle.content.hotspot.pressed_callback = callback(self, "cb_on_alternate_fire_toggle_pressed") end
        if widgets_by_name.crosshair_toggle then widgets_by_name.crosshair_toggle.content.hotspot.pressed_callback = callback(self, "cb_on_crosshair_toggle_pressed") end
        if widgets_by_name.damage_type_toggle then widgets_by_name.damage_type_toggle.content.hotspot.pressed_callback = callback(self, "cb_on_damage_type_toggle_pressed") end
        -- Set callbacks for tip
        if widgets_by_name.tip_1_button then widgets_by_name.tip_1_button.content.hotspot.pressed_callback = callback(self, "cb_on_tip_1_pressed") end
    else
        -- Hide control buttons
        if widgets_by_name.reset_button then widgets_by_name.reset_button.visible = false end
        if widgets_by_name.random_button then widgets_by_name.random_button.visible = false end
        -- Hide material override buttons
        if widgets_by_name.color_button then widgets_by_name.color_button.visible = false end
        if widgets_by_name.pattern_button then widgets_by_name.pattern_button.visible = false end
        if widgets_by_name.wear_button then widgets_by_name.wear_button.visible = false end
        -- Hide override toggle buttons
        if widgets_by_name.alternate_fire_toggle then widgets_by_name.alternate_fire_toggle.visible = false end
        if widgets_by_name.crosshair_toggle then widgets_by_name.crosshair_toggle.visible = false end
        if widgets_by_name.damage_type_toggle then widgets_by_name.damage_type_toggle.visible = false end
        -- Hide tip
        if widgets_by_name.tip_1_button then widgets_by_name.tip_1_button.visible = false end
    end

end)
