local mod = get_mod("visible_equipment")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local Items = mod:original_require("scripts/utilities/items")
local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")
local UIFontSettings = mod:original_require("scripts/managers/ui/ui_font_settings")
local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
local ItemPassTemplates = mod:original_require("scripts/ui/pass_templates/item_pass_templates")
local MasterItems = mod:original_require("scripts/backend/master_items")
local gear_bundle_size = ItemPassTemplates.gear_bundle_size

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local math = math
    local utf8 = Utf8
    local pairs = pairs
    local CLASS = CLASS
    local table = table
    local color = Color
    local math_pi = math.pi
    local math_max = math.max
    local callback = callback
    local managers = Managers
    local localize = Localize
    local utf8_upper = utf8.upper
    local script_unit = ScriptUnit
    local table_clone = table.clone
    local color_white = color.white
    local math_easeInCubic = math.easeInCubic
    local color_ui_terminal = color.ui_terminal
    local script_unit_extension = script_unit.extension
--#endregion

mod:hook_require("scripts/ui/view_elements/view_element_grid/view_element_grid", function(instance)

    instance.inject_blueprint = function(self, content_blueprints, preview_profile)
        if not content_blueprints.cosmetic_gear_icon then
            local grid_size = gear_bundle_size
            local grid_width = grid_size[1]

            local function _apply_live_item_icon_cb_func(widget, grid_index, rows, columns, render_target)
                local material_values = widget.style.icon.material_values

                material_values.use_placeholder_texture = 0
                material_values.rows = rows
                material_values.columns = columns
                material_values.grid_index = grid_index - 1
                material_values.texture_icon = render_target
                widget.content.use_placeholder_texture = material_values.use_placeholder_texture
            end

            local function _remove_live_item_icon_cb_func(widget, ui_renderer)
                if widget.content.visible then
                    UIWidget.set_visible(widget, ui_renderer, false)
                    UIWidget.set_visible(widget, ui_renderer, true)
                end

                local material_values = widget.style.icon.material_values

                material_values.use_placeholder_texture = 1
                material_values.texture_icon = nil
                widget.content.use_placeholder_texture = material_values.use_placeholder_texture
            end

            local cosmetic_item_display_name_text_style = table_clone(UIFontSettings.header_3)
            cosmetic_item_display_name_text_style.font_size = 14
            cosmetic_item_display_name_text_style.text_horizontal_alignment = "left"
            cosmetic_item_display_name_text_style.text_vertical_alignment = "center"
            cosmetic_item_display_name_text_style.horizontal_alignment = "left"
            cosmetic_item_display_name_text_style.vertical_alignment = "top"
            cosmetic_item_display_name_text_style.offset = {
                10,
                0,
                5,
            }
            cosmetic_item_display_name_text_style.size = {
                grid_width - 20,
                50,
            }

            content_blueprints.cosmetic_gear_icon = {
                pass_template = {
                    {
                        content_id = "hotspot",
                        pass_type = "hotspot",
                        style_id = "hotspot",
                        style = {
                            on_hover_sound = UISoundEvents.default_mouse_hover,
                            on_pressed_sound = UISoundEvents.apparel_select,
                        },
                    },
                    {
                        pass_type = "texture",
                        value = "content/ui/materials/frames/hover",
                        style = {
                            hdr = true,
                            horizontal_alignment = "center",
                            vertical_alignment = "center",
                            color = color_ui_terminal(255, true),
                            size_addition = {
                                20,
                                20,
                            },
                            offset = {
                                0,
                                0,
                                4,
                            },
                        },
                        change_function = function (content, style)
                            local anim_progress = math_max(math_max(content.hotspot.anim_hover_progress, content.hotspot.anim_select_progress), content.hotspot.anim_focus_progress)

                            style.color[1] = anim_progress * 255

                            local size_addition = style.size_addition
                            local size_padding = 10 - math_easeInCubic(anim_progress) * 10

                            size_addition[1] = size_padding
                            size_addition[2] = size_padding
                        end,
                        visibility_function = function (content, style)
                            return content.hotspot.is_hover and not content.selected
                        end,
                    },
                    {
                        pass_type = "text",
                        style_id = "title_text",
                        value = "n/a",
                        value_id = "title_text",
                        style = cosmetic_item_display_name_text_style,
                        -- visibility_function = function (content, style)
                        --     return false
                        -- end,
                    },
                    {
                        pass_type = "texture",
                        style_id = "background",
                        value = "content/ui/materials/buttons/background_selected",
                        style = {
                            color = color_ui_terminal(255, true),
                        },
                        visibility_function = function (content, style)
                            return content.current
                        end,
                    },
                    {
                        pass_type = "texture",
                        style_id = "outer_shadow",
                        value = "content/ui/materials/frames/dropshadow_heavy",
                        style = {
                            horizontal_alignment = "center",
                            scale_to_material = true,
                            vertical_alignment = "center",
                            color = Color.ui_terminal(nil, true),
                            size_addition = {
                                23,
                                24,
                            },
                            offset = {
                                0,
                                0,
                                -1,
                            },
                        },
                        visibility_function = function (content, style)
                            return content.selected
                        end,
                    },
                    {
                        pass_type = "texture",
                        style_id = "icon",
                        value = "content/ui/materials/icons/items/containers/item_container_tooltip_no_rarity",
                        value_id = "icon",
                        style = {
                            horizontal_alignment = "center",
                            vertical_alignment = "bottom",
                            size = {
                                grid_size[1],
                                grid_size[2],
                            },
                            -- size = ItemPassTemplates.gear_bundle_size,
                            offset = {
                                0,
                                0,
                                3,
                            },
                            color = color_white(255, true),
                            material_values = {},
                        },
                        visibility_function = function(content, style)
                            local use_placeholder_texture = content.use_placeholder_texture

                            if use_placeholder_texture and use_placeholder_texture == 0 then
                                return true
                            end

                            return false
                        end,
                    },
                    {
                        pass_type = "rotated_texture",
                        style_id = "loading",
                        value = "content/ui/materials/loading/loading_small",
                        style = {
                            angle = 0,
                            horizontal_alignment = "center",
                            vertical_alignment = "center",
                            size = {
                                80,
                                80,
                            },
                            color = {
                                60,
                                160,
                                160,
                                160,
                            },
                            offset = {
                                0,
                                0,
                                3,
                            },
                        },
                        visibility_function = function(content, style)
                            local use_placeholder_texture = content.use_placeholder_texture

                            if not use_placeholder_texture or use_placeholder_texture == 1 then
                                return true
                            end

                            return false
                        end,
                        change_function = function(content, style, _, dt)
                            local add = -0.5 * dt

                            style.rotation_progress = ((style.rotation_progress or 0) + add) % 1
                            style.angle = style.rotation_progress * math_pi * 2
                        end,
                    },
                },
                size = grid_size,
                init = function (parent, widget, element, callback_name, secondary_callback_name)
                    local content = widget.content
                    local style = widget.style

                    -- content.title_text = element.placement_name --Items.display_name(item)
                    content.hotspot.pressed_callback = callback(parent, callback_name, widget, element)
                    content.hotspot.right_pressed_callback = callback(parent, secondary_callback_name, widget, element)
                    content.element = element
                    element.custom_slot_name = "gear_placement_slot"
                    element.view_name = "inventory_cosmetics_view"
                    element.loadout_slot = false

                    local slot_title = element.slot_title

                    content.title_text = mod:localize("placement_"..element.placement_name) or element.placement_name

                    content.has_new_items_update_callback = element.has_new_items_update_callback
                end,
                update = function (parent, widget, input_service, dt, t, ui_renderer)
                    local content = widget.content
                    local element = content.element
                    local slot = element.slot

                    if slot then
                        local slot_name = slot.name
                        local item = element.item
                        local item_name = item and item.name
                        local equipped_item = element.item
                        local equipped_item_name = equipped_item and equipped_item.name

                        content.equipped = item_name and item_name == equipped_item_name
                    end
                end,
                load_icon = function (parent, widget, element)
                    local content = widget.content

                    if not content.icon_load_id then
                        local cb = callback(_apply_live_item_icon_cb_func, widget)
                        local slot = element.slot
                        if slot then
                            local slot_name = slot.name
                            local equipped_item = element.item

                            local item = MasterItems.create_preview_item_instance(element.item)

                            if item then
                                local item_state_machine = equipped_item.state_machine
                                local item_animation_event = equipped_item.animation_event
                                local companion_item_state_machine = equipped_item.companion_state_machine ~= nil and equipped_item.companion_state_machine ~= "" and equipped_item.companion_state_machine or nil
                                local companion_item_animation_event = equipped_item.companion_animation_event ~= nil and equipped_item.companion_animation_event ~= "" and equipped_item.companion_animation_event or nil
                                local render_context = {
                                    camera_focus_slot_name = slot_name,
                                    state_machine = item_state_machine,
                                    animation_event = item_animation_event,
                                    companion_state_machine = companion_item_state_machine,
                                    companion_animation_event = companion_item_animation_event,
                                    custom_slot_name = slot_name.."_placement",
                                    size = {gear_bundle_size[1], gear_bundle_size[2]},
                                    placement_name = element.placement_name,
                                    placement = true,
                                }
                                preview_profile.placement_name = element.placement_name

                                content.icon_load_id = managers.ui:load_item_icon(item, cb, render_context, preview_profile)
                            end
                        end
                    end
                end,
                unload_icon = function (parent, widget, element, ui_renderer)
                    local content = widget.content

                    if content.icon_load_id then
                        _remove_live_item_icon_cb_func(widget, ui_renderer)
                        managers.ui:unload_item_icon(content.icon_load_id)

                        content.icon_load_id = nil
                    end
                end,
                destroy = function (parent, widget, element, ui_renderer)
                    local content = widget.content

                    if content.icon_load_id then
                        _remove_live_item_icon_cb_func(widget, ui_renderer)
                        managers.ui:unload_item_icon(content.icon_load_id)

                        content.icon_load_id = nil
                    end
                end,
            }
        end
    end

end)

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.ViewElementGrid, "cb_on_grid_entry_left_pressed", function(func, self, widget, element, ...)
    if self.__destroyed then return end

    -- Original function
    func(self, widget, element, ...)

    if element.placement then
        local slot = element.slot
        if slot then
            local slot_name = slot.name
            local item = element.item
            if item then
                local parent = self._parent
                mod:gear_placement(item.gear_id, element.placement_name)
                if parent._profile_spawner then
                    local character_spawn_data = parent._profile_spawner._character_spawn_data
                    if character_spawn_data then
                        local equipment_component = character_spawn_data.equipment_component
                        equipment_component:position_objects()
                        equipment_component:animate_equipment()

                        local offset = mod.settings.placement_camera[element.placement_name]

                        local rotation = offset and offset.rotation and offset.rotation + 2.25

                        parent._profile_spawner._rotation_angle = rotation or parent._profile_spawner._rotation_angle
                        parent.selected_placement = element.placement_name
                        parent.placement_saved = false

                        local widgets = self._grid_widgets
                        if widgets then
                            for i, widget in pairs(widgets) do
                                widget.content.selected = false
                            end
                            widget.content.selected = true
                        end
                    end
                end
            end
        end
    end
end)

mod:hook(CLASS.ViewElementGrid, "_on_present_grid_layout_changed", function(func, self, layout, content_blueprints, left_click_callback, right_click_callback, display_name, optional_grow_direction, optional_left_double_click_callback, ...)
    if self.__destroyed then return end

    local parent = self._parent
    local selected_slot = parent and parent._selected_slot
    local primary = selected_slot and selected_slot.name == "slot_primary"
    local secondary = selected_slot and selected_slot.name == "slot_secondary"
    -- local selected_index = 1
    local placement = "default"
    if not self._parent.item_type and (primary or secondary) then

        local profile = parent._preview_player:profile()
        local item
        if primary then
            item = profile.loadout.slot_primary
        else
            item = profile.loadout.slot_secondary
        end
        item = item._master_item or item
        if item then

            local player = managers.player:local_player_safe(1)
            local player_profile = player and player:profile()
            local gear_id = item and item.__gear_id or item.gear_id
            local real_item = player_profile.loadout[selected_slot.name]
            gear_id = real_item and real_item.__gear_id or real_item.gear_id
            placement = gear_id and mod:gear_placement(gear_id)
            self.placement_name = placement

            local preview_profile = profile

            self:inject_blueprint(content_blueprints, preview_profile)

            local item_placements = mod.settings.offsets[item.weapon_template]
            if item_placements then

                layout = {
                    {
                        widget_type = "spacing_vertical",
                        is_external = true,
                    }
                }

                for placement_name, k in pairs(item_placements) do

                    if placement_name ~= "backpack" then

                        layout[#layout+1] = {
                            placement = true,
                            placement_name = placement_name,
                            sort_group = 1,
                            locked = false,
                            profile = preview_profile,
                            entry_id = item.gear_id,
                            sort_data = item,
                            item = item,
                            slot = {
                                name = selected_slot.name,
                            },
                            widget_type = "cosmetic_gear_icon",
                        }

                    end

                end
            end
        end

    end

    self.placement_name = placement

    -- Original function
    func(self, layout, content_blueprints, left_click_callback, right_click_callback, display_name, optional_grow_direction, optional_left_double_click_callback, ...)

end)

mod:hook(CLASS.ViewElementGrid, "_create_entry_widget_from_config", function(func, self, config, suffix, callback_name, secondary_callback_name, double_click_callback_name, ...)
    -- Check widget type
    if not config.widget_type then
        -- Set widget type
        config.widget_type = "gear_set"
    end
    -- Original function
    local widget, size = func(self, config, suffix, callback_name, secondary_callback_name, double_click_callback_name, ...)

    local placement = self.placement_name

    if widget then

        widget.content.placement_name = config.placement_name

        if config.placement_name == placement then
            widget.content.selected = true
            widget.content.current = true
        else
            widget.content.selected = false
            widget.content.current = false
        end
    end

    return widget, size
end)
