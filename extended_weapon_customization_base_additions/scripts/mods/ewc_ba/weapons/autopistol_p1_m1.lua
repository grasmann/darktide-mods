local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local autogun_infantry_group = {custom_selection_group = "autogun_infantry"}
local magazine_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_infantry")
mod:merge_attachment_data(autogun_infantry_group, magazine_autogun_infantry)

local autogun_braced_group = {custom_selection_group = "autogun_braced"}
local magazine_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_braced")
mod:merge_attachment_data(autogun_braced_group, magazine_autogun_braced)

local magazine_laser_group = {custom_selection_group = "magazine_laser"}
local magazine_laser = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_laser_autogun")
mod:merge_attachment_data(magazine_laser_group, magazine_laser)

local bolter_group = {custom_selection_group = "bolter"}
local magazine_bolter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_bolter")
local magazine_bolter_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_bolter_double")
mod:merge_attachment_data(bolter_group, magazine_bolter, magazine_bolter_double)

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
local laser_magazines = "autogun_rifle_laser_magazine_01|autogun_rifle_laser_magazine_02|autogun_rifle_laser_magazine_03"
local bolter_magazines = "boltgun_rifle_magazine_01_ba|boltgun_rifle_magazine_02_ba|boltgun_rifle_magazine_01_double|boltgun_rifle_magazine_02_double"
local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local scopes = "scope_01"

local attachments = {
    autopistol_p1_m1 = {
        grip = grip_common,
        flashlight = table_merge_recursive_n(nil, laser_pointer_human, flashlight_modded_human),
        magazine = table_merge_recursive_n(nil, magazine_autogun_double, magazine_autopistol_double, magazine_autogun_infantry, magazine_autogun_braced, magazine_laser, magazine_bolter, magazine_bolter_double),
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
        -- Adjust magazine scale when using autogun magazines
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
        -- Adjust magazine scale when using braced autogun magazines
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
                    scale = vector3_box(1, .6, 1.5),
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
                    position = vector3_box(0, 0, -.05),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(.7, .6, .8),
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
                    position = vector3_box(0, 0, -.0075),
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
                    position = vector3_box(0, -.05, -.03),
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
                    position = vector3_box(0, -.04, 0),
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
                    position = vector3_box(0, -.06, .0225),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        -- Adjust rail position when using reflex sights or scopes
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
            zzz_shared_material_overrides = {
                item = "",
                children = {},
            },
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
        display_name = "",
        description = "loc_description_autogun_pistol_magazine_01_double",
        attach_node = "ap_magazine_01",
        -- dev_name = "loc_autogun_pistol_magazine_01_double",
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
            ["content/weapons/player/ranged/autogun_pistol/attachments/magazine_01/magazine_01"] = true,
            ["content/weapons/player/ranged/lasgun_rifle/attachments/magazine_01/magazine_01"] = true,
        },
        workflow_checklist = {
        },
        name = _item_ranged.."/magazines/autogun_pistol_magazine_01_double",
        workflow_state = "RELEASABLE",
        is_full_item = true,
        disable_vfx_spawner_exclusion = true,
    },
    [_item_ranged.."/magazines/autopistol_laser_magazine_01"] = {
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
        name = _item_ranged.."/magazines/autopistol_laser_magazine_01",
        workflow_state = "RELEASABLE",
        is_full_item = true,
        disable_vfx_spawner_exclusion = true,
    },
    [_item_ranged.."/magazines/autopistol_laser_magazine_02"] = {
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
        name = _item_ranged.."/magazines/autopistol_laser_magazine_02",
        workflow_state = "RELEASABLE",
        is_full_item = true,
        disable_vfx_spawner_exclusion = true,
    },
    [_item_ranged.."/magazines/autopistol_laser_magazine_03"] = {
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
        name = _item_ranged.."/magazines/autopistol_laser_magazine_03",
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
