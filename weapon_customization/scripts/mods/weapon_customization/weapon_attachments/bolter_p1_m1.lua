local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
local _common_ranged = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_ranged")
local _common_lasgun = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_lasgun")
local _autopistol_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/autopistol_p1_m1")
local _ogryn_rippergun_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/ogryn_rippergun_p1_m1")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_melee = _item.."/melee"
local _item_minion = "content/items/weapons/minions"

local _receivers = "receiver_01|receiver_02|receiver_03|receiver_04|receiver_05"
local _barrels = "bolter_barrel_01|bolter_barrel_02"
local _magazines = "bolter_magazine_01|bolter_magazine_02"
local _underbarrels = "underbarrel_01|underbarrel_02|underbarrel_03"
local _sights = "bolter_sight_01|bolter_sight_02"

local REFERENCE = "weapon_customization"

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
            {id = "receiver_05",        name = "Receiver 5"},
            {id = "receiver_06",        name = "Receiver 6"},
            {id = "receiver_07",        name = "Receiver 7"},
            {id = "receiver_08",        name = "Receiver 8"},
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
            {name = "receiver_01",      model = _item_ranged.."/recievers/boltgun_rifle_receiver_01"},
            {name = "receiver_02",      model = _item_ranged.."/recievers/boltgun_rifle_receiver_02"},
            {name = "receiver_03",      model = _item_ranged.."/recievers/boltgun_rifle_receiver_03"},
            {name = "receiver_04",      model = _item_ranged.."/recievers/boltgun_rifle_receiver_04"},
            {name = "receiver_05",      model = _item_ranged.."/recievers/boltgun_rifle_receiver_05"},
            {name = "receiver_06",      model = _item_ranged.."/recievers/boltgun_pistol_receiver_01"},
            {name = "receiver_07",      model = _item_ranged.."/recievers/boltgun_rifle_receiver_06"},
            {name = "receiver_08",      model = _item_ranged.."/recievers/boltgun_rifle_receiver_07"},
        }, parent, angle, move, remove, type or "receiver", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    magazine_attachments = function(default)
        local attachments = {
            {id = "bolter_magazine_01",        name = "Bolter Magazine A"},
            {id = "bolter_magazine_02",        name = "Bolter Magazine B"},
            {id = "bolter_magazine_03",        name = "Bolter Magazine C"},
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
            {name = "bolter_magazine_01",      model = _item_ranged.."/magazines/boltgun_rifle_magazine_01"},
            {name = "bolter_magazine_02",      model = _item_ranged.."/magazines/boltgun_rifle_magazine_02"},
            {name = "bolter_magazine_03",      model = _item_ranged.."/magazines/boltgun_pistol_magazine_01"},
        }, parent, angle, move, remove, type or "magazine", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    barrel_attachments = function(default)
        local attachments = {
            {id = "bolter_barrel_01",   name = "Barrel 1"},
            {id = "bolter_barrel_02",   name = "Barrel 2"},
            -- {id = "bolter_barrel_03",   name = "Barrel 3"},
            {id = "bolter_barrel_04",   name = "Barrel 3"},
            {id = "bolter_barrel_05",   name = "Barrel 4"},
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
            {name = "bolter_barrel_01",      model = _item_ranged.."/barrels/boltgun_rifle_barrel_01"},
            {name = "bolter_barrel_02",      model = _item_ranged.."/barrels/boltgun_rifle_barrel_02"},
            {name = "bolter_barrel_03",      model = _item_ranged.."/barrels/boltgun_pistol_barrel_01"},
            {name = "bolter_barrel_04",      model = _item_ranged.."/barrels/boltgun_rifle_barrel_03"},
            {name = "bolter_barrel_05",      model = _item_ranged.."/barrels/boltgun_rifle_barrel_04"},
        }, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    underbarrel_attachments = function(default)
        local attachments = {
            {id = "underbarrel_01",         name = "Underbarrel 1"},
            {id = "underbarrel_02",         name = "Underbarrel 2"},
            {id = "underbarrel_03",         name = "Underbarrel 3"},
            {id = "underbarrel_04",         name = "Underbarrel 4"},
            {id = "underbarrel_05",         name = "Underbarrel 5"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "underbarrel_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    underbarrel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "underbarrel_default", model = ""},
            {name = "underbarrel_01",      model = _item_ranged.."/underbarrels/boltgun_rifle_underbarrel_01"},
            {name = "underbarrel_02",      model = _item_ranged.."/underbarrels/boltgun_rifle_underbarrel_02"},
            {name = "underbarrel_03",      model = _item_ranged.."/underbarrels/boltgun_rifle_underbarrel_03"},
            {name = "underbarrel_04",      model = _item_ranged.."/underbarrels/boltgun_rifle_underbarrel_04"},
            {name = "underbarrel_05",      model = _item_ranged.."/underbarrels/boltgun_rifle_underbarrel_05"},
            {name = "no_underbarrel",      model = ""},
        }, parent, angle, move, remove, type or "underbarrel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    sight_attachments = function(default)
        local attachments = {
            {id = "bolter_sight_01",       name = "Bolter Sight A"},
            {id = "bolter_sight_02",       name = "Bolter Sight B"},
            -- {id = "bolter_sight_03",       name = "Bolter Sight C"},
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
            {name = "bolter_sight_01",      model = _item_ranged.."/sights/boltgun_rifle_sight_01"},
            {name = "bolter_sight_02",      model = _item_ranged.."/sights/boltgun_rifle_sight_02"},
            {name = "bolter_sight_03",      model = _item_ranged.."/sights/boltgun_pistol_sight_01"},
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
            underbarrel = functions.underbarrel_attachments(),
            sight = table.icombine(
                _common_ranged.reflex_sights_attachments(),
                _common_ranged.scopes_attachments(false)
            ),
            -- Ranged
            flashlight = _common_ranged.flashlights_attachments(),
            magazine = table.icombine(
                _common_ranged.magazine_attachments()
            ),
            bayonet = _common_ranged.bayonet_attachments(),
            grip = _common_ranged.grip_attachments(),
            stock = _common_ranged.stock_attachments(),
            -- Lasgun
            -- rail = _common_lasgun.rail_attachments(),
            -- Other
            muzzle = table.icombine(
                _autopistol_p1_m1.muzzle_attachments(),
                _ogryn_rippergun_p1_m1.barrel_attachments(false)
            ),
            -- Common
            trinket_hook = _common.trinket_hook_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
        },
        models = table.combine(
            -- Native
            functions.receiver_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.00001), nil, nil, nil, nil, nil, function(gear_id, item, attachment)
                local changes = {}
                if attachment == "receiver_06" then
                    if mod:get_gear_setting(gear_id, "barrel", item) ~= "bolter_barrel_03" then changes["barrel"] = "bolter_barrel_03" end
                    if mod:get_gear_setting(gear_id, "magazine", item) ~= "bolter_magazine_03" then changes["magazine"] = "bolter_magazine_03" end
                    if mod:get_gear_setting(gear_id, "underbarrel", item) ~= "no_underbarrel" then changes["underbarrel"] = "no_underbarrel" end
                    if mod:get_gear_setting(gear_id, "sight", item) ~= "bolter_sight_03" then changes["sight"] = "bolter_sight_03" end
                else
                    if mod:get_gear_setting(gear_id, "barrel", item) == "bolter_barrel_03" then changes["barrel"] = _barrels end
                    if mod:get_gear_setting(gear_id, "magazine", item) == "bolter_magazine_03" then changes["magazine"] = _magazines end
                    if mod:get_gear_setting(gear_id, "underbarrel", item) == "no_underbarrel" then changes["underbarrel"] = _underbarrels end
                    if mod:get_gear_setting(gear_id, "sight", item) == "bolter_sight_03" then changes["sight"] = _sights end
                end
                return changes
            end),
            functions.barrel_models(nil, -.5, vector3_box(.2, -2, 0), vector3_box(0, .2, 0)),
            functions.underbarrel_models(nil, -.5, vector3_box(0, -4, 0), vector3_box(0, 0, -.2)),
            functions.sight_models(nil, -.5, vector3_box(-.3, -4, -.2), vector3_box(0, -.2, 0), "sight", {}, {
                {rail = "rail_default", sight_2 = "sight_default"},
                {rail = "rail_default", sight_2 = "sight_default"},
                {rail = "rail_default", sight_2 = "sight_default"},
                {rail = "rail_default", sight_2 = "sight_default"},
            }),
            -- Ranged
            _common_ranged.flashlight_models("receiver", -2.5, vector3_box(-.3, -3, 0), vector3_box(.2, 0, 0)),
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
                {trinket_hook = "trinket_hook_empty|trinket_hook_default"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_default"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_default"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_default"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_default"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_default"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty"},
            }),
            _common_ranged.reflex_sights_models("receiver", -.5, vector3_box(-.3, -4, -.2), vector3_box(0, -.2, 0), "sight", {}, {
                {rail = "rail_default", sight_2 = "sight_default"},
                {rail = "rail_01", sight_2 = "sight_default"},
                {rail = "rail_01", sight_2 = "sight_default"},
                {rail = "rail_01", sight_2 = "sight_default"},
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
                {rail = "rail_01", sight_2 = "sight_default"},
                {rail = "rail_default", sight_2 = "sight_default"},
                {rail = "rail_01", sight_2 = "sight_default"},
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
                {rail = "rail_01"},
                {rail = "rail_01"},
                {rail = "rail_01"},
                {rail = "rail_default"},
            }),
            _common_ranged.scope_lens_models("sight_2", .2, vector3_box(-.3, -4, -.2), vector3_box(0, 0, 0)),
            _common_ranged.scope_lens_2_models("sight_2", .2, vector3_box(-.3, -4, -.2), vector3_box(0, 0, 0)),
            _common_ranged.stock_models("receiver", 0, vector3_box(-.6, -4, 0), vector3_box(0, -.2, 0)),
            _common_ranged.magazine_models(nil, 0, vector3_box(-.2, -3, .1), vector3_box(0, 0, -.2)),
            _common_ranged.bayonet_models("barrel", -.5, vector3_box(.3, -4, 0), vector3_box(0, .4, 0)),
            -- Lasgun
            _common_lasgun.rail_models("receiver", 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2)),
            -- Other
            _autopistol_p1_m1.muzzle_models("barrel", -.5, vector3_box(.2, -2, 0), vector3_box(0, .2, 0)),
            _ogryn_rippergun_p1_m1.barrel_models("receiver", -.5, vector3_box(.2, -2, 0), vector3_box(0, .3, 0), "muzzle"),
            -- Common
            _common.trinket_hook_models("grip", -.2, vector3_box(-.1, -4, .2), vector3_box(0, 0, -.2)),
            _common.emblem_right_models("receiver", -3, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("receiver", 0, vector3_box(0, -4, 0), vector3_box(.2, 0, 0))
        ),
        anchors = {
            -- scope_offset = {position = vector3_box(0, 0, .022)},
            trinket_slot = "slot_trinket_2",
            fixes = {
                {dependencies = {"receiver_06"}, -- Grip
                    receiver = {offset = true,
                        mesh_position = {
                            vector3_box(-.035, -.01, -.01),
                            vector3_box(0, -.065, -.035),
                            vector3_box(0, -.015, .017),
                            vector3_box(0, .07, -.01),
                        },
                        mesh_index = {2, 4, 3, 5},
                        mesh_rotation = {
                            vector3_box(0, 0, 90),
                            vector3_box(0, 0, 90),
                            vector3_box(0, 0, 90),
                            vector3_box(0, 0, 90),
                        }
                    },
                    grip = {offset = true, position = vector3_box(0, .01, -.01)}
                },



                {dependencies = {"bolter_magazine_03"}, -- Magazine
                    magazine = {offset = true, position = vector3_box(0, -.01, -.01), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},




                {dependencies = {"scope_01"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, -.06, .19), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1.5, 1)},
                    lens = {offset = true, position = vector3_box(0, .12, .034), rotation = vector3_box(0, 0, 0), scale = vector3_box(.64, .6, .7), data = {lens = 1}},
                    lens_2 = {offset = true, position = vector3_box(0, .01, .034), rotation = vector3_box(180, 0, 0), scale = vector3_box(.64, .85, .7), data = {lens = 2}},
                    sight_2 = {offset = true, position = vector3_box(0, .07, -.046), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}}},
                    scope_offset = {position = vector3_box(0, .075, .014), rotation = vector3_box(-.3, 0, 0)},
                    rail = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                {dependencies = {"scope_02"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, -.08, .19), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 3, 1)},
                    lens = {offset = true, position = vector3_box(0, -.02, .035), rotation = vector3_box(0, 0, 0), scale = vector3_box(.62, .4, .7), data = {lens = 1}},
                    lens_2 = {offset = true, position = vector3_box(0, -.14, .035), rotation = vector3_box(180, 0, 0), scale = vector3_box(.62, .4, .7), data = {lens = 2}},
                    sight_2 = {offset = true, position = vector3_box(0, .09, -.0475), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 3, 4, 5}}},
                    scope_offset = {position = vector3_box(0, .1, .0165), rotation = vector3_box(.25, 0, 0)},
                    rail = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                {dependencies = {"scope_03"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, -.03, .19), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    lens = {offset = true, position = vector3_box(0, .08, .034), rotation = vector3_box(0, 0, 0), scale = vector3_box(.62, 1, .62), data = {lens = 1}},
                    lens_2 = {offset = true, position = vector3_box(0, .22, .034), rotation = vector3_box(180, 0, 0), scale = vector3_box(.62, 1, .62), data = {lens = 2}},
                    sight_2 = {offset = true, position = vector3_box(0, 0, -.0425), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}}},
                    scope_offset = {position = vector3_box(0, .13, .02)},
                    rail = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                {sight_2 = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                {lens = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                {lens_2 = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},



                {dependencies = {"grip_27|grip_28|grip_29"}, -- Grip
                    grip = {offset = true, position = vector3_box(0, .01, -.02), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},



                {dependencies = {"receiver_01", "emblem_left_02"}, -- Emblem
                    emblem_left = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, -1, 1)}},
                {dependencies = {"receiver_02", "emblem_left_02"}, -- Emblem
                    emblem_left = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, -1, 1)}},



                {dependencies = {"!trinket_hook"}, -- Sight
                    trinket_hook = {parent = "underbarrel", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},



                {dependencies = {"reflex_sight_01"}, -- Sight
                    sight = {offset = true, position = vector3_box(0, .03, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"reflex_sight_02"}, -- Sight
                    sight = {offset = true, position = vector3_box(0, .03, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"reflex_sight_03"}, -- Sight
                    sight = {offset = true, position = vector3_box(0, .03, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},



                {dependencies = {"auto_pistol_magazine_01"}, -- Magazine
                    magazine = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.4, 1.8, 1)}},
                {dependencies = {"magazine_01"}, -- Magazine
                    magazine = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.4, 1, 1)}},
                {dependencies = {"magazine_02"}, -- Magazine
                    magazine = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.4, 1, 1)}},
                {dependencies = {"magazine_03"}, -- Magazine
                    magazine = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.4, 1, 1)}},
                {dependencies = {"magazine_04"}, -- Magazine
                    magazine = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.4, 1, 1)}},



                {dependencies = {"laser_pointer"}, -- Laser Pointer
                    flashlight = {parent = "receiver", position = vector3_box(.045, .3, .1), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {flashlight = {parent = "receiver", position = vector3_box(.045, .3, .1), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}}, -- Flashlight



                {stock = {parent = "receiver", position = vector3_box(0, -0.1, 0.08), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}}, -- Stocks



                {dependencies = {"reflex_sight_01|reflex_sight_02|reflex_sight_03"}, -- Grip
                    scope_offset = {position = vector3_box(0, 0, .022)},
                    rail = {parent = "receiver", position = vector3_box(0, .025, .1625), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1.35, 1.3)}},
                {rail = {parent = "receiver", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}}, -- Rail



                {dependencies = {"autogun_bayonet_03"}, -- Bayonet
                    bayonet = {parent = "barrel", position = vector3_box(0, .125, -.04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {bayonet = {parent = "barrel", position = vector3_box(0, .2, -.045), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}}, -- Bayonet



                {dependencies = {"muzzle_02"}, -- Muzzle
                    muzzle = {parent = "barrel", position = vector3_box(0, .21, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.4, 1.4, 1.4)}},
                {dependencies = {"muzzle_04"}, -- Muzzle
                    muzzle = {parent = "barrel", position = vector3_box(0, .177, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.4, 1.4, 1.4)}},
                {dependencies = {"muzzle_05"}, -- Muzzle
                    muzzle = {parent = "barrel", position = vector3_box(0, .177, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.4, 1.4, 1.4)}},
                {dependencies = {"barrel_01"}, -- Ripper muzzle
                    muzzle = {parent = "barrel", position = vector3_box(0, -.08, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(.56, .56, .56)}},
                {dependencies = {"barrel_02"}, -- Ripper muzzle
                    muzzle = {parent = "barrel", position = vector3_box(0, -.1, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(.56, .56, .56)}},
                {dependencies = {"barrel_03"}, -- Ripper muzzle
                    muzzle = {parent = "barrel", position = vector3_box(0, -.1, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(.56, .56, .56)}},
                {dependencies = {"barrel_04"}, -- Ripper muzzle
                    muzzle = {parent = "barrel", position = vector3_box(0, -.08, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(.56, .56, .56)}},
                {dependencies = {"barrel_05"}, -- Ripper muzzle
                    muzzle = {parent = "barrel", position = vector3_box(0, -.08, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(.56, .56, .56)}},
                {dependencies = {"barrel_06"}, -- Ripper muzzle
                    muzzle = {parent = "barrel", position = vector3_box(0, -.1, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(.56, .56, .56)}},
                {muzzle = {position = vector3_box(0, .21, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.4, 1.4, 1.4)}},



                -- {slot_trinket_2 = {parent = "trinket_hook", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
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