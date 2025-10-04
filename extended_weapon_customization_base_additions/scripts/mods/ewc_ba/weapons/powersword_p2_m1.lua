local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local blade_power_sword = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_power_sword")
mod:modify_customization_groups(blade_power_sword, "power_sword")

local blade_laser_power_sword_p1_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_laser_power_sword_p1_human")

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

local attachments = {
    powersword_p2_m1 = {
        blade = table_merge_recursive_n(nil, blade_power_sword),
    },
}

attachments.powersword_p2_m3 = table_clone_safe(attachments.powersword_p2_m1)
attachments.powersword_p2_m2 = table_clone_safe(attachments.powersword_p2_m1)

local kitbashs = {
    -- [_item_melee.."/blades/laser_blade_power_sword_p1_01"] = {
    --     is_fallback_item = false,
    --     show_in_1p = true,
    --     base_unit = "content/weapons/player/melee/power_sword/attachments/blade_06/blade_06",
    --     item_list_faction = "Player",
    --     tags = {
    --     },
    --     only_show_in_1p = false,
    --     feature_flags = {
    --         "FEATURE_item_retained",
    --     },
    --     attach_node = "ap_blade_01",
    --     resource_dependencies = {
    --         ["content/weapons/player/melee/power_sword/attachments/blade_06/blade_06"] = true,
    --     },
    --     attachments = {
    --         zzz_shared_material_overrides = {
    --             item = "",
    --             children = {},
    --         },
    --         tank = {
    --             item = _item_melee.."/tanks/laser_blade_tank_01",
    --             fix = {
    --                 offset = {
    --                     node = 1,
    --                     position = vector3_box(0, -.02, .08),
    --                     rotation = vector3_box(90, 180, 180),
    --                     scale = vector3_box(.65, .65, .65),
    --                 },
    --             },
    --             children = {},
    --         }
    --     },
    --     workflow_checklist = {
    --     },
    --     display_name = "n/a",
    --     name = _item_melee.."/blades/laser_blade_power_sword_p1_01",
    --     workflow_state = "RELEASABLE",
    --     is_full_item = true,
    -- },
    -- [_item_melee.."/blades/laser_blade_power_sword_p1_02"] = {
    --     is_fallback_item = false,
    --     show_in_1p = true,
    --     base_unit = "content/weapons/player/melee/power_sword/attachments/blade_07/blade_07",
    --     item_list_faction = "Player",
    --     tags = {
    --     },
    --     only_show_in_1p = false,
    --     feature_flags = {
    --         "FEATURE_item_retained",
    --     },
    --     attach_node = "ap_blade_01",
    --     resource_dependencies = {
    --         ["content/weapons/player/melee/power_sword/attachments/blade_07/blade_07"] = true,
    --     },
    --     attachments = {
    --         zzz_shared_material_overrides = {
    --             item = "",
    --             children = {},
    --         },
    --         tank = {
    --             item = _item_melee.."/tanks/laser_blade_tank_02",
    --             fix = {
    --                 offset = {
    --                     node = 1,
    --                     position = vector3_box(0, -.02, .08),
    --                     rotation = vector3_box(90, 180, 180),
    --                     scale = vector3_box(.65, .65, .65),
    --                 },
    --             },
    --             children = {},
    --         }
    --     },
    --     workflow_checklist = {
    --     },
    --     display_name = "n/a",
    --     name = _item_melee.."/blades/laser_blade_power_sword_p1_02",
    --     workflow_state = "RELEASABLE",
    --     is_full_item = true,
    -- },
    -- [_item_melee.."/blades/laser_blade_green_power_sword_p1_01"] = {
    --     is_fallback_item = false,
    --     show_in_1p = true,
    --     base_unit = "content/weapons/player/melee/power_sword/attachments/blade_06/blade_06",
    --     item_list_faction = "Player",
    --     tags = {
    --     },
    --     only_show_in_1p = false,
    --     feature_flags = {
    --         "FEATURE_item_retained",
    --     },
    --     attach_node = "ap_blade_01",
    --     resource_dependencies = {
    --         ["content/weapons/player/melee/power_sword/attachments/blade_06/blade_06"] = true,
    --     },
    --     attachments = {
    --         zzz_shared_material_overrides = {
    --             item = "",
    --             children = {},
    --         },
    --         tank = {
    --             item = _item_melee.."/tanks/laser_blade_tank_01",
    --             fix = {
    --                 offset = {
    --                     node = 1,
    --                     position = vector3_box(0, -.02, .08),
    --                     rotation = vector3_box(90, 180, 180),
    --                     scale = vector3_box(.65, .65, .65),
    --                 },
    --             },
    --             children = {},
    --         }
    --     },
    --     workflow_checklist = {
    --     },
    --     display_name = "n/a",
    --     name = _item_melee.."/blades/laser_blade_green_power_sword_p1_01",
    --     workflow_state = "RELEASABLE",
    --     is_full_item = true,
    -- },
    -- [_item_melee.."/blades/laser_blade_green_power_sword_p1_02"] = {
    --     is_fallback_item = false,
    --     show_in_1p = true,
    --     base_unit = "content/weapons/player/melee/power_sword/attachments/blade_07/blade_07",
    --     item_list_faction = "Player",
    --     tags = {
    --     },
    --     only_show_in_1p = false,
    --     feature_flags = {
    --         "FEATURE_item_retained",
    --     },
    --     attach_node = "ap_blade_01",
    --     resource_dependencies = {
    --         ["content/weapons/player/melee/power_sword/attachments/blade_07/blade_07"] = true,
    --     },
    --     attachments = {
    --         zzz_shared_material_overrides = {
    --             item = "",
    --             children = {},
    --         },
    --         tank = {
    --             item = _item_melee.."/tanks/laser_blade_tank_02",
    --             fix = {
    --                 offset = {
    --                     node = 1,
    --                     position = vector3_box(0, -.02, .08),
    --                     rotation = vector3_box(90, 180, 180),
    --                     scale = vector3_box(.65, .65, .65),
    --                 },
    --             },
    --             children = {},
    --         }
    --     },
    --     workflow_checklist = {
    --     },
    --     display_name = "n/a",
    --     name = _item_melee.."/blades/laser_blade_green_power_sword_p1_02",
    --     workflow_state = "RELEASABLE",
    --     is_full_item = true,
    -- },
}

return {
    attachments = attachments,
    kitbashs = kitbashs,
}
