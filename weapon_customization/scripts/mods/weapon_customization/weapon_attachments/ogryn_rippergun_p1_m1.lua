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
    barrel_attachments = function()
        return {
            -- {id = "barrel_default", name = mod:localize("mod_attachment_default"),   sounds = {_barrel_sound}},
            {id = "barrel_01",      name = "Ripper Barrel A"},
            {id = "barrel_02",      name = "Ripper Barrel B"},
            {id = "barrel_03",      name = "Ripper Barrel C"},
            {id = "barrel_04",      name = "Ripper Barrel D"},
            {id = "barrel_05",      name = "Ripper Barrel E"},
            {id = "barrel_06",      name = "Ripper Barrel F"},
        }
    end,
    barrel_models = function(parent, angle, move, remove, type, no_support, automatic_equip)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        local t = type or "barrel"
        return {
            barrel_default = {model = "",                                                 type = t, parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1), mesh_move = false},
            barrel_01 =      {model = _item_ranged.."/barrels/rippergun_rifle_barrel_01", type = t, parent = tv(parent, 2), angle = a, move = m, remove = tv(r, 2), mesh_move = false},
            barrel_02 =      {model = _item_ranged.."/barrels/rippergun_rifle_barrel_02", type = t, parent = tv(parent, 3), angle = a, move = m, remove = tv(r, 3), mesh_move = false},
            barrel_03 =      {model = _item_ranged.."/barrels/rippergun_rifle_barrel_03", type = t, parent = tv(parent, 4), angle = a, move = m, remove = tv(r, 4), mesh_move = false},
            barrel_04 =      {model = _item_ranged.."/barrels/rippergun_rifle_barrel_04", type = t, parent = tv(parent, 5), angle = a, move = m, remove = tv(r, 5), mesh_move = false},
            barrel_05 =      {model = _item_ranged.."/barrels/rippergun_rifle_barrel_05", type = t, parent = tv(parent, 6), angle = a, move = m, remove = tv(r, 6), mesh_move = false},
            barrel_06 =      {model = _item_ranged.."/barrels/rippergun_rifle_barrel_06", type = t, parent = tv(parent, 7), angle = a, move = m, remove = tv(r, 7), mesh_move = false},
        }
    end,
    receiver_attachments = function()
        return {
            {id = "receiver_default",   name = mod:localize("mod_attachment_default")},
            {id = "receiver_01",        name = "Receiver 1"},
            {id = "receiver_02",        name = "Receiver 2"},
            {id = "receiver_03",        name = "Receiver 3"},
            {id = "receiver_04",        name = "Receiver 4"},
            {id = "receiver_05",        name = "Receiver 5"},
            {id = "receiver_06",        name = "Receiver 6"},
            {id = "receiver_07",        name = "Receiver 7"},
            {id = "receiver_08",        name = "Receiver 8"},
            {id = "receiver_09",        name = "Receiver 9"},
        }
    end,
    receiver_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            receiver_default = {model = "",                                                     type = "receiver", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1), no_support = {"trinket_hook_empty"}},
            receiver_01 =      {model = _item_ranged.."/recievers/rippergun_rifle_receiver_01", type = "receiver", parent = tv(parent, 2), angle = a, move = m, remove = tv(r, 2), no_support = {"trinket_hook_empty"}},
            receiver_02 =      {model = _item_ranged.."/recievers/rippergun_rifle_receiver_02", type = "receiver", parent = tv(parent, 3), angle = a, move = m, remove = tv(r, 3), no_support = {"trinket_hook_empty"}},
            receiver_03 =      {model = _item_ranged.."/recievers/rippergun_rifle_receiver_03", type = "receiver", parent = tv(parent, 4), angle = a, move = m, remove = tv(r, 4), no_support = {"trinket_hook_empty"}},
            receiver_04 =      {model = _item_ranged.."/recievers/rippergun_rifle_receiver_04", type = "receiver", parent = tv(parent, 5), angle = a, move = m, remove = tv(r, 5), no_support = {"trinket_hook_empty"}},
            receiver_05 =      {model = _item_ranged.."/recievers/rippergun_rifle_receiver_05", type = "receiver", parent = tv(parent, 6), angle = a, move = m, remove = tv(r, 6), no_support = {"trinket_hook_empty"}},
            receiver_06 =      {model = _item_ranged.."/recievers/rippergun_rifle_receiver_06", type = "receiver", parent = tv(parent, 7), angle = a, move = m, remove = tv(r, 7), no_support = {"trinket_hook_empty"}},
            receiver_07 =      {model = _item_ranged.."/recievers/rippergun_rifle_receiver_07", type = "receiver", parent = tv(parent, 8), angle = a, move = m, remove = tv(r, 8), no_support = {"trinket_hook_empty"}},
            receiver_08 =      {model = _item_ranged.."/recievers/rippergun_rifle_receiver_08", type = "receiver", parent = tv(parent, 9), angle = a, move = m, remove = tv(r, 9), no_support = {"trinket_hook_empty"}},
            receiver_09 =      {model = _item_ranged.."/recievers/rippergun_rifle_receiver_09", type = "receiver", parent = tv(parent, 10), angle = a, move = m, remove = tv(r, 10), no_support = {"trinket_hook_empty"}},
        }
    end,
    magazine_attachments = function()
        return {
            {id = "magazine_default",   name = mod:localize("mod_attachment_default")},
            {id = "magazine_01",        name = "Magazine 1"},
            {id = "magazine_02",        name = "Magazine 2"},
            {id = "magazine_03",        name = "Magazine 3"},
            {id = "magazine_04",        name = "Magazine 4"},
            {id = "magazine_05",        name = "Magazine 5"},
            {id = "magazine_06",        name = "Magazine 6"},
            {id = "magazine_07",        name = "Magazine 7"},
        }
    end,
    magazine_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            magazine_default = {model = "",                                                     type = "magazine", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1)},
            magazine_01 =      {model = _item_ranged.."/magazines/rippergun_rifle_magazine_01", type = "magazine", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1)},
            magazine_02 =      {model = _item_ranged.."/magazines/rippergun_rifle_magazine_02", type = "magazine", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1)},
            magazine_03 =      {model = _item_ranged.."/magazines/rippergun_rifle_magazine_03", type = "magazine", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1)},
            magazine_04 =      {model = _item_ranged.."/magazines/rippergun_rifle_magazine_04", type = "magazine", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1)},
            magazine_05 =      {model = _item_ranged.."/magazines/rippergun_rifle_magazine_05", type = "magazine", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1)},
            magazine_06 =      {model = _item_ranged.."/magazines/rippergun_rifle_magazine_06", type = "magazine", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1)},
            magazine_07 =      {model = _item_ranged.."/magazines/rippergun_rifle_magazine_07", type = "magazine", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1)},
        }
    end,
    handle_attachments = function()
        return {
            {id = "handle_default", name = mod:localize("mod_attachment_default")},
            {id = "handle_01",      name = "Handle 1"},
            {id = "handle_02",      name = "Handle 2"},
            {id = "handle_03",      name = "Handle 3"},
            {id = "handle_04",      name = "Handle 4"},
            {id = "handle_05",      name = "Handle 5"},
        }
    end,
    handle_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            handle_default = {model = "",                                                 type = "handle", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1)},
            handle_01 =      {model = _item_ranged.."/handles/rippergun_rifle_handle_01", type = "handle", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1)},
            handle_02 =      {model = _item_ranged.."/handles/rippergun_rifle_handle_02", type = "handle", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1)},
            handle_03 =      {model = _item_ranged.."/handles/rippergun_rifle_handle_03", type = "handle", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1)},
            handle_04 =      {model = _item_ranged.."/handles/rippergun_rifle_handle_04", type = "handle", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1)},
            handle_05 =      {model = _item_ranged.."/handles/rippergun_rifle_handle_05", type = "handle", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1)},
        }
    end,
}

return table.combine(
    functions,
    {
        attachments = { -- Done 8.9.2023
            flashlight = _common_ranged.flashlights_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            bayonet = _common_ranged.ogryn_bayonet_attachments(),
            barrel = table.icombine(
                {{id = "barrel_default", name = mod:localize("mod_attachment_default")}},
                functions.barrel_attachments()
            ),
            receiver = functions.receiver_attachments(),
            magazine = functions.magazine_attachments(),
            handle = functions.handle_attachments(),
            trinket_hook = _common.trinket_hook_attachments(),
        },
        models = table.combine( -- Done 8.9.2023
            _common_ranged.flashlight_models("receiver", -2.25, vector3_box(-.2, -3, -.1), vector3_box(.4, 0, .4)),
            _common.emblem_right_models("receiver", -3, vector3_box(-.2, -6, -.1), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("receiver", 0, vector3_box(-.1, -6, -.1), vector3_box(.2, 0, 0)),
            _common_ranged.ogryn_bayonet_models({"", "", "", "", "", "receiver"}, -.5, vector3_box(.2, -2, 0), vector3_box(0, .4, 0)),
            functions.barrel_models(nil, -.5, vector3_box(.2, -2, 0), vector3_box(0, .6, 0)),
            functions.receiver_models(nil, 0, vector3_box(0, -1, 0), vector3_box(0, 0, -.00001)),
            functions.magazine_models(nil, 0, vector3_box(0, -3, .1), vector3_box(0, 0, -.2)),
            functions.handle_models(nil, -.75, vector3_box(-.2, -4, -.1), vector3_box(-.2, 0, 0)),
            _common.trinket_hook_models(nil, -.3, vector3_box(.15, -5, .1), vector3_box(0, 0, -.2))
        ),
        anchors = { -- Done 8.9.2023
            flashlight_01 =    {position = vector3_box(.09, .76, .35), rotation = vector3_box(0, 311, 0), scale = vector3_box(2, 2, 2)},
            flashlight_02 =    {position = vector3_box(.09, .76, .35), rotation = vector3_box(0, 311, 0), scale = vector3_box(2, 2, 2)},
            flashlight_03 =    {position = vector3_box(.09, .76, .35), rotation = vector3_box(0, 311, 0), scale = vector3_box(2, 2, 2)},
            flashlight_04 =    {position = vector3_box(.16, .76, .41), rotation = vector3_box(0, 128, 0), scale = vector3_box(2, 2, 2)},
            bayonet_blade_01 = {position = vector3_box(0, .45, 0.025), rotation = vector3_box(-90, 0, 0), scale = vector3_box(2, 2, 2)},
            fixes = {
                {dependencies = {"laser_pointer"}, -- Laser Pointer
                    flashlight = {position = vector3_box(.16, .76, .41), rotation = vector3_box(0, 128, 0), scale = vector3_box(2, 2, 2)}},
                {dependencies = {"receiver_02"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.145, .3, .27), rotation = vector3_box(0, 0, 180), scale = vector3_box(3, 3, 3)},
                    emblem_right = {offset = true, position = vector3_box(.145, .615, .27), rotation = vector3_box(0, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"receiver_03"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(.0047, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    emblem_right = {offset = true, position = vector3_box(.0047, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"receiver_06"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, 1.5, 1.5)},
                    emblem_right = {offset = true, position = vector3_box(.06, 0, .05), rotation = vector3_box(0, -20, 0), scale = vector3_box(2, 2, 2)}},
            }
        },
    }
)