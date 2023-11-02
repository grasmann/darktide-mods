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
            {id = "grip_default", name = mod:localize("mod_attachment_default")},
            {id = "axe_grip_01",  name = "Combat Axe 1"},
            {id = "axe_grip_02",  name = "Combat Axe 2"},
            {id = "axe_grip_03",  name = "Combat Axe 3"},
            {id = "axe_grip_04",  name = "Combat Axe 4"},
            {id = "axe_grip_05",  name = "Combat Axe 5"},
            {id = "axe_grip_06",  name = "Combat Axe 6"},
        }
    end,
    grip_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            grip_default = {model = "",                                type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_grip_01 =  {model = _item_melee.."/grips/axe_grip_01", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_grip_02 =  {model = _item_melee.."/grips/axe_grip_02", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_grip_03 =  {model = _item_melee.."/grips/axe_grip_03", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_grip_04 =  {model = _item_melee.."/grips/axe_grip_04", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_grip_05 =  {model = _item_melee.."/grips/axe_grip_05", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_grip_06 =  {model = _item_melee.."/grips/axe_grip_06", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    head_attachments = function()
        return {
            {id = "head_default", name = mod:localize("mod_attachment_default")},
            {id = "axe_head_01",  name = "Combat Axe 1"},
            {id = "axe_head_02",  name = "Combat Axe 2"},
            {id = "axe_head_03",  name = "Combat Axe 3"},
            {id = "axe_head_04",  name = "Combat Axe 4"},
            {id = "axe_head_05",  name = "Combat Axe 5"},
        }
    end,
    head_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            head_default = {model = "",                                type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_head_01 =  {model = _item_melee.."/heads/axe_head_01", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_head_02 =  {model = _item_melee.."/heads/axe_head_02", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_head_03 =  {model = _item_melee.."/heads/axe_head_03", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_head_04 =  {model = _item_melee.."/heads/axe_head_04", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_head_05 =  {model = _item_melee.."/heads/axe_head_05", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    pommel_attachments = function()
        return {
            {id = "pommel_default", name = mod:localize("mod_attachment_default")},
            {id = "axe_pommel_01",  name = "Combat Axe 1"},
            {id = "axe_pommel_02",  name = "Combat Axe 2"},
            {id = "axe_pommel_03",  name = "Combat Axe 3"},
            {id = "axe_pommel_04",  name = "Combat Axe 4"},
            {id = "axe_pommel_05",  name = "Combat Axe 5"},
        }
    end,
    pommel_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            pommel_default = {model = "",                                    type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_pommel_01 =  {model = _item_melee.."/pommels/axe_pommel_01", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_pommel_02 =  {model = _item_melee.."/pommels/axe_pommel_02", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_pommel_03 =  {model = _item_melee.."/pommels/axe_pommel_03", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_pommel_04 =  {model = _item_melee.."/pommels/axe_pommel_04", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_pommel_05 =  {model = _item_melee.."/pommels/axe_pommel_05", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
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
            grip = table.icombine(
                _common_melee.grip_default(),
                _common_melee.axe_grip_attachments()
            ),
            head = table.icombine(
                _common_melee.head_default(),
                _common_melee.axe_head_attachments()
            ),
            pommel = table.icombine(
                _common_melee.pommel_default(),
                _common_melee.axe_pommel_attachments()
            ),
        },
        models = table.combine(
            _common.emblem_right_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.emblem_left_models(nil, -3, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common_melee.axe_grip_models(nil, 0, vector3_box(-.3, -2, .1), vector3_box(0, 0, 0)),
            _common_melee.axe_head_models(nil, 0, vector3_box(0, -3, -.1), vector3_box(0, 0, .2)),
            _common_melee.axe_pommel_models(nil, 0, vector3_box(-.5, -4, .3), vector3_box(0, 0, -.2))
        ),
        anchors = {
            fixes = {
                {dependencies = {"axe_head_02"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.015, .06, .16), rotation = vector3_box(90, 0, 180), scale = vector3_box(1, 1, 1)},
                    emblem_right = {offset = true, position = vector3_box(.015, .06, .16), rotation = vector3_box(90, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"axe_head_03"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.015, .06, .16), rotation = vector3_box(90, 0, 180), scale = vector3_box(1, 1, 1)},
                    emblem_right = {offset = true, position = vector3_box(.015, .06, .16), rotation = vector3_box(90, 0, 0), scale = vector3_box(1, 1, 1)}},
            },
        },
    }
)