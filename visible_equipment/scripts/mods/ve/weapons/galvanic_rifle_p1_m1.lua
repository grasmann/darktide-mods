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

local medium_ranged_offsets = mod:io_dofile("visible_equipment/scripts/mods/ve/templates/offsets/medium_ranged")
local medium_ranged_animations = mod:io_dofile("visible_equipment/scripts/mods/ve/templates/animations/medium_ranged")

return {
    offsets = {
        default = {
            right = {
                node = "j_spine2",
                position = vector3_box(.16, .21, -.08),
                rotation = vector3_box(-10, 0, 90),
                center_mass = vector3_box(0, -.35, -.08),
            },
        },
        hip_front = {
            right = {
                node = "j_hips",
                position = vector3_box(-.022, .27, .02),
                rotation = vector3_box(0, -20, 90),
                center_mass = vector3_box(-.1, -.35, -.08),
            },
        },
        hip_back = {
            right = {
                node = "j_hips",
                position = vector3_box(-.05, -.27, .02),
                rotation = vector3_box(0, 0, 90),
                center_mass = vector3_box(.1, -.35, -.08),
            },
        },
        hip_left = {
            right = {
                node = "j_hips",
                position = vector3_box(-.09, -.01, .06),
                rotation = vector3_box(180+45, 180, 0),
                center_mass = vector3_box(.1, -.35, -.09),
            },
        },
        hip_right = {
            right = {
                node = "j_hips",
                position = vector3_box(.09, .01, .06),
                rotation = vector3_box(180+45, 180, 30),
                center_mass = vector3_box(-.1, -.35, -.09),
            },
        },
        backpack = {
            right = {
                node = "j_spine2",
                position = vector3_box(.22, .26, -.16),
                rotation = vector3_box(-30, 0, 90),
                center_mass = vector3_box(0, -.35, -.16),
            },
        },
    },
    animations = medium_ranged_animations,
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