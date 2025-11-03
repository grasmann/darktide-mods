local mod = get_mod("ewc_example_plugin_2")

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

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_melee = _item.."/melee"
local _empty_item = "content/items/weapons/player/trinkets/unused_trinket"

local braced_receivers = "autogun_rifle_ak_receiver_01|autogun_rifle_ak_receiver_02|autogun_rifle_ak_receiver_03|autogun_rifle_ak_receiver_ml01"
local infantry_receivers = "autogun_rifle_receiver_01|autogun_rifle_receiver_ml01"
local headhunter_receivers = "autogun_rifle_killshot_receiver_01|autogun_rifle_killshot_receiver_02|autogun_rifle_killshot_receiver_03|autogun_rifle_killshot_receiver_04|autogun_rifle_killshot_receiver_ml01"

-- Plugin definition
-- The extended weapon customization main mod will search for this table
mod.extended_weapon_customization_plugin = {
    -- Attachment table
    attachments = {
        -- Weapon
        autogun_p2_m1 = {
            -- Slot name
            sight = {
                -- Attachment definition
                example_scope_01 = {
                    -- This is the name of the attachment in the master items list
                    replacement_path = _item_ranged.."/sights/example_scope_01",
                    -- This is the offset used in the icon for the attachment selection
                    icon_render_unit_rotation_offset = {90, 0, -85},
                    icon_render_camera_position_offset = {0, -.8, .2},
                    -- This is an option that must return true for the attachment to be used in randomized weapons
                    randomization_requirement = "mod_option_scope_randomization",
                    -- This overwrites aim animations
                    -- More info can be found in mod file
                    -- scripts\mods\ewc\patches\alternate_fire.lua
                    alternate_fire = "ironsight",
                    -- This overwrites the crosshair
                    -- More info on crosshairs can be found in game file
                    -- scripts/ui/hud/elements/crosshair/hud_element_crosshair_settings
                    crosshair_type = "dot",
                },
            },
        },
    },
    fixes = {
        -- Weapon
        autogun_p2_m1 = {
            {attachment_slot = "sight",
                requirements = {
                    sight = {
                        has = "example_scope_01",
                    },
                    receiver = {
                        has = braced_receivers,
                    },
                },
                fix = {
                    offset = {
                        position = vector3_box(0, -.025, .03),
                        rotation = vector3_box(0, 0, 0),
                    },
                },
            },
            {attachment_slot = "sight",
                requirements = {
                    sight = {
                        has = "example_scope_01",
                    },
                    receiver = {
                        has = headhunter_receivers.."|"..infantry_receivers,
                    },
                },
                fix = {
                    offset = {
                        position = vector3_box(0, -.05, .03),
                        rotation = vector3_box(0, 0, 0),
                    },
                },
            },
            {attachment_slot = "sight_offset",
                requirements = {
                    sight = {
                        has = "example_scope_01",
                    },
                    receiver = {
                        has = braced_receivers,
                    },
                },
                fix = {
                    offset = {
                        position = vector3_box(0, -.05, -.04),
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
                        has = "example_scope_01",
                    },
                    receiver = {
                        has = headhunter_receivers.."|"..infantry_receivers,
                    },
                },
                fix = {
                    offset = {
                        position = vector3_box(0, -.05, -.043),
                        rotation = vector3_box(0, 0, 0),
                        custom_fov = 32.5,
                        aim_scale = .5,
                        fov = 25,
                    },
                },
            },
            --#region Use these fixes to test fixes before adding them to the kitbash itself
                -- Disable fixes in the kitbash to test.
                -- {attachment_slot = "lense_1",
                --     fix = {
                --         offset = {
                --             node = 1,
                --             position = vector3_box(0, .045, .002),
                --             rotation = vector3_box(0, 0, 0),
                --             scale = vector3_box(.9, .3, .9),
                --         },
                --     },
                -- },
                -- {attachment_slot = "lense_2",
                --     fix = {
                --         offset = {
                --             node = 1,
                --             position = vector3_box(0, .085, .002),
                --             rotation = vector3_box(180, 0, 0),
                --             scale = vector3_box(.9, .4, .9),
                --         },
                --     },
                -- },
                -- {attachment_slot = "scope",
                --     fix = {
                --         offset = {
                --             node = 1,
                --             position = vector3_box(0, -.04, .0275),
                --             rotation = vector3_box(0, 0, 0),
                --             scale = vector3_box(1.5, 1.5, 1.5),
                --         },
                --     },
                -- },
            --#endregion
        },
    },
    kitbashs = {
        -- A kitbash is an item entry how it would be in the master items list.
        -- The master items list contains all weapons, attachments, trinkets, armors, etc.
        -- It's a good idea to search for the kind of attachment you want to kitbash.
        -- and basically copy paste the values you find into the kitbash.
        [_item_ranged.."/lenses/exmaple_lense_01"] = {
            -- Fallback item - not tested might be interesting for custom slots
            is_fallback_item = false,
            -- Show in first person / only in first person
            show_in_1p = true,
            only_show_in_1p = false,
            -- Base unit that is loaded for the attachment
            -- Here it is the empty item, so it's kind of a dummy and only the attachments show.
            base_unit = "content/weapons/player/ranged/rippergun_rifle/ammunition/ammunition_01/ammunition_01",
            -- Item list faction - Who can use the item?
            item_list_faction = "Player",
            -- Unknown
            tags = {},
            workflow_checklist = {},
            workflow_state = "RELEASABLE",
            feature_flags = {"ROTATION_ursula"},
            -- Attach node in the unit - can be removed, in which case it will probably use node 1 of the parent slot unit
            attach_node = "ap_bullet_01",
            -- Resource packages to load - I recommend adding all resources needed by the different attachments
            resource_dependencies = {
                ["content/weapons/player/ranged/rippergun_rifle/ammunition/ammunition_01/ammunition_01"] = true,
            },
            -- Attachments - This describes the structure of the item
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                    material_overrides = {},
                },
            },
            -- Display name - Attachment names can be localized
            -- The localizations must be global - see the localization file.
            display_name = "n/a",
            -- Name - This needs to be set - should be the same as the key in master item table
            name = _item_ranged.."/lenses/exmaple_lense_01",
            -- This tells the main mod it is a complete item.
            is_full_item = true,
        },
        [_item_ranged.."/scope_bodies/example_scope_body_01"] = {
            -- Fallback item - not tested might be interesting for custom slots
            is_fallback_item = false,
            -- Show in first person / only in first person
            only_show_in_1p = false,
            show_in_1p = true,
            -- Base unit that is loaded for the attachment
            -- Here it is the empty item, so it's kind of a dummy and only the attachments show.
            base_unit = "content/weapons/player/ranged/lasgun_rifle_krieg/attachments/muzzle_05/muzzle_05",
            -- Item list faction - Who can use the item?
            item_list_faction = "Player",
            -- Unknown
            tags = {},
            feature_flags = {"ROTATION_ursula"},
            workflow_checklist = {},
            workflow_state = "RELEASABLE",
            -- Attach node in the unit - can be removed, in which case it will probably use node 1 of the parent slot unit
            attach_node = "ap_bullet_01",
            -- Resource packages to load - I recommend adding all resources needed by the different attachments
            resource_dependencies = {
                ["content/weapons/player/ranged/lasgun_rifle_krieg/attachments/muzzle_05/muzzle_05"] = true,
            },
            -- Attachments - This describes the structure of the item
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                    material_overrides = {},
                },
            },
            -- Display name - Attachment names can be localized
            -- The localizations must be global - see the localization file.
            display_name = "n/a",
            -- Name - This needs to be set - should be the same as the key in master item table
            name = _item_ranged.."/scope_bodies/example_scope_body_01",
            -- This tells the main mod it is a complete item.
            is_full_item = true,
        },
        [_item_ranged.."/sights/example_scope_01"] = {
            -- Fallback item - not tested might be interesting for custom slots
            is_fallback_item = false,
            -- Show in first person / only in first person
            show_in_1p = true,
            only_show_in_1p = false,
            -- Base unit that is loaded for the attachment
            -- Here it is the empty item, so it's kind of a dummy and only the attachments show.
            base_unit = "content/characters/empty_item/empty_item",
            -- Item list faction - Who can use the item?
            item_list_faction = "Player",
            -- Unknown
            tags = {},
            feature_flags = {"FEATURE_item_retained"},
            workflow_state = "RELEASABLE",
            workflow_checklist = {},
            -- Attach node in the unit - can be removed, in which case it will probably use node 1 of the parent slot unit
            attach_node = "ap_sight_01",
            -- Resource packages to load - I recommend adding all resources needed by the different attachments
            resource_dependencies = {
                ["content/characters/empty_item/empty_item"] = true,
                ["content/weapons/player/attachments/sights/sight_reflex_02/sight_reflex_02"] = true,
                ["content/weapons/player/ranged/lasgun_rifle_krieg/attachments/muzzle_05/muzzle_05"] = true,
                ["content/weapons/player/ranged/rippergun_rifle/ammunition/ammunition_01/ammunition_01"] = true,
            },
            -- Attachments - This describes the structure of the item
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                },
                base = {
                    item = _item_ranged.."/sights/reflex_sight_02",
                    fix = {
                        hide = {
                            mesh = {5},
                        },
                    },
                    children = {
                        scope = {
                            item = _item_ranged.."/scope_bodies/example_scope_body_01",
                            -- Disable this fix to test with individual fixes
                            fix = {
                                offset = {
                                    node = 1,
                                    position = vector3_box(0, -.04, .0275),
                                    rotation = vector3_box(0, 0, 0),
                                    scale = vector3_box(1.5, 1.5, 1.5),
                                },
                            },
                            -- Disable this fix to test with individual fixes
                            children = {
                                -- lense_1 and lense_2 are currently used by the sight extension.
                                -- When aiming in first person they become transparent.
                                lense_1 = {
                                    item = _item_ranged.."/lenses/exmaple_lense_01",
                                    -- Disable this fix to test with individual fixes
                                    fix = {
                                        offset = {
                                            node = 1,
                                            position = vector3_box(0, .045, .002),
                                            rotation = vector3_box(0, 0, 0),
                                            scale = vector3_box(.9, .3, .9),
                                        },
                                        alpha = .25,
                                    },
                                    -- Disable this fix to test with individual fixes
                                },
                                lense_2 = {
                                    item = _item_ranged.."/lenses/exmaple_lense_01",
                                    -- Disable this fix to test with individual fixes
                                    fix = {
                                        offset = {
                                            node = 1,
                                            position = vector3_box(0, .085, .002),
                                            rotation = vector3_box(180, 0, 0),
                                            scale = vector3_box(.9, .4, .9),
                                        },
                                        alpha = .25,
                                    },
                                    -- Disable this fix to test with individual fixes
                                },
                            },
                        },
                    },
                },
            },
            -- Display name - Attachment names can be localized
            -- The localizations must be global - see the localization file.
            display_name = "loc_example_scope_01",
            -- Name - This needs to be set - should be the same as the key in master item table
            name = _item_ranged.."/sights/example_scope_01",
            -- This tells the main mod it is a complete item.
            is_full_item = true,
            -- This allows the attachment to be used for fx source spawning.
            -- By default kitbash items are ignored when the game wants to spawn fx sources.
            -- This is done to prevent muzzle flashes coming from a scope that uses a muzzle for example.
            disable_vfx_spawner_exclusion = true,
        },
    },
}

-- Copy attachments and fixes for autogun_p2 variants
-- Kitbashs are not defined for a specific weapon
mod.extended_weapon_customization_plugin.attachments.autogun_p2_m2 = table_clone(mod.extended_weapon_customization_plugin.attachments.autogun_p2_m1)
mod.extended_weapon_customization_plugin.attachments.autogun_p2_m3 = table_clone(mod.extended_weapon_customization_plugin.attachments.autogun_p2_m1)
mod.extended_weapon_customization_plugin.fixes.autogun_p2_m2 = table_clone(mod.extended_weapon_customization_plugin.fixes.autogun_p2_m1)
mod.extended_weapon_customization_plugin.fixes.autogun_p2_m3 = table_clone(mod.extended_weapon_customization_plugin.fixes.autogun_p2_m1)
