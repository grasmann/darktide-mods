local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local combat_sword_group = {custom_selection_group = "combat_sword", damage_type = "metal_slashing_heavy"}
local blade_laser_combat_sword_p1_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_laser_combat_sword_p1_human")
mod:merge_attachment_data(combat_sword_group, blade_laser_combat_sword_p1_human)

local falchion_group = {custom_selection_group = "falchion", damage_type = "metal_slashing_heavy"}
local blade_falchion = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_falchion")
    -- local grip_falchion = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_falchion")
local blade_laser_combat_sword_p2_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_laser_combat_sword_p2_human")
-- mod:merge_attachment_data(falchion_group, blade_falchion, grip_falchion, blade_laser_combat_sword_p2_human)
mod:merge_attachment_data(falchion_group, blade_falchion, blade_laser_combat_sword_p2_human)

local sabre_group = {custom_selection_group = "sabre", damage_type = "metal_slashing_heavy"}
local blade_sabre = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_sabre")
    -- local grip_sabre = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_sabre")
local blade_laser_combat_sword_p3_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_laser_combat_sword_p3_human")
-- mod:merge_attachment_data(sabre_group, blade_sabre, grip_sabre, blade_laser_combat_sword_p3_human)
mod:merge_attachment_data(sabre_group, blade_sabre, blade_laser_combat_sword_p3_human)

local force_sword_group = {custom_selection_group = "force_sword", damage_type = "metal_slashing_heavy"}
    -- local force_sword_invisible_group = {custom_selection_group = "force_sword", hide_from_selection = true}
local blade_force_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_force_sword")
    -- local grip_force_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_force_sword")
    -- local hilt_force_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/hilt_force_sword")
    -- local pommel_force_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/pommel_force_sword")
local blade_laser_force_sword_p1_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_laser_force_sword_p1_human")
-- mod:merge_attachment_data(force_sword_group, blade_force_sword, grip_force_sword, blade_laser_force_sword_p1_human)
mod:merge_attachment_data(force_sword_group, blade_force_sword, blade_laser_force_sword_p1_human)
    -- mod:merge_attachment_data(force_sword_invisible_group, hilt_force_sword, pommel_force_sword)

local power_sword_group = {custom_selection_group = "power_sword", damage_type = "metal_slashing_heavy"}
    -- local power_sword_invisible_group = {custom_selection_group = "power_sword", hide_from_selection = true}
local blade_power_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_power_sword")
    -- local grip_power_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_power_sword")
    -- local hilt_power_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/hilt_power_sword")
    -- local pommel_power_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/pommel_power_sword")
local blade_laser_power_sword_p1_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_laser_power_sword_p1_human")
-- mod:merge_attachment_data(power_sword_group, blade_power_sword, grip_power_sword, blade_laser_power_sword_p1_human)
mod:merge_attachment_data(power_sword_group, blade_power_sword, blade_laser_power_sword_p1_human)
    -- mod:merge_attachment_data(power_sword_invisible_group, hilt_power_sword, pommel_power_sword)

local blade_laser_thunderhammer_2h_p1_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_laser_thunderhammer_2h_p1_human")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local table = table
    local vector3 = Vector3
    local vector3_box = Vector3Box
    local table_clone = table.clone
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

local thunderhammer_heads = "thunder_hammer_head_01|thunder_hammer_head_02|thunder_hammer_head_03|thunder_hammer_head_04|thunder_hammer_head_05|thunder_hammer_head_06|thunder_hammer_head_ml01"
local thunderhammer_laser_heads = "laser_blade_thunderhammer_2h_p1_01|laser_blade_thunderhammer_2h_p1_02|laser_blade_green_thunderhammer_2h_p1_01|laser_blade_green_thunderhammer_2h_p1_02"

local combat_sword_blades = "combat_sword_blade_01|combat_sword_blade_02|combat_sword_blade_03|combat_sword_blade_04|combat_sword_blade_05|combat_sword_blade_06|combat_sword_blade_07|combat_sword_blade_ml01"
local combat_sword_laser_blades = "laser_blade_2h_force_sword_p1_01|laser_blade_2h_force_sword_p1_02|laser_blade_2h_force_sword_green_p1_01|laser_blade_2h_force_sword_green_p1_02"
local falchion_blades = "falchion_blade_01|falchion_blade_02|falchion_blade_03|falchion_blade_04|falchion_blade_05|falchion_blade_06|falchion_blade_ml01"
local falchion_laser_blades = "laser_blade_combat_sword_p2_01|laser_blade_combat_sword_p2_02|laser_blade_green_combat_sword_p2_01|laser_blade_green_combat_sword_p2_02"
local sabre_blades = "sabre_blade_01|sabre_blade_02|sabre_blade_03|sabre_blade_04|sabre_blade_05|sabre_blade_06|sabre_blade_07|sabre_blade_ml01"
local sabre_laser_blades = "laser_blade_combat_sword_p3_01|laser_blade_combat_sword_p3_02|laser_blade_green_combat_sword_p3_01|laser_blade_green_combat_sword_p3_02"
local force_sword_blades = "force_sword_blade_01|force_sword_blade_02|force_sword_blade_03|force_sword_blade_04|force_sword_blade_05|force_sword_blade_06|force_sword_blade_ml01"
local force_sword_laser_blades = "laser_blade_force_sword_p1_01|laser_blade_force_sword_p1_02|laser_blade_green_force_sword_p1_01|laser_blade_green_force_sword_p1_02"
local power_sword_blades = "power_sword_blade_01|power_sword_blade_01_no_light|power_sword_blade_02|power_sword_blade_03|power_sword_blade_04|power_sword_blade_05|power_sword_blade_06|power_sword_blade_07|power_sword_blade_ml01"
local power_sword_laser_blades = "laser_blade_power_sword_p1_01|laser_blade_power_sword_p1_02|laser_blade_green_power_sword_p1_01|laser_blade_green_power_sword_p1_02"

local attachments = {
    thunderhammer_2h_p1_m1 = {
        head = table_merge_recursive_n(nil, blade_laser_thunderhammer_2h_p1_human, blade_laser_combat_sword_p1_human, blade_falchion, blade_laser_combat_sword_p2_human, blade_sabre, blade_laser_combat_sword_p3_human, blade_force_sword, blade_laser_force_sword_p1_human, blade_power_sword, blade_laser_power_sword_p1_human),
    },
}

attachments.thunderhammer_2h_p1_m2 = table_clone_safe(attachments.thunderhammer_2h_p1_m1)

local fixes = {
    thunderhammer_2h_p1_m1 = {
        -- {attachment_slot = "head",
        --     requirements = {
        --         head = {
        --             missing = thunderhammer_heads.."|"..thunderhammer_laser_heads,
        --         },
        --     },
        --     fix = {
        --         offset = {
        --             position = vector3_box(0, 0, .2),
        --             rotation = vector3_box(0, 0, 0),
        --             scale = vector3_box(1, 1, 1),
        --         },
        --     },
        -- },
        {attachment_slot = "head",
            requirements = {
                head = {
                    has = combat_sword_blades.."|"..combat_sword_laser_blades,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .2),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 3,
                },
            },
        },
        {attachment_slot = "head",
            requirements = {
                head = {
                    has = falchion_blades.."|"..falchion_laser_blades,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .2),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "head",
            requirements = {
                head = {
                    has = sabre_blades.."|"..sabre_laser_blades,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .2),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "head",
            requirements = {
                head = {
                    has = force_sword_blades.."|"..force_sword_laser_blades,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .2),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "head",
            requirements = {
                head = {
                    has = power_sword_blades.."|"..power_sword_laser_blades,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .2),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 2,
                },
            },
        },
    },
}

fixes.thunderhammer_2h_p1_m2 = table_clone_safe(fixes.thunderhammer_2h_p1_m1)

local attachment_slots = {
    thunderhammer_2h_p1_m1 = {},
}

attachment_slots.thunderhammer_2h_p1_m2 = table_clone_safe(attachment_slots.thunderhammer_2h_p1_m1)

local kitbashs = {
    [_item_melee.."/blades/laser_blade_thunderhammer_2h_p1_01"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/melee/thunder_hammer/attachments/head_05/head_05",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
            "ROTATION_gun",
        },
        attach_node = "ap_head_01",
        resource_dependencies = {
            ["content/weapons/player/melee/thunder_hammer/attachments/head_05/head_05"] = true,
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
                        position = vector3_box(0, -.035, -.1),
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
        name = _item_melee.."/blades/laser_blade_thunderhammer_2h_p1_01",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item_melee.."/blades/laser_blade_thunderhammer_2h_p1_02"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/melee/thunder_hammer/attachments/head_06/head_06",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
            "ROTATION_gun",
        },
        attach_node = "ap_head_01",
        resource_dependencies = {
            ["content/weapons/player/melee/thunder_hammer/attachments/head_06/head_06"] = true,
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
                        position = vector3_box(0, -.035, -.1),
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
        name = _item_melee.."/blades/laser_blade_thunderhammer_2h_p1_02",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item_melee.."/blades/laser_blade_green_thunderhammer_2h_p1_01"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/melee/thunder_hammer/attachments/head_05/head_05",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
            "ROTATION_gun",
        },
        attach_node = "ap_head_01",
        resource_dependencies = {
            ["content/weapons/player/melee/thunder_hammer/attachments/head_05/head_05"] = true,
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
                        position = vector3_box(0, -.035, -.1),
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
        name = _item_melee.."/blades/laser_blade_green_thunderhammer_2h_p1_01",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item_melee.."/blades/laser_blade_green_thunderhammer_2h_p1_02"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/melee/thunder_hammer/attachments/head_06/head_06",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
            "ROTATION_gun",
        },
        attach_node = "ap_head_01",
        resource_dependencies = {
            ["content/weapons/player/melee/thunder_hammer/attachments/head_06/head_06"] = true,
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
                        position = vector3_box(0, -.035, -.1),
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
        name = _item_melee.."/blades/laser_blade_green_thunderhammer_2h_p1_02",
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
