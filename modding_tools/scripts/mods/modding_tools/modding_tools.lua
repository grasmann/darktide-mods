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
    self:_add_unit_manipulation_extension(unit, camera, world, gui)
end

mod.unit_manipulation_remove = function(self, unit)
    self:_remove_unit_manipulation_extension(unit)
end

mod.unit_manipulation_remove_all = function(self)
    self:_remove_all_unit_manipulation_extensions()
end

mod.unit_manipulation_select = function(self, unit)
    self:_select_unit_manipulation_extension(unit)
end

mod.unit_manipulation_extensions = function(self)
    return self:persistent_table("modding_tools").unit_manipulation_extensions or {}
end

mod.unit_manipulation_busy = function(self, unit)
    return self:_unit_manipulation_extension_busy(unit)
end

mod.unit_manipulation_deselect = function(self)
    self:_deselect_all_unit_manipulation_extensions()
end

-- ##### ┬┌┐┌┌┬┐┌─┐┬─┐┌┐┌┌─┐┬   #######################################################################################
-- ##### ││││ │ ├┤ ├┬┘│││├─┤│   #######################################################################################
-- ##### ┴┘└┘ ┴ └─┘┴└─┘└┘┴ ┴┴─┘ #######################################################################################

mod._add_unit_manipulation_extension = function(self, unit, camera, world, gui)
    if unit and unit_alive(unit) and camera and world and gui then
        if not script_unit_has_extension(unit, "unit_manipulation_system") then
            local extension = script_unit_add_extension({
                world = world,
            }, unit, "UnitManipulationExtension", "unit_manipulation_system", {
                unit = unit, gui = gui, camera = camera,
            })
            self:unit_manipulation_extensions()[unit] = extension
        end
    end
end

mod._remove_all_unit_manipulation_extensions = function(self)
    for unit, _ in pairs(self:unit_manipulation_extensions()) do
        self:_remove_unit_manipulation_extension(unit)
    end
end

mod._remove_unit_manipulation_extension = function(self, unit)
    if unit and unit_alive(unit) then
        local unit_manipulation_extension = self:unit_manipulation_extensions()[unit]
        if unit_manipulation_extension then
            self:unit_manipulation_extensions()[unit] = nil
        end
        if script_unit_has_extension(unit, "unit_manipulation_system") then
            script_unit_remove_extension(unit, "unit_manipulation_system")
        end
    end
end

mod._unit_manipulation_extension_busy = function(self, unit)
    if unit and unit_alive(unit) then
        -- Specific
        local unit_manipulation_extension = self:unit_manipulation_extensions()[unit]
        if unit_manipulation_extension then
            return unit_manipulation_extension:is_busy()
        end
    else
        -- Any
        for _, unit_manipulation_extension in pairs(self:unit_manipulation_extensions()) do
            if unit_manipulation_extension:is_busy() then return true end
        end
    end
end

mod._deselect_all_unit_manipulation_extensions = function(self)
	for _, unit_manipulation_extension in pairs(self:unit_manipulation_extensions()) do
		unit_manipulation_extension:set_selected(false)
	end
end

mod._select_unit_manipulation_extension = function(self, unit)
	self:_deselect_all_unit_manipulation_extensions()
    local unit_manipulation_extension = self:unit_manipulation_extensions()[unit]
    if unit_manipulation_extension then
	    unit_manipulation_extension:set_selected(true)
    end
end

mod._update_unit_manipulation_extensions = function(self, dt, t, input_service)
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
    mod:_update_unit_manipulation_extensions(dt, t, input_service)
    -- Update console
	-- if mod.console then mod.console:update(dt, t, input_service) end
end)