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
    offsets = medium_ranged_offsets,
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
    hide_attachments = {
        "ammo",
        "ammo_used",
        "special_ammo_01",
        "special_ammo_02",
        "special_ammo_03",
        "special_ammo_04",
        "special_ammo_05",
        "special_ammo_06",
    },
}