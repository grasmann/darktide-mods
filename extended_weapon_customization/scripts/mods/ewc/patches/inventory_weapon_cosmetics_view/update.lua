-- File: extended_weapon_customization/scripts/mods/ewc/patches/inventory_weapon_cosmetics_view/update.lua
local mod = get_mod("extended_weapon_customization"); if not mod then return end

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
local math = math
local localize = Localize
local math_lerp = math.lerp
local utf8_upper = Utf8.upper
local string_format = string.format
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local TEXT_COLOR_DISABLED = {255, 0, 0}
local TEXT_COLOR_ENABLED = {255, 255, 255}
local OWNED_GLYPH = ""

-- ##### ┬ ┬┌─┐┌─┐┌┬┐┌─┐┬─┐┌─┐ #################################################################################################
-- ##### ├─┤├┤ ├─┤ ││├┤ ├┬┘└─┐ #################################################################################################
-- ##### ┴ ┴└─┘┴ ┴─┴┘└─┘┴└─└─┘ #################################################################################################

local function hide_custom_widgets(widgets_by_name)
	if not widgets_by_name then
		return
	end

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

local function update_equip_button(self, widgets_by_name, slot_name)
	local disable_button = true

	if self["_selected_" .. slot_name .. "_name"] ~= self["_equipped_" .. slot_name .. "_name"] or
			self.selected_color_override or self.selected_pattern_override or self.selected_wear_override then
		disable_button = false
	end

	local button_content = widgets_by_name.equip_button.content

	button_content.hotspot.disabled = disable_button
	button_content.text = utf8_upper(disable_button and localize("loc_weapon_inventory_equipped_button") or
		localize("loc_weapon_inventory_equip_button"))
end

local function update_reset_button(self, widgets_by_name)
	if widgets_by_name.reset_button then
		local button_content = widgets_by_name.reset_button.content
		local gear_id = mod:gear_id(self._selected_item)

		button_content.hotspot.disabled = not mod:gear_settings(gear_id)
	end
end

local function update_auto_rotation(self, dt)
	local weapon_preview = self._weapon_preview
	local ui_weapon_spawner = weapon_preview and weapon_preview._ui_weapon_spawner

	if ui_weapon_spawner and not self.modding_tools then
		if self.current_default_rotation_angle ~= ui_weapon_spawner._default_rotation_angle then
			ui_weapon_spawner._default_rotation_angle = math_lerp(ui_weapon_spawner._default_rotation_angle,
				self.current_default_rotation_angle, dt)
		end

		if ui_weapon_spawner._rotation_angle ~= ui_weapon_spawner._default_rotation_angle and not ui_weapon_spawner._is_rotating then
			ui_weapon_spawner._rotation_angle = math_lerp(ui_weapon_spawner._rotation_angle,
				ui_weapon_spawner._default_rotation_angle, dt)
		end
	end
end

local function update_grid_owned_markers(self, slot_name)
	local grid_widgets = self._item_grid and self._item_grid:widgets()

	if grid_widgets then
		for i = 1, #grid_widgets do
			local widget = grid_widgets[i]

			if widget then
				local content = widget.content
				local element = content and content.element
				local real_item = element and element.real_item
				local item_path = real_item and real_item.name
				local attachment_data = mod.settings.attachment_data_by_item_string[item_path]

				if attachment_data and attachment_data.replacement_path == self["_equipped_" .. slot_name .. "_name"] then
					content.owned = OWNED_GLYPH
				else
					content.owned = nil
				end
			end
		end
	end
end

local function update_toggle_text(widget, display_name, enabled)
	local text_color = enabled and TEXT_COLOR_ENABLED or TEXT_COLOR_DISABLED

	widget.content.text = string_format("{#color(%d,%d,%d)}%s{#reset()}",
		text_color[1], text_color[2], text_color[3], localize(display_name))
end

local function update_alternate_fire_toggle(self, widgets_by_name)
	local has_alternate_fire = mod:item_has(self._selected_item, "alternate_fire") or not self.finished_tutorial
	local widget = widgets_by_name.alternate_fire_toggle

	if has_alternate_fire and widget then
		local gear_id = mod:gear_id(self._selected_item)
		local alternate_fire_list = mod:get(mod.inventory_weapon_cosmetics_view_alternate_fire_setting)
		local alternate_fire_value = alternate_fire_list and alternate_fire_list[gear_id]

		if alternate_fire_value == nil then
			alternate_fire_value = true
		end

		update_toggle_text(widget, "loc_weapon_inventory_alternate_fire_toggle", alternate_fire_value)
	end

	if widget then
		widget.visible = has_alternate_fire
	end
end

local function update_crosshair_toggle(self, widgets_by_name)
	local has_crosshair = mod:item_has(self._selected_item, "crosshair_type") or not self.finished_tutorial
	local widget = widgets_by_name.crosshair_toggle

	if has_crosshair and widget then
		local gear_id = mod:gear_id(self._selected_item)
		local crosshair_list = mod:get(mod.inventory_weapon_cosmetics_view_crosshair_list_setting)
		local crosshair_value = crosshair_list and crosshair_list[gear_id]

		if crosshair_value == nil then
			crosshair_value = true
		end

		update_toggle_text(widget, "loc_weapon_inventory_crosshair_toggle", crosshair_value)
	end

	if widget then
		widget.visible = has_crosshair
	end
end

local function update_damage_type_toggle(self, widgets_by_name)
	local has_damage_type = mod:item_has(self._selected_item, "damage_type") or not self.finished_tutorial
	local widget = widgets_by_name.damage_type_toggle

	if has_damage_type and widget then
		local gear_id = mod:gear_id(self._selected_item)
		local damage_type_active_list = mod:get(mod.inventory_weapon_cosmetics_view_damage_type_active_setting) or {}
		local damage_type_value = damage_type_active_list and damage_type_active_list[gear_id]

		if damage_type_value == nil then
			damage_type_value = true
		end

		update_toggle_text(widget, "loc_weapon_inventory_damage_type_toggle", damage_type_value)
	end

	if widget then
		widget.visible = has_damage_type
	end
end

local function update_dropdowns(self, widgets_by_name, input_service, dt, t)
	if widgets_by_name.color_dropdown then
		self:update_dropdown(widgets_by_name.color_dropdown, input_service, dt, t)
	end

	if widgets_by_name.pattern_dropdown then
		self:update_dropdown(widgets_by_name.pattern_dropdown, input_service, dt, t)
	end

	if widgets_by_name.wear_dropdown then
		self:update_dropdown(widgets_by_name.wear_dropdown, input_service, dt, t)
	end
end

local function update_clear_override_buttons(widgets_by_name)
	if widgets_by_name.color_button and widgets_by_name.color_dropdown then
		widgets_by_name.color_button.visible = widgets_by_name.color_dropdown.content.entry.get_function()
	end

	if widgets_by_name.pattern_button and widgets_by_name.pattern_dropdown then
		widgets_by_name.pattern_button.visible = widgets_by_name.pattern_dropdown.content.entry.get_function()
	end

	if widgets_by_name.wear_button and widgets_by_name.wear_dropdown then
		widgets_by_name.wear_button.visible = widgets_by_name.wear_dropdown.content.entry.get_function()
	end
end

local function update_tab_scrollbar(self, input_service, dt, t)
	if self._tab_menu_element and input_service then
		mod.inventory_weapon_cosmetics_view_update_tab_scrollbar(self, self._tab_menu_element, input_service)
	end
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

-- Performance impact: per-frame while the cosmetics view is open. Work is limited to existing visible widgets and grid widgets.
mod.inventory_weapon_cosmetics_view_draw = function(self, dt)
	self.ui_is_hovered = self:is_ui_hovered()

	-- Check if tutorial is active
	if not self:tutorial() then
		-- Check if any custom widgets are hovered
		if self.customize_attachments and not self.ui_is_hovered then
			-- Fade out custom widgets when no custom widgets are hovered
			self.animated_alpha_multiplier = math_lerp(self.animated_alpha_multiplier, .3, dt * 4)
		else
			-- Fade in custom widgets when any custom widgets are hovered
			self.animated_alpha_multiplier = math_lerp(self.animated_alpha_multiplier, 1, dt * 4)
		end
	end
end

-- Performance impact: per-frame while the cosmetics view is open. Uses existing widget tables and preserves existing dropdown update behaviour.
mod.inventory_weapon_cosmetics_view_update = function(self, dt, t, input_service)
	if self.customize_attachments and self._tabs_content and self._selected_tab_index and self._tabs_content[self._selected_tab_index] then
		local slot_name = self:selected_slot_name()
		local widgets_by_name = self._widgets_by_name

		if not slot_name or not widgets_by_name or not widgets_by_name.equip_button then
			return
		end

		update_equip_button(self, widgets_by_name, slot_name)
		update_reset_button(self, widgets_by_name)
		update_auto_rotation(self, dt)
		update_grid_owned_markers(self, slot_name)

		update_alternate_fire_toggle(self, widgets_by_name)
		update_crosshair_toggle(self, widgets_by_name)
		update_damage_type_toggle(self, widgets_by_name)

		update_tab_scrollbar(self, input_service, dt, t)

		update_dropdowns(self, widgets_by_name, input_service, dt, t)
		update_clear_override_buttons(widgets_by_name)

		return
	end

	hide_custom_widgets(self._widgets_by_name)
end
