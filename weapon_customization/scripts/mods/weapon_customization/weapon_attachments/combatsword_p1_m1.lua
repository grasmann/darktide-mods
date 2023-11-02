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
            {id = "combat_sword_grip_default", name = mod:localize("mod_attachment_default")},
            {id = "combat_sword_grip_01",      name = "Grip 1"},
            {id = "combat_sword_grip_02",      name = "Grip 2"},
            {id = "combat_sword_grip_03",      name = "Grip 3"},
            {id = "combat_sword_grip_04",      name = "Grip 4"},
            {id = "combat_sword_grip_05",      name = "Grip 5"},
            {id = "combat_sword_grip_06",      name = "Grip 6"},
        }
    end,
    grip_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            combat_sword_grip_default = {model = "",                                         type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            combat_sword_grip_01 =      {model = _item_melee.."/grips/combat_sword_grip_01", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            combat_sword_grip_02 =      {model = _item_melee.."/grips/combat_sword_grip_02", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            combat_sword_grip_03 =      {model = _item_melee.."/grips/combat_sword_grip_03", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            combat_sword_grip_04 =      {model = _item_melee.."/grips/combat_sword_grip_04", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            combat_sword_grip_05 =      {model = _item_melee.."/grips/combat_sword_grip_05", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            combat_sword_grip_06 =      {model = _item_melee.."/grips/combat_sword_grip_06", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    body_attachments = function()
        return {
            {id = "combat_sword_blade_default", name = mod:localize("mod_attachment_default")},
            {id = "combat_sword_blade_01",      name = "Blade 1"},
            {id = "combat_sword_blade_02",      name = "Blade 2"},
            {id = "combat_sword_blade_03",      name = "Blade 3"},
            {id = "combat_sword_blade_04",      name = "Blade 4"},
            {id = "combat_sword_blade_05",      name = "Blade 5"},
            {id = "combat_sword_blade_06",      name = "Blade 6"},
            {id = "combat_sword_blade_07",      name = "Blade 7"},
        }
    end,
    body_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            combat_sword_blade_default = {model = "", type = "body"},
            combat_sword_blade_01 =      {model = _item_melee.."/blades/combat_sword_blade_01", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            combat_sword_blade_02 =      {model = _item_melee.."/blades/combat_sword_blade_02", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            combat_sword_blade_03 =      {model = _item_melee.."/blades/combat_sword_blade_03", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            combat_sword_blade_04 =      {model = _item_melee.."/blades/combat_sword_blade_04", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            combat_sword_blade_05 =      {model = _item_melee.."/blades/combat_sword_blade_05", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            combat_sword_blade_06 =      {model = _item_melee.."/blades/combat_sword_blade_06", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            combat_sword_blade_07 =      {model = _item_melee.."/blades/combat_sword_blade_07", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
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
            body = functions.body_attachments(),
        },
        models = table.combine(
            _common.emblem_right_models("head", 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.emblem_left_models("head", -3, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            functions.body_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2)),
            functions.grip_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.2))
        ),
        anchors = {

        },
    }
)