local mod = get_mod("weapon_customization")

local inventory_weapon_cosmetics_view_definitions = mod:original_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view_definitions")
local DropdownPassTemplates = mod:original_require("scripts/ui/pass_templates/dropdown_pass_templates")
local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
local UIFontSettings = mod:original_require("scripts/managers/ui/ui_font_settings")
local MasterItems = mod:original_require("scripts/backend/master_items")
local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")
local ScriptCamera = mod:original_require("scripts/foundation/utilities/script_camera")
local ButtonPassTemplates = mod:original_require("scripts/ui/pass_templates/button_pass_templates")

local grid_size = inventory_weapon_cosmetics_view_definitions.grid_settings.grid_size
local edge_padding = inventory_weapon_cosmetics_view_definitions.grid_settings.edge_padding
local grid_width = grid_size[1] + edge_padding
local button_width = grid_width * 0.3

mod.original_weapon_settings = {}
mod.changed_weapon_settings = {}

mod.get_changed_weapon_settings = function(self, InventoryWeaponCosmeticsView)
	local gear_id = self:get_gear_id(InventoryWeaponCosmeticsView._selected_item)
	if gear_id then
		local attachment_slots = self:get_item_attachment_slots(InventoryWeaponCosmeticsView._selected_item)
		for _, attachment_slot in pairs(attachment_slots) do
			mod.changed_weapon_settings[attachment_slot] = mod:get(tostring(gear_id).."_"..attachment_slot)
		end
	end
end

mod.added_cosmetics_scenegraphs = {}
for _, attachment_slot in pairs(mod.attachment_slots) do
	mod.added_cosmetics_scenegraphs[#mod.added_cosmetics_scenegraphs+1] = attachment_slot.."_text_pivot"
	mod.added_cosmetics_scenegraphs[#mod.added_cosmetics_scenegraphs+1] = attachment_slot.."_pivot"
end

mod.update_equip_button = function(self, InventoryWeaponCosmeticsView)
	if InventoryWeaponCosmeticsView._selected_tab_index == 3 then
		local button = InventoryWeaponCosmeticsView._widgets_by_name.equip_button
		local button_content = button.content
		local disabled = table.size(self.original_weapon_settings) == 0
		button_content.hotspot.disabled = disabled
		button_content.text = Utf8.upper(disabled and Localize("loc_weapon_inventory_equipped_button") or Localize("loc_weapon_inventory_equip_button"))
	end
end

mod.update_reset_button = function(self, InventoryWeaponCosmeticsView)
	local button = InventoryWeaponCosmeticsView._widgets_by_name.reset_button
	local button_content = button.content
	local disabled = table.size(self.changed_weapon_settings) == 0
	button_content.hotspot.disabled = disabled
	button_content.text = Utf8.upper(disabled and self:localize("loc_weapon_inventory_no_reset_button") or self:localize("loc_weapon_inventory_reset_button"))
end

mod.check_unsaved_changes = function(self, InventoryWeaponCosmeticsView)
	if table.size(mod.original_weapon_settings) > 0 then
		local gear_id = mod:get_gear_id(InventoryWeaponCosmeticsView._selected_item)
		if gear_id then

			mod:attachment_package_snapshot(InventoryWeaponCosmeticsView._presentation_item)

			for attachment_slot, value in pairs(mod.original_weapon_settings) do
				if string.find(value, "default") then
					mod:set(tostring(gear_id).."_"..attachment_slot, nil)
				else
					mod:set(tostring(gear_id).."_"..attachment_slot, value)
				end
			end

			InventoryWeaponCosmeticsView._presentation_item = MasterItems.create_preview_item_instance(InventoryWeaponCosmeticsView._selected_item)

			mod.flashlight_attached[gear_id] = nil

			if InventoryWeaponCosmeticsView._previewed_element then
				InventoryWeaponCosmeticsView:_preview_element(InventoryWeaponCosmeticsView._previewed_element)
			else
				InventoryWeaponCosmeticsView:_preview_item(InventoryWeaponCosmeticsView._presentation_item)
			end

			local old_packages, new_packages = mod:attachment_package_snapshot(InventoryWeaponCosmeticsView._presentation_item)
			if new_packages and #new_packages > 0 then
				local weapon_loader = InventoryWeaponCosmeticsView._weapon_preview._ui_weapon_spawner
				local reference_name = weapon_loader._reference_name .. "_weapon_item_loader_" .. tostring(weapon_loader._weapon_loader_index)
				for _, new_package in pairs(new_packages) do
					Managers.package:load(new_package, reference_name, nil, true)
				end
			end

			local package_synchronizer_client = Managers.package_synchronization:synchronizer_client()
			if package_synchronizer_client then
				package_synchronizer_client:reevaluate_all_profiles_packages()
			end
			mod:redo_weapon_attachments(gear_id)

			-- Managers.ui:item_icon_updated(InventoryWeaponCosmeticsView._selected_item)
			-- Managers.event:trigger("event_item_icon_updated", InventoryWeaponCosmeticsView._selected_item)
			-- Managers.event:trigger("event_replace_list_item", InventoryWeaponCosmeticsView._selected_item)
			mod.weapon_changed = nil
			mod.original_weapon_settings = {}
		end
		-- InventoryWeaponCosmeticsView._widgets_by_name.equip_button.content.hotspot.disabled = false
		mod:update_equip_button(InventoryWeaponCosmeticsView)
	end
end

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_register_button_callbacks", function(func, self, ...)
	func(self, ...)
	local widgets_by_name = self._widgets_by_name
	local reset_button = widgets_by_name.reset_button
	reset_button.content.hotspot.pressed_callback = callback(mod, "cb_on_reset_pressed")
	local randomize_button = widgets_by_name.randomize_button
	randomize_button.content.hotspot.pressed_callback = callback(mod, "cb_on_randomize_pressed")
end)

mod.cb_on_randomize_pressed = function(self)
	local InventoryWeaponCosmeticsView = Managers.ui:view_instance("inventory_weapon_cosmetics_view")
	if InventoryWeaponCosmeticsView and InventoryWeaponCosmeticsView._selected_item then
		local random_attachments = mod:randomize_weapon(InventoryWeaponCosmeticsView._selected_item)

		local gear_id = mod:get_gear_id(InventoryWeaponCosmeticsView._selected_item)
		if gear_id and random_attachments then
			mod:attachment_package_snapshot(InventoryWeaponCosmeticsView._presentation_item)

			for attachment_slot, value in pairs(random_attachments) do
				if not mod.original_weapon_settings[attachment_slot] then
					if not mod:get(tostring(gear_id).."_"..attachment_slot) then
						mod.original_weapon_settings[attachment_slot] = "default"
					else
						mod.original_weapon_settings[attachment_slot] = mod:get(tostring(gear_id).."_"..attachment_slot)
					end
				end
				self:set(tostring(gear_id).."_"..attachment_slot, value)
			end

			InventoryWeaponCosmeticsView._presentation_item = MasterItems.create_preview_item_instance(InventoryWeaponCosmeticsView._selected_item)

			mod.flashlight_attached[gear_id] = nil

			if InventoryWeaponCosmeticsView._previewed_element then
				InventoryWeaponCosmeticsView:_preview_element(InventoryWeaponCosmeticsView._previewed_element)
			else
				InventoryWeaponCosmeticsView:_preview_item(InventoryWeaponCosmeticsView._presentation_item)
			end

			local old_packages, new_packages = mod:attachment_package_snapshot(InventoryWeaponCosmeticsView._presentation_item)
			if new_packages and #new_packages > 0 then
				local weapon_loader = InventoryWeaponCosmeticsView._weapon_preview._ui_weapon_spawner
				local reference_name = weapon_loader._reference_name .. "_weapon_item_loader_" .. tostring(weapon_loader._weapon_loader_index)
				for _, new_package in pairs(new_packages) do
					Managers.package:load(new_package, reference_name, nil, true)
				end
			end

			local package_synchronizer_client = Managers.package_synchronization:synchronizer_client()
			if package_synchronizer_client then
				package_synchronizer_client:reevaluate_all_profiles_packages()
			end
			mod:redo_weapon_attachments(gear_id)

			-- Managers.ui:item_icon_updated(InventoryWeaponCosmeticsView._selected_item)
			-- Managers.event:trigger("event_item_icon_updated", InventoryWeaponCosmeticsView._selected_item)
			-- Managers.event:trigger("event_replace_list_item", InventoryWeaponCosmeticsView._selected_item)

			-- self.changed_weapon_settings = {}
			self:update_reset_button(InventoryWeaponCosmeticsView)
		end
	end
end

mod.cb_on_reset_pressed = function(self)
	if table.size(self.changed_weapon_settings) > 0 then
		local InventoryWeaponCosmeticsView = Managers.ui:view_instance("inventory_weapon_cosmetics_view")
		if InventoryWeaponCosmeticsView then
			local gear_id = mod:get_gear_id(InventoryWeaponCosmeticsView._selected_item)
			if gear_id then
				mod:attachment_package_snapshot(InventoryWeaponCosmeticsView._presentation_item)

				for attachment_slot, data in pairs(self.changed_weapon_settings) do
					self:set(tostring(gear_id).."_"..attachment_slot, nil)
				end

				InventoryWeaponCosmeticsView._presentation_item = MasterItems.create_preview_item_instance(InventoryWeaponCosmeticsView._selected_item)

				mod.flashlight_attached[gear_id] = nil

				if InventoryWeaponCosmeticsView._previewed_element then
					InventoryWeaponCosmeticsView:_preview_element(InventoryWeaponCosmeticsView._previewed_element)
				else
					InventoryWeaponCosmeticsView:_preview_item(InventoryWeaponCosmeticsView._presentation_item)
				end

				local old_packages, new_packages = mod:attachment_package_snapshot(InventoryWeaponCosmeticsView._presentation_item)
				if new_packages and #new_packages > 0 then
					local weapon_loader = InventoryWeaponCosmeticsView._weapon_preview._ui_weapon_spawner
					local reference_name = weapon_loader._reference_name .. "_weapon_item_loader_" .. tostring(weapon_loader._weapon_loader_index)
					for _, new_package in pairs(new_packages) do
						Managers.package:load(new_package, reference_name, nil, true)
					end
				end

				local package_synchronizer_client = Managers.package_synchronization:synchronizer_client()
				if package_synchronizer_client then
					package_synchronizer_client:reevaluate_all_profiles_packages()
				end
				mod:redo_weapon_attachments(gear_id)

				Managers.ui:item_icon_updated(InventoryWeaponCosmeticsView._selected_item)
				Managers.event:trigger("event_item_icon_updated", InventoryWeaponCosmeticsView._selected_item)
				Managers.event:trigger("event_replace_list_item", InventoryWeaponCosmeticsView._selected_item)

				self.changed_weapon_settings = {}
				self:update_reset_button(InventoryWeaponCosmeticsView)
			end
		end
	end
end

mod:hook(CLASS.InventoryWeaponCosmeticsView, "update", function(func, self, dt, t, input_service, ...)
    func(self, dt, t, input_service, ...)
    mod:update_custom_widgets(self, input_service)
	mod:update_equip_button(self)
	mod:update_reset_button(self)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "cb_on_equip_pressed", function(func, self, ...)
	func(self, ...)
	if self._selected_tab_index == 3 then
		mod.original_weapon_settings = {}
		-- self._widgets_by_name.equip_button.content.hotspot.disabled = true
		mod:update_equip_button(self)

		local gear_id = mod:get_gear_id(self._selected_item)
		if gear_id then
			self._presentation_item = MasterItems.create_preview_item_instance(self._selected_item)

			mod.flashlight_attached[gear_id] = nil

			if self._previewed_element then
				self:_preview_element(self._previewed_element)
			else
				self:_preview_item(self._presentation_item)
			end

			local package_synchronizer_client = Managers.package_synchronization:synchronizer_client()
			if package_synchronizer_client then
				package_synchronizer_client:reevaluate_all_profiles_packages()
			end
			mod:redo_weapon_attachments(gear_id)

			Managers.ui:item_icon_updated(self._selected_item)
			Managers.event:trigger("event_item_icon_updated", self._selected_item)
			Managers.event:trigger("event_replace_list_item", self._selected_item)

			mod.weapon_changed = true
		end
	end
end)

mod.weapon_changed = nil

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_setup_menu_tabs", function(func, self, content, ...)
    content[3] = {
        display_name = "loc_weapon_cosmetics_customization",
		slot_name = "slot_weapon_skin",
		item_type = "WEAPON_SKIN",
		icon = "content/ui/materials/icons/system/settings/category_gameplay",
		filter_on_weapon_template = true,
		apply_on_preview = function (real_item, presentation_item)
            self:_preview_item(presentation_item)
			-- mod.weapon_changed = true
		end
    }
    func(self, content, ...)
    
    self._tab_menu_element._widgets_by_name.entry_0.content.size[1] = button_width
    self._tab_menu_element._widgets_by_name.entry_1.content.size[1] = button_width
    self._tab_menu_element._widgets_by_name.entry_2.content.size[1] = button_width
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "cb_switch_tab", function(func, self, index, ...)
	if index == 3 then
        self:present_grid_layout({})
        self._item_grid._widgets_by_name.grid_empty.visible = false
        mod:hide_custom_widgets(self, false)
    else
		local t = Managers.time:time("main")
		mod.reset_start = t
		mod:check_unsaved_changes(self)
        mod:hide_custom_widgets(self, true)
    end
    func(self, index, ...)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_select_starting_item_by_slot_name", function(func, self, slot_name, optional_start_index, ...)
	if self._selected_tab_index < 3 then
		func(self, slot_name, optional_start_index, ...)
	end
end)

mod.label_template = function(self, text, scenegraph_id)
	local style = table.clone(UIFontSettings.grid_title)
	style.offset = {0, 15, 1}
    return UIWidget.create_definition({
        {
            value_id = "text",
            style_id = "text",
            pass_type = "text",
            value = mod:localize(text),
            style = style,
        }
    }, scenegraph_id)
end

mod.generate_label = function(self, InventoryWeaponCosmeticsView, scenegraph, attachment_slot, item)

	local weapon_name = self:item_name_from_content_string(item.name)
	local style = table.clone(UIFontSettings.grid_title)
	style.offset = {0, 15, 1}
	local text = "loc_weapon_cosmetics_customization_"..attachment_slot

	if self.text_overwrite[weapon_name] then
		text = self.text_overwrite[weapon_name][text] or text
	end

    local definition = UIWidget.create_definition({
        {
            value_id = "text",
            style_id = "text",
            pass_type = "text",
            value = self:localize(text),
            style = style,
        }
    }, scenegraph, nil)

	local widget_name = attachment_slot.."_custom_text"
	local widget = InventoryWeaponCosmeticsView:_create_widget(widget_name, definition)

	InventoryWeaponCosmeticsView._widgets_by_name[widget_name] = widget
    InventoryWeaponCosmeticsView._widgets[#InventoryWeaponCosmeticsView._widgets+1] = widget

	return widget
end

mod.generate_dropdown = function(self, InventoryWeaponCosmeticsView, scenegraph, attachment_slot, item)

    local gear_id = mod:get_gear_id(item)

    local weapon_name = mod:item_name_from_content_string(item.name)
    local options = {}
    if mod.attachment[weapon_name] and mod.attachment[weapon_name][attachment_slot] then
        for _, data in pairs(mod.attachment[weapon_name][attachment_slot]) do
            options[#options+1] = mod:dropdown_option(data.id, data.name, data.sounds)
        end
    end

    local max_visible_options = 5
    local num_options = #options
    local num_visible_options = math.min(num_options, max_visible_options)

    local size = {grid_size[1], 50}
    local template = DropdownPassTemplates.settings_dropdown(size[1], size[2], size[1], num_visible_options, true)
	template[7].pass_type = "texture"
	template[7].value = "content/ui/materials/backgrounds/terminal_basic"
	template[7].style.horizontal_alignment = "center"
    local definition = UIWidget.create_definition(template, scenegraph, nil, size)
    local widget_name = attachment_slot.."_custom"
    local widget = InventoryWeaponCosmeticsView:_create_widget(widget_name, definition)

    InventoryWeaponCosmeticsView._widgets_by_name[widget_name] = widget
    InventoryWeaponCosmeticsView._widgets[#InventoryWeaponCosmeticsView._widgets+1] = widget

    local content = widget.content
    content.entry = {
        options = options,
        widget_type = "dropdown",
        on_activated = function(new_value, entry)

			mod:attachment_package_snapshot(InventoryWeaponCosmeticsView._presentation_item)

			if not mod.original_weapon_settings[attachment_slot] then
				if not mod:get(tostring(gear_id).."_"..attachment_slot) then
					mod.original_weapon_settings[attachment_slot] = "default"
				else
					mod.original_weapon_settings[attachment_slot] = mod:get(tostring(gear_id).."_"..attachment_slot)
				end
			end

			local item_name = mod:item_name_from_content_string(InventoryWeaponCosmeticsView._presentation_item.name)
			local weapon_attachments = mod.attachment_models[item_name]
			local attachment = weapon_attachments[new_value]
			if attachment and string.find(new_value, "default") then
				mod:set(tostring(gear_id).."_"..attachment_slot, nil)
			else
				mod:set(tostring(gear_id).."_"..attachment_slot, new_value)
			end

			InventoryWeaponCosmeticsView._presentation_item = MasterItems.create_preview_item_instance(InventoryWeaponCosmeticsView._selected_item)

			mod.flashlight_attached[gear_id] = nil

			if InventoryWeaponCosmeticsView._previewed_element then
				InventoryWeaponCosmeticsView:_preview_element(InventoryWeaponCosmeticsView._previewed_element)
			else
				InventoryWeaponCosmeticsView:_preview_item(InventoryWeaponCosmeticsView._presentation_item)
			end

			local old_packages, new_packages = mod:attachment_package_snapshot(InventoryWeaponCosmeticsView._presentation_item)
			if new_packages and #new_packages > 0 then
				local weapon_loader = InventoryWeaponCosmeticsView._weapon_preview._ui_weapon_spawner
				local reference_name = weapon_loader._reference_name .. "_weapon_item_loader_" .. tostring(weapon_loader._weapon_loader_index)
				for _, new_package in pairs(new_packages) do
					Managers.package:load(new_package, reference_name, nil, true)
				end
			end

			-- local package_synchronizer_client = Managers.package_synchronization:synchronizer_client()
			-- if package_synchronizer_client then
			-- 	package_synchronizer_client:reevaluate_all_profiles_packages()
			-- end
			-- mod:redo_weapon_attachments(gear_id)

			-- Managers.ui:item_icon_updated(InventoryWeaponCosmeticsView._selected_item)
			-- Managers.event:trigger("event_item_icon_updated", InventoryWeaponCosmeticsView._selected_item)
			-- Managers.event:trigger("event_replace_list_item", InventoryWeaponCosmeticsView._selected_item)

			for _, option in pairs(entry.options) do
				if option.id == new_value then
					if option.sounds then
						for _, sound in pairs(option.sounds) do
							InventoryWeaponCosmeticsView:_play_sound(sound)
						end
					end
				end
			end

			local new_angle = attachment.angle or 0
			if attachment.angle ~= 0 and InventoryWeaponCosmeticsView._weapon_preview._ui_weapon_spawner._default_rotation_angle ~= new_angle then
				InventoryWeaponCosmeticsView:_play_sound(UISoundEvents.apparel_zoom_in)
			elseif InventoryWeaponCosmeticsView._weapon_preview._ui_weapon_spawner._default_rotation_angle ~= new_angle then
				InventoryWeaponCosmeticsView:_play_sound(UISoundEvents.apparel_zoom_out)
			end
			InventoryWeaponCosmeticsView._weapon_preview._ui_weapon_spawner._rotation_angle = mod._last_rotation_angle or 0
			InventoryWeaponCosmeticsView._weapon_preview._ui_weapon_spawner._default_rotation_angle = new_angle
			mod._last_rotation_angle = InventoryWeaponCosmeticsView._weapon_preview._ui_weapon_spawner._default_rotation_angle

			if attachment.move then
				mod:start_weapon_move(attachment.move)
			else
				mod:start_weapon_move()
			end

        end,
        get_function = function()
            return mod:get_gear_setting(gear_id, attachment_slot)
        end,
    }
    local options_by_id = {}
    for index, option in pairs(options) do
        options_by_id[option.id] = option
    end
    content.options_by_id = options_by_id
	content.options = options
    content.num_visible_options = num_visible_options

    content.hotspot.pressed_callback = function ()
		if not mod.dropdown_open then
			local selected_widget = nil
			local selected = true
			content.exclusive_focus = selected
			local hotspot = content.hotspot or content.button_hotspot
			if hotspot then
				hotspot.is_selected = selected
			end
			mod.dropdown_open = true
		end
    end

    content.area_length = size[2] * num_visible_options
    local scroll_length = math.max(size[2] * num_options - content.area_length, 0)
    content.scroll_length = scroll_length
    local spacing = 0
    local scroll_amount = scroll_length > 0 and (size[2] + spacing) / scroll_length or 0
    content.scroll_amount = scroll_amount

    return widget
end

mod:hook(CLASS.UIWeaponSpawner, "init", function(func, self, reference_name, world, camera, unit_spawner, ...)
	func(self, reference_name, world, camera, unit_spawner, ...)
	if reference_name ~= "WeaponIconUI" then
		self._rotation_angle = mod._last_rotation_angle or 0
		self._default_rotation_angle = self._rotation_angle
	end
end)

mod.move_duration_in = 4
mod.move_duration_out = 2
mod.reset_wait_time = 15
mod.sound_duration = 1

mod.start_weapon_move = function(self, position)
	if position then
		self.move_position = position
		self.do_move = true
	elseif self.link_unit_position then
		self.move_position = Vector3Box(Vector3.zero())
		self.do_move = true
	end
	self.reset_start = nil
end

mod.play_zoom_sound = function(self, t, sound, view)
	if not self.sound_end or t >= self.sound_end then
		self.sound_end = t + self.sound_duration
		view:_play_sound(sound)
	end
end

mod:hook(CLASS.UIWeaponSpawner, "update", function(func, self, dt, t, input_service, ...)

	func(self, dt, t, input_service, ...)

	local InventoryWeaponCosmeticsView = Managers.ui:view_instance("inventory_weapon_cosmetics_view")

	if self._reference_name ~= "WeaponIconUI" then
		local weapon_spawn_data = self._weapon_spawn_data
		if weapon_spawn_data and self._link_unit_position then
			local link_unit = weapon_spawn_data.link_unit
			local position = Vector3Box.unbox(self._link_unit_position)

			if mod.do_move then

				if mod.move_position then
					local last_move_position = mod.last_move_position and Vector3Box.unbox(mod.last_move_position) or Vector3.zero()
					local move_position = Vector3Box.unbox(mod.move_position)
					if not Vector3.equal(last_move_position, move_position) then
						mod.new_position = Vector3Box(Vector3Box.unbox(self._link_unit_base_position) + move_position)
						mod.move_end = t + mod.move_duration_in
						mod.current_move_duration = mod.move_duration_in
						mod.last_move_position = mod.move_position
						mod:play_zoom_sound(t, UISoundEvents.apparel_zoom_in, InventoryWeaponCosmeticsView)
					end
				elseif self._link_unit_base_position then
					local last_move_position = Vector3Box.unbox(self._link_unit_position)
					local move_position = Vector3Box.unbox(self._link_unit_base_position)
					if not Vector3.equal(move_position, last_move_position) then
						mod.new_position = self._link_unit_base_position
						mod.move_end = t + mod.move_duration_out
						mod.current_move_duration = mod.move_duration_out
						mod.last_move_position = Vector3.zero()
						mod:play_zoom_sound(t, UISoundEvents.apparel_zoom_out, InventoryWeaponCosmeticsView)
					end
				end

				mod.do_move = nil

			end

			if mod.move_end ~= nil and t <= mod.move_end then
				local progress = (mod.move_end - t) / mod.current_move_duration
				local anim_progress = math.easeInCubic(1 - progress)
				local lerp_position = Vector3.lerp(position, Vector3Box.unbox(mod.new_position), anim_progress)
				mod.link_unit_position = Vector3Box(lerp_position)
				Unit.set_local_position(link_unit, 1, lerp_position)
				self._link_unit_position = Vector3Box(lerp_position)
			elseif mod.move_end ~= nil and t > mod.move_end then
				mod.move_end = nil
				mod.link_unit_position = Vector3Box(Unit.local_position(link_unit, 1))
				if mod.current_move_duration == mod.move_duration_in then
					mod.reset_start = t + mod.reset_wait_time
				end
			end

			if mod.reset_start and t >= mod.reset_start then
				mod.move_position = nil
				mod.do_move = true
				mod.reset_start = nil
			end
		end

	end
end)

mod:hook(CLASS.UIWeaponSpawner, "_spawn_weapon", function(func, self, item, link_unit_name, loader, position, rotation, scale, force_highest_mip, ...)
	force_highest_mip = true
	func(self, item, link_unit_name, loader, position, rotation, scale, force_highest_mip, ...)
	local weapon_spawn_data = self._weapon_spawn_data
	if weapon_spawn_data then
		local link_unit = weapon_spawn_data.link_unit

		local t = Managers.time:time("main")
		local start_seed = self._auto_spin_random_seed
		if not start_seed then
			return 0, 0
		end
		local progress_speed = 0.3
		local progress_range = 0.3
		local progress = math.sin((start_seed + t) * progress_speed) * progress_range
		local auto_tilt_angle = -(progress * 0.5)
		local auto_turn_angle = -(progress * math.pi * 0.25)

		local start_angle = self._rotation_angle or 0
		local rotation = Quaternion.axis_angle(Vector3(0, auto_tilt_angle, 1), -(auto_turn_angle + start_angle))
		if link_unit then
			local initial_rotation = weapon_spawn_data.rotation and QuaternionBox.unbox(weapon_spawn_data.rotation)

			if initial_rotation then
				rotation = Quaternion.multiply(rotation, initial_rotation)
			end

			Unit.set_local_rotation(link_unit, 1, rotation)

			if self._reference_name ~= "WeaponIconUI" then

				local item_name = mod:item_name_from_content_string(item.name)

				if not self._link_unit_base_position_backup then
					self._link_unit_base_position_backup = Vector3Box(Unit.local_position(link_unit, 1))
				end

				if self._last_item_name and self._last_item_name ~= item_name then
					mod.reset_start = t
					mod.move_end = nil
					mod.do_move = nil
					mod.last_move_position = nil
					mod.move_position = nil
					mod:echo("bla")
				end
				
				if mod.attachment_models[item_name].customization_default_position then
					local position = Vector3Box.unbox(mod.attachment_models[item_name].customization_default_position)
					Unit.set_local_position(link_unit, 1, Unit.local_position(link_unit, 1) + position)
				else
					Unit.set_local_position(link_unit, 1, Vector3Box.unbox(self._link_unit_base_position_backup))
				end

				if not self._link_unit_base_position then
					self._link_unit_base_position = Vector3Box(Unit.local_position(link_unit, 1))
				end

				if mod.link_unit_position then
					local position = Vector3Box.unbox(mod.link_unit_position)
					Unit.set_local_position(link_unit, 1, position)
				end

				self._link_unit_position = Vector3Box(Unit.local_position(link_unit, 1))
				self._last_item_name = item_name
				
			end
		end
	end
	
end)

mod.dropdown_option = function(self, id, display_name, sounds)
    return {
        id = id,
        display_name = display_name,
        ignore_localization = true,
        value = id,
		sounds = sounds,
    }
end

mod:hook_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view_definitions", function(instance)

	local top = 85
    local edge = edge_padding * 0.5
	local z = 1

	local y = top - edge
	for _, scenegraph_id in pairs(mod.added_cosmetics_scenegraphs) do
		if string.find(scenegraph_id, "text_pivot") then
			y = y + 35
		else
			y = y + 50
		end
		instance.scenegraph_definition[scenegraph_id] = {
			vertical_alignment = "top",
			parent = "grid_tab_panel",
			horizontal_alignment = "left",
			size = {grid_size[1], 35},
			position = {edge, y, z}
		}
	end

	instance.scenegraph_definition.panel_extension_pivot = {
		vertical_alignment = "top",
		parent = "grid_tab_panel",
		horizontal_alignment = "left",
		size = {grid_width + edge, 170 + edge * 2},
		position = {grid_width - 10, grid_size[2] - 255, z}
	}

	local equip_button_size = {374, 76}
	instance.scenegraph_definition.reset_button = {
		vertical_alignment = "bottom",
		parent = "equip_button",
		horizontal_alignment = "right",
		size = equip_button_size,
		position = {0, -equip_button_size[2] - 15, 1}
	}
	instance.widget_definitions.reset_button = UIWidget.create_definition(table.clone(ButtonPassTemplates.default_button), "reset_button", {
		gamepad_action = "confirm_pressed",
		text = Utf8.upper(mod:localize("loc_weapon_inventory_reset_button")),
		hotspot = {
			on_pressed_sound = UISoundEvents.weapons_skin_confirm
		}
	})
	
	instance.scenegraph_definition.randomize_button = {
		vertical_alignment = "bottom",
		parent = "equip_button",
		horizontal_alignment = "right",
		size = equip_button_size,
		position = {0, -equip_button_size[2] * 2 - 15 * 2, 1}
	}
	instance.widget_definitions.randomize_button = UIWidget.create_definition(table.clone(ButtonPassTemplates.default_button), "randomize_button", {
		gamepad_action = "confirm_pressed",
		text = Utf8.upper(mod:localize("loc_weapon_inventory_randomize_button")),
		hotspot = {
			on_pressed_sound = UISoundEvents.weapons_skin_confirm
		}
	})

	instance.widget_definitions.panel_extension = UIWidget.create_definition({
		{
			value = "content/ui/materials/backgrounds/terminal_basic",
			style_id = "background",
			pass_type = "texture",
			style = {
				vertical_alignment = "bottom",
				scale_to_material = true,
				horizontal_alignment = "left",
				offset = {0, 0, 0},
				size_addition = {0, -1},
				color = Color.terminal_grid_background(255, true),
			}
		},
		{
			value = "content/ui/materials/frames/dropshadow_medium",
			style_id = "input_progress_frame",
			pass_type = "texture",
			style = {
				vertical_alignment = "bottom",
				scale_to_material = true,
				horizontal_alignment = "right",
				offset = {10, 10, 4},
				default_offset = {10, 0, 4},
				size = {0, 10},
				color = {255, 226, 199, 126},
				-- size_addition = {20, 20}
			}
		}
	}, "panel_extension_pivot")

	if #instance.legend_inputs == 1 then
		instance.legend_inputs[#instance.legend_inputs+1] = {
			on_pressed_callback = "_cb_on_ui_visibility_toggled",
			input_action = "hotkey_menu_special_2",
			display_name = "loc_menu_toggle_ui_visibility_off",
			alignment = "right_alignment"
		}
	end

	instance.always_visible_widget_names.background = true

end)


-- mod:hook(CLASS.InventoryWeaponCosmeticsView, "_draw_elements", function(func, self, dt, t, ui_renderer, render_settings, input_service, ...)
-- 	func(self, dt, t, ui_renderer, render_settings, input_service, ...)

-- 	local old_alpha_multiplier = render_settings and render_settings.alpha_multiplier or 1
-- 	local alpha_multiplier = self._alpha_multiplier or 1
-- 	local elements_array = self._elements_array

-- 	if not test then
-- 		mod:echo("lol")
-- 		test = true
-- 	end

-- 	for i = 1, #elements_array do
-- 		local element = elements_array[i]

-- 		if element then
-- 			local element_name = element.__class_name

-- 			if element_name ~= "ViewElementInputLegend" then
-- 				ui_renderer = self._ui_default_renderer or ui_renderer
-- 			end

-- 			render_settings.alpha_multiplier = element_name ~= "ViewElementInputLegend" and alpha_multiplier or 1

-- 			element:draw(dt, t, ui_renderer, render_settings, input_service)
-- 		end
-- 	end

-- 	render_settings.alpha_multiplier = old_alpha_multiplier
-- end)

-- InventoryWeaponDetailsView._draw_elements = function(self, dt, t, ui_renderer, render_settings, input_service)
-- 	local old_alpha_multiplier = render_settings.alpha_multiplier or 1
-- 	local alpha_multiplier = self._alpha_multiplier or 1
-- 	local elements_array = self._elements_array

-- 	for i = 1, #elements_array do
-- 		local element = elements_array[i]

-- 		if element then
-- 			local element_name = element.__class_name

-- 			if element_name ~= "ViewElementInventoryWeaponPreview" or element_name ~= "ViewElementInputLegend" then
-- 				ui_renderer = self._ui_default_renderer or ui_renderer
-- 			end

-- 			render_settings.alpha_multiplier = element_name ~= "ViewElementInputLegend" and alpha_multiplier or 1

-- 			element:draw(dt, t, ui_renderer, render_settings, input_service)
-- 		end
-- 	end

-- 	render_settings.alpha_multiplier = old_alpha_multiplier
-- end

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_draw_widgets", function(func, self, dt, t, input_service, ui_renderer, render_settings, ...)
	local always_visible_widget_names = self._always_visible_widget_names
	local alpha_multiplier = self._render_settings and self._render_settings.alpha_multiplier or 1
	local anim_alpha_speed = 3

	if self._visibility_toggled_on then
		alpha_multiplier = math.min(alpha_multiplier + dt * anim_alpha_speed, 1)
	else
		alpha_multiplier = math.max(alpha_multiplier - dt * anim_alpha_speed, 0)
	end

	local always_visible_widget_names = self._always_visible_widget_names
	self._alpha_multiplier = alpha_multiplier
	local widgets = self._widgets
	local num_widgets = #widgets

	for i = 1, num_widgets do
		local widget = widgets[i]
		local widget_name = widget.name
		self._render_settings.alpha_multiplier = always_visible_widget_names[widget_name] and 1 or alpha_multiplier

		UIWidget.draw(widget, ui_renderer)
	end
end)

mod.hide_custom_widgets = function(self, InventoryWeaponCosmeticsView, hide)
    if InventoryWeaponCosmeticsView._custom_widgets then
        for _, widget in pairs(InventoryWeaponCosmeticsView._custom_widgets) do
			if not widget.not_applicable then
            	widget.visible = not hide
			else
				widget.visible = false
			end
        end
		if InventoryWeaponCosmeticsView._custom_widgets_overlapping then
			InventoryWeaponCosmeticsView._widgets_by_name.panel_extension.visible = not hide
		else
			InventoryWeaponCosmeticsView._widgets_by_name.panel_extension.visible = false
		end
		InventoryWeaponCosmeticsView._widgets_by_name.reset_button.visible = not hide
		InventoryWeaponCosmeticsView._widgets_by_name.randomize_button.visible = not hide
    end
end

mod.update_custom_widgets = function(self, InventoryWeaponCosmeticsView, input_service)
    if InventoryWeaponCosmeticsView._custom_widgets then
        for _, widget in pairs(InventoryWeaponCosmeticsView._custom_widgets) do
            if widget.content and widget.content.entry and widget.content.entry.widget_type == "dropdown" then
				local pivot_name = widget.name.."_pivot"
				pivot_name = string.gsub(pivot_name, "_custom", "")
				local scenegraph_entry = InventoryWeaponCosmeticsView._ui_scenegraph[pivot_name]
				if scenegraph_entry and scenegraph_entry.position then
					if scenegraph_entry.position[2] > 580 then
						widget.content.grow_downwards = false
					else
						widget.content.grow_downwards = true
					end
				end
                self.widget_update_functions["dropdown"](self, widget, input_service)
            end
        end
    end
end

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_set_weapon_zoom", function(func, self, fraction, ...)
	if not mod.dropdown_open then
		func(self, fraction, ...)
	end
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_handle_input", function(func, self, input_service, dt, t, ...)
	local zoom_target = self._weapon_zoom_target
	func(self, input_service, dt, t, ...)
	if mod.dropdown_open then
		self._weapon_zoom_target = zoom_target
	end
end)

mod.add_custom_widget = function(self, widget, InventoryWeaponCosmeticsView)
	InventoryWeaponCosmeticsView._custom_widgets[#InventoryWeaponCosmeticsView._custom_widgets+1] = widget
end

mod:hook(CLASS.InventoryWeaponCosmeticsView, "on_exit", function(func, self, ...)
	mod:check_unsaved_changes(self)
	func(self, ...)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "init", function(func, self, settings, context, ...)
	func(self, settings, context, ...)
	self._draw_elements = function(self, dt, t, ui_renderer, render_settings, input_service)
		local old_alpha_multiplier = render_settings.alpha_multiplier
		local alpha_multiplier = self._alpha_multiplier or 1
		local elements_array = self._elements_array
	
		for i = 1, #elements_array do
			local element = elements_array[i]
	
			if element then
				local element_name = element.__class_name
	
				if element_name ~= "ViewElementInventoryWeaponPreview" or element_name ~= "ViewElementInputLegend" then
					ui_renderer = self._ui_default_renderer or ui_renderer
				end
	
				render_settings.alpha_multiplier = element_name ~= "ViewElementInputLegend" and alpha_multiplier or 1
	
				element:draw(dt, t, ui_renderer, render_settings, input_service)
			end
		end
	
		render_settings.alpha_multiplier = old_alpha_multiplier
	end
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "on_enter", function(func, self, ...)
    func(self, ...)

    if self._selected_item then
		local item_name = mod:item_name_from_content_string(self._selected_item.name)

        self._custom_widgets = {}

		for _, added_scenegraph in pairs(mod.added_cosmetics_scenegraphs) do
			if string.find(added_scenegraph, "text_pivot") then
				local slot = string.gsub(added_scenegraph, "_text_pivot", "")
				mod:add_custom_widget(mod:generate_label(self, added_scenegraph, slot, self._selected_item), self)
			else
				local slot = string.gsub(added_scenegraph, "_pivot", "")
				mod:add_custom_widget(mod:generate_dropdown(self, added_scenegraph, slot, self._selected_item), self)
			end
		end

		local not_applicable = {}

		for index, slot in pairs(mod.attachment_slots) do
			
			if mod.attachment[item_name] and not mod.attachment[item_name][slot] then
				self._widgets_by_name[slot.."_custom"].not_applicable = true
				self._widgets_by_name[slot.."_custom_text"].not_applicable = true
				not_applicable[#not_applicable+1] = slot.."_pivot"
				not_applicable[#not_applicable+1] = slot.."_text_pivot"
			end
		end

		local move = 0
		for _, scenegraph_entry in pairs(mod.added_cosmetics_scenegraphs) do
			if table.contains(not_applicable, scenegraph_entry) then
				-- move = move + 35
				if string.find(scenegraph_entry, "text_pivot") then
					move = move + 35
				else
					move = move + 50
				end
			end
			if self._ui_scenegraph[scenegraph_entry] then
				self._ui_scenegraph[scenegraph_entry].local_position[2] = self._ui_scenegraph[scenegraph_entry].local_position[2] - move
			end
		end
		move = 0
		self._custom_widgets_overlapping = false
		for _, scenegraph_entry in pairs(mod.added_cosmetics_scenegraphs) do
			if not table.contains(not_applicable, scenegraph_entry) then
				-- move = move + 35
				if string.find(scenegraph_entry, "text_pivot") then
					move = move + 35
				else
					move = move + 50
				end
			end
			if self._ui_scenegraph[scenegraph_entry].local_position[2] > grid_size[2] then
				self._custom_widgets_overlapping = true
				self._ui_scenegraph[scenegraph_entry].local_position[1] = self._ui_scenegraph[scenegraph_entry].local_position[1] + grid_width
				self._ui_scenegraph[scenegraph_entry].local_position[2] = self._ui_scenegraph[scenegraph_entry].local_position[2] - 255
			end
		end

		if mod.attachment_models[item_name].customization_min_zoom then
			local min_zoom = mod.attachment_models[item_name].customization_min_zoom
			self._min_zoom = min_zoom
		else
			self._min_zoom = -2
		end
		self._weapon_zoom_target = self._min_zoom
		self._weapon_zoom_fraction = self._min_zoom
		self:_set_weapon_zoom(self._min_zoom)
    end

	mod.original_weapon_settings = {}
	mod:get_changed_weapon_settings(self)

	self._widgets_by_name.reset_button.content.hotspot.disabled = true

    mod:hide_custom_widgets(self, true)

end)

mod.widget_update_functions = {
	dropdown = function (self, widget, input_service)
		local content = widget.content
		local entry = content.entry

		if content.close_setting then
			content.close_setting = nil
			content.exclusive_focus = false
			local hotspot = content.hotspot or content.button_hotspot

			if hotspot then
				hotspot.is_selected = false
			end
			mod.dropdown_open = false

			return
		end

		local is_disabled = entry.disabled or false
		content.disabled = is_disabled
		local size = {
			400,
			50
		}
		local using_gamepad = not Managers.ui:using_cursor_navigation()
		local offset = widget.offset
		local style = widget.style
		local options = content.options
		local options_by_id = content.options_by_id
		local num_visible_options = content.num_visible_options
		local num_options = #options
		local focused = content.exclusive_focus and not is_disabled

		if focused then
			offset[3] = 90
		else
			offset[3] = 0
		end

		local selected_index = content.selected_index
		local value, new_value, real_value = nil, nil, nil
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

		value = entry.get_function and entry:get_function() or content.internal_value or "<not selected>"
		local localization_manager = Managers.localization
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
			if input_service:get("navigate_up_continuous") then
				if grow_downwards or not grow_downwards and always_keep_order then
					new_selection_index = math.max(selected_index - 1, 1)
				else
					new_selection_index = math.min(selected_index + 1, num_options)
				end
			elseif input_service:get("navigate_down_continuous") then
				if grow_downwards or not grow_downwards and always_keep_order then
					new_selection_index = math.min(selected_index + 1, num_options)
				else
					new_selection_index = math.max(selected_index - 1, 1)
				end
			end
		end

		if new_selection_index or not content.selected_index then
			if new_selection_index then
				selected_index = new_selection_index
			end

			if num_visible_options < num_options then
				local step_size = 1 / num_options
				local new_scroll_percentage = math.min(selected_index - 1, num_options) * step_size
				content.scroll_percentage = new_scroll_percentage
				content.scroll_add = nil
			end

			content.selected_index = selected_index
		end

		local scroll_percentage = content.scroll_percentage

		if scroll_percentage then
			local step_size = 1 / (num_options - (num_visible_options - 1))
			content.start_index = math.max(1, math.ceil(scroll_percentage / step_size))
		end

		local option_hovered = false
		local option_index = 1
		local start_index = content.start_index or 1
		local end_index = math.min(start_index + num_visible_options - 1, num_options)
		local using_scrollbar = num_visible_options < num_options

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

			if option_hotspot.on_pressed then
				option_hotspot.on_pressed = nil
				new_value = option.id
                real_value = option.value
				content.selected_index = actual_i
			end

			local option_display_name = option.display_name
			local option_ignore_localization = option.ignore_localization
			content[option_text_id] = option_ignore_localization and option_display_name or localization_manager:localize(option_display_name)
			local options_y = size[2] * option_index
			style[option_hotspot_id].offset[2] = grow_downwards and options_y or -options_y
			style[option_text_id].offset[2] = grow_downwards and options_y or -options_y
			local entry_length = using_scrollbar and size[1] - style.scrollbar_hotspot.size[1] or size[1]
			style[outline_style_id].size[1] = entry_length
			style[option_text_id].size[1] = size[1]
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

			return
		end

		if content.wait_next_frame then
			content.wait_next_frame = nil
			content.close_setting = true
			mod.dropdown_open = false

			return
		end
	end,
}
