local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
--#region local functions
    local type = type
    local pairs = pairs
    local table = table
    local ipairs = ipairs
    local select = select
	local vector3 = Vector3
    local quaternion = Quaternion
    local table_clone = table.clone
    local table_clone_instance = table.clone_instance
	local quaternion_to_euler_angles_xyz = quaternion.to_euler_angles_xyz
	local quaternion_from_euler_angles_xyz = quaternion.from_euler_angles_xyz
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
