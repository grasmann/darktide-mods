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

-- Get servo friend extension from unit
mod.servo_friend_extension = function(self, unit, system_or_extension)
    local pt = self:pt()
    -- Wrap to system
    local system = pt.systems[system_or_extension] or system_or_extension
    -- Get and return extension
    return script_unit_has_extension(unit, system)
end

-- Add servo friend extension to unit
mod.servo_friend_add_extension = function(self, unit, system, extension_init_context, extension_init_data)
    -- Add extension to unit and check if successful
    if self:add_extension(unit, system, extension_init_context, extension_init_data) then
        local pt = self:pt()
        -- Get extension
        local extension = script_unit_extension(unit, system)
        -- Add unit to loaded extensions
        if not pt.loaded_extensions[unit] then pt.loaded_extensions[unit] = {} end
        -- Add extension to loaded extensions
        pt.loaded_extensions[unit][system] = extension
        -- Return extension
        return extension
    end
end

-- Remove servo friend extension from unit
mod.servo_friend_remove_extension = function(self, unit, system)
    -- Remove extension from unit and check if successful
    if self:remove_extension(unit, system) then
        local pt = self:pt()
        -- Remove extension from loaded extensions
        if pt.loaded_extensions[unit] then
            pt.loaded_extensions[unit][system] = nil
        end
        -- Remove unit from loaded extensions
        if table_size(pt.loaded_extensions[unit]) == 0 then pt.loaded_extensions[unit] = nil end
        return true
    end
end