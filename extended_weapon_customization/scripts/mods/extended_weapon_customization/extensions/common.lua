local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
--#region local functions
    local pairs = pairs
    local table = table
    local ipairs = ipairs
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
--#endregion
