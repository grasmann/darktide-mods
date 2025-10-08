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
        -- Sights
        local sight_extension = script_unit_extension(root_unit, "sight_system")
        if sight_extension and camera_data then
            sight_extension:update_zoom(viewport_name, camera_data.vertical_fov, camera_data.custom_vertical_fov)
        end
    end
end)
