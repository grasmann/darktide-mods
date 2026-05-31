local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

-- local rails = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/rail")
-- local flashlight_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/flashlight_human")
-- local sight_reflex = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_reflex")
-- local sight_scope = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_scope")

-- local autogun_infantry_group = {custom_selection_group = "autogun_infantry"}
-- -- local magazine_autogun_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_double")
-- local magazine_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_infantry")
-- local muzzle_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_infantry")
-- mod:merge_attachment_data(autogun_infantry_group, magazine_autogun_infantry, muzzle_autogun_infantry)

-- local autogun_headhunter_group = {custom_selection_group = "autogun_headhunter"}
-- local muzzle_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_headhunter")
-- local magazine_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_headhunter")
-- mod:merge_attachment_data(autogun_headhunter_group, muzzle_autogun_headhunter, magazine_autogun_headhunter)

-- local autogun_braced_group = {custom_selection_group = "autogun_braced"}
-- local muzzle_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_braced")
-- local magazine_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_braced")
-- mod:merge_attachment_data(autogun_braced_group, muzzle_autogun_braced, magazine_autogun_braced)

-- local autopistol_group = {custom_selection_group = "autopistol"}
-- -- local magazine_autopistol_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autopistol_double")
-- local magazine_autopistol = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autopistol")
-- mod:merge_attachment_data(autopistol_group, magazine_autopistol)

-- local magazine_laser_group = {custom_selection_group = "magazine_laser"}
-- local magazine_laser = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_laser_autogun")
-- mod:merge_attachment_data(magazine_laser_group, magazine_laser)

-- local bolter_group = {custom_selection_group = "bolter"}
-- local magazine_bolter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_bolter")
-- -- local magazine_bolter_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_bolter_double")
-- mod:merge_attachment_data(bolter_group, magazine_bolter)

-- local suppressor_group = {custom_selection_group = "suppressors"}
-- local muzzle_suppressors = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_suppressors")
-- mod:merge_attachment_data(suppressor_group, muzzle_suppressors)

local suppressor_group = {custom_selection_group = "combat_knife"}
local blade_laser_dual_shivs_p1_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_laser_dual_shivs_p1_human")
mod:merge_attachment_data(suppressor_group, blade_laser_dual_shivs_p1_human)

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
local _item_melee = _item.."/melee"
-- local _item_ranged = _item.."/ranged"
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

-- local bolter_magazines = "boltgun_rifle_magazine_01_ba|boltgun_rifle_magazine_02_ba|boltgun_rifle_magazine_01_double|boltgun_rifle_magazine_02_double"
-- local laser_magazines = "autogun_rifle_laser_magazine_01|autogun_rifle_laser_magazine_02|autogun_rifle_laser_magazine_03"
-- local autopistol_magazines = "autogun_pistol_magazine_01|autogun_pistol_magazine_01_double"
-- local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
-- local scope_sights = "scope_01"

local attachments = {
    dual_shivs_p1_m1 = {
        fake_blade = table_merge_recursive_n(nil, blade_laser_dual_shivs_p1_human),
        -- rail = rails,
        -- flashlight = flashlight_human,
        -- sight = table_merge_recursive_n(nil, sight_reflex, sight_scope),
        -- fake_magazine = table_merge_recursive_n(nil, magazine_autogun_infantry, magazine_autogun_headhunter, magazine_autogun_braced, magazine_autopistol, magazine_laser, magazine_bolter),
        -- muzzle = table_merge_recursive_n(nil, muzzle_autogun_headhunter, muzzle_autogun_braced, muzzle_autogun_infantry, muzzle_suppressors),
    },
}

attachments.dual_shivs_p1_m2 = table_clone(attachments.dual_shivs_p1_m1)
attachments.dual_shivs_p1_m3 = table_clone(attachments.dual_shivs_p1_m1)
attachments.dual_shivs_p1_m4 = table_clone(attachments.dual_shivs_p1_m1)

local attachment_slots = {
    dual_shivs_p1_m1 = {
        fake_blade = {
            parent_slot = "left|right",
            default_path = _item_empty_trinket,
        },
        -- muzzle = {
        --     parent_slot = "left|right",
        --     default_path = _item_empty_trinket,
        -- },
        -- sight = {
        --     parent_slot = "rail",
        --     default_path = _item_empty_trinket,
        -- },
        -- rail = {
        --     parent_slot = "left|right",
        --     default_path = _item_empty_trinket,
        -- },
        -- fake_magazine = {
        --     parent_slot = "rail",
        --     default_path = _item_empty_trinket,
        -- },
    },
}

attachment_slots.dual_shivs_p1_m2 = table_clone(attachment_slots.dual_shivs_p1_m1)
attachment_slots.dual_shivs_p1_m3 = table_clone(attachment_slots.dual_shivs_p1_m1)
attachment_slots.dual_shivs_p1_m4 = table_clone(attachment_slots.dual_shivs_p1_m1)

local fixes = {
    dual_shivs_p1_m1 = {
        {attachment_slot = "fake_blade",
            requirements = {
                fake_blade = {
                    has = "query:dual_shivs_p1_m1,fake_blade,extended_weapon_customization_base_additions",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.004, .05),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
    }
}

fixes.dual_shivs_p1_m2 = table_clone(fixes.dual_shivs_p1_m1)
fixes.dual_shivs_p1_m3 = table_clone(fixes.dual_shivs_p1_m1)
fixes.dual_shivs_p1_m4 = table_clone(fixes.dual_shivs_p1_m1)

local kitbashs = {
    dual_shivs_p1_m1 = {
        [_item_melee.."/blades/laser_blade_dual_shivs_p1_01"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = _item_melee.."/shiv_p1_deluxe01_ver01",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
        },
        attach_node = "ap_blade_01",
        resource_dependencies = {
            -- ["content/weapons/player/melee/combat_knife/attachments/blade_07/blade_07"] = true,
            -- ["content/ui/materials/icons/weapons/hud/combatknife_p1"] = true,
            -- ["content/weapons/player/melee/shiv/wpn_shiv_chained_rig"] = true,
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
            -- zzz_shared_material_overrides = {
            --     item = "",
            --     children = {},
            -- },
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
        name = _item_melee.."/blades/laser_blade_dual_shivs_p1_01",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item_melee.."/blades/laser_blade_dual_shivs_p1_02"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = _item_melee.."/shiv_p1_deluxe01_ver02",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
        },
        attach_node = "ap_blade_01",
        resource_dependencies = {
            -- ["content/weapons/player/melee/combat_knife/attachments/blade_09/blade_09"] = true,
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
            -- zzz_shared_material_overrides = {
            --     item = "",
            --     children = {},
            -- },
            tank = {
                item = _item_melee.."/tanks/laser_blade_tank_02",
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
        name = _item_melee.."/blades/laser_blade_dual_shivs_p1_02",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item_melee.."/blades/laser_blade_green_dual_shivs_p1_01"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = _item_melee.."/shiv_p1_deluxe01_ver01",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
        },
        attach_node = "ap_blade_01",
        resource_dependencies = {
            -- ["content/weapons/player/melee/combat_knife/attachments/blade_07/blade_07"] = true,
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
            -- zzz_shared_material_overrides = {
            --     item = "",
            --     children = {},
            -- },
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
        name = _item_melee.."/blades/laser_blade_green_dual_shivs_p1_01",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item_melee.."/blades/laser_blade_green_dual_shivs_p1_02"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = _item_melee.."/shiv_p1_deluxe01_ver02",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
        },
        attach_node = "ap_blade_01",
        resource_dependencies = {
            -- ["content/weapons/player/melee/combat_knife/attachments/blade_09/blade_09"] = true,
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
            -- zzz_shared_material_overrides = {
            --     item = "",
            --     children = {},
            -- },
            tank = {
                item = _item_melee.."/tanks/laser_blade_tank_02",
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
        name = _item_melee.."/blades/laser_blade_green_combat_knife_p1_02",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    }
}

return {
    fixes = fixes,
    kitbashs = kitbashs,
    attachments = attachments,
    attachment_slots = attachment_slots,
}
