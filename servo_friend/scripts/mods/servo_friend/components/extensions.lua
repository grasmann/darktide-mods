local mod = get_mod("servo_friend")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local type = type
local script_unit = ScriptUnit
local script_unit_has_extension = script_unit.has_extension
local script_unit_add_extension = script_unit.add_extension
local script_unit_remove_extension = script_unit.remove_extension

-- ##### ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌┌─┐ ################################################################################
-- ##### ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││└─┐ ################################################################################
-- ##### └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘└─┘ ################################################################################

-- Check if extension is valid
mod.extension_valid = function(self, extension)
    if extension and not extension.__deleted then
        return extension
    end
end

-- Register servo_friend extension
mod.register_extension = function(self, extension, system)
    if not extension or not system then
        return
    end

    local pt = self:pt()
    pt.extensions[system] = extension
    pt.systems[extension] = system
end

-- Add extension to unit
mod.add_extension = function(self, unit, system, extension_init_context, extension_init_data)
    if not self:is_unit_alive(unit) or not system then
        return nil
    end

    local pt = self:pt()
    local extension = pt.extensions[system]

    if extension and not script_unit_has_extension(unit, system) then
        return script_unit_add_extension(extension_init_context, unit, extension, system, extension_init_data)
    end
end

-- Remove extension from unit
mod.remove_extension = function(self, unit, system)
    if not self:is_unit_alive(unit) or not system then
        return nil
    end

    if script_unit_has_extension(unit, system) then
        return script_unit_remove_extension(unit, system)
    end
end

-- Execute function in extension
mod.execute_extension = function(self, unit, system, function_name, ...)
    if not self:is_unit_alive(unit) or not system or not function_name then
        return nil
    end

    local extension = script_unit_has_extension(unit, system)

    if self:extension_valid(extension) and type(extension[function_name]) == "function" then
        return extension[function_name](extension, ...)
    end
end
