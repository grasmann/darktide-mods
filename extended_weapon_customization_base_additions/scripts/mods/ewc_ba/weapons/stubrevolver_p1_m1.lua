local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

-- local trinket_hooks = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/trinket_hook")
-- local flashlights = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/flashlight")
-- local sights = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/sight")
-- local rails = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/rail")
-- local muzzles = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/muzzle")
-- local emblem_left = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/emblem_left")
-- local emblem_right = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/emblem_right")

local autogun_infantry_group = {custom_selection_group = "autogun_infantry"}
local autogun_braced_group = {custom_selection_group = "autogun_braced"}
local autogun_headhunter_group = {custom_selection_group = "autogun_headhunter"}
local shotgun_double_barrel_group = {custom_selection_group = "shotgun_double_barrel"}

local stock_shotgun_double_barrel = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/stock_shotgun_double_barrel")
mod:merge_attachment_data(shotgun_double_barrel_group, stock_shotgun_double_barrel)

local muzzle_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_infantry")
mod:merge_attachment_data(autogun_infantry_group, muzzle_autogun_infantry)

local muzzle_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_braced")
mod:merge_attachment_data(autogun_braced_group, muzzle_autogun_braced)

local muzzle_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_headhunter")
mod:merge_attachment_data(autogun_headhunter_group, muzzle_autogun_headhunter)

local suppressor_group = {custom_selection_group = "suppressors"}
local muzzle_suppressors = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_suppressors")
mod:merge_attachment_data(suppressor_group, muzzle_suppressors)

local flashlight_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/flashlight_human")
local sight_reflex = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_reflex")
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
local _item_melee = _item.."/melee"
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local scopes = "scope_01"

local attachments = {
    stubrevolver_p1_m1 = {
        rail = rails,
        flashlight = flashlight_human,
        stock = stock_shotgun_double_barrel,
        sight = table_merge_recursive_n(nil, sight_reflex, sight_scope),
        muzzle = table_merge_recursive_n(nil, muzzle_autogun_infantry, muzzle_autogun_braced, muzzle_autogun_headhunter, muzzle_suppressors),
    },
}

attachments.stubrevolver_p1_m2 = table_clone(attachments.stubrevolver_p1_m1)
attachments.stubrevolver_p1_m3 = table_clone(attachments.stubrevolver_p1_m1)

local attachment_slots = {
    stubrevolver_p1_m1 = {
        sight = {
            parent_slot = "rail",
            default_path = _item_empty_trinket,
        },
        flashlight = {
            parent_slot = "sight",
            default_path = _item_empty_trinket,
        },
        muzzle = {
            parent_slot = "rail",
            default_path = _item_empty_trinket,
        },
        stock = {
            parent_slot = "body",
            default_path = _item_empty_trinket,
        },
    },
}

attachment_slots.stubrevolver_p1_m2 = table_clone(attachment_slots.stubrevolver_p1_m1)
attachment_slots.stubrevolver_p1_m3 = table_clone(attachment_slots.stubrevolver_p1_m1)

local fixes = {
    stubrevolver_p1_m1 = {
        {attachment_slot = "stock",
            fix = {
                offset = {
                    position = vector3_box(0, -.1, -.1),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "flashlight",
            fix = {
                offset = {
                    position = vector3_box(.02, .095, -.07),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(.5, .5, .5),
                    node = 1,
                },
            },
        },
        {attachment_slot = "sight_offset",
            requirements = {
                sight = {
                    has = reflex_sights.."|"..scopes,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.0315),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        {attachment_slot = "rail",
            requirements = {
                sight = {
                    has = reflex_sights.."|"..scopes,
                },
            },
            fix = {
                attach = {
                    rail = "lasgun_pistol_rail_01",
                },
                offset = {
                    position = vector3_box(0, -.07, .01),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "rail",
            requirements = {
                sight = {
                    missing = reflex_sights.."|"..scopes,
                },
            },
            fix = {
                attach = {
                    rail = "stubgun_pistol_rail_off",
                },
                offset = {
                    position = vector3_box(0, -.07, .01),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "muzzle",
            requirements = {
                barrel = {
                    has = "stubgun_pistol_barrel_04|stubgun_pistol_barrel_06",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .1675, -.037),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "muzzle",
            requirements = {
                barrel = {
                    has = "stubgun_pistol_barrel_03|stubgun_pistol_barrel_ml01",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .1825, -.041),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "muzzle",
            requirements = {
                barrel = {
                    has = "stubgun_pistol_barrel_02",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .2025, -.0405),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "muzzle",
            requirements = {
                barrel = {
                    has = "stubgun_pistol_barrel_05",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .1875, -.039),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "muzzle",
            requirements = {
                barrel = {
                    has = "stubgun_pistol_barrel_01",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .1675, -.037),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
    },
}

fixes.stubrevolver_p1_m2 = table_clone(fixes.stubrevolver_p1_m1)
fixes.stubrevolver_p1_m3 = table_clone(fixes.stubrevolver_p1_m1)

return {
    attachments = attachments,
    fixes = fixes,
    attachment_slots = attachment_slots,
}
