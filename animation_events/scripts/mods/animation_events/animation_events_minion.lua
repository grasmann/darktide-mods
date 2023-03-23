local mod = get_mod("animation_events")

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################

-- Find event name by index
mod.minion_find_event_name = function(self, unit, event_index)
    -- Get indices if neccessary
    self:get_unit_indices(unit, "minion")
    -- Check if unit list exists
    if self.event_indices["minion"][unit] then
        -- Iterate through unit event list
        for event_name, index in pairs(self.event_indices["minion"][unit]) do
            -- Compare index
            if index == event_index then
                -- Return name
                return event_name
            end
        end
    end
end

mod.minion_handle_event = function(self, unit_id, event_index)
    local unit = Managers.state.unit_spawner:unit(unit_id)
    -- Find event
    local event_name = self:minion_find_event_name(unit, event_index)
    if event_name and self.all_events[event_name] then
        -- Handle event
        self:handle_callbacks(event_name, event_index, unit, false, "minion")
    end
end

mod.minion_handle_local_event = function(self, unit, event_name)
    -- Check for event name
    if self.all_events[event_name] then
        -- Handle event
        self:handle_callbacks(event_name, nil, unit, false, "minion")
    end
end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################

mod:hook(CLASS.AnimationSystem, "rpc_minion_anim_event", function(func, self, channel_id, unit_id, event_index, ...)
    mod:minion_handle_event(unit_id, event_index)
    return func(self, channel_id, unit_id, event_index, ...)
end)

mod:hook(CLASS.AnimationSystem, "rpc_minion_anim_event_variable_float",
function(func, self, channel_id, unit_id, event_index, variable_index, variable_value, ...)
    mod:minion_handle_event(unit_id, event_index)
    return func(self, channel_id, unit_id, event_index, variable_index, variable_value, ...)
end)

mod:hook(CLASS.MinionAnimationExtension, "anim_event", function(func, self, event_name, optional_except_channel_id, ...)
    mod:minion_handle_local_event(self._unit, event_name)
    return func(self, event_name, optional_except_channel_id, ...)
end)

mod:hook(CLASS.MinionAnimationExtension, "anim_event_with_variable_float", function(func, self, event_name, variable_name, variable_value, ...)
    mod:minion_handle_local_event(self._unit, event_name)
    return func(self, event_name, variable_name, variable_value, ...)
end)
