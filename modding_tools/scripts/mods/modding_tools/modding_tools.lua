local mod = get_mod("modding_tools")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
    local Unit = Unit
    local CLASS = CLASS
    local pairs = pairs
    local unit_alive = Unit.alive
    local script_unit = ScriptUnit
    local script_unit_extension = script_unit.extension
    local script_unit_has_extension = script_unit.has_extension
	local script_unit_add_extension = script_unit.add_extension
    local script_unit_remove_extension = script_unit.remove_extension
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    mod:persistent_table("modding_tools", {
        -- Flashlight
        unit_manipulation_extensions = {},
    })
--#endregion

-- ##### ┬ ┬┌┐┌┬┌┬┐  ┌┬┐┌─┐┌┐┌┬┌─┐┬ ┬┬  ┌─┐┌┬┐┬┌─┐┌┐┌  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ #####################################
-- ##### │ │││││ │   │││├─┤││││├─┘│ ││  ├─┤ │ ││ ││││  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ #####################################
-- ##### └─┘┘└┘┴ ┴   ┴ ┴┴ ┴┘└┘┴┴  └─┘┴─┘┴ ┴ ┴ ┴└─┘┘└┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ #####################################

mod:io_dofile("modding_tools/scripts/mods/modding_tools/unit_manipulation_extension")

mod.unit_manipulation_add = function(self, unit, camera, world, gui)
    if unit and unit_alive(unit) and camera and world and gui then
        if not script_unit_has_extension(unit, "unit_manipulation_system") then
            script_unit_add_extension({
                world = world,
            }, unit, "UnitManipulationExtension", "unit_manipulation_system", {
                unit = unit, gui = gui, camera = camera,
            })
        end
    end
end

mod.unit_manipulation_remove = function(self, unit)
    if unit and unit_alive(unit) then
        if script_unit_has_extension(unit, "unit_manipulation_system") then
            script_unit_remove_extension(unit, "unit_manipulation_system")
        end
    end
end

mod.unit_manipulation_extensions = function(self)
    return self:persistent_table("modding_tools").unit_manipulation_extensions
end

mod.add_unit_manipulation_extension = function(self, extension)
	self:unit_manipulation_extensions()[extension.unit] = extension
end

mod.remove_unit_manipulation_extension = function(self, extension)
	self:unit_manipulation_extensions()[extension.unit] = nil
end

mod.any_unit_manipulation_extension_busy = function(self)
	for _, unit_manipulation_extension in pairs(self:unit_manipulation_extensions()) do
		if unit_manipulation_extension:is_busy() then return true end
	end
end

mod.deselect_all_unit_manipulation_extensions = function(self)
	for _, unit_manipulation_extension in pairs(self:unit_manipulation_extensions()) do
		unit_manipulation_extension:set_selected(false)
	end
end

mod.select_unit_manipulation_extension = function(self, unit)
	self:deselect_all_unit_manipulation_extensions()
	self:unit_manipulation_extensions()[unit]:set_selected(true)
end

mod.update_unit_manipulation_extensions = function(self, dt, t, input_service)
    for _, unit_manipulation_extension in pairs(self:unit_manipulation_extensions()) do
        unit_manipulation_extension:update(dt, t, input_service)
    end
end

-- ##### ┌─┐┌─┐┌┬┐┌┬┐┌─┐┌┐┌ ###########################################################################################
-- ##### │  │ ││││││││ ││││ ###########################################################################################
-- ##### └─┘└─┘┴ ┴┴ ┴└─┘┘└┘ ###########################################################################################

-- Main update loop
mod:hook(CLASS.UIManager, "update", function(func, self, dt, t, ...)
    -- Original function
    func(self, dt, t, ...)
    
    local input_service = self:input_service()
    -- Update unit manipulation extensions
    mod:update_unit_manipulation_extensions(dt, t, input_service)
    -- Update console
	-- if mod.console then mod.console:update(dt, t, input_service) end
end)