local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local blade_laser_powermaul_shield_p1_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_laser_powermaul_shield_p1_human")

local shield_ogryn_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/shield_ogryn_human")

local flashlight_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/flashlight_human")
local rails = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/rail")
local sight_reflex = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_reflex")
local sight_scope = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_scope")

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

local ogryn_shields = "ogryn_shield_01|ogryn_shield_02|ogryn_shield_03|ogryn_shield_04|ogryn_shield_05|ogryn_shield_06|ogryn_shield_07"

local short_heads = "human_power_maul_short_head_01|human_power_maul_short_head_ml01|human_power_maul_short_head_deluxe01"
local medium_heads = "human_power_maul_short_head_02|human_power_maul_short_head_ml02|human_power_maul_short_head_deluxe02"
local long_heads = "human_power_maul_short_head_03"

local short_connectors = "human_power_maul_short_connector_03"
local medium_connectors = "human_power_maul_short_connector_02|human_power_maul_short_connector_ml02|human_power_maul_short_connector_deluxe02"
local long_connectors = "human_power_maul_short_connector_01|human_power_maul_short_connector_ml01|human_power_maul_short_connector_deluxe01"

local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local scopes = "scope_01"

local attachments = {
    powermaul_shield_p1_m1 = {
        head = blade_laser_powermaul_shield_p1_human,
        left = shield_ogryn_human,
    },
}

attachments.powermaul_shield_p1_m2 = table_clone_safe(attachments.powermaul_shield_p1_m1)

local attachment_slots = {
    powermaul_shield_p1_m1 = {
    },
}

attachment_slots.powermaul_shield_p1_m2 = table_clone_safe(attachment_slots.powermaul_shield_p1_m1)

local fixes = {
    powermaul_shield_p1_m1 = {
        {attachment_slot = "left",
            requirements = {
                left = {
                    has = ogryn_shields,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(.5, .5, .5),
                    node = 1,
                },
            },
        },
        {attachment_slot = "left",
            requirements = {
                left = {
                    has = "bulwark_shield_01",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.025),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(.5, .5, .5),
                    node = 1,
                },
            },
        },
        {attachment_slot = "head",
            requirements = {
                connector = {
                    has = short_connectors,
                },
                head = {
                    has = short_heads,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.175),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "head",
            requirements = {
                connector = {
                    has = short_connectors,
                },
                head = {
                    has = medium_heads,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.11),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "head",
            requirements = {
                connector = {
                    has = medium_connectors,
                },
                head = {
                    has = short_heads,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.06),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "head",
            requirements = {
                connector = {
                    has = medium_connectors,
                },
                head = {
                    has = long_heads,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .12),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "head",
            requirements = {
                connector = {
                    has = long_connectors,
                },
                head = {
                    has = medium_heads,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .064),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "head",
            requirements = {
                connector = {
                    has = long_connectors,
                },
                head = {
                    has = long_heads,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .172),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
    },
}

fixes.powermaul_shield_p1_m2 = table_clone_safe(fixes.powermaul_shield_p1_m1)

local kitbashs = {
    [_item_melee.."/blades/laser_blade_powermaul_shield_p1_01"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/melee/human_power_maul_short/attachments/head_03/head_03",
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
            ["content/weapons/player/melee/human_power_maul_short/attachments/head_03/head_03"] = true,
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
                        position = vector3_box(0, -.035, -.27),
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
        name = _item_melee.."/blades/laser_blade_powermaul_shield_p1_01",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item_melee.."/blades/laser_blade_powermaul_shield_p1_02"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/melee/human_power_maul_short/attachments/head_deluxe01/head_deluxe01",
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
            ["content/weapons/player/melee/human_power_maul_short/attachments/head_deluxe01/head_deluxe01"] = true,
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
                        position = vector3_box(0, -.035, -.27),
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
        name = _item_melee.."/blades/laser_blade_powermaul_shield_p1_02",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item_melee.."/blades/laser_blade_green_powermaul_shield_p1_01"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/melee/human_power_maul_short/attachments/head_03/head_03",
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
            ["content/weapons/player/melee/human_power_maul_short/attachments/head_03/head_03"] = true,
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
                        position = vector3_box(0, -.035, -.27),
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
        name = _item_melee.."/blades/laser_blade_green_powermaul_shield_p1_01",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item_melee.."/blades/laser_blade_green_powermaul_shield_p1_02"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/melee/human_power_maul_short/attachments/head_deluxe01/head_deluxe01",
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
            ["content/weapons/player/melee/human_power_maul_short/attachments/head_deluxe01/head_deluxe01"] = true,
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
                        position = vector3_box(0, -.035, -.27),
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
        name = _item_melee.."/blades/laser_blade_green_powermaul_shield_p1_02",
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
