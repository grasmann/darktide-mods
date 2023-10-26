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
        }
    end,
    barrel_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            barrel_default = {model = "",                                                     type = "barrel", parent = tv(parent, 1), angle = a, move = m, remove = r},
            barrel_01 =      {model = _item_ranged.."/barrels/stubgun_heavy_ogryn_barrel_01", type = "barrel", parent = tv(parent, 2), angle = a, move = m, remove = r},
            barrel_02 =      {model = _item_ranged.."/barrels/stubgun_heavy_ogryn_barrel_02", type = "barrel", parent = tv(parent, 3), angle = a, move = m, remove = r},
            barrel_03 =      {model = _item_ranged.."/barrels/stubgun_heavy_ogryn_barrel_03", type = "barrel", parent = tv(parent, 4), angle = a, move = m, remove = r},
        }
    end,
    receiver_attachments = function()
        return {
            {id = "receiver_default",   name = "Default"},
            {id = "receiver_01",        name = "Receiver 1"},
            {id = "receiver_02",        name = "Receiver 2"},
            {id = "receiver_03",        name = "Receiver 3"},
        }
    end,
    receiver_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            receiver_default = {model = "",                                                         type = "receiver", parent = tv(parent, 1), angle = a, move = m, remove = r},
            receiver_01 =      {model = _item_ranged.."/recievers/stubgun_heavy_ogryn_receiver_01", type = "receiver", parent = tv(parent, 2), angle = a, move = m, remove = r},
            receiver_02 =      {model = _item_ranged.."/recievers/stubgun_heavy_ogryn_receiver_02", type = "receiver", parent = tv(parent, 3), angle = a, move = m, remove = r},
            receiver_03 =      {model = _item_ranged.."/recievers/stubgun_heavy_ogryn_receiver_03", type = "receiver", parent = tv(parent, 4), angle = a, move = m, remove = r},
        }
    end,
    magazine_attachments = function()
        return {
            {id = "magazine_default",   name = "Default"},
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
            magazine_default = {model = "",                                                         type = "magazine", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            magazine_01 =      {model = _item_ranged.."/magazines/stubgun_heavy_ogryn_magazine_01", type = "magazine", parent = tv(parent, 2), angle = a, move = m, remove = r, mesh_move = false},
            magazine_02 =      {model = _item_ranged.."/magazines/stubgun_heavy_ogryn_magazine_02", type = "magazine", parent = tv(parent, 3), angle = a, move = m, remove = r, mesh_move = false},
            magazine_03 =      {model = _item_ranged.."/magazines/stubgun_heavy_ogryn_magazine_03", type = "magazine", parent = tv(parent, 4), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    grip_attachments = function()
        return {
            {id = "grip_default",   name = "Default"},
            {id = "grip_01",        name = "Grip 1"},
            {id = "grip_02",        name = "Grip 2"},
            {id = "grip_03",        name = "Grip 3"},
        }
    end,
    grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        local t = type or "grip"
        local ae = automatic_equip or {}
        local n = no_support or {}
        return {
            grip_default = {model = "",                                                 type = t, parent = tv(parent, 1), angle = a, move = m, remove = r, automatic_equip = tv(ae, 1), no_support = tv(n, 1), mesh_move = false},
            grip_01 =      {model = _item_ranged.."/grips/stubgun_heavy_ogryn_grip_01", type = t, parent = tv(parent, 2), angle = a, move = m, remove = r, automatic_equip = tv(ae, 2), no_support = tv(n, 2), mesh_move = false},
            grip_02 =      {model = _item_ranged.."/grips/stubgun_heavy_ogryn_grip_02", type = t, parent = tv(parent, 3), angle = a, move = m, remove = r, automatic_equip = tv(ae, 3), no_support = tv(n, 3), mesh_move = false},
            grip_03 =      {model = _item_ranged.."/grips/stubgun_heavy_ogryn_grip_03", type = t, parent = tv(parent, 4), angle = a, move = m, remove = r, automatic_equip = tv(ae, 4), no_support = tv(n, 4), mesh_move = false},
        }
    end,
}

return table.combine(
    functions,
    {
        attachments = { -- Done 5.9.2023
            flashlight = _common_functions.flashlights_attachments(),
            bayonet = _common_functions.ogryn_bayonet_attachments(),
            barrel = functions.barrel_attachments(),
            receiver = functions.receiver_attachments(),
            magazine = functions.magazine_attachments(),
            grip = functions.grip_attachments(),
            emblem_right = _common_functions.emblem_right_attachments(),
            emblem_left = _common_functions.emblem_left_attachments(),
            trinket_hook = _common_functions.trinket_hook_attachments(),
        },
        models = table.combine( -- Done 5.9.2023
            -- {customization_default_position = vector3_box(.2, -1, .075)},
            _common_functions.flashlight_models("receiver", -2.25, vector3_box(0, -3, -.2), vector3_box(.4, 0, .4)),
            _common_functions.emblem_right_models("receiver", -3, vector3_box(.1, -6, -.1), vector3_box(.2, 0, 0)),
            _common_functions.emblem_left_models("receiver", 0, vector3_box(-.3, -6, -.1), vector3_box(-.2, 0, 0)),
            _common_functions.ogryn_bayonet_models("receiver", -.5, vector3_box(.4, -2, 0), vector3_box(0, .4, 0)),
            functions.barrel_models("receiver", -.25, vector3_box(.35, -3, 0), vector3_box(0, .2, 0)),
            functions.receiver_models(nil, 0, vector3_box(0, -1, 0), vector3_box(0, 0, -.00001)),
            functions.magazine_models("receiver", 0, vector3_box(0, -3, .1), vector3_box(0, 0, -.2)),
            functions.grip_models("receiver", .3, vector3_box(-.4, -3, 0), vector3_box(0, -.2, 0), "grip", {
                {},
                {"trinket_hook"},
                {"trinket_hook"},
                {"trinket_hook_empty"},
            }, {
                {trinket_hook = "!trinket_hook_default|trinket_hook_default"},
                {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"},
                {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01"},
            }),
            _common_functions.trinket_hook_models("grip", .3, vector3_box(-.6, -5, .1), vector3_box(0, -.1, -.1))
        ),
        anchors = { -- Done 5.9.2023
            flashlight_01 =    {position = vector3_box(.09, .9, .13), rotation = vector3_box(0, 311, 0), scale = vector3_box(2, 2, 2)},
            flashlight_02 =    {position = vector3_box(.09, .9, .13), rotation = vector3_box(0, 311, 0), scale = vector3_box(2, 2, 2)},
            flashlight_03 =    {position = vector3_box(.09, .9, .13), rotation = vector3_box(0, 311, 0), scale = vector3_box(2, 2, 2)},
            flashlight_04 =    {position = vector3_box(.15, .86, .21), rotation = vector3_box(0, 128, 0), scale = vector3_box(2, 2, 2)},
            bayonet_blade_01 = {position = vector3_box(0, 1.04, -0.39), rotation = vector3_box(-90, 0, 0), scale = vector3_box(2, 2, 2)},
            bayonet_01 =       {position = vector3_box(0, 1.08, -0.36), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
            bayonet_02 =       {position = vector3_box(0, 1.08, -0.36), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
            bayonet_03 =       {position = vector3_box(0, 1.08, -0.36), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
            fixes = {
                {dependencies = {"laser_pointer"}, -- Laser Pointer
                    flashlight = {position = vector3_box(.15, .86, .21), rotation = vector3_box(0, 128, 0), scale = vector3_box(2, 2, 2)}},
                {dependencies = {"emblem_left_02"}, -- Emblem
                    emblem_left = {offset = true, position = vector3_box(-.09, .42, .085), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, -2, 2)}},
                {emblem_left = {offset = true, position = vector3_box(-.09, .42, .085), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, 2, 2)}}, -- Emblem left
            }
        },
    }
)