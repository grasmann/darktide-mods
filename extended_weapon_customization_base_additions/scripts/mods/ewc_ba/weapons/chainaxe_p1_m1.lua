local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

-- ##### Pommels ######################################################################################################

local power_sword_group = {custom_selection_group = "power_sword"}
local pommel_power_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/pommel_power_sword")
mod:merge_attachment_data(power_sword_group, pommel_power_sword)

local force_sword_group = {custom_selection_group = "force_sword"}
local pommel_force_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/pommel_force_sword")
mod:merge_attachment_data(force_sword_group, pommel_force_sword)

local _2h_power_sword_group = {custom_selection_group = "2h_power_sword"}
local pommel_2h_power_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/pommel_2h_power_sword")
mod:merge_attachment_data(_2h_power_sword_group, pommel_2h_power_sword)

local _2h_force_sword_group = {custom_selection_group = "2h_force_sword"}
local pommel_2h_force_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/pommel_2h_force_sword")
mod:merge_attachment_data(_2h_force_sword_group, pommel_2h_force_sword)

-- ##### Blades #######################################################################################################

local blade_laser_group = {custom_selection_group = "blade_laser"}
local blade_laser_chain_axe_p1_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_laser_chain_axe_p1_human")
mod:merge_attachment_data(blade_laser_group, blade_laser_chain_axe_p1_human)

-- ##### Grips ########################################################################################################

local shovel_group = {custom_selection_group = "shovel"}
local grip_shovel = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_shovel")
mod:merge_attachment_data(shovel_group, grip_shovel)

local axe_group = {custom_selection_group = "axe"}
local grip_axe = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_axe")
mod:merge_attachment_data(axe_group, grip_axe)

local hatchet_group = {custom_selection_group = "hatchet"}
local grip_hatchet = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_hatchet")
mod:merge_attachment_data(hatchet_group, grip_hatchet)

-- ##### Shaft ########################################################################################################

local force_staff_group = {custom_selection_group = "force_staff"}
local shaft_upper_forcestaff = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/shaft_upper_forcestaff")
mod:merge_attachment_data(force_staff_group, shaft_upper_forcestaff)

local _2h_power_maul_group = {custom_selection_group = "2h_power_maul"}
local shaft_2h_power_maul = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/shaft_2h_power_maul")
mod:merge_attachment_data(_2h_power_maul_group, shaft_2h_power_maul)

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
local _item_melee = _item.."/melee"
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

local shovel_grips = "shovel_grip_01|shovel_grip_02|shovel_grip_03|shovel_grip_04|shovel_grip_05|shovel_grip_ml01"
local axe_grips = "axe_grip_01|axe_grip_02|axe_grip_03|axe_grip_04|axe_grip_05|axe_grip_06"
local hatchet_grips = "hatchet_grip_01|hatchet_grip_02|hatchet_grip_03|hatchet_grip_04|hatchet_grip_05|hatchet_grip_06"
local chain_axe_grips = "chain_axe_grip_01|chain_axe_grip_02|chain_axe_grip_03|chain_axe_grip_04|chain_axe_grip_05|chain_axe_grip_06|chain_axe_grip_ml01"

local chain_axe_shafts = "chain_axe_shaft_01|chain_axe_shaft_02|chain_axe_shaft_03|chain_axe_shaft_04|chain_axe_shaft_05|chain_axe_shaft_06|chain_axe_shaft_ml01"
local force_staff_shafts = "force_staff_shaft_upper_01|force_staff_shaft_upper_02|force_staff_shaft_upper_03|force_staff_shaft_upper_04|force_staff_shaft_upper_05|force_staff_shaft_upper_06|force_staff_shaft_upper_ml01"
local _2h_power_maul_shafts = "2h_power_maul_shaft_01|2h_power_maul_shaft_02|2h_power_maul_shaft_03|2h_power_maul_shaft_04|2h_power_maul_shaft_05|2h_power_maul_shaft_06|2h_power_maul_shaft_07|2h_power_maul_shaft_ml01"

local _2h_force_sword_pommels = "2h_force_sword_pommel_01|2h_force_sword_pommel_02|2h_force_sword_pommel_03|2h_force_sword_pommel_04|2h_force_sword_pommel_05|2h_force_sword_pommel_ml01"
local _2h_power_sword_pommels = "2h_power_sword_pommel_01|2h_power_sword_pommel_02|2h_power_sword_pommel_03|2h_power_sword_pommel_ml01"
local power_sword_pommels = "power_sword_pommel_01|power_sword_pommel_02|power_sword_pommel_03|power_sword_pommel_05|power_sword_pommel_06|power_sword_pommel_ml01"
local force_sword_pommels = "force_sword_pommel_01|force_sword_pommel_02|force_sword_pommel_03|force_sword_pommel_04|force_sword_pommel_05|force_sword_pommel_ml01"

-- ##### Attachments ##################################################################################################

local attachments = {
    chainaxe_p1_m1 = {
        shaft = table_merge_recursive_n(nil, shaft_upper_forcestaff, shaft_2h_power_maul),
        blade = table_merge_recursive_n(nil, blade_laser_chain_axe_p1_human),
        grip = table_merge_recursive_n(nil, grip_shovel, grip_axe, grip_hatchet),
        pommel = table_merge_recursive_n(nil, pommel_power_sword, pommel_force_sword, pommel_2h_power_sword, pommel_2h_force_sword),
    },
}

attachments.chainaxe_p1_m2 = table_clone(attachments.chainaxe_p1_m1)
attachments.chainaxe_p1_m3 = table_clone(attachments.chainaxe_p1_m1)

-- ##### Attachment slots #############################################################################################

local attachment_slots = {
    chainaxe_p1_m1 = {
        pommel = {
            parent_slot = "shaft",
            default_path = _item_empty_trinket,
        },
    },
}

attachment_slots.chainaxe_p1_m2 = table_clone(attachment_slots.chainaxe_p1_m1)
attachment_slots.chainaxe_p1_m3 = table_clone(attachment_slots.chainaxe_p1_m1)

-- ##### Fixes ########################################################################################################

local fixes = {
    chainaxe_p1_m1 = {
        -- Move pommel down
        {attachment_slot = "pommel",
            requirements = {
                pommel = { has = _2h_force_sword_pommels.."|".._2h_power_sword_pommels.."|"..power_sword_pommels.."|"..force_sword_pommels },
                shaft = { has = chain_axe_shafts },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.1515),
                },
            },
        },
        -- Scale pommel bigger when using 2h force sword pommel
        {attachment_slot = "pommel",
            requirements = {
                pommel = { has = _2h_force_sword_pommels },
                shaft = { has = chain_axe_shafts.."|"..force_staff_shafts.."|".._2h_power_maul_shafts },
            },
            fix = {
                offset = {
                    scale = vector3_box(1.3, 1.3, 1.3),
                },
            },
        },
        -- Reposition pommel when using force staff shafts
        {attachment_slot = "pommel",
            requirements = {
                pommel = { has = _2h_force_sword_pommels.."|".._2h_power_sword_pommels.."|"..power_sword_pommels.."|"..force_sword_pommels },
                shaft = { has = force_staff_shafts },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .08),
                },
            },
        },
        -- -- Reposition pommel when using 2h power maul shafts
        -- {attachment_slot = "pommel",
        --     requirements = {
        --         pommel = { has = _2h_force_sword_pommels.."|".._2h_power_sword_pommels.."|"..power_sword_pommels.."|"..force_sword_pommels },
        --         shaft = { has = _2h_power_maul_shafts },
        --     },
        --     fix = {
        --         offset = {
        --             position = vector3_box(0, 0, .42),
        --         },
        --     },
        -- },
        -- Move shaft down when using force staff shafts
        {attachment_slot = "shaft",
            requirements = {
                shaft = { has = force_staff_shafts },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.1),
                },
            },
        },
        -- Move shaft down when using 2h power maul shafts
        {attachment_slot = "shaft",
            requirements = {
                shaft = { has = _2h_power_maul_shafts },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.12),
                },
            },
        },
        -- Reposition blade when using force staff shafts 01 / 05
        {attachment_slot = "blade",
            requirements = {
                shaft = { has = "force_staff_shaft_upper_01|force_staff_shaft_upper_05" },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .352),
                },
            },
        },
        -- Reposition blade when using force staff shafts 02 / ml01
        {attachment_slot = "blade",
            requirements = {
                shaft = { has = "force_staff_shaft_upper_02|force_staff_shaft_upper_ml01" },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .335),
                },
            },
        },
        -- Reposition blade when using force staff shafts 03 / 06
        {attachment_slot = "blade",
            requirements = {
                shaft = { has = "force_staff_shaft_upper_03|force_staff_shaft_upper_06" },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .3),
                },
            },
        },
        -- Reposition blade when using force staff shafts 04
        {attachment_slot = "blade",
            requirements = {
                shaft = { has = "force_staff_shaft_upper_04" },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .32),
                },
            },
        },
        -- Reposition blade when using 2h power maul shafts
        {attachment_slot = "blade",
            requirements = {
                shaft = { has = "2h_power_maul_shaft_01|2h_power_maul_shaft_02|2h_power_maul_shaft_04|2h_power_maul_shaft_06|2h_power_maul_shaft_07|2h_power_maul_shaft_ml01" },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .42),
                },
            },
        },
        -- Reposition blade when using 2h power maul shaft 03
        {attachment_slot = "blade",
            requirements = {
                shaft = { has = "2h_power_maul_shaft_03" },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .4),
                },
            },
        },
        -- Reposition blade when using 2h power maul shaft 05
        {attachment_slot = "blade",
            requirements = {
                shaft = { has = "2h_power_maul_shaft_05" },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .355),
                },
            },
        },
        -- Scale grip bigger when using shovel, axe or hatchet grips
        {attachment_slot = "grip",
            requirements = {
                grip = { has = shovel_grips.."|"..axe_grips.."|"..hatchet_grips },
                shaft = { has = force_staff_shafts.."|"..chain_axe_shafts },
            },
            fix = {
                offset = {
                    scale = vector3_box(1.3, 1.3, 1),
                },
            },
        },
        -- Scale grip bigger when using 2h power maul shafts
        {attachment_slot = "grip",
            requirements = {
                grip = { has = chain_axe_grips },
                shaft = { has = _2h_power_maul_shafts },
            },
            fix = {
                offset = {
                    scale = vector3_box(1, 1, 1.5),
                },
            },
        },
        -- Scale grip bigger when using shovel, axe or hatchet grips with 2h power maul shafts
        {attachment_slot = "grip",
            requirements = {
                grip = { has = shovel_grips.."|"..axe_grips.."|"..hatchet_grips },
                shaft = { has = _2h_power_maul_shafts },
            },
            fix = {
                offset = {
                    scale = vector3_box(1.3, 1.3, 1.5),
                },
            },
        },
        -- Reposition shovel, axe or hatchet grips when using force staff shafts
        {attachment_slot = "grip",
            requirements = {
                grip = { has = shovel_grips.."|"..axe_grips.."|"..hatchet_grips },
                shaft = { has = force_staff_shafts },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .2),
                },
            },
        },
        -- Reposition chain axe grips when using force staff shafts
        {attachment_slot = "grip",
            requirements = {
                grip = { has = chain_axe_grips },
                shaft = { has = force_staff_shafts },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .15),
                },
            },
        },
        -- Reposition chain axe grips when using 2h power maul shafts
        {attachment_slot = "grip",
            requirements = {
                grip = { has = shovel_grips.."|"..axe_grips.."|"..hatchet_grips.."|"..chain_axe_grips },
                shaft = { has = _2h_power_maul_shafts },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .06),
                },
            },
        },
    },
}

fixes.chainaxe_p1_m2 = table_clone(fixes.chainaxe_p1_m1)
fixes.chainaxe_p1_m3 = table_clone(fixes.chainaxe_p1_m1)

local kitbashs = {
    [_item_melee.."/blades/laser_blade_chain_axe_p1_01"] = {
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
                        position = vector3_box(0, -.07, .2),
                        rotation = vector3_box(90, 180, 180),
                        scale = vector3_box(.65, .65, .65),
                    },
                },
                children = {},
            }
        },
        display_name = "",
        description = "loc_laser_blade_chain_axe_p1_01",
        attach_node = "ap_blade_01",
        -- dev_name = "loc_laser_blade_chain_axe_p1_01",
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/melee/chain_axe/attachments/blade_06/blade_06",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
            "ROTATION_gun",
        },
        resource_dependencies = {
            ["content/weapons/player/melee/chain_axe/attachments/blade_06/blade_06"] = true,
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
        workflow_checklist = {
        },
        name = _item_melee.."/blades/laser_blade_chain_axe_p1_01",
        workflow_state = "RELEASABLE",
        is_full_item = true,
        disable_vfx_spawner_exclusion = true,
    },
    [_item_melee.."/blades/laser_blade_chain_axe_p1_02"] = {
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
                        position = vector3_box(0, -.07, .2),
                        rotation = vector3_box(90, 180, 180),
                        scale = vector3_box(.65, .65, .65),
                    },
                },
                children = {},
            }
        },
        display_name = "",
        description = "loc_laser_blade_chain_axe_p1_02",
        attach_node = "ap_blade_01",
        -- dev_name = "loc_laser_blade_chain_axe_p1_02",
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/melee/chain_axe/attachments/blade_07/blade_07",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
            "ROTATION_gun",
        },
        resource_dependencies = {
            ["content/weapons/player/melee/chain_axe/attachments/blade_07/blade_07"] = true,
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
        workflow_checklist = {
        },
        name = _item_melee.."/blades/laser_blade_chain_axe_p1_02",
        workflow_state = "RELEASABLE",
        is_full_item = true,
        disable_vfx_spawner_exclusion = true,
    },
    [_item_melee.."/blades/laser_blade_chain_axe_green_p1_01"] = {
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
                        position = vector3_box(0, -.07, .2),
                        rotation = vector3_box(90, 180, 180),
                        scale = vector3_box(.65, .65, .65),
                    },
                },
                children = {},
            }
        },
        display_name = "",
        description = "loc_laser_blade_chain_axe_green_p1_01",
        attach_node = "ap_blade_01",
        -- dev_name = "loc_laser_blade_chain_axe_green_p1_01",
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/melee/chain_axe/attachments/blade_06/blade_06",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
            "ROTATION_gun",
        },
        resource_dependencies = {
            ["content/weapons/player/melee/chain_axe/attachments/blade_06/blade_06"] = true,
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
        workflow_checklist = {
        },
        name = _item_melee.."/blades/laser_blade_chain_axe_green_p1_01",
        workflow_state = "RELEASABLE",
        is_full_item = true,
        disable_vfx_spawner_exclusion = true,
    },
    [_item_melee.."/blades/laser_blade_chain_axe_green_p1_02"] = {
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
                        position = vector3_box(0, -.07, .2),
                        rotation = vector3_box(90, 180, 180),
                        scale = vector3_box(.65, .65, .65),
                    },
                },
                children = {},
            }
        },
        display_name = "",
        description = "loc_laser_blade_chain_axe_green_p1_02",
        attach_node = "ap_blade_01",
        -- dev_name = "loc_laser_blade_chain_axe_green_p1_02",
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/melee/chain_axe/attachments/blade_07/blade_07",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
            "ROTATION_gun",
        },
        resource_dependencies = {
            ["content/weapons/player/melee/chain_axe/attachments/blade_07/blade_07"] = true,
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
        workflow_checklist = {
        },
        name = _item_melee.."/blades/laser_blade_chain_axe_green_p1_02",
        workflow_state = "RELEASABLE",
        is_full_item = true,
        disable_vfx_spawner_exclusion = true,
    },
}

return {
    attachment_slots = attachment_slots,
    attachments = attachments,
    kitbashs = kitbashs,
    fixes = fixes,
}
