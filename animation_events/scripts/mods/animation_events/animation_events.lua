local mod = get_mod("animation_events")
local DMF = get_mod("DMF")
-- local mod_name = "AnimationEvents"
-- Mods[mod_name] = {} --Mods[mod_name] or {}
-- local mod = Mods[mod_name]
mod.debug = false

mod.callbacks = {}
mod.register_callback = function(self, event_name, callback)
	self.callbacks[#self.callbacks+1] = {
		event_name = event_name,
		callback = callback,
	}
end

mod.handle_callbacks = function(self, event_name, event_index, unit, first_person, context)
	-- if mod.debug then self:check_existence(event_name, event_index, unit, first_person) end
	for _, callback in pairs(self.callbacks) do
		if callback.event_name == event_name or callback.event_name == "__all" then
			callback.callback(event_name, event_index, unit, first_person, context)
		end
	end
end

mod.get_event_names = function(self)
    local event_names = {}
    for _, data in pairs(self.callbacks) do
        event_names[#event_names+1] = data.event_name
    end
    return event_names
end

function mod.on_all_mods_loaded()
	for _, this_mod in pairs(DMF.mods) do
		if type(this_mod) == "table" then
			if this_mod.animation_events then
				for event_name, callback in pairs(this_mod.animation_events) do
					mod:register_callback(event_name, callback)
				end
			end
		end
	end
end

-- Mods.exec("patch", "AnimationEventsPlayer")
Mods.file.dofile("animation_events/scripts/mods/animation_events/AnimationEventsPlayer")
-- Mods.exec("patch", "AnimationEventsServer")
Mods.file.dofile("animation_events/scripts/mods/animation_events/AnimationEventsServer")
-- Mods.exec("patch", "AnimationEventsRPC")
Mods.file.dofile("animation_events/scripts/mods/animation_events/AnimationEventsRPC")
-- Mods.exec("patch", "AnimationEventsMinion")
Mods.file.dofile("animation_events/scripts/mods/animation_events/AnimationEventsMinion")
