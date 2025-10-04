local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local magazine_lasgun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_lasgun_infantry")
mod:modify_customization_groups(magazine_lasgun_infantry, "lasgun_infantry")
local muzzle_lasgun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_lasgun_infantry")
mod:modify_customization_groups(muzzle_lasgun_infantry, "lasgun_infantry")

local magazine_lasgun_helbore = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_lasgun_helbore")
mod:modify_customization_groups(magazine_lasgun_helbore, "lasgun_helbore")
local muzzle_lasgun_helbore = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_lasgun_helbore")
mod:modify_customization_groups(muzzle_lasgun_helbore, "lasgun_helbore")

local muzzle_lasgun_recon = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_lasgun_recon")
mod:modify_customization_groups(muzzle_lasgun_helbore, "lasgun_recon")

local muzzle_laspistol = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_laspistol")
mod:modify_customization_groups(magazine_lasgun_helbore, "laspistol")

local flashlight_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/flashlight_human")
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

local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local scopes = "scope_01"

local attachments = {
    laspistol_p1_m1 = {
        muzzle = table_merge_recursive_n(nil, muzzle_laspistol, muzzle_lasgun_infantry, muzzle_lasgun_helbore),
        sight = sight_scope,
        flashlight = flashlight_human,
        magazine = table_merge_recursive_n(nil, magazine_lasgun_infantry, magazine_lasgun_helbore),
    }
}

attachments.laspistol_p1_m2 = table_clone(attachments.laspistol_p1_m1)
attachments.laspistol_p1_m3 = table_clone(attachments.laspistol_p1_m1)

local fixes = {
    laspistol_p1_m1 = {
        {attachment_slot = "sight_offset",
            requirements = {
                sight = {
                    has = scopes,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.05, -.0065),
                    rotation = vector3_box(0, 0, 0),
                    custom_fov = 32.5,
                    aim_scale = .5,
                    fov = 25,
                },
            },
        },
        {attachment_slot = "sight",
            requirements = {
                sight = {
                    has = scopes,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.0375, .008),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "flashlight",
            fix = {
                offset = {
                    position = vector3_box(.03, 0, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "rail",
            requirements = {
                sight = {
                    has = scopes,
                },
            },
            fix = {
                attach = {
                    rail = "stubgun_pistol_rail_off",
                },
                offset = {
                    position = vector3_box(0, 0, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "rail",
            requirements = {
                sight = {
                    has = reflex_sights,
                },
            },
            fix = {
                attach = {
                    rail = "lasgun_pistol_rail_01",
                },
                offset = {
                    position = vector3_box(0, 0, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        -- {attachment_slot = "receiver",
        --     requirements = {
        --         sight = {
        --             has = scopes,
        --         },
        --     },
        --     fix = {
        --         hide = {
        --             mesh = {5},
        --         },
        --     },
        -- },
    },
}

fixes.laspistol_p1_m2 = table_clone(fixes.laspistol_p1_m1)
fixes.laspistol_p1_m3 = table_clone(fixes.laspistol_p1_m1)

return {
    attachments = attachments,
    fixes = fixes,
}
