local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
    local _common_ranged = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_ranged")
    local _common_lasgun = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_lasgun")
    local _plasmagun_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/plasmagun_p1_m1")
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
    _plasmagun_p1_m1,
    {
        attachments = {
            -- Native
            receiver = _plasmagun_p1_m1.receiver_attachments(),
            magazine = _plasmagun_p1_m1.magazine_attachments(),
            barrel = _plasmagun_p1_m1.barrel_attachments(),
            stock = _plasmagun_p1_m1.stock_attachments(),
            -- Ranged
            sight = table.icombine(
                _common_ranged.reflex_sights_attachments()--,
                -- _common_ranged.scopes_attachments(false)
            ),
            grip = _common_ranged.grip_attachments(),
            stock_2 = _common_ranged.stock_attachments(),
            -- Common
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            trinket_hook = _common.trinket_hook_attachments(),
        },
        models = table.combine(
            -- Native
            _plasmagun_p1_m1.receiver_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.00001)),
            _plasmagun_p1_m1.magazine_models(nil, .1, vector3_box(-.2, -3, .1), vector3_box(0, 0, -.2)),
            _plasmagun_p1_m1.barrel_models(nil, -.5, vector3_box(.2, -2, 0), vector3_box(0, .2, 0), "barrel", {
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
            }),
            _plasmagun_p1_m1.stock_models(nil, .75, vector3_box(-.3, -4, -.1), vector3_box(0, -.015, .1)),
            _plasmagun_p1_m1.grip_models(nil, .2, vector3_box(-.3, -4, .1), vector3_box(0, -.1, -.1)),
            -- Ranged
            _common_ranged.reflex_sights_models("receiver", -.5, vector3_box(-.3, -4, -.2), vector3_box(0, -.2, 0), "sight", nil, {
                {rail = "rail_default", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
                {rail = "rail_01", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
                {rail = "rail_01", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
                {rail = "rail_01", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
            }),
            _common_ranged.sights_models("body", .35, vector3_box(0, -4, -.2), {
                vector3_box(-.2, 0, 0),
                vector3_box(0, -.2, 0),
                vector3_box(0, -.2, 0),
                vector3_box(0, -.2, 0),
                vector3_box(-.2, 0, 0),
                vector3_box(0, -.3, 0),
                vector3_box(0, -.4, 0),
                vector3_box(0, -.15, 0),
                vector3_box(0, -.2, 0),
            }, "sight", {}, {
                {rail = "rail_default", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
                {rail = "rail_01", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
                {rail = "rail_default", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
                {rail = "rail_01", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
                {rail = "rail_default", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
                {rail = "rail_default", sight_2 = "scope_sight_03", lens = "scope_lens_02", lens_2 = "scope_lens_2_02"},
                {rail = "rail_default", sight_2 = "scope_sight_02", lens = "scope_lens_02", lens_2 = "scope_lens_2_02"},
                {rail = "rail_default", sight_2 = "scope_sight_03", lens = "scope_lens_02", lens_2 = "scope_lens_2_02"},
                {rail = "rail_default", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
            }, {
                {},
                {},
                {},
                {},
                {{"sight", 1}},
                {},
                {},
                {},
                {},
            }, {
                true,
                true,
                false,
                false,
                true,
                false,
                false,
                false,
                false,
            }),
            _common_ranged.scope_sights_models("sight", .2, vector3_box(0, -4, -.2), vector3_box(0, 0, 0), "sight_2", {}, {
                {rail = "rail_default", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
                {rail = "rail_default"},
                {rail = "rail_default"},
                {rail = "rail_default"},
                {rail = "rail_default", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
            }),
            _common_ranged.scope_lens_models("sight", .2, vector3_box(0, -4, -.2), vector3_box(0, 0, 0)),
            _common_ranged.scope_lens_2_models("sight", .2, vector3_box(0, -4, -.2), vector3_box(0, 0, 0)),
            _common_ranged.stock_models("receiver", .5, vector3_box(-.4, -4, 0), vector3_box(0, -.2, 0), "stock_2"),
            _common_lasgun.rail_models("receiver", 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2)),
            -- Common
            _common.emblem_right_models("receiver", -3, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("receiver", 0, vector3_box(0, -4, 0), vector3_box(-.2, 0, 0)),
            _common.trinket_hook_models("barrel", -.2, vector3_box(.1, -4, .2), vector3_box(0, 0, -.2))
        ),
        anchors = {
            scope_offset = {position = vector3_box(-.07, -.2, .00675)},
            fixes = {
                --#region Scope
                    -- Ranger's Vigil
                    {dependencies = {"scope_03"},
                        sight = {parent = "receiver", position = vector3_box(-.065, -.04, .165), rotation = vector3_box(0, -52, 0), scale = vector3_box(1, 1, 1),
                            animation_wait_attach = {"rail"}
                        },
                        lens = {parent = "sight", position = vector3_box(0, .033, .002), rotation = vector3_box(0, 0, 0), scale = vector3_box(.9, .4, .9), data = {lens = 1}},
                        lens_2 = {parent = "sight", position = vector3_box(0, .085, .002), rotation = vector3_box(180, 0, 0), scale = vector3_box(.9, .4, .9), data = {lens = 2}},
                        sight_2 = {parent = "sight", position = vector3_box(0, 0, -.0425), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}},
                            animation_wait_attach = {"rail"}
                        },
                        scope_offset = {position = vector3_box(.05, -.15, .0145), rotation = vector3_box(-5, -7.5, 0), lense_transparency = true}},
                    -- Martyr's Gaze
                    {dependencies = {"scope_01"},
                        sight = {parent = "receiver", position = vector3_box(-.046, .01, .150), rotation = vector3_box(0, -52, 0), scale = vector3_box(1, 1.5, 1),
                            animation_wait_attach = {"rail"}
                        },
                        lens = {parent = "sight", position = vector3_box(0, .105, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, .275, 1), data = {lens = 1}},
                        lens_2 = {parent = "sight", position = vector3_box(0, .065, 0), rotation = vector3_box(180, 0, 0), scale = vector3_box(1, .3, 1), data = {lens = 2}},
                        sight_2 = {parent = "sight", position = vector3_box(0, .07, -.045), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}},
                            animation_wait_attach = {"rail"}
                        },
                        scope_offset = {position = vector3_box(0, -.015, -.0135), rotation = vector3_box(.6, 0, 0), lense_transparency = true}},
                    -- Exterminatus Lens
                    {dependencies = {"scope_02"},
                        sight = {parent = "receiver", position = vector3_box(-.046, .01, .150), rotation = vector3_box(0, -52, 0), scale = vector3_box(1, 3, 1),
                            animation_wait_attach = {"rail"}
                        },
                        lens = {parent = "sight", position = vector3_box(0, .075, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(.9, .15, .9), data = {lens = 1}},
                        lens_2 = {parent = "sight", position = vector3_box(0, .022, 0), rotation = vector3_box(180, 0, 0), scale = vector3_box(.9, .1, .9), data = {lens = 2}},
                        sight_2 = {parent = "sight", position = vector3_box(0, .07, -.048), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 3, 4, 5}},
                            animation_wait_attach = {"rail"}
                        },
                        scope_offset = {position = vector3_box(0, -.17, -.01), rotation = vector3_box(.6, 0, 0), lense_transparency = true}},
                    {sight_2 = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0),
                        animation_wait_attach = {"rail"}
                    }},
                    {lens = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                    {lens_2 = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                --#endregion
                {dependencies = {"grip_27|grip_28|grip_29"}, -- Grip
                    grip = {offset = true, position = vector3_box(0, .01, -.02), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_01", "emblem_left_02"}, -- Emblem
                    emblem_left = {parent = "barrel", position = vector3_box(-.0415, .3, -.025), rotation = vector3_box(0, -5, 177.5), scale = vector3_box(1, -1, 1)}},
                {dependencies = {"barrel_01"}, -- Emblem
                    emblem_left = {parent = "barrel", position = vector3_box(-.0415, .3, -.025), rotation = vector3_box(0, -5, 177.5), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_02", "emblem_left_02"}, -- Emblem
                    emblem_left = {parent = "barrel", position = vector3_box(-.043, .2965, -.033), rotation = vector3_box(0, -5, 177.5), scale = vector3_box(.65, -.65, .65)}},
                {dependencies = {"barrel_02"}, -- Emblem
                    emblem_left = {parent = "barrel", position = vector3_box(-.043, .2965, -.033), rotation = vector3_box(0, -5, 177.5), scale = vector3_box(.65, .65, .65)}},
                {dependencies = {"barrel_03", "emblem_left_02"}, -- Emblem
                    emblem_left = {parent = "barrel", position = vector3_box(-.04, .375, -.023), rotation = vector3_box(0, -5, 177.5), scale = vector3_box(.65, -.65, .65)}},
                {dependencies = {"barrel_03"}, -- Emblem
                    emblem_left = {parent = "barrel", position = vector3_box(-.04, .375, -.023), rotation = vector3_box(0, -5, 177.5), scale = vector3_box(.65, .65, .65)}},
                {emblem_right = {parent = "receiver", position = vector3_box(.062, .115, -.005), rotation = vector3_box(0, 0, 0), scale = vector3_box(.65, .65, .65)}},
                {dependencies = {"magazine_03"}, -- Sight
                    magazine = {offset = true, position = vector3_box(0, 0, -.06), rotation = vector3_box(90, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"reflex_sight_01"}, -- Sight
                    sight = {parent = "receiver", position = vector3_box(-.046, .01, .150), rotation = vector3_box(0, -52, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"reflex_sight_02"}, -- Sight
                    sight = {parent = "receiver", position = vector3_box(-.046, .01, .150), rotation = vector3_box(0, -52, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"reflex_sight_03"}, -- Sight
                    sight = {parent = "receiver", position = vector3_box(-.046, .01, .150), rotation = vector3_box(0, -52, 0), scale = vector3_box(1, 1, 1)}},
                {rail = {parent = "receiver", position = vector3_box(-.045, -.005, .15), rotation = vector3_box(0, -52, 0), scale = vector3_box(1, .3, 1)}}, -- Rail
                {stock_2 = {parent = "receiver", position = vector3_box(0, -0.095, 0.055), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}}, -- Stocks
            },
        },
    }
)