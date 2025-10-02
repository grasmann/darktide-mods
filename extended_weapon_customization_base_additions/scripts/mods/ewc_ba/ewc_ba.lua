local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    -- local unit = Unit
    local pairs = pairs
    local table = table
    local managers = Managers
    local vector3_box = Vector3Box
    local table_clone = table.clone
    local table_merge_recursive = table.merge_recursive
--#endregion

mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/extensions/common")

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.get_view = function(self, view_name)
    local ui_manager = managers.ui
    return ui_manager:view_active(view_name) and ui_manager:view_instance(view_name) or nil
end

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_melee = _item.."/melee"

local extended_weapon_customization_plugin = {
    attachments = {},
    attachment_slots = {},
    fixes = {},
    kitbashs = {
        [_item_ranged.."/lenses/lense_01"] = {
            is_fallback_item = false,
            show_in_1p = true,
            base_unit = "content/weapons/player/ranged/rippergun_rifle/ammunition/ammunition_01/ammunition_01",
            item_list_faction = "Player",
            tags = {
            },
            only_show_in_1p = false,
            feature_flags = {
                "ROTATION_ursula"
            },
            attach_node = "ap_bullet_01",
            resource_dependencies = {
                ["content/weapons/player/ranged/rippergun_rifle/ammunition/ammunition_01/ammunition_01"] = true,
            },
            attachments = {
                zzz_shared_material_overrides = {
                    leaf_attach_node_override = "",
                    link_map_mode_override = "",
                    item = "",
                    children = {},
                    material_overrides = {},
                },
            },
            workflow_checklist = {
            },
            display_name = "n/a",
            name = _item_ranged.."/lenses/lense_01",
            workflow_state = "RELEASABLE",
            is_full_item = true,
        },
        [_item_ranged.."/scope_bodies/scope_body_01"] = {
            is_fallback_item = false,
            show_in_1p = true,
            base_unit = "content/weapons/player/ranged/lasgun_rifle_krieg/attachments/muzzle_02/muzzle_02",
            item_list_faction = "Player",
            tags = {
            },
            only_show_in_1p = false,
            feature_flags = {
                "ROTATION_ursula"
            },
            attach_node = "ap_bullet_01",
            resource_dependencies = {
                ["content/weapons/player/ranged/lasgun_rifle_krieg/attachments/muzzle_02/muzzle_02"] = true,
            },
            attachments = {
                zzz_shared_material_overrides = {
                    leaf_attach_node_override = "",
                    link_map_mode_override = "",
                    item = "",
                    children = {},
                    material_overrides = {},
                },
            },
            workflow_checklist = {
            },
            display_name = "n/a",
            name = _item_ranged.."/scope_bodies/scope_body_01",
            workflow_state = "RELEASABLE",
            is_full_item = true,
        },
        [_item_ranged.."/sights/scope_01"] = {
            attachments = {
                base = {
                    item = _item_ranged.."/sights/reflex_sight_03",
                    fix = {
                        hide = {
                            mesh = {5},
                        },
                    },
                    children = {
                        scope = {
                            item = _item_ranged.."/scope_bodies/scope_body_01",
                            fix = {
                                offset = {
                                    node = 1,
                                    position = vector3_box(0, -.04, .035),
                                    rotation = vector3_box(0, 0, 0),
                                    scale = vector3_box(1.5, 1.5, 1.5),
                                },
                            },
                            children = {
                                lense_1 = {
                                    item = _item_ranged.."/lenses/lense_01",
                                    fix = {
                                        offset = {
                                            node = 1,
                                            position = vector3_box(0, .085, 0),
                                            rotation = vector3_box(0, 0, 0),
                                            scale = vector3_box(1, .35, 1),
                                        },
                                        alpha = .25,
                                    },
                                },
                                lense_2 = {
                                    item = _item_ranged.."/lenses/lense_01",
                                    fix = {
                                        offset = {
                                            node = 1,
                                            position = vector3_box(0, .075, 0),
                                            rotation = vector3_box(180, 0, 0),
                                            scale = vector3_box(1, .35, 1),
                                        },
                                        alpha = .25,
                                    },
                                },
                            },
                        },
                    },
                },
            },
            attach_node = "ap_sight_01",
            display_name = "loc_scope_01",
            description = "loc_description_scope_01",
            dev_name = "loc_scope_01",
            disable_vfx_spawner_exclusion = true,
        },
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
            disable_vfx_spawner_exclusion = true,
        },
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
        [_item_ranged.."/flashlights/invisible_flashlight"] = {
            attachments = {
                flashlight = {
                    item = _item_ranged.."/flashlights/flashlight_01",
                    fix = {
                        offset = {
                            node = 1,
                            position = vector3_box(.075, 0, 0),
                            rotation = vector3_box(0, 0, 0),
                            scale = vector3_box(.001, .001, .001),
                        },
                    },
                    children = {},
                },
            },
            display_name = "loc_invisible_flashlight",
            description = "loc_description_invisible_flashlight",
            attach_node = "ap_flashlight_01",
            dev_name = "invisible_flashlight",
            disable_vfx_spawner_exclusion = true,
        },
        [_item_ranged.."/flashlights/invisible_flashlight_ogryn"] = {
            attachments = {
                flashlight = {
                    item = _item_ranged.."/flashlights/flashlight_ogryn_01",
                    fix = {
                        offset = {
                            node = 1,
                            position = vector3_box(.075, 0, 0),
                            rotation = vector3_box(0, 0, 0),
                            scale = vector3_box(.001, .001, .001),
                        },
                    },
                    children = {},
                },
            },
            display_name = "loc_invisible_flashlight_ogryn",
            description = "loc_description_invisible_flashlight_ogryn",
            attach_node = "ap_flashlight_01",
            dev_name = "invisible_flashlight_ogryn",
            disable_vfx_spawner_exclusion = true,
        },
        [_item_ranged.."/laser_pointers/laser_pointer_01"] = {
            is_fallback_item = false,
            show_in_1p = true,
            base_unit = "content/weapons/player/attachments/flashlights/flashlight_01/flashlight_01",
            item_list_faction = "Player",
            tags = {
            },
            only_show_in_1p = false,
            feature_flags = {
                "FEATURE_item_retained",
            },
            attach_node = "ap_flashlight_01",
            resource_dependencies = {
                ["content/weapons/player/attachments/flashlights/flashlight_01/flashlight_01"] = true,
            },
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                },
            },
            workflow_checklist = {
            },
            display_name = "n/a",
            name = _item_ranged.."/laser_pointers/laser_pointer_01",
            workflow_state = "RELEASABLE",
            is_full_item = true,
        },
        [_item_ranged.."/laser_pointers/laser_pointer_02"] = {
            is_fallback_item = false,
            show_in_1p = true,
            base_unit = "content/weapons/player/attachments/flashlights/flashlight_02/flashlight_02",
            item_list_faction = "Player",
            tags = {
            },
            only_show_in_1p = false,
            feature_flags = {
                "FEATURE_item_retained",
            },
            attach_node = "ap_flashlight_01",
            resource_dependencies = {
                ["content/weapons/player/attachments/flashlights/flashlight_02/flashlight_02"] = true,
            },
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                },
            },
            workflow_checklist = {
            },
            display_name = "n/a",
            name = _item_ranged.."/laser_pointers/laser_pointer_02",
            workflow_state = "RELEASABLE",
            is_full_item = true,
        },
        [_item_ranged.."/laser_pointers/laser_pointer_03"] = {
            is_fallback_item = false,
            show_in_1p = true,
            base_unit = "content/weapons/player/attachments/flashlights/flashlight_03/flashlight_03",
            item_list_faction = "Player",
            tags = {
            },
            only_show_in_1p = false,
            feature_flags = {
                "FEATURE_item_retained",
            },
            attach_node = "ap_flashlight_01",
            resource_dependencies = {
                ["content/weapons/player/attachments/flashlights/flashlight_03/flashlight_03"] = true,
            },
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                },
            },
            workflow_checklist = {
            },
            display_name = "n/a",
            name = _item_ranged.."/laser_pointers/laser_pointer_03",
            workflow_state = "RELEASABLE",
            is_full_item = true,
        },
        [_item_ranged.."/laser_pointers/laser_pointer_05"] = {
            is_fallback_item = false,
            show_in_1p = true,
            base_unit = "content/weapons/player/attachments/flashlights/flashlight_05/flashlight_05",
            item_list_faction = "Player",
            tags = {
            },
            only_show_in_1p = false,
            feature_flags = {
                "FEATURE_item_retained",
            },
            attach_node = "ap_flashlight_01",
            resource_dependencies = {
                ["content/weapons/player/attachments/flashlights/flashlight_05/flashlight_05"] = true,
            },
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                },
            },
            workflow_checklist = {
            },
            display_name = "n/a",
            name = _item_ranged.."/laser_pointers/laser_pointer_05",
            workflow_state = "RELEASABLE",
            is_full_item = true,
        },
        [_item_ranged.."/laser_pointers/laser_pointer_green_01"] = {
            is_fallback_item = false,
            show_in_1p = true,
            base_unit = "content/weapons/player/attachments/flashlights/flashlight_01/flashlight_01",
            item_list_faction = "Player",
            tags = {
            },
            only_show_in_1p = false,
            feature_flags = {
                "FEATURE_item_retained",
            },
            attach_node = "ap_flashlight_01",
            resource_dependencies = {
                ["content/weapons/player/attachments/flashlights/flashlight_01/flashlight_01"] = true,
            },
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                },
            },
            workflow_checklist = {
            },
            display_name = "n/a",
            name = _item_ranged.."/laser_pointers/laser_pointer_green_01",
            workflow_state = "RELEASABLE",
            is_full_item = true,
        },
        [_item_ranged.."/laser_pointers/laser_pointer_green_02"] = {
            is_fallback_item = false,
            show_in_1p = true,
            base_unit = "content/weapons/player/attachments/flashlights/flashlight_02/flashlight_02",
            item_list_faction = "Player",
            tags = {
            },
            only_show_in_1p = false,
            feature_flags = {
                "FEATURE_item_retained",
            },
            attach_node = "ap_flashlight_01",
            resource_dependencies = {
                ["content/weapons/player/attachments/flashlights/flashlight_02/flashlight_02"] = true,
            },
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                },
            },
            workflow_checklist = {
            },
            display_name = "n/a",
            name = _item_ranged.."/laser_pointers/laser_pointer_green_02",
            workflow_state = "RELEASABLE",
            is_full_item = true,
        },
        [_item_ranged.."/laser_pointers/laser_pointer_green_03"] = {
            is_fallback_item = false,
            show_in_1p = true,
            base_unit = "content/weapons/player/attachments/flashlights/flashlight_03/flashlight_03",
            item_list_faction = "Player",
            tags = {
            },
            only_show_in_1p = false,
            feature_flags = {
                "FEATURE_item_retained",
            },
            attach_node = "ap_flashlight_01",
            resource_dependencies = {
                ["content/weapons/player/attachments/flashlights/flashlight_03/flashlight_03"] = true,
            },
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                },
            },
            workflow_checklist = {
            },
            display_name = "n/a",
            name = _item_ranged.."/laser_pointers/laser_pointer_green_03",
            workflow_state = "RELEASABLE",
            is_full_item = true,
        },
        [_item_ranged.."/laser_pointers/laser_pointer_green_05"] = {
            is_fallback_item = false,
            show_in_1p = true,
            base_unit = "content/weapons/player/attachments/flashlights/flashlight_05/flashlight_05",
            item_list_faction = "Player",
            tags = {
            },
            only_show_in_1p = false,
            feature_flags = {
                "FEATURE_item_retained",
            },
            attach_node = "ap_flashlight_01",
            resource_dependencies = {
                ["content/weapons/player/attachments/flashlights/flashlight_05/flashlight_05"] = true,
            },
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                },
            },
            workflow_checklist = {
            },
            display_name = "n/a",
            name = _item_ranged.."/laser_pointers/laser_pointer_green_05",
            workflow_state = "RELEASABLE",
            is_full_item = true,
        },
        [_item_ranged.."/laser_pointers/laser_pointer_ogryn_01"] = {
            is_fallback_item = false,
            show_in_1p = true,
            base_unit = "content/weapons/player/attachments/flashlights/flashlight_ogryn_01/flashlight_ogryn_01",
            item_list_faction = "Player",
            tags = {
            },
            only_show_in_1p = false,
            feature_flags = {
                "FEATURE_item_retained",
            },
            attach_node = "ap_flashlight_01",
            resource_dependencies = {
                ["content/weapons/player/attachments/flashlights/flashlight_ogryn_01/flashlight_ogryn_01"] = true,
            },
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                },
            },
            workflow_checklist = {
            },
            display_name = "n/a",
            name = _item_ranged.."/laser_pointers/laser_pointer_ogryn_01",
            workflow_state = "RELEASABLE",
            is_full_item = true,
        },
        [_item_ranged.."/laser_pointers/laser_pointer_ogryn_long_01"] = {
            is_fallback_item = false,
            show_in_1p = true,
            base_unit = "content/weapons/player/attachments/flashlights/flashlight_ogryn_01/flashlight_ogryn_long_01",
            item_list_faction = "Player",
            tags = {
            },
            only_show_in_1p = false,
            feature_flags = {
                "FEATURE_item_retained",
            },
            attach_node = "ap_flashlight_01",
            resource_dependencies = {
                ["content/weapons/player/attachments/flashlights/flashlight_ogryn_01/flashlight_ogryn_long_01"] = true,
            },
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                },
            },
            workflow_checklist = {
            },
            display_name = "n/a",
            name = _item_ranged.."/laser_pointers/laser_pointer_ogryn_long_01",
            workflow_state = "RELEASABLE",
            is_full_item = true,
        },
        [_item_ranged.."/laser_pointers/laser_pointer_ogryn_green_01"] = {
            is_fallback_item = false,
            show_in_1p = true,
            base_unit = "content/weapons/player/attachments/flashlights/flashlight_ogryn_01/flashlight_ogryn_01",
            item_list_faction = "Player",
            tags = {
            },
            only_show_in_1p = false,
            feature_flags = {
                "FEATURE_item_retained",
            },
            attach_node = "ap_flashlight_01",
            resource_dependencies = {
                ["content/weapons/player/attachments/flashlights/flashlight_ogryn_01/flashlight_ogryn_01"] = true,
            },
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                },
            },
            workflow_checklist = {
            },
            display_name = "n/a",
            name = _item_ranged.."/laser_pointers/laser_pointer_ogryn_green_01",
            workflow_state = "RELEASABLE",
            is_full_item = true,
        },
        [_item_ranged.."/laser_pointers/laser_pointer_ogryn_long_green_01"] = {
            is_fallback_item = false,
            show_in_1p = true,
            base_unit = "content/weapons/player/attachments/flashlights/flashlight_ogryn_01/flashlight_ogryn_long_01",
            item_list_faction = "Player",
            tags = {
            },
            only_show_in_1p = false,
            feature_flags = {
                "FEATURE_item_retained",
            },
            attach_node = "ap_flashlight_01",
            resource_dependencies = {
                ["content/weapons/player/attachments/flashlights/flashlight_ogryn_01/flashlight_ogryn_long_01"] = true,
            },
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                },
            },
            workflow_checklist = {
            },
            display_name = "n/a",
            name = _item_ranged.."/laser_pointers/laser_pointer_ogryn_long_green_01",
            workflow_state = "RELEASABLE",
            is_full_item = true,
        },
        [_item_melee.."/tanks/laser_blade_tank_01"] = {
            is_fallback_item = false,
            show_in_1p = true,
            base_unit = "content/weapons/player/ranged/flamer_rifle/attachments/magazine_01/magazine_01",
            item_list_faction = "Player",
            tags = {
            },
            only_show_in_1p = false,
            feature_flags = {
                "FEATURE_item_retained",
            },
            attach_node = "ap_blade_01",
            resource_dependencies = {
                ["content/weapons/player/ranged/flamer_rifle/attachments/magazine_01/magazine_01"] = true,
            },
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                },
            },
            workflow_checklist = {
            },
            display_name = "n/a",
            name = _item_melee.."/tanks/laser_blade_tank_01",
            workflow_state = "RELEASABLE",
            is_full_item = true,
        },
        [_item_melee.."/tanks/laser_blade_tank_02"] = {
            is_fallback_item = false,
            show_in_1p = true,
            base_unit = "content/weapons/player/ranged/flamer_rifle/attachments/magazine_02/magazine_02",
            item_list_faction = "Player",
            tags = {
            },
            only_show_in_1p = false,
            feature_flags = {
                "FEATURE_item_retained",
            },
            attach_node = "ap_blade_01",
            resource_dependencies = {
                ["content/weapons/player/ranged/flamer_rifle/attachments/magazine_02/magazine_02"] = true,
            },
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                },
            },
            workflow_checklist = {
            },
            display_name = "n/a",
            name = _item_melee.."/tanks/laser_blade_tank_02",
            workflow_state = "RELEASABLE",
            is_full_item = true,
        },
        [_item_melee.."/blades/laser_blade_01"] = {
            is_fallback_item = false,
            show_in_1p = true,
            base_unit = "content/weapons/player/melee/power_sword/attachments/blade_06/blade_06",
            item_list_faction = "Player",
            tags = {
            },
            only_show_in_1p = false,
            feature_flags = {
                "FEATURE_item_retained",
            },
            attach_node = "ap_blade_01",
            resource_dependencies = {
                ["content/weapons/player/melee/power_sword/attachments/blade_06/blade_06"] = true,
            },
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                },
                tank = {
                    item = _item_melee.."/tanks/laser_blade_tank_01",
                    fix = {
                        offset = {
                            node = 1,
                            position = vector3_box(0, -.02, .08),
                            rotation = vector3_box(90, 180, 180),
                            scale = vector3_box(.65, .65, .65),
                        },
                    },
                    children = {},
                }
            },
            workflow_checklist = {
            },
            display_name = "n/a",
            name = _item_melee.."/blades/laser_blade_01",
            workflow_state = "RELEASABLE",
            is_full_item = true,
        },
        [_item_melee.."/blades/laser_blade_green_01"] = {
            is_fallback_item = false,
            show_in_1p = true,
            base_unit = "content/weapons/player/melee/power_sword/attachments/blade_06/blade_06",
            item_list_faction = "Player",
            tags = {
            },
            only_show_in_1p = false,
            feature_flags = {
                "FEATURE_item_retained",
            },
            attach_node = "ap_blade_01",
            resource_dependencies = {
                ["content/weapons/player/melee/power_sword/attachments/blade_06/blade_06"] = true,
            },
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                },
                tank = {
                    item = _item_melee.."/tanks/laser_blade_tank_02",
                    fix = {
                        offset = {
                            node = 1,
                            position = vector3_box(0, -.02, .08),
                            rotation = vector3_box(90, 180, 180),
                            scale = vector3_box(.65, .65, .65),
                        },
                    },
                    children = {},
                }
            },
            workflow_checklist = {
            },
            display_name = "n/a",
            name = _item_melee.."/blades/laser_blade_green_01",
            workflow_state = "RELEASABLE",
            is_full_item = true,
        },
    },
    flashlight_templates = {
        laser_pointer_01 = {
            light = {
                first_person = {
                    cast_shadows = true,
                    color_temperature = 7300,
                    ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_01",
                    -- intensity = 8,
                    intensity = 2,
                    spot_reflector = false,
                    volumetric_intensity = 0.1,
                    color_filter = vector3_box(1, 0, 0),
                    spot_angle = {
                        max = 1.3,
                        min = 0,
                    },
                    falloff = {
                        far = 70,
                        near = 0,
                    },
                },
                third_person = {
                    cast_shadows = true,
                    color_temperature = 7000,
                    ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_01",
                    intensity = 2,
                    spot_reflector = false,
                    volumetric_intensity = 0.6,
                    color_filter = vector3_box(1, 0, 0),
                    spot_angle = {
                        max = 0.9,
                        min = 0,
                    },
                    falloff = {
                        far = 30,
                        near = 0,
                    },
                },
            },
            flicker = "led_flicker",
        },
        laser_pointer_02 = {
            light = {
                first_person = {
                    cast_shadows = true,
                    color_temperature = 5900,
                    ies_profile = "content/environment/ies_profiles/narrow/narrow_05",
                    -- intensity = 16,
                    intensity = 4,
                    spot_reflector = false,
                    volumetric_intensity = 0.1,
                    color_filter = vector3_box(1, 0, 0),
                    spot_angle = {
                        max = 0.8,
                        min = 0,
                    },
                    falloff = {
                        far = 45,
                        near = 0,
                    },
                },
                third_person = {
                    cast_shadows = true,
                    color_temperature = 5900,
                    ies_profile = "content/environment/ies_profiles/narrow/narrow_05",
                    intensity = 4,
                    spot_reflector = false,
                    volumetric_intensity = 0.6,
                    color_filter = vector3_box(1, 0, 0),
                    spot_angle = {
                        max = 0.6,
                        min = 0,
                    },
                    falloff = {
                        far = 25,
                        near = 0,
                    },
                },
            },
            flicker = "incandescent_flicker",
        },
        laser_pointer_03 = {
            light = {
                first_person = {
                    cast_shadows = true,
                    color_temperature = 7900,
                    ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_01",
                    -- intensity = 10,
                    intensity = 2.5,
                    spot_reflector = false,
                    volumetric_intensity = 0.1,
                    color_filter = vector3_box(1, 0, 0),
                    spot_angle = {
                        max = 1.2,
                        min = 0,
                    },
                    falloff = {
                        far = 70,
                        near = 0,
                    },
                },
                third_person = {
                    cast_shadows = true,
                    color_temperature = 7500,
                    ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_01",
                    intensity = 2.5,
                    spot_reflector = false,
                    volumetric_intensity = 0.6,
                    color_filter = vector3_box(1, 0, 0),
                    spot_angle = {
                        max = 0.8,
                        min = 0,
                    },
                    falloff = {
                        far = 30,
                        near = 0,
                    },
                },
            },
            flicker = "led_flicker",
        },
        laser_pointer_05 = {
            light = {
                first_person = {
                    cast_shadows = true,
                    color_temperature = 6200,
                    ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_03",
                    -- intensity = 18,
                    intensity = 4.5,
                    spot_reflector = false,
                    volumetric_intensity = 0.1,
                    color_filter = vector3_box(1, 0, 0),
                    spot_angle = {
                        max = 1.1,
                        min = 0,
                    },
                    falloff = {
                        far = 45,
                        near = 0,
                    },
                },
                third_person = {
                    cast_shadows = true,
                    color_temperature = 6200,
                    ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_03",
                    intensity = 4.5,
                    spot_reflector = false,
                    volumetric_intensity = 0.6,
                    color_filter = vector3_box(1, 0, 0),
                    spot_angle = {
                        max = 0.8,
                        min = 0,
                    },
                    falloff = {
                        far = 25,
                        near = 0,
                    },
                },
            },
            flicker = "incandescent_flicker",
        },
        laser_pointer_green_01 = {
            light = {
                first_person = {
                    cast_shadows = true,
                    color_temperature = 7300,
                    ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_01",
                    -- intensity = 8,
                    intensity = 2,
                    spot_reflector = false,
                    volumetric_intensity = 0.1,
                    color_filter = vector3_box(0, 1, 0),
                    spot_angle = {
                        max = 1.3,
                        min = 0,
                    },
                    falloff = {
                        far = 70,
                        near = 0,
                    },
                },
                third_person = {
                    cast_shadows = true,
                    color_temperature = 7000,
                    ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_01",
                    intensity = 2,
                    spot_reflector = false,
                    volumetric_intensity = 0.6,
                    color_filter = vector3_box(0, 1, 0),
                    spot_angle = {
                        max = 0.9,
                        min = 0,
                    },
                    falloff = {
                        far = 30,
                        near = 0,
                    },
                },
            },
            flicker = "led_flicker",
        },
        laser_pointer_green_02 = {
            light = {
                first_person = {
                    cast_shadows = true,
                    color_temperature = 5900,
                    ies_profile = "content/environment/ies_profiles/narrow/narrow_05",
                    -- intensity = 16,
                    intensity = 4,
                    spot_reflector = false,
                    volumetric_intensity = 0.1,
                    color_filter = vector3_box(0, 1, 0),
                    spot_angle = {
                        max = 0.8,
                        min = 0,
                    },
                    falloff = {
                        far = 45,
                        near = 0,
                    },
                },
                third_person = {
                    cast_shadows = true,
                    color_temperature = 5900,
                    ies_profile = "content/environment/ies_profiles/narrow/narrow_05",
                    intensity = 4,
                    spot_reflector = false,
                    volumetric_intensity = 0.6,
                    color_filter = vector3_box(0, 1, 0),
                    spot_angle = {
                        max = 0.6,
                        min = 0,
                    },
                    falloff = {
                        far = 25,
                        near = 0,
                    },
                },
            },
            flicker = "incandescent_flicker",
        },
        laser_pointer_green_03 = {
            light = {
                first_person = {
                    cast_shadows = true,
                    color_temperature = 7900,
                    ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_01",
                    -- intensity = 10,
                    intensity = 2.5,
                    spot_reflector = false,
                    volumetric_intensity = 0.1,
                    color_filter = vector3_box(0, 1, 0),
                    spot_angle = {
                        max = 1.2,
                        min = 0,
                    },
                    falloff = {
                        far = 70,
                        near = 0,
                    },
                },
                third_person = {
                    cast_shadows = true,
                    color_temperature = 7500,
                    ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_01",
                    intensity = 2.5,
                    spot_reflector = false,
                    volumetric_intensity = 0.6,
                    color_filter = vector3_box(0, 1, 0),
                    spot_angle = {
                        max = 0.8,
                        min = 0,
                    },
                    falloff = {
                        far = 30,
                        near = 0,
                    },
                },
            },
            flicker = "led_flicker",
        },
        laser_pointer_green_05 = {
            light = {
                first_person = {
                    cast_shadows = true,
                    color_temperature = 6200,
                    ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_03",
                    -- intensity = 18,
                    intensity = 4.5,
                    spot_reflector = false,
                    volumetric_intensity = 0.1,
                    color_filter = vector3_box(0, 1, 0),
                    spot_angle = {
                        max = 1.1,
                        min = 0,
                    },
                    falloff = {
                        far = 45,
                        near = 0,
                    },
                },
                third_person = {
                    cast_shadows = true,
                    color_temperature = 6200,
                    ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_03",
                    intensity = 4.5,
                    spot_reflector = false,
                    volumetric_intensity = 0.6,
                    color_filter = vector3_box(0, 1, 0),
                    spot_angle = {
                        max = 0.8,
                        min = 0,
                    },
                    falloff = {
                        far = 25,
                        near = 0,
                    },
                },
            },
            flicker = "incandescent_flicker",
        },
        laser_pointer_ogryn_01 = {
            light = {
                first_person = {
                    cast_shadows = true,
                    color_temperature = 4400,
                    ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_02",
                    intensity = 2.5,
                    spot_reflector = false,
                    volumetric_intensity = 0.1,
                    color_filter = vector3_box(1, 0, 0),
                    spot_angle = {
                        max = 1.2,
                        min = 0,
                    },
                    falloff = {
                        far = 35,
                        near = 0,
                    },
                },
                third_person = {
                    cast_shadows = true,
                    color_temperature = 4400,
                    ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_02",
                    intensity = 2.5,
                    spot_reflector = false,
                    volumetric_intensity = 0.6,
                    color_filter = vector3_box(1, 0, 0),
                    spot_angle = {
                        max = 0.9,
                        min = 0,
                    },
                    falloff = {
                        far = 20,
                        near = 0,
                    },
                },
            },
            flicker = "worn_incandescent_flicker",
        },
        laser_pointer_ogryn_long_01 = {
            light = {
                first_person = {
                    cast_shadows = true,
                    color_temperature = 4400,
                    ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_02",
                    intensity = 2.5,
                    spot_reflector = false,
                    volumetric_intensity = 0.1,
                    color_filter = vector3_box(1, 0, 0),
                    spot_angle = {
                        max = 1.2,
                        min = 0,
                    },
                    falloff = {
                        far = 35,
                        near = 0,
                    },
                },
                third_person = {
                    cast_shadows = true,
                    color_temperature = 4400,
                    ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_02",
                    intensity = 2.5,
                    spot_reflector = false,
                    volumetric_intensity = 0.6,
                    color_filter = vector3_box(1, 0, 0),
                    spot_angle = {
                        max = 0.9,
                        min = 0,
                    },
                    falloff = {
                        far = 20,
                        near = 0,
                    },
                },
            },
            flicker = "worn_incandescent_flicker",
        },
        laser_pointer_ogryn_green_01 = {
            light = {
                first_person = {
                    cast_shadows = true,
                    color_temperature = 4400,
                    ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_02",
                    intensity = 2.5,
                    spot_reflector = false,
                    volumetric_intensity = 0.1,
                    color_filter = vector3_box(0, 1, 0),
                    spot_angle = {
                        max = 1.2,
                        min = 0,
                    },
                    falloff = {
                        far = 35,
                        near = 0,
                    },
                },
                third_person = {
                    cast_shadows = true,
                    color_temperature = 4400,
                    ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_02",
                    intensity = 2.5,
                    spot_reflector = false,
                    volumetric_intensity = 0.6,
                    color_filter = vector3_box(0, 1, 0),
                    spot_angle = {
                        max = 0.9,
                        min = 0,
                    },
                    falloff = {
                        far = 20,
                        near = 0,
                    },
                },
            },
            flicker = "worn_incandescent_flicker",
        },
        laser_pointer_ogryn_long_green_01 = {
            light = {
                first_person = {
                    cast_shadows = true,
                    color_temperature = 4400,
                    ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_02",
                    intensity = 2.5,
                    spot_reflector = false,
                    volumetric_intensity = 0.1,
                    color_filter = vector3_box(0, 1, 0),
                    spot_angle = {
                        max = 1.2,
                        min = 0,
                    },
                    falloff = {
                        far = 35,
                        near = 0,
                    },
                },
                third_person = {
                    cast_shadows = true,
                    color_temperature = 4400,
                    ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_02",
                    intensity = 2.5,
                    spot_reflector = false,
                    volumetric_intensity = 0.6,
                    color_filter = vector3_box(0, 1, 0),
                    spot_angle = {
                        max = 0.9,
                        min = 0,
                    },
                    falloff = {
                        far = 20,
                        near = 0,
                    },
                },
            },
            flicker = "worn_incandescent_flicker",
        },
    },
    packages_to_load = {
        ["content/fx/particles/enemies/red_glowing_eyes"] = true,
        ["content/fx/particles/enemies/sniper_laser_sight"] = true,
        ["content/fx/particles/enemies/renegade_sniper/renegade_sniper_beam_outdoors"] = true,
        ["content/fx/particles/weapons/rifles/plasma_gun/plasma_gun_charge"] = true,
        ["content/fx/particles/enemies/buff_taunted_1p"] = true,
        ["content/fx/particles/enemies/plasma_gun_laser_sight"] = true,
        ["content/fx/particles/enemies/renegade_flamer/renegade_flamer_fuse_loop"] = true,
        ["content/fx/particles/weapons/rifles/player_flamer/flamer_code_control"] = true,
        ["wwise/events/weapon/play_flametrower_alt_fire_on"] = true,
        ["wwise/events/weapon/play_flametrower_alt_fire_off"] = true,
        ["wwise/events/weapon/play_aoe_liquid_fire_green_loop"] = true,
        ["wwise/events/weapon/stop_aoe_liquid_fire_green_loop"] = true,
        ["wwise/events/weapon/play_flamethrower_interrupt"] = true,
        ["content/fx/particles/weapons/grenades/flame_grenade_hostile_fire_lingering_green"] = true,
        ["wwise/events/minions/play_traitor_captain_shield_bullet_hits"] = true,
        ["wwise/events/weapon/play_shockmaul_1h_p2_swing"] = true,
        ["content/fx/particles/weapons/rifles/plasma_gun/plasma_vent_valve"] = true,
    },
}

local weapons_folder = "extended_weapon_customization_base_additions/scripts/mods/ewc_ba/weapons/"
local load_weapons = {
    "ogryn_heavystubber_p1_m1",
    "ogryn_heavystubber_p2_m1",
    "powersword_p1_m1",
    "boltpistol_p1_m1",
    "autopistol_p1_m1",
    "laspistol_p1_m1",
    "autogun_p1_m1",
    "autogun_p2_m1",
    "autogun_p3_m1",
    "shotgun_p4_m1",
    "bolter_p1_m1",
    "flamer_p1_m1",
    "lasgun_p1_m1",
    "lasgun_p2_m1",
    "lasgun_p3_m1",
}

for _, file_name in pairs(load_weapons) do
    local data = mod:io_dofile(weapons_folder..file_name)

    if data then

        if data.attachments then
            extended_weapon_customization_plugin.attachments = table_merge_recursive(extended_weapon_customization_plugin.attachments, data.attachments)
        end

        if data.attachment_slots then
            extended_weapon_customization_plugin.attachment_slots = table_merge_recursive(extended_weapon_customization_plugin.attachment_slots, data.attachment_slots)
        end

        if data.fixes then
            extended_weapon_customization_plugin.fixes = table_merge_recursive(extended_weapon_customization_plugin.fixes, data.fixes)
        end

        if data.kitbashs then
            extended_weapon_customization_plugin.kitbashs = table_merge_recursive(extended_weapon_customization_plugin.kitbashs, data.kitbashs)
        end

    end

end

mod.extended_weapon_customization_plugin = extended_weapon_customization_plugin
