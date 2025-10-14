local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local ScriptWorld = mod:original_require("scripts/foundation/utilities/script_world")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local CLASS = CLASS
    local Viewport = Viewport
    local unit_alive = unit.alive
    local script_unit = ScriptUnit
    local unit_sight_callback = unit.sight_callback
    local script_unit_extension = script_unit.extension
--#endregion

mod:hook(CLASS.CameraManager, "post_update", function(func, self, dt, t, viewport_name, ...)
    -- Original function
    func(self, dt, t, viewport_name, ...)
    -- Get unit
    local camera_nodes = self._camera_nodes[viewport_name]
    local current_node = self:_current_node(camera_nodes)
    local root_unit = current_node:root_unit()
    if root_unit and unit_alive(root_unit) then
        local viewport = ScriptWorld.viewport(self._world, viewport_name)
        local camera_data = self._viewport_camera_data[viewport] or self._viewport_camera_data[Viewport.get_data(viewport, "overridden_viewport")]
        -- Sight update zoom callback
        if camera_data then unit_sight_callback(root_unit, "update_zoom", viewport_name, camera_data.vertical_fov, camera_data.custom_vertical_fov) end
    end
end)

mod:hook(CLASS.CameraManager, "shading_callback", function(func, self, world, shading_env, viewport, default_shading_environment_resource, ...)
    -- Original function
    func(self, world, shading_env, viewport, default_shading_environment_resource, ...)
    -- Camera data
    local camera_data = self._viewport_camera_data[viewport] or self._viewport_camera_data[Viewport.get_data(viewport, "overridden_viewport")]
    -- Extensions
    if self._world == world then
        -- Get unit
        local viewport_name = Viewport.get_data(viewport, "name")
        local camera_nodes = self._camera_nodes[viewport_name]
        local current_node = self:_current_node(camera_nodes)
        local root_unit = current_node:root_unit()
        -- Sight weapon dof callback
        unit_sight_callback(root_unit, "apply_weapon_dof", shading_env)
    end
end)
