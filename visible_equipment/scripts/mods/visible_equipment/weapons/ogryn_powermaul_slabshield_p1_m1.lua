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
    offsets = {
        default = {
            right = {
                node = "j_spine2",
                position = vector3_box(.5, .55, .25),
                rotation = vector3_box(0, -90, -90),
            },
            left = {
                node = "j_spine2",
                position = vector3_box(.2, .55, -.25),
                rotation = vector3_box(0, 90, 90),
            },
        },
        backpack = {
            right = {
                node = "j_spine2",
                position = vector3_box(.5, .7, .45),
                rotation = vector3_box(0, -90, -120),
            },
            left = {
                node = "j_spine2",
                position = vector3_box(.2, .7, -.25),
                rotation = vector3_box(0, 90, 90),
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
            left = {
                states = 3,
                start = "place",
                interrupt = true,
                place = {
                    name = "place",
                    no_modifiers = true,
                    start_position = vector3_box(vector3(1, -.5, 0) * .5),
                    start_rotation = vector3_box(vector3(-5, 2.5, -90) * .5),
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