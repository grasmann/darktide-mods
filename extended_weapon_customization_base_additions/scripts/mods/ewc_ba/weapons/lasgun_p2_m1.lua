local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local lasgun_infantry_group = {custom_selection_group = "lasgun_infantry"}
local lasgun_recon_group = {custom_selection_group = "lasgun_recon"}
local laspistol_group = {custom_selection_group = "laspistol"}

local barrel_lasgun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/barrel_lasgun_infantry")
local muzzle_lasgun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_lasgun_infantry")
mod:merge_attachment_data(lasgun_infantry_group, barrel_lasgun_infantry, muzzle_lasgun_infantry)

local barrel_lasgun_recon = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/barrel_lasgun_recon")
local muzzle_lasgun_recon = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_lasgun_recon")
mod:merge_attachment_data(lasgun_recon_group, barrel_lasgun_recon, muzzle_lasgun_recon)

local magazine_laspistol = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_laspistol")
local muzzle_laspistol = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_laspistol")
mod:merge_attachment_data(laspistol_group, magazine_laspistol, muzzle_laspistol)

local flashlight_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/flashlight_human")
local sight_reflex = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_reflex")
local sight_scope = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_scope")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local table = table
    local vector3 = Vector3
    local vector3_box = Vector3Box
    local table_clone = table.clone
    local vector3_zero = vector3.zero
    local table_merge_recursive = table.merge_recursive
    local table_merge_recursive_n = table.merge_recursive_n
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

local laspistol_muzzles = "lasgun_pistol_muzzle_01|lasgun_pistol_muzzle_02|lasgun_pistol_muzzle_03|lasgun_pistol_muzzle_04|lasgun_pistol_muzzle_05|lasgun_pistol_muzzle_ml01"
local lasgun_recon_muzzles = "lasgun_rifle_elysian_muzzle_01|lasgun_rifle_elysian_muzzle_02|lasgun_rifle_elysian_muzzle_03|lasgun_rifle_elysian_muzzle_ml01"

local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local scopes = "scope_01"

local attachments = {
    lasgun_p2_m1 = {
        magazine = magazine_laspistol,
        flashlight = flashlight_human,
        muzzle = table_merge_recursive_n(nil, muzzle_lasgun_infantry, muzzle_lasgun_recon, muzzle_laspistol),
        sight = table_merge_recursive_n(nil, sight_reflex, sight_scope),
        barrel = table_merge_recursive_n(nil, barrel_lasgun_recon, barrel_lasgun_infantry),
    },
}

attachments.lasgun_p2_m2 = table_clone(attachments.lasgun_p2_m1)
attachments.lasgun_p2_m3 = table_clone(attachments.lasgun_p2_m1)

local fixes = {
    lasgun_p2_m1 = {
        {attachment_slot = "sight",
            requirements = {
                sight = {
                    has = scopes,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.03, .024),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "sight_offset",
            requirements = {
                sight = {
                    has = "reflex_sight_01",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.02275),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        {attachment_slot = "sight_offset",
            requirements = {
                sight = {
                    has = "reflex_sight_02|reflex_sight_03",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.0225),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        {attachment_slot = "sight_offset",
            requirements = {
                sight = {
                    has = scopes,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.047),
                    rotation = vector3_box(0, 0, 0),
                    custom_fov = 32.5,
                    aim_scale = .5,
                    fov = 25,
                },
            },
        },
        {attachment_slot = "bayonet",
            requirements = {
                muzzle = {
                    has = laspistol_muzzles.."|"..lasgun_recon_muzzles,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .075, -.0325),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
    },
}

fixes.lasgun_p2_m2 = table_clone(fixes.lasgun_p2_m1)
fixes.lasgun_p2_m3 = table_clone(fixes.lasgun_p2_m1)

return {
    attachments = attachments,
    fixes = fixes,
}
