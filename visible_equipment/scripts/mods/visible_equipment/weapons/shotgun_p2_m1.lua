local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
    local _common_ranged = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_ranged")
    local _common_lasgun = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_lasgun")
    local _autogun_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/autogun_p1_m1")
    local _shotgun_p2_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/shotgun_p2_m1")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local vector3_box = Vector3Box
    local tostring = tostring
    local table = table
    local math = math
    local math_random = math.random
--#endregion

-- ##### ┌┬┐┌─┐┌─┐┬┌┐┌┬┌┬┐┬┌─┐┌┐┌┌─┐ ##################################################################################
-- #####  ││├┤ ├┤ │││││ │ ││ ││││└─┐ ##################################################################################
-- ##### ─┴┘└─┘└  ┴┘└┘┴ ┴ ┴└─┘┘└┘└─┘ ##################################################################################

local _single_barrel_barrels = {"barrel_01", "barrel_02", "barrel_03", "barrel_04", "barrel_07", "barrel_08", "barrel_09"}
local _single_barrel_receivers = {"receiver_01"}
local _double_barrel_barrels = {"barrel_10", "barrel_11", "barrel_12"}
local _double_barrel_receivers = {"receiver_02", "receiver_03", "receiver_04"}

return table.combine(
    _shotgun_p2_m1,
    {
        attachments = {
            -- Native
            receiver = _shotgun_p2_m1.receiver_attachments(),
            stock = _shotgun_p2_m1.stock_attachments(),
            barrel = _shotgun_p2_m1.barrel_attachments(),
            -- Ranged
            flashlight = _common_ranged.flashlights_attachments(),
            sight = table.icombine(
                _shotgun_p2_m1.sight_attachments(),
                _common_ranged.reflex_sights_attachments(false),
                _common_ranged.scopes_attachments(false)
            ),
            -- Autogun
            muzzle = _autogun_p1_m1.muzzle_attachments();
            -- Common
            trinket_hook = _common.trinket_hook_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
        },
        models = table.combine(
            -- Native
            _shotgun_p2_m1.sight_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.2)),
            _shotgun_p2_m1.receiver_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.00001)),
            _shotgun_p2_m1.stock_models("receiver", 0, vector3_box(-.4, -4, 0), vector3_box(0, -.2, 0)),
            _shotgun_p2_m1.barrel_models(nil, -.5, vector3_box(.1, -4, 0), vector3_box(0, .2, 0)),
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
            -- Autogun
            _autogun_p1_m1.muzzle_models("barrel", -.5, vector3_box(0, 0, 0), vector3_box(0, .2, 0), nil, nil, nil, nil, nil, function(gear_id, item, attachment, attachment_list)
                return {muzzle_2 = attachment_list and attachment_list["muzzle"] or mod.gear_settings:get(item, "muzzle")}
            end),
            -- Common
            _common.emblem_right_models("receiver", -3, vector3_box(-.4, -5, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("receiver", 0, vector3_box(0, -5, 0), vector3_box(-.2, 0, 0)),
            _common.trinket_hook_models(nil, -.2, vector3_box(.3, -4, .1), vector3_box(0, 0, -.2))
        ),
        anchors = {
            fixes = {
                --#region Muzzle
                    {dependencies = {"double_barrel_barrel_01"},
                        muzzle = {parent = "barrel", position = vector3_box(-.03, .36, .0575), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.25, 1.25, 1.25), trigger_move = {"muzzle_2"}},
                        muzzle_2 = {parent = "barrel", position = vector3_box(.03, .36, .0575), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.25, 1.25, 1.25)}},
                    {dependencies = {"double_barrel_barrel_02"},
                        muzzle = {parent = "barrel", position = vector3_box(-.03, .47, .0575), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.25, 1.25, 1.25), trigger_move = {"muzzle_2"}},
                        muzzle_2 = {parent = "barrel", position = vector3_box(.03, .47, .0575), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.25, 1.25, 1.25)}},
                    {dependencies = {"double_barrel_barrel_03"},
                        muzzle = {parent = "barrel", position = vector3_box(-.03, .6, .0575), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.25, 1.25, 1.25), trigger_move = {"muzzle_2"}},
                        muzzle_2 = {parent = "barrel", position = vector3_box(.03, .6, .0575), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.25, 1.25, 1.25)}},
                    {muzzle = {parent = "barrel", position = vector3_box(0, .5, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.25, 1.25, 1.25), trigger_move = {"muzzle_2"}}},
                    {muzzle_2 = {parent = "barrel", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                --#endregion
                --#region Barrel
                    {barrel = {offset = true, animation_wait_detach = {"rail", "sight", "muzzle_2"}, trigger_move = {"rail", "sight", "muzzle_2"}}},
                --#endregion
                --#region Scopes
                    -- Ranger's Vigil
                    {dependencies = {"scope_03"},
                        sight = {parent = "barrel", position = vector3_box(0, -.1, .137), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1), animation_wait_attach = {"rail"}},
                        lens = {parent = "sight_2", position = vector3_box(0, .08, .034), rotation = vector3_box(0, 0, 0), scale = vector3_box(.62, 1, .62), data = {lens = 1}},
                        lens_2 = {parent = "sight_2", position = vector3_box(0, .22, .034), rotation = vector3_box(180, 0, 0), scale = vector3_box(.62, 1, .62), data = {lens = 2}},
                        sight_2 = {parent = "sight", position = vector3_box(0, 0, -.0425), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}}},
                        scope_offset = {position = vector3_box(-.07, -.05, .035), fov = 25, custom_fov = 32.5, custom_fov_multiplier = 1.3, aim_scale = .75, lense_transparency = true}},
                    -- Martyr's Gaze
                    {dependencies = {"scope_01"}, -- Lasgun sight
                        sight = {parent = "barrel", position = vector3_box(0, -.12, .139), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1.5, 1)},
                        lens = {parent = "sight_2", position = vector3_box(0, .12, .031), rotation = vector3_box(0, 0, 0), scale = vector3_box(.64, .6, .7), data = {lens = 1}},
                        lens_2 = {parent = "sight_2", position = vector3_box(0, .01, .031), rotation = vector3_box(180, 0, 0), scale = vector3_box(.64, .85, .7), data = {lens = 2}},
                        sight_2 = {parent = "sight", position = vector3_box(0, .07, -.0415), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}}},
                        scope_offset = {position = vector3_box(0, -.1, -.013), fov = 15, custom_fov = 27, fov_multiplier = 1.8, aim_scale = .65, lense_transparency = true}},
                    -- Exterminatus Lens
                    {dependencies = {"scope_02"}, -- Lasgun sight
                        sight = {parent = "barrel", position = vector3_box(0, -.14, .139), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 3, 1), animation_wait_attach = {"rail"}},
                        lens = {parent = "sight_2", position = vector3_box(0, -.02, .03), rotation = vector3_box(0, 0, 0), scale = vector3_box(.62, .4, .7), data = {lens = 1}},
                        lens_2 = {parent = "sight_2", position = vector3_box(0, -.14, .03), rotation = vector3_box(180, 0, 0), scale = vector3_box(.62, .4, .7), data = {lens = 2}},
                        sight_2 = {parent = "sight", position = vector3_box(0, .09, -.04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 3, 4, 5}}},
                        scope_offset = {position = vector3_box(0, -.1, -.0145), fov = 9, custom_fov = 24, fov_multiplier = 2, aim_scale = .65, lense_transparency = true}},
                    {sight_2 = {parent = "barrel", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                    {lens = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                    {lens_2 = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                --#endregion
                --#region Reflex Sights
                    {dependencies = {"reflex_sight_01|reflex_sight_02|reflex_sight_03"}, -- Grip
                        sight = {parent = "barrel", position = vector3_box(0, -.041, .1), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1), animation_wait_attach = {"barrel"}},
                        scope_offset = {position = vector3_box(-.07, -.05, .035)}},
                --#endregion
                --#region Sight
                    -- {dependencies = {"double_barrel_sight_01"}, -- Grip
                    --     -- sight = {parent = "barrel", position = vector3_box(0, -.041, .1), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1), animation_wait_attach = {"barrel"}},
                    --     scope_offset = {position = vector3_box(-.07, -.05, .035)}},
                    {sight = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                --#endregion
                --#region Emblems
                    {dependencies = {"double_barrel_receiver_01|double_barrel_receiver_03", "emblem_left_02"}, -- Emblems
                        emblem_left = {parent = "receiver", position = vector3_box(-.033, .035, .056), rotation = vector3_box(0, 0, 180), scale = vector3_box(.75, -.75, .75)}},
                    {dependencies = {"double_barrel_receiver_01|double_barrel_receiver_03"}, -- Emblems
                        emblem_left = {parent = "receiver", position = vector3_box(-.033, .035, .056), rotation = vector3_box(0, 0, 180), scale = vector3_box(.75, .75, .75)},
                        emblem_right = {parent = "receiver", position = vector3_box(.033, .035, .056), rotation = vector3_box(0, 0, 0), scale = vector3_box(.75, .75, .75)}},
                    {dependencies = {"double_barrel_receiver_02", "emblem_left_02"}, -- Emblems
                        emblem_left = {parent = "barrel", position = vector3_box(-.052, .08, .062), rotation = vector3_box(0, 0, 180), scale = vector3_box(.75, -.75, .75)}},
                    {dependencies = {"double_barrel_receiver_02"}, -- Emblems
                        emblem_left = {parent = "barrel", position = vector3_box(-.052, .08, .062), rotation = vector3_box(0, 0, 180), scale = vector3_box(.75, .75, .75)},
                        emblem_right = {parent = "barrel", position = vector3_box(.052, .08, .062), rotation = vector3_box(0, 0, 0), scale = vector3_box(.75, .75, .75)}},
                --#endregion
                --#region Grip
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
                --#endregion
            },
        },
    }
)