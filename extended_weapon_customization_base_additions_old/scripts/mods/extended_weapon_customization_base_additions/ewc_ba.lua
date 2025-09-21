local mod = get_mod("ewc_ba")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    -- local unit = Unit
    local pairs = pairs
    local table = table
    local vector3_box = Vector3Box
    local table_clone = table.clone
    local table_merge_recursive = table.merge_recursive
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local extended_weapon_customization_plugin = {
    attachments = {},
    fixes = {},
    kitbashs = {},
}

local weapons_folder = "extended_weapon_customization_base_additions/scripts/mods/ewc_ba/weapons/"
local load_weapons = {
    "autogun_p1_m1",
}

for _, file_name in pairs(load_weapons) do
    local data = mod:io_dofile(weapons_folder..file_name)

    if data then

        if data.attachments then
            extended_weapon_customization_plugin.attachments = table_merge_recursive(extended_weapon_customization_plugin.attachments, data.attachments)
        end

        if data.fixes then
            extended_weapon_customization_plugin.fixes = table_merge_recursive(extended_weapon_customization_plugin.fixes, data.fixes)
        end

        if data.kitbashs then
            extended_weapon_customization_plugin.kitbashs = table_merge_recursive(extended_weapon_customization_plugin.kitbashs, data.kitbashs)
        end

    end

end

mod.extended_weapon_customization_plugin = extended_weapon_customization_plugin
