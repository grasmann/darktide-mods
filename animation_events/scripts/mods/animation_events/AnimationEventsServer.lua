-- local mod_name = "AnimationEventsServer"
-- Mods[mod_name] = {} --Mods[mod_name] or {}
-- local mod = Mods[mod_name]
local mod = get_mod("animation_events")

-- ##### ██████╗  █████╗ ████████╗ █████╗  ############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################

-- local PlayerUnitAnimationState = Mods.original_require("scripts/extension_systems/animation/utilities/player_unit_animation_state")
-- local authoritative_player_unit_animation_extension_file = "scripts/extension_systems/animation/authoritative_player_unit_animation_extension"
-- local AnimationEvents = nil

-- -- ##### ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗ #########################################################
-- -- ##### ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝ #########################################################
-- -- ##### █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗ #########################################################
-- -- ##### ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║ #########################################################
-- -- ##### ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║ #########################################################
-- -- ##### ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ #########################################################

-- function mod.on_all_mods_loaded()
-- 	AnimationEvents = Mods.AnimationEvents
-- end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################

-- Mods.hook.remove("anim_event", mod_name)
mod:hook(CLASS.AuthoritativePlayerUnitAnimationExtension, "anim_event", function(func, self, event_name, ...)
	mod:handle_callbacks(event_name, nil, self._unit, false, "server")
	return func(self, event_name, ...)
end)

-- Mods.hook.remove("anim_event_with_variable_float", mod_name)
mod:hook(CLASS.AuthoritativePlayerUnitAnimationExtension, "anim_event_with_variable_float", function(func, self, event_name, variable_name, variable_value, ...)
	mod:handle_callbacks(event_name, nil, self._unit, false, "server")
	return func(self, event_name, variable_name, variable_value, ...)
end)

-- Mods.hook.remove("anim_event_with_variable_int", mod_name)
mod:hook(CLASS.AuthoritativePlayerUnitAnimationExtension, "anim_event_with_variable_int", function(func, self, event_name, variable_name, variable_value, ...)
	mod:handle_callbacks(event_name, nil, self._unit, false, "server")
	return func(self, event_name, variable_name, variable_value, ...)
end)

-- Mods.hook.remove("anim_event_with_variable_floats", mod_name)
mod:hook(CLASS.AuthoritativePlayerUnitAnimationExtension, "anim_event_with_variable_floats", function(func, self, event_name, ...)
	mod:handle_callbacks(event_name, nil, self._unit, false, "server")
	return func(self, event_name, ...)
end)

-- Mods.hook.remove("anim_event_1p", mod_name)
mod:hook(CLASS.AuthoritativePlayerUnitAnimationExtension, "anim_event_1p", function(func, self, event_name, ...)
	mod:handle_callbacks(event_name, nil, self._unit, true, "server")
	return func(self, event_name, ...)
end)

-- Mods.hook.remove("anim_event_with_variable_float_1p", mod_name)
mod:hook(CLASS.AuthoritativePlayerUnitAnimationExtension, "anim_event_with_variable_float_1p", function(func, self, event_name, variable_name, variable_value, ...)
	mod:handle_callbacks(event_name, nil, self._unit, true, "server")
	return func(self, event_name, variable_name, variable_value, ...)
end)

-- Mods.hook.remove("anim_event_with_variable_floats_1p", mod_name)
-- mod:hook(mod_name, authoritative_player_unit_animation_extension_file, "anim_event_with_variable_floats_1p", function(func, self, event_name, ...)
mod:hook(CLASS.AuthoritativePlayerUnitAnimationExtension, "anim_event_with_variable_floats_1p", function(func, self, event_name, ...)
	mod:handle_callbacks(event_name, nil, self._unit, true, "server")
	return func(self, event_name, ...)
end)