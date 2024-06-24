local mod = get_mod("modding_tools")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    mod:io_dofile("modding_tools/scripts/mods/modding_tools/extensions/unit_manipulation_extension")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
    local Unit = Unit
    local pairs = pairs
    local unit_alive = Unit.alive
    local script_unit = ScriptUnit
    local script_unit_extension = script_unit.extension
    local script_unit_has_extension = script_unit.has_extension
    local script_unit_add_extension = script_unit.add_extension
    local script_unit_remove_extension = script_unit.remove_extension
--#endregion

-- ##### ┬┌┐┌┌┬┐┌─┐┬─┐┌─┐┌─┐┌─┐┌─┐ ####################################################################################
-- ##### ││││ │ ├┤ ├┬┘├┤ ├─┤│  ├┤  ####################################################################################
-- ##### ┴┘└┘ ┴ └─┘┴└─└  ┴ ┴└─┘└─┘ ####################################################################################

-- Create
mod.unit_manipulation_add = function(self, data)
    return self:_add_unit_manipulation_extension(data)
end

-- Destroy
mod.unit_manipulation_remove = function(self, unit)
    self:_remove_unit_manipulation_extension(unit)
end
mod.unit_manipulation_remove_all = function(self)
    self:_remove_all_unit_manipulation_extensions()
end

-- Function
mod.unit_manipulation_busy = function(self, unit)
    return self:_unit_manipulation_extension_busy(unit)
end

mod.unit_manipulation_select = function(self, unit)
    self:_select_unit_manipulation_extension(unit)
end
mod.unit_manipulation_deselect = function(self)
    self:_deselect_all_unit_manipulation_extensions()
end

-- Extensions
mod.unit_manipulation_extensions = function(self)
    return self:persistent_table("modding_tools").unit_manipulation.extensions
end
mod.unit_manipulation_remove_extension = function(self, extension)
    self:_remove_unit_manipulation_extension(extension.unit)
end

-- ##### ┬┌┐┌┌┬┐┌─┐┬─┐┌─┐┌─┐┌─┐┌─┐ ####################################################################################
-- ##### ││││ │ ├┤ ├┬┘├┤ ├─┤│  ├┤  ####################################################################################
-- ##### ┴┘└┘ ┴ └─┘┴└─└  ┴ ┴└─┘└─┘ ####################################################################################

mod._add_unit_manipulation_extension = function(self, data)
    if data.unit and unit_alive(data.unit) and data.camera and data.world and data.gui then
        if not script_unit_has_extension(data.unit, "unit_manipulation_system") then
            local extension = script_unit_add_extension({
                world = data.world,
            }, data.unit, "UnitManipulationExtension", "unit_manipulation_system", data)
            self:unit_manipulation_extensions()[data.unit] = extension
            return extension
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