local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local lasgun_helbore_group = {custom_selection_group = "lasgun_helbore"}
local lasgun_recon_group = {custom_selection_group = "lasgun_recon"}
local laspistol_group = {custom_selection_group = "laspistol"}

local barrel_lasgun_helbore = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/barrel_lasgun_helbore")
local muzzle_lasgun_helbore = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_lasgun_helbore")
mod:merge_attachment_data(lasgun_helbore_group, barrel_lasgun_helbore, muzzle_lasgun_helbore)

local barrel_lasgun_recon = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/barrel_lasgun_recon")
local muzzle_lasgun_recon = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_lasgun_recon")
mod:merge_attachment_data(lasgun_recon_group, barrel_lasgun_recon, muzzle_lasgun_recon)

local magazine_laspistol = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_laspistol")
local muzzle_laspistol = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_laspistol")
mod:merge_attachment_data(laspistol_group, magazine_laspistol, muzzle_laspistol)

local flashlight_modded_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/flashlight_modded_human")
local laser_pointer_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/laser_pointer_human")
local sight_scope = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_scope")
local grip_common = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_common")

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
    lasgun_p1_m1 = {
        grip = grip_common,
        sight = sight_scope,
        magazine = magazine_laspistol,
        muzzle = table_merge_recursive_n(nil, muzzle_lasgun_helbore, muzzle_lasgun_recon, muzzle_laspistol),
        flashlight = table_merge_recursive_n(nil, laser_pointer_human, flashlight_modded_human),
        barrel = table_merge_recursive_n(nil, barrel_lasgun_recon, barrel_lasgun_helbore),
    },
}

attachments.lasgun_p1_m2 = table_clone(attachments.lasgun_p1_m1)
attachments.lasgun_p1_m3 = table_clone(attachments.lasgun_p1_m1)
attachments.high_bot_lasgun_killshot = table_clone(attachments.lasgun_p1_m1)
attachments.bot_lasgun_killshot = table_clone(attachments.lasgun_p1_m1)

local fixes = {
    lasgun_p1_m1 = {
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
                    position = vector3_box(0, -.03, .0065),
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
                    rail = "lasgun_rifle_rail_01",
                },
                offset = {
                    position = vector3_box(0, 0, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "receiver",
            requirements = {
                sight = {
                    has = scopes,
                },
            },
            fix = {
                hide = {
                    mesh = {5},
                },
            },
        },
    },
}

fixes.lasgun_p1_m2 = table_clone(fixes.lasgun_p1_m1)
fixes.lasgun_p1_m3 = table_clone(fixes.lasgun_p1_m1)
fixes.high_bot_lasgun_killshot = table_clone(fixes.lasgun_p1_m1)
fixes.bot_lasgun_killshot = table_clone(fixes.lasgun_p1_m1)

return {
    attachments = attachments,
    fixes = fixes,
}
