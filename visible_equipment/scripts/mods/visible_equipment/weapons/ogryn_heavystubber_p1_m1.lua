local mod = get_mod("visible_equipment")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local table = table
    local vector3 = Vector3
    local unit_node = unit.node
    local table_find = table.find
    local quaternion = Quaternion
    local vector3_box = Vector3Box
    local vector3_zero = vector3.zero
    local unit_has_node = unit.has_node
    local quaternion_from_vector = quaternion.from_vector
    local unit_set_local_rotation = unit.set_local_rotation
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

return {
    offsets = {
        default = {
            right = {
                node = "j_spine2",
                position = vector3_box(.2, .6, -.3),
                rotation = vector3_box(15, 7.5, 90),
                center_mass = vector3_box(-.2, -.7, 0),
            },
        },
        hip_back = {
            right = {
                node = "j_hips",
                position = vector3_box(.05, -.325, .2),
                rotation = vector3_box(10, -20, 90),
                center_mass = vector3_box(-.2, -.7, 0),
            },
        },
        hip_front = {
            right = {
                node = "j_hips",
                position = vector3_box(.05, .7, .2),
                rotation = vector3_box(15, -20, 90),
                center_mass = vector3_box(-.2, -.7, 0),
            },
        },
        hip_left = {
            right = {
                node = "j_hips",
                position = vector3_box(-.8, -.125, 0),
                rotation = vector3_box(180+45, 180-20, 0),
                center_mass = vector3_box(-.2, -.7, 0),
            },
        },
        hip_right = {
            right = {
                node = "j_hips",
                position = vector3_box(.4, .125, 0),
                rotation = vector3_box(180+45, 180, 10),
                center_mass = vector3_box(-.2, -.7, 0),
            },
        },
        backpack = {
            right = {
                node = "j_spine2",
                position = vector3_box(.2, .8, -.5),
                rotation = vector3_box(10, 0, 90),
                center_mass = vector3_box(-.2, -.7, 0),
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
    momentum = {
        right = {
            momentum = vector3_box(1, -3, 0),
        },
    },
    scripts = {
        init = function(item, item_unit, attachment_units, attachment_names)
            local receiver = table_find(attachment_names, "receiver")
            if receiver then
                local has_node = unit_has_node(receiver, "ap_anim_01")
                local node_index = has_node and unit_node(receiver, "ap_anim_01")
                if node_index then
                    unit_set_local_rotation(receiver, node_index, quaternion_from_vector(vector3(0, 0, 90)))
                end
            end
        end,
    },
}