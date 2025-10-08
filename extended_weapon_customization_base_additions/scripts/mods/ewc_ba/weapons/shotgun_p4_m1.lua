local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local autogun_headhunter_group = {custom_selection_group = "autogun_headhunter"}
local autogun_infantry_group = {custom_selection_group = "autogun_infantry"}
local autogun_braced_group = {custom_selection_group = "autogun_braced"}

local muzzle_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_headhunter")
mod:merge_attachment_data(autogun_headhunter_group, muzzle_autogun_headhunter)

local muzzle_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_braced")
mod:merge_attachment_data(autogun_braced_group, muzzle_autogun_braced)

local muzzle_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_infantry")
mod:merge_attachment_data(autogun_infantry_group, muzzle_autogun_infantry)

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

local short_receivers = "assault_shotgun_receiver_01|assault_shotgun_receiver_03|assault_shotgun_receiver_deluxe01|assault_shotgun_receiver_ml01"
local long_receivers = "assault_shotgun_receiver_02"
local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local scopes = "scope_01"

local attachments = {
    shotgun_p4_m1 = {
        rail2 = rails,
        grip = grip_common,
        muzzle = table_merge_recursive_n(nil, muzzle_autogun_headhunter, muzzle_autogun_braced, muzzle_autogun_infantry),
        flashlight = flashlight_human,
        sight = table_merge_recursive_n(nil, sight_reflex, sight_scope),
    },
}

attachments.shotgun_p4_m2 = table_clone(attachments.shotgun_p4_m1)
attachments.shotgun_p4_m3 = table_clone(attachments.shotgun_p4_m1)

local attachment_slots = {
    shotgun_p4_m1 = {
        flashlight = {
            parent_slot = "receiver",
            default_path = _item_empty_trinket,
            fix = {
                offset = {
                    position = vector3_box(.075, .8, .3),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        muzzle = {
            parent_slot = "receiver",
            default_path = _item_empty_trinket,
        },
        sight = {
            parent_slot = "rail2",
            default_path = _item_empty_trinket,
        },
        rail2 = {
            parent_slot = "receiver",
            default_path = _item_empty_trinket,
            fix = {
                offset = {
                    position = vector3_box(-.035, -.25, 0),
                    rotation = vector3_box(0, -45, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
    },
}

attachment_slots.shotgun_p4_m2 = table_clone(attachment_slots.shotgun_p4_m1)
attachment_slots.shotgun_p4_m3 = table_clone(attachment_slots.shotgun_p4_m1)

local fixes = {
    shotgun_p4_m1 = {
        {attachment_slot = "sight_offset",
            requirements = {
                sight = {
                    has = reflex_sights,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(-.09, 0, .13),
                    rotation = vector3_box(-6, 0, -5.5),
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
                    -- position = vector3_box(.016, -.05, .1325),
                    -- rotation = vector3_box(-7.5, 35, 0),
                    position = vector3_box(-.068, 0, .117),
                    rotation = vector3_box(-6, 0, -5),
                    custom_fov = 32.5,
                    aim_scale = .5,
                    fov = 25,
                },
            },
        },
        {attachment_slot = "flashlight",
            fix = {
                offset = {
                    position = vector3_box(.0325, .58, .11),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "muzzle",
            requirements = {
                receiver = {
                    has = short_receivers,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .64, .11),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1.5, 1.5, 1.5),
                    node = 1,
                },
            },
        },
        {attachment_slot = "muzzle",
            requirements = {
                receiver = {
                    has = long_receivers,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .755, .11),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1.5, 1.5, 1.5),
                    node = 1,
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
                    position = vector3_box(0, 0, .0235),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "rail2",
            requirements = {
                sight = {
                    has = reflex_sights,
                },
            },
            fix = {
                attach = {
                    rail2 = "lasgun_pistol_rail_01",
                },
            },
        },
        {attachment_slot = "rail2",
            requirements = {
                sight = {
                    missing = reflex_sights,
                },
            },
            fix = {
                attach = {
                    rail2 = "stubgun_pistol_rail_off",
                },
            },
        },
        {attachment_slot = "rail",
            requirements = {
                receiver = {
                    has = long_receivers,
                },
                rail = {
                    missing = "assault_shotgun_rail_02",
                }
            },
            fix = {
                attach = {
                    rail = "assault_shotgun_rail_02",
                },
            },
        },
        {attachment_slot = "rail",
            requirements = {
                receiver = {
                    has = short_receivers,
                },
                rail = {
                    missing = "assault_shotgun_rail_01",
                }
            },
            fix = {
                attach = {
                    rail = "assault_shotgun_rail_01",
                },
            },
        },
    },
}

fixes.shotgun_p4_m2 = table_clone(fixes.shotgun_p4_m1)
fixes.shotgun_p4_m3 = table_clone(fixes.shotgun_p4_m1)

return {
    attachments = attachments,
    attachment_slots = attachment_slots,
    fixes = fixes,
}
