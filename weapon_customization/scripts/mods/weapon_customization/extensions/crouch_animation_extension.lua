local mod = get_mod("weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local class = class
    local Unit = Unit
    local unit_has_animation_event = Unit.has_animation_event
    local unit_animation_event = Unit.animation_event
    local table = table
    local table_contains = table.contains
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local CROUCH_OPTION = "mod_option_misc_cover_on_crouch"
local IGNORE_STATES = {"sliding", "dodging", "ledge_vaulting"}

-- ##### ┌─┐┬─┐┌─┐┬ ┬┌─┐┬ ┬  ┌─┐┌┐┌┬┌┬┐┌─┐┌┬┐┬┌─┐┌┐┌  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ######################################
-- ##### │  ├┬┘│ ││ ││  ├─┤  ├─┤│││││││├─┤ │ ││ ││││  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ######################################
-- ##### └─┘┴└─└─┘└─┘└─┘┴ ┴  ┴ ┴┘└┘┴┴ ┴┴ ┴ ┴ ┴└─┘┘└┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ######################################

local CrouchAnimationExtension = class("CrouchAnimationExtension", "WeaponCustomizationExtension")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

-- Initialize
CrouchAnimationExtension.init = function(self, extension_init_context, unit, extension_init_data)
    CrouchAnimationExtension.super.init(self, extension_init_context, unit, extension_init_data)
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

-- Update character state to check for ignore states
CrouchAnimationExtension.update_character_state = function(self)
    self.character_state = self.character_state_extension:current_state()
end

-- Update
CrouchAnimationExtension.update = function(self)
    if mod:get(CROUCH_OPTION) then
        if self.movement_state_component.is_crouching and not table_contains(IGNORE_STATES, self.character_state) then
            if unit_has_animation_event(self.first_person_unit, "to_cover") and not self.is_crouched then
                unit_animation_event(self.first_person_unit, "to_cover")
                self.is_crouched = true
            end
        else
            if unit_has_animation_event(self.first_person_unit, "from_cover") and self.is_crouched then
                unit_animation_event(self.first_person_unit, "from_cover")
                self.is_crouched = nil
            end
        end
    end
end

return CrouchAnimationExtension
