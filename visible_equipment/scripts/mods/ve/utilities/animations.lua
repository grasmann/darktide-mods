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
local dual_shivs_p1_m1 = mod:io_dofile(weapons_folder.."dual_shivs_p1_m1")
local boltpistol_p1_m1 = mod:io_dofile(weapons_folder.."boltpistol_p1_m1")
local chainsword_p1_m1 = mod:io_dofile(weapons_folder.."chainsword_p1_m1")
local forcestaff_p1_m1 = mod:io_dofile(weapons_folder.."forcestaff_p1_m1")
local forcesword_p1_m1 = mod:io_dofile(weapons_folder.."forcesword_p1_m1")
local ogryn_club_p1_m1 = mod:io_dofile(weapons_folder.."ogryn_club_p1_m1")
local ogryn_club_p2_m1 = mod:io_dofile(weapons_folder.."ogryn_club_p2_m1")
local powersword_p1_m1 = mod:io_dofile(weapons_folder.."powersword_p1_m1")
local powersword_p2_m1 = mod:io_dofile(weapons_folder.."powersword_p2_m1")
local autopistol_p1_m1 = mod:io_dofile(weapons_folder.."autopistol_p1_m1")
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

local animations = {
    [BREED_HUMAN] = human.animations,
    [BREED_OGRYN] = ogryn.animations,
    ogryn_powermaul_slabshield_p1_m1 = ogryn_powermaul_slabshield_p1_m1.animations,
    ogryn_heavystubber_p1_m1 = ogryn_heavystubber_p1_m1.animations,
    ogryn_heavystubber_p2_m1 = ogryn_heavystubber_p2_m1.animations,
    ogryn_combatblade_p1_m1 = ogryn_combatblade_p1_m1.animations,
    shotpistol_shield_p1_m1 = shotpistol_shield_p1_m1.animations,
    dual_stubpistols_p1_m1 = dual_stubpistols_p1_m1.animations,
    ogryn_pickaxe_2h_p1_m1 = ogryn_pickaxe_2h_p1_m1.animations,
    powermaul_shield_p1_m1 = powermaul_shield_p1_m1.animations,
    thunderhammer_2h_p1_m1 = thunderhammer_2h_p1_m1.animations,
    ogryn_powermaul_p1_m1 = ogryn_powermaul_p1_m1.animations,
    ogryn_rippergun_p1_m1 = ogryn_rippergun_p1_m1.animations,
    ogryn_gauntlet_p1_m1 = ogryn_gauntlet_p1_m1.animations,
    chainsword_2h_p1_m1 = chainsword_2h_p1_m1.animations,
    forcesword_2h_p1_m1 = forcesword_2h_p1_m1.animations,
    ogryn_thumper_p1_m1 = ogryn_thumper_p1_m1.animations,
    powersword_2h_p1_m1 = powersword_2h_p1_m1.animations,
    powermaul_2h_p1_m1 = powermaul_2h_p1_m1.animations,
    stubrevolver_p1_m1 = stubrevolver_p1_m1.animations,
    combatknife_p1_m1 = combatknife_p1_m1.animations,
    combatsword_p1_m1 = combatsword_p1_m1.animations,
    combatsword_p2_m1 = combatsword_p2_m1.animations,
    combatsword_p3_m1 = combatsword_p3_m1.animations,
    boltpistol_p1_m1 = boltpistol_p1_m1.animations,
    chainsword_p1_m1 = chainsword_p1_m1.animations,
    forcestaff_p1_m1 = forcestaff_p1_m1.animations,
    forcesword_p1_m1 = forcesword_p1_m1.animations,
    ogryn_club_p1_m1 = ogryn_club_p1_m1.animations,
    ogryn_club_p2_m1 = ogryn_club_p2_m1.animations,
    powersword_p1_m1 = powersword_p1_m1.animations,
    powersword_p2_m1 = powersword_p2_m1.animations,
    autopistol_p1_m1 = autopistol_p1_m1.animations,
    dual_shivs_p1_m1 = dual_shivs_p1_m1.animations,
    combataxe_p1_m1 = combataxe_p1_m1.animations,
    combataxe_p2_m1 = combataxe_p2_m1.animations,
    combataxe_p3_m1 = combataxe_p3_m1.animations,
    laspistol_p1_m1 = laspistol_p1_m1.animations,
    plasmagun_p1_m1 = plasmagun_p1_m1.animations,
    powermaul_p1_m1 = powermaul_p1_m1.animations,
    powermaul_p2_m1 = powermaul_p2_m1.animations,
    chainaxe_p1_m1 = chainaxe_p1_m1.animations,
    crowbar_p1_m1 = crowbar_p1_m1.animations,
    autogun_p1_m1 = autogun_p1_m1.animations,
    shotgun_p1_m1 = shotgun_p1_m1.animations,
    shotgun_p2_m1 = shotgun_p2_m1.animations,
    shotgun_p4_m1 = shotgun_p4_m1.animations,
    bolter_p1_m1 = bolter_p1_m1.animations,
    flamer_p1_m1 = flamer_p1_m1.animations,
    lasgun_p1_m1 = lasgun_p1_m1.animations,
    lasgun_p2_m1 = lasgun_p2_m1.animations,
    lasgun_p3_m1 = lasgun_p3_m1.animations,
    default = {
        right = {
            start = "step",
            states = 2,
            step = {
                name = "step",
                start_position = vector3_box(vector3_zero()),
                start_rotation = vector3_box(vector3_zero()),
                end_position = vector3_box(vector3(-.05, 0, 0) * .5),
                end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
                next = "back",
            },
            back = {
                name = "back",
                start_position = vector3_box(vector3(-.05, 0, 0) * .5),
                start_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
                end_position = vector3_box(vector3_zero()),
                end_rotation = vector3_box(vector3_zero()),
            },
        },
        left = {
            start = "step",
            states = 2,
            step = {
                name = "step",
                start_position = vector3_box(vector3(-.05, 0, 0) * .5),
                start_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
                end_position = vector3_box(vector3_zero()),
                end_rotation = vector3_box(vector3_zero()),
                next = "back",
            },
            back = {
                name = "back",
                start_position = vector3_box(vector3_zero()),
                start_rotation = vector3_box(vector3_zero()),
                end_position = vector3_box(vector3(-.05, 0, 0) * .5),
                end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
            },
        },
    },
}

--#region Copies
    --#region Ogryn melee
        animations.ogryn_combatblade_p1_m2 = table_clone_safe(animations.ogryn_combatblade_p1_m1)
        animations.ogryn_combatblade_p1_m3 = table_clone_safe(animations.ogryn_combatblade_p1_m1)
        animations.ogryn_pickaxe_2h_p1_m2 = table_clone_safe(animations.ogryn_pickaxe_2h_p1_m1)
        animations.ogryn_pickaxe_2h_p1_m3 = table_clone_safe(animations.ogryn_pickaxe_2h_p1_m1)
        animations.ogryn_powermaul_p1_m2 = table_clone_safe(animations.ogryn_powermaul_p1_m1)
        animations.ogryn_powermaul_p1_m3 = table_clone_safe(animations.ogryn_powermaul_p1_m1)
        animations.ogryn_club_p1_m2 = table_clone_safe(animations.ogryn_club_p1_m1)
        animations.ogryn_club_p1_m3 = table_clone_safe(animations.ogryn_club_p1_m1)
        animations.ogryn_club_p2_m2 = table_clone_safe(animations.ogryn_club_p2_m1)
        animations.ogryn_club_p2_m3 = table_clone_safe(animations.ogryn_club_p2_m1)
                animations.ogryn_combatblade_npc_01 = table_clone_safe(animations.ogryn_combatblade_p1_m1)
                animations.ogryn_powermaul_slabshield_npc_01 = table_clone_safe(animations.ogryn_powermaul_slabshield_p1_m1)
    --#endregion
    --#region Ogryn ranged
        animations.ogryn_heavystubber_p1_m2 = table_clone_safe(animations.ogryn_heavystubber_p1_m1)
		animations.ogryn_heavystubber_p1_m3 = table_clone_safe(animations.ogryn_heavystubber_p1_m1)
        animations.ogryn_heavystubber_p2_m2 = table_clone_safe(animations.ogryn_heavystubber_p2_m1)
		animations.ogryn_heavystubber_p2_m3 = table_clone_safe(animations.ogryn_heavystubber_p2_m1)
        animations.ogryn_rippergun_p1_m2 = table_clone_safe(animations.ogryn_rippergun_p1_m1)
		animations.ogryn_rippergun_p1_m3 = table_clone_safe(animations.ogryn_rippergun_p1_m1)
        animations.ogryn_thumper_p1_m2 = table_clone_safe(animations.ogryn_thumper_p1_m1)
                animations.ogryn_rippergun_npc_01 = table_clone_safe(animations.ogryn_rippergun_p1_m1)
                animations.ogryn_thumper_npc_01 = table_clone_safe(animations.ogryn_thumper_p1_m1)
                animations.ogryn_gauntlet_npc_01 = table_clone_safe(animations.ogryn_gauntlet_p1_m1)
    --#endregion
    --#region Human melee
        animations.thunderhammer_2h_p1_m2 = table_clone_safe(animations.thunderhammer_2h_p1_m1)
        animations.powermaul_shield_p1_m2 = table_clone_safe(animations.powermaul_shield_p1_m1)
        animations.chainsword_2h_p1_m2 = table_clone_safe(animations.chainsword_2h_p1_m1)
        animations.forcesword_2h_p1_m2 = table_clone_safe(animations.forcesword_2h_p1_m1)
        animations.powersword_2h_p1_m2 = table_clone_safe(animations.powersword_2h_p1_m1)
        animations.combatknife_p1_m2 = table_clone_safe(animations.combatknife_p1_m1)
        animations.combatsword_p1_m2 = table_clone_safe(animations.combatsword_p1_m1)
        animations.combatsword_p1_m3 = table_clone_safe(animations.combatsword_p1_m1)
        animations.combatsword_p2_m2 = table_clone_safe(animations.combatsword_p2_m1)
        animations.combatsword_p2_m3 = table_clone_safe(animations.combatsword_p2_m1)
        animations.combatsword_p3_m2 = table_clone_safe(animations.combatsword_p3_m1)
        animations.combatsword_p3_m3 = table_clone_safe(animations.combatsword_p3_m1)
        animations.chainsword_p1_m2 = table_clone_safe(animations.chainsword_p1_m1)
        animations.forcesword_p1_m2 = table_clone_safe(animations.forcesword_p1_m1)
        animations.forcesword_p1_m3 = table_clone_safe(animations.forcesword_p1_m1)
        animations.powersword_p1_m2 = table_clone_safe(animations.powersword_p1_m1)
        animations.powersword_p1_m3 = table_clone_safe(animations.powersword_p1_m1)
        animations.powersword_p2_m2 = table_clone_safe(animations.powersword_p2_m1)
        animations.dual_shivs_p1_m2 = table_clone_safe(animations.dual_shivs_p1_m1)
        animations.dual_shivs_p1_m3 = table_clone_safe(animations.dual_shivs_p1_m1)
        animations.dual_shivs_p1_m4 = table_clone_safe(animations.dual_shivs_p1_m1)
        animations.combataxe_p1_m2 = table_clone_safe(animations.combataxe_p1_m1)
        animations.combataxe_p1_m3 = table_clone_safe(animations.combataxe_p1_m1)
        animations.combataxe_p2_m2 = table_clone_safe(animations.combataxe_p2_m1)
        animations.combataxe_p2_m3 = table_clone_safe(animations.combataxe_p2_m1)
        animations.combataxe_p3_m2 = table_clone_safe(animations.combataxe_p3_m1)
        animations.combataxe_p3_m3 = table_clone_safe(animations.combataxe_p3_m1)
        animations.powermaul_p1_m2 = table_clone_safe(animations.powermaul_p1_m1)
        animations.chainaxe_p1_m2 = table_clone_safe(animations.chainaxe_p1_m1)
        animations.crowbar_p1_m1 = table_clone_safe(animations.crowbar_p1_m1)
        animations.crowbar_p1_m2 = table_clone_safe(animations.crowbar_p1_m1)
        animations.crowbar_p1_m3 = table_clone_safe(animations.crowbar_p1_m1)
        animations.crowbar_p1_m4 = table_clone_safe(animations.crowbar_p1_m1)
            animations.bot_combataxe_linesman = table_clone_safe(animations.combataxe_p1_m1)
            animations.bot_combatsword_linesman_p1 = table_clone_safe(animations.combatsword_p1_m1)
            animations.bot_combatsword_linesman_p2 = table_clone_safe(animations.combatsword_p2_m1)
                animations.thunderhammer_d7_zealot_f = table_clone_safe(animations.thunderhammer_2h_p1_m1)
                animations.forcesword_npc_01 = table_clone_safe(animations.forcesword_p1_m1)
                animations.powersword_2h_npc_01 = table_clone_safe(animations.powersword_p1_m1)
                animations.chainsword_npc_01 = table_clone_safe(animations.chainsword_p1_m1)
    --#endregion
    --#region Human ranged
        animations.dual_stubpistols_p1_m2 = table_clone_safe(animations.dual_stubpistols_p1_m1)
        animations.dual_stubpistols_p1_m3 = table_clone_safe(animations.dual_stubpistols_p1_m1)
        animations.dual_stubpistols_p1_m4 = table_clone_safe(animations.dual_stubpistols_p1_m1)
        animations.stubrevolver_p1_m2 = table_clone_safe(animations.stubrevolver_p1_m1)
        animations.stubrevolver_p1_m3 = table_clone_safe(animations.stubrevolver_p1_m1)
        animations.boltpistol_p1_m2 = table_clone_safe(animations.boltpistol_p1_m1)
        animations.forcestaff_p2_m1 = table_clone_safe(animations.forcestaff_p1_m1)
        animations.forcestaff_p3_m1 = table_clone_safe(animations.forcestaff_p1_m1)
        animations.forcestaff_p4_m1 = table_clone_safe(animations.forcestaff_p1_m1)
        animations.laspistol_p1_m2 = table_clone_safe(animations.laspistol_p1_m1)
        animations.laspistol_p1_m3 = table_clone_safe(animations.laspistol_p1_m1)
        animations.autogun_p1_m2 = table_clone_safe(animations.autogun_p1_m1)
        animations.autogun_p1_m3 = table_clone_safe(animations.autogun_p1_m1)
        animations.autogun_p2_m1 = table_clone_safe(animations.autogun_p1_m1)
        animations.autogun_p2_m2 = table_clone_safe(animations.autogun_p1_m1)
        animations.autogun_p2_m3 = table_clone_safe(animations.autogun_p1_m1)
        animations.autogun_p3_m1 = table_clone_safe(animations.autogun_p1_m1)
        animations.autogun_p3_m2 = table_clone_safe(animations.autogun_p1_m1)
        animations.autogun_p3_m3 = table_clone_safe(animations.autogun_p1_m1)
        animations.shotgun_p1_m2 = table_clone_safe(animations.shotgun_p1_m1)
        animations.shotgun_p1_m3 = table_clone_safe(animations.shotgun_p1_m1)
        animations.shotgun_p4_m2 = table_clone_safe(animations.shotgun_p4_m1)
        animations.shotgun_p4_m3 = table_clone_safe(animations.shotgun_p4_m1)
        animations.bolter_p1_m2 = table_clone_safe(animations.bolter_p1_m1)
        animations.bolter_p1_m3 = table_clone_safe(animations.bolter_p1_m1)
        animations.lasgun_p1_m2 = table_clone_safe(animations.lasgun_p1_m1)
        animations.lasgun_p1_m3 = table_clone_safe(animations.lasgun_p1_m1)
        animations.lasgun_p2_m2 = table_clone_safe(animations.lasgun_p2_m1)
        animations.lasgun_p2_m3 = table_clone_safe(animations.lasgun_p2_m1)
        animations.lasgun_p3_m2 = table_clone_safe(animations.lasgun_p3_m1)
        animations.lasgun_p3_m3 = table_clone_safe(animations.lasgun_p3_m1)
            animations.bot_laspistol_killshot = table_clone_safe(animations.laspistol_p1_m1)
            animations.bot_zola_laspistol = table_clone_safe(animations.laspistol_p1_m1)
            animations.high_bot_lasgun_killshot = table_clone_safe(animations.lasgun_p1_m1)
            animations.bot_lasgun_killshot = table_clone_safe(animations.lasgun_p1_m1)
            animations.high_bot_autogun_killshot = table_clone_safe(animations.autogun_p3_m1)
            animations.bot_autogun_killshot = table_clone_safe(animations.autogun_p3_m1)
                animations.laspistol_npc_01 = table_clone_safe(animations.laspistol_p1_m1)
                animations.lasgun_npc_01 = table_clone_safe(animations.lasgun_p1_m1)
                animations.lasgun_npc_02 = table_clone_safe(animations.lasgun_p1_m1)
                animations.lasgun_npc_03 = table_clone_safe(animations.lasgun_p1_m1)
                animations.lasgun_npc_04 = table_clone_safe(animations.lasgun_p1_m1)
                animations.lasgun_npc_05 = table_clone_safe(animations.lasgun_p1_m1)
                animations.lasgun_d7_veteran_m = table_clone_safe(animations.lasgun_p1_m1)
                animations.autogun_npc_01 = table_clone_safe(animations.autogun_p1_m1)
                animations.autogun_npc_02 = table_clone_safe(animations.autogun_p1_m1)
                animations.autogun_npc_03 = table_clone_safe(animations.autogun_p1_m1)
                animations.autogun_npc_04 = table_clone_safe(animations.autogun_p2_m1)
                animations.autogun_npc_05 = table_clone_safe(animations.autogun_p2_m1)
                animations.flamer_npc_01 = table_clone_safe(animations.flamer_p1_m1)
    --#endregion
--#endregion

return animations