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
    local WEAPON_RELOAD_HOLD = "weapon_reload_hold"
    local WEAPON_RELOAD_PRESSED = "weapon_reload"
--#endregion

-- ##### ┬┌┐┌┌─┐┬ ┬┌┬┐ ################################################################################################
-- ##### ││││├─┘│ │ │  ################################################################################################
-- ##### ┴┘└┘┴  └─┘ ┴  ################################################################################################

-- local test = true
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

-- mod:hook(CLASS.InputService, "update", function(func, self, dt, t, ...)
--     -- Original function
--     func(self, dt, t, ...)
--     -- Detach scope
--     if mod:is_scope_used() and mod:can_detach_scope() then
--         if self._actions[WEAPON_RELOAD_HOLD] and self:get(WEAPON_RELOAD_HOLD) then

--             if not self.reload_holding and self.reload_hold_timer and self.reload_hold_timer < t then

--                 self.reload_holding = true

--                 self.scope_detached = not self.scope_detached
--                 mod:execute_extension(mod.player_unit, "sight_system", "on_detach_scope")

--             elseif not self.reload_hold_timer then

--                 self.reload_hold_timer = t + 1

--             end

--         elseif self._actions[WEAPON_RELOAD_HOLD] and not self:get(WEAPON_RELOAD_HOLD) then

--             self.reload_holding = false
--             self.reload_hold_timer = nil

--         end
--     end
-- end)

-- local test = true
-- mod:hook(CLASS.InputService, "init", function(func, self, type, mappings, filter_mappings, aliases, ...)
--     -- Original function
--     func(self, type, mappings, filter_mappings, aliases, ...)

--     if test then

--         mod:dtf(self._mappings, "mappings", 10)

--         test = false
--     end
    
--     -- Initialize
--     -- if not self._actions[WEAPON_RELOAD_HOLD] then
--     --     self._actions[WEAPON_RELOAD_HOLD] = {
--     --         type = "held",
--     --         callbacks = {},
--     --         default_func = function(input_service)
--     --             return false
--     --         end
--     --     }
--     -- end
-- end)