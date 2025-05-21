local mod = get_mod("servo_friend_audio_server_plugin")
local audio_mod, servo_friend = nil, nil

local unit = Unit
local math = math
local pairs = pairs
local table = table
local CLASS = CLASS
local get_mod = get_mod
local tostring = tostring
local managers = Managers
local math_uuid = math.uuid
local table_size = table.size
local unit_alive = unit.alive
local math_random = math.random
local table_clear = table.clear
local table_remove = table.remove

local enemy_descriptions = {
    {name = "enemy",     length = .5},
    {name = "assailant", length = .5},
    {name = "foe",       length = .5},
    {name = "traitor",   length = .5},
    {name = "unit",      length = .5},
}

local tagged_enemy_descriptions = {
    {name = "following", length = .65},
    {name = "observing", length = .65},
    {name = "pursuing",  length = .6},
    {name = "tailing",   length = .5},
    {name = "tracking",  length = .5},
}

local objective_descriptions = {
    {name = "objective",   length = .75},
    {name = "directive",   length = .75},
    {name = "order",       length = .5},
    {name = "instruction", length = .75},
    {name = "command",     length = .5},
}

local cancel_descriptions = {
    {name = "canceled",  length = .5},
    {name = "optimized", length = .5},
    {name = "abandoned", length = .5},
    {name = "upgraded",  length = .5},
    {name = "enhanced",  length = .5},
}

local items_descriptions = {
    {name = "inventory",   length = .75},
    {name = "reservoir", length = .75},
    {name = "stock", length = .5},
    {name = "provisions", length = .75},
    {name = "resources", length = .75},
}

local tagged_item_descriptions = {
    {name = "identified", length = .65},
    {name = "discovered", length = .65},
    {name = "located",  length = .6},
    {name = "found",   length = .5},
    {name = "ascertained",  length = .5},
}

local oversee_descriptions = {
    {name = "overseeing",  length = .75},
    {name = "supervising", length = .75},
    {name = "watching",    length = .65},
    {name = "controlling", length = .75},
    {name = "guarding",    length = .65},
}

local area_descriptions = {
    {name = "locality", length = .5},
    {name = "scene",    length = .5},
    {name = "position", length = .5},
    {name = "region",   length = .5},
    {name = "precinct", length = .5},
}

local victory_speeches = {{
        {name = "target_eliminated", length = 1.5},
        {name = "purity_confirmed", length = 1.5},
    }, {
        {name = "glory_to_the_emperor", length = 1.5},
        {name = "the_heretics_eternal_silence", length = 1.5},
    }, {
        {name = "machine_psalm_47", length = 2},
        {name = "success_is_effeciency", length = 1.5},
    }, {
        {name = "recording_stored", length = 1.5},
        {name = "vitory_through_fury", length = 1.5},
    }, {
        {name = "enemy_contact_neutralized", length = 2},
        {name = "database_updated", length = 1.5},
    }, {
        {name = "victory_logged", length = 1.5},
        {name = "mercy_is_for_weak", length = 1.5},
    }, {
        {name = "emperor_demands_results", length = 2.5},
        {name = "and_we_have_delivered", length = 1.5},
    }, {
        {name = "operation_complete", length = 1.5},
        {name = "assasment", length = 1.5},
    }, {
        {name = "99_97_effeciency", length = 2.5},
        {name = "suggestions_for_improvement", length = 1.5},
    }, {
        {name = "knowledge_through_annihalation", length = 1.5},
    }, {
        {name = "thruth_speaks_bolter", length = 2},
        {name = "victory_confirmed", length = 1.5},
    }, {
        {name = "heretic_data_extracted", length = 1.75},
        {name = "purge_initialized", length = 1.5},
    }, {
        {name = "purity_of_our_mission", length = 1.5},
    }, {
        {name = "proceeding_to_next", length = 2},
        {name = "log_updated", length = 1.5},
    }, {
        {name = "rightous_have_prevailed", length = 1.5},
        {name = "initiating_victory_hymn", length = 1.5},
    }, {
        {name = "fire_cleanses", length = 1.5},
        {name = "emperor_blesses_this_day", length = 1.5},
    }, {
        {name = "false_gods_fallen", length = 1.5},
        {name = "machine_god_is_pleased", length = 1.5},
    }, {
        {name = "success_lies_in_obedience", length = 1.5},
    }, {
        {name = "heretic_status_erased", length = 2},
        {name = "servo_processor_pleased", length = 1.5},
    }, {
        {name = "statistical_probability_failure", length = 2.75},
        {name = "fait_outweighs_numbers", length = 1.5},
    }, {
        {name = "exterminatus_unnecessary", length = 2},
        {name = "target_zone_cleansed", length = 1.5},
    }, {
        {name = "emperial_effeciency_optimal", length = 2.5},
        {name = "praise_omnissiah", length = 1.5},
    },
}

local awake_speeches = {
    {name = "awake_01", length = 1.5},
    {name = "awake_02", length = 1.5},
    {name = "awake_03", length = 1.5},
    {name = "awake_04", length = 1.5},
    {name = "awake_05", length = 1.5},
    {name = "awake_06", length = 1.5},
    {name = "awake_07", length = 1.5},
    {name = "awake_08", length = 1.5},
    {name = "awake_09", length = 1.5},
}

local avoid_daemonhost_speeches = {
    {name = "avoid_daemonhost_01", length = 1.5},
    {name = "avoid_daemonhost_02", length = 1.5},
    {name = "avoid_daemonhost_03", length = 1.5},
    {name = "avoid_daemonhost_04", length = 1.5},
    {name = "avoid_daemonhost_05", length = 1.5},
    {name = "avoid_daemonhost_06", length = 1.5},
    {name = "avoid_daemonhost_07", length = 1.5},
}

local alert_sound = "alert"

local temp_map = {}

mod.on_all_mods_loaded = function()
    -- References
    audio_mod = get_mod("Audio")
    servo_friend = get_mod("servo_friend")
    -- Init
    -- mod.event_manager = managers.event
    mod.voice_volume = 1
    mod.queued_audio = {}
    mod.running_audio = {}
    mod.talk_timer = 0
    mod.talk_cooldown = 2
    mod.time_manager = managers.time
    mod.used_victory_speech = {}
    mod.avoid_daemonhost_speeches_timer = 0
    mod.avoid_daemonhost_speeches_cooldown = 5
    mod.used_avoid_daemonhost_speech = {}
    mod.running_alert_sound = nil
    -- Events
    managers.event:register(mod, "servo_friend_settings_changed", "on_settings_changed")
    -- Settings
    mod:on_settings_changed()
end

mod.on_unload = function()
    managers.event:unregister("servo_friend_settings_changed")
end

mod.on_game_state_changed = function(status, state_name)
    mod.talk_timer = 0
    mod.avoid_daemonhost_speeches_timer = 0
    mod:stop_alert()
end

mod.on_setting_changed = function(setting_id)
    mod:on_settings_changed()
end

mod.on_settings_changed = function(self)
    self.voice_volume = nil
    self.alert_volume = nil
end

mod.volume = function(self)
    if not self.voice_volume then
        self.voice_volume = servo_friend:get("mod_option_voice_volume")
    end
    return self.voice_volume or 1
end

mod.alert_volumne = function(self)
    if not self.alert_volume then
        self.alert_volume = servo_friend:get("mod_option_alert_mode_sound_volume")
    end
    return self.alert_volume or 1
end

mod.update = function(dt)
    if mod.time_manager and mod.time_manager:has_timer("gameplay") then
        local t = mod.time_manager:time("gameplay")
        mod:play_queued_audio(dt, t)
    end
end

mod.play_queued_audio = function(self, dt, t)
    if audio_mod then

        for i = #self.queued_audio, 1, -1 do
            local queued_audio = self.queued_audio[i]
            if queued_audio and queued_audio.time < t then

                local audio_key = math_uuid()
                if queued_audio.unit and unit_alive(queued_audio.unit) then
                    local audio_id = audio_mod.play_file("servo_friend_audio_server_plugin/audio/sfx/"..queued_audio.name..".ogg", {
                        audio_type = "sfx",
                        track_status = function()
                            mod:on_running_audio_finished(audio_key)
                        end,
                        volume = 200 * self:volume(),
                    }, queued_audio.unit)

                    self.running_audio[audio_key] = {
                        name = queued_audio.name,
                        time = t,
                        audio_id = audio_id,
                    }
                end

                table_remove(self.queued_audio, i)
            end
        end

    end
end

mod.on_running_audio_finished = function(self, audio_key)
    self.running_audio[audio_key] = nil
end

mod.can_play_audio = function(self)
    return table_size(self.queued_audio) == 0 and table_size(self.running_audio) == 0
end

mod.talk = function(self, dt, t, event_name, unit)

    -- No audio queued
    if self:can_play_audio() then

        -- Victory
        if event_name == "victory" then
            
            self:victory(dt, t, unit)

            self.talk_timer = t + self.talk_cooldown

        elseif t > self.avoid_daemonhost_speeches_timer and event_name == "avoid_daemonhost" then

            self:avoid_daemonhost(dt, t, unit)

            self.avoid_daemonhost_speeches_timer = t + self.avoid_daemonhost_speeches_cooldown
            self.talk_timer = t + self.talk_cooldown

        -- Talk
        elseif t > self.talk_timer or event_name == "spawned" then

            if event_name == "tagged_enemy" then
                self:tagged_enemy(dt, t, unit)
            elseif event_name == "tagged_item" then
                self:tagged_item(dt, t, unit)
            elseif event_name == "objective_canceled" then
                self:objective_canceled(dt, t, unit)
            elseif event_name == "marker" then
                self:marker(dt, t, unit)
            elseif event_name == "spawned" then
                self:awake(dt, t, unit)
            end

            self.talk_timer = t + self.talk_cooldown

        end

    end

    if event_name == "start_alert" then

        self:start_alert(dt, t, unit)

    elseif event_name == "stop_alert" then

        self:stop_alert(dt, t, unit)

    end

end

mod.start_alert = function(self, dt, t, unit, audio_key)
    if not self.running_alert_sound or self.running_alert_sound == audio_key then
        audio_key = math_uuid()
        if unit and unit_alive(unit) then
            audio_mod.play_file("servo_friend_audio_server_plugin/audio/sfx/"..alert_sound..".ogg", {
                audio_type = "sfx",
                track_status = function()
                    mod:on_alert_finished(unit, audio_key)
                end,
                volume = 200 * self:alert_volumne(),
            }, unit)
            self.running_alert_sound = audio_key
        end
    end
end

mod.on_alert_finished = function(self, unit, audio_key)
    if self.running_alert_sound == audio_key then
        if mod.time_manager and mod.time_manager:has_timer("gameplay") then
            local dt, t = mod.time_manager:delta_time("gameplay"), mod.time_manager:time("gameplay")
            self:start_alert(dt, t, unit, audio_key)
        end
    end
end

mod.stop_alert = function(self, dt, t, unit)
    self.running_alert_sound = nil
end

mod.map_avoid_daemonhost = function(self)
    table_clear(temp_map)
    if table_size(mod.used_avoid_daemonhost_speech) >= #avoid_daemonhost_speeches then
        table_clear(mod.used_avoid_daemonhost_speech)
    end
    for speech_index, speech_data in pairs(avoid_daemonhost_speeches) do
        if not mod.used_avoid_daemonhost_speech[speech_data] then
            temp_map[#temp_map+1] = speech_data
        end
    end
    return temp_map
end

mod.avoid_daemonhost = function(self, dt, t, unit)

    local avoid_map = self:map_avoid_daemonhost()
    local rnd_avoid = math_random(1, #avoid_map)
    local avoid_sfx = avoid_map[rnd_avoid]

    self.queued_audio[#self.queued_audio+1] = {
        name = avoid_sfx.name,
        time = t,
        unit = unit,
    }

    mod.used_avoid_daemonhost_speech[avoid_sfx] = true
end

mod.awake = function(self, dt, t, unit)
    local rnd_awake = math_random(1, #awake_speeches)
    local awake_sfx = awake_speeches[rnd_awake]

    self.queued_audio[#self.queued_audio+1] = {
        name = awake_sfx.name,
        time = t,
        unit = unit,
    }
end

mod.map_victory = function(self)
    table_clear(temp_map)
    if table_size(mod.used_victory_speech) >= #victory_speeches then
        table_clear(mod.used_victory_speech)
    end
    for speech_index, speech_data in pairs(victory_speeches) do
        if not mod.used_victory_speech[speech_data] then
            temp_map[#temp_map+1] = speech_data
        end
    end
    return temp_map
end

mod.victory = function(self, dt, t, unit)
    
    local speech_map = self:map_victory()
    local rnd_speech = math_random(1, #speech_map)
    local speech_data = speech_map[rnd_speech]

    local speech_sfx_1 = speech_data[1]
    self.queued_audio[#self.queued_audio+1] = {
        name = speech_sfx_1.name,
        time = t,
        unit = unit,
    }

    if #speech_data > 1 then

        local speech_sfx_2 = speech_data[2]
        self.queued_audio[#self.queued_audio+1] = {
            name = speech_sfx_2.name,
            time = t + speech_sfx_1.length,
            unit = unit,
        }

    end

    mod.used_victory_speech[speech_data] = true
end

mod.marker = function(self, dt, t, unit)
    local rnd_oversee = math_random(1, #oversee_descriptions)
    local oversee_sfx = oversee_descriptions[rnd_oversee]
    local rnd_area = math_random(1, #area_descriptions)
    local area_sfx = area_descriptions[rnd_area]

    self.queued_audio[#self.queued_audio+1] = {
        name = oversee_sfx.name,
        time = t,
        unit = unit,
    }
    self.queued_audio[#self.queued_audio+1] = {
        name = area_sfx.name,
        time = t + oversee_sfx.length,
        unit = unit,
    }
end

mod.tagged_enemy = function(self, dt, t, unit)
    local rnd_tagged = math_random(1, #tagged_enemy_descriptions)
    local tagged_sfx = tagged_enemy_descriptions[rnd_tagged]
    local rnd_enemy = math_random(1, #enemy_descriptions)
    local enemy_sfx = enemy_descriptions[rnd_enemy]

    self.queued_audio[#self.queued_audio+1] = {
        name = tagged_sfx.name,
        time = t,
        unit = unit,
    }
    self.queued_audio[#self.queued_audio+1] = {
        name = enemy_sfx.name,
        time = t + tagged_sfx.length,
        unit = unit,
    }
end

mod.tagged_item = function(self, dt, t, unit)
    local rnd_item = math_random(1, #items_descriptions)
    local item_sfx = items_descriptions[rnd_item]
    local rnd_tagged = math_random(1, #tagged_item_descriptions)
    local tagged_sfx = tagged_item_descriptions[rnd_tagged]

    self.queued_audio[#self.queued_audio+1] = {
        name = item_sfx.name,
        time = t,
        unit = unit,
    }
    self.queued_audio[#self.queued_audio+1] = {
        name = tagged_sfx.name,
        time = t + item_sfx.length,
        unit = unit,
    }
end

mod.objective_canceled = function(self, dt, t, unit)
    local rnd_objective = math_random(1, #objective_descriptions)
    local objective_sfx = objective_descriptions[rnd_objective]
    local rnd_cancel = math_random(1, #cancel_descriptions)
    local cancel_sfx = cancel_descriptions[rnd_cancel]

    self.queued_audio[#self.queued_audio+1] = {
        name = objective_sfx.name,
        time = t,
        unit = unit,
    }
    self.queued_audio[#self.queued_audio+1] = {
        name = cancel_sfx.name,
        time = t + objective_sfx.length,
        unit = unit,
    }
end