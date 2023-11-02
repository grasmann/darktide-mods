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
            {id = "receiver_02",        name = "Receiver 2"},
            {id = "receiver_03",        name = "Receiver 3"},
            {id = "receiver_04",        name = "Receiver 4"},
            {id = "receiver_05",        name = "Receiver 5"},
            -- {id = "receiver_04",        name = "Receiver 4"},
        }
    end,
    receiver_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            receiver_default = {model = "",                                                   type = "receiver", parent = tv(parent, 1), angle = a, move = m, remove = r},
            receiver_01 =      {model = _item_ranged.."/recievers/boltgun_rifle_receiver_01", type = "receiver", parent = tv(parent, 2), angle = a, move = m, remove = r},
            receiver_02 =      {model = _item_ranged.."/recievers/boltgun_rifle_receiver_02", type = "receiver", parent = tv(parent, 3), angle = a, move = m, remove = r},
            receiver_03 =      {model = _item_ranged.."/recievers/boltgun_rifle_receiver_03", type = "receiver", parent = tv(parent, 4), angle = a, move = m, remove = r},
            receiver_04 =      {model = _item_ranged.."/recievers/boltgun_rifle_receiver_04", type = "receiver", parent = tv(parent, 5), angle = a, move = m, remove = r},
            receiver_05 =      {model = _item_ranged.."/recievers/boltgun_rifle_receiver_05", type = "receiver", parent = tv(parent, 6), angle = a, move = m, remove = r},
            -- receiver_04 =      {model = _item_ranged.."/recievers/boltgun_pistol_receiver_01", type = "receiver", parent = tv(parent, 5), angle = a, move = m, remove = r},
        }
    end,
    magazine_attachments = function()
        return {
            {id = "bolter_magazine_01",        name = "Bolter Magazine A"},
            {id = "bolter_magazine_02",        name = "Bolter Magazine B"},
            -- {id = "bolter_magazine_03",        name = "Bolter Magazine C"},
        }
    end,
    magazine_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            magazine_default =   {model = "",                                                   type = "magazine", parent = tv(parent, 1), angle = a, move = m, remove = r},
            bolter_magazine_01 = {model = _item_ranged.."/magazines/boltgun_rifle_magazine_01", type = "magazine", parent = tv(parent, 2), angle = a, move = m, remove = r},
            bolter_magazine_02 = {model = _item_ranged.."/magazines/boltgun_rifle_magazine_02", type = "magazine", parent = tv(parent, 3), angle = a, move = m, remove = r},
            -- bolter_magazine_03 = {model = _item_ranged.."/magazines/boltgun_pistol_magazine_01", type = "magazine", parent = tv(parent, 4), angle = a, move = m, remove = r},
        }
    end,
    barrel_attachments = function()
        return {
            {id = "barrel_default",     name = mod:localize("mod_attachment_default")},
            {id = "bolter_barrel_01",   name = "Barrel 1"},
            {id = "bolter_barrel_02",   name = "Barrel 2"},
            -- {id = "bolter_barrel_02",   name = "Barrel 2"},
        }
    end,
    barrel_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            barrel_default =   {model = "",                                               type = "barrel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            bolter_barrel_01 = {model = _item_ranged.."/barrels/boltgun_rifle_barrel_01", type = "barrel", parent = tv(parent, 2), angle = a, move = m, remove = r, mesh_move = false},
            bolter_barrel_02 = {model = _item_ranged.."/barrels/boltgun_rifle_barrel_02", type = "barrel", parent = tv(parent, 3), angle = a, move = m, remove = r, mesh_move = false},
            -- bolter_barrel_02 = {model = _item_ranged.."/barrels/boltgun_pistol_barrel_01", type = "barrel", parent = tv(parent, 3), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    underbarrel_attachments = function()
        return {
            {id = "underbarrel_default",    name = mod:localize("mod_attachment_default")},
            {id = "underbarrel_01",         name = "Underbarrel 1"},
            {id = "underbarrel_02",         name = "Underbarrel 2"},
            {id = "underbarrel_03",         name = "Underbarrel 3"},
            -- {id = "no_underbarrel",         name = "No Underbarrel"},
        }
    end,
    underbarrel_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            underbarrel_default = {model = "",                                                         type = "underbarrel", parent = tv(parent, 1), angle = a, move = m, remove = r},
            underbarrel_01 =      {model = _item_ranged.."/underbarrels/boltgun_rifle_underbarrel_01", type = "underbarrel", parent = tv(parent, 2), angle = a, move = m, remove = r},
            underbarrel_02 =      {model = _item_ranged.."/underbarrels/boltgun_rifle_underbarrel_02", type = "underbarrel", parent = tv(parent, 3), angle = a, move = m, remove = r},
            underbarrel_03 =      {model = _item_ranged.."/underbarrels/boltgun_rifle_underbarrel_03", type = "underbarrel", parent = tv(parent, 4), angle = a, move = m, remove = r},
            -- no_underbarrel =      {model = "",                                                         type = "underbarrel", parent = tv(parent, 5), angle = a, move = m, remove = r},
        }
    end,
    sight_attachments = function()
        return {
            {id = "bolter_sight_01",       name = "Bolter Sight A"},
            {id = "bolter_sight_02",       name = "Bolter Sight B"},
            -- {id = "bolter_sight_03",       name = "Bolter Sight C"},
        }
    end,
    sight_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        local t = type or "sight"
        local n = no_support or {{"rail"}}
        local ae = automatic_equip or {
            {rail = "rail_default"},
        }
        local h = hide_mesh or {}
        return {
            sight_default =   {model = "",                                             type = t, parent = tv(parent, 1), angle = a, move = m, remove = r},
            bolter_sight_01 = {model = _item_ranged.."/sights/boltgun_rifle_sight_01", type = t, parent = tv(parent, 2), angle = a, move = m, remove = r, automatic_equip = tv(ae, 1), no_support = tv(n, 1)},
            bolter_sight_02 = {model = _item_ranged.."/sights/boltgun_rifle_sight_02", type = t, parent = tv(parent, 3), angle = a, move = m, remove = r, automatic_equip = tv(ae, 2), no_support = tv(n, 2)},
            -- bolter_sight_03 = {model = _item_ranged.."/sights/boltgun_pistol_sight_01", type = t, parent = tv(parent, 4), angle = a, move = m, remove = r, automatic_equip = tv(ae, 3), no_support = tv(n, 3)},
        }
    end,
}

return table.combine(
    functions,
    {
        attachments = { -- Done 13.9.2023
            flashlight = _common_ranged.flashlights_attachments(),
            receiver = functions.receiver_attachments(),
            trinket_hook = _common.trinket_hook_attachments(),
            -- slot_trinket_2 = _common.slot_trinket_2_attachments(),
            magazine = table.icombine(
                {{id = "magazine_default", name = mod:localize("mod_attachment_default")}},
                _common_ranged.magazine_attachments()
            ),
            barrel = functions.barrel_attachments(),
            underbarrel = functions.underbarrel_attachments(),
            grip = _common_ranged.grip_attachments(),
            sight = table.icombine(
                _common_ranged.sight_default(),
                functions.sight_attachments(),
                _common_ranged.reflex_sights_attachments()
            ),
            stock = _common_ranged.stock_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            rail = _common_lasgun.rail_attachments(),
            bayonet = _common_ranged.bayonet_attachments(),
            muzzle = table.icombine(
                _autopistol_p1_m1.muzzle_attachments(),
                _ogryn_rippergun_p1_m1.barrel_attachments()
            ),
        },
        models = table.combine( -- Done 13.9.2023
            _common_ranged.flashlight_models("receiver", -2.5, vector3_box(-.3, -3, 0), vector3_box(.2, 0, 0)),
            _common.emblem_right_models("receiver", -3, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("receiver", 0, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
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
            _common_ranged.reflex_sights_models("receiver", -.5, vector3_box(-.3, -4, -.2), vector3_box(0, -.2, 0), "sight", {}, {
                {rail = "rail_default"},
                {rail = "rail_01"},
                {rail = "rail_01"},
                {rail = "rail_01"},
            }),
            _common_ranged.stock_models("receiver", 0, vector3_box(-.6, -4, 0), vector3_box(0, -.2, 0)),
            functions.receiver_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.00001)),
            _common_ranged.magazine_models(nil, 0, vector3_box(-.2, -3, .1), vector3_box(0, 0, -.2)),
            functions.barrel_models(nil, -.5, vector3_box(.2, -2, 0), vector3_box(0, .2, 0)),
            functions.underbarrel_models(nil, -.5, vector3_box(0, -4, 0), vector3_box(0, 0, -.2)),
            functions.sight_models(nil, -.5, vector3_box(-.3, -4, -.2), vector3_box(0, -.2, 0)),
            _common_lasgun.rail_models("receiver", 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2)),
            _common_ranged.bayonet_models("barrel", -.5, vector3_box(.3, -4, 0), vector3_box(0, .4, 0)),
            _autopistol_p1_m1.muzzle_models("barrel", -.5, vector3_box(.2, -2, 0), vector3_box(0, .2, 0)),
            _common.trinket_hook_models("grip", -.2, vector3_box(-.1, -4, .2), vector3_box(0, 0, -.2)),
            -- _common.slot_trinket_2_models("trinket_hook", 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _ogryn_rippergun_p1_m1.barrel_models("receiver", -.5, vector3_box(.2, -2, 0), vector3_box(0, .3, 0), "muzzle")
        ),
        anchors = { -- Done 13.9.2023
            scope_offset = {position = vector3_box(0, 0, .022)},
            trinket_slot = "slot_trinket_2",
            fixes = {
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
                {rail = {parent = "receiver", position = vector3_box(0, .025, .125), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1.35, 1.3)}}, -- Rail
                {dependencies = {"autogun_bayonet_03"}, -- Bayonet
                    bayonet = {parent = "barrel", position = vector3_box(0, .125, -.04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {bayonet = {parent = "barrel", position = vector3_box(0, .2, -.045), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}}, -- Bayonet
                {dependencies = {"muzzle_02"}, -- Muzzle
                    muzzle = {parent = "barrel", position = vector3_box(0, .155, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.4, 1.4, 1.4)}},
                {dependencies = {"muzzle_04"}, -- Muzzle
                    muzzle = {parent = "barrel", position = vector3_box(0, .122, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.4, 1.4, 1.4)}},
                {dependencies = {"muzzle_05"}, -- Muzzle
                    muzzle = {parent = "barrel", position = vector3_box(0, .122, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.4, 1.4, 1.4)}},
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
                {muzzle = {position = vector3_box(0, .145, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.4, 1.4, 1.4)}},
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