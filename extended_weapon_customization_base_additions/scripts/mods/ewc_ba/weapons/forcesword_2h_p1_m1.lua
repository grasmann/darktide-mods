local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local _2h_power_sword_group = {custom_selection_group = "2h_power_sword"}

local blade_laser_2h_power_sword_p1_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_laser_2h_power_sword_p1_human")
local pommel_2h_power_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/pommel_2h_power_sword")
local blade_2h_power_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_2h_power_sword")
local hilt_2h_power_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/hilt_2h_power_sword")
local grip_2h_power_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_2h_power_sword")
mod:merge_attachment_data(_2h_power_sword_group, blade_2h_power_sword, hilt_2h_power_sword, pommel_2h_power_sword, grip_2h_power_sword)

local blade_laser_2h_force_sword_p1_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_laser_2h_force_sword_p1_human")

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

local _2h_power_sword_laser_blades = "laser_blade_2h_power_sword_p1_01|laser_blade_2h_power_sword_p1_02|laser_blade_2h_power_sword_green_p1_01|laser_blade_2h_power_sword_green_p1_02"
local _2h_power_sword_blades = "2h_power_sword_blade_01|2h_power_sword_blade_02|2h_power_sword_blade_03|2h_power_sword_blade_ml01"
local _2h_power_sword_hilts = "2h_power_sword_hilt_01|2h_power_sword_hilt_02|2h_power_sword_hilt_03|2h_power_sword_hilt_ml01"
local _2h_power_sword_grips = "2h_power_sword_grip_01|2h_power_sword_grip_02|2h_power_sword_grip_03"

local _2h_force_sword_blades = "2h_force_sword_blade_01|2h_force_sword_blade_02|2h_force_sword_blade_03|2h_force_sword_blade_04|2h_force_sword_blade_05|2h_force_sword_blade_ml01"
local _2h_force_sword_hilts = "2h_force_sword_hilt_01|2h_force_sword_hilt_02|2h_force_sword_hilt_03|2h_force_sword_hilt_04|2h_force_sword_hilt_05|2h_force_sword_hilt_ml01"
local _2h_force_sword_grips = "2h_force_sword_grip_01|2h_force_sword_grip_02|2h_force_sword_grip_03|2h_force_sword_grip_04|2h_force_sword_grip_05|2h_force_sword_grip_ml01"
local _2h_force_sword_pommels = "2h_force_sword_pommel_01|2h_force_sword_pommel_02|2h_force_sword_pommel_03|2h_force_sword_pommel_04|2h_force_sword_pommel_05|2h_force_sword_pommel_ml01"

local attachments = {
    forcesword_2h_p1_m1 = {
        blade = table_merge_recursive_n(nil, blade_laser_2h_force_sword_p1_human, blade_laser_2h_power_sword_p1_human, blade_2h_power_sword),
        hilt = table_merge_recursive_n(nil, hilt_2h_power_sword),
        pommel = table_merge_recursive_n(nil, pommel_2h_power_sword),
        grip = table_merge_recursive_n(nil, grip_2h_power_sword),
        hilt_2 = {
            power_sword_hilt_empty_01 = {
                replacement_path = _item_melee.."/hilts/power_sword_hilt_empty_01",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {-.025, -.75, .275},
                hide_from_selection = true,
            },
            power_sword_hilt_01 = {
                replacement_path = _item_melee.."/hilts/power_sword_hilt_01",
                icon_render_unit_rotation_offset = {90, 45, 0},
                icon_render_camera_position_offset = {-.025, -.75, .275},
                hide_from_selection = true,
            },
        },
    },
}

attachments.forcesword_2h_p1_m2 = table_clone_safe(attachments.forcesword_2h_p1_m1)
attachments.forcesword_2h_p1_m3 = table_clone_safe(attachments.forcesword_2h_p1_m1)

local attachment_slots = {
    forcesword_2h_p1_m1 = {
        hilt_2 = {
            parent_slot = "hilt",
            default_path = _item_empty_trinket,
            fix = {
                offset = {
                    position = vector3_box(0, 0, .045),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1.2, 1.2, 1.2),
                    node = 1,
                },
            },
        },
    }
}

attachment_slots.forcesword_2h_p1_m2 = table_clone_safe(attachment_slots.forcesword_2h_p1_m1)
attachment_slots.forcesword_2h_p1_m3 = table_clone_safe(attachment_slots.forcesword_2h_p1_m1)

local fixes = {
    forcesword_2h_p1_m1 = {
        -- When using 2h force sword hilt and 2h power sword blade - move the blade down
        {attachment_slot = "blade",
            requirements = {
                hilt = {
                    has = _2h_force_sword_hilts,
                },
                blade = {
                    has = _2h_power_sword_blades.."|".._2h_power_sword_laser_blades,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.15),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        -- When using 2h power sword hilt and not 2h force sword blade - move the blade up
        {attachment_slot = "blade",
            requirements = {
                hilt = {
                    has = _2h_power_sword_hilts,
                },
                blade = {
                    missing = _2h_power_sword_blades.."|".._2h_power_sword_laser_blades,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .07),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        -- When using 2h force sword hilt 5 and not 2h force sword grip 5 - move the hilt down
        {attachment_slot = "hilt",
            requirements = {
                hilt = {
                    has = "2h_force_sword_hilt_05",
                },
                grip = {
                    missing = "2h_force_sword_grip_05",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.03),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        -- When using 2h power sword grip 2 and not 2h power sword hilt 2 - move the hilt down
        {attachment_slot = "hilt",
            requirements = {
                grip = {
                    has = "2h_power_sword_grip_02",
                },
                hilt = {
                    missing = "2h_power_sword_hilt_02",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.03),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        -- When using 2h power sword grip 3 and not 2h power sword hilt 3 - move the hilt down
        {attachment_slot = "hilt",
            requirements = {
                grip = {
                    has = "2h_power_sword_grip_03",
                },
                hilt = {
                    missing = "2h_power_sword_hilt_03",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.01),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        -- When using 2h force sword pommel 4 and not 2h force sword grip 4 - move the pommel up
        {attachment_slot = "pommel",
            requirements = {
                grip = {
                    has = "2h_force_sword_grip_04",
                },
                pommel = {
                    missing = "2h_force_sword_pommel_04",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .01),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        -- When using 2h power sword hilt and not 2h power sword blade - set hilt 2
        {attachment_slot = "hilt_2",
            requirements = {
                hilt = {
                    has = _2h_power_sword_hilts,
                },
                blade = {
                    missing = _2h_power_sword_blades.."|".._2h_power_sword_laser_blades,
                },
            },
            fix = {
                attach = {
                    hilt_2 = "power_sword_hilt_01",
                },
                offset = {
                    position = vector3_box(0, 0, .045),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1.2, 1.2, 1.2),
                    node = 1,
                },
            },
        },
        -- When not using 2h power sword hilt - unset hilt 2
        {attachment_slot = "hilt_2",
            requirements = {
                hilt = {
                    missing = _2h_power_sword_hilts,
                },
            },
            fix = {
                attach = {
                    hilt_2 = "power_sword_hilt_empty_01",
                },
                offset = {
                    position = vector3_box(0, 0, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
    },
}

fixes.forcesword_2h_p1_m2 = table_clone_safe(fixes.forcesword_2h_p1_m1)
fixes.forcesword_2h_p1_m3 = table_clone_safe(fixes.forcesword_2h_p1_m1)

local kitbashs = {
    [_item_melee.."/blades/laser_blade_2h_force_sword_p1_01"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/melee/2h_force_sword/attachments/blade_04/blade_04",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
        },
        attach_node = "ap_blade_01",
        resource_dependencies = {
            ["content/weapons/player/melee/2h_force_sword/attachments/blade_04/blade_04"] = true,
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
                        position = vector3_box(0, -.02, -.08),
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
        name = _item_melee.."/blades/laser_blade_2h_force_sword_p1_01",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item_melee.."/blades/laser_blade_2h_force_sword_p1_02"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/melee/2h_force_sword/attachments/blade_05/blade_05",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
        },
        attach_node = "ap_blade_01",
        resource_dependencies = {
            ["content/weapons/player/melee/2h_force_sword/attachments/blade_05/blade_05"] = true,
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
                        position = vector3_box(0, -.02, -.08),
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
        name = _item_melee.."/blades/laser_blade_2h_force_sword_p1_02",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item_melee.."/blades/laser_blade_green_2h_force_sword_p1_01"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/melee/2h_force_sword/attachments/blade_04/blade_04",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
        },
        attach_node = "ap_blade_01",
        resource_dependencies = {
            ["content/weapons/player/melee/2h_force_sword/attachments/blade_04/blade_04"] = true,
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
                        position = vector3_box(0, -.02, -.08),
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
        name = _item_melee.."/blades/laser_blade_green_2h_force_sword_p1_01",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item_melee.."/blades/laser_blade_green_2h_force_sword_p1_02"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/melee/2h_force_sword/attachments/blade_05/blade_05",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
        },
        attach_node = "ap_blade_01",
        resource_dependencies = {
            ["content/weapons/player/melee/2h_force_sword/attachments/blade_05/blade_05"] = true,
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
                        position = vector3_box(0, -.02, -.08),
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
        name = _item_melee.."/blades/laser_blade_green_2h_force_sword_p1_02",
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
