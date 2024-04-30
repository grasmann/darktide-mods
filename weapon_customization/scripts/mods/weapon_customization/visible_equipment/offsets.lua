local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local SoundEventAliases = mod:original_require("scripts/settings/sound/player_character_sound_event_aliases")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local Unit = Unit
    local vector3 = Vector3
    local unit_alive = Unit.alive
    local Quaternion = Quaternion
    local vector3_box = Vector3Box
    local quaternion_to_vector = Quaternion.to_vector
    local quaternion_from_vector = Quaternion.from_vector
    local unit_set_local_position = Unit.set_local_position
    local unit_set_local_rotation = Unit.set_local_rotation
    local quaternion_to_euler_angles_xyz = Quaternion.to_euler_angles_xyz
    local quaternion_from_euler_angles_xyz = Quaternion.from_euler_angles_xyz
    local quaternion_from_euler_angles_xyz = Quaternion.from_euler_angles_xyz
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"
local WEAPON_MELEE = "WEAPON_MELEE"
local WEAPON_RANGED = "WEAPON_RANGED"

-- ##### ┌─┐┌─┐┌─┐┌─┐┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │ │├┤ ├┤ └─┐├┤  │ └─┐ ########################################################################################
-- ##### └─┘└  └  └─┘└─┘ ┴ └─┘ ########################################################################################

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

mod.visible_equipment_offsets = {
    ogryn = {
        WEAPON_MELEE = {
            default = {position = vector3_box(.5, .5, -.15), rotation = vector3_box(170, -85, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.01, .003, 0), step_rotation = vector3_box(-1.5, 1.5, 5)},
            backpack = {position = vector3_box(.65, .5, .4), rotation = vector3_box(180, -15, 135), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, -2.5, 5)},
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
            loading = mod.visible_equipment_loading_offsets.melee_medium,
            step_sounds = {SoundEventAliases.sfx_equip.events.ogryn_combatblade_p1_m1, SoundEventAliases.sfx_equip_03.events.combatknife_p1_m2},
        },
        WEAPON_RANGED = {
            default = {position = vector3_box(.3, .22, .125), rotation = vector3_box(200, -10, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.01, .0075, .005), step_rotation = vector3_box(-5, -2.5, -5)},
            backpack = {position = vector3_box(.3, .22, .25), rotation = vector3_box(240, 10, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.01, .0075, .005), step_rotation = vector3_box(-5, -2.5, -5)},
            loading = mod.visible_equipment_loading_offsets.default,
        },
    },
    --#region Ogryn Guns
        ogryn_heavystubber_p1_m1 = {
            default = {position = vector3_box(.8, .45, .15), rotation = vector3_box(200, -10, 100), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.01, .003, .005), step_rotation = vector3_box(-1, 1.5, -1.5)},
            backpack = {position = vector3_box(.1, .6, .8), rotation = vector3_box(200, 60, 70), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(.02, -.03, -.04), step_rotation = vector3_box(2.5, -2.5, .5)},
            loading = mod.visible_equipment_loading_offsets.ranged_bulky,
            init = function(visible_equipment_extension, slot)
                local slot_info_id = mod:get_slot_info_id(slot.item)
                local slot_infos = mod:persistent_table(REFERENCE).attachment_slot_infos
                local attachment_slot_info = slot_infos and slot_infos[slot_info_id]
                if attachment_slot_info then
                    local receiver = attachment_slot_info.attachment_slot_to_unit["receiver"]
                    local attachment = attachment_slot_info.unit_to_attachment_name[receiver]
                    if receiver and unit_alive(receiver) then
                        local node_index = 17
                        if attachment == "receiver_04" then node_index = 21 end
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
            loading = mod.visible_equipment_loading_offsets.ranged_bulky,
            init = function(visible_equipment_extension, slot)
                -- Get slot info
                local slot_info_id = mod:get_slot_info_id(slot.item)
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
            loading = mod.visible_equipment_loading_offsets.ranged_bulky,
        },
        ogryn_thumper_p1_m1 = {
            default = {position = vector3_box(.3, .45, .5), rotation = vector3_box(200, -10, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.03, .0075, .01), step_rotation = vector3_box(2.5, 2.5, -5)},
            backpack = {position = vector3_box(-.2, .4, .5), rotation = vector3_box(200, 60, 70), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(.02, -.03, -.02), step_rotation = vector3_box(2.5, -2.5, .5)},
            loading = mod.visible_equipment_loading_offsets.ranged_bulky,
            step_sounds = {SoundEventAliases.sfx_ads_up.events.ogryn_thumper_p1_m1},
        },
    --#endregion
    --#region Ogryn Melee
        ogryn_powermaul_p1_m1 = {
            default = {position = vector3_box(.5, .5, -.15), rotation = vector3_box(170, -85, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.03, .0075, 0), step_rotation = vector3_box(2.5, -2.5, 5)},
            backpack = {position = vector3_box(.65, .5, .4), rotation = vector3_box(180, -15, 135), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, -2.5, 5)},
            loading = mod.visible_equipment_loading_offsets.melee_medium,
        },
        ogryn_powermaul_slabshield_p1_m1 = {
            default = {position = vector3_box(.5, .5, -.15), rotation = vector3_box(170, -85, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.03, .0075, 0), step_rotation = vector3_box(2.5, -2.5, 5),
                position2 = vector3_box(.2, .45, -.2), rotation2 = vector3_box(0, 90, 70), scale2 = vector3_box(1, 1, 1),
                step_move2 = vector3_box(-.02, .05, 0), step_rotation2 = vector3_box(2.5, 0, 0)},
            backpack = {position = vector3_box(.65, .5, .4), rotation = vector3_box(180, -15, 135), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, -2.5, 5),
                position2 = vector3_box(.2, .6, -.25), rotation2 = vector3_box(20, 90, 60), scale2 = vector3_box(1, 1, 1),
                step_move2 = vector3_box(-.02, .05, 0), step_rotation2 = vector3_box(2.5, 0, 0)},
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
    --#endregion
    --#region Guns
        autopistol_p1_m1 = {
            default = {position = vector3_box(.1, .22, .125), rotation = vector3_box(200, -10, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.01, .0075, .01), step_rotation = vector3_box(-5, -2.5, -5)},
            backpack = {position = vector3_box(.1, .22, .25), rotation = vector3_box(240, 10, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.01, .0075, .01), step_rotation = vector3_box(-5, -2.5, -5)},
            loading = mod.visible_equipment_loading_offsets.default,
        },
        forcestaff_p1_m1 = {
            default = {position = vector3_box(.3, .22, .05), rotation = vector3_box(200, 80, 45), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.01, .0075, -.005), step_rotation = vector3_box(-1.5, -2.5, -1.5)},
            backpack = {position = vector3_box(.3, .22, .175), rotation = vector3_box(200, 100, 0), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.01, .0075, -.005), step_rotation = vector3_box(-1.5, -2.5, -1.5)},
            loading = mod.visible_equipment_loading_offsets.ranged_huge,
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
    --#endregion
    --#region Melee
        thunderhammer_2h_p1_m1 = {
            default = {position = vector3_box(.3, .25, -.1), rotation = vector3_box(180, -90, 130), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.02, .0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
            backpack = {position = vector3_box(.3, .25, -.225), rotation = vector3_box(120, -95, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.01, .0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
            loading = mod.visible_equipment_loading_offsets.ranged_huge,
            init = function(visible_equipment_extension, slot)
                -- Flip
                local ext = visible_equipment_extension
                local unit = ext.dummy_units[slot].attachments and ext.dummy_units[slot].attachments[1]
                if unit and unit_alive(unit) then
                    unit_set_local_rotation(unit, 1, quaternion_from_vector(vector3(0, 180, 0)))
                    unit_set_local_position(unit, 1, vector3(0, 0, .8))
                end
            end,
        },
        powermaul_2h_p1_m1 = {
            default = {position = vector3_box(.1, .25, -.1), rotation = vector3_box(180, -90, 130), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.02, -.0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
            backpack = {position = vector3_box(.1, .25, -.225), rotation = vector3_box(120, -95, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.01, -.0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
            loading = mod.visible_equipment_loading_offsets.ranged_huge,
            init = function(visible_equipment_extension, slot)
                -- Flip
                local ext = visible_equipment_extension
                local unit = ext.dummy_units[slot].attachments and ext.dummy_units[slot].attachments[1]
                if unit and unit_alive(unit) then
                    unit_set_local_rotation(unit, 1, quaternion_from_vector(vector3(0, 180, 0)))
                    unit_set_local_position(unit, 1, vector3(0, 0, .4))
                end
            end,
        },
        chainsword_2h_p1_m1 = {
            default = {position = vector3_box(.3, .25, -.1), rotation = vector3_box(180, -90, 110), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.01, .0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
            backpack = {position = vector3_box(.5, .25, -.225), rotation = vector3_box(120, -95, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.01, .0125, 0), step_rotation = vector3_box(5, -2.5, 5)},
            loading = mod.visible_equipment_loading_offsets.melee_medium,
            step_sounds = {SoundEventAliases.sfx_equip.events.ogryn_combatblade_p1_m1, SoundEventAliases.sfx_equip_03.events.combatknife_p1_m2},
        }
    --#endregion
}
--#region Other weapons
    --#region Ogryn Melee
        mod.visible_equipment_offsets.ogryn_club_p1_m1 = mod.visible_equipment_offsets.ogryn[WEAPON_MELEE]
        mod.visible_equipment_offsets.ogryn_combatblade_p1_m1 = mod.visible_equipment_offsets.ogryn[WEAPON_MELEE]
        mod.visible_equipment_offsets.ogryn_club_p2_m1 = mod.visible_equipment_offsets.ogryn[WEAPON_MELEE]
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
        mod.visible_equipment_offsets.powersword_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
        mod.visible_equipment_offsets.combatsword_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
        mod.visible_equipment_offsets.combatsword_p1_m2 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
        mod.visible_equipment_offsets.combatsword_p1_m3 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
        mod.visible_equipment_offsets.combatsword_p2_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
        mod.visible_equipment_offsets.forcesword_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
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
    --#endregion
    --#region Ogryn Guns
        mod.visible_equipment_offsets.ogryn_heavystubber_p1_m2 = mod.visible_equipment_offsets.ogryn_heavystubber_p1_m1
        mod.visible_equipment_offsets.ogryn_heavystubber_p1_m3 = mod.visible_equipment_offsets.ogryn_heavystubber_p1_m1
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
    --#endregion
    --#region Guns
        mod.visible_equipment_offsets.shotgun_p1_m2 = mod.visible_equipment_offsets.shotgun_p1_m1
        mod.visible_equipment_offsets.shotgun_p1_m3 = mod.visible_equipment_offsets.shotgun_p1_m1
        mod.visible_equipment_offsets.stubrevolver_p1_m2 = mod.visible_equipment_offsets.stubrevolver_p1_m1
        mod.visible_equipment_offsets.stubrevolver_p1_m3 = mod.visible_equipment_offsets.stubrevolver_p1_m1
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

-- --#region Other weapons
--     mod.visible_equipment_offsets.ogryn_club_p1_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.ogryn_club_p1_m2.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.ogryn_club_p1_m3.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.ogryn_combatblade_p1_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.ogryn_combatblade_p1_m2.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.ogryn_combatblade_p1_m3.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.ogryn_club_p2_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.ogryn_club_p2_m2.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.ogryn_club_p2_m3.loading = mod.visible_equipment_loading_offsets.melee_medium

--     mod.visible_equipment_offsets.combataxe_p1_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.combataxe_p1_m2.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.combataxe_p1_m3.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.combataxe_p2_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.combataxe_p2_m2.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.combataxe_p2_m3.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.combataxe_p3_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.combatknife_p1_m1.loading = mod.visible_equipment_loading_offsets.melee_medium --tiny
--     mod.visible_equipment_offsets.powersword_p1_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.powersword_p1_m2.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.combatsword_p1_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.combatsword_p1_m2.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.combatsword_p1_m3.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.thunderhammer_2h_p1_m1.loading = mod.visible_equipment_loading_offsets.melee_big_angle
--     mod.visible_equipment_offsets.thunderhammer_2h_p1_m2.loading = mod.visible_equipment_loading_offsets.melee_big_angle
--     mod.visible_equipment_offsets.powermaul_2h_p1_m1.loading = mod.visible_equipment_loading_offsets.melee_big_angle
--     mod.visible_equipment_offsets.chainsword_2h_p1_m1.loading = mod.visible_equipment_loading_offsets.melee_big_angle
--     mod.visible_equipment_offsets.combatsword_p2_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.combatsword_p2_m2.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.combatsword_p2_m3.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.forcesword_p1_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.forcesword_p1_m2.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.forcesword_p1_m3.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.combatsword_p3_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.combatsword_p3_m2.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.combatsword_p3_m3.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.chainaxe_p1_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
--     mod.visible_equipment_offsets.chainsword_p1_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
-- --#endregion

return mod.visible_equipment_offsets