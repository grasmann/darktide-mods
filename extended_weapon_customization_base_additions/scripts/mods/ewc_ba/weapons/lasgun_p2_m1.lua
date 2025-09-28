local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local barrel_lasgun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/barrel_lasgun_infantry")
local barrel_lasgun_recon = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/barrel_lasgun_recon")
local magazine_laspistol = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_laspistol")
local flashlight_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/flashlight_human")
local sight_reflex = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_reflex")
local sight_scope = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_scope")
local grip_common = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_common")
local rails = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/rail")

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

local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local scopes = "scope_01"

local attachments = {
    lasgun_p2_m1 = {
        rail = rails,
        grip = grip_common,
        magazine = magazine_laspistol,
        flashlight = flashlight_human,
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
    },
}

fixes.lasgun_p2_m2 = table_clone(fixes.lasgun_p2_m1)
fixes.lasgun_p2_m3 = table_clone(fixes.lasgun_p2_m1)

return {
    attachments = attachments,
    fixes = fixes,
}
