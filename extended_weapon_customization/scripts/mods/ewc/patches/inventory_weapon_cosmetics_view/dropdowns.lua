-- File: extended_weapon_customization/scripts/mods/ewc/patches/inventory_weapon_cosmetics_view/dropdowns.lua
local mod = get_mod("extended_weapon_customization")
if not mod then return end

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local DropdownPassTemplates = mod:original_require("scripts/ui/pass_templates/dropdown_pass_templates")
local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
	local math = math
	local table = table
	local pairs = pairs
	local vector3 = Vector3
	local vector2 = Vector2
	local managers = Managers
	local math_max = math.max
	local math_min = math.min
	local math_ceil = math.ceil
	local string_upper = string.upper
	local table_contains = table.contains
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local ItemMaterialOverridesGearMaterials = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/legacy_material_overrides/item_material_overrides_gear_materials")
local ItemMaterialOverridesGearPatterns = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/legacy_material_overrides/item_material_overrides_gear_patterns")
local ItemMaterialOverridesGearColors = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/legacy_material_overrides/item_material_overrides_gear_colors")

local dropdown_size = {400, 38}
local scrollbar_width = 14

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

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.inventory_weapon_cosmetics_view_install_dropdowns = function(instance)

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

	-- Performance impact: low. This is per-frame while the customization view is open, but it reuses existing widget state and allocates no persistent tables.
	instance.update_dropdown = function(self, widget, input_service, dt, t)
		if not widget or not widget.content or not input_service then
			return
		end

		local content = widget.content
		local entry = content.entry
		local options = content.options
		local options_by_id = content.options_by_id

		if not entry or not options or not options_by_id then
			return
		end

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
		local position = vector2(size[1] - scrollbar_width, 0)
		local using_gamepad = not managers.ui:using_cursor_navigation()
		local offset = widget.offset
		local style = widget.style
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

		local scrollbar_hotspot = content.scrollbar_hotspot
		local scrollbar_hovered = scrollbar_hotspot.is_hover
		local on_pressed = scrollbar_hotspot.on_pressed

		if not content.drag_active then
			if on_pressed then
				content.drag_active = true
			end
		end

		if not input_service:get("left_hold") and content.drag_active then
			content.drag_active = nil
			content.drag_was_active = true
		elseif content.drag_active then
			new_selection_index = math_min(math_max(1, num_options * content.scroll_percentage or 0), num_options)
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
		local end_index = math.min(start_index + num_visible_options - 1, num_options)
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

		if content.drag_active then
			return
		end

		local value_changed = new_value ~= nil

		if value_changed and new_value ~= value then
			local on_activated = entry.on_activated

			on_activated(new_value, entry)
		end

		if content.drag_was_active then
			content.drag_was_active = nil
			content.wait_next_frame = false
			content.close_setting = false
			self.dropdown_closing = false

			return
		end
	
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

	-- Performance impact: moderate only during view setup. It allocates the dropdown option tables once when the customization view opens.
	instance.create_dropdown = function(self, dropdown_name, options, size)

		if not dropdown_name or not options then
			return
		end

		local effective_dropdown_size = size or dropdown_size
		local num_visible_options = math_min(10, #options)
		local template = DropdownPassTemplates.settings_dropdown(effective_dropdown_size[1], effective_dropdown_size[2], effective_dropdown_size[1], num_visible_options, true)
		for index, pass in pairs(template) do
			if pass.style_id == "text" then
				pass.style.font_size = 16
			end
			if pass.style_id == "scrollbar_hotspot" or pass.style_id == "scrollbar_track" or pass.style_id == "thumb" then
				pass.style.size[1] = scrollbar_width
			end
		end
		local definition = UIWidget.create_definition(template, dropdown_name, nil, effective_dropdown_size)
		local widget = self:_create_widget(dropdown_name, definition)

		self._widgets[#self._widgets+1] = widget
		self._widgets_by_name[dropdown_name] = widget

		table.sort(options, compare_item_name)

		local content = widget.content
		local options_by_id = {}
		for index, option in pairs(options) do
			options_by_id[option.id] = option
		end
		content.dropdown_size = effective_dropdown_size
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
				if slot_name and selected_option then

					if dropdown_name == "color_dropdown" then
						self.selected_color_override = new_value
					elseif dropdown_name == "pattern_dropdown" then
						self.selected_pattern_override = new_value
					elseif dropdown_name == "wear_dropdown" then
						self.selected_wear_override = new_value
					end

					mod:gear_material_overrides(self._presentation_item, nil, slot_name, selected_option.material_overrides)
					-- mod:gear_material_overrides(self._selected_item, nil, slot_name, selected_option.material_overrides)

					self:_preview_item(self._presentation_item)

				end
			end,
			get_function = function()

				if content.selected_index then

					-- local tab_content = self._tabs_content[self._selected_tab_index]
					-- local slot_name = tab_content.slot_name

					local slot_name = self:selected_slot_name()
					local material_override = slot_name and mod:gear_material_overrides(self._presentation_item, nil, slot_name)
					if material_override then
						for _, option in pairs(options) do
							if material_override.material_overrides and table_contains(material_override.material_overrides, option.value) then
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

		content.area_length = effective_dropdown_size[2] * content.num_visible_options

		local scroll_length = math.max(effective_dropdown_size[2] * num_options - content.area_length, 0)

		content.scroll_length = scroll_length

		local spacing = 0
		local scroll_amount = scroll_length > 0 and (effective_dropdown_size[2] + spacing) / scroll_length or 0

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

end
