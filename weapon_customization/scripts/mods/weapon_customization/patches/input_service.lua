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

--#region Data
    local REFERENCE = "weapon_customization"
    local WEAPON_EXTRA_HOLD = "weapon_extra_hold"
    local WEAPON_EXTRA_PRESSED = "weapon_extra_pressed"
--#endregion

-- ##### ┬┌┐┌┌─┐┬ ┬┌┬┐ ################################################################################################
-- ##### ││││├─┘│ │ │  ################################################################################################
-- ##### ┴┘└┘┴  └─┘ ┴  ################################################################################################

local input_hook = function(func, self, action_name, ...)
    -- Oiriginal function
    local action_result = func(self, action_name, ...)
    if mod.initialized then
        local action_pressed = action_name == WEAPON_EXTRA_PRESSED
        local action_hold = action_name == WEAPON_EXTRA_HOLD
        if action_pressed or action_hold then
            if mod:is_flashlight_modded() then
                if mod:is_flashlight_wielded() then
                    if action_pressed and action_result then
                        mod:toggle_flashlight()
                        return self:get_default(action_name)
                    elseif action_hold then
                        return self:get_default(action_name)
                    end
                end
            elseif action_pressed and action_result then
                mod:toggle_flashlight()
            end
        end
    end
    -- Return
    return action_result
end
  
-- Input hook 
mod:hook(CLASS.InputService, "_get", input_hook)

-- Input hook for simulate
mod:hook(CLASS.InputService, "_get_simulate", input_hook)