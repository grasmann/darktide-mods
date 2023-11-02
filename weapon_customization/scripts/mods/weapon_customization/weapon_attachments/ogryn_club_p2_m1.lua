local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")

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
    body_attachments = function()
        return {
            {id = "body_default",   name = mod:localize("mod_attachment_default")},
            {id = "body_01",        name = "Body 1"},
            {id = "body_02",        name = "Body 2"},
            {id = "body_03",        name = "Body 3"},
            {id = "body_04",        name = "Body 4"},
            {id = "body_05",        name = "Body 5"},
        }
    end,
    body_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            body_default = {model = "",                                           type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r},
            body_01 =      {model = _item_melee.."/full/ogryn_club_pipe_full_01", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r},
            body_02 =      {model = _item_melee.."/full/ogryn_club_pipe_full_02", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r},
            body_03 =      {model = _item_melee.."/full/ogryn_club_pipe_full_03", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r},
            body_04 =      {model = _item_melee.."/full/ogryn_club_pipe_full_04", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r},
            body_05 =      {model = _item_melee.."/full/ogryn_club_pipe_full_05", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r},
        }
    end,
}

return table.combine(
    functions,
    {
        attachments = { -- Done 12.9.2023
            body = functions.body_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            trinket_hook = _common.trinket_hook_attachments(),
        },
        models = table.combine( -- Done 12.9.2023
            functions.body_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.2)),
            _common.emblem_right_models("body", -2.5, vector3_box(0, -4, -.2), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("body", 0, vector3_box(.1, -4, -.2), vector3_box(-.2, 0, 0)),
            _common.trinket_hook_models(nil, -.5, vector3_box(0, -4, 0), vector3_box(0, 0, -.2))
        ),
        anchors = { -- Done 12.9.2023 Additional custom positions for paper thing emblems?
            fixes = {
                {dependencies = {"body_01"}, -- Emblems
                    emblem_left = {parent = "body", position = vector3_box(-.155, 0, 1.025), rotation = vector3_box(90, 0, 180), scale = vector3_box(3, 3, 3)},
                    emblem_right = {parent = "body", position = vector3_box(.155, 0, 1.025), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"body_02"}, -- Emblems
                    emblem_left = {parent = "body", position = vector3_box(-.15, -.02, .965), rotation = vector3_box(98, 7.5, 180), scale = vector3_box(2.5, 2.5, 2.5)},
                    emblem_right = {parent = "body", position = vector3_box(.155, -.005, 1.01), rotation = vector3_box(107.5, 0, 0), scale = vector3_box(2.5, 2.5, 2.5)}},
                {dependencies = {"body_03"}, -- Emblems
                    emblem_left = {parent = "body", position = vector3_box(-.1175, 0, .9), rotation = vector3_box(90, 0, 180), scale = vector3_box(5, 5, 5)},
                    emblem_right = {parent = "body", position = vector3_box(.1475, 0, .9), rotation = vector3_box(90, 0, 0), scale = vector3_box(5, 5, 5)}},
                {dependencies = {"body_04"}, -- Emblems
                    emblem_left = {parent = "body", position = vector3_box(-.16, .02, .985), rotation = vector3_box(80, 0, 180), scale = vector3_box(4, 4, 4)},
                    emblem_right = {parent = "body", position = vector3_box(.19, .02, .985), rotation = vector3_box(100, 0, -2.5), scale = vector3_box(4, 4, 4)}},
                {dependencies = {"body_05"}, -- Emblems
                    emblem_left = {parent = "body", position = vector3_box(-.19, .02, 1.02), rotation = vector3_box(45, 0, 180), scale = vector3_box(4, 4, 4)},
                    emblem_right = {parent = "body", position = vector3_box(.15, 0, 1.05), rotation = vector3_box(100, 0, -2.5), scale = vector3_box(4, 4, 4)}},
            },
        },
    }
)