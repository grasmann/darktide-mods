local mod = get_mod("visible_equipment")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local CLASS = CLASS
    local table = table
    local table_find = table.find
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook_require("scripts/utilities/material_fx", function(instance)

    mod:hook(instance, "trigger_material_fx", function(func, unit, world, wwise_world, physics_world, sound_alias, source_id, query_from, query_to, optional_set_speed_parameter, optional_set_first_person_parameter, use_cached_material_hit, ...)
        -- Get equipment component
        local equipment_component = table_find(mod:pt().equipment_components, unit)
        if equipment_component then
            equipment_component:footstep()
        end
        -- Original function
        func(unit, world, wwise_world, physics_world, sound_alias, source_id, query_from, query_to, optional_set_speed_parameter, optional_set_first_person_parameter, use_cached_material_hit, ...)
    end)

    -- Execute first person footsteps instead of third person
    mod:hook(instance, "update_1p_footsteps", function(func, t, footstep_time, right_foot_next, previous_frame_character_state_name, is_in_first_person_mode, context, ...)
        -- Set first person true
        is_in_first_person_mode = true
        -- Original function
        return func(t, footstep_time, right_foot_next, previous_frame_character_state_name, is_in_first_person_mode, context, ...)
    end)

    -- Don't execute games default third person footsteps
    mod:hook(instance, "update_3p_footsteps", function(func, previous_frame_character_state_name, is_in_first_person_mode, context, ...)
        return
    end)

end)
