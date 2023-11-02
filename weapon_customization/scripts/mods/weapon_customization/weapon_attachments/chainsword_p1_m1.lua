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
            {id = "chain_sword_grip_default", name = mod:localize("mod_attachment_default")},
            {id = "chain_sword_grip_01",      name = "Grip 1"},
            {id = "chain_sword_grip_02",      name = "Grip 2"},
            {id = "chain_sword_grip_03",      name = "Grip 3"},
            {id = "chain_sword_grip_04",      name = "Grip 4"},
            {id = "chain_sword_grip_05",      name = "Grip 5"},
            {id = "chain_sword_grip_06",      name = "Grip 6"},
            {id = "chain_sword_grip_07",      name = "Grip 7"},
            {id = "chain_sword_grip_08",      name = "Grip 8"},
        }
    end,
    grip_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            chain_sword_grip_default = {model = "",                                        type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_sword_grip_01 =      {model = _item_melee.."/grips/chain_sword_grip_01", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_sword_grip_02 =      {model = _item_melee.."/grips/chain_sword_grip_02", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_sword_grip_03 =      {model = _item_melee.."/grips/chain_sword_grip_03", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_sword_grip_04 =      {model = _item_melee.."/grips/chain_sword_grip_04", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_sword_grip_05 =      {model = _item_melee.."/grips/chain_sword_grip_05", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_sword_grip_06 =      {model = _item_melee.."/grips/chain_sword_grip_06", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_sword_grip_07 =      {model = _item_melee.."/grips/chain_sword_grip_07", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_sword_grip_08 =      {model = _item_melee.."/grips/chain_sword_grip_08", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    body_attachments = function()
        return {
            {id = "chain_sword_body_default", name = mod:localize("mod_attachment_default")},
            {id = "chain_sword_body_01",      name = "Body 1"},
            {id = "chain_sword_body_02",      name = "Body 2"},
            {id = "chain_sword_body_03",      name = "Body 3"},
            {id = "chain_sword_body_04",      name = "Body 4"}, --buggy
            {id = "chain_sword_body_05",      name = "Body 5"}, --buggy
            {id = "chain_sword_body_06",      name = "Body 6"},
            {id = "chain_sword_body_07",      name = "Body 7"},
            {id = "chain_sword_body_08",      name = "Body 8"},
            {id = "chain_sword_body_09",      name = "Body 9"},
        }
    end,
    body_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            chain_sword_body_default = {model = "",                                       type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_sword_body_01 =      {model = _item_melee.."/full/chain_sword_full_01", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_sword_body_02 =      {model = _item_melee.."/full/chain_sword_full_02", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_sword_body_03 =      {model = _item_melee.."/full/chain_sword_full_03", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_sword_body_04 =      {model = _item_melee.."/full/chain_sword_full_04", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false}, --buggy
            chain_sword_body_05 =      {model = _item_melee.."/full/chain_sword_full_05", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false}, --buggy
            chain_sword_body_06 =      {model = _item_melee.."/full/chain_sword_full_06", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_sword_body_07 =      {model = _item_melee.."/full/chain_sword_full_07", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_sword_body_08 =      {model = _item_melee.."/full/chain_sword_full_08", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_sword_body_09 =      {model = _item_melee.."/full/chain_sword_full_09", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    chain_attachments = function()
        return {
            {id = "chain_sword_chain_default", name = mod:localize("mod_attachment_default")},
            {id = "chain_sword_chain_01",      name = "Chain 1"},
        }
    end,
    chain_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            chain_sword_chain_default = {model = "",                                          type = "chain", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            chain_sword_chain_01 =      {model = _item_melee.."/chains/chain_sword_chain_01", type = "chain", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
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
            _common.emblem_right_models("head", 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.emblem_left_models("head", -3, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            functions.chain_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            functions.body_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2)),
            functions.grip_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.2))
        ),
        anchors = {

        },
    }
)