local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
local _common_melee = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_melee")

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
    grip_attachments = function()
        return {
            {id = "chain_axe_grip_default", name = mod:localize("mod_attachment_default")},
            {id = "chain_axe_grip_01",      name = "Grip 1"},
            {id = "chain_axe_grip_02",      name = "Grip 2"},
            {id = "chain_axe_grip_03",      name = "Grip 3"},
            {id = "chain_axe_grip_04",      name = "Grip 4"},
            {id = "chain_axe_grip_05",      name = "Grip 5"},
        }
    end,
    grip_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            chain_axe_grip_default = {model = "",                                      type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_axe_grip_01 =      {model = _item_melee.."/grips/chain_axe_grip_01", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_axe_grip_02 =      {model = _item_melee.."/grips/chain_axe_grip_02", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_axe_grip_03 =      {model = _item_melee.."/grips/chain_axe_grip_03", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_axe_grip_04 =      {model = _item_melee.."/grips/chain_axe_grip_04", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_axe_grip_05 =      {model = _item_melee.."/grips/chain_axe_grip_05", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    shaft_attachments = function()
        return {
            {id = "chain_axe_shaft_default", name = mod:localize("mod_attachment_default")},
            {id = "chain_axe_shaft_01",      name = "Shaft 1"},
            {id = "chain_axe_shaft_02",      name = "Shaft 2"},
            {id = "chain_axe_shaft_03",      name = "Shaft 3"},
            {id = "chain_axe_shaft_04",      name = "Shaft 4"},
            {id = "chain_axe_shaft_05",      name = "Shaft 5"},
        }
    end,
    shaft_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            chain_axe_shaft_default = {model = "",                                         type = "shaft", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_axe_shaft_01 =      {model = _item_ranged.."/shafts/chain_axe_shaft_01", type = "shaft", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_axe_shaft_02 =      {model = _item_ranged.."/shafts/chain_axe_shaft_02", type = "shaft", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_axe_shaft_03 =      {model = _item_ranged.."/shafts/chain_axe_shaft_03", type = "shaft", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_axe_shaft_04 =      {model = _item_ranged.."/shafts/chain_axe_shaft_04", type = "shaft", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_axe_shaft_05 =      {model = _item_ranged.."/shafts/chain_axe_shaft_05", type = "shaft", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    blade_attachments = function()
        return {
            {id = "chain_axe_blade_default", name = mod:localize("mod_attachment_default")},
            {id = "chain_axe_blade_01",      name = "Blade 1"},
            {id = "chain_axe_blade_02",      name = "Blade 2"},
            {id = "chain_axe_blade_03",      name = "Blade 3"},
            {id = "chain_axe_blade_04",      name = "Blade 4"},
            {id = "chain_axe_blade_05",      name = "Blade 5"},
        }
    end,
    blade_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            chain_axe_blade_default = {model = "",                                        type = "blade", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_axe_blade_01 =      {model = _item_melee.."/blades/chain_axe_blade_01", type = "blade", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_axe_blade_02 =      {model = _item_melee.."/blades/chain_axe_blade_02", type = "blade", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_axe_blade_03 =      {model = _item_melee.."/blades/chain_axe_blade_03", type = "blade", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_axe_blade_04 =      {model = _item_melee.."/blades/chain_axe_blade_04", type = "blade", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_axe_blade_05 =      {model = _item_melee.."/blades/chain_axe_blade_05", type = "blade", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    teeth_attachments = function()
        return {
            {id = "chain_axe_teeth_default", name = mod:localize("mod_attachment_default")},
            {id = "chain_axe_teeth_01",      name = "Chain 1"},
        }
    end,
    teeth_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            chain_axe_teeth_default = {model = "",                                        type = "teeth", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_axe_teeth_01 =      {model = _item_melee.."/chains/chain_axe_chain_01", type = "teeth", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
}

return table.combine(
    functions,
    {
        attachments = {
            trinket_hook = _common.trinket_hook_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            grip = functions.grip_attachments(),
            shaft = functions.shaft_attachments(),
            blade = functions.blade_attachments(),
            teeth = functions.teeth_attachments(),
        },
        models = table.combine(
            _common.emblem_right_models("head", 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.emblem_left_models("head", -3, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            functions.shaft_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            functions.blade_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2)),
            functions.grip_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.2)),
            functions.teeth_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0))
        ),
        anchors = {
            
        }
    }
)