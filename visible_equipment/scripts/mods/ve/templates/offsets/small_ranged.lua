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
        right = {
            node = "j_spine2",
            position = vector3_box(.16, .21, -.08),
            rotation = vector3_box(-10, 0, 90),
            center_mass = vector3_box(0, -.1, -.08),
        },
    },
    hip_front = {
        right = {
            node = "j_hips",
            position = vector3_box(-.022, .27, .02),
            rotation = vector3_box(0, -20, 90),
            center_mass = vector3_box(-.1, -.07, -.08),
        },
    },
    hip_back = {
        right = {
            node = "j_hips",
            position = vector3_box(-.05, -.27, .02),
            rotation = vector3_box(0, 0, 90),
            center_mass = vector3_box(.1, -.07, -.08),
        },
    },
    leg_left = {
        right = {
            node = "j_leftupleg",
            position = vector3_box(0, .03, -.16),
            rotation = vector3_box(290, 220, 100),
            center_mass = vector3_box(.03, .1, -.07),
        },
    },
    leg_right = {
        right = {
            node = "j_rightupleg",
            position = vector3_box(.005, -.06, .03),
            rotation = vector3_box(290, 220 + 180, 280 + 180),
            center_mass = vector3_box(-.02, .1, -.07),
        },
    },
    hip_left = {
        right = {
            node = "j_hips",
            position = vector3_box(-.09, -.01, .06),
            rotation = vector3_box(180+45, 180, -30),
            center_mass = vector3_box(.1, -.06, -.09),
        },
    },
    hip_right = {
        right = {
            node = "j_hips",
            position = vector3_box(.09, .01, .06),
            rotation = vector3_box(180+45, 180, 30),
            center_mass = vector3_box(-.1, -.06, -.09),
        },
    },
    backpack = {
        right = {
            node = "j_spine2",
            position = vector3_box(.14, .25, -.2),
            rotation = vector3_box(-30, 0, 90),
            center_mass = vector3_box(0, -.1, -.16),
        },
    },
}