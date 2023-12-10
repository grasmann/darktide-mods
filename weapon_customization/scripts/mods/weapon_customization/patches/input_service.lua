local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local CLASS = CLASS
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"

-- ##### ┬┌┐┌┌─┐┬ ┬┌┬┐ ################################################################################################
-- ##### ││││├─┘│ │ │  ################################################################################################
-- ##### ┴┘└┘┴  └─┘ ┴  ################################################################################################

local input_hook = function (func, self, action_name, ...)
    local pressed = func(self, action_name, ...)
    local wielded = mod:execute_extension(mod.player_unit, "flashlight_system", "is_wielded")
    local modded = mod:execute_extension(mod.player_unit, "flashlight_system", "is_modded")
    if mod.initialized and wielded and modded then
        if action_name == "weapon_extra_pressed" and pressed then
            mod:execute_extension(mod.player_unit, "flashlight_system", "on_toggle")
            return self:get_default(action_name)
        end
        if action_name == "weapon_extra_hold" then
            return self:get_default(action_name)
        end
    end
    return pressed
end
  
-- Detach player movement from camera
mod:hook(CLASS.InputService, "_get", input_hook)

-- Detach simulated player movement from camera
mod:hook(CLASS.InputService, "_get_simulate", input_hook)