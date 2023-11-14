local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
local _common_ranged = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_ranged")
local _common_lasgun = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_lasgun")
local _bolter_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/bolter_p1_m1")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_melee = _item.."/melee"
local _item_minion = "content/items/weapons/minions"

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local string = string
    local string_find = string.find
    local vector3_box = Vector3Box
    local table = table
    local pairs = pairs
    local ipairs = ipairs
    local type = type
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

local functions = {
    receiver_attachments = function(default)
        local attachments = {
            {id = "receiver_01",        name = "Receiver 1"},
            {id = "receiver_02",        name = "Receiver 2"},
            {id = "receiver_03",        name = "Receiver 3"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "receiver_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    receiver_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "receiver_default", model = ""},
            {name = "receiver_01",      model = _item_ranged.."/recievers/lasgun_rifle_krieg_receiver_01"},
            {name = "receiver_02",      model = _item_ranged.."/recievers/lasgun_rifle_krieg_receiver_02"},
            {name = "receiver_03",      model = _item_ranged.."/recievers/lasgun_rifle_krieg_receiver_04"},
        }, parent, angle, move, remove, type or "receiver", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    stock_attachments = function(default)
        local attachments = {
            {id = "stock_01",       name = "Stock 1"},
            {id = "stock_02",       name = "Stock 2"},
            {id = "stock_03",       name = "Stock 3"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "stock_default",  name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    stock_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "stock_default", model = ""},
            {name = "stock_01",      model = _item_ranged.."/stocks/lasgun_rifle_krieg_stock_01"},
            {name = "stock_02",      model = _item_ranged.."/stocks/lasgun_rifle_krieg_stock_02"},
            {name = "stock_03",      model = _item_ranged.."/stocks/lasgun_rifle_krieg_stock_04"},
        }, parent, angle, move, remove, type or "stock", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}

-- ##### ┌┬┐┌─┐┌─┐┬┌┐┌┬┌┬┐┬┌─┐┌┐┌┌─┐ ##################################################################################
-- #####  ││├┤ ├┤ │││││ │ ││ ││││└─┐ ##################################################################################
-- ##### ─┴┘└─┘└  ┴┘└┘┴ ┴ ┴└─┘┘└┘└─┘ ##################################################################################

return table.combine(
    functions,
    {
        attachments = {
            -- Native
            receiver = functions.receiver_attachments(),
            stock = functions.stock_attachments(),
            -- Lasgun
            barrel = _common_lasgun.barrel_attachments(),
            muzzle = _common_lasgun.muzzle_attachments(),
            magazine = _common_lasgun.magazine_attachments(),
            -- rail = _lasgun_rail_attachments(),
            -- Ranged
            flashlight = _common_ranged.flashlights_attachments(),
            bayonet = _common_ranged.bayonet_attachments(),
            sight = table.icombine(
                _common_ranged.sight_default(),
                _common_ranged.reflex_sights_attachments(),
                _common_ranged.sights_attachments()
            ),
            -- Bolter
            -- help_sight = _bolter_p1_m1.sight_attachments(),
            -- Common
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
        },
        models = table.combine(
            -- Native
            functions.receiver_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.00001)),
            functions.stock_models(nil, .5, vector3_box(-.5, -4, 0), vector3_box(0, -.4, -.11)),
            -- Lasgun
            _common_lasgun.barrel_models(nil, -.3, vector3_box(0, -2, 0), vector3_box(0, .2, 0)),
            _common_lasgun.muzzle_models(nil, -.5, vector3_box(.1, -3, 0), vector3_box(0, .2, 0)),
            _common_lasgun.magazine_models(nil, .2, vector3_box(-.2, -3, .1), vector3_box(0, 0, -.2)),
            -- _lasgun_rail_models("receiver", 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2)),
            -- Ranged
            _common_ranged.flashlight_models(nil, -2.5, vector3_box(-.5, -3, -.05), vector3_box(.2, 0, 0)),
            _common_ranged.bayonet_models({"barrel", "barrel", "barrel", "muzzle"}, -.5, vector3_box(.1, -3, 0), vector3_box(0, .4, -.034)),
            _common_ranged.grip_models(nil, .4, vector3_box(-.4, -4, .1), vector3_box(0, -.1, -.1)),
            _common_ranged.reflex_sights_models(nil, .2, vector3_box(-.3, -4, -.2), vector3_box(0, -.2, 0), "sight", {}, {
                {help_sight = "sight_default", sight_2 = "sight_default"},
                {help_sight = "sight_default", sight_2 = "sight_default"},
                {help_sight = "sight_default", sight_2 = "sight_default"},
                {help_sight = "sight_default", sight_2 = "sight_default"},
            }, {}),
            _common_ranged.sights_models(nil, .35, vector3_box(-.3, -4, -.2), vector3_box(0, -.2, 0), "sight", {}, {
                {help_sight = "sight_default", sight_2 = "sight_default"},
                {help_sight = "bolter_sight_01", sight_2 = "sight_default"},
                {help_sight = "bolter_sight_01", sight_2 = "sight_default"},
                {help_sight = "bolter_sight_01", sight_2 = "sight_default"},
                {help_sight = "sight_default", sight_2 = "sight_default"},
                {help_sight = "sight_default", sight_2 = "scope_sight_03", lens = "scope_lens_02", lens_2 = "scope_lens_2_02"},
                {help_sight = "sight_default", sight_2 = "scope_sight_02", lens = "scope_lens_02", lens_2 = "scope_lens_2_02"},
                {help_sight = "sight_default", sight_2 = "scope_sight_03", lens = "scope_lens_02", lens_2 = "scope_lens_2_02"},
                {help_sight = "sight_default", sight_2 = "sight_default"},
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
            }),
            _common_ranged.scope_sights_models("sight", .2, vector3_box(-.3, -4, -.2), vector3_box(0, 0, 0), "sight_2", {}, {
                {rail = "rail_default"},
                {rail = "rail_01"},
                {rail = "rail_01"},
                {rail = "rail_01"},
                {rail = "rail_default"},
            }),
            _common_ranged.scope_lens_models("sight_2", .2, vector3_box(-.3, -4, -.2), vector3_box(0, 0, 0)),
            _common_ranged.scope_lens_2_models("sight_2", .2, vector3_box(-.3, -4, -.2), vector3_box(0, 0, 0)),
            -- Bolter
            _bolter_p1_m1.sight_models("receiver", .35, vector3_box(-.3, -4, -.2), vector3_box(0, -.2, 0), "help_sight"),
            -- Common
            _common.emblem_right_models("receiver", -3, vector3_box(-.2, -4, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("receiver", 0, vector3_box(-.2, -4, 0), vector3_box(.2, 0, 0))
        ),
        anchors = {
            scope_offset = {position = vector3_box(0, 0, .0275)},
            fixes = {

                -- -- Scope
                -- {dependencies = {"scope_01"}, -- Lasgun sight
                --     sight = {offset = true, position = vector3_box(0, -.04, .15), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1.5, 1)},
                --     lens = {offset = true, position = vector3_box(-.0295, .22, .03675), rotation = vector3_box(0, 0, 0), scale = vector3_box(.495, 1, .505), hide_mesh = {{"lens", 1, 2, 3, 5}}, data = {lens = 1}},
                --     lens_2 = {offset = true, position = vector3_box(-.0295, -.16, .03675), rotation = vector3_box(180, 0, 0), scale = vector3_box(.495, 1, -.505), hide_mesh = {{"lens_2", 1, 2, 3, 5}}, data = {lens = 2}},
                --     sight_2 = {offset = true, position = vector3_box(0, .07, -.0415), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}}},
                --     scope_offset = {position = vector3_box(0, 0, .0338)}},
                -- {dependencies = {"scope_02"}, -- Lasgun sight
                --     sight = {offset = true, position = vector3_box(0, -.08, .15), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 3, 1)},
                --     lens = {offset = true, position = vector3_box(-.0265, .04, .0355), rotation = vector3_box(0, 0, 0), scale = vector3_box(.45, 1, .48), hide_mesh = {{"lens", 1, 2, 3, 5}}, data = {lens = 1}},
                --     lens_2 = {offset = true, position = vector3_box(-.0295, -.2, .0365), rotation = vector3_box(180, 0, 0), scale = vector3_box(.495, 1, -.505), hide_mesh = {{"lens_2", 1, 2, 3, 5}}, data = {lens = 2}},
                --     sight_2 = {offset = true, position = vector3_box(0, .09, -.04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 3, 4, 5}}},
                --     scope_offset = {position = vector3_box(0, 0, .036)}},
                -- {dependencies = {"scope_03"}, -- Lasgun sight
                --     sight = {offset = true, position = vector3_box(0, 0, .15), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                --     lens = {offset = true, position = vector3_box(-.0265, .26, .0355), rotation = vector3_box(0, 0, 0), scale = vector3_box(.45, 1, .48), hide_mesh = {{"lens", 1, 2, 3, 5}}, data = {lens = 1}},
                --     lens_2 = {offset = true, position = vector3_box(-.0295, 0, .038), rotation = vector3_box(180, 0, 0), scale = vector3_box(.495, 1, -.505), hide_mesh = {{"lens_2", 1, 2, 3, 5}}, data = {lens = 2}},
                --     sight_2 = {offset = true, position = vector3_box(0, 0, -.0425), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}}},
                --     scope_offset = {position = vector3_box(0, 0, .033)}},
                -- {sight_2 = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                -- {lens = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                -- {lens_2 = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                {dependencies = {"scope_01"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, -.04, .15), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1.5, 1)},
                    lens = {offset = true, position = vector3_box(0, .12, .031), rotation = vector3_box(0, 0, 0), scale = vector3_box(.64, .6, .7), data = {lens = 1}},
                    lens_2 = {offset = true, position = vector3_box(0, .01, .031), rotation = vector3_box(180, 0, 0), scale = vector3_box(.64, .85, .7), data = {lens = 2}},
                    sight_2 = {offset = true, position = vector3_box(0, .07, -.0415), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}}},
                    scope_offset = {position = vector3_box(0, .1, .0338)}},
                {dependencies = {"scope_02"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, -.08, .15), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 3, 1)},
                    lens = {offset = true, position = vector3_box(0, -.02, .03), rotation = vector3_box(0, 0, 0), scale = vector3_box(.62, .4, .7), data = {lens = 1}},
                    lens_2 = {offset = true, position = vector3_box(0, -.14, .03), rotation = vector3_box(180, 0, 0), scale = vector3_box(.62, .4, .7), data = {lens = 2}},
                    sight_2 = {offset = true, position = vector3_box(0, .09, -.04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 3, 4, 5}}},
                    scope_offset = {position = vector3_box(0, 0, .036)}},
                {dependencies = {"scope_03"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, 0, .15), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    lens = {offset = true, position = vector3_box(0, .08, .034), rotation = vector3_box(0, 0, 0), scale = vector3_box(.62, 1, .62), data = {lens = 1}},
                    lens_2 = {offset = true, position = vector3_box(0, .22, .034), rotation = vector3_box(180, 0, 0), scale = vector3_box(.62, 1, .62), data = {lens = 2}},
                    sight_2 = {offset = true, position = vector3_box(0, 0, -.0425), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}}},
                    scope_offset = {position = vector3_box(0, .1, .033)}},
                {sight_2 = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                {lens = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                {lens_2 = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},

                {dependencies = {"grip_27|grip_28|grip_29"}, -- Grip
                    grip = {offset = true, position = vector3_box(0, .01, -.02), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"emblem_left_02", "receiver_02"}, -- Emblem
                    emblem_left = {offset = true, position = vector3_box(0, -.005, -.0475), rotation = vector3_box(0, 0, 0), scale = vector3_box(.5, -.5, .5)}},
                {dependencies = {"receiver_02"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(0, -.005, -.0475), rotation = vector3_box(0, 0, 0), scale = vector3_box(.5, .5, .5)},
                    emblem_right = {offset = true, position = vector3_box(0, .005, -.0475), rotation = vector3_box(0, 0, 0), scale = vector3_box(.5, .5, .5)}},
                {dependencies = {"emblem_left_02", "receiver_01"}, -- Emblem
                    emblem_left = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, -1, 1)}},
                {dependencies = {"lasgun_rifle_sight_01"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, -.005, .035), rotation = vector3_box(0, 0, 0), scale = vector3_box(.7, 1, 1), scale_node = 6}},
                {dependencies = {"lasgun_rifle_sight_01"}, -- Lasgun sight
                    no_scope_offset = {position = vector3_box(0, 0, .0015), rotation = vector3_box(0, 0, 0)}},
                {dependencies = {"autogun_rifle_sight_01"}, -- Infantry sight
                    sight = {offset = true, position = vector3_box(0, -.02, -.0025), mesh_position = vector3_box(0, .03, 0), mesh_index = 8, scale = vector3_box(.7, 1, 1), scale_node = 5},
                    help_sight = {offset = true, position = vector3_box(0, -.0975, .005), scale = vector3_box(.645, .75, 1), scale_node = 5}},
                {dependencies = {"autogun_rifle_sight_01"}, -- Infantry sight
                    no_scope_offset = {position = vector3_box(0, 0, .0135), rotation = vector3_box(.8, 0, 0)}},
                {dependencies = {"autogun_rifle_ak_sight_01"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, .0225, 0), mesh_position = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1), scale_node = 1},
                    help_sight = {offset = true, position = vector3_box(0, -.11, .005), scale = vector3_box(.475, .75, 1), scale_node = 5}},
                {dependencies = {"autogun_rifle_ak_sight_01"}, -- Infantry sight
                    no_scope_offset = {position = vector3_box(0, 0, .0135), rotation = vector3_box(1.2, 0, 0)}},
                {dependencies = {"autogun_rifle_killshot_sight_01"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, .0225, -.002), mesh_position = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1), scale_node = 1},
                    help_sight = {offset = true, position = vector3_box(0, -.11, .005), scale = vector3_box(.475, .75, 1), scale_node = 5}},
                {dependencies = {"autogun_rifle_killshot_sight_01"}, -- Infantry sight
                    no_scope_offset = {position = vector3_box(0, 0, .013), rotation = vector3_box(1.2, 0, 0)}},
                {help_sight = {parent = "receiver", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0), scale_node = 5}},

                {dependencies = {"barrel_10"}, -- Muzzle
                    muzzle = {offset = true, position = vector3_box(0, .05, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},

                {dependencies = {"barrel_01", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .27, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_01", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .27, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_02", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .27, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_02", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .27, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_03", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .195, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_03", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .195, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_04", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .27, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_04", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .27, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_05", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .27, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_05", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .27, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_06", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "muzzle", position = vector3_box(0, .065, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_06", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "muzzle", position = vector3_box(0, .065, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_07", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "muzzle", position = vector3_box(0, .065, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_07", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "muzzle", position = vector3_box(0, .065, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_08", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .27, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_08", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .27, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_09", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .36, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_09", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .36, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_10", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .495, -.03), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_10", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .495, -.03), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_11", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .42, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_11", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .42, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_12", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .36, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_12", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .36, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_13", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .35, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_13", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .35, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_14", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .18, -.042), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_14", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .18, -.042), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_15", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .17, -.06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_15", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .17, -.06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_16", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .19, -.042), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_16", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .19, -.042), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_17", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .18, -.043), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_17", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .18, -.043), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_18", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .18, -.043), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_18", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .18, -.043), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},

                {dependencies = {"autogun_bayonet_03", "muzzle_07|muzzle_08|muzzle_09"}, -- Bayonet 3
                    bayonet = {parent = "muzzle", position = vector3_box(0, .05, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},

                {dependencies = {"barrel_17"}, -- Trinket hook
                    trinket_hook = {parent = "barrel", position = vector3_box(0, .075, -.11), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_18"}, -- Trinket hook
                    trinket_hook = {parent = "barrel", position = vector3_box(0, .075, -.11), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1)}},
            }
        },
    }
)