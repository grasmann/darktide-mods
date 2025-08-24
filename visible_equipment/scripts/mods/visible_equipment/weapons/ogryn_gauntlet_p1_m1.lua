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
                position = vector3_box(0, .6, -.4),
                rotation = vector3_box(-10, 180, 90),
                center_mass = vector3_box(0, .2, .2),
            },
        },
        hip_back = {
            right = {
                node = "j_hips",
                position = vector3_box(.1, -.4, .1),
                rotation = vector3_box(0, -20, 90),
                center_mass = vector3_box(0, .2, .2),
            },
        },
        hip_front = {
            right = {
                node = "j_hips",
                position = vector3_box(.05, .6, 0),
                rotation = vector3_box(0, -20, 90),
                center_mass = vector3_box(0, .2, .2),
            },
        },
        hip_left = {
            right = {
                node = "j_hips",
                position = vector3_box(-.6, .125, 0),
                rotation = vector3_box(180+45, 180-20, 0),
                center_mass = vector3_box(0, .2, .2),
            },
        },
        hip_right = {
            right = {
                node = "j_hips",
                position = vector3_box(.6, .125, 0),
                rotation = vector3_box(180+45, 180, 10),
                center_mass = vector3_box(0, .2, .2),
            },
        },
        backpack = {
            right = {
                node = "j_spine2",
                position = vector3_box(0, .6, -.3),
                rotation = vector3_box(0, 180, 90),
                center_mass = vector3_box(0, .2, .6),
            },
        },
    },
    animations = {
        default = {
            right = {
                states = 2,
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
                    start_rotation = vector3_box(vector3(-5, 2.5, 90) * .5),
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
    momentum = {
        right = {
            momentum = vector3_box(1, -3, 0),
        },
    },
}