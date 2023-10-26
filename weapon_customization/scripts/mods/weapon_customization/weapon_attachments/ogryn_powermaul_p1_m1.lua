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
    shaft_attachments = function()
        return {
            {id = "shaft_default",  name = "Default"},
            {id = "shaft_01",       name = "Shaft 1"},
            {id = "shaft_02",       name = "Shaft 2"},
            {id = "shaft_03",       name = "Shaft 3"},
            {id = "shaft_04",       name = "Shaft 4"},
            {id = "shaft_05",       name = "Shaft 5"},
        }
    end,
    shaft_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            shaft_default = {model = "",                                          type = "shaft", parent = tv(parent, 1), angle = a, move = m, remove = r},
            shaft_01 =      {model = _item_ranged.."/shafts/power_maul_shaft_01", type = "shaft", parent = tv(parent, 1), angle = a, move = m, remove = r},
            shaft_02 =      {model = _item_ranged.."/shafts/power_maul_shaft_02", type = "shaft", parent = tv(parent, 1), angle = a, move = m, remove = r},
            shaft_03 =      {model = _item_ranged.."/shafts/power_maul_shaft_03", type = "shaft", parent = tv(parent, 1), angle = a, move = m, remove = r},
            shaft_04 =      {model = _item_ranged.."/shafts/power_maul_shaft_04", type = "shaft", parent = tv(parent, 1), angle = a, move = m, remove = r},
            shaft_05 =      {model = _item_ranged.."/shafts/power_maul_shaft_05", type = "shaft", parent = tv(parent, 1), angle = a, move = m, remove = r},
        }
    end,
    head_attachments = function()
        return {
            {id = "head_default",   name = "Default"},
            {id = "head_01",        name = "Head 1"},
            {id = "head_02",        name = "Head 2"},
            {id = "head_03",        name = "Head 3"},
            {id = "head_04",        name = "Head 4"},
            {id = "head_05",        name = "Head 5"},
        }
    end,
    head_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            head_default = {model = "",                                       type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r},
            head_01 =      {model = _item_melee.."/heads/power_maul_head_01", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r},
            head_02 =      {model = _item_melee.."/heads/power_maul_head_02", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r},
            head_03 =      {model = _item_melee.."/heads/power_maul_head_03", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r},
            head_04 =      {model = _item_melee.."/heads/power_maul_head_04", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r},
            head_05 =      {model = _item_melee.."/heads/power_maul_head_05", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r},
        }
    end,
    pommel_attachments = function()
        return {
            {id = "pommel_default", name = "Default"},
            {id = "pommel_01",      name = "Pommel 1"},
            {id = "pommel_02",      name = "Pommel 2"},
            {id = "pommel_03",      name = "Pommel 3"},
            {id = "pommel_04",      name = "Pommel 4"},
            {id = "pommel_05",      name = "Pommel 5"},
        }
    end,
    pommel_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            pommel_default = {model = "",                                           type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            pommel_01 =      {model = _item_melee.."/pommels/power_maul_pommel_01", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false, no_support = {"trinket_hook_empty"}},
            pommel_02 =      {model = _item_melee.."/pommels/power_maul_pommel_02", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false, no_support = {"trinket_hook_empty"}},
            pommel_03 =      {model = _item_melee.."/pommels/power_maul_pommel_03", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false, no_support = {"trinket_hook_empty"}},
            pommel_04 =      {model = _item_melee.."/pommels/power_maul_pommel_04", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false, no_support = {"trinket_hook_empty"}},
            pommel_05 =      {model = _item_melee.."/pommels/power_maul_pommel_05", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false, no_support = {"trinket_hook_empty"}},
        }
    end
}

return table.combine(
    functions,
    {
        attachments = { -- Done 11.9.2023
            shaft = functions.shaft_attachments(),
            head = functions.head_attachments(),
            pommel = functions.pommel_attachments(),
            emblem_right = _common_functions.emblem_right_attachments(),
            emblem_left = _common_functions.emblem_left_attachments(),
            trinket_hook = _common_functions.trinket_hook_attachments(),
        },
        models = table.combine( -- Done 11.9.2023
            {customization_default_position = vector3_box(0, 2, 0)},
            functions.shaft_models(nil, 0, vector3_box(-.1, -4, .2), vector3_box(0, 0, 0)),
            _common_functions.emblem_right_models("head", -2.5, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common_functions.emblem_left_models("head", 0, vector3_box(.1, -4, -.1), vector3_box(-.2, 0, 0)),
            _common_functions.trinket_hook_models(nil, 0, vector3_box(-.3, -4, .3), vector3_box(0, 0, -.2)),
            functions.head_models(nil, 0, vector3_box(.3, -3, -.3), vector3_box(0, 0, .2)),
            functions.pommel_models(nil, 0, vector3_box(-.25, -5, .4), vector3_box(0, 0, -.2))
        ),
        anchors = { -- Done 11.9.2023 Additional custom positions for paper thing emblems?
            fixes = {
                {dependencies = {"pommel_05"}, -- Trinket hook
                    trinket_hook = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(.01, .01, .01)}},
                {dependencies = {"head_01"}, -- Emblems
                    emblem_left = {parent = "head", position = vector3_box(-.08, -.08, .54), rotation = vector3_box(90, 45, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "head", position = vector3_box(.08, .08, .54), rotation = vector3_box(90, 45, 0), scale = vector3_box(2, 2, 2)}},
                {dependencies = {"head_02"}, -- Emblems
                    emblem_left = {parent = "head", position = vector3_box(-.185, -.005, .315), rotation = vector3_box(90, 0, 185), scale = vector3_box(3, 3, 3)},
                    emblem_right = {parent = "head", position = vector3_box(.185, -.005, .315), rotation = vector3_box(90, 0, -5), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_03"}, -- Emblems
                    emblem_left = {parent = "head", position = vector3_box(-.21, 0, .280), rotation = vector3_box(90, 0, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "head", position = vector3_box(.21, 0, .280), rotation = vector3_box(90, 0, 0), scale = vector3_box(2, 2, 2)}},
                {dependencies = {"head_04"}, -- Emblems
                    emblem_left = {parent = "head", position = vector3_box(-.045, .105, .12), rotation = vector3_box(90, 0, 180), scale = vector3_box(1.75, 1.75, 1.75)},
                    emblem_right = {parent = "head", position = vector3_box(.045, -.105, .12), rotation = vector3_box(90, 0, 0), scale = vector3_box(1.75, 1.75, 1.75)}},
                {dependencies = {"head_05"}, -- Emblems
                    emblem_left = {parent = "head", position = vector3_box(-.16, -.05, .3), rotation = vector3_box(90, 10, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "head", position = vector3_box(.16, -.05, .3), rotation = vector3_box(90, -10, 0), scale = vector3_box(2, 2, 2)}},
            }
        },
    }
)