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
    shaft_attachments = function()
        return {
            {id = "2h_power_maul_shaft_default", name = mod:localize("mod_attachment_default")},
            {id = "2h_power_maul_shaft_01",      name = "Shaft 1"},
            {id = "2h_power_maul_shaft_02",      name = "Shaft 2"},
            {id = "2h_power_maul_shaft_03",      name = "Shaft 3"},
            {id = "2h_power_maul_shaft_04",      name = "Shaft 4"},
            {id = "2h_power_maul_shaft_05",      name = "Shaft 5"},
        }
    end,
    shaft_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            ["2h_power_maul_shaft_default"] = {model = "",                                            type = "shaft", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_power_maul_shaft_01"] =      {model = _item_melee.."/shafts/2h_power_maul_shaft_01", type = "shaft", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_power_maul_shaft_02"] =      {model = _item_melee.."/shafts/2h_power_maul_shaft_02", type = "shaft", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_power_maul_shaft_03"] =      {model = _item_melee.."/shafts/2h_power_maul_shaft_03", type = "shaft", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_power_maul_shaft_04"] =      {model = _item_melee.."/shafts/2h_power_maul_shaft_04", type = "shaft", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_power_maul_shaft_05"] =      {model = _item_melee.."/shafts/2h_power_maul_shaft_05", type = "shaft", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    head_attachments = function()
        return {
            {id = "2h_power_maul_head_default", name = mod:localize("mod_attachment_default")},
            {id = "2h_power_maul_head_01",      name = "Head 1"},
            {id = "2h_power_maul_head_02",      name = "Head 2"},
            {id = "2h_power_maul_head_03",      name = "Head 3"},
            {id = "2h_power_maul_head_04",      name = "Head 4"},
            {id = "2h_power_maul_head_05",      name = "Head 5"},
        }
    end,
    head_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            ["2h_power_maul_head_default"] = {model = "",                                          type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_power_maul_head_01"] =      {model = _item_melee.."/heads/2h_power_maul_head_01", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_power_maul_head_02"] =      {model = _item_melee.."/heads/2h_power_maul_head_02", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_power_maul_head_03"] =      {model = _item_melee.."/heads/2h_power_maul_head_03", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_power_maul_head_04"] =      {model = _item_melee.."/heads/2h_power_maul_head_04", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_power_maul_head_05"] =      {model = _item_melee.."/heads/2h_power_maul_head_05", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    pommel_attachments = function()
        return {
            {id = "2h_power_maul_pommel_default", name = mod:localize("mod_attachment_default")},
            {id = "2h_power_maul_pommel_01",      name = "Pommel 1"},
            {id = "2h_power_maul_pommel_02",      name = "Pommel 2"},
            {id = "2h_power_maul_pommel_03",      name = "Pommel 3"},
            {id = "2h_power_maul_pommel_04",      name = "Pommel 4"},
            {id = "2h_power_maul_pommel_05",      name = "Pommel 5"},
        }
    end,
    pommel_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            ["2h_power_maul_pommel_default"] = {model = "",                                              type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_power_maul_pommel_01"] =      {model = _item_melee.."/pommels/2h_power_maul_pommel_01", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_power_maul_pommel_02"] =      {model = _item_melee.."/pommels/2h_power_maul_pommel_02", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_power_maul_pommel_03"] =      {model = _item_melee.."/pommels/2h_power_maul_pommel_03", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_power_maul_pommel_04"] =      {model = _item_melee.."/pommels/2h_power_maul_pommel_04", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_power_maul_pommel_05"] =      {model = _item_melee.."/pommels/2h_power_maul_pommel_05", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    connector_attachments = function()
        return {
            {id = "2h_power_maul_connector_default", name = mod:localize("mod_attachment_default")},
            {id = "2h_power_maul_connector_01",      name = "Connector 1"},
            {id = "2h_power_maul_connector_02",      name = "Connector 2"},
            {id = "2h_power_maul_connector_03",      name = "Connector 3"},
            {id = "2h_power_maul_connector_04",      name = "Connector 4"},
            {id = "2h_power_maul_connector_05",      name = "Connector 5"},
        }
    end,
    connector_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            ["2h_power_maul_connector_default"] = {model = "",                                                    type = "connector", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_power_maul_connector_01"] =      {model = _item_melee.."/connectors/2h_power_maul_connector_01", type = "connector", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_power_maul_connector_02"] =      {model = _item_melee.."/connectors/2h_power_maul_connector_02", type = "connector", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_power_maul_connector_03"] =      {model = _item_melee.."/connectors/2h_power_maul_connector_03", type = "connector", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_power_maul_connector_04"] =      {model = _item_melee.."/connectors/2h_power_maul_connector_04", type = "connector", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            ["2h_power_maul_connector_05"] =      {model = _item_melee.."/connectors/2h_power_maul_connector_05", type = "connector", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
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
            shaft = table.icombine(
                functions.shaft_attachments(),
                _common_melee.human_power_maul_shaft_attachments()
            ),
            pommel = functions.pommel_attachments(),
            connector = table.icombine(
                functions.connector_attachments(),
                _common_melee.human_power_maul_connector_attachments()
            ),
            head = table.icombine(
                functions.head_attachments(),
                _common_melee.human_power_maul_head_attachments()
            ),
        },
        models = table.combine(
            {customization_default_position = vector3_box(0, 3, .35)},
            _common.emblem_right_models("head", 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.emblem_left_models("head", -3, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            functions.shaft_models(nil, 0, vector3_box(-.3, -3, .2), vector3_box(0, 0, 0)),
            functions.connector_models(nil, 0, vector3_box(0, -5.5, -.4), vector3_box(0, 0, .2)),
            functions.head_models(nil, 0, vector3_box(.05, -4.5, -.5), vector3_box(0, 0, .4)),
            functions.pommel_models(nil, 0, vector3_box(-.5, -4, .5), vector3_box(0, 0, -.2)),
            _common_melee.human_power_maul_shaft_models(nil, 0, vector3_box(-.3, -3, .2), vector3_box(0, 0, 0)),
            _common_melee.human_power_maul_head_models(nil, 0, vector3_box(.05, -4.5, -.5), vector3_box(0, 0, .4)),
            _common_melee.human_power_maul_connector_models(nil, 0, vector3_box(0, -5.5, -.4), vector3_box(0, 0, .2))
        ),
        anchors = {

        },
    }
)