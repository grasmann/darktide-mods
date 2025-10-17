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

local large_melee_animation = mod:io_dofile("visible_equipment/scripts/mods/ve/templates/animations/large_melee")

return {
    offsets = {
        default = {
        	right = {
				node = "j_spine2",
				position = vector3_box(.3, .175, -.15),
				rotation = vector3_box(-30, 90, -90),
			},
		},
        backpack = {
            right = {
                node = "j_spine2",
                position = vector3_box(.3, .175, -.25),
                rotation = vector3_box(0, 90, -90),
            },
        },
    },
    animations = large_melee_animation,
    sounds = {
        crouching = {
            "sfx_ads_up",
            "sfx_ads_down",
        },
        default = {
            "sfx_ads_up",
            "sfx_ads_down",
            -- "sfx_equip",
            -- "sfx_inspect",
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
            momentum = vector3_box(1, 0, 3),
        },
    },
}