local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
local _common_ranged = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_ranged")
local _common_lasgun = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_lasgun")

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
            {id = "receiver_01",        name = "Receiver 1"},
        }
    end,
    receiver_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            receiver_default = {model = "",                                                  type = "receiver", parent = tv(parent, 1), angle = a, move = m, remove = r},
            receiver_01 =      {model = _item_ranged.."/recievers/plasma_rifle_receiver_01", type = "receiver", parent = tv(parent, 2), angle = a, move = m, remove = r},
        }
    end,
    magazine_attachments = function()
        return {
            {id = "magazine_default",   name = mod:localize("mod_attachment_default")},
            {id = "magazine_01",        name = "Magazine 1"},
            {id = "magazine_02",        name = "Magazine 2"},
            {id = "magazine_03",        name = "Magazine 3"},
        }
    end,
    magazine_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            magazine_default = {model = "",                                                  type = "magazine", parent = tv(parent, 1), angle = a, move = m, remove = r},
            magazine_01 =      {model = _item_ranged.."/magazines/plasma_rifle_magazine_01", type = "magazine", parent = tv(parent, 2), angle = a, move = m, remove = r},
            magazine_02 =      {model = _item_ranged.."/magazines/plasma_rifle_magazine_02", type = "magazine", parent = tv(parent, 3), angle = a, move = m, remove = r},
            magazine_03 =      {model = _item_ranged.."/magazines/melta_gun_magazine_01",    type = "magazine", parent = tv(parent, 4), angle = a, move = m, remove = r},
        }
    end,
    barrel_attachments = function()
        return {
            {id = "barrel_default", name = mod:localize("mod_attachment_default")},
            {id = "barrel_01",      name = "Barrel 1"},
            {id = "barrel_02",      name = "Barrel 2"},
            {id = "barrel_03",      name = "Barrel 3"},
        }
    end,
    barrel_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            barrel_default = {model = "",                                              type = "barrel", parent = tv(parent, 1), angle = a, move = m, remove = r},
            barrel_01 =      {model = _item_ranged.."/barrels/plasma_rifle_barrel_01", type = "barrel", parent = tv(parent, 2), angle = a, move = m, remove = r},
            barrel_02 =      {model = _item_ranged.."/barrels/plasma_rifle_barrel_02", type = "barrel", parent = tv(parent, 3), angle = a, move = m, remove = r},
            barrel_03 =      {model = _item_ranged.."/barrels/plasma_rifle_barrel_03", type = "barrel", parent = tv(parent, 4), angle = a, move = m, remove = r},
        }
    end,
    stock_attachments = function()
        return {
            {id = "plasma_rifle_stock_default", name = mod:localize("mod_attachment_default")},
            {id = "plasma_rifle_stock_01",      name = "Ventilation 1"},
            {id = "plasma_rifle_stock_02",      name = "Ventilation 2"},
            {id = "plasma_rifle_stock_03",      name = "Ventilation 3"},
        }
    end,
    stock_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            plasma_rifle_stock_default = {model = "",                                            type = "stock", parent = tv(parent, 1), angle = a, move = m, remove = r},
            plasma_rifle_stock_01 =      {model = _item_ranged.."/stocks/plasma_rifle_stock_01", type = "stock", parent = tv(parent, 2), angle = a, move = m, remove = r},
            plasma_rifle_stock_02 =      {model = _item_ranged.."/stocks/plasma_rifle_stock_02", type = "stock", parent = tv(parent, 3), angle = a, move = m, remove = r},
            plasma_rifle_stock_03 =      {model = _item_ranged.."/stocks/plasma_rifle_stock_03", type = "stock", parent = tv(parent, 4), angle = a, move = m, remove = r},
        }
    end,
    grip_attachments = function()
        return {
            {id = "grip_default",   name = mod:localize("mod_attachment_default")},
            {id = "grip_01",        name = "Grip 1"},
            {id = "grip_02",        name = "Grip 2"},
            {id = "grip_03",        name = "Grip 3"},
        }
    end,
    grip_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            grip_default = {model = "",                                          type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r},
            grip_01 =      {model = _item_ranged.."/grips/plasma_rifle_grip_01", type = "grip", parent = tv(parent, 2), angle = a, move = m, remove = r},
            grip_02 =      {model = _item_ranged.."/grips/plasma_rifle_grip_02", type = "grip", parent = tv(parent, 3), angle = a, move = m, remove = r},
            grip_03 =      {model = _item_ranged.."/grips/plasma_rifle_grip_03", type = "grip", parent = tv(parent, 4), angle = a, move = m, remove = r},
        }
    end
}

return table.combine(
    functions,
    {
        attachments = { -- Done 14.9.2023
            sight_2 = table.icombine(
                _common_ranged.sight_default(),
                _common_ranged.reflex_sights_attachments()
            ),
            receiver = functions.receiver_attachments(),
            magazine = functions.magazine_attachments(),
            barrel = functions.barrel_attachments(),
            grip = functions.grip_attachments(),
            stock = functions.stock_attachments(),
            rail = _common_lasgun.rail_attachments(),
            stock_2 = _common_ranged.stock_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            trinket_hook = _common.trinket_hook_attachments(),
        },
        models = table.combine( -- Done 14.9.2023
            _common_ranged.reflex_sights_models("receiver", -.5, vector3_box(-.3, -4, -.2), vector3_box(0, -.2, 0), "sight_2", {}, {
                {rail = "rail_default"},
                {rail = "rail_01"},
                {rail = "rail_01"},
                {rail = "rail_01"},
            }),
            _common_ranged.stock_models("receiver", .5, vector3_box(-.4, -4, 0), vector3_box(0, -.2, 0), "stock_2"),
            _common_lasgun.rail_models("receiver", 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2)),
            _common.emblem_right_models("receiver", -3, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("receiver", 0, vector3_box(0, -4, 0), vector3_box(-.2, 0, 0)),
            functions.receiver_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.00001)),
            functions.magazine_models(nil, .1, vector3_box(-.2, -3, .1), vector3_box(0, 0, -.2)),
            functions.barrel_models(nil, -.5, vector3_box(.2, -2, 0), vector3_box(0, .2, 0), "barrel", {
                "trinket_hook_empty",
                "trinket_hook_empty",
                "trinket_hook_empty",
                "trinket_hook_empty",
            }),
            functions.stock_models(nil, .75, vector3_box(-.3, -4, -.1), vector3_box(0, -.015, .1)),
            _common.trinket_hook_models("barrel", -.2, vector3_box(.1, -4, .2), vector3_box(0, 0, -.2)),
            functions.grip_models(nil, .2, vector3_box(-.3, -4, .1), vector3_box(0, -.1, -.1))
        ),
        anchors = { -- Done 14.9.2023
            scope_offset = {position = vector3_box(.063, .15, -.00675)},
            fixes = {
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
                    magazine = {offset = true, position = vector3_box(0, -.06, 0), rotation = vector3_box(90, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"reflex_sight_01"}, -- Sight
                    sight_2 = {parent = "receiver", position = vector3_box(-.046, .01, .150), rotation = vector3_box(0, -52, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"reflex_sight_02"}, -- Sight
                    sight_2 = {parent = "receiver", position = vector3_box(-.046, .01, .150), rotation = vector3_box(0, -52, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"reflex_sight_03"}, -- Sight
                    sight_2 = {parent = "receiver", position = vector3_box(-.046, .01, .150), rotation = vector3_box(0, -52, 0), scale = vector3_box(1, 1, 1)}},
                {rail = {parent = "receiver", position = vector3_box(.089, -.02, .129), rotation = vector3_box(0, -52, 0), scale = vector3_box(1, .3, 1)}}, -- Rail
                {stock_2 = {parent = "receiver", position = vector3_box(0, -0.095, 0.055), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}}, -- Stocks
            },
        },
    }
)