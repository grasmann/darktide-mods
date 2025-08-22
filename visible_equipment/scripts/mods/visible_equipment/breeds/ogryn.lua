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

local WEAPON_MELEE = "WEAPON_MELEE"
local WEAPON_RANGED = "WEAPON_RANGED"
local POCKETABLE_SMALL = "POCKETABLE_SMALL"
local POCKETABLE = "POCKETABLE"

return {
    offsets = {
        [WEAPON_MELEE] = {
            default = {
                left = {
                    node = "j_spine2",
                    position = vector3_box(.2, .5, -.25),
                    rotation = vector3_box(0, 90, 90),
                },
                right = {
                    node = "j_spine2",
                    position = vector3_box(.3, .5, .25),
                    rotation = vector3_box(0, -90, -90),
                },
            },
            backpack = {
                left = {
                    node = "j_spine2",
                    position = vector3_box(.2, .7, -.25),
                    rotation = vector3_box(0, 90, 90),
                },
                right = {
                    node = "j_spine2",
                    position = vector3_box(.3, .7, .45),
                    rotation = vector3_box(0, -90, -120),
                },
            },
        },
        [WEAPON_RANGED] = {
            default = {
                right = {
                    node = "j_spine2",
                    position = vector3_box(.5, .5, -.25),
                    rotation = vector3_box(0, 0, 90),
                },
            },
            backpack = {
                right = {
                    node = "j_spine2",
                    position = vector3_box(.5, .7, -.45),
                    rotation = vector3_box(0, 0, 90),
                },
            },
        },
        [POCKETABLE_SMALL] = {
            default = {
                right = {
                    node = "j_hips",
                    position = vector3_box(.28, -.35, .25),
                    rotation = vector3_box(-10, -10, 0),
                    scale = vector3_box(1, 1, 1),
                },
            },
        },
        [POCKETABLE] = {
            default = {
                right = {
                    node = "j_hips",
                    position = vector3_box(0, -.35, .5),
                    rotation = vector3_box(80, 0, 180),
                    scale = vector3_box(1, 1, 1),
                },
            },
        },
    },
    animations = {
        [WEAPON_RANGED] = {
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
        [WEAPON_MELEE] = {
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
    },
    sounds = {
        [WEAPON_MELEE] = {
            crouching = {
                "sfx_grab_weapon",
                "sfx_foley_equip",
            },
            default = {
                "sfx_ads_up",
                "sfx_ads_down",
            },
            accent = {
                "sfx_equip",
                "sfx_pull_pin",
            },
        },
        [WEAPON_RANGED] = {
            crouching = {
                "sfx_ads_up",
                "sfx_ads_down",
            },
            default = {
                "sfx_ads_up",
                "sfx_ads_down",
            },
            accent = {
                "sfx_equip",
                "sfx_magazine_eject",
                "sfx_magazine_insert",
                "sfx_reload_lever_pull",
                "sfx_reload_lever_release",
            },
        },
    },
}