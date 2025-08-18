local mod = get_mod("visible_equipment")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local UIProfileSpawner = mod:original_require("scripts/managers/ui/ui_profile_spawner")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local CLASS = CLASS
    local vector3 = Vector3
    local quaternion = Quaternion
    local vector3_from_array = vector3.from_array
    local unit_world_position = unit.world_position
    local unit_world_rotation = unit.world_rotation
    local quaternion_multiply = quaternion.multiply
    local quaternion_from_euler_angles_xyz = quaternion.from_euler_angles_xyz
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.PortraitUI, "load_profile_portrait", function(func, self, profile, on_load_callback, optional_render_context, prioritized, on_unload_callback, ...)

    -- self.custom_position = nil
    if optional_render_context and optional_render_context.placement and optional_render_context.placement_name then
        mod.next_ui_profile_spawner_placement_name[profile.character_id] = optional_render_context.placement_name
    end

    -- Original function
    return func(self, profile, on_load_callback, optional_render_context, prioritized, on_unload_callback, ...)
end)

mod:hook(CLASS.PortraitUI, "_spawn_profile", function(func, self, profile, render_context, ...)

    if render_context and render_context.placement and render_context.placement_name and render_context.unit_3p then
        if self._profile_spawner then
            self._profile_spawner:destroy()

            self._profile_spawner = nil
        end

        local world_spawner = self._world_spawner
        local world = world_spawner:world()
        local camera = world_spawner:camera()
        local unit_spawner = world_spawner:unit_spawner()
        local profile_spawner = UIProfileSpawner:new("PortraitUI", world, camera, unit_spawner, false)

        self._profile_spawner = profile_spawner

        local spawn_position = unit_world_position(self._spawn_point_unit, 1)
        local spawn_rotation = unit_world_rotation(self._spawn_point_unit, 1)
        local optional_state_machine = render_context and render_context.state_machine
        local optional_animation_event = render_context and render_context.animation_event
        local optional_face_animation_event = render_context and render_context.face_animation_event
        local optional_companion_state_machine = render_context and render_context.companion_state_machine
        local optional_companion_animation_event = render_context and render_context.companion_animation_event
        local ignore_companion = true

        if render_context and render_context.ignore_companion ~= nil then
            ignore_companion = render_context.ignore_companion
        end

        local force_highest_mip = false
        local disable_hair_state_machine = true
        local companion_data = {
            state_machine = optional_companion_state_machine,
            animation_event = optional_companion_animation_event,
            ignore = ignore_companion,
        }

        profile_spawner:spawn_profile(profile, spawn_position, spawn_rotation, nil, optional_state_machine, optional_animation_event, nil, optional_face_animation_event, false, disable_hair_state_machine, render_context.unit_3p, nil, companion_data)

        local archetype = profile.archetype
        local breed = archetype.breed
        local camera_settings = self._breed_camera_settings[breed]
        local camera_unit = camera_settings.camera_unit

        if render_context then
            local camera_focus_slot_name = render_context.camera_focus_slot_name

            if camera_focus_slot_name then
                local camera_settings_by_item_slot = camera_settings.camera_settings_by_item_slot
                local slot_camera_settings = camera_settings_by_item_slot[camera_focus_slot_name]

                if slot_camera_settings then
                    camera_settings = slot_camera_settings
                    camera_unit = slot_camera_settings.camera_unit
                end
            end
        end

        world_spawner:change_camera_unit(camera_unit)

        local camera_position = vector3_from_array(camera_settings.boxed_camera_start_position)
        local camera_rotation = camera_settings.boxed_camera_start_rotation:unbox()

        if render_context then
            local wield_slot = render_context.wield_slot

            if wield_slot then
                self._profile_spawner:wield_slot(wield_slot)
            end
        end

        local icon_camera_adjustment = profile.loadout.slot_animation_end_of_round

        if render_context and icon_camera_adjustment then
            local position_offset = icon_camera_adjustment.icon_render_camera_position_offset

            if position_offset then
                camera_position = vector3(camera_position.x + (position_offset[1] or 0), camera_position.y + (position_offset[2] or 0), camera_position.z + (position_offset[3] or 0))
            end

            local rotation_offset = icon_camera_adjustment.icon_render_camera_rotation_offset

            if rotation_offset then
                camera_rotation = quaternion_multiply(camera_rotation, quaternion_from_euler_angles_xyz(rotation_offset[1] or 0, rotation_offset[2] or 0, rotation_offset[3] or 0))
            end
        end

        world_spawner:set_camera_position(camera_position)
        world_spawner:set_camera_rotation(camera_rotation)

        return
    end

    -- Original function
    return func(self, profile, render_context, ...)

end)
