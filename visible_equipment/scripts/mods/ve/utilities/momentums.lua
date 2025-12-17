local mod = get_mod("visible_equipment")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local breed_folder = "visible_equipment/scripts/mods/ve/breeds/"
local ogryn = mod:io_dofile(breed_folder.."ogryn")
local human = mod:io_dofile(breed_folder.."human")
local weapons_folder = "visible_equipment/scripts/mods/ve/weapons/"
local ogryn_powermaul_slabshield_p1_m1 = mod:io_dofile(weapons_folder.."ogryn_powermaul_slabshield_p1_m1")
local ogryn_heavystubber_p1_m1 = mod:io_dofile(weapons_folder.."ogryn_heavystubber_p1_m1")
local ogryn_heavystubber_p2_m1 = mod:io_dofile(weapons_folder.."ogryn_heavystubber_p2_m1")
local ogryn_combatblade_p1_m1 = mod:io_dofile(weapons_folder.."ogryn_combatblade_p1_m1")
local shotpistol_shield_p1_m1 = mod:io_dofile(weapons_folder.."shotpistol_shield_p1_m1")
local dual_stubpistols_p1_m1 = mod:io_dofile(weapons_folder.."dual_stubpistols_p1_m1")
local ogryn_pickaxe_2h_p1_m1 = mod:io_dofile(weapons_folder.."ogryn_pickaxe_2h_p1_m1")
local powermaul_shield_p1_m1 = mod:io_dofile(weapons_folder.."powermaul_shield_p1_m1")
local thunderhammer_2h_p1_m1 = mod:io_dofile(weapons_folder.."thunderhammer_2h_p1_m1")
local ogryn_powermaul_p1_m1 = mod:io_dofile(weapons_folder.."ogryn_powermaul_p1_m1")
local ogryn_rippergun_p1_m1 = mod:io_dofile(weapons_folder.."ogryn_rippergun_p1_m1")
local ogryn_gauntlet_p1_m1 = mod:io_dofile(weapons_folder.."ogryn_gauntlet_p1_m1")
local chainsword_2h_p1_m1 = mod:io_dofile(weapons_folder.."chainsword_2h_p1_m1")
local forcesword_2h_p1_m1 = mod:io_dofile(weapons_folder.."forcesword_2h_p1_m1")
local ogryn_thumper_p1_m1 = mod:io_dofile(weapons_folder.."ogryn_thumper_p1_m1")
local powersword_2h_p1_m1 = mod:io_dofile(weapons_folder.."powersword_2h_p1_m1")
local powermaul_2h_p1_m1 = mod:io_dofile(weapons_folder.."powermaul_2h_p1_m1")
local stubrevolver_p1_m1 = mod:io_dofile(weapons_folder.."stubrevolver_p1_m1")
local combatknife_p1_m1 = mod:io_dofile(weapons_folder.."combatknife_p1_m1")
local combatsword_p1_m1 = mod:io_dofile(weapons_folder.."combatsword_p1_m1")
local combatsword_p2_m1 = mod:io_dofile(weapons_folder.."combatsword_p2_m1")
local combatsword_p3_m1 = mod:io_dofile(weapons_folder.."combatsword_p3_m1")
local boltpistol_p1_m1 = mod:io_dofile(weapons_folder.."boltpistol_p1_m1")
local chainsword_p1_m1 = mod:io_dofile(weapons_folder.."chainsword_p1_m1")
local forcestaff_p1_m1 = mod:io_dofile(weapons_folder.."forcestaff_p1_m1")
local forcesword_p1_m1 = mod:io_dofile(weapons_folder.."forcesword_p1_m1")
local ogryn_club_p1_m1 = mod:io_dofile(weapons_folder.."ogryn_club_p1_m1")
local ogryn_club_p2_m1 = mod:io_dofile(weapons_folder.."ogryn_club_p2_m1")
local powersword_p1_m1 = mod:io_dofile(weapons_folder.."powersword_p1_m1")
local powersword_p2_m1 = mod:io_dofile(weapons_folder.."powersword_p2_m1")
local autopistol_p1_m1 = mod:io_dofile(weapons_folder.."autopistol_p1_m1")
local dual_shivs_p1_m1 = mod:io_dofile(weapons_folder.."dual_shivs_p1_m1")
local combataxe_p1_m1 = mod:io_dofile(weapons_folder.."combataxe_p1_m1")
local combataxe_p2_m1 = mod:io_dofile(weapons_folder.."combataxe_p2_m1")
local combataxe_p3_m1 = mod:io_dofile(weapons_folder.."combataxe_p3_m1")
local laspistol_p1_m1 = mod:io_dofile(weapons_folder.."laspistol_p1_m1")
local plasmagun_p1_m1 = mod:io_dofile(weapons_folder.."plasmagun_p1_m1")
local powermaul_p1_m1 = mod:io_dofile(weapons_folder.."powermaul_p1_m1")
local powermaul_p2_m1 = mod:io_dofile(weapons_folder.."powermaul_p2_m1")
local chainaxe_p1_m1 = mod:io_dofile(weapons_folder.."chainaxe_p1_m1")
local crowbar_p1_m1 = mod:io_dofile(weapons_folder.."crowbar_p1_m1")
local autogun_p1_m1 = mod:io_dofile(weapons_folder.."autogun_p1_m1")
local shotgun_p1_m1 = mod:io_dofile(weapons_folder.."shotgun_p1_m1")
local shotgun_p2_m1 = mod:io_dofile(weapons_folder.."shotgun_p2_m1")
local shotgun_p4_m1 = mod:io_dofile(weapons_folder.."shotgun_p4_m1")
local bolter_p1_m1 = mod:io_dofile(weapons_folder.."bolter_p1_m1")
local flamer_p1_m1 = mod:io_dofile(weapons_folder.."flamer_p1_m1")
local lasgun_p1_m1 = mod:io_dofile(weapons_folder.."lasgun_p1_m1")
local lasgun_p2_m1 = mod:io_dofile(weapons_folder.."lasgun_p2_m1")
local lasgun_p3_m1 = mod:io_dofile(weapons_folder.."lasgun_p3_m1")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local table = table
    local vector3 = Vector3
    local vector3_box = Vector3Box
    local vector3_zero = vector3.zero
    local table_clone_safe = table.clone_safe
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local BREED_HUMAN = "human"
local BREED_OGRYN = "ogryn"
local WEAPON_MELEE = "WEAPON_MELEE"
local WEAPON_RANGED = "WEAPON_RANGED"

local momentum = {
    ogryn_powermaul_slabshield_p1_m1 = table_clone_safe(ogryn_powermaul_slabshield_p1_m1.momentum),
    ogryn_heavystubber_p1_m1 = table_clone_safe(ogryn_heavystubber_p1_m1.momentum),
    ogryn_heavystubber_p2_m1 = table_clone_safe(ogryn_heavystubber_p2_m1.momentum),
    ogryn_combatblade_p1_m1 = table_clone_safe(ogryn_combatblade_p1_m1.momentum),
    shotpistol_shield_p1_m1 = table_clone_safe(shotpistol_shield_p1_m1.momentum),
    dual_stubpistols_p1_m1 = table_clone_safe(dual_stubpistols_p1_m1.momentum),
    ogryn_pickaxe_2h_p1_m1 = table_clone_safe(ogryn_pickaxe_2h_p1_m1.momentum),
    powermaul_shield_p1_m1 = table_clone_safe(powermaul_shield_p1_m1.momentum),
    thunderhammer_2h_p1_m1 = table_clone_safe(thunderhammer_2h_p1_m1.momentum),
    ogryn_powermaul_p1_m1 = table_clone_safe(ogryn_powermaul_p1_m1.momentum),
    ogryn_rippergun_p1_m1 = table_clone_safe(ogryn_rippergun_p1_m1.momentum),
    ogryn_gauntlet_p1_m1 = table_clone_safe(ogryn_gauntlet_p1_m1.momentum),
    chainsword_2h_p1_m1 = table_clone_safe(chainsword_2h_p1_m1.momentum),
    forcesword_2h_p1_m1 = table_clone_safe(forcesword_2h_p1_m1.momentum),
    ogryn_thumper_p1_m1 = table_clone_safe(ogryn_thumper_p1_m1.momentum),
    powersword_2h_p1_m1 = table_clone_safe(powersword_2h_p1_m1.momentum),
    powermaul_2h_p1_m1 = table_clone_safe(powermaul_2h_p1_m1.momentum),
    stubrevolver_p1_m1 = table_clone_safe(stubrevolver_p1_m1.momentum),
    combatknife_p1_m1 = table_clone_safe(combatknife_p1_m1.momentum),
    combatsword_p1_m1 = table_clone_safe(combatsword_p1_m1.momentum),
    combatsword_p2_m1 = table_clone_safe(combatsword_p2_m1.momentum),
    combatsword_p3_m1 = table_clone_safe(combatsword_p3_m1.momentum),
    boltpistol_p1_m1 = table_clone_safe(boltpistol_p1_m1.momentum),
    chainsword_p1_m1 = table_clone_safe(chainsword_p1_m1.momentum),
    forcestaff_p1_m1 = table_clone_safe(forcestaff_p1_m1.momentum),
    forcesword_p1_m1 = table_clone_safe(forcesword_p1_m1.momentum),
    ogryn_club_p1_m1 = table_clone_safe(ogryn_club_p1_m1.momentum),
    ogryn_club_p2_m1 = table_clone_safe(ogryn_club_p2_m1.momentum),
    powersword_p1_m1 = table_clone_safe(powersword_p1_m1.momentum),
    powersword_p2_m1 = table_clone_safe(powersword_p2_m1.momentum),
    autopistol_p1_m1 = table_clone_safe(autopistol_p1_m1.momentum),
    dual_shivs_p1_m1 = table_clone_safe(dual_shivs_p1_m1.momentum),
    combataxe_p1_m1 = table_clone_safe(combataxe_p1_m1.momentum),
    combataxe_p2_m1 = table_clone_safe(combataxe_p2_m1.momentum),
    combataxe_p3_m1 = table_clone_safe(combataxe_p3_m1.momentum),
    laspistol_p1_m1 = table_clone_safe(laspistol_p1_m1.momentum),
    plasmagun_p1_m1 = table_clone_safe(plasmagun_p1_m1.momentum),
    powermaul_p1_m1 = table_clone_safe(powermaul_p1_m1.momentum),
    powermaul_p2_m1 = table_clone_safe(powermaul_p2_m1.momentum),
    chainaxe_p1_m1 = table_clone_safe(chainaxe_p1_m1.momentum),
    crowbar_p1_m1 = table_clone_safe(crowbar_p1_m1.momentum),
    autogun_p1_m1 = table_clone_safe(autogun_p1_m1.momentum),
    shotgun_p1_m1 = table_clone_safe(shotgun_p1_m1.momentum),
    shotgun_p2_m1 = table_clone_safe(shotgun_p2_m1.momentum),
    shotgun_p4_m1 = table_clone_safe(shotgun_p4_m1.momentum),
    bolter_p1_m1 = table_clone_safe(bolter_p1_m1.momentum),
    flamer_p1_m1 = table_clone_safe(flamer_p1_m1.momentum),
    lasgun_p1_m1 = table_clone_safe(lasgun_p1_m1.momentum),
    lasgun_p2_m1 = table_clone_safe(lasgun_p2_m1.momentum),
    lasgun_p3_m1 = table_clone_safe(lasgun_p3_m1.momentum),
    [WEAPON_MELEE] = {
        right = {
            momentum = vector3_box(1, 0, -3),
        },
        left = {
            momentum = vector3_box(0, -3, -3),
        },
    },
    [WEAPON_RANGED] = {
        right = {
            momentum = vector3_box(1, 3, 0),
        },
        left = {
            momentum = vector3_box(0, -3, -3),
        },
    },
    default = {
        right = {
            momentum = vector3_box(1, 0, -3),
        },
        left = {
            momentum = vector3_box(0, -3, -3),
        },
    },
}

--#region Copies
    --#region Ogryn melee
        momentum.ogryn_combatblade_p1_m2 = table_clone_safe(momentum.ogryn_combatblade_p1_m1)
        momentum.ogryn_combatblade_p1_m3 = table_clone_safe(momentum.ogryn_combatblade_p1_m1)
        momentum.ogryn_pickaxe_2h_p1_m2 = table_clone_safe(momentum.ogryn_pickaxe_2h_p1_m1)
        momentum.ogryn_pickaxe_2h_p1_m3 = table_clone_safe(momentum.ogryn_pickaxe_2h_p1_m1)
        momentum.ogryn_powermaul_p1_m2 = table_clone_safe(momentum.ogryn_powermaul_p1_m1)
		momentum.ogryn_powermaul_p1_m3 = table_clone_safe(momentum.ogryn_powermaul_p1_m1)
        momentum.ogryn_club_p2_m2 = table_clone_safe(momentum.ogryn_club_p2_m1)
		momentum.ogryn_club_p1_m3 = table_clone_safe(momentum.ogryn_club_p1_m1)
		momentum.ogryn_club_p2_m3 = table_clone_safe(momentum.ogryn_club_p2_m1)
        momentum.ogryn_club_p1_m2 = table_clone_safe(momentum.ogryn_club_p1_m1)
                momentum.ogryn_combatblade_npc_01 = table_clone_safe(momentum.ogryn_combatblade_p1_m1)
                momentum.ogryn_powermaul_slabshield_npc_01 = table_clone_safe(momentum.ogryn_powermaul_slabshield_p1_m1)
    --#endregion
    --#region Ogryn ranged
        momentum.ogryn_heavystubber_p1_m2 = table_clone_safe(momentum.ogryn_heavystubber_p1_m1)
		momentum.ogryn_heavystubber_p1_m3 = table_clone_safe(momentum.ogryn_heavystubber_p1_m1)
        momentum.ogryn_heavystubber_p2_m2 = table_clone_safe(momentum.ogryn_heavystubber_p2_m1)
		momentum.ogryn_heavystubber_p2_m3 = table_clone_safe(momentum.ogryn_heavystubber_p2_m1)
        momentum.ogryn_rippergun_p1_m2 = table_clone_safe(momentum.ogryn_rippergun_p1_m1)
		momentum.ogryn_rippergun_p1_m3 = table_clone_safe(momentum.ogryn_rippergun_p1_m1)
        momentum.ogryn_thumper_p1_m2 = table_clone_safe(momentum.ogryn_thumper_p1_m1)
                momentum.ogryn_rippergun_npc_01 = table_clone_safe(momentum.ogryn_rippergun_p1_m1)
                momentum.ogryn_thumper_npc_01 = table_clone_safe(momentum.ogryn_thumper_p1_m1)
                momentum.ogryn_gauntlet_npc_01 = table_clone_safe(momentum.ogryn_gauntlet_p1_m1)
    --#endregion
    --#region Human melee
        momentum.dual_stubpistols_p1_m2 = table_clone_safe(momentum.dual_stubpistols_p1_m1)
        momentum.dual_stubpistols_p1_m3 = table_clone_safe(momentum.dual_stubpistols_p1_m1)
        momentum.dual_stubpistols_p1_m4 = table_clone_safe(momentum.dual_stubpistols_p1_m1)
        momentum.powermaul_shield_p1_m2 = table_clone_safe(momentum.powermaul_shield_p1_m1)
        momentum.thunderhammer_2h_p1_m2 = table_clone_safe(momentum.thunderhammer_2h_p1_m1)
        momentum.forcesword_2h_p1_m2 = table_clone_safe(momentum.forcesword_2h_p1_m1)
        momentum.chainsword_2h_p1_m2 = table_clone_safe(momentum.chainsword_2h_p1_m1)
        momentum.powersword_2h_p1_m2 = table_clone_safe(momentum.powersword_2h_p1_m1)
        momentum.combatknife_p1_m2 = table_clone_safe(momentum.combatknife_p1_m1)
        momentum.combatsword_p1_m2 = table_clone_safe(momentum.combatsword_p1_m1)
        momentum.combatsword_p2_m2 = table_clone_safe(momentum.combatsword_p2_m1)
        momentum.combatsword_p3_m2 = table_clone_safe(momentum.combatsword_p3_m1)
        momentum.combatsword_p1_m3 = table_clone_safe(momentum.combatsword_p1_m1)
		momentum.combatsword_p2_m3 = table_clone_safe(momentum.combatsword_p2_m1)
		momentum.combatsword_p3_m3 = table_clone_safe(momentum.combatsword_p3_m1)
		momentum.forcesword_p1_m3 = table_clone_safe(momentum.forcesword_p1_m1)
        momentum.powersword_p1_m3 = table_clone_safe(momentum.powersword_p1_m1)
        momentum.powersword_p1_m2 = table_clone_safe(momentum.powersword_p1_m1)
        momentum.powersword_p2_m2 = table_clone_safe(momentum.powersword_p2_m1)
        momentum.chainsword_p1_m2 = table_clone_safe(momentum.chainsword_p1_m1)
        momentum.forcesword_p1_m2 = table_clone_safe(momentum.forcesword_p1_m1)
        momentum.dual_shivs_p1_m2 = table_clone_safe(momentum.dual_shivs_p1_m1)
        momentum.dual_shivs_p1_m3 = table_clone_safe(momentum.dual_shivs_p1_m1)
        momentum.dual_shivs_p1_m4 = table_clone_safe(momentum.dual_shivs_p1_m1)
        momentum.combataxe_p1_m2 = table_clone_safe(momentum.combataxe_p1_m1)
        momentum.combataxe_p2_m2 = table_clone_safe(momentum.combataxe_p2_m1)
        momentum.combataxe_p2_m3 = table_clone_safe(momentum.combataxe_p2_m1)
        momentum.combataxe_p3_m2 = table_clone_safe(momentum.combataxe_p3_m1)
        momentum.combataxe_p3_m3 = table_clone_safe(momentum.combataxe_p3_m1)
        momentum.powermaul_p1_m2 = table_clone_safe(momentum.powermaul_p1_m1)
		momentum.combataxe_p1_m3 = table_clone_safe(momentum.combataxe_p1_m1)
        momentum.chainaxe_p1_m2 = table_clone_safe(momentum.chainaxe_p1_m1)
        momentum.crowbar_p1_m1 = table_clone_safe(momentum.crowbar_p1_m1)
        momentum.crowbar_p1_m2 = table_clone_safe(momentum.crowbar_p1_m1)
        momentum.crowbar_p1_m3 = table_clone_safe(momentum.crowbar_p1_m1)
        momentum.crowbar_p1_m4 = table_clone_safe(momentum.crowbar_p1_m1)
            momentum.bot_combataxe_linesman = table_clone_safe(momentum.combataxe_p1_m1)
            momentum.bot_combatsword_linesman_p1 = table_clone_safe(momentum.combatsword_p1_m1)
            momentum.bot_combatsword_linesman_p2 = table_clone_safe(momentum.combatsword_p2_m1)
                momentum.thunderhammer_d7_zealot_f = table_clone_safe(momentum.thunderhammer_2h_p1_m1)
                momentum.forcesword_npc_01 = table_clone_safe(momentum.forcesword_p1_m1)
                momentum.powersword_2h_npc_01 = table_clone_safe(momentum.powersword_p1_m1)
                momentum.chainsword_npc_01 = table_clone_safe(momentum.chainsword_p1_m1)
    --#endregion
    --#region Human ranged
        momentum.stubrevolver_p1_m3 = table_clone_safe(momentum.stubrevolver_p1_m1)
        momentum.stubrevolver_p1_m2 = table_clone_safe(momentum.stubrevolver_p1_m1)
        momentum.boltpistol_p1_m2 = table_clone_safe(momentum.boltpistol_p1_m1)
        momentum.forcestaff_p2_m1 = table_clone_safe(momentum.forcestaff_p1_m1)
        momentum.forcestaff_p3_m1 = table_clone_safe(momentum.forcestaff_p1_m1)
        momentum.forcestaff_p4_m1 = table_clone_safe(momentum.forcestaff_p1_m1)
        momentum.laspistol_p1_m2 = table_clone_safe(momentum.laspistol_p1_m1)
        momentum.laspistol_p1_m3 = table_clone_safe(momentum.laspistol_p1_m1)
        momentum.autogun_p1_m3 = table_clone_safe(momentum.autogun_p1_m1)
        momentum.autogun_p2_m1 = table_clone_safe(momentum.autogun_p1_m1)
        momentum.autogun_p2_m2 = table_clone_safe(momentum.autogun_p1_m1)
        momentum.autogun_p2_m3 = table_clone_safe(momentum.autogun_p1_m1)
        momentum.autogun_p3_m1 = table_clone_safe(momentum.autogun_p1_m1)
        momentum.autogun_p3_m2 = table_clone_safe(momentum.autogun_p1_m1)
        momentum.autogun_p3_m3 = table_clone_safe(momentum.autogun_p1_m1)
        momentum.shotgun_p1_m2 = table_clone_safe(momentum.shotgun_p1_m1)
        momentum.shotgun_p1_m3 = table_clone_safe(momentum.shotgun_p1_m1)
        momentum.shotgun_p4_m2 = table_clone_safe(momentum.shotgun_p4_m1)
        momentum.shotgun_p4_m3 = table_clone_safe(momentum.shotgun_p4_m1)
        momentum.autogun_p1_m2 = table_clone_safe(momentum.autogun_p1_m1)
        momentum.bolter_p1_m2 = table_clone_safe(momentum.bolter_p1_m1)
        momentum.lasgun_p1_m2 = table_clone_safe(momentum.lasgun_p1_m1)
        momentum.lasgun_p2_m2 = table_clone_safe(momentum.lasgun_p2_m1)
        momentum.lasgun_p2_m3 = table_clone_safe(momentum.lasgun_p2_m1)
        momentum.lasgun_p3_m2 = table_clone_safe(momentum.lasgun_p3_m1)
        momentum.lasgun_p3_m3 = table_clone_safe(momentum.lasgun_p3_m1)
		momentum.bolter_p1_m3 = table_clone_safe(momentum.bolter_p1_m1)
		momentum.lasgun_p1_m3 = table_clone_safe(momentum.lasgun_p1_m1)
            momentum.bot_laspistol_killshot = table_clone_safe(momentum.laspistol_p1_m1)
            momentum.bot_zola_laspistol = table_clone_safe(momentum.laspistol_p1_m1)
            momentum.high_bot_lasgun_killshot = table_clone_safe(momentum.lasgun_p1_m1)
            momentum.bot_lasgun_killshot = table_clone_safe(momentum.lasgun_p1_m1)
            momentum.high_bot_autogun_killshot = table_clone_safe(momentum.autogun_p3_m1)
            momentum.bot_autogun_killshot = table_clone_safe(momentum.autogun_p3_m1)
                momentum.laspistol_npc_01 = table_clone_safe(momentum.laspistol_p1_m1)
                momentum.lasgun_npc_01 = table_clone_safe(momentum.lasgun_p1_m1)
                momentum.lasgun_npc_02 = table_clone_safe(momentum.lasgun_p1_m1)
                momentum.lasgun_npc_03 = table_clone_safe(momentum.lasgun_p1_m1)
                momentum.lasgun_npc_04 = table_clone_safe(momentum.lasgun_p1_m1)
                momentum.lasgun_npc_05 = table_clone_safe(momentum.lasgun_p1_m1)
                momentum.lasgun_d7_veteran_m = table_clone_safe(momentum.lasgun_p1_m1)
                momentum.autogun_npc_01 = table_clone_safe(momentum.autogun_p1_m1)
                momentum.autogun_npc_02 = table_clone_safe(momentum.autogun_p1_m1)
                momentum.autogun_npc_03 = table_clone_safe(momentum.autogun_p1_m1)
                momentum.autogun_npc_04 = table_clone_safe(momentum.autogun_p2_m1)
                momentum.autogun_npc_05 = table_clone_safe(momentum.autogun_p2_m1)
                momentum.flamer_npc_01 = table_clone_safe(momentum.flamer_p1_m1)
    --#endregion
--#endregion

return momentum