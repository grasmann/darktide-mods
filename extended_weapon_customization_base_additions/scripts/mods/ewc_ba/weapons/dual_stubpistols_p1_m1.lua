local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local flashlight_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/flashlight_human")
local sight_reflex = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_reflex")
local sight_scope = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_scope")

local autogun_headhunter_group = {custom_selection_group = "autogun_headhunter"}
local muzzle_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_headhunter")
mod:merge_attachment_data(autogun_headhunter_group, muzzle_autogun_headhunter)

local autogun_braced_group = {custom_selection_group = "autogun_braced"}
local muzzle_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_braced")
mod:merge_attachment_data(autogun_braced_group, muzzle_autogun_braced)

local suppressor_group = {custom_selection_group = "suppressors"}
local muzzle_suppressors = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_suppressors")
mod:merge_attachment_data(suppressor_group, muzzle_suppressors)

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

local attachments = {
    dual_stubpistols_p1_m1 = {
        flashlight = flashlight_human,
        sight = table_merge_recursive_n(nil, sight_reflex, sight_scope),
        muzzle = table_merge_recursive_n(nil, muzzle_autogun_headhunter, muzzle_autogun_braced, muzzle_suppressors),
    },
}

attachments.dual_stubpistols_p1_m2 = table_clone(attachments.dual_stubpistols_p1_m1)
attachments.dual_stubpistols_p1_m3 = table_clone(attachments.dual_stubpistols_p1_m1)
attachments.dual_stubpistols_p1_m4 = table_clone(attachments.dual_stubpistols_p1_m1)

local attachment_slots = {
    dual_stubpistols_p1_m1 = {
        flashlight = {
            parent_slot = "left|right",
            default_path = _item_empty_trinket,
        },
        muzzle = {
            parent_slot = "left|right",
            default_path = _item_empty_trinket,
        },
    },
}

attachment_slots.dual_stubpistols_p1_m2 = table_clone(attachment_slots.dual_stubpistols_p1_m1)
attachment_slots.dual_stubpistols_p1_m3 = table_clone(attachment_slots.dual_stubpistols_p1_m1)
attachment_slots.dual_stubpistols_p1_m4 = table_clone(attachment_slots.dual_stubpistols_p1_m1)

local fixes = {
    dual_stubpistols_p1_m1 = {
        {attachment_slot = "flashlight",
            requirements = {
                flashlight = {
                    has = "query:dual_stubpistols_p1_m1,flashlight,extended_weapon_customization_base_additions,debug",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(.02, .215, .1),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(.5, .5, .5),
                    node = 1,
                },
            },
        },
        {attachment_slot = "muzzle",
            requirements = {
                muzzle = {
                    has = "query:dual_stubpistols_p1_m1,muzzle,extended_weapon_customization_base_additions,debug",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .285, .122),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(.5, .5, .5),
                    node = 1,
                },
            },
        },
    }
}

fixes.dual_stubpistols_p1_m2 = table_clone(fixes.dual_stubpistols_p1_m1)
fixes.dual_stubpistols_p1_m3 = table_clone(fixes.dual_stubpistols_p1_m1)
fixes.dual_stubpistols_p1_m4 = table_clone(fixes.dual_stubpistols_p1_m1)

return {
    fixes = fixes,
    attachments = attachments,
    attachment_slots = attachment_slots,
}
