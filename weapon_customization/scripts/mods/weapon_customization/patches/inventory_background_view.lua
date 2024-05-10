local mod = get_mod("weapon_customization")
local modding_tools = get_mod("modding_tools")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
	local ContentBlueprints = mod:original_require("scripts/ui/views/options_view/options_view_content_blueprints")
	local OptionsViewSettings = mod:original_require("scripts/ui/views/options_view/options_view_settings")
	local UIFontSettings = mod:original_require("scripts/managers/ui/ui_font_settings")
	local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
	local ScriptWorld = mod:original_require("scripts/foundation/utilities/script_world")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
	local Unit = Unit
	local math = math
	local CLASS = CLASS
	local get_mod = get_mod
	local Localize = Localize
	local unit_alive = Unit.alive
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data

--#endregion

mod:hook_require("scripts/ui/views/inventory_background_view/inventory_background_view", function(instance)

	instance.get_inventory_view = function(self)
		self.inventory_view = self.inventory_view or mod:get_view("inventory_view")
	end

end)

mod:hook(CLASS.InventoryBackgroundView, "on_exit", function(func, self, ...)

	-- Destroy background view
	self.inventory_view = nil

	-- Original function
	func(self, ...)

end)

mod:hook(CLASS.InventoryBackgroundView, "_update_has_empty_talent_nodes", function(func, self, optional_selected_nodes, ...)
	modding_tools = get_mod("modding_tools")
	if not self._custom_panel_added then
		local player = self._preview_player
		local profile = player:profile()
		local profile_archetype = profile.archetype
		local archetype_name = profile_archetype.name
		local is_ogryn = archetype_name == "ogryn"
		self._views_settings[#self._views_settings + 1] = {
			view_name = "inventory_view",
			display_name = "loc_visible_equipment_customization",
			update = function (content, style, dt) end,
			view_context = {
				tabs = {
					{
						ui_animation = "cosmetics_on_enter",
						display_name = "tab_weapon_customization",
						draw_wallet = false,
						allow_item_hover_information = true,
						icon = "content/ui/materials/icons/system/settings/category_gameplay",
						is_grid_layout = false,
						camera_settings = {
							{"event_inventory_set_camera_position_axis_offset", "x", is_ogryn and 1.8 or 1.45, 0.5, math.easeCubic},
							{"event_inventory_set_camera_position_axis_offset", "y", 2, 0.5, math.easeCubic},
							{"event_inventory_set_camera_position_axis_offset", "z", .3, 0.5, math.easeCubic},
							{"event_inventory_set_camera_rotation_axis_offset", "x", 0, 0.5, math.easeCubic},
							{"event_inventory_set_camera_rotation_axis_offset", "y", 0, 0.5, math.easeCubic},
							{"event_inventory_set_camera_rotation_axis_offset", "z", 0, 0.5, math.easeCubic},
						},
						item_hover_information_offset = {0},
						layout = {}
					}
				}
			}
		}
		self._custom_panel_added = true
	end
end)

mod:hook(CLASS.InventoryBackgroundView, "update", function(func, self, dt, t, input_service, ...)
	local ret = func(self, dt, t, input_service, ...)
	if self._profile_spawner and self._profile_spawner._character_spawn_data then
		local unit = self._profile_spawner._character_spawn_data.unit_3p
		if unit and unit_alive(unit) then
			self:get_inventory_view()
			if self.inventory_view then
				local tab_context = self.inventory_view._active_category_tab_context
				local is_tab = tab_context and tab_context.display_name == "tab_weapon_customization"
				-- Check custom tab
				if is_tab then
					local ui_profile_spawner = self._profile_spawner
					local weapon_unit = self.inventory_view.weapon_unit and self.inventory_view:weapon_unit()
					-- Check modding tools
					if modding_tools then
						local world = self.inventory_view._world
						local camera = ui_profile_spawner and ui_profile_spawner._camera
						local gui = self.inventory_view._ui_forward_renderer.gui
						-- Add units
						modding_tools:unit_manipulation_add(weapon_unit, camera, world, gui)
						modding_tools:unit_manipulation_select(weapon_unit)
					end
					-- Disable rotation when interacting with modding tools
					ui_profile_spawner._rotation_input_disabled = modding_tools and modding_tools:unit_manipulation_busy()
					local wbn = self.inventory_view._widgets_by_name
					if wbn then wbn.name_text.content.text = self._item_name end
				end
			end
		end
	end
	return ret
end)

mod:hook(CLASS.InventoryBackgroundView, "cb_on_weapon_swap_pressed", function(func, self, ...)

	self:get_inventory_view()

	if self.inventory_view then
		self.inventory_view:respawn_profile()
	end

	func(self, ...)

end)

mod:hook(CLASS.InventoryBackgroundView, "_update_presentation_wield_item", function(func, self, ...)

	self:get_inventory_view()

	if self.inventory_view and self.inventory_view.weapon_unit then
		if modding_tools then
			modding_tools:unit_manipulation_remove(self.inventory_view:weapon_unit())
		end
	end

	-- Original function
	func(self, ...)

	-- Update weapon name in inventory view
	if self._profile_spawner and self.inventory_view then
		local slot_id = self._preview_wield_slot_id == "slot_primary" and "slot_secondary" or "slot_primary"
		local preview_profile_equipped_items = self._preview_profile_equipped_items
		local presentation_inventory = preview_profile_equipped_items
		local slot_item = presentation_inventory[slot_id]
		local item_name = Localize(slot_item.display_name)
		self._item_name = item_name
		self._profile_spawner._rotation_angle = self.inventory_view.customization_angle and self.inventory_view:customization_angle() or 0
	end

end)