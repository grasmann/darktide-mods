-- File: servo_friend/scripts/mods/servo_friend/player_extensions/player_unit_servo_friend_state.lua
local mod = get_mod("servo_friend")

local unit = Unit
local unit_world_position = unit.world_position
local unit_local_rotation = unit.local_rotation

local SPRINT = "sprint"

return function(Extension)
    -- ##### ┌─┐┬  ┌─┐┬ ┬┌─┐┬─┐ ###########################################################################################
    -- ##### ├─┘│  ├─┤└┬┘├┤ ├┬┘ ###########################################################################################
    -- ##### ┴  ┴─┘┴ ┴ ┴ └─┘┴└─ ###########################################################################################

    Extension.player_position = function(self)
        return unit_world_position(self.unit, 1)
    end

    Extension.player_rotation = function(self)
        return unit_local_rotation(self.first_person_unit, 1)
    end

    Extension.is_in_hub = function(self)
        return mod:is_in_hub()
    end

    Extension.is_crouching = function(self)
        return self.movement_state_component and self.movement_state_component.is_crouching
    end

    Extension.is_in_first_person = function(self)
        return self.first_person_extension and self.first_person_extension:is_in_first_person_mode()
    end

    Extension.is_blocking = function(self)
        return self.weapon_action_component and self.weapon_action_component.current_action_name == "action_block"
    end

    Extension.is_aiming = function(self)
        return (self.alternate_fire_component and self.alternate_fire_component.is_active) or
            (self.weapon_action_component and self.weapon_action_component.current_action_name == "action_charge")
    end

    Extension.is_venting = function(self)
        return self.weapon_action_component and self.weapon_action_component.current_action_name == "action_vent"
    end

    Extension.is_walking = function(self)
        return self.locomotion_extension and self.locomotion_extension:move_speed_squared() > 0.01 and
            not self:is_sprinting()
    end

    Extension.is_sprinting = function(self)
        local is_sprinting = self.sprint_character_state_component and self.sprint_character_state_component
            .is_sprinting

        return self:is_in_hub() and self.hub_jog_character_state and self.hub_jog_character_state.move_state == SPRINT or
            is_sprinting
    end

    Extension.has_found_something_valid = function(self)
        return self.found_something_valid
    end

    Extension.archetype_name = function(self)
        if self._archetype_name then
            return self._archetype_name
        end

        local unit_data = self.unit_data
        if unit_data and unit_data.archetype then
            local archetype = unit_data:archetype()
            self._archetype_name = archetype and archetype.name or nil
        end

        if not self._archetype_name and self.is_local_unit then
            self._archetype_name = mod:get_local_archetype()
        end

        return self._archetype_name
    end

    Extension.is_nuncio_aquila = function(self)
        return self.appearance == "nuncio_aquila"
    end

    -- ##### ┬ ┬┌─┐┬─┐┬  ┌┬┐ ##############################################################################################
    -- ##### ││││ │├┬┘│   ││ ##############################################################################################
    -- ##### └┴┘└─┘┴└─┴─┘─┴┘ ##############################################################################################

    Extension.world = function(self)
        return mod:world()
    end

    Extension.wwise_world = function(self)
        return mod:wwise_world()
    end

    Extension.physics_world = function(self)
        return mod:physics_world()
    end
end
