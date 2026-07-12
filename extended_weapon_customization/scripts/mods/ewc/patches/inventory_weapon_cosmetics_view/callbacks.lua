-- File: extended_weapon_customization/scripts/mods/ewc/patches/inventory_weapon_cosmetics_view/callbacks.lua
local mod = get_mod("extended_weapon_customization"); if not mod then return end

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
local callback = callback
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local empty_table = {}

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

-- Performance impact: negligible. These helpers only route view callbacks and avoid duplicating hook bodies.
mod.inventory_weapon_cosmetics_view_install_callbacks = function(instance)
	instance.selected_slot_name = function(self)
		local tab_content = self._tabs_content and self._selected_tab_index and
			self._tabs_content[self._selected_tab_index]
		return tab_content and tab_content.slot_name
	end
end

mod.inventory_weapon_cosmetics_view_selected_item_name_in_slot = function(self, slot_name)
	if slot_name and self.customize_attachments then
		return true, self["_selected_" .. slot_name .. "_name"]
	end

	return false
end

mod.inventory_weapon_cosmetics_view_equipped_item_name_in_slot = function(self, slot_name)
	if slot_name and self.customize_attachments then
		return true, self["_equipped_" .. slot_name .. "_name"]
	end

	return false
end

mod.inventory_weapon_cosmetics_view_fetch_inventory_items = function(self)
	if self.customize_attachments then
		self._items_by_slot = empty_table
		return true
	end

	return false
end

mod.inventory_weapon_cosmetics_view_should_handle_input = function(self)
	local item_grid_hovered = self._item_grid and self._item_grid:hovered()
	return not item_grid_hovered and not self.dropdown_open and not self.ui_is_hovered
end

mod.inventory_weapon_cosmetics_view_register_button_callbacks = function(self)
	local widgets_by_name = self._widgets_by_name

	if not widgets_by_name then
		return
	end

	if self.customize_attachments then
		if widgets_by_name.reset_button then
			widgets_by_name.reset_button.content.hotspot.pressed_callback = callback(
				self, "cb_on_reset_pressed")
		end

		if widgets_by_name.random_button then
			widgets_by_name.random_button.content.hotspot.pressed_callback = callback(
				self, "cb_on_random_pressed")
		end

		if widgets_by_name.color_button then
			widgets_by_name.color_button.content.hotspot.pressed_callback = callback(
				self, "cb_on_color_pressed")
		end

		if widgets_by_name.pattern_button then
			widgets_by_name.pattern_button.content.hotspot.pressed_callback = callback(
				self, "cb_on_pattern_pressed")
		end

		if widgets_by_name.wear_button then
			widgets_by_name.wear_button.content.hotspot.pressed_callback = callback(self,
				"cb_on_wear_pressed")
		end

		if widgets_by_name.alternate_fire_toggle then
			widgets_by_name.alternate_fire_toggle.content.hotspot.pressed_callback =
				callback(self, "cb_on_alternate_fire_toggle_pressed")
		end

		if widgets_by_name.crosshair_toggle then
			widgets_by_name.crosshair_toggle.content.hotspot.pressed_callback =
				callback(self, "cb_on_crosshair_toggle_pressed")
		end

		if widgets_by_name.damage_type_toggle then
			widgets_by_name.damage_type_toggle.content.hotspot.pressed_callback =
				callback(self, "cb_on_damage_type_toggle_pressed")
		end

		if widgets_by_name.tip_1_button then
			widgets_by_name.tip_1_button.content.hotspot.pressed_callback = callback(
				self, "cb_on_tip_1_pressed")
		end
	else
		if widgets_by_name.reset_button then widgets_by_name.reset_button.visible = false end
		if widgets_by_name.random_button then widgets_by_name.random_button.visible = false end

		if widgets_by_name.color_button then widgets_by_name.color_button.visible = false end
		if widgets_by_name.pattern_button then widgets_by_name.pattern_button.visible = false end
		if widgets_by_name.wear_button then widgets_by_name.wear_button.visible = false end

		if widgets_by_name.alternate_fire_toggle then widgets_by_name.alternate_fire_toggle.visible = false end
		if widgets_by_name.crosshair_toggle then widgets_by_name.crosshair_toggle.visible = false end
		if widgets_by_name.damage_type_toggle then widgets_by_name.damage_type_toggle.visible = false end

		if widgets_by_name.tip_1_button then widgets_by_name.tip_1_button.visible = false end
		if widgets_by_name.plugin_warning then widgets_by_name.plugin_warning.visible = false end
	end
end
