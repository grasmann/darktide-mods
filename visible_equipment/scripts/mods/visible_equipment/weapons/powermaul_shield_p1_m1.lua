local mod = get_mod("weapon_customization")

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
    offsets = {
        default = {
            left = {
                node = "j_spine2",
                position = vector3_box(.2, .175, -.125),
                rotation = vector3_box(0, 90, 90),
            },
            right = {
                node = "j_spine2",
                position = vector3_box(.3, .2, .15),
                rotation = vector3_box(10, -90, -90),
            },
        },
        leg_left = {
            left = {
                node = "j_spine2",
                position = vector3_box(.2, .175, -.125),
                rotation = vector3_box(0, 90, 90),
            },
            right = {
                node = "j_leftupleg",
                position = vector3_box(0.1, 0.11, -0.06),
                rotation = vector3_box(-10, 75, -280),
            },
        },
        leg_right = {
            left = {
                node = "j_spine2",
                position = vector3_box(.2, .175, -.125),
                rotation = vector3_box(0, 90, 90),
            },
            right = {
                node = "j_rightupleg",
                position = vector3_box(-.1, -.125, 0),
                rotation = vector3_box(-10, 250, 90),
            },
        },
        hip_back = {
            left = {
                node = "j_spine2",
                position = vector3_box(.2, .175, -.125),
                rotation = vector3_box(0, 90, 90),
            },
            right = {
                node = "j_hips",
                position = vector3_box(0.075, -0.1, 0.15),
                rotation = vector3_box(0, -120, 90),
            },
        },
        hip_front = {
            left = {
                node = "j_spine2",
                position = vector3_box(.2, .175, -.125),
                rotation = vector3_box(0, 90, 90),
            },
            right = {
                node = "j_hips",
                position = vector3_box(0.075, 0.15, 0.15),
                rotation = vector3_box(0, -110, 90),
            },
        },
        hip_left = {
            left = {
                node = "j_spine2",
                position = vector3_box(.2, .175, -.125),
                rotation = vector3_box(0, 90, 90),
            },
            right = {
                node = "j_hips",
                position = vector3_box(-.2, .125, 0.1),
                rotation = vector3_box(-40, 180, 0),
            },
        },
        hip_right = {
            left = {
                node = "j_spine2",
                position = vector3_box(.2, .175, -.125),
                rotation = vector3_box(0, 90, 90),
            },
            right = {
                node = "j_hips",
                position = vector3_box(.2, .125, 0.1),
                rotation = vector3_box(-40, 180, 30),
            },
        },
        backpack = {
            left = {
                node = "j_spine2",
                position = vector3_box(.2, .35, -.125),
                rotation = vector3_box(0, 90, 90),
            },
            right = {
                node = "j_spine2",
                position = vector3_box(.3, .2, .2),
                rotation = vector3_box(0, -90, -120),
            },
        },
    },
    animations = {
        default = {
            right = {
                start = "step",
                states = 2,
                step = {
                    name = "step",
                    start_position = vector3_box(vector3_zero()),
                    start_rotation = vector3_box(vector3_zero()),
                    end_position = vector3_box(vector3(-.05, 0, 0) * .5),
                    end_rotation = vector3_box(vector3(5, 2.5, 5) * .5),
                    next = "back",
                },
                back = {
                    name = "back",
                    start_position = vector3_box(vector3(-.05, 0, 0) * .5),
                    start_rotation = vector3_box(vector3(5, 2.5, 5) * .5),
                    end_position = vector3_box(vector3_zero()),
                    end_rotation = vector3_box(vector3_zero()),
                },
            },
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
            right = {
                states = 2,
                start = "step",
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
                place = {
                    name = "place",
                    no_modifiers = true,
                    start_position = vector3_box(vector3(1, -.5, 0) * .5),
                    start_rotation = vector3_box(vector3(-5, 2.5, -5) * .5),
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
            right = {
                states = 3,
                start = "place",
                interrupt = true,
                place = {
                    name = "place",
                    no_modifiers = true,
                    start_position = vector3_box(vector3(1, -.5, 0) * .5),
                    start_rotation = vector3_box(vector3(-5, 90, -5) * .5),
                    end_position = vector3_box(vector3(-.05, 0, 0) * .5),
                    end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
                    next = "step",
                },
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
    },
    sounds = {
        crouching = {
            "sfx_grab_weapon",
            "sfx_foley_equip",
        },
        default = {
            -- "sfx_equip",
            "sfx_weapon_foley_left_hand_01",
            "sfx_weapon_foley_left_hand_02",
            -- "sfx_swing",
        },
        accent = {
            "sfx_equip_02",
            "sfx_magazine_eject",
            "sfx_swing_heavy",
        },
    },
}