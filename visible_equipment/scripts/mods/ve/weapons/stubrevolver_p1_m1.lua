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

local small_ranged_offset = mod:io_dofile("visible_equipment/scripts/mods/ve/templates/offsets/medium_ranged")
local medium_ranged_animations = mod:io_dofile("visible_equipment/scripts/mods/ve/templates/animations/medium_ranged")

return {
    offsets = small_ranged_offset,
    animations = medium_ranged_animations,
    sounds = {
        crouching = {
            "sfx_ads_up",
            "sfx_ads_down",
        },
        default = {
            "sfx_weapon_up",
            "sfx_weapon_down",
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
        "bullet_01",
        "bullet_02",
        "bullet_03",
        "bullet_04",
        "bullet_05",
        "casing_01",
        "casing_02",
        "casing_03",
        "casing_04",
        "casing_05",
    },
}