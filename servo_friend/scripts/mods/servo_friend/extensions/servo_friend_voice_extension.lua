local mod = get_mod("servo_friend")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local AttackSettings = mod:original_require("scripts/settings/damage/attack_settings")
local Breeds = mod:original_require("scripts/settings/breed/breeds")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local type = type
local math = math
local pairs = pairs
local table = table
local class = class
local CLASS = CLASS
local get_mod = get_mod
local tostring = tostring
local managers = Managers
local math_huge = math.huge
local script_unit = ScriptUnit
local math_random = math.random
local table_clear = table.clear
local network_lookup = NetworkLookup
local script_unit_has_extension = script_unit.has_extension

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local attack_results = AttackSettings.attack_results
local packages_to_load = {
    "wwise/events/minions/play_minion_terror_event_group_sfx_cultists",
    "wwise/events/minions/stop_minion_terror_event_group_sfx_cultists",
}

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local ServoFriendVoiceExtension = class("ServoFriendVoiceExtension", "ServoFriendBaseExtension")

mod:register_extension("ServoFriendVoiceExtension", "servo_friend_voice_system")
mod:register_sounds({
    fail                  = "wwise/events/player/play_device_auspex_bio_minigame_fail",
    progress_last         = "wwise/events/player/play_device_auspex_bio_minigame_progress_last",
    objective_canceled    = "wwise/events/player/play_device_auspex_bio_minigame_progress_last",
    progress              = "wwise/events/player/play_device_auspex_scanner_minigame_progress",
    wrong                 = "wwise/events/player/play_device_auspex_bio_minigame_selection_wrong",
    avoid_daemonhost      = "wwise/events/player/play_device_auspex_scanner_minigame_fail",
    right                 = "wwise/events/player/play_device_auspex_bio_minigame_selection_right",
    spawned               = "wwise/events/player/play_device_auspex_bio_minigame_selection_right",
    tagged_item           = "wwise/events/player/play_device_auspex_scanner_minigame_progress_last",
    selection             = "wwise/events/player/play_device_auspex_bio_minigame_selection",
    victory               = "wwise/events/player/play_device_auspex_bio_minigame_selection",
    tagged_enemy          = "wwise/events/player/play_device_auspex_scanner_minigame_progress",
    scanner_fail          = "wwise/events/player/play_device_auspex_scanner_minigame_fail",
    scanner_progress      = "wwise/events/player/play_device_auspex_scanner_minigame_progress",
    marker                = "wwise/events/player/play_device_auspex_scanner_minigame_progress",
    scanner_progress_last = "wwise/events/player/play_device_auspex_scanner_minigame_progress_last",
    start_alert           = "wwise/events/minions/play_minion_terror_event_group_sfx_cultists",
    stop_alert            = "wwise/events/minions/stop_minion_terror_event_group_sfx_cultists",
})
mod:register_packages(packages_to_load)

-- ##### ┬┌┐┌┬┌┬┐       ┌┬┐┌─┐┌─┐┌┬┐┬─┐┌─┐┬ ┬ #########################################################################
-- ##### │││││ │   ───   ││├┤ └─┐ │ ├┬┘│ │└┬┘ #########################################################################
-- ##### ┴┘└┘┴ ┴        ─┴┘└─┘└─┘ ┴ ┴└─└─┘ ┴  #########################################################################

ServoFriendVoiceExtension.init = function(self, extension_init_context, unit, extension_init_data)
    -- Base class
    ServoFriendVoiceExtension.super.init(self, extension_init_context, unit, extension_init_data)
    -- Data
    self.unit = unit
    self.talk_timer = 0
    self.talk_cooldown = 2
    self.victory_speech_points = 0
    self.voice_lines = {}
    self.audio_plugin = get_mod("servo_friend_audio_server_plugin")
    self.alert_playing = nil
    -- Events
    -- managers.event:register(self, "servo_friend_spawned", "on_servo_friend_spawned")
    -- managers.event:register(self, "servo_friend_destroyed", "on_servo_friend_destroyed")
    managers.event:register(self, "servo_friend_talk", "talk")
    managers.event:register(self, "servo_friend_victory_speech_accumulation", "victory_speech_accumulation")
    -- Settings
    self:on_settings_changed()
    -- Debug
    self:print("ServoFriendVoiceExtension initialized")
end

ServoFriendVoiceExtension.destroy = function(self)
    if self.alert_playing then
        self:stop_repeating_sound()
        self.alert_playing = nil
    end
    -- Events
    -- managers.event:unregister(self, "servo_friend_spawned")
    -- managers.event:unregister(self, "servo_friend_destroyed")
    managers.event:unregister(self, "servo_friend_talk")
    managers.event:unregister(self, "servo_friend_victory_speech_accumulation")
    -- Debug
    self:print("ServoFriendVoiceExtension destroyed")
    -- Base class
    ServoFriendVoiceExtension.super.destroy(self)
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

ServoFriendVoiceExtension.update = function(self, dt, t)
    -- Base class
    ServoFriendVoiceExtension.super.update(self, dt, t)
end

-- ##### ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ######################################################
-- ##### └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ └┐┌┘├┤ │││ │ └─┐ ######################################################
-- ##### └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘ └┘ └─┘┘└┘ ┴ └─┘ ######################################################

ServoFriendVoiceExtension.on_settings_changed = function(self)
    -- Base class
    ServoFriendVoiceExtension.super.on_settings_changed(self)
    -- Settings
    self.voice                    = mod:get("mod_option_voice")
    self.use_audio_mod            = mod:get("mod_option_use_audio_mod")
    self.victory_speech_frequency = mod:get("mod_option_victory_speech_frequency")
    self.victory_speech_max       = (1 - self.victory_speech_frequency) * 100
    -- Load
    self:load_voice_lines(true)
end

ServoFriendVoiceExtension.on_servo_friend_spawned = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        -- Base class
        ServoFriendVoiceExtension.super.on_servo_friend_spawned(self)
    end
end

ServoFriendVoiceExtension.on_servo_friend_destroyed = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        -- Base class
        ServoFriendVoiceExtension.super.on_servo_friend_destroyed(self)
    end
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

ServoFriendVoiceExtension.is_owned = function(self, marker)
    return marker and marker.data and marker.data.is_my_tag
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

ServoFriendVoiceExtension.talk = function(self, dt, t, optional_sound_event, servo_friend_unit, player_unit)
    -- local pt = self:pt()
    if self:is_initialized() and self.is_local_unit and self:is_me(servo_friend_unit) then
        if self.use_audio_mod and self.audio_plugin and self:servo_friend_alive() then
            self.audio_plugin:talk(dt, t, optional_sound_event, self.servo_friend_unit)

        elseif optional_sound_event == "start_alert" then
            -- self.alert_playing = self:play_sound("start_alert")
            self.alert_playing = self:start_repeating_sound("start_alert", 3)

        elseif optional_sound_event == "stop_alert" and self.alert_playing then
            self:stop_repeating_sound(self.alert_playing)
            self.alert_playing = nil

        elseif t > self.talk_timer or optional_sound_event == "spawned" then
            if self.voice ~= "off" then
                if self:servo_friend_alive() and #self.voice_lines > 0 then
                    local random = math_random(1, #self.voice_lines)
                    local sound_event = self.voice_lines[random]
                    local vo_file_path = "wwise/externals/"..sound_event
                    local event = "wwise/events/vo/play_sfx_es_player_vo"
                    local prio = "es_vo_prio_1"
                    local source = self._wwise_world:make_auto_source(self.servo_friend_unit, 1)
                    self._wwise_world:trigger_resource_external_event(event, prio, vo_file_path, 4, source)
                end
            elseif optional_sound_event then
                self:play_sound(optional_sound_event)
            else
                self:play_sound("progress")
            end

            self.talk_timer = t + self.talk_cooldown
        end
    end
end

ServoFriendVoiceExtension.victory_speech_accumulation = function(self, point_cost, is_boss, servo_friend_unit, player_unit)

    if self:is_initialized() and self.is_local_unit and player_unit == self.player_unit then
        if is_boss then point_cost = self.victory_speech_max end
        if point_cost == math_huge or point_cost ~= point_cost then point_cost = 6 end

        self.victory_speech_points = self.victory_speech_points + point_cost

        if self.victory_speech_points > self.victory_speech_max then

            local dt, t = self:delta_time(), self:time()
            managers.event:trigger("servo_friend_talk", dt, t, "victory", self.servo_friend_unit, self.player_unit)

            self.victory_speech_points = 0

        end
    end

end

ServoFriendVoiceExtension.load_voice_lines = function(self, clear)

    if not self.voice_lines then
        return
    end

    if clear then
        table_clear(self.voice_lines)
        self.voice_lines_loaded = false
    end

    if not self.voice_lines_loaded then
        local conversation_files = {}

        self.voice_lines_loaded = true

        if self.voice ~= "off" then
            conversation_files[#conversation_files+1] = "dialogues/generated/"..self.voice
        end

        for _, conversation_file in pairs(conversation_files) do
            local conversation_data = mod:original_require(conversation_file)
            if conversation_data then
                for _, conversation_sub_data in pairs(conversation_data) do
                    if conversation_sub_data and conversation_sub_data.sound_events then
                        for _, sound_event in pairs(conversation_sub_data.sound_events) do
                            self.voice_lines[#self.voice_lines+1] = sound_event
                        end
                    end
                end
            end
        end

        local dt, t = self:delta_time(), self:time()
        self:talk(dt, t, "selection")
    end
end

-- ##### ┬ ┬┌─┐┌─┐┬┌─┌─┐ ##############################################################################################
-- ##### ├─┤│ ││ │├┴┐└─┐ ##############################################################################################
-- ##### ┴ ┴└─┘└─┘┴ ┴└─┘ ##############################################################################################

mod:hook(CLASS.AttackReportManager, "rpc_add_attack_result", function(func, self, channel_id, damage_profile_id, attacked_unit_id, attacked_unit_is_level_unit,
        attacking_unit_id, attack_direction, hit_world_position, hit_weakspot, damage, attack_result_id, attack_type_id, damage_efficiency_id, is_critical_strike, ...)

    -- Original function
    func(self, channel_id, damage_profile_id, attacked_unit_id, attacked_unit_is_level_unit,
        attacking_unit_id, attack_direction, hit_world_position, hit_weakspot, damage, attack_result_id, attack_type_id, damage_efficiency_id, is_critical_strike, ...)

    -- local attacked_unit = buffer_data.attacked_unit
    local unit_spawner_manager = managers.state.unit_spawner
    local attacked_unit = attacked_unit_id and unit_spawner_manager:unit(attacked_unit_id, attacked_unit_is_level_unit)
    local attacking_unit = attacking_unit_id and unit_spawner_manager:unit(attacking_unit_id)
    local unit_data_extension = script_unit_has_extension(attacked_unit, "unit_data_system")
	local breed_or_nil = unit_data_extension and unit_data_extension:breed()

    if not breed_or_nil then
		return
	end

    local attack_result = network_lookup.attack_results[attack_result_id]
    local tags = breed_or_nil and breed_or_nil.tags
    local allowed_breed = tags and (tags.monster or tags.special or tags.elite)
    if allowed_breed and attack_result == attack_results.died then

        local point_cost = breed_or_nil.point_cost or 0
        managers.event:trigger("servo_friend_victory_speech_accumulation", point_cost, breed_or_nil.is_boss, nil, attacking_unit)

    end

end)

mod:hook(CLASS.AttackReportManager, "_process_attack_result", function(func, self, buffer_data, ...)

    -- Original function
    func(self, buffer_data, ...)

    local attacked_unit = buffer_data.attacked_unit
    local attacking_unit = buffer_data.attacking_unit
    local unit_data_extension = script_unit_has_extension(attacked_unit, "unit_data_system")
	local breed_or_nil = unit_data_extension and unit_data_extension:breed()

    if not breed_or_nil then
		return
	end

    local attack_result = buffer_data.attack_result
    local tags = breed_or_nil and breed_or_nil.tags
    local allowed_breed = tags and (tags.monster or tags.special or tags.elite)
    if allowed_breed and attack_result == attack_results.died then

        local point_cost = breed_or_nil.point_cost or 0
        managers.event:trigger("servo_friend_victory_speech_accumulation", point_cost, breed_or_nil.is_boss, nil, attacking_unit)

    end

end)

return ServoFriendVoiceExtension