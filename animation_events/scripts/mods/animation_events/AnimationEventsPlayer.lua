-- local mod_name = "modPlayer"
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
-- local player_unit_animation_extension_file = "scripts/extension_systems/animation/player_unit_animation_extension"
-- local mod = nil

-- -- ##### ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗ #########################################################
-- -- ##### ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝ #########################################################
-- -- ##### █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗ #########################################################
-- -- ##### ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║ #########################################################
-- -- ##### ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║ #########################################################
-- -- ##### ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ #########################################################

-- mod.all_mods_loaded = function()
-- 	mod = Mods.mod
-- end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################

-- Mods.hook.remove("anim_event", mod_name)
mod:hook(CLASS.PlayerUnitAnimationExtension, "anim_event", function(func, self, event_name, ...)
	mod:handle_callbacks(event_name, nil, self._unit, false, "player")
	return func(self, event_name, ...)
end)

-- Mods.hook.remove("anim_event_with_variable_float", mod_name)
mod:hook(CLASS.PlayerUnitAnimationExtension, "anim_event_with_variable_float", function(func, self, event_name, variable_name, variable_value, ...)
	mod:handle_callbacks(event_name, nil, self._unit, false, "player")
	return func(self, event_name, variable_name, variable_value, ...)
end)

-- Mods.hook.remove("anim_event_with_variable_floats", mod_name)
mod:hook(CLASS.PlayerUnitAnimationExtension, "anim_event_with_variable_floats", function(func, self, event_name, ...)
    mod:handle_callbacks(event_name, nil, self._unit, false, "player")
	return func(self, event_name, ...)
end)

-- Mods.hook.remove("anim_event_with_variable_int", mod_name)
mod:hook(CLASS.PlayerUnitAnimationExtension, "anim_event_with_variable_int", function(func, self, event_name, variable_name, variable_value, ...)
    mod:handle_callbacks(event_name, nil, self._unit, false, "player")
	return func(self, event_name, variable_name, variable_value, ...)
end)

-- Mods.hook.remove("anim_event_1p", mod_name)
mod:hook(CLASS.PlayerUnitAnimationExtension, "anim_event_1p", function(func, self, event_name, ...)
    mod:handle_callbacks(event_name, nil, self._unit, true, "player")
	return func(self, event_name, ...)
end)

-- Mods.hook.remove("anim_event_with_variable_float_1p", mod_name)
mod:hook(CLASS.PlayerUnitAnimationExtension, "anim_event_with_variable_float_1p", function(func, self, event_name, variable_name, variable_value, ...)
    mod:handle_callbacks(event_name, nil, self._unit, true, "player")
	return func(self, event_name, variable_name, variable_value, ...)
end)

-- Mods.hook.remove("anim_event_with_variable_floats_1p", mod_name)
mod:hook(CLASS.PlayerUnitAnimationExtension, "anim_event_with_variable_floats_1p", function(func, self, event_name, ...)
    mod:handle_callbacks(event_name, nil, self._unit, true, "player")
	return func(self, event_name, ...)
end)
