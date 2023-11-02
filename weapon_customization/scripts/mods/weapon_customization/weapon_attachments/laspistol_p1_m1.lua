local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
local _common_ranged = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_ranged")
local _shotgun_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/shotgun_p1_m1")

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
            {id = "laspistol_receiver_default", name = mod:localize("mod_attachment_default")},
            {id = "laspistol_receiver_01",      name = "Laspistol Receiver 1"},
            {id = "laspistol_receiver_02",      name = "Laspistol Receiver 2"},
            {id = "laspistol_receiver_03",      name = "Laspistol Receiver 3"},
            -- {id = "laspistol_receiver_04",      name = "Laspistol Receiver 4"},
            {id = "laspistol_receiver_05",      name = "Laspistol Receiver 5"},
            {id = "laspistol_receiver_06",      name = "Laspistol Receiver 6"},
        }
    end,
    receiver_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            laspistol_receiver_default = {model = "",                                                   type = "receiver", parent = tv(parent, 1), angle = a, move = m, remove = r, trigger_move = {"magazine"}},
            laspistol_receiver_01 =      {model = _item_ranged.."/recievers/lasgun_pistol_receiver_01", type = "receiver", parent = tv(parent, 2), angle = a, move = m, remove = r, trigger_move = {"magazine"}},
            laspistol_receiver_02 =      {model = _item_ranged.."/recievers/lasgun_pistol_receiver_02", type = "receiver", parent = tv(parent, 3), angle = a, move = m, remove = r, trigger_move = {"magazine"}},
            laspistol_receiver_03 =      {model = _item_ranged.."/recievers/lasgun_pistol_receiver_03", type = "receiver", parent = tv(parent, 4), angle = a, move = m, remove = r, trigger_move = {"magazine"}},
            laspistol_receiver_04 =      {model = _item_ranged.."/recievers/lasgun_pistol_receiver_04", type = "receiver", parent = tv(parent, 5), angle = a, move = m, remove = r, trigger_move = {"magazine"}},
            laspistol_receiver_05 =      {model = _item_ranged.."/recievers/lasgun_pistol_receiver_05", type = "receiver", parent = tv(parent, 6), angle = a, move = m, remove = r, trigger_move = {"magazine"}},
            laspistol_receiver_06 =      {model = _item_ranged.."/recievers/lasgun_pistol_receiver_06", type = "receiver", parent = tv(parent, 7), angle = a, move = m, remove = r, trigger_move = {"magazine"}},
        }
    end,
    magazine_attachments = function()
        return {
            {id = "magazine_default",   name = mod:localize("mod_attachment_default")},
            {id = "magazine_01",        name = "Magazine 1"},
            -- {id = "magazine_02",        name = "Magazine 2"},
            -- {id = "magazine_03",        name = "Magazine 3"},
            -- {id = "magazine_04",        name = "Magazine 4"},
        }
    end,
    magazine_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            magazine_default = {model = "",                                                   type = "magazine", parent = tv(parent, 1), angle = a, move = m, remove = r},
            magazine_01 =      {model = _item_ranged.."/magazines/lasgun_pistol_magazine_01", type = "magazine", parent = tv(parent, 2), angle = a, move = m, remove = r},
            magazine_02 =      {model = _item_ranged.."/magazines/lasgun_pistol_magazine_02", type = "magazine", parent = tv(parent, 3), angle = a, move = m, remove = r},
            magazine_03 =      {model = _item_ranged.."/magazines/lasgun_pistol_magazine_03", type = "magazine", parent = tv(parent, 4), angle = a, move = m, remove = r},
            magazine_04 =      {model = _item_ranged.."/magazines/lasgun_pistol_magazine_04", type = "magazine", parent = tv(parent, 5), angle = a, move = m, remove = r},
        }
    end,
    barrel_attachments = function()
        return {
            {id = "barrel_default", name = mod:localize("mod_attachment_default")},
            {id = "barrel_01",      name = "Barrel 1"},
            {id = "barrel_02",      name = "Barrel 2"},
            {id = "barrel_03",      name = "Barrel 3"},
            {id = "barrel_04",      name = "Barrel 4"},
            {id = "barrel_05",      name = "Barrel 5"},
            {id = "barrel_06",      name = "Barrel 6"},
        }
    end,
    barrel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, special_resolve)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        local t = type or "barrel"
        local n = no_support or {}
        local ae = automatic_equip or {}
        local h = hide_mesh or {}
        return {
            barrel_default = {model = "",                                               type = t, parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 1), no_support = tv(n, 1), hide_mesh = tv(h, 1), special_resolve = special_resolve},
            barrel_01 =      {model = _item_ranged.."/barrels/lasgun_pistol_barrel_01", type = t, parent = tv(parent, 2), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 1), no_support = tv(n, 1), hide_mesh = tv(h, 1), special_resolve = special_resolve},
            barrel_02 =      {model = _item_ranged.."/barrels/lasgun_pistol_barrel_02", type = t, parent = tv(parent, 3), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 1), no_support = tv(n, 1), hide_mesh = tv(h, 1), special_resolve = special_resolve},
            barrel_03 =      {model = _item_ranged.."/barrels/lasgun_pistol_barrel_03", type = t, parent = tv(parent, 4), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 1), no_support = tv(n, 1), hide_mesh = tv(h, 1), special_resolve = special_resolve},
            barrel_04 =      {model = _item_ranged.."/barrels/lasgun_pistol_barrel_04", type = t, parent = tv(parent, 5), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 1), no_support = tv(n, 1), hide_mesh = tv(h, 1), special_resolve = special_resolve},
            barrel_05 =      {model = _item_ranged.."/barrels/lasgun_pistol_barrel_05", type = t, parent = tv(parent, 6), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 1), no_support = tv(n, 1), hide_mesh = tv(h, 1), special_resolve = special_resolve},
            barrel_06 =      {model = _item_ranged.."/barrels/lasgun_pistol_barrel_06", type = t, parent = tv(parent, 7), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 1), no_support = tv(n, 1), hide_mesh = tv(h, 1), special_resolve = special_resolve},
        }
    end,
    muzzle_attachments = function()
        return {
            {id = "muzzle_default", name = mod:localize("mod_attachment_default")},
            {id = "muzzle_01",      name = "Muzzle 1"},
            -- {id = "muzzle_02",      name = "Muzzle 2"}, -- buggy
            {id = "muzzle_03",      name = "Muzzle 3"},
            {id = "muzzle_04",      name = "Muzzle 4"},
            {id = "muzzle_05",      name = "Muzzle 5"},
        }
    end,
    muzzle_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            muzzle_default = {model = "",                                               type = "muzzle", parent = tv(parent, 1), angle = a, move = m, remove = r},
            muzzle_01 =      {model = _item_ranged.."/muzzles/lasgun_pistol_muzzle_01", type = "muzzle", parent = tv(parent, 2), angle = a, move = m, remove = r},
            muzzle_03 =      {model = _item_ranged.."/muzzles/lasgun_pistol_muzzle_03", type = "muzzle", parent = tv(parent, 3), angle = a, move = m, remove = r},
            muzzle_04 =      {model = _item_ranged.."/muzzles/lasgun_pistol_muzzle_04", type = "muzzle", parent = tv(parent, 4), angle = a, move = m, remove = r},
            -- muzzle_02 =      {model = _item_ranged.."/muzzles/lasgun_pistol_muzzle_02", type = "muzzle", parent = tv(parent, 5), angle = a, move = m, remove = r}, -- buggy
            muzzle_05 =      {model = _item_ranged.."/muzzles/lasgun_pistol_muzzle_05", type = "muzzle", parent = tv(parent, 6), angle = a, move = m, remove = r},
        }
    end,
    rail_attachments = function()
        return {
            {id = "rail_default",   name = mod:localize("mod_attachment_default")},
            {id = "rail_01",        name = "Rail 1"},
        }
    end,
    rail_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            rail_default = {model = "",                                           type = "rail", parent = tv(parent, 1), angle = a, move = m, remove = r},
            rail_01 =      {model = _item_ranged.."/rails/lasgun_pistol_rail_01", type = "rail", parent = tv(parent, 2), angle = a, move = m, remove = r},
        }
    end,
    stock_attachments = function()
        return {
            {id = "lasgun_pistol_stock_default",    name = mod:localize("mod_attachment_default")},
            {id = "lasgun_pistol_stock_01",         name = "Ventilation 1"},
            {id = "lasgun_pistol_stock_02",         name = "Ventilation 2"},
            {id = "lasgun_pistol_stock_03",         name = "Ventilation 3"},
        }
    end,
    stock_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            lasgun_pistol_stock_default = {model = "",                                             type = "stock", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            lasgun_pistol_stock_01 =      {model = _item_ranged.."/stocks/lasgun_pistol_stock_01", type = "stock", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            lasgun_pistol_stock_02 =      {model = _item_ranged.."/stocks/lasgun_pistol_stock_02", type = "stock", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            lasgun_pistol_stock_03 =      {model = _item_ranged.."/stocks/lasgun_pistol_stock_03", type = "stock", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
}

return table.combine(
    functions,
    {
        attachments = { -- Done 22.9.2023
            flashlight = _common_ranged.flashlights_attachments(),
            receiver = functions.receiver_attachments(),
            bayonet = _common_ranged.bayonet_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            trinket_hook = _common.trinket_hook_attachments(),
            slot_trinket_1 = _common.slot_trinket_1_attachments(),
            grip = _common_ranged.grip_attachments(),
            sight = table.icombine(
                _common_ranged.sight_default(),
                {{id = "sight_none",    name = "No Sight"}},
                _common_ranged.reflex_sights_attachments()
            ),
            magazine = functions.magazine_attachments(),
            barrel = functions.barrel_attachments(),
            muzzle = functions.muzzle_attachments(),
            rail = functions.rail_attachments(),
            stock = functions.stock_attachments(),
            stock_3 = _shotgun_p1_m1.stock_attachments(),
        },
        models = table.combine( -- Done 22.9.2023
            _common_ranged.flashlight_models("receiver", -2.5, vector3_box(0, -3, 0), vector3_box(.2, 0, 0)),
            _common.emblem_right_models("receiver", -3, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("receiver", 0, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common_ranged.bayonet_models({"barrel", "barrel", "barrel", "muzzle"}, -.5, vector3_box(.1, -4, 0), vector3_box(0, .4, -.025)),
            _common.trinket_hook_models("grip", -.2, vector3_box(.1, -4, .2), vector3_box(0, 0, -.2)),
            _common.slot_trinket_1_models("trinket_hook", 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
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
                {rail = "rail_default"},
                {rail = "rail_01"},
                {rail = "rail_01"},
                {rail = "rail_01"},
            }),
            functions.receiver_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.00001)),
            functions.magazine_models("receiver", 0, vector3_box(-.2, -3, .1), vector3_box(0, 0, -.2)),
            functions.barrel_models(nil, -.5, vector3_box(.2, -2, 0), vector3_box(0, .2, 0), nil, {}, {
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
            _shotgun_p1_m1.stock_models("grip", 0, vector3_box(-.6, -4, .2), vector3_box(0, -.4, -.11), "stock_3")
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
                {stock_3 = {parent = "body", position = vector3_box(0, -.0225, -.0125), rotation = vector3_box(15, 0, 0), scale = vector3_box(.6, 1.2, 1)}}, -- Stocks
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