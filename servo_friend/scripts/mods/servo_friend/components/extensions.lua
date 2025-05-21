local mod = get_mod("servo_friend")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local script_unit = ScriptUnit
local script_unit_has_extension = script_unit.has_extension
local script_unit_extension = script_unit.extension
local script_unit_add_extension = script_unit.add_extension
local script_unit_remove_extension = script_unit.remove_extension

-- ##### ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌┌─┐ ################################################################################
-- ##### ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││└─┐ ################################################################################
-- ##### └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘└─┘ ################################################################################

-- Check if extension is valid
mod.extension_valid = function(self, extension)
    -- Check if extension is valid and not deleted
    if extension and not extension.__deleted then
        -- Return extension
        return extension
    end
end

-- Register servo friend extension
mod.register_extension = function(self, extension, system)
    local pt = self:pt()
    -- Add extension
    pt.extensions[system] = extension
    pt.systems[extension] = system
end

-- Add extension to unit
mod.add_extension = function(self, unit, system, extension_init_context, extension_init_data)
    local pt = self:pt()
    -- Get extension name
    local extension = pt.extensions[system]
    -- Check if extension is valid and unit does not already have extension
    if extension and not script_unit_has_extension(unit, system) then
        -- Add extension to unit and return
        return script_unit_add_extension(extension_init_context, unit, extension, system, extension_init_data)
    end
end

-- Remove extension from unit
mod.remove_extension = function(self, unit, system)
    -- Check if unit has extension
    if script_unit_has_extension(unit, system) then
        -- Remove extension
		return script_unit_remove_extension(unit, system)
	end
end

-- Execute function in extension
mod.execute_extension = function(self, unit, system, function_name, ...)
    -- Get extension from unit
    local extension = script_unit_has_extension(unit, system)
    if self:extension_valid(extension) then
        -- local extension = script_unit_extension(unit, system)
        -- Check if extension has function
        if extension[function_name] then
            -- Execute function in extension and return
            return extension[function_name](extension, ...)
        end
    end
end