local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

-- local trinket_hooks = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/trinket_hook")
local flashlight_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/flashlight_human")
-- local sights = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight")
local sight_reflex = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_reflex")
local sight_scope = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_scope")
local rails = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/rail")
-- local emblem_left = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/emblem_left")
-- local emblem_right = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/emblem_right")

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
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local scopes = "scope_01"

local attachments = {
    plasmagun_p1_m1 = {
        flashlight = flashlight_human,
        rail = rails,
        sight = table_merge_recursive_n(nil, sight_reflex, sight_scope),
    },
}

attachments.plasmagun_p1_m2 = table_clone(attachments.plasmagun_p1_m1)
attachments.plasmagun_p1_m3 = table_clone(attachments.plasmagun_p1_m1)

local attachment_slots = {
    plasmagun_p1_m1 = {
        flashlight = {
            parent_slot = "barrel",
            default_path = _item_empty_trinket,
            fix = {
                offset = {
                    position = vector3_box(.04, .27, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        rail = {
            parent_slot = "receiver",
            default_path = _item_empty_trinket,
            fix = {
                offset = {
                    position = vector3_box(0, .07, .1625),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1.075, 1),
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

attachment_slots.plasmagun_p1_m2 = table_clone(attachment_slots.plasmagun_p1_m1)
attachment_slots.plasmagun_p1_m3 = table_clone(attachment_slots.plasmagun_p1_m1)

local fixes = {
    plasmagun_p1_m1 = {
        {attachment_slot = "sight_offset",
            requirements = {
                sight = {
                    has = reflex_sights,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(-.1325, 0, .05),
                    rotation = vector3_box(-1, 20, 0),
                },
            },
        },
        {attachment_slot = "rail",
            requirements = {
                sight = {
                    has = scopes,
                },
            },
            fix = {
                attach = {
                    rail = "stubgun_pistol_rail_off",
                },
            },
        },
        {attachment_slot = "rail",
            requirements = {
                sight = {
                    has = reflex_sights,
                },
            },
            fix = {
                attach = {
                    rail = "lasgun_rifle_rail_01",
                },
            },
        },
        {attachment_slot = "sight",
            requirements = {
                sight = {
                    has = scopes,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.105, .1875),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
    },
}

fixes.plasmagun_p1_m2 = table_clone(fixes.plasmagun_p1_m1)
fixes.plasmagun_p1_m3 = table_clone(fixes.plasmagun_p1_m1)

return {
    attachments = attachments,
    attachment_slots = attachment_slots,
    fixes = fixes,
}
