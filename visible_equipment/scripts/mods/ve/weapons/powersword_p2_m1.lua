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
				position = vector3_box(0.15, 0.2, 0.12),
				rotation = vector3_box(10, -90, -90),
                center_mass = vector3_box(0, 0, -.15),
			},
		},
        leg_left = {
            right = {
                node = "j_leftupleg",
                position = vector3_box(.2, .06, -.03),
                rotation = vector3_box(-90, 75 + 45, 100),
                center_mass = vector3_box(0, 0, -.15),
            },
        },
        leg_right = {
            right = {
                node = "j_rightupleg",
                position = vector3_box(-.2, -.05, .2),
                rotation = vector3_box(-90, 250 + 45, -90),
                center_mass = vector3_box(0, 0, -.15),
            },
        },
        hip_back = {
            right = {
                node = "j_hips",
                position = vector3_box(-.004, -0.15, 0.15),
                rotation = vector3_box(0, -120, 90),
                center_mass = vector3_box(0, 0, -.25),
            },
        },
        hip_front = {
            right = {
                node = "j_hips",
                position = vector3_box(-.004, 0.165, 0.15),
                rotation = vector3_box(0, -110, 90),
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
                        start_position = vector3_box(vector3(-1, .5, .5) * .5),
                        start_rotation = vector3_box(vector3(0, -90, 0) * .5),
                        end_position = vector3_box(vector3(-.15, 0, 0) * .5),
                        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
                        next = "step",
                    },
                    leg_right = {
                        name = "place",
                        no_modifiers = true,
                        start_position = vector3_box(vector3(1, -.5, -.5) * .5),
                        start_rotation = vector3_box(vector3(0, 90, 0) * .5),
                        end_position = vector3_box(vector3(-.15, 0, 0) * .5),
                        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
                        next = "step",
                    },
                    hip_left = {
                        name = "place",
                        no_modifiers = true,
                        start_position = vector3_box(vector3(1, .5, .5) * .5),
                        start_rotation = vector3_box(vector3(0, 90, 0) * .5),
                        end_position = vector3_box(vector3(-.15, 0, 0) * .5),
                        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
                        next = "step",
                    },
                    hip_right = {
                        name = "place",
                        no_modifiers = true,
                        start_position = vector3_box(vector3(-1, .5, .5) * .5),
                        start_rotation = vector3_box(vector3(0, -90, 0) * .5),
                        end_position = vector3_box(vector3(-.15, 0, 0) * .5),
                        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
                        next = "step",
                    },
                    hip_front = {
                        name = "place",
                        no_modifiers = true,
                        start_position = vector3_box(vector3(1, -.5, 0) * .5),
                        start_rotation = vector3_box(vector3(90, 0, 0) * .5),
                        end_position = vector3_box(vector3(-.15, 0, 0) * .5),
                        end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
                        next = "step",
                    },
                    hip_back = {
                        name = "place",
                        no_modifiers = true,
                        start_position = vector3_box(vector3(1, .5, 0) * .5),
                        start_rotation = vector3_box(vector3(-90, 0, 0) * .5),
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
}