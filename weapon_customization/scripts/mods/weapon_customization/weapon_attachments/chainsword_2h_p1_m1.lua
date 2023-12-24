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
            {id = "2h_chain_sword_grip_default", name = mod:localize("mod_attachment_default")},
            {id = "2h_chain_sword_grip_01",      name = "Grip 1"},
            {id = "2h_chain_sword_grip_02",      name = "Grip 2"},
            {id = "2h_chain_sword_grip_03",      name = "Grip 3"},
            {id = "2h_chain_sword_grip_04",      name = "Grip 4"},
        }
    end,
    grip_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            ["2h_chain_sword_grip_default"] = {model = "",                                           type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_chain_sword_grip_01"] =      {model = _item_melee.."/grips/2h_chain_sword_grip_01", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_chain_sword_grip_02"] =      {model = _item_melee.."/grips/2h_chain_sword_grip_02", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_chain_sword_grip_03"] =      {model = _item_melee.."/grips/2h_chain_sword_grip_03", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_chain_sword_grip_04"] =      {model = _item_melee.."/grips/2h_chain_sword_grip_04", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    body_attachments = function()
        return {
            {id = "2h_chain_sword_body_default", name = mod:localize("mod_attachment_default")},
            {id = "2h_chain_sword_body_01",      name = "Body 1"},
            {id = "2h_chain_sword_body_02",      name = "Body 2"},
            {id = "2h_chain_sword_body_03",      name = "Body 3"},
            {id = "2h_chain_sword_body_04",      name = "Body 4"},
        }
    end,
    body_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            ["2h_chain_sword_body_default"] = {model = "",                                          type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_chain_sword_body_01"] =      {model = _item_melee.."/full/2h_chain_sword_body_01", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_chain_sword_body_02"] =      {model = _item_melee.."/full/2h_chain_sword_body_02", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_chain_sword_body_03"] =      {model = _item_melee.."/full/2h_chain_sword_body_03", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_chain_sword_body_04"] =      {model = _item_melee.."/full/2h_chain_sword_body_04", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    chain_attachments = function()
        return {
            {id = "2h_chain_sword_chain_default", name = mod:localize("mod_attachment_default")},
            {id = "2h_chain_sword_chain_01",      name = "Chain 1"},
        }
    end,
    chain_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            ["2h_chain_sword_chain_default"] = {model = "",                                             type = "chain", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_chain_sword_chain_01"] =      {model = _item_melee.."/chains/2h_chain_sword_chain_01", type = "chain", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
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
            chain = functions.chain_attachments(),
        },
        models = table.combine(
            -- {customization_default_position = vector3_box(0, 3, .35)},
            _common.emblem_right_models("head", 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.emblem_left_models("head", -3, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            functions.chain_models(nil, 0, vector3_box(-.3, -3, .2), vector3_box(0, 0, 0)),
            functions.body_models(nil, 0, vector3_box(0, -5.5, -.4), vector3_box(0, 0, .2)),
            functions.grip_models(nil, 0, vector3_box(-.5, -4, .5), vector3_box(0, 0, -.2))
        ),
        anchors = {

        },
    }
)