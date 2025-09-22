local mod = get_mod("visible_equipment")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local table = table
    local vector3 = Vector3
    local vector3_box = Vector3Box
    local vector3_zero = vector3.zero
    local table_clone_safe = table.clone_safe
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local WEAPON_RANGED = "WEAPON_RANGED"
local WEAPON_MELEE = "WEAPON_MELEE"
local BREED_HUMAN = "human"
local BREED_OGRYN = "ogryn"

local placement_camera = {
    [BREED_HUMAN] = {
        default = {
            [WEAPON_RANGED] = {
                position = vector3_box(-1.1683889865875244, 2.639409065246582, 1.6318360567092896),
                rotation = 2.5,
            },
            [WEAPON_MELEE] = {
                position = vector3_box(-1.3683889865875244, 2.639409065246582, 1.6318360567092896),
                rotation = 4.5,
            },
        },
        POCKETABLE_SMALL = {
            position = vector3_box(-1.2683889865875244, 2.639409065246582, 1.6318360567092896),
            rotation = 3.5,
        },
        POCKETABLE = {
            position = vector3_box(-1.2683889865875244, 2.639409065246582, 1.6318360567092896),
            rotation = 3.5,
        },
        leg_left = {
            position = vector3_box(-1.1683889865875244, 2.639409065246582, 1.6318360567092896),
            rotation = 1,
        },
        leg_right = {
            position = vector3_box(-1.2683889865875244, 2.639409065246582, 1.6318360567092896),
            rotation = -.5,
        },
        hip_left = {
            position = vector3_box(-1.1683889865875244, 2.639409065246582, 1.6318360567092896),
            rotation = 1.5,
        },
        hip_right = {
            position = vector3_box(-1.2683889865875244, 2.639409065246582, 1.6318360567092896),
            rotation = -1,
        },
        hip_back = {
            position = vector3_box(-1.2683889865875244, 2.639409065246582, 1.6318360567092896),
            rotation = 3.5,
        },
        hip_front = {
            position = vector3_box(-1.2683889865875244, 2.639409065246582, 1.6318360567092896),
            rotation = .5,
        },
        chest = {
            position = vector3_box(-1.2683889865875244, 2.639409065246582, 1.6318360567092896),
            rotation = .5,
        },
    },
    [BREED_OGRYN] = {
        default = {
            [WEAPON_RANGED] = {
                position = vector3_box(-1.4683889865875244, 1.039409065246582, 2.0318360567092896),
                rotation = 2.5,
            },
            [WEAPON_MELEE] = {
                position = vector3_box(-2.0683889865875244, 1.039409065246582, 2.0318360567092896),
                rotation = 4.5,
            },
        },
        POCKETABLE_SMALL = {
            position = vector3_box(-1.5683889865875244, 1.039409065246582, 2.0318360567092896),
            rotation = 3.5,
        },
        POCKETABLE = {
            position = vector3_box(-1.5683889865875244, 1.039409065246582, 2.0318360567092896),
            rotation = 3.5,
        },
        leg_left = {
            position = vector3_box(-1.3683889865875244, 1.039409065246582, 2.0318360567092896),
            rotation = 1,
        },
        leg_right = {
            position = vector3_box(-1.8683889865875244, 1.039409065246582, 2.0318360567092896),
            rotation = -.5,
        },
        hip_left = {
            position = vector3_box(-1.4683889865875244, 1.039409065246582, 2.0318360567092896),
            rotation = 1.5,
        },
        hip_right = {
            position = vector3_box(-1.8683889865875244, 1.039409065246582, 2.0318360567092896),
            rotation = -1,
        },
        hip_back = {
            position = vector3_box(-1.7683889865875244, 1.039409065246582, 2.0318360567092896),
            rotation = 3.5,
        },
        hip_front = {
            position = vector3_box(-1.5683889865875244, 1.039409065246582, 2.0318360567092896),
            rotation = .5,
        },
        chest = {
            position = vector3_box(-1.5683889865875244, 1.039409065246582, 2.0318360567092896),
            rotation = .5,
        },
    },
}

--#region Copies
    placement_camera[BREED_HUMAN].backpack = table_clone_safe(placement_camera[BREED_HUMAN].default)
    placement_camera[BREED_OGRYN].backpack = table_clone_safe(placement_camera[BREED_OGRYN].default)
--#endregion

return placement_camera