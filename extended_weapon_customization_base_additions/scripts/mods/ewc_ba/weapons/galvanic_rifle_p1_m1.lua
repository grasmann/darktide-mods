local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local autogun_infantry_group = {custom_selection_group = "autogun_infantry"}
local magazine_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_infantry")
local muzzle_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_infantry")
mod:merge_attachment_data(autogun_infantry_group, magazine_autogun_infantry, muzzle_autogun_infantry)

local autogun_braced_group = {custom_selection_group = "autogun_braced"}
local magazine_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_braced")
local muzzle_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_braced")
mod:merge_attachment_data(autogun_braced_group, magazine_autogun_braced, muzzle_autogun_braced)

local autogun_headhunter_group = {custom_selection_group = "autogun_headhunter"}
local magazine_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_headhunter")
local muzzle_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_headhunter")
mod:merge_attachment_data(autogun_headhunter_group, muzzle_autogun_headhunter, magazine_autogun_headhunter)

local autopistol_group = {custom_selection_group = "autopistol"}
local magazine_autopistol = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autopistol")
mod:merge_attachment_data(autopistol_group, magazine_autopistol)

local suppressor_group = {custom_selection_group = "suppressors"}
local muzzle_suppressors = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_suppressors")
mod:merge_attachment_data(suppressor_group, muzzle_suppressors)

local magazine_autopistol_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autopistol_double")
local magazine_autogun_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_double")
local flashlight_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/flashlight_human")
local muzzle_autogun = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun")
local sight_reflex = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_reflex")
local sight_scope = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_scope")
local rails = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/rail")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local type = type
    local table = table
    local pairs = pairs
    local select = select
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

local autopistol_magazines = "autogun_pistol_magazine_01|autogun_pistol_magazine_01_double"
local autogun_magazines = "autogun_rifle_magazine_01|autogun_rifle_magazine_02|autogun_rifle_magazine_03|autogun_rifle_ak_magazine_01"
local autogun_double_magazines = "autogun_rifle_magazine_01_double|autogun_rifle_magazine_02_double|autogun_rifle_magazine_03_double|autogun_rifle_ak_magazine_01_double"

local autogun_infantry_muzzles = "autogun_rifle_muzzle_01|autogun_rifle_muzzle_02|autogun_rifle_muzzle_03|autogun_rifle_muzzle_04|autogun_rifle_muzzle_05|autogun_rifle_muzzle_06|autogun_rifle_muzzle_ml01"
local autogun_braced_muzzles = "autogun_rifle_ak_muzzle_01|autogun_rifle_ak_muzzle_02|autogun_rifle_ak_muzzle_03|autogun_rifle_ak_muzzle_04|autogun_rifle_ak_muzzle_05|autogun_rifle_ak_muzzle_ml01"
local autogun_headhunter_muzzles = "autogun_rifle_killshot_muzzle_01|autogun_rifle_killshot_muzzle_03|autogun_rifle_killshot_muzzle_04|autogun_rifle_killshot_muzzle_05|autogun_rifle_killshot_muzzle_ml01"
local autogun_muzzles = autogun_infantry_muzzles.."|"..autogun_braced_muzzles.."|"..autogun_headhunter_muzzles

local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local scopes = "scope_01"

local attachments = {
    galvanic_rifle_p1_m1 = {
        rail = rails,
        flashlight = flashlight_human,
        fake_magazine = table_merge_recursive_n(nil, magazine_autopistol, magazine_autogun_double, magazine_autopistol_double, magazine_autogun_infantry, magazine_autogun_braced, magazine_autogun_headhunter),
        sight = table_merge_recursive_n(nil, sight_reflex, sight_scope, {
            lasgun_rifle_sight_01 = {
                replacement_path = _item_ranged.."/sights/lasgun_rifle_sight_01",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .125},
            },
        }),
        muzzle_2 = table_merge_recursive_n(nil, muzzle_autogun, muzzle_suppressors),
    },
}

local fixes = {
    galvanic_rifle_p1_m1 = {
        -- Attach rail and adjust position when using reflex sights
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
                    position = vector3_box(0, .306, .107),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        -- Attach rail and adjust position when using scopes
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
                    position = vector3_box(0, .306, .107),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        -- Sight offset when using reflex sights
        {attachment_slot = "sight_offset",
            requirements = {
                sight = {
                    has = reflex_sights,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.02),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        -- Sight offset when using scopes
        {attachment_slot = "sight_offset",
            requirements = {
                sight = {
                    has = scopes,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.05, -.035),
                    rotation = vector3_box(0, 0, 0),
                    custom_fov = 32.5,
                    aim_scale = .5,
                    fov = 25,
                },
            },
        },
        -- Adjust sight position when using reflex sights
        {attachment_slot = "sight",
            requirements = {
                sight = {
                    has = reflex_sights,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .001, -.001),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        -- Adjust sight position when using scopes
        {attachment_slot = "sight",
            requirements = {
                sight = {
                    has = scopes,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.025, .014),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        -- Adjust sight position when using lasgun sight
        {attachment_slot = "sight",
            requirements = {
                sight = {
                    has = "lasgun_rifle_sight_01",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .326, .128),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        -- Adjust fake magazine position
        {attachment_slot = "fake_magazine",
            fix = {
                offset = {
                    position = vector3_box(.006, .166, .008),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                },
            },
        },
        -- Adjust second muzzle position
        {attachment_slot = "muzzle_2",
            requirements = {
                muzzle_2 = {
                    has = autogun_muzzles,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .212, .016),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1.5, 1.5, 1.5),
                    node = 1,
                },
            },
        },
        -- Other muzzle
        {attachment_slot = "muzzle_2",
            fix = {
                offset = {
                    position = vector3_box(0, .212, .016),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        -- Flashlight offset
        {attachment_slot = "flashlight",
            fix = {
                offset = {
                    position = vector3_box(.02, .673, .055),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                },
            },
        },
    },
}

local attachment_slots = {
    galvanic_rifle_p1_m1 = {
        flashlight = {
            parent_slot = "receiver",
            default_path = _item_empty_trinket,
        },
        rail = {
            parent_slot = "receiver",
            default_path = _item_empty_trinket,
        },
        sight = {
            parent_slot = "rail",
            default_path = _item_empty_trinket,
        },
        muzzle_2 = {
            parent_slot = "muzzle",
            default_path = _item_empty_trinket,
        },
        fake_magazine = {
            parent_slot = "stock",
            default_path = _item_empty_trinket,
        },
    },
}

return {
    attachment_slots = attachment_slots,
    attachments = attachments,
    fixes = fixes,
}
