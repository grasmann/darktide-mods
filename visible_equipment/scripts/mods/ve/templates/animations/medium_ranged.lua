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

local step = {
    default = {
        name = "step",
        start_position = vector3_box(vector3_zero()),
        start_rotation = vector3_box(vector3_zero()),
        end_position = vector3_box(vector3(-.05, 0, 0) * .5),
        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        next = "back",
    },
    backpack = {
        name = "step",
        start_position = vector3_box(vector3_zero()),
        start_rotation = vector3_box(vector3_zero()),
        end_position = vector3_box(vector3(-.05, 0, 0) * .5),
        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        next = "back",
    },
    leg_left = {
        name = "step",
        start_position = vector3_box(vector3_zero()),
        start_rotation = vector3_box(vector3_zero()),
        end_position = vector3_box(vector3(0, -.05, 0) * .5),
        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        next = "back",
    },
    leg_right = {
        name = "step",
        start_position = vector3_box(vector3_zero()),
        start_rotation = vector3_box(vector3_zero()),
        end_position = vector3_box(vector3(0, -.05, 0) * .5),
        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        next = "back",
    },
    hip_left = {
        name = "step",
        start_position = vector3_box(vector3_zero()),
        start_rotation = vector3_box(vector3_zero()),
        end_position = vector3_box(vector3(0, -.05, 0) * .5),
        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        next = "back",
    },
    hip_right = {
        name = "step",
        start_position = vector3_box(vector3_zero()),
        start_rotation = vector3_box(vector3_zero()),
        end_position = vector3_box(vector3(0, -.05, 0) * .5),
        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        next = "back",
    },
    hip_front = {
        name = "step",
        start_position = vector3_box(vector3_zero()),
        start_rotation = vector3_box(vector3_zero()),
        end_position = vector3_box(vector3(0, 0, -.05) * .5),
        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        next = "back",
    },
    hip_back = {
        name = "step",
        start_position = vector3_box(vector3_zero()),
        start_rotation = vector3_box(vector3_zero()),
        end_position = vector3_box(vector3(0, 0, -.05) * .5),
        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        next = "back",
    },
    name = "step",
    start_position = vector3_box(vector3_zero()),
    start_rotation = vector3_box(vector3_zero()),
    end_position = vector3_box(vector3(-.05, 0, 0) * .5),
    end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
    next = "back",
}

local back = {
    default = {
        name = "back",
        start_position = vector3_box(vector3(-.05, 0, 0) * .5),
        start_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        end_position = vector3_box(vector3_zero()),
        end_rotation = vector3_box(vector3_zero()),
    },
    backpack = {
        name = "back",
        start_position = vector3_box(vector3(-.05, 0, 0) * .5),
        start_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        end_position = vector3_box(vector3_zero()),
        end_rotation = vector3_box(vector3_zero()),
    },
    leg_left = {
        name = "back",
        start_position = vector3_box(vector3(0, -.05, 0) * .5),
        start_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        end_position = vector3_box(vector3_zero()),
        end_rotation = vector3_box(vector3_zero()),
    },
    leg_right = {
        name = "back",
        start_position = vector3_box(vector3(0, -.05, 0) * .5),
        start_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        end_position = vector3_box(vector3_zero()),
        end_rotation = vector3_box(vector3_zero()),
    },
    hip_left = {
        name = "back",
        start_position = vector3_box(vector3(0, -.05, 0) * .5),
        start_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        end_position = vector3_box(vector3_zero()),
        end_rotation = vector3_box(vector3_zero()),
    },
    hip_right = {
        name = "back",
        start_position = vector3_box(vector3(0, -.05, 0) * .5),
        start_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        end_position = vector3_box(vector3_zero()),
        end_rotation = vector3_box(vector3_zero()),
    },
    hip_front = {
        name = "back",
        start_position = vector3_box(vector3(0, 0, -.05) * .5),
        start_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        end_position = vector3_box(vector3_zero()),
        end_rotation = vector3_box(vector3_zero()),
    },
    hip_back = {
        name = "back",
        start_position = vector3_box(vector3(0, 0, -.05) * .5),
        start_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        end_position = vector3_box(vector3_zero()),
        end_rotation = vector3_box(vector3_zero()),
    },
    name = "back",
    start_position = vector3_box(vector3(-.05, 0, 0) * .5),
    start_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
    end_position = vector3_box(vector3_zero()),
    end_rotation = vector3_box(vector3_zero()),
}

local place = {
    default = {
        name = "place",
        no_modifiers = true,
        start_position = vector3_box(vector3(1, -.5, .5) * .5),
        start_rotation = vector3_box(vector3(0, 0, -90) * .5),
        end_position = vector3_box(vector3(-.15, 0, 0) * .5),
        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        next = "step",
    },
    backpack = {
        name = "place",
        no_modifiers = true,
        start_position = vector3_box(vector3(1, -.5, .5) * .5),
        start_rotation = vector3_box(vector3(0, 0, -90) * .5),
        end_position = vector3_box(vector3(-.15, 0, 0) * .5),
        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        next = "step",
    },
    leg_left = {
        name = "place",
        no_modifiers = true,
        start_position = vector3_box(vector3(-1, .5, 0) * .5),
        start_rotation = vector3_box(vector3(90, 0, 0) * .5),
        end_position = vector3_box(vector3(-.15, 0, 0) * .5),
        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        next = "step",
    },
    leg_right = {
        name = "place",
        no_modifiers = true,
        start_position = vector3_box(vector3(1, -.5, 0) * .5),
        start_rotation = vector3_box(vector3(0, 0, 90) * .5),
        end_position = vector3_box(vector3(-.15, 0, 0) * .5),
        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        next = "step",
    },
    hip_left = {
        name = "place",
        no_modifiers = true,
        start_position = vector3_box(vector3(1, .5, 0) * .5),
        start_rotation = vector3_box(vector3(0, 0, -90) * .5),
        end_position = vector3_box(vector3(-.15, 0, 0) * .5),
        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        next = "step",
    },
    hip_right = {
        name = "place",
        no_modifiers = true,
        start_position = vector3_box(vector3(-1, .5, 0) * .5),
        start_rotation = vector3_box(vector3(0, 0, 90) * .5),
        end_position = vector3_box(vector3(-.15, 0, 0) * .5),
        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        next = "step",
    },
    hip_front = {
        name = "place",
        no_modifiers = true,
        start_position = vector3_box(vector3(1, -.5, 0) * .5),
        start_rotation = vector3_box(vector3(-5, 2.5, -90) * .5),
        end_position = vector3_box(vector3(-.15, 0, 0) * .5),
        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        next = "step",
    },
    hip_back = {
        name = "place",
        no_modifiers = true,
        start_position = vector3_box(vector3(1, -.5, 0) * .5),
        start_rotation = vector3_box(vector3(-5, 2.5, 90) * .5),
        end_position = vector3_box(vector3(-.15, 0, 0) * .5),
        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        next = "step",
    },
    name = "place",
    no_modifiers = true,
    start_position = vector3_box(vector3(1, -.5, 0) * .5),
    start_rotation = vector3_box(vector3(-5, 2.5, -90) * .5),
    end_position = vector3_box(vector3(-.15, 0, 0) * .5),
    end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
    next = "step",
}

return {
    default = {
        right = {
            states = 2,
            start = "step",
            step = step,
            back = back,
        },
    },
    shoot = {
        right = {
            states = 2,
            start = "step",
            interval = .035,
            interrupt = true,
            step = step,
            back = back,
        },
    },
    sheath = {
        right = {
            states = 3,
            start = "place",
            interrupt = true,
            place = place,
            step = step,
            back = back,
        },
    },
}