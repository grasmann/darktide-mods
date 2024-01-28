local mod = get_mod("weapon_customization")

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
local WEAPON_EXTRA_HOLD = "weapon_extra_hold"
local WEAPON_EXTRA_PRESSED = "weapon_extra_pressed"

-- ##### ┬┌┐┌┌─┐┬ ┬┌┬┐ ################################################################################################
-- ##### ││││├─┘│ │ │  ################################################################################################
-- ##### ┴┘└┘┴  └─┘ ┴  ################################################################################################

local input_hook = function (func, self, action_name, ...)
    local pressed = func(self, action_name, ...)
    if mod.initialized then
        if mod:is_flashlight_modded() then
            if mod:is_flashlight_wielded() then
                if action_name == WEAPON_EXTRA_PRESSED and pressed then
                    mod:toggle_flashlight()
                    return self:get_default(action_name)
                end
                if action_name == WEAPON_EXTRA_HOLD then
                    return self:get_default(action_name)
                end
            end
        end
    end
    return pressed
end
  
-- Detach player movement from camera
mod:hook(CLASS.InputService, "_get", input_hook)

-- Detach simulated player movement from camera
mod:hook(CLASS.InputService, "_get_simulate", input_hook)