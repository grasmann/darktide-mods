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
}