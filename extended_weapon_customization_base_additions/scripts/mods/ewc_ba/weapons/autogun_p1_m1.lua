local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local magazine_autopistol_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autopistol_double")
local magazine_autogun_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_double")
local magazine_autopistol = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autopistol")
local bayonet_common = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/bayonet_common")
local barrel_common = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/barrel_common")
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
local headhunter_receivers = "autogun_rifle_killshot_receiver_01|autogun_rifle_killshot_receiver_02|autogun_rifle_killshot_receiver_03|autogun_rifle_killshot_receiver_04|autogun_rifle_killshot_receiver_ml01"
local braced_receivers = "autogun_rifle_ak_receiver_01|autogun_rifle_ak_receiver_02|autogun_rifle_ak_receiver_03|autogun_rifle_ak_receiver_ml01"

local autopistol_magazines = "autogun_pistol_magazine_01|autogun_pistol_magazine_01_double"

local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local scopes = "scope_01"

local attachments = {
    autogun_p1_m1 = {
        rail = rails,
        emblem_left = decals_left,
        emblem_right = decals_right,
        grip = grip_common,
        stock = stock_common,
        bayonet = bayonet_common,
        barrel = barrel_common,
        magazine = table_merge_recursive_n(nil, magazine_autopistol, magazine_autogun_double, magazine_autopistol_double),
        sight = table_merge_recursive_n(nil, sight_reflex, sight_scope, {
            lasgun_rifle_sight_01 = {
                replacement_path = _item_ranged.."/sights/lasgun_rifle_sight_01",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .125},
            },
        }),
    },
}

attachments.autogun_p1_m2 = table_clone(attachments.autogun_p1_m1)
attachments.autogun_p1_m3 = table_clone(attachments.autogun_p1_m1)
attachments.autogun_p2_m1 = table_clone(attachments.autogun_p1_m1)
attachments.autogun_p2_m2 = table_clone(attachments.autogun_p1_m1)
attachments.autogun_p2_m3 = table_clone(attachments.autogun_p1_m1)
attachments.autogun_p3_m1 = table_clone(attachments.autogun_p1_m1)
attachments.autogun_p3_m2 = table_clone(attachments.autogun_p1_m1)
attachments.autogun_p3_m3 = table_clone(attachments.autogun_p1_m1)

local fixes = {
    autogun_p1_m1 = {
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
        {attachment_slot = "sight_offset",
            requirements = {
                sight = { has = "reflex_sight_01|reflex_sight_02" },
                receiver = { has = infantry_receivers },
            },
            fix = {
                offset = { position = vector3_box(0, 0, -.0085) },
            },
        },
        {attachment_slot = "sight_offset",
            requirements = {
                sight = { has = "reflex_sight_03" },
                receiver = { has = infantry_receivers },
            },
            fix = {
                offset = { position = vector3_box(0, 0, -.0075) },
            },
        },
        {attachment_slot = "sight_offset",
            requirements = {
                sight = { has = "reflex_sight_01|reflex_sight_02" },
                receiver = { has = braced_receivers },
            },
            fix = {
                offset = { position = vector3_box(0, 0, -.0085) },
            },
        },
        {attachment_slot = "sight_offset",
            requirements = {
                sight = { has = "reflex_sight_03" },
                receiver = { has = braced_receivers },
            },
            fix = {
                offset = { position = vector3_box(0, 0, -.0075) },
            },
        },
        {attachment_slot = "sight_offset",
            requirements = {
                sight = { has = "reflex_sight_01|reflex_sight_02" },
                receiver = { has = headhunter_receivers },
            },
            fix = {
                offset = { position = vector3_box(0, 0, -.011) },
            },
        },
        {attachment_slot = "sight_offset",
            requirements = {
                sight = { has = "reflex_sight_03" },
                receiver = { has = headhunter_receivers },
            },
            fix = {
                offset = { position = vector3_box(0, 0, -.0085) },
            },
        },
        {attachment_slot = "sight_offset",
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
                    position = vector3_box(0, -.05, -.036),
                    rotation = vector3_box(0, 0, 0),
                    custom_fov = 32.5,
                    aim_scale = .5,
                    fov = 25,
                },
            },
        },
        {attachment_slot = "sight_offset",
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
                    position = vector3_box(0, -.05, -.034),
                    rotation = vector3_box(0, 0, 0),
                    custom_fov = 32.5,
                    aim_scale = .5,
                    fov = 25,
                },
            },
        },
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

fixes.autogun_p1_m2 = table_clone(fixes.autogun_p1_m1)
fixes.autogun_p1_m3 = table_clone(fixes.autogun_p1_m1)
fixes.autogun_p2_m1 = table_clone(fixes.autogun_p1_m1)
fixes.autogun_p2_m2 = table_clone(fixes.autogun_p1_m1)
fixes.autogun_p2_m3 = table_clone(fixes.autogun_p1_m1)
fixes.autogun_p3_m1 = table_clone(fixes.autogun_p1_m1)
fixes.autogun_p3_m2 = table_clone(fixes.autogun_p1_m1)
fixes.autogun_p3_m3 = table_clone(fixes.autogun_p1_m1)

local kitbashs = {}

return {
    attachments = attachments,
    fixes = fixes,
    kitbashs = kitbashs,
}
