local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local rails = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/rail")
local flashlight_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/flashlight_human")
local sight_reflex = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_reflex")
local sight_scope = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_scope")

local autogun_infantry_group = {custom_selection_group = "autogun_infantry"}
-- local magazine_autogun_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_double")
local magazine_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_infantry")
local muzzle_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_infantry")
mod:merge_attachment_data(autogun_infantry_group, magazine_autogun_infantry, muzzle_autogun_infantry)

local autogun_headhunter_group = {custom_selection_group = "autogun_headhunter"}
local muzzle_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_headhunter")
local magazine_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_headhunter")
mod:merge_attachment_data(autogun_headhunter_group, muzzle_autogun_headhunter, magazine_autogun_headhunter)

local autogun_braced_group = {custom_selection_group = "autogun_braced"}
local muzzle_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_braced")
local magazine_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_braced")
mod:merge_attachment_data(autogun_braced_group, muzzle_autogun_braced, magazine_autogun_braced)

local autopistol_group = {custom_selection_group = "autopistol"}
-- local magazine_autopistol_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autopistol_double")
local magazine_autopistol = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autopistol")
mod:merge_attachment_data(autopistol_group, magazine_autopistol)

local magazine_laser_group = {custom_selection_group = "magazine_laser"}
local magazine_laser = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_laser_autogun")
mod:merge_attachment_data(magazine_laser_group, magazine_laser)

local bolter_group = {custom_selection_group = "bolter"}
local magazine_bolter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_bolter")
-- local magazine_bolter_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_bolter_double")
mod:merge_attachment_data(bolter_group, magazine_bolter)

local suppressor_group = {custom_selection_group = "suppressors"}
local muzzle_suppressors = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_suppressors")
mod:merge_attachment_data(suppressor_group, muzzle_suppressors)

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
local _item_melee = _item.."/melee"
local _item_ranged = _item.."/ranged"
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

local bolter_magazines = "boltgun_rifle_magazine_01_ba|boltgun_rifle_magazine_02_ba|boltgun_rifle_magazine_01_double|boltgun_rifle_magazine_02_double"
local laser_magazines = "autogun_rifle_laser_magazine_01|autogun_rifle_laser_magazine_02|autogun_rifle_laser_magazine_03"
local autopistol_magazines = "autogun_pistol_magazine_01|autogun_pistol_magazine_01_double"
local braced_muzzles = "autogun_rifle_ak_muzzle_01|autogun_rifle_ak_muzzle_02|autogun_rifle_ak_muzzle_03|autogun_rifle_ak_muzzle_04|autogun_rifle_ak_muzzle_05|autogun_rifle_ak_muzzle_ml01|autogun_rifle_invisible_muzzle_01"
local infantry_muzzles = "autogun_rifle_muzzle_01|autogun_rifle_muzzle_02|autogun_rifle_muzzle_03|autogun_rifle_muzzle_04|autogun_rifle_muzzle_05|autogun_rifle_muzzle_ml01|autogun_rifle_invisible_muzzle_01"
local headhunter_muzzles = "autogun_rifle_killshot_muzzle_01|autogun_rifle_killshot_muzzle_03|autogun_rifle_killshot_muzzle_04|autogun_rifle_killshot_muzzle_05|autogun_rifle_killshot_muzzle_ml01"
local suppressors = "autogun_rifle_suppressed_muzzle_01|autogun_rifle_suppressed_muzzle_02|autogun_rifle_suppressed_muzzle_03"
local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local scope_sights = "scope_01"

local attachments = {
    dual_autopistols_p1_m1 = {
        rail = rails,
        flashlight = flashlight_human,
        sight = table_merge_recursive_n(nil, sight_reflex, sight_scope),
        fake_magazine = table_merge_recursive_n(nil, magazine_autogun_infantry, magazine_autogun_headhunter, magazine_autogun_braced, magazine_autopistol, magazine_laser, magazine_bolter),
        muzzle = table_merge_recursive_n(nil, muzzle_autogun_headhunter, muzzle_autogun_braced, muzzle_autogun_infantry, muzzle_suppressors),
    },
}

attachments.dual_autopistols_p1_m2 = table_clone(attachments.dual_autopistols_p1_m1)
attachments.dual_autopistols_p1_m3 = table_clone(attachments.dual_autopistols_p1_m1)
attachments.dual_autopistols_p1_m4 = table_clone(attachments.dual_autopistols_p1_m1)

local attachment_slots = {
    dual_autopistols_p1_m1 = {
        flashlight = {
            parent_slot = "left|right",
            default_path = _item_empty_trinket,
        },
        muzzle = {
            parent_slot = "left|right",
            default_path = _item_empty_trinket,
        },
        sight = {
            parent_slot = "rail",
            default_path = _item_empty_trinket,
        },
        rail = {
            parent_slot = "left|right",
            default_path = _item_empty_trinket,
        },
        fake_magazine = {
            parent_slot = "rail",
            default_path = _item_empty_trinket,
        },
    },
}

attachment_slots.dual_autopistols_p1_m2 = table_clone(attachment_slots.dual_autopistols_p1_m1)
attachment_slots.dual_autopistols_p1_m3 = table_clone(attachment_slots.dual_autopistols_p1_m1)
attachment_slots.dual_autopistols_p1_m4 = table_clone(attachment_slots.dual_autopistols_p1_m1)

local fixes = {
    dual_autopistols_p1_m1 = {
        {attachment_slot = "flashlight",
            requirements = {
                flashlight = {
                    has = "query:dual_autopistols_p1_m1,flashlight,extended_weapon_customization_base_additions",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(.03, .065, .006),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(.5, .5, .5),
                    node = 1,
                },
            },
        },
        {attachment_slot = "muzzle",
            requirements = {
                muzzle = {
                    has = "query:dual_autopistols_p1_m1,muzzle,extended_weapon_customization_base_additions,"..suppressors,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .06, .06),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1.6, 1.6, 1.6),
                    node = 1,
                },
            },
        },
        {attachment_slot = "muzzle",
            requirements = {
                muzzle = {
                    has = "query:dual_autopistols_p1_m1,muzzle,extended_weapon_customization_base_additions,"..headhunter_muzzles.."|"..braced_muzzles.."|"..infantry_muzzles,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .06, .06),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        -- {attachment_slot = "barrel",
        --     requirements = {
        --         muzzle = {
        --             has = "query:dual_autopistols_p1_m1,muzzle,extended_weapon_customization_base_additions",
        --         },
        --     },
        --     fix = {
        --         hide = {
        --             node = 2,
        --         }
        --     },
        -- },
        {attachment_slot = "rail",
            requirements = {
                sight = {
                    missing = reflex_sights,
                },
            },
            fix = {
                attach = {
                    rail = "stubgun_pistol_rail_off",
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
            },
        },
        {attachment_slot = "rail",
            requirements = {
                rail = {
                    has = "stubgun_pistol_rail_off|lasgun_pistol_rail_01",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.134, .113),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "sight",
            requirements = {
                sight = {
                    has = scope_sights,
                },
            },
            fix = {
                attach = {
                    rail = "stubgun_pistol_rail_off",
                },
                offset = {
                    position = vector3_box(0, -.014, .006),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(.75, .75, .75),
                    node = 1,
                },
            },
        },
        {attachment_slot = "magazine",
            requirements = {
                fake_magazine = {
                    has = "query:dual_autopistols_p1_m1,fake_magazine,extended_weapon_customization_base_additions",
                },
            },
            fix = {
                alpha = 1,
            },
        },
        {attachment_slot = "fake_magazine",
            requirements = {
                fake_magazine = {
                    has = "query:dual_autopistols_p1_m1,fake_magazine,extended_weapon_customization_base_additions,"..bolter_magazines.."|"..laser_magazines.."|"..autopistol_magazines.."|"..bolter_magazines,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .06, -.16),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(.64, .5, .77),
                    node = 1,
                },
            },
        },
        {attachment_slot = "fake_magazine",
            requirements = {
                fake_magazine = {
                    has = autopistol_magazines,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .06, -.182),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(.62, .82, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "fake_magazine",
            requirements = {
                fake_magazine = {
                    has = laser_magazines,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .112, -.17),
                    rotation = vector3_box(0, 0, 180),
                    scale = vector3_box(.73, .544, .852),
                    node = 1,
                },
            },
        },
        {attachment_slot = "fake_magazine",
            requirements = {
                fake_magazine = {
                    has = bolter_magazines,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .06, -.19),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(.5, .475, .585),
                    node = 1,
                },
            },
        },
    }
}

fixes.dual_autopistols_p1_m2 = table_clone(fixes.dual_autopistols_p1_m1)
fixes.dual_autopistols_p1_m3 = table_clone(fixes.dual_autopistols_p1_m1)
fixes.dual_autopistols_p1_m4 = table_clone(fixes.dual_autopistols_p1_m1)

return {
    fixes = fixes,
    attachments = attachments,
    attachment_slots = attachment_slots,
}
