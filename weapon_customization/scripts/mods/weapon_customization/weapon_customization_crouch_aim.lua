local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local Crouch = mod:original_require("scripts/extension_systems/character_state_machine/character_states/utilities/crouch")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local managers = Managers
    local script_unit = ScriptUnit
    local Unit = Unit
    local unit_has_animation_event = Unit.has_animation_event
    local unit_animation_event = Unit.animation_event
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local CROUCH_OPTION = "mod_option_misc_cover_on_crouch"
local REFERENCE = "weapon_customization"
local CROUCH_AIM_TIME = .3
local CROUCH_AIM_HOLD_TIME = 1.4

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.crouch_aim_exit = function(self)

end

mod.crouch_aim_enter = function(self)

end

mod.update_crouch_aim = function(self)
    if self.initialized and self:get(CROUCH_OPTION) then
        local t = managers.time:time("main")
        -- local movement_state_component = self._movement_state_component
        local unit_data_extension = script_unit.has_extension(self.player_unit, "unit_data_system")
        local movement_state = unit_data_extension and unit_data_extension:read_component("movement_state")
        local is_crouching = movement_state and movement_state.is_crouching
        local first_person_unit = self.first_person_unit
        if is_crouching then
            self.crouch_aim_timer = self.crouch_aim_timer or t - 1

            if t >= self.crouch_aim_timer then
                if unit_has_animation_event(first_person_unit, "slide_in") and not self.crouch_aiming then
                    unit_animation_event(first_person_unit, "slide_in")
                    self.crouch_aiming = true
                    self.crouch_aim_timer = t + CROUCH_AIM_TIME
                else --if not self.crouch_aim_state then --if unit_has_animation_event(first_person_unit, "slide_out") then
                    -- unit_animation_event(first_person_unit, "slide_in")
                    -- unit_animation_event(first_person_unit, "slide_out")
                    if self.crouch_aim_state then
                        Unit.animation_set_state(first_person_unit, unpack(self.crouch_aim_state))
                    end
                    self.crouch_aim_timer = t + CROUCH_AIM_HOLD_TIME
                    self.crouch_aim_state = Unit.animation_get_state(first_person_unit)
                -- else
                --     self.crouch_aim_timer = t + CROUCH_AIM_HOLD_TIME
                --     Unit.animation_set_state(first_person_unit, unpack(self.crouch_aim_state))
                end
            end
        else
            if unit_has_animation_event(first_person_unit, "slide_out") and self.crouch_aiming then
                unit_animation_event(first_person_unit, "slide_out")
                self.crouch_aiming = nil
                -- self.was_crouch_aiming = nil
                self.crouch_aim_state = nil
                self.crouch_aim_timer = nil
            end
        end
    end
end