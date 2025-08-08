local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
    local _common_ranged = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_ranged")
    local _ogryn_heavystubber_p2_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/ogryn_heavystubber_p2_m1")
    local SoundEventAliases = mod:original_require("scripts/settings/sound/player_character_sound_event_aliases")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local table = table
    local vector3_box = Vector3Box
    local table_combine = table.combine
--#endregion

-- ##### ┌┬┐┌─┐┌─┐┬┌┐┌┬┌┬┐┬┌─┐┌┐┌┌─┐ ##################################################################################
-- #####  ││├┤ ├┤ │││││ │ ││ ││││└─┐ ##################################################################################
-- ##### ─┴┘└─┘└  ┴┘└┘┴ ┴ ┴└─┘┘└┘└─┘ ##################################################################################

local changes = {}
return table_combine(
    _ogryn_heavystubber_p2_m1,
    {
        attachments = {
            -- Native
            receiver = _ogryn_heavystubber_p2_m1.receiver_attachments(),
            barrel = _ogryn_heavystubber_p2_m1.barrel_attachments(),
            magazine = _ogryn_heavystubber_p2_m1.magazine_attachments(),
            grip = _ogryn_heavystubber_p2_m1.grip_attachments(),
            -- Ranged
            flashlight = _common_ranged.flashlights_attachments(),
            bayonet = _common_ranged.ogryn_bayonet_attachments(),
            -- Common
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            trinket_hook = _common.trinket_hook_attachments(),
        },
        models = table_combine(
            -- Native
            _ogryn_heavystubber_p2_m1.barrel_models(nil, -.25, vector3_box(.35, -3, 0), vector3_box(0, .2, 0)),
            _ogryn_heavystubber_p2_m1.receiver_models(nil, 0, vector3_box(0, -1, 0), vector3_box(0, 0, -.00001)),
            _ogryn_heavystubber_p2_m1.magazine_models("receiver", 0, vector3_box(0, -3, .1), vector3_box(0, 0, -.2)),
            _ogryn_heavystubber_p2_m1.grip_models(nil, .3, vector3_box(-.4, -3, 0), vector3_box(0, -.2, 0), "grip", {
                {"trinket_hook_default"},
                {"trinket_hook"},
                {"trinket_hook"},
                {"trinket_hook_empty"},
            }, {
                {trinket_hook = "!trinket_hook_default|trinket_hook_default"},
                {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"},
                {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01"},
            }),
            -- Ranged
            _common_ranged.flashlight_models("receiver", -2.25, vector3_box(0, -3, -.2), vector3_box(.4, 0, .4)),
            _common_ranged.ogryn_bayonet_models("receiver", -.5, vector3_box(.4, -2, 0), vector3_box(0, .4, 0)),
            -- Common
            _common.emblem_right_models("receiver", -3, vector3_box(.1, -6, -.1), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("receiver", 0, vector3_box(-.3, -6, -.1), vector3_box(-.2, 0, 0)),
            _common.trinket_hook_models(nil, .3, vector3_box(-.6, -5, .1), vector3_box(0, -.1, -.1))
        ),
        anchors = {
            fixes = {
                -- Bayonet
                {dependencies = {"bayonet_blade_01"},
                    bayonet = {position = vector3_box(0, .85, -0.15), rotation = vector3_box(-90, 0, 0), scale = vector3_box(2, 2, 2)}},
                {bayonet = {position = vector3_box(0, .9, -0.12), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                -- Laser Pointer / Flashlight
                {dependencies = {"flashlight_04|laser_pointer"},
                    flashlight = {position = vector3_box(.15, .86, .21), rotation = vector3_box(0, 128, 0), scale = vector3_box(2, 2, 2)}},
                {dependencies = {"flashlight_ogryn_01|flashlight_ogryn_long_01"},
                    flashlight = {position = vector3_box(.05, .8, .13), rotation = vector3_box(0, 311, 0), scale = vector3_box(1, 1, 1)}},
                {flashlight = {position = vector3_box(.09, .9, .13), rotation = vector3_box(0, 311, 0), scale = vector3_box(2, 2, 2)}},
                -- Emblems
                {dependencies = {"emblem_left_02"},
                    emblem_left = {offset = true, position = vector3_box(-.09, .42, .085), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, -2, 2)}},
                {emblem_left = {offset = true, position = vector3_box(-.09, .42, .085), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, 2, 2)}}, -- Emblem left
            }
        },
        sounds = {
            magazine = {
                detach = {SoundEventAliases.sfx_reload_lever_pull.events.ogryn_heavystubber_p1_m1},
                attach = {SoundEventAliases.sfx_reload_lever_release.events.ogryn_heavystubber_p1_m1},
            }
        },
    }
)