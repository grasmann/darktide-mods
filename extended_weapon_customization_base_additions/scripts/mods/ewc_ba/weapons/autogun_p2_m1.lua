local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local autogun_headhunter_group = {custom_selection_group = "autogun_headhunter"}
local autogun_infantry_group = {custom_selection_group = "autogun_infantry"}
local autopistol_group = {custom_selection_group = "autopistol"}
local sight_show = {custom_selection_group = "sight_show"}

local receiver_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/receiver_autogun_headhunter")
local magazine_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_headhunter")
local barrel_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/barrel_autogun_headhunter")
local muzzle_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_headhunter")
local sight_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_autogun_headhunter")
local stock_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/stock_autogun_headhunter")
local grip_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_autogun_headhunter")
mod:merge_attachment_data(autogun_headhunter_group, receiver_autogun_headhunter, magazine_autogun_headhunter, barrel_autogun_headhunter, muzzle_autogun_headhunter, stock_autogun_headhunter, sight_autogun_headhunter, grip_autogun_headhunter)

local magazine_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_infantry")
local receiver_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/receiver_autogun_infantry")
local barrel_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/barrel_autogun_infantry")
local muzzle_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_infantry")
local sight_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_autogun_infantry")
local stock_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/stock_autogun_infantry")
local grip_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_autogun_infantry")
mod:merge_attachment_data(autogun_infantry_group, receiver_autogun_infantry, magazine_autogun_infantry, barrel_autogun_infantry, muzzle_autogun_infantry, stock_autogun_infantry, sight_autogun_infantry, grip_autogun_infantry)

local magazine_autopistol = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autopistol")
mod:merge_attachment_data(autopistol_group, magazine_autopistol)

local sight_scope_show = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_scope_show")
local sight_reflex_show = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_reflex_show")
mod:merge_attachment_data(sight_show, sight_scope_show, sight_reflex_show)

local magazine_laser_group = {custom_selection_group = "magazine_laser"}
local magazine_laser = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_laser")
mod:merge_attachment_data(magazine_laser_group, magazine_laser)

local sight_scope = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_scope")
local sight_reflex = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_reflex")
local magazine_autogun_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_double")
local magazine_autopistol_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autopistol_double")
local flashlight_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/flashlight_human")
local bayonet_common = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/bayonet_common")
local stock_common = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/stock_common")
local decals_right = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/decal_right")
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
local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local reflex_sights_show = "reflex_sight_show_01|reflex_sight_show_02|reflex_sight_show_03"
local scopes = "scope_01"

local attachments = {
    autogun_p2_m1 = {
        rail = rails,
        bayonet = bayonet_common,
        emblem_left = decals_left,
        emblem_right = decals_right,
        flashlight = flashlight_human,
        muzzle = table_merge_recursive_n(nil, muzzle_autogun_infantry, muzzle_autogun_headhunter),
        barrel = table_merge_recursive_n(nil, barrel_autogun_infantry, barrel_autogun_headhunter),
        receiver = table_merge_recursive_n(nil, receiver_autogun_infantry, receiver_autogun_headhunter),
        grip = table_merge_recursive_n(nil, grip_common, grip_autogun_infantry, grip_autogun_headhunter),
        stock = table_merge_recursive_n(nil, stock_common, stock_autogun_infantry, stock_autogun_headhunter),
        magazine = table_merge_recursive_n(nil, magazine_autopistol, magazine_autogun_double, magazine_autopistol_double, magazine_autogun_infantry, magazine_laser),
        sight = table_merge_recursive_n(nil, sight_reflex, sight_scope, sight_autogun_infantry, sight_autogun_headhunter, sight_scope_show, sight_reflex_show),
    },
}

attachments.autogun_p2_m2 = table_clone(attachments.autogun_p2_m1)
attachments.autogun_p2_m3 = table_clone(attachments.autogun_p2_m1)
attachments.autogun_npc_04 = table_clone(attachments.autogun_p2_m1)
attachments.autogun_npc_05 = table_clone(attachments.autogun_p2_m1)

local fixes = {
    autogun_p2_m1 = {
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
        {attachment_slot = "sight_offset",
            requirements = {
                sight = { has = reflex_sights },
                receiver = { has = infantry_receivers },
            },
            fix = {
                offset = { position = vector3_box(0, 0, -.0085) },
            },
        },
        {attachment_slot = "sight_offset",
            requirements = {
                sight = { has = reflex_sights },
                receiver = { has = braced_receivers },
            },
            fix = {
                offset = { position = vector3_box(0, 0, -.0085) },
            },
        },
        {attachment_slot = "sight_offset",
            requirements = {
                sight = { has = reflex_sights },
                receiver = { has = headhunter_receivers },
            },
            fix = {
                offset = { position = vector3_box(0, 0, -.011) },
            },
        },
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
                    has = reflex_sights.."|"..reflex_sights_show,
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
                    has = reflex_sights.."|"..reflex_sights_show,
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
                    has = reflex_sights.."|autogun_rifle_killshot_sight_01|autogun_rifle_ak_sight_01|"..reflex_sights_show,
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

fixes.autogun_p2_m2 = table_clone(fixes.autogun_p2_m1)
fixes.autogun_p2_m3 = table_clone(fixes.autogun_p2_m1)
fixes.autogun_npc_04 = table_clone(fixes.autogun_p2_m1)
fixes.autogun_npc_05 = table_clone(fixes.autogun_p2_m1)

local kitbashs = {
    [_item_ranged.."/magazines/autogun_rifle_ak_magazine_01_double"] = {
        attachments = {
            zzz_shared_material_overrides = {
                item = "",
                children = {},
            },
            double_magazine_1 = {
                item = _item_ranged.."/magazines/autogun_rifle_ak_magazine_01",
                fix = {
                    offset = {
                        node = 1,
                        position = vector3_box(0, 0, 0),
                        rotation = vector3_box(0, 0, 0),
                        scale = vector3_box(1, 1, 1),
                    },
                },
                children = {
                    double_magazine_clip = {
                        item = _item_ranged.."/magazines/lasgun_rifle_magazine_01",
                        fix = {
                            offset = {
                                node = 1,
                                position = vector3_box(.0325, 0, -.16),
                                rotation = vector3_box(10, 90, 0),
                                scale = vector3_box(1, 1.2, .75),
                            },
                        },
                        children = {
                            double_magazine_2 = {
                                item = _item_ranged.."/magazines/autogun_rifle_ak_magazine_01",
                                fix = {
                                    offset = {
                                        node = 1,
                                        position = vector3_box(.15, .1, -.125),
                                        rotation = vector3_box(0, 90, 180),
                                        scale = vector3_box(1.3, .85, 1),
                                    },
                                },
                                children = {},
                            },
                        },
                    },
                },
            },
        },
        display_name = "",
        description = "loc_description_autogun_rifle_ak_magazine_01_double",
        attach_node = "ap_magazine_01",
        -- dev_name = "loc_autogun_rifle_ak_magazine_01_double",
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/characters/empty_item/empty_item",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
        },
        resource_dependencies = {
            ["content/characters/empty_item/empty_item"] = true,
            ["content/weapons/player/ranged/autogun_rifle_ak/attachments/magazine_01/magazine_01"] = true,
            ["content/weapons/player/ranged/lasgun_rifle/attachments/magazine_01/magazine_01"] = true,
        },
        workflow_checklist = {
        },
        name = _item_ranged.."/magazines/autogun_rifle_ak_magazine_01_double",
        workflow_state = "RELEASABLE",
        is_full_item = true,
        disable_vfx_spawner_exclusion = true,
    },
}

return {
    attachments = attachments,
    fixes = fixes,
    kitbashs = kitbashs,
}
