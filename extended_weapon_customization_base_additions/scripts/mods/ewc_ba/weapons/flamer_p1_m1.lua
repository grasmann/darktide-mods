local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

-- local trinket_hooks = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/trinket_hook")
-- local flashlights = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/flashlight")
-- local sights = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight")
-- local rails = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/rail")
local flashlight_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/flashlight_human")
-- local emblem_left = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/emblem_left")
-- local emblem_right = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/emblem_right")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local table = table
    local vector3 = Vector3
    local vector3_box = Vector3Box
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
        flashlight = flashlight_human,
    },
}

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

local fixes = {}

local kitbashs = {}

return {
    fixes = fixes,
    attachments = attachments,
    attachment_slots = attachment_slots,
    kitbashs = kitbashs,
}
