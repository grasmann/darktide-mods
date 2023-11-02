local mod = get_mod("weapon_customization")

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

return {
    barrel_attachments = function()
        return {
            {id = "barrel_default", name = mod:localize("mod_attachment_default")},
            {id = "barrel_01", name = "Infantry Lasgun 1"},
            {id = "barrel_02", name = "Infantry Lasgun 2"},
            {id = "barrel_03", name = "Infantry Lasgun 3"},
            {id = "barrel_04", name = "Infantry Lasgun 4"},
            {id = "barrel_05", name = "Infantry Lasgun 5"},
            {id = "barrel_06", name = "Infantry Lasgun 6"},
            {id = "barrel_07", name = "Infantry Lasgun 7"},
            {id = "barrel_08", name = "Infantry Lasgun 8"},
            {id = "barrel_09", name = "Helbore Lasgun 1"},
            {id = "barrel_10", name = "Helbore Lasgun 2"},
            {id = "barrel_11", name = "Helbore Lasgun 3"},
            {id = "barrel_12", name = "Helbore Lasgun 4"},
            {id = "barrel_13", name = "Helbore Lasgun 5"},
            {id = "barrel_14", name = "Recon Lasgun 1"},
            {id = "barrel_15", name = "Recon Lasgun 2"},
            {id = "barrel_16", name = "Recon Lasgun 3"},
            {id = "barrel_17", name = "Recon Lasgun 4"},
            {id = "barrel_18", name = "Recon Lasgun 5"},
        }
    end,
    barrel_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            barrel_default = {model = "",                                                      type = "barrel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            barrel_01 =      {model = _item_ranged.."/barrels/lasgun_rifle_barrel_01",         type = "barrel", parent = tv(parent, 2), angle = a, move = m, remove = r, mesh_move = false},
            barrel_02 =      {model = _item_ranged.."/barrels/lasgun_rifle_barrel_02",         type = "barrel", parent = tv(parent, 3), angle = a, move = m, remove = r, mesh_move = false},
            barrel_03 =      {model = _item_ranged.."/barrels/lasgun_rifle_barrel_03",         type = "barrel", parent = tv(parent, 4), angle = a, move = m, remove = r, mesh_move = false},
            barrel_04 =      {model = _item_ranged.."/barrels/lasgun_rifle_barrel_04",         type = "barrel", parent = tv(parent, 5), angle = a, move = m, remove = r, mesh_move = false},
            barrel_05 =      {model = _item_ranged.."/barrels/lasgun_rifle_barrel_05",         type = "barrel", parent = tv(parent, 6), angle = a, move = m, remove = r, mesh_move = false},
            barrel_06 =      {model = _item_ranged.."/barrels/lasgun_rifle_barrel_06",         type = "barrel", parent = tv(parent, 7), angle = a, move = m, remove = r, mesh_move = false},
            barrel_07 =      {model = _item_ranged.."/barrels/lasgun_rifle_barrel_07",         type = "barrel", parent = tv(parent, 8), angle = a, move = m, remove = r, mesh_move = false},
            barrel_08 =      {model = _item_ranged.."/barrels/lasgun_rifle_barrel_08",         type = "barrel", parent = tv(parent, 9), angle = a, move = m, remove = r, mesh_move = false},
            barrel_09 =      {model = _item_ranged.."/barrels/lasgun_rifle_krieg_barrel_01",   type = "barrel", parent = tv(parent, 10), angle = a, move = m, remove = r, mesh_move = false},
            barrel_10 =      {model = _item_ranged.."/barrels/lasgun_rifle_krieg_barrel_02",   type = "barrel", parent = tv(parent, 11), angle = a, move = m, remove = r, mesh_move = false},
            barrel_11 =      {model = _item_ranged.."/barrels/lasgun_rifle_krieg_barrel_04",   type = "barrel", parent = tv(parent, 12), angle = a, move = m, remove = r, mesh_move = false},
            barrel_12 =      {model = _item_ranged.."/barrels/lasgun_rifle_krieg_barrel_05",   type = "barrel", parent = tv(parent, 13), angle = a, move = m, remove = r, mesh_move = false},
            barrel_13 =      {model = _item_ranged.."/barrels/lasgun_rifle_krieg_barrel_06",   type = "barrel", parent = tv(parent, 14), angle = a, move = m, remove = r, mesh_move = false},
            barrel_14 =      {model = _item_ranged.."/barrels/lasgun_rifle_elysian_barrel_01", type = "barrel", parent = tv(parent, 15), angle = a, move = m, remove = r, mesh_move = false},
            barrel_15 =      {model = _item_ranged.."/barrels/lasgun_rifle_elysian_barrel_02", type = "barrel", parent = tv(parent, 16), angle = a, move = m, remove = r, mesh_move = false},
            barrel_16 =      {model = _item_ranged.."/barrels/lasgun_rifle_elysian_barrel_03", type = "barrel", parent = tv(parent, 17), angle = a, move = m, remove = r, mesh_move = false},
            barrel_17 =      {model = _item_ranged.."/barrels/lasgun_rifle_elysian_barrel_04", type = "barrel", parent = tv(parent, 18), angle = a, move = m, remove = r, mesh_move = false},
            barrel_18 =      {model = _item_ranged.."/barrels/lasgun_rifle_elysian_barrel_05", type = "barrel", parent = tv(parent, 19), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    muzzle_attachments = function()
        return {
            {id = "muzzle_default", name = mod:localize("mod_attachment_default")},
            {id = "muzzle_01", name = "Infantry Lasgun 1"},
            {id = "muzzle_02", name = "Infantry Lasgun 2"},
            {id = "muzzle_03", name = "Infantry Lasgun 3"},
            {id = "muzzle_04", name = "Helbore Lasgun 1"},
            {id = "muzzle_05", name = "Helbore Lasgun 2"},
            {id = "muzzle_06", name = "Helbore Lasgun 3"},
            {id = "muzzle_07", name = "Recon Lasgun 1"},
            {id = "muzzle_08", name = "Recon Lasgun 2"},
            {id = "muzzle_09", name = "Recon Lasgun 3"},
        }
    end,
    muzzle_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            muzzle_default = {model = "",                                                      type = "muzzle", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            muzzle_01 =      {model = _item_ranged.."/muzzles/lasgun_rifle_muzzle_01",         type = "muzzle", parent = tv(parent, 2), angle = a, move = m, remove = r, mesh_move = false},
            muzzle_02 =      {model = _item_ranged.."/muzzles/lasgun_rifle_muzzle_02",         type = "muzzle", parent = tv(parent, 3), angle = a, move = m, remove = r, mesh_move = false},
            muzzle_03 =      {model = _item_ranged.."/muzzles/lasgun_rifle_muzzle_03",         type = "muzzle", parent = tv(parent, 4), angle = a, move = m, remove = r, mesh_move = false},
            muzzle_04 =      {model = _item_ranged.."/muzzles/lasgun_rifle_krieg_muzzle_02",   type = "muzzle", parent = tv(parent, 5), angle = a, move = m, remove = r, mesh_move = false},
            muzzle_05 =      {model = _item_ranged.."/muzzles/lasgun_rifle_krieg_muzzle_04",   type = "muzzle", parent = tv(parent, 6), angle = a, move = m, remove = r, mesh_move = false},
            muzzle_06 =      {model = _item_ranged.."/muzzles/lasgun_rifle_krieg_muzzle_05",   type = "muzzle", parent = tv(parent, 7), angle = a, move = m, remove = r, mesh_move = false},
            muzzle_07 =      {model = _item_ranged.."/muzzles/lasgun_rifle_elysian_muzzle_01", type = "muzzle", parent = tv(parent, 8), angle = a, move = m, remove = r, mesh_move = false},
            muzzle_08 =      {model = _item_ranged.."/muzzles/lasgun_rifle_elysian_muzzle_02", type = "muzzle", parent = tv(parent, 9), angle = a, move = m, remove = r, mesh_move = false},
            muzzle_09 =      {model = _item_ranged.."/muzzles/lasgun_rifle_elysian_muzzle_03", type = "muzzle", parent = tv(parent, 10), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    rail_attachments = function()
        return {
            {id = "rail_default",   name = mod:localize("mod_attachment_default")},
            {id = "rail_01",        name = "Rail 1"},
        }
    end,
    rail_models = function(parent, angle, move, remove, type)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        local t = type or "rail"
        return {
            rail_default = {model = "",                                          type = t, parent = tv(parent, 1), angle = a, move = m, remove = r},
            rail_01 =      {model = _item_ranged.."/rails/lasgun_rifle_rail_01", type = t, parent = tv(parent, 2), angle = a, move = m, remove = r},
        }
    end,
    magazine_attachments = function()
        return {
            {id = "magazine_default",   name = mod:localize("mod_attachment_default")},
            {id = "magazine_01",        name = "Magazine 1"},
        }
    end,
    magazine_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            magazine_default = {model = "",                                                  type = "magazine", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            magazine_01 =      {model = _item_ranged.."/magazines/lasgun_rifle_magazine_01", type = "magazine", parent = tv(parent, 2), angle = a, move = m, remove = r, mesh_move = false},
        }
    end
}