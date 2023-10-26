local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local _common_functions = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")

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

local functions = {
    receiver_attachments = function()
        return {
            {id = "receiver_default",   name = "Default"},
            {id = "receiver_01",        name = "Receiver 1"},
        }
    end,
    receiver_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            receiver_default = {model = "",                                                   type = "receiver", parent = tv(parent, 1), angle = a, move = m, remove = r},
            receiver_01 =      {model = _item_ranged.."/recievers/shotgun_rifle_receiver_01", type = "receiver", parent = tv(parent, 2), angle = a, move = m, remove = r},
        }
    end,
    stock_attachments = function()
        return {
            {id = "shotgun_rifle_stock_default",    name = "Default"},
            {id = "shotgun_rifle_stock_01",         name = "Stock 1"},
            {id = "shotgun_rifle_stock_02",         name = "Stock 2"},
            {id = "shotgun_rifle_stock_03",         name = "Stock 3"},
            {id = "shotgun_rifle_stock_04",         name = "Stock 4"},
        }
    end,
    stock_models = function(parent, angle, move, remove, type)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        local t = type or "stock"
        return {
            shotgun_rifle_stock_default = {model = "",                                             type = t, parent = tv(parent, 1), angle = a, move = m, remove = r},
            shotgun_rifle_stock_01 =      {model = _item_ranged.."/stocks/shotgun_rifle_stock_01", type = t, parent = tv(parent, 2), angle = a, move = m, remove = r},
            shotgun_rifle_stock_02 =      {model = _item_ranged.."/stocks/shotgun_rifle_stock_03", type = t, parent = tv(parent, 3), angle = a, move = m, remove = r},
            shotgun_rifle_stock_03 =      {model = _item_ranged.."/stocks/shotgun_rifle_stock_05", type = t, parent = tv(parent, 4), angle = a, move = m, remove = r},
            shotgun_rifle_stock_04 =      {model = _item_ranged.."/stocks/shotgun_rifle_stock_06", type = t, parent = tv(parent, 5), angle = a, move = m, remove = r},
        }
    end,
    barrel_attachments = function()
        return {
            {id = "barrel_default", name = "Default"},
            {id = "barrel_01",      name = "Barrel 1"},
            {id = "barrel_02",      name = "Barrel 2"},
            {id = "barrel_03",      name = "Barrel 3"},
            {id = "barrel_04",      name = "Barrel 4"},
        }
    end,
    barrel_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            barrel_default = {model = "",                                               type = "barrel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            barrel_01 =      {model = _item_ranged.."/barrels/shotgun_rifle_barrel_01", type = "barrel", parent = tv(parent, 2), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = {trinket_hook = "trinket_hook_01"}, no_support = {"trinket_hook_empty"}},
            barrel_02 =      {model = _item_ranged.."/barrels/shotgun_rifle_barrel_04", type = "barrel", parent = tv(parent, 3), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = {trinket_hook = "trinket_hook_01"}, no_support = {"trinket_hook_empty"}},
            barrel_03 =      {model = _item_ranged.."/barrels/shotgun_rifle_barrel_05", type = "barrel", parent = tv(parent, 4), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = {trinket_hook = "trinket_hook_empty"}, no_support = {"trinket_hook"}},
            barrel_04 =      {model = _item_ranged.."/barrels/shotgun_rifle_barrel_06", type = "barrel", parent = tv(parent, 5), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = {trinket_hook = "trinket_hook_empty"}, no_support = {"trinket_hook"}},
        }
    end,
    underbarrel_attachments = function()
        return {
            {id = "underbarrel_default",    name = "Default"},
            {id = "underbarrel_01",         name = "Underbarrel 1"},
            {id = "underbarrel_02",         name = "Underbarrel 2"},
            {id = "underbarrel_03",         name = "Underbarrel 3"},
            {id = "underbarrel_04",         name = "Underbarrel 4"},
        }
    end,
    underbarrel_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            underbarrel_default = {model = "",                                                         type = "underbarrel", parent = tv(parent, 1), angle = a, move = m, remove = r},
            underbarrel_01 =      {model = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_01", type = "underbarrel", parent = tv(parent, 2), angle = a, move = m, remove = r},
            underbarrel_02 =      {model = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_04", type = "underbarrel", parent = tv(parent, 3), angle = a, move = m, remove = r},
            underbarrel_03 =      {model = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_05", type = "underbarrel", parent = tv(parent, 4), angle = a, move = m, remove = r},
            underbarrel_04 =      {model = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_06", type = "underbarrel", parent = tv(parent, 5), angle = a, move = m, remove = r},
        }
    end,
}

return table.combine(
    functions,
    {
        attachments = { -- Done 13.9.2023
            flashlight = _common_functions.flashlights_attachments(),
            trinket_hook = _common_functions.trinket_hook_attachments(),
            receiver = functions.receiver_attachments(),
            stock = functions.stock_attachments(),
            sight_2 = table.icombine(
                _common_functions.sight_default(),
                _common_functions.reflex_sights_attachments()
            ),
            barrel = functions.barrel_attachments(),
            underbarrel = functions.underbarrel_attachments(),
            emblem_right = _common_functions.emblem_right_attachments(),
            emblem_left = _common_functions.emblem_left_attachments(),
        },
        models = table.combine( -- Done 13.9.2023
            _common_functions.flashlight_models(nil, -2.5, vector3_box(-.3, -3, 0), vector3_box(.2, 0, 0)),
            _common_functions.emblem_right_models("receiver", -3, vector3_box(-.4, -5, 0), vector3_box(.2, 0, 0)),
            _common_functions.emblem_left_models("receiver", 0, vector3_box(0, -5, 0), vector3_box(-.2, 0, 0)),
            _common_functions.trinket_hook_models(nil, -.2, vector3_box(.3, -4, .1), vector3_box(0, 0, -.2)),
            _common_functions.reflex_sights_models("sight", -.5, vector3_box(-.3, -4, -.2), vector3_box(0, -.2, 0), "sight_2"),
            functions.receiver_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.00001)),
            functions.stock_models("receiver", 0, vector3_box(-.4, -4, 0), vector3_box(0, -.2, 0)),
            functions.barrel_models(nil, -.5, vector3_box(.1, -4, 0), vector3_box(0, .2, 0)),
            functions.underbarrel_models(nil, -.5, vector3_box(0, -4, 0), vector3_box(0, 0, -.2))
        ),
        anchors = { -- Done 13.9.2023
            scope_offset = {position = vector3_box(0, 0, .02)},
            fixes = {
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
                {sight_2 = {parent = "sight", position = vector3_box(0, -.04, .025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
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