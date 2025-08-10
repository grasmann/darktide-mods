local mod = get_mod("visible_equipment")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local ogryn = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/breeds/ogryn")
local human = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/breeds/human")

local autogun_p1_m1 = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/weapons/autogun_p1_m1")

local backpack_scions_a = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/backpacks/backpack_scions_a")

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

local BREED_HUMAN = "human"
local BREED_OGRYN = "ogryn"
local WEAPON_MELEE = "WEAPON_MELEE"
local WEAPON_RANGED = "WEAPON_RANGED"

local offsets = {
    [BREED_HUMAN] = human.offsets,
    [BREED_OGRYN] = ogryn.offsets,
    autogun_p1_m1 = autogun_p1_m1.offsets,

    forcestaff_p1_m1 = {
        default = {
            right = {
                node = "j_spine2",
                position = vector3_box(.3, .175, -.15),
                rotation = vector3_box(10, 90, -90),
            },
        },
        backpack = {
            right = {
                node = "j_spine2",
                position = vector3_box(.3, .175, -.25),
                rotation = vector3_box(0, 90, 90),
            },
        },
    },

    ogryn_pickaxe_2h_p1_m1 = {
        default = {
            right = {
                node = "j_spine2",
                position = vector3_box(-.9, .5, .25),
                rotation = vector3_box(0, 90, 180),
                center_mass = vector3_box(.8, 0, 0),
            },
        },
        backpack = {
            right = {
                node = "j_spine2",
                position = vector3_box(-.9, .7, .45),
                rotation = vector3_box(0, 90, 180),
                center_mass = vector3_box(.8, 0, 0),
            },
        },
    },

}

offsets.ogryn_pickaxe_2h_p1_m2 = offsets.ogryn_pickaxe_2h_p1_m1
offsets.ogryn_pickaxe_2h_p1_m3 = offsets.ogryn_pickaxe_2h_p1_m1
offsets.forcestaff_p2_m1 = offsets.forcestaff_p1_m1
offsets.forcestaff_p3_m1 = offsets.forcestaff_p1_m1
offsets.forcestaff_p4_m1 = offsets.forcestaff_p1_m1
offsets.autogun_p1_m2 = offsets.autogun_p1_m1
offsets.autogun_p1_m3 = offsets.autogun_p1_m1
offsets.autogun_p2_m1 = offsets.autogun_p1_m1
offsets.autogun_p2_m2 = offsets.autogun_p1_m1
offsets.autogun_p2_m3 = offsets.autogun_p1_m1
offsets.autogun_p3_m1 = offsets.autogun_p1_m1
offsets.autogun_p3_m2 = offsets.autogun_p1_m1
offsets.autogun_p3_m3 = offsets.autogun_p1_m1

local footstep_animations = {
    [BREED_HUMAN] = human.footstep_animations,
    [BREED_OGRYN] = ogryn.footstep_animations,
    autogun_p1_m1 = autogun_p1_m1.footstep_animations,

    forcestaff_p1_m1 = {
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
                start_position = vector3_box(vector3(-.05, 0, 0) * .5),
                start_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
                end_position = vector3_box(vector3_zero()),
                end_rotation = vector3_box(vector3_zero()),
                next = "back",
            },
            back = {
                name = "back",
                start_position = vector3_box(vector3_zero()),
                start_rotation = vector3_box(vector3_zero()),
                end_position = vector3_box(vector3(-.05, 0, 0) * .5),
                end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
            },
        },
    },
}

footstep_animations.forcestaff_p2_m1 = footstep_animations.forcestaff_p1_m1
footstep_animations.forcestaff_p3_m1 = footstep_animations.forcestaff_p1_m1
footstep_animations.forcestaff_p4_m1 = footstep_animations.forcestaff_p1_m1
footstep_animations.autogun_p1_m2 = footstep_animations.autogun_p1_m1
footstep_animations.autogun_p1_m3 = footstep_animations.autogun_p1_m1
footstep_animations.autogun_p2_m1 = footstep_animations.autogun_p1_m1
footstep_animations.autogun_p2_m2 = footstep_animations.autogun_p1_m1
footstep_animations.autogun_p2_m3 = footstep_animations.autogun_p1_m1
footstep_animations.autogun_p3_m1 = footstep_animations.autogun_p1_m1
footstep_animations.autogun_p3_m2 = footstep_animations.autogun_p1_m1
footstep_animations.autogun_p3_m3 = footstep_animations.autogun_p1_m1

local sounds = {
    [BREED_HUMAN] = human.sounds,
    [BREED_OGRYN] = ogryn.sounds,
    autogun_p1_m1 = autogun_p1_m1.sounds,

    ogryn_powermaul_slabshield_p1_m1 = {
        crouching = {
            "sfx_grab_weapon",
            "sfx_foley_equip",
        },
        default = {
            "sfx_equip",
            "sfx_weapon_foley_left_hand_01",
            "sfx_weapon_foley_left_hand_02",
            "sfx_swing",
        },
        accent = {
            "sfx_equip_02",
            "sfx_magazine_eject",
            "sfx_swing_heavy",
        },
    },

    default = {
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

sounds.autogun_p1_m2 = sounds.autogun_p1_m1
sounds.autogun_p1_m3 = sounds.autogun_p1_m1
sounds.autogun_p2_m1 = sounds.autogun_p1_m1
sounds.autogun_p2_m2 = sounds.autogun_p1_m1
sounds.autogun_p2_m3 = sounds.autogun_p1_m1
sounds.autogun_p3_m1 = sounds.autogun_p1_m1
sounds.autogun_p3_m2 = sounds.autogun_p1_m1
sounds.autogun_p3_m3 = sounds.autogun_p1_m1

local backpacks = {
    backpack_scions_a = backpack_scions_a,
    default = {
        width = 2,
    },
}

return {
    sounds = sounds,
    offsets = offsets,
    footstep_animations = footstep_animations,
}
