local mod = get_mod("character_info")

mod.widgets = {}
mod.widgets_by_name = {}
mod.packages = mod.packages or {}

function mod.on_all_mods_loaded()
    mod.packages = {
        veteran = "veteran_2",
        psyker = "psyker_2",
        zealot = "zealot_2",
        ogryn = "ogryn_2"
    }
end

mod.create_talent_widget = function(self, character_slot, talent_index)
    local offset_x = (talent_index - 1) * 100
    return {
        scenegraph_id = "character_"..character_slot,
        {
            pass_type = "texture",
            value = "content/ui/materials/frames/dropshadow_heavy",
            style = {
                vertical_alignment = "center",
                scale_to_material = true,
                horizontal_alignment = "center",
                offset = {offset_x, 0, 103},
                size = {100, 100},
                color = Color.black(255, true),
                disabled_color = Color.black(255, true),
                default_color = Color.black(255, true),
                hover_color = Color.black(255, true),
            }
        },
        {
            pass_type = "texture",
            value = "content/ui/materials/frames/dropshadow_heavy",
            style = {
                vertical_alignment = "center",
                scale_to_material = true,
                horizontal_alignment = "center",
                offset = {offset_x, 0, 104},
                size = {100, 100},
                color = Color.black(255, true),
                disabled_color = Color.black(255, true),
                default_color = Color.black(255, true),
                hover_color = Color.black(255, true),
            }
        },
    }
end

mod.load_ = function(self)
    local players = Managers.player:players()
    local slot = 0
    for _, player in pairs(players) do
        slot = slot + 1
        if slot < 2 then
            -- mod:dtf(player, "player_"..slot, 5)
            -- local profile = player:profile()
            -- mod:dtf(profile, "profile_"..slot, 5)
            -- local talents = profile.talents
            -- mod:dtf(talents, "talents_"..slot, 5)
            local profile = player:profile()
            local specialization = profile.specialization
            local talents = {}
            for talent, _ in pairs(profile.talents) do
                local tier_str = string.match(talent, "tier_%d")
                if tier_str then
                    -- mod:echo("tier_string = '"..tier_str.."'")
                    local tier = string.sub(tier_str, -1)
                    -- mod:echo("tier = '"..tier.."' lol")
                    local widget_name = "character_"..slot.."_"..tier
                    -- mod:echo("widget_name = '"..widget_name.."'")
                    local icon = profile.archetype.talents[specialization][talent].icon
                    local widget = mod.widgets_by_name[widget_name]

                    -- local talent_service = Managers.data_service.talents
                    -- local on_package_loaded = callback(self, "_populate_data", profile, selected_talents)
                    -- self._talent_icons_package_id = self._talent_service:load_icons_for_profile(profile, "TalentsView", on_package_loaded, true)

                    mod:echo("icon = '"..icon.."'")
                    widget.content.value_id_1 = icon
                    -- mod:dtf(widget, "widget", 5)
                end
            end
        end
    end
end

mod.ui = {
    inventory_view = {
        scenegraph = {
            character_1 = {
                vertical_alignment = "center",
                parent = "screen",
                horizontal_alignment = "center",
                size = {500, 100},
                position = {0, 0, 100}
            },
        },
        widgets = {
            character_1_1 = mod:create_talent_widget(1, 1),
            character_1_2 = mod:create_talent_widget(1, 2),
            character_1_3 = mod:create_talent_widget(1, 3),
            character_1_4 = mod:create_talent_widget(1, 4),
            character_1_5 = mod:create_talent_widget(1, 5),
            character_1_6 = mod:create_talent_widget(1, 6),
        },
        on_widgets_loaded = function(widgets, widgets_by_name)
            mod.widgets = widgets
            mod.widgets_by_name = widgets_by_name
            mod:load_()
            -- self:fill_values()
        end,
        on_enter = function(view_name)
            -- mod:load_()
        end,
    },
}
