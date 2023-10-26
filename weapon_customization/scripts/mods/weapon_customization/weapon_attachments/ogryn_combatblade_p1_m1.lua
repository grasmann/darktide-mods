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
    blade_attachments = function()
        return {
            {id = "blade_default",  name = "Default"},
            {id = "blade_01",       name = "Blade 1"},
            {id = "blade_02",       name = "Blade 2"},
            {id = "blade_03",       name = "Blade 3"},
            {id = "blade_04",       name = "Blade 4"},
            {id = "blade_05",       name = "Blade 5"},
            {id = "blade_06",       name = "Blade 6"},
        }
    end,
    blade_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            blade_default = {model = "",                                           type = "blade", parent = tv(parent, 1), angle = a, move = m, remove = r, trigger_move = {"emblem_left", "emblem_right"}},
            blade_01 =      {model = _item_melee.."/blades/combat_blade_blade_01", type = "blade", parent = tv(parent, 1), angle = a, move = m, remove = r, trigger_move = {"emblem_left", "emblem_right"}},
            blade_02 =      {model = _item_melee.."/blades/combat_blade_blade_02", type = "blade", parent = tv(parent, 1), angle = a, move = m, remove = r, trigger_move = {"emblem_left", "emblem_right"}},
            blade_03 =      {model = _item_melee.."/blades/combat_blade_blade_03", type = "blade", parent = tv(parent, 1), angle = a, move = m, remove = r, trigger_move = {"emblem_left", "emblem_right"}},
            blade_04 =      {model = _item_melee.."/blades/combat_blade_blade_04", type = "blade", parent = tv(parent, 1), angle = a, move = m, remove = r, trigger_move = {"emblem_left", "emblem_right"}},
            blade_05 =      {model = _item_melee.."/blades/combat_blade_blade_05", type = "blade", parent = tv(parent, 1), angle = a, move = m, remove = r, trigger_move = {"emblem_left", "emblem_right"}},
            blade_06 =      {model = _item_melee.."/blades/combat_blade_blade_06", type = "blade", parent = tv(parent, 1), angle = a, move = m, remove = r, trigger_move = {"emblem_left", "emblem_right"}},
        }
    end,
    grip_attachments = function()
        return {
            {id = "grip_default",   name = "Default"},
            {id = "grip_01",        name = "Grip 1"},
            {id = "grip_02",        name = "Grip 2"},
            {id = "grip_03",        name = "Grip 3"},
            {id = "grip_04",        name = "Grip 4"},
            {id = "grip_05",        name = "Grip 5"},
            {id = "grip_06",        name = "Grip 6"},
        }
    end,
    grip_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            grip_default = {model = "",                                         type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r},
            grip_01 =      {model = _item_melee.."/grips/combat_blade_grip_01", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, no_support = {"trinket_hook_empty"}},
            grip_02 =      {model = _item_melee.."/grips/combat_blade_grip_02", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, no_support = {"trinket_hook_empty"}},
            grip_03 =      {model = _item_melee.."/grips/combat_blade_grip_03", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, automatic_equip = {trinket_hook = "trinket_hook_default"}, no_support = {"trinket_hook"}},
            grip_04 =      {model = _item_melee.."/grips/combat_blade_grip_04", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, no_support = {"trinket_hook_empty"}},
            grip_05 =      {model = _item_melee.."/grips/combat_blade_grip_05", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, no_support = {"trinket_hook_empty"}},
            grip_06 =      {model = _item_melee.."/grips/combat_blade_grip_06", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, no_support = {"trinket_hook_empty"}},
        }
    end,
    handle_attachments = function()
        return {
            {id = "handle_default", name = "Default"},
            {id = "handle_01",      name = "Handle 1"},
            {id = "handle_02",      name = "Handle 2"},
            {id = "handle_03",      name = "Handle 3"},
            {id = "handle_04",      name = "Handle 4"},
            {id = "handle_05",      name = "Handle 5"},
            {id = "handle_06",      name = "Handle 6"},
        }
    end,
    handle_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            handle_default = {model = "",                                              type = "handle", parent = tv(parent, 1), angle = a, move = m, remove = r},
            handle_01 =      {model = _item_ranged.."/handles/combat_blade_handle_01", type = "handle", parent = tv(parent, 1), angle = a, move = m, remove = r},
            handle_02 =      {model = _item_ranged.."/handles/combat_blade_handle_02", type = "handle", parent = tv(parent, 1), angle = a, move = m, remove = r},
            handle_03 =      {model = _item_ranged.."/handles/combat_blade_handle_03", type = "handle", parent = tv(parent, 1), angle = a, move = m, remove = r},
            handle_04 =      {model = _item_ranged.."/handles/combat_blade_handle_04", type = "handle", parent = tv(parent, 1), angle = a, move = m, remove = r},
            handle_05 =      {model = _item_ranged.."/handles/combat_blade_handle_05", type = "handle", parent = tv(parent, 1), angle = a, move = m, remove = r},
            handle_06 =      {model = _item_ranged.."/handles/combat_blade_handle_06", type = "handle", parent = tv(parent, 1), angle = a, move = m, remove = r},
        }
    end
}

return table.combine(
    functions,
    {
        attachments = { -- Done 10.9.2023
            blade = functions.blade_attachments(),
            grip = functions.grip_attachments(),
            handle = functions.handle_attachments(),
            emblem_right = _common_functions.emblem_right_attachments(),
            emblem_left = _common_functions.emblem_left_attachments(),
            trinket_hook = _common_functions.trinket_hook_attachments(),
        },
        models = table.combine( -- Done 10.9.2023
            _common_functions.emblem_right_models("grip", -2.5, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common_functions.emblem_left_models("grip", 0, vector3_box(.1, -4, -.1), vector3_box(-.2, 0, 0)),
            _common_functions.trinket_hook_models(nil, 0, vector3_box(-.3, -4, .3), vector3_box(0, 0, -.2)),
            functions.blade_models(nil, 0, vector3_box(.1, -3, -.1), vector3_box(0, 0, .2)),
            functions.grip_models(nil, 0, vector3_box(-.1, -4, .2), vector3_box(0, .2, 0)),
            functions.handle_models(nil, 0, vector3_box(-.15, -5, .2), vector3_box(0, 0, -.2))
        ),
        anchors = { -- Done 10.9.2023 Additional custom positions for paper thing emblems?
            fixes = {
                {dependencies = {"grip_05", "!handle_05"}, -- Trinket hook
                    trinket_hook = {offset = true, position = vector3_box(0, 0, .055), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"blade_01"}, -- Emblems
                    emblem_left = {parent = "blade", position = vector3_box(-.02, .02, .375), rotation = vector3_box(90, 0, 180), scale = vector3_box(3, 3, 3)},
                    emblem_right = {parent = "blade", position = vector3_box(.02, .02, .375), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"blade_02"}, -- Emblems
                    emblem_left = {parent = "blade", position = vector3_box(-.02, -.01, .275), rotation = vector3_box(90, 0, 180), scale = vector3_box(3, 3, 3)},
                    emblem_right = {parent = "blade", position = vector3_box(.02, -.01, .275), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"blade_03"}, -- Emblems
                    emblem_left = {parent = "blade", position = vector3_box(-.02, .015, .175), rotation = vector3_box(90, 0, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "blade", position = vector3_box(.02, .015, .175), rotation = vector3_box(90, 0, 0), scale = vector3_box(2, 2, 2)}},
                {dependencies = {"blade_04"}, -- Emblems
                    emblem_left = {parent = "blade", position = vector3_box(-.02, .04, .525), rotation = vector3_box(90, 0, 180), scale = vector3_box(3, 3, 3)},
                    emblem_right = {parent = "blade", position = vector3_box(.02, .04, .525), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"blade_05"}, -- Emblems
                    emblem_left = {parent = "blade", position = vector3_box(-.02, .06, .125), rotation = vector3_box(83, 0, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "blade", position = vector3_box(.02, .06, .125), rotation = vector3_box(83, 0, 0), scale = vector3_box(2, 2, 2)}},
                {dependencies = {"blade_06"}, -- Emblems
                    emblem_left = {parent = "blade", position = vector3_box(-.02, 0, .275), rotation = vector3_box(90, 0, 180), scale = vector3_box(4, 4, 4)},
                    emblem_right = {parent = "blade", position = vector3_box(.02, 0, .275), rotation = vector3_box(90, 0, 0), scale = vector3_box(4, 4, 4)}},
            },
        },
    }
)