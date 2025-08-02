local mod = get_mod("weapon_customization")

--#region Require
    -- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
    -- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
    -- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

    local SoundEventAliases = mod:original_require("scripts/settings/sound/player_character_sound_event_aliases")
--#endregion

--#region Performance
    -- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
    -- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
    -- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

    local Unit = Unit
    local vector3 = Vector3
    local vector3_one = vector3.one
    local unit_alive = Unit.alive
    local Quaternion = Quaternion
    local vector3_box = Vector3Box
    local unit_local_position = Unit.local_position
    local unit_set_local_scale = Unit.set_local_scale
    local quaternion_to_vector = Quaternion.to_vector
    local quaternion_from_vector = Quaternion.from_vector
    local unit_set_local_position = Unit.set_local_position
    local unit_set_local_rotation = Unit.set_local_rotation
    local quaternion_to_euler_angles_xyz = Quaternion.to_euler_angles_xyz
    local quaternion_from_euler_angles_xyz = Quaternion.from_euler_angles_xyz
    local quaternion_from_euler_angles_xyz = Quaternion.from_euler_angles_xyz
--#endregion

--#region Data
    -- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
    -- #####  ││├─┤ │ ├─┤ #################################################################################################
    -- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

    local REFERENCE = "weapon_customization"
    local WEAPON_MELEE = "WEAPON_MELEE"
    local WEAPON_RANGED = "WEAPON_RANGED"
--#endregion

--#region Gear nodes
    -- ##### ┌─┐┌─┐┌─┐┬─┐  ┌┐┌┌─┐┌┬┐┌─┐┌─┐ ################################################################################
    -- ##### │ ┬├┤ ├─┤├┬┘  ││││ │ ││├┤ └─┐ ################################################################################
    -- ##### └─┘└─┘┴ ┴┴└─  ┘└┘└─┘─┴┘└─┘└─┘ ################################################################################

    mod.gear_node_offsets = {
        human = {
            default = {
                WEAPON_RANGED = {
                    hips_front = {position = vector3_box(.06, -.003, -.006), rotation = vector3_box(5.3, -33, 102), scale = vector3_box(vector3_one())},
                    hips_back = {position = vector3_box(.12, -.02, -.045), rotation = vector3_box(12, -33, 96), scale = vector3_box(vector3_one())},
                    hips_left = {position = vector3_box(-.04, .17, -.04), rotation = vector3_box(51, -9, 160), scale = vector3_box(vector3_one())},
                    hips_right = {position = vector3_box(.06, .15, -.05), rotation = vector3_box(51, -9, -160), scale = vector3_box(vector3_one())},
                    leg_left = {position = vector3_box(.12, -.002, -.15), rotation = vector3_box(-87, 13, -85), scale = vector3_box(vector3_one())},
                    leg_right = {position = vector3_box(-.12, -.002, .15), rotation = vector3_box(105, -14, 87), scale = vector3_box(vector3_one())},
                    chest = {position = vector3_box(0, -.05, -.1), rotation = vector3_box(-7, 38, 99), scale = vector3_box(vector3_one())},
                    back_left = {position = vector3_box(.02, .04, .084), rotation = vector3_box(171, 10, 88), scale = vector3_box(vector3_one())},
                    back_right = {position = vector3_box(.02, .04, -.05), rotation = vector3_box(12, 10, 91), scale = vector3_box(vector3_one())},
                    backpack_left = {position = vector3_box(.12, -.03, -.11), rotation = vector3_box(-59, 10, 93), scale = vector3_box(vector3_one())},
                    backpack_right = {position = vector3_box(.12, -.03, .11), rotation = vector3_box(-136, 10, 93), scale = vector3_box(vector3_one())},
                },
                WEAPON_MELEE = {
                    hips_front = {position = vector3_box(.075, .03, .041), rotation = vector3_box(178, -65, -102), scale = vector3_box(vector3_one())},
                    hips_back = {position = vector3_box(.075, .033, .066), rotation = vector3_box(178, -65, -102), scale = vector3_box(vector3_one())},
                    hips_left = {position = vector3_box(-.09, .09, .03), rotation = vector3_box(146, -8.1, 170), scale = vector3_box(vector3_one())},
                    hips_right = {position = vector3_box(.09, .09, -.03), rotation = vector3_box(146, 8.1, -170), scale = vector3_box(vector3_one())},
                    leg_left = {position = vector3_box(.16, -.002, -.15), rotation = vector3_box(172, 85, 12), scale = vector3_box(vector3_one())},
                    leg_right = {position = vector3_box(-.16, -.002, .15), rotation = vector3_box(-42, -85, -46), scale = vector3_box(vector3_one())},
                    chest = {position = vector3_box(.18, .034, -.18), rotation = vector3_box(8.1, -54, 102), scale = vector3_box(vector3_one())},
                    back_left = {position = vector3_box(.15, .017, .05), rotation = vector3_box(-123, -80, 156), scale = vector3_box(vector3_one())},
                    back_right = {position = vector3_box(.15, .017, -.05), rotation = vector3_box(-65, -80, -147), scale = vector3_box(vector3_one())},
                    backpack_left = {position = vector3_box(.12, -.009, -.09), rotation = vector3_box(-44, -79, 105), scale = vector3_box(vector3_one())},
                    backpack_right = {position = vector3_box(.12, -.009, .09), rotation = vector3_box(-146, -79, -140), scale = vector3_box(vector3_one())},
                },
            },
        },
        ogryn = {
            default = {
                WEAPON_RANGED = {
                    hips_front = {position = vector3_box(.61, .09, .35), rotation = vector3_box(24, -28, 108), scale = vector3_box(vector3_one())},
                    hips_back = {position = vector3_box(.2, -.03, .033), rotation = vector3_box(12, -22, 96), scale = vector3_box(vector3_one())},
                    hips_left = {position = vector3_box(.01, .5, .4), rotation = vector3_box(39, 11, 155), scale = vector3_box(vector3_one())},
                    hips_right = {position = vector3_box(.01, .5, .4), rotation = vector3_box(39, 1.5, -168), scale = vector3_box(vector3_one())},
                    leg_left = {position = vector3_box(-.32, .15, -.3), rotation = vector3_box(-105, -4.5, -85), scale = vector3_box(vector3_one())},
                    leg_right = {position = vector3_box(.32, -.15, .3), rotation = vector3_box(105, 0, 90), scale = vector3_box(vector3_one())},
                    chest = {position = vector3_box(.6, .01, -.62), rotation = vector3_box(-13.6, 60, 104), scale = vector3_box(vector3_one())},
                    back_left = {position = vector3_box(.6, .12, .15), rotation = vector3_box(11.4, .5, 99), scale = vector3_box(vector3_one())},
                    back_right = {position = vector3_box(.6, .12, -.15), rotation = vector3_box(-157, -10, 91), scale = vector3_box(vector3_one())},
                    backpack_left = {position = vector3_box(.7, .05, -.37), rotation = vector3_box(-25, 10, 87), scale = vector3_box(vector3_one())},
                    backpack_right = {position = vector3_box(.7, .17, .22), rotation = vector3_box(-132, .37, 89), scale = vector3_box(vector3_one())},
                },
                WEAPON_MELEE = {
                    hips_front = {position = vector3_box(.24, -.05, .4), rotation = vector3_box(178, -65, -102), scale = vector3_box(vector3_one())},
                    hips_back = {position = vector3_box(.2, .06, .18), rotation = vector3_box(164, -65, -114), scale = vector3_box(vector3_one())},
                    hips_left = {position = vector3_box(-.2, .19, .15), rotation = vector3_box(146, -19, -12), scale = vector3_box(vector3_one())},
                    hips_right = {position = vector3_box(.2, .19, .15), rotation = vector3_box(146, 19, -170), scale = vector3_box(vector3_one())},
                    leg_left = {position = vector3_box(.16, .15, -.27), rotation = vector3_box(61, 85, 121), scale = vector3_box(vector3_one())},
                    leg_right = {position = vector3_box(-.16, -.15, .27), rotation = vector3_box(-147, -85, 29), scale = vector3_box(vector3_one())},
                    chest = {position = vector3_box(.32, -.015, -.13), rotation = vector3_box(5, -43, 99), scale = vector3_box(vector3_one())},
                    back_left = {position = vector3_box(.15, .1, .05), rotation = vector3_box(-123, -80, 156), scale = vector3_box(vector3_one())},
                    back_right = {position = vector3_box(.15, .1, -.05), rotation = vector3_box(-65, -80, -147), scale = vector3_box(vector3_one())},
                    backpack_left = {position = vector3_box(.38, .12, -.18), rotation = vector3_box(-92, -78, -114), scale = vector3_box(vector3_one())},
                    backpack_right = {position = vector3_box(.38, .15, .28), rotation = vector3_box(-141, -79, 60), scale = vector3_box(vector3_one())},
                },
            }
        },
        ogryn_pickaxe_2h_p1_m1 = {
            supported_gear_nodes = {
                "backpack_left",
                "backpack_right",
                "back_left",
                "back_right",
            }
        },
        forcestaff_p1_m1 = {
            supported_gear_nodes = {
                "backpack_left",
                "backpack_right",
                "back_left",
                "back_right",
            }
        },
    }
    --#region Copies
        mod.gear_node_offsets.ogryn_pickaxe_2h_p1_m2 = mod.gear_node_offsets.ogryn_pickaxe_2h_p1_m1
        mod.gear_node_offsets.ogryn_pickaxe_2h_p1_m3 = mod.gear_node_offsets.ogryn_pickaxe_2h_p1_m1
        mod.gear_node_offsets.forcestaff_p2_m1 = mod.gear_node_offsets.forcestaff_p1_m1
        mod.gear_node_offsets.forcestaff_p3_m1 = mod.gear_node_offsets.forcestaff_p1_m1
        mod.gear_node_offsets.forcestaff_p4_m1 = mod.gear_node_offsets.forcestaff_p1_m1
    --#endregion
--#endregion

--#region Loading screen
    -- ##### ┬  ┌─┐┌─┐┌┬┐┬┌┐┌┌─┐  ┌─┐┌─┐┬─┐┌─┐┌─┐┌┐┌ ######################################################################
    -- ##### │  │ │├─┤ │││││││ ┬  └─┐│  ├┬┘├┤ ├┤ │││ ######################################################################
    -- ##### ┴─┘└─┘┴ ┴─┴┘┴┘└┘└─┘  └─┘└─┘┴└─└─┘└─┘┘└┘ ######################################################################

    mod.visible_equipment_loading_offsets = {
        melee_big_angle = {
            {position = vector3_box(2, -.4, 3.2), rotation = vector3_box(200, 0, -40), scale = vector3_box(3, 3, 3),    ----------
                step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, 30),                                --[]--[]--
                position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --XX--[]--
                step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------

            {position = vector3_box(2, .4, 3.2), rotation = vector3_box(200, 0, 40), scale = vector3_box(3, 3, 3),      ----------
                step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, -30),                               --[]--[]--
                position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --[]--XX--
                step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------

            {position = vector3_box(2, -.4, 3.2), rotation = vector3_box(200, 0, -40), scale = vector3_box(3, 3, 3),    ----------
                step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, 30),                                --XX--[]-- ?
                position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --[]--[]--
                step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------
            
            {position = vector3_box(2, .4, 3.2), rotation = vector3_box(200, 0, 40), scale = vector3_box(3, 3, 3),      ----------
                step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, -30),                               --[]--XX-- ?
                position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --[]--[]--
                step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------
        },
        melee_big = {},
        melee_medium = {
            {position = vector3_box(2, -.5, 2.75), rotation = vector3_box(200, 0, -40), scale = vector3_box(3, 3, 3),   ----------
                step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, 30),                                --[]--[]--
                position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --XX--[]--
                step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------

            {position = vector3_box(2, .5, 2.75), rotation = vector3_box(200, 0, 40), scale = vector3_box(3, 3, 3),     ----------
                step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, -30),                               --[]--[]--
                position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --[]--XX--
                step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------

            {position = vector3_box(2, -.5, 2.75), rotation = vector3_box(200, 0, -40), scale = vector3_box(3, 3, 3),   ----------
                step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, 30),                                --XX--[]-- ?
                position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --[]--[]--
                step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------
            
            {position = vector3_box(2, .5, 2.75), rotation = vector3_box(200, 0, 40), scale = vector3_box(3, 3, 3),     ----------
                step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, -30),                               --[]--XX-- ?
                position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --[]--[]--
                step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------
        },

        ranged_bulky = {
            {position = vector3_box(2, .4, 2), rotation = vector3_box(0, 0, -40), scale = vector3_box(3, 3, 3),         ----------
                step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, 30),                                --[]--[]--
                position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --XX--[]--
                step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------

            {position = vector3_box(2, .4, 2), rotation = vector3_box(0, 0, 40), scale = vector3_box(3, 3, 3),          ----------
                step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, -30),                               --[]--[]--
                position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --[]--XX--
                step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------

            {position = vector3_box(2, .4, 2), rotation = vector3_box(0, 0, -40), scale = vector3_box(3, 3, 3),         ----------
                step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, 30),                                --XX--[]-- ?
                position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --[]--[]--
                step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------
            
            {position = vector3_box(2, .4, 2), rotation = vector3_box(0, 0, 40), scale = vector3_box(3, 3, 3),          ----------
                step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, -30),                               --[]--XX-- ?
                position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --[]--[]--
                step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------
        },
        ranged_huge = {
            {position = vector3_box(2, -.3, 3.75), rotation = vector3_box(200, 0, -40), scale = vector3_box(3, 3, 3),   ----------
                step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, 30),                                --[]--[]--
                position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --XX--[]--
                step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------

            {position = vector3_box(2, .3, 3.75), rotation = vector3_box(200, 0, 40), scale = vector3_box(3, 3, 3),     ----------
                step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, -30),                               --[]--[]--
                position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --[]--XX--
                step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------

            {position = vector3_box(2, -.3, 3.75), rotation = vector3_box(200, 0, -40), scale = vector3_box(3, 3, 3),   ----------
                step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, 30),                                --XX--[]-- ?
                position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --[]--[]--
                step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------
            
            {position = vector3_box(2, .3, 3.75), rotation = vector3_box(200, 0, 40), scale = vector3_box(3, 3, 3),     ----------
                step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, -30),                               --[]--XX-- ?
                position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --[]--[]--
                step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------
        },
        ranged_medium = {},
        ranged_small = {},

        default = {
            -- position: x = -forward / +backward | y = -left / +right | z = -down / +up
            -- rotation: x = up / down | y = roll | z = left / right
            {position = vector3_box(0, 6, 5), rotation = vector3_box(0, 0, 180), scale = vector3_box(3, 3, 3),
                step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, 0),
                position2 = vector3_box(0, 6, 5), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(3, 3, 3),
                step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},
            {position = vector3_box(0, 6, 5), rotation = vector3_box(0, 0, 180), scale = vector3_box(3, 3, 3),
                step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, 0),
                position2 = vector3_box(0, 6, 5), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(3, 3, 3),
                step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},
            {position = vector3_box(0, -6, 5), rotation = vector3_box(0, 0, 180), scale = vector3_box(3, 3, 3),
                step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, 0),
                position2 = vector3_box(0, -6, 5), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(3, 3, 3),
                step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},
            {position = vector3_box(0, -6, 5), rotation = vector3_box(0, 0, 180), scale = vector3_box(3, 3, 3),
                step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, 0),
                position2 = vector3_box(0, -6, 5), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(3, 3, 3),
                step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},
        },
    }
--#endregion

--#region Old Offsets
    -- ##### ┌─┐┌─┐┌─┐┌─┐┌─┐┌┬┐┌─┐ ########################################################################################
    -- ##### │ │├┤ ├┤ └─┐├┤  │ └─┐ ########################################################################################
    -- ##### └─┘└  └  └─┘└─┘ ┴ └─┘ ########################################################################################

    mod.visible_equipment_offsets = {
        ogryn = {
            WEAPON_MELEE = {
                default = {position = vector3_box(.5, .5, -.15), rotation = vector3_box(170, -85, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .003, 0), step_rotation = vector3_box(-1.5, 1.5, 5)},
                backpack = {position = vector3_box(.65, .5, .4), rotation = vector3_box(180, -15, 135), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, -2.5, 5)},
                center_mass = vector3_box(0, 0, -.6),
                loading = mod.visible_equipment_loading_offsets.melee_medium,
            },
            WEAPON_RANGED = {
                default = {position = vector3_box(.4, .55, .4), rotation = vector3_box(200, -10, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.03, .0075, .01), step_rotation = vector3_box(-2, 2.5, -2.5)},
                backpack = {position = vector3_box(-.2, .6, .7), rotation = vector3_box(200, 60, 70), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(.02, -.03, -.02), step_rotation = vector3_box(2.5, -2.5, .5)},
                loading = mod.visible_equipment_loading_offsets.ranged_bulky,
            },
        },
        human = {
            WEAPON_MELEE = {
                default = {position = vector3_box(.3, .25, -.1), rotation = vector3_box(180, -90, 110), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
                backpack = {position = vector3_box(.4, .25, -.225), rotation = vector3_box(120, -95, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
                center_mass = vector3_box(0, 0, -.075),
                loading = mod.visible_equipment_loading_offsets.melee_medium,
                step_sounds = {SoundEventAliases.sfx_equip_03.events.combatknife_p1_m2},
            },
            WEAPON_RANGED = {
                default = {position = vector3_box(.3, .22, .125), rotation = vector3_box(200, -10, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0075, .005), step_rotation = vector3_box(-5, -2.5, -5)},
                backpack = {position = vector3_box(.3, .22, .25), rotation = vector3_box(240, 10, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0075, .005), step_rotation = vector3_box(-5, -2.5, -5)},
                -- center_mass = vector3_box(0, -.3, 0),
                loading = mod.visible_equipment_loading_offsets.default,
            },
        },
        --#region Ogryn Guns
            ogryn_heavystubber_p1_m1 = {
                default = {position = vector3_box(.8, .45, .15), rotation = vector3_box(200, -10, 100), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .003, .005), step_rotation = vector3_box(-1, 1.5, -1.5)},
                backpack = {position = vector3_box(.1, .6, .8), rotation = vector3_box(200, 60, 70), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(.02, -.03, -.04), step_rotation = vector3_box(2.5, -2.5, .5)},
                center_mass = vector3_box(0, -.6, .2),
                loading = mod.visible_equipment_loading_offsets.ranged_bulky,
                init = function(visible_equipment_extension, slot)
                    local slot_info_id = mod.gear_settings:slot_info_id(slot.item)
                    local slot_infos = mod:persistent_table(REFERENCE).attachment_slot_infos
                    local attachment_slot_info = slot_infos and slot_infos[slot_info_id]
                    if attachment_slot_info then
                        local receiver = attachment_slot_info.attachment_slot_to_unit["receiver"]
                        local attachment = attachment_slot_info.unit_to_attachment_name[receiver]
                        if receiver and unit_alive(receiver) then
                            local node_index = 17
                            if attachment == "receiver_04" then node_index = 21 end
                            if attachment == "receiver_05" or attachment == "receiver_06" or attachment == "receiver_07" then node_index = 15 end
                            local rot = vector3(0, 0, 90)
                            local rotation = quaternion_from_euler_angles_xyz(rot[1], rot[2], rot[3])
                            unit_set_local_rotation(receiver, node_index, rotation)
                        end
                    end
                end,
            },
            ogryn_heavystubber_p2_m1 = {
                default = {position = vector3_box(.8, .45, .15), rotation = vector3_box(200, -10, 100), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .003, .005), step_rotation = vector3_box(-1, 1.5, -1.5)},
                backpack = {position = vector3_box(.1, .6, .8), rotation = vector3_box(200, 60, 70), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(.02, -.03, -.04), step_rotation = vector3_box(2.5, -2.5, .5)},
                center_mass = vector3_box(0, -.6, .2),
                loading = mod.visible_equipment_loading_offsets.ranged_bulky,
                init = function(visible_equipment_extension, slot)
                    local slot_info_id = mod.gear_settings:slot_info_id(slot.item)
                    local slot_infos = mod:persistent_table(REFERENCE).attachment_slot_infos
                    local attachment_slot_info = slot_infos and slot_infos[slot_info_id]
                    if attachment_slot_info then
                        local receiver = attachment_slot_info.attachment_slot_to_unit["receiver"]
                        local attachment = attachment_slot_info.unit_to_attachment_name[receiver]
                        if receiver and unit_alive(receiver) then
                            local node_index = 15
                            -- if attachment == "receiver_04" then node_index = 21 end
                            -- if attachment == "receiver_05" or attachment == "receiver_06" or attachment == "receiver_07" then node_index = 15 end
                            local rot = vector3(0, 0, 90)
                            local rotation = quaternion_from_euler_angles_xyz(rot[1], rot[2], rot[3])
                            unit_set_local_rotation(receiver, node_index, rotation)
                        end
                    end
                end,
            },
            ogryn_rippergun_p1_m1 = {
                default = {position = vector3_box(.4, .55, .4), rotation = vector3_box(200, -10, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .003, .005), step_rotation = vector3_box(-1, 1.5, -1.5)},
                backpack = {position = vector3_box(-.2, .5, .7), rotation = vector3_box(200, 60, 70), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(.02, -.03, -.04), step_rotation = vector3_box(2.5, -2.5, .5)},
                center_mass = vector3_box(0, -.3, 0),
                loading = mod.visible_equipment_loading_offsets.ranged_bulky,
                init = function(visible_equipment_extension, slot)
                    -- Get slot info
                    local slot_info_id = mod.gear_settings:slot_info_id(slot.item)
                    local slot_infos = mod:persistent_table(REFERENCE).attachment_slot_infos
                    local attachment_slot_info = slot_infos and slot_infos[slot_info_id]
                    if attachment_slot_info then
                        local handle = attachment_slot_info.attachment_slot_to_unit["handle"]
                        local attachment = attachment_slot_info.unit_to_attachment_name[handle]
                        if handle and unit_alive(handle) then
                            local node_index = 6
                            if attachment == "handle_04" then node_index = 3 end
                            local rot = vector3(0, 0, 90)
                            local rotation = quaternion_from_euler_angles_xyz(rot[1], rot[2], rot[3])
                            unit_set_local_rotation(handle, node_index, rotation)
                        end
                    end
                end,
            },
            ogryn_gauntlet_p1_m1 = {
                default = {position = vector3_box(.05, .4, .8), rotation = vector3_box(20, 10, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .003, .005), step_rotation = vector3_box(-1, 1.5, -1.5)},
                backpack = {position = vector3_box(-.5, .5, .4), rotation = vector3_box(200, -120, 110), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(.02, -.03, -.04), step_rotation = vector3_box(2.5, -2.5, .5)},
                center_mass = vector3_box(0, .1, .3),
                loading = mod.visible_equipment_loading_offsets.ranged_bulky,
            },
            ogryn_thumper_p1_m1 = {
                default = {position = vector3_box(.3, .45, .5), rotation = vector3_box(200, -10, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.03, .0075, .01), step_rotation = vector3_box(2.5, 2.5, -5)},
                backpack = {position = vector3_box(-.2, .4, .5), rotation = vector3_box(200, 60, 70), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(.02, -.03, -.02), step_rotation = vector3_box(2.5, -2.5, .5)},
                center_mass = vector3_box(0, -.1, -.1),
                loading = mod.visible_equipment_loading_offsets.ranged_bulky,
                step_sounds = {SoundEventAliases.sfx_ads_up.events.ogryn_thumper_p1_m1},
            },
        --#endregion
        --#region Ogryn Melee
            ogryn_combatblade_p1_m1 = {
                default = {position = vector3_box(.5, .5, -.15), rotation = vector3_box(170, -85, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .003, 0), step_rotation = vector3_box(-1.5, 1.5, 5)},
                backpack = {position = vector3_box(.65, .5, .4), rotation = vector3_box(180, -15, 135), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, -2.5, 5)},
                center_mass = vector3_box(0, 0, -.2),
                loading = mod.visible_equipment_loading_offsets.default,
            },
            ogryn_powermaul_p1_m1 = {
                default = {position = vector3_box(.5, .5, -.15), rotation = vector3_box(170, -85, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.03, .0075, 0), step_rotation = vector3_box(2.5, -2.5, 5)},
                backpack = {position = vector3_box(.65, .5, .4), rotation = vector3_box(180, -15, 135), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, -2.5, 5)},
                loading = mod.visible_equipment_loading_offsets.melee_medium,
            },
            ogryn_club_p1_m1 = {
                default = {position = vector3_box(.5, .5, -.15), rotation = vector3_box(170, -85, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .003, 0), step_rotation = vector3_box(-1.5, 1.5, 5)},
                backpack = {position = vector3_box(.65, .5, .4), rotation = vector3_box(180, -15, 135), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, -2.5, 5)},
                center_mass = vector3_box(0, 0, -.4),
                loading = mod.visible_equipment_loading_offsets.melee_medium,
            },
            ogryn_club_p2_m1 = {
                default = {position = vector3_box(.5, .5, -.15), rotation = vector3_box(170, -85, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .003, 0), step_rotation = vector3_box(-1.5, 1.5, 5)},
                backpack = {position = vector3_box(.65, .5, .4), rotation = vector3_box(180, -15, 135), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, -2.5, 5)},
                center_mass = vector3_box(0, 0, -.2),
                loading = mod.visible_equipment_loading_offsets.melee_medium,
            },
            ogryn_powermaul_slabshield_p1_m1 = {
                default = {position = vector3_box(0, .4, -.15), rotation = vector3_box(170, -85, 120), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.03, .0075, 0), step_rotation = vector3_box(-2.5, 1, 1.5),
                    position2 = vector3_box(.2, .45, -.2), rotation2 = vector3_box(20, 90, 70), scale2 = vector3_box(1, 1, 1),
                    step_move2 = vector3_box(-.01, 0, 0), step_rotation2 = vector3_box(.5, 0, -.5)},
                backpack = {position = vector3_box(.65, .5, 0), rotation = vector3_box(180, -15, 120), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(-2.5, 1, 1.5),
                    position2 = vector3_box(.2, .6, -.25), rotation2 = vector3_box(20, 90, 60), scale2 = vector3_box(1, 1, 1),
                    step_move2 = vector3_box(-.01, 0, 0), step_rotation2 = vector3_box(2.5, 0, -2.5)},
                loading = mod.visible_equipment_loading_offsets.melee_medium,
                step_sounds = {SoundEventAliases.sfx_equip.events.default},
                step_sounds2 = {
                    SoundEventAliases.sfx_weapon_foley_left_hand_01.events.ogryn_powermaul_slabshield_p1_m1,
                    SoundEventAliases.sfx_weapon_foley_left_hand_02.events.ogryn_powermaul_slabshield_p1_m1,
                },
                wield = function(visible_equipment_extension, slot)
                    visible_equipment_extension:position_equipment()
                end,
            },
            ogryn_pickaxe_2h_p1_m1 = {
                default = {position = vector3_box(.15, .55, -.29), rotation = vector3_box(-33, 90, -150), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0075, -.005), step_rotation = vector3_box(-1.5, -2.5, -1.5)},
                backpack = {position = vector3_box(.15, .56, -.43), rotation = vector3_box(75, 90, 65), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0075, -.005), step_rotation = vector3_box(-1.5, -2.5, -1.5)},
                center_mass = vector3_box(0, 0, -1.25),
                loading = mod.visible_equipment_loading_offsets.melee_medium,
                step_sounds = {SoundEventAliases.sfx_equip.events.default},
                step_sounds2 = {
                    SoundEventAliases.sfx_weapon_foley_left_hand_01.events.ogryn_powermaul_slabshield_p1_m1,
                    SoundEventAliases.sfx_weapon_foley_left_hand_02.events.ogryn_powermaul_slabshield_p1_m1,
                },
            },
        --#endregion
        --#region Guns
            -- autogun_p1_m1 = {
            --     default = {
            --         position = vector3_box(.3, .22, .125), rotation = vector3_box(200, -10, 90), scale = vector3_box(1, 1, 1),
            --         step_move = vector3_box(-.01, .0075, .005), step_rotation = vector3_box(-5, -2.5, -5),
            --         -- center_mass = vector3_box(0, .128, .044)
            --     },
            --     backpack = {position = vector3_box(.1, .3, .18), rotation = vector3_box(230, 10, 90), scale = vector3_box(1, 1, 1),
            --         step_move = vector3_box(-.01, .0075, .005), step_rotation = vector3_box(-5, -2.5, -5),
            --         -- center_mass = vector3_box(0, .128, .044)
            --     },
            --     loading = mod.visible_equipment_loading_offsets.default,
            -- },
            autopistol_p1_m1 = {
                default = {position = vector3_box(.1, .22, .125), rotation = vector3_box(200, -10, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0075, .01), step_rotation = vector3_box(-5, -2.5, -5)},
                backpack = {position = vector3_box(.1, .22, .25), rotation = vector3_box(240, 10, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0075, .01), step_rotation = vector3_box(-5, -2.5, -5)},
                loading = mod.visible_equipment_loading_offsets.default,
            },
            forcestaff_p1_m1 = {
                default = {position = vector3_box(.3, .22, .125), rotation = vector3_box(140, 83, 40), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.02, .0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
                backpack = {position = vector3_box(.3, .22, .175), rotation = vector3_box(200, 100, 0), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
                loading = mod.visible_equipment_loading_offsets.ranged_huge,
            },
            shotgun_p4_m1 = {
                default = {position = vector3_box(.3, .25, .125), rotation = vector3_box(180, -10, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, 0, 0), step_rotation = vector3_box(2.5, -2.5, 0)},
                backpack = {position = vector3_box(.3, .25, .25), rotation = vector3_box(200, 0, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, 0, 0), step_rotation = vector3_box(2.5, -2.5, 0)},
                -- center_mass = vector3_box(0, -.1, -.025),
                loading = mod.visible_equipment_loading_offsets.default,
            },
            flamer_p1_m1 = {
                default = {position = vector3_box(.3, .22, .125), rotation = vector3_box(200, -10, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0075, .005), step_rotation = vector3_box(-5, -2.5, -5)},
                backpack = {position = vector3_box(.3, .22, .25), rotation = vector3_box(240, 10, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, 0, 0), step_rotation = vector3_box(2.5, -2.5, 0)},
                loading = mod.visible_equipment_loading_offsets.default,
                -- step_sounds = {SoundEventAliases.sfx_weapon_locomotion.events.flamer_p1_m1},
                step_sounds = {SoundEventAliases.sfx_ads_up.events.default},
            },
            stubrevolver_p1_m1 = {
                default = {position = vector3_box(-.01, .2, .1), rotation = vector3_box(30, -10, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.0025, -.01, .005), step_rotation = vector3_box(-2.5, -2.5, 2.5)},
                backpack = {position = vector3_box(-.09, .21, .1), rotation = vector3_box(180, 10, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0075, .0025), step_rotation = vector3_box(-1.5, -2.5, -5)},
                loading = mod.visible_equipment_loading_offsets.default,
                -- step_sounds = {SoundEventAliases.sfx_equip.events.stubrevolver_p1_m1},
                -- step_sounds = {SoundEventAliases.sfx_ads_up.events.stubrevolver_p1_m1},
                step_sounds = {SoundEventAliases.sfx_ads_up.events.default},
                attach_node = "j_spine1",
                -- step_sounds = {SoundEventAliases.sfx_weapon_revolver_open.events.stubrevolver_p1_m1},
                --sfx_weapon_revolver_close
                --sfx_weapon_eject_ammo
            },
            laspistol_p1_m1 = {
                default = {position = vector3_box(.1, .22, .125), rotation = vector3_box(200, -10, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0075, .01), step_rotation = vector3_box(-5, -2.5, -5)},
                backpack = {position = vector3_box(.1, .22, .25), rotation = vector3_box(240, 10, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0075, .01), step_rotation = vector3_box(-5, -2.5, -5)},
                loading = mod.visible_equipment_loading_offsets.default,
            },
            plasmagun_p1_m1 = {
                default = {position = vector3_box(.3, .25, .125), rotation = vector3_box(180, -10, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, 0, 0), step_rotation = vector3_box(2.5, -2.5, 0)},
                backpack = {position = vector3_box(.4, .25, .25), rotation = vector3_box(200, 0, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, 0, 0), step_rotation = vector3_box(2.5, -2.5, 0)},
                loading = mod.visible_equipment_loading_offsets.default,
                -- step_sounds = {SoundEventAliases.sfx_weapon_locomotion.events.flamer_p1_m1},
            },
            bolter_p1_m1 = {
                default = {position = vector3_box(.3, .25, .125), rotation = vector3_box(180, -10, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, 0, 0), step_rotation = vector3_box(2.5, -2.5, 0)},
                backpack = {position = vector3_box(.3, .25, .25), rotation = vector3_box(200, 0, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, 0, 0), step_rotation = vector3_box(2.5, -2.5, 0)},
                loading = mod.visible_equipment_loading_offsets.default,
                -- step_sounds = {SoundEventAliases.sfx_weapon_locomotion.events.flamer_p1_m1},
            },
            -- shotgun_p4_m1 = {
            --     default = {position = vector3_box(.6, .25, .125), rotation = vector3_box(180, -10, 90), scale = vector3_box(1, 1, 1),
            --         step_move = vector3_box(-.01, 0, 0), step_rotation = vector3_box(2.5, -2.5, 0)},
            --     backpack = {position = vector3_box(.3, .25, .25), rotation = vector3_box(200, 0, 90), scale = vector3_box(1, 1, 1),
            --         step_move = vector3_box(-.01, 0, 0), step_rotation = vector3_box(2.5, -2.5, 0)},
            --     loading = mod.visible_equipment_loading_offsets.default,
            --     -- step_sounds = {SoundEventAliases.sfx_weapon_locomotion.events.flamer_p1_m1},
            -- },
        --#endregion
        --#region Melee
            -- combataxe_p3_m1 = {
            --     default = {position = vector3_box(.3, .25, -.1), rotation = vector3_box(180, -90, 110), scale = vector3_box(1, 1, 1),
            --         step_move = vector3_box(-.01, .0125, 0), step_rotation = vector3_box(5, -2.5, 5),
            --         -- center_mass = vector3_box(0, 0, .075)
            --     },
            --     backpack = {position = vector3_box(.2, .23, -.225), rotation = vector3_box(120, -95, 90), scale = vector3_box(1, 1, 1),
            --         step_move = vector3_box(-.01, .0125, 0), step_rotation = vector3_box(5, -2.5, 5),
            --         -- center_mass = vector3_box(0, 0, .075)
            --     },
            --     loading = mod.visible_equipment_loading_offsets.melee_medium,
            --     step_sounds = {SoundEventAliases.sfx_equip.events.ogryn_combatblade_p1_m1, SoundEventAliases.sfx_equip_03.events.combatknife_p1_m2},
            -- },

            -- default = {position = vector3_box(.3, .25, -.1), rotation = vector3_box(180, -90, 110), scale = vector3_box(1, 1, 1),
            --     step_move = vector3_box(-.01, .0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
            -- backpack = {position = vector3_box(.4, .25, -.225), rotation = vector3_box(120, -95, 90), scale = vector3_box(1, 1, 1),
            --     step_move = vector3_box(-.01, .0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
            -- center_mass = vector3_box(0, 0, -.075),

            -- step_move = vector3_box(-.01, 0, 0), step_rotation = vector3_box(2.5, -2.5, 0)

            powermaul_shield_p1_m1 = {
                default = {position = vector3_box(.2, .15, -.1), rotation = vector3_box(180, -90, 110), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0125, 0), step_rotation = vector3_box(0, 2.5, 0),
                    position2 = vector3_box(.2, .2, -.1), rotation2 = vector3_box(0, 90, 80), scale2 = vector3_box(1, 1, 1),
                    step_move2 = vector3_box(-.01, 0, 0), step_rotation2 = vector3_box(2.5, 0, -2.5)},
                backpack = {position = vector3_box(.2, .2, -.15), rotation = vector3_box(120, -95, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0125, 0), step_rotation = vector3_box(0, 2.5, 0),
                    position2 = vector3_box(.2, .25, -.15), rotation2 = vector3_box(20, 90, 70), scale2 = vector3_box(1, 1, 1),
                    step_move2 = vector3_box(-.01, 0, 0), step_rotation2 = vector3_box(2.5, 0, -2.5)},
                loading = mod.visible_equipment_loading_offsets.melee_medium,
                center_mass = vector3_box(0, 0, -.075),
                -- center_mass2 = vector3_box(0, 0, 0.3),
                step_sounds = {SoundEventAliases.sfx_weapon_foley_left_hand_01.events.default},
                step_sounds2 = {
                    -- SoundEventAliases.sfx_push_follow_up.events.powermaul_shield_p1_m1,
                    SoundEventAliases.sfx_weapon_locomotion.events.ogryn_gauntlet_p1_m1,
                    -- SoundEventAliases.sfx_weapon_foley_left_hand_02.events.powermaul_shield_p1_m1,
                },
                -- init = function(visible_equipment_extension, slot)
                --     local slot_info_id = mod.gear_settings:slot_info_id(slot.item)
                --     local slot_infos = mod:persistent_table(REFERENCE).attachment_slot_infos
                --     local attachment_slot_info = slot_infos and slot_infos[slot_info_id]
                --     if attachment_slot_info then
                --         local left = attachment_slot_info.attachment_slot_to_unit["left"]
                --         local attachment = attachment_slot_info.unit_to_attachment_name[left]
                --         mod:echo("left"..tostring(left).." "..attachment)
                --         if left and unit_alive(left) and attachment == "left_03" then
                --             -- unit_set_local_scale(left, 1, vector3(.5, .5, .5))
                --             unit_set_local_position(left, 1, unit_local_position(left, 1) + vector3(0, 0, -.5))
                --         end
                --     end
                -- end,
                wield = function(visible_equipment_extension, slot)
                    visible_equipment_extension:position_equipment()
                end,
            },

            -- default = {position = vector3_box(-.01, .2, .1), rotation = vector3_box(30, -10, 90), scale = vector3_box(1, 1, 1),
            --     step_move = vector3_box(-.0025, -.01, .005), step_rotation = vector3_box(-2.5, -2.5, 2.5)},
            -- backpack = {position = vector3_box(-.09, .21, .1), rotation = vector3_box(180, 10, 90), scale = vector3_box(1, 1, 1),
            --     step_move = vector3_box(-.01, .0075, .0025), step_rotation = vector3_box(-1.5, -2.5, -5)},
            -- loading = mod.visible_equipment_loading_offsets.default,
            -- -- step_sounds = {SoundEventAliases.sfx_equip.events.stubrevolver_p1_m1},
            -- -- step_sounds = {SoundEventAliases.sfx_ads_up.events.stubrevolver_p1_m1},
            -- step_sounds = {SoundEventAliases.sfx_ads_up.events.default},
            -- attach_node = "j_spine1",

            shotpistol_shield_p1_m1 = {
                default = {position = vector3_box(.2, .15, -.1), rotation = vector3_box(180, -90, 110), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0125, 0), step_rotation = vector3_box(0, 2.5, 0),
                    position2 = vector3_box(.2, .2, -.1), rotation2 = vector3_box(0, 90, 80), scale2 = vector3_box(1, 1, 1),
                    step_move2 = vector3_box(-.01, 0, 0), step_rotation2 = vector3_box(2.5, 0, -2.5)},
                backpack = {position = vector3_box(.2, .2, -.15), rotation = vector3_box(120, -95, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0125, 0), step_rotation = vector3_box(0, 2.5, 0),
                    position2 = vector3_box(.2, .25, -.15), rotation2 = vector3_box(20, 90, 70), scale2 = vector3_box(1, 1, 1),
                    step_move2 = vector3_box(-.01, 0, 0), step_rotation2 = vector3_box(2.5, 0, -2.5)},
                loading = mod.visible_equipment_loading_offsets.melee_medium,
                center_mass = vector3_box(0, 0, -.075),
                step_sounds = {SoundEventAliases.sfx_equip.events.default},
                step_sounds2 = {
                    SoundEventAliases.sfx_equip.events.powermaul_shield_p1_m1,
                    SoundEventAliases.sfx_weapon_foley_left_hand_02.events.powermaul_shield_p1_m1,
                },
                -- attach_node = "j_spine1",
                -- init = function(visible_equipment_extension, slot)
                --     local slot_info_id = mod.gear_settings:slot_info_id(slot.item)
                --     local slot_infos = mod:persistent_table(REFERENCE).attachment_slot_infos
                --     local attachment_slot_info = slot_infos and slot_infos[slot_info_id]
                --     if attachment_slot_info then
                --         local left = attachment_slot_info.attachment_slot_to_unit["left"]
                --         local attachment = attachment_slot_info.unit_to_attachment_name[left]
                --         mod:echo("left", left, attachment)
                --         if attachment ~= "left_01" then
                --             unit_set_local_scale(left, 1, vector3(.5, .5, .5))
                --         end
                --     end
                -- end,
                wield = function(visible_equipment_extension, slot)
                    visible_equipment_extension:position_equipment()
                end,
            },
            thunderhammer_2h_p1_m1 = {
                default = {position = vector3_box(.3, .25, -.1), rotation = vector3_box(180, -90, 130), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.02, .0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
                backpack = {position = vector3_box(.3, .25, -.225), rotation = vector3_box(120, -95, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
                center_mass = vector3_box(0, 0, -.8),
                loading = mod.visible_equipment_loading_offsets.ranged_huge,
                init = function(visible_equipment_extension, slot)
                    -- Flip
                    local ext = visible_equipment_extension
                    local unit = ext.dummy_units[slot].attachments and ext.dummy_units[slot].attachments[1]
                    if unit and unit_alive(unit) then
                        unit_set_local_rotation(unit, 1, quaternion_from_vector(vector3(0, 180, 0)))
                    end
                end,
            },
            powersword_p1_m1 = {
                default = {position = vector3_box(.3, .25, -.1), rotation = vector3_box(180, -90, 110), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
                backpack = {position = vector3_box(.4, .25, -.225), rotation = vector3_box(120, -95, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
                center_mass = vector3_box(0, 0, -.075),
                loading = mod.visible_equipment_loading_offsets.melee_medium,
                step_sounds = {SoundEventAliases.sfx_equip_03.events.combatknife_p1_m2},
            },
            forcesword_p1_m1 = {
                default = {position = vector3_box(.3, .25, -.1), rotation = vector3_box(180, -90, 110), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
                backpack = {position = vector3_box(.4, .25, -.225), rotation = vector3_box(120, -95, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
                center_mass = vector3_box(0, 0, -.075),
                loading = mod.visible_equipment_loading_offsets.melee_medium,
                step_sounds = {SoundEventAliases.sfx_equip_03.events.combatknife_p1_m2},
            },
            powermaul_p1_m1 = {
                default = {position = vector3_box(.3, .25, -.1), rotation = vector3_box(180, -90, 110), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
                backpack = {position = vector3_box(.4, .25, -.225), rotation = vector3_box(120, -95, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
                center_mass = vector3_box(0, 0, -.1),
                loading = mod.visible_equipment_loading_offsets.melee_medium,
                step_sounds = {SoundEventAliases.sfx_equip_03.events.combatknife_p1_m2},
            },
            powermaul_p2_m1 = {
                default = {position = vector3_box(.3, .25, -.1), rotation = vector3_box(180, -90, 110), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
                backpack = {position = vector3_box(.4, .25, -.225), rotation = vector3_box(120, -95, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
                center_mass = vector3_box(0, 0, -.1),
                loading = mod.visible_equipment_loading_offsets.melee_medium,
                step_sounds = {SoundEventAliases.sfx_equip_03.events.combatknife_p1_m2},
            },
            powermaul_2h_p1_m1 = {
                default = {position = vector3_box(.1, .25, -.1), rotation = vector3_box(180, -90, 130), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.02, -.0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
                backpack = {position = vector3_box(.1, .25, -.225), rotation = vector3_box(120, -95, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, -.0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
                center_mass = vector3_box(0, 0, -.6),
                -- attach_points = {"back_left", "back_right", "backpack_left", "backpack_right", "hips_left", "hips_right", "hips_back"},
                loading = mod.visible_equipment_loading_offsets.ranged_huge,
                init = function(visible_equipment_extension, slot)
                    -- Flip
                    local ext = visible_equipment_extension
                    local unit = ext.dummy_units[slot].attachments and ext.dummy_units[slot].attachments[1]
                    if unit and unit_alive(unit) then
                        unit_set_local_rotation(unit, 1, quaternion_from_vector(vector3(0, 180, 0)))
                        -- unit_set_local_position(unit, 1, vector3(0, 0, .4))
                    end
                end,
            },
            chainsword_2h_p1_m1 = {
                default = {position = vector3_box(.3, .25, -.1), rotation = vector3_box(180, -90, 110), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
                backpack = {position = vector3_box(.5, .25, -.225), rotation = vector3_box(120, -95, 90), scale = vector3_box(1, 1, 1),
                    step_move = vector3_box(-.01, .0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
                loading = mod.visible_equipment_loading_offsets.melee_medium,
                step_sounds = {SoundEventAliases.sfx_equip_03.events.combatknife_p1_m2},
            }
        --#endregion
    }

    --#region Other weapons
        --#region Ogryn Melee
            -- mod.visible_equipment_offsets.ogryn_club_p1_m1 = mod.visible_equipment_offsets.ogryn[WEAPON_MELEE]
            -- mod.visible_equipment_offsets.ogryn_club_p1_m1 = mod.visible_equipment_offsets.ogryn[WEAPON_MELEE]
            -- mod.visible_equipment_offsets.ogryn_combatblade_p1_m1 = mod.visible_equipment_offsets.ogryn[WEAPON_MELEE]
            -- mod.visible_equipment_offsets.ogryn_club_p2_m1 = mod.visible_equipment_offsets.ogryn[WEAPON_MELEE]
        --#endregion
        --#region Guns
            mod.visible_equipment_offsets.shotgun_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
            mod.visible_equipment_offsets.autogun_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
            mod.visible_equipment_offsets.lasgun_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
            mod.visible_equipment_offsets.lasgun_p2_m1 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
            mod.visible_equipment_offsets.lasgun_p3_m1 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
        --#endregion
        --#region Melee
            mod.visible_equipment_offsets.combataxe_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
            mod.visible_equipment_offsets.combataxe_p2_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
            mod.visible_equipment_offsets.combataxe_p3_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
            mod.visible_equipment_offsets.combatknife_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
            -- mod.visible_equipment_offsets.powersword_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
            mod.visible_equipment_offsets.combatsword_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
            mod.visible_equipment_offsets.combatsword_p1_m2 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
            mod.visible_equipment_offsets.combatsword_p1_m3 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
            mod.visible_equipment_offsets.combatsword_p2_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
            -- mod.visible_equipment_offsets.forcesword_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
            mod.visible_equipment_offsets.combatsword_p3_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
            mod.visible_equipment_offsets.chainaxe_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
            mod.visible_equipment_offsets.chainsword_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
        --#endregion
    --#endregion
    --#region Copies
        --#region Melee
            mod.visible_equipment_offsets.combataxe_p1_m2 = mod.visible_equipment_offsets.combataxe_p1_m1
            mod.visible_equipment_offsets.combataxe_p1_m3 = mod.visible_equipment_offsets.combataxe_p1_m1
            mod.visible_equipment_offsets.combataxe_p2_m2 = mod.visible_equipment_offsets.combataxe_p2_m1
            mod.visible_equipment_offsets.combataxe_p2_m3 = mod.visible_equipment_offsets.combataxe_p2_m1
            mod.visible_equipment_offsets.powersword_p1_m2 = mod.visible_equipment_offsets.powersword_p1_m1
            mod.visible_equipment_offsets.combatsword_p2_m2 = mod.visible_equipment_offsets.combatsword_p2_m1
            mod.visible_equipment_offsets.combatsword_p2_m3 = mod.visible_equipment_offsets.combatsword_p2_m1
            mod.visible_equipment_offsets.forcesword_p1_m2 = mod.visible_equipment_offsets.forcesword_p1_m1
            mod.visible_equipment_offsets.forcesword_p1_m3 = mod.visible_equipment_offsets.forcesword_p1_m1
            mod.visible_equipment_offsets.chainsword_p1_m2       = mod.visible_equipment_offsets.chainsword_p1_m1
            mod.visible_equipment_offsets.chainsword_2h_p1_m2    = mod.visible_equipment_offsets.chainsword_2h_p1_m1
            mod.visible_equipment_offsets.thunderhammer_2h_p1_m2 = mod.visible_equipment_offsets.thunderhammer_2h_p1_m1
            mod.visible_equipment_offsets.combatknife_p1_m2      = mod.visible_equipment_offsets.combatknife_p1_m1
            mod.visible_equipment_offsets.combatsword_p3_m2 = mod.visible_equipment_offsets.combatsword_p3_m1
            mod.visible_equipment_offsets.combatsword_p3_m3 = mod.visible_equipment_offsets.combatsword_p3_m1
            mod.visible_equipment_offsets.chainaxe_p1_m2 = mod.visible_equipment_offsets.chainaxe_p1_m1
            mod.visible_equipment_offsets.powermaul_p1_m2 = mod.visible_equipment_offsets.powermaul_p1_m1
            -- mod.visible_equipment_offsets.powermaul_p2_m1 = mod.visible_equipment_offsets.powermaul_p1_m1
            -- mod.visible_equipment_offsets.powermaul_p2_m2 = mod.visible_equipment_offsets.powermaul_p1_m1
            mod.visible_equipment_offsets.powermaul_shield_p1_m2 = mod.visible_equipment_offsets.powermaul_shield_p1_m1
            -- mod.visible_equipment_offsets.assault_shield_p1_m1 = mod.visible_equipment_offsets.powermaul_shield_p1_m1
            -- mod.visible_equipment_offsets.shotpistol_shield_p1_m1 = mod.visible_equipment_offsets.powermaul_shield_p1_m1
        --#endregion
        --#region Ogryn Guns
            mod.visible_equipment_offsets.ogryn_heavystubber_p1_m2 = mod.visible_equipment_offsets.ogryn_heavystubber_p1_m1
            mod.visible_equipment_offsets.ogryn_heavystubber_p1_m3 = mod.visible_equipment_offsets.ogryn_heavystubber_p1_m1
            mod.visible_equipment_offsets.ogryn_heavystubber_p2_m2 = mod.visible_equipment_offsets.ogryn_heavystubber_p2_m1
            mod.visible_equipment_offsets.ogryn_heavystubber_p2_m3 = mod.visible_equipment_offsets.ogryn_heavystubber_p2_m1
            mod.visible_equipment_offsets.ogryn_rippergun_p1_m2 = mod.visible_equipment_offsets.ogryn_rippergun_p1_m1
            mod.visible_equipment_offsets.ogryn_rippergun_p1_m3 = mod.visible_equipment_offsets.ogryn_rippergun_p1_m1
            mod.visible_equipment_offsets.ogryn_thumper_p1_m2 = mod.visible_equipment_offsets.ogryn_thumper_p1_m1
        --#endregion
        --#region Ogryn Melee
            mod.visible_equipment_offsets.ogryn_club_p1_m2 = mod.visible_equipment_offsets.ogryn_club_p1_m1
            mod.visible_equipment_offsets.ogryn_club_p1_m3 = mod.visible_equipment_offsets.ogryn_club_p1_m1
            mod.visible_equipment_offsets.ogryn_powermaul_p1_m2 = mod.visible_equipment_offsets.ogryn_powermaul_p1_m1
            mod.visible_equipment_offsets.ogryn_powermaul_p1_m3 = mod.visible_equipment_offsets.ogryn_powermaul_p1_m1
            mod.visible_equipment_offsets.ogryn_combatblade_p1_m2 = mod.visible_equipment_offsets.ogryn_combatblade_p1_m1
            mod.visible_equipment_offsets.ogryn_combatblade_p1_m3 = mod.visible_equipment_offsets.ogryn_combatblade_p1_m1
            mod.visible_equipment_offsets.ogryn_club_p2_m2 = mod.visible_equipment_offsets.ogryn_club_p2_m1
            mod.visible_equipment_offsets.ogryn_club_p2_m3 = mod.visible_equipment_offsets.ogryn_club_p2_m1
            mod.visible_equipment_offsets.ogryn_pickaxe_2h_p1_m2 = mod.visible_equipment_offsets.ogryn_pickaxe_2h_p1_m1
            mod.visible_equipment_offsets.ogryn_pickaxe_2h_p1_m3 = mod.visible_equipment_offsets.ogryn_pickaxe_2h_p1_m1
        --#endregion
        --#region Guns
            mod.visible_equipment_offsets.shotgun_p1_m2 = mod.visible_equipment_offsets.shotgun_p1_m1
            mod.visible_equipment_offsets.shotgun_p1_m3 = mod.visible_equipment_offsets.shotgun_p1_m1
            mod.visible_equipment_offsets.shotgun_p4_m2 = mod.visible_equipment_offsets.shotgun_p4_m1
            mod.visible_equipment_offsets.shotgun_p4_m3 = mod.visible_equipment_offsets.shotgun_p4_m1
            mod.visible_equipment_offsets.stubrevolver_p1_m2 = mod.visible_equipment_offsets.stubrevolver_p1_m1
            mod.visible_equipment_offsets.stubrevolver_p1_m3 = mod.visible_equipment_offsets.stubrevolver_p1_m1
            mod.visible_equipment_offsets.laspistol_p1_m2 = mod.visible_equipment_offsets.laspistol_p1_m1
            mod.visible_equipment_offsets.laspistol_p1_m3 = mod.visible_equipment_offsets.laspistol_p1_m1
            mod.visible_equipment_offsets.forcestaff_p2_m1 = mod.visible_equipment_offsets.forcestaff_p1_m1
            mod.visible_equipment_offsets.forcestaff_p3_m1 = mod.visible_equipment_offsets.forcestaff_p1_m1
            mod.visible_equipment_offsets.forcestaff_p4_m1 = mod.visible_equipment_offsets.forcestaff_p1_m1
            mod.visible_equipment_offsets.autogun_p1_m2 = mod.visible_equipment_offsets.autogun_p1_m1
            mod.visible_equipment_offsets.autogun_p1_m3 = mod.visible_equipment_offsets.autogun_p1_m1
            mod.visible_equipment_offsets.autogun_p2_m1 = mod.visible_equipment_offsets.autogun_p1_m1
            mod.visible_equipment_offsets.autogun_p2_m2 = mod.visible_equipment_offsets.autogun_p1_m1
            mod.visible_equipment_offsets.autogun_p2_m3 = mod.visible_equipment_offsets.autogun_p1_m1
            mod.visible_equipment_offsets.autogun_p3_m1 = mod.visible_equipment_offsets.autogun_p1_m1
            mod.visible_equipment_offsets.autogun_p3_m2 = mod.visible_equipment_offsets.autogun_p1_m1
            mod.visible_equipment_offsets.autogun_p3_m3 = mod.visible_equipment_offsets.autogun_p1_m1
            mod.visible_equipment_offsets.lasgun_p1_m2 = mod.visible_equipment_offsets.lasgun_p1_m1
            mod.visible_equipment_offsets.lasgun_p1_m3 = mod.visible_equipment_offsets.lasgun_p1_m1
            mod.visible_equipment_offsets.lasgun_p2_m2 = mod.visible_equipment_offsets.lasgun_p2_m1
            mod.visible_equipment_offsets.lasgun_p2_m3 = mod.visible_equipment_offsets.lasgun_p2_m1
            mod.visible_equipment_offsets.lasgun_p3_m2 = mod.visible_equipment_offsets.lasgun_p3_m1
            mod.visible_equipment_offsets.lasgun_p3_m3 = mod.visible_equipment_offsets.lasgun_p3_m1
        --#endregion
    --#endregion
--#endregion

return mod.visible_equipment_offsets