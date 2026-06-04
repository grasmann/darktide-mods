-- File: servo_friend/scripts/mods/servo_friend/servo_friend_data.lua
local mod = get_mod("servo_friend")
if not mod then
    return
end

local UiSettings = require("scripts/settings/ui/ui_settings")
local DMF = get_mod("DMF")
local Localize = Localize

local type = type
local pairs = pairs
local ipairs = ipairs
local string = string
local table_sort = table.sort
local string_sub = string.sub
local string_format = string.format

mod.servo_friend_builtin_appearances = mod.servo_friend_builtin_appearances or {
    { name = "off",           text = Localize("loc_setting_nv_reflex_disabled") },
    { name = "spineless",     text = Localize("loc_setting_mix_preset_flat") },
    { name = "dominant",      text = Localize("loc_interactable_servo_skull_scanner") },
    { name = "decoder",       text = Localize("loc_action_interaction_setup_decode") },
    { name = "decoder_2",     text = Localize("loc_action_interaction_setup_biotic_probe") },
    { name = "nuncio_aquila", text = Localize("loc_talent_ability_area_buff_drone") },
}
mod.servo_friend_builtin_voices = mod.servo_friend_builtin_voices or {
    { text = Localize("loc_setting_nv_reflex_disabled"),                                                                value = "off" },
    { text = Localize("loc_npc_full_name_credit_store_servitor_b"),                                                     value = "conversations_hub_credit_store_servitor_a" }, -- FS seem to have swapped the name locs of servitor a and b
    { text = Localize("loc_npc_full_name_credit_store_servitor_a"),                                                     value = "conversations_hub_credit_store_servitor_b" }, -- FS seem to have swapped the name locs of servitor a and b
    { text = Localize("loc_npc_full_name_credit_store_servitor_c"),                                                     value = "conversations_hub_credit_store_servitor_c" },
    { text = Localize("loc_npc_full_name_reject_npc_servitor_a"),                                                       value = "conversations_hub_reject_npc_servitor_a" },
    { text = Localize("loc_credits_view_hadron_servitor_title"),                                                        value = "conversations_hub_mourningstar_hadron_servitor_a" },
    { text = Localize("loc_npc_short_name_servitor_male_a") .. " (" .. Localize("loc_mission_name_cm_archives") .. ")", value = "mission_vo_cm_archives_archive_servitor_a" },
    { text = Localize("loc_npc_short_name_medicae_servitor_a") .. " 1",                                                 value = "gameplay_vo_medicae_servitor_a" },
    { text = Localize("loc_npc_short_name_medicae_servitor_a") .. " 2",                                                 value = "gameplay_vo_medicae_servitor_b" },
    { text = Localize("loc_npc_full_name_vocator_a") .. " 1",                                                           value = "conversations_hub_mourningstar_servitor_a" },
    { text = Localize("loc_npc_full_name_vocator_a") .. " 2",                                                           value = "conversations_hub_mourningstar_servitor_b" },
    { text = Localize("loc_npc_full_name_vocator_a") .. " 3",                                                           value = "conversations_hub_mourningstar_servitor_c" },
    { text = Localize("loc_npc_full_name_vocator_a") .. " 4",                                                           value = "conversations_hub_mourningstar_servitor_d" },
}
local flashlight_options = {
    {
        text = Localize("loc_achievement_category_missions_label") .. "/" ..
            Localize("loc_mission_name_hub_ship"),
        value = "always_on"
    },
    { text = Localize("loc_achievement_category_missions_label"),        value = "all_missions" },
    { text = Localize("loc_expeditions_modifier_simple_theme_darkness"), value = "only_dark_missions" },
    { text = Localize("loc_setting_checkbox_off"),                       value = "off" }
}
local priority_order_options = {
    { text = Localize("loc_setting_dlss_quality_balanced"), value = "balanced" },
    { text = Localize("loc_tagging"),                       value = "focus_targets" },
    { text = Localize("loc_ranged_attack_secondary_ads"),   value = "locked_aiming" },
    {
        text = Localize("loc_objective_op_train_alert_header") .. "/" ..
            Localize("loc_ranged_attack_secondary_ads"),
        value = "alerts"
    },
}
local focus_tags_and_markers_options = {
    {
        text = Localize("loc_smart_tag_type_attention") .. "/" ..
            Localize("loc_setting_com_wheel_tap_ping") .. "/" ..
            Localize("loc_tag_input_description"),
        value = "all"
    },
    {
        text = Localize("loc_smart_tag_type_attention") .. "/" ..
            Localize("loc_tag_input_description"),
        value = "tagged_enemies_and_items"
    },
    {
        text = Localize("loc_setting_com_wheel_tap_ping") .. "/" ..
            Localize("loc_tag_input_description"),
        value = "tagged_enemies_and_world_markers"
    },
    {
        text = Localize("loc_smart_tag_type_attention") .. "/" ..
            Localize("loc_setting_com_wheel_tap_ping"),
        value = "tagged_items_and_world_markers"
    },
    { text = Localize("loc_tag_input_description"),      value = "tagged_enemies" },
    { text = Localize("loc_smart_tag_type_attention"),   value = "tagged_items" },
    { text = Localize("loc_setting_com_wheel_tap_ping"), value = "world_markers" },
    { text = Localize("loc_setting_checkbox_off"),       value = "off" },
}

local distribution_options = {
    { text = Localize("loc_setting_notification_type_mine"),          value = "only_me" },
    { text = Localize("loc_setting_notification_type_all") .. " (1)", value = "one" },
    { text = Localize("loc_setting_notification_type_all") .. " (2)", value = "two" },
    {
        text = Localize("loc_main_menu_warband_count") .. "/" ..
            Localize("loc_mission_name_hub_ship"),
        value = "everyone"
    },
}

local function _format_colored_title(text, r, g, b)
    return string_format("{#color(%d,%d,%d)}%s{#reset()}", r, g, b, text or "")
end

local function _update_appearance_dropdowns_in_widget_data(widgets, appearance_options, default_appearance_name)
    if type(widgets) ~= "table" then
        return
    end

    for i = 1, #widgets do
        local widget_data = widgets[i]

        if type(widget_data) == "table" then
            if type(widget_data.setting_id) == "string" and
                string_sub(widget_data.setting_id, - #"_mod_option_appearance") == "_mod_option_appearance"
            then
                widget_data.options = appearance_options
                widget_data.default_value = default_appearance_name
            end

            local sub_widgets = widget_data.sub_widgets

            if sub_widgets then
                _update_appearance_dropdowns_in_widget_data(sub_widgets, appearance_options, default_appearance_name)
            end
        end
    end
end

mod.servo_friend_refresh_appearance_dropdown_widgets = mod.servo_friend_refresh_appearance_dropdown_widgets or
    function(self, optional_widgets)
        local appearance_options = self.servo_friend_appearance_options or {}
        local default_appearance_name = self:servo_friend_get_default_appearance_name()
        local widgets = optional_widgets or self.servo_friend_options_widgets

        _update_appearance_dropdowns_in_widget_data(widgets, appearance_options, default_appearance_name)

        if DMF and DMF.options_widgets_data then
            local mod_name = self:get_name()

            for i = 1, #DMF.options_widgets_data do
                local mod_data = DMF.options_widgets_data[i]

                if mod_data[1] and mod_data[1].mod_name == mod_name then
                    _update_appearance_dropdowns_in_widget_data(mod_data, appearance_options, default_appearance_name)
                    break
                end
            end
        end
    end

mod.servo_friend_build_appearance_registry = mod.servo_friend_build_appearance_registry or function(self)
    local appearance_definitions = {}
    local appearance_names = {}
    local appearance_options = {}

    local function add_appearance(entry, source_mod_name)
        if type(entry) ~= "table" then
            return
        end

        local appearance_name = entry.name or entry.value

        if type(appearance_name) ~= "string" or appearance_name == "" or appearance_definitions[appearance_name] then
            return
        end

        local appearance_text = entry.text

        if type(appearance_text) ~= "string" or appearance_text == "" then
            if type(entry.localization_key) == "string" and entry.localization_key ~= "" then
                local localized_text = Localize(entry.localization_key)

                if type(localized_text) == "string" and localized_text ~= "" and localized_text ~= ("<" .. entry.localization_key .. ">") then
                    appearance_text = localized_text
                end
            elseif type(entry.localization) == "table" then
                appearance_text = entry.localization.en
            end
        end

        if type(appearance_text) ~= "string" or appearance_text == "" then
            appearance_text = appearance_name
        end

        local definition = {}

        for key, value in pairs(entry) do
            definition[key] = value
        end

        definition.name = appearance_name
        definition.text = appearance_text
        definition.source_mod = source_mod_name

        appearance_definitions[appearance_name] = definition
        appearance_names[#appearance_names + 1] = appearance_name
        appearance_options[#appearance_options + 1] = {
            text = appearance_text,
            value = appearance_name,
        }
    end

    for i = 1, #mod.servo_friend_builtin_appearances do
        add_appearance(mod.servo_friend_builtin_appearances[i], mod:get_name())
    end

    if DMF and DMF.mods then
        for _, other_mod in pairs(DMF.mods) do
            if type(other_mod) == "table" and other_mod ~= mod and other_mod.is_enabled and other_mod:is_enabled() and
                type(other_mod.servo_friend_appearances) == "table"
            then
                local source_mod_name = other_mod.get_name and other_mod:get_name() or nil

                for i = 1, #other_mod.servo_friend_appearances do
                    add_appearance(other_mod.servo_friend_appearances[i], source_mod_name)
                end
            end
        end
    end

    mod.servo_friend_appearance_definitions = appearance_definitions
    mod.servo_friend_appearance_names = appearance_names
    mod.servo_friend_appearance_options = appearance_options

    if self.servo_friend_refresh_appearance_dropdown_widgets then
        self:servo_friend_refresh_appearance_dropdown_widgets()
    end

    return appearance_definitions, appearance_names, appearance_options
end

mod.servo_friend_get_appearance_registry = mod.servo_friend_get_appearance_registry or function(self)
    if not self.servo_friend_appearance_definitions or not self.servo_friend_appearance_options then
        return self:servo_friend_build_appearance_registry()
    end

    return self.servo_friend_appearance_definitions, self.servo_friend_appearance_names,
        self.servo_friend_appearance_options
end

mod.servo_friend_get_appearance_options = mod.servo_friend_get_appearance_options or function(self)
    local _, _, appearance_options = self:servo_friend_get_appearance_registry()

    return appearance_options
end

mod.servo_friend_get_default_appearance_name = mod.servo_friend_get_default_appearance_name or function(self)
    local _, appearance_names = self:servo_friend_get_appearance_registry()

    if appearance_names then
        for i = 1, #appearance_names do
            if appearance_names[i] ~= "off" then
                return appearance_names[i]
            end
        end
    end

    return "spineless"
end

local function _update_voice_dropdowns_in_widget_data(widgets, voice_options, default_voice_name)
    if type(widgets) ~= "table" then
        return
    end

    for i = 1, #widgets do
        local widget_data = widgets[i]

        if type(widget_data) == "table" then
            if type(widget_data.setting_id) == "string" and
                string_sub(widget_data.setting_id, - #"_mod_option_voice") == "_mod_option_voice"
            then
                widget_data.options = voice_options
                widget_data.default_value = default_voice_name
            end

            local sub_widgets = widget_data.sub_widgets

            if sub_widgets then
                _update_voice_dropdowns_in_widget_data(sub_widgets, voice_options, default_voice_name)
            end
        end
    end
end

mod.servo_friend_refresh_voice_dropdown_widgets = mod.servo_friend_refresh_voice_dropdown_widgets or
    function(self, optional_widgets)
        local voice_options = self.servo_friend_voice_options or {}
        local default_voice_name = self:servo_friend_get_default_voice_name()
        local widgets = optional_widgets or self.servo_friend_options_widgets

        _update_voice_dropdowns_in_widget_data(widgets, voice_options, default_voice_name)

        if DMF and DMF.options_widgets_data then
            local mod_name = self:get_name()

            for i = 1, #DMF.options_widgets_data do
                local mod_data = DMF.options_widgets_data[i]

                if mod_data[1] and mod_data[1].mod_name == mod_name then
                    _update_voice_dropdowns_in_widget_data(mod_data, voice_options, default_voice_name)
                    break
                end
            end
        end
    end

mod.servo_friend_build_voice_registry = mod.servo_friend_build_voice_registry or function(self)
    local voice_definitions = {}
    local voice_names = {}
    local voice_options = {}

    local function add_voice(entry, source_mod_name)
        if type(entry) ~= "table" then
            return
        end

        local voice_name = entry.name or entry.value

        if type(voice_name) ~= "string" or voice_name == "" or voice_definitions[voice_name] then
            return
        end

        local voice_text = entry.text

        if type(voice_text) ~= "string" or voice_text == "" then
            if type(entry.localization_key) == "string" and entry.localization_key ~= "" then
                local localized_text = Localize(entry.localization_key)

                if type(localized_text) == "string" and localized_text ~= "" and localized_text ~= ("<" .. entry.localization_key .. ">") then
                    voice_text = localized_text
                end
            elseif type(entry.localization) == "table" then
                voice_text = entry.localization.en
            end
        end

        if type(voice_text) ~= "string" or voice_text == "" then
            voice_text = voice_name
        end

        local definition = {}

        for key, value in pairs(entry) do
            definition[key] = value
        end

        definition.name = voice_name
        definition.text = voice_text
        definition.source_mod = source_mod_name

        voice_definitions[voice_name] = definition
        voice_names[#voice_names + 1] = voice_name
        voice_options[#voice_options + 1] = {
            text = voice_text,
            value = voice_name,
        }
    end

    for i = 1, #mod.servo_friend_builtin_voices do
        add_voice(mod.servo_friend_builtin_voices[i], mod:get_name())
    end

    if DMF and DMF.mods then
        for _, other_mod in pairs(DMF.mods) do
            if type(other_mod) == "table" and other_mod ~= mod and other_mod.is_enabled and other_mod:is_enabled() and
                type(other_mod.servo_friend_voices) == "table"
            then
                local source_mod_name = other_mod.get_name and other_mod:get_name() or nil

                for i = 1, #other_mod.servo_friend_voices do
                    add_voice(other_mod.servo_friend_voices[i], source_mod_name)
                end
            end
        end
    end

    mod.servo_friend_voice_definitions = voice_definitions
    mod.servo_friend_voice_names = voice_names
    mod.servo_friend_voice_options = voice_options

    if self.servo_friend_refresh_voice_dropdown_widgets then
        self:servo_friend_refresh_voice_dropdown_widgets()
    end

    return voice_definitions, voice_names, voice_options
end

mod.servo_friend_get_voice_registry = mod.servo_friend_get_voice_registry or function(self)
    if not self.servo_friend_voice_definitions or not self.servo_friend_voice_options then
        return self:servo_friend_build_voice_registry()
    end

    return self.servo_friend_voice_definitions, self.servo_friend_voice_names,
        self.servo_friend_voice_options
end

mod.servo_friend_get_voice_options = mod.servo_friend_get_voice_options or function(self)
    local _, _, voice_options = self:servo_friend_get_voice_registry()

    return voice_options
end

mod.servo_friend_get_default_voice_name = mod.servo_friend_get_default_voice_name or function(self)
    local _, voice_names = self:servo_friend_get_voice_registry()

    return voice_names and voice_names[1] or "off"
end

local function _get_archetypes()
    local archetypes = {}
    local archetype_icons = (UiSettings and UiSettings.archetype_font_icon_simple) or {}

    for archetype_name, _ in pairs(archetype_icons) do
        archetypes[#archetypes + 1] = archetype_name
    end

    table_sort(archetypes)

    return archetypes, archetype_icons
end

local function _get_archetype_display_name(archetype_name)
    local localized_name = Localize("loc_class_" .. archetype_name .. "_name")

    if localized_name == ("<loc_class_" .. archetype_name .. "_name>") or
        localized_name == ("<loc_archetype_name_" .. archetype_name .. ">")
    then
        localized_name = archetype_name
    end

    return localized_name
end

local function _get_archetype_group_setting_id(archetype_name)
    return "group_archetype_" .. archetype_name
end

local function _get_archetype_group_title(archetype_name, archetype_icons)
    local icon = archetype_icons[archetype_name] or ""
    local display_name = _get_archetype_display_name(archetype_name)

    return icon ~= "" and (icon .. " " .. display_name) or display_name
end

local function _build_archetype_groups(appearance_options, default_appearance_name, voice_options, default_voice_name)
    local groups = {}
    local archetypes, archetype_icons = _get_archetypes()

    for _, archetype_name in ipairs(archetypes) do
        groups[#groups + 1] = {
            setting_id = _get_archetype_group_setting_id(archetype_name),
            type = "group",
            title = _get_archetype_group_title(archetype_name, archetype_icons),
            localize = false,
            sub_widgets = {
                {
                    setting_id = archetype_name .. "_mod_option_appearance",
                    title = Localize("loc_character_create_title_appearance"),
                    type = "dropdown",
                    default_value = default_appearance_name,
                    options = appearance_options,
                    localize = false,
                },
                {
                    setting_id = archetype_name .. "_mod_option_voice",
                    title = Localize("loc_character_create_title_personality"),
                    type = "dropdown",
                    default_value = default_voice_name,
                    options = voice_options,
                    localize = false,
                },
                {
                    setting_id = archetype_name .. "_mod_option_flashlight_color_red",
                    title = _format_colored_title(mod:localize("mod_option_flashlight_color_red"), 200, 100, 100),
                    type = "numeric",
                    default_value = 1,
                    range = { 0, 1 },
                    decimals_number = 2,
                    localize = false,
                },
                {
                    setting_id = archetype_name .. "_mod_option_flashlight_color_green",
                    title = _format_colored_title(mod:localize("mod_option_flashlight_color_green"), 100, 200, 100),
                    type = "numeric",
                    default_value = 1,
                    range = { 0, 1 },
                    decimals_number = 2,
                    localize = false,
                },
                {
                    setting_id = archetype_name .. "_mod_option_flashlight_color_blue",
                    title = _format_colored_title(mod:localize("mod_option_flashlight_color_blue"), 100, 100, 200),
                    type = "numeric",
                    default_value = 1,
                    range = { 0, 1 },
                    decimals_number = 2,
                    localize = false,
                },
            },
        }
    end

    return groups
end

mod.servo_friend_build_options_widgets = mod.servo_friend_build_options_widgets or function(self)
    local appearance_options = self:servo_friend_get_appearance_options()
    local default_appearance_name = self:servo_friend_get_default_appearance_name()

    local voice_options = self:servo_friend_get_voice_options()
    local default_voice_name = self:servo_friend_get_default_voice_name()

    local options_widgets = {
        {
            setting_id = "group_archetype_settings",
            type = "group",
            title = Localize("loc_character_create_title_appearance"),
            localize = false,
            sub_widgets = _build_archetype_groups(appearance_options, default_appearance_name, voice_options,
                default_voice_name),
        },
        {
            setting_id = "group_focus",
            title = Localize("loc_settings_menu_group_gameplay_settings"),
            localize = false,
            type = "group",
            sub_widgets = {
                {
                    setting_id = "mod_option_only_own_tags",
                    title = Localize("loc_tagging"),
                    localize = false,
                    type = "dropdown",
                    default_value = "all",
                    options = {
                        { text = Localize("loc_setting_notification_type_mine"), value = "only_mine" },
                        { text = Localize("loc_setting_notification_type_all"),  value = "all" },
                    }
                },
                {
                    setting_id = "mod_option_focus_tags_and_markers",
                    title = Localize("loc_penance_menu_panel_option_highlights") .. " (" .. Localize("loc_tagging") ..
                        ")",
                    localize = false,
                    type = "dropdown",
                    default_value = "all",
                    options = focus_tags_and_markers_options,
                },
                {
                    setting_id = "mod_option_focus_self",
                    title = Localize("loc_penance_menu_panel_option_highlights") ..
                        " (" .. Localize("loc_character_view_display_name") .. ")",
                    localize = false,
                    type = "dropdown",
                    default_value = "both",
                    options = {
                        { text = Localize("loc_setting_checkbox_off"),       value = "off" },
                        { text = Localize("loc_block"),                      value = "block" },
                        { text = Localize("loc_weapon_special_weapon_vent"), value = "vent" },
                        {
                            text = Localize("loc_block") ..
                                "/" .. Localize("loc_weapon_special_weapon_vent"),
                            value = "both",
                        },
                    },
                },
                {
                    setting_id = "mod_option_locked_aiming",
                    title = Localize("loc_ranged_attack_secondary_ads") ..
                        " / " .. Localize("loc_ranged_attack_secondary_braced"),
                    localize = false,
                    type = "dropdown",
                    default_value = "on_with_laser_and_sound",
                    options = {
                        { text = Localize("loc_setting_checkbox_off"),                                                                                                  value = "off" },
                        { text = Localize("loc_settings_menu_group_controller_aim_settings_new"),                                                                       value = "on" },
                        { text = Localize("loc_settings_menu_group_controller_aim_settings_new") .. "/" .. Localize("loc_settings_menu_category_sound"),                value = "on_with_sound" },
                        { text = Localize("loc_item_weapon_variant_killshot"),                                                                                          value = "on_with_laser" },
                        { text = Localize("loc_item_weapon_variant_killshot") .. "/" .. Localize("loc_settings_menu_category_sound"),                                   value = "on_with_laser_and_sound" },
                        { text = Localize("loc_item_weapon_variant_killshot") .. "/" .. Localize("loc_tagging"),                                                        value = "on_with_laser_and_tags" },
                        { text = Localize("loc_item_weapon_variant_killshot") .. "/" .. Localize("loc_tagging") .. "/" .. Localize("loc_settings_menu_category_sound"), value = "on_with_laser_and_tags_and_sound" },
                    }
                },
                {
                    setting_id = "mod_option_alert_mode",
                    title = Localize("loc_objective_op_train_alert_header") ..
                        " (" .. Localize("loc_objective_km_heresy_survive_mid_header") ..
                        " / " .. Localize("loc_settings_menu_group_other_settings") .. ")",
                    localize = false,
                    type = "dropdown",
                    default_value = "lights",
                    options = {
                        { text = Localize("loc_setting_checkbox_off"),         value = "off" },
                        { text = mod:localize("mod_option_alert_mode_lights"), value = "lights" },
                        { text = Localize("loc_settings_menu_category_sound"), value = "sound" },
                        {
                            text = mod:localize("mod_option_alert_mode_lights") ..
                                "/" .. Localize("loc_settings_menu_category_sound"),
                            value = "lights_and_sound",
                        },
                    },
                },
                {
                    setting_id = "mod_option_roaming_area",
                    title = Localize("loc_stats_display_range_stat") ..
                        " (" .. Localize("loc_keybind_category_movement") .. ")",
                    localize = false,
                    type = "numeric",
                    default_value = 10,
                    range = { 0, 20 },
                    decimals_number = 0,
                    step_size_value = 5,
                    tooltip = mod:localize("mod_option_roaming_area_tooltip"),
                },
                {
                    setting_id = "mod_option_priority_order",
                    title = mod:localize("mod_option_priority_order"),
                    localize = false,
                    type = "dropdown",
                    default_value = "alerts",
                    options = priority_order_options,
                },
            },
        },
        {
            setting_id = "group_light_sound",
            title = Localize("loc_weapon_special_flashlight") .. " / " .. Localize("loc_settings_menu_category_sound"),
            localize = false,
            type = "group",
            sub_widgets = {
                {
                    setting_id = "group_flashlight",
                    title = Localize("loc_weapon_special_flashlight"),
                    localize = false,
                    type = "group",
                    sub_widgets = {
                        {
                            setting_id = "mod_option_flashlight_toggle",
                            title = Localize("loc_stats_special_action_flashlight_desc"),
                            localize = false,
                            type = "keybind",
                            default_value = {},
                            keybind_trigger = "pressed",
                            keybind_type = "function_call",
                            function_name = "flashlight_toggle",
                        },
                        {
                            setting_id = "mod_option_avoid_daemonhost",
                            title = Localize("loc_setting_speaker_auto_detect") ..
                                ": " .. Localize("loc_breed_display_name_chaos_daemonhost"),
                            localize = false,
                            type = "checkbox",
                            default_value = true,
                            tooltip = mod:localize("mod_option_avoid_daemonhost_tooltip"),
                        },
                        {
                            setting_id = "mod_option_flashlight",
                            title = Localize("loc_setting_dlss_quality_auto") ..
                                " (" .. Localize("loc_weapon_special_activate") .. ")",
                            localize = false,
                            type = "dropdown",
                            default_value = "only_dark_missions",
                            options = flashlight_options
                        },
                        {
                            setting_id = "mod_option_flashlight_type",
                            title = Localize("loc_weapon_special_flashlight"),
                            type = "dropdown",
                            default_value = "small_quality",
                            localize = false,
                            options = {
                                { text = Localize("loc_weapon_keyword_accurate"),                                                                        value = "small_default" },
                                { text = Localize("loc_weapon_keyword_accurate") .. " (" .. Localize("loc_setting_dlss_quality_max_quality") .. ")",     value = "small_quality" },
                                { text = Localize("loc_weapon_stats_display_spread"),                                                                    value = "large_default" },
                                { text = Localize("loc_weapon_stats_display_spread") .. " (" .. Localize("loc_setting_dlss_quality_max_quality") .. ")", value = "large_quality" },
                            }
                        },
                    },
                },
                {
                    setting_id = "group_voice",
                    type = "group",
                    title = Localize("loc_settings_menu_category_sound"),
                    localize = false,
                    sub_widgets = {
                        { setting_id = "mod_option_hover_sound_effect", type = "checkbox", default_value = true },
                        {
                            setting_id = "mod_option_voice_volume",
                            title = Localize("loc_settings_master_volume"),
                            localize = false,
                            type = "numeric",
                            default_value = 1,
                            range = { 0, 1 },
                            decimals_number = 2,
                        },
                        {
                            setting_id = "mod_option_victory_speech_frequency",
                            type = "numeric",
                            default_value = 0.5,
                            range = { 0, 1 },
                            decimals_number = 2,
                        },
                        {
                            setting_id = "mod_option_alert_mode_sound_volume",
                            title = Localize("loc_objective_op_train_alert_header") ..
                                ": " .. Localize("loc_settings_sfx_volume"),
                            localize = false,
                            type = "numeric",
                            default_value = 0.5,
                            range = { 0, 1 },
                            decimals_number = 2,
                        },
                    },
                },
            },
        },
        {
            setting_id = "group_performance",
            title = Localize("loc_settings_menu_group_performance"),
            localize = false,
            type = "group",
            sub_widgets = {
                {
                    setting_id = "group_distribution",
                    title = Localize("loc_achievement_category_teamplay_label"),
                    localize = false,
                    type = "group",
                    sub_widgets = {
                        {
                            setting_id = "mod_option_distribution",
                            title = Localize("loc_setting_companion_outline_in_mission_allies"),
                            type = "dropdown",
                            default_value = "only_me",
                            localize = false,
                            options = distribution_options
                        },
                        {
                            setting_id = "mod_option_distribution_flashlight",
                            type = "dropdown",
                            default_value = "only_me",
                            title = Localize("loc_weapon_special_flashlight"),
                            localize = false,
                            options = distribution_options
                        },
                        {
                            setting_id = "mod_option_distribution_alert",
                            title = Localize("loc_objective_op_train_alert_header"),
                            localize = false,
                            type = "dropdown",
                            default_value = "only_me",
                            options = distribution_options
                        },
                    },
                },
                {
                    setting_id = "group_misc",
                    title = Localize("loc_horde_tactical_overlay_category_misc"),
                    localize = false,
                    type = "group",
                    sub_widgets = {
                        { setting_id = "mod_option_keep_packages",          type = "checkbox", default_value = true, tooltip = "mod_option_keep_packages_tooltip" },
                        { setting_id = "mod_option_avoid_going_into_walls", type = "checkbox", default_value = true, tooltip = "mod_option_avoid_going_into_walls_tooltip" },
                        { setting_id = "mod_option_debug",                  type = "checkbox", default_value = false },
                    },
                },
            },
        },
    }

    self.servo_friend_options_widgets = options_widgets

    return options_widgets
end

local options_widgets = mod:servo_friend_build_options_widgets()

return {
    name = mod:localize("mod_title"),
    description = mod:localize("mod_description"),
    is_togglable = false,
    options = {
        widgets = options_widgets,
    },
}
