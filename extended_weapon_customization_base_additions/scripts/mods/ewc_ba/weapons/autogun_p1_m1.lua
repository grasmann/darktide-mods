local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local autogun_headhunter_group = {custom_selection_group = "autogun_headhunter"}
local receiver_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/receiver_autogun_headhunter")
local magazine_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_headhunter")
local barrel_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/barrel_autogun_headhunter")
local muzzle_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_headhunter")
local stock_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/stock_autogun_headhunter")
local sight_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_autogun_headhunter")
local grip_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_autogun_headhunter")
mod:merge_attachment_data(autogun_headhunter_group, receiver_autogun_headhunter, magazine_autogun_headhunter, barrel_autogun_headhunter, muzzle_autogun_headhunter, stock_autogun_headhunter, sight_autogun_headhunter, grip_autogun_headhunter)

local autogun_braced_group = {custom_selection_group = "autogun_braced"}
local magazine_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_braced")
local receiver_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/receiver_autogun_braced")
local barrel_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/barrel_autogun_braced")
local muzzle_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_braced")
local sight_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_autogun_braced")
local stock_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/stock_autogun_braced")
local grip_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_autogun_braced")
mod:merge_attachment_data(autogun_braced_group, receiver_autogun_braced, magazine_autogun_braced, barrel_autogun_braced, muzzle_autogun_braced, stock_autogun_braced, sight_autogun_braced, grip_autogun_braced)

local autopistol_group = {custom_selection_group = "autopistol"}
local magazine_autopistol = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autopistol")
mod:merge_attachment_data(autopistol_group, magazine_autopistol)

local magazine_laser_group = {custom_selection_group = "magazine_laser"}
local magazine_laser = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_laser_autogun")
mod:merge_attachment_data(magazine_laser_group, magazine_laser)

local bolter_group = {custom_selection_group = "bolter"}
local magazine_bolter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_bolter")
local magazine_bolter_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_bolter_double")
mod:merge_attachment_data(bolter_group, magazine_bolter, magazine_bolter_double)

local suppressor_group = {custom_selection_group = "suppressors"}
local muzzle_suppressors = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_suppressors")
mod:merge_attachment_data(suppressor_group, muzzle_suppressors)

local magazine_autopistol_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autopistol_double")
local magazine_autogun_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_double")
local flashlight_modded_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/flashlight_modded_human")
local laser_pointer_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/laser_pointer_human")
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
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

local braced_barrels = "autogun_rifle_barrel_ak_01|autogun_rifle_barrel_ak_02|autogun_rifle_barrel_ak_03|autogun_rifle_barrel_ak_04|autogun_rifle_barrel_ak_05|autogun_rifle_barrel_ak_06|autogun_rifle_barrel_ak_07|autogun_rifle_barrel_ak_08|autogun_rifle_barrel_ak_ml01"
local braced_receivers = "autogun_rifle_ak_receiver_01|autogun_rifle_ak_receiver_02|autogun_rifle_ak_receiver_03|autogun_rifle_ak_receiver_ml01"
local infantry_receivers = "autogun_rifle_receiver_01|autogun_rifle_receiver_ml01"
local headhunter_receivers = "autogun_rifle_killshot_receiver_01|autogun_rifle_killshot_receiver_02|autogun_rifle_killshot_receiver_03|autogun_rifle_killshot_receiver_04|autogun_rifle_killshot_receiver_ml01"
local autopistol_magazines = "autogun_pistol_magazine_01|autogun_pistol_magazine_01_double"
local laser_magazines = "autogun_rifle_laser_magazine_01|autogun_rifle_laser_magazine_02|autogun_rifle_laser_magazine_03"
local bolter_magazines = "boltgun_rifle_magazine_01_ba|boltgun_rifle_magazine_02_ba|boltgun_rifle_magazine_01_double|boltgun_rifle_magazine_02_double"
local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local scopes = "scope_01"

local attachments = {
    autogun_p1_m1 = {
        rail = rails,
        bayonet = bayonet_common,
        emblem_left = decals_left,
        emblem_right = decals_right,
        flashlight = table_merge_recursive_n(nil, laser_pointer_human, flashlight_modded_human),
        muzzle = table_merge_recursive_n(nil, muzzle_autogun_braced, muzzle_autogun_headhunter, muzzle_suppressors),
        barrel = table_merge_recursive_n(nil, barrel_autogun_braced, barrel_autogun_headhunter),
        receiver = table_merge_recursive_n(nil, receiver_autogun_braced, receiver_autogun_headhunter),
        grip = table_merge_recursive_n(nil, grip_common, grip_autogun_braced, grip_autogun_headhunter),
        stock = table_merge_recursive_n(nil, stock_common, stock_autogun_braced, stock_autogun_headhunter),
        magazine = table_merge_recursive_n(nil, magazine_autopistol, magazine_autogun_double, magazine_autopistol_double, magazine_autogun_braced, magazine_laser, magazine_bolter, magazine_bolter_double),
        sight = table_merge_recursive_n(nil, sight_reflex, sight_scope, sight_autogun_braced, sight_autogun_headhunter),
    },
}

attachments.autogun_p1_m2 = table_clone(attachments.autogun_p1_m1)
attachments.autogun_p1_m3 = table_clone(attachments.autogun_p1_m1)
attachments.autogun_npc_01 = table_clone(attachments.autogun_p1_m1)
attachments.autogun_npc_02 = table_clone(attachments.autogun_p1_m1)
attachments.autogun_npc_03 = table_clone(attachments.autogun_p1_m1)

local fixes = {
    autogun_p1_m1 = {
        -- Adjust barrel position when mixing braced and non-braced receivers and barrels
        {attachment_slot = "barrel",
            requirements = {
                receiver = {
                    has = braced_receivers,
                },
                barrel = {
                    has = "query:autogun_p1_m1,barrel,extended_weapon_customization|extended_weapon_customization_base_additions,"..braced_barrels,
                },
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
                    has = "query:autogun_p1_m1,receiver,extended_weapon_customization|extended_weapon_customization_base_additions,"..braced_receivers,
                },
                barrel = {
                    has = braced_barrels,
                },
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
                    scale = vector3_box(1.15, 1.05, 1.15),
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
        -- Sight offset when using scopes on infantry receivers
        {attachment_slot = "sight_offset",
            requirements = {
                sight = { has = scopes },
                receiver = { has = infantry_receivers },
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
        -- Sight offset when using scopes on braced receivers
        {attachment_slot = "sight_offset",
            requirements = {
                sight = { has = scopes },
                receiver = { has = braced_receivers },
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
                sight = { has = scopes },
                receiver = { has = headhunter_receivers },
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
        -- Adjust sight position when reflex sights on braced receiver
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

fixes.autogun_p1_m2 = table_clone(fixes.autogun_p1_m1)
fixes.autogun_p1_m3 = table_clone(fixes.autogun_p1_m1)
fixes.autogun_npc_01 = table_clone(fixes.autogun_p1_m1)
fixes.autogun_npc_02 = table_clone(fixes.autogun_p1_m1)
fixes.autogun_npc_03 = table_clone(fixes.autogun_p1_m1)

local attachment_slots = {
    autogun_p1_m1 = {},
}

attachment_slots.autogun_p1_m2 = table_clone(attachment_slots.autogun_p1_m1)
attachment_slots.autogun_p1_m3 = table_clone(attachment_slots.autogun_p1_m1)
attachment_slots.autogun_npc_01 = table_clone(attachment_slots.autogun_p1_m1)
attachment_slots.autogun_npc_02 = table_clone(attachment_slots.autogun_p1_m1)
attachment_slots.autogun_npc_03 = table_clone(attachment_slots.autogun_p1_m1)

local kitbashs = {

    -- ##### Double magazines #########################################################################################

    [_item_ranged.."/magazines/autogun_rifle_magazine_01_double"] = {
        attachments = {
            zzz_shared_material_overrides = {
                item = "",
                children = {},
            },
            double_magazine_1 = {
                item = _item_ranged.."/magazines/autogun_rifle_magazine_01",
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
                                position = vector3_box(.0325, -.01, -.15),
                                rotation = vector3_box(0, 90, 0),
                                scale = vector3_box(1, 1.2, .75),
                            },
                        },
                        children = {
                            double_magazine_2 = {
                                item = _item_ranged.."/magazines/autogun_rifle_magazine_01",
                                fix = {
                                    offset = {
                                        node = 1,
                                        position = vector3_box(.15, .005, -.125),
                                        rotation = vector3_box(0, 90, 0),
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
        description = "loc_description_autogun_rifle_magazine_01_double",
        attach_node = "ap_magazine_01",
        -- dev_name = "loc_autogun_rifle_magazine_01_double",

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
            ["content/weapons/player/ranged/autogun_rifle/attachments/magazine_01/magazine_01"] = true,
            ["content/weapons/player/ranged/lasgun_rifle/attachments/magazine_01/magazine_01"] = true,
        },
        workflow_checklist = {
        },
        name = _item_ranged.."/magazines/autogun_rifle_magazine_01_double",
        workflow_state = "RELEASABLE",
        is_full_item = true,
        disable_vfx_spawner_exclusion = true,
    },
    [_item_ranged.."/magazines/autogun_rifle_magazine_02_double"] = {
        attachments = {
            zzz_shared_material_overrides = {
                item = "",
                children = {},
            },
            double_magazine_1 = {
                item = _item_ranged.."/magazines/autogun_rifle_magazine_02",
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
                                position = vector3_box(.0325, -.01, -.15),
                                rotation = vector3_box(0, 90, 0),
                                scale = vector3_box(1, 1.2, .75),
                            },
                        },
                        children = {
                            double_magazine_2 = {
                                item = _item_ranged.."/magazines/autogun_rifle_magazine_02",
                                fix = {
                                    offset = {
                                        node = 1,
                                        position = vector3_box(.15, .005, -.125),
                                        rotation = vector3_box(0, 90, 0),
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
        description = "loc_description_autogun_rifle_magazine_02_double",
        attach_node = "ap_magazine_01",
        -- dev_name = "loc_autogun_rifle_magazine_02_double",
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
            ["content/weapons/player/ranged/autogun_rifle/attachments/magazine_02/magazine_02"] = true,
            ["content/weapons/player/ranged/lasgun_rifle/attachments/magazine_01/magazine_01"] = true,
        },
        workflow_checklist = {
        },
        name = _item_ranged.."/magazines/autogun_rifle_magazine_02_double",
        workflow_state = "RELEASABLE",
        is_full_item = true,
        disable_vfx_spawner_exclusion = true,
    },
    [_item_ranged.."/magazines/autogun_rifle_magazine_03_double"] = {
        attachments = {
            zzz_shared_material_overrides = {
                item = "",
                children = {},
            },
            double_magazine_1 = {
                item = _item_ranged.."/magazines/autogun_rifle_magazine_03",
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
                                position = vector3_box(.0325, -.01, -.15),
                                rotation = vector3_box(0, 90, 0),
                                scale = vector3_box(1, 1.2, .75),
                            },
                        },
                        children = {
                            double_magazine_2 = {
                                item = _item_ranged.."/magazines/autogun_rifle_magazine_03",
                                fix = {
                                    offset = {
                                        node = 1,
                                        position = vector3_box(.15, .005, -.125),
                                        rotation = vector3_box(0, 90, 0),
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
        description = "loc_description_autogun_rifle_magazine_03_double",
        attach_node = "ap_magazine_01",
        -- dev_name = "loc_autogun_rifle_magazine_03_double",
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
            ["content/weapons/player/ranged/autogun_rifle/attachments/magazine_03/magazine_03"] = true,
            ["content/weapons/player/ranged/lasgun_rifle/attachments/magazine_01/magazine_01"] = true,
        },
        workflow_checklist = {
        },
        name = _item_ranged.."/magazines/autogun_rifle_magazine_03_double",
        workflow_state = "RELEASABLE",
        is_full_item = true,
        disable_vfx_spawner_exclusion = true,
    },

    -- ##### Laser magazines ##########################################################################################

    [_item_ranged.."/magazines/autogun_rifle_laser_magazine_01"] = {
        attachments = {
            zzz_shared_material_overrides = {
                item = "",
                children = {},
            },
        },
        display_name = "",
        description = "loc_description_autogun_rifle_laser_magazine_01",
        attach_node = "ap_magazine_01",
        -- dev_name = "loc_autogun_rifle_laser_magazine_01",
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/ranged/lasgun_rifle/attachments/magazine_ml01/magazine_ml01",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
        },
        resource_dependencies = {
            ["content/weapons/player/ranged/lasgun_rifle/attachments/magazine_ml01/magazine_ml01"] = true,
            -- Muzzle flash
            ["content/fx/particles/weapons/rifles/lasgun/lasgun_muzzle_elysian"] = true,
            ["content/fx/particles/weapons/rifles/autogun/autogun_muzzle_02"] = true,
            ["content/fx/particles/weapons/rifles/autogun/autogun_muzzle_crit"] = true,
            -- Line effect
            ["content/fx/particles/weapons/rifles/lasgun/lasgun_beam_elysian"] = true,
            ["content/fx/particles/weapons/rifles/lasgun/lasgun_beam_crit"] = true,
            ["content/fx/particles/weapons/rifles/lasgun/lasgun_beam_standard_linger"] = true,
            -- Sounds
            ["wwise/events/weapon/play_weapon_lasgun_crack_beam_nearby"] = true,
            ["wwise/events/weapon/play_lasgun_p3_m2_fire_auto"] = true,
            ["wwise/events/weapon/stop_lasgun_p3_m2_fire_auto"] = true,
            ["wwise/events/weapon/play_lasgun_p3_m3_fire_single"] = true,
        },
        workflow_checklist = {
        },
        name = _item_ranged.."/magazines/autogun_rifle_laser_magazine_01",
        workflow_state = "RELEASABLE",
        is_full_item = true,
        disable_vfx_spawner_exclusion = true,
    },
    [_item_ranged.."/magazines/autogun_rifle_laser_magazine_02"] = {
        attachments = {
            zzz_shared_material_overrides = {
                item = "",
                children = {},
            },
        },
        display_name = "",
        description = "loc_description_autogun_rifle_laser_magazine_01",
        attach_node = "ap_magazine_01",
        -- dev_name = "loc_autogun_rifle_laser_magazine_01",
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/ranged/lasgun_rifle/attachments/magazine_01/magazine_01",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
        },
        resource_dependencies = {
            ["content/weapons/player/ranged/lasgun_rifle/attachments/magazine_01/magazine_01"] = true,
            -- Muzzle flash
            ["content/fx/particles/weapons/rifles/lasgun/lasgun_muzzle_elysian"] = true,
            ["content/fx/particles/weapons/rifles/autogun/autogun_muzzle_02"] = true,
            ["content/fx/particles/weapons/rifles/autogun/autogun_muzzle_crit"] = true,
            -- Line effect
            ["content/fx/particles/weapons/rifles/lasgun/lasgun_beam_elysian"] = true,
            ["content/fx/particles/weapons/rifles/lasgun/lasgun_beam_crit"] = true,
            ["content/fx/particles/weapons/rifles/lasgun/lasgun_beam_standard_linger"] = true,
            -- Sounds
            ["wwise/events/weapon/play_weapon_lasgun_crack_beam_nearby"] = true,
            ["wwise/events/weapon/play_lasgun_p3_m2_fire_auto"] = true,
            ["wwise/events/weapon/stop_lasgun_p3_m2_fire_auto"] = true,
            ["wwise/events/weapon/play_lasgun_p3_m3_fire_single"] = true,
        },
        workflow_checklist = {
        },
        name = _item_ranged.."/magazines/autogun_rifle_laser_magazine_02",
        workflow_state = "RELEASABLE",
        is_full_item = true,
        disable_vfx_spawner_exclusion = true,
    },
    [_item_ranged.."/magazines/autogun_rifle_laser_magazine_03"] = {
        attachments = {
            zzz_shared_material_overrides = {
                item = "",
                children = {},
            },
        },
        display_name = "",
        description = "loc_description_autogun_rifle_laser_magazine_01",
        attach_node = "ap_magazine_01",
        -- dev_name = "loc_autogun_rifle_laser_magazine_01",
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/ranged/lasgun_rifle_krieg/attachments/magazine_01/magazine_01",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
        },
        resource_dependencies = {
            ["content/weapons/player/ranged/lasgun_rifle_krieg/attachments/magazine_01/magazine_01"] = true,
            -- Muzzle flash
            ["content/fx/particles/weapons/rifles/lasgun/lasgun_muzzle_elysian"] = true,
            ["content/fx/particles/weapons/rifles/autogun/autogun_muzzle_02"] = true,
            ["content/fx/particles/weapons/rifles/autogun/autogun_muzzle_crit"] = true,
            -- Line effect
            ["content/fx/particles/weapons/rifles/lasgun/lasgun_beam_elysian"] = true,
            ["content/fx/particles/weapons/rifles/lasgun/lasgun_beam_crit"] = true,
            ["content/fx/particles/weapons/rifles/lasgun/lasgun_beam_standard_linger"] = true,
            -- Sounds
            ["wwise/events/weapon/play_weapon_lasgun_crack_beam_nearby"] = true,
            ["wwise/events/weapon/play_lasgun_p3_m2_fire_auto"] = true,
            ["wwise/events/weapon/stop_lasgun_p3_m2_fire_auto"] = true,
            ["wwise/events/weapon/play_lasgun_p3_m3_fire_single"] = true,
        },
        workflow_checklist = {
        },
        name = _item_ranged.."/magazines/autogun_rifle_laser_magazine_03",
        workflow_state = "RELEASABLE",
        is_full_item = true,
        disable_vfx_spawner_exclusion = true,
    },

    -- ##### Muzzles ##################################################################################################

    [_item_ranged.."/muzzles/autogun_rifle_invisible_muzzle_01"] = {
        attachments = {
            zzz_shared_material_overrides = {
                item = "",
                children = {},
            },
            muzzle = {
                item = _item_ranged.."/muzzles/autogun_rifle_ak_muzzle_05",
                fix = {
                    offset = {
                        node = 1,
                        position = vector3_box(0, 0, 0),
                        rotation = vector3_box(0, 0, 0),
                        scale = vector3_box(1, 1, 1),
                    },
                    alpha = 1,
                },
                children = {},
            },
        },
        display_name = "",
        description = "loc_description_autogun_rifle_suppressed_muzzle_01",
        attach_node = "ap_muzzle_01",
        -- dev_name = "loc_autogun_rifle_suppressed_muzzle_01",
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
            ["content/weapons/player/ranged/autogun_rifle_ak/attachments/muzzle_05/muzzle_05"] = true,
        },
        workflow_checklist = {
        },
        name = _item_ranged.."/muzzles/autogun_rifle_invisible_muzzle_01",
        workflow_state = "RELEASABLE",
        is_full_item = true,
        disable_vfx_spawner_exclusion = true,
    },

    -- ##### Suppressors ##############################################################################################

    [_item_ranged.."/muzzles/autogun_rifle_suppressed_muzzle_01"] = {
        attachments = {
            zzz_shared_material_overrides = {
                item = "",
                children = {},
            },
            inv_muzzle = {
                item = _item_ranged.."/muzzles/autogun_rifle_ak_muzzle_05",
                fix = {
                    offset = {
                        node = 1,
                        position = vector3_box(0, 0, 0),
                        rotation = vector3_box(0, 0, 0),
                        scale = vector3_box(1.5, 2, 1.5),
                    },
                },
                children = {
                    inv_muzzle2 = {
                        item = _item_ranged.."/muzzles/lasgun_rifle_muzzle_04",
                        fix = {
                            offset = {
                                node = 1,
                                position = vector3_box(0, 0, 0),
                                rotation = vector3_box(0, 0, 0),
                                scale = vector3_box(1, 1, 1),
                            },
                        },
                        children = {},
                    },
                },
            },
        },
        display_name = "",
        description = "loc_description_autogun_rifle_suppressed_muzzle_01",
        attach_node = "ap_muzzle_01",
        -- dev_name = "loc_autogun_rifle_suppressed_muzzle_01",
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
            ["content/weapons/player/ranged/autogun_rifle_ak/attachments/muzzle_05/muzzle_05"] = true,
            ["content/weapons/player/ranged/lasgun_rifle/attachments/muzzle_04/muzzle_04"] = true,
            -- Muzzle flash
            ["content/fx/particles/weapons/rifles/bolter/bolter_muzzle_secondary"] = true,
            -- Line effect
            ["content/fx/particles/weapons/rifles/autogun/autogun_tracer_trail"] = true,
            ["content/fx/particles/weapons/rifles/autogun/autogun_smoke_trail"] = true,
            ["content/fx/particles/weapons/rifles/autogun/autogun_smoke_trail_3p"] = true,
            ["content/fx/particles/weapons/rifles/ogryn_heavystubber/heavystubber_tracer_trail"] = true,
            -- Sounds
            ["wwise/events/weapon/play_weapon_silence"] = true,
            ["wwise/events/weapon/stop_weapon_silence"] = true,
            ["wwise/events/weapon/play_heavy_swing_hit"] = true,
            -- ["wwise/events/weapon/play_shotgun_p1_m2_special"] = true,
            -- ["wwise/events/weapon/play_shotgun_p4_m2_special"] = true,
        },
        workflow_checklist = {
        },
        name = _item_ranged.."/muzzles/autogun_rifle_suppressed_muzzle_01",
        workflow_state = "RELEASABLE",
        is_full_item = true,
        disable_vfx_spawner_exclusion = true,
    },
    [_item_ranged.."/muzzles/autogun_rifle_suppressed_muzzle_02"] = {
        attachments = {
            zzz_shared_material_overrides = {
                item = "",
                children = {},
            },
            inv_muzzle = {
                item = _item_ranged.."/muzzles/autogun_rifle_ak_muzzle_03",
                fix = {
                    offset = {
                        node = 1,
                        position = vector3_box(0, 0, 0),
                        rotation = vector3_box(0, 0, 0),
                        scale = vector3_box(1.5, 2, 1.5),
                    },
                },
                children = {
                    inv_muzzle2 = {
                        item = _item_ranged.."/muzzles/lasgun_rifle_muzzle_03",
                        fix = {
                            offset = {
                                node = 1,
                                position = vector3_box(0, 0, 0),
                                rotation = vector3_box(0, 0, 0),
                                scale = vector3_box(1, 1, 1),
                            },
                        },
                        children = {},
                    },
                },
            },
        },
        display_name = "",
        description = "loc_description_autogun_rifle_suppressed_muzzle_01",
        attach_node = "ap_muzzle_01",
        -- dev_name = "loc_autogun_rifle_suppressed_muzzle_01",
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
            ["content/weapons/player/ranged/autogun_rifle_ak/attachments/muzzle_03/muzzle_03"] = true,
            ["content/weapons/player/ranged/lasgun_rifle/attachments/muzzle_03/muzzle_03"] = true,
            -- Muzzle flash
            ["content/fx/particles/weapons/rifles/bolter/bolter_muzzle_secondary"] = true,
            -- Line effect
            ["content/fx/particles/weapons/rifles/autogun/autogun_tracer_trail"] = true,
            ["content/fx/particles/weapons/rifles/autogun/autogun_smoke_trail"] = true,
            ["content/fx/particles/weapons/rifles/autogun/autogun_smoke_trail_3p"] = true,
            ["content/fx/particles/weapons/rifles/ogryn_heavystubber/heavystubber_tracer_trail"] = true,
            -- Sounds
            ["wwise/events/weapon/play_weapon_silence"] = true,
            ["wwise/events/weapon/stop_weapon_silence"] = true,
            ["wwise/events/weapon/play_heavy_swing_hit"] = true,
            -- ["wwise/events/weapon/play_shotgun_p1_m2_special"] = true,
            -- ["wwise/events/weapon/play_shotgun_p4_m2_special"] = true,
        },
        workflow_checklist = {
        },
        name = _item_ranged.."/muzzles/autogun_rifle_suppressed_muzzle_02",
        workflow_state = "RELEASABLE",
        is_full_item = true,
        disable_vfx_spawner_exclusion = true,
    },
    [_item_ranged.."/muzzles/autogun_rifle_suppressed_muzzle_03"] = {
        attachments = {
            zzz_shared_material_overrides = {
                item = "",
                children = {},
            },
            inv_muzzle = {
                item = _item_ranged.."/muzzles/autogun_rifle_muzzle_02",
                fix = {
                    offset = {
                        node = 1,
                        position = vector3_box(0, 0, 0),
                        rotation = vector3_box(0, 0, 0),
                        scale = vector3_box(1.5, 2, 1.5),
                    },
                },
                children = {
                    inv_muzzle2 = {
                        item = _item_ranged.."/muzzles/lasgun_rifle_muzzle_01",
                        fix = {
                            offset = {
                                node = 1,
                                position = vector3_box(0, 0, 0),
                                rotation = vector3_box(0, 0, 0),
                                scale = vector3_box(1, 1, 1),
                            },
                        },
                        children = {},
                    },
                },
            },
        },
        display_name = "",
        description = "loc_description_autogun_rifle_suppressed_muzzle_01",
        attach_node = "ap_muzzle_01",
        -- dev_name = "loc_autogun_rifle_suppressed_muzzle_01",
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
            ["content/weapons/player/ranged/autogun_rifle/attachments/muzzle_02/muzzle_02"] = true,
            ["content/weapons/player/ranged/lasgun_rifle/attachments/muzzle_01/muzzle_01"] = true,
            -- Muzzle flash
            ["content/fx/particles/weapons/rifles/bolter/bolter_muzzle_secondary"] = true,
            -- Line effect
            ["content/fx/particles/weapons/rifles/autogun/autogun_tracer_trail"] = true,
            ["content/fx/particles/weapons/rifles/autogun/autogun_smoke_trail"] = true,
            ["content/fx/particles/weapons/rifles/autogun/autogun_smoke_trail_3p"] = true,
            ["content/fx/particles/weapons/rifles/ogryn_heavystubber/heavystubber_tracer_trail"] = true,
            -- Sounds
            ["wwise/events/weapon/play_weapon_silence"] = true,
            ["wwise/events/weapon/stop_weapon_silence"] = true,
            ["wwise/events/weapon/play_heavy_swing_hit"] = true,
            -- ["wwise/events/weapon/play_shotgun_p1_m2_special"] = true,
            -- ["wwise/events/weapon/play_shotgun_p4_m2_special"] = true,
        },
        workflow_checklist = {
        },
        name = _item_ranged.."/muzzles/autogun_rifle_suppressed_muzzle_03",
        workflow_state = "RELEASABLE",
        is_full_item = true,
        disable_vfx_spawner_exclusion = true,
    },
}

return {
    attachment_slots = attachment_slots,
    attachments = attachments,
    kitbashs = kitbashs,
    fixes = fixes,
}
