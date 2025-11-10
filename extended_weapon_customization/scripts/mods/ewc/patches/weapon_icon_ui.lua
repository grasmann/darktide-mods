local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local light = Light
    local CLASS = CLASS
    local pairs = pairs
    local level = Level
    local tostring = tostring
    local unit_light = unit.light
    local level_units = level.units
    local unit_num_lights = unit.num_lights
    local light_set_intensity = light.set_intensity
    local light_set_ies_profile = light.set_ies_profile
    local light_set_falloff_end = light.set_falloff_end
    local light_set_falloff_start = light.set_falloff_start
    local light_set_spot_angle_end = light.set_spot_angle_end
    local light_set_spot_angle_start = light.set_spot_angle_start
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

-- Update all requests that contain gear id
local update_requests = function(weapon_icon_ui, request_id, item, prioritized)
    if item and request_id then
        for size_key, requests in pairs(weapon_icon_ui._requests_by_size) do
            for _, request in pairs(requests) do
                local combined_id = tostring(request_id).."_"..tostring(size_key)
                if request.id == request_id or request.id == combined_id then
                    weapon_icon_ui:_update_request(request, item, prioritized)
                end
            end
        end
    end
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.WeaponIconUI, "_spawn_weapon", function(func, self, item, render_context, ...)
    -- Original function
    func(self, item, render_context, ...)
    -- Update lights
    if self._world_spawner and self._world_spawner._level then
        local level_units = level_units(self._world_spawner._level, true)
        if level_units then
            for _, unit in pairs(level_units) do
                local num_lights = unit_num_lights(unit)
                for i = 1, num_lights do
                    local light = unit_light(unit, i)
                    light_set_ies_profile(light, "content/environment/ies_profiles/narrow/narrow_04")
                    light_set_spot_angle_start(light, 0)
                    light_set_spot_angle_end(light, 3)
                    light_set_intensity(light, 8)
                    light_set_falloff_start(light, 0)
                    light_set_falloff_end(light, 500)
                end
            end
        end
    end
end)

mod:hook(CLASS.WeaponIconUI, "weapon_icon_updated", function(func, self, item, prioritized, ...)
    local request_id = item.gear_id or item.name
    update_requests(self, request_id, item, prioritized)
end)

mod:hook(CLASS.WeaponIconUI, "load_weapon_icon", function(func, self, item, on_load_callback, optional_render_context, prioritized, on_unload_callback, ...)
    -- Modify item
    mod:modify_item(item)
    -- Fixes
    mod:apply_attachment_fixes(item)
    -- Original function
    return func(self, item, on_load_callback, optional_render_context, prioritized, on_unload_callback, ...)
end)
