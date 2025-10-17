local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local blade_laser_combat_sword_p3_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_laser_combat_sword_p3_human")

local combat_sword_group = {custom_selection_group = "combat_sword"}
local blade_combat_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_combat_sword")
local grip_combat_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_combat_sword")
local blade_laser_combat_sword_p1_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_laser_combat_sword_p1_human")
mod:merge_attachment_data(combat_sword_group, blade_combat_sword, grip_combat_sword, blade_laser_combat_sword_p1_human)

local falchion_group = {custom_selection_group = "falchion"}
local blade_falchion = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_falchion")
local grip_falchion = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_falchion")
local blade_laser_combat_sword_p2_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_laser_combat_sword_p2_human")
mod:merge_attachment_data(falchion_group, blade_falchion, grip_falchion, blade_laser_combat_sword_p2_human)

local force_sword_group = {custom_selection_group = "force_sword"}
local force_sword_invisible_group = {custom_selection_group = "force_sword", hide_from_selection = true}
local blade_force_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_force_sword")
local grip_force_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_force_sword")
local hilt_force_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/hilt_force_sword")
local pommel_force_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/pommel_force_sword")
local blade_laser_force_sword_p1_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_laser_force_sword_p1_human")
mod:merge_attachment_data(force_sword_group, blade_force_sword, grip_force_sword, blade_laser_force_sword_p1_human)
mod:merge_attachment_data(force_sword_invisible_group, hilt_force_sword, pommel_force_sword)

local power_sword_group = {custom_selection_group = "power_sword"}
local power_sword_invisible_group = {custom_selection_group = "power_sword", hide_from_selection = true}
local blade_power_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_power_sword")
local grip_power_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_power_sword")
local hilt_power_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/hilt_power_sword")
local pommel_power_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/pommel_power_sword")
local blade_laser_power_sword_p1_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_laser_power_sword_p1_human")
mod:merge_attachment_data(power_sword_group, blade_power_sword, grip_power_sword, blade_laser_power_sword_p1_human)
mod:merge_attachment_data(power_sword_invisible_group, hilt_power_sword, pommel_power_sword)

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
local _item_melee = _item.."/melee"
local _item_ranged = _item.."/ranged"
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

local offset_blades = "falchion_blade_06|laser_blade_combat_sword_p2_02|laser_blade_green_combat_sword_p2_02"
local offset_grips = "falchion_grip_06"

local force_sword_blades = "force_sword_blade_01|force_sword_blade_02|force_sword_blade_03|force_sword_blade_04|force_sword_blade_05|force_sword_blade_06|force_sword_blade_ml01"
local force_sword_hilts = "force_sword_hilt_01|force_sword_hilt_02|force_sword_hilt_03|force_sword_hilt_04|force_sword_hilt_05|force_sword_hilt_06|force_sword_hilt_07|force_sword_hilt_ml01"
local force_sword_grips = "force_sword_grip_01|force_sword_grip_02|force_sword_grip_03|force_sword_grip_04|force_sword_grip_05|force_sword_grip_06"
local force_sword_pommels = "force_sword_pommel_01|force_sword_pommel_02|force_sword_pommel_03|force_sword_pommel_04|force_sword_pommel_05|force_sword_pommel_ml01"

local power_sword_blades = "power_sword_blade_01|power_sword_blade_02|power_sword_blade_03|power_sword_blade_04|power_sword_blade_05|power_sword_blade_06|power_sword_blade_07|power_sword_blade_ml01"
local power_sword_hilts = "power_sword_hilt_01"
local power_sword_grips = "power_sword_grip_01|power_sword_grip_02|power_sword_grip_03|power_sword_grip_04|power_sword_grip_05|power_sword_grip_06|power_sword_grip_ml01"
local power_sword_pommels = "power_sword_pommel_01|power_sword_pommel_02|power_sword_pommel_03|power_sword_pommel_05|power_sword_pommel_06|power_sword_pommel_ml01"

local attachments = {
    combatsword_p3_m1 = {
        body = table_merge_recursive_n(nil, blade_force_sword, blade_laser_combat_sword_p1_human, blade_laser_combat_sword_p2_human, blade_laser_combat_sword_p3_human, blade_combat_sword, blade_falchion, blade_laser_force_sword_p1_human),
        grip = table_merge_recursive_n(nil, grip_force_sword, grip_combat_sword, grip_falchion, grip_power_sword),
        hilt = table_merge_recursive_n({
            -- Unused trinket for hiding perposes
            unused_trinket = {
                replacement_path = _item.."/trinkets/unused_trinket",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {0, -.5, .05},
            },
        }, hilt_force_sword, hilt_power_sword),
        pommel = table_merge_recursive_n({
            -- Unused trinket for hiding perposes
            unused_trinket = {
                replacement_path = _item.."/trinkets/unused_trinket",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {0, -.5, .05},
            },
        }, pommel_force_sword, pommel_power_sword),
    },
}

attachments.combatsword_p3_m3 = table_clone_safe(attachments.combatsword_p3_m1)
attachments.combatsword_p3_m2 = table_clone_safe(attachments.combatsword_p3_m1)

local fixes = {
    combatsword_p3_m1 = {
        {attachment_slot = "body",
            requirements = {
                body = {
                    has = offset_blades,
                },
                grip = {
                    missing = offset_grips,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.03),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                },
            },
        },
        {attachment_slot = "body",
            requirements = {
                body = {
                    missing = offset_blades,
                },
                grip = {
                    has = offset_grips,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .03),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                },
            },
        },

        -- Attach force sword pommels when force sword grip is used
        {attachment_slot = "pommel",
            requirements = {
                grip = {
                    has = "force_sword_grip_01",
                },
                pommel = {
                    missing = force_sword_pommels,
                },
            },
            fix = {
                attach = {
                    pommel = "force_sword_pommel_01",
                },
            },
        },
        {attachment_slot = "pommel",
            requirements = {
                grip = {
                    has = "force_sword_grip_02",
                },
                pommel = {
                    missing = force_sword_pommels,
                },
            },
            fix = {
                attach = {
                    pommel = "force_sword_pommel_02",
                },
            },
        },
        {attachment_slot = "pommel",
            requirements = {
                grip = {
                    has = "force_sword_grip_03",
                },
                pommel = {
                    missing = force_sword_pommels,
                },
            },
            fix = {
                attach = {
                    pommel = "force_sword_pommel_03",
                },
            },
        },
        {attachment_slot = "pommel",
            requirements = {
                grip = {
                    has = "force_sword_grip_04",
                },
                pommel = {
                    missing = force_sword_pommels,
                },
            },
            fix = {
                attach = {
                    pommel = "force_sword_pommel_04",
                },
            },
        },
        {attachment_slot = "pommel",
            requirements = {
                grip = {
                    has = "force_sword_grip_05",
                },
                pommel = {
                    missing = force_sword_pommels,
                },
            },
            fix = {
                attach = {
                    pommel = "force_sword_pommel_05",
                },
            },
        },
        {attachment_slot = "pommel",
            requirements = {
                grip = {
                    has = "force_sword_grip_06",
                },
                pommel = {
                    missing = force_sword_pommels,
                },
            },
            fix = {
                attach = {
                    pommel = "force_sword_pommel_ml01",
                },
            },
        },
        -- Remove force sword pommel when force sword grip is not used
        {attachment_slot = "pommel",
            requirements = {
                grip = {
                    missing = force_sword_grips,
                },
                pommel = {
                    has = force_sword_pommels,
                },
            },
            fix = {
                attach = {
                    pommel = "unused_trinket",
                },
            },
        },
        -- Blade offset when force sword grip is used
        {attachment_slot = "body",
            requirements = {
                grip = {
                    has = force_sword_grips,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .1),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                },
            },
        },
        -- Attach force sword hilt when force sword grip is used
        {attachment_slot = "hilt",
            requirements = {
                grip = {
                    has = "force_sword_grip_01",
                },
                hilt = {
                    missing = force_sword_hilts,
                },
            },
            fix = {
                attach = {
                    hilt = "force_sword_hilt_01",
                },
            },
        },
        {attachment_slot = "hilt",
            requirements = {
                grip = {
                    has = "force_sword_grip_02",
                },
                hilt = {
                    missing = force_sword_hilts,
                },
            },
            fix = {
                attach = {
                    hilt = "force_sword_hilt_02",
                },
            },
        },
        {attachment_slot = "hilt",
            requirements = {
                grip = {
                    has = "force_sword_grip_03",
                },
                hilt = {
                    missing = force_sword_hilts,
                },
            },
            fix = {
                attach = {
                    hilt = "force_sword_hilt_03",
                },
            },
        },
        {attachment_slot = "hilt",
            requirements = {
                grip = {
                    has = "force_sword_grip_04",
                },
                hilt = {
                    missing = force_sword_hilts,
                },
            },
            fix = {
                attach = {
                    hilt = "force_sword_hilt_04",
                },
            },
        },
        {attachment_slot = "hilt",
            requirements = {
                grip = {
                    has = "force_sword_grip_05",
                },
                hilt = {
                    missing = force_sword_hilts,
                },
            },
            fix = {
                attach = {
                    hilt = "force_sword_hilt_05",
                },
            },
        },
        {attachment_slot = "hilt",
            requirements = {
                grip = {
                    has = "force_sword_grip_06",
                },
                hilt = {
                    missing = force_sword_hilts,
                },
            },
            fix = {
                attach = {
                    hilt = "force_sword_hilt_06",
                },
            },
        },
        -- Remove force sword hilt when force sword grip is not used
        {attachment_slot = "hilt",
            requirements = {
                grip = {
                    missing = force_sword_grips,
                },
                hilt = {
                    has = force_sword_hilts,
                },
            },
            fix = {
                attach = {
                    hilt = "unused_trinket",
                },
            },
        },

        -- Attach power sword pommels when power sword grip is used
        {attachment_slot = "pommel",
            requirements = {
                grip = {
                    has = "power_sword_grip_01",
                },
                pommel = {
                    missing = power_sword_pommels,
                },
            },
            fix = {
                attach = {
                    pommel = "power_sword_pommel_01",
                },
            },
        },
        {attachment_slot = "pommel",
            requirements = {
                grip = {
                    has = "power_sword_grip_02",
                },
                pommel = {
                    missing = power_sword_pommels,
                },
            },
            fix = {
                attach = {
                    pommel = "power_sword_pommel_02",
                },
            },
        },
        {attachment_slot = "pommel",
            requirements = {
                grip = {
                    has = "power_sword_grip_03",
                },
                pommel = {
                    missing = power_sword_pommels,
                },
            },
            fix = {
                attach = {
                    pommel = "power_sword_pommel_03",
                },
            },
        },
        {attachment_slot = "pommel",
            requirements = {
                grip = {
                    has = "power_sword_grip_04",
                },
                pommel = {
                    missing = power_sword_pommels,
                },
            },
            fix = {
                attach = {
                    pommel = "power_sword_pommel_03",
                },
            },
        },
        {attachment_slot = "pommel",
            requirements = {
                grip = {
                    has = "power_sword_grip_05",
                },
                pommel = {
                    missing = power_sword_pommels,
                },
            },
            fix = {
                attach = {
                    pommel = "power_sword_pommel_05",
                },
            },
        },
        {attachment_slot = "pommel",
            requirements = {
                grip = {
                    has = "power_sword_grip_06",
                },
                pommel = {
                    missing = power_sword_pommels,
                },
            },
            fix = {
                attach = {
                    pommel = "power_sword_pommel_06",
                },
            },
        },
        {attachment_slot = "pommel",
            requirements = {
                grip = {
                    has = "power_sword_grip_ml01",
                },
                pommel = {
                    missing = power_sword_pommels,
                },
            },
            fix = {
                attach = {
                    pommel = "power_sword_pommel_ml01",
                },
            },
        },
        -- Remove power sword pommel when power sword grip is not used
        {attachment_slot = "pommel",
            requirements = {
                grip = {
                    missing = power_sword_grips,
                },
                pommel = {
                    has = power_sword_pommels,
                },
            },
            fix = {
                attach = {
                    pommel = "unused_trinket",
                },
            },
        },
        -- Blade offset when power sword grip is used
        {attachment_slot = "body",
            requirements = {
                grip = {
                    has = power_sword_grips,
                    missing = "power_sword_grip_04",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .075),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                },
            },
        },
        {attachment_slot = "body",
            requirements = {
                grip = {
                    has = "power_sword_grip_04",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .065),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                },
            },
        },
        -- Hilt offset when power sword grip is used
        {attachment_slot = "hilt",
            requirements = {
                grip = {
                    has = "power_sword_grip_04",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .05),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                },
            },
        },
        -- Attach power sword hilt when power sword grip is used
        {attachment_slot = "hilt",
            requirements = {
                grip = {
                    has = power_sword_grips,
                },
                hilt = {
                    missing = power_sword_hilts,
                },
            },
            fix = {
                attach = {
                    hilt = "power_sword_hilt_01",
                },
            },
        },
        -- Remove power sword hilt when power sword grip is not used
        {attachment_slot = "hilt",
            requirements = {
                grip = {
                    missing = power_sword_grips,
                },
                hilt = {
                    has = power_sword_hilts,
                },
            },
            fix = {
                attach = {
                    hilt = "unused_trinket",
                },
            },
        },
    },
}

fixes.combatsword_p3_m3 = table_clone_safe(fixes.combatsword_p3_m1)
fixes.combatsword_p3_m2 = table_clone_safe(fixes.combatsword_p3_m1)

local attachment_slots = {
    combatsword_p3_m1 = {
        hilt = {
            parent_slot = "grip",
            default_path = _item_empty_trinket,
        },
        pommel = {
            parent_slot = "grip",
            default_path = _item_empty_trinket,
        },
    },
}

attachment_slots.combatsword_p3_m3 = table_clone_safe(attachment_slots.combatsword_p3_m1)
attachment_slots.combatsword_p3_m2 = table_clone_safe(attachment_slots.combatsword_p3_m1)

local kitbashs = {
    [_item_melee.."/blades/laser_blade_combat_sword_p3_01"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/melee/sabre/attachments/blade_06/blade_06",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
        },
        attach_node = "ap_blade_01",
        resource_dependencies = {
            ["content/weapons/player/melee/sabre/attachments/blade_06/blade_06"] = true,
            -- ["content/fx/particles/weapons/grenades/flame_grenade_hostile_fire_lingering_green"] = true,
            ["content/fx/particles/weapons/grenades/flame_grenade_hostile_fire_lingering"] = true,
            ["content/fx/particles/weapons/rifles/plasma_gun/plasma_vent_valve"] = true,
            ["content/fx/particles/weapons/rifles/plasma_gun/plasma_gun_charge"] = true,
            -- ["content/fx/particles/enemies/plasma_gun_laser_sight"] = true,
            ["content/fx/particles/enemies/sniper_laser_sight"] = true,
            ["wwise/events/minions/play_traitor_captain_shield_bullet_hits"] = true,
            ["wwise/events/weapon/play_aoe_liquid_fire_green_loop"] = true,
            ["wwise/events/weapon/stop_aoe_liquid_fire_green_loop"] = true,
            ["wwise/events/weapon/play_flametrower_alt_fire_off"] = true,
            ["wwise/events/weapon/play_flametrower_alt_fire_on"] = true,
            ["wwise/events/weapon/play_flamethrower_interrupt"] = true,
            ["wwise/events/weapon/play_shockmaul_1h_p2_swing"] = true,
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
                        position = vector3_box(0, -.02, 0),
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
        name = _item_melee.."/blades/laser_blade_combat_sword_p3_01",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item_melee.."/blades/laser_blade_combat_sword_p3_02"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/melee/sabre/attachments/blade_07/blade_07",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
        },
        attach_node = "ap_blade_01",
        resource_dependencies = {
            ["content/weapons/player/melee/sabre/attachments/blade_07/blade_07"] = true,
            -- ["content/fx/particles/weapons/grenades/flame_grenade_hostile_fire_lingering_green"] = true,
            ["content/fx/particles/weapons/grenades/flame_grenade_hostile_fire_lingering"] = true,
            ["content/fx/particles/weapons/rifles/plasma_gun/plasma_vent_valve"] = true,
            ["content/fx/particles/weapons/rifles/plasma_gun/plasma_gun_charge"] = true,
            -- ["content/fx/particles/enemies/plasma_gun_laser_sight"] = true,
            ["content/fx/particles/enemies/sniper_laser_sight"] = true,
            ["wwise/events/minions/play_traitor_captain_shield_bullet_hits"] = true,
            ["wwise/events/weapon/play_aoe_liquid_fire_green_loop"] = true,
            ["wwise/events/weapon/stop_aoe_liquid_fire_green_loop"] = true,
            ["wwise/events/weapon/play_flametrower_alt_fire_off"] = true,
            ["wwise/events/weapon/play_flametrower_alt_fire_on"] = true,
            ["wwise/events/weapon/play_flamethrower_interrupt"] = true,
            ["wwise/events/weapon/play_shockmaul_1h_p2_swing"] = true,
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
                        position = vector3_box(0, -.02, -.02),
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
        name = _item_melee.."/blades/laser_blade_combat_sword_p3_02",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item_melee.."/blades/laser_blade_green_combat_sword_p3_01"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/melee/sabre/attachments/blade_06/blade_06",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
        },
        attach_node = "ap_blade_01",
        resource_dependencies = {
            ["content/weapons/player/melee/sabre/attachments/blade_06/blade_06"] = true,
            ["content/fx/particles/weapons/grenades/flame_grenade_hostile_fire_lingering_green"] = true,
            -- ["content/fx/particles/weapons/grenades/flame_grenade_hostile_fire_lingering"] = true,
            ["content/fx/particles/weapons/rifles/plasma_gun/plasma_vent_valve"] = true,
            ["content/fx/particles/weapons/rifles/plasma_gun/plasma_gun_charge"] = true,
            ["content/fx/particles/enemies/plasma_gun_laser_sight"] = true,
            -- ["content/fx/particles/enemies/sniper_laser_sight"] = true,
            ["wwise/events/minions/play_traitor_captain_shield_bullet_hits"] = true,
            ["wwise/events/weapon/play_aoe_liquid_fire_green_loop"] = true,
            ["wwise/events/weapon/stop_aoe_liquid_fire_green_loop"] = true,
            ["wwise/events/weapon/play_flametrower_alt_fire_off"] = true,
            ["wwise/events/weapon/play_flametrower_alt_fire_on"] = true,
            ["wwise/events/weapon/play_flamethrower_interrupt"] = true,
            ["wwise/events/weapon/play_shockmaul_1h_p2_swing"] = true,
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
                        position = vector3_box(0, -.02, 0),
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
        name = _item_melee.."/blades/laser_blade_green_combat_sword_p3_01",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item_melee.."/blades/laser_blade_green_combat_sword_p3_02"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/melee/sabre/attachments/blade_07/blade_07",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
        },
        attach_node = "ap_blade_01",
        resource_dependencies = {
            ["content/weapons/player/melee/sabre/attachments/blade_07/blade_07"] = true,
            ["content/fx/particles/weapons/grenades/flame_grenade_hostile_fire_lingering_green"] = true,
            -- ["content/fx/particles/weapons/grenades/flame_grenade_hostile_fire_lingering"] = true,
            ["content/fx/particles/weapons/rifles/plasma_gun/plasma_vent_valve"] = true,
            ["content/fx/particles/weapons/rifles/plasma_gun/plasma_gun_charge"] = true,
            ["content/fx/particles/enemies/plasma_gun_laser_sight"] = true,
            -- ["content/fx/particles/enemies/sniper_laser_sight"] = true,
            ["wwise/events/minions/play_traitor_captain_shield_bullet_hits"] = true,
            ["wwise/events/weapon/play_aoe_liquid_fire_green_loop"] = true,
            ["wwise/events/weapon/stop_aoe_liquid_fire_green_loop"] = true,
            ["wwise/events/weapon/play_flametrower_alt_fire_off"] = true,
            ["wwise/events/weapon/play_flametrower_alt_fire_on"] = true,
            ["wwise/events/weapon/play_flamethrower_interrupt"] = true,
            ["wwise/events/weapon/play_shockmaul_1h_p2_swing"] = true,
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
                        position = vector3_box(0, -.02, -.02),
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
        name = _item_melee.."/blades/laser_blade_green_combat_sword_p3_02",
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
