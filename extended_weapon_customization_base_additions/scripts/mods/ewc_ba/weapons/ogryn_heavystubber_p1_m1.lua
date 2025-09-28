local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local flashlight_ogryn = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/flashlight_ogryn")
local sight_reflex = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_reflex")
local rails = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/rail")

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
local _item_ranged = _item.."/ranged"
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"

local attachments = {
    ogryn_heavystubber_p1_m1 = {
        flashlight = flashlight_ogryn,
        rail = rails,
        sight = sight_reflex,
    }
}

attachments.ogryn_heavystubber_p1_m2 = table_clone(attachments.ogryn_heavystubber_p1_m1)
attachments.ogryn_heavystubber_p1_m3 = table_clone(attachments.ogryn_heavystubber_p1_m1)

local fixes = {
    ogryn_heavystubber_p1_m1 = {
        {attachment_slot = "sight_offset",
            requirements = {
                sight = {
                    has = "reflex_sight_02|reflex_sight_03",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(-.25, -.2, .14),
                    rotation = vector3_box(-1, -3, 0),
                },
            },
        },
        {attachment_slot = "sight_offset",
            requirements = {
                sight = {
                    has = "reflex_sight_01",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(-.25, -.2, .13),
                    rotation = vector3_box(-1, -3, 0),
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
                    rail = "lasgun_pistol_rail_01",
                },
            },
        },
    },
}

fixes.ogryn_heavystubber_p1_m2 = table_clone(fixes.ogryn_heavystubber_p1_m1)
fixes.ogryn_heavystubber_p1_m3 = table_clone(fixes.ogryn_heavystubber_p1_m1)

local attachment_slots = {
    ogryn_heavystubber_p1_m1 = {
        rail = {
            parent_slot = "receiver",
            default_path = _item_empty_trinket,
            fix = {
                offset = {
                    position = vector3_box(-.07, .2, .16),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(3, 3, 3),
                    node = 1,
                },
            },
        },
        sight = {
            parent_slot = "rail",
            default_path = _item_empty_trinket,
            fix = {
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

attachment_slots.ogryn_heavystubber_p1_m2 = table_clone(attachment_slots.ogryn_heavystubber_p1_m1)
attachment_slots.ogryn_heavystubber_p1_m3 = table_clone(attachment_slots.ogryn_heavystubber_p1_m1)

return {
    attachments = attachments,
    attachment_slots = attachment_slots,
    fixes = fixes,
}
