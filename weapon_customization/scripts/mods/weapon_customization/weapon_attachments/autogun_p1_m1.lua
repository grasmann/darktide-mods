local mod = get_mod("weapon_customization")

--#region Require
    -- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #####################################################################################
    -- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #####################################################################################
    -- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #####################################################################################
    local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
    local _autogun_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/autogun_p1_m1")
    local _common_ranged = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_ranged")
    local _common_lasgun = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_lasgun")
--#endregion

--#region Data
    -- ##### ┌┬┐┌─┐┌┬┐┌─┐ #############################################################################################
    -- #####  ││├─┤ │ ├─┤ #############################################################################################
    -- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #############################################################################################
    local _sight_default = "sight_default"
    local _lense_default = "scope_lens_default"
    local _infantry_receivers = "receiver_01|receiver_10"
    local _braced_receivers = "receiver_03|receiver_06|receiver_07|receiver_08"
    local _headhunter_receivers = "receiver_02|receiver_04|receiver_05|receiver_09|receiver_11"
    local _infantry_and_headhunter_receivers = _infantry_receivers.."|".._headhunter_receivers
    local _headhunter_barrels = "barrel_11|barrel_12|barrel_15|barrel_16|barrel_22"
    local _infantry_barrels = "barrel_01|barrel_02|barrel_03|barrel_04|barrel_05|barrel_06|barrel_21"
    local _braced_barrels = "barrel_07|barrel_08|barrel_09|barrel_10|barrel_13|barrel_14|barrel_18|barrel_19|barrel_20"
    local _infantry_and_braced_barrels = _infantry_barrels.."|".._braced_barrels
    local _infantry_and_headhunter_barrels = _infantry_barrels.."|".._headhunter_barrels
--#endregion

--#region Performance
    -- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ########################################################################
    -- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ########################################################################
    -- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ########################################################################
    local table = table
    local vector3_box = Vector3Box
    local table_combine = table.combine
    local table_icombine = table.icombine
--#endregion

--#region Definitions
    -- ##### ┌┬┐┌─┐┌─┐┬┌┐┌┬┌┬┐┬┌─┐┌┐┌┌─┐ ##################################################################################
    -- #####  ││├┤ ├┤ │││││ │ ││ ││││└─┐ ##################################################################################
    -- ##### ─┴┘└─┘└  ┴┘└┘┴ ┴ ┴└─┘┘└┘└─┘ ##################################################################################
    return table_combine(
        _autogun_p1_m1,
        {
            -- ┌─┐┌┬┐┌┬┐┌─┐┌─┐┬ ┬┌┬┐┌─┐┌┐┌┌┬┐┌─┐
            -- ├─┤ │  │ ├─┤│  ├─┤│││├┤ │││ │ └─┐
            -- ┴ ┴ ┴  ┴ ┴ ┴└─┘┴ ┴┴ ┴└─┘┘└┘ ┴ └─┘
            attachments = {
                -- Native
                receiver = _autogun_p1_m1.receiver_attachments(),
                barrel   = _autogun_p1_m1.barrel_attachments(),
                muzzle   = _autogun_p1_m1.muzzle_attachments(),
                -- Ranged
                flashlight = _common_ranged.flashlights_attachments(),
                grip       = _common_ranged.grip_attachments(),
                stock      = _common_ranged.stock_attachments(),
                magazine   = _common_ranged.magazine_attachments(),
                sight = table_icombine(
                    _common_ranged.reflex_sights_attachments(),
                    _common_ranged.sights_attachments(false)
                ),
                bayonet = _common_ranged.bayonet_attachments(),
                -- Common
                emblem_right = _common.emblem_right_attachments(),
                emblem_left  = _common.emblem_left_attachments(),
                trinket_hook = _common.trinket_hook_attachments(),
            },
            -- ┌┬┐┌─┐┌┬┐┌─┐┬  ┌─┐
            -- ││││ │ ││├┤ │  └─┐
            -- ┴ ┴└─┘─┴┘└─┘┴─┘└─┘
            models = table_combine(
                {customization_default_position = vector3_box(0, -.5, 0)},
                -- Native
                _autogun_p1_m1.braced_barrel_models(nil, -.3, vector3_box(.2, -1, 0), vector3_box(0, .1, 0)),
                _autogun_p1_m1.headhunter_barrel_models(nil, -.3, vector3_box(.2, -1, 0), vector3_box(0, .1, 0), nil, {
                    -- No support
                    {"trinket_hook"},
                }, {
                    -- Auto-equip
                    {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"},
                }),
                _autogun_p1_m1.infantry_barrel_models(nil, -.3, vector3_box(.2, -1, 0), vector3_box(0, .1, 0), nil, {
                    -- No support
                    {"trinket_hook_empty"},
                }, {
                    -- Auto-equip
                    {trinket_hook = "trinket_hook_empty|trinket_hook_default"},
                }),
                _autogun_p1_m1.muzzle_models(nil, -.5, vector3_box(.4, -1, 0), vector3_box(0, .1, 0)),
                _autogun_p1_m1.receiver_models(nil, 0, vector3_box(-.2, -1, 0), vector3_box(0, 0, -.00001)),
                -- Ranged
                _common_ranged.flashlight_models(nil, -2.5, vector3_box(-.3, -1, 0), vector3_box(.1, 0, 0)),
                _common_ranged.bayonet_models({"barrel", "barrel", "barrel", "muzzle"}, -.5, vector3_box(.4, -1, 0), vector3_box(0, .4, -.034)),
                _common_ranged.grip_models(nil, .4, vector3_box(-.4, -1, .1), vector3_box(0, -.1, -.1)),
                _common_ranged.reflex_sights_models(nil, .2, vector3_box(-.3, -1, -.2), vector3_box(0, -.2, 0), "sight", {}, {
                    -- Auto-equip
                    {rail = "rail_default", sight_2 = _sight_default, lens = _lense_default, lens_2 = _lense_default},
                    {rail = "rail_01",      sight_2 = _sight_default, lens = _lense_default, lens_2 = _lense_default},
                    {rail = "rail_01",      sight_2 = _sight_default, lens = _lense_default, lens_2 = _lense_default},
                    {rail = "rail_01",      sight_2 = _sight_default, lens = _lense_default, lens_2 = _lense_default},
                }),
                _common_ranged.scope_sights_models("sight", .2, vector3_box(-.3, -1, -.2), vector3_box(0, 0, 0), "sight_2", {}, {
                    -- Auto-equip
                    {rail = "rail_default"},
                    {rail = "rail_default"},
                    {rail = "rail_default"},
                }),
                _common_ranged.scope_lens_models("sight_2", .2, vector3_box(-.3, -1, -.2), vector3_box(0, 0, 0)),
                _common_ranged.scope_lens_2_models("sight_2", .2, vector3_box(-.3, -1, -.2), vector3_box(0, 0, 0)),
                _common_ranged.sights_models(nil, .35, vector3_box(-.3, -1, -.2), {
                    -- Remove
                    vector3_box(0, 0, .2),
                    vector3_box(0, -.2, 0),
                    vector3_box(0, -.2, 0),
                    vector3_box(0, -.2, 0),
                    vector3_box(0, 0, .2),
                    vector3_box(0, -.2, 0),
                    vector3_box(0, -.2, 0),
                    vector3_box(0, -.2, 0),
                    vector3_box(0, -.2, 0),
                }, nil, nil, {
                    -- Auto-equip
                    {rail = "rail_default", sight_2 = _sight_default,   lens = _lense_default,  lens_2 = _lense_default},
                    {rail = "rail_01",      sight_2 = _sight_default,   lens = _lense_default,  lens_2 = _lense_default},
                    {rail = "rail_default", sight_2 = _sight_default,   lens = _lense_default,  lens_2 = _lense_default},
                    {rail = "rail_01",      sight_2 = _sight_default,   lens = _lense_default,  lens_2 = _lense_default},
                    {rail = "rail_default", sight_2 = _sight_default,   lens = _lense_default,  lens_2 = _lense_default},
                    {rail = "rail_default", sight_2 = "scope_sight_03", lens = "scope_lens_02", lens_2 = "scope_lens_2_02"},
                    {rail = "rail_default", sight_2 = "scope_sight_03", lens = "scope_lens_02", lens_2 = "scope_lens_2_02"},
                    {rail = "rail_default", sight_2 = "scope_sight_03", lens = "scope_lens_02", lens_2 = "scope_lens_2_02"},
                    {rail = "rail_default", sight_2 = _sight_default,   lens = _lense_default,  lens_2 = _lense_default},
                }, {
                    -- Hide mesh
                    {},
                    {},
                    {},
                    {},
                    {{"sight", 1}},
                    {},
                    {},
                    {},
                    {},
                }),
                _common_ranged.stock_models(nil, .5, vector3_box(-.6, -1, 0), vector3_box(0, -.2, 0)),
                _common_ranged.magazine_models(nil, 0, vector3_box(-.2, -1, .1), vector3_box(0, 0, -.2)),
                -- Lasgun
                _common_lasgun.rail_models("receiver", 0, vector3_box(0, 0, 0), vector3_box(0, 0, .1)),
                -- Common
                _common.trinket_hook_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.1)),
                _common.emblem_right_models("receiver", -3, vector3_box(0, 0, 0), vector3_box(.1, 0, 0)),
                _common.emblem_left_models("receiver", 0, vector3_box(0, 0, 0), vector3_box(-.1, 0, 0))
            ),
            -- ┌─┐┬─┐ ┬┌─┐┌─┐
            -- ├┤ │┌┴┬┘├┤ └─┐
            -- └  ┴┴ └─└─┘└─┘
            anchors = {
                fixes = {
                    --#region Receiver
                        {receiver = {offset = true, animation_wait_detach = {"barrel"}}},
                    --#endregion
                    --#region Grips
                        {dependencies = {"grip_27|grip_28|grip_29"}, -- Grip
                            grip = {offset = true, position = vector3_box(0, .01, -.02), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                    --#endregion
                    --#region Bayonets
                        --#region Bayonet 1
                            {dependencies = {"barrel_01", "autogun_bayonet_01|autogun_bayonet_05"}, -- Bayonets 1 and 5
                                bayonet = {offset = true, position = vector3_box(0, .115, .06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"barrel_02", "autogun_bayonet_01|autogun_bayonet_05"}, -- Bayonets 1 and 5
                                bayonet = {offset = true, position = vector3_box(0, .115, .06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"barrel_03", "autogun_bayonet_01|autogun_bayonet_05"}, -- Bayonets 1 and 5
                                bayonet = {offset = true, position = vector3_box(0, .145, .06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"barrel_04", "autogun_bayonet_01|autogun_bayonet_05"}, -- Bayonets 1 and 5
                                bayonet = {offset = true, position = vector3_box(0, .115, .06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"barrel_06", "autogun_bayonet_01|autogun_bayonet_05"}, -- Bayonets 1 and 5
                                bayonet = {offset = true, position = vector3_box(0, .12, .055), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"barrel_11", "autogun_bayonet_01|autogun_bayonet_05"}, -- Bayonets 1 and 5
                                bayonet = {offset = true, position = vector3_box(0, .173, .0675), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"barrel_12", "autogun_bayonet_01|autogun_bayonet_05"}, -- Bayonets 1 and 5
                                bayonet = {offset = true, position = vector3_box(0, .09, .041), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"barrel_15", "autogun_bayonet_01|autogun_bayonet_05"}, -- Bayonets 1 and 5
                                bayonet = {offset = true, position = vector3_box(0, .17, .088), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"barrel_16", "autogun_bayonet_01|autogun_bayonet_05"}, -- Bayonets 1 and 5
                                bayonet = {offset = true, position = vector3_box(0, .19, .076), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"barrel_21", "autogun_bayonet_01|autogun_bayonet_05"}, -- Bayonets 1 and 5
                                bayonet = {offset = true, position = vector3_box(0, .115, .06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"barrel_22", "autogun_bayonet_01|autogun_bayonet_05"}, -- Bayonets 1 and 5
                                bayonet = {offset = true, position = vector3_box(0, .13, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                        --#endregion
                        --#region Bayonet 2
                            {dependencies = {"barrel_16", "autogun_bayonet_01|autogun_bayonet_05"}, -- Bayonets 1 and 5
                                bayonet = {offset = true, position = vector3_box(0, .19, .076), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"barrel_01", "autogun_bayonet_02"}, -- Bayonet 2
                                bayonet = {offset = true, position = vector3_box(0, .115, .06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"barrel_02", "autogun_bayonet_02"}, -- Bayonet 2
                                bayonet = {offset = true, position = vector3_box(0, .115, .06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"barrel_03", "autogun_bayonet_02"}, -- Bayonet 2
                                bayonet = {offset = true, position = vector3_box(0, .145, .06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"barrel_04", "autogun_bayonet_02"}, -- Bayonet 2
                                bayonet = {offset = true, position = vector3_box(0, .115, .06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"barrel_06", "autogun_bayonet_02"}, -- Bayonet 2
                                bayonet = {offset = true, position = vector3_box(0, .12, .055), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"barrel_11", "autogun_bayonet_02"}, -- Bayonet 2
                                bayonet = {offset = true, position = vector3_box(0, .173, .0675), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"barrel_12", "autogun_bayonet_02"}, -- Bayonet 2
                                bayonet = {offset = true, position = vector3_box(0, .09, .041), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"barrel_15", "autogun_bayonet_02"}, -- Bayonet 2
                                bayonet = {offset = true, position = vector3_box(0, .17, .088), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"barrel_16", "autogun_bayonet_02"}, -- Bayonet 2
                                bayonet = {offset = true, position = vector3_box(0, .19, .076), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"barrel_21", "autogun_bayonet_02"}, -- Bayonet 2
                                bayonet = {offset = true, position = vector3_box(0, .115, .06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"barrel_22", "autogun_bayonet_02"}, -- Bayonet 2
                                bayonet = {offset = true, position = vector3_box(0, .13, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                        --#endregion
                        --#region Bayonet 3
                            {dependencies = {"muzzle_01", "autogun_bayonet_03"}, -- Bayonet 3
                                bayonet = {offset = true, position = vector3_box(0, .045, -.025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"muzzle_02", "autogun_bayonet_03"}, -- Bayonet 3
                                bayonet = {offset = true, position = vector3_box(0, .075, -.025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"muzzle_03", "autogun_bayonet_03"}, -- Bayonet 3
                                bayonet = {offset = true, position = vector3_box(0, .045, -.025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"muzzle_04", "autogun_bayonet_03"}, -- Bayonet 3
                                bayonet = {offset = true, position = vector3_box(0, .045, -.025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"muzzle_05", "autogun_bayonet_03"}, -- Bayonet 3
                                bayonet = {offset = true, position = vector3_box(0, .055, -.025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"muzzle_06|muzzle_12", "autogun_bayonet_03"}, -- Bayonet 3
                                bayonet = {offset = true, position = vector3_box(0, .075, -.025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"muzzle_07", "autogun_bayonet_03"}, -- Bayonet 3
                                bayonet = {offset = true, position = vector3_box(0, .05, -.025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"muzzle_08|muzzle_11|muzzle_15", "autogun_bayonet_03"}, -- Bayonet 3
                                bayonet = {offset = true, position = vector3_box(0, .07, -.025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"muzzle_09|muzzle_13|muzzle_14|muzzle_16", "autogun_bayonet_03"}, -- Bayonet 3
                                bayonet = {offset = true, position = vector3_box(0, .09, -.03), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                            {dependencies = {"muzzle_10", "autogun_bayonet_03"}, -- Bayonet 3
                                bayonet = {offset = true, position = vector3_box(0, .1, -.03), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                        --#endregion
                    --#endregion
                    --#region Scope
                        --#region Ranger's Vigil
                            {dependencies = {"scope_03"},
                                sight = {parent = "receiver", position = vector3_box(0, -.09, .143), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1),
                                    animation_wait_attach = {"rail"}
                                },
                                lens = {parent = "sight", position = vector3_box(0, .033, .002), rotation = vector3_box(0, 0, 0), scale = vector3_box(.9, .4, .9), data = {lens = 1}},
                                lens_2 = {parent = "sight", position = vector3_box(0, .085, .002), rotation = vector3_box(180, 0, 0), scale = vector3_box(.9, .4, .9), data = {lens = 2}},
                                sight_2 = {parent = "sight", position = vector3_box(0, 0, -.04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}},
                                    animation_wait_attach = {"rail"}
                                },
                                scope_offset = {position = vector3_box(0, -.075, -.01), fov = 25, custom_fov = 32.5, custom_fov_multiplier = 1.3, aim_scale = .75, lense_transparency = true}},
                        --#endregion
                        --#region Martyr's Gaze
                            {dependencies = {"scope_01"},
                                sight = {parent = "receiver", position = vector3_box(0, -.09, .15), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1.5, 1),
                                    animation_wait_attach = {"rail"}
                                },
                                lens = {parent = "sight", position = vector3_box(0, .105, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, .275, 1), data = {lens = 1}},
                                lens_2 = {parent = "sight", position = vector3_box(0, .065, 0), rotation = vector3_box(180, 0, 0), scale = vector3_box(1, .3, 1), data = {lens = 2}},
                                sight_2 = {parent = "sight", position = vector3_box(0, 0, -.045), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}},
                                    animation_wait_attach = {"rail"}
                                },
                                scope_offset = {position = vector3_box(0, -.075, -.0175), fov = 15, custom_fov = 27, fov_multiplier = 1.8, aim_scale = .65, lense_transparency = true}},
                        --#endregion
                        --#region Exterminatus Lens
                            {dependencies = {"scope_02"},
                                sight = {parent = "receiver", position = vector3_box(0, -.09, .15), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 3, 1),
                                    animation_wait_attach = {"rail"}
                                },
                                lens = {parent = "sight", position = vector3_box(0, .075, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(.9, .15, .9), data = {lens = 1}},
                                lens_2 = {parent = "sight", position = vector3_box(0, .022, 0), rotation = vector3_box(180, 0, 0), scale = vector3_box(.9, .1, .9), data = {lens = 2}},
                                sight_2 = {parent = "sight", position = vector3_box(0, 0, -.045), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 3, 4, 5}},
                                    animation_wait_attach = {"rail"}
                                },
                                scope_offset = {position = vector3_box(0, -.075, -.015), fov = 9, custom_fov = 24, fov_multiplier = 2, aim_scale = .65, lense_transparency = true}},

                            {sight_2 = {parent = "receiver", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                            {lens = {parent = "sight", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                            {lens_2 = {parent = "sight", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                        --#endregion
                    --#endregion
                    --#region Sights
                        --#region Infantry receiver
                        {dependencies = {"lasgun_rifle_sight_01", _infantry_receivers}, -- Lasgun sight
                            sight = {offset = true, position = vector3_box(0, -.028, .0265), rotation = vector3_box(0, 0, 0),
                            animation_wait_attach = {"rail"}
                        }},
                        {dependencies = {"reflex_sight_01", _infantry_receivers}, -- Infantry lasgun reflex sight
                            sight = {offset = true, position = vector3_box(.00010, -0.037, .0005), rotation = vector3_box(0, 0, 0),
                            animation_wait_attach = {"rail"}
                        }},
                        {dependencies = {"reflex_sight_02|reflex_sight_03", _infantry_receivers}, -- Other two reflex sights
                            sight = {offset = true, position = vector3_box(.00010, -0.037, -.00035), rotation = vector3_box(0, 0, 0), 
                            animation_wait_attach = {"rail"}
                        }},
                        --#endregion
                        --#region Headhunter receiver
                            {dependencies = {"autogun_rifle_sight_01", _headhunter_receivers}, -- Infantry sight
                                sight = {offset = true, position = vector3_box(0, -.006, -.005), rotation = vector3_box(0, 0, 0), scale = vector3_box(.9, 1, 1),
                                animation_wait_attach = {"rail"}
                            }},
                            {dependencies = {"autogun_rifle_ak_sight_01", _headhunter_receivers}, -- Braced sight
                                sight = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1),
                                animation_wait_attach = {"rail"}
                            }},
                            {dependencies = {"autogun_rifle_killshot_sight_01", _headhunter_receivers}, -- Headhunter sight
                                sight = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1),
                                animation_wait_attach = {"rail"}
                            }},
                            {dependencies = {"lasgun_rifle_sight_01", _headhunter_receivers}, -- Headhunter sight
                                sight = {offset = true, position = vector3_box(0, -.028, .026), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1),
                                animation_wait_attach = {"rail"}
                            }},
							{dependencies = {"reflex_sight_01", _headhunter_receivers}, -- Infantry lasgun reflex sight
								sight = {offset = true, position = vector3_box(.00010, -.045, .0005), rotation = vector3_box(0, 0, 0),
								animation_wait_attach = {"rail"}
							}},
							{dependencies = {"reflex_sight_02|reflex_sight_03", _headhunter_receivers}, -- Other two reflex sights
								sight = {offset = true, position = vector3_box(.00010, -.045, -.00035), rotation = vector3_box(0, 0, 0), 
								animation_wait_attach = {"rail"}
							}},
                        --#endregion
                        --#region Braced receiver
                            {dependencies = {"autogun_rifle_sight_01", _braced_receivers}, -- Infantry sight
                                sight = {offset = true, position = vector3_box(0, .03, .0005), rotation = vector3_box(0, 0, 0), scale = vector3_box(.9, 1, 1),
                                animation_wait_attach = {"rail"}
                            }},
                            {dependencies = {"autogun_rifle_ak_sight_01", _braced_receivers}, -- Braced sight
                                sight = {offset = true, position = vector3_box(0, .01, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1),
                                animation_wait_attach = {"rail"}
                            }},
                            {dependencies = {"autogun_rifle_killshot_sight_01", _braced_receivers}, -- Headhunter sight
                                sight = {offset = true, position = vector3_box(0, .01, .001), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1),
                                animation_wait_attach = {"rail"}
                            }},
                            {dependencies = {"lasgun_rifle_sight_01", _braced_receivers}, -- Headhunter sight
                                sight = {offset = true, position = vector3_box(0, -.01, .026), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, .65, 1),
                                animation_wait_attach = {"rail"}
                            }},
                            {dependencies = {"reflex_sight_01", _braced_receivers}, -- Infantry lasgun reflex sight
								sight = {offset = true, position = vector3_box(.00010, -.035, .0009), rotation = vector3_box(0, 0, 0),
								animation_wait_attach = {"rail"}
							}},
							{dependencies = {"reflex_sight_02|reflex_sight_03", _braced_receivers}, -- Other two reflex sights
								sight = {offset = true, position = vector3_box(.00010, -.035, 0), rotation = vector3_box(0, 0, 0), 
								animation_wait_attach = {"rail"}
							}},

                            
                            {dependencies = {_headhunter_receivers}, -- Sight
                                sight = {offset = true, position = vector3_box(0, -.045, 0), rotation = vector3_box(0, 0, 0),
                                animation_wait_attach = {"rail"}
                            }},
                            {dependencies = {_braced_receivers}, -- Sight
                                sight = {offset = true, position = vector3_box(0, -.035, 0), rotation = vector3_box(0, 0, 0),
                                animation_wait_attach = {"rail"}
                            }},
                        --#endregion
                        {sight = {offset = true, animation_wait_attach = {"rail"}}},
                    --#endregion
                    --#region Barrels
                        -- Fix vertical positions of braced barrels with non-braced receivers
                        {dependencies = {_braced_barrels, _infantry_and_headhunter_receivers},
                            barrel = {offset = true, position = vector3_box(0, 0, -.034), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                        -- Fix vertical positions of non braced barrels with braced receivers
                        {dependencies = {_infantry_barrels, _braced_receivers}, -- Barrel 7
                            barrel = {offset = true, position = vector3_box(0, 0, .034), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1),
                                animation_wait_detach = {"rail"}, trigger_move = {"rail"},
                        }},
                        {dependencies = {_headhunter_barrels, _braced_receivers}, -- Barrel 7
                            barrel = {offset = true, position = vector3_box(0, 0, .034), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                        -- Default
                        {barrel = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                    --#endregion
                    --#region Rails
                        -- Infantry receiver
                        {dependencies = {"rail_01", _infantry_receivers, "barrel_01|barrel_03|barrel_21"}, -- Bigger than receiver
                            rail = {offset = true, position = vector3_box(0, -.02, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 2.2, 1),
                                animation_wait_detach = {"sight", "sight_2"}, trigger_move = {"sight", "sight_2"},
                                animation_wait_attach = {"barrel"}
                        }},
                        {dependencies = {"rail_01", _infantry_receivers, "barrel_02|barrel_04|barrel_11|barrel_12|barrel_15|barrel_16|barrel_22"},
                            rail = {offset = true, position = vector3_box(0, -.05, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1.3, 1),
                                animation_wait_detach = {"sight", "sight_2"}, trigger_move = {"sight", "sight_2"},
                        }},
                        {dependencies = {"rail_01", _infantry_receivers, "barrel_05|barrel_06"}, -- Bigger than receiver
                            rail = {offset = true, position = vector3_box(0, -.03, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 2, 1),
                                animation_wait_detach = {"sight", "sight_2"}, trigger_move = {"sight", "sight_2"},
                                animation_wait_attach = {"barrel"}
                        }},
                        {dependencies = {"rail_01", _infantry_receivers, "barrel_07|barrel_08|barrel_09|barrel_10|barrel_18|barrel_19|barrel_20"},
                            rail = {offset = true, position = vector3_box(0, -.05, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1.1, 1),
                        }},
                        {dependencies = {"rail_01", _infantry_receivers, "barrel_13"}, -- Bigger than receiver
                            rail = {offset = true, position = vector3_box(0, -.04, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1.7, 1),
                                animation_wait_detach = {"sight", "sight_2"}, trigger_move = {"sight", "sight_2"},
                                animation_wait_attach = {"barrel"}
                        }},
                        {dependencies = {"rail_01", _infantry_receivers, "barrel_14"}, -- Bigger than receiver
                            rail = {offset = true, position = vector3_box(0, -.04, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1.5, 1),
                                animation_wait_detach = {"sight", "sight_2"}, trigger_move = {"sight", "sight_2"},
                                animation_wait_attach = {"barrel"}
                        }},
                        {dependencies = {"rail_01", "!receiver_01"},
                            rail = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0),
                                animation_wait_detach = {"sight", "sight_2"}, trigger_move = {"sight", "sight_2"},
                        }},
                    --#endregion
                    --#region Sight offsets
                        --#region Infantry receiver / Infantry barrels
                            -- Braced sight
                            {dependencies = {_infantry_barrels, "autogun_rifle_ak_sight_01", _infantry_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .002), rotation = vector3_box(-.3, 0, 0)}},
                            -- Headhunter sight
                            {dependencies = {_infantry_barrels, "autogun_rifle_killshot_sight_01", _infantry_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .001), rotation = vector3_box(-.2, 0, 0)}},
                            -- Lasgun sight
                            {dependencies = {_infantry_barrels, "lasgun_rifle_sight_01", _infantry_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .0075), rotation = vector3_box(-.55, 0, 0)}},
                        --#endregion
                        --#region Infantry receiver / Braced barrels
                            -- Infantry sight
                            {dependencies = {_braced_barrels, "autogun_rifle_sight_01", _infantry_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .00075), rotation = vector3_box(.75, 0, 0)}},
                            -- Braced sight
                            {dependencies = {_braced_barrels, "autogun_rifle_ak_sight_01", _infantry_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .003), rotation = vector3_box(.4, 0, 0)}},
                            -- Headhunter sight
                            {dependencies = {_braced_barrels, "autogun_rifle_killshot_sight_01", _infantry_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .002), rotation = vector3_box(.75, 0, 0)}},
                            -- Lasgun sight
                            {dependencies = {_braced_barrels, "lasgun_rifle_sight_01", _infantry_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .008), rotation = vector3_box(-.1, 0, 0)}},
                        --#endregion
                        --#region Infantry receiver / Headhunter barrels
                            -- Infantry sight
                            {dependencies = {"barrel_16", "autogun_rifle_sight_01", _infantry_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .001), rotation = vector3_box(.7, 0, 0)}},
                            -- Braced sight
                            {dependencies = {"barrel_16", "autogun_rifle_ak_sight_01", _infantry_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .003), rotation = vector3_box(.5, 0, 0)}},
                            {dependencies = {_headhunter_barrels, "autogun_rifle_ak_sight_01", _infantry_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .0025), rotation = vector3_box(-.3, 0, 0)}},
                            -- Headhunter sight
                            {dependencies = {"barrel_16", "autogun_rifle_killshot_sight_01", _infantry_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .002), rotation = vector3_box(.7, 0, 0)}},
                            {dependencies = {_headhunter_barrels, "autogun_rifle_killshot_sight_01", _infantry_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .001), rotation = vector3_box(-.1, 0, 0)}},
                            -- Lasgun sight
                            {dependencies = {"barrel_16", "lasgun_rifle_sight_01", _infantry_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .008), rotation = vector3_box(-.1, 0, 0)}},
                            {dependencies = {_headhunter_barrels, "lasgun_rifle_sight_01", _infantry_receivers}, 
                                no_scope_offset = {position = vector3_box(0, 0, .0075), rotation = vector3_box(-.5, 0, 0)}},
                        --#endregion
                        --#region Headhunter receiver / Infantry barrels
                            -- Infantry sight
                            {dependencies = {_infantry_barrels, "autogun_rifle_sight_01", _headhunter_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .0035), rotation = vector3_box(-.1, 0, 0)}},
                            -- Braced sight
                            {dependencies = {_infantry_barrels, "autogun_rifle_ak_sight_01", _headhunter_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .001), rotation = vector3_box(-.25, 0, 0)}},
                            -- Headhunter sight
                            {dependencies = {_infantry_barrels, "autogun_rifle_killshot_sight_01", _headhunter_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, -.001), rotation = vector3_box(-.1, 0, 0)}},
                            -- Lasgun sight
                            {dependencies = {_infantry_barrels, "lasgun_rifle_sight_01", _headhunter_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .0065), rotation = vector3_box(-.55, 0, 0)}},
                        --#endregion
                        --#region Headhunter receiver / Braced barrels
                            -- Infantry sight
                            {dependencies = {_braced_barrels, "autogun_rifle_sight_01", _headhunter_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .004), rotation = vector3_box(.4, 0, 0)}},
                            -- Braced sight
                            {dependencies = {_braced_barrels, "autogun_rifle_ak_sight_01", _headhunter_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .002), rotation = vector3_box(.5, 0, 0)}},
                            -- Headhunter sight
                            {dependencies = {_braced_barrels, "autogun_rifle_killshot_sight_01", _headhunter_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, 0), rotation = vector3_box(.75, 0, 0)}},
                            -- Lasgun sight
                            {dependencies = {_braced_barrels, "lasgun_rifle_sight_01", _headhunter_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .007), rotation = vector3_box(0, 0, 0)}},
                        --#endregion
                        --#region Headhunter receiver / Headhunter barrels
                            -- Infantry sight
                            {dependencies = {"barrel_16", "autogun_rifle_sight_01", _headhunter_receivers}, -- Barrel 16
                                no_scope_offset = {position = vector3_box(0, 0, .004), rotation = vector3_box(.3, 0, 0)}},
                            {dependencies = {_headhunter_barrels, "autogun_rifle_sight_01", _headhunter_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .003), rotation = vector3_box(-.2, 0, 0)}},
                            -- Braced sight
                            {dependencies = {"barrel_16", "autogun_rifle_ak_sight_01", _headhunter_receivers}, -- Barrel 16
                                no_scope_offset = {position = vector3_box(0, 0, .0015), rotation = vector3_box(.5, 0, 0)}},
                            {dependencies = {_headhunter_barrels, "autogun_rifle_ak_sight_01", _headhunter_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .001), rotation = vector3_box(-.1, 0, 0)}},
                            -- Headhunter sight
                            {dependencies = {"barrel_16", "autogun_rifle_killshot_sight_01", _headhunter_receivers}, -- Barrel 16
                                no_scope_offset = {position = vector3_box(0, 0, 0), rotation = vector3_box(.7, 0, 0)}},
                            {dependencies = {_headhunter_barrels, "autogun_rifle_killshot_sight_01", _headhunter_receivers}, 
                                no_scope_offset = {position = vector3_box(0, 0, -.001), rotation = vector3_box(0, 0, 0)}},
                            -- Lasgun sight
                            {dependencies = {"barrel_16", "lasgun_rifle_sight_01", _headhunter_receivers}, -- Barrel 16
                                no_scope_offset = {position = vector3_box(0, 0, .007), rotation = vector3_box(-.1, 0, 0)}},
                            {dependencies = {_headhunter_barrels, "lasgun_rifle_sight_01", _headhunter_receivers}, 
                                no_scope_offset = {position = vector3_box(0, 0, .0065), rotation = vector3_box(-.5, 0, 0)}},
                        --#endregion
                        --#region Braced receiver / Infantry barrels
                            -- Infantry sight
                            {dependencies = {_infantry_barrels, "autogun_rifle_sight_01", _braced_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0)}},
                            -- Braced sight
                            {dependencies = {_infantry_barrels, "autogun_rifle_ak_sight_01", _braced_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .002), rotation = vector3_box(-.25, 0, 0)}},
                            -- Headhunter sight
                            {dependencies = {_infantry_barrels, "autogun_rifle_killshot_sight_01", _braced_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, 0), rotation = vector3_box(-.1, 0, 0)}},
                            -- Lasgun sight
                            {dependencies = {_infantry_barrels, "lasgun_rifle_sight_01", _braced_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .009), rotation = vector3_box(-.9, 0, 0)}},
                        --#endregion
                        --#region Braced receiver / Braced barrels
                            -- Infantry sight
                            {dependencies = {_braced_barrels, "autogun_rifle_sight_01", _braced_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, 0), rotation = vector3_box(.8, 0, 0)}},
                            -- Braced sight
                            {dependencies = {_braced_barrels, "autogun_rifle_ak_sight_01", _braced_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .003), rotation = vector3_box(.5, 0, 0)}},
                            -- Headhunter sight
                            {dependencies = {_braced_barrels, "autogun_rifle_killshot_sight_01", _braced_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .001), rotation = vector3_box(.75, 0, 0)}},
                            -- Lasgun sight
                            {dependencies = {_braced_barrels, "lasgun_rifle_sight_01", _braced_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .009), rotation = vector3_box(0, 0, 0)}},
                        --#endregion
                        --#region Braced receiver / Headhunter barrels
                            -- Infantry sight
                            {dependencies = {"barrel_16", "autogun_rifle_sight_01", _braced_receivers}, -- Barrel 16
                                no_scope_offset = {position = vector3_box(0, 0, 0), rotation = vector3_box(.5, 0, 0)}},
                            {dependencies = {_headhunter_barrels, "autogun_rifle_sight_01", _braced_receivers}, 
                                no_scope_offset = {position = vector3_box(0, 0, 0), rotation = vector3_box(-.1, 0, 0)}},
                            -- Braced sight
                            {dependencies = {"barrel_16", "autogun_rifle_ak_sight_01", _braced_receivers}, -- Barrel 16
                                no_scope_offset = {position = vector3_box(0, 0, .0025), rotation = vector3_box(.2, 0, 0)}},
                            {dependencies = {_headhunter_barrels, "autogun_rifle_ak_sight_01", _braced_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .003), rotation = vector3_box(-.1, 0, 0)}},
                            -- Headhunter sight
                            {dependencies = {"barrel_16", "autogun_rifle_killshot_sight_01", _braced_receivers}, -- Barrel 16
                                no_scope_offset = {position = vector3_box(0, 0, .001), rotation = vector3_box(.7, 0, 0)}},
                            {dependencies = {_headhunter_barrels, "autogun_rifle_killshot_sight_01", _braced_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0)}},
                            -- Lasgun sight
                            {dependencies = {"barrel_16", "lasgun_rifle_sight_01", _braced_receivers}, -- Barrel 16
                                no_scope_offset = {position = vector3_box(0, 0, .009), rotation = vector3_box(-.3, 0, 0)}},
                            {dependencies = {_headhunter_barrels, "lasgun_rifle_sight_01", _braced_receivers},
                                no_scope_offset = {position = vector3_box(0, 0, .009), rotation = vector3_box(-.7, 0, 0)}},
                        --#endregion
                        -- Default
                        {dependencies = {"lasgun_rifle_sight_01"},
                            no_scope_offset = {position = vector3_box(0, 0, .008), rotation = vector3_box(-.1, 0, 0)}},
                    --#endregion
                    --#region Default values
                        {dependencies = {_infantry_receivers}, -- Scope Offset
                            scope_offset = {position = vector3_box(0, 0, -.0085)}},
                        {dependencies = {_headhunter_receivers}, -- Scope Offset
                            scope_offset = {position = vector3_box(0, 0, -.01025)}},
                        {dependencies = {_braced_receivers}, -- Scope Offset
                            scope_offset = {position = vector3_box(0, 0, -.009)}},
                    --#endregion
                    --#region Emblems
                        --#region Infantry receiver
                            {dependencies = {_infantry_receivers, "emblem_left_02"}, -- Emblems
                                emblem_left = {parent = "receiver", position = vector3_box(-.027, .21, .07), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, -1, 1)}},
                            {dependencies = {_infantry_receivers}, -- Emblems
                                emblem_left = {parent = "receiver", position = vector3_box(-.027, .21, .07), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, 1, 1)},
                                emblem_right = {parent = "receiver", position = vector3_box(.027, .21, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                        --#endregion
                        --#region Braced receiver
                            {dependencies = {_braced_receivers, "emblem_left_02"}, -- Emblems
                                emblem_left = {parent = "receiver", position = vector3_box(-.0215, .11, .102), rotation = vector3_box(0, 20, 180), scale = vector3_box(1, -1, 1)}},
                            {dependencies = {_braced_receivers}, -- Emblems
                                emblem_left = {parent = "receiver", position = vector3_box(-.0215, .11, .102), rotation = vector3_box(0, 20, 180), scale = vector3_box(1, 1, 1)},
                                emblem_right = {parent = "receiver", position = vector3_box(.029, -.02, .06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, 1.5, 1.5)}},
                        --#endregion
                        --#region Headhunter receiver
                            {dependencies = {"receiver_02|receiver_09", "emblem_left_02"}, -- Emblems
                                emblem_left = {parent = "receiver", position = vector3_box(-.029, -.02, .07), rotation = vector3_box(0, 0, 180), scale = vector3_box(1.8, -1.8, 1.8)}},
                            {dependencies = {"receiver_02|receiver_09"}, -- Emblems
                                emblem_left = {parent = "receiver", position = vector3_box(-.029, -.02, .07), rotation = vector3_box(0, 0, 180), scale = vector3_box(1.8, 1.8, 1.8)},
                                emblem_right = {parent = "receiver", position = vector3_box(.029, -.02, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.8, 1.8, 1.8)}},
                            {dependencies = {"receiver_04", "emblem_left_02"}, -- Emblems
                                emblem_left = {parent = "receiver", position = vector3_box(-.03, .1575, .057), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, -1, 1)}},
                            {dependencies = {"receiver_04"}, -- Emblems
                                emblem_left = {parent = "receiver", position = vector3_box(-.03, .1575, .057), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, 1, 1)},
                                emblem_right = {parent = "receiver", position = vector3_box(.03, .19, .04), rotation = vector3_box(0, 0, 0), scale = vector3_box(.7, .7, .7)}},
                            {dependencies = {"receiver_05|receiver_11", "emblem_left_02"}, -- Emblems
                                emblem_left = {parent = "receiver", position = vector3_box(-.03, .135, .06), rotation = vector3_box(0, 0, 180), scale = vector3_box(.7, -.7, .7)}},
                            {dependencies = {"receiver_05|receiver_11"}, -- Emblems
                                emblem_left = {parent = "receiver", position = vector3_box(-.03, .135, .06), rotation = vector3_box(0, 0, 180), scale = vector3_box(.7, .7, .7)},
                                emblem_right = {parent = "receiver", position = vector3_box(.03, .19, .04), rotation = vector3_box(0, 0, 0), scale = vector3_box(.7, .7, .7)}},
                        --#endregion
                    --#endregion
                    --#region Trinket hooks
                        --#region Infantry and braced barrels
                            {dependencies = {"grip_01", _infantry_and_braced_barrels}, -- Trinket
                                trinket_hook = {parent = "grip", position = vector3_box(0, -.115, -.15), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"}}},
                            {dependencies = {"grip_02", _infantry_and_braced_barrels}, -- Trinket
                                trinket_hook = {parent = "grip", position = vector3_box(0, -.12, -.165), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"}}},
                            {dependencies = {"grip_03", _infantry_and_braced_barrels}, -- Trinket
                                trinket_hook = {parent = "grip", position = vector3_box(0, -.155, -.125), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"}}},
                            {dependencies = {"grip_04", _infantry_and_braced_barrels}, -- Trinket
                                trinket_hook = {parent = "grip", position = vector3_box(0, -.132, -.136), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"}}},
                            {dependencies = {"grip_05", _infantry_and_braced_barrels}, -- Trinket
                                trinket_hook = {parent = "grip", position = vector3_box(0, -.145, -.120), rotation = vector3_box(-35, 0, 0), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook_empty"}, automatic_equip = {trinket_hook = "trinket_hook_empty|trinket_hook_02"}}},
                            {dependencies = {"grip_06", _infantry_and_braced_barrels}, -- Trinket
                                trinket_hook = {parent = "grip", position = vector3_box(0, -.12, -.145), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"}}},
                            {dependencies = {"grip_07", _infantry_and_braced_barrels}, -- Trinket
                                trinket_hook = {parent = "grip", position = vector3_box(0, -.132, -.136), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"}}},
                            {dependencies = {"grip_08", _infantry_and_braced_barrels}, -- Trinket
                                trinket_hook = {parent = "grip", position = vector3_box(0, -.145, -.120), rotation = vector3_box(-35, 0, 0), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook_empty"}, automatic_equip = {trinket_hook = "trinket_hook_empty|trinket_hook_02"}}},
                            {dependencies = {"grip_09|grip_10|grip_11|grip_31|grip_32", _infantry_and_braced_barrels}, -- Trinket
                                trinket_hook = {parent = "grip", parent_node = 5, position = vector3_box(.018, 0, 0), rotation = vector3_box(90, 0, -90), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "trinket_hook_empty"}}},
                            {dependencies = {"grip_12", _infantry_and_braced_barrels}, -- Trinket
                                trinket_hook = {parent = "grip", position = vector3_box(0, -.155, -.13), rotation = vector3_box(-35, 0, 0), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook_empty"}, automatic_equip = {trinket_hook = "trinket_hook_empty|trinket_hook_02"}}},
                            {dependencies = {"grip_14", _infantry_and_braced_barrels}, -- Trinket
                                trinket_hook = {parent = "grip", position = vector3_box(0, -.165, -.115), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"}}},
                            {dependencies = {"grip_13|grip_15|grip_34", _infantry_and_braced_barrels}, -- Trinket
                                trinket_hook = {parent = "grip", position = vector3_box(0, -.145, -.12), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook_empty"}, automatic_equip = {trinket_hook = "trinket_hook_empty|trinket_hook_02"}}},
                            {dependencies = {"grip_30", _infantry_and_braced_barrels}, -- Trinket
                                trinket_hook = {parent = "grip", position = vector3_box(0, -.125, -.12), rotation = vector3_box(-35, 0, 0), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook_empty"}, automatic_equip = {trinket_hook = "trinket_hook_empty|trinket_hook_02"}}},
                            {dependencies = {"grip_19|grip_33", _infantry_and_braced_barrels}, -- Trinket
                                trinket_hook = {parent = "grip", position = vector3_box(0, -.115, -.14), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"}}},
                            {dependencies = {"grip_20", _infantry_and_braced_barrels}, -- Trinket
                                trinket_hook = {parent = "grip", position = vector3_box(0, -.125, -.15), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"}}},
                            {dependencies = {"grip_21", _infantry_and_braced_barrels}, -- Trinket
                                trinket_hook = {parent = "grip", position = vector3_box(0, -.12, -.15), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"}}},
                            {dependencies = {"grip_22", _infantry_and_braced_barrels}, -- Trinket
                                trinket_hook = {parent = "grip", position = vector3_box(0, -.12, -.145), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"}}},
                            {dependencies = {"grip_23", _infantry_and_braced_barrels}, -- Trinket
                                trinket_hook = {parent = "grip", position = vector3_box(0, -.12, -.145), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"}}},
                            {dependencies = {"grip_24", _infantry_and_braced_barrels}, -- Trinket
                                trinket_hook = {parent = "grip", position = vector3_box(0, -.135, -.15), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"}}},
                            {dependencies = {"grip_25", _infantry_and_braced_barrels}, -- Trinket
                                trinket_hook = {parent = "grip", position = vector3_box(0, -.165, -.11), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"}}},
                            {dependencies = {"grip_26", _infantry_and_braced_barrels}, -- Trinket
                                trinket_hook = {parent = "grip", position = vector3_box(0, -.165, -.11), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"}}},
                            {dependencies = {"grip_27|grip_28|grip_29", _infantry_and_braced_barrels}, -- Trinket
                                trinket_hook = {parent = "grip", position = vector3_box(0, -.17, -.11), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook_empty"}, automatic_equip = {trinket_hook = "trinket_hook_empty|trinket_hook_02"}}},
                        --#endregion
                        --#region Headhunter barrels
                            {dependencies = {"barrel_11"}, -- Trinket
                                trinket_hook = {parent = "barrel", position = vector3_box(0, .25, -.105), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"}}},
                            {dependencies = {"barrel_15"}, -- Trinket
                                trinket_hook = {parent = "barrel", position = vector3_box(0, .255, -.12), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"}}},
                            {dependencies = {"barrel_16"}, -- Trinket
                                trinket_hook = {parent = "barrel", position = vector3_box(0, .23, -.11), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"}}},
                            {dependencies = {"barrel_12"}, -- Trinket
                                trinket_hook = {parent = "barrel", parent_node = 3, position = vector3_box(.029, 0, 0), rotation = vector3_box(90, 0, -45), scale = vector3_box(1, 1, 1),
                                no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"}}},
                        --#endregion
                    --#endregion
                    --#region Magazines
                        {dependencies = {_headhunter_receivers, "auto_pistol_magazine_01"}, -- Magazine
                            magazine = {offset = true, position = vector3_box(0, .01, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1.6, 1.6)}},
                        {dependencies = {"auto_pistol_magazine_01"}, -- Magazine
                            magazine = {offset = true, position = vector3_box(0, .0025, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1.6, 1.6)}},
                        {dependencies = {_headhunter_receivers, "bolter_magazine_01"}, -- Magazine
                            magazine = {offset = true, position = vector3_box(0, .005, -.035), rotation = vector3_box(0, 0, 0), scale = vector3_box(.7, 1, 1)}},
                        {dependencies = {"bolter_magazine_01"}, -- Magazine
                            magazine = {offset = true, position = vector3_box(0, 0, -.035), rotation = vector3_box(0, 0, 0), scale = vector3_box(.7, 1, 1)}},
                        {dependencies = {_headhunter_receivers, "bolter_magazine_02"}, -- Magazine
                            magazine = {offset = true, position = vector3_box(0, .005, -.035), rotation = vector3_box(0, 0, 0), scale = vector3_box(.7, 1, 1)}},
                        {dependencies = {"bolter_magazine_02"}, -- Magazine
                            magazine = {offset = true, position = vector3_box(0, 0, -.035), rotation = vector3_box(0, 0, 0), scale = vector3_box(.7, 1, 1)}},
                        {dependencies = {"bolter_magazine_03"}, -- Magazine
                            magazine = {offset = true, position = vector3_box(0, 0, -.05), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1.2, 1.2)}},
                        {dependencies = {"boltpistol_magazine_01|boltpistol_magazine_02"}, -- Magazine
                            magazine = {offset = true, position = vector3_box(0, 0, -.05), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1.15, 1.218)}},
                    --#endregion
                },
            },
            -- ┌─┐┌─┐┌─┐┌─┐┌─┐┌┬┐
            -- │ │├┤ ├┤ └─┐├┤  │
            -- └─┘└  └  └─┘└─┘ ┴
            offset = {
                default = mod.visible_equipment_offsets.human.WEAPON_RANGED.default,
                backpack = mod.visible_equipment_offsets.human.WEAPON_RANGED.backpack,
                -- center_mass = vector3_box(0, -.3, 0),
                loading = mod.visible_equipment_loading_offsets.default,
            },
        }
    )
--#endregion