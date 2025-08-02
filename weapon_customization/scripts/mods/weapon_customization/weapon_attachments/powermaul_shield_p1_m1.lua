local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
    local _powermaul_p2_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/powermaul_p2_m1")
    local _powermaul_shield_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/powermaul_shield_p1_m1")
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
    _powermaul_shield_p1_m1,
    {
        attachments = {
            -- Native
            left = _powermaul_shield_p1_m1.shield_attachments(),
            -- Power Maul
            shaft = _powermaul_p2_m1.shaft_attachments(),
            head = _powermaul_p2_m1.head_attachments(),
            connector = _powermaul_p2_m1.connector_attachments(),
            -- Common
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            trinket_hook = _common.trinket_hook_attachments(),
        },
        models = table.combine(
            -- {customization_default_position = vector3_box(.2, 0, 0)},
            -- Native
            _powermaul_shield_p1_m1.shield_models(nil, 0, vector3_box(-.15, -2, .1), vector3_box(0, 0, -.2)),
            -- Power Maul
            _powermaul_p2_m1.head_models(nil, -2.5, vector3_box(0, -5, -.4), vector3_box(0, 0, .2)),
            _powermaul_p2_m1.connector_models(nil, -2.5, vector3_box(0, -6, .1), vector3_box(0, 0, -.2)),
            _powermaul_p2_m1.shaft_models(nil, -2.5, vector3_box(0, -5, -.15), vector3_box(0, 0, 0)),
            -- Common
            _common.emblem_right_models("head", 0, vector3_box(0, -5, -.4), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("head", -3, vector3_box(0, -5, -.4), vector3_box(-.2, 0, 0)),
            _common.trinket_hook_models(nil, -2.5, vector3_box(-.3, -4, .3), vector3_box(0, 0, -.2))
        ),
        anchors = { -- Additional custom positions for paper thing emblems?
            fixes = {
                {dependencies = {"left_03"}, -- Bulwark Shield
                    scale2 = vector3_box(.5, .5, .5),
                    position2 = {default = vector3_box(.1, .15, -.2), backpack = vector3_box(.1, .2, -.25)},
                    left = {offset = true, position = vector3_box(0, 0, -.05), rotation = vector3_box(0, 0, 0), scale = vector3_box(.5, .5, .5)}},
                {dependencies = {"!left_01"}, -- Ogryn Shield
                    scale2 = vector3_box(.5, .5, .5),
                    left = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(.5, .5, .5)}},

                -- {dependencies = {"pommel_05"}, -- Trinket hook
                --     trinket_hook = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(.01, .01, .01)}},
                -- {dependencies = {"head_01"}, -- Emblems
                --     emblem_left = {parent = "head", position = vector3_box(-.08, -.08, .54), rotation = vector3_box(90, 45, 180), scale = vector3_box(2, 2, 2)},
                --     emblem_right = {parent = "head", position = vector3_box(.08, .08, .54), rotation = vector3_box(90, 45, 0), scale = vector3_box(2, 2, 2)}},
                -- {dependencies = {"head_02"}, -- Emblems
                --     emblem_left = {parent = "head", position = vector3_box(-.185, -.005, .315), rotation = vector3_box(90, 0, 185), scale = vector3_box(3, 3, 3)},
                --     emblem_right = {parent = "head", position = vector3_box(.185, -.005, .315), rotation = vector3_box(90, 0, -5), scale = vector3_box(3, 3, 3)}},
                -- {dependencies = {"head_03"}, -- Emblems
                --     emblem_left = {parent = "head", position = vector3_box(-.21, 0, .280), rotation = vector3_box(90, 0, 180), scale = vector3_box(2, 2, 2)},
                --     emblem_right = {parent = "head", position = vector3_box(.21, 0, .280), rotation = vector3_box(90, 0, 0), scale = vector3_box(2, 2, 2)}},
                -- {dependencies = {"head_04"}, -- Emblems
                --     emblem_left = {parent = "head", position = vector3_box(-.045, .105, .12), rotation = vector3_box(90, 0, 180), scale = vector3_box(1.75, 1.75, 1.75)},
                --     emblem_right = {parent = "head", position = vector3_box(.045, -.105, .12), rotation = vector3_box(90, 0, 0), scale = vector3_box(1.75, 1.75, 1.75)}},
                -- {dependencies = {"head_05"}, -- Emblems
                --     emblem_left = {parent = "head", position = vector3_box(-.16, -.05, .3), rotation = vector3_box(90, 10, 180), scale = vector3_box(2, 2, 2)},
                --     emblem_right = {parent = "head", position = vector3_box(.16, -.05, .3), rotation = vector3_box(90, -10, 0), scale = vector3_box(2, 2, 2)}},
            }
        },
    }
)