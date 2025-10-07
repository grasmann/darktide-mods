local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local magazine_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_infantry")
mod:modify_customization_groups(magazine_autogun_infantry, "autogun_infantry")

local magazine_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_braced")
mod:modify_customization_groups(magazine_autogun_braced, "autogun_braced")

local magazine_autopistol_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autopistol_double")
local magazine_autogun_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_double")
local flashlight_modded_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/flashlight_modded_human")
local laser_pointer_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/laser_pointer_human")
local sight_reflex = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_reflex")
local sight_scope = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_scope")
local grip_common = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_common")
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

local autogun_magazines = "autogun_rifle_magazine_01|autogun_rifle_magazine_02|autogun_rifle_magazine_03|autogun_rifle_magazine_01_double|autogun_rifle_magazine_02_double|autogun_rifle_magazine_03_double"
local braced_magazines = "autogun_rifle_ak_magazine_01|autogun_rifle_ak_magazine_01_double"
local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local scopes = "scope_01"

local attachments = {
    autopistol_p1_m1 = {
        grip = grip_common,
        flashlight = table_merge_recursive_n(nil, laser_pointer_human, flashlight_modded_human),
        magazine = table_merge_recursive_n(nil, magazine_autogun_double, magazine_autopistol_double, magazine_autogun_infantry, magazine_autogun_braced),
        sight = table_merge_recursive_n(nil, sight_reflex, sight_scope, {
            lasgun_rifle_sight_01 = {
                replacement_path = _item_ranged.."/sights/lasgun_rifle_sight_01",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .125},
            },
        }),
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
                    has = reflex_sights,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.0075),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        {attachment_slot = "sight_offset",
            requirements = {
                sight = {
                    has = scopes,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.05, -.03),
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
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.04, 0),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        {attachment_slot = "sight",
            requirements = {
                sight = {
                    has = scopes,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.06, .0225),
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
        disable_vfx_spawner_exclusion = true,
    },
}

return {
    attachments = attachments,
    fixes = fixes,
    kitbashs = kitbashs,
}
