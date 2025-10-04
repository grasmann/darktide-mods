local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local autogun_headhunter_group = {custom_selection_group = "autogun_headhunter"}
local autogun_braced_group = {custom_selection_group = "autogun_braced"}
local autopistol_group = {custom_selection_group = "autopistol"}

local receiver_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/receiver_autogun_headhunter")
-- mod:modify_customization_groups(receiver_autogun_headhunter, "autogun_headhunter")
local magazine_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_headhunter")
-- mod:modify_customization_groups(magazine_autogun_headhunter, "autogun_headhunter")
local barrel_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/barrel_autogun_headhunter")
-- mod:modify_customization_groups(barrel_autogun_headhunter, "autogun_headhunter")
local muzzle_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_headhunter")
-- mod:modify_customization_groups(muzzle_autogun_headhunter, "autogun_headhunter")
local stock_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/stock_autogun_headhunter")
-- mod:modify_customization_groups(stock_autogun_headhunter, "autogun_headhunter")
local sight_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_autogun_headhunter")
-- mod:modify_customization_groups(sight_autogun_headhunter, "autogun_headhunter")
local grip_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_autogun_headhunter")
-- mod:modify_customization_groups(grip_autogun_headhunter, "autogun_headhunter")
mod:merge_attachment_data(autogun_headhunter_group, receiver_autogun_headhunter, magazine_autogun_headhunter, barrel_autogun_headhunter, muzzle_autogun_headhunter, stock_autogun_headhunter, sight_autogun_headhunter, grip_autogun_headhunter)

local magazine_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_braced")
-- mod:modify_customization_groups(magazine_autogun_braced, "autogun_braced")
local receiver_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/receiver_autogun_braced")
-- mod:modify_customization_groups(receiver_autogun_braced, "autogun_braced")
local barrel_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/barrel_autogun_braced")
-- mod:modify_customization_groups(barrel_autogun_braced, "autogun_braced")
local muzzle_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_braced")
-- mod:modify_customization_groups(muzzle_autogun_braced, "autogun_braced")
local sight_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_autogun_braced")
-- mod:modify_customization_groups(sight_autogun_braced, "autogun_braced")
local stock_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/stock_autogun_braced")
-- mod:modify_customization_groups(stock_autogun_braced, "autogun_braced")
local grip_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_autogun_braced")
-- mod:modify_customization_groups(grip_autogun_braced, "autogun_braced")
mod:merge_attachment_data(autogun_braced_group, receiver_autogun_braced, magazine_autogun_braced, barrel_autogun_braced, muzzle_autogun_braced, stock_autogun_braced, sight_autogun_braced, grip_autogun_braced)

local magazine_autopistol = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autopistol")
-- mod:modify_customization_groups(magazine_autopistol, "autopistol")
mod:merge_attachment_data(autopistol_group, magazine_autopistol)

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

local infantry_receivers = "autogun_rifle_receiver_01|autogun_rifle_receiver_ml01"
local braced_barrels = "autogun_rifle_barrel_ak_01|autogun_rifle_barrel_ak_02|autogun_rifle_barrel_ak_03|autogun_rifle_barrel_ak_04|autogun_rifle_barrel_ak_05|autogun_rifle_barrel_ak_06|autogun_rifle_barrel_ak_07|autogun_rifle_barrel_ak_08|autogun_rifle_barrel_ak_ml01"
local headhunter_receivers = "autogun_rifle_killshot_receiver_01|autogun_rifle_killshot_receiver_02|autogun_rifle_killshot_receiver_03|autogun_rifle_killshot_receiver_04|autogun_rifle_killshot_receiver_ml01"
local braced_receivers = "autogun_rifle_ak_receiver_01|autogun_rifle_ak_receiver_02|autogun_rifle_ak_receiver_03|autogun_rifle_ak_receiver_ml01"
local autopistol_magazines = "autogun_pistol_magazine_01|autogun_pistol_magazine_01_double"
local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local scopes = "scope_01"

local attachments = {
    autogun_p1_m1 = {
        rail = rails,
        bayonet = bayonet_common,
        emblem_left = decals_left,
        emblem_right = decals_right,
        flashlight = table_merge_recursive_n(nil, laser_pointer_human, flashlight_modded_human),
        muzzle = table_merge_recursive_n(nil, muzzle_autogun_braced, muzzle_autogun_headhunter),
        barrel = table_merge_recursive_n(nil, barrel_autogun_braced, barrel_autogun_headhunter),
        receiver = table_merge_recursive_n(nil, receiver_autogun_braced, receiver_autogun_headhunter),
        grip = table_merge_recursive_n(nil, grip_common, grip_autogun_braced, grip_autogun_headhunter),
        stock = table_merge_recursive_n(nil, stock_common, stock_autogun_braced, stock_autogun_headhunter),
        magazine = table_merge_recursive_n(nil, magazine_autopistol, magazine_autogun_double, magazine_autopistol_double, magazine_autogun_braced),
        sight = table_merge_recursive_n(nil, sight_reflex, sight_scope, sight_autogun_braced, sight_autogun_headhunter),
    },
}

attachments.autogun_p1_m2 = table_clone(attachments.autogun_p1_m1)
attachments.autogun_p1_m3 = table_clone(attachments.autogun_p1_m1)

local fixes = {
    autogun_p1_m1 = {
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

local attachment_slots = {
    autogun_p1_m1 = {
    },
}

attachment_slots.autogun_p1_m2 = table_clone(attachment_slots.autogun_p1_m1)
attachment_slots.autogun_p1_m3 = table_clone(attachment_slots.autogun_p1_m1)

local kitbashs = {
    [_item_ranged.."/magazines/autogun_rifle_magazine_01_double"] = {
        attachments = {
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
        display_name = "loc_autogun_rifle_magazine_01_double",
        description = "loc_description_autogun_rifle_magazine_01_double",
        attach_node = "ap_magazine_01",
        dev_name = "loc_autogun_rifle_magazine_01_double",
        disable_vfx_spawner_exclusion = true,
    },
    [_item_ranged.."/magazines/autogun_rifle_magazine_02_double"] = {
        attachments = {
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
        display_name = "loc_autogun_rifle_magazine_02_double",
        description = "loc_description_autogun_rifle_magazine_02_double",
        attach_node = "ap_magazine_01",
        dev_name = "loc_autogun_rifle_magazine_02_double",
        disable_vfx_spawner_exclusion = true,
    },
    [_item_ranged.."/magazines/autogun_rifle_magazine_03_double"] = {
        attachments = {
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
        display_name = "loc_autogun_rifle_magazine_03_double",
        description = "loc_description_autogun_rifle_magazine_03_double",
        attach_node = "ap_magazine_01",
        dev_name = "loc_autogun_rifle_magazine_03_double",
        disable_vfx_spawner_exclusion = true,
    },
}

return {
    attachments = attachments,
    attachment_slots = attachment_slots,
    fixes = fixes,
    kitbashs = kitbashs,
}
