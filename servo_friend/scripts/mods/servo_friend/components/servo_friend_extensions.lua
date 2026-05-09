local mod = get_mod("servo_friend")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local table = table
local table_size = table.size
local script_unit = ScriptUnit
local script_unit_extension = script_unit.extension
local script_unit_has_extension = script_unit.has_extension

-- ##### ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌┌─┐ ############################################
-- ##### └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││└─┐ ############################################
-- ##### └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘└─┘ ############################################

-- Get servo_friend extension from unit
mod.servo_friend_extension = function(self, unit, system_or_extension)
    if not self:is_unit_alive(unit) then
        return nil
    end

    local pt = self:pt()
    local system = pt.systems[system_or_extension] or system_or_extension

    if not system then
        return nil
    end

    return script_unit_has_extension(unit, system)
end

-- Add servo_friend extension to unit
mod.servo_friend_add_extension = function(self, unit, system, extension_init_context, extension_init_data)
    if not self:is_unit_alive(unit) or not system then
        return nil
    end

    if self:add_extension(unit, system, extension_init_context, extension_init_data) then
        local pt = self:pt()
        local extension = script_unit_extension(unit, system)

        if not extension then
            return nil
        end

        if not pt.loaded_extensions[unit] then
            pt.loaded_extensions[unit] = {}
        end

        pt.loaded_extensions[unit][system] = extension

        return extension
    end
end

-- Remove servo_friend extension from unit
mod.servo_friend_remove_extension = function(self, unit, system)
    local pt = self:pt()
    local removed = false

    if self:is_unit_alive(unit) and system then
        removed = self:remove_extension(unit, system) and true or false
    end

    if pt.loaded_extensions[unit] then
        if system then
            pt.loaded_extensions[unit][system] = nil
        end

        if table_size(pt.loaded_extensions[unit]) == 0 then
            pt.loaded_extensions[unit] = nil
        end
    end

    return removed
end
