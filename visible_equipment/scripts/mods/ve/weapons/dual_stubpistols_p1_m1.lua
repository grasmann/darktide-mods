local mod = get_mod("visible_equipment")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local table = table
    local vector3 = Vector3
    local vector3_box = Vector3Box
    local vector3_zero = vector3.zero
    local table_merge_recursive_n = table.merge_recursive_n
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local medium_melee_offset = mod:io_dofile("visible_equipment/scripts/mods/ve/templates/offsets/medium_melee")
local medium_melee_animation = mod:io_dofile("visible_equipment/scripts/mods/ve/templates/animations/medium_melee")

local shield_a_offset = mod:io_dofile("visible_equipment/scripts/mods/ve/templates/offsets/shield_a")
local shield_animation = mod:io_dofile("visible_equipment/scripts/mods/ve/templates/animations/shield")

local offsets = table_merge_recursive_n(nil, medium_melee_offset, shield_a_offset)
local animations = table_merge_recursive_n(nil, medium_melee_animation, shield_animation)

return {
    offsets = {
        default = {
            right = {
                node = "j_spine2",
                position = vector3_box(.16, .21, -.08),
                rotation = vector3_box(-10, 0, 90),
                center_mass = vector3_box(0, -.1, -.08),
            },
            left = {
                node = "j_spine2",
                position = vector3_box(-.16, .21, -.08),
                rotation = vector3_box(10, 0, 90),
                center_mass = vector3_box(0, -.1, -.08),
            },
        },
        hip_front = {
            right = {
                node = "j_hips",
                position = vector3_box(-.022, .27, .02),
                rotation = vector3_box(0, -20, 90),
                center_mass = vector3_box(-.1, -.07, -.08),
            },
            left = {
                node = "j_hips",
                position = vector3_box(.022, .27, .02),
                rotation = vector3_box(0, 20, 90),
                center_mass = vector3_box(.1, -.07, -.08),
            },
        },
        hip_back = {
            right = {
                node = "j_hips",
                position = vector3_box(-.05, -.27, .02),
                rotation = vector3_box(0, 0, 90),
                center_mass = vector3_box(.1, -.07, -.08),
            },
            left = {
                node = "j_hips",
                position = vector3_box(.05, -.27, .02),
                rotation = vector3_box(0, 0, 90),
                center_mass = vector3_box(-.1, -.07, -.08),
            },
        },
        leg_left = {
            right = {
                node = "j_leftupleg",
                position = vector3_box(0, .03, -.16),
                rotation = vector3_box(290, 220, 100),
                center_mass = vector3_box(.03, .1, -.07),
            },
            left = {
                node = "j_rightupleg",
                position = vector3_box(.005, -.06, .03),
                rotation = vector3_box(290, 220 + 180, 280 + 180),
                center_mass = vector3_box(-.02, .1, -.07),
            },
        },
        -- leg_right = {
        --     right = {
        --         node = "j_rightupleg",
        --         position = vector3_box(.005, -.06, .03),
        --         rotation = vector3_box(290, 220 + 180, 280 + 180),
        --         center_mass = vector3_box(-.02, .1, -.07),
        --     },
        -- },
        hip_left = {
            right = {
                node = "j_hips",
                position = vector3_box(-.09, -.01, .06),
                rotation = vector3_box(180+45, 180, -30),
                center_mass = vector3_box(.1, -.06, -.09),
            },
            left = {
                node = "j_hips",
                position = vector3_box(.09, .01, .06),
                rotation = vector3_box(180+45, 180, 30),
                center_mass = vector3_box(-.1, -.06, -.09),
            },
        },
        -- hip_right = {
        --     right = {
        --         node = "j_hips",
        --         position = vector3_box(.09, .01, .06),
        --         rotation = vector3_box(180+45, 180, 30),
        --         center_mass = vector3_box(-.1, -.06, -.09),
        --     },
        -- },
        backpack = {
            right = {
                node = "j_spine2",
                position = vector3_box(.14, .25, -.2),
                rotation = vector3_box(-30, 0, 90),
                center_mass = vector3_box(0, -.1, -.16),
            },
            left = {
                node = "j_spine2",
                position = vector3_box(-.14, .25, -.2),
                rotation = vector3_box(30, 0, 90),
                center_mass = vector3_box(0, -.1, -.16),
            },
        },
    },
    animations = animations,
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