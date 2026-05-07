local mod = get_mod("visible_equipment")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local table = table
    local vector3 = Vector3
    local vector3_box = Vector3Box
    local table_clone = table.clone
    local vector3_zero = vector3.zero
    local table_merge_recursive_n = table.merge_recursive_n
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local step_right = {
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

local back_right = {
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

local place_right = {
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

local step_left = {
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

local back_left = {
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

local place_left = {
    default = {
        name = "place",
        no_modifiers = true,
        start_position = vector3_box(vector3(1, .5, .5) * .5),
        start_rotation = vector3_box(vector3(0, 0, -90) * .5),
        end_position = vector3_box(vector3(-.15, 0, 0) * .5),
        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        next = "step",
    },
    backpack = {
        name = "place",
        no_modifiers = true,
        start_position = vector3_box(vector3(1, .5, .5) * .5),
        start_rotation = vector3_box(vector3(0, 0, -90) * .5),
        end_position = vector3_box(vector3(-.15, 0, 0) * .5),
        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        next = "step",
    },
    leg_left = {
        name = "place",
        no_modifiers = true,
        start_position = vector3_box(vector3(-1, -.5, 0) * .5),
        start_rotation = vector3_box(vector3(90, 0, 0) * .5),
        end_position = vector3_box(vector3(-.15, 0, 0) * .5),
        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        next = "step",
    },
    leg_right = {
        name = "place",
        no_modifiers = true,
        start_position = vector3_box(vector3(1, .5, 0) * .5),
        start_rotation = vector3_box(vector3(0, 0, 90) * .5),
        end_position = vector3_box(vector3(-.15, 0, 0) * .5),
        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        next = "step",
    },
    hip_left = {
        name = "place",
        no_modifiers = true,
        start_position = vector3_box(vector3(1, -.5, 0) * .5),
        start_rotation = vector3_box(vector3(0, 0, -90) * .5),
        end_position = vector3_box(vector3(-.15, 0, 0) * .5),
        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        next = "step",
    },
    hip_right = {
        name = "place",
        no_modifiers = true,
        start_position = vector3_box(vector3(-1, -.5, 0) * .5),
        start_rotation = vector3_box(vector3(0, 0, 90) * .5),
        end_position = vector3_box(vector3(-.15, 0, 0) * .5),
        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        next = "step",
    },
    hip_front = {
        name = "place",
        no_modifiers = true,
        start_position = vector3_box(vector3(1, .5, 0) * .5),
        start_rotation = vector3_box(vector3(-5, 2.5, -90) * .5),
        end_position = vector3_box(vector3(-.15, 0, 0) * .5),
        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        next = "step",
    },
    hip_back = {
        name = "place",
        no_modifiers = true,
        start_position = vector3_box(vector3(1, .5, 0) * .5),
        start_rotation = vector3_box(vector3(-5, 2.5, 90) * .5),
        end_position = vector3_box(vector3(-.15, 0, 0) * .5),
        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
        next = "step",
    },
    name = "place",
    no_modifiers = true,
    start_position = vector3_box(vector3(1, .5, 0) * .5),
    start_rotation = vector3_box(vector3(-5, 2.5, -90) * .5),
    end_position = vector3_box(vector3(-.15, 0, 0) * .5),
    end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
    next = "step",
}

local offsets = {
    default = {
        right = {
            node = "j_spine2",
            position = vector3_box(.37, .08, -.14),
            rotation = vector3_box(-45, -55, -120),
        },
        left = {
            node = "j_spine2",
            position = vector3_box(.37, .08, .14),
            rotation = vector3_box(-145, -55, 120),
        },
    },
    hip_front = {
        right = {
            node = "j_hips",
            position = vector3_box(.22, .11, .13),
            rotation = vector3_box(-35, -65, 40),
        },
        left = {
            node = "j_hips",
            position = vector3_box(-.22, .11, .13),
            rotation = vector3_box(-35, 65, -50),
        },
    },
    hip_back = {
        right = {
            node = "j_hips",
            position = vector3_box(.24, -.1, .045),
            rotation = vector3_box(25, -50, 115),
        },
        left = {
            node = "j_hips",
            position = vector3_box(-.24, -.1, .045),
            rotation = vector3_box(25, 50, -125),
        },
    },
    leg_left = {
        right = {
            node = "j_leftupleg",
            position = vector3_box(.22, .16, -.09),
            rotation = vector3_box(110, -40, -80),
        },
        left = {
            node = "j_rightupleg",
            position = vector3_box(-.22, -.16, .09),
            rotation = vector3_box(-80, 40, 90),
        },
    },
    leg_right = {
        right = {
            node = "j_leftupleg",
            position = vector3_box(.135, -.09, -.15),
            rotation = vector3_box(-80, -15, -100),
        },
        left = {
            node = "j_rightupleg",
            position = vector3_box(-.135, .09, .15),
            rotation = vector3_box(100, 15, 100),
        },
    },
    hip_left = {
        right = {
            node = "j_hips",
            position = vector3_box(-.19, .15, .08),
            rotation = vector3_box(45, 0, 165),
        },
        left = {
            node = "j_hips",
            position = vector3_box(.19, .15, .08),
            rotation = vector3_box(45, 0, -165),
        },
    },
    hip_right = {
        right = {
            node = "j_hips",
            position = vector3_box(-.20, -.08, .08),
            rotation = vector3_box(-50, 15, 10),
        },
        left = {
            node = "j_hips",
            position = vector3_box(.20, -.08, .08),
            rotation = vector3_box(-50, -15, -10),
        },
    },
    backpack = {
        right = {
            node = "j_spine2",
            position = vector3_box(.14, .25, -.2),
            rotation = vector3_box(-30, 0, 90),
        },
        left = {
            node = "j_spine2",
            position = vector3_box(-.14, .25, -.2),
            rotation = vector3_box(30, 0, 90),
        },
    },
}

return {
    offsets = offsets,
    animations = {
        default = {
            right = {
                states = 2,
                start = "step",
                step = step_right,
                back = back_right,
            },
            left = {
                states = 2,
                start = "step",
                step = step_left,
                back = back_left,
            },
        },
        shoot = {
            right = {
                states = 2,
                start = "step",
                interval = .035,
                interrupt = true,
                step = step_right,
                back = back_right,
            },
            left = {
                states = 2,
                start = "step",
                interval = .035,
                interrupt = true,
                step = step_left,
                back = back_left,
            },
        },
        sheath = {
            right = {
                states = 3,
                start = "place",
                interrupt = true,
                place = place_right,
                step = step_right,
                back = back_right,
            },
            left = {
                states = 3,
                start = "place",
                interrupt = true,
                place = place_left,
                step = step_left,
                back = back_left,
            },
        },
    },
    sounds = {
        crouching = {
            "sfx_grab_weapon",
            "sfx_foley_equip",
        },
        default = {
            "sfx_ads_up",
            "sfx_ads_down",
        },
        accent = {
            "sfx_equip_02",
            "sfx_magazine_eject",
            "sfx_swing_heavy",
        },
    },
}