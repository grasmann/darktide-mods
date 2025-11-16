local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local table = table
    local vector3 = Vector3
    local vector3_box = Vector3Box
    local vector3_zero = vector3.zero
    local table_merge_recursive_n = table.merge_recursive_n
--#endregion

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local barrel_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/barrel_autogun_headhunter")
local barrel_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/barrel_autogun_infantry")
local barrel_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/barrel_autogun_braced")

return table_merge_recursive_n(nil, barrel_autogun_infantry, barrel_autogun_braced, barrel_autogun_headhunter)
