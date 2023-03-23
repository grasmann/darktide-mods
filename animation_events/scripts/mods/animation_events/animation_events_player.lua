local mod = get_mod("animation_events")

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################

mod.player_handle_event = function(self, unit, event_name)
	if self.all_events[event_name] then
		mod:handle_callbacks(event_name, nil, unit, false, "player")
	end
end

mod:hook(CLASS.PlayerUnitAnimationExtension, "anim_event", function(func, self, event_name, ...)
	mod:server_handle_event(self._unit, event_name)
	return func(self, event_name, ...)
end)

mod:hook(CLASS.PlayerUnitAnimationExtension, "anim_event_with_variable_float", function(func, self, event_name, variable_name, variable_value, ...)
	mod:server_handle_event(self._unit, event_name)
	return func(self, event_name, variable_name, variable_value, ...)
end)

mod:hook(CLASS.PlayerUnitAnimationExtension, "anim_event_with_variable_floats", function(func, self, event_name, ...)
	mod:server_handle_event(self._unit, event_name)
	return func(self, event_name, ...)
end)

mod:hook(CLASS.PlayerUnitAnimationExtension, "anim_event_with_variable_int", function(func, self, event_name, variable_name, variable_value, ...)
	mod:server_handle_event(self._unit, event_name)
	return func(self, event_name, variable_name, variable_value, ...)
end)

mod:hook(CLASS.PlayerUnitAnimationExtension, "anim_event_1p", function(func, self, event_name, ...)
	mod:server_handle_event(self._unit, event_name)
	return func(self, event_name, ...)
end)

mod:hook(CLASS.PlayerUnitAnimationExtension, "anim_event_with_variable_float_1p", function(func, self, event_name, variable_name, variable_value, ...)
	mod:server_handle_event(self._unit, event_name)
	return func(self, event_name, variable_name, variable_value, ...)
end)

mod:hook(CLASS.PlayerUnitAnimationExtension, "anim_event_with_variable_floats_1p", function(func, self, event_name, ...)
	mod:server_handle_event(self._unit, event_name)
	return func(self, event_name, ...)
end)
