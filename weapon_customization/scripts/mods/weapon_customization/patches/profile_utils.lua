local mod = get_mod("weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local CLASS = CLASS
--#endregion

mod:hook_require("scripts/utilities/profile_utils", function(instance)

    mod:hook(instance, "character_to_profile", function(func, character, gear_list, progression)
        local profile = func(character, gear_list, progression)
        mod:echo("character_to_profile")
        return profile
    end)

    mod:hook(instance, "backend_profile_data_to_profile", function(func, backend_profile_data)
        local profile = func(backend_profile_data)
        mod:echo("backend_profile_data_to_profile")
        return profile
    end)

    mod:hook(instance, "unpack_profile", function(func, profile_json)
        local profile = func(profile_json)
        mod:echo("unpack_profile")
        return profile
    end)

end)