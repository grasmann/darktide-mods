local mod = get_mod("visible_equipment")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local breed_folder = "visible_equipment/scripts/mods/visible_equipment/breeds/"
local ogryn = mod:io_dofile(breed_folder.."ogryn")
local human = mod:io_dofile(breed_folder.."human")
local weapons_folder = "visible_equipment/scripts/mods/visible_equipment/weapons/"
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
    local vector3 = Vector3
    local vector3_box = Vector3Box
    local vector3_zero = vector3.zero
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local BREED_HUMAN = "human"
local BREED_OGRYN = "ogryn"
local WEAPON_MELEE = "WEAPON_MELEE"
local WEAPON_RANGED = "WEAPON_RANGED"

-- local offsets = {
--     [BREED_HUMAN] = human.offsets,
--     [BREED_OGRYN] = ogryn.offsets,
--     ogryn_powermaul_slabshield_p1_m1 = ogryn_powermaul_slabshield_p1_m1.offsets,
--     ogryn_heavystubber_p1_m1 = ogryn_heavystubber_p1_m1.offsets,
--     ogryn_heavystubber_p2_m1 = ogryn_heavystubber_p2_m1.offsets,
--     ogryn_combatblade_p1_m1 = ogryn_combatblade_p1_m1.offsets,
--     shotpistol_shield_p1_m1 = shotpistol_shield_p1_m1.offsets,
--     ogryn_pickaxe_2h_p1_m1 = ogryn_pickaxe_2h_p1_m1.offsets,
--     powermaul_shield_p1_m1 = powermaul_shield_p1_m1.offsets,
--     thunderhammer_2h_p1_m1 = thunderhammer_2h_p1_m1.offsets,
--     ogryn_powermaul_p1_m1 = ogryn_powermaul_p1_m1.offsets,
--     ogryn_rippergun_p1_m1 = ogryn_rippergun_p1_m1.offsets,
--     ogryn_gauntlet_p1_m1 = ogryn_gauntlet_p1_m1.offsets,
--     chainsword_2h_p1_m1 = chainsword_2h_p1_m1.offsets,
--     forcesword_2h_p1_m1 = forcesword_2h_p1_m1.offsets,
--     ogryn_thumper_p1_m1 = ogryn_thumper_p1_m1.offsets,
--     powersword_2h_p1_m1 = powersword_2h_p1_m1.offsets,
--     powermaul_2h_p1_m1 = powermaul_2h_p1_m1.offsets,
--     stubrevolver_p1_m1 = stubrevolver_p1_m1.offsets,
--     combatknife_p1_m1 = combatknife_p1_m1.offsets,
--     combatsword_p1_m1 = combatsword_p1_m1.offsets,
--     combatsword_p2_m1 = combatsword_p2_m1.offsets,
--     combatsword_p3_m1 = combatsword_p3_m1.offsets,
--     boltpistol_p1_m1 = boltpistol_p1_m1.offsets,
--     chainsword_p1_m1 = chainsword_p1_m1.offsets,
--     forcestaff_p1_m1 = forcestaff_p1_m1.offsets,
--     forcesword_p1_m1 = forcesword_p1_m1.offsets,
--     ogryn_club_p1_m1 = ogryn_club_p1_m1.offsets,
--     ogryn_club_p2_m1 = ogryn_club_p2_m1.offsets,
--     powersword_p1_m1 = powersword_p1_m1.offsets,
--     combataxe_p1_m1 = combataxe_p1_m1.offsets,
--     combataxe_p2_m1 = combataxe_p2_m1.offsets,
--     combataxe_p3_m1 = combataxe_p3_m1.offsets,
--     laspistol_p1_m1 = laspistol_p1_m1.offsets,
--     plasmagun_p1_m1 = plasmagun_p1_m1.offsets,
--     powermaul_p1_m1 = powermaul_p1_m1.offsets,
--     powermaul_p2_m1 = powermaul_p2_m1.offsets,
--     chainaxe_p1_m1 = chainaxe_p1_m1.offsets,
--     shotgun_p1_m1 = shotgun_p1_m1.offsets,
--     shotgun_p2_m1 = shotgun_p2_m1.offsets,
--     shotgun_p4_m1 = shotgun_p4_m1.offsets,
--     bolter_p1_m1 = bolter_p1_m1.offsets,
--     flamer_p1_m1 = flamer_p1_m1.offsets,
--     lasgun_p1_m1 = lasgun_p1_m1.offsets,
--     lasgun_p2_m1 = lasgun_p2_m1.offsets,
--     lasgun_p3_m1 = lasgun_p3_m1.offsets,
--     autogun_p1_m1 = autogun_p1_m1.offsets,
-- }

-- --#endregion Copies
--     --#region Ogryn melee
--         offsets.ogryn_combatblade_p1_m2 = offsets.ogryn_combatblade_p1_m1
--         offsets.ogryn_combatblade_p1_m3 = offsets.ogryn_combatblade_p1_m1
--         offsets.ogryn_pickaxe_2h_p1_m2 = offsets.ogryn_pickaxe_2h_p1_m1
--         offsets.ogryn_pickaxe_2h_p1_m3 = offsets.ogryn_pickaxe_2h_p1_m1
--         offsets.ogryn_powermaul_p1_m2 = offsets.ogryn_powermaul_p1_m1
-- 		offsets.ogryn_powermaul_p1_m3 = offsets.ogryn_powermaul_p1_m1
--         offsets.ogryn_club_p2_m2 = offsets.ogryn_club_p2_m1
-- 		offsets.ogryn_club_p1_m3 = offsets.ogryn_club_p1_m1
-- 		offsets.ogryn_club_p2_m3 = offsets.ogryn_club_p2_m1
--         offsets.ogryn_club_p1_m2 = offsets.ogryn_club_p1_m1
--     --#endregion
--     --#region Ogryn ranged
--         offsets.ogryn_heavystubber_p1_m2 = offsets.ogryn_heavystubber_p1_m1
-- 		offsets.ogryn_heavystubber_p1_m3 = offsets.ogryn_heavystubber_p1_m1
--         offsets.ogryn_heavystubber_p2_m2 = offsets.ogryn_heavystubber_p2_m1
-- 		offsets.ogryn_heavystubber_p2_m3 = offsets.ogryn_heavystubber_p2_m1
--         offsets.ogryn_rippergun_p1_m2 = offsets.ogryn_rippergun_p1_m1
-- 		offsets.ogryn_rippergun_p1_m3 = offsets.ogryn_rippergun_p1_m1
--         offsets.ogryn_thumper_p1_m2 = offsets.ogryn_thumper_p1_m1
--     --#endregion
--     --#region Human melee
--         offsets.powermaul_shield_p1_m2 = offsets.powermaul_shield_p1_m1
--         offsets.thunderhammer_2h_p1_m2 = offsets.thunderhammer_2h_p1_m1
--         offsets.forcesword_2h_p1_m2 = offsets.forcesword_2h_p1_m1
--         offsets.chainsword_2h_p1_m2 = offsets.chainsword_2h_p1_m1
--         offsets.powersword_2h_p1_m2 = offsets.powersword_2h_p1_m1
--         offsets.combatknife_p1_m2 = offsets.combatknife_p1_m1
--         offsets.combatsword_p1_m2 = offsets.combatsword_p1_m1
--         offsets.combatsword_p2_m2 = offsets.combatsword_p2_m1
--         offsets.combatsword_p3_m2 = offsets.combatsword_p3_m1
--         offsets.combatsword_p1_m3 = offsets.combatsword_p1_m1
-- 		offsets.combatsword_p2_m3 = offsets.combatsword_p2_m1
-- 		offsets.combatsword_p3_m3 = offsets.combatsword_p3_m1
-- 		offsets.forcesword_p1_m3 = offsets.forcesword_p1_m1
--         offsets.powersword_p1_m3 = offsets.powersword_p1_m1
--         offsets.powersword_p1_m2 = offsets.powersword_p1_m1
--         offsets.chainsword_p1_m2 = offsets.chainsword_p1_m1
--         offsets.forcesword_p1_m2 = offsets.forcesword_p1_m1
--         offsets.combataxe_p1_m2 = offsets.combataxe_p1_m1
--         offsets.combataxe_p2_m2 = offsets.combataxe_p2_m1
--         offsets.combataxe_p2_m3 = offsets.combataxe_p2_m1
--         offsets.combataxe_p3_m2 = offsets.combataxe_p3_m1
--         offsets.combataxe_p3_m3 = offsets.combataxe_p3_m1
--         offsets.powermaul_p1_m2 = offsets.powermaul_p1_m1
-- 		offsets.combataxe_p1_m3 = offsets.combataxe_p1_m1
--     --#endregion
--     --#region Human ranged
--         offsets.stubrevolver_p1_m3 = offsets.stubrevolver_p1_m1
--         offsets.stubrevolver_p1_m2 = offsets.stubrevolver_p1_m1
--         offsets.forcestaff_p2_m1 = offsets.forcestaff_p1_m1
--         offsets.forcestaff_p3_m1 = offsets.forcestaff_p1_m1
--         offsets.forcestaff_p4_m1 = offsets.forcestaff_p1_m1
--         offsets.laspistol_p1_m2 = offsets.laspistol_p1_m1
--         offsets.laspistol_p1_m3 = offsets.laspistol_p1_m1
--         offsets.autogun_p1_m3 = offsets.autogun_p1_m1
--         offsets.autogun_p2_m1 = offsets.autogun_p1_m1
--         offsets.autogun_p2_m2 = offsets.autogun_p1_m1
--         offsets.autogun_p2_m3 = offsets.autogun_p1_m1
--         offsets.autogun_p3_m1 = offsets.autogun_p1_m1
--         offsets.autogun_p3_m2 = offsets.autogun_p1_m1
--         offsets.autogun_p3_m3 = offsets.autogun_p1_m1
--         offsets.shotgun_p1_m2 = offsets.shotgun_p1_m1
--         offsets.shotgun_p1_m3 = offsets.shotgun_p1_m1
--         offsets.shotgun_p4_m2 = offsets.shotgun_p4_m1
--         offsets.shotgun_p4_m3 = offsets.shotgun_p4_m1
--         offsets.autogun_p1_m2 = offsets.autogun_p1_m1
--         offsets.bolter_p1_m2 = offsets.bolter_p1_m1
--         offsets.lasgun_p1_m2 = offsets.lasgun_p1_m1
--         offsets.lasgun_p2_m2 = offsets.lasgun_p2_m1
--         offsets.lasgun_p2_m3 = offsets.lasgun_p2_m1
--         offsets.lasgun_p3_m2 = offsets.lasgun_p3_m1
--         offsets.lasgun_p3_m3 = offsets.lasgun_p3_m1
-- 		offsets.bolter_p1_m3 = offsets.bolter_p1_m1
-- 		offsets.lasgun_p1_m3 = offsets.lasgun_p1_m1
--     --#endregion
-- --#endregion

-- local animations = {
--     [BREED_HUMAN] = human.animations,
--     [BREED_OGRYN] = ogryn.animations,
--     ogryn_powermaul_slabshield_p1_m1 = ogryn_powermaul_slabshield_p1_m1.animations,
--     ogryn_heavystubber_p1_m1 = ogryn_heavystubber_p1_m1.animations,
--     ogryn_heavystubber_p2_m1 = ogryn_heavystubber_p2_m1.animations,
--     ogryn_combatblade_p1_m1 = ogryn_combatblade_p1_m1.animations,
--     shotpistol_shield_p1_m1 = shotpistol_shield_p1_m1.animations,
--     ogryn_pickaxe_2h_p1_m1 = ogryn_pickaxe_2h_p1_m1.animations,
--     powermaul_shield_p1_m1 = powermaul_shield_p1_m1.animations,
--     thunderhammer_2h_p1_m1 = thunderhammer_2h_p1_m1.animations,
--     ogryn_powermaul_p1_m1 = ogryn_powermaul_p1_m1.animations,
--     ogryn_rippergun_p1_m1 = ogryn_rippergun_p1_m1.animations,
--     ogryn_gauntlet_p1_m1 = ogryn_gauntlet_p1_m1.animations,
--     chainsword_2h_p1_m1 = chainsword_2h_p1_m1.animations,
--     forcesword_2h_p1_m1 = forcesword_2h_p1_m1.animations,
--     ogryn_thumper_p1_m1 = ogryn_thumper_p1_m1.animations,
--     powersword_2h_p1_m1 = powersword_2h_p1_m1.animations,
--     powermaul_2h_p1_m1 = powermaul_2h_p1_m1.animations,
--     stubrevolver_p1_m1 = stubrevolver_p1_m1.animations,
--     combatknife_p1_m1 = combatknife_p1_m1.animations,
--     combatsword_p1_m1 = combatsword_p1_m1.animations,
--     combatsword_p2_m1 = combatsword_p2_m1.animations,
--     combatsword_p3_m1 = combatsword_p3_m1.animations,
--     boltpistol_p1_m1 = boltpistol_p1_m1.animations,
--     chainsword_p1_m1 = chainsword_p1_m1.animations,
--     forcestaff_p1_m1 = forcestaff_p1_m1.animations,
--     forcesword_p1_m1 = forcesword_p1_m1.animations,
--     ogryn_club_p1_m1 = ogryn_club_p1_m1.animations,
--     ogryn_club_p2_m1 = ogryn_club_p2_m1.animations,
--     powersword_p1_m1 = powersword_p1_m1.animations,
--     combataxe_p1_m1 = combataxe_p1_m1.animations,
--     combataxe_p2_m1 = combataxe_p2_m1.animations,
--     combataxe_p3_m1 = combataxe_p3_m1.animations,
--     laspistol_p1_m1 = laspistol_p1_m1.animations,
--     plasmagun_p1_m1 = plasmagun_p1_m1.animations,
--     powermaul_p1_m1 = powermaul_p1_m1.animations,
--     powermaul_p2_m1 = powermaul_p2_m1.animations,
--     chainaxe_p1_m1 = chainaxe_p1_m1.animations,
--     autogun_p1_m1 = autogun_p1_m1.animations,
--     shotgun_p1_m1 = shotgun_p1_m1.animations,
--     shotgun_p2_m1 = shotgun_p2_m1.animations,
--     shotgun_p4_m1 = shotgun_p4_m1.animations,
--     bolter_p1_m1 = bolter_p1_m1.animations,
--     flamer_p1_m1 = flamer_p1_m1.animations,
--     lasgun_p1_m1 = lasgun_p1_m1.animations,
--     default = {
--         right = {
--             start = "step",
--             states = 2,
--             step = {
--                 name = "step",
--                 start_position = vector3_box(vector3_zero()),
--                 start_rotation = vector3_box(vector3_zero()),
--                 end_position = vector3_box(vector3(-.05, 0, 0) * .5),
--                 end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
--                 next = "back",
--             },
--             back = {
--                 name = "back",
--                 start_position = vector3_box(vector3(-.05, 0, 0) * .5),
--                 start_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
--                 end_position = vector3_box(vector3_zero()),
--                 end_rotation = vector3_box(vector3_zero()),
--             },
--         },
--         left = {
--             start = "step",
--             states = 2,
--             step = {
--                 name = "step",
--                 start_position = vector3_box(vector3(-.05, 0, 0) * .5),
--                 start_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
--                 end_position = vector3_box(vector3_zero()),
--                 end_rotation = vector3_box(vector3_zero()),
--                 next = "back",
--             },
--             back = {
--                 name = "back",
--                 start_position = vector3_box(vector3_zero()),
--                 start_rotation = vector3_box(vector3_zero()),
--                 end_position = vector3_box(vector3(-.05, 0, 0) * .5),
--                 end_rotation = vector3_box(vector3(-5, 2.5, 5) * .5),
--             },
--         },
--     },
-- }

-- --#endregion Copies
--     --#region Ogryn melee
--         animations.ogryn_combatblade_p1_m2 = animations.ogryn_combatblade_p1_m1
--         animations.ogryn_combatblade_p1_m3 = animations.ogryn_combatblade_p1_m1
--         animations.ogryn_pickaxe_2h_p1_m2 = animations.ogryn_pickaxe_2h_p1_m1
--         animations.ogryn_pickaxe_2h_p1_m3 = animations.ogryn_pickaxe_2h_p1_m1
--         animations.powermaul_shield_p1_m2 = animations.powermaul_shield_p1_m1
--         animations.ogryn_powermaul_p1_m2 = animations.ogryn_powermaul_p1_m1
--         animations.ogryn_powermaul_p1_m3 = animations.ogryn_powermaul_p1_m1
--         animations.powersword_2h_p1_m2 = animations.powersword_2h_p1_m1
--         animations.ogryn_club_p1_m2 = animations.ogryn_club_p1_m1
--         animations.ogryn_club_p1_m3 = animations.ogryn_club_p1_m1
--         animations.ogryn_club_p2_m2 = animations.ogryn_club_p2_m1
--         animations.ogryn_club_p2_m3 = animations.ogryn_club_p2_m1
--         animations.powersword_p1_m2 = animations.powersword_p1_m1
--         animations.powersword_p1_m3 = animations.powersword_p1_m1
--     --#endregion
--     --#region Ogryn ranged
--         animations.ogryn_heavystubber_p1_m2 = animations.ogryn_heavystubber_p1_m1
-- 		animations.ogryn_heavystubber_p1_m3 = animations.ogryn_heavystubber_p1_m1
--         animations.ogryn_heavystubber_p2_m2 = animations.ogryn_heavystubber_p2_m1
-- 		animations.ogryn_heavystubber_p2_m3 = animations.ogryn_heavystubber_p2_m1
--         animations.ogryn_rippergun_p1_m2 = animations.ogryn_rippergun_p1_m1
-- 		animations.ogryn_rippergun_p1_m3 = animations.ogryn_rippergun_p1_m1
--         animations.ogryn_thumper_p1_m2 = animations.ogryn_thumper_p1_m1
--     --#endregion
--     --#region Human melee
--         animations.thunderhammer_2h_p1_m2 = animations.thunderhammer_2h_p1_m1
--         animations.chainsword_2h_p1_m2 = animations.chainsword_2h_p1_m1
--         animations.forcesword_2h_p1_m2 = animations.forcesword_2h_p1_m1
--         animations.combatknife_p1_m2 = animations.combatknife_p1_m1
--         animations.combatsword_p1_m2 = animations.combatsword_p1_m1
--         animations.combatsword_p1_m3 = animations.combatsword_p1_m1
--         animations.combatsword_p2_m2 = animations.combatsword_p2_m1
--         animations.combatsword_p2_m3 = animations.combatsword_p2_m1
--         animations.combatsword_p3_m2 = animations.combatsword_p3_m1
--         animations.combatsword_p3_m3 = animations.combatsword_p3_m1
--         animations.chainsword_p1_m2 = animations.chainsword_p1_m1
--         animations.forcesword_p1_m2 = animations.forcesword_p1_m1
--         animations.forcesword_p1_m3 = animations.forcesword_p1_m1
--         animations.combataxe_p1_m2 = animations.combataxe_p1_m1
--         animations.combataxe_p1_m3 = animations.combataxe_p1_m1
--         animations.combataxe_p2_m2 = animations.combataxe_p2_m1
--         animations.combataxe_p2_m3 = animations.combataxe_p2_m1
--         animations.combataxe_p3_m2 = animations.combataxe_p3_m1
--         animations.combataxe_p3_m3 = animations.combataxe_p3_m1
--         animations.powermaul_p1_m2 = animations.powermaul_p1_m1
--     --#endregion
--     --#region Human ranged
--         animations.stubrevolver_p1_m2 = animations.stubrevolver_p1_m1
--         animations.stubrevolver_p1_m3 = animations.stubrevolver_p1_m1
--         animations.forcestaff_p2_m1 = animations.forcestaff_p1_m1
--         animations.forcestaff_p3_m1 = animations.forcestaff_p1_m1
--         animations.forcestaff_p4_m1 = animations.forcestaff_p1_m1
--         animations.laspistol_p1_m2 = animations.laspistol_p1_m1
--         animations.laspistol_p1_m3 = animations.laspistol_p1_m1
--         animations.autogun_p1_m2 = animations.autogun_p1_m1
--         animations.autogun_p1_m3 = animations.autogun_p1_m1
--         animations.autogun_p2_m1 = animations.autogun_p1_m1
--         animations.autogun_p2_m2 = animations.autogun_p1_m1
--         animations.autogun_p2_m3 = animations.autogun_p1_m1
--         animations.autogun_p3_m1 = animations.autogun_p1_m1
--         animations.autogun_p3_m2 = animations.autogun_p1_m1
--         animations.autogun_p3_m3 = animations.autogun_p1_m1
--         animations.shotgun_p1_m2 = animations.shotgun_p1_m1
--         animations.shotgun_p1_m3 = animations.shotgun_p1_m1
--         animations.shotgun_p4_m2 = animations.shotgun_p4_m1
--         animations.shotgun_p4_m3 = animations.shotgun_p4_m1
--         animations.bolter_p1_m2 = animations.bolter_p1_m1
--         animations.bolter_p1_m3 = animations.bolter_p1_m1
--         animations.lasgun_p1_m2 = animations.lasgun_p1_m1
--         animations.lasgun_p1_m3 = animations.lasgun_p1_m1
--         animations.lasgun_p2_m2 = animations.lasgun_p2_m1
--         animations.lasgun_p2_m3 = animations.lasgun_p2_m1
--         animations.lasgun_p3_m2 = animations.lasgun_p3_m1
--         animations.lasgun_p3_m3 = animations.lasgun_p3_m1
--     --#endregion
-- --#endregion

-- local sounds = {
--     [BREED_HUMAN] = human.sounds,
--     [BREED_OGRYN] = ogryn.sounds,
--     ogryn_powermaul_slabshield_p1_m1 = ogryn_powermaul_slabshield_p1_m1.sounds,
--     ogryn_heavystubber_p1_m1 = ogryn_heavystubber_p1_m1.sounds,
--     ogryn_heavystubber_p2_m1 = ogryn_heavystubber_p2_m1.sounds,
--     ogryn_combatblade_p1_m1 = ogryn_combatblade_p1_m1.sounds,
--     shotpistol_shield_p1_m1 = shotpistol_shield_p1_m1.sounds,
--     ogryn_pickaxe_2h_p1_m1 = ogryn_pickaxe_2h_p1_m1.sounds,
--     powermaul_shield_p1_m1 = powermaul_shield_p1_m1.sounds,
--     thunderhammer_2h_p1_m1 = thunderhammer_2h_p1_m1.sounds,
--     ogryn_powermaul_p1_m1 = ogryn_powermaul_p1_m1.sounds,
--     ogryn_rippergun_p1_m1 = ogryn_rippergun_p1_m1.sounds,
--     ogryn_gauntlet_p1_m1 = ogryn_gauntlet_p1_m1.sounds,
--     chainsword_2h_p1_m1 = chainsword_2h_p1_m1.sounds,
--     forcesword_2h_p1_m1 = forcesword_2h_p1_m1.sounds,
--     ogryn_thumper_p1_m1 = ogryn_thumper_p1_m1.sounds,
--     powersword_2h_p1_m1 = powersword_2h_p1_m1.sounds,
--     powermaul_2h_p1_m1 = powermaul_2h_p1_m1.sounds,
--     stubrevolver_p1_m1 = stubrevolver_p1_m1.sounds,
--     combatknife_p1_m1 = combatknife_p1_m1.sounds,
--     combatsword_p1_m1 = combatsword_p1_m1.sounds,
--     combatsword_p2_m1 = combatsword_p2_m1.sounds,
--     combatsword_p3_m1 = combatsword_p3_m1.sounds,
--     boltpistol_p1_m1 = boltpistol_p1_m1.sounds,
--     chainsword_p1_m1 = chainsword_p1_m1.sounds,
--     forcestaff_p1_m1 = forcestaff_p1_m1.sounds,
--     forcesword_p1_m1 = forcesword_p1_m1.sounds,
--     ogryn_club_p1_m1 = ogryn_club_p1_m1.sounds,
--     ogryn_club_p2_m1 = ogryn_club_p2_m1.sounds,
--     powersword_p1_m1 = powersword_p1_m1.sounds,
--     combataxe_p1_m1 = combataxe_p1_m1.sounds,
--     combataxe_p2_m1 = combataxe_p2_m1.sounds,
--     combataxe_p3_m1 = combataxe_p3_m1.sounds,
--     laspistol_p1_m1 = laspistol_p1_m1.sounds,
--     plasmagun_p1_m1 = plasmagun_p1_m1.sounds,
--     powermaul_p1_m1 = powermaul_p1_m1.sounds,
--     powermaul_p2_m1 = powermaul_p2_m1.sounds,
--     chainaxe_p1_m1 = chainaxe_p1_m1.sounds,
--     autogun_p1_m1 = autogun_p1_m1.sounds,
--     shotgun_p1_m1 = shotgun_p1_m1.sounds,
--     shotgun_p2_m1 = shotgun_p2_m1.sounds,
--     shotgun_p4_m1 = shotgun_p4_m1.sounds,
--     bolter_p1_m1 = bolter_p1_m1.sounds,
--     flamer_p1_m1 = flamer_p1_m1.sounds,
--     lasgun_p1_m1 = lasgun_p1_m1.sounds,
--     default = {
--         [WEAPON_MELEE] = {
--             crouching = {
--                 "sfx_grab_weapon",
--                 "sfx_foley_equip",
--             },
--             default = {
--                 "sfx_ads_up",
--                 "sfx_ads_down",
--             },
--             accent = {
--                 "sfx_equip",
--                 "sfx_pull_pin",
--             },
--         },
--         [WEAPON_RANGED] = {
--             crouching = {
--                 "sfx_ads_up",
--                 "sfx_ads_down",
--             },
--             default = {
--                 "sfx_ads_up",
--                 "sfx_ads_down",
--             },
--             accent = {
--                 "sfx_equip",
--                 "sfx_magazine_eject",
--                 "sfx_magazine_insert",
--                 "sfx_reload_lever_pull",
--                 "sfx_reload_lever_release",
--             },
--         },
--     },
-- }

-- --#endregion Copies
--     --#region Ogryn melee
--         sounds.ogryn_combatblade_p1_m2 = sounds.ogryn_combatblade_p1_m1
--         sounds.ogryn_combatblade_p1_m3 = sounds.ogryn_combatblade_p1_m1
--         sounds.ogryn_pickaxe_2h_p1_m2 = sounds.ogryn_pickaxe_2h_p1_m1
--         sounds.ogryn_pickaxe_2h_p1_m3 = sounds.ogryn_pickaxe_2h_p1_m1
--         sounds.powermaul_shield_p1_m2 = sounds.powermaul_shield_p1_m1
--         sounds.ogryn_powermaul_p1_m2 = sounds.ogryn_powermaul_p1_m1
--         sounds.ogryn_powermaul_p1_m3 = sounds.ogryn_powermaul_p1_m1
--         sounds.powersword_2h_p1_m2 = sounds.powersword_2h_p1_m1
--         sounds.ogryn_club_p1_m2 = sounds.ogryn_club_p1_m1
--         sounds.ogryn_club_p1_m3 = sounds.ogryn_club_p1_m1
--         sounds.ogryn_club_p2_m2 = sounds.ogryn_club_p2_m1
--         sounds.ogryn_club_p2_m3 = sounds.ogryn_club_p2_m1
--         sounds.powersword_p1_m2 = sounds.powersword_p1_m1
--         sounds.powersword_p1_m3 = sounds.powersword_p1_m1
--     --#endregion
--     --#region Ogryn ranged
--         sounds.ogryn_heavystubber_p1_m2 = sounds.ogryn_heavystubber_p1_m1
-- 		sounds.ogryn_heavystubber_p1_m3 = sounds.ogryn_heavystubber_p1_m1
--         sounds.ogryn_heavystubber_p2_m2 = sounds.ogryn_heavystubber_p2_m1
-- 		sounds.ogryn_heavystubber_p2_m3 = sounds.ogryn_heavystubber_p2_m1
--         sounds.ogryn_rippergun_p1_m2 = sounds.ogryn_rippergun_p1_m1
-- 		sounds.ogryn_rippergun_p1_m3 = sounds.ogryn_rippergun_p1_m1
--         sounds.ogryn_thumper_p1_m2 = sounds.ogryn_thumper_p1_m1
--     --#endregion
--     --#region Human melee
--         sounds.thunderhammer_2h_p1_m2 = sounds.thunderhammer_2h_p1_m1
--         sounds.chainsword_2h_p1_m2 = sounds.chainsword_2h_p1_m1
--         sounds.forcesword_2h_p1_m2 = sounds.forcesword_2h_p1_m1
--         sounds.combatknife_p1_m2 = sounds.combatknife_p1_m1
--         sounds.combatsword_p1_m2 = sounds.combatsword_p1_m1
--         sounds.combatsword_p1_m3 = sounds.combatsword_p1_m1
--         sounds.combatsword_p2_m2 = sounds.combatsword_p2_m1
--         sounds.combatsword_p2_m3 = sounds.combatsword_p2_m1
--         sounds.combatsword_p3_m2 = sounds.combatsword_p3_m1
--         sounds.combatsword_p3_m3 = sounds.combatsword_p3_m1
--         sounds.chainsword_p1_m2 = sounds.chainsword_p1_m1
--         sounds.forcesword_p1_m2 = sounds.forcesword_p1_m1
--         sounds.forcesword_p1_m3 = sounds.forcesword_p1_m1
--         sounds.combataxe_p1_m2 = sounds.combataxe_p1_m1
--         sounds.combataxe_p1_m3 = sounds.combataxe_p1_m1
--         sounds.combataxe_p2_m2 = sounds.combataxe_p2_m1
--         sounds.combataxe_p2_m3 = sounds.combataxe_p2_m1
--         sounds.combataxe_p3_m2 = sounds.combataxe_p3_m1
--         sounds.combataxe_p3_m3 = sounds.combataxe_p3_m1
--         sounds.powermaul_p1_m2 = sounds.powermaul_p1_m1
--     --#endregion
--     --#region Human ranged
--         sounds.stubrevolver_p1_m2 = sounds.stubrevolver_p1_m1
--         sounds.stubrevolver_p1_m3 = sounds.stubrevolver_p1_m1
--         sounds.forcestaff_p2_m1 = sounds.forcestaff_p1_m1
--         sounds.forcestaff_p3_m1 = sounds.forcestaff_p1_m1
--         sounds.forcestaff_p4_m1 = sounds.forcestaff_p1_m1
--         sounds.laspistol_p1_m2 = sounds.laspistol_p1_m1
--         sounds.laspistol_p1_m3 = sounds.laspistol_p1_m1
--         sounds.autogun_p1_m2 = sounds.autogun_p1_m1
--         sounds.autogun_p1_m3 = sounds.autogun_p1_m1
--         sounds.autogun_p2_m1 = sounds.autogun_p1_m1
--         sounds.autogun_p2_m2 = sounds.autogun_p1_m1
--         sounds.autogun_p2_m3 = sounds.autogun_p1_m1
--         sounds.autogun_p3_m1 = sounds.autogun_p1_m1
--         sounds.autogun_p3_m2 = sounds.autogun_p1_m1
--         sounds.autogun_p3_m3 = sounds.autogun_p1_m1
--         sounds.shotgun_p1_m2 = sounds.shotgun_p1_m1
--         sounds.shotgun_p1_m3 = sounds.shotgun_p1_m1
--         sounds.shotgun_p4_m2 = sounds.shotgun_p4_m1
--         sounds.shotgun_p4_m3 = sounds.shotgun_p4_m1
--         sounds.bolter_p1_m2 = sounds.bolter_p1_m1
--         sounds.bolter_p1_m3 = sounds.bolter_p1_m1
--         sounds.lasgun_p1_m2 = sounds.lasgun_p1_m1
--         sounds.lasgun_p1_m3 = sounds.lasgun_p1_m1
--         sounds.lasgun_p2_m2 = sounds.lasgun_p2_m1
--         sounds.lasgun_p2_m3 = sounds.lasgun_p2_m1
--         sounds.lasgun_p3_m2 = sounds.lasgun_p3_m1
--         sounds.lasgun_p3_m3 = sounds.lasgun_p3_m1
--     --#endregion
-- --#endregion

local momentum = {
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
    ogryn_pickaxe_2h_p1_m1 = ogryn_pickaxe_2h_p1_m1.momentum,
    ogryn_rippergun_p1_m1 = ogryn_rippergun_p1_m1.momentum,
    ogryn_gauntlet_p1_m1 = ogryn_gauntlet_p1_m1.momentum,
    ogryn_thumper_p1_m1 = ogryn_thumper_p1_m1.momentum,
    forcestaff_p1_m1 = forcestaff_p1_m1.momentum,
    default = {
        right = {
            momentum = vector3_box(1, 0, -3),
        },
        left = {
            momentum = vector3_box(0, -3, -3),
        },
    },
}

--#endregion Copies
    --#region Ogryn melee
        momentum.ogryn_pickaxe_2h_p1_m2 = momentum.ogryn_pickaxe_2h_p1_m1
        momentum.ogryn_pickaxe_2h_p1_m3 = momentum.ogryn_pickaxe_2h_p1_m1
    --#endregion
    --#region Ogryn ranged
        momentum.ogryn_rippergun_p1_m2 = momentum.ogryn_rippergun_p1_m1
		momentum.ogryn_rippergun_p1_m3 = momentum.ogryn_rippergun_p1_m1
        momentum.ogryn_thumper_p1_m2 = momentum.ogryn_thumper_p1_m1
    --#endregion
    --#region Human ranged
        momentum.forcestaff_p2_m1 = momentum.forcestaff_p1_m1
        momentum.forcestaff_p3_m1 = momentum.forcestaff_p1_m1
        momentum.forcestaff_p4_m1 = momentum.forcestaff_p1_m1
    --#endregion
--#endregion

local placements = {
    default = "default",
    hip_front = "hip_front",
    hip_back = "hip_back",
    hip_left = "hip_left",
    hip_right = "hip_right",
    leg_left = "leg_left",
    leg_right = "leg_right",
    chest = "chest",
    POCKETABLE_SMALL = "POCKETABLE_SMALL",
    POCKETABLE = "POCKETABLE",
}

placements.backpack = placements.default

-- z = up / down
local placement_camera = {
    default = {
        position = vector3_box(-1.2683889865875244, 2.639409065246582, 1.6318360567092896),
        rotation = 2.5,
        [WEAPON_RANGED] = {
            position = vector3_box(-1.3683889865875244, 2.639409065246582, 1.6318360567092896),
            rotation = 2.5,
        },
        [WEAPON_MELEE] = {
            position = vector3_box(-1.1683889865875244, 2.639409065246582, 1.6318360567092896),
            rotation = 4.5,
        },
    },
    POCKETABLE_SMALL = {
        position = vector3_box(-1.2683889865875244, 2.639409065246582, 1.6318360567092896),
        rotation = 3.5,
    },
    POCKETABLE = {
        position = vector3_box(-1.2683889865875244, 2.639409065246582, 1.6318360567092896),
        rotation = 3.5,
    },
    leg_left = {
        position = vector3_box(-1.1683889865875244, 2.639409065246582, 1.6318360567092896),
        rotation = 1,
    },
    leg_right = {
        position = vector3_box(-1.2683889865875244, 2.639409065246582, 1.6318360567092896),
        rotation = -.5,
    },
    hip_left = {
        position = vector3_box(-1.1683889865875244, 2.639409065246582, 1.6318360567092896),
        rotation = 1.5,
    },
    hip_right = {
        position = vector3_box(-1.2683889865875244, 2.639409065246582, 1.6318360567092896),
        rotation = -1,
    },
    hip_back = {
        position = vector3_box(-1.2683889865875244, 2.639409065246582, 1.6318360567092896),
        rotation = 3.5,
    },
    hip_front = {
        position = vector3_box(-1.2683889865875244, 2.639409065246582, 1.6318360567092896),
        rotation = .5,
    },
    chest = {
        position = vector3_box(-1.2683889865875244, 2.639409065246582, 1.6318360567092896),
        rotation = .5,
    },
}

placement_camera.backpack = placement_camera.default

return {
    sounds = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/utilities/sounds"), --sounds,
    offsets = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/utilities/offsets"), --offsets,
    animations = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/utilities/animations"), --animations,
    backpacks = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/utilities/backpacks"),
    momentum = momentum,
    placements = placements,
    placement_camera = placement_camera,
}
