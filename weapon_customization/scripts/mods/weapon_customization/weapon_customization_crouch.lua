local mod = get_mod("weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local script_unit = ScriptUnit
    local Unit = Unit
    local unit_has_animation_event = Unit.has_animation_event
    local unit_animation_event = Unit.animation_event
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local CROUCH_OPTION = "mod_option_misc_cover_on_crouch"

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

local CrouchAnimationExtension = class("CrouchAnimationExtension")

CrouchAnimationExtension.init = function(self, extension_init_context, unit, extension_init_data)
    self.world = extension_init_context.world
    self.player = extension_init_data.player
    self.is_local_unit = extension_init_data.is_local_unit
    self.player_unit = self.player.player_unit
    local unit_data_extension = script_unit.extension(self.player_unit, "unit_data_system")
    self.movement_state_component = unit_data_extension:read_component("movement_state")
    local first_person_extension = script_unit.extension(self.player_unit, "first_person_system")
    self.first_person_unit = first_person_extension:first_person_unit()
end

CrouchAnimationExtension.update = function(self)
    if mod:get(CROUCH_OPTION) then
        if self.movement_state_component.is_crouching then
            if unit_has_animation_event(self.first_person_unit, "to_cover") and not self.is_crouched then
                mod:echo("crouch")
                unit_animation_event(self.first_person_unit, "to_cover")
                self.is_crouched = true
            end
        else
            if unit_has_animation_event(self.first_person_unit, "from_cover") and self.is_crouched then
                mod:echo("!crouch")
                unit_animation_event(self.first_person_unit, "from_cover")
                self.is_crouched = nil
            end
        end
    end
end

return CrouchAnimationExtension
