local mod = get_mod("visible_equipment")

local vector3_box = Vector3Box

local WEAPON_MELEE = "WEAPON_MELEE"
local WEAPON_RANGED = "WEAPON_RANGED"

return {
    [WEAPON_MELEE] = {
        right = {
            position = vector3_box(0, 0, -.05),
            rotation = vector3_box(0, 7.5, 0),
        },
        left = {
            position = vector3_box(0, 0, 0),
            rotation = vector3_box(0, 0, 0),
        },
    },
    [WEAPON_RANGED] = {
        right = {
            position = vector3_box(0, 0, .05),
            rotation = vector3_box(0, -7.5, 0),
        },
        left = {
            position = vector3_box(0, 0, 0),
            rotation = vector3_box(0, 0, 0),
        },
    },
}