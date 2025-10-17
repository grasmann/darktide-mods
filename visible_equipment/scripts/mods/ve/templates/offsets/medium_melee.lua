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
            position = vector3_box(0.15, 0.2, 0.12),
            rotation = vector3_box(10, -90, -90),
            center_mass = vector3_box(0, 0, -.15),
        },
    },
    hip_back = {
        right = {
            node = "j_hips",
            position = vector3_box(-.004, -0.15, 0.05),
            rotation = vector3_box(0, -120, 90),
            center_mass = vector3_box(0, 0, -.25),
        },
    },
    hip_front = {
        right = {
            node = "j_hips",
            position = vector3_box(-.004, 0.185, 0.05),
            rotation = vector3_box(0, -140, 90),
            center_mass = vector3_box(0, 0, -.25),
        },
    },
    hip_left = {
        right = {
            node = "j_hips",
            position = vector3_box(-.2, 0, 0.1),
            rotation = vector3_box(-40, 180, 0),
            center_mass = vector3_box(0, 0, -.15),
        },
    },
    hip_right = {
        right = {
            node = "j_hips",
            position = vector3_box(.2, 0, 0.1),
            rotation = vector3_box(-40, 180, 30),
            center_mass = vector3_box(0, 0, -.15),
        },
    },
    backpack = {
        right = {
            node = "j_spine2",
            position = vector3_box(.18, .24, .23),
            rotation = vector3_box(0, -90, -120),
            center_mass = vector3_box(0, 0, -.15),
        },
    },
}