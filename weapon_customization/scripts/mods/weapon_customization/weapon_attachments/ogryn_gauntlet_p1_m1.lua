local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
    local _common_ranged = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_ranged")
    local _ogryn_gauntlet_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/ogryn_gauntlet_p1_m1")
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
    _ogryn_gauntlet_p1_m1,
    {
        attachments = {
            -- Native
            barrel = _ogryn_gauntlet_p1_m1.barrel_attachments(),
            body = _ogryn_gauntlet_p1_m1.body_attachments(),
            magazine = _ogryn_gauntlet_p1_m1.magazine_attachments(),
            -- Ranged
            flashlight = _common_ranged.flashlights_attachments(),
            bayonet = _common_ranged.ogryn_bayonet_attachments(),
            -- Common
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            trinket_hook = _common.trinket_hook_attachments(),
        },
        models = table.combine(
            -- Native
            _ogryn_gauntlet_p1_m1.barrel_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 1.5, 0), nil, nil, nil, nil, true),
            _ogryn_gauntlet_p1_m1.body_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.00001)),
            _ogryn_gauntlet_p1_m1.magazine_models(nil, 0, vector3_box(-.8, -4, 0), vector3_box(0, -.6, 0)),
            -- Ranged
            _common_ranged.ogryn_bayonet_models("barrel", -.5, vector3_box(.4, -2, 0), vector3_box(0, .4, 0)),
            _common_ranged.flashlight_models("receiver", -2.25, vector3_box(0, -3, 0), vector3_box(.4, 0, 0)),
            -- Common
            _common.emblem_right_models(nil, -3, vector3_box(0, -2, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models(nil, 0, vector3_box(0, -2, 0), vector3_box(.2, 0, 0)),
            _common.trinket_hook_models("barrel", -.3, vector3_box(.25, -5, .1), vector3_box(-.2, 0, 0))
        ),
        anchors = {
            fixes = {
                -- Bayonet
                {dependencies = {"bayonet_blade_01"},
                    bayonet = {position = vector3_box(0, .4, -0.27), rotation = vector3_box(-90, 0, 0), scale = vector3_box(2, 2, 2)}},
                {bayonet = {position = vector3_box(0, .4, -0.27), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                -- Laser Pointer / Flashlight
                {dependencies = {"laser_pointer|flashlight_04"},
                    flashlight = {position = vector3_box(.2, .18, .11), rotation = vector3_box(0, 360, 0), scale = vector3_box(2, 2, 2)}},
                {flashlight = {position = vector3_box(.2, .18, .11), rotation = vector3_box(0, 360, 0), scale = vector3_box(2, 2, 2)}},
                -- Trinket hook
                {dependencies = {"barrel_01"},
                    trinket_hook = {parent = "barrel", position = vector3_box(-.19, .375, -.08), rotation = vector3_box(0, 90, 0), scale = vector3_box(2.5, 2.5, 2.5)}},
                {dependencies = {"barrel_02"},
                    trinket_hook = {parent = "barrel", position = vector3_box(-.19, .375, -.04), rotation = vector3_box(0, 90, 0), scale = vector3_box(2.5, 2.5, 2.5)}},
                {dependencies = {"barrel_03"},
                    trinket_hook = {parent = "barrel", position = vector3_box(-.19, .375, -.08), rotation = vector3_box(0, 90, 0), scale = vector3_box(2.5, 2.5, 2.5)}},
                {dependencies = {"barrel_04"},
                    trinket_hook = {parent = "barrel", position = vector3_box(-.19, .375, -.08), rotation = vector3_box(0, 90, 0), scale = vector3_box(2.5, 2.5, 2.5)}},
                -- Emblems
                {dependencies = {"emblem_left_02"},
                    emblem_left = {offset = true, position = vector3_box(.001, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, -1, 1)}},
                {emblem_left = {offset = true, position = vector3_box(.001, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}, -- Emblems
                    emblem_right = {offset = true, position = vector3_box(.001, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
            }
        },
    }
)