-- File: extended_weapon_customization/scripts/mods/ewc/patches/inventory_weapon_cosmetics_view.lua
local mod = get_mod("extended_weapon_customization"); if not mod then return end

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
local CLASS = CLASS
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################


mod.inventory_weapon_cosmetics_view_alternate_fire_setting = "alternate_fire"
mod.inventory_weapon_cosmetics_view_crosshair_list_setting = "crosshair"
mod.inventory_weapon_cosmetics_view_damage_type_active_setting = "damage_type_active"

mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/inventory_weapon_cosmetics_view/tutorial")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/inventory_weapon_cosmetics_view/dropdowns")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/inventory_weapon_cosmetics_view/tabs")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/inventory_weapon_cosmetics_view/preview")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/inventory_weapon_cosmetics_view/equip")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/inventory_weapon_cosmetics_view/lifecycle")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/inventory_weapon_cosmetics_view/update")
mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/patches/inventory_weapon_cosmetics_view/callbacks")

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

-- Selectable attachment counting is installed by inventory_weapon_cosmetics_view/tabs.lua.

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view", function(instance)
	mod.inventory_weapon_cosmetics_view_install_callbacks(instance)
	mod.inventory_weapon_cosmetics_view_install_tutorial(instance)
	mod.inventory_weapon_cosmetics_view_install_dropdowns(instance)
	mod.inventory_weapon_cosmetics_view_install_equip(instance)
end)

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

-- Initialize view
mod:hook(CLASS.InventoryWeaponCosmeticsView, "init", function(func, self, settings, context, ...)
	-- Original function
	func(self, settings, context, ...)

	mod.inventory_weapon_cosmetics_view_init(self, context)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_setup_menu_tabs", function(func, self, content, ...)
	if self.customize_attachments and content and mod.inventory_weapon_cosmetics_view_setup_menu_tabs(self, content) then
		return
	end

	-- Original function
	func(self, content, ...)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "cb_switch_tab", function(func, self, index, ...)
	if self.customize_attachments and self._tabs_content and mod.inventory_weapon_cosmetics_view_switch_tab(self, index) then
		return
	end

	-- Check element
	if not self._tabs_content or not self._tabs_content[index] then
		-- Return; prevent crash
		return
	end

	-- Original function
	func(self, index, ...)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_setup_sort_options", function(func, self, ...)
	if self.customize_attachments and mod.inventory_weapon_cosmetics_view_setup_sort_options(self) then
		return
	end

	-- Original function
	func(self, ...)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "draw", function(func, self, dt, t, input_service, layer, ...)
	if self.customize_attachments then
		mod.inventory_weapon_cosmetics_view_draw(self, dt)
	end

	-- Original function
	func(self, dt, t, input_service, layer, ...)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "update", function(func, self, dt, t, input_service, ...)
	-- Original function
	func(self, dt, t, input_service, ...)

	mod.inventory_weapon_cosmetics_view_update(self, dt, t, input_service)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "selected_item_name_in_slot", function(func, self, slot_name, ...)
	local handled, selected_item_name = mod.inventory_weapon_cosmetics_view_selected_item_name_in_slot(self, slot_name)
	if handled then
		return selected_item_name
	end

	-- Original function
	return func(self, slot_name, ...)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "equipped_item_name_in_slot", function(func, self, slot_name, ...)
	local handled, equipped_item_name = mod.inventory_weapon_cosmetics_view_equipped_item_name_in_slot(self, slot_name)
	if handled then
		return equipped_item_name
	end

	-- Original function
	return func(self, slot_name, ...)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_destroy_forward_gui", function(func, self, ...)
	mod.inventory_weapon_cosmetics_view_destroy_forward_gui(self)

	-- Original function
	func(self, ...)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "on_enter", function(func, self, ...)
	if mod.inventory_weapon_cosmetics_view_on_enter(self) then
		return
	end

	-- Original function
	func(self, ...)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_preview_element", function(func, self, element, ...)
	if self.customize_attachments and self._tabs_content and mod.inventory_weapon_cosmetics_view_preview_element(self, element) then
		return
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

	if self.customize_attachments then
		mod.inventory_weapon_cosmetics_view_preview_item(self)
	end
end)

-- Save attachment settings when in customization menu
mod:hook(CLASS.InventoryWeaponCosmeticsView, "cb_on_equip_pressed", function(func, self, ...)
	if self.customize_attachments and mod.inventory_weapon_cosmetics_view_equip_selected(self) then
		return
	end

	-- Delete item from item cache
	local gear_id = mod:gear_id(self._selected_item)
	mod:clear_mod_item(gear_id)

	-- Original function
	func(self, ...)
end)

-- Only fetch inventory items if not in customization menu; prevent crash
mod:hook(CLASS.InventoryWeaponCosmeticsView, "_fetch_inventory_items", function(func, self, tabs_content, ...)
	if mod.inventory_weapon_cosmetics_view_fetch_inventory_items(self) then
		return
	end

	-- Original function
	return func(self, tabs_content, ...)
end)

-- Only handle input if item grid is not hovered or dropdown open
mod:hook(CLASS.InventoryWeaponCosmeticsView, "_handle_input", function(func, self, input_service, dt, t, ...)
	if mod.inventory_weapon_cosmetics_view_should_handle_input(self) then
		-- Original function
		func(self, input_service, dt, t, ...)
	end
end)

-- Register button callbacks for custom widgets or hide custom widgets
mod:hook(CLASS.InventoryWeaponCosmeticsView, "_register_button_callbacks", function(func, self, ...)
	-- Original function
	func(self, ...)

	mod.inventory_weapon_cosmetics_view_register_button_callbacks(self)
end)
