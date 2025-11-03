local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local pairs = pairs
    local color = Color
    local color_ui_veteran = color.ui_veteran
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

local function find_in_table(t, key, value)
    for i, v in pairs(t) do
        if v[key] == value then
            return i
        end
    end
end

mod.item_pass_templates_damage_type_visible = function(self, content, style)
    local element = content and content.element
    local real_item = element and element.real_item
    local replacement_path = real_item and real_item.name
    local attachment_data = self.settings.attachment_data_by_item_string[replacement_path]
    local hotspot = content.hotspot
    return attachment_data and attachment_data.damage_type --and ((hotspot and (hotspot.cursor_hover or hotspot.is_selected)) or content.owned == "")
end

mod.item_pass_templates_alternate_fire_visible = function(self, content, style)
    local element = content and content.element
    local real_item = element and element.real_item
    local replacement_path = real_item and real_item.name
    local attachment_data = self.settings.attachment_data_by_item_string[replacement_path]
    local hotspot = content.hotspot
    return attachment_data and attachment_data.alternate_fire --and ((hotspot and (hotspot.cursor_hover or hotspot.is_selected)) or content.owned == "")
end

mod.item_pass_templates_crosshair_visible = function(self, content, style)
    local element = content and content.element
    local real_item = element and element.real_item
    local replacement_path = real_item and real_item.name
    local attachment_data = self.settings.attachment_data_by_item_string[replacement_path]
    local hotspot = content.hotspot
    return attachment_data and attachment_data.crosshair_type --and ((hotspot and (hotspot.cursor_hover or hotspot.is_selected)) or content.owned == "")
end

mod:hook_require("scripts/ui/pass_templates/item_pass_templates", function(instance)

    local damage_type_icon_index = find_in_table(instance.gear_item, "style_id", "damage_type_icon")
    instance.gear_item[damage_type_icon_index or #instance.gear_item+1] = {
        pass_type = "texture",
        style_id = "damage_type_icon",
        value = "content/ui/materials/icons/weapons/actions/melee",
        style = {
            horizontal_alignment = "right",
            vertical_alignment = "top",
            size = {20, 20},
            offset = {-55, 5, 16},
            color = color_ui_veteran(255, true),
        },
        visibility_function = function(content, style)
            return mod:item_pass_templates_damage_type_visible(content, style)
        end,
    }

    local alternate_fire_icon_index = find_in_table(instance.gear_item, "style_id", "alternate_fire_icon")
    instance.gear_item[alternate_fire_icon_index or #instance.gear_item+1] = {
        pass_type = "texture",
        style_id = "alternate_fire_icon",
        value = "content/ui/materials/icons/system/settings/category_gameplay", --content/ui/materials/icons/item_types/beveled/accessories
        style = {
            horizontal_alignment = "right",
            vertical_alignment = "top",
            size = {20, 20},
            offset = {-30, 5, 16},
            color = color_ui_veteran(255, true),
        },
        visibility_function = function(content, style)
            return mod:item_pass_templates_alternate_fire_visible(content, style)
        end,
    }

    local crosshair_icon_index = find_in_table(instance.gear_item, "style_id", "crosshair_icon")
    instance.gear_item[crosshair_icon_index or #instance.gear_item+1] = {
        pass_type = "texture",
        style_id = "crosshair_icon",
        value = "content/ui/materials/icons/system/settings/dropdown/icon_crosshair_killshot",
        style = {
            horizontal_alignment = "right",
            vertical_alignment = "top",
            size = {20, 20},
            offset = {-5, 5, 16},
            color = color_ui_veteran(255, true),
        },
        visibility_function = function(content, style)
            return mod:item_pass_templates_crosshair_visible(content, style)
        end,
    }

end)
