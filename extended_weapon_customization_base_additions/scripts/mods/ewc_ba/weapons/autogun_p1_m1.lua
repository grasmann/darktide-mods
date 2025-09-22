local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

-- local trinket_hooks = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/trinket_hook")
-- local flashlights = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/flashlight")
local sight_reflex = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_reflex")
local sight_scope = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_scope")
local rails = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/rail")
-- local emblem_left = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/emblem_left")
-- local emblem_right = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/emblem_right")
local magazine_autopistol = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autopistol")
local magazine_autogun_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_double")

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
        magazine = table_merge_recursive(
            magazine_autopistol,
            magazine_autogun_double
        ),
        sight = table_merge_recursive(
            table_merge_recursive({
                lasgun_rifle_sight_01 = {
                    replacement_path = _item_ranged.."/sights/lasgun_rifle_sight_01",
                    icon_render_unit_rotation_offset = {90, 0, -95},
                    icon_render_camera_position_offset = {.035, -.1, .125},
                },
            },
            sight_reflex),
        sight_scope),
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
                    scale = vector3_box(1, 1.8, 1.8),
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
                    position = vector3_box(0, 0, -.0085),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        {attachment_slot = "sight",
            requirements = {
                sight = {
                    has = reflex_sights.."|"..scopes,
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
                    has = reflex_sights.."|"..scopes,
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
                    has = reflex_sights.."|"..scopes.."|autogun_rifle_killshot_sight_01|autogun_rifle_ak_sight_01",
                },
            },
            fix = {
                attach = {
                    rail = "lasgun_rifle_rail_01",
                },
                offset = {
                    position = vector3_box(0, -.05, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1.3, 1),
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
    },
    [_item_ranged.."/magazines/autogun_rifle_ak_magazine_01_double"] = {
        attachments = {
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
        display_name = "loc_autogun_rifle_ak_magazine_01_double",
        description = "loc_description_autogun_rifle_ak_magazine_01_double",
        attach_node = "ap_magazine_01",
        dev_name = "loc_autogun_rifle_ak_magazine_01_double",
    },
}

return {
    attachments = attachments,
    fixes = fixes,
    kitbashs = kitbashs,
}
