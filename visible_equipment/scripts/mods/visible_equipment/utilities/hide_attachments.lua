local mod = get_mod("visible_equipment")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local weapons_folder = "visible_equipment/scripts/mods/visible_equipment/weapons/"
local shotpistol_shield_p1_m1 = mod:io_dofile(weapons_folder.."shotpistol_shield_p1_m1")
local stubrevolver_p1_m1 = mod:io_dofile(weapons_folder.."stubrevolver_p1_m1")
local shotgun_p1_m1 = mod:io_dofile(weapons_folder.."shotgun_p1_m1")
local shotgun_p2_m1 = mod:io_dofile(weapons_folder.."shotgun_p2_m1")
local shotgun_p4_m1 = mod:io_dofile(weapons_folder.."shotgun_p4_m1")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local table = table
    -- local vector3 = Vector3
    -- local vector3_box = Vector3Box
    -- local vector3_zero = vector3.zero
    local table_clone_safe = table.clone_safe
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local hide_attachments = {
    shotpistol_shield_p1_m1 = table_clone_safe(shotpistol_shield_p1_m1.hide_attachments),
    stubrevolver_p1_m1 = table_clone_safe(stubrevolver_p1_m1.hide_attachments),
    shotgun_p1_m1 = table_clone_safe(shotgun_p1_m1.hide_attachments),
    shotgun_p2_m1 = table_clone_safe(shotgun_p2_m1.hide_attachments),
    shotgun_p4_m1 = table_clone_safe(shotgun_p4_m1.hide_attachments),
}

--#region Copies
    --#region Ogryn melee
        -- momentum.ogryn_pickaxe_2h_p1_m2 = table_clone_safe(momentum.ogryn_pickaxe_2h_p1_m1)
        -- momentum.ogryn_pickaxe_2h_p1_m3 = table_clone_safe(momentum.ogryn_pickaxe_2h_p1_m1)
    --#endregion
    --#region Ogryn ranged
        -- momentum.ogryn_rippergun_p1_m2 = table_clone_safe(momentum.ogryn_rippergun_p1_m1)
		-- momentum.ogryn_rippergun_p1_m3 = table_clone_safe(momentum.ogryn_rippergun_p1_m1)
        -- momentum.ogryn_thumper_p1_m2 = table_clone_safe(momentum.ogryn_thumper_p1_m1)
    --#endregion
    --#region Human ranged
        -- momentum.forcestaff_p2_m1 = table_clone_safe(momentum.forcestaff_p1_m1)
        -- momentum.forcestaff_p3_m1 = table_clone_safe(momentum.forcestaff_p1_m1)
        -- momentum.forcestaff_p4_m1 = table_clone_safe(momentum.forcestaff_p1_m1)
        hide_attachments.stubrevolver_p1_m3 = table_clone_safe(hide_attachments.stubrevolver_p1_m1)
        hide_attachments.stubrevolver_p1_m2 = table_clone_safe(hide_attachments.stubrevolver_p1_m1)
        hide_attachments.shotgun_p1_m2 = table_clone_safe(hide_attachments.shotgun_p1_m1)
        hide_attachments.shotgun_p1_m3 = table_clone_safe(hide_attachments.shotgun_p1_m1)
        hide_attachments.shotgun_p4_m2 = table_clone_safe(hide_attachments.shotgun_p4_m1)
        hide_attachments.shotgun_p4_m3 = table_clone_safe(hide_attachments.shotgun_p4_m1)
    --#endregion
--#endregion

return hide_attachments