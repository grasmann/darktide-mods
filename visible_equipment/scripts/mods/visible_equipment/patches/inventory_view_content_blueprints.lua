local mod = get_mod("visible_equipment")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local Items = mod:original_require("scripts/utilities/items")
local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
local ItemPassTemplates = mod:original_require("scripts/ui/pass_templates/item_pass_templates")
local gear_icon_size = ItemPassTemplates.gear_icon_size
local gear_bundle_size = ItemPassTemplates.gear_bundle_size

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local type = type
    local utf8 = Utf8
    local table = table
    local callback = callback
    local managers = Managers
    local localize = Localize
    local utf8_upper = utf8.upper
    local table_clone = table.clone
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #############################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################################################

mod:hook_require("scripts/ui/views/inventory_view/inventory_view_content_blueprints", function(instance)

    local function _apply_live_item_icon_cb_func(widget, grid_index, rows, columns, render_target)
        local material_values = widget.style.icon.material_values

        material_values.use_placeholder_texture = 0
        material_values.use_render_target = 1
        material_values.rows = rows
        material_values.columns = columns
        material_values.grid_index = type(grid_index) == "number" and grid_index - 1 or nil
        material_values.render_target = render_target
        widget.content.use_placeholder_texture = material_values.use_placeholder_texture
    end

    local function _remove_live_item_icon_cb_func(widget, ui_renderer)
        if widget.content.visible then
            UIWidget.set_visible(widget, ui_renderer, false)
            UIWidget.set_visible(widget, ui_renderer, true)
        end

        local material_values = widget.style.icon.material_values

        material_values.use_placeholder_texture = 1
        widget.content.use_placeholder_texture = material_values.use_placeholder_texture
        material_values.render_target = nil
    end

    instance.gear_placement_slot = {
        size = gear_icon_size,
        pass_template = ItemPassTemplates.gear_item_slot,
        init = function (parent, widget, element, callback_name, secondary_callback_name)
            local content = widget.content
            local style = widget.style

            content.hotspot.pressed_callback = callback(parent, callback_name, widget, element)
            content.element = element
            element.custom_slot_name = "gear_placement_slot"
            element.view_name = "inventory_cosmetics_view"
            element.loadout_slot = false

            local slot_title = element.slot_title

            local slot = element.slot
            slot_title = slot and slot.name or slot_title
            content.slot_title = mod:localize(slot_title.."_placement")

            if slot then
                local slot_name = slot.name
                local equipped_item = parent:equipped_item_in_slot(slot_name)

                content.item = equipped_item

                local display_name = equipped_item and equipped_item.display_name

                if display_name then
                    content.display_name = Items.display_name(equipped_item)
                    content.sub_display_name = Items.sub_display_name(equipped_item)
                end

                if equipped_item then
                    local cb = callback(_apply_live_item_icon_cb_func, widget)
					local item_state_machine = equipped_item.state_machine
					local item_animation_event = equipped_item.animation_event
					local companion_item_state_machine = equipped_item.companion_state_machine ~= nil and equipped_item.companion_state_machine ~= "" and equipped_item.companion_state_machine or nil
                    local companion_item_animation_event = equipped_item.companion_animation_event ~= nil and equipped_item.companion_animation_event ~= "" and equipped_item.companion_animation_event or nil
                    local render_context = {
						camera_focus_slot_name = element.placement_name or "default",
						state_machine = item_state_machine,
						animation_event = item_animation_event,
						companion_state_machine = companion_item_state_machine,
						companion_animation_event = companion_item_animation_event,
                        custom_slot_name = slot_name.."_placement",
                        size = gear_icon_size,
                        placement_name = element.placement_name or "default",
                        slot_name = slot_name,
					}

                    content.icon_load_id = managers.ui:load_item_icon(equipped_item, cb, render_context)
                end

                local rarity = equipped_item and equipped_item.rarity

                if rarity then
                    local _, rarity_color_dark = Items.rarity_color(equipped_item)

                    if rarity_color_dark then
                        style.background_gradient.color = table_clone(rarity_color_dark)
                    end
                else
                    style.background_gradient.color = style.background_gradient.default_color
                end
            end

            content.has_new_items_update_callback = element.has_new_items_update_callback
        end,
        update = function (parent, widget, input_service, dt, t, ui_renderer)
            local content = widget.content
            local style = widget.style
            local element = content.element
            local slot = element.slot

            if slot then
                local slot_name = slot.name
                local previous_item = content.item
                local equipped_item = parent:equipped_item_in_slot(slot_name)
                local equipped_gear_id = mod:gear_id(equipped_item)
                local previous_gear_id = mod:gear_id(previous_item)
                local update = equipped_item and not previous_item or not equipped_item and previous_item or previous_item and previous_gear_id ~= equipped_gear_id

                if update then
                    content.item = equipped_item

                    local display_name = equipped_item and equipped_item.display_name

                    if display_name then
                        content.display_name = Items.display_name(equipped_item)
                        content.sub_display_name = Items.sub_display_name(equipped_item)
                    end

                    local rarity = equipped_item and equipped_item.rarity

                    if rarity then
                        local _, rarity_color_dark = Items.rarity_color(equipped_item)

                        if rarity_color_dark then
                            style.background_gradient.color = table_clone(rarity_color_dark)
                        end
                    else
                        style.background_gradient.color = style.background_gradient.default_color
                    end

                    if content.icon_load_id then
                        _remove_live_item_icon_cb_func(widget, ui_renderer)
                        managers.ui:unload_item_icon(content.icon_load_id)

                        content.icon_load_id = nil
                    end

                    if equipped_item then
                        local cb = callback(_apply_live_item_icon_cb_func, widget)
                        local item_state_machine = equipped_item.state_machine
                        local item_animation_event = equipped_item.animation_event
                        local companion_item_state_machine = equipped_item.companion_state_machine ~= nil and equipped_item.companion_state_machine ~= "" and equipped_item.companion_state_machine or nil
                        local companion_item_animation_event = equipped_item.companion_animation_event ~= nil and equipped_item.companion_animation_event ~= "" and equipped_item.companion_animation_event or nil
                        local render_context = {
                            camera_focus_slot_name = element.placement_name or "default",
						    state_machine = item_state_machine,
                            animation_event = item_animation_event,
                            companion_state_machine = companion_item_state_machine,
                            companion_animation_event = companion_item_animation_event,
                            custom_slot_name = slot_name.."_placement",
                            size = gear_icon_size,
                            placement_name = element.placement_name or "default",
                            slot_name = slot_name,
                        }

                        content.icon_load_id = managers.ui:load_item_icon(equipped_item, cb, render_context)
                    end
                end
            end

            local item_type = element.item_type
            local has_new_items = item_type and content.has_new_items_update_callback and content.has_new_items_update_callback(item_type) or false

            content.has_new_items = has_new_items
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

end)