local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local blade_laser_combat_sword_p1_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_laser_combat_sword_p1_human")
local blade_laser_combat_sword_p2_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_laser_combat_sword_p2_human")
local blade_laser_combat_sword_p3_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_laser_combat_sword_p3_human")

local blade_falchion = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_falchion")
mod:modify_customization_groups(blade_falchion, "falchion")
local grip_falchion = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_falchion")
mod:modify_customization_groups(grip_falchion, "falchion")

local blade_sabre = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_sabre")
mod:modify_customization_groups(blade_sabre, "sabre")
local grip_sabre = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_sabre")
mod:modify_customization_groups(grip_sabre, "sabre")

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

local offset_blades = "falchion_blade_06|laser_blade_combat_sword_p2_02|laser_blade_green_combat_sword_p2_02"
local offset_grips = "falchion_grip_06"

local attachments = {
    combatsword_p1_m1 = {
        body = table_merge_recursive_n(nil, blade_laser_combat_sword_p1_human, blade_laser_combat_sword_p2_human, blade_laser_combat_sword_p3_human, blade_falchion, blade_sabre),
        grip = table_merge_recursive_n(nil, grip_falchion, grip_sabre),
    },
}

attachments.combatsword_p1_m3 = table_clone_safe(attachments.combatsword_p1_m1)
attachments.combatsword_p1_m2 = table_clone_safe(attachments.combatsword_p1_m1)

local fixes = {
    combatsword_p1_m1 = {
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
    },
}

fixes.combatsword_p1_m3 = table_clone_safe(fixes.combatsword_p1_m1)
fixes.combatsword_p1_m2 = table_clone_safe(fixes.combatsword_p1_m1)

local kitbashs = {
    [_item_melee.."/blades/laser_blade_combat_sword_p1_01"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/melee/combat_sword/attachments/blade_06/blade_06",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
        },
        attach_node = "ap_blade_01",
        resource_dependencies = {
            ["content/weapons/player/melee/combat_sword/attachments/blade_06/blade_06"] = true,
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
        name = _item_melee.."/blades/laser_blade_combat_sword_p1_01",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item_melee.."/blades/laser_blade_combat_sword_p1_02"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/melee/combat_sword/attachments/blade_07/blade_07",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
        },
        attach_node = "ap_blade_01",
        resource_dependencies = {
            ["content/weapons/player/melee/combat_sword/attachments/blade_07/blade_07"] = true,
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
        name = _item_melee.."/blades/laser_blade_combat_sword_p1_02",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item_melee.."/blades/laser_blade_green_combat_sword_p1_01"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/melee/combat_sword/attachments/blade_06/blade_06",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
        },
        attach_node = "ap_blade_01",
        resource_dependencies = {
            ["content/weapons/player/melee/combat_sword/attachments/blade_06/blade_06"] = true,
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
        name = _item_melee.."/blades/laser_blade_green_combat_sword_p1_01",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item_melee.."/blades/laser_blade_green_combat_sword_p1_02"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/weapons/player/melee/combat_sword/attachments/blade_07/blade_07",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
        },
        attach_node = "ap_blade_01",
        resource_dependencies = {
            ["content/weapons/player/melee/combat_sword/attachments/blade_07/blade_07"] = true,
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
        name = _item_melee.."/blades/laser_blade_green_combat_sword_p1_02",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
}

return {
    attachments = attachments,
    kitbashs = kitbashs,
    fixes = fixes,
}
