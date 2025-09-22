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
local magazine_autogun = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun")
local magazine_autogun_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_double")
local magazine_autopistol_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autopistol_double")

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

local autogun_magazines = "autogun_rifle_magazine_01|autogun_rifle_magazine_02|autogun_rifle_magazine_03|autogun_rifle_magazine_01_double|autogun_rifle_magazine_02_double|autogun_rifle_magazine_03_double"
local braced_magazines = "autogun_rifle_ak_magazine_01|autogun_rifle_ak_magazine_01_double"

local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local scopes = "scope_01"

local attachments = {
    autopistol_p1_m1 = {
        rail = rails,
        magazine = table_merge_recursive(
            table_merge_recursive(
                magazine_autogun,
                magazine_autogun_double
            ),
        magazine_autopistol_double),
        sight = table_merge_recursive(
            table_merge_recursive({
                lasgun_rifle_sight_01 = {
                    replacement_path = _item_ranged.."/sights/lasgun_rifle_sight_01",
                    icon_render_unit_rotation_offset = {90, 0, -95},
                    icon_render_camera_position_offset = {.035, -.1, .125},
                },
            }, sight_reflex),
        sight_scope),
    },
}

local fixes = {
    autopistol_p1_m1 = {
        {attachment_slot = "magazine",
            requirements = {
                magazine = {
                    has = autogun_magazines,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, .6, 1),
                },
            },
        },
        {attachment_slot = "magazine",
            requirements = {
                magazine = {
                    has = braced_magazines,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.04),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, .6, .85),
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
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.04, 0),
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
                -- attach = {
                --     rail = "lasgun_rifle_rail_01",
                -- },
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

local kitbashs = {
    [_item_ranged.."/magazines/autogun_pistol_magazine_01_double"] = {
        attachments = {
            double_magazine_1 = {
                item = _item_ranged.."/magazines/autogun_pistol_magazine_01",
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
                                scale = vector3_box(1, .8, .75),
                            },
                        },
                        children = {
                            double_magazine_2 = {
                                item = _item_ranged.."/magazines/autogun_pistol_magazine_01",
                                fix = {
                                    offset = {
                                        node = 1,
                                        position = vector3_box(.15, .005, -.125),
                                        rotation = vector3_box(0, 90, 0),
                                        scale = vector3_box(1.3, 1.3, 1),
                                    },
                                },
                                children = {},
                            },
                        },
                    },
                },
            },
        },
        display_name = "loc_autogun_pistol_magazine_01_double",
        description = "loc_description_autogun_pistol_magazine_01_double",
        attach_node = "ap_magazine_01",
        dev_name = "loc_autogun_pistol_magazine_01_double",
    },
}

return {
    attachments = attachments,
    fixes = fixes,
    kitbashs = kitbashs,
}
