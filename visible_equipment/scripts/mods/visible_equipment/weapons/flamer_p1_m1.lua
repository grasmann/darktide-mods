local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
    local _common_ranged = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_ranged")
    local _flamer_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/flamer_p1_m1")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local vector3_box = Vector3Box
    local table = table
--#endregion

-- ##### ┌┬┐┌─┐┌─┐┬┌┐┌┬┌┬┐┬┌─┐┌┐┌┌─┐ ##################################################################################
-- #####  ││├┤ ├┤ │││││ │ ││ ││││└─┐ ##################################################################################
-- ##### ─┴┘└─┘└  ┴┘└┘┴ ┴ ┴└─┘┘└┘└─┘ ##################################################################################

return table.combine(
    _flamer_p1_m1,
    {
        attachments = { -- Done 16.10.2023
            flashlight = _common_ranged.flashlights_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            trinket_hook = _common.trinket_hook_attachments(),
            receiver = _flamer_p1_m1.receiver_attachments(),
            magazine = _flamer_p1_m1.magazine_attachments(),
            barrel = _flamer_p1_m1.barrel_attachments(),
            grip = _common_ranged.grip_attachments(),
        },
        models = table.combine( -- Done 16.10.2023
            _common_ranged.flashlight_models("receiver", -2.5, vector3_box(-.3, -3, -.05), vector3_box(.2, 0, 0)),
            _common.emblem_right_models("receiver", -3, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("receiver", 0, vector3_box(0, -3, 0), vector3_box(-.2, 0, 0)),
            _common_ranged.grip_models(nil, .4, vector3_box(-.4, -4, .1), vector3_box(0, 0, -.1)),
            _common.trinket_hook_models(nil, 0, vector3_box(.1, -4, .2), vector3_box(0, 0, -.2)),
            _flamer_p1_m1.receiver_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.00001)),
            _flamer_p1_m1.magazine_models(nil, .2, vector3_box(-.2, -3, .1), vector3_box(0, 0, -.2)),
            _flamer_p1_m1.barrel_models(nil, -.3, vector3_box(.2, -2, 0), vector3_box(0, .2, 0), "barrel", {
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
            }, {
                {trinket_hook = "trinket_hook_empty|trinket_hook_05_carbon"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_05_carbon"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_05_carbon"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_05_carbon"},
                {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_05_carbon"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_05_carbon"},
            })
        ),
        anchors = { -- Done 16.10.2023
            flashlight_01 = {position = vector3_box(.04075, .42, 0), rotation = vector3_box(0, 45, 0), scale = vector3_box(1, 1, 1)},
            flashlight_02 = {position = vector3_box(.04075, .42, 0), rotation = vector3_box(0, 45, 0), scale = vector3_box(1, 1, 1)},
            flashlight_03 = {position = vector3_box(.04075, .42, 0), rotation = vector3_box(0, 45, 0), scale = vector3_box(1, 1, 1)},
            flashlight_04 = {position = vector3_box(.04075, .42, 0), rotation = vector3_box(0, 45, 0), scale = vector3_box(1, 1, 1)},
            fixes = {
                {dependencies = {"barrel_01"}, -- Emblems
                    flashlight = {position = vector3_box(.035, .425, 0), rotation = vector3_box(0, 35, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_02"}, -- Emblems
                    flashlight = {position = vector3_box(.035, .46, 0), rotation = vector3_box(0, 35, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_03"}, -- Emblems
                    flashlight = {position = vector3_box(.035, .44, .005), rotation = vector3_box(0, 35, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_04"}, -- Emblems
                    flashlight = {position = vector3_box(.04, .44, .005), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_05"}, -- Emblems
                    flashlight = {position = vector3_box(.05, .32, .08), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_06"}, -- Emblems
                    flashlight = {position = vector3_box(.04, .42, .005), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"receiver_02|receiver_04|receiver_05|receiver_06", "barrel_06"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.0525, .215, .005), rotation = vector3_box(5, 10, 180), scale = vector3_box(1.1, -1.1, 1.1)}},
                {dependencies = {"receiver_02|receiver_04|receiver_05|receiver_06", "barrel_06"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.0525, .215, .005), rotation = vector3_box(5, 10, 180), scale = vector3_box(1.1, 1.1, 1.1)},
                    emblem_right = {parent = "barrel", position = vector3_box(.0525, .215, .005), rotation = vector3_box(5, -10, 0), scale = vector3_box(1.1, 1.1, 1.1)}},
                {dependencies = {"receiver_02|receiver_04|receiver_05|receiver_06", "barrel_05"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.0275, .1875, -.09), rotation = vector3_box(0, 0, 180), scale = vector3_box(.75, -.75, .75)}},
                {dependencies = {"receiver_02|receiver_04|receiver_05|receiver_06", "barrel_05"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.0275, .1875, -.09), rotation = vector3_box(0, 0, 180), scale = vector3_box(.75, .75, .75)},
                    emblem_right = {parent = "barrel", position = vector3_box(.0275, .1875, -.09), rotation = vector3_box(0, 0, 0), scale = vector3_box(.75, .75, .75)}},
                {dependencies = {"receiver_02|receiver_04|receiver_05|receiver_06", "barrel_04"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.0385, .0215, -.085), rotation = vector3_box(0, 0, 180), scale = vector3_box(1.2, -1.2, 1.2)}},
                {dependencies = {"receiver_02|receiver_04|receiver_05|receiver_06", "barrel_04"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.0385, .0215, -.085), rotation = vector3_box(0, 0, 180), scale = vector3_box(1.2, 1.2, 1.2)},
                    emblem_right = {parent = "barrel", position = vector3_box(.0385, .0215, -.085), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.2, 1.2, 1.2)}},
                {dependencies = {"receiver_02|receiver_04|receiver_05|receiver_06", "barrel_03"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.045, .215, -.05), rotation = vector3_box(0, 0, 180), scale = vector3_box(1.2, -1.2, 1.2)}},
                {dependencies = {"receiver_02|receiver_04|receiver_05|receiver_06", "barrel_03"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.045, .215, -.05), rotation = vector3_box(0, 0, 180), scale = vector3_box(1.2, 1.2, 1.2)},
                    emblem_right = {parent = "barrel", position = vector3_box(.045, .215, -.05), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.2, 1.2, 1.2)}},
                {dependencies = {"receiver_02|receiver_04|receiver_05|receiver_06", "barrel_02"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.05, .13, .0125), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, -2, 2)}},
                {dependencies = {"receiver_02|receiver_04|receiver_05|receiver_06", "barrel_02"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.05, .13, .0125), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "barrel", position = vector3_box(.05, .13, .0125), rotation = vector3_box(0, 0, 0), scale = vector3_box(2, 2, 2)}},
                {dependencies = {"receiver_02|receiver_04|receiver_05|receiver_06", "barrel_01"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.0275, .1, 0), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, -1, 1)}},
                {dependencies = {"receiver_02|receiver_04|receiver_05|receiver_06", "barrel_01"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.0275, .1, 0), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, 1, 1)},
                    emblem_right = {parent = "barrel", position = vector3_box(.0275, .1, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"receiver_01|receiver_03", "emblem_left_02"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.045, -.01, .105), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, -2, 2)}},
                {dependencies = {"receiver_01|receiver_03"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.045, -.01, .105), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {offset = true, position = vector3_box(.045, -.01, .105), rotation = vector3_box(0, 0, 0), scale = vector3_box(2, 2, 2)}},
                {dependencies = {"laser_pointer"}, -- Laser Pointer
                    flashlight = {position = vector3_box(.04075, .42, 0), rotation = vector3_box(0, 45, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"grip_27|grip_28|grip_29"}, -- Grip
                    grip = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {grip = {offset = true, position = vector3_box(0, -.01, .02), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
            },
        },
    }
)