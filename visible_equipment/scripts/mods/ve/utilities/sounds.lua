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
local combataxe_p1_m1 = mod:io_dofile(weapons_folder.."combataxe_p1_m1")
local combataxe_p2_m1 = mod:io_dofile(weapons_folder.."combataxe_p2_m1")
local combataxe_p3_m1 = mod:io_dofile(weapons_folder.."combataxe_p3_m1")
local laspistol_p1_m1 = mod:io_dofile(weapons_folder.."laspistol_p1_m1")
local plasmagun_p1_m1 = mod:io_dofile(weapons_folder.."plasmagun_p1_m1")
local powermaul_p1_m1 = mod:io_dofile(weapons_folder.."powermaul_p1_m1")
local powermaul_p2_m1 = mod:io_dofile(weapons_folder.."powermaul_p2_m1")
local chainaxe_p1_m1 = mod:io_dofile(weapons_folder.."chainaxe_p1_m1")
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

local POCKETABLE_SMALL = "POCKETABLE_SMALL"
local WEAPON_RANGED = "WEAPON_RANGED"
local WEAPON_MELEE = "WEAPON_MELEE"
local POCKETABLE = "POCKETABLE"
local BREED_HUMAN = "human"
local BREED_OGRYN = "ogryn"

local sounds = {
    [BREED_HUMAN] = human.sounds,
    [BREED_OGRYN] = ogryn.sounds,
    ogryn_powermaul_slabshield_p1_m1 = ogryn_powermaul_slabshield_p1_m1.sounds,
    ogryn_heavystubber_p1_m1 = ogryn_heavystubber_p1_m1.sounds,
    ogryn_heavystubber_p2_m1 = ogryn_heavystubber_p2_m1.sounds,
    ogryn_combatblade_p1_m1 = ogryn_combatblade_p1_m1.sounds,
    shotpistol_shield_p1_m1 = shotpistol_shield_p1_m1.sounds,
    ogryn_pickaxe_2h_p1_m1 = ogryn_pickaxe_2h_p1_m1.sounds,
    powermaul_shield_p1_m1 = powermaul_shield_p1_m1.sounds,
    thunderhammer_2h_p1_m1 = thunderhammer_2h_p1_m1.sounds,
    ogryn_powermaul_p1_m1 = ogryn_powermaul_p1_m1.sounds,
    ogryn_rippergun_p1_m1 = ogryn_rippergun_p1_m1.sounds,
    ogryn_gauntlet_p1_m1 = ogryn_gauntlet_p1_m1.sounds,
    chainsword_2h_p1_m1 = chainsword_2h_p1_m1.sounds,
    forcesword_2h_p1_m1 = forcesword_2h_p1_m1.sounds,
    ogryn_thumper_p1_m1 = ogryn_thumper_p1_m1.sounds,
    powersword_2h_p1_m1 = powersword_2h_p1_m1.sounds,
    powermaul_2h_p1_m1 = powermaul_2h_p1_m1.sounds,
    stubrevolver_p1_m1 = stubrevolver_p1_m1.sounds,
    combatknife_p1_m1 = combatknife_p1_m1.sounds,
    combatsword_p1_m1 = combatsword_p1_m1.sounds,
    combatsword_p2_m1 = combatsword_p2_m1.sounds,
    combatsword_p3_m1 = combatsword_p3_m1.sounds,
    boltpistol_p1_m1 = boltpistol_p1_m1.sounds,
    chainsword_p1_m1 = chainsword_p1_m1.sounds,
    forcestaff_p1_m1 = forcestaff_p1_m1.sounds,
    forcesword_p1_m1 = forcesword_p1_m1.sounds,
    ogryn_club_p1_m1 = ogryn_club_p1_m1.sounds,
    ogryn_club_p2_m1 = ogryn_club_p2_m1.sounds,
    powersword_p1_m1 = powersword_p1_m1.sounds,
    powersword_p2_m1 = powersword_p2_m1.sounds,
    combataxe_p1_m1 = combataxe_p1_m1.sounds,
    combataxe_p2_m1 = combataxe_p2_m1.sounds,
    combataxe_p3_m1 = combataxe_p3_m1.sounds,
    laspistol_p1_m1 = laspistol_p1_m1.sounds,
    plasmagun_p1_m1 = plasmagun_p1_m1.sounds,
    powermaul_p1_m1 = powermaul_p1_m1.sounds,
    powermaul_p2_m1 = powermaul_p2_m1.sounds,
    chainaxe_p1_m1 = chainaxe_p1_m1.sounds,
    autogun_p1_m1 = autogun_p1_m1.sounds,
    shotgun_p1_m1 = shotgun_p1_m1.sounds,
    shotgun_p2_m1 = shotgun_p2_m1.sounds,
    shotgun_p4_m1 = shotgun_p4_m1.sounds,
    bolter_p1_m1 = bolter_p1_m1.sounds,
    flamer_p1_m1 = flamer_p1_m1.sounds,
    lasgun_p1_m1 = lasgun_p1_m1.sounds,
    default = {
        [WEAPON_MELEE] = {
            crouching = {
                "sfx_grab_weapon",
                "sfx_foley_equip",
            },
            default = {
                "sfx_ads_up",
                "sfx_ads_down",
            },
            accent = {
                "sfx_equip",
                "sfx_pull_pin",
            },
        },
        [WEAPON_RANGED] = {
            crouching = {
                "sfx_ads_up",
                "sfx_ads_down",
            },
            default = {
                "sfx_ads_up",
                "sfx_ads_down",
            },
            accent = {
                "sfx_equip",
                "sfx_magazine_eject",
                "sfx_magazine_insert",
                "sfx_reload_lever_pull",
                "sfx_reload_lever_release",
            },
        },
        [POCKETABLE_SMALL] = {
            crouching = {},
            default = {},
            accent = {},
        },
        [POCKETABLE] = {
            crouching = {},
            default = {},
            accent = {},
        },
    },
}

--#region Copies
    --#region Ogryn melee
        sounds.ogryn_combatblade_p1_m2 = table_clone_safe(sounds.ogryn_combatblade_p1_m1)
        sounds.ogryn_combatblade_p1_m3 = table_clone_safe(sounds.ogryn_combatblade_p1_m1)
        sounds.ogryn_pickaxe_2h_p1_m2 = table_clone_safe(sounds.ogryn_pickaxe_2h_p1_m1)
        sounds.ogryn_pickaxe_2h_p1_m3 = table_clone_safe(sounds.ogryn_pickaxe_2h_p1_m1)
        sounds.ogryn_powermaul_p1_m2 = table_clone_safe(sounds.ogryn_powermaul_p1_m1)
        sounds.ogryn_powermaul_p1_m3 = table_clone_safe(sounds.ogryn_powermaul_p1_m1)
        sounds.ogryn_club_p1_m2 = table_clone_safe(sounds.ogryn_club_p1_m1)
        sounds.ogryn_club_p1_m3 = table_clone_safe(sounds.ogryn_club_p1_m1)
        sounds.ogryn_club_p2_m2 = table_clone_safe(sounds.ogryn_club_p2_m1)
        sounds.ogryn_club_p2_m3 = table_clone_safe(sounds.ogryn_club_p2_m1)
    --#endregion
    --#region Ogryn ranged
        sounds.ogryn_heavystubber_p1_m2 = table_clone_safe(sounds.ogryn_heavystubber_p1_m1)
		sounds.ogryn_heavystubber_p1_m3 = table_clone_safe(sounds.ogryn_heavystubber_p1_m1)
        sounds.ogryn_heavystubber_p2_m2 = table_clone_safe(sounds.ogryn_heavystubber_p2_m1)
		sounds.ogryn_heavystubber_p2_m3 = table_clone_safe(sounds.ogryn_heavystubber_p2_m1)
        sounds.ogryn_rippergun_p1_m2 = table_clone_safe(sounds.ogryn_rippergun_p1_m1)
		sounds.ogryn_rippergun_p1_m3 = table_clone_safe(sounds.ogryn_rippergun_p1_m1)
        sounds.ogryn_thumper_p1_m2 = table_clone_safe(sounds.ogryn_thumper_p1_m1)
    --#endregion
    --#region Human melee
        sounds.thunderhammer_2h_p1_m2 = table_clone_safe(sounds.thunderhammer_2h_p1_m1)
        sounds.powermaul_shield_p1_m2 = table_clone_safe(sounds.powermaul_shield_p1_m1)
        sounds.chainsword_2h_p1_m2 = table_clone_safe(sounds.chainsword_2h_p1_m1)
        sounds.forcesword_2h_p1_m2 = table_clone_safe(sounds.forcesword_2h_p1_m1)
        sounds.powersword_2h_p1_m2 = table_clone_safe(sounds.powersword_2h_p1_m1)
        sounds.combatknife_p1_m2 = table_clone_safe(sounds.combatknife_p1_m1)
        sounds.combatsword_p1_m2 = table_clone_safe(sounds.combatsword_p1_m1)
        sounds.combatsword_p1_m3 = table_clone_safe(sounds.combatsword_p1_m1)
        sounds.combatsword_p2_m2 = table_clone_safe(sounds.combatsword_p2_m1)
        sounds.combatsword_p2_m3 = table_clone_safe(sounds.combatsword_p2_m1)
        sounds.combatsword_p3_m2 = table_clone_safe(sounds.combatsword_p3_m1)
        sounds.combatsword_p3_m3 = table_clone_safe(sounds.combatsword_p3_m1)
        sounds.chainsword_p1_m2 = table_clone_safe(sounds.chainsword_p1_m1)
        sounds.forcesword_p1_m2 = table_clone_safe(sounds.forcesword_p1_m1)
        sounds.forcesword_p1_m3 = table_clone_safe(sounds.forcesword_p1_m1)
        sounds.powersword_p1_m2 = table_clone_safe(sounds.powersword_p1_m1)
        sounds.powersword_p1_m3 = table_clone_safe(sounds.powersword_p1_m1)
        sounds.powersword_p2_m2 = table_clone_safe(sounds.powersword_p2_m1)
        sounds.combataxe_p1_m2 = table_clone_safe(sounds.combataxe_p1_m1)
        sounds.combataxe_p1_m3 = table_clone_safe(sounds.combataxe_p1_m1)
        sounds.combataxe_p2_m2 = table_clone_safe(sounds.combataxe_p2_m1)
        sounds.combataxe_p2_m3 = table_clone_safe(sounds.combataxe_p2_m1)
        sounds.combataxe_p3_m2 = table_clone_safe(sounds.combataxe_p3_m1)
        sounds.combataxe_p3_m3 = table_clone_safe(sounds.combataxe_p3_m1)
        sounds.powermaul_p1_m2 = table_clone_safe(sounds.powermaul_p1_m1)
    --#endregion
    --#region Human ranged
        sounds.stubrevolver_p1_m2 = table_clone_safe(sounds.stubrevolver_p1_m1)
        sounds.stubrevolver_p1_m3 = table_clone_safe(sounds.stubrevolver_p1_m1)
        sounds.forcestaff_p2_m1 = table_clone_safe(sounds.forcestaff_p1_m1)
        sounds.forcestaff_p3_m1 = table_clone_safe(sounds.forcestaff_p1_m1)
        sounds.forcestaff_p4_m1 = table_clone_safe(sounds.forcestaff_p1_m1)
        sounds.laspistol_p1_m2 = table_clone_safe(sounds.laspistol_p1_m1)
        sounds.laspistol_p1_m3 = table_clone_safe(sounds.laspistol_p1_m1)
        sounds.autogun_p1_m2 = table_clone_safe(sounds.autogun_p1_m1)
        sounds.autogun_p1_m3 = table_clone_safe(sounds.autogun_p1_m1)
        sounds.autogun_p2_m1 = table_clone_safe(sounds.autogun_p1_m1)
        sounds.autogun_p2_m2 = table_clone_safe(sounds.autogun_p1_m1)
        sounds.autogun_p2_m3 = table_clone_safe(sounds.autogun_p1_m1)
        sounds.autogun_p3_m1 = table_clone_safe(sounds.autogun_p1_m1)
        sounds.autogun_p3_m2 = table_clone_safe(sounds.autogun_p1_m1)
        sounds.autogun_p3_m3 = table_clone_safe(sounds.autogun_p1_m1)
        sounds.shotgun_p1_m2 = table_clone_safe(sounds.shotgun_p1_m1)
        sounds.shotgun_p1_m3 = table_clone_safe(sounds.shotgun_p1_m1)
        sounds.shotgun_p4_m2 = table_clone_safe(sounds.shotgun_p4_m1)
        sounds.shotgun_p4_m3 = table_clone_safe(sounds.shotgun_p4_m1)
        sounds.bolter_p1_m2 = table_clone_safe(sounds.bolter_p1_m1)
        sounds.bolter_p1_m3 = table_clone_safe(sounds.bolter_p1_m1)
        sounds.lasgun_p1_m2 = table_clone_safe(sounds.lasgun_p1_m1)
        sounds.lasgun_p1_m3 = table_clone_safe(sounds.lasgun_p1_m1)
        sounds.lasgun_p2_m2 = table_clone_safe(sounds.lasgun_p2_m1)
        sounds.lasgun_p2_m3 = table_clone_safe(sounds.lasgun_p2_m1)
        sounds.lasgun_p3_m2 = table_clone_safe(sounds.lasgun_p3_m1)
        sounds.lasgun_p3_m3 = table_clone_safe(sounds.lasgun_p3_m1)
    --#endregion
--#endregion

return sounds