local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local lasgun_infantry_group = {custom_selection_group = "lasgun_infantry"}
local lasgun_helbore_group = {custom_selection_group = "lasgun_helbore"}

local barrel_lasgun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/barrel_lasgun_infantry")
local muzzle_lasgun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_lasgun_infantry")
mod:merge_attachment_data(lasgun_infantry_group, barrel_lasgun_infantry, muzzle_lasgun_infantry)

local barrel_lasgun_helbore = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/barrel_lasgun_helbore")
local muzzle_lasgun_helbore = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_lasgun_helbore")
mod:merge_attachment_data(lasgun_helbore_group, barrel_lasgun_helbore, muzzle_lasgun_helbore)

local flashlight_modded_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/flashlight_modded_human")
local laser_pointer_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/laser_pointer_human")
local sight_reflex = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_reflex")
local grip_common = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_common")
local sight_scope = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_scope")
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

local short_receivers = "lasgun_rifle_elysian_receiver_01|lasgun_rifle_elysian_receiver_04|lasgun_rifle_elysian_receiver_05|lasgun_rifle_elysian_receiver_06|lasgun_rifle_elysian_receiver_07|lasgun_rifle_elysian_receiver_08"
local medium_receivers = "lasgun_rifle_elysian_receiver_03"
local long_receivers = "lasgun_rifle_elysian_receiver_02|lasgun_rifle_elysian_receiver_ml01"
local sights = "lasgun_rifle_elysian_sight_01|lasgun_rifle_elysian_sight_02|lasgun_rifle_elysian_sight_03"
local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local scopes = "scope_01"

local attachments = {
    lasgun_p3_m1 = {
        rail = rails,
        grip = grip_common,
        flashlight = table_merge_recursive_n(nil, laser_pointer_human, flashlight_modded_human),
        sight = table_merge_recursive_n(nil, sight_scope, sight_reflex),
        barrel = table_merge_recursive_n(nil, barrel_lasgun_infantry, barrel_lasgun_helbore),
    },
}

attachments.lasgun_p3_m2 = table_clone(attachments.lasgun_p3_m1)
attachments.lasgun_p3_m3 = table_clone(attachments.lasgun_p3_m1)

local fixes = {
    lasgun_p3_m1 = {
        {attachment_slot = "sight_offset",
            requirements = {
                sight = {
                    has = reflex_sights,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.0335),
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
                    position = vector3_box(0, -.05, -.046),
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
                    has = sights,
                },
                receiver = {
                    has = short_receivers,
                },
            },
            fix = {
                attach = {
                    sight = "lasgun_rifle_elysian_sight_01",
                },
            },
        },
        {attachment_slot = "sight",
            requirements = {
                sight = {
                    has = sights,
                },
                receiver = {
                    has = medium_receivers,
                },
            },
            fix = {
                attach = {
                    sight = "lasgun_rifle_elysian_sight_03",
                },
            },
        },
        {attachment_slot = "sight",
            requirements = {
                sight = {
                    has = sights,
                },
                receiver = {
                    has = long_receivers,
                },
            },
            fix = {
                attach = {
                    sight = "lasgun_rifle_elysian_sight_02",
                },
            },
        },
        {attachment_slot = "sight",
            requirements = {
                sight = {
                    has = reflex_sights,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .05, .0075),
                    rotation = vector3_box(0, 0, 0),
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
                    position = vector3_box(0, .02, .02),
                    rotation = vector3_box(0, 0, 0),
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
                    position = vector3_box(0, .05, .0075),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        {attachment_slot = "rail",
            requirements = {
                sight = {
                    has = scopes.."|"..sights,
                },
            },
            fix = {
                attach = {
                    rail = "stubgun_pistol_rail_off",
                },
            },
        },
    },
}

fixes.lasgun_p3_m2 = table_clone(fixes.lasgun_p3_m1)
fixes.lasgun_p3_m3 = table_clone(fixes.lasgun_p3_m1)

return {
    attachments = attachments,
    fixes = fixes,
}
