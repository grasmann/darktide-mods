local mod = get_mod("weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
	local type = type
	local DMFMod = DMFMod
	local vector3 = Vector3
	local tostring = tostring
	local managers = Managers
	local Localize = Localize
    local string_upper = string.upper
	local quaternion_to_euler_angles_xyz = Quaternion.to_euler_angles_xyz
	local quaternion_from_euler_angles_xyz = Quaternion.from_euler_angles_xyz
--#endregion

--#region String
	string._trim = function(s)
		return (s:gsub("^%s*(.-)%s*$", "%1"))
	end
	string.cap = function(str)
		return (str:gsub("^%l", string_upper))
	end
--#endregion

--#region Quaternion
	Quaternion.to_vector = function(quaternion)
		local x, y, z = quaternion_to_euler_angles_xyz(quaternion)
		return vector3(x, y, z)
	end
	Quaternion.from_vector = function(vector)
		return quaternion_from_euler_angles_xyz(vector[1], vector[2], vector[3])
	end
--#endregion

function DMFMod:localize_or_global(string_id)
	local localized_string = self:localize(string_id)
	if localized_string == "<"..tostring(string_id)..">" then localized_string = Localize(string_id) end
	return localized_string
end