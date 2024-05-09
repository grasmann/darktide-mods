local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
    local _ogryn_combatblade_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/ogryn_combatblade_p1_m1")
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
    _ogryn_combatblade_p1_m1,
    {
        attachments = {
            -- Native
            blade = _ogryn_combatblade_p1_m1.blade_attachments(),
            grip = _ogryn_combatblade_p1_m1.grip_attachments(),
            handle = _ogryn_combatblade_p1_m1.handle_attachments(),
            -- Common
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            trinket_hook = _common.trinket_hook_attachments(),
        },
        models = table.combine(
            -- Native
            _ogryn_combatblade_p1_m1.blade_models(nil, 0, vector3_box(.1, -3, -.1), vector3_box(0, 0, .2)),
            _ogryn_combatblade_p1_m1.grip_models(nil, 0, vector3_box(-.1, -4, .2), vector3_box(0, .2, 0), nil, {
                {},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
            }, {
                {},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01"},
                {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01"},
            }),
            _ogryn_combatblade_p1_m1.handle_models(nil, 0, vector3_box(-.15, -5, .2), vector3_box(0, 0, -.2)),
            -- Common
            _common.emblem_right_models("grip", -2.5, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("grip", 0, vector3_box(.1, -4, -.1), vector3_box(-.2, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(-.3, -4, .3), vector3_box(0, 0, -.2))
        ),
        anchors = { -- Additional custom positions for paper thing emblems?
            fixes = {
                {dependencies = {"grip_05", "!handle_05"}, -- Trinket hook
                    trinket_hook = {offset = true, position = vector3_box(0, 0, .055), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"blade_01"}, -- Emblems
                    emblem_left = {parent = "blade", position = vector3_box(-.02, .02, .375), rotation = vector3_box(90, 0, 180), scale = vector3_box(3, 3, 3)},
                    emblem_right = {parent = "blade", position = vector3_box(.02, .02, .375), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"blade_02"}, -- Emblems
                    emblem_left = {parent = "blade", position = vector3_box(-.02, -.01, .275), rotation = vector3_box(90, 0, 180), scale = vector3_box(3, 3, 3)},
                    emblem_right = {parent = "blade", position = vector3_box(.02, -.01, .275), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"blade_03"}, -- Emblems
                    emblem_left = {parent = "blade", position = vector3_box(-.02, .015, .175), rotation = vector3_box(90, 0, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "blade", position = vector3_box(.02, .015, .175), rotation = vector3_box(90, 0, 0), scale = vector3_box(2, 2, 2)}},
                {dependencies = {"blade_04"}, -- Emblems
                    emblem_left = {parent = "blade", position = vector3_box(-.02, .04, .525), rotation = vector3_box(90, 0, 180), scale = vector3_box(3, 3, 3)},
                    emblem_right = {parent = "blade", position = vector3_box(.02, .04, .525), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"blade_05"}, -- Emblems
                    emblem_left = {parent = "blade", position = vector3_box(-.02, .06, .125), rotation = vector3_box(83, 0, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "blade", position = vector3_box(.02, .06, .125), rotation = vector3_box(83, 0, 0), scale = vector3_box(2, 2, 2)}},
                {dependencies = {"blade_06"}, -- Emblems
                    emblem_left = {parent = "blade", position = vector3_box(-.02, 0, .275), rotation = vector3_box(90, 0, 180), scale = vector3_box(4, 4, 4)},
                    emblem_right = {parent = "blade", position = vector3_box(.02, 0, .275), rotation = vector3_box(90, 0, 0), scale = vector3_box(4, 4, 4)}},
            },
        },
    }
)