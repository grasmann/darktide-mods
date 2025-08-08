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

return {
    offsets = {
        [WEAPON_MELEE] = {
            default = {
                left = {
                    node = "j_spine2",
                    position = vector3_box(.2, .35, -.15),
                    rotation = vector3_box(0, 90, 90),
                },
                right = {
                    node = "j_spine2",
                    position = vector3_box(.3, .15, .15),
                    rotation = vector3_box(0, -90, 90),
                },
            },
            backpack = {
                left = {
                    node = "j_spine2",
                    position = vector3_box(.2, .7, -.15),
                    rotation = vector3_box(0, 90, 90),
                },
                right = {
                    node = "j_spine2",
                    position = vector3_box(.3, .25, .25),
                    rotation = vector3_box(0, -90, 90),
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
                    position = vector3_box(.5, .5, -.35),
                    rotation = vector3_box(0, 0, 90),
                },
            },
        },
    },
    footstep_animations = {
        [WEAPON_RANGED] = {
            default = {
                right = {
                    start = "step",
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
            equip = {
                right = {
                    start = "equip",
                    equip = {
                        name = "equip",
                        start_position = vector3_box(vector3_zero()),
                        start_rotation = vector3_box(vector3_zero()),
                        end_position = "equip",
                        end_rotation = "equip",
                    },
                },
                left = {
                    start = "equip",
                    equip = {
                        name = "equip",
                        start_position = vector3_box(vector3_zero()),
                        start_rotation = vector3_box(vector3_zero()),
                        end_position = "equip",
                        end_rotation = "equip",
                    },
                },
            },
        },
        [WEAPON_MELEE] = {
            default = {
                right = {
                    start = "step",
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