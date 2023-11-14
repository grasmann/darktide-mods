local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
local _common_ranged = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_ranged")

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
            {id = "receiver_04",        name = "Receiver 4"},
            {id = "receiver_05",        name = "Receiver 2"},
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
            {name = "receiver_01",      model = _item_ranged.."/recievers/autogun_pistol_receiver_01"},
            {name = "receiver_05",      model = _item_ranged.."/recievers/autogun_pistol_receiver_05"},
            {name = "receiver_02",      model = _item_ranged.."/recievers/autogun_pistol_receiver_02"},
            {name = "receiver_03",      model = _item_ranged.."/recievers/autogun_pistol_receiver_03"},
            {name = "receiver_04",      model = _item_ranged.."/recievers/autogun_pistol_receiver_04"},
        }, parent, angle, move, remove, type or "receiver", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    barrel_attachments = function(default)
        local attachments = {
            {id = "barrel_01",      name = "Barrel 1"},
            {id = "barrel_02",      name = "Barrel 2"},
            {id = "barrel_03",      name = "Barrel 3"},
            {id = "barrel_04",      name = "Barrel 4"},
            {id = "barrel_05",      name = "Barrel 5"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "barrel_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    barrel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "barrel_default", model = ""},
            {name = "barrel_01",      model = _item_ranged.."/barrels/autogun_pistol_barrel_01"},
            {name = "barrel_02",      model = _item_ranged.."/barrels/autogun_pistol_barrel_02"},
            {name = "barrel_03",      model = _item_ranged.."/barrels/autogun_pistol_barrel_03"},
            {name = "barrel_04",      model = _item_ranged.."/barrels/autogun_pistol_barrel_04"},
            {name = "barrel_05",      model = _item_ranged.."/barrels/autogun_pistol_barrel_05"},
        }, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    magazine_attachments = function(default)
        local attachments = {
            {id = "auto_pistol_magazine_01",        name = "Magazine 1"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "magazine_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    magazine_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "magazine_default",        model = ""},
            {name = "auto_pistol_magazine_01", model = _item_ranged.."/magazines/autogun_pistol_magazine_01"},
        }, parent, angle, move, remove, type or "magazine", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    muzzle_attachments = function(default)
        local attachments = {
            {id = "muzzle_01",      name = "Autopistol Muzzle A"},
            {id = "muzzle_02",      name = "Autopistol Muzzle B"},
            {id = "muzzle_03",      name = "Autopistol Muzzle C"},
            {id = "muzzle_04",      name = "Autopistol Muzzle D"},
            {id = "muzzle_05",      name = "Autopistol Muzzle E"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "muzzle_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    muzzle_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "muzzle_default", model = ""},
            {name = "muzzle_01",      model = _item_ranged.."/muzzles/autogun_pistol_muzzle_01"},
            {name = "muzzle_02",      model = _item_ranged.."/muzzles/autogun_pistol_muzzle_02"},
            {name = "muzzle_03",      model = _item_ranged.."/muzzles/autogun_pistol_muzzle_03"},
            {name = "muzzle_04",      model = _item_ranged.."/muzzles/autogun_pistol_muzzle_04"},
            {name = "muzzle_05",      model = _item_ranged.."/muzzles/autogun_pistol_muzzle_05"},
        }, parent, angle, move, remove, type or "muzzle", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    sight_attachments = function(default)
        local attachments = {
            {id = "sight_01",       name = "Sight 1"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "sight_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    sight_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "sight_default", model = ""},
            {name = "sight_01",      model = _item_ranged.."/sights/autogun_pistol_sight_01"},
        }, parent, angle, move, remove, type or "sight", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
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
            barrel = functions.barrel_attachments(),
            muzzle = functions.muzzle_attachments(),
            sight = table.icombine(
                _common_ranged.sight_default(),
                functions.sight_attachments(),
                _common_ranged.reflex_sights_attachments(),
                _common_ranged.sights_attachments()
            ),
            -- Ranged
            flashlight = _common_ranged.flashlights_attachments(),
            magazine = table.icombine(
                {{id = "magazine_default", name = mod:localize("mod_attachment_default")}},
                _common_ranged.magazine_attachments()
            ),
            grip = _common_ranged.grip_attachments(),
            stock = _common_ranged.stock_attachments(),
            bayonet = _common_ranged.bayonet_attachments(),
            -- Common
            trinket_hook = _common.trinket_hook_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
        },
        models = table.combine(
            -- Native
            functions.receiver_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.00001)),
            functions.barrel_models(nil, -.5, vector3_box(.2, -2, 0), vector3_box(0, .2, 0)),
            -- functions.magazine_models(nil, 0, vector3_box(0, -3, .1), vector3_box(0, 0, -.2)),
            functions.muzzle_models(nil, -.5, vector3_box(.2, -2, 0), vector3_box(0, .2, 0)),
            functions.sight_models("receiver", -.5, vector3_box(-.3, -4, -.2), vector3_box(0, -.2, 0)),
            -- Ranged
            _common_ranged.flashlight_models(nil, -2.5, vector3_box(0, -3, 0), vector3_box(.2, 0, 0)),
            _common_ranged.bayonet_models({"barrel", "barrel", "barrel", "muzzle"}, -.5, vector3_box(.3, -4, 0), vector3_box(0, .4, -.034)),
            _common_ranged.grip_models(nil, -.1, vector3_box(-.3, -4, 0), vector3_box(0, -.1, -.1)),
            _common_ranged.stock_models("receiver", 0, vector3_box(-.4, -4, 0), vector3_box(0, -.2, 0)),
            _common_ranged.reflex_sights_models("receiver", -.5, vector3_box(-.3, -4, -.2), vector3_box(0, -.2, 0), "sight", {}, {
                {sight_2 = "sight_default"},
                {sight_2 = "sight_default"},
                {sight_2 = "sight_default"},
                {sight_2 = "sight_default"},
                {sight_2 = "sight_default"},
            }),
            _common_ranged.scope_sights_models("sight", .2, vector3_box(-.3, -4, -.2), vector3_box(0, 0, 0), "sight_2"),
            _common_ranged.scope_lens_models("sight_2", .2, vector3_box(-.3, -4, -.2), vector3_box(0, 0, 0)),
            _common_ranged.scope_lens_2_models("sight_2", .2, vector3_box(-.3, -4, -.2), vector3_box(0, 0, 0)),
            _common_ranged.magazine_models(nil, 0, vector3_box(0, -3, .1), vector3_box(0, 0, -.2)),
            _common_ranged.sights_models("receiver", -.5, vector3_box(-.3, -4, -.2), {
                vector3_box(-.2, 0, 0),
                vector3_box(0, -.2, 0),
                vector3_box(0, -.2, 0),
                vector3_box(0, -.2, 0),
                vector3_box(0, -.2, 0),
                vector3_box(0, -.2, 0),
                vector3_box(0, -.2, 0),
                vector3_box(0, -.2, 0),
                vector3_box(0, -.2, 0),
            }, "sight", {}, {
                {sight_2 = "sight_default"},
                {sight_2 = "sight_default"},
                {sight_2 = "sight_default"},
                {sight_2 = "sight_default"},
                {sight_2 = "sight_default"},
                {sight_2 = "scope_sight_03", lens = "scope_lens_02", lens_2 = "scope_lens_2_02"},
                {sight_2 = "scope_sight_02", lens = "scope_lens_02", lens_2 = "scope_lens_2_02"},
                {sight_2 = "scope_sight_03", lens = "scope_lens_02", lens_2 = "scope_lens_2_02"},
                {sight_2 = "sight_default"},
            }, {}, {
                true,
                true,
                false,
                false,
                false,
                false,
                false,
                false,
                false,
            }),
            -- Common
            _common.trinket_hook_models("barrel", -.2, vector3_box(.1, -4, .2), vector3_box(0, 0, -.2)),
            _common.emblem_right_models("receiver", -3, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("receiver", 0, vector3_box(0, -4, 0), vector3_box(-.2, 0, 0))
        ),
        anchors = {
            fixes = {

                -- -- Scope
                -- {dependencies = {"scope_01"}, -- Lasgun sight
                --     sight = {offset = true, position = vector3_box(0, -.08, .153), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1.5, 1)},
                --     lens = {offset = true, position = vector3_box(-.0295, .22, .03675), rotation = vector3_box(0, 0, 0), scale = vector3_box(.495, 1, .505), hide_mesh = {{"lens", 1, 2, 3, 5}}, data = {lens = 1}},
                --     lens_2 = {offset = true, position = vector3_box(-.0295, -.16, .03675), rotation = vector3_box(180, 0, 0), scale = vector3_box(.495, 1, -.505), hide_mesh = {{"lens_2", 1, 2, 3, 5}}, data = {lens = 2}},
                --     sight_2 = {offset = true, position = vector3_box(0, .07, -.0415), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}}},
                --     scope_offset = {position = vector3_box(0, 0, -.0048)}},
                -- {dependencies = {"scope_02"}, -- Lasgun sight
                --     sight = {offset = true, position = vector3_box(0, -.12, .153), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 3, 1)},
                --     lens = {offset = true, position = vector3_box(-.0265, .04, .0355), rotation = vector3_box(0, 0, 0), scale = vector3_box(.45, 1, .48), hide_mesh = {{"lens", 1, 2, 3, 5}}, data = {lens = 1}},
                --     lens_2 = {offset = true, position = vector3_box(-.0295, -.2, .0365), rotation = vector3_box(180, 0, 0), scale = vector3_box(.495, 1, -.505), hide_mesh = {{"lens_2", 1, 2, 3, 5}}, data = {lens = 2}},
                --     sight_2 = {offset = true, position = vector3_box(0, .09, -.04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 3, 4, 5}}},
                --     scope_offset = {position = vector3_box(0, 0, -.0035)}},
                -- {dependencies = {"scope_03"}, -- Lasgun sight
                --     sight = {offset = true, position = vector3_box(0, -.08, .153), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                --     lens = {offset = true, position = vector3_box(-.0265, .26, .0355), rotation = vector3_box(0, 0, 0), scale = vector3_box(.45, 1, .48), hide_mesh = {{"lens", 1, 2, 3, 5}}, data = {lens = 1}},
                --     lens_2 = {offset = true, position = vector3_box(-.0295, 0, .038), rotation = vector3_box(180, 0, 0), scale = vector3_box(.495, 1, -.505), hide_mesh = {{"lens_2", 1, 2, 3, 5}}, data = {lens = 2}},
                --     sight_2 = {offset = true, position = vector3_box(0, 0, -.0425), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}}},
                --     scope_offset = {position = vector3_box(0, 0, -.0055)}},
                -- {sight_2 = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                -- {lens = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                -- {lens_2 = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                {dependencies = {"scope_01"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, -.08, .153), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1.5, 1)},
                    lens = {offset = true, position = vector3_box(0, .12, .031), rotation = vector3_box(0, 0, 0), scale = vector3_box(.64, .6, .7), data = {lens = 1}},
                    lens_2 = {offset = true, position = vector3_box(0, .01, .031), rotation = vector3_box(180, 0, 0), scale = vector3_box(.64, .85, .7), data = {lens = 2}},
                    sight_2 = {offset = true, position = vector3_box(0, .07, -.0415), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}}},
                    scope_offset = {position = vector3_box(0, .15, .015)}},
                {dependencies = {"scope_02"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, -.12, .153), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 3, 1)},
                    lens = {offset = true, position = vector3_box(0, -.02, .03), rotation = vector3_box(0, 0, 0), scale = vector3_box(.62, .4, .7), data = {lens = 1}},
                    lens_2 = {offset = true, position = vector3_box(0, -.14, .03), rotation = vector3_box(180, 0, 0), scale = vector3_box(.62, .4, .7), data = {lens = 2}},
                    sight_2 = {offset = true, position = vector3_box(0, .09, -.04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 3, 4, 5}}},
                    scope_offset = {position = vector3_box(0, 0, .015)}},
                {dependencies = {"scope_03"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, -.08, .153), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    lens = {offset = true, position = vector3_box(0, .08, .034), rotation = vector3_box(0, 0, 0), scale = vector3_box(.62, 1, .62), data = {lens = 1}},
                    lens_2 = {offset = true, position = vector3_box(0, .22, .034), rotation = vector3_box(180, 0, 0), scale = vector3_box(.62, 1, .62), data = {lens = 2}},
                    sight_2 = {offset = true, position = vector3_box(0, 0, -.0425), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}}},
                    scope_offset = {position = vector3_box(0, .15, .015)}},
                {sight_2 = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                {lens = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                {lens_2 = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},

                {dependencies = {"grip_27|grip_28|grip_29"}, -- Grip
                    grip = {offset = true, position = vector3_box(0, .01, -.02), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"laser_pointer"}, -- Laser Pointer
                    flashlight = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"lasgun_rifle_sight_01"}, -- Sight
                    sight = {offset = true, position = vector3_box(0, -.036, .026), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, .8, 1)}},
                {dependencies = {"reflex_sight_01"}, -- Sight
                    sight = {offset = true, position = vector3_box(0, -.05, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"reflex_sight_02"}, -- Sight
                    sight = {offset = true, position = vector3_box(0, -.05, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"reflex_sight_03"}, -- Sight
                    sight = {offset = true, position = vector3_box(0, -.05, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"magazine_01"}, -- Magazine
                    magazine = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, .6, 1)}},
                {dependencies = {"magazine_02"}, -- Magazine
                    magazine = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, .6, 1)}},
                {dependencies = {"magazine_03"}, -- Magazine
                    magazine = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, .6, 1)}},
                {dependencies = {"magazine_04"}, -- Magazine
                    magazine = {offset = true, position = vector3_box(0, 0, -.06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, .6, .6)}},
                {dependencies = {"emblem_left_02"}, -- Emblem
                    emblem_left = {parent = "receiver", position = vector3_box(-.0257, .08, .09), rotation = vector3_box(0, 10, 180), scale = vector3_box(1, -1, 1)}},
                {emblem_left = {parent = "receiver", position = vector3_box(-.0257, .08, .09), rotation = vector3_box(0, 10, 180), scale = vector3_box(1, 1, 1)}},
                {stock = {parent = "receiver", position = vector3_box(0, -.095, .065), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_01", "autogun_bayonet_01"}, -- Bayonet
                    bayonet = {parent = "barrel", position = vector3_box(0, .105, -.034), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_01", "autogun_bayonet_02"}, -- Bayonet
                    bayonet = {parent = "barrel", position = vector3_box(0, .105, -.034), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"muzzle_01", "autogun_bayonet_03"}, -- Bayonet
                    bayonet = {parent = "muzzle", position = vector3_box(0, .009, -.0275), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_02", "autogun_bayonet_01"}, -- Bayonet
                    bayonet = {parent = "barrel", position = vector3_box(0, .105, -.034), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_02", "autogun_bayonet_02"}, -- Bayonet
                    bayonet = {parent = "barrel", position = vector3_box(0, .105, -.034), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"muzzle_02", "autogun_bayonet_03"}, -- Bayonet
                    bayonet = {parent = "muzzle", position = vector3_box(0, .02, -.0275), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_03", "autogun_bayonet_01"}, -- Bayonet
                    bayonet = {parent = "barrel", position = vector3_box(0, .13, -.034), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_03", "autogun_bayonet_02"}, -- Bayonet
                    bayonet = {parent = "barrel", position = vector3_box(0, .13, -.034), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"muzzle_03", "autogun_bayonet_03"}, -- Bayonet
                    bayonet = {parent = "muzzle", position = vector3_box(0, .009, -.03), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_04", "autogun_bayonet_01"}, -- Bayonet
                    bayonet = {parent = "barrel", position = vector3_box(0, .14, -.034), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_04", "autogun_bayonet_02"}, -- Bayonet
                    bayonet = {parent = "barrel", position = vector3_box(0, .14, -.034), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"muzzle_04", "autogun_bayonet_03"}, -- Bayonet
                    bayonet = {parent = "muzzle", position = vector3_box(0, .009, -.03), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_05", "autogun_bayonet_01"}, -- Bayonet
                    bayonet = {parent = "barrel", position = vector3_box(0, .14, -.034), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_05", "autogun_bayonet_02"}, -- Bayonet
                    bayonet = {parent = "barrel", position = vector3_box(0, .14, -.034), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"muzzle_05", "autogun_bayonet_03"}, -- Bayonet
                    bayonet = {parent = "muzzle", position = vector3_box(0, .052, -.03), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
            },
        },
    }
)