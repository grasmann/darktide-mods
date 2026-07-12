-- File: extended_weapon_customization/scripts/mods/ewc/patches/inventory_weapon_cosmetics_view/tutorial.lua
local mod = get_mod("extended_weapon_customization")
if not mod then return end

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
	local pairs = pairs
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.inventory_weapon_cosmetics_view_install_tutorial = function(instance)

	-- ##### Hover alpha fade #########################################################################################

	-- Performance impact: negligible. This only iterates existing view widgets when tutorial/fade state changes.
	instance.set_widget_alpha_multiplier = function(self, alpha_multiplier, tab_menu_alpha_multiplier, item_grid_alpha_multiplier, toggle_buttons_alpha_multiplier, control_buttons_alpha_multiplier, material_override_alpha_multiplier)

		local widgets_by_name = self._widgets_by_name
		if not widgets_by_name then
			return
		end

		-- Set widgets in inventory weapon cosmetics view
		for _, widget in pairs(widgets_by_name) do
			widget.alpha_multiplier = alpha_multiplier
		end

		local tab_menu_alpha_multiplier = tab_menu_alpha_multiplier or alpha_multiplier
		-- Set tab menu widgets
		if widgets_by_name.button_pivot_background then
			-- Set background residing in inventory weapon cosmetics view
			widgets_by_name.button_pivot_background.alpha_multiplier = tab_menu_alpha_multiplier
			-- Check tab menu
			if self._tab_menu_element and self._tab_menu_element._widgets_by_name then
				-- Set widgets in tab menu
				for _, widget in pairs(self._tab_menu_element._widgets_by_name) do
					widget.alpha_multiplier = tab_menu_alpha_multiplier
				end
			end
		end

		local item_grid_alpha_multiplier = item_grid_alpha_multiplier or alpha_multiplier
		-- Set item grid widgets
		if self._item_grid and self._item_grid._widgets_by_name then
			-- Set widgets in item grid
			for _, widget in pairs(self._item_grid._widgets_by_name) do
				widget.alpha_multiplier = item_grid_alpha_multiplier
			end
		end

		local toggle_buttons_alpha_multiplier = toggle_buttons_alpha_multiplier or alpha_multiplier
		-- Set toggle button widgets
		if widgets_by_name.alternate_fire_toggle then
			widgets_by_name.alternate_fire_toggle.alpha_multiplier = toggle_buttons_alpha_multiplier
		end
		if widgets_by_name.crosshair_toggle then
			widgets_by_name.crosshair_toggle.alpha_multiplier = toggle_buttons_alpha_multiplier
		end
		if widgets_by_name.damage_type_toggle then
			widgets_by_name.damage_type_toggle.alpha_multiplier = toggle_buttons_alpha_multiplier
		end

		local control_buttons_alpha_multiplier = control_buttons_alpha_multiplier or alpha_multiplier
		-- Set random, reset and equip buttons
		if widgets_by_name.equip_button then
			widgets_by_name.equip_button.alpha_multiplier = control_buttons_alpha_multiplier
		end
		if widgets_by_name.reset_button then
			widgets_by_name.reset_button.alpha_multiplier = control_buttons_alpha_multiplier
		end
		if widgets_by_name.random_button then
			widgets_by_name.random_button.alpha_multiplier = control_buttons_alpha_multiplier
		end

		local material_override_alpha_multiplier = material_override_alpha_multiplier or alpha_multiplier
		-- Set color, pattern and wear
		if widgets_by_name.color_dropdown then
			widgets_by_name.color_dropdown.alpha_multiplier = material_override_alpha_multiplier
		end
		if widgets_by_name.pattern_dropdown then
			widgets_by_name.pattern_dropdown.alpha_multiplier = material_override_alpha_multiplier
		end
		if widgets_by_name.wear_dropdown then
			widgets_by_name.wear_dropdown.alpha_multiplier = material_override_alpha_multiplier
		end
		if widgets_by_name.color_button then
			widgets_by_name.color_button.alpha_multiplier = material_override_alpha_multiplier
		end
		if widgets_by_name.pattern_button then
			widgets_by_name.pattern_button.alpha_multiplier = material_override_alpha_multiplier
		end
		if widgets_by_name.wear_button then
			widgets_by_name.wear_button.alpha_multiplier = material_override_alpha_multiplier
		end
		if widgets_by_name.color_text then
			widgets_by_name.color_text.alpha_multiplier = material_override_alpha_multiplier
		end
		if widgets_by_name.pattern_text then
			widgets_by_name.pattern_text.alpha_multiplier = material_override_alpha_multiplier
		end
		if widgets_by_name.wear_text then
			widgets_by_name.wear_text.alpha_multiplier = material_override_alpha_multiplier
		end

	end

	-- ##### Tutorial functions #######################################################################################

	instance.cb_on_tip_1_pressed = function(self)
		self.tutorial_step = self.tutorial_step + 1
	end

	-- Performance impact: negligible. This updates a small number of tutorial widgets once per draw while the view is open.
	instance.tutorial = function(self)

		local widgets_by_name = self._widgets_by_name
		if not widgets_by_name then
			return false
		end

		-- Check if tutorial is finished
		if self.finished_tutorial then

			-- Hide tutorial window
			if widgets_by_name.tip_1 then
				widgets_by_name.tip_1.alpha_multiplier = 0
			end

			-- Hide tutorial button
			if widgets_by_name.tip_1_button then
				widgets_by_name.tip_1_button.alpha_multiplier = 0
				widgets_by_name.tip_1_button.content.hotspot.disabled = true
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
				widgets_by_name.tip_1.content.title = mod:localize("mod_tips_title_01")
				widgets_by_name.tip_1.content.text = mod:localize("mod_tips_01")

			elseif self.tutorial_step == 2 then
				self:set_widget_alpha_multiplier(.25, 1, .25, .25, .25, .25)
				widgets_by_name.tip_1.content.title = mod:localize("mod_tips_title_02")
				widgets_by_name.tip_1.content.text = mod:localize("mod_tips_02")

			elseif self.tutorial_step == 3 then
				self:set_widget_alpha_multiplier(.25, .25, 1, .25, .25, .25)
				widgets_by_name.tip_1.content.title = mod:localize("mod_tips_title_03")
				widgets_by_name.tip_1.content.text = mod:localize("mod_tips_03")

			elseif self.tutorial_step == 4 then
				self:set_widget_alpha_multiplier(.25, .25, .25, 1, .25, .25)
				widgets_by_name.tip_1.content.title = mod:localize("mod_tips_title_04")
				widgets_by_name.tip_1.content.text = mod:localize("mod_tips_04")

			elseif self.tutorial_step == 5 then
				self:set_widget_alpha_multiplier(.25, .25, .25, .25, .25, 1)
				widgets_by_name.tip_1.content.title = mod:localize("mod_tips_title_05")
				widgets_by_name.tip_1.content.text = mod:localize("mod_tips_05")

			elseif self.tutorial_step == 6 then
				self:set_widget_alpha_multiplier(.25, .25, .25, .25, 1, .25)
				widgets_by_name.tip_1.content.title = mod:localize("mod_tips_title_06")
				widgets_by_name.tip_1.content.text = mod:localize("mod_tips_06")

			elseif self.tutorial_step == 7 then
				-- Reset alpha
				self:set_widget_alpha_multiplier(1, 1, 1, 1, 1, 1)
				-- Finish tutorial
				self.finished_tutorial = true
				-- Save tutorial finished
				mod:set("customization_menu_finished_tutorial", true)
			end

			-- Show tutorial window
			if widgets_by_name.tip_1 then
				widgets_by_name.tip_1.alpha_multiplier = 1
			end

			-- Show tutorial button
			if widgets_by_name.tip_1_button then
				widgets_by_name.tip_1_button.alpha_multiplier = 1
				widgets_by_name.tip_1_button.content.hotspot.disabled = false
			end

			return true

		end

	end

	-- Performance impact: negligible. This only checks existing widget hotspot states while the customization view is open.
	instance.is_ui_hovered = function(self)
		
		local widgets_by_name = self._widgets_by_name
		if not widgets_by_name then
			return false
		end

		-- Get hovered value for view widgets
		local item_grid_hovered = self._item_grid and self._item_grid:hovered()
		local tab_menu_hovered = self._tab_menu_element and self._tab_menu_element:hovered()
		local equip_button_hovered = widgets_by_name.equip_button and widgets_by_name.equip_button.content.hotspot.is_hover

		-- Get hovered value for custom widgets
		local reset_button_hovered = widgets_by_name.reset_button and widgets_by_name.reset_button.content.hotspot.is_hover
		local random_button_hovered = widgets_by_name.random_button and widgets_by_name.random_button.content.hotspot.is_hover

		local alternate_fire_toggle_hovered = widgets_by_name.alternate_fire_toggle and widgets_by_name.alternate_fire_toggle.content.hotspot.is_hover
		local crosshair_toggle_hovered = widgets_by_name.crosshair_toggle and widgets_by_name.crosshair_toggle.content.hotspot.is_hover
		local damage_type_toggle_hovered = widgets_by_name.damage_type_toggle and widgets_by_name.damage_type_toggle.content.hotspot.is_hover

		local color_button_hovered = widgets_by_name.color_button and widgets_by_name.color_button.visible and widgets_by_name.color_button.content.hotspot.is_hover
		local pattern_button_hovered = widgets_by_name.pattern_button and widgets_by_name.pattern_button.visible and widgets_by_name.pattern_button.content.hotspot.is_hover
		local wear_button_hovered = widgets_by_name.wear_button and widgets_by_name.wear_button.visible and widgets_by_name.wear_button.content.hotspot.is_hover

		local color_dropdown_hovered = widgets_by_name.color_dropdown and widgets_by_name.color_dropdown.visible and widgets_by_name.color_dropdown.content.hotspot.is_hover
		local pattern_dropdown_hovered = widgets_by_name.pattern_dropdown and widgets_by_name.pattern_dropdown.visible and widgets_by_name.pattern_dropdown.content.hotspot.is_hover
		local wear_dropdown_hovered = widgets_by_name.wear_dropdown and widgets_by_name.wear_dropdown.visible and widgets_by_name.wear_dropdown.content.hotspot.is_hover

		local color_dropdown_option_hovered = widgets_by_name.color_dropdown and widgets_by_name.color_dropdown.visible and widgets_by_name.color_dropdown.content.hovered_option
		local pattern_dropdown_option_hovered = widgets_by_name.pattern_dropdown and widgets_by_name.pattern_dropdown.visible and widgets_by_name.pattern_dropdown.content.hovered_option
		local wear_dropdown_option_hovered = widgets_by_name.wear_dropdown and widgets_by_name.wear_dropdown.visible and widgets_by_name.wear_dropdown.content.hovered_option

		local color_dropdown_scrollbar_hovered_or_drag_active = widgets_by_name.color_dropdown and widgets_by_name.color_dropdown.visible and widgets_by_name.color_dropdown.content.scrollbar_hotspot.is_hover or widgets_by_name.color_dropdown.content.drag_active
		local pattern_dropdown_scrollbar_hovered_or_drag_active = widgets_by_name.pattern_dropdown and widgets_by_name.pattern_dropdown.visible and widgets_by_name.pattern_dropdown.content.scrollbar_hotspot.is_hover or widgets_by_name.pattern_dropdown.content.drag_active
		local wear_dropdown_scrollbar_hovered_or_drag_active = widgets_by_name.wear_dropdown and widgets_by_name.wear_dropdown.visible and widgets_by_name.wear_dropdown.content.scrollbar_hotspot.is_hover or widgets_by_name.wear_dropdown.content.drag_active

		return item_grid_hovered or tab_menu_hovered
				or equip_button_hovered or reset_button_hovered or random_button_hovered
				or alternate_fire_toggle_hovered or crosshair_toggle_hovered or damage_type_toggle_hovered
				or color_button_hovered or pattern_button_hovered or wear_button_hovered
				or color_dropdown_hovered or pattern_dropdown_hovered or wear_dropdown_hovered
				or color_dropdown_option_hovered or pattern_dropdown_option_hovered or wear_dropdown_option_hovered
				or color_dropdown_scrollbar_hovered_or_drag_active or pattern_dropdown_scrollbar_hovered_or_drag_active or wear_dropdown_scrollbar_hovered_or_drag_active

	end

end
