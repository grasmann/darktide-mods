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
local grip_common = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_common")
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
local suppressors = "autogun_rifle_suppressed_muzzle_01|autogun_rifle_suppressed_muzzle_02|autogun_rifle_suppressed_muzzle_03"
local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local scopes = "scope_01"

local attachments = {
    needlepistol_p1_m1 = {
        grip = grip_common,
        flashlight = flashlight_human,
        rail = rails,
        -- magazine = table_merge_recursive_n({
        --     boltgun_pistol_magazine_01_double = {
        --         replacement_path = _item_ranged.."/magazines/boltgun_pistol_magazine_01_double",
        --         icon_render_unit_rotation_offset = {90, 0, 30},
        --         icon_render_camera_position_offset = {-.125, -1.25, -.05},
        --     },
        --     boltgun_pistol_magazine_02_double = {
        --         replacement_path = _item_ranged.."/magazines/boltgun_pistol_magazine_02_double",
        --         icon_render_unit_rotation_offset = {90, 0, 30},
        --         icon_render_camera_position_offset = {-.125, -1.25, -.05},
        --     },
        -- }, magazine_autopistol, magazine_autogun_double, magazine_autopistol_double, magazine_autogun_infantry, magazine_autogun_braced, magazine_autogun_headhunter),
        magazine = table_merge_recursive_n(nil, magazine_autopistol, magazine_autogun_double, magazine_autopistol_double, magazine_autogun_infantry, magazine_autogun_braced, magazine_autogun_headhunter),
        sight = table_merge_recursive_n(nil, sight_reflex, sight_scope, {
            lasgun_rifle_sight_01 = {
                replacement_path = _item_ranged.."/sights/lasgun_rifle_sight_01",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .125},
            },
        }),
        muzzle = table_merge_recursive_n(nil, muzzle_autogun, muzzle_suppressors),
    },
}

attachments.needlepistol_p1_m2 = table_clone(attachments.needlepistol_p1_m1)
attachments.needlepistol_p1_m3 = table_clone(attachments.needlepistol_p1_m1)
attachments.needlepistol_p1_m4 = table_clone(attachments.needlepistol_p1_m1)

local fixes = {
    needlepistol_p1_m1 = {
        -- Grip offset when using non-needle-pistol grips
        {attachment_slot = "grip",
            requirements = {
                grip = {
                    has = "query:needlepistol_p1_m1,grip,extended_weapon_customization_base_additions",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .075, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                },
            },
        },
        -- Muzzle offset
        {attachment_slot = "muzzle",
            requirements = {
                muzzle = {
                    has = "query:needlepistol_p1_m1,muzzle,extended_weapon_customization_base_additions",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .065, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "muzzle",
            requirements = {
                muzzle = {
                    has = "query:needlepistol_p1_m1,muzzle,extended_weapon_customization_base_additions,"..suppressors,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .065, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1.35, 1.35, 1.35),
                    node = 1,
                },
            },
        },
        -- Rail offset
        {attachment_slot = "rail",
            requirements = {
                rail = {
                    has = "query:needlepistol_p1_m1,rail,extended_weapon_customization_base_additions",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.04, .096),
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
                    position = vector3_box(0, 0, -.026),
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
                    position = vector3_box(0, -.05, -.0375),
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
                    position = vector3_box(0, -.023, .096),
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
                    position = vector3_box(0, -.063, .114),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        -- Adjust sight position when using scopes
        {attachment_slot = "sight",
            requirements = {
                sight = {
                    has = "lasgun_rifle_sight_01",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.04, .114),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, .6, 1),
                },
            },
        },
        -- Unequip rail
        {attachment_slot = "rail",
            requirements = {
                sight = {
                    has = reflex_sights,
                },
            },
            fix = {
                attach = {
                    rail = "lasgun_pistol_rail_01",
                }
            },
        },
        -- Equip rail
        {attachment_slot = "rail",
            requirements = {
                sight = {
                    has = scopes,
                },
            },
            fix = {
                attach = {
                    rail = "stubgun_pistol_rail_off",
                }
            },
        },
        -- Adjust magazine scale when using autopistol magazines
        {attachment_slot = "magazine",
            requirements = {
                magazine = {
                    has = autopistol_magazines,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.025, .018),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(.5, .715, .5),
                },
            },
        },
        -- Adjust magazine scale when using autogun magazines
        {attachment_slot = "magazine",
            requirements = {
                magazine = {
                    has = autogun_magazines.."|"..autogun_double_magazines,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.03, .018),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(.475, .475, .475),
                },
            },
        },
        -- Flashlight offset
        {attachment_slot = "flashlight",
            requirements = {
                flashlight = {
                    has = "query:needlepistol_p1_m1,flashlight,extended_weapon_customization_base_additions",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(.04, -.145, -.002),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                },
            },
        },
    },
}

fixes.needlepistol_p1_m2 = table_clone(fixes.needlepistol_p1_m1)
fixes.needlepistol_p1_m3 = table_clone(fixes.needlepistol_p1_m1)
fixes.needlepistol_p1_m4 = table_clone(fixes.needlepistol_p1_m1)

local attachment_slots = {
    needlepistol_p1_m1 = {
        muzzle = {
            parent_slot = "barrel",
            default_path = _item_empty_trinket,
        },
    },
}

attachment_slots.needlepistol_p1_m2 = table_clone(attachment_slots.needlepistol_p1_m1)
attachment_slots.needlepistol_p1_m3 = table_clone(attachment_slots.needlepistol_p1_m1)
attachment_slots.needlepistol_p1_m4 = table_clone(attachment_slots.needlepistol_p1_m1)

return {
    attachments = attachments,
    attachment_slots = attachment_slots,
    fixes = fixes,
}
