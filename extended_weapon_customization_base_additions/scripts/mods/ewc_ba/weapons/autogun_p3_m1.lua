local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local autogun_infantry_group = {custom_selection_group = "autogun_infantry"}
local receiver_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/receiver_autogun_infantry")
local magazine_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_infantry")
local barrel_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/barrel_autogun_infantry")
local muzzle_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_infantry")
local sight_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_autogun_infantry")
local stock_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/stock_autogun_infantry")
local grip_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_autogun_infantry")
mod:merge_attachment_data(autogun_infantry_group, receiver_autogun_infantry, magazine_autogun_infantry, barrel_autogun_infantry, muzzle_autogun_infantry, sight_autogun_infantry, stock_autogun_infantry, grip_autogun_infantry)

local autogun_braced_group = {custom_selection_group = "autogun_braced"}
local magazine_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_braced")
local receiver_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/receiver_autogun_braced")
local barrel_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/barrel_autogun_braced")
local muzzle_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_braced")
local stock_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/stock_autogun_braced")
local sight_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_autogun_braced")
local grip_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_autogun_braced")
mod:merge_attachment_data(autogun_braced_group, magazine_autogun_braced, receiver_autogun_braced, barrel_autogun_braced, muzzle_autogun_braced, stock_autogun_braced, sight_autogun_braced, grip_autogun_braced)

local bolter_group = {custom_selection_group = "bolter"}
local magazine_bolter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_bolter")
local magazine_bolter_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_bolter_double")
mod:merge_attachment_data(bolter_group, magazine_bolter, magazine_bolter_double)

local autopistol_group = {custom_selection_group = "autopistol"}
local magazine_autopistol = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autopistol")
mod:merge_attachment_data(autopistol_group, magazine_autopistol)

local magazine_laser_group = {custom_selection_group = "magazine_laser"}
local magazine_laser = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_laser_autogun")
mod:merge_attachment_data(magazine_laser_group, magazine_laser)

local magazine_autopistol_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autopistol_double")
local magazine_autogun_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_double")
local flashlight_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/flashlight_human")
local bayonet_common = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/bayonet_common")
local sight_reflex = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_reflex")
local stock_common = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/stock_common")
local decals_right = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/decal_right")
local sight_scope = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_scope")
local grip_common = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_common")
local decals_left = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/decal_left")
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

local infantry_receivers = "autogun_rifle_receiver_01|autogun_rifle_receiver_ml01"
local braced_barrels = "autogun_rifle_barrel_ak_01|autogun_rifle_barrel_ak_02|autogun_rifle_barrel_ak_03|autogun_rifle_barrel_ak_04|autogun_rifle_barrel_ak_05|autogun_rifle_barrel_ak_06|autogun_rifle_barrel_ak_07|autogun_rifle_barrel_ak_08|autogun_rifle_barrel_ak_ml01"
local headhunter_receivers = "autogun_rifle_killshot_receiver_01|autogun_rifle_killshot_receiver_02|autogun_rifle_killshot_receiver_03|autogun_rifle_killshot_receiver_04|autogun_rifle_killshot_receiver_ml01"
local braced_receivers = "autogun_rifle_ak_receiver_01|autogun_rifle_ak_receiver_02|autogun_rifle_ak_receiver_03|autogun_rifle_ak_receiver_ml01"
local autopistol_magazines = "autogun_pistol_magazine_01|autogun_pistol_magazine_01_double"
local laser_magazines = "autogun_rifle_laser_magazine_01|autogun_rifle_laser_magazine_02|autogun_rifle_laser_magazine_03"
local bolter_magazines = "boltgun_rifle_magazine_01|boltgun_rifle_magazine_02|boltgun_rifle_magazine_01_double|boltgun_rifle_magazine_02_double"
local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local scopes = "scope_01"

local attachments = {
    autogun_p3_m1 = {
        rail = rails,
        bayonet = bayonet_common,
        emblem_left = decals_left,
        emblem_right = decals_right,
        flashlight = flashlight_human,
        barrel = table_merge_recursive_n(nil, barrel_autogun_infantry, barrel_autogun_braced),
        muzzle = table_merge_recursive_n(nil, muzzle_autogun_infantry, muzzle_autogun_braced),
        receiver = table_merge_recursive_n(nil, receiver_autogun_braced, receiver_autogun_infantry),
        grip = table_merge_recursive_n(nil, grip_common, grip_autogun_infantry, grip_autogun_braced),
        stock = table_merge_recursive_n(nil, stock_common, stock_autogun_infantry, stock_autogun_braced),
        magazine = table_merge_recursive_n(nil, magazine_autopistol, magazine_autogun_double, magazine_autopistol_double, magazine_autogun_braced, magazine_laser, magazine_bolter, magazine_bolter_double, magazine_autogun_infantry),
        sight = table_merge_recursive_n(nil, sight_reflex, sight_scope, sight_autogun_braced, sight_autogun_infantry),
    },
}

attachments.autogun_p3_m2 = table_clone(attachments.autogun_p3_m1)
attachments.autogun_p3_m3 = table_clone(attachments.autogun_p3_m1)
attachments.high_bot_autogun_killshot = table_clone(attachments.autogun_p3_m1)
attachments.bot_autogun_killshot = table_clone(attachments.autogun_p3_m1)

local fixes = {
    autogun_p3_m1 = {
        -- Adjust barrel position when mixing braced and non-braced receivers and barrels
        {attachment_slot = "barrel",
            requirements = {
                receiver = {
                    has = braced_receivers,
                },
                barrel = {
                    missing = braced_barrels,
                }
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .0325),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "barrel",
            requirements = {
                receiver = {
                    missing = braced_receivers,
                },
                barrel = {
                    has = braced_barrels,
                }
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.0325),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        -- Adjust muzzle position when using barrel_01
        {attachment_slot = "muzzle",
            requirements = {
                barrel = {
                    has = "barrel_01",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .1, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                },
            },
        },
        -- Adjust flashlight position when using barrel_01
        {attachment_slot = "flashlight",
            requirements = {
                barrel = {
                    has = "barrel_01",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(.025, .035, -.04),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                },
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
                    position = vector3_box(0, 0, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1.8, 1),
                },
            },
        },
        -- Adjust magazine scale when using laser magazines
        {attachment_slot = "magazine",
            requirements = {
                magazine = {
                    has = laser_magazines,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1.15, 1.15, 1.15),
                },
            },
        },
        -- Adjust magazine scale when using bolter magazines
        {attachment_slot = "magazine",
            requirements = {
                magazine = {
                    has = bolter_magazines,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.025),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(.8, 1, 1),
                },
            },
        },
        -- Sight offset when using reflex sights on infantry receivers
        {attachment_slot = "sight_offset",
            requirements = {
                sight = { has = reflex_sights },
                receiver = { has = infantry_receivers },
            },
            fix = {
                offset = { position = vector3_box(0, 0, -.0085) },
            },
        },
        -- Sight offset when using reflex sights on braced receivers
        {attachment_slot = "sight_offset",
            requirements = {
                sight = { has = reflex_sights },
                receiver = { has = braced_receivers },
            },
            fix = {
                offset = { position = vector3_box(0, 0, -.0085) },
            },
        },
        -- Sight offset when using reflex sights on headhunter receivers
        {attachment_slot = "sight_offset",
            requirements = {
                sight = { has = reflex_sights },
                receiver = { has = headhunter_receivers },
            },
            fix = {
                offset = { position = vector3_box(0, 0, -.011) },
            },
        },
        -- Sight offset when using scopes on infantry or braced receivers
        {attachment_slot = "sight_offset",
            requirements = {
                sight = {
                    has = scopes,
                },
                receiver = {
                    has = infantry_receivers.."|"..braced_receivers,
                }
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.05, -.034),
                    rotation = vector3_box(0, 0, 0),
                    custom_fov = 32.5,
                    aim_scale = .5,
                    fov = 25,
                },
            },
        },
        -- Sight offset when using scopes on headhunter receivers
        {attachment_slot = "sight_offset",
            requirements = {
                sight = {
                    has = scopes,
                },
                receiver = {
                    has = headhunter_receivers,
                }
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.05, -.036),
                    rotation = vector3_box(0, 0, 0),
                    custom_fov = 32.5,
                    aim_scale = .5,
                    fov = 25,
                },
            },
        },
        -- Adjust sight position when using infantry autogun ironsight braced receiver
        {attachment_slot = "sight",
            requirements = {
                sight = {
                    has = "autogun_rifle_sight_01",
                },
                receiver = {
                    has = braced_receivers,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .03, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                },
            },
        },
        -- Adjust sight position when using reflex sights on braced receiver
        {attachment_slot = "sight",
            requirements = {
                sight = {
                    has = reflex_sights,
                },
                receiver = {
                    has = braced_receivers,
                }
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.025, 0),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        -- Adjust sight position when reflex sights on headhunter receiver
        {attachment_slot = "sight",
            requirements = {
                sight = {
                    has = reflex_sights,
                },
                receiver = {
                    has = headhunter_receivers,
                }
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.05, 0),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        -- Adjust sight position when using scopes on braced receivers
        {attachment_slot = "sight",
            requirements = {
                sight = {
                    has = scopes,
                },
                receiver = {
                    has = braced_receivers,
                }
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.025, .025),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        -- Adjust sight position when using scopes on headhunter receivers
        {attachment_slot = "sight",
            requirements = {
                sight = {
                    has = scopes,
                },
                receiver = {
                    has = headhunter_receivers,
                }
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.05, .025),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        -- Adjust sight position when using scopes on infantry receivers
        {attachment_slot = "sight",
            requirements = {
                sight = {
                    has = scopes,
                },
                receiver = {
                    has = infantry_receivers,
                }
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.05, .025),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        -- Adjust sight position when using lasgun sight on infantry receivers
        {attachment_slot = "sight",
            requirements = {
                sight = {
                    has = "lasgun_rifle_sight_01",
                },
                receiver = {
                    has = infantry_receivers,
                }
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.0225, .025),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        -- Adjust sight position when using lasgun sight on braced receivers
        {attachment_slot = "sight",
            requirements = {
                sight = {
                    has = "lasgun_rifle_sight_01",
                },
                receiver = {
                    has = braced_receivers,
                }
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.0125, .025),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, .65, 1),
                },
            },
        },
        -- Adjust sight position when using lasgun sight on braced receivers
        {attachment_slot = "sight",
            requirements = {
                sight = {
                    has = "autogun_rifle_sight_01",
                },
                receiver = {
                    has = braced_receivers,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .03, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                },
            },
        },
        -- Attach rail and adjust rail position when using infantry autogun receiver
        {attachment_slot = "rail",
            requirements = {
                receiver = {
                    has = infantry_receivers,
                },
                sight = {
                    has = reflex_sights.."|autogun_rifle_killshot_sight_01|autogun_rifle_ak_sight_01",
                },
            },
            fix = {
                attach = {
                    rail = "lasgun_rifle_rail_01",
                },
                offset = {
                    position = vector3_box(0, -.05, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        -- Attach empty rail when not using infantry autogun receiver
        {attachment_slot = "rail",
            requirements = {
                receiver = {
                    missing = infantry_receivers,
                },
            },
            fix = {
                attach = {
                    rail = "stubgun_pistol_rail_off",
                },
                offset = {
                    position = vector3_box(0, -.05, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
    },
}

fixes.autogun_p3_m2 = table_clone(fixes.autogun_p3_m1)
fixes.autogun_p3_m3 = table_clone(fixes.autogun_p3_m1)
fixes.high_bot_autogun_killshot = table_clone(fixes.autogun_p3_m1)
fixes.bot_autogun_killshot = table_clone(fixes.autogun_p3_m1)

local attachment_slots = {
    autogun_p3_m1 = {},
}

attachment_slots.autogun_p3_m2 = table_clone(attachment_slots.autogun_p3_m1)
attachment_slots.autogun_p3_m3 = table_clone(attachment_slots.autogun_p3_m1)
attachment_slots.high_bot_autogun_killshot = table_clone(attachment_slots.autogun_p3_m1)
attachment_slots.bot_autogun_killshot = table_clone(attachment_slots.autogun_p3_m1)

local kitbashs = {}

return {
    attachment_slots = attachment_slots,
    attachments = attachments,
    fixes = fixes,
    kitbashs = kitbashs,
}
