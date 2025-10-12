local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local CLASS = CLASS
    local pairs = pairs
    local table = table
    local managers = Managers
    local vector3_box = Vector3Box
    local table_clone = table.clone
    local table_merge_recursive = table.merge_recursive
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "extended_weapon_customization_base_additions"

mod:persistent_table(REFERENCE, {})

mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/extensions/common")

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.pt = function(self)
    return self:persistent_table(REFERENCE)
end

local pt = mod:pt()

mod.get_view = function(self, view_name)
    local ui_manager = managers.ui
    return ui_manager:view_active(view_name) and ui_manager:view_instance(view_name) or nil
end

mod.modify_customization_groups = function(self, attachments, group_name)
    for attachment_name, attachment_data in pairs(attachments) do
        attachment_data.custom_selection_group = group_name
    end
end

mod.merge_attachment_data = function(self, merge_attachment_data, ...)
    local attachment_collections = {...}
    for _, attachment_collection in pairs(attachment_collections) do
        for attachment_name, attachment_data in pairs(attachment_collection) do
            attachment_data = table_merge_recursive(attachment_data, merge_attachment_data)
        end
    end
end

mod.is_cutscene_active = function (self)
	local extension_manager = managers.state.extension
	local cinematic_scene_system = extension_manager:system("cinematic_scene_system")
	local cinematic_scene_system_active = cinematic_scene_system:is_active()
	local cinematic_manager = managers.state.cinematic
	local cinematic_manager_active = cinematic_manager:cinematic_active()
	return cinematic_scene_system_active or cinematic_manager_active
end

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_melee = _item.."/melee"
local _empty_item = "content/items/weapons/player/trinkets/unused_trinket"

local extended_weapon_customization_plugin = {
    attachments = {},
    attachment_slots = {},
    fixes = {},
    kitbashs = {
        -- ##### Scopes ###############################################################################################
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
        [_item_ranged.."/scope_bodies/scope_body_02"] = {
            is_fallback_item = false,
            show_in_1p = true,
            base_unit = "content/weapons/player/ranged/lasgun_rifle_krieg/attachments/muzzle_04/muzzle_04",
            item_list_faction = "Player",
            tags = {
            },
            only_show_in_1p = false,
            feature_flags = {
                "ROTATION_ursula"
            },
            attach_node = "ap_bullet_01",
            resource_dependencies = {
                ["content/weapons/player/ranged/lasgun_rifle_krieg/attachments/muzzle_04/muzzle_04"] = true,
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
            name = _item_ranged.."/scope_bodies/scope_body_02",
            workflow_state = "RELEASABLE",
            is_full_item = true,
        },
        [_item_ranged.."/sights/scope_01"] = {
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
            attach_node = "ap_sight_01",
            resource_dependencies = {
                ["content/characters/empty_item/empty_item"] = true,
                ["content/weapons/player/attachments/sights/sight_reflex_03/sight_reflex_03"] = true,
                ["content/weapons/player/ranged/lasgun_rifle_krieg/attachments/muzzle_02/muzzle_02"] = true,
                ["content/weapons/player/ranged/rippergun_rifle/ammunition/ammunition_01/ammunition_01"] = true,
            },
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                },
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
            workflow_checklist = {
            },
            display_name = "loc_scope_01",
            name = _item_ranged.."/sights/scope_01",
            workflow_state = "RELEASABLE",
            is_full_item = true,
            disable_vfx_spawner_exclusion = true,
        },
        -- ##### Invisible sights #####################################################################################
        [_item_ranged.."/sights/shotgun_rifle_sight_invisible_01"] = {
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
            attach_node = "ap_sight_01",
            resource_dependencies = {
                ["content/characters/empty_item/empty_item"] = true,
            },
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                },
            },
            workflow_checklist = {
            },
            display_name = "loc_shotgun_rifle_sight_invisible_01",
            name = _item_ranged.."/sights/shotgun_rifle_sight_invisible_01",
            workflow_state = "RELEASABLE",
            is_full_item = true,
            disable_vfx_spawner_exclusion = true,
        },
        [_item_ranged.."/sights/shotgun_double_barrel_sight_invisible_01"] = {
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
            attach_node = "ap_sight_01",
            resource_dependencies = {
                ["content/characters/empty_item/empty_item"] = true,
            },
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                },
            },
            workflow_checklist = {
            },
            display_name = "loc_shotgun_double_barrel_sight_invisible_01",
            name = _item_ranged.."/sights/shotgun_double_barrel_sight_invisible_01",
            workflow_state = "RELEASABLE",
            is_full_item = true,
            disable_vfx_spawner_exclusion = true,
        },
        -- ##### Fake Sights ##########################################################################################
        [_item_ranged.."/sights/reflex_sight_show_01"] = {
            is_fallback_item = false,
            show_in_1p = true,
            base_unit = "content/weapons/player/attachments/sights/sight_reflex_01/sight_reflex_01",
            item_list_faction = "Player",
            tags = {
            },
            only_show_in_1p = false,
            feature_flags = {
                "FEATURE_item_retained"
            },
            attach_node = "ap_sight_01",
            resource_dependencies = {
                ["content/weapons/player/attachments/sights/sight_reflex_01/sight_reflex_01"] = true,
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
            name = _item_ranged.."/sights/reflex_sight_show_01",
            workflow_state = "RELEASABLE",
            is_full_item = true,
        },
        [_item_ranged.."/sights/reflex_sight_show_02"] = {
            is_fallback_item = false,
            show_in_1p = true,
            base_unit = "content/weapons/player/attachments/sights/sight_reflex_02/sight_reflex_02",
            item_list_faction = "Player",
            tags = {
            },
            only_show_in_1p = false,
            feature_flags = {
                "FEATURE_item_retained"
            },
            attach_node = "ap_sight_01",
            resource_dependencies = {
                ["content/weapons/player/attachments/sights/sight_reflex_02/sight_reflex_02"] = true,
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
            name = _item_ranged.."/sights/reflex_sight_show_02",
            workflow_state = "RELEASABLE",
            is_full_item = true,
        },
        [_item_ranged.."/sights/reflex_sight_show_03"] = {
            is_fallback_item = false,
            show_in_1p = true,
            base_unit = "content/weapons/player/attachments/sights/sight_reflex_03/sight_reflex_03",
            item_list_faction = "Player",
            tags = {
            },
            only_show_in_1p = false,
            feature_flags = {
                "FEATURE_item_retained"
            },
            attach_node = "ap_sight_01",
            resource_dependencies = {
                ["content/weapons/player/attachments/sights/sight_reflex_03/sight_reflex_03"] = true,
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
            name = _item_ranged.."/sights/reflex_sight_show_03",
            workflow_state = "RELEASABLE",
            is_full_item = true,
        },
        [_item_ranged.."/sights/scope_show_01"] = {
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                },
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
            display_name = "loc_scope_show_01",
            description = "loc_description_scope_show_01",
            dev_name = "loc_scope_show_01",
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
                ["content/weapons/player/attachments/sights/sight_reflex_03/sight_reflex_03"] = true,
                ["content/weapons/player/ranged/lasgun_rifle_krieg/attachments/muzzle_02/muzzle_02"] = true,
                ["content/weapons/player/ranged/rippergun_rifle/ammunition/ammunition_01/ammunition_01"] = true,
            },
            workflow_checklist = {
            },
            name = _item_ranged.."/sights/scope_show_01",
            workflow_state = "RELEASABLE",
            is_full_item = true,
            disable_vfx_spawner_exclusion = true,
        },
        -- ##### Invisible Flashlights ################################################################################
        [_item_ranged.."/flashlights/invisible_flashlight"] = {
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                },
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
            resource_dependencies = {
                ["content/weapons/player/attachments/flashlights/flashlight_01/flashlight_01"] = true,
            },
            workflow_checklist = {
            },
            name = _item_ranged.."/flashlights/invisible_flashlight",
            workflow_state = "RELEASABLE",
            is_full_item = true,
            disable_vfx_spawner_exclusion = true,
        },
        [_item_ranged.."/flashlights/invisible_flashlight_ogryn"] = {
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                },
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
            resource_dependencies = {
                ["content/weapons/player/attachments/flashlights/flashlight_ogryn_01/flashlight_ogryn_01"] = true,
            },
            workflow_checklist = {
            },
            name = _item_ranged.."/flashlights/invisible_flashlight_ogryn",
            workflow_state = "RELEASABLE",
            is_full_item = true,
            disable_vfx_spawner_exclusion = true,
        },
        -- ##### Red Laser Pointers ###################################################################################
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
        -- ##### Green Laser Pointers #################################################################################
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
        -- ##### Red Ogryn Laser Pointers #############################################################################
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
        -- ##### Green Ogryn Laser Pointers ###########################################################################
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
        -- ##### Laser Blade Tanks ####################################################################################
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
            base_unit = "content/weapons/player/ranged/flamer_rifle/attachments/magazine_03/magazine_03",
            item_list_faction = "Player",
            tags = {
            },
            only_show_in_1p = false,
            feature_flags = {
                "FEATURE_item_retained",
            },
            attach_node = "ap_blade_01",
            resource_dependencies = {
                ["content/weapons/player/ranged/flamer_rifle/attachments/magazine_03/magazine_03"] = true,
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
    },
    flashlight_templates = {
        -- ##### Red Laser Pointers ###################################################################################
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
        -- ##### Green Laser Pointers #################################################################################
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
        -- ##### Red Ogryn Laser Pointers #############################################################################
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
        -- ##### Green Ogryn Laser Pointers ###########################################################################
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
        ["content/fx/particles/weapons/grenades/flame_grenade_hostile_fire_lingering_green"] = true,
        ["content/fx/particles/weapons/grenades/flame_grenade_hostile_fire_lingering"] = true,
        ["content/fx/particles/enemies/renegade_sniper/renegade_sniper_beam_outdoors"] = true,
        ["content/fx/particles/weapons/rifles/plasma_gun/plasma_vent_valve"] = true,
        ["content/fx/particles/weapons/rifles/plasma_gun/plasma_gun_charge"] = true,
        ["content/fx/particles/enemies/plasma_gun_laser_sight"] = true,
        ["content/fx/particles/enemies/sniper_laser_sight"] = true,
        ["content/fx/particles/enemies/red_glowing_eyes"] = true,
        ["wwise/events/minions/play_traitor_captain_shield_bullet_hits"] = true,
        ["wwise/events/weapon/play_aoe_liquid_fire_green_loop"] = true,
        ["wwise/events/weapon/stop_aoe_liquid_fire_green_loop"] = true,
        ["wwise/events/weapon/play_flametrower_alt_fire_off"] = true,
        ["wwise/events/weapon/play_flametrower_alt_fire_on"] = true,
        ["wwise/events/weapon/play_flamethrower_interrupt"] = true,
        ["wwise/events/weapon/play_shockmaul_1h_p2_swing"] = true,
    },
}

local weapons_folder = "extended_weapon_customization_base_additions/scripts/mods/ewc_ba/weapons/"
local load_weapons = {
    "ogryn_heavystubber_p1_m1",
    "ogryn_heavystubber_p2_m1",
    "ogryn_rippergun_p1_m1",
    "ogryn_gauntlet_p1_m1",
    "ogryn_thumper_p1_m1",
    "forcesword_2h_p1_m1",
    "powersword_2h_p1_m1",
    "stubrevolver_p1_m1",
    "combatsword_p1_m1",
    "combatsword_p2_m1",
    "combatsword_p3_m1",
    "combatknife_p1_m1",
    "powersword_p1_m1",
    "powersword_p2_m1",
    "boltpistol_p1_m1",
    "autopistol_p1_m1",
    "laspistol_p1_m1",
    "plasmagun_p1_m1",
    "autogun_p1_m1",
    "autogun_p2_m1",
    "autogun_p3_m1",
    "shotgun_p1_m1",
    "shotgun_p2_m1",
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
