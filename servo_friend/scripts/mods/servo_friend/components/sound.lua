local mod = get_mod("servo_friend")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local math = math
local table = table
local pairs = pairs
local vector3 = Vector3
local math_uuid = math.uuid
local table_size = table.size
local wwise_world = WwiseWorld
local vector3_box = Vector3Box
local table_clear = table.clear
local vector3_unbox = vector3_box.unbox
local wwise_world_stop_event = wwise_world.stop_event
local wwise_world_is_playing = wwise_world.is_playing
local wwise_world_make_auto_source = wwise_world.make_auto_source
local wwise_world_trigger_resource_event = wwise_world.trigger_resource_event

-- ##### ┌─┐┌─┐┬ ┬┌┐┌┌┬┐┌─┐ ###########################################################################################
-- ##### └─┐│ ││ ││││ ││└─┐ ###########################################################################################
-- ##### └─┘└─┘└─┘┘└┘─┴┘└─┘ ###########################################################################################

mod.repeating_sounds = {}

-- Register sounds
mod.register_sounds = function(self, sounds)
    local pt = self:pt()

    if not sounds or table_size(sounds) == 0 then
        return
    end

    for event, sound in pairs(sounds) do
        pt.sound_events[event] = sound
    end
end

-- Play sound
mod.play_sound = function(self, sound_event, optional_source_id, position)
    local pt = self:pt()
    local current_wwise_world = self:wwise_world()

    if current_wwise_world and sound_event then
        local sound_effect = pt.sound_events[sound_event]

        if sound_effect then
            position = position or self:local_player_position()

            local source_id = optional_source_id or wwise_world_make_auto_source(current_wwise_world, position)
            local audio_id = source_id and
                wwise_world_trigger_resource_event(current_wwise_world, sound_effect, source_id)

            return source_id, audio_id
        end
    end
end

mod.start_repeating_sound = function(self, sound_event, length, optional_source_id)
    local repeating_id = math_uuid()
    local source_id, audio_id = self:play_sound(sound_event, optional_source_id)

    if not source_id or not audio_id then
        return nil
    end

    self.repeating_sounds[repeating_id] = {
        event = sound_event,
        length = length or 1,
        source_id = source_id,
        audio_id = audio_id,
        start_time = self:time(),
    }

    return repeating_id
end

mod.stop_sound_event = function(self, audio_id)
    local current_wwise_world = self:wwise_world()

    if current_wwise_world and audio_id and wwise_world_is_playing(current_wwise_world, audio_id) then
        wwise_world_stop_event(current_wwise_world, audio_id)
    end
end

mod.stop_all_repeating_sounds = function(self)
    for repeating_id, repeating_sound in pairs(self.repeating_sounds) do
        self:stop_sound_event(repeating_sound.audio_id)
    end

    table_clear(self.repeating_sounds)
end

mod.stop_repeating_sound = function(self, repeating_id)
    local repeating_sound = self.repeating_sounds[repeating_id]

    if repeating_sound then
        self:stop_sound_event(repeating_sound.audio_id)
        self.repeating_sounds[repeating_id] = nil
    end
end

mod.update_repeating_sounds = function(self, dt, t)
    for repeating_id, repeating_sound in pairs(self.repeating_sounds) do
        if t > repeating_sound.start_time + repeating_sound.length then
            self:stop_sound_event(repeating_sound.audio_id)

            local source_id, audio_id = self:play_sound(repeating_sound.event, repeating_sound.source_id)

            if source_id and audio_id then
                repeating_sound.source_id = source_id
                repeating_sound.audio_id = audio_id
                repeating_sound.start_time = t
            else
                self.repeating_sounds[repeating_id] = nil
            end
        end
    end
end
