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
            barrel_default = {model = "",                                                type = "barrel", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1), mesh_move = "both", no_support = {"trinket_hook_empty"}},
            barrel_01 =      {model = _item_ranged.."/barrels/gauntlet_basic_barrel_01", type = "barrel", parent = tv(parent, 2), angle = a, move = m, remove = tv(r, 2), mesh_move = "both", no_support = {"trinket_hook_empty"}},
            barrel_02 =      {model = _item_ranged.."/barrels/gauntlet_basic_barrel_02", type = "barrel", parent = tv(parent, 3), angle = a, move = m, remove = tv(r, 3), mesh_move = "both", no_support = {"trinket_hook_empty"}},
            barrel_03 =      {model = _item_ranged.."/barrels/gauntlet_basic_barrel_03", type = "barrel", parent = tv(parent, 4), angle = a, move = m, remove = tv(r, 4), mesh_move = "both", no_support = {"trinket_hook_empty"}},
            barrel_04 =      {model = _item_ranged.."/barrels/gauntlet_basic_barrel_04", type = "barrel", parent = tv(parent, 5), angle = a, move = m, remove = tv(r, 5), mesh_move = "both", no_support = {"trinket_hook_empty"}},
        }
    end,
    body_attachments = function()
        return {
            {id = "body_default", name = "Default"},
            {id = "body_01",      name = "Body 1"},
            {id = "body_02",      name = "Body 2"},
            {id = "body_03",      name = "Body 3"},
            {id = "body_04",      name = "Body 4"},
        }
    end,
    body_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            body_default = {model = "",                                                    type = "body", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1)},
            body_01 =      {model = _item_ranged.."/recievers/gauntlet_basic_receiver_01", type = "body", parent = tv(parent, 2), angle = a, move = m, remove = tv(r, 2)},
            body_02 =      {model = _item_ranged.."/recievers/gauntlet_basic_receiver_02", type = "body", parent = tv(parent, 3), angle = a, move = m, remove = tv(r, 3)},
            body_03 =      {model = _item_ranged.."/recievers/gauntlet_basic_receiver_03", type = "body", parent = tv(parent, 4), angle = a, move = m, remove = tv(r, 4)},
            body_04 =      {model = _item_ranged.."/recievers/gauntlet_basic_receiver_04", type = "body", parent = tv(parent, 5), angle = a, move = m, remove = tv(r, 5)},
        }
    end,
    magazine_attachments = function()
        return {
            {id = "magazine_default", name = "Default"},
            {id = "magazine_01",      name = "Magazine 1"},
            {id = "magazine_02",      name = "Magazine 2"},
        }
    end,
    magazine_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            magazine_default = {model = "",                                                    type = "magazine", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1)},
            magazine_01 =      {model = _item_ranged.."/magazines/gauntlet_basic_magazine_01", type = "magazine", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1)},
            magazine_02 =      {model = _item_ranged.."/magazines/gauntlet_basic_magazine_02", type = "magazine", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1)},
        }
    end
}

return table.combine(
    functions,
    {
        attachments = { -- Done 8.9.2023
            flashlight = _common_functions.flashlights_attachments(),
            emblem_right = _common_functions.emblem_right_attachments(),
            emblem_left = _common_functions.emblem_left_attachments(),
            bayonet = _common_functions.ogryn_bayonet_attachments(),
            barrel = functions.barrel_attachments(),
            body = functions.body_attachments(),
            magazine = functions.magazine_attachments(),
            trinket_hook = _common_functions.trinket_hook_attachments(),
        },
        models = table.combine( -- Done 8.9.2023
            _common_functions.flashlight_models("receiver", -2.25, vector3_box(0, -3, 0), vector3_box(.4, 0, 0)),
            _common_functions.emblem_right_models(nil, -3, vector3_box(0, -2, 0), vector3_box(.2, 0, 0)),
            _common_functions.emblem_left_models(nil, 0, vector3_box(0, -2, 0), vector3_box(.2, 0, 0)),
            _common_functions.ogryn_bayonet_models("barrel", -.5, vector3_box(.4, -2, 0), vector3_box(0, .4, 0)),
            functions.barrel_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 1.5, 0)),
            functions.body_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.00001)),
            functions.magazine_models(nil, 0, vector3_box(-.8, -4, 0), vector3_box(0, -.6, 0)),
            _common_functions.trinket_hook_models("barrel", -.3, vector3_box(.25, -5, .1), vector3_box(-.2, 0, 0))
        ),
        anchors = { -- Done 8.9.2023
            flashlight_01 =    {position = vector3_box(.2, .18, .11), rotation = vector3_box(0, 360, 0), scale = vector3_box(2, 2, 2)},
            flashlight_02 =    {position = vector3_box(.2, .18, .11), rotation = vector3_box(0, 360, 0), scale = vector3_box(2, 2, 2)},
            flashlight_03 =    {position = vector3_box(.2, .18, .11), rotation = vector3_box(0, 360, 0), scale = vector3_box(2, 2, 2)},
            flashlight_04 =    {position = vector3_box(.2, .18, .11), rotation = vector3_box(0, 360, 0), scale = vector3_box(2, 2, 2)},
            bayonet_blade_01 = {position = vector3_box(0, .4, -0.27), rotation = vector3_box(-90, 0, 0), scale = vector3_box(2, 2, 2)},
            bayonet_01 =       {position = vector3_box(0, .4, -0.27), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
            bayonet_02 =       {position = vector3_box(0, .4, -0.27), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
            bayonet_03 =       {position = vector3_box(0, .4, -0.27), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
            fixes = {
                {dependencies = {"laser_pointer"}, -- Laser Pointer
                    flashlight = {position = vector3_box(.2, .18, .11), rotation = vector3_box(0, 360, 0), scale = vector3_box(2, 2, 2)}},
                {dependencies = {"barrel_01"}, -- Trinket hook
                    trinket_hook = {parent = "barrel", position = vector3_box(-.19, .375, -.08), rotation = vector3_box(0, 90, 0), scale = vector3_box(2.5, 2.5, 2.5)}},
                {dependencies = {"barrel_02"}, -- Trinket hook
                    trinket_hook = {parent = "barrel", position = vector3_box(-.19, .375, -.04), rotation = vector3_box(0, 90, 0), scale = vector3_box(2.5, 2.5, 2.5)}},
                {dependencies = {"barrel_03"}, -- Trinket hook
                    trinket_hook = {parent = "barrel", position = vector3_box(-.19, .375, -.08), rotation = vector3_box(0, 90, 0), scale = vector3_box(2.5, 2.5, 2.5)}},
                {dependencies = {"barrel_04"}, -- Trinket hook
                    trinket_hook = {parent = "barrel", position = vector3_box(-.19, .375, -.08), rotation = vector3_box(0, 90, 0), scale = vector3_box(2.5, 2.5, 2.5)}},
                {dependencies = {"emblem_left_02"}, -- Emblem
                    emblem_left = {offset = true, position = vector3_box(.001, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, -1, 1)}},
                {emblem_left = {offset = true, position = vector3_box(.001, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}, -- Emblems
                    emblem_right = {offset = true, position = vector3_box(.001, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
            }
        },
    }
)