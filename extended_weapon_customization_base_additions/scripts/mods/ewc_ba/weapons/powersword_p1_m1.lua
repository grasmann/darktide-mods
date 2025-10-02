local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local blade_laser_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/blade_laser_human")

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
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_melee = _item.."/melee"
local _item_ranged = _item.."/ranged"

local attachments = {
    powersword_p1_m1 = {
        blade = blade_laser_human,
    },
}

attachments.powersword_p1_m3 = table_clone_safe(attachments.powersword_p1_m1)
attachments.powersword_p1_m2 = table_clone_safe(attachments.powersword_p1_m1)

local fixes = {
    powersword_p1_m1 = {
        -- {attachment_slot = "tank",
        --     fix = {
        --         offset = {
        --             node = 1,
        --             position = vector3_box(0, -.02, .08),
        --             rotation = vector3_box(90, 180, 180),
        --             scale = vector3_box(.65, .65, .65),
        --         },
        --     },
        -- },
    },
}

fixes.powersword_p1_m3 = table_clone_safe(fixes.powersword_p1_m1)
fixes.powersword_p1_m2 = table_clone_safe(fixes.powersword_p1_m1)

return {
    attachments = attachments,
    fixes = fixes,
}
