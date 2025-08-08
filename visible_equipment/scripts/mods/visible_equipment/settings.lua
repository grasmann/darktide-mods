local mod = get_mod("visible_equipment")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local ogryn = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/breeds/ogryn")
local human = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/breeds/human")
local autogun_p1_m1 = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/weapons/autogun_p1_m1")

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

local breed_human = "human"
local breed_ogryn = "ogryn"
local WEAPON_MELEE = "WEAPON_MELEE"
local WEAPON_RANGED = "WEAPON_RANGED"

local offsets = {
    [breed_human] = human.offsets,
    [breed_ogryn] = ogryn.offsets,
    autogun_p1_m1 = autogun_p1_m1.offsets,

    forcestaff_p1_m1 = {
        default = {
            right = {
                position = vector3_box(.3, .175, -.15),
                rotation = vector3_box(0, 90, 90),
            },
        },
        backpack = {
            right = {
                position = vector3_box(.3, .175, -.25),
                rotation = vector3_box(0, 90, 90),
            },
        },
    },
}

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
    [breed_human] = human.footstep_animations,
    [breed_ogryn] = ogryn.footstep_animations,
    autogun_p1_m1 = autogun_p1_m1.footstep_animations,

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

footstep_animations.autogun_p1_m2 = footstep_animations.autogun_p1_m1
footstep_animations.autogun_p1_m3 = footstep_animations.autogun_p1_m1
footstep_animations.autogun_p2_m1 = footstep_animations.autogun_p1_m1
footstep_animations.autogun_p2_m2 = footstep_animations.autogun_p1_m1
footstep_animations.autogun_p2_m3 = footstep_animations.autogun_p1_m1
footstep_animations.autogun_p3_m1 = footstep_animations.autogun_p1_m1
footstep_animations.autogun_p3_m2 = footstep_animations.autogun_p1_m1
footstep_animations.autogun_p3_m3 = footstep_animations.autogun_p1_m1

local sounds = {
    [breed_human] = human.sounds,
    [breed_ogryn] = ogryn.sounds,
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

return {
    sounds = sounds,
    offsets = offsets,
    footstep_animations = footstep_animations,
}
