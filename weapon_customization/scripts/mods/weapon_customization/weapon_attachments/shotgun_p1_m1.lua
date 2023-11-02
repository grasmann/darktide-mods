local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
local _common_ranged = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_ranged")

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
    sight_attachments = function()
        return {
            {id = "sight_default", name = mod:localize("mod_attachment_default")},
            {id = "sight_01",      name = "Sight 1"},
            {id = "sight_04",      name = "Sight 4"},
            {id = "sight_05",      name = "Sight 5"},
            {id = "sight_06",      name = "Sight 6"},
            {id = "sight_07",      name = "Sight 7"},
        }
    end,
    sight_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            sight_default = {model = "",                                                     type = "sight", parent = tv(parent, 1), angle = a, move = m, remove = r},
            sight_01 =      {model = _item_ranged.."/sights/shotgun_rifle_sight_01",         type = "sight", parent = tv(parent, 2), angle = a, move = m, remove = r},
            sight_04 =      {model = _item_ranged.."/sights/shotgun_rifle_sight_04",         type = "sight", parent = tv(parent, 3), angle = a, move = m, remove = r},
            sight_05 =      {model = _item_ranged.."/sights/shotgun_pump_action_sight_01",   type = "sight", parent = tv(parent, 4), angle = a, move = m, remove = r},
            sight_06 =      {model = _item_ranged.."/sights/shotgun_pump_action_sight_02",   type = "sight", parent = tv(parent, 5), angle = a, move = m, remove = r},
            sight_07 =      {model = _item_ranged.."/sights/shotgun_double_barrel_sight_01", type = "sight", parent = tv(parent, 6), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    receiver_attachments = function()
        return {
            {id = "receiver_default", name = mod:localize("mod_attachment_default")},
            {id = "receiver_01",      name = "Receiver 1"},
            {id = "receiver_02",      name = "Receiver 2"},
            {id = "receiver_03",      name = "Receiver 3"},
            {id = "receiver_04",      name = "Receiver 4"},
        }
    end,
    receiver_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, special_resolve)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        local t = type or "receiver"
        local n = no_support or {}
        local ae = automatic_equip or {}
        local h = hide_mesh or {}
        return {
            receiver_default = {model = "",                                                           type = t, parent = tv(parent, 1), angle = a, move = m, remove = r, automatic_equip = tv(ae, 1),  no_support = tv(n, 1), special_resolve = special_resolve},
            receiver_01 =      {model = _item_ranged.."/recievers/shotgun_rifle_receiver_01",         type = t, parent = tv(parent, 2), angle = a, move = m, remove = r, automatic_equip = tv(ae, 2),  no_support = tv(n, 2), special_resolve = special_resolve},
            receiver_02 =      {model = _item_ranged.."/recievers/shotgun_double_barrel_receiver_01", type = t, parent = tv(parent, 3), angle = a, move = m, remove = r, automatic_equip = tv(ae, 3),  no_support = tv(n, 3), special_resolve = special_resolve},
            receiver_03 =      {model = _item_ranged.."/recievers/shotgun_double_barrel_receiver_02", type = t, parent = tv(parent, 4), angle = a, move = m, remove = r, automatic_equip = tv(ae, 4),  no_support = tv(n, 4), special_resolve = special_resolve},
            receiver_04 =      {model = _item_ranged.."/recievers/shotgun_double_barrel_receiver_03", type = t, parent = tv(parent, 5), angle = a, move = m, remove = r, automatic_equip = tv(ae, 5),  no_support = tv(n, 5), special_resolve = special_resolve},
        }
    end,
    stock_attachments = function()
        return {
            {id = "shotgun_rifle_stock_default", name = mod:localize("mod_attachment_default")},
            {id = "shotgun_rifle_stock_01",      name = "Stock 1"},
            {id = "shotgun_rifle_stock_02",      name = "Stock 2"},
            {id = "shotgun_rifle_stock_03",      name = "Stock 3"},
            {id = "shotgun_rifle_stock_04",      name = "Stock 4"},
            {id = "shotgun_rifle_stock_07",      name = "Stock 7"},
            {id = "shotgun_rifle_stock_08",      name = "Stock 8"},
            {id = "shotgun_rifle_stock_09",      name = "Stock 9"},
            {id = "shotgun_rifle_stock_10",      name = "Stock 10"},
            {id = "shotgun_rifle_stock_11",      name = "Stock 11"},
            {id = "shotgun_rifle_stock_12",      name = "Stock 12"},
        }
    end,
    stock_models = function(parent, angle, move, remove, type)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        local t = type or "stock"
        return {
            shotgun_rifle_stock_default = {model = "",                                                     type = t, parent = tv(parent, 1),  angle = a, move = m, remove = r, mesh_move = true},
            shotgun_rifle_stock_01 =      {model = _item_ranged.."/stocks/shotgun_rifle_stock_01",         type = t, parent = tv(parent, 2),  angle = a, move = m, remove = r, mesh_move = true},
            shotgun_rifle_stock_02 =      {model = _item_ranged.."/stocks/shotgun_rifle_stock_03",         type = t, parent = tv(parent, 3),  angle = a, move = m, remove = r, mesh_move = true},
            shotgun_rifle_stock_03 =      {model = _item_ranged.."/stocks/shotgun_rifle_stock_05",         type = t, parent = tv(parent, 4),  angle = a, move = m, remove = r, mesh_move = true},
            shotgun_rifle_stock_04 =      {model = _item_ranged.."/stocks/shotgun_rifle_stock_06",         type = t, parent = tv(parent, 5),  angle = a, move = m, remove = r, mesh_move = true},
            shotgun_rifle_stock_07 =      {model = _item_ranged.."/stocks/shotgun_rifle_stock_07",         type = t, parent = tv(parent, 6),  angle = a, move = m, remove = r, mesh_move = true},
            shotgun_rifle_stock_08 =      {model = _item_ranged.."/stocks/shotgun_rifle_stock_08",         type = t, parent = tv(parent, 7),  angle = a, move = m, remove = r, mesh_move = false},
            shotgun_rifle_stock_09 =      {model = _item_ranged.."/stocks/shotgun_rifle_stock_09",         type = t, parent = tv(parent, 8),  angle = a, move = m, remove = r, mesh_move = true},
            shotgun_rifle_stock_10 =      {model = _item_ranged.."/stocks/shotgun_double_barrel_stock_01", type = t, parent = tv(parent, 9),  angle = a, move = m, remove = r, mesh_move = false},
            shotgun_rifle_stock_11 =      {model = _item_ranged.."/stocks/shotgun_double_barrel_stock_02", type = t, parent = tv(parent, 10), angle = a, move = m, remove = r, mesh_move = false},
            shotgun_rifle_stock_12 =      {model = _item_ranged.."/stocks/shotgun_double_barrel_stock_03", type = t, parent = tv(parent, 11), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    barrel_attachments = function()
        return {
            {id = "barrel_default", name = mod:localize("mod_attachment_default")},
            {id = "barrel_01",      name = "Barrel 1"},
            {id = "barrel_02",      name = "Barrel 2"},
            {id = "barrel_03",      name = "Barrel 3"},
            {id = "barrel_04",      name = "Barrel 4"},
            {id = "barrel_07",      name = "Barrel 7"},
            {id = "barrel_08",      name = "Barrel 8"},
            {id = "barrel_09",      name = "Barrel 9"},
            {id = "barrel_10",      name = "Barrel 10"},
            {id = "barrel_11",      name = "Barrel 11"},
            {id = "barrel_12",      name = "Barrel 12"},
        }
    end,
    barrel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, special_resolve)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        local t = type or "barrel"
        local n = no_support or {}
        local ae = automatic_equip or {}
        local h = hide_mesh or {}
        return {
            barrel_default = {model = "",                                                type = t, parent = tv(parent, 1),  angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 1),  no_support = tv(n, 1),  special_resolve = special_resolve},
            barrel_01 =      {model = _item_ranged.."/barrels/shotgun_rifle_barrel_01",  type = t, parent = tv(parent, 2),  angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 2),  no_support = tv(n, 2),  special_resolve = special_resolve},
            barrel_02 =      {model = _item_ranged.."/barrels/shotgun_rifle_barrel_04",  type = t, parent = tv(parent, 3),  angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 3),  no_support = tv(n, 3),  special_resolve = special_resolve},
            barrel_03 =      {model = _item_ranged.."/barrels/shotgun_rifle_barrel_05",  type = t, parent = tv(parent, 4),  angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 4),  no_support = tv(n, 4),  special_resolve = special_resolve},
            barrel_04 =      {model = _item_ranged.."/barrels/shotgun_rifle_barrel_06",  type = t, parent = tv(parent, 5),  angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 5),  no_support = tv(n, 5),  special_resolve = special_resolve},
            barrel_07 =      {model = _item_ranged.."/barrels/shotgun_rifle_barrel_07",  type = t, parent = tv(parent, 6),  angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 6),  no_support = tv(n, 6),  special_resolve = special_resolve},
            barrel_08 =      {model = _item_ranged.."/barrels/shotgun_rifle_barrel_08",  type = t, parent = tv(parent, 7),  angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 7),  no_support = tv(n, 7),  special_resolve = special_resolve},
            barrel_09 =      {model = _item_ranged.."/barrels/shotgun_rifle_barrel_09",  type = t, parent = tv(parent, 8),  angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 8),  no_support = tv(n, 8),  special_resolve = special_resolve},
            barrel_10 =      {model = _item_ranged.."/barrels/shotgun_double_barrel_01", type = t, parent = tv(parent, 9),  angle = a, move = m, remove = r, mesh_move = true,  automatic_equip = tv(ae, 9),  no_support = tv(n, 9),  special_resolve = special_resolve},
            barrel_11 =      {model = _item_ranged.."/barrels/shotgun_double_barrel_02", type = t, parent = tv(parent, 10), angle = a, move = m, remove = r, mesh_move = true,  automatic_equip = tv(ae, 10), no_support = tv(n, 10), special_resolve = special_resolve},
            barrel_12 =      {model = _item_ranged.."/barrels/shotgun_double_barrel_03", type = t, parent = tv(parent, 11), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 11), no_support = tv(n, 11), special_resolve = special_resolve},
        }
    end,
    underbarrel_attachments = function()
        return {
            {id = "underbarrel_default", name = mod:localize("mod_attachment_default")},
            {id = "underbarrel_01",      name = "Underbarrel 1"},
            {id = "underbarrel_02",      name = "Underbarrel 2"},
            {id = "underbarrel_03",      name = "Underbarrel 3"},
            {id = "underbarrel_04",      name = "Underbarrel 4"},
            {id = "underbarrel_07",      name = "Underbarrel 7"},
            {id = "underbarrel_08",      name = "Underbarrel 8"},
            {id = "underbarrel_09",      name = "Underbarrel 9"},
            {id = "underbarrel_10",      name = "Underbarrel 10"},
            {id = "underbarrel_11",      name = "Underbarrel 11"},
            -- {id = "no_underbarrel",      name = "No Underbarrel"},
        }
    end,
    underbarrel_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            underbarrel_default = {model = "",                                                               type = "underbarrel", parent = tv(parent, 1),  angle = a, move = m, remove = r},
            underbarrel_01 =      {model = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_01",       type = "underbarrel", parent = tv(parent, 2),  angle = a, move = m, remove = r},
            underbarrel_02 =      {model = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_04",       type = "underbarrel", parent = tv(parent, 3),  angle = a, move = m, remove = r},
            underbarrel_03 =      {model = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_05",       type = "underbarrel", parent = tv(parent, 4),  angle = a, move = m, remove = r},
            underbarrel_04 =      {model = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_06",       type = "underbarrel", parent = tv(parent, 5),  angle = a, move = m, remove = r},
            underbarrel_07 =      {model = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_07",       type = "underbarrel", parent = tv(parent, 6),  angle = a, move = m, remove = r},
            underbarrel_08 =      {model = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_08",       type = "underbarrel", parent = tv(parent, 7),  angle = a, move = m, remove = r},
            underbarrel_09 =      {model = _item_ranged.."/underbarrels/shotgun_pump_action_underbarrel_01", type = "underbarrel", parent = tv(parent, 8),  angle = a, move = m, remove = r},
            underbarrel_10 =      {model = _item_ranged.."/underbarrels/shotgun_pump_action_underbarrel_02", type = "underbarrel", parent = tv(parent, 9),  angle = a, move = m, remove = r},
            underbarrel_11 =      {model = _item_ranged.."/underbarrels/shotgun_pump_action_underbarrel_03", type = "underbarrel", parent = tv(parent, 10), angle = a, move = m, remove = r},
            no_underbarrel =      {model = "",                                                               type = "underbarrel", parent = tv(parent, 11), angle = a, move = m, remove = r},
        }
    end,
}

return table.combine(
    functions,
    {
        attachments = { -- Done 13.9.2023
            flashlight = _common_ranged.flashlights_attachments(),
            trinket_hook = _common.trinket_hook_attachments(),
            receiver = functions.receiver_attachments(),
            stock = functions.stock_attachments(),
            -- sight = functions.sight_attachments(),
            sight_2 = table.icombine(
                _common_ranged.sight_default(),
                _common_ranged.reflex_sights_attachments()
            ),
            barrel = functions.barrel_attachments(),
            underbarrel = functions.underbarrel_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
        },
        models = table.combine( -- Done 13.9.2023
            _common_ranged.flashlight_models(nil, -2.5, vector3_box(-.3, -3, 0), vector3_box(.2, 0, 0)),
            _common.emblem_right_models("receiver", -3, vector3_box(-.4, -5, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("receiver", 0, vector3_box(0, -5, 0), vector3_box(-.2, 0, 0)),
            _common.trinket_hook_models(nil, -.2, vector3_box(.3, -4, .1), vector3_box(0, 0, -.2)),
            _common_ranged.reflex_sights_models("sight", -.5, vector3_box(-.3, -4, -.2), vector3_box(0, -.2, 0), "sight_2"),
            functions.receiver_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.00001), nil, {}, {
                {sight = "sight_07|sight_default"},
                {sight = "sight_07|sight_default"},
                {sight = "!sight_07|sight_07"},
                {sight = "!sight_07|sight_07"},
                {sight = "!sight_07|sight_07"},
            }, {}, function(gear_id, item, attachment)
                local changes = {}
                if attachment == "receiver_02" or attachment == "receiver_03" or attachment == "receiver_04" then
                    local barrel = mod:get_gear_setting(gear_id, "barrel", item)
                    if barrel ~= "barrel_10" and barrel ~= "barrel_11" and barrel ~= "barrel_12" then changes["barrel"] = "barrel_10" end
                else
                    local barrel = mod:get_gear_setting(gear_id, "barrel", item)
                    if barrel == "barrel_10" or barrel == "barrel_11" or barrel == "barrel_12" then changes["barrel"] = "barrel_01" end
                end
                return changes
            end),
            functions.stock_models("receiver", 0, vector3_box(-.4, -4, 0), vector3_box(0, -.2, 0)),
            functions.barrel_models(nil, -.5, vector3_box(.1, -4, 0), vector3_box(0, .2, 0), nil, {
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook"},
                {"trinket_hook"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty", "underbarrel"},
                {"trinket_hook_empty", "underbarrel"},
                {"trinket_hook_empty", "underbarrel"},
            }, {
                {trinket_hook = "trinket_hook_empty|trinket_hook_01",     underbarrel = "no_underbarrel|underbarrel_01"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01",     underbarrel = "no_underbarrel|underbarrel_02"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01",     underbarrel = "no_underbarrel|underbarrel_03"},
                {trinket_hook = "!trinket_hook_empty|trinket_hook_empty", underbarrel = "no_underbarrel|underbarrel_04"},
                {trinket_hook = "!trinket_hook_empty|trinket_hook_empty", underbarrel = "no_underbarrel|underbarrel_05"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01",     underbarrel = "no_underbarrel|underbarrel_06"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01",     underbarrel = "no_underbarrel|underbarrel_07"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01",     underbarrel = "no_underbarrel|underbarrel_08"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01",     underbarrel = "!no_underbarrel|no_underbarrel"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01",     underbarrel = "!no_underbarrel|no_underbarrel"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01",     underbarrel = "!no_underbarrel|no_underbarrel"},
            }, {}, function(gear_id, item, attachment)
                local changes = {}
                if attachment == "barrel_10" or attachment == "barrel_11" or attachment == "barrel_12" then
                    local receiver = mod:get_gear_setting(gear_id, "receiver", item)
                    if receiver ~= "receiver_02" and receiver ~= "receiver_03" and receiver ~= "receiver_04" then changes["receiver"] = "receiver_02" end
                else
                    local receiver = mod:get_gear_setting(gear_id, "receiver", item)
                    if receiver == "receiver_02" or receiver == "receiver_03" or receiver == "receiver_04" then changes["receiver"] = "receiver_01" end
                end
                return changes
            end),
            functions.underbarrel_models(nil, -.5, vector3_box(0, -4, 0), vector3_box(0, 0, -.2)),
            functions.sight_models(nil, -.5, vector3_box(-.3, -4, -.2), vector3_box(0, -.2, 0))
        ),
        anchors = { -- Done 13.9.2023
            scope_offset = {position = vector3_box(0, 0, .02)},
            fixes = {
                {dependencies = {"receiver_02|receiver_04", "emblem_left_02"}, -- Emblems
                    emblem_left = {parent = "receiver", position = vector3_box(-.033, .035, .056), rotation = vector3_box(0, 0, 180), scale = vector3_box(.75, -.75, .75)}},
                {dependencies = {"receiver_02|receiver_04"}, -- Emblems
                    emblem_left = {parent = "receiver", position = vector3_box(-.033, .035, .056), rotation = vector3_box(0, 0, 180), scale = vector3_box(.75, .75, .75)},
                    emblem_right = {parent = "receiver", position = vector3_box(.033, .035, .056), rotation = vector3_box(0, 0, 0), scale = vector3_box(.75, .75, .75)}},
                {dependencies = {"receiver_03", "emblem_left_02"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.052, .08, .062), rotation = vector3_box(0, 0, 180), scale = vector3_box(.75, -.75, .75)}},
                {dependencies = {"receiver_03"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.052, .08, .062), rotation = vector3_box(0, 0, 180), scale = vector3_box(.75, .75, .75)},
                    emblem_right = {parent = "barrel", position = vector3_box(.052, .08, .062), rotation = vector3_box(0, 0, 0), scale = vector3_box(.75, .75, .75)}},
                {dependencies = {"barrel_10|barrel_11|barrel_12", "reflex_sight_01|reflex_sight_02|reflex_sight_03"}, -- Grip
                    sight = {parent = "barrel", position = vector3_box(0, 0, .1), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)},
                    sight_2 = {parent = "barrel", position = vector3_box(0, -.03, .1), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    scope_offset = {position = vector3_box(0, .1, .014)}},
                {dependencies = {"barrel_10|barrel_11|barrel_12"}, -- Grip
                    ammo = {offset = true, position = vector3_box(0, 0, .05), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)},
                    ammo_used = {offset = true, position = vector3_box(0, 0, .05), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)},
                    sight = {parent = "barrel", position = vector3_box(0, 0, .1), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    trinket_hook = {parent = "barrel", position = vector3_box(0, 0, -.024), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    no_scope_offset = {position = vector3_box(0, 0, -.0075)}},
                {dependencies = {"grip_27|grip_28|grip_29"}, -- Grip
                    grip = {offset = true, position = vector3_box(0, .01, -.02), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_01"}, -- Flashlight
                    flashlight = {parent = "barrel", position = vector3_box(.03, .4, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_02"}, -- Flashlight
                    flashlight = {parent = "barrel", position = vector3_box(.03, .45, -.025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_03"}, -- Flashlight
                    flashlight = {parent = "barrel", position = vector3_box(.025, .4, -.045), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_04"}, -- Flashlight
                    flashlight = {parent = "barrel", position = vector3_box(.042, .4, -.025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_01", "laser_pointer"}, -- Flashlight
                    flashlight = {parent = "barrel", position = vector3_box(.03, .4, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_02", "laser_pointer"}, -- Flashlight
                    flashlight = {parent = "barrel", position = vector3_box(.03, .45, -.025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_03", "laser_pointer"}, -- Flashlight
                    flashlight = {parent = "barrel", position = vector3_box(.025, .4, -.045), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_04", "laser_pointer"}, -- Flashlight
                    flashlight = {parent = "barrel", position = vector3_box(.042, .4, -.025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {sight_2 = {parent = "sight", position = vector3_box(0, -.04, .025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_01", "emblem_left_02"}, -- Emblem
                    emblem_left = {parent = "barrel", position = vector3_box(-.035, .225, .003), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, -1, 1)}},
                {dependencies = {"barrel_01"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.035, .225, .003), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, 1, 1)},
                    emblem_right = {parent = "barrel", position = vector3_box(.035, .225, .003), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_02", "emblem_left_02"}, -- Emblem
                    emblem_left = {parent = "barrel", position = vector3_box(-.035, .225, .003), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, -1, 1)}},
                {dependencies = {"barrel_02"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.035, .225, .003), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, 1, 1)},
                    emblem_right = {parent = "barrel", position = vector3_box(.035, .225, .003), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_03", "emblem_left_02"}, -- Emblem
                    emblem_left = {parent = "barrel", position = vector3_box(-.035, .08, .003), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, -1, 1)}},
                {dependencies = {"barrel_03"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.035, .08, .003), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, 1, 1)},
                    emblem_right = {parent = "barrel", position = vector3_box(.035, .08, .003), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_04", "emblem_left_02"}, -- Emblem
                    emblem_left = {parent = "barrel", position = vector3_box(-.035, .155, .003), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, -1, 1)}},
                {dependencies = {"barrel_04"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.035, .155, .003), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, 1, 1)},
                    emblem_right = {parent = "barrel", position = vector3_box(.035, .155, .003), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
            },
        },
    }
)