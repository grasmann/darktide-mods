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

local tv = function(t, i)
    local res = nil
    if type(t) == "table" then
        if #t >= i then
            res = t[i]
        elseif #t >= 1 then
            res = t[1]
        else
            return nil
        end
    else
        res = t
    end
    if res == "" then
        return nil
    end
    return res
end
table.combine = function(...)
    local arg = {...}
    local combined = {}
    for _, t in ipairs(arg) do
        for name, value in pairs(t) do
            combined[name] = value
        end
    end
    return combined
end
table.icombine = function(...)
    local arg = {...}
    local combined = {}
    for _, t in ipairs(arg) do
        for _, value in pairs(t) do
            combined[#combined+1] = value
        end
    end
    return combined
end

local functions = {
    receiver_attachments = function()
        return {
            {id = "receiver_default",   name = mod:localize("mod_attachment_default")},
            {id = "receiver_01",        name = "Recon Lasgun 1"},
            {id = "receiver_02",        name = "Recon Lasgun 2"},
            {id = "receiver_03",        name = "Recon Lasgun 3"},
            {id = "receiver_04",        name = "Recon Lasgun 4"},
            {id = "receiver_05",        name = "Recon Lasgun 5"},
            {id = "receiver_06",        name = "Recon Lasgun 6"},
        }
    end,
    receiver_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            receiver_default = {model = "",                                                          type = "receiver", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            receiver_01 =      {model = _item_ranged.."/recievers/lasgun_rifle_elysian_receiver_01", type = "receiver", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            receiver_02 =      {model = _item_ranged.."/recievers/lasgun_rifle_elysian_receiver_02", type = "receiver", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            receiver_03 =      {model = _item_ranged.."/recievers/lasgun_rifle_elysian_receiver_03", type = "receiver", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            receiver_04 =      {model = _item_ranged.."/recievers/lasgun_rifle_elysian_receiver_04", type = "receiver", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            receiver_05 =      {model = _item_ranged.."/recievers/lasgun_rifle_elysian_receiver_05", type = "receiver", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            receiver_06 =      {model = _item_ranged.."/recievers/lasgun_rifle_elysian_receiver_06", type = "receiver", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    stock_attachments = function()
        return {
            {id = "stock_default", name = mod:localize("mod_attachment_default")},
            {id = "stock_01",      name = "Recon Lasgun 1"},
            {id = "stock_02",      name = "Recon Lasgun 2"},
            {id = "stock_03",      name = "Recon Lasgun 3"},
        }
    end,
    stock_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            stock_default = {model = "",                                                    type = "stock", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            stock_01 =      {model = _item_ranged.."/stocks/lasgun_rifle_elysian_stock_01", type = "stock", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            stock_02 =      {model = _item_ranged.."/stocks/lasgun_rifle_elysian_stock_02", type = "stock", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            stock_03 =      {model = _item_ranged.."/stocks/lasgun_rifle_elysian_stock_03", type = "stock", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    magazine_attachments = function()
        return {
            {id = "magazine_default", name = mod:localize("mod_attachment_default")},
            {id = "magazine_01",      name = "Recon Lasgun"},
        }
    end,
    magazine_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            magazine_default = {model = "",                                                    type = "magazine", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            magazine_01 =      {model = _item_ranged.."/magazines/lasgun_elysian_magazine_01", type = "magazine", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    sight_attachments = function()
        return {
            -- {id = "elysian_sight_default", name = mod:localize("mod_attachment_default"),      sounds = {UISoundEvents.apparel_equip}},
            {id = "elysian_sight_01",      name = "Recon Lasgun 1"},
            {id = "elysian_sight_02",      name = "Recon Lasgun 2"},
            {id = "elysian_sight_03",      name = "Recon Lasgun 3"},
        }
    end,
    sight_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            elysian_sight_default = {model = "",                                                    type = "sight", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            elysian_sight_01 =      {model = _item_ranged.."/sights/lasgun_rifle_elysian_sight_01", type = "sight", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            elysian_sight_02 =      {model = _item_ranged.."/sights/lasgun_rifle_elysian_sight_02", type = "sight", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            elysian_sight_03 =      {model = _item_ranged.."/sights/lasgun_rifle_elysian_sight_03", type = "sight", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
}

return table.combine(
    functions,
    {
        attachments = { -- Done 12.10.2023
            flashlight = _common_ranged.flashlights_attachments(),
            bayonet = _common_ranged.bayonet_attachments(),
            rail = _common_lasgun.rail_attachments(),
            grip = _common_ranged.grip_attachments(),
            barrel = _common_lasgun.barrel_attachments(),
            muzzle = _common_lasgun.muzzle_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            sight = table.icombine(
                _common_ranged.sight_default(),
                -- {{id = "elysian_sight_default", name = mod:localize("mod_attachment_default"),      sounds = {UISoundEvents.apparel_equip}}},
                functions.sight_attachments(),
                _common_ranged.reflex_sights_attachments(),
                _common_ranged.sights_attachments()
            ),
            help_sight = _bolter_p1_m1.sight_attachments(),
            receiver = functions.receiver_attachments(),
            stock = functions.stock_attachments(),
            magazine = functions.magazine_attachments(),
        },
        models = table.combine( -- Done 12.10.2023
            _common_ranged.flashlight_models(nil, -2.5, vector3_box(-.3, -3, -.05), vector3_box(.2, 0, 0)),
            _common.emblem_right_models("receiver", -3, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("receiver", 0, vector3_box(0, -3, 0), vector3_box(-.2, 0, 0)),
            _common_ranged.bayonet_models({"barrel", "barrel", "barrel", "muzzle"}, -.5, vector3_box(.3, -3, 0), vector3_box(0, .4, -.034)),
            _common_ranged.grip_models(nil, .4, vector3_box(-.4, -4, .1), vector3_box(0, 0, -.1)),
            _common_lasgun.barrel_models(nil, -.3, vector3_box(.2, -2, 0), vector3_box(0, .2, 0)),
            _common_lasgun.muzzle_models(nil, -.5, vector3_box(.3, -3, 0), vector3_box(0, .2, 0)),
            functions.sight_models(nil, .35, vector3_box(-.3, -4, -.2), vector3_box(0, -.2, 0)),
            _common_ranged.reflex_sights_models(nil, .2, vector3_box(-.3, -4, -.2), vector3_box(0, -.2, 0), "sight", {}, {
                {rail = "rail_default", help_sight = "sight_default"},
                {rail = "rail_01", help_sight = "sight_default"},
                {rail = "rail_01", help_sight = "sight_default"},
                {rail = "rail_01", help_sight = "sight_default"},
            }),
            _common_ranged.sights_models(nil, .35, vector3_box(-.3, -4, -.2), vector3_box(0, -.2, 0), "sight", {}, {
                {rail = "rail_default", help_sight = "sight_default"},
                {rail = "rail_01", help_sight = "bolter_sight_01"},
                {rail = "rail_default", help_sight = "bolter_sight_01"},
                {rail = "rail_01", help_sight = "bolter_sight_01"},
                {rail = "rail_default", help_sight = "sight_default"},
            }, {
                {},
                {},
                {},
                {},
                {{"sight", 1}},
            }),
            _common_lasgun.rail_models("receiver", 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2)),
            _bolter_p1_m1.sight_models("receiver", .35, vector3_box(-.3, -4, -.2), vector3_box(0, -.2, 0), "help_sight", {}, {}, {}),
            functions.stock_models(nil, .5, vector3_box(-.5, -4, 0), vector3_box(0, -.4, -.11)),
            functions.receiver_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.00001)),
            functions.magazine_models(nil, .2, vector3_box(-.2, -3, .1), vector3_box(0, 0, -.2))
        ),
        anchors = { -- Done 12.10.2023
            scope_offset = {position = vector3_box(0, 0, .0275)},
            fixes = {
                {dependencies = {"grip_27|grip_28|grip_29"}, -- Grip
                    grip = {offset = true, position = vector3_box(0, .01, -.02), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"receiver_01", "emblem_left_02"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.023, .325, .115), rotation = vector3_box(0, 25, 180), scale = vector3_box(1, -1, 1)}},
                {dependencies = {"receiver_01"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.023, .325, .115), rotation = vector3_box(0, 25, 180), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"receiver_02", "emblem_left_02"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.0225, .365, .12), rotation = vector3_box(0, 25, 180), scale = vector3_box(1.25, -1.25, 1.25)}},
                {dependencies = {"receiver_02"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.0225, .365, .12), rotation = vector3_box(0, 25, 180), scale = vector3_box(1.25, 1.25, 1.25)}},
                {dependencies = {"receiver_03", "emblem_left_02"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, -1, 1)}},
                {dependencies = {"receiver_04", "emblem_left_02"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.023, .325, .115), rotation = vector3_box(0, 25, 180), scale = vector3_box(1, -1, 1)}},
                {dependencies = {"receiver_04"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.023, .325, .115), rotation = vector3_box(0, 25, 180), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"receiver_05", "emblem_left_02"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.03, -.045, .04), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, -1, 1)}},
                {dependencies = {"receiver_05"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.03, -.045, .04), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"receiver_06", "emblem_left_02"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.03, -.045, .04), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, -1, 1)}},
                {dependencies = {"receiver_06"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.03, -.045, .04), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, 1, 1)}},

                {dependencies = {"reflex_sight_01|reflex_sight_02|reflex_sight_03"}, -- Muzzle
                    sight = {offset = true, position = vector3_box(0, .01, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    scope_offset = {position = vector3_box(0, 0, .027)}},

                {dependencies = {"autogun_rifle_sight_01"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, .0265, 0), mesh_position = vector3_box(0, .0265, 0), mesh_index = 8, scale = vector3_box(.765, 1, 1), scale_node = 5},
                    help_sight = {offset = true, position = vector3_box(0, -.055, .0065), scale = vector3_box(.7, .75, 1), scale_node = 5}},
                {dependencies = {"autogun_rifle_sight_01"}, -- Infantry sight
                    no_scope_offset = {position = vector3_box(0, 0, .0155), rotation = vector3_box(1, 0, 0)}},
                {dependencies = {"autogun_rifle_ak_sight_01"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, .045, 0), scale = vector3_box(1, 1, 1), scale_node = 1},
                    help_sight = {offset = true, position = vector3_box(0, -.055, .0065), scale = vector3_box(.7, .75, 1), scale_node = 5}},
                {dependencies = {"autogun_rifle_ak_sight_01"}, -- Infantry sight
                    no_scope_offset = {position = vector3_box(0, 0, .0134), rotation = vector3_box(.6, 0, 0)}},
                {dependencies = {"autogun_rifle_killshot_sight_01"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, .045, 0), scale = vector3_box(1, 1, 1), scale_node = 1},
                    help_sight = {offset = true, position = vector3_box(0, -.055, .0065), scale = vector3_box(.7, .75, 1), scale_node = 5}},
                {dependencies = {"autogun_rifle_killshot_sight_01"}, -- Infantry sight
                    no_scope_offset = {position = vector3_box(0, 0, .0145), rotation = vector3_box(.8, 0, 0)}},
                {help_sight = {parent = "receiver", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0), scale_node = 5}},

                {dependencies = {"lasgun_rifle_sight_01", "receiver_01"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, .031, .0375), rotation = vector3_box(0, 0, 0), scale = vector3_box(.9, 1, 1), scale_node = 6}},
                {dependencies = {"lasgun_rifle_sight_01", "receiver_02"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, .05, .0375), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.1, 1, 1), scale_node = 6}},
                {dependencies = {"lasgun_rifle_sight_01", "receiver_03"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, .04, .0375), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1), scale_node = 6}},
                {dependencies = {"lasgun_rifle_sight_01", "receiver_04"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, .031, .0375), rotation = vector3_box(0, 0, 0), scale = vector3_box(.9, 1, 1), scale_node = 6}},
                {dependencies = {"lasgun_rifle_sight_01", "receiver_05"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, .031, .0375), rotation = vector3_box(0, 0, 0), scale = vector3_box(.9, 1, 1), scale_node = 6}},
                {dependencies = {"lasgun_rifle_sight_01", "receiver_06"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, .031, .0375), rotation = vector3_box(0, 0, 0), scale = vector3_box(.9, 1, 1), scale_node = 6}},
                {dependencies = {"lasgun_rifle_sight_01"}, -- Infantry sight
                    no_scope_offset = {position = vector3_box(0, 0, .0038), rotation = vector3_box(0, 0, 0)}},

                {dependencies = {"reflex_sight_01|reflex_sight_02|reflex_sight_03|autogun_rifle_ak_sight_01|autogun_rifle_killshot_sight_01", "receiver_01"}, -- Rail
                    rail = {parent = "receiver", position = vector3_box(0, .0325, .18), rotation = vector3_box(0, 0, 0), scale = vector3_box(.68, .975, 1)}},
                {dependencies = {"reflex_sight_01|reflex_sight_02|reflex_sight_03|autogun_rifle_ak_sight_01|autogun_rifle_killshot_sight_01", "receiver_02"}, -- Rail
                    rail = {parent = "receiver", position = vector3_box(0, .035, .18), rotation = vector3_box(0, 0, 0), scale = vector3_box(.68, 1.22, 1)}},
                {dependencies = {"reflex_sight_01|reflex_sight_02|reflex_sight_03|autogun_rifle_ak_sight_01|autogun_rifle_killshot_sight_01", "receiver_03"}, -- Rail
                    rail = {parent = "receiver", position = vector3_box(0, .0325, .18), rotation = vector3_box(0, 0, 0), scale = vector3_box(.68, 1.075, 1)}},
                {dependencies = {"reflex_sight_01|reflex_sight_02|reflex_sight_03|autogun_rifle_ak_sight_01|autogun_rifle_killshot_sight_01", "receiver_04"}, -- Rail
                    rail = {parent = "receiver", position = vector3_box(0, .0325, .18), rotation = vector3_box(0, 0, 0), scale = vector3_box(.68, .975, 1)}},
                {dependencies = {"reflex_sight_01|reflex_sight_02|reflex_sight_03|autogun_rifle_ak_sight_01|autogun_rifle_killshot_sight_01", "receiver_05"}, -- Rail
                    rail = {parent = "receiver", position = vector3_box(0, .0325, .18), rotation = vector3_box(0, 0, 0), scale = vector3_box(.68, .975, 1)}},
                {dependencies = {"reflex_sight_01|reflex_sight_02|reflex_sight_03|autogun_rifle_ak_sight_01|autogun_rifle_killshot_sight_01", "receiver_06"}, -- Rail
                    rail = {parent = "receiver", position = vector3_box(0, .0325, .18), rotation = vector3_box(0, 0, 0), scale = vector3_box(.68, .975, 1)}},
                {rail = {parent = "receiver", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},

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
            },
        },
    }
)