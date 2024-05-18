local mod = get_mod("weapon_customization")

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
	local string = string
	local get_mod = get_mod
	local Localize = Localize
	local tostring = tostring
	local managers = Managers
	local unit_alive = Unit.alive
	local string_gsub = string.gsub
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local WEAPON_CUSTOMIZATION_TAB = "tab_weapon_customization"
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/ui/views/inventory_background_view/inventory_background_view", function(instance)

	instance.get_inventory_view = function(self)
		self.inventory_view = self.inventory_view or mod:get_view("inventory_view")
	end

	instance.get_modding_tools = function(self)
		self.modding_tools = self.modding_tools or get_mod("modding_tools")
	end

	instance.remove_unit_manipulation = function(self)
		self:get_modding_tools()
		if self.modding_tools and self.modding_tools.unit_manipulation_remove_all then
			self.modding_tools:unit_manipulation_remove_all()
		end
	end

	instance.unit_manipulation_busy = function(self)
		self:get_modding_tools()
		if self.modding_tools and self.modding_tools.unit_manipulation_busy then
			return self.modding_tools and self.modding_tools:unit_manipulation_busy()
		end
	end

	instance.unit_manipulation_add = function(self, unit, camera, world, gui)
		self:get_modding_tools()
		if self.modding_tools and self.modding_tools.unit_manipulation_add then
			return self.modding_tools:unit_manipulation_add(unit, camera, world, gui, self.inventory_view:weapon_name())
		end
	end

	instance.unit_manipulation_select = function(self, unit)
		self:get_modding_tools()
		if self.modding_tools and self.modding_tools.unit_manipulation_select then
			self.modding_tools:unit_manipulation_select(unit)
		end
	end

	instance.set_unique_id = function(self)
		self._unique_id = self.__class_name.."_"..string_gsub(tostring(self), "table: ", "")
	end

	instance.add_custom_panel = function(self)
		if not self._custom_panel_added and self._views_settings then
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
							display_name = WEAPON_CUSTOMIZATION_TAB,
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
	end

	instance.add_unit_manipulation = function(self)
		-- Check profile spawner
		local ui_profile_spawner = self._profile_spawner
		if ui_profile_spawner and ui_profile_spawner._character_spawn_data then
			local character_spawn_data = ui_profile_spawner._character_spawn_data
			local unit = character_spawn_data and character_spawn_data.unit_3p

			if unit and unit_alive(unit) then

				self:get_inventory_view()
				
				if self.inventory_view and self.inventory_view._ui_forward_renderer then
					
					local tab_context = self.inventory_view._active_category_tab_context
					local is_tab = tab_context and tab_context.display_name == WEAPON_CUSTOMIZATION_TAB
					-- Check custom tab
					if is_tab then
						local weapon_unit = self.inventory_view.weapon_unit and self.inventory_view:weapon_unit()
						
						-- Check modding tools
						self:get_modding_tools()
						if self.modding_tools then
							local world = self.inventory_view._world
							local camera = ui_profile_spawner and ui_profile_spawner._camera
							local gui = self.inventory_view._ui_forward_renderer.gui
							
							-- Add units
							self:unit_manipulation_add(weapon_unit, camera, world, gui, self.inventory_view:weapon_name())
							self:unit_manipulation_select(weapon_unit)
						end

						-- Disable rotation when interacting with modding tools
						ui_profile_spawner._rotation_input_disabled = self:unit_manipulation_busy()
						local wbn = self.inventory_view._widgets_by_name
						if wbn then wbn.name_text.content.text = self._item_name or "n/a" end
					end

				end
			end
		end
	end

	instance.update_item_name = function(self)
		self:get_inventory_view()
		if self._profile_spawner and self.inventory_view then
			local slot_id = self._preview_wield_slot_id == "slot_primary" and "slot_secondary" or "slot_primary"
			local preview_profile_equipped_items = self._preview_profile_equipped_items
			local presentation_inventory = preview_profile_equipped_items
			local slot_item = presentation_inventory[slot_id]
			local item_name = Localize(slot_item.display_name)
			self._item_name = item_name
			-- Rotation
			self._profile_spawner._rotation_angle = self.inventory_view.customization_angle and self.inventory_view:customization_angle() or 0
		end
	end

	instance.reset_rotation = function(self)
		self:get_inventory_view()
		if self.inventory_view then
			self.inventory_view:reset_rotation()
		end
	end

end)

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #############################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################################################

mod:hook(CLASS.InventoryBackgroundView, "on_enter", function(func, self, ...)

	-- Modding tools
	self:remove_unit_manipulation()

	-- Original function
	func(self, ...)

end)

mod:hook(CLASS.InventoryBackgroundView, "on_exit", function(func, self, ...)

	-- Destroy background view
	self.inventory_view = nil

	-- Modding tools
	self:remove_unit_manipulation()

	-- Original function
	func(self, ...)

end)

mod:hook(CLASS.InventoryBackgroundView, "_update_has_empty_talent_nodes", function(func, self, optional_selected_nodes, ...)

	-- Custom panel
	self:add_custom_panel()

	-- Original function
	func(self, optional_selected_nodes, ...)

end)

mod:hook(CLASS.InventoryBackgroundView, "update", function(func, self, dt, t, input_service, ...)

	-- Original function
	local ret = func(self, dt, t, input_service, ...)

	-- Add unit manipulation
	self:add_unit_manipulation()

	-- Return
	return ret
end)

mod:hook(CLASS.InventoryBackgroundView, "cb_on_weapon_swap_pressed", function(func, self, ...)

	-- Rotation
	self:reset_rotation()

	-- Original function
	func(self, ...)

end)

mod:hook(CLASS.InventoryBackgroundView, "_update_presentation_wield_item", function(func, self, ...)

	-- Modding tools
	self:remove_unit_manipulation()

	-- Original function
	func(self, ...)

	-- Update weapon name
	self:update_item_name()

end)