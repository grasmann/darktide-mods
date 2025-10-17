local mod = get_mod("visible_equipment")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local vector3 = Vector3
    local vector3_box = Vector3Box
    local vector3_zero = vector3.zero
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

return {
    default = {
        left = {
            node = "j_spine2",
            position = vector3_box(.2, .175, -.125),
            rotation = vector3_box(0, 90, 90),
        },
    },
    leg_left = {
        left = {
            node = "j_spine2",
            position = vector3_box(.2, .175, -.125),
            rotation = vector3_box(0, 90, 90),
        },
    },
    leg_right = {
        left = {
            node = "j_spine2",
            position = vector3_box(.2, .175, -.125),
            rotation = vector3_box(0, 90, 90),
        },
    },
    hip_back = {
        left = {
            node = "j_spine2",
            position = vector3_box(.2, .175, -.125),
            rotation = vector3_box(0, 90, 90),
        },
    },
    hip_front = {
        left = {
            node = "j_spine2",
            position = vector3_box(.2, .175, -.125),
            rotation = vector3_box(0, 90, 90),
        },
    },
    hip_left = {
        left = {
            node = "j_spine2",
            position = vector3_box(.2, .175, -.125),
            rotation = vector3_box(0, 90, 90),
        },
    },
    hip_right = {
        left = {
            node = "j_spine2",
            position = vector3_box(.2, .175, -.125),
            rotation = vector3_box(0, 90, 90),
        },
    },
    backpack = {
        left = {
            node = "j_spine2",
            position = vector3_box(.2, .35, -.125),
            rotation = vector3_box(0, 90, 90),
        },
    },
}