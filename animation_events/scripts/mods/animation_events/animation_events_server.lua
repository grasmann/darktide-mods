local mod = get_mod("animation_events")

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################

mod:hook(CLASS.AuthoritativePlayerUnitAnimationExtension, "anim_event",
function(func, self, event_name, ...)
	mod:handle_callbacks(event_name, nil, self._unit, false, "server")
	return func(self, event_name, ...)
end)

mod:hook(CLASS.AuthoritativePlayerUnitAnimationExtension, "anim_event_with_variable_float",
function(func, self, event_name, variable_name, variable_value, ...)
	mod:handle_callbacks(event_name, nil, self._unit, false, "server")
	return func(self, event_name, variable_name, variable_value, ...)
end)

mod:hook(CLASS.AuthoritativePlayerUnitAnimationExtension, "anim_event_with_variable_int",
function(func, self, event_name, variable_name, variable_value, ...)
	mod:handle_callbacks(event_name, nil, self._unit, false, "server")
	return func(self, event_name, variable_name, variable_value, ...)
end)

mod:hook(CLASS.AuthoritativePlayerUnitAnimationExtension, "anim_event_with_variable_floats",
function(func, self, event_name, ...)
	mod:handle_callbacks(event_name, nil, self._unit, false, "server")
	return func(self, event_name, ...)
end)

mod:hook(CLASS.AuthoritativePlayerUnitAnimationExtension, "anim_event_1p",
function(func, self, event_name, ...)
	mod:handle_callbacks(event_name, nil, self._unit, true, "server")
	return func(self, event_name, ...)
end)

mod:hook(CLASS.AuthoritativePlayerUnitAnimationExtension, "anim_event_with_variable_float_1p",
function(func, self, event_name, variable_name, variable_value, ...)
	mod:handle_callbacks(event_name, nil, self._unit, true, "server")
	return func(self, event_name, variable_name, variable_value, ...)
end)

mod:hook(CLASS.AuthoritativePlayerUnitAnimationExtension, "anim_event_with_variable_floats_1p",
function(func, self, event_name, ...)
	mod:handle_callbacks(event_name, nil, self._unit, true, "server")
	return func(self, event_name, ...)
end)