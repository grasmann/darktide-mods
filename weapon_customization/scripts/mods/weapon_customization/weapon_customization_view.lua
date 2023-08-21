local mod = get_mod("weapon_customization")

local inventory_weapon_cosmetics_view_definitions = mod:original_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view_definitions")
local DropdownPassTemplates = mod:original_require("scripts/ui/pass_templates/dropdown_pass_templates")
local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
local UIFontSettings = mod:original_require("scripts/managers/ui/ui_font_settings")
local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")

local grid_size = inventory_weapon_cosmetics_view_definitions.grid_settings.grid_size
local edge_padding = inventory_weapon_cosmetics_view_definitions.grid_settings.edge_padding
local grid_width = grid_size[1] + edge_padding
local button_width = grid_width * 0.3

-- mod:hook(CLASS.InventoryWeaponCosmeticsView, "on_enter", function(func, self, ...)
-- 	func(self, ...)
-- 	mod.selected_cosmetics_item = self._selected_item
-- 	-- if self._selected_item then
-- 	-- 	mod:load_weapon_customization(self._selected_item, self._selected_item.weapon_unit, true, self._world, "InventoryWeaponCosmeticsView")
-- 	-- end
-- end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_preview_item", function(func, self, item, ...)
    if self._presentation_item and not self._initial_attachment_spawned then
        local gear_id = mod:get_gear_id(self._presentation_item)
        -- local reference = self._weapon_preview and self._weapon_preview._reference_name
        mod:destroy_attachments(gear_id, "InventoryWeaponCosmeticsView")
        -- mod:destroy_attachments(gear_id, self._world, "Player")
	-- elseif not self._initial_attachment_spawn then
		-- -- local gear_id = mod:get_gear_id(self._presentation_item, true)
		-- mod:dtf(self._presentation_item, "self._presentation_item", 3)
		-- local weapon_unit = self._weapon_preview._ui_weapon_spawner
		-- mod:load_weapon_customization(self._presentation_item, self._presentation_item.weapon_unit, true, self._world, "InventoryWeaponCosmeticsView")
		-- self._initial_attachment_spawn = true
    end
	self._initial_attachment_spawned = true
    func(self, item, ...)
	-- if self._level_spawned then
	-- 	mod:hide_parts()
	-- end
	-- mod:hide_parts()
end)

-- mod:hook(CLASS.InventoryWeaponCosmeticsView, "_preview_element", function(func, self, element, ...)
-- 	func(self, element, ...)
-- 	mod:hide_parts()
-- end)

mod:hook(CLASS.ViewElementInventoryWeaponPreview, "present_item", function(func, self, item, disable_auto_spin, ...)
	func(self, item, disable_auto_spin, ...)
	-- mod:hide_parts()
	-- if self._level_spawned then
	-- 	mod:hide_parts()
	-- end
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "update", function(func, self, dt, t, input_service, ...)
    func(self, dt, t, input_service, ...)
    -- if self._presentation_item then
    --     -- local item = self._presentation_item
    --     -- local gear_id = mod:get_gear_id(item) --item.__is_preview_item and item.__original_gear_id or item.__gear_id
    --     -- mod:hide_attachments(gear_id, false)
    --     mod:hide_parts()
    -- end
    mod:update_custom_widgets(self, input_service)
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
            -- mod:destroy_all_attachments()
			-- if presentation_item.__master_item then
			-- 	presentation_item.__master_item.slot_weapon_skin = nil
			-- end
            -- mod:echo("apply_on_preview")
			-- presentation_item.slot_weapon_skin = real_item
			-- self._selected_weapon_skin = real_item
			-- self._selected_weapon_skin_name = real_item and real_item.gear.masterDataInstance.id
            -- local level_world = Managers.world:world("level_world")
            self:_preview_item(presentation_item)
			-- if self._previewed_element then
			-- 	InventoryWeaponCosmeticsView:_preview_element(self._previewed_element)
			-- else
			-- 	InventoryWeaponCosmeticsView:_preview_item(self._selected_item)
			-- end
			mod.weapon_changed = true
			-- mod:hide_parts()
			-- mod:hide_parts()
			-- mod:hide_parts()
            -- mod:load_weapon_customization(real_item, real_item.weapon_unit, false, level_world, "Player")
            -- local gear_id = presentation_item.__is_preview_item and presentation_item.__original_gear_id or presentation_item.__gear_id
		end
    }
    func(self, content, ...)
    
    self._tab_menu_element._widgets_by_name.entry_0.content.size[1] = button_width
    self._tab_menu_element._widgets_by_name.entry_1.content.size[1] = button_width
    self._tab_menu_element._widgets_by_name.entry_2.content.size[1] = button_width
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "cb_switch_tab", function(func, self, index, ...)
    func(self, index, ...)
    if index == 3 then
        self:present_grid_layout({})
        self._item_grid._widgets_by_name.grid_empty.visible = false
        mod:hide_custom_widgets(self, false)
    else
        mod:hide_custom_widgets(self, true)
    end
	if self._previewed_element then
		self:_preview_element(self._previewed_element)
	else
		self:_preview_item(self._selected_item)
	end
	-- mod:hide_parts()
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_select_starting_item_by_slot_name", function(func, self, slot_name, optional_start_index, ...)
	local element = self:element_by_index(start_index)
	if element then
		func(self, slot_name, optional_start_index, ...)
	end
end)

mod.label_template = function(self, text, scenegraph_id)
    return UIWidget.create_definition({
        {
            value_id = "text",
            style_id = "text",
            pass_type = "text",
            value = mod:localize(text),
            style = table.clone(UIFontSettings.item_info_big)
        }
    }, scenegraph_id)
end

mod.generate_dropdown = function(self, InventoryWeaponCosmeticsView, scenegraph, attachment_slot, item)

    -- local widget = InventoryWeaponCosmeticsView._widgets_by_name[attachment_slot.."_custom"]

    local gear_id, original_gear_id = mod:get_gear_id(item) --item.__is_preview_item and item.__original_gear_id or item.__gear_id

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
    local definition = UIWidget.create_definition(template, scenegraph, nil, size)
    local widget_name = attachment_slot.."_custom"
    local widget = InventoryWeaponCosmeticsView:_create_widget(widget_name, definition)
    -- widget.name = widget_name
    InventoryWeaponCosmeticsView._widgets_by_name[widget_name] = widget
    InventoryWeaponCosmeticsView._widgets[#InventoryWeaponCosmeticsView._widgets+1] = widget

    -- local options = {
    --     mod:dropdown_option("test1", "test1"),
    --     mod:dropdown_option("test2", "test2"),
    --     mod:dropdown_option("test3", "test3"),
    -- }

    local content = widget.content
    -- content.text = "test1"
    content.entry = {
        options = options,
        widget_type = "dropdown",
        on_activated = function(new_value, entry)
            -- mod:echo(new_value)
            mod:set(tostring(original_gear_id).."_"..attachment_slot, new_value)
            -- self._previewed_element.real_item
			if InventoryWeaponCosmeticsView._previewed_element then
				InventoryWeaponCosmeticsView:_preview_element(InventoryWeaponCosmeticsView._previewed_element)
			else
				InventoryWeaponCosmeticsView:_preview_item(InventoryWeaponCosmeticsView._selected_item)
			end
            mod:redo_weapon_attachments(original_gear_id, self._world)
			-- InventoryWeaponCosmeticsView:_play_sound(UISoundEvents.apparel_equip_small)
			-- mod:dtf(entry, "entry", 4)
			-- mod:echo(new_value)
			for _, option in pairs(entry.options) do
				if option.id == new_value then
					if option.sounds then
						for _, sound in pairs(option.sounds) do
							InventoryWeaponCosmeticsView:_play_sound(sound)
						end
					end
				end
			end
			-- apparel_equip_frame medium
			-- weapons_equip_weapon
			-- weapons_equip_gadget
            -- mod:reload_weapon_icons()
            -- if Managers.ui._back_buffer_render_handlers then
            --     -- local item = InventoryWeaponCosmeticsView._previewed_element.real_item
            --     Managers.ui._back_buffer_render_handlers.weapons:update_all()
            -- end
            -- mod:delete_weapon_icons(gear_id)
        end,
        get_function = function()
            return mod:get(tostring(original_gear_id).."_"..attachment_slot)
        end,
    }
    -- local options = content.entry.options
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

    local size = {grid_size[1], 50}
    content.area_length = size[2] * num_visible_options
    local scroll_length = math.max(size[2] * num_options - content.area_length, 0)
    content.scroll_length = scroll_length
    local spacing = 0
    local scroll_amount = scroll_length > 0 and (size[2] + spacing) / scroll_length or 0
    content.scroll_amount = scroll_amount

    return widget
end

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
    
    -- special_custom_template[21].style.offset = {}
    -- mod:dtf(special_custom_template, "special_custom_template", 5)

    local edge = edge_padding * 0.5
    instance.scenegraph_definition.special_text_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge, 30}
	}
    instance.scenegraph_definition.special_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 50, 30}
	}
    instance.scenegraph_definition.barrel_text_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 100, 30}
	}
    instance.scenegraph_definition.barrel_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 150, 30}
	}
    instance.scenegraph_definition.receiver_text_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 200, 30}
	}
    instance.scenegraph_definition.receiver_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 250, 30}
	}
	instance.scenegraph_definition.magazine_text_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 300, 30}
	}
    instance.scenegraph_definition.magazine_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 350, 30}
	}
	instance.scenegraph_definition.grip_text_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 400, 30}
	}
    instance.scenegraph_definition.grip_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 450, 30}
	}
	instance.scenegraph_definition.bayonet_text_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 500, 30}
	}
    instance.scenegraph_definition.bayonet_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 550, 30}
	}
	instance.scenegraph_definition.handle_text_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 600, 30}
	}
    instance.scenegraph_definition.handle_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 650, 30}
	}
	instance.scenegraph_definition.sight_text_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 700, 30}
	}
    instance.scenegraph_definition.sight_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 750, 30}
	}
	instance.scenegraph_definition.body_text_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 800, 30}
	}
    instance.scenegraph_definition.body_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 850, 30}
	}
	instance.scenegraph_definition.pommel_text_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 900, 30}
	}
    instance.scenegraph_definition.pommel_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 950, 30}
	}
	instance.scenegraph_definition.head_text_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 1000, 30}
	}
    instance.scenegraph_definition.head_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 1050, 30}
	}
	instance.scenegraph_definition.blade_text_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 1100, 30}
	}
    instance.scenegraph_definition.blade_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 1150, 30}
	}
	instance.scenegraph_definition.shaft_text_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 1200, 30}
	}
    instance.scenegraph_definition.shaft_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 1250, 30}
	}
	instance.scenegraph_definition.left_text_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 1300, 30}
	}
    instance.scenegraph_definition.left_pivot = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {grid_size[1], 50},
		position = {edge, 100 - edge + 1350, 30}
	}


	mod.added_cosmetics_scenegraphs = {
		"special_text_pivot",
		"special_pivot",
		"barrel_text_pivot",
		"barrel_pivot",
		"receiver_text_pivot",
		"receiver_pivot",
		"magazine_text_pivot",
		"magazine_pivot",
		"grip_text_pivot",
		"grip_pivot",
		"bayonet_text_pivot",
		"bayonet_pivot",
		"handle_text_pivot",
		"handle_pivot",
		"sight_text_pivot",
		"sight_pivot",
		"body_text_pivot",
		"body_pivot",
		"pommel_text_pivot",
		"pommel_pivot",
		"head_text_pivot",
		"head_pivot",
		"blade_text_pivot",
		"blade_pivot",
		"shaft_text_pivot",
		"shaft_pivot",
	}

    instance.widget_definitions.special_custom_text = mod:label_template("loc_weapon_cosmetics_customization_special", "special_text_pivot")
    instance.widget_definitions.barrel_custom_text = mod:label_template("loc_weapon_cosmetics_customization_barrel", "barrel_text_pivot")
    instance.widget_definitions.receiver_custom_text = mod:label_template("loc_weapon_cosmetics_customization_receiver", "receiver_text_pivot")
	instance.widget_definitions.magazine_custom_text = mod:label_template("loc_weapon_cosmetics_customization_magazine", "magazine_text_pivot")
	instance.widget_definitions.grip_custom_text = mod:label_template("loc_weapon_cosmetics_customization_grip", "grip_text_pivot")
	instance.widget_definitions.bayonet_custom_text = mod:label_template("loc_weapon_cosmetics_customization_bayonet", "bayonet_text_pivot")
	instance.widget_definitions.handle_custom_text = mod:label_template("loc_weapon_cosmetics_customization_handle", "handle_text_pivot")
	instance.widget_definitions.sight_custom_text = mod:label_template("loc_weapon_cosmetics_customization_sight", "sight_text_pivot")
	instance.widget_definitions.body_custom_text = mod:label_template("loc_weapon_cosmetics_customization_body", "body_text_pivot")
	instance.widget_definitions.pommel_custom_text = mod:label_template("loc_weapon_cosmetics_customization_pommel", "pommel_text_pivot")
	instance.widget_definitions.head_custom_text = mod:label_template("loc_weapon_cosmetics_customization_head", "head_text_pivot")
	instance.widget_definitions.blade_custom_text = mod:label_template("loc_weapon_cosmetics_customization_blade", "blade_text_pivot")
	instance.widget_definitions.shaft_custom_text = mod:label_template("loc_weapon_cosmetics_customization_shaft", "shaft_text_pivot")

    -- local size = {grid_size[1], 50}
    -- local max_visible_options = 5
    -- local num_options = 3
    -- local num_visible_options = math.min(num_options, max_visible_options)
    -- local special_custom_template = DropdownPassTemplates.settings_dropdown(size[1], size[2], size[1], num_visible_options, true)
    -- instance.widget_definitions.special_custom = UIWidget.create_definition(special_custom_template, "special_pivot", nil, size)
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
    end
end

mod.update_custom_widgets = function(self, InventoryWeaponCosmeticsView, input_service)
    if InventoryWeaponCosmeticsView._custom_widgets then
        for _, widget in pairs(InventoryWeaponCosmeticsView._custom_widgets) do
            if widget.content and widget.content.entry and widget.content.entry.widget_type == "dropdown" then
                self.widget_update_functions["dropdown"](self, widget, input_service)
            end
        end
    end
    -- mod.widget_update_functions["dropdown"](self, self._widgets_by_name.barrel_custom, input_service)
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

mod:hook(CLASS.InventoryWeaponCosmeticsView, "on_enter", function(func, self, ...)
    func(self, ...)

	-- mod.selected_cosmetics_item = self._selected_item

    if self._presentation_item then
        self._custom_widgets = {}
        -- local previewed_item = self._presentation_item
        -- local gear_id = previewed_item.__is_preview_item and previewed_item.__original_gear_id or previewed_item.__gear_id
        self._custom_widgets[#self._custom_widgets+1] = mod:generate_dropdown(self, "special_pivot", "special", self._presentation_item)
        self._custom_widgets[#self._custom_widgets+1] = mod:generate_dropdown(self, "barrel_pivot", "barrel", self._presentation_item)
        self._custom_widgets[#self._custom_widgets+1] = mod:generate_dropdown(self, "receiver_pivot", "receiver", self._presentation_item)
		self._custom_widgets[#self._custom_widgets+1] = mod:generate_dropdown(self, "magazine_pivot", "magazine", self._presentation_item)
		self._custom_widgets[#self._custom_widgets+1] = mod:generate_dropdown(self, "grip_pivot", "grip", self._presentation_item)
		self._custom_widgets[#self._custom_widgets+1] = mod:generate_dropdown(self, "bayonet_pivot", "bayonet", self._presentation_item)
		self._custom_widgets[#self._custom_widgets+1] = mod:generate_dropdown(self, "handle_pivot", "handle", self._presentation_item, false)
		self._custom_widgets[#self._custom_widgets+1] = mod:generate_dropdown(self, "sight_pivot", "sight", self._presentation_item, false)
		self._custom_widgets[#self._custom_widgets+1] = mod:generate_dropdown(self, "body_pivot", "body", self._presentation_item, false)
		self._custom_widgets[#self._custom_widgets+1] = mod:generate_dropdown(self, "pommel_pivot", "pommel", self._presentation_item, false)
		self._custom_widgets[#self._custom_widgets+1] = mod:generate_dropdown(self, "head_pivot", "head", self._presentation_item, false)
		self._custom_widgets[#self._custom_widgets+1] = mod:generate_dropdown(self, "blade_pivot", "blade", self._presentation_item, false)
		self._custom_widgets[#self._custom_widgets+1] = mod:generate_dropdown(self, "shaft_pivot", "shaft", self._presentation_item, false)
        self._custom_widgets[#self._custom_widgets+1] = self._widgets_by_name.special_custom_text
        self._custom_widgets[#self._custom_widgets+1] = self._widgets_by_name.barrel_custom_text
        self._custom_widgets[#self._custom_widgets+1] = self._widgets_by_name.receiver_custom_text
		self._custom_widgets[#self._custom_widgets+1] = self._widgets_by_name.magazine_custom_text
		self._custom_widgets[#self._custom_widgets+1] = self._widgets_by_name.grip_custom_text
		self._custom_widgets[#self._custom_widgets+1] = self._widgets_by_name.bayonet_custom_text
		self._custom_widgets[#self._custom_widgets+1] = self._widgets_by_name.handle_custom_text
		self._custom_widgets[#self._custom_widgets+1] = self._widgets_by_name.sight_custom_text
		self._custom_widgets[#self._custom_widgets+1] = self._widgets_by_name.body_custom_text
		self._custom_widgets[#self._custom_widgets+1] = self._widgets_by_name.pommel_custom_text
		self._custom_widgets[#self._custom_widgets+1] = self._widgets_by_name.head_custom_text
		self._custom_widgets[#self._custom_widgets+1] = self._widgets_by_name.blade_custom_text
		self._custom_widgets[#self._custom_widgets+1] = self._widgets_by_name.shaft_custom_text

		local not_applicable = {}

		for index, slot in pairs(mod.attachment_slots) do
			local item_name = mod:item_name_from_content_string(self._presentation_item.name)
			if mod.attachment[item_name] and not mod.attachment[item_name][slot] then
				self._widgets_by_name[slot.."_custom"].not_applicable = true
				self._widgets_by_name[slot.."_custom_text"].not_applicable = true
				not_applicable[#not_applicable+1] = slot.."_pivot"
				not_applicable[#not_applicable+1] = slot.."_text_pivot"
			end
		end

		-- mod:dtf(self._ui_scenegraph, "self._ui_scenegraph", 5)

		local move = 0
		for _, scenegraph_entry in pairs(mod.added_cosmetics_scenegraphs) do
			if table.contains(not_applicable, scenegraph_entry) then
				-- mod:echo(scenegraph_entry)
				move = move + 50
			end
			if self._ui_scenegraph[scenegraph_entry] then
				self._ui_scenegraph[scenegraph_entry].local_position[2] = self._ui_scenegraph[scenegraph_entry].local_position[2] - move
			end
		end
    end

    mod:hide_custom_widgets(self, true)

    -- options = {
    --     mod:dropdown_option("test1", "test1"),
    --     mod:dropdown_option("test2", "test2"),
    --     mod:dropdown_option("test3", "test3"),
    -- }

    -- local options_by_id = {}
    -- for index, option in pairs(options) do
    --     options_by_id[option.id] = option
    -- end

    -- local special_custom = self._widgets_by_name.special_custom

    -- local content = special_custom.content
    -- content.text = "test1"
    -- content.entry = mod:generate_dropdown_entry(options)
    -- local options = content.entry.options
    -- local options_by_id = {}
    -- for index, option in pairs(options) do
    --     options_by_id[option.id] = option
    -- end
    -- content.options_by_id = options_by_id
	-- content.options = options
    -- local max_visible_options = 5
    -- local num_options = 3
    -- local num_visible_options = math.min(num_options, max_visible_options)
    -- content.num_visible_options = num_visible_options

    -- content.hotspot.pressed_callback = function ()
    --     local selected_widget = nil
    --     local selected = true
    --     content.exclusive_focus = selected
    --     local hotspot = content.hotspot or content.button_hotspot
    --     if hotspot then
    --         hotspot.is_selected = selected
    --     end
    -- end

    -- local size = {grid_size[1], 50}
    -- content.area_length = size[2] * num_visible_options
    -- local scroll_length = math.max(size[2] * num_options - content.area_length, 0)
    -- content.scroll_length = scroll_length
    -- local spacing = 0
    -- local scroll_amount = scroll_length > 0 and (size[2] + spacing) / scroll_length or 0
    -- content.scroll_amount = scroll_amount
end)

-- mod:hook(CLASS.ViewElemenMissionBoardOptions, "present", function(func, self, presentation_data, ...)
--     -- mod:dtf(presentation_data, "presentation_data", 5)
--     func(self, presentation_data, ...)
-- end)

mod.widget_update_functions = {
	dropdown = function (self, widget, input_service, grow_downwards)
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
		local value, new_value, real_value = nil
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
		-- local grow_downwards = true
		grow_downwards = grow_downwards or true
		content.grow_downwards = grow_downwards
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

-- mod:hook(CLASS.InventoryWeaponCosmeticsView, "update", function(func, self, dt, t, input_service, ...)
--     func(self, dt, t, input_service, ...)
-- end)