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
            start = "step",
            states = 2,
            step = {
                name = "step",
                start_position = vector3_box(vector3_zero()),
                start_rotation = vector3_box(vector3_zero()),
                end_position = vector3_box(vector3(-.05, 0, 0) * .5),
                end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
                next = "back",
            },
            back = {
                name = "back",
                start_position = vector3_box(vector3(-.05, 0, 0) * .5),
                start_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
                end_position = vector3_box(vector3_zero()),
                end_rotation = vector3_box(vector3_zero()),
            },
        },
    },
    shoot = {
        left = {
            start = "step",
            states = 2,
            interval = .035,
            interrupt = true,
            step = {
                name = "step",
                start_position = vector3_box(vector3_zero()),
                start_rotation = vector3_box(vector3_zero()),
                end_position = vector3_box(vector3(-.05, 0, 0) * .5),
                end_rotation = vector3_box(vector3(-5, 2.5, 25) * .5),
                next = "back",
            },
            back = {
                name = "back",
                start_position = vector3_box(vector3(-.05, 0, 0) * .5),
                start_rotation = vector3_box(vector3(-5, 2.5, 25) * .5),
                end_position = vector3_box(vector3_zero()),
                end_rotation = vector3_box(vector3_zero()),
            },
        },
    },
    sheath = {
        left = {
            states = 3,
            start = "place",
            interrupt = true,
            -- interval = .3,
            place = {
                name = "place",
                no_modifiers = true,
                start_position = vector3_box(vector3(1, -.5, -.5) * .5),
                start_rotation = vector3_box(vector3(180, -180, -180) * .5),
                end_position = vector3_box(vector3(-.15, 0, 0) * .5),
                end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
                next = "step",
            },
            step = {
                name = "step",
                start_position = vector3_box(vector3(-.15, 0, 0) * .5),
                start_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
                end_position = vector3_box(vector3(-.05, 0, 0) * .5),
                end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
                next = "back",
            },
            back = {
                name = "back",
                start_position = vector3_box(vector3(-.05, 0, 0) * .5),
                start_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
                end_position = vector3_box(vector3_zero()),
                end_rotation = vector3_box(vector3_zero()),
            },
        },
    },
}