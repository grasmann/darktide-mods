local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
    local _common_ranged = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_ranged")
    local _common_lasgun = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_lasgun")
    local _autogun_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/autogun_p1_m1")
    local _shotgun_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/shotgun_p1_m1")
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
    _shotgun_p1_m1,
    {
        attachments = {
            -- Native
            receiver = _shotgun_p1_m1.receiver_attachments(),
            stock = _shotgun_p1_m1.stock_attachments(),
            barrel = _shotgun_p1_m1.barrel_attachments(),
            underbarrel = _shotgun_p1_m1.underbarrel_attachments(),
            -- sight = functions.sight_attachments(),
            -- Ranged
            flashlight = _common_ranged.flashlights_attachments(),
            sight = table.icombine(
                _common_ranged.reflex_sights_attachments(),
                _common_ranged.scopes_attachments(false)
            ),
            -- Lasgun
            -- rail = _common_lasgun.rail_attachments(),
            -- Autogun
            muzzle = _autogun_p1_m1.muzzle_attachments();
            -- Common
            trinket_hook = _common.trinket_hook_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
        },
        models = table.combine(
            -- Native
            _shotgun_p1_m1.receiver_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.00001), nil, nil, {
                {sight = "sight_07|sight_default"},
                {sight = "sight_07|sight_default"},
                {sight = "sight_default|sight_07", rail = "rail_default"},
                {sight = "sight_default|sight_07", rail = "rail_default"},
                {sight = "sight_default|sight_07", rail = "rail_default"},
            }, nil, nil, function(gear_id, item, attachment)
                local changes = {}
                if attachment == "receiver_02" or attachment == "receiver_03" or attachment == "receiver_04" then
                    local barrel = mod:get_gear_setting(gear_id, "barrel", item)
                    if barrel ~= "barrel_10" and barrel ~= "barrel_11" and barrel ~= "barrel_12" then changes["barrel"] = "barrel_10" end
                else
                    local barrel = mod:get_gear_setting(gear_id, "barrel", item)
                    if barrel == "barrel_10" or barrel == "barrel_11" or barrel == "barrel_12" then changes["barrel"] = "barrel_01" end
                end
                return changes
            end),
            _shotgun_p1_m1.stock_models("receiver", 0, vector3_box(-.4, -4, 0), vector3_box(0, -.2, 0)),
            _shotgun_p1_m1.barrel_models(nil, -.5, vector3_box(.1, -4, 0), vector3_box(0, .2, 0), nil, {
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook"},
                {"trinket_hook"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty", "underbarrel"},
                {"trinket_hook_empty", "underbarrel"},
                {"trinket_hook_empty", "underbarrel"},
            }, {
                {trinket_hook = "trinket_hook_empty|trinket_hook_01",     underbarrel = "no_underbarrel|underbarrel_01"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01",     underbarrel = "no_underbarrel|underbarrel_02"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01",     underbarrel = "no_underbarrel|underbarrel_03"},
                {trinket_hook = "!trinket_hook_empty|trinket_hook_empty", underbarrel = "no_underbarrel|underbarrel_04"},
                {trinket_hook = "!trinket_hook_empty|trinket_hook_empty", underbarrel = "no_underbarrel|underbarrel_05"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01",     underbarrel = "no_underbarrel|underbarrel_06"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01",     underbarrel = "no_underbarrel|underbarrel_07"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01",     underbarrel = "no_underbarrel|underbarrel_08"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01",     underbarrel = "!no_underbarrel|no_underbarrel"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01",     underbarrel = "!no_underbarrel|no_underbarrel"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01",     underbarrel = "!no_underbarrel|no_underbarrel"},
            }, nil, nil, function(gear_id, item, attachment)
                local changes = {}
                changes["muzzle_2"] = mod:get_gear_setting(gear_id, "muzzle", item)
                if attachment == "barrel_10" or attachment == "barrel_11" or attachment == "barrel_12" then
                    local receiver = mod:get_gear_setting(gear_id, "receiver", item)
                    if receiver ~= "receiver_02" and receiver ~= "receiver_03" and receiver ~= "receiver_04" then changes["receiver"] = "receiver_02" end
                else
                    local receiver = mod:get_gear_setting(gear_id, "receiver", item)
                    if receiver == "receiver_02" or receiver == "receiver_03" or receiver == "receiver_04" then changes["receiver"] = "receiver_01" end
                end
                return changes
            end),
            _shotgun_p1_m1.underbarrel_models(nil, -.5, vector3_box(0, -4, 0), vector3_box(0, 0, -.2)),
            _shotgun_p1_m1.sight_models(nil, -.5, vector3_box(-.3, -4, -.2), vector3_box(0, 0, .1), "sight", nil, {
                {rail = "rail_default", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"}
            }),
            -- Ranged
            _common_ranged.flashlight_models(nil, -2.5, vector3_box(-.3, -3, 0), vector3_box(.2, 0, 0)),
            -- _common_ranged.reflex_sights_models(nil, -.5, vector3_box(-.3, -4, -.2), vector3_box(0, -.2, 0)),
            _common_ranged.reflex_sights_models("barrel", -.5, vector3_box(-.3, -4, -.2), vector3_box(0, -.4, 0), "sight", {}, {
                {rail = "rail_default", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
                {rail = "rail_01", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
                {rail = "rail_01", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
                {rail = "rail_01", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
            }),
            _common_ranged.sights_models("barrel", .35, vector3_box(0, -4, -.2), {
                vector3_box(-.2, 0, 0),
                vector3_box(0, -.2, 0),
                vector3_box(0, -.2, 0),
                vector3_box(0, -.2, 0),
                vector3_box(-.2, 0, 0),
                vector3_box(0, -.2, 0),
                vector3_box(0, -.2, 0),
                vector3_box(0, -.2, 0),
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
            }, {}, {
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
            _common_ranged.scope_sights_models("barrel", .2, vector3_box(0, -4, -.2), vector3_box(0, 0, 0), "sight_2", {}, {
                {rail = "rail_default"},
                {rail = "rail_01"},
                {rail = "rail_01"},
                {rail = "rail_01"},
                {rail = "rail_default"},
            }),
            _common_ranged.scope_lens_models("sight_2", .2, vector3_box(0, -4, -.2), vector3_box(0, 0, 0)),
            _common_ranged.scope_lens_2_models("sight_2", .2, vector3_box(0, -4, -.2), vector3_box(0, 0, 0)),
            -- Lasgun
            _common_lasgun.rail_models("barrel", 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2)),
            -- Autogun
            _autogun_p1_m1.muzzle_models("barrel", -.5, vector3_box(0, 0, 0), vector3_box(0, .2, 0)),
            -- Common
            _common.emblem_right_models("receiver", -3, vector3_box(-.4, -5, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("receiver", 0, vector3_box(0, -5, 0), vector3_box(-.2, 0, 0)),
            _common.trinket_hook_models(nil, -.2, vector3_box(.3, -4, .1), vector3_box(0, 0, -.2))
        ),
        anchors = {
            scope_offset = {position = vector3_box(0, 0, -.02)},
            fixes = {
                {dependencies = {"barrel_01|barrel_02|barrel_04"},
                    rail = {parent = "barrel", position = vector3_box(0, -.045, .035), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 2.2, 1)}},
                {dependencies = {"barrel_03|barrel_07|barrel_08|barrel_09"},
                    rail = {parent = "barrel", position = vector3_box(0, -.045, .035), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 2.1, 1)}},
                -- {dependencies = {"barrel_10|barrel_11|barrel_12"},
                --     rail = {parent = "barrel", position = vector3_box(0, -.045, .035), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 2.3, 1)}},
                {rail = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                
                {dependencies = {"barrel_01"},
                    muzzle = {parent = "barrel", position = vector3_box(0, .475, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.25, 1.25, 1.25)}},
                {dependencies = {"barrel_02"},
                    muzzle = {parent = "barrel", position = vector3_box(0, .71, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.25, 1.25, 1.25)}},
                {dependencies = {"barrel_03"},
                    muzzle = {parent = "barrel", position = vector3_box(0, .5, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.25, 1.25, 1.25)}},
                {dependencies = {"barrel_04"},
                    muzzle = {parent = "barrel", position = vector3_box(0, .51, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.25, 1.25, 1.25)}},
                {dependencies = {"barrel_07"},
                    muzzle = {parent = "barrel", position = vector3_box(0, .475, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.25, 1.25, 1.25)}},
                {dependencies = {"barrel_08"},
                    muzzle = {parent = "barrel", position = vector3_box(0, .475, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.25, 1.25, 1.25)}},
                {dependencies = {"barrel_09"},
                    muzzle = {parent = "barrel", position = vector3_box(0, .475, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.25, 1.25, 1.25)}},
                {dependencies = {"barrel_10"},
                    muzzle = {parent = "barrel", position = vector3_box(-.03, .36, .0575), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.25, 1.25, 1.25)},
                    muzzle_2 = {parent = "barrel", position = vector3_box(.03, .36, .0575), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.25, 1.25, 1.25)}},
                {dependencies = {"barrel_11"},
                    muzzle = {parent = "barrel", position = vector3_box(-.03, .47, .0575), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.25, 1.25, 1.25)},
                    muzzle_2 = {parent = "barrel", position = vector3_box(.03, .47, .0575), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.25, 1.25, 1.25)}},
                {dependencies = {"barrel_12"},
                    muzzle = {parent = "barrel", position = vector3_box(-.03, .6, .0575), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.25, 1.25, 1.25)},
                    muzzle_2 = {parent = "barrel", position = vector3_box(.03, .6, .0575), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.25, 1.25, 1.25)}},
                {muzzle = {parent = "barrel", position = vector3_box(0, .5, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.25, 1.25, 1.25)}},
                {muzzle_2 = {parent = "barrel", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},

                {barrel = {offset = true, animation_wait_detach = {"underbarrel", "rail", "sight"}, trigger_move = {"underbarrel", "rail", "sight"}}},
                {underbarrel = {offset = true, animation_wait_attach = {"barrel"}}},
                -- Ranger's Vigil
                {dependencies = {"scope_03", "barrel_10|barrel_11|barrel_12"},
                    sight = {parent = "barrel", position = vector3_box(0, -.08, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1), animation_wait_attach = {"rail"}},
                    scope_offset = {position = vector3_box(0, -.15, -.0235), fov = 25, custom_fov = 32.5, custom_fov_multiplier = 1.3, aim_scale = .75}},
                {dependencies = {"scope_03"},
                    sight = {parent = "barrel", position = vector3_box(0, -.1, .075), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1), animation_wait_attach = {"rail"}},
                    lens = {parent = "sight_2", position = vector3_box(0, .08, .034), rotation = vector3_box(0, 0, 0), scale = vector3_box(.62, 1, .62), data = {lens = 1}},
                    lens_2 = {parent = "sight_2", position = vector3_box(0, .22, .034), rotation = vector3_box(180, 0, 0), scale = vector3_box(.62, 1, .62), data = {lens = 2}},
                    sight_2 = {parent = "sight", position = vector3_box(0, 0, -.0425), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}}},
                    scope_offset = {position = vector3_box(0, -.1, -.012), fov = 25, custom_fov = 32.5, custom_fov_multiplier = 1.3, aim_scale = .75}},
                -- Martyr's Gaze
                {dependencies = {"scope_01", "barrel_10|barrel_11|barrel_12"},
                    sight = {parent = "barrel", position = vector3_box(0, -.16, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1.5, 1), animation_wait_attach = {"rail"}},
                    scope_offset = {position = vector3_box(0, -.16, -.024), fov = 15, custom_fov = 27, fov_multiplier = 1.8, aim_scale = .65}},
                {dependencies = {"scope_01"}, -- Lasgun sight
                    sight = {parent = "barrel", position = vector3_box(0, -.12, .075), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1.5, 1)},
                    lens = {parent = "sight_2", position = vector3_box(0, .12, .031), rotation = vector3_box(0, 0, 0), scale = vector3_box(.64, .6, .7), data = {lens = 1}},
                    lens_2 = {parent = "sight_2", position = vector3_box(0, .01, .031), rotation = vector3_box(180, 0, 0), scale = vector3_box(.64, .85, .7), data = {lens = 2}},
                    sight_2 = {parent = "sight", position = vector3_box(0, .07, -.0415), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}}},
                    scope_offset = {position = vector3_box(0, -.1, -.013), fov = 15, custom_fov = 27, fov_multiplier = 1.8, aim_scale = .65}},
                -- Exterminatus Lens
                {dependencies = {"scope_02", "barrel_10|barrel_11|barrel_12"},
                    sight = {parent = "barrel", position = vector3_box(0, -.16, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 3, 1), animation_wait_attach = {"rail"}},
                    scope_offset = {position = vector3_box(0, -.1, -.025), fov = 9, custom_fov = 24, fov_multiplier = 2, aim_scale = .65}},
                {dependencies = {"scope_02"}, -- Lasgun sight
                    sight = {parent = "barrel", position = vector3_box(0, -.14, .075), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 3, 1), animation_wait_attach = {"rail"}},
                    lens = {parent = "sight_2", position = vector3_box(0, -.02, .03), rotation = vector3_box(0, 0, 0), scale = vector3_box(.62, .4, .7), data = {lens = 1}},
                    lens_2 = {parent = "sight_2", position = vector3_box(0, -.14, .03), rotation = vector3_box(180, 0, 0), scale = vector3_box(.62, .4, .7), data = {lens = 2}},
                    sight_2 = {parent = "sight", position = vector3_box(0, .09, -.04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 3, 4, 5}}},
                    scope_offset = {position = vector3_box(0, -.1, -.0145), fov = 9, custom_fov = 24, fov_multiplier = 2, aim_scale = .65}},
                {sight_2 = {parent = "barrel", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                {lens = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                {lens_2 = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},

                {dependencies = {"receiver_02|receiver_04", "emblem_left_02"}, -- Emblems
                    emblem_left = {parent = "receiver", position = vector3_box(-.033, .035, .056), rotation = vector3_box(0, 0, 180), scale = vector3_box(.75, -.75, .75)}},
                {dependencies = {"receiver_02|receiver_04"}, -- Emblems
                    emblem_left = {parent = "receiver", position = vector3_box(-.033, .035, .056), rotation = vector3_box(0, 0, 180), scale = vector3_box(.75, .75, .75)},
                    emblem_right = {parent = "receiver", position = vector3_box(.033, .035, .056), rotation = vector3_box(0, 0, 0), scale = vector3_box(.75, .75, .75)}},
                {dependencies = {"receiver_03", "emblem_left_02"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.052, .08, .062), rotation = vector3_box(0, 0, 180), scale = vector3_box(.75, -.75, .75)}},
                {dependencies = {"receiver_03"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.052, .08, .062), rotation = vector3_box(0, 0, 180), scale = vector3_box(.75, .75, .75)},
                    emblem_right = {parent = "barrel", position = vector3_box(.052, .08, .062), rotation = vector3_box(0, 0, 0), scale = vector3_box(.75, .75, .75)}},
                {dependencies = {"barrel_10|barrel_11|barrel_12", "reflex_sight_01|reflex_sight_02|reflex_sight_03"}, -- Grip
                    -- sight = {parent = "barrel", position = vector3_box(0, 0, .1), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)},
                    sight = {parent = "barrel", position = vector3_box(0, -.03, .1), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1), animation_wait_attach = {"barrel"}},
                    scope_offset = {position = vector3_box(0, -.05, -.014)}},
                {dependencies = {"reflex_sight_01|reflex_sight_02|reflex_sight_03"}, -- Grip
                    -- sight = {parent = "barrel", position = vector3_box(0, 0, .1), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)},
                    sight = {parent = "barrel", position = vector3_box(0, -.065, .035), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1), animation_wait_attach = {"barrel"}},
                    scope_offset = {position = vector3_box(0, -.05, -.0035)}},
                {dependencies = {"barrel_10|barrel_11|barrel_12"}, -- Grip
                    ammo = {offset = true, position = vector3_box(0, 0, .05), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)},
                    ammo_used = {offset = true, position = vector3_box(0, 0, .05), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)},
                    sight = {parent = "barrel", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0), animation_wait_attach = {"barrel"}},
                    trinket_hook = {parent = "barrel", position = vector3_box(0, 0, -.024), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    no_scope_offset = {position = vector3_box(0, 0, .0075)}},
                {dependencies = {"grip_27|grip_28|grip_29"}, -- Grip
                    grip = {offset = true, position = vector3_box(0, .01, -.02), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_01"}, -- Flashlight
                    flashlight = {parent = "barrel", position = vector3_box(.03, .4, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_02"}, -- Flashlight
                    flashlight = {parent = "barrel", position = vector3_box(.03, .45, -.025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_03"}, -- Flashlight
                    flashlight = {parent = "barrel", position = vector3_box(.025, .4, -.045), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_04"}, -- Flashlight
                    flashlight = {parent = "barrel", position = vector3_box(.042, .4, -.025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_01", "laser_pointer"}, -- Flashlight
                    flashlight = {parent = "barrel", position = vector3_box(.03, .4, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_02", "laser_pointer"}, -- Flashlight
                    flashlight = {parent = "barrel", position = vector3_box(.03, .45, -.025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_03", "laser_pointer"}, -- Flashlight
                    flashlight = {parent = "barrel", position = vector3_box(.025, .4, -.045), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_04", "laser_pointer"}, -- Flashlight
                    flashlight = {parent = "barrel", position = vector3_box(.042, .4, -.025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                -- {dependencies = {"scope_01|scope_02|scope_03|reflex_sight_01|reflex_sight_02|reflex_sight_03"},
                --     sight = {parent = "rail", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                
                {sight = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_01", "emblem_left_02"}, -- Emblem
                    emblem_left = {parent = "barrel", position = vector3_box(-.035, .225, .003), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, -1, 1)}},
                {dependencies = {"barrel_01"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.035, .225, .003), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, 1, 1)},
                    emblem_right = {parent = "barrel", position = vector3_box(.035, .225, .003), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_02", "emblem_left_02"}, -- Emblem
                    emblem_left = {parent = "barrel", position = vector3_box(-.035, .225, .003), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, -1, 1)}},
                {dependencies = {"barrel_02"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.035, .225, .003), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, 1, 1)},
                    emblem_right = {parent = "barrel", position = vector3_box(.035, .225, .003), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_03", "emblem_left_02"}, -- Emblem
                    emblem_left = {parent = "barrel", position = vector3_box(-.035, .08, .003), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, -1, 1)}},
                {dependencies = {"barrel_03"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.035, .08, .003), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, 1, 1)},
                    emblem_right = {parent = "barrel", position = vector3_box(.035, .08, .003), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_04", "emblem_left_02"}, -- Emblem
                    emblem_left = {parent = "barrel", position = vector3_box(-.035, .155, .003), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, -1, 1)}},
                {dependencies = {"barrel_04"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.035, .155, .003), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, 1, 1)},
                    emblem_right = {parent = "barrel", position = vector3_box(.035, .155, .003), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
            },
        },
    }
)