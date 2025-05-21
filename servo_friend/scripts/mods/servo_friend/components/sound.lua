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
    -- Check sounds
    if not sounds or table_size(sounds) == 0 then return end
    -- Iterate sounds
    for event, sound in pairs(sounds) do
        -- Add sound
        pt.sound_events[event] = sound
    end
end

-- Play sound
mod.play_sound = function(self, sound_event, optional_source_id, position)
    local pt = self:pt()
    -- Get wwise world
    local wwise_world = self:wwise_world()
    -- Check wwise world and sound event
    if wwise_world and sound_event then
        -- Get real sound effect
        local sound_effect = pt.sound_events[sound_event]
        -- Check sound effect
        if sound_effect then
            -- Get position
            position = position or self:local_player_position()
            -- Create audio source or use optional source
            local source_id = optional_source_id or wwise_world_make_auto_source(wwise_world, position)
            -- Play sound effect and get audio id
            local audio_id = wwise_world_trigger_resource_event(wwise_world, sound_effect, source_id)
            -- Return audio source id and audio id
            return source_id, audio_id
        end
    end
end

mod.start_repeating_sound = function(self, sound_event, length, optional_source_id)
    -- Create repeating id
    local repeating_id = math_uuid()
    -- Play sound
    local source_id, audio_id = self:play_sound(sound_event, optional_source_id)
    -- Add repeating sound
    self.repeating_sounds[repeating_id] = {
        event = sound_event,
        length = length or 1,
        source_id = source_id,
        audio_id = audio_id,
        start_time = self:time(),
    }
    -- Return repeating id
    return repeating_id
end

mod.stop_sound_event = function(self, audio_id)
    -- Get wwise world
    local wwise_world = self:wwise_world()
    -- Check if sound still playing
    if wwise_world_is_playing(wwise_world, audio_id) then
        -- Stop sound
        wwise_world_stop_event(wwise_world, audio_id)
    end
end

mod.stop_all_repeating_sounds = function(self)
    -- Iterate repeating sounds
    for repeating_id, repeating_sound in pairs(self.repeating_sounds) do
        -- self:stop_repeating_sound(repeating_id)
        self:stop_sound_event(repeating_sound.audio_id)
    end
    table_clear(self.repeating_sounds)
end

mod.stop_repeating_sound = function(self, repeating_id)
    local repeating_sound = self.repeating_sounds[repeating_id]
    if repeating_sound then
        -- Check if sound is still playing and stop
        self:stop_sound_event(repeating_sound.audio_id)
        -- Remove repeating sound
        self.repeating_sounds[repeating_id] = nil
    end
end

mod.update_repeating_sounds = function(self, dt, t)
    -- Iterate repeating sounds
    for repeating_id, repeating_sound in pairs(self.repeating_sounds) do
        -- Get wwise world
        local wwise_world = self:wwise_world()
        -- if not wwise_world_is_playing(wwise_world, repeating_sound.audio_id) then
        if t > repeating_sound.start_time + repeating_sound.length then
            -- Check if sound is still playing and stop
            self:stop_sound_event(repeating_sound.audio_id)
            -- Replay sound
            repeating_sound.audio_id = self:play_sound(repeating_sound.event, repeating_sound.source_id)
            -- Reset start time
            repeating_sound.start_time = t
        end
    end
end