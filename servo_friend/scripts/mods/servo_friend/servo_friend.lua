-- File: servo_friend/scripts/mods/servo_friend/servo_friend.lua
local mod = get_mod("servo_friend"); if not mod then return end

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local PointOfInterestManager = mod:io_dofile("servo_friend/scripts/mods/servo_friend/managers/point_of_interest_manager")
local UiSettings = require("scripts/settings/ui/ui_settings")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local type = type
local math = math
local unit = Unit
local table = table
local pairs = pairs
local actor = Actor
local ipairs = ipairs
local string = string
local get_mod = get_mod
local vector3 = Vector3
local managers = Managers
local math_abs = math.abs
local actor_unit = actor.unit
local unit_alive = unit.alive
local quaternion = Quaternion
local wwise_world = WwiseWorld
local script_unit = ScriptUnit
local vector3_box = Vector3Box
local math_max = math.max
local math_min = math.min
local math_floor = math.floor
local math_random = math.random
local vector3_dot = vector3.dot
local table_sort = table.sort
local table_clear = table.clear
local vector3_zero = vector3.zero
local physics_world = PhysicsWorld
local string_sub = string.sub
local string_gsub = string.gsub
local string_format = string.format
local vector3_length = vector3.length
local vector3_normalize = vector3.normalize
local quaternion_forward = quaternion.forward
local unit_local_rotation = unit.local_rotation
local unit_world_position = unit.world_position
local physics_world_raycast = physics_world.raycast

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

mod.REFERENCE = "servo_friend"
mod.debug_mode = false

local ARCHETYPE_SETTING_DEFAULTS = {
    mod_option_appearance = "spineless",
    mod_option_hover_particle_effect = true,
    mod_option_voice = "conversations_hub_credit_store_servitor_a",
    mod_option_flashlight_color_red = 1,
    mod_option_flashlight_color_green = 1,
    mod_option_flashlight_color_blue = 1,
}

local ARCHETYPE_SETTING_IDS = {
    "mod_option_appearance",
    "mod_option_hover_particle_effect",
    "mod_option_voice",
    "mod_option_flashlight_color_red",
    "mod_option_flashlight_color_green",
    "mod_option_flashlight_color_blue",
}

mod:persistent_table(mod.REFERENCE, {
    player_unit_extensions = {},
    all_packages_loaded = false,
    permanent_packages = {},
    loaded_extensions = {},
    finished_loading = {},
    loaded_packages = {},
    sound_events = {},
    extensions = {},
    systems = {},
})

mod.register_persistent_data = function(self, key, data, overwrite)
    local pt = self:pt()

    if not pt[key] or overwrite then
        pt[key] = data
    end
end

local function _set_group_title_in_widget_data(widgets, target_setting_id, new_title)
    if type(widgets) ~= "table" then
        return false
    end

    for i = 1, #widgets do
        local widget_data = widgets[i]

        if type(widget_data) == "table" then
            if widget_data.setting_id == target_setting_id then
                widget_data.title = new_title
                return true
            end

            local sub_widgets = widget_data.sub_widgets

            if sub_widgets and _set_group_title_in_widget_data(sub_widgets, target_setting_id, new_title) then
                return true
            end
        end
    end

    return false
end

local function _get_archetype_name_from_color_setting_id(self, setting_id)
    if not setting_id then
        return nil
    end

    self._available_archetypes = self._available_archetypes or self:get_available_archetypes()

    for i = 1, #self._available_archetypes do
        local archetype_name = self._available_archetypes[i]

        if setting_id == self:get_archetype_setting_id(archetype_name, "mod_option_flashlight_color_red")
            or setting_id == self:get_archetype_setting_id(archetype_name, "mod_option_flashlight_color_green")
            or setting_id == self:get_archetype_setting_id(archetype_name, "mod_option_flashlight_color_blue")
        then
            return archetype_name
        end
    end

    return nil
end

local function _update_archetype_group_title_in_dmf(self, archetype_name)
    local target_setting_id = self:get_archetype_group_setting_id(archetype_name)

    if not target_setting_id then
        return
    end

    local new_title = self:get_archetype_group_title(archetype_name)
    local dmf = get_mod("DMF")

    if dmf and dmf.options_widgets_data then
        local mod_name = self:get_name()

        for i = 1, #dmf.options_widgets_data do
            local mod_data = dmf.options_widgets_data[i]

            if mod_data[1] and mod_data[1].mod_name == mod_name then
                _set_group_title_in_widget_data(mod_data, target_setting_id, new_title)
                break
            end
        end
    end

    local ui_manager = managers.ui
    local view = ui_manager and ui_manager:view_instance("dmf_options_view")

    if not view or not view._settings_category_widgets then
        return
    end

    local category_widgets = view._settings_category_widgets[self:localize("mod_title")]

    if not category_widgets then
        return
    end

    local clean_title = string_gsub(new_title, "{#.-}", "")

    for i = 1, #category_widgets do
        local data = category_widgets[i]
        local widget = data and data.widget
        local content = widget and widget.content

        if content then
            local entry = content.entry
            local widget_setting_id = entry and entry.setting_id or content.setting_id
            local widget_text = content.text
            local widget_clean_text = type(widget_text) == "string" and string_gsub(widget_text, "{#.-}", "") or nil

            if widget_setting_id == target_setting_id or widget_clean_text == clean_title then
                if entry then
                    entry.display_name = new_title
                end

                content.text = new_title
                break
            end
        end
    end
end

local function _update_all_archetype_group_titles_in_dmf(self)
    self._available_archetypes = self._available_archetypes or self:get_available_archetypes()

    for i = 1, #self._available_archetypes do
        local archetype_name = self._available_archetypes[i]

        _update_archetype_group_title_in_dmf(self, archetype_name)
    end
end

-- ##### ┌┬┐┌┬┐┌─┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ###############################################################################
-- #####  │││││├┤   ├┤ └┐┌┘├┤ │││ │ └─┐ ###############################################################################
-- ##### ─┴┘┴ ┴└    └─┘ └┘ └─┘┘└┘ ┴ └─┘ ###############################################################################

mod.on_all_mods_loaded = function()
    mod:init()
end

mod.on_unload = function(exit_game)
    mod:deinit()
end

mod.on_setting_changed = function(setting_id)
    mod:on_settings_changed(setting_id)
end

mod.update = function()
    local dt, t = mod:delta_time(), mod:time()

    mod:update_point_of_interest_manager(dt, t)
    mod:update_repeating_sounds(dt, t)
end

mod.on_game_state_changed = function(status, state_name)
    if status == "enter" and state_name == "StateGameplay" then
        mod._cached_archetype = nil
    end
end

-- ##### ┌─┐┌─┐┌┬┐┌┬┐┬┌┐┌┌─┐┌─┐  ┌─┐┬ ┬┌─┐┌┐┌┌─┐┌─┐┌┬┐ ################################################################
-- ##### └─┐├┤  │  │ │││││ ┬└─┐  │  ├─┤├─┤││││ ┬├┤  ││ ################################################################
-- ##### └─┘└─┘ ┴  ┴ ┴┘└┘└─┘└─┘  └─┘┴ ┴┴ ┴┘└┘└─┘└─┘─┴┘ ################################################################

mod.on_settings_changed = function(self, setting_id)
    if not self.initialized then
        return
    end

    self.debug_mode = self:get("mod_option_debug")
    self.distribution = self:get("mod_option_distribution")
    self.keep_packages = self:get("mod_option_keep_packages")

    if setting_id == nil then
        self:cache_archetype_settings()
        _update_all_archetype_group_titles_in_dmf(self)
    else
        self:update_archetype_setting_cache(setting_id)

        local archetype_name_for_title_refresh = _get_archetype_name_from_color_setting_id(self, setting_id)

        if archetype_name_for_title_refresh then
            _update_archetype_group_title_in_dmf(self, archetype_name_for_title_refresh)
        end
    end

    if setting_id == "mod_option_distribution" then
        self:destroy_existing_players()
        self:initialize_existing_players()
    end

    managers.event:trigger("servo_friend_settings_changed")
    self:settings_changed_existing_players(setting_id)
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

mod.update_point_of_interest_manager = function(self, dt, t)
    if self.point_of_interest_manager then
        self.point_of_interest_manager:update(dt, t)
    end
end

-- ##### ┬┌┐┌┬┌┬┐       ┌┬┐┌─┐┌─┐┌┬┐┬─┐┌─┐┬ ┬ #########################################################################
-- ##### │││││ │   ───   ││├┤ └─┐ │ ├┬┘│ │└┬┘ #########################################################################
-- ##### ┴┘└┘┴ ┴        ─┴┘└─┘└─┘ ┴ ┴└─└─┘ ┴  #########################################################################

mod.init = function(self)
    self.world_manager = managers.world
    self.package_manager = managers.package
    self.time_manager = managers.time
    self.point_of_interest_manager = PointOfInterestManager:new()

    self._available_archetypes = self:get_available_archetypes()
    self._cached_archetype = nil
    self._archetype_settings = {}

    self.servo_friend_appearance_definitions = nil
    self.servo_friend_appearance_names = nil
    self.servo_friend_appearance_options = nil

    if self.servo_friend_build_appearance_registry then
        self:servo_friend_build_appearance_registry()
    end

    if self.servo_friend_build_voice_registry then
        self:servo_friend_build_voice_registry()
    end

    if self.servo_friend_register_appearance_packages then
        self:servo_friend_register_appearance_packages()
    end

    self:load_packages()

    self.p2p = get_mod("rtc")
    self.initialized = true

    self:on_settings_changed()
    self:initialize_existing_players()
end

mod.deinit = function(self)
    if self.point_of_interest_manager then
        self.point_of_interest_manager:destroy()
        self.point_of_interest_manager = nil
    end

    self:stop_all_repeating_sounds()
    self:destroy_existing_players()

    self.initialized = false
    self._cached_archetype = nil
    self._archetype_settings = {}
    self._available_archetypes = nil

    self.servo_friend_appearance_definitions = nil
    self.servo_friend_appearance_names = nil
    self.servo_friend_appearance_options = nil

    self.servo_friend_voice_definitions = nil
    self.servo_friend_voice_names = nil
    self.servo_friend_voice_options = nil

    self:release_packages()
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.pt = function(self)
    return self:persistent_table(mod.REFERENCE)
end

mod.print = function(self, message)
    if self.debug_mode then
        self:echo(message)
    end
end

mod.is_unit_alive = function(self, unit_to_check)
    return type(unit_to_check) == "userdata" and unit_alive(unit_to_check)
end

mod.random_option = function(self, values)
    local rnd = math_random(1, #values)

    return values[rnd]
end

mod.is_in_hub = function(self)
    local game_mode = managers.state and managers.state.game_mode
    local game_mode_name = game_mode and game_mode:game_mode_name()

    return game_mode_name == "hub"
end

mod.is_dark_mission = function(self)
    local template = managers.state.circumstance and managers.state.circumstance:template()

    if template and template.mutators then
        for _, mutator in pairs(template.mutators) do
            if mutator == "mutator_darkness_los" then
                self:print("dark mission!")
                return true
            end
        end
    end

    self:print("no dark mission")
end

mod.is_in_psykanium = function(self)
    local game_mode = managers.state and managers.state.game_mode
    local game_mode_name = game_mode and game_mode:game_mode_name()

    return game_mode_name == "training_grounds" or game_mode_name == "shooting_range"
end

mod.get_available_archetypes = function(self)
    local archetypes = {}
    local archetype_table = UiSettings and UiSettings.archetype_font_icon_simple or {}

    for archetype_name, _ in pairs(archetype_table) do
        archetypes[#archetypes + 1] = archetype_name
    end

    table_sort(archetypes)

    return archetypes
end

mod.get_local_player = function(self)
    local player_manager = Managers.player

    return player_manager and player_manager:local_player_safe(1)
end

mod.get_local_archetype = function(self)
    if self._cached_archetype then
        return self._cached_archetype
    end

    local player = self:get_local_player()
    if not player then
        return nil
    end

    if type(player.archetype_name) == "function" then
        self._cached_archetype = player:archetype_name()
    elseif type(player.archetype_name) == "string" then
        self._cached_archetype = player.archetype_name
    end

    return self._cached_archetype
end

mod.get_archetype_setting_id = function(self, archetype_name, setting_id)
    if not archetype_name or not setting_id then
        return nil
    end

    return archetype_name .. "_" .. setting_id
end

mod.cache_archetype_settings = function(self)
    self._archetype_settings = self._archetype_settings or {}
    self._available_archetypes = self._available_archetypes or self:get_available_archetypes()

    for _, archetype_name in ipairs(self._available_archetypes) do
        local archetype_cache = self._archetype_settings[archetype_name] or {}

        for i = 1, #ARCHETYPE_SETTING_IDS do
            local setting_id = ARCHETYPE_SETTING_IDS[i]
            local archetype_setting_id = self:get_archetype_setting_id(archetype_name, setting_id)
            local value = self:get(archetype_setting_id)

            if value == nil then
                value = ARCHETYPE_SETTING_DEFAULTS[setting_id]
            end

            archetype_cache[setting_id] = value
        end

        self._archetype_settings[archetype_name] = archetype_cache
    end
end

mod.update_archetype_setting_cache = function(self, setting_id)
    if not setting_id then
        return
    end

    self._archetype_settings = self._archetype_settings or {}
    self._available_archetypes = self._available_archetypes or self:get_available_archetypes()

    for _, archetype_name in ipairs(self._available_archetypes) do
        local prefix = archetype_name .. "_"

        if string_sub(setting_id, 1, #prefix) == prefix then
            local base_setting_id = string_sub(setting_id, #prefix + 1)

            if ARCHETYPE_SETTING_DEFAULTS[base_setting_id] ~= nil then
                local archetype_cache = self._archetype_settings[archetype_name] or {}
                local value = self:get(setting_id)

                if value == nil then
                    value = ARCHETYPE_SETTING_DEFAULTS[base_setting_id]
                end

                archetype_cache[base_setting_id] = value
                self._archetype_settings[archetype_name] = archetype_cache
            end

            return
        end
    end
end

mod.get_archetype_setting = function(self, setting_id, optional_archetype_name)
    local archetype_name = optional_archetype_name or self:get_local_archetype()
    local default_value = ARCHETYPE_SETTING_DEFAULTS[setting_id]

    if not archetype_name then
        return default_value
    end

    local archetype_cache = self._archetype_settings and self._archetype_settings[archetype_name]
    if archetype_cache and archetype_cache[setting_id] ~= nil then
        return archetype_cache[setting_id]
    end

    return default_value
end

mod.get_archetype_group_setting_id = function(self, archetype_name)
    if not archetype_name then
        return nil
    end

    return "group_archetype_" .. archetype_name
end

mod.get_archetype_group_display_name = function(self, archetype_name)
    local localized_name = Localize("loc_class_" .. archetype_name .. "_name")

    if localized_name == ("<loc_class_" .. archetype_name .. "_name>") or
        localized_name == ("<loc_archetype_name_" .. archetype_name .. ">") then
        localized_name = archetype_name
    end

    return localized_name
end

mod.get_archetype_group_title = function(self, archetype_name)
    if not archetype_name then
        return ""
    end

    local archetype_icons = (UiSettings and UiSettings.archetype_font_icon_simple) or {}
    local icon = archetype_icons[archetype_name] or ""
    local display_name = self:get_archetype_group_display_name(archetype_name)
    local plain_title = icon ~= "" and (icon .. " " .. display_name) or display_name

    local r = self:get_archetype_setting("mod_option_flashlight_color_red", archetype_name) or 1
    local g = self:get_archetype_setting("mod_option_flashlight_color_green", archetype_name) or 1
    local b = self:get_archetype_setting("mod_option_flashlight_color_blue", archetype_name) or 1

    r = math_floor(math_max(0, math_min(1, r)) * 255 + 0.5)
    g = math_floor(math_max(0, math_min(1, g)) * 255 + 0.5)
    b = math_floor(math_max(0, math_min(1, b)) * 255 + 0.5)

    return string_format("{#color(%d,%d,%d)}%s{#reset()}", r, g, b, plain_title)
end

mod.get_vectors_almost_same = function(self, v1, v2, tolerance)
    tolerance = tolerance or .5
    v1 = v1 or vector3_zero()
    v2 = v2 or vector3_zero()

    if math_abs(v1[1] - v2[1]) < tolerance and
        math_abs(v1[2] - v2[2]) < tolerance and
        math_abs(v1[3] - v2[3]) < tolerance then
        return true
    end
end

mod.is_point_in_cone = function(self, target_position, position, direction, depth, radius)
    local axis = vector3_normalize(direction)
    local tip_to_point = target_position - position
    local projection_length = vector3_dot(tip_to_point, axis)

    if projection_length < 0 or projection_length > depth then
        return false
    end

    local closest_point_on_axis = position + axis * projection_length
    local radial_vector = target_position - closest_point_on_axis
    local radial_distance = vector3_length(radial_vector)
    local max_radius_at_projection = (projection_length / depth) * radius

    return radial_distance <= max_radius_at_projection
end

mod.is_in_line_of_sight = function(self, from, to, optional_physics_world, optional_collision_filter)
    if to and from then
        local to_target = to - from
        local distance = vector3_length(to_target)
        local direction = vector3_normalize(to_target)

        optional_physics_world = optional_physics_world or self:physics_world()
        optional_collision_filter = optional_collision_filter or "filter_minion_line_of_sight_check"

        if not optional_physics_world then
            return nil
        end

        local hits, hits_n = physics_world_raycast(optional_physics_world, from, direction, distance, "all", "types",
            "both", "collision_filter", optional_collision_filter)

        if hits then
            local INDEX_DISTANCE = 2

            for i = 1, hits_n do
                local hit = hits[i]
                local hit_distance = hit[INDEX_DISTANCE]

                if hit_distance and hit_distance < distance * .8 then
                    return false
                end
            end
        end

        return true
    end
end

mod.aim_target = function(self, optional_offset, optional_unit, optional_length, optional_collision_filter,
                          optional_physics_world, optional_direction)
    optional_physics_world = optional_physics_world or self:physics_world()
    optional_offset = optional_offset or vector3_zero()
    optional_unit = optional_unit or self:local_player_unit()
    optional_length = optional_length or 1000
    optional_collision_filter = optional_collision_filter or "filter_player_character_shooting_projectile"

    if not self:is_unit_alive(optional_unit) or not optional_physics_world then
        return nil, nil
    end

    local from = unit_world_position(optional_unit, 1) + optional_offset

    if not optional_direction then
        local camera_forward = quaternion_forward(unit_local_rotation(optional_unit, 1))
        local to = from + camera_forward * optional_length + optional_offset
        local to_target = to - from

        optional_direction = vector3_normalize(to_target)
    end

    local _, hit_position, _, _, hit_actor = physics_world_raycast(optional_physics_world, from, optional_direction,
        optional_length, "closest", "types", "both", "collision_filter", optional_collision_filter)
    local hit_unit = hit_actor and actor_unit(hit_actor)

    return hit_position, hit_unit
end

mod.p2p_command = function(self, command, target, data)
    if self.p2p then
        target = target or "all"
        return self.p2p.send(self, command, target, data)
    end
end

-- ##### ┬  ┌─┐┌─┐┌┬┐  ┌─┐┌─┐┌┬┐┌─┐┌─┐┌┐┌┌─┐┌┐┌┌┬┐┌─┐ #################################################################
-- ##### │  │ │├─┤ ││  │  │ ││││├─┘│ ││││├┤ │││ │ └─┐ #################################################################
-- ##### ┴─┘└─┘┴ ┴─┴┘  └─┘└─┘┴ ┴┴  └─┘┘└┘└─┘┘└┘ ┴ └─┘ #################################################################

mod:io_dofile("servo_friend/scripts/mods/servo_friend/components/players")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/components/world")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/components/extensions")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/components/servo_friend_extensions")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/components/sound")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/components/time")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/components/package")

-- ##### ┬  ┌─┐┌─┐┌┬┐  ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌┌─┐ ##############################
-- ##### │  │ │├─┤ ││  └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││└─┐ ##############################
-- ##### ┴─┘└─┘┴ ┴─┴┘  └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘└─┘ ##############################

mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_base_extension")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_decoration_extension")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_tag_extension")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_marker_extension")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_point_of_interest_extension")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_hover_particle_extension")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_hover_sound_extension")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_flashlight_extension")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_voice_extension")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_roaming_extension")
-- mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_transparency_extension")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_out_of_bounds_extension")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_inspect_extension")
mod:io_dofile("servo_friend/scripts/mods/servo_friend/extensions/servo_friend_alert_extension")

-- ##### ┬  ┌─┐┌─┐┌┬┐  ┌─┐┬  ┌─┐┬ ┬┌─┐┬─┐  ┬ ┬┌┐┌┬┌┬┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ #####################################
-- ##### │  │ │├─┤ ││  ├─┘│  ├─┤└┬┘├┤ ├┬┘  │ │││││ │   ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ #####################################
-- ##### ┴─┘└─┘┴ ┴─┴┘  ┴  ┴─┘┴ ┴ ┴ └─┘┴└─  └─┘┘└┘┴ ┴   └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ #####################################

mod:io_dofile("servo_friend/scripts/mods/servo_friend/player_extensions/player_unit_servo_friend_extension")
