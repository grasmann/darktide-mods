local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
local _common_ranged = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_ranged")
local _common_lasgun = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_lasgun")
local _shotgun_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/shotgun_p1_m1")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"

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
            {id = "laspistol_receiver_01",      name = "Laspistol Receiver 1"},
            {id = "laspistol_receiver_02",      name = "Laspistol Receiver 2"},
            {id = "laspistol_receiver_03",      name = "Laspistol Receiver 3"},
            {id = "laspistol_receiver_05",      name = "Laspistol Receiver 5"},
            {id = "laspistol_receiver_06",      name = "Laspistol Receiver 6"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "laspistol_receiver_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    receiver_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "laspistol_receiver_default", model = ""},
            {name = "laspistol_receiver_01",      model = _item_ranged.."/recievers/lasgun_pistol_receiver_01"},
            {name = "laspistol_receiver_02",      model = _item_ranged.."/recievers/lasgun_pistol_receiver_02"},
            {name = "laspistol_receiver_03",      model = _item_ranged.."/recievers/lasgun_pistol_receiver_03"},
            {name = "laspistol_receiver_04",      model = _item_ranged.."/recievers/lasgun_pistol_receiver_04"},
            {name = "laspistol_receiver_05",      model = _item_ranged.."/recievers/lasgun_pistol_receiver_05"},
            {name = "laspistol_receiver_06",      model = _item_ranged.."/recievers/lasgun_pistol_receiver_06"},
        }, parent, angle, move, remove, type or "receiver", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    magazine_attachments = function(default)
        local attachments = {
            {id = "magazine_01",        name = "Magazine 1"},
            {id = "magazine_02",        name = "Magazine 2"},
            {id = "magazine_03",        name = "Magazine 3"},
            {id = "magazine_04",        name = "Magazine 4"},
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
            {name = "magazine_default", model = ""},
            {name = "magazine_01",      model = _item_ranged.."/magazines/lasgun_pistol_magazine_01"},
            {name = "magazine_02",      model = _item_ranged.."/magazines/lasgun_pistol_magazine_02"},
            {name = "magazine_03",      model = _item_ranged.."/magazines/lasgun_pistol_magazine_03"},
            {name = "magazine_04",      model = _item_ranged.."/magazines/lasgun_pistol_magazine_04"},
        }, parent, angle, move, remove, type or "magazine", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    barrel_attachments = function(default)
        local attachments = {
            {id = "barrel_01",      name = "Barrel 1"},
            {id = "barrel_02",      name = "Barrel 2"},
            {id = "barrel_03",      name = "Barrel 3"},
            {id = "barrel_04",      name = "Barrel 4"},
            {id = "barrel_05",      name = "Barrel 5"},
            {id = "barrel_06",      name = "Barrel 6"},
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
            {name = "barrel_01",      model = _item_ranged.."/barrels/lasgun_pistol_barrel_01"},
            {name = "barrel_02",      model = _item_ranged.."/barrels/lasgun_pistol_barrel_02"},
            {name = "barrel_03",      model = _item_ranged.."/barrels/lasgun_pistol_barrel_03"},
            {name = "barrel_04",      model = _item_ranged.."/barrels/lasgun_pistol_barrel_04"},
            {name = "barrel_05",      model = _item_ranged.."/barrels/lasgun_pistol_barrel_05"},
            {name = "barrel_06",      model = _item_ranged.."/barrels/lasgun_pistol_barrel_06"},
        }, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    muzzle_attachments = function(default)
        local attachments = {
            {id = "muzzle_01",      name = "Muzzle 1"},
            -- {id = "muzzle_02",      name = "Muzzle 2"}, -- buggy
            {id = "muzzle_03",      name = "Muzzle 3"},
            {id = "muzzle_04",      name = "Muzzle 4"},
            {id = "muzzle_05",      name = "Muzzle 5"},
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
            {name = "muzzle_01",      model = _item_ranged.."/muzzles/lasgun_pistol_muzzle_01"},
            {name = "muzzle_03",      model = _item_ranged.."/muzzles/lasgun_pistol_muzzle_03"},
            {name = "muzzle_04",      model = _item_ranged.."/muzzles/lasgun_pistol_muzzle_04"},
            -- {name = "muzzle_02",      model = _item_ranged.."/muzzles/lasgun_pistol_muzzle_02"}, -- buggy
            {name = "muzzle_05",      model = _item_ranged.."/muzzles/lasgun_pistol_muzzle_05"},
        }, parent, angle, move, remove, type or "muzzle", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    rail_attachments = function(default)
        local attachments = {
            {id = "rail_01",        name = "Rail 1"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "rail_default",   name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    rail_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "rail_default", model = ""},
            {name = "rail_01",      model = _item_ranged.."/rails/lasgun_pistol_rail_01"},
        }, parent, angle, move, remove, type or "rail", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    stock_attachments = function(default)
        local attachments = {
            {id = "lasgun_pistol_stock_01",         name = "Ventilation 1"},
            {id = "lasgun_pistol_stock_02",         name = "Ventilation 2"},
            {id = "lasgun_pistol_stock_03",         name = "Ventilation 3"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "lasgun_pistol_stock_default",    name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    stock_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "lasgun_pistol_stock_default", model = ""},
            {name = "lasgun_pistol_stock_01",      model = _item_ranged.."/stocks/lasgun_pistol_stock_01"},
            {name = "lasgun_pistol_stock_02",      model = _item_ranged.."/stocks/lasgun_pistol_stock_02"},
            {name = "lasgun_pistol_stock_03",      model = _item_ranged.."/stocks/lasgun_pistol_stock_03"},
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
            -- magazine = functions.magazine_attachments(),
            barrel = functions.barrel_attachments(),
            muzzle = functions.muzzle_attachments(),
            -- rail = functions.rail_attachments(),
            stock = functions.stock_attachments(),
            -- Ranged
            flashlight = _common_ranged.flashlights_attachments(),
            bayonet = _common_ranged.bayonet_attachments(),
            grip = _common_ranged.grip_attachments(),
            sight = table.icombine(
                _common_ranged.reflex_sights_attachments(),
                _common_ranged.scopes_attachments(false)
            ),
            -- Lasgun
            magazine = _common_lasgun.magazine_attachments(),
            -- Shotgun
            stock_3 = _shotgun_p1_m1.stock_attachments(),
            -- Common
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            trinket_hook = _common.trinket_hook_attachments(),
            slot_trinket_1 = _common.slot_trinket_1_attachments(),
        },
        models = table.combine(
            -- Native
            functions.receiver_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.00001)),
            -- functions.magazine_models("receiver", 0, vector3_box(-.2, -3, .1), vector3_box(0, 0, -.2)),
            functions.barrel_models(nil, -.5, vector3_box(.2, -2, 0), vector3_box(0, .2, 0), "barrel", {}, {
                {receiver = "laspistol_receiver_04|laspistol_receiver_01"},
                {receiver = "laspistol_receiver_04|laspistol_receiver_01"},
                {receiver = "laspistol_receiver_04|laspistol_receiver_02"},
                {receiver = "laspistol_receiver_04|laspistol_receiver_03"},
                {receiver = "laspistol_receiver_04|laspistol_receiver_03"},
                {receiver = "laspistol_receiver_04|laspistol_receiver_03"},
                {receiver = "!laspistol_receiver_04|laspistol_receiver_04"},
            }),
            functions.muzzle_models(nil, -.5, vector3_box(.2, -2, 0), vector3_box(0, .2, 0)),
            functions.rail_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2)),
            functions.stock_models(nil, .5, vector3_box(-.6, -4, 0), vector3_box(0, -.2, 0)),
            -- Ranged
            _common_ranged.flashlight_models("receiver", -2.5, vector3_box(0, -3, 0), vector3_box(.2, 0, 0)),
            _common_ranged.bayonet_models({"barrel", "barrel", "barrel", "muzzle"}, -.5, vector3_box(.1, -4, 0), vector3_box(0, .4, -.025)),
            _common_ranged.grip_models(nil, -.1, vector3_box(-.4, -4, .2), vector3_box(0, -.1, -.1), "grip", {
                {"trinket_hook_empty"},
                {"trinket_hook"},
                {"trinket_hook"},
                {"trinket_hook"},
                {"trinket_hook"},
                {"trinket_hook_empty"},
                {"trinket_hook"},
                {"trinket_hook"},
                {"trinket_hook_empty"},
                {"trinket_hook"},
                {"trinket_hook"},
                {"trinket_hook"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook"},
                {"trinket_hook_empty"},
                {"trinket_hook"},
                {"trinket_hook"},
                {"trinket_hook"},
                {"trinket_hook"},
                {"trinket_hook"},
                {"trinket_hook"},
                {"trinket_hook"},
                {"trinket_hook"},
            }, {
                {trinket_hook = "trinket_hook_05_carbon"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_05_carbon"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_05_carbon"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_05_carbon"},
                {trinket_hook = "trinket_hook_05_carbon"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_05_carbon"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
            }),
            _common_ranged.reflex_sights_models("rail", -.5, vector3_box(-.1, -4, -.2), vector3_box(0, -.2, 0), "sight", {}, {
                {rail = "rail_default", sight_2 = "sight_default"},
                {rail = "rail_02", sight_2 = "sight_default"},
                {rail = "rail_02", sight_2 = "sight_default"},
                {rail = "rail_02", sight_2 = "sight_default"},
            }),
            _common_ranged.sights_models(nil, .35, vector3_box(-.3, -4, -.2), {
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
                {rail = "rail_default", sight_2 = "sight_default"},
                {rail = "rail_02", sight_2 = "sight_default"},
                {rail = "rail_default", sight_2 = "sight_default"},
                {rail = "rail_02", sight_2 = "sight_default"},
                {rail = "rail_default", sight_2 = "sight_default"},
                {rail = "rail_default", sight_2 = "scope_sight_03", lens = "scope_lens_02", lens_2 = "scope_lens_2_02"},
                {rail = "rail_default", sight_2 = "scope_sight_02", lens = "scope_lens_02", lens_2 = "scope_lens_2_02"},
                {rail = "rail_default", sight_2 = "scope_sight_03", lens = "scope_lens_02", lens_2 = "scope_lens_2_02"},
                {rail = "rail_default", sight_2 = "sight_default"},
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
            _common_ranged.scope_sights_models("sight", .2, vector3_box(-.3, -4, -.2), vector3_box(0, 0, 0), "sight_2", {}, {
                {rail = "rail_default"},
                {rail = "rail_02"},
                {rail = "rail_02"},
                {rail = "rail_02"},
                {rail = "rail_default"},
            }),
            _common_ranged.scope_lens_models("sight_2", .2, vector3_box(-.3, -4, -.2), vector3_box(0, 0, 0)),
            _common_ranged.scope_lens_2_models("sight_2", .2, vector3_box(-.3, -4, -.2), vector3_box(0, 0, 0)),
            -- Lasgun
            _common_lasgun.rail_models("receiver", 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2)),
            _common_lasgun.magazine_models("receiver", 0, vector3_box(-.2, -3, .1), vector3_box(0, 0, -.2)),
            -- Shotgun
            _shotgun_p1_m1.stock_models("grip", 0, vector3_box(-.6, -4, .2), vector3_box(0, -.4, -.11), "stock_3"),
            -- Common
            _common.emblem_right_models("receiver", -3, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("receiver", 0, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common.trinket_hook_models("grip", -.2, vector3_box(.1, -4, .2), vector3_box(0, 0, -.2)),
            _common.slot_trinket_1_models("trinket_hook", 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0))
        ),
        anchors = { -- Done 22.9.2023
            flashlight_01 =             {position = vector3_box(.03, .16, .035), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
            flashlight_02 =             {position = vector3_box(.03, .16, .035), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
            flashlight_03 =             {position = vector3_box(.03, .16, .035), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
            flashlight_04 =             {position = vector3_box(.03, .16, .035), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
            autogun_bayonet_01 =        {position = vector3_box(0, .14, -.033), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
            autogun_bayonet_02 =        {position = vector3_box(0, .14, -.033), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
            autogun_bayonet_03 =        {position = vector3_box(0, .05, -.033), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
            fixes = {

                -- -- Scope
                -- {dependencies = {"scope_01"}, -- Lasgun sight
                --     sight = {offset = true, position = vector3_box(0, -.06, .156), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1.5, 1)},
                --     lens = {offset = true, position = vector3_box(-.0295, .22, .03675), rotation = vector3_box(0, 0, 0), scale = vector3_box(.495, 1, .505), hide_mesh = {{"lens", 1, 2, 3, 5}}, data = {lens = 1}},
                --     lens_2 = {offset = true, position = vector3_box(-.0295, -.16, .03675), rotation = vector3_box(180, 0, 0), scale = vector3_box(.495, 1, -.505), hide_mesh = {{"lens_2", 1, 2, 3, 5}}, data = {lens = 2}},
                --     sight_2 = {offset = true, position = vector3_box(0, .07, -.0415), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}}},
                --     scope_offset = {position = vector3_box(.00245, .5, -.00365)},
                --     rail = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                -- {dependencies = {"scope_02"}, -- Lasgun sight
                --     sight = {offset = true, position = vector3_box(0, -.12, .156), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 3, 1)},
                --     lens = {offset = true, position = vector3_box(-.0265, .04, .0355), rotation = vector3_box(0, 0, 0), scale = vector3_box(.45, 1, .48), hide_mesh = {{"lens", 1, 2, 3, 5}}, data = {lens = 1}},
                --     lens_2 = {offset = true, position = vector3_box(-.0295, -.2, .0365), rotation = vector3_box(180, 0, 0), scale = vector3_box(.495, 1, -.505), hide_mesh = {{"lens_2", 1, 2, 3, 5}}, data = {lens = 2}},
                --     sight_2 = {offset = true, position = vector3_box(0, .09, -.04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 3, 4, 5}}},
                --     scope_offset = {position = vector3_box(.0009, .5, -.0013)},
                --     rail = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                -- {dependencies = {"scope_03"}, -- Lasgun sight
                --     sight = {offset = true, position = vector3_box(0, -.05, .156), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                --     lens = {offset = true, position = vector3_box(-.0265, .26, .0355), rotation = vector3_box(0, 0, 0), scale = vector3_box(.45, 1, .48), hide_mesh = {{"lens", 1, 2, 3, 5}}, data = {lens = 1}},
                --     lens_2 = {offset = true, position = vector3_box(-.0295, 0, .038), rotation = vector3_box(180, 0, 0), scale = vector3_box(.495, 1, -.505), hide_mesh = {{"lens_2", 1, 2, 3, 5}}, data = {lens = 2}},
                --     sight_2 = {offset = true, position = vector3_box(0, 0, -.0425), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}}},
                --     scope_offset = {position = vector3_box(.003, .5, -.0055)},
                --     rail = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                -- {sight_2 = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                -- {lens = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                -- {lens_2 = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                {dependencies = {"scope_01"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, -.06, .156), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1.5, 1)},
                    lens = {offset = true, position = vector3_box(0, .12, .031), rotation = vector3_box(0, 0, 0), scale = vector3_box(.64, .6, .7), data = {lens = 1}},
                    lens_2 = {offset = true, position = vector3_box(0, .01, .031), rotation = vector3_box(180, 0, 0), scale = vector3_box(.64, .85, .7), data = {lens = 2}},
                    sight_2 = {offset = true, position = vector3_box(0, .07, -.0415), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}}},
                    scope_offset = {position = vector3_box(.00245, .65, -.00365)},
                    rail = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                {dependencies = {"scope_02"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, -.12, .156), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 3, 1)},
                    lens = {offset = true, position = vector3_box(0, -.02, .03), rotation = vector3_box(0, 0, 0), scale = vector3_box(.62, .4, .7), data = {lens = 1}},
                    lens_2 = {offset = true, position = vector3_box(0, -.14, .03), rotation = vector3_box(180, 0, 0), scale = vector3_box(.62, .4, .7), data = {lens = 2}},
                    sight_2 = {offset = true, position = vector3_box(0, .09, -.04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 3, 4, 5}}},
                    scope_offset = {position = vector3_box(.0009, .5, -.0013)},
                    rail = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                {dependencies = {"scope_03"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, -.05, .156), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    lens = {offset = true, position = vector3_box(0, .08, .034), rotation = vector3_box(0, 0, 0), scale = vector3_box(.62, 1, .62), data = {lens = 1}},
                    lens_2 = {offset = true, position = vector3_box(0, .22, .034), rotation = vector3_box(180, 0, 0), scale = vector3_box(.62, 1, .62), data = {lens = 2}},
                    sight_2 = {offset = true, position = vector3_box(0, 0, -.0425), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}}},
                    scope_offset = {position = vector3_box(.003, .65, -.0055)},
                    rail = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                {sight_2 = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                {lens = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                {lens_2 = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},

                {dependencies = {"grip_27|grip_28|grip_29"}, -- Grip
                    grip = {offset = true, position = vector3_box(0, .01, -.02), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"emblem_left_02"}, -- Emblem
                    emblem_left = {scale = vector3_box(1, -1, 1)}},
                {dependencies = {"laser_pointer"}, -- Laser Pointer
                    flashlight = {position = vector3_box(.03, .16, .035), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"laspistol_receiver_01", "barrel_02"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(.0025, 0, .007), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    emblem_right = {offset = true, position = vector3_box(.0025, 0, .007), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"laspistol_receiver_01|laspistol_receiver_06", "barrel_03"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.005, .1, .05), rotation = vector3_box(0, -25, 0), scale = vector3_box(1, 1, 1)},
                    emblem_right = {offset = true, position = vector3_box(-.005, -.1, .05), rotation = vector3_box(0, -25, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"laspistol_receiver_01|laspistol_receiver_06", "barrel_04"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.005, .1, .05), rotation = vector3_box(0, -25, 0), scale = vector3_box(1, 1, 1)},
                    emblem_right = {offset = true, position = vector3_box(-.005, -.1, .05), rotation = vector3_box(0, -25, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"laspistol_receiver_01|laspistol_receiver_06", "barrel_05"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.005, .1, .05), rotation = vector3_box(0, -25, 0), scale = vector3_box(1, 1, 1)},
                    emblem_right = {offset = true, position = vector3_box(-.005, -.1, .05), rotation = vector3_box(0, -25, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"laspistol_receiver_01|laspistol_receiver_06", "barrel_06"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(.0055, 0, .015), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    emblem_right = {offset = true, position = vector3_box(.0055, 0, .015), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"laspistol_receiver_02", "barrel_01"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(0, -.03, -.005), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    emblem_right = {offset = true, position = vector3_box(0, -.03, -.005), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"laspistol_receiver_02", "barrel_02"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(0, -.01, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    emblem_right = {offset = true, position = vector3_box(0, -.01, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"laspistol_receiver_02", "barrel_03"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(0, -.03, -.005), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    emblem_right = {offset = true, position = vector3_box(0, -.03, -.005), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"laspistol_receiver_02", "barrel_06"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(.001, -.025, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    emblem_right = {offset = true, position = vector3_box(.001, -.025, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"laspistol_receiver_02", "barrel_04"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.005, -.08, .02), rotation = vector3_box(0, -25, 0), scale = vector3_box(.5, .5, .5)},
                    emblem_right = {offset = true, position = vector3_box(-.005, -.08, .02), rotation = vector3_box(0, -25, 0), scale = vector3_box(.5, .5, .5)}},
                {dependencies = {"laspistol_receiver_02", "barrel_05"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.005, -.08, .02), rotation = vector3_box(0, -25, 0), scale = vector3_box(.5, .5, .5)},
                    emblem_right = {offset = true, position = vector3_box(-.005, -.08, .02), rotation = vector3_box(0, -25, 0), scale = vector3_box(.5, .5, .5)}},
                {dependencies = {"laspistol_receiver_05"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.005, .1, .05), rotation = vector3_box(0, -25, 0), scale = vector3_box(1, 1, 1)},
                    emblem_right = {offset = true, position = vector3_box(-.005, -.1, .05), rotation = vector3_box(0, -25, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"laspistol_receiver_06", "barrel_02"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(.003, -.03, .011), rotation = vector3_box(0, 0, 0), scale = vector3_box(2, 2, 2)},
                    emblem_right = {offset = true, position = vector3_box(.003, .03, .011), rotation = vector3_box(0, 0, 0), scale = vector3_box(2, 2, 2)}},
                {dependencies = {"laspistol_receiver_06"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(2, 2, 2)},
                    emblem_right = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(2, 2, 2)}},
                {dependencies = {"barrel_01", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {offset = true, position = vector3_box(0, .08, -.033), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_01", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {offset = true, position = vector3_box(0, .08, -.033), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_02", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {offset = true, position = vector3_box(0, .1, -.033), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_02", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {offset = true, position = vector3_box(0, .1, -.033), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_04", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {offset = true, position = vector3_box(0, .11, -.033), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_04", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {offset = true, position = vector3_box(0, .11, -.033), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_05", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {offset = true, position = vector3_box(0, .13, -.033), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_05", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {offset = true, position = vector3_box(0, .13, -.033), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_06", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {offset = true, position = vector3_box(0, .11, -.033), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_06", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {offset = true, position = vector3_box(0, .11, -.033), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"muzzle_03", "autogun_bayonet_03"}, -- Bayonet 3
                    bayonet = {offset = true, position = vector3_box(0, .065, -.03), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                -- {stock_3 = {parent = "body", position = vector3_box(0, -.037, -.035), rotation = vector3_box(25, 0, 0), scale = vector3_box(.6, 1.2, 1)}}, -- Stocks
                {stock_3 = {parent = "grip", position = vector3_box(0, -.14, -.11), rotation = vector3_box(-10, 0, 0), scale = vector3_box(.9, 1, 1)}},
                -- {slot_trinket_1 = {parent = "trinket_hook", position = vector3_box(0, 0, .5), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"grip_01"}, -- Trinket
                    trinket_hook = {parent = "grip", position = vector3_box(0, -.115, -.15), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"grip_02"}, -- Trinket
                    trinket_hook = {parent = "grip", position = vector3_box(0, -.12, -.165), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"grip_03"}, -- Trinket
                    trinket_hook = {parent = "grip", position = vector3_box(0, -.155, -.125), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"grip_04"}, -- Trinket
                    trinket_hook = {parent = "grip", position = vector3_box(0, -.132, -.136), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"grip_05"}, -- Trinket
                    trinket_hook = {parent = "grip", position = vector3_box(0, -.145, -.120), rotation = vector3_box(-35, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"grip_06"}, -- Trinket
                    trinket_hook = {parent = "grip", position = vector3_box(0, -.12, -.145), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"grip_07"}, -- Trinket
                    trinket_hook = {parent = "grip", position = vector3_box(0, -.132, -.136), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"grip_08"}, -- Trinket
                    trinket_hook = {parent = "grip", position = vector3_box(0, -.145, -.120), rotation = vector3_box(-35, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"grip_12"}, -- Trinket
                    trinket_hook = {parent = "grip", position = vector3_box(0, -.155, -.13), rotation = vector3_box(-35, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"grip_14"}, -- Trinket
                    trinket_hook = {parent = "grip", position = vector3_box(0, -.165, -.115), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"grip_19"}, -- Trinket
                    trinket_hook = {parent = "grip", position = vector3_box(0, -.115, -.14), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"grip_20"}, -- Trinket
                    trinket_hook = {parent = "grip", position = vector3_box(0, -.125, -.15), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"grip_21"}, -- Trinket
                    trinket_hook = {parent = "grip", position = vector3_box(0, -.12, -.15), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"grip_22"}, -- Trinket
                    trinket_hook = {parent = "grip", position = vector3_box(0, -.12, -.145), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"grip_23"}, -- Trinket
                    trinket_hook = {parent = "grip", position = vector3_box(0, -.12, -.145), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"grip_24"}, -- Trinket
                    trinket_hook = {parent = "grip", position = vector3_box(0, -.135, -.15), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"grip_25"}, -- Trinket
                    trinket_hook = {parent = "grip", position = vector3_box(0, -.165, -.11), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"grip_26"}, -- Trinket
                    trinket_hook = {parent = "grip", position = vector3_box(0, -.165, -.11), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1)}},
            },
        },
    }
)