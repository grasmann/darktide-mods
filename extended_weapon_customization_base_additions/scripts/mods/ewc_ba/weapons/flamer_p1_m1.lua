local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local flashlight_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/flashlight_human")
local grip_common = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_common")

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
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

local attachments = {
    flamer_p1_m1 = {
        grip = grip_common,
        flashlight = flashlight_human,
    },
}

attachments.flamer_npc_01 = table_clone(attachments.flamer_p1_m1)

local attachment_slots = {
    flamer_p1_m1 = {
        flashlight = {
            parent_slot = "receiver",
            default_path = _item_empty_trinket,
            fix = {
                offset = {
                    position = vector3_box(.03, .19, .146),
                    rotation = vector3_box(0, -60, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
    },
}

attachment_slots.flamer_npc_01 = table_clone(attachment_slots.flamer_p1_m1)

local fixes = {
    flamer_p1_m1 = {},
}

fixes.flamer_npc_01 = table_clone(fixes.flamer_p1_m1)

local kitbashs = {
    -- [_item_ranged.."/magazines/flamer_rifle_magazine_green_01"] = {
    --     attachments = {
    --         zzz_shared_material_overrides = {
    --             item = "",
    --             children = {},
    --         },
    --         magazine_1 = {
    --             item = _item_ranged.."/magazines/boltgun_rifle_magazine_01",
    --             fix = {
    --                 offset = {
    --                     node = 1,
    --                     position = vector3_box(0, 0, 0),
    --                     rotation = vector3_box(0, 0, 0),
    --                     scale = vector3_box(1, 1, 1),
    --                 },
    --             },
    --             children = {},
    --         },
    --     },
    --     display_name = "loc_boltgun_rifle_magazine_01_double",
    --     description = "loc_description_boltgun_rifle_magazine_01_double",
    --     attach_node = "ap_magazine_01",
    --     dev_name = "loc_boltgun_rifle_magazine_01_double",
    --     is_fallback_item = false,
    --     show_in_1p = true,
    --     base_unit = "content/characters/empty_item/empty_item",
    --     item_list_faction = "Player",
    --     tags = {
    --     },
    --     only_show_in_1p = false,
    --     feature_flags = {
    --         "FEATURE_item_retained",
    --     },
    --     resource_dependencies = {
    --         ["content/characters/empty_item/empty_item"] = true,
    --         ["content/weapons/player/ranged/bolt_gun/attachments/magazine_01/magazine_01"] = true,
    --         -- Muzzle flash
    --         ["content/fx/particles/weapons/rifles/bolter/bolter_muzzle_ignite"] = true,
    --         ["content/fx/particles/weapons/rifles/bolter/bolter_muzzle_secondary"] = true,
    --         -- ["content/fx/particles/weapons/rifles/autogun/autogun_muzzle_crit"] = true,
    --         -- Line effect
    --         ["content/fx/particles/weapons/rifles/bolter/bolter_trail"] = true,
    --         ["content/fx/particles/weapons/rifles/bolter/bolter_smoke_trail"] = true,
    --         -- ["content/fx/particles/weapons/rifles/lasgun/lasgun_beam_standard_linger"] = true,
    --         -- Sounds
    --         ["wwise/events/weapon/play_shared_combat_weapon_bolter_bullet_flyby"] = true,
    --         ["wwise/events/weapon/play_weapon_bolter"] = true,
    --         -- ["wwise/events/weapon/stop_lasgun_p3_m2_fire_auto"] = true,
    --         -- ["wwise/events/weapon/play_lasgun_p3_m3_fire_single"] = true,
    --     },
    --     workflow_checklist = {
    --     },
    --     name = _item_ranged.."/magazines/flamer_rifle_magazine_green_01",
    --     workflow_state = "RELEASABLE",
    --     is_full_item = true,
    --     disable_vfx_spawner_exclusion = true,
    -- },
}

return {
    fixes = fixes,
    attachments = attachments,
    attachment_slots = attachment_slots,
    kitbashs = kitbashs,
}
