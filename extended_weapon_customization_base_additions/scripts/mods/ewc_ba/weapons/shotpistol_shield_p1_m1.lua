local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local lasgun_helbore_group = {custom_selection_group = "lasgun_helbore"}
local bayonets = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/bayonet_common")
mod:merge_attachment_data(lasgun_helbore_group, bayonets)

local slab_shield_group = {custom_selection_group = "slab_shield"}
local shield_ogryn_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/shield_ogryn_human")
mod:merge_attachment_data(slab_shield_group, shield_ogryn_human)

local autogun_headhunter_group = {custom_selection_group = "autogun_headhunter"}
local muzzle_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_headhunter")
mod:merge_attachment_data(autogun_headhunter_group, muzzle_autogun_headhunter)

local autogun_braced_group = {custom_selection_group = "autogun_braced"}
local muzzle_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_braced")
mod:merge_attachment_data(autogun_braced_group, muzzle_autogun_braced)

local autogun_infantry_group = {custom_selection_group = "autogun_infantry"}
local muzzle_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_infantry")
mod:merge_attachment_data(autogun_infantry_group, muzzle_autogun_infantry)

local flashlight_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/flashlight_human")
local sight_reflex = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_reflex")
local sight_scope = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_scope")
local rails = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/rail")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local table = table
    local vector3 = Vector3
    local vector3_box = Vector3Box
    local vector3_zero = vector3.zero
    local table_clone_safe = table.clone_safe
    local table_merge_recursive = table.merge_recursive
    local table_merge_recursive_n = table.merge_recursive_n
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_melee = _item.."/melee"
local _item_empty_trinket = _item.."/trinkets/unused_trinket"
local _minion = "content/items/weapons/minions"

local ogryn_shields = "ogryn_shield_01|ogryn_shield_02|ogryn_shield_03|ogryn_shield_04|ogryn_shield_05|ogryn_shield_06|ogryn_shield_07|bulwark_shield_01"
local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local scopes = "scope_01"

local attachments = {
    shotpistol_shield_p1_m1 = {
        bayonet = bayonets,
        muzzle = table_merge_recursive_n(nil, muzzle_autogun_headhunter, muzzle_autogun_braced, muzzle_autogun_infantry),
        flashlight = flashlight_human,
        sight = table_merge_recursive_n(nil, sight_reflex, sight_scope),
        rail = {
            shotpistol_rail_off = {
                replacement_path = _item_ranged.."/rails/shotpistol_rail_off",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
                hide_from_selection = true,
            },
            shotpistol_rail_01 = {
                replacement_path = _item_ranged.."/rails/shotpistol_rail_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
                hide_from_selection = true,
            },
        },
        left = shield_ogryn_human,
    },
}

attachments.shotpistol_shield_p1_m2 = table_clone_safe(attachments.shotpistol_shield_p1_m1)
attachments.shotpistol_shield_p1_m3 = table_clone_safe(attachments.shotpistol_shield_p1_m1)

local attachment_slots = {
    shotpistol_shield_p1_m1 = {
        flashlight = {
            parent_slot = "rail",
            default_path = _item_empty_trinket,
            fix = {
                offset = {
                    position = vector3_box(.034, .112, -.053),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        muzzle = {
            parent_slot = "rail",
            default_path = _item_empty_trinket,
            fix = {
                offset = {
                    position = vector3_box(0, .185, -.048),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        bayonet = {
            parent_slot = "rail",
            default_path = _item_empty_trinket,
            fix = {
                offset = {
                    position = vector3_box(0, .11, -.135),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        sight = {
            parent_slot = "rail",
            default_path = _item_empty_trinket,
        },
    },
}

attachment_slots.shotpistol_shield_p1_m2 = table_clone_safe(attachment_slots.shotpistol_shield_p1_m1)
attachment_slots.shotpistol_shield_p1_m3 = table_clone_safe(attachment_slots.shotpistol_shield_p1_m1)

local fixes = {
    shotpistol_shield_p1_m1 = {
        -- Attach pistol rail when using reflex sights
        {attachment_slot = "rail",
            requirements = {
                sight = {
                    has = reflex_sights,
                },
            },
            fix = {
                attach = {
                    rail = "shotpistol_rail_01",
                },
            },
        },
        -- Attach empty rail when not using reflex sights
        {attachment_slot = "rail",
            requirements = {
                sight = {
                    missing = reflex_sights,
                },
            },
            fix = {
                attach = {
                    rail = "shotpistol_rail_off",
                },
            },
        },
        -- Adjust rail position
        {attachment_slot = "rail",
            requirements = {
                rail = {
                    has = "shotpistol_rail_01|shotpistol_rail_off",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.02, .12),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        -- Adjust flashlight position
        {attachment_slot = "flashlight",
            fix = {
                offset = {
                    position = vector3_box(.034, .112, -.053),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        -- Adjust muzzle position
        {attachment_slot = "muzzle",
            fix = {
                offset = {
                    position = vector3_box(0, .185, -.048),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        -- Adjust bayonet position
        {attachment_slot = "bayonet",
            fix = {
                offset = {
                    position = vector3_box(0, .11, -.135),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        -- Adjust shield scale and position when using bulwark shield
        {attachment_slot = "left",
            requirements = {
                left = {
                    has = "bulwark_shield_01",
                },
            },
            fix = {
                only_in_ui = true,
                offset = {
                    position = vector3_box(0, -.1, -.1),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(.5, .5, .5),
                    node = 1,
                },
            },
        },
        -- Adjust shield scale when using ogryn shields but no bulwark shield
        {attachment_slot = "left",
            requirements = {
                left = {
                    has = ogryn_shields,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(-.025, 0, .015),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(.5, .5, .5),
                    node = 1,
                },
            },
        },
    },
}

fixes.shotpistol_shield_p1_m2 = table_clone_safe(fixes.shotpistol_shield_p1_m1)
fixes.shotpistol_shield_p1_m3 = table_clone_safe(fixes.shotpistol_shield_p1_m1)

local kitbashs = {
    [_item.."/shields/bulwark_shield_01"] = {
        attachments = {
            shield = {
                item = _minion.."/shields/chaos_ogryn_bulwark_shield_01",
                children = {},
            },
            zzz_shared_material_overrides = {
                item = "",
                children = {},
            },
        },
        disable_vfx_spawner_exclusion = true,
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/characters/empty_item/empty_item",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
            "ROTATION_gun",
        },
        attach_node = "j_leftweaponattach",
        resource_dependencies = {
            ["content/characters/empty_item/empty_item"] = true,
            ["content/weapons/enemy/shields/bulwark_shield_01/bulwark_shield_01"] = true,
        },
        workflow_checklist = {
        },
        display_name = "n/a",
        name = _item.."/shields/bulwark_shield_01",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item.."/shields/ogryn_shield_01"] = {
        attachments = {
            shield = {
                item = _item_melee.."/ogryn_slabshield_p1_m1",
                children = {},
            },
            zzz_shared_material_overrides = {
                item = "",
                children = {},
            },
        },
        disable_vfx_spawner_exclusion = true,
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/characters/empty_item/empty_item",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
            "ROTATION_gun",
        },
        attach_node = "j_leftweaponattach",
        resource_dependencies = {
            ["content/characters/empty_item/empty_item"] = true,
            ["content/weapons/player/shields/ogryn_slab_shield/wpn_ogryn_slab_shield_chained_rig"] = true,
        },
        workflow_checklist = {
        },
        display_name = "n/a",
        name = _item.."/shields/ogryn_shield_01",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item.."/shields/ogryn_shield_02"] = {
        attachments = {
            shield = {
                item = _item_melee.."/ogryn_slabshield_p1_m2",
                children = {},
            },
            zzz_shared_material_overrides = {
                item = "",
                children = {},
            },
        },
        disable_vfx_spawner_exclusion = true,
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/characters/empty_item/empty_item",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
            "ROTATION_gun",
        },
        attach_node = "j_leftweaponattach",
        resource_dependencies = {
            ["content/characters/empty_item/empty_item"] = true,
            ["content/weapons/player/shields/ogryn_slab_shield/wpn_ogryn_slab_shield_chained_rig_02"] = true,
        },
        workflow_checklist = {
        },
        display_name = "n/a",
        name = _item.."/shields/ogryn_shield_02",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item.."/shields/ogryn_shield_03"] = {
        attachments = {
            shield = {
                item = _item_melee.."/ogryn_slabshield_p1_m3",
                children = {},
            },
            zzz_shared_material_overrides = {
                item = "",
                children = {},
            },
        },
        disable_vfx_spawner_exclusion = true,
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/characters/empty_item/empty_item",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
            "ROTATION_gun",
        },
        attach_node = "j_leftweaponattach",
        resource_dependencies = {
            ["content/characters/empty_item/empty_item"] = true,
            ["content/weapons/player/shields/ogryn_slab_shield/wpn_ogryn_slab_shield_chained_rig_03"] = true,
        },
        workflow_checklist = {
        },
        display_name = "n/a",
        name = _item.."/shields/ogryn_shield_03",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item.."/shields/ogryn_shield_04"] = {
        attachments = {
            shield = {
                item = _item_melee.."/ogryn_slabshield_p1_04",
                children = {},
            },
            zzz_shared_material_overrides = {
                item = "",
                children = {},
            },
        },
        disable_vfx_spawner_exclusion = true,
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/characters/empty_item/empty_item",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
            "ROTATION_gun",
        },
        attach_node = "j_leftweaponattach",
        resource_dependencies = {
            ["content/characters/empty_item/empty_item"] = true,
            ["content/weapons/player/shields/ogryn_slab_shield/wpn_ogryn_slab_shield_chained_rig_04"] = true,
        },
        workflow_checklist = {
        },
        display_name = "n/a",
        name = _item.."/shields/ogryn_shield_04",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item.."/shields/ogryn_shield_05"] = {
        attachments = {
            shield = {
                item = _item_melee.."/ogryn_slabshield_p1_05",
                children = {},
            },
            zzz_shared_material_overrides = {
                item = "",
                children = {},
            },
        },
        disable_vfx_spawner_exclusion = true,
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/characters/empty_item/empty_item",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
            "ROTATION_gun",
        },
        attach_node = "j_leftweaponattach",
        resource_dependencies = {
            ["content/characters/empty_item/empty_item"] = true,
            ["content/weapons/player/shields/ogryn_slab_shield/wpn_ogryn_slab_shield_chained_rig_05"] = true,
        },
        workflow_checklist = {
        },
        display_name = "n/a",
        name = _item.."/shields/ogryn_shield_05",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item.."/shields/ogryn_shield_06"] = {
        attachments = {
            shield = {
                item = _item_melee.."/ogryn_slabshield_p1_06",
                children = {},
            },
            zzz_shared_material_overrides = {
                item = "",
                children = {},
            },
        },
        disable_vfx_spawner_exclusion = true,
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/characters/empty_item/empty_item",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
            "ROTATION_gun",
        },
        attach_node = "j_leftweaponattach",
        resource_dependencies = {
            ["content/characters/empty_item/empty_item"] = true,
            ["content/weapons/player/shields/ogryn_slab_shield/wpn_ogryn_slab_shield_chained_rig_06"] = true,
        },
        workflow_checklist = {
        },
        display_name = "n/a",
        name = _item.."/shields/ogryn_shield_06",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item.."/shields/ogryn_shield_07"] = {
        attachments = {
            shield = {
                item = _item_melee.."/ogryn_slabshield_p1_ml01",
                children = {},
            },
            zzz_shared_material_overrides = {
                item = "",
                children = {},
            },
        },
        disable_vfx_spawner_exclusion = true,
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/characters/empty_item/empty_item",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
            "ROTATION_gun",
        },
        attach_node = "j_leftweaponattach",
        resource_dependencies = {
            ["content/characters/empty_item/empty_item"] = true,
            ["content/weapons/player/shields/ogryn_slab_shield/attachments/ogryn_slab_shield_ml01/wpn_ogryn_slab_shield_chained_rig_ml01"] = true,
        },
        workflow_checklist = {
        },
        display_name = "n/a",
        name = _item.."/shields/ogryn_shield_07",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item_ranged.."/rails/shotpistol_rail_off"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/ranged/stubgun_pistol/attachments/rail_off/rail_off",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained"
        },
        attach_node = 2,
        resource_dependencies = {
            ["content/weapons/player/ranged/stubgun_pistol/attachments/rail_off/rail_off"] = true,
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
        name = _item_ranged.."/rails/shotpistol_rail_off",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item_ranged.."/rails/shotpistol_rail_01"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/ranged/lasgun_pistol/attachments/rail_01/rail_01",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained"
        },
        attach_node = 2,
        resource_dependencies = {
            ["content/weapons/player/ranged/lasgun_pistol/attachments/rail_01/rail_01"] = true,
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
        name = _item_ranged.."/rails/shotpistol_rail_01",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
}

return {
    attachment_slots = attachment_slots,
    attachments = attachments,
    kitbashs = kitbashs,
    fixes = fixes,
}
