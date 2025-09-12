local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local pairs = pairs
    local table = table
    local vector3 = Vector3
    local vector3_box = Vector3Box
    local vector3_one = vector3.one
    local vector3_zero = vector3.zero
    local table_clone_safe = table.clone_safe
--#endregion

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

-- local breed_folder = "visible_equipment/scripts/mods/visible_equipment/breeds/"
-- local ogryn = mod:io_dofile(breed_folder.."ogryn")
-- local human = mod:io_dofile(breed_folder.."human")
local weapons_folder = "extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/"
local chainsword_2h_p1_m1 = mod:io_dofile(weapons_folder.."chainsword_2h_p1_m1")
local boltpistol_p1_m1 = mod:io_dofile(weapons_folder.."boltpistol_p1_m1")
local autopistol_p1_m1 = mod:io_dofile(weapons_folder.."autopistol_p1_m1")
local combataxe_p3_m1 = mod:io_dofile(weapons_folder.."combataxe_p3_m1")
local chainaxe_p1_m1 = mod:io_dofile(weapons_folder.."chainaxe_p1_m1")
local autogun_p1_m1 = mod:io_dofile(weapons_folder.."autogun_p1_m1")
local bolter_p1_m1 = mod:io_dofile(weapons_folder.."bolter_p1_m1")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local attachments = {
    -- [BREED_HUMAN] = human.offsets,
    -- [BREED_OGRYN] = ogryn.offsets,
    chainsword_2h_p1_m1 = chainsword_2h_p1_m1.attachments,
    autopistol_p1_m1 = autopistol_p1_m1.attachments,
    boltpistol_p1_m1 = boltpistol_p1_m1.attachments,
    combataxe_p3_m1 = combataxe_p3_m1.attachments,
    chainaxe_p1_m1 = chainaxe_p1_m1.attachments,
    autogun_p1_m1 = autogun_p1_m1.attachments,
    bolter_p1_m1 = bolter_p1_m1.attachments,
}

--#region Copies
    --#region Ogryn melee
        -- offsets.ogryn_combatblade_p1_m2 = table_clone_safe(offsets.ogryn_combatblade_p1_m1)
        -- offsets.ogryn_combatblade_p1_m3 = table_clone_safe(offsets.ogryn_combatblade_p1_m1)
        -- offsets.ogryn_pickaxe_2h_p1_m2 = table_clone_safe(offsets.ogryn_pickaxe_2h_p1_m1)
        -- offsets.ogryn_pickaxe_2h_p1_m3 = table_clone_safe(offsets.ogryn_pickaxe_2h_p1_m1)
        -- offsets.ogryn_powermaul_p1_m2 = table_clone_safe(offsets.ogryn_powermaul_p1_m1)
		-- offsets.ogryn_powermaul_p1_m3 = table_clone_safe(offsets.ogryn_powermaul_p1_m1)
        -- offsets.ogryn_club_p2_m2 = table_clone_safe(offsets.ogryn_club_p2_m1)
		-- offsets.ogryn_club_p1_m3 = table_clone_safe(offsets.ogryn_club_p1_m1)
		-- offsets.ogryn_club_p2_m3 = table_clone_safe(offsets.ogryn_club_p2_m1)
        -- offsets.ogryn_club_p1_m2 = table_clone_safe(offsets.ogryn_club_p1_m1)
    --#endregion
    --#region Ogryn ranged
        -- offsets.ogryn_heavystubber_p1_m2 = table_clone_safe(offsets.ogryn_heavystubber_p1_m1)
		-- offsets.ogryn_heavystubber_p1_m3 = table_clone_safe(offsets.ogryn_heavystubber_p1_m1)
        -- offsets.ogryn_heavystubber_p2_m2 = table_clone_safe(offsets.ogryn_heavystubber_p2_m1)
		-- offsets.ogryn_heavystubber_p2_m3 = table_clone_safe(offsets.ogryn_heavystubber_p2_m1)
        -- offsets.ogryn_rippergun_p1_m2 = table_clone_safe(offsets.ogryn_rippergun_p1_m1)
		-- offsets.ogryn_rippergun_p1_m3 = table_clone_safe(offsets.ogryn_rippergun_p1_m1)
        -- offsets.ogryn_thumper_p1_m2 = table_clone_safe(offsets.ogryn_thumper_p1_m1)
    --#endregion
    --#region Human melee
        -- offsets.powermaul_shield_p1_m2 = table_clone_safe(offsets.powermaul_shield_p1_m1)
        -- offsets.thunderhammer_2h_p1_m2 = table_clone_safe(offsets.thunderhammer_2h_p1_m1)
        -- offsets.forcesword_2h_p1_m2 = table_clone_safe(offsets.forcesword_2h_p1_m1)
        attachments.chainsword_2h_p1_m2 = table_clone_safe(attachments.chainsword_2h_p1_m1)
        -- offsets.powersword_2h_p1_m2 = table_clone_safe(offsets.powersword_2h_p1_m1)
        -- offsets.combatknife_p1_m2 = table_clone_safe(offsets.combatknife_p1_m1)
        -- offsets.combatsword_p1_m2 = table_clone_safe(offsets.combatsword_p1_m1)
        -- offsets.combatsword_p2_m2 = table_clone_safe(offsets.combatsword_p2_m1)
        -- offsets.combatsword_p3_m2 = table_clone_safe(offsets.combatsword_p3_m1)
        -- offsets.combatsword_p1_m3 = table_clone_safe(offsets.combatsword_p1_m1)
		-- offsets.combatsword_p2_m3 = table_clone_safe(offsets.combatsword_p2_m1)
		-- offsets.combatsword_p3_m3 = table_clone_safe(offsets.combatsword_p3_m1)
		-- offsets.forcesword_p1_m3 = table_clone_safe(offsets.forcesword_p1_m1)
        -- offsets.powersword_p1_m3 = table_clone_safe(offsets.powersword_p1_m1)
        -- offsets.powersword_p1_m2 = table_clone_safe(offsets.powersword_p1_m1)
        -- offsets.chainsword_p1_m2 = table_clone_safe(offsets.chainsword_p1_m1)
        -- offsets.forcesword_p1_m2 = table_clone_safe(offsets.forcesword_p1_m1)
        -- offsets.combataxe_p1_m2 = table_clone_safe(offsets.combataxe_p1_m1)
        -- offsets.combataxe_p2_m2 = table_clone_safe(offsets.combataxe_p2_m1)
        -- offsets.combataxe_p2_m3 = table_clone_safe(offsets.combataxe_p2_m1)
        attachments.combataxe_p3_m2 = table_clone_safe(attachments.combataxe_p3_m1)
        attachments.combataxe_p3_m3 = table_clone_safe(attachments.combataxe_p3_m1)
        -- offsets.powermaul_p1_m2 = table_clone_safe(offsets.powermaul_p1_m1)
		-- offsets.combataxe_p1_m3 = table_clone_safe(offsets.combataxe_p1_m1)
    --#endregion
    --#region Human ranged
        -- offsets.stubrevolver_p1_m3 = table_clone_safe(offsets.stubrevolver_p1_m1)
        -- offsets.stubrevolver_p1_m2 = table_clone_safe(offsets.stubrevolver_p1_m1)
        -- offsets.forcestaff_p2_m1 = table_clone_safe(offsets.forcestaff_p1_m1)
        -- offsets.forcestaff_p3_m1 = table_clone_safe(offsets.forcestaff_p1_m1)
        -- offsets.forcestaff_p4_m1 = table_clone_safe(offsets.forcestaff_p1_m1)
        -- offsets.laspistol_p1_m2 = table_clone_safe(offsets.laspistol_p1_m1)
        -- offsets.laspistol_p1_m3 = table_clone_safe(offsets.laspistol_p1_m1)
        attachments.autogun_p1_m2 = table_clone_safe(attachments.autogun_p1_m1)
        attachments.autogun_p1_m3 = table_clone_safe(attachments.autogun_p1_m1)
        attachments.autogun_p2_m1 = table_clone_safe(attachments.autogun_p1_m1)
        attachments.autogun_p2_m2 = table_clone_safe(attachments.autogun_p1_m1)
        attachments.autogun_p2_m3 = table_clone_safe(attachments.autogun_p1_m1)
        attachments.autogun_p3_m1 = table_clone_safe(attachments.autogun_p1_m1)
        attachments.autogun_p3_m2 = table_clone_safe(attachments.autogun_p1_m1)
        attachments.autogun_p3_m3 = table_clone_safe(attachments.autogun_p1_m1)
        -- offsets.shotgun_p1_m2 = table_clone_safe(offsets.shotgun_p1_m1)
        -- offsets.shotgun_p1_m3 = table_clone_safe(offsets.shotgun_p1_m1)
        -- offsets.shotgun_p4_m2 = table_clone_safe(offsets.shotgun_p4_m1)
        -- offsets.shotgun_p4_m3 = table_clone_safe(offsets.shotgun_p4_m1)
        attachments.bolter_p1_m2 = table_clone_safe(attachments.bolter_p1_m1)
        attachments.bolter_p1_m3 = table_clone_safe(attachments.bolter_p1_m1)
        -- offsets.lasgun_p1_m2 = table_clone_safe(offsets.lasgun_p1_m1)
        -- offsets.lasgun_p2_m2 = table_clone_safe(offsets.lasgun_p2_m1)
        -- offsets.lasgun_p2_m3 = table_clone_safe(offsets.lasgun_p2_m1)
        -- offsets.lasgun_p3_m2 = table_clone_safe(offsets.lasgun_p3_m1)
        -- offsets.lasgun_p3_m3 = table_clone_safe(offsets.lasgun_p3_m1)
		-- offsets.lasgun_p1_m3 = table_clone_safe(offsets.lasgun_p1_m1)
    --#endregion
--#endregion

local fixes = {
    -- [BREED_HUMAN] = human.fixes,
    -- [BREED_OGRYN] = ogryn.fixes,
    chainsword_2h_p1_m1 = chainsword_2h_p1_m1.fixes,
    autopistol_p1_m1 = autopistol_p1_m1.fixes,
    boltpistol_p1_m1 = boltpistol_p1_m1.fixes,
    combataxe_p3_m1 = combataxe_p3_m1.fixes,
    chainaxe_p1_m1 = chainaxe_p1_m1.fixes,
    autogun_p1_m1 = autogun_p1_m1.fixes,
    bolter_p1_m1 = bolter_p1_m1.fixes,
}

--#region Copies
    --#region Ogryn melee
        -- offsets.ogryn_combatblade_p1_m2 = table_clone_safe(offsets.ogryn_combatblade_p1_m1)
        -- offsets.ogryn_combatblade_p1_m3 = table_clone_safe(offsets.ogryn_combatblade_p1_m1)
        -- offsets.ogryn_pickaxe_2h_p1_m2 = table_clone_safe(offsets.ogryn_pickaxe_2h_p1_m1)
        -- offsets.ogryn_pickaxe_2h_p1_m3 = table_clone_safe(offsets.ogryn_pickaxe_2h_p1_m1)
        -- offsets.ogryn_powermaul_p1_m2 = table_clone_safe(offsets.ogryn_powermaul_p1_m1)
		-- offsets.ogryn_powermaul_p1_m3 = table_clone_safe(offsets.ogryn_powermaul_p1_m1)
        -- offsets.ogryn_club_p2_m2 = table_clone_safe(offsets.ogryn_club_p2_m1)
		-- offsets.ogryn_club_p1_m3 = table_clone_safe(offsets.ogryn_club_p1_m1)
		-- offsets.ogryn_club_p2_m3 = table_clone_safe(offsets.ogryn_club_p2_m1)
        -- offsets.ogryn_club_p1_m2 = table_clone_safe(offsets.ogryn_club_p1_m1)
    --#endregion
    --#region Ogryn ranged
        -- offsets.ogryn_heavystubber_p1_m2 = table_clone_safe(offsets.ogryn_heavystubber_p1_m1)
		-- offsets.ogryn_heavystubber_p1_m3 = table_clone_safe(offsets.ogryn_heavystubber_p1_m1)
        -- offsets.ogryn_heavystubber_p2_m2 = table_clone_safe(offsets.ogryn_heavystubber_p2_m1)
		-- offsets.ogryn_heavystubber_p2_m3 = table_clone_safe(offsets.ogryn_heavystubber_p2_m1)
        -- offsets.ogryn_rippergun_p1_m2 = table_clone_safe(offsets.ogryn_rippergun_p1_m1)
		-- offsets.ogryn_rippergun_p1_m3 = table_clone_safe(offsets.ogryn_rippergun_p1_m1)
        -- offsets.ogryn_thumper_p1_m2 = table_clone_safe(offsets.ogryn_thumper_p1_m1)
    --#endregion
    --#region Human melee
        -- offsets.powermaul_shield_p1_m2 = table_clone_safe(offsets.powermaul_shield_p1_m1)
        -- offsets.thunderhammer_2h_p1_m2 = table_clone_safe(offsets.thunderhammer_2h_p1_m1)
        -- offsets.forcesword_2h_p1_m2 = table_clone_safe(offsets.forcesword_2h_p1_m1)
        fixes.chainsword_2h_p1_m2 = table_clone_safe(fixes.chainsword_2h_p1_m1)
        -- offsets.powersword_2h_p1_m2 = table_clone_safe(offsets.powersword_2h_p1_m1)
        -- offsets.combatknife_p1_m2 = table_clone_safe(offsets.combatknife_p1_m1)
        -- offsets.combatsword_p1_m2 = table_clone_safe(offsets.combatsword_p1_m1)
        -- offsets.combatsword_p2_m2 = table_clone_safe(offsets.combatsword_p2_m1)
        -- offsets.combatsword_p3_m2 = table_clone_safe(offsets.combatsword_p3_m1)
        -- offsets.combatsword_p1_m3 = table_clone_safe(offsets.combatsword_p1_m1)
		-- offsets.combatsword_p2_m3 = table_clone_safe(offsets.combatsword_p2_m1)
		-- offsets.combatsword_p3_m3 = table_clone_safe(offsets.combatsword_p3_m1)
		-- offsets.forcesword_p1_m3 = table_clone_safe(offsets.forcesword_p1_m1)
        -- offsets.powersword_p1_m3 = table_clone_safe(offsets.powersword_p1_m1)
        -- offsets.powersword_p1_m2 = table_clone_safe(offsets.powersword_p1_m1)
        -- offsets.chainsword_p1_m2 = table_clone_safe(offsets.chainsword_p1_m1)
        -- offsets.forcesword_p1_m2 = table_clone_safe(offsets.forcesword_p1_m1)
        -- offsets.combataxe_p1_m2 = table_clone_safe(offsets.combataxe_p1_m1)
        -- offsets.combataxe_p2_m2 = table_clone_safe(offsets.combataxe_p2_m1)
        -- offsets.combataxe_p2_m3 = table_clone_safe(offsets.combataxe_p2_m1)
        fixes.combataxe_p3_m2 = table_clone_safe(fixes.combataxe_p3_m1)
        fixes.combataxe_p3_m3 = table_clone_safe(fixes.combataxe_p3_m1)
        -- offsets.powermaul_p1_m2 = table_clone_safe(offsets.powermaul_p1_m1)
		-- offsets.combataxe_p1_m3 = table_clone_safe(offsets.combataxe_p1_m1)
    --#endregion
    --#region Human ranged
        -- offsets.stubrevolver_p1_m3 = table_clone_safe(offsets.stubrevolver_p1_m1)
        -- offsets.stubrevolver_p1_m2 = table_clone_safe(offsets.stubrevolver_p1_m1)
        -- offsets.forcestaff_p2_m1 = table_clone_safe(offsets.forcestaff_p1_m1)
        -- offsets.forcestaff_p3_m1 = table_clone_safe(offsets.forcestaff_p1_m1)
        -- offsets.forcestaff_p4_m1 = table_clone_safe(offsets.forcestaff_p1_m1)
        -- offsets.laspistol_p1_m2 = table_clone_safe(offsets.laspistol_p1_m1)
        -- offsets.laspistol_p1_m3 = table_clone_safe(offsets.laspistol_p1_m1)
        fixes.autogun_p1_m2 = table_clone_safe(fixes.autogun_p1_m1)
        fixes.autogun_p1_m3 = table_clone_safe(fixes.autogun_p1_m1)
        fixes.autogun_p2_m1 = table_clone_safe(fixes.autogun_p1_m1)
        fixes.autogun_p2_m2 = table_clone_safe(fixes.autogun_p1_m1)
        fixes.autogun_p2_m3 = table_clone_safe(fixes.autogun_p1_m1)
        fixes.autogun_p3_m1 = table_clone_safe(fixes.autogun_p1_m1)
        fixes.autogun_p3_m2 = table_clone_safe(fixes.autogun_p1_m1)
        fixes.autogun_p3_m3 = table_clone_safe(fixes.autogun_p1_m1)
        -- offsets.shotgun_p1_m2 = table_clone_safe(offsets.shotgun_p1_m1)
        -- offsets.shotgun_p1_m3 = table_clone_safe(offsets.shotgun_p1_m1)
        -- offsets.shotgun_p4_m2 = table_clone_safe(offsets.shotgun_p4_m1)
        -- offsets.shotgun_p4_m3 = table_clone_safe(offsets.shotgun_p4_m1)
        fixes.bolter_p1_m2 = table_clone_safe(fixes.bolter_p1_m1)
        fixes.bolter_p1_m3 = table_clone_safe(fixes.bolter_p1_m1)
        -- offsets.lasgun_p1_m2 = table_clone_safe(offsets.lasgun_p1_m1)
        -- offsets.lasgun_p2_m2 = table_clone_safe(offsets.lasgun_p2_m1)
        -- offsets.lasgun_p2_m3 = table_clone_safe(offsets.lasgun_p2_m1)
        -- offsets.lasgun_p3_m2 = table_clone_safe(offsets.lasgun_p3_m1)
        -- offsets.lasgun_p3_m3 = table_clone_safe(offsets.lasgun_p3_m1)
		-- offsets.lasgun_p1_m3 = table_clone_safe(offsets.lasgun_p1_m1)
    --#endregion
--#endregion

local attachment_slots = {
    chainsword_2h_p1_m1 = chainsword_2h_p1_m1.attachment_slots,
    autopistol_p1_m1 = autopistol_p1_m1.attachment_slots,
    boltpistol_p1_m1 = boltpistol_p1_m1.attachment_slots,
    combataxe_p3_m1 = combataxe_p3_m1.attachment_slots,
    chainaxe_p1_m1 = chainaxe_p1_m1.attachment_slots,
    autogun_p1_m1 = autogun_p1_m1.attachment_slots,
    bolter_p1_m1 = bolter_p1_m1.attachment_slots,
}

--#region Copies
    --#region Ogryn melee
        -- offsets.ogryn_combatblade_p1_m2 = table_clone_safe(offsets.ogryn_combatblade_p1_m1)
        -- offsets.ogryn_combatblade_p1_m3 = table_clone_safe(offsets.ogryn_combatblade_p1_m1)
        -- offsets.ogryn_pickaxe_2h_p1_m2 = table_clone_safe(offsets.ogryn_pickaxe_2h_p1_m1)
        -- offsets.ogryn_pickaxe_2h_p1_m3 = table_clone_safe(offsets.ogryn_pickaxe_2h_p1_m1)
        -- offsets.ogryn_powermaul_p1_m2 = table_clone_safe(offsets.ogryn_powermaul_p1_m1)
		-- offsets.ogryn_powermaul_p1_m3 = table_clone_safe(offsets.ogryn_powermaul_p1_m1)
        -- offsets.ogryn_club_p2_m2 = table_clone_safe(offsets.ogryn_club_p2_m1)
		-- offsets.ogryn_club_p1_m3 = table_clone_safe(offsets.ogryn_club_p1_m1)
		-- offsets.ogryn_club_p2_m3 = table_clone_safe(offsets.ogryn_club_p2_m1)
        -- offsets.ogryn_club_p1_m2 = table_clone_safe(offsets.ogryn_club_p1_m1)
    --#endregion
    --#region Ogryn ranged
        -- offsets.ogryn_heavystubber_p1_m2 = table_clone_safe(offsets.ogryn_heavystubber_p1_m1)
		-- offsets.ogryn_heavystubber_p1_m3 = table_clone_safe(offsets.ogryn_heavystubber_p1_m1)
        -- offsets.ogryn_heavystubber_p2_m2 = table_clone_safe(offsets.ogryn_heavystubber_p2_m1)
		-- offsets.ogryn_heavystubber_p2_m3 = table_clone_safe(offsets.ogryn_heavystubber_p2_m1)
        -- offsets.ogryn_rippergun_p1_m2 = table_clone_safe(offsets.ogryn_rippergun_p1_m1)
		-- offsets.ogryn_rippergun_p1_m3 = table_clone_safe(offsets.ogryn_rippergun_p1_m1)
        -- offsets.ogryn_thumper_p1_m2 = table_clone_safe(offsets.ogryn_thumper_p1_m1)
    --#endregion
    --#region Human melee
        -- offsets.powermaul_shield_p1_m2 = table_clone_safe(offsets.powermaul_shield_p1_m1)
        -- offsets.thunderhammer_2h_p1_m2 = table_clone_safe(offsets.thunderhammer_2h_p1_m1)
        -- offsets.forcesword_2h_p1_m2 = table_clone_safe(offsets.forcesword_2h_p1_m1)
        attachment_slots.chainsword_2h_p1_m2 = table_clone_safe(attachment_slots.chainsword_2h_p1_m1)
        -- offsets.powersword_2h_p1_m2 = table_clone_safe(offsets.powersword_2h_p1_m1)
        -- offsets.combatknife_p1_m2 = table_clone_safe(offsets.combatknife_p1_m1)
        -- offsets.combatsword_p1_m2 = table_clone_safe(offsets.combatsword_p1_m1)
        -- offsets.combatsword_p2_m2 = table_clone_safe(offsets.combatsword_p2_m1)
        -- offsets.combatsword_p3_m2 = table_clone_safe(offsets.combatsword_p3_m1)
        -- offsets.combatsword_p1_m3 = table_clone_safe(offsets.combatsword_p1_m1)
		-- offsets.combatsword_p2_m3 = table_clone_safe(offsets.combatsword_p2_m1)
		-- offsets.combatsword_p3_m3 = table_clone_safe(offsets.combatsword_p3_m1)
		-- offsets.forcesword_p1_m3 = table_clone_safe(offsets.forcesword_p1_m1)
        -- offsets.powersword_p1_m3 = table_clone_safe(offsets.powersword_p1_m1)
        -- offsets.powersword_p1_m2 = table_clone_safe(offsets.powersword_p1_m1)
        -- offsets.chainsword_p1_m2 = table_clone_safe(offsets.chainsword_p1_m1)
        -- offsets.forcesword_p1_m2 = table_clone_safe(offsets.forcesword_p1_m1)
        -- offsets.combataxe_p1_m2 = table_clone_safe(offsets.combataxe_p1_m1)
        -- offsets.combataxe_p2_m2 = table_clone_safe(offsets.combataxe_p2_m1)
        -- offsets.combataxe_p2_m3 = table_clone_safe(offsets.combataxe_p2_m1)
        attachment_slots.combataxe_p3_m2 = table_clone_safe(attachment_slots.combataxe_p3_m1)
        attachment_slots.combataxe_p3_m3 = table_clone_safe(attachment_slots.combataxe_p3_m1)
        -- offsets.powermaul_p1_m2 = table_clone_safe(offsets.powermaul_p1_m1)
		-- offsets.combataxe_p1_m3 = table_clone_safe(offsets.combataxe_p1_m1)
    --#endregion
    --#region Human ranged
        -- offsets.stubrevolver_p1_m3 = table_clone_safe(offsets.stubrevolver_p1_m1)
        -- offsets.stubrevolver_p1_m2 = table_clone_safe(offsets.stubrevolver_p1_m1)
        -- offsets.forcestaff_p2_m1 = table_clone_safe(offsets.forcestaff_p1_m1)
        -- offsets.forcestaff_p3_m1 = table_clone_safe(offsets.forcestaff_p1_m1)
        -- offsets.forcestaff_p4_m1 = table_clone_safe(offsets.forcestaff_p1_m1)
        -- offsets.laspistol_p1_m2 = table_clone_safe(offsets.laspistol_p1_m1)
        -- offsets.laspistol_p1_m3 = table_clone_safe(offsets.laspistol_p1_m1)
        attachment_slots.autogun_p1_m2 = table_clone_safe(attachment_slots.autogun_p1_m1)
        attachment_slots.autogun_p1_m3 = table_clone_safe(attachment_slots.autogun_p1_m1)
        attachment_slots.autogun_p2_m1 = table_clone_safe(attachment_slots.autogun_p1_m1)
        attachment_slots.autogun_p2_m2 = table_clone_safe(attachment_slots.autogun_p1_m1)
        attachment_slots.autogun_p2_m3 = table_clone_safe(attachment_slots.autogun_p1_m1)
        attachment_slots.autogun_p3_m1 = table_clone_safe(attachment_slots.autogun_p1_m1)
        attachment_slots.autogun_p3_m2 = table_clone_safe(attachment_slots.autogun_p1_m1)
        attachment_slots.autogun_p3_m3 = table_clone_safe(attachment_slots.autogun_p1_m1)
        -- offsets.shotgun_p1_m2 = table_clone_safe(offsets.shotgun_p1_m1)
        -- offsets.shotgun_p1_m3 = table_clone_safe(offsets.shotgun_p1_m1)
        -- offsets.shotgun_p4_m2 = table_clone_safe(offsets.shotgun_p4_m1)
        -- offsets.shotgun_p4_m3 = table_clone_safe(offsets.shotgun_p4_m1)
        attachment_slots.bolter_p1_m2 = table_clone_safe(attachment_slots.bolter_p1_m1)
        attachment_slots.bolter_p1_m3 = table_clone_safe(attachment_slots.bolter_p1_m1)
        -- offsets.lasgun_p1_m2 = table_clone_safe(offsets.lasgun_p1_m1)
        -- offsets.lasgun_p2_m2 = table_clone_safe(offsets.lasgun_p2_m1)
        -- offsets.lasgun_p2_m3 = table_clone_safe(offsets.lasgun_p2_m1)
        -- offsets.lasgun_p3_m2 = table_clone_safe(offsets.lasgun_p3_m1)
        -- offsets.lasgun_p3_m3 = table_clone_safe(offsets.lasgun_p3_m1)
		-- offsets.lasgun_p1_m3 = table_clone_safe(offsets.lasgun_p1_m1)
    --#endregion
--#endregion

local attachment_data_by_item_string = {}
local attachment_name_by_item_string = {}

for weapon_template, attachments in pairs(attachments) do
    for attachment_slot, attachment_entires in pairs(attachments) do
        for attachment_name, attachment_data in pairs(attachment_entires) do
            attachment_data_by_item_string[attachment_data.replacement_path] = attachment_data
            attachment_name_by_item_string[attachment_data.replacement_path] = attachment_name
        end
    end
end

local attachment_data_by_attachment_name = {}

for weapon_template, attachments in pairs(attachments) do
    for attachment_slot, attachment_entires in pairs(attachments) do
        for attachment_name, attachment_data in pairs(attachment_entires) do
            attachment_data_by_attachment_name[attachment_name] = attachment_data
        end
    end
end

return {
    fixes = fixes,
    attachments = attachments,
    attachment_slots = attachment_slots,
    attachment_data_by_item_string = attachment_data_by_item_string,
    attachment_name_by_item_string = attachment_name_by_item_string,
    attachment_data_by_attachment_name = attachment_data_by_attachment_name,
}
