local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local CLASS = CLASS
    local unit_alive = unit.alive
    local script_unit = ScriptUnit
    local script_unit_extension = script_unit.extension
--#endregion

-- ##### ┬┌┐┌┌─┐┬ ┬┌┬┐ ################################################################################################
-- ##### ││││├─┘│ │ │  ################################################################################################
-- ##### ┴┘└┘┴  └─┘ ┴  ################################################################################################

local interact_pressed = "interact_pressed"
local pressed_once_timeout = .5
local pressed_twice_cooldown = .15

mod.pressed = nil
mod.pressed_once_t = nil
mod.pressed_twice = nil
mod.pressed_twice_t = nil
mod.custom_twice_cooldown = nil

mod:hook(CLASS.InputService, "update", function(func, self, dt, t, ...)

    -- Has been pressed twice and cooldown is running?
    if mod.pressed_twice_t then

        -- Wait for cooldown to be over
        -- Use custom cooldown if set
        if  t > mod.pressed_twice_t + (mod.custom_twice_cooldown or pressed_twice_cooldown) then
            -- Unset pressed twice
            mod.pressed_twice_t = nil
            mod.custom_twice_cooldown = nil
        end

    -- Has been pressed twice?
    elseif mod.pressed_twice then

        -- Set pressed twice
        mod.pressed_twice_t = t
        mod.pressed_twice = nil

    else
        -- Unset custom pressed twice cooldown
        mod.custom_twice_cooldown = nil

        -- Has been pressed once and timeout is running?
        if mod.pressed_once_t then

            -- Wait for timeout end.
            if t > mod.pressed_once_t + pressed_once_timeout then
                -- Unset pressed once
                mod.pressed_once_t = nil
            end

        -- Has been pressed once?
        elseif mod.pressed then

            -- Set pressed once
            mod.pressed_once_t = t
            mod.pressed = nil

        end
    end
    -- Original function
    func(self, dt, t, ...)
end)

-- local test = true
local input_hook = function(func, self, action_name, ...)
    -- Oiriginal function
    local action_result = func(self, action_name, ...)
    local action_pressed = action_name == interact_pressed
    if action_pressed and action_result and not mod.pressed_twice_t then

        -- Get player unit
        local player_unit = mod:me()
        -- Check player unit
        if player_unit and unit_alive(player_unit) then

            -- Get flashlight extension
            local flashlight_extension = script_unit_extension(player_unit, "flashlight_system")
            -- Check flashlight extension
            if flashlight_extension and flashlight_extension:is_modded() and flashlight_extension:is_wielded() then

                local interact_aim, interact_aim_double = flashlight_extension:input_settings()
                local aiming = flashlight_extension.alternate_fire_component.is_active

                -- Process if aiming or has been pressed previously
                if (interact_aim and aiming) or (interact_aim_double and mod.pressed_once_t and not aiming) then
                    flashlight_extension:set_light()

                    -- Has been pressed previously?
                    if mod.pressed_once_t then
                        -- Set pressed twice
                        mod.pressed_twice = true
                    end

                    -- Unset pressed previously
                    mod.pressed_once_t = nil

                else

                    -- Set pressed
                    mod.pressed = true

                end

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
