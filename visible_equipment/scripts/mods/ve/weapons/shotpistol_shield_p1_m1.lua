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

local small_ranged_offset = mod:io_dofile("visible_equipment/scripts/mods/ve/templates/offsets/small_ranged")
local medium_ranged_animations = mod:io_dofile("visible_equipment/scripts/mods/ve/templates/animations/medium_ranged")

local shield_b_offset = mod:io_dofile("visible_equipment/scripts/mods/ve/templates/offsets/shield_b")
local shield_animation = mod:io_dofile("visible_equipment/scripts/mods/ve/templates/animations/shield")

local offsets = table_merge_recursive_n(nil, small_ranged_offset, shield_b_offset)
local animations = table_merge_recursive_n(nil, medium_ranged_animations, shield_animation)

return {
    offsets = offsets,
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