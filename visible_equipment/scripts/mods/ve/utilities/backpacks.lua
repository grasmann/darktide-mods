local mod = get_mod("visible_equipment")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local vector3_box = Vector3Box
--#endregion

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local backpack_folder = "visible_equipment/scripts/mods/ve/backpacks/"
local backpack_veteran_death_korps_of_krieg_a_var_02 = mod:io_dofile(backpack_folder.."backpack_veteran_death_korps_of_krieg_a_var_02")
local skull_edition_backpack_cadian_c = mod:io_dofile(backpack_folder.."skull_edition_backpack_cadian_c")
local backpack_cadian_b_01_var_01 = mod:io_dofile(backpack_folder.."backpack_cadian_b_01_var_01")
local backpack_psyker_c_01_var_01 = mod:io_dofile(backpack_folder.."backpack_psyker_c_01_var_01")
local backpack_greyfax_a_var_03 = mod:io_dofile(backpack_folder.."backpack_greyfax_a_var_03")
local backpack_zealot_b_var_01 = mod:io_dofile(backpack_folder.."backpack_zealot_b_var_01")
local cadian_d_backpack_set_06 = mod:io_dofile(backpack_folder.."cadian_d_backpack_set_06")
local backpack_cadian_a_var_01 = mod:io_dofile(backpack_folder.."backpack_cadian_a_var_01")
local cadian_c_backpack_set_02 = mod:io_dofile(backpack_folder.."cadian_c_backpack_set_02")
local cadian_d_backpack_set_05 = mod:io_dofile(backpack_folder.."cadian_d_backpack_set_05")
local cadian_c_backpack_set_05 = mod:io_dofile(backpack_folder.."cadian_c_backpack_set_05")
local backpack_zealot_a_var_01 = mod:io_dofile(backpack_folder.."backpack_zealot_a_var_01")
local backpack_psyker_c_var_01 = mod:io_dofile(backpack_folder.."backpack_psyker_c_var_01")
local backpack_psyker_e_var_01 = mod:io_dofile(backpack_folder.."backpack_psyker_e_var_01")
local backpack_psyker_d_var_02 = mod:io_dofile(backpack_folder.."backpack_psyker_d_var_02")
local backpack_skulls_a_var_01 = mod:io_dofile(backpack_folder.."backpack_skulls_a_var_01")
local ogryn_backpack_07_var_01 = mod:io_dofile(backpack_folder.."ogryn_backpack_07_var_01")
local ogryn_backpack_09_var_01 = mod:io_dofile(backpack_folder.."ogryn_backpack_09_var_01")
local ogryn_backpack_12_var_01 = mod:io_dofile(backpack_folder.."ogryn_backpack_12_var_01")
local ogryn_backpack_01_var_01 = mod:io_dofile(backpack_folder.."ogryn_backpack_01_var_01")
local ogryn_backpack_01_var_02 = mod:io_dofile(backpack_folder.."ogryn_backpack_01_var_02")
local ogryn_backpack_03_var_01 = mod:io_dofile(backpack_folder.."ogryn_backpack_03_var_01")
local ogryn_backpack_06_var_01 = mod:io_dofile(backpack_folder.."ogryn_backpack_06_var_01")
local ogryn_backpack_11_var_02 = mod:io_dofile(backpack_folder.."ogryn_backpack_11_var_02")
local ogryn_backpack_02_var_02 = mod:io_dofile(backpack_folder.."ogryn_backpack_02_var_02")
local ogryn_backpack_08_var_02 = mod:io_dofile(backpack_folder.."ogryn_backpack_08_var_02")
local ogryn_backpack_04_var_01 = mod:io_dofile(backpack_folder.."ogryn_backpack_04_var_01")
local ogryn_backpack_02_var_03 = mod:io_dofile(backpack_folder.."ogryn_backpack_02_var_03")
local ogryn_backpack_11_var_01 = mod:io_dofile(backpack_folder.."ogryn_backpack_11_var_01")
local backpack_book_b_candles = mod:io_dofile(backpack_folder.."backpack_book_b_candles")
local backpack_scions_a = mod:io_dofile(backpack_folder.."backpack_scions_a")
local backpack_a_var_02 = mod:io_dofile(backpack_folder.."backpack_a_var_02")
local backpack_b_var_02 = mod:io_dofile(backpack_folder.."backpack_b_var_02")
local backpack_a_var_01 = mod:io_dofile(backpack_folder.."backpack_a_var_01")
local backpack_book_a = mod:io_dofile(backpack_folder.."backpack_book_a")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local WEAPON_MELEE = "WEAPON_MELEE"
local WEAPON_RANGED = "WEAPON_RANGED"

return {
    backpack_veteran_death_korps_of_krieg_a_var_02 = backpack_veteran_death_korps_of_krieg_a_var_02,
    skull_edition_backpack_cadian_c = skull_edition_backpack_cadian_c,
    backpack_cadian_b_01_var_01 = backpack_cadian_b_01_var_01,
    backpack_psyker_c_01_var_01 = backpack_psyker_c_01_var_01,
    backpack_greyfax_a_var_03 = backpack_greyfax_a_var_03,
    backpack_zealot_b_var_01 = backpack_zealot_b_var_01,
    cadian_d_backpack_set_06 = cadian_d_backpack_set_06,
    backpack_cadian_a_var_01 = backpack_cadian_a_var_01,
    cadian_c_backpack_set_02 = cadian_c_backpack_set_02,
    cadian_d_backpack_set_05 = cadian_d_backpack_set_05,
    cadian_c_backpack_set_05 = cadian_c_backpack_set_05,
    backpack_zealot_a_var_01 = backpack_zealot_a_var_01,
    backpack_psyker_c_var_01 = backpack_psyker_c_var_01,
    backpack_psyker_e_var_01 = backpack_psyker_e_var_01,
    backpack_psyker_d_var_02 = backpack_psyker_d_var_02,
    backpack_skulls_a_var_01 = backpack_skulls_a_var_01,
    ogryn_backpack_07_var_01 = ogryn_backpack_07_var_01,
    ogryn_backpack_09_var_01 = ogryn_backpack_09_var_01,
    ogryn_backpack_12_var_01 = ogryn_backpack_12_var_01,
    ogryn_backpack_01_var_01 = ogryn_backpack_01_var_01,
    ogryn_backpack_01_var_02 = ogryn_backpack_01_var_02,
    ogryn_backpack_03_var_01 = ogryn_backpack_03_var_01,
    ogryn_backpack_06_var_01 = ogryn_backpack_06_var_01,
    ogryn_backpack_11_var_02 = ogryn_backpack_11_var_02,
    ogryn_backpack_02_var_02 = ogryn_backpack_02_var_02,
    ogryn_backpack_08_var_02 = ogryn_backpack_08_var_02,
    ogryn_backpack_04_var_01 = ogryn_backpack_04_var_01,
    ogryn_backpack_02_var_03 = ogryn_backpack_02_var_03,
    ogryn_backpack_11_var_01 = ogryn_backpack_11_var_01,
    backpack_book_b_candles = backpack_book_b_candles,
    backpack_scions_a = backpack_scions_a,
    backpack_a_var_02 = backpack_a_var_02,
    backpack_b_var_02 = backpack_b_var_02,
    backpack_a_var_01 = backpack_a_var_01,
    backpack_book_a = backpack_book_a,
    default = {
        [WEAPON_MELEE] = {
            right = {
                position = vector3_box(0, 0, 0),
                rotation = vector3_box(0, 0, 0),
            },
            left = {
                position = vector3_box(0, 0, 0),
                rotation = vector3_box(0, 0, 0),
            },
        },
        [WEAPON_RANGED] = {
            right = {
                position = vector3_box(0, 0, 0),
                rotation = vector3_box(0, 0, 0),
            },
            left = {
                position = vector3_box(0, 0, 0),
                rotation = vector3_box(0, 0, 0),
            },
        },
    },
}