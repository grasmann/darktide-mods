local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
--#region local functions
    local unit = Unit
    local type = type
    local pairs = pairs
    local table = table
    local ipairs = ipairs
    local select = select
	local vector3 = Vector3
    local unit_alive = unit.alive
    local quaternion = Quaternion
    local script_unit = ScriptUnit
    local table_clone = table.clone
    local table_clone_instance = table.clone_instance
    local script_unit_extension = script_unit.extension
	local quaternion_to_euler_angles_xyz = quaternion.to_euler_angles_xyz
	local quaternion_from_euler_angles_xyz = quaternion.from_euler_angles_xyz
--#endregion

--#region Unit
    unit.extension_callback = function(player_unit, system_name, function_name, ...)
        local callback_extension = player_unit and unit_alive(player_unit) and script_unit_extension(player_unit, system_name)
        if callback_extension and callback_extension[function_name] then
            return callback_extension[function_name](callback_extension, ...)
        end
	end
	unit.attachment_callback = function(player_unit, function_name, ...) return unit.extension_callback(player_unit, "attachment_callback_system", function_name, ...) end
    unit.sight_callback = function(player_unit, function_name, ...) return unit.extension_callback(player_unit, "sight_system", function_name, ...) end
    unit.shield_callback = function(player_unit, function_name, ...) return unit.extension_callback(player_unit, "shield_transparency_system", function_name, ...) end
    unit.damage_type_callback = function(player_unit, function_name, ...) return unit.extension_callback(player_unit, "damage_type_system", function_name, ...) end
    unit.sway_callback = function(player_unit, function_name, ...) return unit.extension_callback(player_unit, "sway_system", function_name, ...) end
    unit.flashlight_callback = function(player_unit, function_name, ...) return unit.extension_callback(player_unit, "flashlight_system", function_name, ...) end
    unit.callback = function(player_unit, function_name, ...)
        unit.attachment_callback(player_unit, function_name, ...)
        unit.sight_callback(player_unit, function_name, ...)
        unit.shield_callback(player_unit, function_name, ...)
        unit.damage_type_callback(player_unit, function_name, ...)
        unit.sway_callback(player_unit, function_name, ...)
        unit.flashlight_callback(player_unit, function_name, ...)
    end
--#endregion

--#region Quaternion
	quaternion.to_vector = function(quaternion)
		local x, y, z = quaternion_to_euler_angles_xyz(quaternion)
		return vector3(x, y, z)
	end
	quaternion.from_vector = function(vector)
		return quaternion_from_euler_angles_xyz(vector[1], vector[2], vector[3])
	end
--#endregion

--#region Table
    table.combine = function(...)
        local arg = {...}
        local combined = {}
        for _, t in ipairs(arg) do
            for name, value in pairs(t) do
                combined[name] = value
            end
        end
        return combined
    end
    table.icombine = function(...)
        local arg = {...}
        local combined = {}
        for _, t in ipairs(arg) do
            for _, value in pairs(t) do
                combined[#combined+1] = value
            end
        end
        return combined
    end
    table.clone_safe = function(t)
        return t and table_clone(t)
    end
    table.clone_instance_safe = function(t)
        return t and table_clone_instance(t)
    end
    table.merge_recursive_n = function (dest, ...)
        local dest = dest or {}
        local num_args = select('#', ...)
        local arg = {...}
        for i = 1, num_args do
            local source = arg[i]
            for key, value in pairs(source) do
                local is_table = type(value) == "table"
                if value == source then
                    dest[key] = dest
                elseif is_table and type(dest[key]) == "table" then
                    table.merge_recursive_n(dest[key], value)
                elseif is_table then
                    dest[key] = table.clone(value)
                else
                    dest[key] = value
                end
            end
        end
        return dest
    end
--#endregion
