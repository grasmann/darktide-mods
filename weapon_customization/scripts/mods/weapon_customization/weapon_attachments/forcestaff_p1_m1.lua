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
    staff_head_attachments = function()
        return {
            {id = "head_default", name = mod:localize("mod_attachment_default")},
            {id = "head_01",      name = "Head 1"},
            {id = "head_02",      name = "Head 2"},
            {id = "head_03",      name = "Head 3"},
            {id = "head_04",      name = "Head 4"},
            {id = "head_05",      name = "Head 5"},
            {id = "head_06",      name = "Head 6"},
            {id = "head_07",      name = "Head 7"},
        }
    end,
    staff_head_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            head_default = {model = "",                                        type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            head_01 =      {model = _item_melee.."/heads/force_staff_head_01", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            head_02 =      {model = _item_melee.."/heads/force_staff_head_02", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            head_03 =      {model = _item_melee.."/heads/force_staff_head_03", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            head_04 =      {model = _item_melee.."/heads/force_staff_head_04", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            head_05 =      {model = _item_melee.."/heads/force_staff_head_05", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            head_06 =      {model = _item_melee.."/heads/force_staff_head_06", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            head_07 =      {model = _item_melee.."/heads/force_staff_head_07", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    staff_body_attachments = function()
        return {
            {id = "body_default", name = mod:localize("mod_attachment_default")},
            {id = "body_01",      name = "Body 1"},
            {id = "body_02",      name = "Body 2"},
            {id = "body_03",      name = "Body 3"},
            {id = "body_04",      name = "Body 4"},
            {id = "body_05",      name = "Body 5"},
        }
    end,
    staff_body_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            body_default = {model = "",                                       type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = true},
            body_01 =      {model = _item_melee.."/full/force_staff_full_01", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = true},
            body_02 =      {model = _item_melee.."/full/force_staff_full_02", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = true},
            body_03 =      {model = _item_melee.."/full/force_staff_full_03", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = true},
            body_04 =      {model = _item_melee.."/full/force_staff_full_04", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = true},
            body_05 =      {model = _item_melee.."/full/force_staff_full_05", type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = true},
        }
    end,
    staff_shaft_upper_attachments = function()
        return {
            {id = "shaft_upper_default", name = mod:localize("mod_attachment_default")},
            {id = "shaft_upper_01",      name = "Upper Shaft 1"},
            {id = "shaft_upper_02",      name = "Upper Shaft 2"},
            {id = "shaft_upper_03",      name = "Upper Shaft 3"},
            {id = "shaft_upper_04",      name = "Upper Shaft 4"},
            {id = "shaft_upper_05",      name = "Upper Shaft 5"},
        }
    end,
    staff_shaft_upper_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            shaft_upper_default = {model = "",                                                 type = "shaft_upper", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            shaft_upper_01 =      {model = _item_ranged.."/shafts/force_staff_shaft_upper_01", type = "shaft_upper", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            shaft_upper_02 =      {model = _item_ranged.."/shafts/force_staff_shaft_upper_02", type = "shaft_upper", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            shaft_upper_03 =      {model = _item_ranged.."/shafts/force_staff_shaft_upper_03", type = "shaft_upper", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            shaft_upper_04 =      {model = _item_ranged.."/shafts/force_staff_shaft_upper_04", type = "shaft_upper", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            shaft_upper_05 =      {model = _item_ranged.."/shafts/force_staff_shaft_upper_05", type = "shaft_upper", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    staff_shaft_lower_attachments = function()
        return {
            {id = "shaft_lower_default", name = mod:localize("mod_attachment_default")},
            {id = "shaft_lower_01",      name = "Lower Shaft 1"},
            {id = "shaft_lower_02",      name = "Lower Shaft 2"},
            {id = "shaft_lower_03",      name = "Lower Shaft 3"},
            {id = "shaft_lower_04",      name = "Lower Shaft 4"},
            {id = "shaft_lower_05",      name = "Lower Shaft 5"},
        }
    end,
    staff_shaft_lower_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            shaft_lower_default = {model = "",                                                 type = "shaft_lower", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            shaft_lower_01 =      {model = _item_ranged.."/shafts/force_staff_shaft_lower_01", type = "shaft_lower", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            shaft_lower_02 =      {model = _item_ranged.."/shafts/force_staff_shaft_lower_02", type = "shaft_lower", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            shaft_lower_03 =      {model = _item_ranged.."/shafts/force_staff_shaft_lower_03", type = "shaft_lower", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            shaft_lower_04 =      {model = _item_ranged.."/shafts/force_staff_shaft_lower_04", type = "shaft_lower", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            shaft_lower_05 =      {model = _item_ranged.."/shafts/force_staff_shaft_lower_05", type = "shaft_lower", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
}

return table.combine(
    functions,
    {
        attachments = {
            shaft_lower = functions.staff_shaft_lower_attachments(),
            shaft_upper = functions.staff_shaft_upper_attachments(),
            body = functions.staff_body_attachments(),
            head = functions.staff_head_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            trinket_hook = _common.trinket_hook_attachments(),
        },
        models = table.combine(
            {customization_default_position = vector3_box(-.5, 8, .75)},
            functions.staff_head_models(nil, 0, vector3_box(.15, -8.5, -.8), vector3_box(0, 0, .4)),
            functions.staff_body_models(nil, 0, vector3_box(.1, -7, -.65), vector3_box(0, 0, .2)),
            functions.staff_shaft_upper_models(nil, 0, vector3_box(-.25, -5.5, -.4), vector3_box(0, 0, .1)),
            functions.staff_shaft_lower_models(nil, 0, vector3_box(-.75, -4, .5), vector3_box(0, 0, -.1)),
            _common.emblem_right_models("body", -3, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("body", 0, vector3_box(0, -3, 0), vector3_box(-.2, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(.1, -4, .2), vector3_box(0, 0, -.2))
        ),
        anchors = {
            fixes = {
                {dependencies = {"body_01"}, -- Emblems
                    emblem_left = {parent = "body", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    emblem_right = {parent = "body", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
            }
        },
    }
)