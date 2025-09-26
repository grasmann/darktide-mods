local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local inventory_weapon_cosmetics_view_definitions = mod:original_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view_definitions")
local ViewElementTabMenu = mod:original_require("scripts/ui/view_elements/view_element_tab_menu/view_element_tab_menu")
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
    local unit = Unit
    local type = type
    local utf8 = Utf8
    local math = math
    local table = table
    local pairs = pairs
    local CLASS = CLASS
    local string = string
    local vector3 = Vector3
    local callback = callback
    local managers = Managers
    local localize = Localize
    local tostring = tostring
    local math_lerp = math.lerp
    local math_uuid = math.uuid
    local unit_alive = unit.alive
    local table_size = table.size
    local utf8_upper = utf8.upper
    local quaternion = Quaternion
    local vector3_box = Vector3Box
    local script_unit = ScriptUnit
    local table_clear = table.clear
    local string_gsub = string.gsub
    local string_upper = string.upper
    local vector3_zero = vector3.zero
    local unit_get_data = unit.get_data
    local string_format = string.format
    local quaternion_box = QuaternionBox
    local table_contains = table.contains
    local vector3_unbox = vector3_box.unbox
    local unit_local_position = unit.local_position
    local unit_world_position = unit.world_position
    local quaternion_identity = quaternion.identity
    local table_clone_instance = table.clone_instance
    local table_merge_recursive = table.merge_recursive
    local script_unit_extension = script_unit.extension
    local quaternion_from_vector = quaternion.from_vector
    local unit_set_local_position = unit.set_local_position
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local temp_detached = {}
local temp_validated = {}
local temp_mod_count = {}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.selectable_attachment_count = function(self, attachment_entries)
    local count = 0
    for attachment_name, attachment_data in pairs(attachment_entries) do
        if not attachment_data.hide_from_selection then
            count = count + 1
        end
    end
    return count
end

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view", function(instance)

    instance.update_presentation_item = function(self, optional_item)
        local item = optional_item or self._selected_item
        
        self._presentation_item = master_items.create_preview_item_instance(item, true)

        local gear_id = math_uuid()

        self._presentation_item.gear_id = gear_id
        self._presentation_item.__gear_id = gear_id
        self._presentation_item.__original_gear_id = gear_id
        self._presentation_item.__attachment_customization = true

        mod:pt().items_originating_from_customization_menu[gear_id] = true

        self:_preview_item(self._presentation_item)
        self:cb_switch_tab(1)
    end

    instance.update_real_world_item = function(self, optional_item)
        local item = optional_item or self._selected_item
        managers.ui:item_icon_updated(item)
        managers.event:trigger("event_item_icon_updated", item)
        managers.event:trigger("event_replace_list_item", item)
        -- Redo weapon attachments
        mod:reevaluate_packages()
        mod:redo_weapon_attachments(self._selected_item)
    end

    instance.cb_on_reset_pressed = function(self)

        mod.is_in_customization_menu = nil
        mod.customization_menu_slot_name = nil
        table_clear(mod:pt().items_originating_from_customization_menu)

        local gear_id = mod:gear_id(self._selected_item)
        mod:delete_gear_settings(gear_id, true)

        local fake_gear_id = mod:gear_id(self._presentation_item, true)
        mod:delete_gear_settings(gear_id, true)

        mod:reset_item(self._selected_item, true)
        mod:reset_item(self._presentation_item, true)

        local attachment_slots = mod:fetch_attachment_slots(self._selected_item.attachments)
        for attachment_slot, data in pairs(attachment_slots) do

            local attachment_item_path = mod:fetch_attachment(self._selected_item.attachments, attachment_slot)
            local attachment_item = master_items.get_item(attachment_item_path)
            
            self["_equipped_"..attachment_slot.."_name"] = attachment_item_path or "content/items/weapons/player/trinkets/unused_trinket"
            self["_selected_"..attachment_slot.."_name"] = attachment_item_path or "content/items/weapons/player/trinkets/unused_trinket"

            self["_equipped_"..attachment_slot] = attachment_item
            self["_selected_"..attachment_slot] = attachment_item

        end


        self:update_real_world_item()

        self:update_presentation_item()

        mod:pt().items_originating_from_customization_menu[fake_gear_id] = true

        self:_preview_item(self._presentation_item)
        local index = self._selected_tab_index
        self._selected_tab_index = nil
        self:cb_switch_tab(index)

        mod.is_in_customization_menu = true
    end

    instance.cb_on_random_pressed = function(self)

        mod.is_in_customization_menu = nil
        mod.customization_menu_slot_name = nil
        table_clear(mod:pt().items_originating_from_customization_menu)

        local new_gear_settings = mod:randomize_item(self._selected_item)

        local gear_id = mod:gear_id(self._selected_item)
        mod:gear_settings(gear_id, new_gear_settings, true)

        local fake_gear_id = mod:gear_id(self._presentation_item, true)

        mod:modify_item(self._selected_item, false, new_gear_settings)
        -- Fixes
        mod:apply_attachment_fixes(self._selected_item)

        for attachment_slot, replacement_path in pairs(new_gear_settings) do

            -- local attachment_item_path = mod:fetch_attachment(self._selected_item.attachments, attachment_slot)
            local attachment_item = master_items.get_item(replacement_path)
            
            self["_equipped_"..attachment_slot.."_name"] = replacement_path or "content/items/weapons/player/trinkets/unused_trinket"
            self["_selected_"..attachment_slot.."_name"] = replacement_path or "content/items/weapons/player/trinkets/unused_trinket"

            self["_equipped_"..attachment_slot] = attachment_item
            self["_selected_"..attachment_slot] = attachment_item

        end

        self:update_real_world_item()

        self:update_presentation_item()

        mod:pt().items_originating_from_customization_menu[fake_gear_id] = true

        self:_preview_item(self._presentation_item)
        local index = self._selected_tab_index
        self._selected_tab_index = nil
        self:cb_switch_tab(index)

        mod.is_in_customization_menu = true

    end

end)

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.InventoryWeaponCosmeticsView, "init", function(func, self, settings, context, ...)
    -- Original function
    func(self, settings, context, ...)
    -- Custom init
    self.customize_attachments = context.customize_attachments
    if self.customize_attachments then

        local weapon_template = self._selected_item.weapon_template
        local attachments = weapon_template and mod.settings.attachments[weapon_template]
        if attachments then
            for attachment_slot, attachment_entries in pairs(attachments) do
                local attachment_item_path = mod:fetch_attachment(self._selected_item.attachments, attachment_slot)

                self["_equipped_"..attachment_slot.."_name"] = attachment_item_path or "content/items/weapons/player/trinkets/unused_trinket"
                self["_selected_"..attachment_slot.."_name"] = attachment_item_path or "content/items/weapons/player/trinkets/unused_trinket"

                if attachment_item_path then
                    local attachment_item = master_items.get_item(attachment_item_path)

                    self["_equipped_"..attachment_slot] = attachment_item
                    self["_selected_"..attachment_slot] = attachment_item

                end
            end
        end

    end
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_setup_menu_tabs", function(func, self, content, ...)
    if self.customize_attachments then
        self._tabs_content = content

        local grid_size = inventory_weapon_cosmetics_view_definitions.grid_settings.grid_size
        local id = "tab_menu"
        local layer = 10
        local button_size = {
            230,
            40,
        }
        local button_spacing = 10
        local tab_menu_settings = {
            grow_vertically = true,
            vertical_alignment = "top",
            button_size = button_size,
            button_spacing = button_spacing,
            input_label_offset = {
                25,
                30,
            },
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

    table_clear(temp_mod_count)

    if self.customize_attachments then

        local pt = mod:pt()
        local weapon_template = self._presentation_item.weapon_template
        local attachments = weapon_template and mod.settings.attachments[weapon_template]
        local content = self._tabs_content[index]
        if content then
            local slot_name = content.slot_name
            mod.customization_menu_slot_name = slot_name

            if index ~= self._selected_tab_index then
                if self._selected_tab_index then
                    self["_selected_"..slot_name.."_name"] = mod:fetch_attachment(self._selected_item.attachments, slot_name)

                    local real_item = master_items.get_item(self["_selected_"..slot_name.."_name"])

                    self._tabs_content[self._selected_tab_index].apply_on_preview(real_item, self._presentation_item)

                    local gear_id = mod:gear_id(self._presentation_item, true)
                    mod:pt().items_originating_from_customization_menu[gear_id] = true

                    self:_preview_item(self._presentation_item)
                end

                self._selected_tab_index = index

                self._tab_menu_element:set_selected_index(index)

                local generate_visual_item_function = content.generate_visual_item_function
                local get_empty_item_function = content.get_empty_item

                self._grid_display_name = content.display_name

                if not self._using_cursor_navigation then
                    self:_play_sound(UISoundEvents.tab_secondary_button_pressed)
                end

                local layout = {}

                if get_empty_item_function then
                    local empty_item = get_empty_item_function(self._selected_item, self._presentation_item)

                    temp_mod_count[mod] = temp_mod_count[mod] or 0
                    temp_mod_count[mod] = temp_mod_count[mod] + 1

                    layout[#layout + 1] = {
                        is_empty = true,
                        item = empty_item,
                        slot_name = slot_name,
                        sort_data = {
                            display_name = mod:get_name().."_99999",
                        },
                    }

                end

                local attachment_entries = attachments[slot_name]
                if attachment_entries and mod:selectable_attachment_count(attachment_entries) > 1 then
                    for attachment_name, attachment_data in pairs(attachment_entries) do

                        if not attachment_data.hide_from_selection then

                            local attachment_item = master_items.get_item(attachment_data.replacement_path)
                            local item = generate_visual_item_function(slot_name, attachment_item, attachment_data) --, self._selected_item, self._presentation_item)

                            local origin_mod = pt.attachment_data_origin[attachment_data] or mod

                            temp_mod_count[origin_mod] = temp_mod_count[origin_mod] or 0
                            temp_mod_count[origin_mod] = temp_mod_count[origin_mod] + 1

                            local mod_name = origin_mod:get_name()

                            layout[#layout+1] = {
                                widget_type = "gear_set",
                                item = item,
                                real_item = attachment_item,
                                slot_name = slot_name,
                                sort_data = {
                                    display_name = origin_mod:get_name().."_"..tostring(temp_mod_count[origin_mod]),
                                },
                            }

                        end

                    end
                end

                for plugin_mod, count in pairs(temp_mod_count) do
                    local localization_name = "loc_"..tostring(plugin_mod:get_name())

                    layout[#layout+1] = {
                        widget_type = "sub_header",
                        slot_name = slot_name,
                        display_name = localization_name,
                        sort_data = {
                            display_name = plugin_mod:get_name().."_0",
                        },
                    }
                end

                self._offer_items_layout = layout

                self:_sort_grid_layout(self._sort_options[1].sort_function)

                self:_present_layout_by_slot_filter()

            end

            return
        end
    end
    -- Original function
    func(self, index, ...)
end)

-- mod:hook(CLASS.UIWeaponSpawner, "update", function(func, self, dt, t, input_service, ...)

--     -- -- Focus attachment slot
--     -- local weapon_spawn_data = self._weapon_spawn_data
--     -- if self.focus_attachment_unit and unit_alive(self.focus_attachment_unit) and weapon_spawn_data then
--     --     local attachment_position = unit_world_position(self.focus_attachment_unit, 1)
--     --     -- local camera = self._camera
--     --     -- local camera_position = ScriptCamera.position(camera)
--     --     local default_position = self.link_unit_position and vector3_unbox(self.link_unit_position) or vector3_zero()
--     --     local difference = attachment_position - default_position
--     --     -- mod:print("attachment_position "..tostring(attachment_position).." camera_position "..tostring(camera_position).." difference "..tostring(difference))
--     --     local link_unit = weapon_spawn_data.link_unit
--     --     -- local link_unit_position = unit_world_position(link_unit, 1)
        
--     --     local link_difference = vector3(difference.x, difference.y, difference.z)
--     --     mod:print("link_unit_position "..tostring(default_position))

--     --     -- unit_set_local_position(link_unit, 1, default_position - link_difference)
--     --     self:set_position(default_position - link_difference)
--     --     -- ScriptCamera.set_offset(camera, difference)
--     -- end

--     -- Original function
--     func(self, dt, t, input_service, ...)
-- end)

-- mod:hook(CLASS.UIWeaponSpawner, "_spawn_weapon", function(func, self, item, link_unit_name, level_link_unit, loader, position, rotation, scale, force_highest_mip, ...)
--     -- Original function
--     func(self, item, link_unit_name, level_link_unit, loader, position, rotation, scale, force_highest_mip, ...)
--     -- Focus attachment slot
--     if self.focus_attachment_slot then
--         local weapon_spawn_data = self._weapon_spawn_data

-- 	    if weapon_spawn_data then
--             local item_unit_3p = weapon_spawn_data.item_unit_3p
--             local attachment_units_3p = weapon_spawn_data.attachment_units_3p[item_unit_3p]

--             local link_unit = weapon_spawn_data.link_unit
--             -- self.link_unit_position = vector3_box(unit_world_position(link_unit, 1))

--             if attachment_units_3p then
--                 for i = 1, #attachment_units_3p do
--                     local attachment_unit = attachment_units_3p[i]

--                     if attachment_unit and unit_alive(attachment_unit) then

--                         local attachment_slot = unit_get_data(attachment_unit, "attachment_slot")
--                         if attachment_slot == self.focus_attachment_slot then
--                             mod:echo("weapon_spawner focus attachment unit "..tostring(attachment_unit))
--                             -- self.focus_attachment_unit = attachment_unit

--                             local world_attachment_position = unit_world_position(attachment_unit, 1)
--                             -- local camera = self._camera
--                             -- local camera_position = ScriptCamera.position(camera)
--                             -- local default_position = self.link_unit_position and vector3_unbox(self.link_unit_position) or vector3_zero()
--                             local world_link_position = unit_world_position(link_unit, 1)
--                             local difference = world_attachment_position - world_link_position
--                             -- mod:print("attachment_position "..tostring(attachment_position).." camera_position "..tostring(camera_position).." difference "..tostring(difference))
--                             local link_unit = weapon_spawn_data.link_unit
--                             -- local link_unit_position = unit_world_position(link_unit, 1)
--                             -- local item_unit_position = unit_world_position(item_unit_3p, 1)
--                             -- local item_unit_difference = item_unit_position - attachment_position


--                             local attachment_position = unit_local_position(attachment_unit, 1)
--                             mod:print("attachment_position "..tostring(attachment_position))

--                             local angle = 0

--                             -- if attachment_position.y > 0 then

--                             -- end
                            
--                             if attachment_position.x > 0 then

--                                 -- self._rotation_angle = .5
--                                 -- self:_set_rotation(3)
--                                 angle = 3
--                                 -- difference = difference * -1

--                             end

--                             angle = angle + difference.y

--                             self:_set_rotation(angle)

--                             -- mod:print("item_unit_difference "..tostring())
--                             -- if item_unit_difference.y < 0 then
--                             --     mod:print("rotate attachment slot "..tostring(attachment_slot))
--                             -- end
                            
--                             -- local link_difference = vector3(difference.x, difference.y, difference.z)
--                             -- mod:print("link_unit_position "..tostring(default_position))

--                             -- unit_set_local_position(link_unit, 1, default_position - link_difference)
--                             self:set_position(unit_local_position(link_unit, 1) - difference)

--                         end

--                     end
--                 end
--             end
--         end
--     end
-- end)

-- mod:hook(CLASS.ViewElementInventoryWeaponPreview, "present_item", function(func, self, item, disable_auto_spin, ...)
--     -- Original function
--     func(self, item, disable_auto_spin, ...)
--     -- Focus attachment slot
--     if self.focus_attachment_slot and self._ui_weapon_spawner then
--         mod:print("weapon_spawner focus attachment slot "..tostring(self.focus_attachment_slot))
--         self._ui_weapon_spawner.focus_attachment_slot = self.focus_attachment_slot
--     else
--         mod:print("focus_attachment_slot: "..tostring(self.focus_attachment_slot).." weapon_spawner: "..tostring(self._ui_weapon_spawner))
--     end
-- end)

-- mod:hook(CLASS.InventoryWeaponCosmeticsView, "_preview_item", function(func, self, item, ...)
--     -- Original function
--     func(self, item, ...)
--     -- Modify
--     if self.customize_attachments and self._weapon_preview and self._tabs_content then
--         local content = self._tabs_content[self._selected_tab_index]
--         local slot_name = content and content.slot_name
--         if slot_name then
--             mod:print("weapon_preview focus attachment slot "..tostring(slot_name))
--             self._weapon_preview.focus_attachment_slot = slot_name
--             self._weapon_preview:present_item(item, false)
--         end
--     end
-- end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_setup_sort_options", function(func, self, ...)
    if self.customize_attachments then

        local function sort_function_generator(item_comparator)
            return function (a, b)
                if a.sort_group ~= b.sort_group then
                    return a.sort_group < b.sort_group
                end

                if a.widget_type == "divider" and b.widget_type == "divider" then
                    return false
                end

                return item_comparator(a, b)
            end
        end

        if not self._sort_options then
            self._sort_options = {
                {
                    display_name = localize("loc_inventory_item_grid_sort_title_format_increasing_letters", true, {
                        sort_name = localize("loc_inventory_item_grid_sort_title_name"),
                    }),
                    sort_function = items.sort_element_key_comparator({
                        "<",
                        "sort_data",
                        items.compare_item_name,
                    }),
                },
                {
                    display_name = localize("loc_inventory_item_grid_sort_title_format_decreasing_letters", true, {
                        sort_name = localize("loc_inventory_item_grid_sort_title_name"),
                    }),
                    sort_function = items.sort_element_key_comparator({
                        ">",
                        "sort_data",
                        items.compare_item_name,
                    }),
                },
            }
        end

        local sort_callback = callback(self, "cb_on_sort_button_pressed")

        self._item_grid:setup_sort_button(self._sort_options, sort_callback)

        return
    end
    -- Original function
    func(self, ...)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "draw", function(func, self, dt, t, input_service, layer, ...)

    local item_grid_hovered = self._item_grid and self._item_grid:hovered()
    local tab_menu_hovered = self._tab_menu_element and self._tab_menu_element:hovered()
    local equip_button_hovered = self._widgets_by_name.equip_button and self._widgets_by_name.equip_button.content.hotspot.is_hover
    local reset_button_hovered = self._widgets_by_name.reset_button and self._widgets_by_name.reset_button.content.hotspot.is_hover
    local random_button_hovered = self._widgets_by_name.random_button and self._widgets_by_name.random_button.content.hotspot.is_hover

    if self.customize_attachments and not item_grid_hovered and not tab_menu_hovered and not equip_button_hovered and not reset_button_hovered and not random_button_hovered then
        self.animated_alpha_multiplier = math_lerp(self.animated_alpha_multiplier, .3, dt * 4)
    else
        self.animated_alpha_multiplier = math_lerp(self.animated_alpha_multiplier, 1, dt * 4)
    end

    -- Original function
    func(self, dt, t, input_service, layer, ...)

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "update", function(func, self, dt, t, input_service, ...)
    -- Original function
    func(self, dt, t, input_service, ...)

    if self.customize_attachments then
        local content = self._tabs_content[self._selected_tab_index]
        local slot_name = content.slot_name
        local disable_button = true
        if self["_selected_"..slot_name.."_name"] ~= self["_equipped_"..slot_name.."_name"] then
            disable_button = false
        end
        local button = self._widgets_by_name.equip_button
        local button_content = button.content

        button_content.hotspot.disabled = disable_button
        button_content.text = utf8_upper(disable_button and localize("loc_weapon_inventory_equipped_button") or localize("loc_weapon_inventory_equip_button"))

        local reset_button = self._widgets_by_name.reset_button
        if reset_button then
            local button_content = reset_button.content
            local gear_id = mod:gear_id(self._selected_item)
            button_content.hotspot.disabled = not mod:gear_settings(gear_id)
        end


    end
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "selected_item_name_in_slot", function(func, self, slot_name, ...)
    if slot_name and self.customize_attachments then
        return self["_selected_"..slot_name.."_name"]
    end
    -- Original function
    return func(self, slot_name, ...)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "equipped_item_name_in_slot", function(func, self, slot_name, ...)
    if slot_name and self.customize_attachments then
        return self["_equipped_"..slot_name.."_name"]
    end
    -- Original function
    return func(self, slot_name, ...)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "on_exit", function(func, self, ...)
    if self.customize_attachments then
        mod.is_in_customization_menu = nil
        mod.customization_menu_slot_name = nil
        table_clear(mod:pt().items_originating_from_customization_menu)
    end
    -- Original function
    func(self, ...)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "on_enter", function(func, self, ...)
    if self.customize_attachments then
        CLASS.InventoryWeaponCosmeticsView.super.on_enter(self)

        mod.is_in_customization_menu = true

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

            local weapon_template = self._presentation_item.weapon_template
            local attachments = weapon_template and mod.settings.attachments[weapon_template]
            if attachments then
                for attachment_slot, attachment_entries in pairs(attachments) do
                    -- if table_size(attachment_entries) > 1 and not table_contains(mod.settings.hide_attachment_slots_in_menu, attachment_slot) then
                    if mod:selectable_attachment_count(attachment_entries) > 1 and not table_contains(mod.settings.hide_attachment_slots_in_menu, attachment_slot) then
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
                            generate_visual_item_function = function (slot_name, real_item, attachment_data) --, selected_item, presentation_item)

                                local real_item = real_item or self["_selected_"..slot_name]
                                local attachment_item = master_items.get_item(real_item.name)
                                local visual_item = items.weapon_trinket_preview_item(real_item)

                                local gear_id = math_uuid()

                                visual_item.gear_id = gear_id
                                visual_item.__attachment_customization = true
                                attachment_item.icon_render_unit_rotation_offset = attachment_data.icon_render_unit_rotation_offset or {90, 0, 0}
                                attachment_item.icon_render_camera_position_offset = attachment_data.icon_render_camera_position_offset or {0, -1, 0}

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

        if self._presentation_item then
            self:_setup_weapon_preview()

            local gear_id = mod:gear_id(self._presentation_item, true)
            mod:pt().items_originating_from_customization_menu[gear_id] = true

            self:_preview_item(self._presentation_item)
            self._weapon_preview:center_align(0, {
                -0.2,
                -0.3,
                -0.2,
            })
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

        return
    end
    -- Original function
    func(self, ...)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_preview_element", function(func, self, element, ...)
    if self.customize_attachments then
        if element then
            local selected_tab_index = self._selected_tab_index
            local content = self._tabs_content[selected_tab_index]
            local apply_on_preview = content.apply_on_preview
            local presentation_item = self._presentation_item
            local slot_name = content.slot_name
            local replacement_path = content.replacement_path
            local item = element.item
            local real_item = element.real_item

            self._previewed_item = item
            self._previewed_element = element

            if real_item then

                local attachment_data = mod.settings.attachment_data_by_item_string[real_item.name]
                local attachments = mod.settings.attachments[presentation_item.weapon_template]

                -- local detached, validated = {}, {}
                table_clear(temp_detached)
                table_clear(temp_validated)

                -- Detach attachments
                if attachment_data and attachment_data.detach_attachments then
                    for _, attachment_slot_or_attachment_name in pairs(attachment_data.detach_attachments) do
                        
                        if attachments[attachment_slot_or_attachment_name] then
                            -- Remove attachment slot
                            mod:modify_item(presentation_item, nil, {
                                [attachment_slot_or_attachment_name] = "content/items/weapons/player/trinkets/unused_trinket"
                            })
                            temp_detached[attachment_slot_or_attachment_name] = true
                            self["_selected_"..attachment_slot_or_attachment_name.."_name"] = "content/items/weapons/player/trinkets/unused_trinket"
                        else
                            -- Iterate through attachments and remove attachment with specific name
                            for attachment_slot, attachment_entries in pairs(attachments) do
                                if self["_selected_"..attachment_slot.."_name"] == attachment_slot_or_attachment_name then
                                    mod:modify_item(presentation_item, nil, {
                                        [attachment_slot] = "content/items/weapons/player/trinkets/unused_trinket"
                                    })
                                    temp_detached[attachment_slot] = true
                                    self["_selected_"..attachment_slot.."_name"] = "content/items/weapons/player/trinkets/unused_trinket"
                                    break
                                end
                            end
                        end
                    end
                end

                -- Overwrite selected
                for attachment_slot, attachment_entries in pairs(attachments) do
                    local current = mod:fetch_attachment(self._selected_item.attachments, attachment_slot)
                    local selected_or_saved = (slot_name == attachment_slot and self["_selected_"..attachment_slot.."_name"]) or self["_equipped_"..attachment_slot.."_name"] --or current
                    if selected_or_saved and not temp_detached[attachment_slot] then --and not validated[attachment_slot] then
                        mod:modify_item(presentation_item, nil, {
                            [attachment_slot] = selected_or_saved
                        })
                        self["_selected_"..attachment_slot.."_name"] = selected_or_saved
                        temp_validated[attachment_slot] = true
                    end
                end

                -- Validate attachments
                if attachment_data and attachment_data.validate_attachments then
                    for _, attachment_slot in pairs(attachment_data.validate_attachments) do
                        local current_attachment = self["_selected_"..attachment_slot.."_name"]
                        if attachments and attachments[attachment_slot] and (not temp_validated[attachment_slot] or self["_selected_"..attachment_slot.."_name"] == "content/items/weapons/player/trinkets/unused_trinket") then
                            local replacement_path = self["_equipped_"..attachment_slot.."_name"]
                            -- Iterate through attachments and set first
                            for attachment_name, attachment_data in pairs(attachments[attachment_slot]) do
                                if attachment_data.validation_default then
                                    replacement_path = attachment_data.replacement_path
                                    break
                                end
                            end
                            -- Validate
                            mod:modify_item(presentation_item, nil, {
                                [attachment_slot] = replacement_path
                            })
                            self["_selected_"..attachment_slot.."_name"] = replacement_path
                        end
                    end
                end

            else

                self["_selected_"..slot_name.."_name"] = "content/items/weapons/player/trinkets/unused_trinket"

            end

            -- Set selected element
            mod:modify_item(presentation_item, nil, {
                [slot_name] = real_item and real_item.name or "content/items/weapons/player/trinkets/unused_trinket"
            })

            apply_on_preview(real_item, presentation_item)

            local gear_id = mod:gear_id(presentation_item, true)
            mod:pt().items_originating_from_customization_menu[gear_id] = true

            self:_preview_item(presentation_item)

            local widgets_by_name = self._widgets_by_name

            local attachment_name = mod.settings.attachment_name_by_item_string[real_item and real_item.name] or "empty"
            attachment_name = string_gsub(attachment_name, "_", " ")
            attachment_name = string_gsub(attachment_name, "%f[%a].", string_upper)

            widgets_by_name.sub_display_name.content.text = string_format("%s • %s", items.weapon_card_display_name(self._selected_item), items.weapon_card_sub_display_name(self._selected_item))
            widgets_by_name.display_name.content.text = attachment_name

            return
        end
    end
    if not element then
        return
    end
    -- Original function
    func(self, element, ...)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "cb_on_equip_pressed", function(func, self, ...)
    if self.customize_attachments then

        mod.is_in_customization_menu = nil
        mod.customization_menu_slot_name = nil
        table_clear(mod:pt().items_originating_from_customization_menu)

        local gear_id = mod:gear_id(self._selected_item)

        local gear_settings = {}

        local attachments = mod.settings.attachments[self._selected_item.weapon_template]

        for attachment_slot, attachment_name in pairs(attachments) do
            gear_settings[attachment_slot] = self["_selected_"..attachment_slot.."_name"] or "content/items/weapons/player/trinkets/unused_trinket"
            self["_equipped_"..attachment_slot.."_name"] = gear_settings[attachment_slot]
        end

        mod:gear_settings(gear_id, gear_settings, true)

        self:update_real_world_item()

        mod.is_in_customization_menu = true

        local inventory_background_view = mod:get_view("inventory_background_view")
        if inventory_background_view then
            inventory_background_view:event_force_refresh_inventory()
        end

        return
    else
        -- Delete item from item cache
        local gear_id = mod:gear_id(self._selected_item)
        mod:clear_mod_item(gear_id)
    end
    -- Original function
    func(self, ...)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_fetch_inventory_items", function(func, self, tabs_content, ...)
	if self.customize_attachments then
        self._items_by_slot = {}
        return
    end
    return func(self, tabs_content, ...)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_handle_input", function(func, self, input_service, dt, t, ...)
    if not self._item_grid:hovered() then
        -- Original function
        func(self, input_service, dt, t, ...)
    end
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_register_button_callbacks", function(func, self, ...)
    -- Original function
    func(self, ...)
    -- Custom
    local widgets_by_name = self._widgets_by_name
    local reset_button = widgets_by_name.reset_button
    local random_button = widgets_by_name.random_button
    if self.customize_attachments then
        if reset_button then reset_button.content.hotspot.pressed_callback = callback(self, "cb_on_reset_pressed") end
        if random_button then random_button.content.hotspot.pressed_callback = callback(self, "cb_on_random_pressed") end
    else
        if reset_button then reset_button.visible = false end
        if random_button then random_button.visible = false end
    end
end)
